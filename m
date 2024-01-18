Return-Path: <netdev+bounces-64277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB9831FB8
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20B12871DA
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2862E849;
	Thu, 18 Jan 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nN0RYHsk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4B2E647
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605932; cv=fail; b=i+etVVbm3XFZp8B7o8FYChYztHnuaBMj2acw5DiTlGCeUNx/zbB7CtloQpwctTqhTHheT2HvZ2J5Os0CN+LcHVGnlfK/U5kIyb2jwpjF99/8YHaHpw6RXQb0IBwEQN/dEUjHyolJsxV16bMcPFZC+7HC6FZWJ4a4y8TB+3YCsbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605932; c=relaxed/simple;
	bh=rTrVQVuSC1trimGoRGMFEaBdqZfASNVDVv4GokqH5lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1Nn3xrHd2kHQjVwLZqz89flMVmDd4XSIawIdVimokvnGvJDhyUEBCiU5orb92mxAcRy0d0O3Sm6UGn6AdhQNJu/NRHPDJUi9Hn/tmcLh0BEWvxRK14I3CO9bGMOSyrFGFVazxc1ctYwui4Kh1SLDIYKjbRbrWlmXfLYnJ82LDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nN0RYHsk; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naHltLWGre9aNw5JAogWJ4stASzK4Q+bDb3H54m9O2r+lSHhaGM0CJk+LsKcYE4Ne3IV7PNaivgWqxSJmmzaZLLbZCcKcj1jFDWVkzNd+bPRl3D2cPqspz+ru9PqaWdpofjOJ2jFX8myV9SgoTfgJ0TaoD3Iy+NHCMctYyIJnqwrc+qppOQB1qimgOjDIgKbrHFHXbRjjjhjORjy5N+MoTet5CcvB9jvouTz/lwMbw1/I8p490TrtNgiMpxCgutukN1ODLlmRpz1Q3ma9q6ZH7knz+nkHg98p/14/PjcgEuN/i0JtliYDrut52H8aiYQC+keWirqZll3jPBJVwPrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB7CWYYDAYBhZgUXqHPwf+6AaIYuCIi8OUqGMl1C40U=;
 b=JcV76LVp1Z4aU6Tds3iEXQbby4gXxr3MRi7JHzNVjsri4COajI/govuSIdtdoT4uJMBXH55XoJMD2C5GL9AuprUIIbmIDIYcwWWKfLTxHkItwWRadxntmMOj+1X/1oCCX0WZLuo3tx8QNM7V7lSyd6t10tRqB+FmCXhsAMt7PluYtdTeUnDXwAy7wpeJhXVm2XESuxCmRkl5/518zRw0kd0NKwdfcADP0IL4bQb6LvnnBxF7evfl4ywIdXXhHmxSPv06v8PlGNLH648Xah7gd2pgrqLcQmB0nRjnFJi716bskxZCC2crrpNrqVmn0pZc9InQj9a9xJpI0WW8q5kIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB7CWYYDAYBhZgUXqHPwf+6AaIYuCIi8OUqGMl1C40U=;
 b=nN0RYHsk8fOZGUdswxyFhQRU+IVhJVK+XWbIrNHzN/X0LA3pPlUfantKfCLoryuIPojJ6c4OKcmqT81l0zUOkH+5jbE5kaKSbcX40qDW2XfaNJb2sEOdxfMc3hh2KnVAKORKUrpEJpNgBg8+lD0npsN5XdjlU8EcARmOMQmgtXI=
Received: from DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7) by
 IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Thu, 18 Jan
 2024 19:25:28 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::ab) by DS7PR05CA0086.outlook.office365.com
 (2603:10b6:8:56::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:25:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:25:26 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH RFC net-next 9/9] ionic: implement xdp frags support
Date: Thu, 18 Jan 2024 11:25:00 -0800
Message-ID: <20240118192500.58665-10-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240118192500.58665-1-shannon.nelson@amd.com>
References: <20240118192500.58665-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: ae85ead3-9ade-40a3-48ef-08dc185b3a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wmp//zhCN++DUqBzcAiYAxrPAutmt9Qe5vTwR0/DVMtWJXqvaYtR+tLIwEtAtfvIDk9I8baUkPyY8fB1dIzjgeEJs+JwWUhzw+Ht/JkCmOEHMV/xxGIYehButWwwFQfjo96R/wMYuxxhLdDGioQPFyJNEHvJmDmGqE/Bbp6pPvp4SlqZGDDWxT1S8Lz7CzgzxCFrvd+IH9losGpl0Kpw1irvkefoU/oECWuh/GGQATzyl7kUml9GiSm7AdHWdOR6ipC4Lktzro/M0Vl6YdNccH4azLSpey1dpW1+5K1S2/c+9lqmuo8j82MM3wiiRqqEiaSWqOmyU6MuEQRgBTDz2dpEdsQ8c9NahoTMRpPWhAlDs2l+sOEHyFzLChUfl/41YLZI8pzHyKCstkHVQNNHiykGTIsAS3PU5A7DSpNAwaUCdsqfBCDpxN0hIGc5Zt6HMgG56djqzC6W8ExZBrOV7Ci3m6kVIlPJsityfqfE0V8qTYVQYGs5rcZANeUp3niypvMVdCeA6Aea9ScxX+8rT172faRo1s+vc2rZLdHhksfYfgq17+XhYlu8TfJRwsuVNA3tGr2Z1xNUPrpFjdv3cPAPmQAUf9rRAQCeo1khLdADm/NqCr1zFHoPr+EFCUDIu0vRYia5R+lQMXcwBGheDFFONAzr+f+dX31zWsho8/DW7dXBu4aznc9fpUychipOcnP4mVynXg04x+HJB9p2KfFIeYLM1zY0ALgSZiZreDN4WsNjXNM70lWxy4ZVtD7uAQsqlIOcCsQhYqoY8ucDNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(426003)(6666004)(1076003)(36860700001)(16526019)(336012)(2616005)(26005)(81166007)(5660300002)(83380400001)(47076005)(41300700001)(4326008)(2906002)(44832011)(70586007)(110136005)(70206006)(54906003)(8936002)(8676002)(478600001)(316002)(86362001)(36756003)(82740400003)(356005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:25:27.7499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae85ead3-9ade-40a3-48ef-08dc185b3a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

Add support for using scatter-gather / frags in XDP in both
Rx and Tx paths.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 12 ++-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 91 ++++++++++++++++++-
 2 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index ed5d792c4780..11adf3f55fd0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -881,7 +881,8 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	q->partner = &lif->txqcqs[q->index]->q;
 	q->partner->partner = q;
 
-	if (!lif->xdp_prog)
+	if (!lif->xdp_prog ||
+	    (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
 		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
 
 	if (qcq->flags & IONIC_QCQ_F_CMB_RINGS) {
@@ -1651,7 +1652,9 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC    |
 			       NETDEV_XDP_ACT_REDIRECT |
-			       NETDEV_XDP_ACT_NDO_XMIT;
+			       NETDEV_XDP_ACT_RX_SG    |
+			       NETDEV_XDP_ACT_NDO_XMIT |
+			       NETDEV_XDP_ACT_NDO_XMIT_SG;
 
 	return 0;
 }
@@ -1799,6 +1802,9 @@ static bool ionic_xdp_is_valid_mtu(struct ionic_lif *lif, u32 mtu,
 	if (mtu <= IONIC_XDP_MAX_LINEAR_MTU)
 		return true;
 
+	if (xdp_prog->aux && xdp_prog->aux->xdp_has_frags)
+		return true;
+
 	return false;
 }
 
@@ -2809,7 +2815,7 @@ static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
 	}
 
 	maxfs = __le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
-	if (bpf->prog)
+	if (bpf->prog && !(bpf->prog->aux && bpf->prog->aux->xdp_has_frags))
 		maxfs = min_t(u32, maxfs, IONIC_XDP_MAX_LINEAR_MTU);
 	netdev->max_mtu = maxfs;
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 618d15fb8d95..f80ee7a870fb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -15,6 +15,13 @@ static int ionic_maybe_stop_tx(struct ionic_queue *q, int ndescs);
 static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 				      void *data, size_t len);
 
+static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
+				    const skb_frag_t *frag,
+				    size_t offset, size_t len);
+
+static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
+				     struct ionic_desc_info *desc_info);
+
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
 			   struct ionic_cq_info *cq_info,
@@ -309,6 +316,7 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 	unsigned int nbufs = desc_info->nbufs;
 	struct ionic_buf_info *buf_info;
 	struct device *dev = q->dev;
+	int i;
 
 	if (!nbufs)
 		return;
@@ -320,6 +328,15 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 		__free_pages(buf_info->page, 0);
 	buf_info->page = NULL;
 
+	buf_info++;
+	for (i = 1; i < nbufs + 1 && buf_info->page; i++, buf_info++) {
+		dma_unmap_page(dev, buf_info->dma_addr,
+			       buf_info->len, DMA_TO_DEVICE);
+		if (desc_info->act == XDP_TX)
+			__free_pages(buf_info->page, 0);
+		buf_info->page = NULL;
+	}
+
 	if (desc_info->act == XDP_REDIRECT)
 		xdp_return_frame(desc_info->xdpf);
 
@@ -360,8 +377,38 @@ static int ionic_xdp_post_frame(struct net_device *netdev,
 	desc_info->xdpf = frame;
 	desc_info->act = act;
 
+	if (xdp_frame_has_frags(frame)) {
+		struct ionic_txq_sg_elem *elem;
+		struct skb_shared_info *sinfo;
+		struct ionic_buf_info *bi;
+		skb_frag_t *frag;
+		int i;
+
+		bi = &buf_info[1];
+		sinfo = xdp_get_shared_info_from_frame(frame);
+		frag = sinfo->frags;
+		elem = desc_info->txq_sg_desc->elems;
+		for (i = 0; i < sinfo->nr_frags; i++, frag++, bi++) {
+			dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
+			if (dma_mapping_error(q->dev, dma_addr)) {
+				stats->dma_map_err++;
+				ionic_tx_desc_unmap_bufs(q, desc_info);
+				return -EIO;
+			}
+			bi->dma_addr = dma_addr;
+			bi->len = skb_frag_size(frag);
+			bi->page = skb_frag_page(frag);
+
+			elem->addr = cpu_to_le64(bi->dma_addr);
+			elem->len = cpu_to_le16(bi->len);
+			elem++;
+
+			desc_info->nbufs++;
+		}
+	}
+
 	cmd = encode_txq_desc_cmd(IONIC_TXQ_DESC_OPCODE_CSUM_NONE,
-				  0, 0, buf_info->dma_addr);
+				  0, (desc_info->nbufs - 1), buf_info->dma_addr);
 	desc->cmd = cpu_to_le64(cmd);
 	desc->len = cpu_to_le16(len);
 	desc->csum_start = 0;
@@ -444,6 +491,8 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	struct ionic_queue *txq;
 	struct netdev_queue *nq;
 	struct xdp_frame *xdpf;
+	int remain_len;
+	int frag_len;
 	int err = 0;
 
 	xdp_prog = READ_ONCE(rxq->lif->xdp_prog);
@@ -451,8 +500,9 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		return false;
 
 	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
+	frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
 	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
-			 XDP_PACKET_HEADROOM, len, false);
+			 XDP_PACKET_HEADROOM, frag_len, false);
 
 	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
 				      XDP_PACKET_HEADROOM, len,
@@ -460,6 +510,43 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
 	prefetchw(&xdp_buf.data_hard_start);
 
+	/*  We limit MTU size to one buffer if !xdp_has_frags, so
+	 *  if the recv len is bigger than one buffer
+	 *     then we know we have frag info to gather
+	 */
+	remain_len = len - frag_len;
+	if (remain_len) {
+		struct skb_shared_info *sinfo;
+		struct ionic_buf_info *bi;
+		skb_frag_t *frag;
+
+		bi = buf_info;
+		sinfo = xdp_get_shared_info_from_buff(&xdp_buf);
+		sinfo->nr_frags = 0;
+		sinfo->xdp_frags_size = 0;
+		xdp_buff_set_frags_flag(&xdp_buf);
+
+		do {
+			if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS)) {
+				err = -ENOSPC;
+				goto out_xdp_abort;
+			}
+
+			frag = &sinfo->frags[sinfo->nr_frags];
+			sinfo->nr_frags++;
+			bi++;
+			frag_len = min_t(u16, remain_len, ionic_rx_buf_size(bi));
+			dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(bi),
+						      0, frag_len, DMA_FROM_DEVICE);
+			skb_frag_fill_page_desc(frag, bi->page, 0, frag_len);
+			sinfo->xdp_frags_size += frag_len;
+			remain_len -= frag_len;
+
+			if (page_is_pfmemalloc(bi->page))
+				xdp_buff_set_frag_pfmemalloc(&xdp_buf);
+		} while (remain_len > 0);
+	}
+
 	xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp_buf);
 
 	switch (xdp_action) {
-- 
2.17.1


