Return-Path: <netdev+bounces-70056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5130884D75D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C46D1F22C94
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E81CD33;
	Thu,  8 Feb 2024 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DZDir2rk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376312E61
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353877; cv=fail; b=jPwdMFxb6JbqmF6yZM2N/GZ3bwa95NnGI0PJyJBJxtyv5e3mRFDWK4M5IqAW2Xo1WGei+/Z1LvGoYvPoBLIhpCneidHeR/3QIRY9j6/s5ZuW+Jf5BJ3f+ETfqRqMc+uUPZfNCzcn3jdkwjX9zbESFvt45Ie48E5spAWrQxCnxXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353877; c=relaxed/simple;
	bh=qyzdkTwtyzw7V3BNRm9XRGyvOmawbZZhYIyZ+oBlD6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmOGvp7Nf4elF2eR35xeeCmGXUgyIiOHs2P9d9mwtrZW68CggJ+vo/aDR0UtHoZxRXKkFMuD7dXa0OIVlzbKkDt/DAhQBe078JLCGDjcS9zHLYMn2ZKqsD53GwBriL5GjWR3ksJgspXiVNJKE5kXISUEgzSkYYZZlHnOJdCd7dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DZDir2rk; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbCP++eExDVcN2ZmZ3xPzKvZQBDxrPRtE43eJGy/h8QRPfEvVYUcrCcdry5IB52sisziG2xVUMXYRAWZcAW//K9jZUuqr4/WiGRmXPygPFQ9BqKmv+CrahHgTuhx9lZc6avpzMBgT6WZxYXUllaajDsfUOva2mA/u6scvqhMViBTD4ms/0ux9TJjl27vFLCxNHSH2lU+Bb2rRpZap4cDou/XkuOECYhpRzVHcXBvLChNNY8sLI7bjtUMrHe2IQ3hlOXV9JdpsQmYbdZyPAA34UC/ghbHJibXBlikVnCdUb9yCtxO5dDZgUZGCjySdt8Vazf7ozd+QDt4qkscfEhn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYK4E6FlTH+eIHsn39Qp5vRfvx9dTmWLyvB5jMU4f4I=;
 b=oL67ZkXqGQJk73w7vSfdvuu/jGdKBIfKHcgI3N6FNJftsgFVg8RRNPvZWxZQPUVzDLxWDyEROEeYOZOOVlZUG370a6/o9xyK43xENQV/gBKoA+GlLfvR9wZskIgJVecIh5RQxNavG4DhA8nRATyMWQ8Arkx88UmkUL4wsuw0l3/An3YN3PMvgaeyx34Tz5RJ8CerJTSLGYGjl/yMD9Ap2OXtdwHYlrFmw5P9iKdgVfwrthI10y4fUvCaDEyWzA1K7i1/CBJ1s10Z7JgP7Knujiiasw77CorkDjiduW/1VVkH35+yoiP4J3A6VsIvw6CMEMTP3q8kD+ZrTVM/nCf5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYK4E6FlTH+eIHsn39Qp5vRfvx9dTmWLyvB5jMU4f4I=;
 b=DZDir2rkxgIVBDJ/zn8iF4tUERSGSL/ugDTmgAI/5rbQA7uriExfv+D0IIeS+P+cE/9ru44uiN2P49NUZk653tWvU9lhs+sMtUVLb+axD3P4G+pikrPy6YWK2LGfths6/tc9+PoPPGCebvVP9LZQG3iilRFxqC0A4drhM/TuMZ4=
Received: from CH0P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::11)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 00:57:51 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::cf) by CH0P223CA0029.outlook.office365.com
 (2603:10b6:610:116::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:51 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:50 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 05/10] ionic: add initial framework for XDP support
Date: Wed, 7 Feb 2024 16:57:20 -0800
Message-ID: <20240208005725.65134-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208005725.65134-1-shannon.nelson@amd.com>
References: <20240208005725.65134-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da5c99e-5c6e-44a3-20f3-08dc2840f9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZK1L3X+H3n5afVdEE5pmoxjfd9eJ2GErw3dq9qpjIZeo5N3T5qnR4ggfQFLMLw4zU2+TzSxpTnWfRFIT6mee/b3z+ewzAfg2cF0GTofjaLmKtRS8jbExKum79EVuIvBoGh0bGUEerbAGSH0hZyVPUSjM5U4cKfsPigLGZVAcqrca4lLHR/scCu38unXh6w1RLWXJ5eDH6xIrDDvQH6i9A7S1i6Y0tMBqksR1Lglin28wk+tDdlRLzY3gYgyFoCS2VmvfjGwG0Hhf4hP0HIBs2EDKCm07LY2D4t0lsHQstJlRyUcGlSfg+ZO0PlKynuGg82dk15cqld8U055Ap8N/wS0veIk7RUwKNeMFFKLfUyQL+EcovLNzzXGtIGzimTVrRCEG+cQ8LkUBv5ZOgQ71NN4PAsxZa7UtfyA9WVmJFMtlsFtv9wmoqYUqqDng6Crxe4AYmVRFUoGTTIbJrbTtCAbCRP5DhlQ8hwX2she3HuttDoVxO67NtMXq4b2JDO33JPe9ZhNuV0OkVTEmTW9nkn7gzFf4qXtW/0yFmFGSJoPmm35zgVFdGochPfCZyVyNivt+ZnjAsp2DelX/ENdi8zhsDggarLsTZR0rQJp+nsA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(5660300002)(81166007)(2616005)(426003)(336012)(1076003)(26005)(356005)(16526019)(82740400003)(86362001)(41300700001)(316002)(110136005)(70206006)(4326008)(36756003)(478600001)(70586007)(8936002)(8676002)(44832011)(30864003)(83380400001)(54906003)(2906002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:51.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da5c99e-5c6e-44a3-20f3-08dc2840f9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

Set up the basics for running Rx packets through XDP programs.
Add new queue setup and teardown steps for adding/removing an
XDP program, and add the call to run the XDP on a packet.

The XDP frame size needs to be the MTU plus standard ethernet
header, plus head room for XDP scribblings and tail room for a
struct skb_shared_info.  Also, at this point, we don't support
XDP frags, only a single contiguous Rx buffer.  This means
that our page splitting is not very useful, so when XDP is in
use we need to use the full Rx buffer size and not do sharing.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   7 +
 .../ethernet/pensando/ionic/ionic_ethtool.c   |   5 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 172 +++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   7 +
 .../net/ethernet/pensando/ionic/ionic_stats.c |   9 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  61 ++++++-
 6 files changed, 255 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 2667e1cde16b..70f5725fdfe8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <linux/skbuff.h>
+#include <linux/bpf_trace.h>
 
 #include "ionic_if.h"
 #include "ionic_regs.h"
@@ -195,6 +196,11 @@ typedef void (*ionic_desc_cb)(struct ionic_queue *q,
 #define IONIC_PAGE_GFP_MASK			(GFP_ATOMIC | __GFP_NOWARN |\
 						 __GFP_COMP | __GFP_MEMALLOC)
 
+#define IONIC_XDP_MAX_LINEAR_MTU	(IONIC_PAGE_SIZE -	\
+					 (VLAN_ETH_HLEN +	\
+					  XDP_PACKET_HEADROOM +	\
+					  SKB_DATA_ALIGN(sizeof(struct skb_shared_info))))
+
 struct ionic_buf_info {
 	struct page *page;
 	dma_addr_t dma_addr;
@@ -256,6 +262,7 @@ struct ionic_queue {
 		struct ionic_txq_sg_desc *txq_sgl;
 		struct ionic_rxq_sg_desc *rxq_sgl;
 	};
+	struct xdp_rxq_info *xdp_rxq_info;
 	dma_addr_t base_pa;
 	dma_addr_t cmb_base_pa;
 	dma_addr_t sg_base_pa;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index cd3c0b01402e..98df2ee11c51 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -721,6 +721,11 @@ static int ionic_set_channels(struct net_device *netdev,
 
 	ionic_init_queue_params(lif, &qparam);
 
+	if ((ch->rx_count || ch->tx_count) && lif->xdp_prog) {
+		netdev_info(lif->netdev, "Split Tx/Rx interrupts not available when using XDP\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (ch->rx_count != ch->tx_count) {
 		netdev_info(netdev, "The rx and tx count must be equal\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index d92f8734d153..6e9065dd149e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -46,6 +46,9 @@ static int ionic_start_queues(struct ionic_lif *lif);
 static void ionic_stop_queues(struct ionic_lif *lif);
 static void ionic_lif_queue_identify(struct ionic_lif *lif);
 
+static int ionic_xdp_queues_config(struct ionic_lif *lif);
+static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q);
+
 static void ionic_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
@@ -422,6 +425,7 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		qcq->sg_base_pa = 0;
 	}
 
+	ionic_xdp_unregister_rxq_info(&qcq->q);
 	ionic_qcq_intr_free(lif, qcq);
 
 	vfree(qcq->cq.info);
@@ -862,8 +866,7 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 			.type = q->type,
 			.ver = lif->qtype_info[q->type].version,
 			.index = cpu_to_le32(q->index),
-			.flags = cpu_to_le16(IONIC_QINIT_F_IRQ |
-					     IONIC_QINIT_F_SG),
+			.flags = cpu_to_le16(IONIC_QINIT_F_IRQ),
 			.intr_index = cpu_to_le16(cq->bound_intr->index),
 			.pid = cpu_to_le16(q->pid),
 			.ring_size = ilog2(q->num_descs),
@@ -875,6 +878,9 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	};
 	int err;
 
+	if (!lif->xdp_prog)
+		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
+
 	if (qcq->flags & IONIC_QCQ_F_CMB_RINGS) {
 		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_CMB);
 		ctx.cmd.q_init.ring_base = cpu_to_le64(qcq->cmb_q_base_pa);
@@ -1640,6 +1646,8 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 	netdev->priv_flags |= IFF_UNICAST_FLT |
 			      IFF_LIVE_ADDR_CHANGE;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
+
 	return 0;
 }
 
@@ -1777,6 +1785,18 @@ static int ionic_start_queues_reconfig(struct ionic_lif *lif)
 	return err;
 }
 
+static bool ionic_xdp_is_valid_mtu(struct ionic_lif *lif, u32 mtu,
+				   struct bpf_prog *xdp_prog)
+{
+	if (!xdp_prog)
+		return true;
+
+	if (mtu <= IONIC_XDP_MAX_LINEAR_MTU)
+		return true;
+
+	return false;
+}
+
 static int ionic_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
@@ -1789,8 +1809,13 @@ static int ionic_change_mtu(struct net_device *netdev, int new_mtu)
 			.mtu = cpu_to_le32(new_mtu),
 		},
 	};
+	struct bpf_prog *xdp_prog;
 	int err;
 
+	xdp_prog = READ_ONCE(lif->xdp_prog);
+	if (!ionic_xdp_is_valid_mtu(lif, new_mtu, xdp_prog))
+		return -EINVAL;
+
 	err = ionic_adminq_post_wait(lif, &ctx);
 	if (err)
 		return err;
@@ -2166,6 +2191,10 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 	int derr = 0;
 	int i, err;
 
+	err = ionic_xdp_queues_config(lif);
+	if (err)
+		return err;
+
 	for (i = 0; i < lif->nxqs; i++) {
 		if (!(lif->rxqcqs[i] && lif->txqcqs[i])) {
 			dev_err(lif->ionic->dev, "%s: bad qcq %d\n", __func__, i);
@@ -2211,6 +2240,8 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 		derr = ionic_qcq_disable(lif, lif->rxqcqs[i], derr);
 	}
 
+	ionic_xdp_queues_config(lif);
+
 	return err;
 }
 
@@ -2668,11 +2699,147 @@ static void ionic_vf_attr_replay(struct ionic_lif *lif)
 	ionic_vf_start(ionic);
 }
 
+static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q)
+{
+	struct xdp_rxq_info *xi;
+
+	if (!q->xdp_rxq_info)
+		return;
+
+	xi = q->xdp_rxq_info;
+	q->xdp_rxq_info = NULL;
+
+	xdp_rxq_info_unreg(xi);
+	kfree(xi);
+}
+
+static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
+{
+	struct xdp_rxq_info *rxq_info;
+	int err;
+
+	rxq_info = kzalloc(sizeof(*rxq_info), GFP_KERNEL);
+	if (!rxq_info)
+		return -ENOMEM;
+
+	err = xdp_rxq_info_reg(rxq_info, q->lif->netdev, q->index, napi_id);
+	if (err) {
+		dev_err(q->dev, "Queue %d xdp_rxq_info_reg failed, err %d\n",
+			q->index, err);
+		kfree(rxq_info);
+		return err;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_ORDER0, NULL);
+	if (err) {
+		dev_err(q->dev, "Queue %d xdp_rxq_info_reg_mem_model failed, err %d\n",
+			q->index, err);
+		xdp_rxq_info_unreg(rxq_info);
+		kfree(rxq_info);
+		return err;
+	}
+
+	q->xdp_rxq_info = rxq_info;
+
+	return 0;
+}
+
+static int ionic_xdp_queues_config(struct ionic_lif *lif)
+{
+	unsigned int i;
+	int err;
+
+	if (!lif->rxqcqs)
+		return 0;
+
+	/* There's no need to rework memory if not going to/from NULL program.
+	 * If there is no lif->xdp_prog, there should also be no q.xdp_rxq_info
+	 * This way we don't need to keep an *xdp_prog in every queue struct.
+	 */
+	if (!lif->xdp_prog == !lif->rxqcqs[0]->q.xdp_rxq_info)
+		return 0;
+
+	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
+		struct ionic_queue *q = &lif->rxqcqs[i]->q;
+
+		if (q->xdp_rxq_info) {
+			ionic_xdp_unregister_rxq_info(q);
+		} else {
+			err = ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
+			if (err) {
+				dev_err(lif->ionic->dev, "failed to register RX queue %d info for XDP, err %d\n",
+					i, err);
+				goto err_out;
+			}
+		}
+	}
+
+	return 0;
+
+err_out:
+	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++)
+		ionic_xdp_unregister_rxq_info(&lif->rxqcqs[i]->q);
+
+	return err;
+}
+
+static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
+{
+	struct ionic_lif *lif = netdev_priv(netdev);
+	struct bpf_prog *old_prog;
+	u32 maxfs;
+
+	if (test_bit(IONIC_LIF_F_SPLIT_INTR, lif->state)) {
+#define XDP_ERR_SPLIT "XDP not available with split Tx/Rx interrupts"
+		NL_SET_ERR_MSG_MOD(bpf->extack, XDP_ERR_SPLIT);
+		netdev_info(lif->netdev, XDP_ERR_SPLIT);
+		return -EOPNOTSUPP;
+	}
+
+	if (!ionic_xdp_is_valid_mtu(lif, netdev->mtu, bpf->prog)) {
+#define XDP_ERR_MTU "MTU is too large for XDP without frags support"
+		NL_SET_ERR_MSG_MOD(bpf->extack, XDP_ERR_MTU);
+		netdev_info(lif->netdev, XDP_ERR_MTU);
+		return -EINVAL;
+	}
+
+	maxfs = __le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
+	if (bpf->prog)
+		maxfs = min_t(u32, maxfs, IONIC_XDP_MAX_LINEAR_MTU);
+	netdev->max_mtu = maxfs;
+
+	if (!netif_running(netdev)) {
+		old_prog = xchg(&lif->xdp_prog, bpf->prog);
+	} else {
+		mutex_lock(&lif->queue_lock);
+		ionic_stop_queues_reconfig(lif);
+		old_prog = xchg(&lif->xdp_prog, bpf->prog);
+		ionic_start_queues_reconfig(lif);
+		mutex_unlock(&lif->queue_lock);
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
+}
+
+static int ionic_xdp(struct net_device *netdev, struct netdev_bpf *bpf)
+{
+	switch (bpf->command) {
+	case XDP_SETUP_PROG:
+		return ionic_xdp_config(netdev, bpf);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct net_device_ops ionic_netdev_ops = {
 	.ndo_open               = ionic_open,
 	.ndo_stop               = ionic_stop,
 	.ndo_eth_ioctl		= ionic_eth_ioctl,
 	.ndo_start_xmit		= ionic_start_xmit,
+	.ndo_bpf		= ionic_xdp,
 	.ndo_get_stats64	= ionic_get_stats64,
 	.ndo_set_rx_mode	= ionic_ndo_set_rx_mode,
 	.ndo_set_features	= ionic_set_features,
@@ -2755,6 +2922,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
 	swap(a->q.base,       b->q.base);
 	swap(a->q.base_pa,    b->q.base_pa);
 	swap(a->q.info,       b->q.info);
+	swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
 	swap(a->q_base,       b->q_base);
 	swap(a->q_base_pa,    b->q_base_pa);
 	swap(a->q_size,       b->q_size);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 61548b3eea93..61fa4ea4f04c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -51,6 +51,9 @@ struct ionic_rx_stats {
 	u64 alloc_err;
 	u64 hwstamp_valid;
 	u64 hwstamp_invalid;
+	u64 xdp_drop;
+	u64 xdp_aborted;
+	u64 xdp_pass;
 };
 
 #define IONIC_QCQ_F_INITED		BIT(0)
@@ -135,6 +138,9 @@ struct ionic_lif_sw_stats {
 	u64 hw_rx_over_errors;
 	u64 hw_rx_missed_errors;
 	u64 hw_tx_aborted_errors;
+	u64 xdp_drop;
+	u64 xdp_aborted;
+	u64 xdp_pass;
 };
 
 enum ionic_lif_state_flags {
@@ -230,6 +236,7 @@ struct ionic_lif {
 	struct ionic_phc *phc;
 
 	struct dentry *dentry;
+	struct bpf_prog *xdp_prog;
 };
 
 struct ionic_phc {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 1f6022fb7679..2fb20173b2c6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -27,6 +27,9 @@ static const struct ionic_stat_desc ionic_lif_stats_desc[] = {
 	IONIC_LIF_STAT_DESC(hw_rx_over_errors),
 	IONIC_LIF_STAT_DESC(hw_rx_missed_errors),
 	IONIC_LIF_STAT_DESC(hw_tx_aborted_errors),
+	IONIC_LIF_STAT_DESC(xdp_drop),
+	IONIC_LIF_STAT_DESC(xdp_aborted),
+	IONIC_LIF_STAT_DESC(xdp_pass),
 };
 
 static const struct ionic_stat_desc ionic_port_stats_desc[] = {
@@ -149,6 +152,9 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
 	IONIC_RX_STAT_DESC(hwstamp_invalid),
 	IONIC_RX_STAT_DESC(dropped),
 	IONIC_RX_STAT_DESC(vlan_stripped),
+	IONIC_RX_STAT_DESC(xdp_drop),
+	IONIC_RX_STAT_DESC(xdp_aborted),
+	IONIC_RX_STAT_DESC(xdp_pass),
 };
 
 #define IONIC_NUM_LIF_STATS ARRAY_SIZE(ionic_lif_stats_desc)
@@ -185,6 +191,9 @@ static void ionic_add_lif_rxq_stats(struct ionic_lif *lif, int q_num,
 	stats->rx_csum_error += rxstats->csum_error;
 	stats->rx_hwstamp_valid += rxstats->hwstamp_valid;
 	stats->rx_hwstamp_invalid += rxstats->hwstamp_invalid;
+	stats->xdp_drop += rxstats->xdp_drop;
+	stats->xdp_aborted += rxstats->xdp_aborted;
+	stats->xdp_pass += rxstats->xdp_pass;
 }
 
 static void ionic_get_lif_stats(struct ionic_lif *lif,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 65d6fdff3767..95dd632be9fe 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -177,7 +177,7 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
 	if (page_to_nid(buf_info->page) != numa_mem_id())
 		return false;
 
-	size = ALIGN(used, IONIC_PAGE_SPLIT_SZ);
+	size = ALIGN(used, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
 	buf_info->page_offset += size;
 	if (buf_info->page_offset >= IONIC_PAGE_SIZE)
 		return false;
@@ -287,6 +287,54 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 	return skb;
 }
 
+static bool ionic_run_xdp(struct ionic_rx_stats *stats,
+			  struct net_device *netdev,
+			  struct ionic_queue *rxq,
+			  struct ionic_buf_info *buf_info,
+			  int len)
+{
+	u32 xdp_action = XDP_ABORTED;
+	struct bpf_prog *xdp_prog;
+	struct xdp_buff xdp_buf;
+
+	xdp_prog = READ_ONCE(rxq->lif->xdp_prog);
+	if (!xdp_prog)
+		return false;
+
+	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
+	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
+			 0, len, false);
+
+	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
+				      0, len,
+				      DMA_FROM_DEVICE);
+
+	prefetchw(&xdp_buf.data_hard_start);
+
+	xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp_buf);
+
+	switch (xdp_action) {
+	case XDP_PASS:
+		stats->xdp_pass++;
+		return false;  /* false = we didn't consume the packet */
+
+	case XDP_DROP:
+		ionic_rx_page_free(rxq, buf_info);
+		stats->xdp_drop++;
+		break;
+
+	case XDP_REDIRECT:
+	case XDP_TX:
+	case XDP_ABORTED:
+	default:
+		trace_xdp_exception(netdev, xdp_prog, xdp_action);
+		ionic_rx_page_free(rxq, buf_info);
+		stats->xdp_aborted++;
+	}
+
+	return true;
+}
+
 static void ionic_rx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
 			   struct ionic_cq_info *cq_info,
@@ -297,6 +345,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	struct ionic_rx_stats *stats;
 	struct ionic_rxq_comp *comp;
 	struct sk_buff *skb;
+	u16 len;
 
 	comp = cq_info->cq_desc + qcq->cq.desc_size - sizeof(*comp);
 
@@ -307,10 +356,14 @@ static void ionic_rx_clean(struct ionic_queue *q,
 		return;
 	}
 
+	len = le16_to_cpu(comp->len);
 	stats->pkts++;
-	stats->bytes += le16_to_cpu(comp->len);
+	stats->bytes += len;
+
+	if (ionic_run_xdp(stats, netdev, q, desc_info->bufs, len))
+		return;
 
-	if (le16_to_cpu(comp->len) <= q->lif->rx_copybreak)
+	if (len <= q->lif->rx_copybreak)
 		skb = ionic_rx_copybreak(q, desc_info, comp);
 	else
 		skb = ionic_rx_frags(q, desc_info, comp);
@@ -380,7 +433,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 		}
 	}
 
-	if (le16_to_cpu(comp->len) <= q->lif->rx_copybreak)
+	if (len <= q->lif->rx_copybreak)
 		napi_gro_receive(&qcq->napi, skb);
 	else
 		napi_gro_frags(&qcq->napi);
-- 
2.17.1


