Return-Path: <netdev+bounces-53537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E88803A12
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BDC1C20B76
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864682DF83;
	Mon,  4 Dec 2023 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TV/EAJxp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85AB95
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:21:07 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4FxjKu012526;
	Mon, 4 Dec 2023 08:20:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=R5uHVhEMIGpZeVzU5cX0jfDjkwqHeCAPKL0dFi2NzNg=;
 b=TV/EAJxpBKNKdOQ6xYLWQu+j7NLj/6tBzjHD8onMTkVWpp1fV9yZF1gfoEY6ETyQ1Hi5
 bBcvoF6JjWvVuXMkCFqW1wHY9SYMmNCkrTGcrfLhniCcGJrxjaUCUpHEgOcwNT+w+//W
 aImRNr89qeoYNkWT/hmZHyqGAFofW8ewpD9lKu5AjDsxW6hKxdtttgtizCpY5xZjf0HK
 PFH6FjteVnP5Yf2+D+Yi/m43WbBbGWObaB1igynkubcKFsL4e9FMeSohknVIEF0H5jui
 v+1q6bYjg4wIKqHx9D5PlVJtqqE6n3Oa7qn+Fr4jlcF5pZcJ1nUW2UEmLeCGtXw1LcTk fw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ur4yrnqt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 08:20:56 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Dec
 2023 08:20:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 4 Dec 2023 08:20:54 -0800
Received: from EL-LT0043.marvell.com (OBi302.marvell.com [10.9.8.90])
	by maili.marvell.com (Postfix) with ESMTP id 202713F705A;
	Mon,  4 Dec 2023 08:20:52 -0800 (PST)
From: Igor Russkikh <irusskikh@marvell.com>
To: <netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: [PATCH] net: atlantic: fixed double free when constrained memory conditions
Date: Mon, 4 Dec 2023 17:20:40 +0100
Message-ID: <20231204162040.923-1-irusskikh@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cm8FCCCPjA1xvS59_QojxV-MLQjbVTdX
X-Proofpoint-ORIG-GUID: cm8FCCCPjA1xvS59_QojxV-MLQjbVTdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_15,2023-12-04_01,2023-05-22_02

Driver has a logic leak in ring data allocation/free,
where double free may happen in aq_ring_free if system is under
stress and driver init/deinit is happening.

The probability is higher to get this during suspend/resume cycle.

Verification was done simulating same conditions with

    stress -m 2000 --vm-bytes 20M --vm-hang 10 --backoff 1000
    while true; do sudo ifconfig enp1s0 down; sudo ifconfig enp1s0 up; done

Fixed by explicitly clearing pointers to NULL, also eliminate two
levels of aq_ring_free invocation.

Fixes: 018423e90bee ("net: ethernet: aquantia: Add ring support code")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/netdev/CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com/
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 28 +++-----
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 66 ++++++-------------
 .../net/ethernet/aquantia/atlantic/aq_ring.h  | 22 +++----
 .../net/ethernet/aquantia/atlantic/aq_vec.c   | 23 +++----
 4 files changed, 51 insertions(+), 88 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 80b44043e6c5..7157fffd1cc3 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -953,8 +953,6 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 {
 	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
 	unsigned int tx_ring_idx, rx_ring_idx;
-	struct aq_ring_s *hwts;
-	struct aq_ring_s *ring;
 	int err;
 
 	if (!aq_ptp)
@@ -962,29 +960,23 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 
 	tx_ring_idx = aq_ptp_ring_idx(aq_nic->aq_nic_cfg.tc_mode);
 
-	ring = aq_ring_tx_alloc(&aq_ptp->ptp_tx, aq_nic,
-				tx_ring_idx, &aq_nic->aq_nic_cfg);
-	if (!ring) {
-		err = -ENOMEM;
+	err = aq_ring_tx_alloc(&aq_ptp->ptp_tx, aq_nic,
+			       tx_ring_idx, &aq_nic->aq_nic_cfg);
+	if (err)
 		goto err_exit;
-	}
 
 	rx_ring_idx = aq_ptp_ring_idx(aq_nic->aq_nic_cfg.tc_mode);
 
-	ring = aq_ring_rx_alloc(&aq_ptp->ptp_rx, aq_nic,
-				rx_ring_idx, &aq_nic->aq_nic_cfg);
-	if (!ring) {
-		err = -ENOMEM;
+	err = aq_ring_rx_alloc(&aq_ptp->ptp_rx, aq_nic,
+			       rx_ring_idx, &aq_nic->aq_nic_cfg);
+	if (err)
 		goto err_exit_ptp_tx;
-	}
 
-	hwts = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
-				     aq_nic->aq_nic_cfg.rxds,
-				     aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
-	if (!hwts) {
-		err = -ENOMEM;
+	err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
+				    aq_nic->aq_nic_cfg.rxds,
+				    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
+	if (err)
 		goto err_exit_ptp_rx;
-	}
 
 	err = aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cfg.rxds);
 	if (err != 0) {
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 4de22eed099a..ae239bb4c29b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -132,8 +132,8 @@ static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s *rxbuf)
 	return 0;
 }
 
-static struct aq_ring_s *aq_ring_alloc(struct aq_ring_s *self,
-				       struct aq_nic_s *aq_nic)
+static int aq_ring_alloc(struct aq_ring_s *self,
+			 struct aq_nic_s *aq_nic)
 {
 	int err = 0;
 
@@ -156,46 +156,29 @@ static struct aq_ring_s *aq_ring_alloc(struct aq_ring_s *self,
 err_exit:
 	if (err < 0) {
 		aq_ring_free(self);
-		self = NULL;
 	}
 
-	return self;
+	return err;
 }
 
-struct aq_ring_s *aq_ring_tx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg)
+int aq_ring_tx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg)
 {
-	int err = 0;
-
 	self->aq_nic = aq_nic;
 	self->idx = idx;
 	self->size = aq_nic_cfg->txds;
 	self->dx_size = aq_nic_cfg->aq_hw_caps->txd_size;
 
-	self = aq_ring_alloc(self, aq_nic);
-	if (!self) {
-		err = -ENOMEM;
-		goto err_exit;
-	}
-
-err_exit:
-	if (err < 0) {
-		aq_ring_free(self);
-		self = NULL;
-	}
-
-	return self;
+	return aq_ring_alloc(self, aq_nic);
 }
 
-struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg)
+int aq_ring_rx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg)
 {
-	int err = 0;
-
 	self->aq_nic = aq_nic;
 	self->idx = idx;
 	self->size = aq_nic_cfg->rxds;
@@ -217,22 +200,10 @@ struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
 		self->tail_size = 0;
 	}
 
-	self = aq_ring_alloc(self, aq_nic);
-	if (!self) {
-		err = -ENOMEM;
-		goto err_exit;
-	}
-
-err_exit:
-	if (err < 0) {
-		aq_ring_free(self);
-		self = NULL;
-	}
-
-	return self;
+	return aq_ring_alloc(self, aq_nic);
 }
 
-struct aq_ring_s *
+int
 aq_ring_hwts_rx_alloc(struct aq_ring_s *self, struct aq_nic_s *aq_nic,
 		      unsigned int idx, unsigned int size, unsigned int dx_size)
 {
@@ -250,10 +221,10 @@ aq_ring_hwts_rx_alloc(struct aq_ring_s *self, struct aq_nic_s *aq_nic,
 					   GFP_KERNEL);
 	if (!self->dx_ring) {
 		aq_ring_free(self);
-		return NULL;
+		return -ENOMEM;
 	}
 
-	return self;
+	return 0;
 }
 
 int aq_ring_init(struct aq_ring_s *self, const enum atl_ring_type ring_type)
@@ -932,11 +903,14 @@ void aq_ring_free(struct aq_ring_s *self)
 		return;
 
 	kfree(self->buff_ring);
+	self->buff_ring = NULL;
 
-	if (self->dx_ring)
+	if (self->dx_ring) {
 		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
 				  self->size * self->dx_size, self->dx_ring,
 				  self->dx_ring_pa);
+		self->dx_ring = NULL;
+	}
 }
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 0a6c34438c1d..52847310740a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -183,14 +183,14 @@ static inline unsigned int aq_ring_avail_dx(struct aq_ring_s *self)
 		self->sw_head - self->sw_tail - 1);
 }
 
-struct aq_ring_s *aq_ring_tx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg);
-struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg);
+int aq_ring_tx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg);
+int aq_ring_rx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg);
 
 int aq_ring_init(struct aq_ring_s *self, const enum atl_ring_type ring_type);
 void aq_ring_rx_deinit(struct aq_ring_s *self);
@@ -207,9 +207,9 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 		     int budget);
 int aq_ring_rx_fill(struct aq_ring_s *self);
 
-struct aq_ring_s *aq_ring_hwts_rx_alloc(struct aq_ring_s *self,
-		struct aq_nic_s *aq_nic, unsigned int idx,
-		unsigned int size, unsigned int dx_size);
+int aq_ring_hwts_rx_alloc(struct aq_ring_s *self,
+			  struct aq_nic_s *aq_nic, unsigned int idx,
+			  unsigned int size, unsigned int dx_size);
 void aq_ring_hwts_rx_clean(struct aq_ring_s *self, struct aq_nic_s *aq_nic);
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index f5db1c44e9b9..9769ab4f9bef 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -136,35 +136,32 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct aq_nic_s *aq_nic,
 		const unsigned int idx_ring = AQ_NIC_CFG_TCVEC2RING(aq_nic_cfg,
 								    i, idx);
 
-		ring = aq_ring_tx_alloc(&self->ring[i][AQ_VEC_TX_ID], aq_nic,
-					idx_ring, aq_nic_cfg);
-		if (!ring) {
-			err = -ENOMEM;
+		ring = &self->ring[i][AQ_VEC_TX_ID];
+		err = aq_ring_tx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
+		if (err)
 			goto err_exit;
-		}
 
 		++self->tx_rings;
 
 		aq_nic_set_tx_ring(aq_nic, idx_ring, ring);
 
-		if (xdp_rxq_info_reg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq,
+		ring = &self->ring[i][AQ_VEC_RX_ID];
+		if (xdp_rxq_info_reg(&ring->xdp_rxq,
 				     aq_nic->ndev, idx,
 				     self->napi.napi_id) < 0) {
 			err = -ENOMEM;
 			goto err_exit;
 		}
-		if (xdp_rxq_info_reg_mem_model(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq,
+		if (xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 					       MEM_TYPE_PAGE_SHARED, NULL) < 0) {
-			xdp_rxq_info_unreg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq);
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 			err = -ENOMEM;
 			goto err_exit;
 		}
 
-		ring = aq_ring_rx_alloc(&self->ring[i][AQ_VEC_RX_ID], aq_nic,
-					idx_ring, aq_nic_cfg);
-		if (!ring) {
-			xdp_rxq_info_unreg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq);
-			err = -ENOMEM;
+		err = aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
+		if (err) {
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 			goto err_exit;
 		}
 
-- 
2.25.1


