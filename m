Return-Path: <netdev+bounces-197618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3CDAD95B4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A836A1732D2
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617223816F;
	Fri, 13 Jun 2025 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AtAZKMlN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63E22B59D
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843619; cv=fail; b=imkquMBDus4J63ZULYli0Z6KbyLgN8WrwTVbJxS0MIZ11djKMk8SC6ULdqMyEPa3zJ18BJfUPgwedWyupWle8v8b5Lkp8OKa8P2VcHFuP++DbCvd+OGZNv0zJnTYI+SW/EesOM2gFx+fEdjCmJy5VCBlLFzkNX/KO8W71QC64IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843619; c=relaxed/simple;
	bh=u/wC2vUNP7p/lLPqC25mnDlOkyiOEc1hxZi0sg/yQww=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=e9uDVPochqJ0VAIAa8/SwBanOwj9ccn3f0R+ipF/Q4vx78XCG7ISwYaV8esKEhoMOinn6QA+6x1CHn3AcI5Y5fWk3NczT5LL9UWyOo+Ywdf/0nVfDqenwtrkavr/PNCmHoZnSffyVMOEPohIGQ+q0J/U6gjxXy8plZJqCApmZsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AtAZKMlN; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8yLyLyHe0UjsuYBqVGa6zwZgqIS9m8MBg2v9ix2V8wCWJjs/UpkET3bAYspFkgESiqN04dJRvHHuLxAOdaxKWD4IOoDB9RiKPc/6Q37E1cDpONoYmvuAi1MvugSDbkmt7F/OvVWAFCXuPQUeGkhzI/uf5TsKqydS2syIW3BF6zdcOzxPysPgsAPFLgSW+z6qyUEi1UG/jYP9ly4RxPN/nE7PhlXXYZSWbT9t6pvJi+EEboaWr3jWPfPA7Ctd1FqffOk7JblwyRX6fapXwxCj5z8FxPSKVzw0G3Ph9+RA87TUdA5UQOtl3BWh3pMAP5VztmoHxh5FRsaDcf4bSJ+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st00jEMfNEmWmO0XgJQwEXJjOCvXd/Yrep7xz1Fcy4k=;
 b=I7hgMg0aRc+X8w2I9mjb8R59PJC15fQu01DtZbdX/wHS6qmAKIFS8tWK+MTx/ShPxiH00JGmvAVtxRTCg+wF1LbkuJPkoNYmlsF69CEv0grAw2zGMgdtTDnLfzg1OaY5yqPjQoZ0pf8o2jfLRAnNntfifQfamxZ7vx0EZz5lJU5uB8j8VWoDnuQAbQZTqx2j2C6EdeLtZ5fBD4PpW0IgPhXu+4IFEl8VrxaVqeJ6UtY/ilD+5zFGj9rArDQj5zypmh6bgg+hOUAzCRxuiX/4Zwr7ojQcqWR7uceq5Wzc7BHrw6TScJs2Yn0RDZa2gmyOtUW0AIyyRro+N4bMNS+aQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st00jEMfNEmWmO0XgJQwEXJjOCvXd/Yrep7xz1Fcy4k=;
 b=AtAZKMlNkVWe/Zm3y06RhV29P52ELDcsLk+6EeC/dOFntYr0s8WEU1A6FLSptAxnWUHer7m/6UE2Z3dQsT1/7fsKqzj5O8IcjkcpZRdlnatK5f7SPglh6KjdA8Z+ZoM9B5lSIDVtc9NSRctO82ZWRhs9fIaFu2crbv8RL+EoNp4k9K2p+sxHG775mXZGpDGnN2km7ljPC0I01AAwTBvh/IRbWAjGkFa2OkQeSyvJtCNy6sXMnh5RyKwc6AnnNvMKt90TvBoNQk3OuBVp+W7twLhRnA4fyqWia136vNEx3JkyZx4plMSepI30hz6Jo9EIoCDNwugrFGHY0LCSyLRMDw==
Received: from SN7PR04CA0046.namprd04.prod.outlook.com (2603:10b6:806:120::21)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 19:40:11 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::86) by SN7PR04CA0046.outlook.office365.com
 (2603:10b6:806:120::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Fri,
 13 Jun 2025 19:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 19:40:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Jun
 2025 12:39:55 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 13 Jun
 2025 12:39:49 -0700
References: <cover.1749757582.git.petrm@nvidia.com>
 <ad02c7a76fca399736192bcf7a00e8969fa15e3b.1749757582.git.petrm@nvidia.com>
 <20250613095143.37b5500b@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>
Subject: Re: [PATCH net-next v2 04/14] net: ipv4: Add ip_mr_output()
Date: Fri, 13 Jun 2025 21:31:59 +0200
In-Reply-To: <20250613095143.37b5500b@kernel.org>
Message-ID: <871prn4eim.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a112e3a-b54f-46f2-0876-08ddaab21c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UuHKjh2xdvNXeFi9nqfJitWGBdtVs/aeWvCG9wS20Kn4bN9DTVT2qt6Q/Xk9?=
 =?us-ascii?Q?Thlfbty+k4PAVVZwz6sugMPfjtEYxfEI/dGWfb1lPkIIAbgiStvDHc/qGBV3?=
 =?us-ascii?Q?VwwDVM7d9MqtLTddMT6w8Nopy/4Atdoh0yefCAQInnlH+yVoQzOyOx/QHPOI?=
 =?us-ascii?Q?JX5oQ2dRYpQ7yF3mmieJt7icxrkY25kuoznp09oX5YA1LjfkP7i4V7tjJXEI?=
 =?us-ascii?Q?/7cDUQ9q5L6d4JCYErt8mAse7JQNK5qstfrQSPqAyZ+JMDq6jlgdHl4e4s+u?=
 =?us-ascii?Q?z+HWVEF08Dac89UU6bUHInvb/At1SUvKVuYieAKD/pbCxVGgbxGwDgVSZjmv?=
 =?us-ascii?Q?9S0up4PlBzWdLDAoRuvUzuXKEGm5PZp+E3kJelNg9pbqq7cK0KqlgLDfm09V?=
 =?us-ascii?Q?YJCYi1oIQ24XATv2+grVwExVk6ztblLw4Ux/d7hLLotF5AvHdmp7yTmIJL5x?=
 =?us-ascii?Q?2jSNfhImtrduct7xsIWEbph+jgennB9abGpfHN6SS6c3tp6j5yDnAEectuEc?=
 =?us-ascii?Q?SobBqsWnKtldapEqTkVUEC/CWjWIAF2mL0pkjC7ZWdPjamojgVsqU2qtaIM2?=
 =?us-ascii?Q?uvrS8in3IC6niA+tllimH8slj+HgSWsOfngGtw2GHgFUjw9bLx/0vYr7N1VV?=
 =?us-ascii?Q?/g2XFc0m2JVQyK4Stv5FCA/zOB8QAZsndhKp6UeLrssvm55jkdKu4XzMpoPR?=
 =?us-ascii?Q?4sXgx3j0ZduvOQAXAhqw7jl8Azmlr9lPqltB6de711pbhTrF3SFC4skUBgmQ?=
 =?us-ascii?Q?V2ZecRkJsLO6GE5T/X+xoQvTAElo/QEGf7sQBDM7vO1cIsk32Gk0eyYMESJV?=
 =?us-ascii?Q?ITtm4dp4/qZ2rUmu409s5Cwqm7jsuHK6QTLjmkBcvVgLUjSCgOWJLqydqxuR?=
 =?us-ascii?Q?g8KoZ4UArNlOVzl6Y/nn5R+v6hQwosmJTwLT11d4t+OK19wl8/FuonnL6Fbe?=
 =?us-ascii?Q?OQmzUfG1hkL4qXDv6tqFxHPQMA0r5bj4LMx/4sSCtAOJ/0tj63AnfMSIOGFF?=
 =?us-ascii?Q?25S6/o2SYR6dNkqkHcnRmWzzOE7aPt6SFT6AlF3cGr9GQepWF5G78h1o79gT?=
 =?us-ascii?Q?UMkGFOiyuQ5Cyt8Ust9GI2EsAjYdhNsXvar2KxmykegloCDqiPb7L4dXnNyi?=
 =?us-ascii?Q?R9IgaB+8Wo9mjoiAWK6SKQFKSKCQ5oBBwCGTB6HcvnMQDJu51eAKvi1XXn0M?=
 =?us-ascii?Q?PThentY2ZmyHYSdyqvvw9ImwnqFC19aA6VVTV0UNXo/wQbO6PfD+x4DR38jk?=
 =?us-ascii?Q?PojLzXqp1p7QSlzVyGBPT1sxO8ssOY9iI9c8GiJ1i3vRRzRP6ovIHmnU/32/?=
 =?us-ascii?Q?25jsckMQRaKyL/012W0nQVzqG/aNZ9QHIrYO4ti6osyVsV4kcPPi9ZY6yIPu?=
 =?us-ascii?Q?88ul39d3KkSZMS0W/+BfSsCMSePgDnbhwijf2DbDdBDnClc/Mqzm84PJiTUO?=
 =?us-ascii?Q?loN5ZPeAvmadpF4eVCJnqLgj/HG0xcvUtscVY7T3yw0Bv62dnJLYLc1qhlbh?=
 =?us-ascii?Q?bj4S8JMkeLWhFR204u7Mtqu6Il4Avkkq+72D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:40:11.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a112e3a-b54f-46f2-0876-08ddaab21c4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 12 Jun 2025 22:10:38 +0200 Petr Machata wrote:
>> +	/* Forward the frame */
>> +	if (c->mfc_origin == htonl(INADDR_ANY) &&
>> +	    c->mfc_mcastgrp == htonl(INADDR_ANY)) {
>> +		if (ip_hdr(skb)->ttl >
>> +				c->_c.mfc_un.res.ttls[c->_c.mfc_parent]) {
>
> weird indent?

I suppose one extra tab would have sufficed.

>> +			/* It's an (*,*) entry and the packet is not coming from
>> +			 * the upstream: forward the packet to the upstream
>> +			 * only.
>> +			 */
>> +			psend = c->_c.mfc_parent;
>> +			goto last_xmit;
>> +		}
>> +		goto dont_xmit;
>> +	}
>> +
>> +	for (ct = c->_c.mfc_un.res.maxvif - 1;
>> +	     ct >= c->_c.mfc_un.res.minvif; ct--) {
>> +		if (ip_hdr(skb)->ttl > c->_c.mfc_un.res.ttls[ct]) {
>
> I'd be tempted to invert condition, continue, save a level of indent.
> Presumably we expect TTL to actually be large enough so that'd also
> make the expected path not under the if ?

The TTL condition is expressed several times across the MR code, always
in this way. It is the happy path, yeah, but I kept it like this for
consistency reasons.

>> +			if (psend != -1) {
>> +				struct sk_buff *skb2 = skb_clone(skb,
>> +								 GFP_ATOMIC);
>> +
>> +				if (skb2)
>
> maybe this is some local custom in this code but:
>
> 				struct sk_buff *skb2;
>
> 				skb2 = skb_clone(skb, GFP_ATOMIC);
> 				if (skb2)
>
> same LoC, less ugly.

OK.

>
>> +					ipmr_queue_output_xmit(net, mrt,
>> +							       skb2, psend);


