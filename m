Return-Path: <netdev+bounces-115629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1088947481
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6103281255
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1813D518;
	Mon,  5 Aug 2024 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o4b31HSw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E244620
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722834365; cv=fail; b=tvoKmTkeV1iVMPusWN6u8yfphM2ikCkdBU0V4sxGeLxNFhtXkxqR3Gc1VtGDnBb4JZfOIMKVZnRLIYkPdNAcTlz0g358pBx4iLPFNOeWERBjtTvmwoL5qtpFedByCctTFXxMV+9gjpUbhLQq1k+wveGKdeD+hAtV9UQF4uM33mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722834365; c=relaxed/simple;
	bh=7nADSGhTRo0T1kjkjDqouTCKLlWMTIX+v2A3pGYjyU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXP4cYzSe6sz0h6cWiSj46BKgJ9mfp8dT5EwppLCZBX5SYbUvb4N5AwJF2Hp80W6VcKDJekStXMz4r1ffxWmX4pbk8I34I51MKSY9mswEWwQ49/uPQnRm6IT4ONE6q/6WZq+ATzUysqiEnh6wn/1jSjd9v4L63rwGzEMOhyheMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o4b31HSw; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7wtOcr6ynpSE7ljtr6ZBfmlNYcYg10rNMMHwHypViTUb0pPB+zaLC05sD3XnPrCJDOv/dRlafFWBH1/MM360eIpF/SD731ZDRfV1F8VbE4/k2gvDqqpfMKxIOjNt1hzcI4GDDj2sTqmoEV5SeuKZMhW6T9uYfDxyJKcY0WKhetJQc4xZTrn+TrJd1iMw9rWdAv1xaM3DpF/4ZubHTARHIHmvxmL2u8p4Fyl7eUtAEC9OPB47GvnJZZPCb/uFt7eH06mUn1j/H2UwuROmKS7o7IFjkPsWuaBi9X3KacvDgBXMiYyOXLsX8g0i81CphkelxBl5CR374Od6uyKudWlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2ZiB16MtMGs5InXI0LJXEkE6huG2kxxlrfGR0S4Djs=;
 b=QEMokHpBj3vEuzSd+AU4xo0bn7iyGU8uetDxaa0pkL0siRZ7mNd28Zpl6/78qUYcd2N5ASAqPoqTvjbNV5IY2IeesrrBALjNunfIUV+kAY05OQAubENT37zf/IIG6nEqtsVIOQKevHEtFyXz9TRyaT4XnUX6+9LH8JWZ8QFO3rtS6Pklwwp3IGHkGHk8BoxVFAeCUqzfNDk/53gxW8O5pplm9UcJ+ceCKEpfQNPPAdsQsGljjyG4VEF9IaJw179mK/OWIYfVkNJrMECTMerEwwjWca5eahVy8jPI9VSGWjoAcyh+Ov0O8NA4qn/WK2MFwexdvm8HrNCkeqXi85k9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2ZiB16MtMGs5InXI0LJXEkE6huG2kxxlrfGR0S4Djs=;
 b=o4b31HSwedEiJyb/GaH6jdoE+HDf32hpr4HvePQXPDJxXBwLjXuw2h3nwKI6YNe+f1bxt9VQyc5JLFnUkt6MVPnC3j/9ibqH/BFGV6IlCvzEEdneJWIWDISVpgjiqcNp+hqBcB7Se7UkKEMXx0t8VvFynLtonOjX7StdI8DZTuXWyH/BskwBNdMoCCbzHI0eQnhe0wnrYkxBpKppW7yxu6LCDktvBFSk1fKy40hGuqjTbtGBC0GP9lqKV+9I0LmoyQOCpdxhKi17RVDgCzDw/AYnHcQvDcKB3HStK//yVHGjwAPCeURvyjcutigv7//uLkTIWcmkH2uj/r5FTFIxwQ==
Received: from PH3PEPF00004098.namprd05.prod.outlook.com (2603:10b6:518:1::44)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 05:05:59 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2a01:111:f403:f90d::1) by PH3PEPF00004098.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Mon, 5 Aug 2024 05:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 5 Aug 2024 05:05:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:05:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:05:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 4 Aug
 2024 22:05:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V3 0/3] Fixes for IPsec over bonding
Date: Mon, 5 Aug 2024 08:03:54 +0300
Message-ID: <20240805050357.2004888-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f67261-19a0-4af1-008f-08dcb50c4b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?REnm6krUH5NpLVwT8WVEPIoZzS20v80ztVq2pbonFjk1ICpIgOk0b7ZDvHRT?=
 =?us-ascii?Q?UCAi41DI0oNpS9BKv8omelWFvdxhFLhBGDny8nxPNeqTbnWg0DtF25drW4vY?=
 =?us-ascii?Q?aok+to2L93WN3zpHzy+BrFIYTu7RMAT8CDRKp6FKj2tF7ttlk1Vv8sKn7uka?=
 =?us-ascii?Q?8ma8hSP7D37zhhlCwWrwhD0buKWrjQF+/7GhPvVLpNqXcHhfE3le24NX4MMR?=
 =?us-ascii?Q?6AllG58MH5Eg8b7IB/DXI+xbVqAEXAOVjrpHTJUYs0vgOeRKw5UWx/TkNnof?=
 =?us-ascii?Q?6uiMA0gRfL9mWZuDPKi0GyIE8kRMFS0Z1N5qxIPAGaWUWx5M7mivxh7tXJ2T?=
 =?us-ascii?Q?qN+2ELTf7jjn7sz7IOLDwsa+HVl6C9GHTRmuBl8XMIWax+GBPlKZjk0b/crt?=
 =?us-ascii?Q?BXsmefualWJ8SL+Skp0hhRREp+9onceaBaxxh+ko/NhlmOAkkolu5zKFcMM8?=
 =?us-ascii?Q?gEkYW2s6BHdyh8+8DWKQbyDyhwgK0UQvjKXDbkuaFL1hIEB58vyfZKYl6pvl?=
 =?us-ascii?Q?PZo7hs3ccidzn5YED3VBlrrPUppJz6gTOSgg/rey2NhL7poNwTmdlP26KSKo?=
 =?us-ascii?Q?FsCQKZ7d6vQdEiNrvAz/ThTuSokkHoFMYXEgXLFBY65cQizCt6JnhqePQP2d?=
 =?us-ascii?Q?zBQmfWYb9jCn+8a9qzzEV8REseVHZSnRlkc1Jlf33anRki9Rv/SrKp7NKcQ1?=
 =?us-ascii?Q?xx41QiKfn5kytdUYrabcRC/XFIWRljLHdIzBXs41WxhTBjzkvyOEMgVTiwS9?=
 =?us-ascii?Q?a2sCecALeJEOl81G4M4eCkyzMXu4BbRKCXE91yCHzBoCcsZYVtiGEzNOPwJ/?=
 =?us-ascii?Q?LI4c4sOUdpRbNvP28ZZTRNAzjM8HpUNkDGHI5BbNkYDj5SgMezP0sj3lCKpW?=
 =?us-ascii?Q?4uSxM88Wq4KkpKpLvYSbOj0l2UTeMwfLO9h4zP5LE4K7luAu+4zYHOR8aFC3?=
 =?us-ascii?Q?eu4WbSXoU8Ghf6SeDfZATtWmqH/WKR3C9iXfkAzLiZo0NChMFN0CMEnjZP9g?=
 =?us-ascii?Q?LlimNUMVlSAUxtR8seDlXpd5ogsuDndz8jpf3V39be9ky5vAXWh+SR8xOgBp?=
 =?us-ascii?Q?ErxSmawtzA+w5nibOkebor0ESCraMZ7Lpq1hZlk9ok/3EevLOUXzbLH72LNW?=
 =?us-ascii?Q?f6Sj/IeL+TxjS+yy+uWt1eeTChNB/pRaaM5O2VUshmu8K6RixC4nARHODwHo?=
 =?us-ascii?Q?Y8M3q5wRtnNPiB7WV9wuuz0Oi7N5V6xNUjGE7tpo88X1bZLIJ58IySOQ4JFh?=
 =?us-ascii?Q?e5sRGHfqFZe5YDvOUKU6/8dUkw4qwBWlyUFZUpf9A8pH5q+I+U9Xc8vOrD9u?=
 =?us-ascii?Q?ma9w4RGIjF00asQXPIRykB89tssdGTxICmuzGX3c0c+6mgX/mz/OUUhaXpNt?=
 =?us-ascii?Q?/vihaIq3ZZNBr0DyFlCPAIlVkN0G+Dlp4vPB8UHBQCm7fKTmZ+yhHueDZT4q?=
 =?us-ascii?Q?Jftt3YL0pzSpDN46uFsbDhaMxGU6F07h?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 05:05:58.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f67261-19a0-4af1-008f-08dcb50c4b0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

Hi,

This patchset by Jianbo provides bug fixes for IPsec over bonding
driver.

It adds the missing xdo_dev_state_free API, and fixes "scheduling while
atomic" by using mutex lock instead.

Series generated against:
commit 14ab4792ee12 ("net/tcp: Disable TCP-AO static key after RCU grace period")

Regards,
Tariq

V3:
- Add RCU read lock/unlock for bond_ipsec_add_sa, bond_ipsec_del_sa and bond_ipsec_free_sa.

V2:
- Rebased on top of latest net branch.
- Squashed patch #2 into #1 per Hangbin comment.
- Addressed Hangbin's comments.
- Patch #3 (was #4): Addressed comments by Paolo.

Jianbo Liu (3):
  bonding: implement xdo_dev_state_free and call it after deletion
  bonding: extract the use of real_device into local variable
  bonding: change ipsec_lock from spin lock to mutex

 drivers/net/bonding/bond_main.c | 151 ++++++++++++++++++++------------
 include/net/bonding.h           |   2 +-
 2 files changed, 98 insertions(+), 55 deletions(-)

-- 
2.44.0


