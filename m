Return-Path: <netdev+bounces-76650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850CC86E707
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15921C209F7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0357848D;
	Fri,  1 Mar 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EeC710O+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419C46B3
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313539; cv=fail; b=TfuLmm5D26Yu2UCl8cQ/sjAhhD8ShqQNe74TxUsFXgXYC6c3hjEfU4xsjDbPSgVePD22UQYRU0b2nYIxhyxsjuwFSjT25isnie15sGv3GfhiOylSwC5H7AuCgEKSvWCyDaWnsV+V+qMw+xDPsLXfbZ0X7s4WLuAaEdQSScUMK+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313539; c=relaxed/simple;
	bh=HKTCVsc0cYmoYtC1dHRsPu+h+XXFTZvN9zYAuPOxJ34=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bjBgYnwoAUsZvONsrmyVQmDm0fUU4XFgDmCxnralahWUi/Z9eHs/yaoFD9gaafsaS3YpN86CI7kqUWk4zoTRa/N9KkiXIo8EhPikVLVXiJQtvLowxJ5PGDtAjJz7rzIHIkXSdZPAOOvcultPOxGDJlv2k2a75/43NwnIh7sVF5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EeC710O+; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOr/dYs45ngkvHUjeVS9mCLlVxdjsvJTGnJuQXOUOGtoUQum0lwEmys0ISKVR9l+NjutncC1NNT68AW8BlKzBDzNhS080INWekyaN99pZpBmCPEyBGV3HVI9pht71d3wHu25mwDgWujt4/WAYzxcQcRUbfe+be/6Sg+p2kF4O7PyyZzQlYE5TY7BoCuOQ4v1M83U0nxqIoY659zQVGQYv5gvTix1fFRIPviGhFa0/3JPBzn9yqiotb3BCNEWEQUXO9M/Tvt/fiMGV3XjhqbfE5n1aqeAxaDnTW4XzTqPjxHAUJU2F0Vnz+EJ/qnXajQgY8Yxvvs2i/c1HYyNgglcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K7o2wI1+KuEqZUlpqFFzDG0JylKBgQKwaxQFZ5gTgg=;
 b=ggv7VJo77Bp3o6VGHERoMbQw9VZ4xskDAClxdm1En/H6D/5sg0A/KaDi8C/0J1U6menchdADxfjTrrulRlYRFA2k3YDyFqavmJSiPybAggOEKcb7nmu8AOTeyAS6QkT7me1sd04Bd1JAOikswduf84CZHg91U+FBVOS2CWgIiXDKg+ULx3bTYQ0LpeJisy9wzc4+aQgKPeCxyXUGT9apnNNbaT7srQRG5mGa9vjjgIz54/rjqbkPpu8XZjGBo12FTy7lp5Ohefd/ho1VDbmKMvfYz9pfo49EJ/phDRGmNF8CmhkHoK6jHzOpE/i5PK4ard1biuKihFCA+zj6MojLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K7o2wI1+KuEqZUlpqFFzDG0JylKBgQKwaxQFZ5gTgg=;
 b=EeC710O+CwfZ7ViNAvhNzEriTwSsFaNTAQNLlC44vTGvIvEYu0AtxfHgkUTnZJhZmnuvVK9aUf5Uk4RMT7t++lCwyQrNT1N6nBP3yu63KXSi95HQ+A3jEJ8ymKwNp8wxRSnrUMrKL/WJ0sNBi9hSFIKwoJG/wIy+yXGfjsm2bMbsExMkfXxlp3966q31E+OwYvTxOxqNNBUfsu4Cc9Wr8LKpKKH+CPGDurHLjrdLRgf/7P6AaounRmbPujs4OvUgV8bxwLEnc9JsN6Y6bxDyMvKtRLxwHCj1EPLHlYNIQvDubN74HefmpDwTdNIIgirSaQq7lUvGM8PFgSjOHOzGag==
Received: from SA9PR13CA0080.namprd13.prod.outlook.com (2603:10b6:806:23::25)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 17:18:53 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:23:cafe::30) by SA9PR13CA0080.outlook.office365.com
 (2603:10b6:806:23::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.18 via Frontend
 Transport; Fri, 1 Mar 2024 17:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 17:18:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Mar 2024
 09:18:35 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 1 Mar
 2024 09:18:31 -0800
References: <cover.1709217658.git.petrm@nvidia.com>
 <223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
 <148968b2-6d8e-476b-afee-5f1b15713c7e@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Simon Horman <horms@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 4/7] net: nexthop: Expose nexthop group
 stats to user space
Date: Fri, 1 Mar 2024 18:17:28 +0100
In-Reply-To: <148968b2-6d8e-476b-afee-5f1b15713c7e@kernel.org>
Message-ID: <87v865na5d.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: baea2e9c-3769-492f-3f90-08dc3a13ab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b45KqwjeinZnI6EkOvON830uvBObkyA+IggW0O3FJhFYc92rhuxbCO3vK/0kV5QHh+3CNrJdJmnyjGzkj4pJJqfm+IcjbAa9hT/0BcMoV7ZAwkOlJxBP5oZpFCbQB+94po6g9PCHsyhjR/9I0RyJGoKBROUsXO+Vduu68Q6DpFPmpZrS+rQy1EYccjv+p1nJWIsDJyHhJzcbVCe8t6WBatZNheY5gx7Ti4Sl/l7SAt/Jlkg1d2mcefoodYjvzqkQ+X1O4jJhKG/j01K8Yostifl8+yNpX0WTALq5McMwhb8K133LbqPJY6Z1Rqfo2Nqi6+yBXgsYIAGn1bXjOik5qXj/No+Slm7zRQQAfKQSuCAjmZyD5wmpAx6/muW7rZaMY4EDr1374CkGZmstYllhJI0DO2d3o0ag+K5j0mnEbBzt1HwdZQC3c+Ar4CTIjbEdvpIxfzISDnblgCWW+nNcFtrCyVhgmpwjO7NECPy/hDrUeNWuVnoPWm4auL4hIJDUn3SdPClf0hy03DicFpVUt0ee3w4TkS/IW4R2lqmlZGv4LVePAF5rXS+82x+bWg3SwWKr3LXb3AjCoGVTzm8Xt9XQalr4crwUzu54NpexiTEOQlbBrdtLgK/gT0jykqs+v/PFwgLo2PaSoa7wd9BpaLbyGEh74M2j7MI89vqxAP0B+BpBF2v6i48FTXEHxcznNz10xNP3sMZ/99ytDq3Scps2/0GZTV3wes0fFfF2EK+8TlMI+Jaijbf08tpXQkNn
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 17:18:53.0134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baea2e9c-3769-492f-3f90-08dc3a13ab3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738


David Ahern <dsahern@kernel.org> writes:

> On 2/29/24 11:16 AM, Petr Machata wrote:
>> +enum {
>> +	NHA_GROUP_STATS_ENTRY_UNSPEC,
>> +
>> +	/* u32; nexthop id of the nexthop group entry */
>> +	NHA_GROUP_STATS_ENTRY_ID,
>> +
>> +	/* uint; number of packets forwarded via the nexthop group entry */
>
> why not make it a u64?

uint will store it as 32-bit if possible and as 64-bit if necessary.

