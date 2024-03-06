Return-Path: <netdev+bounces-78172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16CB8743EA
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00127B23B5D
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190C1CD11;
	Wed,  6 Mar 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nrXIDwT1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A81C6B8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767824; cv=fail; b=HhSy9LFq25P+sE/qkzklISiBGviwCxwXFI07TqzGsZn0rYD6HhHKOJQcDJ4Qz/0ZFPLbgqN3knTjGMfNammmVWiv2093iAF4Nfz4sVbMkq/k0JDcxvfXlWtm/h1LV8bBZAfNdg6r01fQBv3wvh3LqALJ1eWEBJb+swlsWQUwUQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767824; c=relaxed/simple;
	bh=nBjE2E0Hv0KGjiTjc8KSWxmRhQ+mv7z8GZZ59EbCMCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBK9hrGipSGkQqJqh5k7Q/+v7FhXy97poDXgsg5GBrdTDQAPkbb+yYn7y02K7KuTCXrLOuEr6YZZH5voNrl/Y9Bf4egALF7akLMPeROOdjuV9jX0e3fXdW2YdUi5DuqMP6R9JyNrI51XjIvO6e0vqHcnftuAJXURV6DkdHuLZOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nrXIDwT1; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTLljC9PHYQA/naln/GCwnEoOgy4nhFlW6ttmc7ieGfyLUlkuwpC0zKh6JnI9+MMCZ4w8pH5RT8UJHD3vSI25jqI5rVu9lNoapFPKm0nNt7Koh3TBAiGFvFjD3fnZygk3OAQY0RZeR3NNThhpWGSy1c/tjcolYkLFcl3QPbPPdPdf542tMXYSYwi8RCC4yjjk9g+JR7Gzz179wDXP1N+bo/aF0uOEt2du/TyWlti1HBxgFNV+aoJguPWpjal/r3v1Rup8QFzCeSyTfTOIk1vKk06x9LMcnh1P4QCxasl2yj3rN0OFPDVm+ZFXKukowI2++EEG2WpKBjeNXlLILUmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o92WWVCWeie2Vp1C5uWczEYFaeiFj75QY9eP0vr1pSs=;
 b=LQ48vBOtTVg8eaoaFh47cUySU0p6Nd1HdlKCKsVxgE8gQAr/u6fR2LBBk2lZS86H0tUlaMYLWqYZFCOlICPm02Ww3CE/QHM8EnsSrWQizv3OcZ09uqASLNzN+mdeC4O3C2aeFOfJ6wUyCWRGEivVvgDG+uaTsFrtzQXVOploJQWhkrQ5QXNzsbntLcg160QNpY7TYKoUdwzIS7dXhmE4RsTDpZ3Vxk/VhIVwIb3hahqG6Kx+WMaxRIyL2dxan9prvh38DY+BZvWTLFDsjBVi34vw4eE1E+Kn21iIwyjZbYRB2sp9KvqR1eUK3WXjIjlHmy58+VNj3Enq9C+Dh7IBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o92WWVCWeie2Vp1C5uWczEYFaeiFj75QY9eP0vr1pSs=;
 b=nrXIDwT1Kiw6Wk9TnEWkLjKzMd0G1s5zeN3MJ3fsvztD+xYOuTOQZ+f2/BlHvLEvrzq8OPCUKjFJH7d5fVCuUHWpC4RwfgCAvz3wlKCecSB4ykXhwO16pcBWbejhapU4QEL9+aUc0sQs+ryCZooMPLVGxUdgIUtBOLHF8gqSICU=
Received: from SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:19 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::6) by SA9P223CA0029.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.25 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:19 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:17 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 04/14] ionic: remove callback pointer from desc_info
Date: Wed, 6 Mar 2024 15:29:49 -0800
Message-ID: <20240306232959.17316-5-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ab141e-12cb-4444-d1b1-08dc3e356313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6darI9HOToL6EvV0JGzLzlsFQPW9CXcrCea7b16k71BoelQ1GN8LJ6EMxO6hWsE51SJvuA8OCw+1EEmJ7Fd+GeF81+E107ggWKtYtXYQ1IpLpkISAosMW/icEq2tZTNo+Hk3PjvKajwDaZv3I0fqcQ4YtSB/HhN21WtgRokpUdpA1/UR3+IvjWmG8Wu5Qn+n89CWhrztgmTZl9LHwc/X7DwXy05DWHih9zujD7+csSOi1XsirFh74XwQ6blJqMBtUxFj4CPUWVMSUZgbncT35ID57DcGdT5t9RfkbzUtV8zP3kU3c3DrKdoOWZIHCb3YPQE+ZoFtoRpI/BLrpaL6qE7b+OFBbn4YFgRGoM7TeCZymkSyjDtP0iFvYSz35wwdMvR356mterEAKloVnpp0kbOKWpp/A2UZvK9XxI/qhCFpxP+qda/whQLK5KNeGAGox7wykQS3qt+Mq3g1WGVrn39d+Np4XScA5S5URhKSoU4gwjglItKFmcDrde9YFLTz3TiKP4hAusMbjz1B1zAyUkGGZeODuPRchgOAthcXmgyB1c/GqmETnVKx2m/pDyeqKi6zrhw7Hf0iyZeHezgaeP/fhiMkzuGJB8ap0FV+qyIOrBoC3cfuQ9v2gjvxGTRYkWyq4y6UuMcPZeBOOPtn0n3qF4kD6dfEd9SUCElaHZsAuxgvq135x5zkgAxZJbv3LjJzjTYN8GUBzCATRFPnlqJbvNIsuJBzI625eBjfvPYBlPfxpawj7gwp1HqpzPcf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:19.5574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ab141e-12cb-4444-d1b1-08dc3e356313
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022

By reworking the queue service routines to have their own
servicing loops we can remove the cb pointer from desc_info
to save another 8 bytes per descriptor,

This simplifies some of the queue handling indirection and makes
the code a little easier to follow, and keeps service code in
one place rather than jumping between code files.

   struct ionic_desc_info
	Before:  /* size: 472, cachelines: 8, members: 7 */
	After:   /* size: 464, cachelines: 8, members: 6 */

Suggested-by: Neel Patel <npatel2@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 42 ++-------------
 .../net/ethernet/pensando/ionic/ionic_dev.h   | 14 ++---
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  2 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  | 38 +++++++++-----
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 52 ++++++++-----------
 5 files changed, 57 insertions(+), 91 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index b4889f8c14d8..94bd0db34473 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -706,16 +706,14 @@ int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 	return 0;
 }
 
-void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
-		  void *cb_arg)
+void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, void *arg)
 {
 	struct ionic_desc_info *desc_info;
 	struct ionic_lif *lif = q->lif;
 	struct device *dev = q->dev;
 
 	desc_info = &q->info[q->head_idx];
-	desc_info->cb = cb;
-	desc_info->cb_arg = cb_arg;
+	desc_info->arg = arg;
 
 	q->head_idx = (q->head_idx + 1) & (q->num_descs - 1);
 
@@ -735,7 +733,7 @@ void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
 	}
 }
 
-static bool ionic_q_is_posted(struct ionic_queue *q, unsigned int pos)
+bool ionic_q_is_posted(struct ionic_queue *q, unsigned int pos)
 {
 	unsigned int mask, tail, head;
 
@@ -745,37 +743,3 @@ static bool ionic_q_is_posted(struct ionic_queue *q, unsigned int pos)
 
 	return ((pos - tail) & mask) < ((head - tail) & mask);
 }
-
-void ionic_q_service(struct ionic_queue *q, struct ionic_cq_info *cq_info,
-		     unsigned int stop_index)
-{
-	struct ionic_desc_info *desc_info;
-	ionic_desc_cb cb;
-	void *cb_arg;
-	u16 index;
-
-	/* check for empty queue */
-	if (q->tail_idx == q->head_idx)
-		return;
-
-	/* stop index must be for a descriptor that is not yet completed */
-	if (unlikely(!ionic_q_is_posted(q, stop_index)))
-		dev_err(q->dev,
-			"ionic stop is not posted %s stop %u tail %u head %u\n",
-			q->name, stop_index, q->tail_idx, q->head_idx);
-
-	do {
-		desc_info = &q->info[q->tail_idx];
-		index = q->tail_idx;
-		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-
-		cb = desc_info->cb;
-		cb_arg = desc_info->cb_arg;
-
-		desc_info->cb = NULL;
-		desc_info->cb_arg = NULL;
-
-		if (cb)
-			cb(q, desc_info, cq_info, cb_arg);
-	} while (index != stop_index);
-}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index c70576be3714..2096aae1ef71 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -189,10 +189,6 @@ struct ionic_queue;
 struct ionic_qcq;
 struct ionic_desc_info;
 
-typedef void (*ionic_desc_cb)(struct ionic_queue *q,
-			      struct ionic_desc_info *desc_info,
-			      struct ionic_cq_info *cq_info, void *cb_arg);
-
 #define IONIC_MAX_BUF_LEN			((u16)-1)
 #define IONIC_PAGE_SIZE				PAGE_SIZE
 #define IONIC_PAGE_SPLIT_SZ			(PAGE_SIZE / 2)
@@ -216,8 +212,7 @@ struct ionic_buf_info {
 struct ionic_desc_info {
 	unsigned int bytes;
 	unsigned int nbufs;
-	ionic_desc_cb cb;
-	void *cb_arg;
+	void *arg;
 	struct xdp_frame *xdpf;
 	enum xdp_action act;
 	struct ionic_buf_info bufs[MAX_SKB_FRAGS + 1];
@@ -381,10 +376,9 @@ int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 		 struct ionic_queue *q, unsigned int index, const char *name,
 		 unsigned int num_descs, size_t desc_size,
 		 size_t sg_desc_size, unsigned int pid);
-void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
-		  void *cb_arg);
-void ionic_q_service(struct ionic_queue *q, struct ionic_cq_info *cq_info,
-		     unsigned int stop_index);
+void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, void *arg);
+bool ionic_q_is_posted(struct ionic_queue *q, unsigned int pos);
+
 int ionic_heartbeat_check(struct ionic *ionic);
 bool ionic_is_fw_running(struct ionic_dev *idev);
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index a9835ede446e..4cc879955d21 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3564,7 +3564,7 @@ static int ionic_lif_notifyq_init(struct ionic_lif *lif)
 	dev_dbg(dev, "notifyq->hw_index %d\n", q->hw_index);
 
 	/* preset the callback info */
-	q->info[0].cb_arg = lif;
+	q->info[0].arg = lif;
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 46f2aa34330d..023c2c37056e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -207,8 +207,7 @@ static void ionic_adminq_flush(struct ionic_lif *lif)
 		desc = &q->adminq[q->tail_idx];
 		desc_info = &q->info[q->tail_idx];
 		memset(desc, 0, sizeof(union ionic_adminq_cmd));
-		desc_info->cb = NULL;
-		desc_info->cb_arg = NULL;
+		desc_info->arg = NULL;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 	}
 	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
@@ -248,11 +247,11 @@ static int ionic_adminq_check_err(struct ionic_lif *lif,
 	return err;
 }
 
-static void ionic_adminq_cb(struct ionic_queue *q,
-			    struct ionic_desc_info *desc_info,
-			    struct ionic_cq_info *cq_info, void *cb_arg)
+static void ionic_adminq_clean(struct ionic_queue *q,
+			       struct ionic_desc_info *desc_info,
+			       struct ionic_cq_info *cq_info)
 {
-	struct ionic_admin_ctx *ctx = cb_arg;
+	struct ionic_admin_ctx *ctx = desc_info->arg;
 	struct ionic_admin_comp *comp;
 
 	if (!ctx)
@@ -280,7 +279,7 @@ bool ionic_notifyq_service(struct ionic_cq *cq,
 	u64 eid;
 
 	q = cq->bound_q;
-	lif = q->info[0].cb_arg;
+	lif = q->info[0].arg;
 	netdev = lif->netdev;
 	eid = le64_to_cpu(comp->event.eid);
 
@@ -321,15 +320,30 @@ bool ionic_notifyq_service(struct ionic_cq *cq,
 	return true;
 }
 
-bool ionic_adminq_service(struct ionic_cq *cq,
-			  struct ionic_cq_info *cq_info)
+bool ionic_adminq_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 {
-	struct ionic_admin_comp *comp = cq_info->cq_desc;
+	struct ionic_queue *q = cq->bound_q;
+	struct ionic_desc_info *desc_info;
+	struct ionic_admin_comp *comp;
+	u16 index;
+
+	comp = cq_info->cq_desc;
 
 	if (!color_match(comp->color, cq->done_color))
 		return false;
 
-	ionic_q_service(cq->bound_q, cq_info, le16_to_cpu(comp->comp_index));
+	/* check for empty queue */
+	if (q->tail_idx == q->head_idx)
+		return false;
+
+	do {
+		desc_info = &q->info[q->tail_idx];
+		index = q->tail_idx;
+		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
+		if (likely(desc_info->arg))
+			ionic_adminq_clean(q, desc_info, cq_info);
+		desc_info->arg = NULL;
+	} while (index != le16_to_cpu(comp->comp_index));
 
 	return true;
 }
@@ -394,7 +408,7 @@ int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 	dynamic_hex_dump("cmd ", DUMP_PREFIX_OFFSET, 16, 1,
 			 &ctx->cmd, sizeof(ctx->cmd), true);
 
-	ionic_q_post(q, true, ionic_adminq_cb, ctx);
+	ionic_q_post(q, true, ctx);
 
 err_out:
 	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index bc8e099ca1ac..fcd6a2fe31d2 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -23,19 +23,18 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
-			   struct ionic_cq_info *cq_info,
-			   void *cb_arg);
+			   struct ionic_cq_info *cq_info);
 
 static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell,
-				  ionic_desc_cb cb_func, void *cb_arg)
+				  void *arg)
 {
-	ionic_q_post(q, ring_dbell, cb_func, cb_arg);
+	ionic_q_post(q, ring_dbell, arg);
 }
 
 static inline void ionic_rxq_post(struct ionic_queue *q, bool ring_dbell,
-				  ionic_desc_cb cb_func, void *cb_arg)
+				  void *arg)
 {
-	ionic_q_post(q, ring_dbell, cb_func, cb_arg);
+	ionic_q_post(q, ring_dbell, arg);
 }
 
 bool ionic_txq_poke_doorbell(struct ionic_queue *q)
@@ -427,7 +426,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 	stats->pkts++;
 	stats->bytes += len;
 
-	ionic_txq_post(q, ring_doorbell, ionic_tx_clean, NULL);
+	ionic_txq_post(q, ring_doorbell, NULL);
 
 	return 0;
 }
@@ -636,8 +635,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
 static void ionic_rx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
-			   struct ionic_cq_info *cq_info,
-			   void *cb_arg)
+			   struct ionic_cq_info *cq_info)
 {
 	struct net_device *netdev = q->lif->netdev;
 	struct ionic_qcq *qcq = q_to_qcq(q);
@@ -767,10 +765,9 @@ bool ionic_rx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 	q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 
 	/* clean the related q entry, only one per qc completion */
-	ionic_rx_clean(q, desc_info, cq_info, desc_info->cb_arg);
+	ionic_rx_clean(q, desc_info, cq_info);
 
-	desc_info->cb = NULL;
-	desc_info->cb_arg = NULL;
+	desc_info->arg = NULL;
 
 	return true;
 }
@@ -874,7 +871,7 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 		ionic_write_cmb_desc(q, desc);
 
-		ionic_rxq_post(q, false, ionic_rx_clean, NULL);
+		ionic_rxq_post(q, false, NULL);
 	}
 
 	ionic_dbell_ring(q->lif->kern_dbpage, q->hw_type,
@@ -902,8 +899,7 @@ void ionic_rx_empty(struct ionic_queue *q)
 		}
 
 		desc_info->nbufs = 0;
-		desc_info->cb = NULL;
-		desc_info->cb_arg = NULL;
+		desc_info->arg = NULL;
 	}
 
 	q->head_idx = 0;
@@ -1185,12 +1181,11 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
-			   struct ionic_cq_info *cq_info,
-			   void *cb_arg)
+			   struct ionic_cq_info *cq_info)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct ionic_qcq *qcq = q_to_qcq(q);
-	struct sk_buff *skb = cb_arg;
+	struct sk_buff *skb;
 
 	if (desc_info->xdpf) {
 		ionic_xdp_tx_desc_clean(q->partner, desc_info);
@@ -1204,6 +1199,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 
 	ionic_tx_desc_unmap_bufs(q, desc_info);
 
+	skb = desc_info->arg;
 	if (!skb)
 		return;
 
@@ -1263,13 +1259,12 @@ static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info,
 		desc_info->bytes = 0;
 		index = q->tail_idx;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		ionic_tx_clean(q, desc_info, cq_info, desc_info->cb_arg);
-		if (desc_info->cb_arg) {
+		ionic_tx_clean(q, desc_info, cq_info);
+		if (desc_info->arg) {
 			pkts++;
 			bytes += desc_info->bytes;
+			desc_info->arg = NULL;
 		}
-		desc_info->cb = NULL;
-		desc_info->cb_arg = NULL;
 	} while (index != le16_to_cpu(comp->comp_index));
 
 	(*total_pkts) += pkts;
@@ -1334,13 +1329,12 @@ void ionic_tx_empty(struct ionic_queue *q)
 		desc_info = &q->info[q->tail_idx];
 		desc_info->bytes = 0;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		ionic_tx_clean(q, desc_info, NULL, desc_info->cb_arg);
-		if (desc_info->cb_arg) {
+		ionic_tx_clean(q, desc_info, NULL);
+		if (desc_info->arg) {
 			pkts++;
 			bytes += desc_info->bytes;
+			desc_info->arg = NULL;
 		}
-		desc_info->cb = NULL;
-		desc_info->cb_arg = NULL;
 	}
 
 	if (likely(!ionic_txq_hwstamp_enabled(q))) {
@@ -1427,9 +1421,9 @@ static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
 		skb_tx_timestamp(skb);
 		if (likely(!ionic_txq_hwstamp_enabled(q)))
 			netdev_tx_sent_queue(q_to_ndq(netdev, q), skb->len);
-		ionic_txq_post(q, false, ionic_tx_clean, skb);
+		ionic_txq_post(q, false, skb);
 	} else {
-		ionic_txq_post(q, done, NULL, NULL);
+		ionic_txq_post(q, done, NULL);
 	}
 }
 
@@ -1683,7 +1677,7 @@ static int ionic_tx(struct net_device *netdev, struct ionic_queue *q,
 		ring_dbell = __netdev_tx_sent_queue(ndq, skb->len,
 						    netdev_xmit_more());
 	}
-	ionic_txq_post(q, ring_dbell, ionic_tx_clean, skb);
+	ionic_txq_post(q, ring_dbell, skb);
 
 	return 0;
 }
-- 
2.17.1


