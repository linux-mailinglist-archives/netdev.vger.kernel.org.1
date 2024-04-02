Return-Path: <netdev+bounces-84048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370238955E6
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03CA1F22E04
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C884FA9;
	Tue,  2 Apr 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PDWLYPU2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC99463
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066258; cv=fail; b=GYgXzswOrB+4gflblVbh+Hgtuv30hbh2PBm4Uys/fDWf5vdfgS95nb/x9dU2i338F/Ge4AqzYJx/sIJsDMwMrILdoDZ1Td+YbvRkqrRD3DooUFfXwzYtf8kCpxmBXZuPDqijS1r89K+40qE9wjZr5ux2W7LA5t6mHUD+Dhq1IBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066258; c=relaxed/simple;
	bh=2Xcfqv3lh+D3uLuzDWIscSwOTN/BBKUlxxhZ/vAfIfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G025Ad1I5JSkgK7F9hafaBkV7KAyiMQVRKfjKOIYOmKMruiB7mh1OnoPWGFO745ESFHYTYdSLuxO22RpZOEkD67FE1SvG8PywmG7a8W2/P1/sO3fuPgHoL/xj7SFjrvZTIp+nyIKWf8zSHUtMzXtRhi8dzZv0RiO2kkg0tdQXws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PDWLYPU2; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYz1yB6XI9fmRHUt2TDLwYgcwVU6cgvFiEFiQ4CN8c6QllfmhU8muYakoM7tpzo9p31+YENbwfjSrcV2tRDRolnB+AhFADpQ68WbchtJhjWBNFIrXwQha9haLVHkjain2HnTxeMCxzadAAeYJ8S8ZftC77wbusB4XtEUUjRSe03eUTnNvVZRggKDP6g8zThyq2kdLHBvhY6kXfZ9t/gUVOx8teL5f1yTs2iQcZGFDN/EXUFS2Zh8MVzj73+m8hgHKd1jWVscLoLyG74EJ1Vas/kTrTsOvq5uC/nYZWmVypjkTP6qywpZ5zR0nfcb4Pm8gxUfOl7eW+Yq2u44vaCUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgekQ0pfilbNA2RaPBmIswH12SvEfpRnEoJyGzt/cBI=;
 b=JpNZvO67fYh/JoEpefx0IZQcV1+2TteQ+V16Kz1PvgGaTjZALxeGJ6xXzx9QyZ4A0friSAJk6oudcx8zPFR5kPa4qPjAthOSfYPygzzul7rQ2GahrHTdHu6LH8FjJtnhxhzSpFDFg0/q+ow7iKvWfihfJh1pmRNbMEo8fCXTAPtZ3dq3lHGxwu5gvQW7cneNt86PYtaLPQpnAxAit1Qk9JxxsY8VJgurz7e+afPtn6XHaTQ/TSxCBjmV+mqAS2q2yhTzhI3KGsKXMxcfzUyYI1aql6pYPMRFaquTo/7ra16ZyNGMFZlJWOcVolhX/gEOzhe8jUrP2gV2fftlnX1r/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgekQ0pfilbNA2RaPBmIswH12SvEfpRnEoJyGzt/cBI=;
 b=PDWLYPU2NjRiWXkcwpfRoiQftrdV11hez9e0tvkegzaFXgu59hn8r/j4Kc+CGy62Vugdfp+sSfNd1+kd6ankcfTdjYoF7t85DKYvWDxOr7oeQVAexItz7bBJfw8/t0I3YUj5iO9AZwRzSO37Ybrz3r96ZoiQOqS5jNskj9xHo6i8UujRcxVtaj45vcdqBaS5kBlc8ra3+KlzD7sU+N/8rOc0tIZeYw+fIGMo/AUDhjbs7RJ8PAovcxB3Y1Fwvf5eOcui8fF7nvHC4yWaZD5FLyFxwn7NdOKd6lhUL+wlUWA4U2I6XRwakMijv5mTW06AAuQpK85BPcyeN6IO+zQFkw==
Received: from CH0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::20)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:32 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::62) by CH0P220CA0025.outlook.office365.com
 (2603:10b6:610:ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:13 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:08 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/15] mlxsw: pci: Remove unused counters
Date: Tue, 2 Apr 2024 15:54:18 +0200
Message-ID: <ee9e658800aa0390e08342100bc27daff4c176c0.1712062203.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712062203.git.petrm@nvidia.com>
References: <cover.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c773f2-9283-4dab-4b54-08dc531cd7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qlQxgNLwa19OCXffKb01KyahFRvuaUM5K7TOZSRK0bMFhOcZEty6CVOVcy3o8XLoESP9OXjlXknTWdQ8l6AClhiCAOND26+cyiMkHzCI1rt53BkRq430Kz5+F7WwHTmdGGwoxwMjURqEcV6SxIW8hf5DuXCfn3czi4GnYc2+0hgf9EJqglMwTbwOOK2z70Tcu/Lvf0N7MALI0kRFpkNcQ1qxSJiv7rjdDT3Xgmd/qlI73ACN+wB84pAtizQzJ2idR1L+ZMKjkgytXpS6QHeFQQKuh9CMJmpUtXIW6ttnZieLHYskccUTy6Z51824DjA0211FxsmQeHl9I6Q1zuP/3peJ+BggMe96O/+SZjc4HUWjUMFHCD38mFbAWNlKVfXU914ihYN1JmL+dXOVfLD3QMwdOe+g9umeUarbvAo9KpKWepfyV7JJqREDZOSoREXLgREotJoKKCZHGzeaJfQBAKc4Wch2Q/nYZ+DX4wQHu89NdakVOVM8bUYW3Mzgzn8jXB9nCy6XhjkEKi/ONRwH0rUMtki+1aTY3U/2nu8HNvBKg1xWmx4/U+r7eRPf9tWb+u4f+yBWQe5xgxjCVzfke22df8rIxQpzAwzeF+p4aMN0KxmpZedGOhwoKRP46EvPAc8a9Ob8sjkZDa4ZqI8IzhCuFSCfYuB8zKZnnDAS1gDBvfu/Q2jpwct3zuG35fnkFBJ1YxX2SKrF2cOMVT06X7L6TrebdNhj/D7lvI6gtZZnk1TiEbGpU1T+7TMgP7r1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:32.2491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c773f2-9283-4dab-4b54-08dc531cd7c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

From: Amit Cohen <amcohen@nvidia.com>

The structure 'mlxsw_pci_queue' stores several counters which were consumed
via debugfs. Since commit 9a32562becd9 ("mlxsw: Remove debugfs interface"),
these counters are not used. Remove them. This makes the 'union u' and
'struct eq' redundant. Maintain 'struct cq' as it will be extended later.

Replace increasing 'q->u.eq.ev_other_count' with WARN_ON_ONCE(), as it is
used in an unreasonable case of receiving event in EQ which is not EQ0 or
EQ1. When the queues are initialized, we check number of event queues and
fail with the print "Unsupported number of queues" in case that the driver
tries to initialize more than two queues.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 49 +++++++++--------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 3a5f902b625d..f05137b85483 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -80,18 +80,9 @@ struct mlxsw_pci_queue {
 	enum mlxsw_pci_queue_type type;
 	struct tasklet_struct tasklet; /* queue processing tasklet */
 	struct mlxsw_pci *pci;
-	union {
-		struct {
-			u32 comp_sdq_count;
-			u32 comp_rdq_count;
-			enum mlxsw_pci_cqe_v v;
-		} cq;
-		struct {
-			u32 ev_cmd_count;
-			u32 ev_comp_count;
-			u32 ev_other_count;
-		} eq;
-	} u;
+	struct {
+		enum mlxsw_pci_cqe_v v;
+	} cq;
 };
 
 struct mlxsw_pci_queue_type_group {
@@ -462,12 +453,12 @@ static void mlxsw_pci_rdq_fini(struct mlxsw_pci *mlxsw_pci,
 static void mlxsw_pci_cq_pre_init(struct mlxsw_pci *mlxsw_pci,
 				  struct mlxsw_pci_queue *q)
 {
-	q->u.cq.v = mlxsw_pci->max_cqe_ver;
+	q->cq.v = mlxsw_pci->max_cqe_ver;
 
-	if (q->u.cq.v == MLXSW_PCI_CQE_V2 &&
+	if (q->cq.v == MLXSW_PCI_CQE_V2 &&
 	    q->num < mlxsw_pci->num_sdq_cqs &&
 	    !mlxsw_core_sdq_supports_cqe_v2(mlxsw_pci->core))
-		q->u.cq.v = MLXSW_PCI_CQE_V1;
+		q->cq.v = MLXSW_PCI_CQE_V1;
 }
 
 static unsigned int mlxsw_pci_read32_off(struct mlxsw_pci *mlxsw_pci,
@@ -663,7 +654,7 @@ static char *mlxsw_pci_cq_sw_cqe_get(struct mlxsw_pci_queue *q)
 
 	elem_info = mlxsw_pci_queue_elem_info_consumer_get(q);
 	elem = elem_info->elem;
-	owner_bit = mlxsw_pci_cqe_owner_get(q->u.cq.v, elem);
+	owner_bit = mlxsw_pci_cqe_owner_get(q->cq.v, elem);
 	if (mlxsw_pci_elem_hw_owned(q, owner_bit))
 		return NULL;
 	q->consumer_counter++;
@@ -681,8 +672,8 @@ static void mlxsw_pci_cq_tasklet(struct tasklet_struct *t)
 
 	while ((cqe = mlxsw_pci_cq_sw_cqe_get(q))) {
 		u16 wqe_counter = mlxsw_pci_cqe_wqe_counter_get(cqe);
-		u8 sendq = mlxsw_pci_cqe_sr_get(q->u.cq.v, cqe);
-		u8 dqn = mlxsw_pci_cqe_dqn_get(q->u.cq.v, cqe);
+		u8 sendq = mlxsw_pci_cqe_sr_get(q->cq.v, cqe);
+		u8 dqn = mlxsw_pci_cqe_dqn_get(q->cq.v, cqe);
 		char ncqe[MLXSW_PCI_CQE_SIZE_MAX];
 
 		memcpy(ncqe, cqe, q->elem_size);
@@ -693,15 +684,13 @@ static void mlxsw_pci_cq_tasklet(struct tasklet_struct *t)
 
 			sdq = mlxsw_pci_sdq_get(mlxsw_pci, dqn);
 			mlxsw_pci_cqe_sdq_handle(mlxsw_pci, sdq,
-						 wqe_counter, q->u.cq.v, ncqe);
-			q->u.cq.comp_sdq_count++;
+						 wqe_counter, q->cq.v, ncqe);
 		} else {
 			struct mlxsw_pci_queue *rdq;
 
 			rdq = mlxsw_pci_rdq_get(mlxsw_pci, dqn);
 			mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
-						 wqe_counter, q->u.cq.v, ncqe);
-			q->u.cq.comp_rdq_count++;
+						 wqe_counter, q->cq.v, ncqe);
 		}
 		if (++items == credits)
 			break;
@@ -721,13 +710,13 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	for (i = 0; i < q->count; i++) {
 		char *elem = mlxsw_pci_queue_elem_get(q, i);
 
-		mlxsw_pci_cqe_owner_set(q->u.cq.v, elem, 1);
+		mlxsw_pci_cqe_owner_set(q->cq.v, elem, 1);
 	}
 
-	if (q->u.cq.v == MLXSW_PCI_CQE_V1)
+	if (q->cq.v == MLXSW_PCI_CQE_V1)
 		mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
 				MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_1);
-	else if (q->u.cq.v == MLXSW_PCI_CQE_V2)
+	else if (q->cq.v == MLXSW_PCI_CQE_V2)
 		mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
 				MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_2);
 
@@ -756,13 +745,13 @@ static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
 
 static u16 mlxsw_pci_cq_elem_count(const struct mlxsw_pci_queue *q)
 {
-	return q->u.cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_COUNT :
-					       MLXSW_PCI_CQE01_COUNT;
+	return q->cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_COUNT :
+					     MLXSW_PCI_CQE01_COUNT;
 }
 
 static u8 mlxsw_pci_cq_elem_size(const struct mlxsw_pci_queue *q)
 {
-	return q->u.cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_SIZE :
+	return q->cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_SIZE :
 					       MLXSW_PCI_CQE01_SIZE;
 }
 
@@ -815,16 +804,14 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 		switch (q->num) {
 		case MLXSW_PCI_EQ_ASYNC_NUM:
 			mlxsw_pci_eq_cmd_event(mlxsw_pci, eqe);
-			q->u.eq.ev_cmd_count++;
 			break;
 		case MLXSW_PCI_EQ_COMP_NUM:
 			cqn = mlxsw_pci_eqe_cqn_get(eqe);
 			set_bit(cqn, active_cqns);
 			cq_handle = true;
-			q->u.eq.ev_comp_count++;
 			break;
 		default:
-			q->u.eq.ev_other_count++;
+			WARN_ON_ONCE(1);
 		}
 		if (++items == credits)
 			break;
-- 
2.43.0


