Return-Path: <netdev+bounces-106020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4B9143BC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE001C21A8F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042B4597F;
	Mon, 24 Jun 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gDXiECtj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706C45BE3
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214296; cv=fail; b=RD81ZiZGiLYrKdV/emzLtJ1p5EnsWVTbFrLcoRNkZC0pO9lXS+WFCS9LzW2XFP9B8zGm2Mx3lWFspJUo+2AeL3CQ4xsl/Nomp+x+2j6/z79dwHn4Cer3yiscfxHw+rJUz0riG74OrXYVImLw8kJNx0FgzfwE9OmtIXv0jQyNyoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214296; c=relaxed/simple;
	bh=bbUCNyhKq1US3nBNaav+KH2oGEng3LGKP7axh2rI8dU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWxOsCX0ak7WEajbUZKTDdTlxzym5xHuP9FUQ4lbpCo6iI0aZ+bqS+0S5osH4ez/3B6W5Gi0GayJo8XTChJPgkt03AWgZBI/Xhwxv6KXvPr7h///7Tc0LdzEHw3Fl3xvcGG89wFguDB7ysQ+dZstEiFpfdxfYRyqJseAy4Txkh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gDXiECtj; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCWkFXKVydmD2eMNxXeB7X3TkwWMNX7plAYWJbP5cZasHbuEDsP2I+PFf8W32z3smAHIFkT0OJpXilDOZOhCdhw7n0zEy/c7ExeLQUVXKI9E6OMuFHqsZUmGUKnbg19NyG4AtsvQvymDpgIJQr5nrjHyZZFsofg7ytZLb3dHx5MlxBQaFSbc8aJCrdn5Rf3IzKIijH8lb2u+YzwwUO5zMLCDOR+BnFXENI9mUYA+uRLcD7mRf6kFULCMtLNr8/IAjEAujo+Ia1lELcWB1kIOITqIL2lcsoDDpEE0nvSRDK7jMdmFWB9TB7rMei5gY2361qp7FF0avFH2zw2lgTzFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFDSqEMIPZuVmW1lYWdYlECURavG8XQ62yyZiPqaOMU=;
 b=oST2Sarhq7q/nxEV198KAy3mQ4w4z2F4oo6yGh4JmvNaagIrf++TGUbwaYyAZGItaHJ/DyuPXnGbgD7GTQm9ICa4t78CwK82oju4iccKzrHkgc5vtjznQtH5AOYzlWYeq+sgtn320r6/kRvn/SW24gkdgsjWPyM4itTb0p1aNsNzY9/zWu0enFNTjImRVQDbbddRfw8laoDYrXDJ/FDAyb1zo7xSp8kyhGlfZynUbFiAC28VqQPE9Aq2NXSv/zX63Wqd+kr72IDGFdttUc54s6LmTHE3Vp6WjlykM6OVGK38fs3YoG2RsOTGObO9fy90/nJRxlnlaNwkFiZSmj7UdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFDSqEMIPZuVmW1lYWdYlECURavG8XQ62yyZiPqaOMU=;
 b=gDXiECtjO4itriDWIFabbFwb+QyEgC9PSFDwpdIrqdX5Ay/Y+Hd+ut4/pO0z83hQBNtfW28PUMXSfjIG3pnQvlFCmFAumwM5njkmX7upfbPvNPFVuIaoUAmjrfoAZs+2mlaEwplwcGQD/5K1o9pRDwqLO0l948vDMEtszdqFlRWDNS72TaWBiatfKIXemCZZSVY6XfGub50i6iRpr87ytMw6YOK49XW1FvhMrombi7jWCN1y5uZO4DXUQhZOy7A/qBabxyd7WScJ2V4YWensr/JkwY6CNA6PDugbGU0llf6/t5jY28X054b1mjBlrmwlWVEum/Ff73gI/kpSF4keyA==
Received: from BYAPR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:e0::20)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 07:31:31 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::10) by BYAPR05CA0079.outlook.office365.com
 (2603:10b6:a03:e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.17 via Frontend
 Transport; Mon, 24 Jun 2024 07:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:31:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 00:31:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 00:31:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 00:31:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 4/7] net/mlx5: E-switch, Create ingress ACL when needed
Date: Mon, 24 Jun 2024 10:29:58 +0300
Message-ID: <20240624073001.1204974-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624073001.1204974-1-tariqt@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 786f9a90-d020-418b-4208-08dc941faaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PtgmCxOcD1m2ECMRFTyZMoH3IWqdmF5yzwwnQ2iY2ylVUHBWX0/CBVoIiNIT?=
 =?us-ascii?Q?PsY0kXnFPOaY+OkAHDPO2206Rj5XOBJRyPPRaWSQkAnN3439seHQR+BdAk7l?=
 =?us-ascii?Q?1GJcOaf8UiS8cfZ8Glp1yog7Pwj9E1+BA427pZ8wOypmFO5UTQzbQOVbsBX/?=
 =?us-ascii?Q?Mfc20KTXRT41i33NXFW0pMxeiesfOIahAPf7t8xQXimpanljKhxgbpTfTR3G?=
 =?us-ascii?Q?YTTXQCNt6cvqH7s+eGdYFBafixFnqdf6W/hTy8Lch53ZGC+eNDxl3/DiUeiv?=
 =?us-ascii?Q?GpjgfQQXuTxgWR2DDaIDWroOH53tL6H2Rhf0KJnxf3TPs8+8ylf8pbslG8uq?=
 =?us-ascii?Q?7W82XS3kQHH3q8x5hBhBdI4VW0oBXq6DxQ9GVveRCTfT4XIp0sGzoUKIN+5G?=
 =?us-ascii?Q?FVGAyBJmXvk/HacPPPgRFYXFUsFSVnESK3EhTTCjt/oTAAHYy1G0mMVHnpKN?=
 =?us-ascii?Q?eh7eze0iPphaQKxw8UModLyZpEEvIUSoAxEYkCdOwYsUSCKdK6uvfrvtvjMi?=
 =?us-ascii?Q?xhvO+bsI52GUS0vBAzH/Px49xgD6bRbvBWy6tUI+epM1MkVC+30+KtZVrhGq?=
 =?us-ascii?Q?sFMoIxu5ifVdC457PNRBoV38uI/MKMKmFqjLpwFA6Mab1AMHRz0au3J8hX5o?=
 =?us-ascii?Q?OVedB/+ZxLNkkKdzXWSalAmL6HwacI54F6+6MiIQPGfbt3eTyOF4+Ii+VxW6?=
 =?us-ascii?Q?Sa2VJ/VcneL0XrTAJgpN48Tizh0R0Yt5W8DFiF960GBxX6VmqVTtvbgz+dBv?=
 =?us-ascii?Q?DqMfkCig3hLqEILP7j33luHWaPmR0AWBuS0EXDTzDRaL/5VG2ZZEvbILEm8u?=
 =?us-ascii?Q?T1zY0N9IN+z8grS1yIcW2F5HvOarAS0Jvjx182VRfgh1FKuL6T0nhsGAa26f?=
 =?us-ascii?Q?dA8ull3/UhDyLmn13qBt2aFAp8YfLkh62hfw66gberpoPH/73UMGuOkgjd25?=
 =?us-ascii?Q?x94Qmj23fi41Jah2Ch1skjKlkoIv0yrnYHTVopr4JxeqOIYBRWm1TZ37S2MV?=
 =?us-ascii?Q?018R0eFddKFMk2TF5GjVILBKTi1Cxh/uJMMdsCotiv3FMoMLD8dSiiEQwfGQ?=
 =?us-ascii?Q?+3tHYxdEyzGznItsvzkI3JEZnq/jPn2cmo3Lgvp7VD7lY4c2W5VfaiDz3uk5?=
 =?us-ascii?Q?F7TADCCqlN4tzQs5qGQUYecIETgv7cngUrK/CxYFGLmEsaDyyYz+0D2kBnJy?=
 =?us-ascii?Q?GHrWrx3yK9dOt8uh1uCjDsYvyq832G0OhjRy1tjPFvgzoCk2Ztdf5MbawGK7?=
 =?us-ascii?Q?H7CHQ1Tq8GkV3/ekg52yngQxr1wkhsRygw1PoKfvOwNfyjYqwLQ5zLjcUz5B?=
 =?us-ascii?Q?mgJbgO2Cj/UNoTTUfB+rJipxpbckL3q/LRSgyCiCda488i1M0UJfwzYNLHXl?=
 =?us-ascii?Q?1seUXtQHz6gInekiHeggQ4IJGhW6wDv5gDNoc6fHKTQOyzywzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(1800799021)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:31:30.7637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786f9a90-d020-418b-4208-08dc941faaaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

From: Chris Mi <cmi@nvidia.com>

Currently, ingress acl is used for three features. It is created only
when vport metadata match and prio tag are enabled. But active-backup
lag mode also uses it. It is independent of vport metadata match and
prio tag. And vport metadata match can be disabled using the
following devlink command:

 # devlink dev param set pci/0000:08:00.0 name esw_port_metadata \
	value false cmode runtime

If ingress acl is not created, will hit panic when creating drop rule
for active-backup lag mode. If always create it, there will be about
5% performance degradation.

Fix it by creating ingress acl when needed. If esw_port_metadata is
true, ingress acl exists, then create drop rule using existing
ingress acl. If esw_port_metadata is false, create ingress acl and
then create drop rule.

Fixes: 1749c4c51c16 ("net/mlx5: E-switch, add drop rule support to ingress ACL")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/acl/ingress_ofld.c | 37 +++++++++++++++----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
index 50d2ea323979..a436ce895e45 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
@@ -6,6 +6,9 @@
 #include "helper.h"
 #include "ofld.h"
 
+static int
+acl_ingress_ofld_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
+
 static bool
 esw_acl_ingress_prio_tag_enabled(struct mlx5_eswitch *esw,
 				 const struct mlx5_vport *vport)
@@ -123,18 +126,31 @@ static int esw_acl_ingress_src_port_drop_create(struct mlx5_eswitch *esw,
 {
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *flow_rule;
+	bool created = false;
 	int err = 0;
 
+	if (!vport->ingress.acl) {
+		err = acl_ingress_ofld_setup(esw, vport);
+		if (err)
+			return err;
+		created = true;
+	}
+
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP;
 	flow_act.fg = vport->ingress.offloads.drop_grp;
 	flow_rule = mlx5_add_flow_rules(vport->ingress.acl, NULL, &flow_act, NULL, 0);
 	if (IS_ERR(flow_rule)) {
 		err = PTR_ERR(flow_rule);
-		goto out;
+		goto err_out;
 	}
 
 	vport->ingress.offloads.drop_rule = flow_rule;
-out:
+
+	return 0;
+err_out:
+	/* Only destroy ingress acl created in this function. */
+	if (created)
+		esw_acl_ingress_ofld_cleanup(esw, vport);
 	return err;
 }
 
@@ -299,16 +315,12 @@ static void esw_acl_ingress_ofld_groups_destroy(struct mlx5_vport *vport)
 	}
 }
 
-int esw_acl_ingress_ofld_setup(struct mlx5_eswitch *esw,
-			       struct mlx5_vport *vport)
+static int
+acl_ingress_ofld_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	int num_ftes = 0;
 	int err;
 
-	if (!mlx5_eswitch_vport_match_metadata_enabled(esw) &&
-	    !esw_acl_ingress_prio_tag_enabled(esw, vport))
-		return 0;
-
 	esw_acl_ingress_allow_rule_destroy(vport);
 
 	if (mlx5_eswitch_vport_match_metadata_enabled(esw))
@@ -347,6 +359,15 @@ int esw_acl_ingress_ofld_setup(struct mlx5_eswitch *esw,
 	return err;
 }
 
+int esw_acl_ingress_ofld_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
+{
+	if (!mlx5_eswitch_vport_match_metadata_enabled(esw) &&
+	    !esw_acl_ingress_prio_tag_enabled(esw, vport))
+		return 0;
+
+	return acl_ingress_ofld_setup(esw, vport);
+}
+
 void esw_acl_ingress_ofld_cleanup(struct mlx5_eswitch *esw,
 				  struct mlx5_vport *vport)
 {
-- 
2.31.1


