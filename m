Return-Path: <netdev+bounces-78170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC568743E8
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825C81C20984
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EF21CF83;
	Wed,  6 Mar 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c4GHSrFg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4451CABD
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767822; cv=fail; b=nFxRcXGqzHjWL9yw7YYowfjXV2LqBXJ2+Ll8c+CeDplc9QgrkdRpHQfW5b3ObQ9UUGytSHuobH1Kylh05N2i8LXRCF2zqR0NhuwJHtJCekCFvonmPFsR5r8A5cEw57SfFUkyA7mWSsZyozq9BP/h1GTy71iPp4bzxmrioIdsAhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767822; c=relaxed/simple;
	bh=4Q1YLtEjQb9/58nE5KaZUkQqa8NBl8JVUK0T1op4WTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiWw7y7vaaSHwJDA/Eaj3dDT9Ei206bXTxlYYxRs+clLHi71+QAHiLYcNAAeNOoCgDeO1NHZm1JdTvZ4M11OwqWQd1A7PVX705LoXs5hLX5eH8g4kJh6AoV7lFwfmcizluxSD9JTUlmGZSCckl+eIB3QfXXDcXdnVpPzKQzB8ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c4GHSrFg; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3ohEQPzfrKS2MO2zJQgOKxMp/ymaMAIkwG2CzvhQM7drpZRvWTWhtTK2PZE2694rGoOPTZGZ/JDDCg54QZtnln50NzQOQeVWhJTChFkXNatdHb0qZaXwLfMo7ih3KOLvXUgWP2dbostvwdgVkB9AAyDidb9U/Wg3N51PsCNSR34AqM7q5Hadgiprmk8q11ZMQw/q53B9dnHn0nUBtjvD92LPIOYBBEcZqwOCigSb1gkbItyqcRMqF7YaAiTjHp6LsSCMX7baLCkoPLEJtkTsq6OKHsTdYe4FAmWcCPWpp4EWaUXhFjIo3Kcy9d9WPFf4n2mo6NObGfDytnimgFWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYkHrP7tg15rROo9UsND+6RvjAnEShiWQAdQ8SOBvx0=;
 b=FpUgT9ClK4pJ93c8Am2FRF5uF3eIH2zv/rQFKP8d+LQ0ul4pNKXSu02LhzUSUXwzZIhqBEPN8GwODiLNUtvD2C8HZEu77OPfaaGQ9hx933BmFq+fAO6u6bPlK4iJfDPGQhZovLHNbGFRe3SutCbnKS1YForJBYvYoBeG3ZHcq9PzGFpJZTvyB4kS57Qf8waP1LY+kDFRuzm95nmyjM2vMElod5d8fCOzMQXoo+N08KoK5OeWAFIOGMmzIbcDFV5u5kjTe0tLXr2eD94xf1h+CAgX2Dhh6q+fm+r1di7osnue2LLHZbHRIr/yXAD1klXpIKrDR/aiwqKp1fbzE2vr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYkHrP7tg15rROo9UsND+6RvjAnEShiWQAdQ8SOBvx0=;
 b=c4GHSrFgtNxzf9z6qMLYTLPd8pmaWbE1x4cOVozC0lKD9M7RnVmpHg5w/aPLHNmDCniUqmKXzZAO0b8H024WOgJCsvrwfH7fGCy3Bq18Ze3JAvMyzZ1hpFHVhFgDcl3j4XPJXCC6GqumpSSIG0qFdIZyjFwU2NcCYiXKMsPs2/w=
Received: from PH0PR07CA0098.namprd07.prod.outlook.com (2603:10b6:510:4::13)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:16 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::db) by PH0PR07CA0098.outlook.office365.com
 (2603:10b6:510:4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:15 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:14 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 01/14] ionic: remove desc, sg_desc and cmb_desc from desc_info
Date: Wed, 6 Mar 2024 15:29:46 -0800
Message-ID: <20240306232959.17316-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bfc562-b037-46fe-5df3-08dc3e3560e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ywn+psYIKI5KrJ8G4MBc4ig4pQsMEtLMKNXGu5Cbz+k0S0zeVSX7TCpcCEOghvaYo0UmzAbnfGUQHo13fvyEg62uCvP2cJKJ6sAWOi2e3FAxA6sG0qZbXGBAJxpA/e2Fu8r2F5KQFQ6HdSGIoGxMlgO5DHRJ4FbBlKtbWIdVT3SD/n9FmcoDNh1M+eIRopkf51AQWrX7XFJqUkI6OYUVHRi9ceekOu18KvRcz/YGDpnCghMk8Vx6g9Y/NgO+YVEJMLaFtOALH7AOVgSqrx7WQtLqkqvNAIfP3aPTbYKsbPK5Zg4WAWN3bOj6gNRLWfd8nhBn0e1cne59r92Zl/UbGF7q8DIE1+u3nfo84fqfX95NCUD26FY3KjEzabRyMbehps3FSnn3eh0Tt8bbNIPFU5HgytMmKghTNhF0wCcvw7+bXTcp07JsDESXZNzOG1N/XckFHzB4o8WaQEc1aBDDeULwsSkbBH0RNKOvNlRPrVJIFzbQkePShjnTmahJbiJtCT+g+J1eP0weeQixGk2bfnWJNDWU4ytboCxo/q7HUw4Z75kfAIewKV25nMY3eE6tyAJ0CTQpMd3ILfXUqhnvIiw1AkRaOdSZ3tDq6IehedjYYLL38wuEvbrRy+ez1QoXeIAoKQcL/dKGGBm7b8js4NNSiMoPnps3sY91l424NmZU3yziOXEPwJuwyzdHxF4VwaLANhGoHcfB+rTWDNKbKrxz/xomf8ticwtPJ9M/hJiY3vX0dF3yBmiT7QL6lf3e
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:15.8754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bfc562-b037-46fe-5df3-08dc3e3560e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174

Remove the struct pointers from desc_info to use less space.
Instead of pointers in every desc_info to its descriptor,
we can use the queue descriptor index to find the individual
desc, desc_info, and sgl structs in their parallel arrays.

   struct ionic_desc_info
	Before:  /* size: 496, cachelines: 8, members: 10 */
	After:   /* size: 472, cachelines: 8, members: 7 */

Suggested-by: Neel Patel <npatel2@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 18 -------
 .../net/ethernet/pensando/ionic/ionic_dev.h   | 23 ++++----
 .../net/ethernet/pensando/ionic/ionic_main.c  | 10 ++--
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 54 ++++++++++---------
 4 files changed, 45 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 746072b4dbd0..fc83f80fba00 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -708,38 +708,20 @@ int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 
 void ionic_q_map(struct ionic_queue *q, void *base, dma_addr_t base_pa)
 {
-	struct ionic_desc_info *cur;
-	unsigned int i;
-
 	q->base = base;
 	q->base_pa = base_pa;
-
-	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++)
-		cur->desc = base + (i * q->desc_size);
 }
 
 void ionic_q_cmb_map(struct ionic_queue *q, void __iomem *base, dma_addr_t base_pa)
 {
-	struct ionic_desc_info *cur;
-	unsigned int i;
-
 	q->cmb_base = base;
 	q->cmb_base_pa = base_pa;
-
-	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++)
-		cur->cmb_desc = base + (i * q->desc_size);
 }
 
 void ionic_q_sg_map(struct ionic_queue *q, void *base, dma_addr_t base_pa)
 {
-	struct ionic_desc_info *cur;
-	unsigned int i;
-
 	q->sg_base = base;
 	q->sg_base_pa = base_pa;
-
-	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++)
-		cur->sg_desc = base + (i * q->sg_desc_size);
 }
 
 void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 516db910e8e8..d38c909478ea 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -122,11 +122,13 @@ static_assert(sizeof(struct ionic_log_event) == 64);
 /* I/O */
 static_assert(sizeof(struct ionic_txq_desc) == 16);
 static_assert(sizeof(struct ionic_txq_sg_desc) == 128);
+static_assert(sizeof(struct ionic_txq_sg_desc_v1) == 256);
 static_assert(sizeof(struct ionic_txq_comp) == 16);
 
 static_assert(sizeof(struct ionic_rxq_desc) == 16);
 static_assert(sizeof(struct ionic_rxq_sg_desc) == 128);
 static_assert(sizeof(struct ionic_rxq_comp) == 16);
+static_assert(sizeof(struct ionic_rxq_comp) == sizeof(struct ionic_txq_comp));
 
 /* SR/IOV */
 static_assert(sizeof(struct ionic_vf_setattr_cmd) == 64);
@@ -212,25 +214,13 @@ struct ionic_buf_info {
 #define IONIC_MAX_FRAGS			(1 + IONIC_TX_MAX_SG_ELEMS_V1)
 
 struct ionic_desc_info {
-	union {
-		void *desc;
-		struct ionic_txq_desc *txq_desc;
-		struct ionic_rxq_desc *rxq_desc;
-		struct ionic_admin_cmd *adminq_desc;
-	};
-	void __iomem *cmb_desc;
-	union {
-		void *sg_desc;
-		struct ionic_txq_sg_desc *txq_sg_desc;
-		struct ionic_rxq_sg_desc *rxq_sgl_desc;
-	};
 	unsigned int bytes;
 	unsigned int nbufs;
-	struct ionic_buf_info bufs[MAX_SKB_FRAGS + 1];
 	ionic_desc_cb cb;
 	void *cb_arg;
 	struct xdp_frame *xdpf;
 	enum xdp_action act;
+	struct ionic_buf_info bufs[MAX_SKB_FRAGS + 1];
 };
 
 #define IONIC_QUEUE_NAME_MAX_SZ		16
@@ -259,10 +249,15 @@ struct ionic_queue {
 		struct ionic_rxq_desc *rxq;
 		struct ionic_admin_cmd *adminq;
 	};
-	void __iomem *cmb_base;
+	union {
+		void __iomem *cmb_base;
+		struct ionic_txq_desc __iomem *cmb_txq;
+		struct ionic_rxq_desc __iomem *cmb_rxq;
+	};
 	union {
 		void *sg_base;
 		struct ionic_txq_sg_desc *txq_sgl;
+		struct ionic_txq_sg_desc_v1 *txq_sgl_v1;
 		struct ionic_rxq_sg_desc *rxq_sgl;
 	};
 	struct xdp_rxq_info *xdp_rxq_info;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 29b4d039bbce..750a1ffaf855 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -191,6 +191,7 @@ static const char *ionic_opcode_to_str(enum ionic_cmd_opcode opcode)
 static void ionic_adminq_flush(struct ionic_lif *lif)
 {
 	struct ionic_desc_info *desc_info;
+	struct ionic_admin_cmd *desc;
 	unsigned long irqflags;
 	struct ionic_queue *q;
 
@@ -203,8 +204,9 @@ static void ionic_adminq_flush(struct ionic_lif *lif)
 	q = &lif->adminqcq->q;
 
 	while (q->tail_idx != q->head_idx) {
+		desc = &q->adminq[q->tail_idx];
 		desc_info = &q->info[q->tail_idx];
-		memset(desc_info->desc, 0, sizeof(union ionic_adminq_cmd));
+		memset(desc, 0, sizeof(union ionic_adminq_cmd));
 		desc_info->cb = NULL;
 		desc_info->cb_arg = NULL;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
@@ -298,7 +300,7 @@ bool ionic_adminq_poke_doorbell(struct ionic_queue *q)
 
 int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 {
-	struct ionic_desc_info *desc_info;
+	struct ionic_admin_cmd *desc;
 	unsigned long irqflags;
 	struct ionic_queue *q;
 	int err = 0;
@@ -320,8 +322,8 @@ int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 	if (err)
 		goto err_out;
 
-	desc_info = &q->info[q->head_idx];
-	memcpy(desc_info->desc, &ctx->cmd, sizeof(ctx->cmd));
+	desc = &q->adminq[q->head_idx];
+	memcpy(desc, &ctx->cmd, sizeof(ctx->cmd));
 
 	dev_dbg(&lif->netdev->dev, "post admin queue command:\n");
 	dynamic_hex_dump("cmd ", DUMP_PREFIX_OFFSET, 16, 1,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 6d168ad8c84f..bc8e099ca1ac 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -99,6 +99,14 @@ bool ionic_rxq_poke_doorbell(struct ionic_queue *q)
 	return true;
 }
 
+static inline struct ionic_txq_sg_elem *ionic_tx_sg_elems(struct ionic_queue *q)
+{
+	if (likely(q->sg_desc_size == sizeof(struct ionic_txq_sg_desc_v1)))
+		return q->txq_sgl_v1[q->head_idx].elems;
+	else
+		return q->txq_sgl[q->head_idx].elems;
+}
+
 static inline struct netdev_queue *q_to_ndq(struct net_device *netdev,
 					    struct ionic_queue *q)
 {
@@ -360,7 +368,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 	u64 cmd;
 
 	desc_info = &q->info[q->head_idx];
-	desc = desc_info->txq_desc;
+	desc = &q->txq[q->head_idx];
 	buf_info = desc_info->bufs;
 	stats = q_to_tx_stats(q);
 
@@ -388,7 +396,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 		bi = &buf_info[1];
 		sinfo = xdp_get_shared_info_from_frame(frame);
 		frag = sinfo->frags;
-		elem = desc_info->txq_sg_desc->elems;
+		elem = ionic_tx_sg_elems(q);
 		for (i = 0; i < sinfo->nr_frags; i++, frag++, bi++) {
 			dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
 			if (dma_mapping_error(q->dev, dma_addr)) {
@@ -768,18 +776,19 @@ bool ionic_rx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 }
 
 static inline void ionic_write_cmb_desc(struct ionic_queue *q,
-					void __iomem *cmb_desc,
 					void *desc)
 {
-	if (q_to_qcq(q)->flags & IONIC_QCQ_F_CMB_RINGS)
-		memcpy_toio(cmb_desc, desc, q->desc_size);
+	/* Since Rx and Tx descriptors are the same size, we can
+	 * save an instruction or two and skip the qtype check.
+	 */
+	if (unlikely(q_to_qcq(q)->flags & IONIC_QCQ_F_CMB_RINGS))
+		memcpy_toio(&q->cmb_txq[q->head_idx], desc, sizeof(q->cmb_txq[0]));
 }
 
 void ionic_rx_fill(struct ionic_queue *q)
 {
 	struct net_device *netdev = q->lif->netdev;
 	struct ionic_desc_info *desc_info;
-	struct ionic_rxq_sg_desc *sg_desc;
 	struct ionic_rxq_sg_elem *sg_elem;
 	struct ionic_buf_info *buf_info;
 	unsigned int fill_threshold;
@@ -807,8 +816,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 		nfrags = 0;
 		remain_len = len;
+		desc = &q->rxq[q->head_idx];
 		desc_info = &q->info[q->head_idx];
-		desc = desc_info->desc;
 		buf_info = &desc_info->bufs[0];
 
 		if (!buf_info->page) { /* alloc a new buffer? */
@@ -837,9 +846,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 		nfrags++;
 
 		/* fill sg descriptors - buf[1..n] */
-		sg_desc = desc_info->sg_desc;
-		for (j = 0; remain_len > 0 && j < q->max_sg_elems; j++) {
-			sg_elem = &sg_desc->elems[j];
+		sg_elem = q->rxq_sgl[q->head_idx].elems;
+		for (j = 0; remain_len > 0 && j < q->max_sg_elems; j++, sg_elem++) {
 			if (!buf_info->page) { /* alloc a new sg buffer? */
 				if (unlikely(ionic_rx_page_alloc(q, buf_info))) {
 					sg_elem->addr = 0;
@@ -857,16 +865,14 @@ void ionic_rx_fill(struct ionic_queue *q)
 		}
 
 		/* clear end sg element as a sentinel */
-		if (j < q->max_sg_elems) {
-			sg_elem = &sg_desc->elems[j];
+		if (j < q->max_sg_elems)
 			memset(sg_elem, 0, sizeof(*sg_elem));
-		}
 
 		desc->opcode = (nfrags > 1) ? IONIC_RXQ_DESC_OPCODE_SG :
 					      IONIC_RXQ_DESC_OPCODE_SIMPLE;
 		desc_info->nbufs = nfrags;
 
-		ionic_write_cmb_desc(q, desc_info->cmb_desc, desc);
+		ionic_write_cmb_desc(q, desc);
 
 		ionic_rxq_post(q, false, ionic_rx_clean, NULL);
 	}
@@ -1399,7 +1405,7 @@ static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
 			      u16 vlan_tci, bool has_vlan,
 			      bool start, bool done)
 {
-	struct ionic_txq_desc *desc = desc_info->desc;
+	struct ionic_txq_desc *desc = &q->txq[q->head_idx];
 	u8 flags = 0;
 	u64 cmd;
 
@@ -1415,7 +1421,7 @@ static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
 	desc->hdr_len = cpu_to_le16(hdrlen);
 	desc->mss = cpu_to_le16(mss);
 
-	ionic_write_cmb_desc(q, desc_info->cmb_desc, desc);
+	ionic_write_cmb_desc(q, desc);
 
 	if (start) {
 		skb_tx_timestamp(skb);
@@ -1517,8 +1523,8 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 			chunk_len = min(frag_rem, seg_rem);
 			if (!desc) {
 				/* fill main descriptor */
-				desc = desc_info->txq_desc;
-				elem = desc_info->txq_sg_desc->elems;
+				desc = &q->txq[q->head_idx];
+				elem = ionic_tx_sg_elems(q);
 				desc_addr = frag_addr;
 				desc_len = chunk_len;
 			} else {
@@ -1557,7 +1563,7 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 static void ionic_tx_calc_csum(struct ionic_queue *q, struct sk_buff *skb,
 			       struct ionic_desc_info *desc_info)
 {
-	struct ionic_txq_desc *desc = desc_info->txq_desc;
+	struct ionic_txq_desc *desc = &q->txq[q->head_idx];
 	struct ionic_buf_info *buf_info = desc_info->bufs;
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	bool has_vlan;
@@ -1585,7 +1591,7 @@ static void ionic_tx_calc_csum(struct ionic_queue *q, struct sk_buff *skb,
 	desc->csum_start = cpu_to_le16(skb_checksum_start_offset(skb));
 	desc->csum_offset = cpu_to_le16(skb->csum_offset);
 
-	ionic_write_cmb_desc(q, desc_info->cmb_desc, desc);
+	ionic_write_cmb_desc(q, desc);
 
 	if (skb_csum_is_sctp(skb))
 		stats->crc32_csum++;
@@ -1596,7 +1602,7 @@ static void ionic_tx_calc_csum(struct ionic_queue *q, struct sk_buff *skb,
 static void ionic_tx_calc_no_csum(struct ionic_queue *q, struct sk_buff *skb,
 				  struct ionic_desc_info *desc_info)
 {
-	struct ionic_txq_desc *desc = desc_info->txq_desc;
+	struct ionic_txq_desc *desc = &q->txq[q->head_idx];
 	struct ionic_buf_info *buf_info = desc_info->bufs;
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	bool has_vlan;
@@ -1624,7 +1630,7 @@ static void ionic_tx_calc_no_csum(struct ionic_queue *q, struct sk_buff *skb,
 	desc->csum_start = 0;
 	desc->csum_offset = 0;
 
-	ionic_write_cmb_desc(q, desc_info->cmb_desc, desc);
+	ionic_write_cmb_desc(q, desc);
 
 	stats->csum_none++;
 }
@@ -1632,12 +1638,12 @@ static void ionic_tx_calc_no_csum(struct ionic_queue *q, struct sk_buff *skb,
 static void ionic_tx_skb_frags(struct ionic_queue *q, struct sk_buff *skb,
 			       struct ionic_desc_info *desc_info)
 {
-	struct ionic_txq_sg_desc *sg_desc = desc_info->txq_sg_desc;
 	struct ionic_buf_info *buf_info = &desc_info->bufs[1];
-	struct ionic_txq_sg_elem *elem = sg_desc->elems;
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
+	struct ionic_txq_sg_elem *elem;
 	unsigned int i;
 
+	elem = ionic_tx_sg_elems(q);
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++, buf_info++, elem++) {
 		elem->addr = cpu_to_le64(buf_info->dma_addr);
 		elem->len = cpu_to_le16(buf_info->len);
-- 
2.17.1


