Return-Path: <netdev+bounces-166060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7130A342F8
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571711884D5E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78623F403;
	Thu, 13 Feb 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6oIzy84"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912C221571
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457582; cv=fail; b=qhcJovJOOz+tdpeD+T/vIgCZlgjhFYTzqkedquPTwKebSjxxUcS6HT9fzfWxiag7dTOabLAQCcfnnaasF2OfV6ZrJmdhvRVr2eGhyRU3VwofAYO5sNnc7oO13e8atIzMvtqFsuNYz66Ku2rej7LpEKoI1LkjRRhSvJ0ukgcmKEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457582; c=relaxed/simple;
	bh=RgIOYS76NwB+MDSw/1YlDHu0Ser3dYd6eoZpu+nDlUk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Y4DhyK/BzfjsIsS1AOcGdHPWUsdjMY/jvONF8d3ANwH+ef6wa3WBRo4dl1GLiERE0zhoRmm3ae/4jvSnJ/2tP0UIeNyqjF+pQj6SKd7JSmghcuPsFGbFQo7W3t0vL8bo2lkI7oyfoB9Y4vbADKnY9mRSviZifddllsaERxVWDDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6oIzy84; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQnMgcOc2F7TgxLD7FLbXmqLaDEvwIC4KOCHyyLhoixIB9OLMhJkCZ7KSkvk44+LwVC+O93CtDuO7iANoOI4nd/7YCLdtYOAv/mAX7Noe1JZGGSr2XMV0/soWo7y94oQM4OjFcxKA81amabsMNTZ9qHnPZT+amby6shj19SY2K80/DI2yHKLMtOg65OoJ+2GuZXhO3gC2SqL5+nFN/3IN4S/hcuIMv92EJHfD04YOt2LM5cehdy4uRGY0sKU9SUS+kbffuiYJJGTXIWhh2bMDoMTUi7Zbt9UA1O5t/neSwq6rFP01cw83RgxYMovOn0xbfXnNEaqMCgvdPim2Jk4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgIOYS76NwB+MDSw/1YlDHu0Ser3dYd6eoZpu+nDlUk=;
 b=qBvFDDZ7jsIiCwhBxkx+zats3gqrwk2sMHezwieWOQFRhf5SjeDUFIrJLRr2IBDs8ibEhvmI0fbt0NNBFaC8FGSHLVD+3MnoqF2FuUGXuFztTZejQ0/PEqPcT5u+HJH41my8GnF79kzVCvDdr3CULRF7EWvstl1bXSZfQCtWZg+NMebqSMyuNbC7Idauc0xCySOvm8JW5cMdB8CD/UsRKqL0mUSVHjPbiMbQsVF+sXD2J8HudHhqCEEXS6p1NQu7tJi9Vrs79kpubd9KeR0FSz7E1iqIILycrKnbwBfZqK11XqeaCxuDiZB1NqIVfB5jEoen9+AY9gcXBtjDpHtd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgIOYS76NwB+MDSw/1YlDHu0Ser3dYd6eoZpu+nDlUk=;
 b=D6oIzy84zvjlxk5fIvdc4oL57XSgWw2fybiihRrUMYBX3MAGT3ndCryk75jraRNNZhpNa9vFGF99ydtXNf2iujQ54/eZRws/5DOucRo5YWt9onFuXD2G+jd6LD3pWSAH/AHWnLAsNmpjOFb++nK6GOY1SpL1+u5//bZr/dU98y7Oa3vlF7qTkgJ3utfUXEA6Y+MFBsL+8bGW5+VHQP67hsV1Bd8ucbUUTgaQdPVWJ4lH9Erc53+Ra9HTBP5/vXnmNX1yGAeatcdhStyT/3AHdZ/F5o3GdKuaP+6P033BLwGGdrMLEeRLUHuzwtEZVylr9KYTPpq5NmiEtR+qIfvlKg==
Received: from PH7P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::27)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 14:39:36 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::90) by PH7P223CA0006.outlook.office365.com
 (2603:10b6:510:338::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 14:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 14:39:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 06:39:21 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 06:39:17 -0800
References: <20250213003454.1333711-1-kuba@kernel.org>
 <20250213003454.1333711-3-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemb@google.com>, <shuah@kernel.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next 2/3] selftests: drv-net: get detailed interface
 info
Date: Thu, 13 Feb 2025 15:39:01 +0100
In-Reply-To: <20250213003454.1333711-3-kuba@kernel.org>
Message-ID: <87jz9tdi43.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b75f9c4d-c1b9-4463-a30e-08dd4c3c3cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KiLfnq3ZRbczoZXBxpd0dzu12k/KAkMF9g/QrAy34SSXAfD7D/5V61Exc1yi?=
 =?us-ascii?Q?Gct7iPpAEkjq36q3QBoS03JhxiOI2B+ICAQi5+fcc50/dUAZ3hji7EW95nlz?=
 =?us-ascii?Q?tOYU6KxtccgnruneJz0rFDah+EQU5FNtImmGbqiCevGkFYH6xMc1Aw8K6PLe?=
 =?us-ascii?Q?oz1HeA+YaDWKfLpIorniSyf3ZMQ9uoDPX3xIv6oYMM20Pb1YBonzsaz+d/Va?=
 =?us-ascii?Q?qfy4+EVmzMeYmS/9mwIYBkugFyNQnRKgedWr/vwqkMWbZc0swOFBnoaeSnid?=
 =?us-ascii?Q?QEUNOckH5p7/l16AXvfCxBbmjaQq/XCTLVB3vO8RSXNjrbKtRQ+qanKS7I/7?=
 =?us-ascii?Q?WvezDdDiOd+Aq8qlZjdiKNzmGa31qPnp/vcsiKNMQzo5zTqWu7jDCjxg1jzJ?=
 =?us-ascii?Q?jNgcXhK4xfiwvfsTmcZZnkpyrdxA+hBSo0UGT2UJvNmH1RGiSRXguE/UlP2J?=
 =?us-ascii?Q?v8od5VmstO9M3rKGwF/iIF4KCp/COdVkvxvCJ1UuRDxHhz98IaZfyWSg36u8?=
 =?us-ascii?Q?PMP4ua74vwld+hUmTJcyO9sHAcoZXgbJom8e5vacJ0KaCrIQ/XR66J9EWr/e?=
 =?us-ascii?Q?lqKiVjqj4KZd8u4zkFy7Bt4O544zohI6X8Y66lMTrd2mvTmohsjPO+ikGYzJ?=
 =?us-ascii?Q?1ya9QynEf+U7NlhenuK8BmORKaNKqhX30h8lfcKV1uMEKQ9Nngvfv8A7Gtg4?=
 =?us-ascii?Q?laXnYoMlrGZgjD6/quySKHptAFnuEUdJJBbxhkCgX/an8KYSzUf8jokucMfb?=
 =?us-ascii?Q?9U4lmFd7DhCuZAxaUll4xXP450sN6f/cLCXdbEz9UOWPtFrWGHFYHyhbhI6t?=
 =?us-ascii?Q?/zz2QqeijSHnV+DEjmnosuWPO/UGXxVqmk1gWk3cODXFadxEi9+l7ZX/XZZR?=
 =?us-ascii?Q?6XV0GafizMo26/qiInaPON7dhtvI5rePZuCEzsi1AcykyA5Gy8zb7OByGGCj?=
 =?us-ascii?Q?or2GnaFYmu5uGSZvH9BrXiKds1Q6UawG9I2dbQ+Awqiu4abi6SbRKYgvFB3M?=
 =?us-ascii?Q?OyRvdPIlzAdB8OZibZKZZEV0Plvr3H//nweCVohbsR8VKFT6iotOLE3ZZbSz?=
 =?us-ascii?Q?AFPluR6mnnQzuXVwtM/fpw2PHFap02faWJvWT0Lnmmy9raz0AAiVzAjHtEo4?=
 =?us-ascii?Q?vy/fYLVHtmIYAgoASwIYapyxnzcQXWFgWRcIYtX1a9Qc8+LQGvmtnhiXvu6V?=
 =?us-ascii?Q?ikE/XLodSMOFkM3F49RZ+v6bv5KEww4ykA69FTqdahIo0kbB3XQAaqhtsaR/?=
 =?us-ascii?Q?19w4/5hNVjHENpGUDr8f7MTM7L9j0F8GBAgZAbRs3qthFoNL8Lgcgzbb5aHF?=
 =?us-ascii?Q?rsupqujXdVmoWUFuAKlzChdApv1ZpB+TlsVkJGhrcWuVy0FaG+nvHau6ycuM?=
 =?us-ascii?Q?kH6fKjgh5xn24fQD99Z8IvzNJoLGAnBE05L7AKbjerlj2X/2fq4B2BgN+c4H?=
 =?us-ascii?Q?hI3ZJyAdy6ZaTKANs7UJZ5IpzidIpsnlNjc6oykrGJR+X0+uJu4rd0m4327X?=
 =?us-ascii?Q?gSZvjk8jIQ9KEJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:39:35.7308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75f9c4d-c1b9-4463-a30e-08dd4c3c3cce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764


Jakub Kicinski <kuba@kernel.org> writes:

> We already record output of ip link for NETIF in env for easy access.
> Record the detailed version. TSO test will want to know the max tso size.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

