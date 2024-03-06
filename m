Return-Path: <netdev+bounces-78175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1CF8743ED
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311CC1C21B67
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2251F94C;
	Wed,  6 Mar 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fwRCSjQa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10501CFB2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767827; cv=fail; b=r96xigVE6C+Ks7dy3dSvt8XB2X4Uj+QHKnpN0FIFliuUAXHWFADfsrMQ3aIL39sqVqjjh8BjUxekO8vBP8Fo4+ettgI+Hah3t6DFx6RJC6PTR/LhVgkmbVpdXpspu9Mx6S86xE3izHMeKvM4tw9/xWJsgs8nRZFTAnxiinAN1+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767827; c=relaxed/simple;
	bh=CpRvmqRRBggDDfz6FdYVN/5UPpszBCoGavX/rwobx4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6m07a+npOA8TLkIukfVmxd/wbvWXn4oaqWQKybNqu2QohK7tJ1BaK2tnhkOTU8F7PZzdeY6zmj5Gfz9GR6M76Xyt+69pDikohGY+iZH+//HEVNMKdjVIBAMzHPX0gIfaQ3wVBMZMysLr4ebBnufDN/rcKvL/hid0ckbRWZAM/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fwRCSjQa; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQxi8hlLt0q4IVIEeTqm6MK6Hp5jYBOQktQftrMJitW9xzsUk/hnRIoY8cYJ0B37rro26LYoynmow0dLCwzKJHMMmUNpXqvEac0Cul/jYQ7oBc7olxkNCmuL+yZEcZq7mlpjJ6evUrsqf4j7QcdO/SSv5d7pCh0M5rU1Doe9Aikw8TXczzNcWXwqd9p/MdlIN9BslonlGAY3YXSfb4sVFTOie5r2LF03fzXgVMd0UpK1Xlf93Qva/fNBQBb91U3glnd2RKbXgyPUCtbl01nl/T2kYhVt+OXATrxyqpHXZSdHnVozYHhavfcZYf9Tfnw+PCCk/XxMipX617Zk/MkeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0iyl+VTkk6u3fB7j8CQWp+xABxSVhhun5cF7GpGbaI=;
 b=E2of3lMT7isEU5DozQHv2LyxJDzwpRRQcBjYZcILwmiHv6tI8aZbiXXKBlkCFCsk0dgiwnofg+3CzisAW0+7YTdohdigxy71HUZbFh/VDwNKjvYoCJQALRS4akFqDPqOfmWGROPwJtJrda52i8PRd/y80Z5Bk/zqttOv5yJ/bzz4Qna7InjPhhf2RsLIA63w9URu3BBzPpcCcw9QvmzDtrbUOOGlqPdRxzfr+A1B0p5QWu5x48puzgRLTWd+E5n9FmlCDMBVlhyqMQJtqajw24gsyO2WxvV0+2gg8z6j6nTcK2ZtP/1b7EHyO1koy+yxQMxDIP6HKnKf/js9hLFHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0iyl+VTkk6u3fB7j8CQWp+xABxSVhhun5cF7GpGbaI=;
 b=fwRCSjQaAC09jvuJM+Yp8oshvvUocHrIVREQ1AOP6nW82erasiFFtHf1ntyJvHHAGVIzlfFcAaNmVmpkjZhUemCNbB0Ye6f6eVlMPOtLg4B8jgMWJW/644DsoJl8XRgbrrr0+7795VoBSU6u1hRXqN3Xf7ZXvBR+fgx76rKbo9o=
Received: from PH0PR07CA0101.namprd07.prod.outlook.com (2603:10b6:510:4::16)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:22 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::aa) by PH0PR07CA0101.outlook.office365.com
 (2603:10b6:510:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:20 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 06/14] ionic: use specialized desc info structs
Date: Wed, 6 Mar 2024 15:29:51 -0800
Message-ID: <20240306232959.17316-7-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2868c4-66c5-45e8-5c6f-08dc3e35648d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DuAbQxVxddicZf/stvtOdg7Wb/4N1dtJX3+82iF1eWkGVv1yPaV/aH2HRboc864zKz46A0JobiDS+uOHJHyV9nBjdV12CSt4F1BJX2MbCKHOyesCgrCsyPqqCqk+sy4dw8jpcvgPrfp5ZkdTDT+ri/zu+eJwdzvykiZF/qwiPDmX3wu8OR/f0FLmRFy8qVY/kMP63jj19vjwCnqb+o7KS5ncBdKwo/LWcHwZY/86WRcceeRpTDju/u+H4IiZEABrg7aZqr0Myd5PHpdQq8AG0ju/IjMr6Jep+XC/MPUSrr2s1L2eDjC6wOej5fBeaszW763w3HH5+cvYwMCnWvL42RJ2y9cdMJQKdAgS7oBdA5xMwKQinatiGI2E6KNkczfjZ7vr1755TqFKk+xuFHT2x/AqAhm6f3a8IWugdV7No2FLk/kLqlY9RBI/GGB5zdQCa2TWDaAPLx6X/RejJGvIizD5w+IZFHv/glwehYmU99I+9Qsvq/d+bSzvrr+Tu7x8Dcd6CB/d6sSOHSv6f3SCNNSF/Pm5zPHBGXY8uVHUHLKWAGG3Cwy7YcMxmL6KaXncenhe9bP4y/QZd9q1cTweKGrAFoZtIjev0PypXEKDXCkI6RScw4CG2oJ+K/cYyhycAZ2o8BGk88aWSoLPhXXFo0ThS1mdJrAHD7nFrKhE50o1IcRDzmA2PGD3N20obz7ZbwYFV38ogIqHqSH3WMbS/oMP4ErQUNBhuS5V2h2jXUXp2jiJlJVfvSDSwXrg+M1x
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:22.0161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2868c4-66c5-45e8-5c6f-08dc3e35648d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492

Make desc_info structure specific to the queue type, which
allows us to cut down the Rx and AdminQ descriptor sizes by
not including all the fields needed for the Tx desriptors.

Before:
    struct ionic_desc_info {
	/* size: 464, cachelines: 8, members: 6 */

After:
    struct ionic_tx_desc_info {
	/* size: 464, cachelines: 8, members: 6 */
    struct ionic_rx_desc_info {
	/* size: 224, cachelines: 4, members: 2 */
    struct ionic_admin_desc_info {
	/* size: 8, cachelines: 1, members: 1 */

Suggested-by: Neel Patel <npatel2@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.c   |  6 +-
 .../net/ethernet/pensando/ionic/ionic_dev.h   | 26 +++--
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 41 +++++---
 .../net/ethernet/pensando/ionic/ionic_main.c  | 26 ++---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 98 +++++++++----------
 5 files changed, 111 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 594e65a52010..8c961689b768 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -687,15 +687,11 @@ int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 	return 0;
 }
 
-void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, void *arg)
+void ionic_q_post(struct ionic_queue *q, bool ring_doorbell)
 {
-	struct ionic_desc_info *desc_info;
 	struct ionic_lif *lif = q->lif;
 	struct device *dev = q->dev;
 
-	desc_info = &q->info[q->head_idx];
-	desc_info->arg = arg;
-
 	q->head_idx = (q->head_idx + 1) & (q->num_descs - 1);
 
 	dev_dbg(dev, "lif=%d qname=%s qid=%d qtype=%d p_index=%d ringdb=%d\n",
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 3ed4eaea9315..e76db5647690 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -179,7 +179,6 @@ struct ionic_dev {
 
 struct ionic_queue;
 struct ionic_qcq;
-struct ionic_desc_info;
 
 #define IONIC_MAX_BUF_LEN			((u16)-1)
 #define IONIC_PAGE_SIZE				PAGE_SIZE
@@ -199,23 +198,38 @@ struct ionic_buf_info {
 	u32 len;
 };
 
-#define IONIC_MAX_FRAGS			(1 + IONIC_TX_MAX_SG_ELEMS_V1)
+#define IONIC_TX_MAX_FRAGS			(1 + IONIC_TX_MAX_SG_ELEMS_V1)
+#define IONIC_RX_MAX_FRAGS			(1 + IONIC_RX_MAX_SG_ELEMS)
 
-struct ionic_desc_info {
+struct ionic_tx_desc_info {
 	unsigned int bytes;
 	unsigned int nbufs;
-	void *arg;
+	struct sk_buff *skb;
 	struct xdp_frame *xdpf;
 	enum xdp_action act;
 	struct ionic_buf_info bufs[MAX_SKB_FRAGS + 1];
 };
 
+struct ionic_rx_desc_info {
+	unsigned int nbufs;
+	struct ionic_buf_info bufs[IONIC_RX_MAX_FRAGS];
+};
+
+struct ionic_admin_desc_info {
+	void *ctx;
+};
+
 #define IONIC_QUEUE_NAME_MAX_SZ		16
 
 struct ionic_queue {
 	struct device *dev;
 	struct ionic_lif *lif;
-	struct ionic_desc_info *info;
+	union {
+		void *info;
+		struct ionic_tx_desc_info *tx_info;
+		struct ionic_rx_desc_info *rx_info;
+		struct ionic_admin_desc_info *admin_info;
+	};
 	u64 dbval;
 	unsigned long dbell_deadline;
 	unsigned long dbell_jiffies;
@@ -367,7 +381,7 @@ int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 		 struct ionic_queue *q, unsigned int index, const char *name,
 		 unsigned int num_descs, size_t desc_size,
 		 size_t sg_desc_size, unsigned int pid);
-void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, void *arg);
+void ionic_q_post(struct ionic_queue *q, bool ring_doorbell);
 bool ionic_q_is_posted(struct ionic_queue *q, unsigned int pos);
 
 int ionic_heartbeat_check(struct ionic *ionic);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index afac48427af8..7f0c6cdc375e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -536,6 +536,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			   unsigned int num_descs, unsigned int desc_size,
 			   unsigned int cq_desc_size,
 			   unsigned int sg_desc_size,
+			   unsigned int desc_info_size,
 			   unsigned int pid, struct ionic_qcq **qcq)
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
@@ -555,7 +556,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 	new->q.dev = dev;
 	new->flags = flags;
 
-	new->q.info = vcalloc(num_descs, sizeof(*new->q.info));
+	new->q.info = vcalloc(num_descs, desc_info_size);
 	if (!new->q.info) {
 		netdev_err(lif->netdev, "Cannot allocate queue info\n");
 		err = -ENOMEM;
@@ -713,7 +714,9 @@ static int ionic_qcqs_alloc(struct ionic_lif *lif)
 			      IONIC_ADMINQ_LENGTH,
 			      sizeof(struct ionic_admin_cmd),
 			      sizeof(struct ionic_admin_comp),
-			      0, lif->kern_pid, &lif->adminqcq);
+			      0,
+			      sizeof(struct ionic_admin_desc_info),
+			      lif->kern_pid, &lif->adminqcq);
 	if (err)
 		return err;
 	ionic_debugfs_add_qcq(lif, lif->adminqcq);
@@ -724,7 +727,9 @@ static int ionic_qcqs_alloc(struct ionic_lif *lif)
 				      flags, IONIC_NOTIFYQ_LENGTH,
 				      sizeof(struct ionic_notifyq_cmd),
 				      sizeof(union ionic_notifyq_comp),
-				      0, lif->kern_pid, &lif->notifyqcq);
+				      0,
+				      sizeof(struct ionic_admin_desc_info),
+				      lif->kern_pid, &lif->notifyqcq);
 		if (err)
 			goto err_out;
 		ionic_debugfs_add_qcq(lif, lif->notifyqcq);
@@ -942,6 +947,7 @@ int ionic_lif_create_hwstamp_txq(struct ionic_lif *lif)
 
 	err = ionic_qcq_alloc(lif, IONIC_QTYPE_TXQ, txq_i, "hwstamp_tx", flags,
 			      num_desc, desc_sz, comp_sz, sg_desc_sz,
+			      sizeof(struct ionic_tx_desc_info),
 			      lif->kern_pid, &txq);
 	if (err)
 		goto err_qcq_alloc;
@@ -1001,6 +1007,7 @@ int ionic_lif_create_hwstamp_rxq(struct ionic_lif *lif)
 
 	err = ionic_qcq_alloc(lif, IONIC_QTYPE_RXQ, rxq_i, "hwstamp_rx", flags,
 			      num_desc, desc_sz, comp_sz, sg_desc_sz,
+			      sizeof(struct ionic_rx_desc_info),
 			      lif->kern_pid, &rxq);
 	if (err)
 		goto err_qcq_alloc;
@@ -2027,6 +2034,7 @@ static int ionic_txrx_alloc(struct ionic_lif *lif)
 	for (i = 0; i < lif->nxqs; i++) {
 		err = ionic_qcq_alloc(lif, IONIC_QTYPE_TXQ, i, "tx", flags,
 				      num_desc, desc_sz, comp_sz, sg_desc_sz,
+				      sizeof(struct ionic_tx_desc_info),
 				      lif->kern_pid, &lif->txqcqs[i]);
 		if (err)
 			goto err_out;
@@ -2058,6 +2066,7 @@ static int ionic_txrx_alloc(struct ionic_lif *lif)
 	for (i = 0; i < lif->nxqs; i++) {
 		err = ionic_qcq_alloc(lif, IONIC_QTYPE_RXQ, i, "rx", flags,
 				      num_desc, desc_sz, comp_sz, sg_desc_sz,
+				      sizeof(struct ionic_rx_desc_info),
 				      lif->kern_pid, &lif->rxqcqs[i]);
 		if (err)
 			goto err_out;
@@ -2938,6 +2947,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 				flags = IONIC_QCQ_F_TX_STATS | IONIC_QCQ_F_SG;
 				err = ionic_qcq_alloc(lif, IONIC_QTYPE_TXQ, i, "tx", flags,
 						      4, desc_sz, comp_sz, sg_desc_sz,
+						      sizeof(struct ionic_tx_desc_info),
 						      lif->kern_pid, &lif->txqcqs[i]);
 				if (err)
 					goto err_out;
@@ -2946,6 +2956,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 			flags = lif->txqcqs[i]->flags & ~IONIC_QCQ_F_INTR;
 			err = ionic_qcq_alloc(lif, IONIC_QTYPE_TXQ, i, "tx", flags,
 					      num_desc, desc_sz, comp_sz, sg_desc_sz,
+					      sizeof(struct ionic_tx_desc_info),
 					      lif->kern_pid, &tx_qcqs[i]);
 			if (err)
 				goto err_out;
@@ -2967,6 +2978,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 				flags = IONIC_QCQ_F_RX_STATS | IONIC_QCQ_F_SG;
 				err = ionic_qcq_alloc(lif, IONIC_QTYPE_RXQ, i, "rx", flags,
 						      4, desc_sz, comp_sz, sg_desc_sz,
+						      sizeof(struct ionic_rx_desc_info),
 						      lif->kern_pid, &lif->rxqcqs[i]);
 				if (err)
 					goto err_out;
@@ -2975,6 +2987,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 			flags = lif->rxqcqs[i]->flags & ~IONIC_QCQ_F_INTR;
 			err = ionic_qcq_alloc(lif, IONIC_QTYPE_RXQ, i, "rx", flags,
 					      num_desc, desc_sz, comp_sz, sg_desc_sz,
+					      sizeof(struct ionic_rx_desc_info),
 					      lif->kern_pid, &rx_qcqs[i]);
 			if (err)
 				goto err_out;
@@ -3549,7 +3562,7 @@ static int ionic_lif_notifyq_init(struct ionic_lif *lif)
 	dev_dbg(dev, "notifyq->hw_index %d\n", q->hw_index);
 
 	/* preset the callback info */
-	q->info[0].arg = lif;
+	q->admin_info[0].ctx = lif;
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
@@ -3801,6 +3814,7 @@ static void ionic_lif_queue_identify(struct ionic_lif *lif)
 	union ionic_q_identity __iomem *q_ident;
 	struct ionic *ionic = lif->ionic;
 	struct ionic_dev *idev;
+	u16 max_frags;
 	int qtype;
 	int err;
 
@@ -3868,17 +3882,16 @@ static void ionic_lif_queue_identify(struct ionic_lif *lif)
 		dev_dbg(ionic->dev, " qtype[%d].sg_desc_stride = %d\n",
 			qtype, qti->sg_desc_stride);
 
-		if (qti->max_sg_elems >= IONIC_MAX_FRAGS) {
-			qti->max_sg_elems = IONIC_MAX_FRAGS - 1;
-			dev_dbg(ionic->dev, "limiting qtype %d max_sg_elems to IONIC_MAX_FRAGS-1 %d\n",
-				qtype, qti->max_sg_elems);
-		}
+		if (qtype == IONIC_QTYPE_TXQ)
+			max_frags = IONIC_TX_MAX_FRAGS;
+		else if (qtype == IONIC_QTYPE_RXQ)
+			max_frags = IONIC_RX_MAX_FRAGS;
+		else
+			max_frags = 1;
 
-		if (qti->max_sg_elems > MAX_SKB_FRAGS) {
-			qti->max_sg_elems = MAX_SKB_FRAGS;
-			dev_dbg(ionic->dev, "limiting qtype %d max_sg_elems to MAX_SKB_FRAGS %d\n",
-				qtype, qti->max_sg_elems);
-		}
+		qti->max_sg_elems = min_t(u16, max_frags - 1, MAX_SKB_FRAGS);
+		dev_dbg(ionic->dev, "qtype %d max_sg_elems %d\n",
+			qtype, qti->max_sg_elems);
 	}
 }
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 2c092858bc0d..d248f725ef44 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -190,7 +190,7 @@ static const char *ionic_opcode_to_str(enum ionic_cmd_opcode opcode)
 
 static void ionic_adminq_flush(struct ionic_lif *lif)
 {
-	struct ionic_desc_info *desc_info;
+	struct ionic_admin_desc_info *desc_info;
 	struct ionic_admin_cmd *desc;
 	unsigned long irqflags;
 	struct ionic_queue *q;
@@ -205,9 +205,9 @@ static void ionic_adminq_flush(struct ionic_lif *lif)
 
 	while (q->tail_idx != q->head_idx) {
 		desc = &q->adminq[q->tail_idx];
-		desc_info = &q->info[q->tail_idx];
+		desc_info = &q->admin_info[q->tail_idx];
 		memset(desc, 0, sizeof(union ionic_adminq_cmd));
-		desc_info->arg = NULL;
+		desc_info->ctx = NULL;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 	}
 	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
@@ -248,10 +248,10 @@ static int ionic_adminq_check_err(struct ionic_lif *lif,
 }
 
 static void ionic_adminq_clean(struct ionic_queue *q,
-			       struct ionic_desc_info *desc_info,
+			       struct ionic_admin_desc_info *desc_info,
 			       struct ionic_admin_comp *comp)
 {
-	struct ionic_admin_ctx *ctx = desc_info->arg;
+	struct ionic_admin_ctx *ctx = desc_info->ctx;
 
 	if (!ctx)
 		return;
@@ -277,7 +277,7 @@ bool ionic_notifyq_service(struct ionic_cq *cq)
 	comp = &((union ionic_notifyq_comp *)cq->base)[cq->tail_idx];
 
 	q = cq->bound_q;
-	lif = q->info[0].arg;
+	lif = q->admin_info[0].ctx;
 	netdev = lif->netdev;
 	eid = le64_to_cpu(comp->event.eid);
 
@@ -320,8 +320,8 @@ bool ionic_notifyq_service(struct ionic_cq *cq)
 
 bool ionic_adminq_service(struct ionic_cq *cq)
 {
+	struct ionic_admin_desc_info *desc_info;
 	struct ionic_queue *q = cq->bound_q;
-	struct ionic_desc_info *desc_info;
 	struct ionic_admin_comp *comp;
 	u16 index;
 
@@ -335,12 +335,12 @@ bool ionic_adminq_service(struct ionic_cq *cq)
 		return false;
 
 	do {
-		desc_info = &q->info[q->tail_idx];
+		desc_info = &q->admin_info[q->tail_idx];
 		index = q->tail_idx;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		if (likely(desc_info->arg))
+		if (likely(desc_info->ctx))
 			ionic_adminq_clean(q, desc_info, comp);
-		desc_info->arg = NULL;
+		desc_info->ctx = NULL;
 	} while (index != le16_to_cpu(comp->comp_index));
 
 	return true;
@@ -377,6 +377,7 @@ bool ionic_adminq_poke_doorbell(struct ionic_queue *q)
 
 int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 {
+	struct ionic_admin_desc_info *desc_info;
 	struct ionic_admin_cmd *desc;
 	unsigned long irqflags;
 	struct ionic_queue *q;
@@ -399,6 +400,9 @@ int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 	if (err)
 		goto err_out;
 
+	desc_info = &q->admin_info[q->head_idx];
+	desc_info->ctx = ctx;
+
 	desc = &q->adminq[q->head_idx];
 	memcpy(desc, &ctx->cmd, sizeof(ctx->cmd));
 
@@ -406,7 +410,7 @@ int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 	dynamic_hex_dump("cmd ", DUMP_PREFIX_OFFSET, 16, 1,
 			 &ctx->cmd, sizeof(ctx->cmd), true);
 
-	ionic_q_post(q, true, ctx);
+	ionic_q_post(q, true);
 
 err_out:
 	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index e7ebd2df1e23..d4fd052fc48a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -19,22 +19,20 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 				    size_t offset, size_t len);
 
 static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
-				     struct ionic_desc_info *desc_info);
+				     struct ionic_tx_desc_info *desc_info);
 
 static void ionic_tx_clean(struct ionic_queue *q,
-			   struct ionic_desc_info *desc_info,
+			   struct ionic_tx_desc_info *desc_info,
 			   struct ionic_txq_comp *comp);
 
-static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell,
-				  void *arg)
+static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell)
 {
-	ionic_q_post(q, ring_dbell, arg);
+	ionic_q_post(q, ring_dbell);
 }
 
-static inline void ionic_rxq_post(struct ionic_queue *q, bool ring_dbell,
-				  void *arg)
+static inline void ionic_rxq_post(struct ionic_queue *q, bool ring_dbell)
 {
-	ionic_q_post(q, ring_dbell, arg);
+	ionic_q_post(q, ring_dbell);
 }
 
 bool ionic_txq_poke_doorbell(struct ionic_queue *q)
@@ -211,7 +209,7 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
 
 static struct sk_buff *ionic_rx_frags(struct net_device *netdev,
 				      struct ionic_queue *q,
-				      struct ionic_desc_info *desc_info,
+				      struct ionic_rx_desc_info *desc_info,
 				      unsigned int headroom,
 				      unsigned int len,
 				      unsigned int num_sg_elems,
@@ -279,7 +277,7 @@ static struct sk_buff *ionic_rx_frags(struct net_device *netdev,
 
 static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
 					  struct ionic_queue *q,
-					  struct ionic_desc_info *desc_info,
+					  struct ionic_rx_desc_info *desc_info,
 					  unsigned int headroom,
 					  unsigned int len,
 					  bool synced)
@@ -320,7 +318,7 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
 }
 
 static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
-				    struct ionic_desc_info *desc_info)
+				    struct ionic_tx_desc_info *desc_info)
 {
 	unsigned int nbufs = desc_info->nbufs;
 	struct ionic_buf_info *buf_info;
@@ -358,7 +356,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 				enum xdp_action act, struct page *page, int off,
 				bool ring_doorbell)
 {
-	struct ionic_desc_info *desc_info;
+	struct ionic_tx_desc_info *desc_info;
 	struct ionic_buf_info *buf_info;
 	struct ionic_tx_stats *stats;
 	struct ionic_txq_desc *desc;
@@ -366,7 +364,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 	dma_addr_t dma_addr;
 	u64 cmd;
 
-	desc_info = &q->info[q->head_idx];
+	desc_info = &q->tx_info[q->head_idx];
 	desc = &q->txq[q->head_idx];
 	buf_info = desc_info->bufs;
 	stats = q_to_tx_stats(q);
@@ -426,7 +424,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 	stats->pkts++;
 	stats->bytes += len;
 
-	ionic_txq_post(q, ring_doorbell, NULL);
+	ionic_txq_post(q, ring_doorbell);
 
 	return 0;
 }
@@ -634,7 +632,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 }
 
 static void ionic_rx_clean(struct ionic_queue *q,
-			   struct ionic_desc_info *desc_info,
+			   struct ionic_rx_desc_info *desc_info,
 			   struct ionic_rxq_comp *comp)
 {
 	struct net_device *netdev = q->lif->netdev;
@@ -742,8 +740,8 @@ static void ionic_rx_clean(struct ionic_queue *q,
 
 bool ionic_rx_service(struct ionic_cq *cq)
 {
+	struct ionic_rx_desc_info *desc_info;
 	struct ionic_queue *q = cq->bound_q;
-	struct ionic_desc_info *desc_info;
 	struct ionic_rxq_comp *comp;
 
 	comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];
@@ -758,14 +756,12 @@ bool ionic_rx_service(struct ionic_cq *cq)
 	if (q->tail_idx != le16_to_cpu(comp->comp_index))
 		return false;
 
-	desc_info = &q->info[q->tail_idx];
+	desc_info = &q->rx_info[q->tail_idx];
 	q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 
 	/* clean the related q entry, only one per qc completion */
 	ionic_rx_clean(q, desc_info, comp);
 
-	desc_info->arg = NULL;
-
 	return true;
 }
 
@@ -782,7 +778,7 @@ static inline void ionic_write_cmb_desc(struct ionic_queue *q,
 void ionic_rx_fill(struct ionic_queue *q)
 {
 	struct net_device *netdev = q->lif->netdev;
-	struct ionic_desc_info *desc_info;
+	struct ionic_rx_desc_info *desc_info;
 	struct ionic_rxq_sg_elem *sg_elem;
 	struct ionic_buf_info *buf_info;
 	unsigned int fill_threshold;
@@ -811,7 +807,7 @@ void ionic_rx_fill(struct ionic_queue *q)
 		nfrags = 0;
 		remain_len = len;
 		desc = &q->rxq[q->head_idx];
-		desc_info = &q->info[q->head_idx];
+		desc_info = &q->rx_info[q->head_idx];
 		buf_info = &desc_info->bufs[0];
 
 		if (!buf_info->page) { /* alloc a new buffer? */
@@ -868,7 +864,7 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 		ionic_write_cmb_desc(q, desc);
 
-		ionic_rxq_post(q, false, NULL);
+		ionic_rxq_post(q, false);
 	}
 
 	ionic_dbell_ring(q->lif->kern_dbpage, q->hw_type,
@@ -883,20 +879,19 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 void ionic_rx_empty(struct ionic_queue *q)
 {
-	struct ionic_desc_info *desc_info;
+	struct ionic_rx_desc_info *desc_info;
 	struct ionic_buf_info *buf_info;
 	unsigned int i, j;
 
 	for (i = 0; i < q->num_descs; i++) {
-		desc_info = &q->info[i];
-		for (j = 0; j < IONIC_RX_MAX_SG_ELEMS + 1; j++) {
+		desc_info = &q->rx_info[i];
+		for (j = 0; j < ARRAY_SIZE(desc_info->bufs); j++) {
 			buf_info = &desc_info->bufs[j];
 			if (buf_info->page)
 				ionic_rx_page_free(q, buf_info);
 		}
 
 		desc_info->nbufs = 0;
-		desc_info->arg = NULL;
 	}
 
 	q->head_idx = 0;
@@ -1108,7 +1103,7 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 }
 
 static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
-			    struct ionic_desc_info *desc_info)
+			    struct ionic_tx_desc_info *desc_info)
 {
 	struct ionic_buf_info *buf_info = desc_info->bufs;
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
@@ -1157,7 +1152,7 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 }
 
 static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
-				     struct ionic_desc_info *desc_info)
+				     struct ionic_tx_desc_info *desc_info)
 {
 	struct ionic_buf_info *buf_info = desc_info->bufs;
 	struct device *dev = q->dev;
@@ -1177,7 +1172,7 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 }
 
 static void ionic_tx_clean(struct ionic_queue *q,
-			   struct ionic_desc_info *desc_info,
+			   struct ionic_tx_desc_info *desc_info,
 			   struct ionic_txq_comp *comp)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
@@ -1196,7 +1191,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 
 	ionic_tx_desc_unmap_bufs(q, desc_info);
 
-	skb = desc_info->arg;
+	skb = desc_info->skb;
 	if (!skb)
 		return;
 
@@ -1236,8 +1231,8 @@ static void ionic_tx_clean(struct ionic_queue *q,
 static bool ionic_tx_service(struct ionic_cq *cq,
 			     unsigned int *total_pkts, unsigned int *total_bytes)
 {
+	struct ionic_tx_desc_info *desc_info;
 	struct ionic_queue *q = cq->bound_q;
-	struct ionic_desc_info *desc_info;
 	struct ionic_txq_comp *comp;
 	unsigned int bytes = 0;
 	unsigned int pkts = 0;
@@ -1252,15 +1247,15 @@ static bool ionic_tx_service(struct ionic_cq *cq,
 	 * several q entries completed for each cq completion
 	 */
 	do {
-		desc_info = &q->info[q->tail_idx];
+		desc_info = &q->tx_info[q->tail_idx];
 		desc_info->bytes = 0;
 		index = q->tail_idx;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 		ionic_tx_clean(q, desc_info, comp);
-		if (desc_info->arg) {
+		if (desc_info->skb) {
 			pkts++;
 			bytes += desc_info->bytes;
-			desc_info->arg = NULL;
+			desc_info->skb = NULL;
 		}
 	} while (index != le16_to_cpu(comp->comp_index));
 
@@ -1314,20 +1309,20 @@ void ionic_tx_flush(struct ionic_cq *cq)
 
 void ionic_tx_empty(struct ionic_queue *q)
 {
-	struct ionic_desc_info *desc_info;
+	struct ionic_tx_desc_info *desc_info;
 	int bytes = 0;
 	int pkts = 0;
 
 	/* walk the not completed tx entries, if any */
 	while (q->head_idx != q->tail_idx) {
-		desc_info = &q->info[q->tail_idx];
+		desc_info = &q->tx_info[q->tail_idx];
 		desc_info->bytes = 0;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 		ionic_tx_clean(q, desc_info, NULL);
-		if (desc_info->arg) {
+		if (desc_info->skb) {
 			pkts++;
 			bytes += desc_info->bytes;
-			desc_info->arg = NULL;
+			desc_info->skb = NULL;
 		}
 	}
 
@@ -1385,7 +1380,7 @@ static int ionic_tx_tcp_pseudo_csum(struct sk_buff *skb)
 }
 
 static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
-			      struct ionic_desc_info *desc_info,
+			      struct ionic_tx_desc_info *desc_info,
 			      struct sk_buff *skb,
 			      dma_addr_t addr, u8 nsge, u16 len,
 			      unsigned int hdrlen, unsigned int mss,
@@ -1415,9 +1410,9 @@ static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
 		skb_tx_timestamp(skb);
 		if (likely(!ionic_txq_hwstamp_enabled(q)))
 			netdev_tx_sent_queue(q_to_ndq(netdev, q), skb->len);
-		ionic_txq_post(q, false, skb);
+		ionic_txq_post(q, false);
 	} else {
-		ionic_txq_post(q, done, NULL);
+		ionic_txq_post(q, done);
 	}
 }
 
@@ -1425,7 +1420,7 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 			struct sk_buff *skb)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
-	struct ionic_desc_info *desc_info;
+	struct ionic_tx_desc_info *desc_info;
 	struct ionic_buf_info *buf_info;
 	struct ionic_txq_sg_elem *elem;
 	struct ionic_txq_desc *desc;
@@ -1447,8 +1442,7 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 	bool encap;
 	int err;
 
-	desc_info = &q->info[q->head_idx];
-	buf_info = desc_info->bufs;
+	desc_info = &q->tx_info[q->head_idx];
 
 	if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
 		return -EIO;
@@ -1485,6 +1479,8 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 	else
 		hdrlen = skb_tcp_all_headers(skb);
 
+	desc_info->skb = skb;
+	buf_info = desc_info->bufs;
 	tso_rem = len;
 	seg_rem = min(tso_rem, hdrlen + mss);
 
@@ -1536,7 +1532,7 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 				  start, done);
 		start = false;
 		/* Buffer information is stored with the first tso descriptor */
-		desc_info = &q->info[q->head_idx];
+		desc_info = &q->tx_info[q->head_idx];
 		desc_info->nbufs = 0;
 	}
 
@@ -1549,7 +1545,7 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 }
 
 static void ionic_tx_calc_csum(struct ionic_queue *q, struct sk_buff *skb,
-			       struct ionic_desc_info *desc_info)
+			       struct ionic_tx_desc_info *desc_info)
 {
 	struct ionic_txq_desc *desc = &q->txq[q->head_idx];
 	struct ionic_buf_info *buf_info = desc_info->bufs;
@@ -1588,7 +1584,7 @@ static void ionic_tx_calc_csum(struct ionic_queue *q, struct sk_buff *skb,
 }
 
 static void ionic_tx_calc_no_csum(struct ionic_queue *q, struct sk_buff *skb,
-				  struct ionic_desc_info *desc_info)
+				  struct ionic_tx_desc_info *desc_info)
 {
 	struct ionic_txq_desc *desc = &q->txq[q->head_idx];
 	struct ionic_buf_info *buf_info = desc_info->bufs;
@@ -1624,7 +1620,7 @@ static void ionic_tx_calc_no_csum(struct ionic_queue *q, struct sk_buff *skb,
 }
 
 static void ionic_tx_skb_frags(struct ionic_queue *q, struct sk_buff *skb,
-			       struct ionic_desc_info *desc_info)
+			       struct ionic_tx_desc_info *desc_info)
 {
 	struct ionic_buf_info *buf_info = &desc_info->bufs[1];
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
@@ -1643,13 +1639,15 @@ static void ionic_tx_skb_frags(struct ionic_queue *q, struct sk_buff *skb,
 static int ionic_tx(struct net_device *netdev, struct ionic_queue *q,
 		    struct sk_buff *skb)
 {
-	struct ionic_desc_info *desc_info = &q->info[q->head_idx];
+	struct ionic_tx_desc_info *desc_info = &q->tx_info[q->head_idx];
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	bool ring_dbell = true;
 
 	if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
 		return -EIO;
 
+	desc_info->skb = skb;
+
 	/* set up the initial descriptor */
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		ionic_tx_calc_csum(q, skb, desc_info);
@@ -1671,7 +1669,7 @@ static int ionic_tx(struct net_device *netdev, struct ionic_queue *q,
 		ring_dbell = __netdev_tx_sent_queue(ndq, skb->len,
 						    netdev_xmit_more());
 	}
-	ionic_txq_post(q, ring_dbell, skb);
+	ionic_txq_post(q, ring_dbell);
 
 	return 0;
 }
-- 
2.17.1


