Return-Path: <netdev+bounces-195721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617EEAD2132
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BDB1886A4A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B125D54A;
	Mon,  9 Jun 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o1wcyFQ4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825315DBB3
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480190; cv=fail; b=Zm6B2ARqbnb7pCuBU4ifdyq+7lOsHERXBYx5Rfrd9sU1rnYGXtH65leY2bzgDpyYINrUcBpAWcwsp/ie1hfQlFpZv342A4m+Fq/+FOr8LrEmIMF1tm8dUyte5g68tcNpnVeQgBZsfFF/3wRpup3VfJUYbeTL+3IDMLYm9UiOhtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480190; c=relaxed/simple;
	bh=5vHmbgERxn5RUTW7R81lnAAcX++lhdJjDH5NvKwBWYc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IDq+U3NhmmxMw1FZVP+oIXWZfC03BqpK4rFwqzEMTzcaQCczTYCzy9uCDx0zLuG2Awpg2YOQsHLK5sNii6+K/HCzO57oxbjquxgc06a7d8Lyv5XWKm+GQEA4woYOMVFBWfDwSu1t1ik/8nhRGZxSgVdZxDsFoJcY/9us4bhx7k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o1wcyFQ4; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6fWVbnRlmDoiqpWrn16Hc3Pb+EcczBo4EwE9SgiGNIuM9pgZUw3n/fvYXRqntvth4z+wE8J6jzGH8boFX5+ptp0ICl7AtuNt3RhFG1/6jChOq9G7yDnBOb1GvQiBfMO9cnvZlQ6yPv5sR8+hgVyanOLzco7JMQUKXWjSb+eM6lnBElIoYS9b2K3Qfzow76s3C0RoN8pGoMXpYNySvIjGi7acWsaolALTSYCRMuecXwLtS8yBuklsk/9bRtQTc8OYaKkAliun8gJxLPEjfy3XlPgy6VIZ3hD6G2q9Dhrq0jCLFVzl1+pLz41FBduFnx5wk+IqyfPAuc+HZdEGdSTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWv1v+LMaTWxlw3OVgx/y8OOtOxf8PzOgZ0PmH4x1Tk=;
 b=Pg3y8Zc1tQJ6si6s/0smzw0kHZ0wIAjmBob4z5paIwUweVB2unZ4kv5UvfQKDOw1IMK58qTLDsI+GPGpAkusrSJcRXYU9pcB/NWGk/PCba5Iw2ldY8HK7XQv4UjH7KVbYVvuqmP9MzckAsEWS5WhO78JLvfTN80SlrlDg4bfH1f3ZVPx93TC9NHFolW8uQO/QoZ24BvyOALEJfcfVnG0lPID85eI8AtXcpEPzynb3FNkueGtplIHmvvrrFG3iua9a4pcaySiYxdcFriOvzgDyDqJUh2kRD9SlID4VNm6s5/srNH6sC5aQHI5jbd1fee+Ye0WdkL987nOHsXewXt39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWv1v+LMaTWxlw3OVgx/y8OOtOxf8PzOgZ0PmH4x1Tk=;
 b=o1wcyFQ40nJuhzznJz+wJEAflYy0P7SD7kUrySMLf2hI0v1jwY5o+WZxPo6RMnN2I90VDEpubkTjYU1UBWPOPaBoOyf5gu6IP1QEVnbu1LfoGbl6RmJpm/RJ204RPuq2tz8cPeD5NK9i43sQPZnoPATsa7wOMX1pY1Aw4oengg+T6xLwYidEloPunqgG/3d1arxOMwtKPvlsWvTrxXeaGUEJpr1nTK5so5NKmYGN21YcsXq+gY6mLXgrcfcPfTXz5RNv9d+C1fw3PHgVP6/NEI4o8y0JHed7+d7xT6azj8AX8zSk//2c+lzYx4gjwq89le4k3wV5uzORfgZyhgYGQg==
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.39; Mon, 9 Jun 2025 14:43:05 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::b4) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Mon,
 9 Jun 2025 14:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:43:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:42:47 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:42:44 -0700
References: <cover.1749220201.git.petrm@nvidia.com>
 <997a47a1dcd139a0e50ea4a448b45612b58eac69.1749220201.git.petrm@nvidia.com>
 <aEWhzO9WUiwZsaGl@shredder>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next 4/4] ip: iplink_bridge: Support bridge
 VLAN stats in `ip stats'
Date: Mon, 9 Jun 2025 16:10:50 +0200
In-Reply-To: <aEWhzO9WUiwZsaGl@shredder>
Message-ID: <875xh5f02n.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: e8188d36-f3c1-4940-5f83-08dda763f1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WpjAv+MXkSPcEQNMDL8cpSFWIZX5lBGzozajrtCzMEGxjpXzxfoUUkNaWhJo?=
 =?us-ascii?Q?Cgdyur7AQGCcwmYY/4k7jtxg2UpfZzs4NQCGrKjKigh/DDSd0FGCKaXogtte?=
 =?us-ascii?Q?byU8SNvaSVPeS3Gmn8y7XxtvjmL8/XXG0L/RexOBLMQeAYRmPe3gQ8ohyiJp?=
 =?us-ascii?Q?3ql86Vy0tRuQrTGWBp1ZZ3QSIJHLvdxQWjjvHD2YA9+zN8w4DRYTuOM5qICn?=
 =?us-ascii?Q?dpsq4Ra82uhfuwjviW5aYohO8CphnjabjvY5Jdz5p3c0/mEz4QxNPb6x1iAd?=
 =?us-ascii?Q?Yplga6/jOtfUy7r6+J1ZZ3K46TKZkMIvZSwDRu1gPmafra2zDkfVUI7eq8Nq?=
 =?us-ascii?Q?f/BPnAgfpX5gBdUr1j9o8ZldR3TxenrbQzkQy7ycHMdFipdkgYaGBmuOVWJF?=
 =?us-ascii?Q?Vzrjutg8KDmE/DR6xTwZuin2lwK5R2fLqKoIVPZXf3mV4+NJ0Q9kiIdjHSZq?=
 =?us-ascii?Q?VHstVUk6IM8zyAIoUK24VKe0TNfb2sPJNt3KfcwmoQMONg+OUXAXF0vZPymh?=
 =?us-ascii?Q?KBSxXyFDLmjDosFnewVKCBEGN3L01anXJXBsfAsFVW1PLNDd7zq4lyRZAdGn?=
 =?us-ascii?Q?6+2xTKN7YIdd2EbKwjPQoqPWTNejZ2PLJ47wl6wpcsgRjw6wmxmq+FZXLEis?=
 =?us-ascii?Q?9VVLOdBRblIcdVywPXgmrQ33ngsMwNNVW4lW46dgJNWixTqeRZp7GSHdY0f3?=
 =?us-ascii?Q?pPIqFMcacnqMYHLGU7/h9TT2VulxU9sO9A2xwvt+s2xA/V+RLVmnLVC+zbtY?=
 =?us-ascii?Q?gWzJjjstoRB+SsuqE/r2+EiGg86LlFF73sHHnkNO0Ke+bhZqJc8TMvcLQjpt?=
 =?us-ascii?Q?9P3fgK4rXLYYy8ZpJrjPY8FIhFthVzZKJ/8jmElhiupIoIjh+1w4li1Iqyel?=
 =?us-ascii?Q?cRG4qRtZIQZMalWLbO40p0lt7AhNrsm2k0vdq9vz3AhVLa+wQyJsG9ZhO9c8?=
 =?us-ascii?Q?P15F2CP90roSnIvR3LoOQ5W7nXCSG0FLRKgAawfxM7cURSNpEPY3Cde7IXWJ?=
 =?us-ascii?Q?9GKatDkR2RmZxmHDnGD6NSf3KTlQP1pAfY/fm6T5smTqS6T2HVs+PDbbpuSu?=
 =?us-ascii?Q?rtFSgVT8U16VSmdH1KEL5kn9quvX7Y7mj6k0Pdl1DrzYZUG08hhB/MCPxx1X?=
 =?us-ascii?Q?Jr7DMO4mfyRAEHYVa8CjTCUA8vtejwGuqzepWaGNDVPsllzeFNtMC4VkwCf4?=
 =?us-ascii?Q?9iyG64bUlvqVAhHyN7Fa+FVyNo81YM+9N4Wi9bejbOZRnLfL12XVOdGemm6a?=
 =?us-ascii?Q?jfyqdDcpvXLQd2z09nwUauw8pxnWnyGIulDlcCdnUM8B1JRV20TZVTPtlWsi?=
 =?us-ascii?Q?XrZMtGV0So+tHDlS0xBfwMAWbgpoD5ucF0BiJLaXZhr7iQ1/mZfYf5KenmUQ?=
 =?us-ascii?Q?BrxJ9aEGHsW1uqlPFf0ORnLkKJxOx0+QtJvbSEDeXLHDwW6rVzil1zyP5eEz?=
 =?us-ascii?Q?Ki9/sZSfqN4QQJAfBNubQKI8n9ip2e0QbthGhJk7K5os14tO1J6aDcYYTXjH?=
 =?us-ascii?Q?AKwBX8JxExoO06h9HfFhGN4FeGxpDSrkF4+h?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:43:05.4175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8188d36-f3c1-4940-5f83-08dda763f1bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323


Ido Schimmel <idosch@nvidia.com> writes:

> On Fri, Jun 06, 2025 at 05:04:53PM +0200, Petr Machata wrote:
>> +static const struct ipstats_stat_desc_xstats
>> +ipstats_stat_desc_xstats_slave_bridge_vlan = {
>> +	.desc = {
>> +		.name = "vlan",
>> +		.kind = IPSTATS_STAT_DESC_KIND_LEAF,
>> +		.show = &bridge_stat_desc_show_xstats,
>> +		.pack = &ipstats_stat_desc_pack_xstats,
>> +	},
>> +	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
>
> This will only show VLAN stats for bridge ports, but they also exist for
> the bridge itself inside the IFLA_STATS_LINK_XSTATS nest

I got confused by bridge -s vlan show dev br1 not actually showing
anything for VLAN-aware bridges. Seems like the corresponding data is
not even arriving from the kernel. Anyway, when I add an entry for
XSTATS (sans SLAVE) to ipstats it does actually work.

