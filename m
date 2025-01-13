Return-Path: <netdev+bounces-157725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E262A0B605
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848D71886A32
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BBD1C1F10;
	Mon, 13 Jan 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fNsH+Hu8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396F22CF30
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768852; cv=fail; b=q9rBzbM4P/RGRNHolbz4zjV3eLSZ5xaGVPRymt7dlyl7UNcsujOKnnCvIvCjMU1zf21bnJ2kyTXt3wexIOv3nRVEE2pdRyFZYJFUbrJZL91G9CFBBXdzXBSN2DLDjW7Edxj4eJeKfTvjq//oehKdfn3/lPXQT4d/xlfm9SE8Cmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768852; c=relaxed/simple;
	bh=HFr617am8W6AGSNw7xAmRzkJ+g83a9PxgarFfh63jeE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b5evp22HAK4wr5lHUU/7hiYZuRMnuA9Fe0PVDFPA3xKn4R/Wcy+OVJa1nKCuX9FmS6iSrSEGpdmPjKulVtJiJL5EhskeI8arrj7H6hDVb4F0hvgwFjezCskRDV9JhpzH43o9vaIogJ4o86bseGJTQbggZH1CjnK9bBNltTRmmxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fNsH+Hu8; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRd9+NoPjSfavCIaFAWVdmGVmAgwtYwNkbYMLPxWwan9XnIsVv8bgixGHI4iwp0pIS9rBN8GqDxsNx7aFFcfgHS/DhThej0fPh2JvdgqbTknOxhjQAsODWPmAageDRdWZn0wsR1ieEKDSF5vkBFixFEnR4F7YgJuFu4z7w8hL82qoZ3UCq3nw3sDiHiHiF4toWOoTBb327NLCCMnwsxq8PbCMs6csyf+PLzFizpb9AwmDl40lMpmvHK1Uv4mzR1hfocbi3EAENs19djDlzBQmVmXJ4F1i9EgwrfiYrpA44dwcjz7G89nqGkrogzkNSpd4UlzUrOzobh/NGZQE0r/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFr617am8W6AGSNw7xAmRzkJ+g83a9PxgarFfh63jeE=;
 b=M26LtjLDwhkTbcUGB4k2nytF/D1rPm2XPC8222Td5Y1tVtLWP8SJUA2trsMOqpkjDzIyX1hgx/PhgLu29GdS4JIiP1fh5OEbKV9tKKzLL3fbfpvq0gF9khgb1E/725vbweCg3VO1b3u22pIXKHlR6UWG20mArR0La8h3lvZsaq3C0+knuz2k5+vkKtx9939i6lh336b5V4evduOJsQcdg0yx5VspbSIRDLOnWU2dT7j6yeO0NQ9ig8skG5u8MvQ5VzOX0CkWbq0O7+3Z6jap1hofI9BERuRZTpEXbbktjiiDkIx9vH6+4xhiyqP0r/vKWsz87z1n67CEUiigTGpRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFr617am8W6AGSNw7xAmRzkJ+g83a9PxgarFfh63jeE=;
 b=fNsH+Hu8LTJDamWcivR3m7ws/OYPO2UMhv3csEwBzMyMr8dXOX0sQWKz9bx7j/R6qn7R8/F4GW800eZrc46inswtXUwP+mUsVlAV3XWdFHNqfE6a+TNKplaqitUT4fGD64sqE0zDytOm7pqoy3YWNqMcfhWhLHx4WWuSeh1iBJ+jY+N4OFZOaLlMh3ZllaegQx57xQm50NijwFklcy6v4RAhAYBvDDXWwOCWPqGuJJRSgqpqVKM+uFqDv61tf2w64NBbmRlzuYo43yoLXHJtv00kE7BjEO9fe1/iyiZfCHNVMGwCxhjEedCzrqzqZ3K4t4DmkXdJnIPjXmrFXqCf1A==
Received: from CY8PR12CA0064.namprd12.prod.outlook.com (2603:10b6:930:4c::10)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 11:47:27 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::7b) by CY8PR12CA0064.outlook.office365.com
 (2603:10b6:930:4c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 11:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 11:47:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 03:47:14 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 03:47:08 -0800
References: <20250111144658.74249-1-jhs@mojatatu.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: <netdev@vger.kernel.org>, <jiri@resnulli.us>, <xiyou.wangcong@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<petrm@mellanox.com>, <security@kernel.org>, <g1042620637@gmail.com>
Subject: Re: [PATCH net v3 1/1] net: sched: fix ets qdisc OOB Indexing
Date: Mon, 13 Jan 2025 12:46:15 +0100
In-Reply-To: <20250111144658.74249-1-jhs@mojatatu.com>
Message-ID: <87msfvq6ko.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e0f890-96a6-4bf3-7acc-08dd33c80dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pfioerjPwWb8tC0/d5QQ1hFOG82toY8FG/bBZSssGbWLTbIdtXwhCVqmjhJW?=
 =?us-ascii?Q?yVYRSnDULfkzeCAjwCRI+4HXdWFc1ruin2V3h5Qav4S9PR4IMFkcKcb5FodU?=
 =?us-ascii?Q?LngtKE72qKDYVDCQCoXjemZajV/GB4aq/a5x5Nzfxd5H6p1Lx36DFpZYtmwn?=
 =?us-ascii?Q?QAwC1Gmv10tRl4RAfMCOtju9ifcJyO5px67HiDfC5+QQttvQ1rlnG9yzx/cr?=
 =?us-ascii?Q?jVdeLWrnzjlGPwsnogpTTdzxmc5fJ20BSLo/vABRIS19s3fjdsgN+KNMY3fr?=
 =?us-ascii?Q?8ZYRThDeWOCBkESBr0ys+x9XnsrPBqhepSEosWV46wz2ji55K4c/yYJdDp7d?=
 =?us-ascii?Q?m5j46JtFeP8ZzjCkyN0IC2xxUQVxA6JlNMCs0uJuXJ/YLhEkQ8T5n1U8cg34?=
 =?us-ascii?Q?82fsUIiFXMCwTJ8FdjXQpDnwmKCyqalxohliC7/ov8f3nSBS3FV8UfYK77IY?=
 =?us-ascii?Q?k6JzYqE7+kKU+Qx/FxcDOJ1NDbFirjbQ9yX1g/MduHb5FL3cC/KoB/HdJuQZ?=
 =?us-ascii?Q?eMYrBFlCMpcQVW54TtiNiJZOSOXYm7WXI2fqBV2BDsflUtb/4Ygspiytvciv?=
 =?us-ascii?Q?IWdaeLeqHtcn1Q3wr7O6mJcnjHLE4hVjw/7qksSCKDyHagstUZQpmLGWB8Hh?=
 =?us-ascii?Q?49mBTFh0BFzjiLkxfhNHpbVrkKEsEooE5sRsrxUSSGPqg3Bnfhc9RVLKg+GD?=
 =?us-ascii?Q?0W69sZQkZT4pIAUtlZp/0iCuY/YgswZpH1x2LVSRtxLhEd5IVMtz2vdVOsHe?=
 =?us-ascii?Q?2ghEacvS2AhktomMKpY8c1snzjwORLiAt/jLrwDDCPl8pq4mirsHngSEOI+d?=
 =?us-ascii?Q?gDYmHyFidLxw2lfy9NH7vx32KXz/wipZN2v/dAXzvUjB4LPotJunUphoMdgm?=
 =?us-ascii?Q?S7apz7PoaU/4A6iLqWe+VVADI6G4X7a0FmvFvstSx5AnHvxtJBJ0c3is9dDK?=
 =?us-ascii?Q?JEBKnisI24mPbKmNxiRgapwKs+zSXPQeh365Md1V18DRYxhj8qphuWJpVz1r?=
 =?us-ascii?Q?XA/kwV4Oeus4z5VFClFMAoBP1ftiMdD7+LOpaADGQkxEYxMrmzTmlleghye5?=
 =?us-ascii?Q?SyQ3g60/Z5YwjFsGQ8Ye7F5Covhyvau6JJGpGY3SC4IHzHhIjmzEQpfz89A5?=
 =?us-ascii?Q?ldZzCrD57AJAqnp/GWr/hhK98dr+c+ZairG42hcGzzjveawdRQ02B8BMVkSj?=
 =?us-ascii?Q?pmHqAk+xyjB6UPqTAZ6pakt874thh0kOcyD8QRTAmdrkpChQI5cgqeiO7v5r?=
 =?us-ascii?Q?m8TP+w8x+ZkwfhWM6IfHwhBAclpphgDZLkCb18NIYZkBKjdDZdW5ll4FDqeV?=
 =?us-ascii?Q?qmhcnYBowN35U95G1JSPttcbmGc80js90lYg0hbOaGcA+54Vi5rEoRYIzOmp?=
 =?us-ascii?Q?jQOV8quM27oRiaEqwD7H9XNew7bjTVbZBTaYJ53mmrF8JiL3f/Mi69JrbWwk?=
 =?us-ascii?Q?VvMup/eirEHtUSWjbcV2kPfMHbr7pTp4+la6bmqYKfOC+yb8wM16sIRxndAe?=
 =?us-ascii?Q?YL88ar/htzO9BdM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 11:47:27.3183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e0f890-96a6-4bf3-7acc-08dd33c80dce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755


Jamal Hadi Salim <jhs@mojatatu.com> writes:

> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> Reported-by: Haowei Yan <g1042620637@gmail.com>
> Suggested-by: Haowei Yan <g1042620637@gmail.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

