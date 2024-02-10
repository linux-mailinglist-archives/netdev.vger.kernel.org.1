Return-Path: <netdev+bounces-70713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D937D850155
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6916B1F2A4F1
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663931FB3;
	Sat, 10 Feb 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kj7cfbQ6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6EB65A
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526138; cv=fail; b=VbfTReR8zDpd+XmSAq7lnUXOOIcCp3y8fef2O4JGjTPGbiqxt4QuJkloOkXfxIqiadFd8JCjgyE30Atvkn+LHDubZZVXGEMuME+1+AXkXt+u3A8q+BxPD7WB/+/pjMslWF/3Ou2FcrL/+tM8QLlslDAfeO3mRv4/BqiaxJcybUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526138; c=relaxed/simple;
	bh=ZhWmebH0uK3ZOjex4Gga9B2JAoC7b8xhPsdU4Ou5XnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epCQO+q+5vDPb/0+zzKLwv3U57eFKPFOW4fSgjW3fqpwg+RB7pBHLw4FgidlT6bm8BegKR8kh5rMn8FPlenh6pfZsBuJLrfHmsc8o33g83vyCvotkXwSTzCqGU41m/nr8lIdz+IIn0FJV5+iZxILLFuZGucsaFxVYNf0553gf30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kj7cfbQ6; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv77C4MzUNtcIMuDz2OhDmQuCNbA9FzGQr9bjwPSyYyUM51xfuKYbmRKSGRjVoTNeQQzvOhFSIOuq1I5+eRJhanjm4da1jk9aYFa52G0eLMo9yjoe4eAzA0K7/7OolZ1o96jaXl5ylGq/nT35oLf3qy2mm7/e0wLhQsIfUJDPVlh2x9Ydq7P2CHUSqcicm36h8BsG/gFhVw5NivfXkQWl6PE5QHLXjMV2tYAd/Sd+JW24fOiQzVLmaD83dYWGTLdkriOi8WHD6/FFAkIxU+okU2zAx9Noe3MrEnyFs4y28weEYG7W0k+w7tCtn166bFuVDWabnos80OIX9b7okmGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgOKDD32sGLhlzaeri3Mk6E4O3l3CxKCfO7scHfkIco=;
 b=Bge4M7uE9AXlCpJcP6zNv1zwEe1f68xMmJoe80tQJiGb/itGl52IK8JlAJBMwpg3a/I5mscOWmdwHmVgNDxSQliifZ8Rrkyuw6wE253tpzETOltt1X91fUfvRjk4kRx4DevjDvZQDlnsw3qsXPaGJsMZFlgpYriIieuWvt/WJSfFsfNfLVFZB39FBs0dnUpfdc1SHJnIZdxXJgaW+H8Dqqf65OXF1jiPNdTSILZfQuY/3d+Gcd/LP47NMPPMH4SXnO78Fz59PAnle+UbUnt6gSPGvLdwSHuwWUrxzz4jZBfaUVGdoJTcjG4+LbjRpf29Rub/A+l6xh1zTvtwnrwwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgOKDD32sGLhlzaeri3Mk6E4O3l3CxKCfO7scHfkIco=;
 b=Kj7cfbQ6HZKeEqNcgl6ER/euyrnCA+uh3909JR0nrUhzyeGvTh0KWfU4Zg+RJlFkL9ifNf5iq6wTqYUFE6n7df3w6kkjBCefXsAIbNQVpDux7ik2onxujIS7lgXsA+iABGylNg1aaTJwrnbJR4ahLHWNLWJWNQOPXbf+TK+Q/GU=
Received: from CYXPR02CA0079.namprd02.prod.outlook.com (2603:10b6:930:ce::27)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Sat, 10 Feb
 2024 00:48:51 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::9b) by CYXPR02CA0079.outlook.office365.com
 (2603:10b6:930:ce::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 00:48:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:49 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 9/9] ionic: implement xdp frags support
Date: Fri, 9 Feb 2024 16:48:27 -0800
Message-ID: <20240210004827.53814-10-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240210004827.53814-1-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bedc48-c4cc-4952-59be-08dc29d20c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ct8UnacybH8Wt4B9HNIPAyTXr7Mu/O2dUpW08yBci5G62/gSj7tx4M39dnB9m0app3IW7VsIMh11WCyyJki73lT248VexJk/Po1gG+m4BJjXp3PLYRKE907ZY3bHeMUfwg6JG1/Qzzhi2Wam0YivFE6gvI7OR1vlJ8yamcBRRV8Lp+h20ZbF89IE2NkS4K9wD5mWCh8WDznGfnALJilRfpc35r70VxlZM4aXq8hpyNQt2GdZmdsNV2EQgCnJCqcC2mWsL8GPn7ZRrDsw+YpCGWYnd7K15XhmZScEUr6lEdRxJmwg21ibrP67QOoKMYlSAhP2OP+0r6v2NtpFdfoPKsO9SjmHENda7W+1/Dk0QqHr4fo+rSnr2ERYUaBqbCHDCiGz7Tkf85Q7l+wUrdobTF24k5klIwSfo28wbyLW/fBFI7MLKOtA6S83tnSGQQodGieSmqUzDwnHgyVdJmLUPwaRhzm57fV8ggSw27v8h5R6y6jpFSc2YuPnol0miEDj0IZRdd//VZgtOx/bxAZ25qc/nzayiV4vnIpxo0zJDgibbeowsdZmOXmfdN8dWlH7O5rHJo9ePny4Xqr5/LBwcSBzEpMITLv4Bqbn9pKGU1s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(356005)(81166007)(2616005)(41300700001)(36756003)(1076003)(16526019)(82740400003)(336012)(86362001)(83380400001)(478600001)(426003)(26005)(6666004)(44832011)(4326008)(70206006)(8676002)(8936002)(110136005)(2906002)(54906003)(5660300002)(316002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:50.8217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bedc48-c4cc-4952-59be-08dc29d20c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692

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
index 45644f6428b6..4d05d583c854 100644
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
@@ -445,6 +492,8 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	struct ionic_queue *txq;
 	struct netdev_queue *nq;
 	struct xdp_frame *xdpf;
+	int remain_len;
+	int frag_len;
 	int err = 0;
 
 	xdp_prog = READ_ONCE(rxq->lif->xdp_prog);
@@ -452,8 +501,9 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		return false;
 
 	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
+	frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
 	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
-			 XDP_PACKET_HEADROOM, len, false);
+			 XDP_PACKET_HEADROOM, frag_len, false);
 
 	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
 				      XDP_PACKET_HEADROOM, len,
@@ -461,6 +511,43 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
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


