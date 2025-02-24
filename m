Return-Path: <netdev+bounces-169127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B25FA42A31
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5E63A55C1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA5264FBC;
	Mon, 24 Feb 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TjkcDRgf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF5264FA0;
	Mon, 24 Feb 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419097; cv=fail; b=JIC+ZF9O80davIU7KRerqUndu8QYy3r7kDnQpPJmZnQGwPFD9LIrYu9d7YF/VriStgb3WZRU1iXcXyDNo0pp5ulsPrzc0Xb2jqlgzeQGV8Fi+67jFFhHfVwluYISVRHp+RltopwbLUy8Rs00toCSAAICAiHdQIQwYqUto4kR1JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419097; c=relaxed/simple;
	bh=i53gDZaNNBhDgM14WBvkvFN1JuAH6UWz/UCQgovu54A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROJgizFsFEpyDpLwS8XYE9JVckdkD78/4WaJ+zT41EJdVtiF6CvGr4WrTvc9SI0bRRfSe9JsSSbVdYXiBUXPV50rNfd3gNlIpaHpl5OMu1wDcWj7XN3QW1ut5plp2dmAU/Y6aI/hLg8Kr+qh5dtXLRphGb4kWcF83Wptp9NOD2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TjkcDRgf; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzYUwu4B/KyIWYWMx+oXVsJJU2yDBjVnn4Mzier8ETasfSr3HuDFlfmAaKlEXj7bsQOxb9rr895/3rIUR2bw2I+SV02T/FuI/iR9mXb6BtYi2E81H0pee7AzJybdxkfBsMjU4QkFBaD1txZ2a1W2wtByPKzV2882J7r35pdCm5FFQPE1wloV5yQa2mM2DsRhQQD4LHUimJfqlIAKH1B2BPNK94FG+sVKscs6H97KFb2wdri7UtYzQ4Zzsd6k2jSl8hzgiEPIhHbNfEJleB/JqLWKi7ag3NDNSyEkBM65mT5pFxSxCN4raoIVcb9IcvzChhZW/13ZnHoWzFfbw3Vbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upByaCtG670hZH+stIbNprrOjJTeeyTu5qcxb9F8oUo=;
 b=hjvsWQocb+erZ5WNVLP1p7CxXC73DJf7RGK3TTXH0YlVzFjW/NRLFyi94mTlg3+RwtZVvRqmPeXMK/TNJZxFj9qWfFTy4RXosW239hV1H/lnApbTLef1XxZSB9RYY7H1dqD2f0zIOy+HAD+fQuoxUWo+Wl2MrnbmhCiOOmcupGCw4/CyFC1aumqs4FkIfwCOWPLgRSYA65TTLYXL9T5JrbE9Um1vuVBS5pLw6yE0Bfxk05RnqJElXwhcJFH2Tfykfs8FOAvwXUvIDR2N7HDlAmW6eNRXghLBFLuNxR1TSXHcEmJ/md/OFIu1/m9h2RgAK2BSf17J2Upv4ZzvH0Lkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upByaCtG670hZH+stIbNprrOjJTeeyTu5qcxb9F8oUo=;
 b=TjkcDRgfsFIbRSsmZxI4Ne5AIv4fP8NG1wD8kZTMWkpYKu7gvPQVNb0taDp94Crqy1zSSgsVzchwdWLcTjGuWe1lXf0gDNZTYvlzq42gOeKluvxYP7Mu5PVbBNpr5VHACoz5CgTxRLmCgAW+Sn6qO/GYlYkMoKWj3W9opRSIm6OHrSdArFKBQFrvBETY48UiI4e0I3dTphqbKeG/CbG3y8wWFZ2Qpo0erx60X2LZYED3OP4BEoSB0ycSvRT1hFI2G8rSmW8NVxZe5IFhb/M8pbpkcvb1pEY4ZBURf60rKsG8zbHGoA9UwDnz+S1M3PuZJxipS06CYvx+zrTRuqnejA==
Received: from MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 17:44:45 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:235:cafe::40) by MN2PR20CA0066.outlook.office365.com
 (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 17:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 17:44:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 09:44:29 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 09:44:29 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 09:44:25 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v5 2/4] net/mlx5e: Symmetric OR-XOR RSS hash control
Date: Mon, 24 Feb 2025 19:44:14 +0200
Message-ID: <20250224174416.499070-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250224174416.499070-1-gal@nvidia.com>
References: <20250224174416.499070-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a8ef77-3a17-473a-b4ac-08dd54faecc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ynq2iN5SBOm3gROsz5leYaHsLOWsJw8cCulKU42/AvrWIdgsUxcsP8AqRL5Y?=
 =?us-ascii?Q?n0AEPkDWMTNEak6p/zvTe75P57Yq9vj61yXZ/5iT+sCDIkfkfC5CU//j+ACs?=
 =?us-ascii?Q?5hZL+L9EOYTIOdjd+aOXgwhb62lICFog2LxpUSyL5K46a51mkXLpL82nd5VE?=
 =?us-ascii?Q?hfT7GXa2yhe/8RgSPkvhIBZJaKK0I69hLc08oYnYDLgkBohJatc62hr/AwGV?=
 =?us-ascii?Q?nOc6SGPVz023fheqNCdTZe29oBF+GiXwiztsSTu/+OxZ3bqOvwO3CUr/KBQC?=
 =?us-ascii?Q?BH+iCRepMgvN8/m5XWmo6oVBkKCjQW5NqCSt6lVomxwrfkqdrOR2HuBBA6c3?=
 =?us-ascii?Q?Y+yn22wCDS+92pYV/1yFNzDpEXhx9UlNMCZzrYwunNV9HpG7JVGt1sDC2/0S?=
 =?us-ascii?Q?zKloyKf/0QIn6frqL1LVKeh44g6/O/Eam9Cgw7qV1vxSjjgj0WwKljWjDZHX?=
 =?us-ascii?Q?WGmCamNcBIjBa6ogIvi4w16PpwXVFMRL11F1Lh7ICtrOTw9eWuU+R+onHqrE?=
 =?us-ascii?Q?phKUvfWc83yg4XyOW14WstJHDXdiTbakJLgrnrc3y9ofi/EgT9jvD657HVHv?=
 =?us-ascii?Q?9ei/DpOlsfxoqxw9C40FDJkjJipHSwit27TYZPMNcyntKTXTeHxQhuiyp9Bx?=
 =?us-ascii?Q?AC7KvVBY6sx2QTOlHE3riWfIza92yEKxibqD5uXaSKH9IjkKkhSS9Ttgj09/?=
 =?us-ascii?Q?gPmCYSfe5tifsyZiUMUAHU51xoI6+4ZK37vDeYJFtgsZco0wv1Q4QVnKJprB?=
 =?us-ascii?Q?tW02wiH+dK+WTc1XJ1sCX40geZfj82bqbewtuO5wpSqyLXOBdRWp4Yh8kJdu?=
 =?us-ascii?Q?+66IYdk7/kIn85GlF+3exrmC4wMs1akthSAISyW2ITj0KqIrWkSZjl+RSPn8?=
 =?us-ascii?Q?UkbkQq0vRtr3ggali6hUSUZYERIYtXj0bR/6RQxjIn2UIkL3uaqR01rUMYxL?=
 =?us-ascii?Q?7ZAuA56yEkpyV+fxdqCT1M5ZPO87hrKceqRHIHqe8oMaecKwrQYwrLaK8j1R?=
 =?us-ascii?Q?w+y8KCCYn4L9PDy8i3EP7x4GNYpsEHWl6/Cek4uY8UorT0tlCbTMcpTHHR4v?=
 =?us-ascii?Q?nRtXrYDy166rYxlYCAhxUAk37IPHGlhiF5k1gkma2IHN1iP17zqF55fJ28Cf?=
 =?us-ascii?Q?S/wQC2vP8pRmPlgdHGzOePPKOE+EBry73TfUINQClDOtB02pPyfgLVJkJrlp?=
 =?us-ascii?Q?qbXDORLckqXsvRmm8hASSE7yPrgJNkhE05ANOt415ijTeclPFRZWvR3lhF+d?=
 =?us-ascii?Q?su/kyoVHzfdaiyHXDLRtOOWP52rMvYsu2snRopZxz9X56t0VQgsjP5bIB9Zg?=
 =?us-ascii?Q?6ckEPKxl3U1S42XcLVAJgqqdxdmqc5lcQtMF4PcmJ0O/MAOi+N3MNjKwn8qX?=
 =?us-ascii?Q?ftZdayf8PBKli2Wrz4LaSKljqH3oW0RzRo+LvyUNvwBZqqsDroTXIzmRElHC?=
 =?us-ascii?Q?X3BzZGdjhrLzVChagFFLTbWRKuhSKStSWhtt/VgmXcB8Q86DnpOgQh+7gqNh?=
 =?us-ascii?Q?8tIz1x6+iQYtUAc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:44:44.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a8ef77-3a17-473a-b4ac-08dd54faecc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964

Allow control over the symmetric RSS hash, which was previously set to
enabled by default by the driver.

Symmetric OR-XOR RSS can now be queried and controlled using the
'ethtool -x/X' command.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.c    | 13 +++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/rss.h    |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c | 11 ++++++-----
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en/tir.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tir.h    |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c    | 17 ++++++++++++++---
 7 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 0d8ccc7b6c11..74cd111ee320 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -161,6 +161,7 @@ static void mlx5e_rss_params_init(struct mlx5e_rss *rss)
 {
 	enum mlx5_traffic_types tt;
 
+	rss->hash.symmetric = true;
 	rss->hash.hfunc = ETH_RSS_HASH_TOP;
 	netdev_rss_key_fill(rss->hash.toeplitz_hash_key,
 			    sizeof(rss->hash.toeplitz_hash_key));
@@ -566,7 +567,7 @@ int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 	return final_err;
 }
 
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
+int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	if (indir)
 		memcpy(indir, rss->indir.table,
@@ -579,11 +580,14 @@ int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
 	if (hfunc)
 		*hfunc = rss->hash.hfunc;
 
+	if (symmetric)
+		*symmetric = rss->hash.symmetric;
+
 	return 0;
 }
 
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
-		       const u8 *key, const u8 *hfunc,
+		       const u8 *key, const u8 *hfunc, const bool *symmetric,
 		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns)
 {
 	bool changed_indir = false;
@@ -623,6 +627,11 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 		       rss->indir.actual_table_size * sizeof(*rss->indir.table));
 	}
 
+	if (symmetric) {
+		rss->hash.symmetric = *symmetric;
+		changed_hash = true;
+	}
+
 	if (changed_indir && rss->enabled) {
 		err = mlx5e_rss_apply(rss, rqns, vhca_ids, num_rqns);
 		if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index 72089f5f473c..8ac902190010 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -47,9 +47,9 @@ void mlx5e_rss_disable(struct mlx5e_rss *rss);
 
 int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 				     struct mlx5e_packet_merge_param *pkt_merge_param);
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc);
+int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric);
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
-		       const u8 *key, const u8 *hfunc,
+		       const u8 *key, const u8 *hfunc, const bool *symmetric,
 		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns);
 struct mlx5e_rss_params_hash mlx5e_rss_get_hash(struct mlx5e_rss *rss);
 u8 mlx5e_rss_get_hash_fields(struct mlx5e_rss *rss, enum mlx5_traffic_types tt);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 9d8b2f5f6c96..5fcbe47337b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -194,7 +194,7 @@ void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int n
 }
 
 int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc)
+			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	struct mlx5e_rss *rss;
 
@@ -205,11 +205,12 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	if (!rss)
 		return -ENOENT;
 
-	return mlx5e_rss_get_rxfh(rss, indir, key, hfunc);
+	return mlx5e_rss_get_rxfh(rss, indir, key, hfunc, symmetric);
 }
 
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      const u32 *indir, const u8 *key, const u8 *hfunc)
+			      const u32 *indir, const u8 *key, const u8 *hfunc,
+			      const bool *symmetric)
 {
 	u32 *vhca_ids = get_vhca_ids(res, 0);
 	struct mlx5e_rss *rss;
@@ -221,8 +222,8 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	if (!rss)
 		return -ENOENT;
 
-	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, vhca_ids,
-				  res->rss_nch);
+	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, symmetric,
+				  res->rss_rqns, vhca_ids, res->rss_nch);
 }
 
 int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 05b438043bcb..3e09d91281af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -49,9 +49,10 @@ void mlx5e_rx_res_xsk_update(struct mlx5e_rx_res *res, struct mlx5e_channels *ch
 /* Configuration API */
 void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int nch);
 int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc);
+			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric);
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      const u32 *indir, const u8 *key, const u8 *hfunc);
+			      const u32 *indir, const u8 *key, const u8 *hfunc,
+			      const bool *symmetric);
 
 int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
 				     enum mlx5_traffic_types tt);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index 11f724ad90db..19499072f67f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -124,7 +124,7 @@ void mlx5e_tir_builder_build_rss(struct mlx5e_tir_builder *builder,
 		const size_t len = MLX5_FLD_SZ_BYTES(tirc, rx_hash_toeplitz_key);
 		void *rss_key = MLX5_ADDR_OF(tirc, tirc, rx_hash_toeplitz_key);
 
-		MLX5_SET(tirc, tirc, rx_hash_symmetric, 1);
+		MLX5_SET(tirc, tirc, rx_hash_symmetric, rss_hash->symmetric);
 		memcpy(rss_key, rss_hash->toeplitz_hash_key, len);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
index 857a84bcd53a..e8df3aaf6562 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
@@ -9,6 +9,7 @@
 struct mlx5e_rss_params_hash {
 	u8 hfunc;
 	u8 toeplitz_hash_key[40];
+	bool symmetric;
 };
 
 struct mlx5e_rss_params_traffic_type {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 1bf2212a0bb6..0cb515fa179f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1456,18 +1456,27 @@ static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	u32 rss_context = rxfh->rss_context;
+	bool symmetric;
 	int err;
 
 	mutex_lock(&priv->state_lock);
 	err = mlx5e_rx_res_rss_get_rxfh(priv->rx_res, rss_context,
-					rxfh->indir, rxfh->key, &rxfh->hfunc);
+					rxfh->indir, rxfh->key, &rxfh->hfunc, &symmetric);
 	mutex_unlock(&priv->state_lock);
-	return err;
+
+	if (err)
+		return err;
+
+	if (symmetric)
+		rxfh->input_xfrm = RXH_XFRM_SYM_OR_XOR;
+
+	return 0;
 }
 
 static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
 			  struct netlink_ext_ack *extack)
 {
+	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	u32 *rss_context = &rxfh->rss_context;
 	u8 hfunc = rxfh->hfunc;
@@ -1502,7 +1511,8 @@ static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxf
 
 	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, *rss_context,
 					rxfh->indir, rxfh->key,
-					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc);
+					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
+					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
 
 unlock:
 	mutex_unlock(&priv->state_lock);
@@ -2611,6 +2621,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
-- 
2.40.1


