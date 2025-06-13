Return-Path: <netdev+bounces-197620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08CAD95C8
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5423B2132
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688B220F47;
	Fri, 13 Jun 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pWK6nU6L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD91993B9
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844090; cv=fail; b=Z48RQdc1Jfayjvc0U8kQBfCkMtfDTcD7zJN1DN6joM+8PqWqZnOmbpJpMk1qF+W1DUKfjELGwPkQFCgh18ybVqUsT20tUFuvU+0PG5dRMdJWERWdCqrPijY7fbeFYmLK3DiIgoySsCIMqA6XzEnq+RrmD2opJOq8eoEXZPpaiRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844090; c=relaxed/simple;
	bh=N1xBTQ9h1xrG2RjeK9AP6d+N0B54HDTBhetEI5ZxcL4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DzfD/Xhz3mYsURBw3sKBvAP/Czou498FVc1b/45pH49CkTllT3d/DBl0SlR5njIL4248LB6YOacSyLvCnd4KVmqcg1O50ayVIHfDaJWFN6lmszEC61UYKJEkPXKgHX7ZCHjLHagKkhjZJSeUZYtuZtDwgQoMhW22kxCsy0vaTyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pWK6nU6L; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAEwSFHB3r/Q7siTV9A5YBB8pwbwiC/Mh3Ym/v/ta1RU47SIAz56xv30P3i8CQ25XNJ4m8i8yu+d0KYFQrdlvOhLS46su+biga3xuEFP3l5+jdcv+VDt2wHBIRGyoAj9e5ou8STVpz27N2irVRNdThOQzVbGhaOQQmBm0NSjcEbwGVZ3vwCtq08xqQBMSXRFSyQc7bP6SGXyiLwRtYu2k1yUgO74JqfIID6vqCEJ9SU/2cIcbdczjYpJ0likBcSPeYe1sr2ewiOk121Dqt72OZO0zdj/cUqrAdgx4SQX+ObFOJQ57GcAsFKaNAEipmxVlb1/G9z3kvOIv9xzJ9Ggog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lpjY6uY+bH/SZWXWIL8uxk3alw/FMNG8kXYv43/unU=;
 b=GUrwrTjc98Ia9ZoSmeKx1THtpn5PQihoZYJqrvk15A8C4/8wb0duUCJYtSwKkWlPbj/qYLocPJeURd9mq6DKfvhp6RdzHOnludHofz7N6onFLJnC2mPQKu2eq/UzpyIanrJK0xPaqnHFxWkRJtskAn+FnMAbyA5SWsD49ZT/gxi6tpXxvvSHXtDxEePyg7ZSXp2m6xx0J4MEJYJHNXq6G5YQoI7Zpw4JmCBB28lC004gd1V4EiRfVjI/aznIb8dMiyGJaiWiaMnRPZGX3i022pj/En+Hu0pb4TVgS3SAz3sMzoZ88ThFGIqeebaahJshDv3Eh23qPBMKvncxh4VzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lpjY6uY+bH/SZWXWIL8uxk3alw/FMNG8kXYv43/unU=;
 b=pWK6nU6LnzzxH0zu3x0pdkxI9RjY+W9slAtxpSqj9JlIaIZFOgiJq2nM58oLwEEUTTLfy+HrMuzZ6naY9mPMCbZ7t85p9XklegMQrHeVHBg4jewoJ2+bNFJ9pgPwUA33RVLGayiUZYShnvpwxA36+EfzgENbeuO6dJ3LqUAt60O1RsZgmEG30m65fKl21ALHuTxFl5Ary1YpoMhvsrrJWaeDFTThsL2aWAUksiIjN4zPTOZ/NvAvA/+2S/5uNSJmlIUaBRkey9X8VWJmvJfCGqbOMFOXfquEBgUoi/ff/0CEAbXwhaT8DnAxATBcLBKqGOiTjZtmPidC0RbHebagBA==
Received: from CH2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:610::42) by
 DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.25; Fri, 13 Jun 2025 19:48:02 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::4d) by CH2PR05CA0029.outlook.office365.com
 (2603:10b6:610::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Fri,
 13 Jun 2025 19:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 19:48:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Jun
 2025 12:47:47 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 13 Jun
 2025 12:47:41 -0700
References: <cover.1749757582.git.petrm@nvidia.com>
 <0bef079626b34bc6531d83d79e0fd5c056ee17da.1749757582.git.petrm@nvidia.com>
 <20250613095347.59328a33@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 08/14] net: ipv6: ip6mr: Extract a helper
 out of ip6mr_forward2()
Date: Fri, 13 Jun 2025 21:40:38 +0200
In-Reply-To: <20250613095347.59328a33@kernel.org>
Message-ID: <87sek32zl3.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cda3a3-40f8-4f3a-277b-08ddaab334f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLqXpSvKOq+qdWMB8NuX+dRFT1KXGHnl5m5sQA6xFGfNen+QbjTNLLNU6HCF?=
 =?us-ascii?Q?HhRwqjhcabmlitHiTnkVxcx5qdx8nbKIKqn1Ow1H8JP+q9OROCOzT4RiiDyU?=
 =?us-ascii?Q?qVNEfrYNkV6ul9sgty2DrexuZVHhGMsHmwoQyydud8TV+0XTZpQZxQGjRhaE?=
 =?us-ascii?Q?j4UcoHdRFWJrqIFPY7qJI1RGJobzbNzyU4nreIuHK5Gy9PY9bkbFcyKUg9zj?=
 =?us-ascii?Q?rrNJ5d95HqH+KpRS9hxiN429apJSHs5UuAX4VPHPKhNTH33KUumEJxTQ9ltN?=
 =?us-ascii?Q?+1K6RG5Du54JD3DED5+dpHel81mmPCgvM9Di4xEJutD7bS5HbXFip4DDcS1w?=
 =?us-ascii?Q?w3FATEmp/yBrLU3ywHEuaQDrJm/gl2lDiu5XTBXazN4m8cUkEMx9KsQLXhEN?=
 =?us-ascii?Q?Mf/JMtHCCNtNFx4DfXkNeFrJ/54GYFRcedHqWb1kbbOOih98bZRJpVt2KWxB?=
 =?us-ascii?Q?WpBZnraMqU18cejTSDPqAtNChclmP58BQTAGNfoSQzH8jgpcSU5V3iiN7sW9?=
 =?us-ascii?Q?vJep3J0aXrBj512xoiR4JmdPLeknGHkEA0xA98c3Fi0PPzVc2A1EllMfwAnm?=
 =?us-ascii?Q?jrRHj1zUecpwPZCGbR8QNRkCCwghCkqKC3bCYT+pUBgTZ8CSfiSYMeDbTh6a?=
 =?us-ascii?Q?TuLIHVbiDPTf0JQH7lvPNLUiBQZxTeOm81O1o3lupKcz6cPTRKuPkaIdxJ/u?=
 =?us-ascii?Q?3EkLUdBno4ZfNrRcdMI8pAAaQlqwo5n3atdkpTz1N6QzEjWuyR4k1dIt451V?=
 =?us-ascii?Q?499v0ceL1UeQHFLkx+WL71nYY6zrPSBRswwT1TMaEJsw0t8ZSaDgpIJzwN8z?=
 =?us-ascii?Q?GMRrQi/6i67VpJyBmJ9U96HWutWT0R4cSazks7mKiO58NjoqRmqJzLz6ZfRp?=
 =?us-ascii?Q?3hPhB9AolDNFKEl2eS7sGhq/54It6QcT+Tcee2oMxaw4HHbAdox24bxldu9c?=
 =?us-ascii?Q?Su02VKkfiJpLsdyNNCdJ6burp9R/5tzWjbdWxNqXHBgSlEAIrRhmLBYaGmtX?=
 =?us-ascii?Q?wIcFUrWmbKqRwrzC9Lvi1GhshO3eHUBZ4MMyI7pjHjOofJxxPheb4DiSEpTx?=
 =?us-ascii?Q?yuhixR13pSg/q1xcMiudF7ye9ViT1RPVzmdYC8ISGMqhJpZqyuHgBa2wWYUD?=
 =?us-ascii?Q?JWHjfzASVerlPhe9bKDQE+JTrL6hTpa2sZKxxPHqmSE6FxoppIF2ME3wMU7q?=
 =?us-ascii?Q?1BV/XrZsl7jl8dHgwJ9Wcared7XBQ+IvzmK8rLTbrgf2O9rU+QDLXKV1LEDG?=
 =?us-ascii?Q?Slx0UdvK5HIYLoI82g+wZn7XZquVgLwD+ZpI7yH6Z6tSUzGfDef/mshjm9cc?=
 =?us-ascii?Q?uNQwHGFoYGQ6ndL0O5MBoD4WE/1jj/mEKuMDnJGEs66DWkUwTISAefkCWdvf?=
 =?us-ascii?Q?vWrkCXoaCmz6BL24PEao33KiamfmuJqXfDfXQvzhESgLvLgtXitt5KMC6dzr?=
 =?us-ascii?Q?IT69cc+eOSrAjfA5EF34oj7X7gkHYoakoeAmABiqFCD11rpHVWADYosvKJe2?=
 =?us-ascii?Q?wfokwmxxLEgagKoVDjYcyOKdKvpB3iTdyEga?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:48:01.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cda3a3-40f8-4f3a-277b-08ddaab334f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 12 Jun 2025 22:10:42 +0200 Petr Machata wrote:
>> -static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
>> -			  struct sk_buff *skb, int vifi)
>> +static int ip6mr_prepare_xmit(struct net *net, struct mr_table *mrt,
>> +			      struct sk_buff *skb, int vifi)
>>  {
>>  	struct vif_device *vif = &mrt->vif_table[vifi];
>> -	struct net_device *indev = skb->dev;
>>  	struct net_device *vif_dev;
>>  	struct ipv6hdr *ipv6h;
>>  	struct dst_entry *dst;
>> @@ -2098,6 +2097,20 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
>>  
>>  	ipv6h = ipv6_hdr(skb);
>>  	ipv6h->hop_limit--;
>> +	return 0;
>> +
>> +out_free:
>> +	kfree_skb(skb);
>> +	return -1;
>> +}
>
> ipmr_prepare_xmit() does not free the skb on error, and ip6mr_prepare_xmit() 
> does. The v6 version does lead to slightly cleaner code, but I wonder
> if its worth the asymmetry ?

Hmm, yeah, I think I had them symmetrical originally, but the
ipmr_forward_offloaded() call didn't make sense in ipmr_prepare_xmit(),
and pulled the cleanup up as it went out to the caller.

I'll do the same in IPv6, it makes sense to keep them similar.

