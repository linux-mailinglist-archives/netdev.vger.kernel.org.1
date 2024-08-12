Return-Path: <netdev+bounces-117729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA394EF27
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0471C207BF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3F617D35C;
	Mon, 12 Aug 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oD48RtjR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAF17D35B;
	Mon, 12 Aug 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471764; cv=fail; b=eON1hhyY+PGs+eSfG8CpfE5cul/yyQ313dN6yykMeh1SYlwyQwU8fvQ4XJRqf1uu+YRzZXUVx0vX/2uKxkbmpKZLiBbwvrsv3rtNJwBEp7PTqdOn95UY5QeGKGYLGPEkv1vfY0stcx4srJerBvqmzGsD3ZstvCUiGvFE4yF9CYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471764; c=relaxed/simple;
	bh=SMVA/3hrSSMyudeXp7cJDNVybpF2Rs8QT+rGlwN0sGE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ChcprBr/nwfjmyBP++L9y3lpngKBSjr3nkVae6e+49Rm4qWxoI/ajQOdkf84Ent1Q2gDTtIu+ZzC+UgkDoacSBakxOAkxe1ERZRY6pB4t+Td626pY59WwxfM2+VIqP11esC08rEoR1LmXrN9/TuXe3m7BMUlrAr4O0ZLiE5Av40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oD48RtjR; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAxGzC/InzKB6vvVZrXbCUaJE08A00J1nticjIxOX5hUDmWJ0iNP3mhHZ+/DtfT7ujQe3lz1qjTeBC3WI9ZJWoCt8vsooolLpaKeGq6VoZx+XMa7W4Al8EZfQc1wUnDOAUQVAje1A1Mz/n+ygZWRxTqLzaLgHN0woZqWslSt4yd8Dbgh/3IJE+s3qv3QV6kDMqY2/eFAQ43ljwbSXoY3uMzzDFtsQlRF5PihrO6zYt4a7mu6UGYDfw9i7bfwH3QqOZ5JQAuFI2GlxkstQz3l/QWN3P53n1OboCXRT6CCN85DW6DsV0KBecSAxrmuCzVQoalHWHrhs7HqNeu3x+iqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe0yHi+kiDwJQwHjMZwjchEL66WwT9nssvFZSb014vc=;
 b=pjOHxUsYUrWJ2iyJqZzlrSpy7DEwHajhsI6z18HxcFOmvI33FPARZwWg6PjBTkdauv7R+bJV1dsaQPcLWLTxg+/F9JaQ2pm/2AVuDBhz5IhMW3z6ZRpoQyWZ0zR9lj7JxwCagj1QGzLFOX/ZeGC7G6F6TBS4f8JPv6q8FGKP7zZMosQ/ZB9Hr3b4QtjXBfccuWCUZ7AKx5Q7/0txdbsxvcT0M+dgSzPAL3m1gM1Xkp2Gb8RgptdeeFHVkM7L58UuWMVvlXTgzds/GSCvHtqkNQ1i1RX9m+EgNT/HhKPnZlJ+mkIDHyYnHAMDvka3d7WiWMBtSWbTRE51eT/rmhv22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe0yHi+kiDwJQwHjMZwjchEL66WwT9nssvFZSb014vc=;
 b=oD48RtjRiS3AUE3J/JVeCEhKB2FahZjdsFMFpwWoh+jL+lc4Bor9pGXWBRROgNobLQ3vbFNVbCa8qbyAIindBMWL6BjEzxnZuGoS5fBC35LmnG07fT3NjpJxF1VLaX75xGigbXc34VL15Hao+Z7On9HQfCYCdUlOcOdSAr4LdOHSvlrQfr76tEqohKXOwJAc/nLr2zYYbOS0kpLA9no6sfS7WaYXg9JTcc3jNIBfafagboww6b+OqE3hmjaHOMqYFYVIeFS4e/BaehqC2OeH4ML0SaFFwish1abzwdGY/KmCichSpiy5dojZK5f00MNsBbvwzRJ6mRl2+Y2Cbb8rDA==
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 14:09:18 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::82) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Mon, 12 Aug 2024 14:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 14:09:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 12 Aug
 2024 07:08:55 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 Aug 2024 07:08:52 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <vmykhaliuk@nvidia.com>,
	<danieller@nvidia.com>
Subject: [PATCH net] net: ethtool: Allow write mechanism of LPL and both LPL and EPL
Date: Mon, 12 Aug 2024 17:08:24 +0300
Message-ID: <20240812140824.3718826-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 854f8f0d-0c1e-4c4d-6018-08dcbad85b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?usMJQQo/hTuUIG/CQgNUkrYU9rORFHAfIjApQqFBXQo0te7TyPuFLnJCEptI?=
 =?us-ascii?Q?LBZSSdejAYjLa86POqDqqB1Xa3sW0UzDlQ21mO+xbeUfPGUA03l3YkoDPFwQ?=
 =?us-ascii?Q?4zq1fxyblNIuYmB/5tfzgNkwtFvGhSc19ncHLwW23BkLZVE8qIx3q2ty25Og?=
 =?us-ascii?Q?dszU9nnhTFQoWLsSE1Id2bNEDVNmnXKtILatyGYtccj4V69SsbsRBPRx6wpO?=
 =?us-ascii?Q?gHbmYf7m3k1DH4nbCYGxhtlALu4b6pohyjH5TmK91WAafmZnK6wPDOpW5DeP?=
 =?us-ascii?Q?4yOC/gi1s995gd2zSD95MtRbkaZM8MBlbvkaVlH1TXVIKWA/EPu0w+M6EzEO?=
 =?us-ascii?Q?3CovMWbnVw6DVR7qy5C2lHKEDbQB+zHxiCDvA8vCbR+6zpQFjFTZmElEdy+Z?=
 =?us-ascii?Q?+uNjFNx+IZx17g3xUy7KjRLZxFBdzpuALWhOwYUyIQKocOT6bM0wypmK7LeN?=
 =?us-ascii?Q?NBP3O3aIuhUguvbsEKwRL2OLedWARRZOcQ7aS6R6CTbTpL5JKs8eJJKvJac+?=
 =?us-ascii?Q?Tfm4nm2mc5/P9h9Bu5V12fV7NBoNWbj7GzTJHhOAuT1euCoW4xhuZkwkf4Lp?=
 =?us-ascii?Q?O4nW3pcI32ufQp22/7a4S8cjpNpmijKO+RkCgwLjanav37Cw0Aki0eZpoVQE?=
 =?us-ascii?Q?KJKCsEDjGSxGQm1dZtoFdSETisvbBWPCS8n8VGy4JxOF/socNOf0hJkBeAEw?=
 =?us-ascii?Q?Z3y8ZCGT8ZW9gL6OJzaBShdEh5l1zmSa2tH0J8DHF9ueIXc+hZTh24i65p/K?=
 =?us-ascii?Q?qNc61XrPn3VCa+tzz4t3vlhpJrnVchZUTVPLFmDjXenEqr1rq9OOSkmCzkdw?=
 =?us-ascii?Q?KLG51FFUhFWRd5CM7/xpFd/dKLHBsRGwxpG/S012UoDCKouGnmdgpqJ+f2yS?=
 =?us-ascii?Q?ml6kfVMRoTy/1R5QfLqvRah3uY5zVDNOzxcOuUCgtZiBR5srCi3Kx7cUk/NF?=
 =?us-ascii?Q?fv+Hh48URecTEhekEGMuoZCkfiMLIEq/C9wiDKhsE04T1o7tA1PQiFh1CHTg?=
 =?us-ascii?Q?oVX23eJco+NJMfVxUe93RM5PQxR51fr3tmHmDzLXOaZlLiulbgoJemNZr4GM?=
 =?us-ascii?Q?Ctaw4qJYeJEMC/rvZIY1teHOtJAVGMDSPaqrqC2f1ll2sFRpDrphMZYxT4Eq?=
 =?us-ascii?Q?HDWkjG69Q7tLIJE2wXQXtWRORMRF6InNQkSwDoGPIZG7phuXLLJ7Px1lTWBO?=
 =?us-ascii?Q?r9mf6eI/aqH2AfSLg1J56Vp9AWebXEUOakzc6uvt0zz3PWtFoo532LeNnHeT?=
 =?us-ascii?Q?q7dJTCuJF1bl/tkS1e8+dqrTo+u7pdAhA0kRauaKpu9GVCvy/O6yBMsi6vpj?=
 =?us-ascii?Q?7Zz/83tre7UH3HFKYFh/csNjcRGoxO/2rg8kgOZTHzjdDUbdKFXVODUYDPHY?=
 =?us-ascii?Q?GS6PLPWtXtazGJfqaaZIclROZcWoOsvJJOES93XBrHqzVjSx/aSs5VeEaRX0?=
 =?us-ascii?Q?3IyvBm345YFef4DwYQpmyrVVdIbQGM9S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 14:09:18.4449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 854f8f0d-0c1e-4c4d-6018-08dcbad85b41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

CMIS 5.2 standard section 9.4.2 defines four types of firmware update
supported mechanism: None, only LPL, only EPL, both LPL and EPL.

Currently, only LPL (Local Payload) type of write firmware block is
supported. However, if the module supports both LPL and EPL the flashing
process wrongly fails for no supporting LPL.

Fix that, by allowing the write mechanism to be LPL or both LPL and
EPL.

Fixes: c4f78134d45c ("ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB")
Reported-by: Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/ethtool/cmis_fw_update.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
index ae4b4b28a601..655ff5224ffa 100644
--- a/net/ethtool/cmis_fw_update.c
+++ b/net/ethtool/cmis_fw_update.c
@@ -35,7 +35,10 @@ struct cmis_cdb_fw_mng_features_rpl {
 	__be16	resv7;
 };
 
-#define CMIS_CDB_FW_WRITE_MECHANISM_LPL	0x01
+enum cmis_cdb_fw_write_mechanism {
+	CMIS_CDB_FW_WRITE_MECHANISM_LPL		= 0x01,
+	CMIS_CDB_FW_WRITE_MECHANISM_BOTH	= 0x11,
+};
 
 static int
 cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
@@ -64,7 +67,8 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 	}
 
 	rpl = (struct cmis_cdb_fw_mng_features_rpl *)args.req.payload;
-	if (!(rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL)) {
+	if (!(rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL ||
+	      rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_BOTH)) {
 		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
 					      "Write LPL is not supported",
 					      NULL);
-- 
2.45.0


