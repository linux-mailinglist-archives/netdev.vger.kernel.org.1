Return-Path: <netdev+bounces-78171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F48743E9
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6D1C20A7C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C071CAA7;
	Wed,  6 Mar 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="drXcFCBR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8251CD11
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767822; cv=fail; b=TjRPQ2zAd+yaJPFcSe0d4VnwOLD2oUWLDqvnI3LlvE9eAkFCla7TxSpprphILsIEEydPcQkwtt9P+vUcJ/yjSZrP/MiP+ASLpPZxXIY445rCYoJUFRBfzC8F5m4NzTL4jzMK8R6Z3ir3MtW2PU1QAnsK7iflHsCPghzoNCIsIb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767822; c=relaxed/simple;
	bh=aZmVDZ6LfOWKtps3rcRtrjxrZ0dLskExNwvbp50PANc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKcQnsZJRsv3JcV1NcpzHs/xZBkovyJX/NoAaSNLyb+3u5guzxPGwzADOLzwozjyEwWPd354B9HqS2ZCuh2Gn89lPUwGgsZWBMOW48WlTMCeVLKg/2mPVqwZWr8edNcP7jVfJaNhzVroCg9V/wrqPHQ48M98Tf2Y0wkggnbc1/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=drXcFCBR; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leSViwap4c7nvVLIOdDg8fcA8jXZvBoB1IJjYGDEwcIYyeipw1mL4G3cbVRbS4x43IxyVlEzXKQOUE7MW4CR+LwTKcfYOGsgC06u/Ir7vr3EQhK0PBSkb+d8oId+OIIA+t0cboHepQ47rSnDg4KeABnC27z6lkRnnHPS9/jToneLYpgjNrEGhV+R3SR1OPh3SIsdCUieSCDVVJSZZLuiomwKVUc4KNLLzvqYcjjcP47IMxQ9KwZSioHg5NstpXxpVFSHOF76Yf0iZTXRCmhvcpORhVsZ/CPaDula51rCmEkaDqYU1ni0sUB0bhM8ZCcd22DSAD04QanfurMvX5Mj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4tdGRkOreq38pIzhs6oOdRQk6yYvlkjA8uMBAQmNDk=;
 b=PW1nrzFS/vpmAjT1RqsZb6UFLdMceF9ZJ9PreCOWjpzr5ZNU983N0S1pC5PxKxmHP54BVJ+hZUl36dQaZ4V+MQr3p3ZIKf0TIZzOMNF/Fz3+zVPcmzUGSl2XOQ6zJqszzB4dpwPRkh5Zu+VwUIoMZ/kHdmW0pst0cI2knL/kIZ9tEJVXVlUVewi808xxoYL6ajSuYFLwGxadc1J8BiVGhNHOC3SClONDPEe1/FcJapMp2aZ8kM6MYkHF+Eda2F2rURUn5QLChh89GI2y6JTR1sG4yTt/Lm3MN1zpW+2tDZTJxuX7hHIEsI3erK54vV5OdApjK4iqjf+FMud3wkfA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4tdGRkOreq38pIzhs6oOdRQk6yYvlkjA8uMBAQmNDk=;
 b=drXcFCBRGNT3KJ6l3oNmpdaV13mvdrPAw+HnDFhysYphGKL1mT8KPj75tw+c6wjBJr6F6RKwZl81+fQ1UOr+oz3zgy/pUi0mQv0lrGrYwgZi/IOTIl1GclLyVc+nMGd8h9o+7kqmDww8rofhdrIvbtu3BQy7M4sP7VqXUhYOzes=
Received: from SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::20)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:18 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::d5) by SA1P222CA0182.outlook.office365.com
 (2603:10b6:806:3c4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:18 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:16 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 03/14] ionic: move adminq-notifyq handling to main file
Date: Wed, 6 Mar 2024 15:29:48 -0800
Message-ID: <20240306232959.17316-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 37003d71-0756-41b0-f23f-08dc3e35625d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZyLMiz4+sfhK4maQfQ1WJN9O6KYHWW9w29gvaaiTDrhwvIh/cyDHctp3vscVOP63H4cBh5n+7xCpSWCOBkMK2C8jdIIv4XGxNIPmHHi5J4sB3K09JXxipVEEb/II3eivw6ycVyoe/3MUQ8mD3owhK4207WoLwp/P5tgQVnwWlNo0uRKEofs6DDxcBl/YVT+GJVoUUAFlYqgsFBfp3gJhrv3FhA6Ns7iITAUuMgWNwUq+GPZytP1JhO5n7hU5tz/Ve5QHo21zU1jurBG3AQPv0FzbkuDnH5RyDKrmb5XQr0kNMRKLIgSiC1pUWGy3B8NCG9x9nvhOAngN1yjDSUcycLIbEe1Xs/pTR+kAyvF4PBzG+YpqWvi19uhp58t5qcO/kC9HP7nTMDO2+9yp+5KJdi7hOdM0C9w7+g7Pr68Uq2as7MWe2c+I1SJDB8k7hdexQHxQLYUysoLN3F0iEaqssAwCxLWX6ajFsZRGWVQhuoXYIVtSRt62IvgGP8+gFB38D+T2dMxtcG+K5Y4xuAZlmkQv8SA4JHjOsGW3nN549zIIn3eOpB3L3YO8E+k0jgzW5tlnehj/NU/V4TGKg/vw/3w7tIy7loPS6DoS9C0+v2jV10XqZkPDhR3veCf8wadIkUUvP4jdpPTiRCT+oXWpK0mOktu1N9XqIKZCbntf2L/J8wgPZceIjIYcXlU60sbn0OJwy8y13YzsRWVqjh9QFTsh9tHKVjqFmGS+RBh/3Pip9rBdNdKGEAyiOLhiJZdb
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:18.3499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37003d71-0756-41b0-f23f-08dc3e35625d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

Move the AdminQ and NotifyQ queue handling to ionic_main.c with
the rest of the adminq code.

Suggested-by: Neel Patel <npatel2@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  2 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 65 -------------------
 .../net/ethernet/pensando/ionic/ionic_main.c  | 65 +++++++++++++++++++
 3 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 9ffef2e06885..946c8ae1548f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -76,6 +76,8 @@ int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
 int ionic_adminq_post_wait_nomsg(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
 void ionic_adminq_netdev_err_print(struct ionic_lif *lif, u8 opcode,
 				   u8 status, int err);
+bool ionic_notifyq_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
+bool ionic_adminq_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
 
 int ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_wait);
 int ionic_dev_cmd_wait_nomsg(struct ionic *ionic, unsigned long max_wait);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index eb9ba683d635..a9835ede446e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1168,71 +1168,6 @@ int ionic_lif_set_hwstamp_rxfilt(struct ionic_lif *lif, u64 pkt_class)
 	return ionic_lif_add_hwstamp_rxfilt(lif, pkt_class);
 }
 
-static bool ionic_notifyq_service(struct ionic_cq *cq,
-				  struct ionic_cq_info *cq_info)
-{
-	union ionic_notifyq_comp *comp = cq_info->cq_desc;
-	struct ionic_deferred_work *work;
-	struct net_device *netdev;
-	struct ionic_queue *q;
-	struct ionic_lif *lif;
-	u64 eid;
-
-	q = cq->bound_q;
-	lif = q->info[0].cb_arg;
-	netdev = lif->netdev;
-	eid = le64_to_cpu(comp->event.eid);
-
-	/* Have we run out of new completions to process? */
-	if ((s64)(eid - lif->last_eid) <= 0)
-		return false;
-
-	lif->last_eid = eid;
-
-	dev_dbg(lif->ionic->dev, "notifyq event:\n");
-	dynamic_hex_dump("event ", DUMP_PREFIX_OFFSET, 16, 1,
-			 comp, sizeof(*comp), true);
-
-	switch (le16_to_cpu(comp->event.ecode)) {
-	case IONIC_EVENT_LINK_CHANGE:
-		ionic_link_status_check_request(lif, CAN_NOT_SLEEP);
-		break;
-	case IONIC_EVENT_RESET:
-		if (lif->ionic->idev.fw_status_ready &&
-		    !test_bit(IONIC_LIF_F_FW_RESET, lif->state) &&
-		    !test_and_set_bit(IONIC_LIF_F_FW_STOPPING, lif->state)) {
-			work = kzalloc(sizeof(*work), GFP_ATOMIC);
-			if (!work) {
-				netdev_err(lif->netdev, "Reset event dropped\n");
-				clear_bit(IONIC_LIF_F_FW_STOPPING, lif->state);
-			} else {
-				work->type = IONIC_DW_TYPE_LIF_RESET;
-				ionic_lif_deferred_enqueue(&lif->deferred, work);
-			}
-		}
-		break;
-	default:
-		netdev_warn(netdev, "Notifyq event ecode=%d eid=%lld\n",
-			    comp->event.ecode, eid);
-		break;
-	}
-
-	return true;
-}
-
-static bool ionic_adminq_service(struct ionic_cq *cq,
-				 struct ionic_cq_info *cq_info)
-{
-	struct ionic_admin_comp *comp = cq_info->cq_desc;
-
-	if (!color_match(comp->color, cq->done_color))
-		return false;
-
-	ionic_q_service(cq->bound_q, cq_info, le16_to_cpu(comp->comp_index));
-
-	return true;
-}
-
 static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 {
 	struct ionic_intr_info *intr = napi_to_cq(napi)->bound_intr;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 750a1ffaf855..46f2aa34330d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -269,6 +269,71 @@ static void ionic_adminq_cb(struct ionic_queue *q,
 	complete_all(&ctx->work);
 }
 
+bool ionic_notifyq_service(struct ionic_cq *cq,
+			   struct ionic_cq_info *cq_info)
+{
+	union ionic_notifyq_comp *comp = cq_info->cq_desc;
+	struct ionic_deferred_work *work;
+	struct net_device *netdev;
+	struct ionic_queue *q;
+	struct ionic_lif *lif;
+	u64 eid;
+
+	q = cq->bound_q;
+	lif = q->info[0].cb_arg;
+	netdev = lif->netdev;
+	eid = le64_to_cpu(comp->event.eid);
+
+	/* Have we run out of new completions to process? */
+	if ((s64)(eid - lif->last_eid) <= 0)
+		return false;
+
+	lif->last_eid = eid;
+
+	dev_dbg(lif->ionic->dev, "notifyq event:\n");
+	dynamic_hex_dump("event ", DUMP_PREFIX_OFFSET, 16, 1,
+			 comp, sizeof(*comp), true);
+
+	switch (le16_to_cpu(comp->event.ecode)) {
+	case IONIC_EVENT_LINK_CHANGE:
+		ionic_link_status_check_request(lif, CAN_NOT_SLEEP);
+		break;
+	case IONIC_EVENT_RESET:
+		if (lif->ionic->idev.fw_status_ready &&
+		    !test_bit(IONIC_LIF_F_FW_RESET, lif->state) &&
+		    !test_and_set_bit(IONIC_LIF_F_FW_STOPPING, lif->state)) {
+			work = kzalloc(sizeof(*work), GFP_ATOMIC);
+			if (!work) {
+				netdev_err(lif->netdev, "Reset event dropped\n");
+				clear_bit(IONIC_LIF_F_FW_STOPPING, lif->state);
+			} else {
+				work->type = IONIC_DW_TYPE_LIF_RESET;
+				ionic_lif_deferred_enqueue(&lif->deferred, work);
+			}
+		}
+		break;
+	default:
+		netdev_warn(netdev, "Notifyq event ecode=%d eid=%lld\n",
+			    comp->event.ecode, eid);
+		break;
+	}
+
+	return true;
+}
+
+bool ionic_adminq_service(struct ionic_cq *cq,
+			  struct ionic_cq_info *cq_info)
+{
+	struct ionic_admin_comp *comp = cq_info->cq_desc;
+
+	if (!color_match(comp->color, cq->done_color))
+		return false;
+
+	ionic_q_service(cq->bound_q, cq_info, le16_to_cpu(comp->comp_index));
+
+	return true;
+}
+
 bool ionic_adminq_poke_doorbell(struct ionic_queue *q)
 {
 	struct ionic_lif *lif = q->lif;
-- 
2.17.1


