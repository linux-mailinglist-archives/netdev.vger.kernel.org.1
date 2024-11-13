Return-Path: <netdev+bounces-144577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA419C7CFE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3561F22A03
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA300206506;
	Wed, 13 Nov 2024 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cwJPAxLy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECB205AB3
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530062; cv=fail; b=P99jz+kXXM/3XrhPx0GRP60jQyaU271YWnZ9bdVV3fgpo7Mp/2VPm0APb/2HDk5O08Q9lni6CVSC+cjkenXc6jjwsYPK2Otb560u3+5IBXRUdMJ2489k8MIo/Ww+TgPDZQHtz4N57YBtwmMdGd0NcZMNuq601s7fU930vDKKgIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530062; c=relaxed/simple;
	bh=5kU0MsvS0HKgsObW9YwvATntg3QnhQ36R+bTGXnyct8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llJJiOJZFUetf6nBSemXAuu3vGkMXVpkm4SB9SE20nd7cOJKhwiwoVbR9guEFPTCWyyftDGCo+CpkQ/wlJZ9obg59TzJFLVP5881EtbGIF5qsyMqztuC0TPmPPeRoa0TVSMbKKDH6tyCPJu2JulvtlcOEodQdRQb8hKr7RIF23U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cwJPAxLy; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDLCPdbcAP7OqM2MQi8v53RGEjxYLberoi5a1M1DfHNDPfe/UddkEiJRBAaSzSudU4e538PoMQi6xPIDhqj6risa+zEAwD2NqUgq5S43pJ/22iWiIImJPDoL1Y7Rjyp1GtUpB2c4PhrMwx0Nt8oxSjwHsJen3R7VQzqNqAmfdfPcvMtIyxBsbOASP/vopFbeN/fgVSwExQQnhkjqhhzi+L8Q/72KKxt53iSWpLX6GUit6Gwzdh/9iOMQCBFyWUW0XkQjA4MSMd2Uv/OeouRmbXPYkN8Uts71OBqi5QJGxI1GzgBhU5g4W+naTgeWaAYoe9RB3CtRxdoXVZ5V3B3gAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE4UkLYPAkUfXQEXzr5TSah8LwK1Tl7/FlLf8E4ekrk=;
 b=IN1VRv5yzQkEgYaNSSPopLcHs/opTwheoM9nvbLoTsI/Ek+1MUl9v3wAwGvIpaA/Se5Qd2qnxeq2pnuQUs9kkwtZpK/b5qE8OyozNlbV+B619ccfkxqAVMhrXzmhUJmhfBDo/8JJx4F11AJny3Jx12puf0bonVPmdZZT1Vrm/uHX4Bbsp560Ya9umE+oXVRqaeSGNbc1PsEQGIT6Nxmo3Y4lAA67+ogj1j2M3jsEX36yTbvpTaemPIafUT5bD+g/JL18Z+wNNkTy5gAOntCK2OZQMGCPfFVEHhdhpLOQRW28Ur9x527OZLqk+viwxdl9NPGFHJsUAyPcMeoqQaqt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE4UkLYPAkUfXQEXzr5TSah8LwK1Tl7/FlLf8E4ekrk=;
 b=cwJPAxLyMlwQtV3rsIGM5U/ArfNGthCPs6ntBFxh+GDwMPiWO4X2GTbjI6oEOBy/B+YEa/vV+zumSf2e0qZeITVjQ9/k55I8ziQrSoGY5rmpPyMAR+nNpiJ5bFHynctJ4N/VNQkTT3GmdxokBUrU+nW71Bqva80o5GNCKlz+hzVYI4pX3acDpaIxm2Crgyszs7ZO0mgWAGg04+Cn9nx/aYuttLsCbaOy4vJE2BTFFVCV7iRBiB57TgVuhFEE/9ODc/RrtDO8ZQ+zXHwfIXoDiThPphTYLt9myLCoXJ9kH/SodkJnkWsBSAyCup39RkVTscuvQQrRdIU3PObZGeS2fA==
Received: from DS7PR03CA0149.namprd03.prod.outlook.com (2603:10b6:5:3b4::34)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:34:14 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::fa) by DS7PR03CA0149.outlook.office365.com
 (2603:10b6:5:3b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 20:34:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:57 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:55 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 08/10] net/mlx5: qos: Introduce shared esw qos domains
Date: Wed, 13 Nov 2024 22:30:45 +0200
Message-ID: <20241113203317.2507537-9-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241113203317.2507537-1-cratiu@nvidia.com>
References: <20241113203317.2507537-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c9d3d1-015a-4e93-93dd-08dd0422898e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TlTGmRFYfP1Lzlf05AJyoYwAPxsNWk/J0STgDEAxjw+NfEp1zEEkTZfVEGqk?=
 =?us-ascii?Q?z9NqrXOJZASBRBx60F7ybIuc7kEnQBUMXZReqeNwhGc3yg/O9ktjjCrG/uPb?=
 =?us-ascii?Q?kd+V4/VN/EWmnSnk8MfFhwraczJRDwqyUkK23a2xrVGEag1KJpWZJOYZEe6Q?=
 =?us-ascii?Q?okXAKZDJHIweWEK7l63LC2+++bFusLCj8e9n9RmOrWNWlFC7cT2i8Jidmju0?=
 =?us-ascii?Q?lXJkIgE9RFw4mTP3jTQN3pa1Kz7W59+EP725/QFPe5jesGkek7Yw1aKXW9hS?=
 =?us-ascii?Q?FFvx6yJcFBZIvg8bOvcggbGDBawt/03v/i4bTqTBHsV1Xuu0NAcDubfrBtaF?=
 =?us-ascii?Q?CAw4cSCzbwMcmwMIBYg7CA38Q5DmfqV5sg6WrI55U/IT+tnoX5lwCY9CPO9B?=
 =?us-ascii?Q?7mqrqre2iX+Sbch/GCFRJzsIxwpx6aQ8eMp9WgJKfzCidPFvcwTMIfWvxCJO?=
 =?us-ascii?Q?Q8cH32qgTW6/DsxfvH7+YyLAbmTb2RkFKYzdy9Ph5jZBTmv24qyuCM8KB73t?=
 =?us-ascii?Q?g5poNrBcuUJDXN6VozL3FbvibZdVsZGFg3HcZtcjJcI/wBk8WQDhhSKDaS5D?=
 =?us-ascii?Q?fHPseCM9VO+p2FwFliPEX0F0zGEY5YZzCjJZiBh7sOWVDD7afWGzf50nNG3+?=
 =?us-ascii?Q?FFkdSRYFIVJThiPKRqlMbi9RQEVO1aM7JptPwFSbii4qKPPsBdr1QJc4ExSz?=
 =?us-ascii?Q?c9JFq/vRL//2Cu2WhO+MkMTgRTiSgDLukNGep6HpYiA8DdRKdu32xXDjfdnw?=
 =?us-ascii?Q?ZUvvGUuNChk+SIFOwnsunn8HeSOB2w9gl+kCh3J3BA55dTkRUeXQeJMjGzHp?=
 =?us-ascii?Q?N/SEjha1bmOfSnSyYkh5dZIEe+8ekM0k+lN92P3fBa94FJ//LxtT5QI+tOt1?=
 =?us-ascii?Q?lS4IbCqBK07VmXU4e1j8YilI6po3orKQdQvC5WaskEGtmjc1VTsQkAaCcMsT?=
 =?us-ascii?Q?o266a96PIKAELLYPCql8BxFDHwkZidI74+JGmC+EtBpLRhO+SWqseOHbzL6E?=
 =?us-ascii?Q?P3JxqTtT+xM5v4ILiWimmczaJ1LUtAuqjAoseU4na3Ncl+YjBuJUnd8GUeDJ?=
 =?us-ascii?Q?D33rMGrgteL7oQcC5pgxEeAfa3y3HLAhIPAPaHIVkrQ+jNbpngDOJHgaQsS2?=
 =?us-ascii?Q?hc2/hC0T01g1AYgbOQGFUOiiHiGt6329eSZ5c/4d6KFI2A0QJ4Ae5WPa3X8H?=
 =?us-ascii?Q?aI4EcNAbbIOJM04LV2y7AVDGyC0sHUAfvoEsS6E45NNZWA4lsOLRIAjgmg68?=
 =?us-ascii?Q?wrhidkFYINzmusem88xNuCGFqVhPz0yq/v6Lm3Lq1WN5L48hsS4ifXYAKQuC?=
 =?us-ascii?Q?wJh8WdQQtG9xzxa2Vr41nb7wvd6pASdw+oSMAq/xnDqnJQYJfp0+JxednD68?=
 =?us-ascii?Q?ce0OO6ULipYgNY7F7Ek3BIqLifjJ/ovwDP9hpq/seBUaipdpFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:13.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c9d3d1-015a-4e93-93dd-08dd0422898e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068

Introduce shared esw qos domains, capable of holding rate groups for
multiple E-Switches of the same NIC. Shared qos domains are reference
counted and can be discovered via devcom. The devcom comp lock is used
in write-mode to prevent init/cleanup races.

When initializing a shared qos domain fails due to devcom errors,
the code falls back to using a private qos domain while logging a
message that cross-esw scheduling cannot be supported.

Shared esw qos domains will be used in a future patch to support
cross-eswitch scheduling.

Issue: 3645895
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Change-Id: I45afa120e2ac4c521c13389f789e02b5fd91c42e
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 73 +++++++++++++++++--
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 87c9789c2836..4fba59137011 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -11,10 +11,17 @@
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-/* Holds rate nodes associated with an E-Switch. */
+/* Holds rate nodes associated with one or more E-Switches.
+ * If cross-esw scheduling is supported, this is shared between all
+ * E-Switches of a NIC.
+ */
 struct mlx5_qos_domain {
 	/* Serializes access to all qos changes in the qos domain. */
 	struct mutex lock;
+	/* Whether this domain is shared with other E-Switches. */
+	bool shared;
+	/* The reference count is only used for shared qos domains. */
+	refcount_t refcnt;
 	/* List of all mlx5_esw_sched_nodes. */
 	struct list_head nodes;
 };
@@ -34,7 +41,7 @@ static void esw_assert_qos_lock_held(struct mlx5_eswitch *esw)
 	lockdep_assert_held(&esw->qos.domain->lock);
 }
 
-static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
+static struct mlx5_qos_domain *esw_qos_domain_alloc(bool shared)
 {
 	struct mlx5_qos_domain *qos_domain;
 
@@ -44,21 +51,75 @@ static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
 
 	mutex_init(&qos_domain->lock);
 	INIT_LIST_HEAD(&qos_domain->nodes);
+	qos_domain->shared = shared;
+	if (shared)
+		refcount_set(&qos_domain->refcnt, 1);
 
 	return qos_domain;
 }
 
-static int esw_qos_domain_init(struct mlx5_eswitch *esw)
+static void esw_qos_devcom_lock(struct mlx5_devcom_comp_dev *devcom, bool shared)
 {
-	esw->qos.domain = esw_qos_domain_alloc();
+	if (shared)
+		mlx5_devcom_comp_lock(devcom);
+}
+
+static void esw_qos_devcom_unlock(struct mlx5_devcom_comp_dev *devcom, bool shared)
+{
+	if (shared)
+		mlx5_devcom_comp_unlock(devcom);
+}
+
+static int esw_qos_domain_init(struct mlx5_eswitch *esw, bool shared)
+{
+	struct mlx5_devcom_comp_dev *devcom = esw->dev->priv.hca_devcom_comp;
+
+	if (shared && IS_ERR_OR_NULL(devcom)) {
+		esw_info(esw->dev, "Cross-esw QoS cannot be initialized because devcom is unavailable.");
+		shared = false;
+	}
+
+	esw_qos_devcom_lock(devcom, shared);
+	if (shared) {
+		struct mlx5_devcom_comp_dev *pos;
+		struct mlx5_core_dev *peer_dev;
+
+		mlx5_devcom_for_each_peer_entry(devcom, peer_dev, pos) {
+			struct mlx5_eswitch *peer_esw = peer_dev->priv.eswitch;
+
+			if (peer_esw->qos.domain && peer_esw->qos.domain->shared) {
+				esw->qos.domain = peer_esw->qos.domain;
+				refcount_inc(&esw->qos.domain->refcnt);
+				goto unlock;
+			}
+		}
+	}
+
+	/* If no shared domain found, this esw will create one.
+	 * Doing it with the devcom comp lock held prevents races with other
+	 * eswitches doing concurrent init.
+	 */
+	esw->qos.domain = esw_qos_domain_alloc(shared);
+unlock:
+	esw_qos_devcom_unlock(devcom, shared);
 
 	return esw->qos.domain ? 0 : -ENOMEM;
 }
 
 static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 {
-	kfree(esw->qos.domain);
+	struct mlx5_devcom_comp_dev *devcom = esw->dev->priv.hca_devcom_comp;
+	struct mlx5_qos_domain *domain = esw->qos.domain;
+	bool shared = domain->shared;
+
+	/* Shared domains are released with the devcom comp lock held to
+	 * prevent races with other eswitches doing concurrent init.
+	 */
+	esw_qos_devcom_lock(devcom, shared);
+	if (!shared || refcount_dec_and_test(&domain->refcnt))
+		kfree(domain);
 	esw->qos.domain = NULL;
+	esw_qos_devcom_unlock(devcom, shared);
 }
 
 enum sched_node_type {
@@ -1495,7 +1556,7 @@ int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 	if (esw->qos.domain)
 		return 0;  /* Nothing to change. */
 
-	return esw_qos_domain_init(esw);
+	return esw_qos_domain_init(esw, false);
 }
 
 void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
-- 
2.43.2


