Return-Path: <netdev+bounces-66930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEEB84184D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3BD1F22031
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AEA364B5;
	Tue, 30 Jan 2024 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5iiNLDAS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B807360AE
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578271; cv=fail; b=m08cwagXk+m+UBSdEjPpwN7hD9oTIKHQevXEM7/RpXOVyKcoUH1XUm/63sZC4NFJh5wujkqqY6KmKkZqxY83Kmuh1xhTL5EuvnHA53U+PLkFOlOwEzxGy21lNhPzz2O1HCoEZ6F+aQtKvL4MhUi7/G1UefGeiDoQKsTH6YKFFyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578271; c=relaxed/simple;
	bh=3h7Fzp2CbrW8gV9ndfPj0L1lcuUSGIvTQB0kerbUmLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bcb3XYjGRiHLEsTXYB8G+8t5uj8oMROEBo3jEz265Kuz25/qs6qYX4elrcxHOzfREoMAnoXHeIMOTTsnMIboJZr27sMrXHeJ6Y2D9TX9Worjc+NKSquzY5/hBdaeWbZvY9Z+V8mjneLs8ndr4NIbnHaOCYqHEkbbkqHVhCCP418=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5iiNLDAS; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrwnLUMsBvjF4JX2OdGkL2FJvOt+E+FoU0k52qh6tOHbc+r0OqsBHL+0F4xBnZXgjJVWeVsRRE3HVi624fHieJ9RgCcGIUetPMgQ4yNbpyHdifb8x4UstROFEL995AguQ8rct/FjhxW1c7XMkdJ9JcVW0RmAnUFf6UUqiW1PO+Dh3h1fcclO1i3QcPKfnD0TANWJyIPL59ZUGB1/GSGE4ng2U6DiXBdtAQl9D3o7P6ub1p3K1BblQEVNvHJ8zGf5UvgFm6mFAXrVzBDZEAhIbaCp1Pm0qInTHXP9JNtT9aug9OyGFPtpaXRfy++nynCnefZGoL+hKgYVPsP/GfSByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbLukNUnI9D4esRWJh3zPT6wqq0cnNU3Lb8JTB3HYDc=;
 b=X255eQhnHzrV7uEFAk+UJeeAojjeiIAZbea41IeJ8QNQLF69E7YjnzTfT798ygnoQuSHZvGRha22MlQ9Z9hazumjgTZwjSAbQhjpnoamPzxEm0z8HhrXCe2/I+Co/tBkS7MKXoBtSnma+Ypffa3FOk57UwXyjyE4VS7ltTxlClQNE8KaJSeaGNGks8Oggfna3m3lLanceMGmqB/INKCU2E8Mo1dwQf214Hc2ypphWymbSiiB5e+gZxe92kGUV9No91uPTpKBJ0wGibGwyN+wYCgSKZ+kjcuccayMk8ky/zI2W5Qb4Dyj9nzxzeciaF8wUuWWm8l6vGsdi2jqiLqN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbLukNUnI9D4esRWJh3zPT6wqq0cnNU3Lb8JTB3HYDc=;
 b=5iiNLDASAUvn+r+Cn1bYXCvRUOj2b2kQuQYKdxvvc7eGJ55cn6pe5bw44KIYC3tQ2hIB+w/blkWgjVd4hKocsKV6WcWbwlpG/iR37vvqRufyZDzO0HWV+GcCtuWZ45KPIgQbXdtYkTbjAf17YNymOt0Hnx/E95GrJ1zc6ulBEW8=
Received: from MN2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:208:23e::23)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 01:31:06 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::f6) by MN2PR14CA0018.outlook.office365.com
 (2603:10b6:208:23e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:06 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:04 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 4/9] ionic: add initial framework for XDP support
Date: Mon, 29 Jan 2024 17:30:37 -0800
Message-ID: <20240130013042.11586-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130013042.11586-1-shannon.nelson@amd.com>
References: <20240130013042.11586-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: f6612d50-f9ca-4bdc-c63c-08dc2133210f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0qy9Iz6QBpVDqQbGDA/eLEk5rWAAfVr1O20/WJjWtxyXGrIXE0oheEs/ai5ixb/MbHJpukV1uHGj0NxtwowLuBboxDGZHRopzB2HdS1HPVvpn7faduL/n0T7itH4QvalM/q8JxZb5L36RQ2CChmJgu5NLSS9/QLBCV1DnUFGaN8U+ZUhrQ1ZvFpONkvrKn3Wk4iLjBvIAzzvggJRja3GUgb1q8iN/b1vUxZyZeR4bo9CoQRtMZhQ8Q4M6VnxRH/zFXtE9afVqOwpiqCmWobzXsebei8byZBsDb/hGAnHZ33RKKAcv5V2kXZimp2faYiViboV4cgjPkyaI03ZqkYV6TdPEGSxhJJ+GTYJ5sBVh0DSxMzBNsNvMCaokaVrup6MA2qz4iSEZX4/+ZgqwxScXvBAmaIZyklNQUjKMA2C+IRNJBDQIBC/jtGiTLs8RmS5giyNznKYYNfIrWLPrNzrITfynU0bD9BeMjJmlE3b9BDHfyPEiAuMHy3AHNQycjSRsizeJmtwGEqJER3a/ICgKlzvQSq8Exr8X1Kj9OBVToTagKfQGrBKPuS2s41jRHKKYw+J8ApVWKoWQJmHD0dlB2bK13wg3EBp/SE9bd8udpJZOQ5Wwe+avkDxMb4ibKMvcqoQeGD2WnuB1k/OaaTZnVGxBiHDLV1SnAl9k6Op0UI96GRHAtUya6xtAs3IkPCwzM8ZaFTfs5I/ADSIhU1T2Fr1x7pYRM6w9ZuWjTq3+Zm4ZM/L/yFad3VIuBfcnR1UPiv0SIQxaq2xUEO26bBkJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(36860700001)(36756003)(83380400001)(2616005)(47076005)(316002)(70586007)(8936002)(110136005)(70206006)(8676002)(54906003)(86362001)(478600001)(4326008)(26005)(16526019)(2906002)(1076003)(6666004)(30864003)(5660300002)(426003)(44832011)(336012)(41300700001)(356005)(40460700003)(40480700001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:06.1029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6612d50-f9ca-4bdc-c63c-08dc2133210f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

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
index aee38979a9d7..07a17be94d4d 100644
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


