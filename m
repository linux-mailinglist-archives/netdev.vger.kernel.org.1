Return-Path: <netdev+bounces-56788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE0F810DB3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B53B20B63
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8E2111F;
	Wed, 13 Dec 2023 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kredaVNf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1191
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 01:51:05 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD3XRao012398;
	Wed, 13 Dec 2023 01:50:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=adxG4pKM
	1m6OcTW68rM2FDD+FQjcxFt95eiFA3IIgH0=; b=kredaVNfMoVl50xNo/ik6WF2
	8oNVcD0x/o/GGYw+5rartkppV7SqHBWxXBrJNIj731zrioCMlS4UJy9tf3J9WTxk
	CSZXsmkXMvPDUkFGHWXpu7vLO3Po2/XhSyS7HmpiQxT9aLjogr2Rm+rYdE7g2OIU
	3RQ0dcz4qgvE3uqvxv/Mklbvn0sJTqjgWZg47OYat5/c2yPFKByCBvVccVTvqiDC
	nJvEbXNpgZplzN9qnbb7fbHM5CQUrnwYKs+MLHq2ET8wIy1FkyMwseQ4OrksLp1A
	uUiM/QEi36U/dax4Z4+OVSNQykxxnd0EnfYqwQTBHwSStJWx+dYWeLDx+jPHYA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uy4tgh7t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 01:50:59 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 13 Dec
 2023 01:50:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 13 Dec 2023 01:50:57 -0800
Received: from EL-LT0043.marvell.com (unknown [10.193.38.189])
	by maili.marvell.com (Postfix) with ESMTP id C067F3F709F;
	Wed, 13 Dec 2023 01:50:56 -0800 (PST)
From: Igor Russkikh <irusskikh@marvell.com>
To: <netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>
Subject: [PATCH net-next] net: atlantic: eliminate double free in error handling logic
Date: Wed, 13 Dec 2023 10:50:44 +0100
Message-ID: <20231213095044.23146-1-irusskikh@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iymKadL6KPzrxbkkoEWm8iujWdvujPv0
X-Proofpoint-GUID: iymKadL6KPzrxbkkoEWm8iujWdvujPv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Driver has a logic leak in ring data allocation/free,
where aq_ring_free could be called multiple times on same ring,
if system is under stress and got memory allocation error.

Ring pointer was used as an indicator of failure, but this is
not correct since only ring data is allocated/deallocated.
Ring itself is an array member.

Changing ring allocation functions to return error code directly.
This simplifies error handling and eliminates aq_ring_free
on higher layer.

Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 28 +++------
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 61 +++++--------------
 .../net/ethernet/aquantia/atlantic/aq_ring.h  | 22 +++----
 .../net/ethernet/aquantia/atlantic/aq_vec.c   | 23 +++----
 4 files changed, 47 insertions(+), 87 deletions(-)

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
index 472c7c08bfed..ae239bb4c29b 100644
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


