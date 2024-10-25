Return-Path: <netdev+bounces-139138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FE99B05CD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFB21F24609
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096D820BB31;
	Fri, 25 Oct 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VWcOjOfa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31A20BB21
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866468; cv=fail; b=iYTiKChEMTIncf//tX/QoP4du8wUKIlghWFPLxZZOcN7haJIVaQfudfvkuQ6a5Le+rfmtzU3hdPUBCeIurtznMSTcc4b7/MyzwTegT34PTW/l5wmtj+WyBMgFzdO8qC7Z+16OM7QEjtjTGT3JbUk+6swPmMpwzE3N9nxEWQ/sww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866468; c=relaxed/simple;
	bh=0xBNyGozvBwky5YWZy6dO6f/jq14uSlpKLdF6yvf+Dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUcKJE3rNihpObtu9sWIVi/TtwWQ0DjwtQdvAF5nx3SZKm/EOrUTgaXISu4ho5S8i6QAeYmbGMPXO2qUVOUeefXDTG+1BzddYHYThlxBLLcgGHhysHeOgI0CSg2IfVT6D0UtZvpccTl8UQS2DMgNzOY1iKrJlbIlvWsrHy3OJkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VWcOjOfa; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyWmU5nfQu0N2s4YJWgsSRfRwNse98p0M9ycZ+k06rXLMIXpfJFuFG1JWjm7BRZHRmZVfgj8Kr7XPK39saeHl9TH2F7qf665OBKhqnseu4GoTjyfE93bm2ia8n5gU0G1TrO3iGz1s2ewbIggB7guJQekcT0F/N++up2c5CVrOHrBnICxpa5z1OEPSNacxsWqusYrLoLa0gLYtr31T1N3nHjO6LeEifYBmmQqNGUYT4vyUc3fWq4q+m6AAZgR9P/KlNSFEK4SY9JG9EvoXTfsatq+ZpOxU84YroRy/DkMv8VOX16+dy/spynxDJnKidt708g90qRBZFjwX9fj4H2I3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTDpnscTtnCmguKoArzxwjo6aQOHkpUOC7+R6iPLjP4=;
 b=j4OYHpa6OYDKNyaKn3SD1VU5ZXTj5u3GRzl0i1Acq1gKfLD+4wrvAxuh2bPHfwCul7Qn/0GwVbnP8WrTS7AXy9ZCUD0rwSgFbPQi7e8EMCRXlHTvPJun3/wrGqG26hpjD7IZ5CKkINhidFIsY8EpICbyYr6k89PYUp3h4/+oUB+QLo6H5M1px4fCFAnz/VvhOt13caqon5RKUNY6g/Qgi0tpfO18n7xFuS4zRfbsGXX2sGZALt2piSuxIBEINSrT7PZipS9QC5wY+ukwT/PwMbuVptn6NKzm6uhBseRGX3NRZgrQErqyHl8zgEUDPwI9cj8g9n5vUwmTi6I2dND0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTDpnscTtnCmguKoArzxwjo6aQOHkpUOC7+R6iPLjP4=;
 b=VWcOjOfaIFodBCWwxinMr5gjEXKSlZjQ27L9Ds573i1d6TEjYeG6LrgLNlm/5V6VC4utmGU4Q4nIh83jRZnN0NuLCEKHuRBITXpNDgtbnUA4IS6m8ueIoljZvWCfBsLf1leEitN5j3yX+8JHhey354tCc8V4kWquybY03KNYIWIM8drOhT7Jc6yqQS07DYF73NDOzTo/16Ixl50GEZr+rFyU30VlbfD93cUkMTClGTXRe8/HqruVHs9yCjk5KCeie9mZamCHKncbgKrV/ybPhDoYg6l82rvyccF/KuwvDuffUBfwK/WmBZiEWxqY4+TPc2LpyX3fkZ4OmxBvgOkWlg==
Received: from BLAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:32b::9)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 14:27:25 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::2) by BLAPR03CA0004.outlook.office365.com
 (2603:10b6:208:32b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Fri, 25 Oct 2024 14:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 14:27:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:27:09 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:27:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net 3/5] mlxsw: pci: Sync Rx buffers for device
Date: Fri, 25 Oct 2024 16:26:27 +0200
Message-ID: <92e01f05c4f506a4f0a9b39c10175dcc01994910.1729866134.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729866134.git.petrm@nvidia.com>
References: <cover.1729866134.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cd0c79-9189-4463-f0f5-08dcf50125c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2MBzRIYWInXbKcfvcLmFcQC3pP1adkTQ8NNc/kc0IOudHQt9uJu/bZyQSe9?=
 =?us-ascii?Q?OAmnJptfQUVOZaK9pZAlHQ+uk6RfzPWvC68gJtgLKGAZhW4T8h/UUW1Sm8Z/?=
 =?us-ascii?Q?CtQ5penE+WAgwBXRNL3fXwmcNWdmcZNv5NpAeHUIY6hgmJ/YSXXWCYskSV4y?=
 =?us-ascii?Q?aw/dZO954j3dPk9QemUAuvdK7dX1JKSMIP5Vxi8b+8E6W/ahsXuhUDyFFzWZ?=
 =?us-ascii?Q?qEhlVpf/8vkzvtfHm2Qcv/IN9WQFfzmXYMO3rRqdbqtSBRlLPbIixnjt/6rM?=
 =?us-ascii?Q?dQnK/LaNZjq5bROuErN+sz3+1lEd+0rbRFkMfRy85Euv5oGMMN/WzazLP+j5?=
 =?us-ascii?Q?gjcRNlcnZiu1j5CctlA89fawlYaJlB8gwIwhaWGO+nT1aeiYQXXr6TyPivE7?=
 =?us-ascii?Q?a3kSQZRwQgXcTnCA74hceNnk5ylfSaZMl9oj7NQPhd24kqknUaoWmeg3wyUK?=
 =?us-ascii?Q?Dfvw7f4fPj7hsUTiYEfTBlZ8llyNxhxqMrUlt2IHp9LsNNQraClfrQFoaDp6?=
 =?us-ascii?Q?D68AruqgBal9YO2PdYqNUWFz/rvThaqSvZlo7GtMe8wXAPtmAoQjtAOAvEtj?=
 =?us-ascii?Q?scFcEeX6/zrYtB6e15mRNTlwJYIOIh5YeCB72pIXfEMvqU2DSLvDRZ3v/VoE?=
 =?us-ascii?Q?wK9yCMoTx1VJS6BUonB8rUbaW9pvfgGCIj21dZwRBCp2TuybYIrmBrOZNq1N?=
 =?us-ascii?Q?j7SzSziSDHToYa10zuj8EvISiuDJrryfAa0NFdzn2Yub1yWIuVi/iBRWBWow?=
 =?us-ascii?Q?1gIHO5W7ixRWsKrO16myWekR1fuhmLTNCpy1gXhRGLD32vO5sMctyXZMsuNP?=
 =?us-ascii?Q?Nk7yrVYVihLuMSbg0VVpJhAPz7yyegkgkUYFSdH344RA1lUGI7wwebJ33720?=
 =?us-ascii?Q?GGywtpbLbR9WQDrkT0KwsrEiz8w45PGpr8IuI38c+amuipizSpdxNBvzWpic?=
 =?us-ascii?Q?1Ca/wANv+112f1Vtoj4I8hck7pVpWumnIlu0SLqcLLCk76NxLF0s9XJFHiQA?=
 =?us-ascii?Q?454TUPb5WhhPNFyXADWJXomwCcMbgIQb8pCzVZIoHxZEYyuZPTKn3i63FZdM?=
 =?us-ascii?Q?w10qFR602Rs1WxbRlzqx3Bv/y4ZEVD7+D9pNGRVfOfe9PAVt+cwjuhRhx1wY?=
 =?us-ascii?Q?rg7DW/SfKXSV3RDeNagf8QOaZCdi0hk4w4qP00eTL13HtgcLicfEPkjhAKN3?=
 =?us-ascii?Q?NtUlYKvAVu5RVw4GqvjW3BcRJFIAulboKGaCAE57gm3pcqdc7gmiCw6tEBw3?=
 =?us-ascii?Q?YKaZzfw+ADPsTNlwmXFWqmb2iqy08yro2wa3ieByLJdqR+tnsOfMLyi38K91?=
 =?us-ascii?Q?Y+qJVZnrjuQsJAiZ3SXYSCKj/m7H6W1uHq8D00flzhpIrGZm7CP9ad6UaY7K?=
 =?us-ascii?Q?YQWgo1ZqK9t10SeijjKQWBtpcEPsk89gaJ8iZd227nueCtM1mA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:27:25.5303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cd0c79-9189-4463-f0f5-08dcf50125c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992

From: Amit Cohen <amcohen@nvidia.com>

Non-coherent architectures, like ARM, may require invalidating caches
before the device can use the DMA mapped memory, which means that before
posting pages to device, drivers should sync the memory for device.

Sync for device can be configured as page pool responsibility. Set the
relevant flag and define max_len for sync.

Cc: Jiri Pirko <jiri@resnulli.us>
Fixes: b5b60bb491b2 ("mlxsw: pci: Use page pool for Rx buffers allocation")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 2320a5f323b4..d6f37456fb31 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -996,12 +996,13 @@ static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
 	if (cq_type != MLXSW_PCI_CQ_RDQ)
 		return 0;
 
-	pp_params.flags = PP_FLAG_DMA_MAP;
+	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 	pp_params.pool_size = MLXSW_PCI_WQE_COUNT * mlxsw_pci->num_sg_entries;
 	pp_params.nid = dev_to_node(&mlxsw_pci->pdev->dev);
 	pp_params.dev = &mlxsw_pci->pdev->dev;
 	pp_params.napi = &q->u.cq.napi;
 	pp_params.dma_dir = DMA_FROM_DEVICE;
+	pp_params.max_len = PAGE_SIZE;
 
 	page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(page_pool))
-- 
2.45.0


