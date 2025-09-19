Return-Path: <netdev+bounces-224815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE32B8ACF9
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED13F588A3D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F3323F69;
	Fri, 19 Sep 2025 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HcjyfNpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA783233F2
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304117; cv=none; b=kIHPvLskXTW0bv+r1MR8FWzcxlE3dmEXgIbxCpUuDhwE37Neu7Cd7ytggjbbeYVRFDfni+VL10FmOuWCVNVTSOyCMKfR8NiwUsQLflGz2oSezrdnCr14rimJGERNOXMNmbhwES3zDbuwU0RaEv67nYDCmVWnJfU9DjWM6v4WlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304117; c=relaxed/simple;
	bh=lnfezG8VyIGZ/WTj0Vt5pgVwkJXMU2oog07QRNCkswM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5JYJLuppsLm05Jiseh2Zd9Vg6eHbw0U1mOBIDHFfE4rd2240uYAbD8p5Er/gCfFLqJH+VQaZkJ9t1NRTy80qoaDbx/U7LJdWs684ZTVaAZZ4IkjOTLdXbxrZ4mT5u2c3XncGWj0mITD4gd5FRJ0affghbBMngRdu8aKdFcwMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HcjyfNpF; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-7960d69f14bso11727506d6.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304114; x=1758908914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnJXUu4JK2DcGo43AyLTZEWYsUCAvh8a5G8goJOjFss=;
        b=NjjII1K5Pk3o+KOOH1NaJkPhSs9Y97C7QWG9toVp+NfrlX+XwU8EVDNocuQyJcK21L
         a5uCLSHLCDo0jUwicVnaC+8SD5DWkBwPTocMJ5u+63MVUuk/ZEjeF2inLc6+kYdiAXl4
         4zI6NXFicrCrSX1HC0GAOgWts9G7TvbY17HwsA7fNdU1ObiZQg9wJyWizaDfXIeM/bMk
         KpTnfVbGQHWK15yF92MhLLO9Xz3q/p5R+yU1KbpSphyRM8vGQ27CBycI8lFaphqDx+TC
         v/5V6XcdF9PnEIq6cN8kS/KCc65HpQI+PR+l9tsfrRMrEMJiQkS7iXM91Dk9mtnzPVpl
         Eqzw==
X-Gm-Message-State: AOJu0Yy48M725AG4GnZGUGfZ0dV5Of7fLnRvABSxWmmbPNdaIP0RjlM6
	B1c26xm+hQAy7KQ9pq9YqdXETpYaG+RuF1q+r7tTNBo6QlMPPU+DB+5nZsKTODL78rnOzbWeqOL
	fE19hi+4fm2uzMiqcOGt31uGfJmOv32sGKP6N53KsE+dP+bPw7UtqO3DA60MrtTOoOvqXuaectR
	mwemaTQlVN+wrtBTUc/XTqznWzebUgERVz79frCznsWb/QqBYFLZoqb+CC0Gd0JLvPgeGDnvHr1
	9zeUHjp1yITfKR0nQQL
X-Gm-Gg: ASbGncttlBpehmfyzhfj9IBZzzB4l95dHfKkqqrzAAqHcEgmq/2Og1Spo72K3zalvim
	aQKhVdHksbAd5v7CQPWq5apNH/oulyDJ2/CDh/+UF9gafW6j5cQTi1DiQnjqy0+W0dwL9VqnJf2
	enImFgi70S6XgEb+L/HhvOJWG2YWr5UK30nselh5rb0VwtDttq1UN+iVnHIiYRnJELXActB8AEV
	Mfs2wpuUbYTGHQqOKTzLn+tf/OKZyUb1FfQCYmdff1ChTwc5QpquLpX6563gwU64tjcA5mdBW20
	ihipW5AtkO3xPvGAbVpvAIsvkBSgaCaQdqhpqxgXAHfql5QoNHgmssnIpD0b+4fdEjVcBJZcfTS
	5LSDdAgYesPjPBNQPcDOO6vo5zmF2Lwd1kkcXBvrMCSivji0YJtvEkGCJoHJSkz01WaaXUfkRnZ
	H+HpP+hjKx
X-Google-Smtp-Source: AGHT+IFE3U20kmYcEWT5WSeZVAbyswAH5JXg1MSenpyJQ2BCuDW8FduHaSgUUicdKebHRdwuoQuo3ajJ3og/
X-Received: by 2002:a05:6214:d66:b0:71c:53c0:5674 with SMTP id 6a1803df08f44-79911fe7f93mr56029526d6.7.1758304114363;
        Fri, 19 Sep 2025 10:48:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79343ef2d8dsm3434826d6.2.2025.09.19.10.48.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7761dc1b36dso4516457b3a.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304113; x=1758908913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnJXUu4JK2DcGo43AyLTZEWYsUCAvh8a5G8goJOjFss=;
        b=HcjyfNpFOJRDBL611j8fUXAb3lEC778OFJXHQlSXEQBcK6YGkOXdkGR6Sg0UmDOFwC
         EvQm8/kFrEd5Yd9se5oLLUQ6gXhEd+v7BC8ekepLVlzxO/0MeYiug73Ic/yNBMbjrMAO
         tEHwL3TOHpVoZROx4jAIOL5BAEmzJk4eIjty0=
X-Received: by 2002:a05:6a20:918f:b0:245:fb85:ef69 with SMTP id adf61e73a8af0-2927154c935mr6911034637.40.1758304113004;
        Fri, 19 Sep 2025 10:48:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:918f:b0:245:fb85:ef69 with SMTP id adf61e73a8af0-2927154c935mr6911004637.40.1758304112510;
        Fri, 19 Sep 2025 10:48:32 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:32 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v8, net-next 05/10] bng_en: Initialise core resources
Date: Fri, 19 Sep 2025 23:17:36 +0530
Message-ID: <20250919174742.24969-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add initial settings to all core resources, such as
the RX, AGG, TX, CQ, and NQ rings, as well as the VNIC.
This will help enable these resources in future patches.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 210 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  50 +++++
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   1 +
 3 files changed, 261 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index df05e6ea271..c3418b3fe05 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -547,6 +547,33 @@ static void bnge_free_vnics(struct bnge_net *bn)
 	bn->nr_vnics = 0;
 }
 
+static void bnge_free_ring_grps(struct bnge_net *bn)
+{
+	kfree(bn->grp_info);
+	bn->grp_info = NULL;
+}
+
+static int bnge_init_ring_grps(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	bn->grp_info = kcalloc(bd->nq_nr_rings,
+			       sizeof(struct bnge_ring_grp_info),
+			       GFP_KERNEL);
+	if (!bn->grp_info)
+		return -ENOMEM;
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		bn->grp_info[i].fw_stats_ctx = INVALID_HW_RING_ID;
+		bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;
+		bn->grp_info[i].rx_fw_ring_id = INVALID_HW_RING_ID;
+		bn->grp_info[i].agg_fw_ring_id = INVALID_HW_RING_ID;
+		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
+	}
+
+	return 0;
+}
+
 static void bnge_free_core(struct bnge_net *bn)
 {
 	bnge_free_vnic_attributes(bn);
@@ -554,6 +581,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
@@ -692,6 +720,167 @@ static irqreturn_t bnge_msix(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static void bnge_init_nq_tree(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
+		struct bnge_ring_struct *ring = &nqr->ring_struct;
+
+		ring->fw_ring_id = INVALID_HW_RING_ID;
+		for (j = 0; j < nqr->cp_ring_count; j++) {
+			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
+
+			ring = &cpr->ring_struct;
+			ring->fw_ring_id = INVALID_HW_RING_ID;
+		}
+	}
+}
+
+static void bnge_init_rxbd_pages(struct bnge_ring_struct *ring, u32 type)
+{
+	struct rx_bd **rx_desc_ring;
+	u32 prod;
+	int i;
+
+	rx_desc_ring = (struct rx_bd **)ring->ring_mem.pg_arr;
+	for (i = 0, prod = 0; i < ring->ring_mem.nr_pages; i++) {
+		struct rx_bd *rxbd = rx_desc_ring[i];
+		int j;
+
+		for (j = 0; j < RX_DESC_CNT; j++, rxbd++, prod++) {
+			rxbd->rx_bd_len_flags_type = cpu_to_le32(type);
+			rxbd->rx_bd_opaque = prod;
+		}
+	}
+}
+
+static void bnge_init_one_rx_ring_rxbd(struct bnge_net *bn,
+				       struct bnge_rx_ring_info *rxr)
+{
+	struct bnge_ring_struct *ring;
+	u32 type;
+
+	type = (bn->rx_buf_use_size << RX_BD_LEN_SHIFT) |
+		RX_BD_TYPE_RX_PACKET_BD | RX_BD_FLAGS_EOP;
+
+	if (NET_IP_ALIGN == 2)
+		type |= RX_BD_FLAGS_SOP;
+
+	ring = &rxr->rx_ring_struct;
+	bnge_init_rxbd_pages(ring, type);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_init_one_agg_ring_rxbd(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	struct bnge_ring_struct *ring;
+	u32 type;
+
+	ring = &rxr->rx_agg_ring_struct;
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	if (bnge_is_agg_reqd(bn->bd)) {
+		type = ((u32)BNGE_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
+			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
+
+		bnge_init_rxbd_pages(ring, type);
+	}
+}
+
+static void bnge_init_one_rx_ring_pair(struct bnge_net *bn, int ring_nr)
+{
+	struct bnge_rx_ring_info *rxr;
+
+	rxr = &bn->rx_ring[ring_nr];
+	bnge_init_one_rx_ring_rxbd(bn, rxr);
+
+	netif_queue_set_napi(bn->netdev, ring_nr, NETDEV_QUEUE_TYPE_RX,
+			     &rxr->bnapi->napi);
+
+	bnge_init_one_agg_ring_rxbd(bn, rxr);
+}
+
+static void bnge_init_rx_rings(struct bnge_net *bn)
+{
+	int i;
+
+#define BNGE_RX_OFFSET (NET_SKB_PAD + NET_IP_ALIGN)
+#define BNGE_RX_DMA_OFFSET NET_SKB_PAD
+	bn->rx_offset = BNGE_RX_OFFSET;
+	bn->rx_dma_offset = BNGE_RX_DMA_OFFSET;
+
+	for (i = 0; i < bn->bd->rx_nr_rings; i++)
+		bnge_init_one_rx_ring_pair(bn, i);
+}
+
+static void bnge_init_tx_rings(struct bnge_net *bn)
+{
+	int i;
+
+	bn->tx_wake_thresh = max(bn->tx_ring_size / 2, BNGE_MIN_TX_DESC_CNT);
+
+	for (i = 0; i < bn->bd->tx_nr_rings; i++) {
+		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
+		struct bnge_ring_struct *ring = &txr->tx_ring_struct;
+
+		ring->fw_ring_id = INVALID_HW_RING_ID;
+
+		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX,
+				     &txr->bnapi->napi);
+	}
+}
+
+static void bnge_init_vnics(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic0 = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	int i;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		struct bnge_vnic_info *vnic = &bn->vnic_info[i];
+		int j;
+
+		vnic->fw_vnic_id = INVALID_HW_RING_ID;
+		vnic->vnic_id = i;
+		for (j = 0; j < BNGE_MAX_CTX_PER_VNIC; j++)
+			vnic->fw_rss_cos_lb_ctx[j] = INVALID_HW_RING_ID;
+
+		if (bn->vnic_info[i].rss_hash_key) {
+			if (i == BNGE_VNIC_DEFAULT) {
+				u8 *key = (void *)vnic->rss_hash_key;
+				int k;
+
+				if (!bn->rss_hash_key_valid &&
+				    !bn->rss_hash_key_updated) {
+					get_random_bytes(bn->rss_hash_key,
+							 HW_HASH_KEY_SIZE);
+					bn->rss_hash_key_updated = true;
+				}
+
+				memcpy(vnic->rss_hash_key, bn->rss_hash_key,
+				       HW_HASH_KEY_SIZE);
+
+				if (!bn->rss_hash_key_updated)
+					continue;
+
+				bn->rss_hash_key_updated = false;
+				bn->rss_hash_key_valid = true;
+
+				bn->toeplitz_prefix = 0;
+				for (k = 0; k < 8; k++) {
+					bn->toeplitz_prefix <<= 8;
+					bn->toeplitz_prefix |= key[k];
+				}
+			} else {
+				memcpy(vnic->rss_hash_key, vnic0->rss_hash_key,
+				       HW_HASH_KEY_SIZE);
+			}
+		}
+	}
+}
+
 static void bnge_setup_msix(struct bnge_net *bn)
 {
 	struct net_device *dev = bn->netdev;
@@ -836,6 +1025,20 @@ static void bnge_del_napi(struct bnge_net *bn)
 	synchronize_net();
 }
 
+static int bnge_init_nic(struct bnge_net *bn)
+{
+	int rc;
+
+	bnge_init_nq_tree(bn);
+	bnge_init_rx_rings(bn);
+	bnge_init_tx_rings(bn);
+	rc = bnge_init_ring_grps(bn);
+	if (rc)
+		return rc;
+	bnge_init_vnics(bn);
+	return rc;
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -862,9 +1065,16 @@ static int bnge_open_core(struct bnge_net *bn)
 		goto err_del_napi;
 	}
 
+	rc = bnge_init_nic(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_init_nic err: %d\n", rc);
+		goto err_free_irq;
+	}
 	set_bit(BNGE_STATE_OPEN, &bd->state);
 	return 0;
 
+err_free_irq:
+	bnge_free_irq(bn);
 err_del_napi:
 	bnge_del_napi(bn);
 	bnge_free_core(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 115297dd82c..10bd29a833e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -118,6 +118,20 @@ struct bnge_sw_rx_agg_bd {
 	dma_addr_t		mapping;
 };
 
+#define HWRM_RING_ALLOC_TX	0x1
+#define HWRM_RING_ALLOC_RX	0x2
+#define HWRM_RING_ALLOC_AGG	0x4
+#define HWRM_RING_ALLOC_CMPL	0x8
+#define HWRM_RING_ALLOC_NQ	0x10
+
+struct bnge_ring_grp_info {
+	u16	fw_stats_ctx;
+	u16	fw_grp_id;
+	u16	rx_fw_ring_id;
+	u16	agg_fw_ring_id;
+	u16	nq_fw_ring_id;
+};
+
 #define BNGE_RX_COPY_THRESH     256
 
 #define BNGE_HW_FEATURE_VLAN_ALL_RX	\
@@ -133,6 +147,28 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+/* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1. We need one extra
+ * BD because the first TX BD is always a long BD.
+ */
+#define BNGE_MIN_TX_DESC_CNT	(MAX_SKB_FRAGS + 2)
+
+#define RX_RING(bn, x)	(((x) & (bn)->rx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
+#define RX_AGG_RING(bn, x)	(((x) & (bn)->rx_agg_ring_mask) >>	\
+				 (BNGE_PAGE_SHIFT - 4))
+#define RX_IDX(x)	((x) & (RX_DESC_CNT - 1))
+
+#define TX_RING(bn, x)	(((x) & (bn)->tx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
+#define TX_IDX(x)	((x) & (TX_DESC_CNT - 1))
+
+#define CP_RING(x)	(((x) & ~(CP_DESC_CNT - 1)) >> (BNGE_PAGE_SHIFT - 4))
+#define CP_IDX(x)	((x) & (CP_DESC_CNT - 1))
+
+#define RING_RX(bn, idx)	((idx) & (bn)->rx_ring_mask)
+#define NEXT_RX(idx)		((idx) + 1)
+
+#define RING_RX_AGG(bn, idx)	((idx) & (bn)->rx_agg_ring_mask)
+#define NEXT_RX_AGG(idx)	((idx) + 1)
+
 #define BNGE_NQ_HDL_TYPE_RX	0x00
 #define BNGE_NQ_HDL_TYPE_TX	0x01
 
@@ -176,9 +212,19 @@ struct bnge_net {
 	u16				*tx_ring_map;
 	enum dma_data_direction		rx_dir;
 
+	/* grp_info indexed by napi/nq index */
+	struct bnge_ring_grp_info	*grp_info;
 	struct bnge_vnic_info		*vnic_info;
 	int				nr_vnics;
 	int				total_irqs;
+
+	u32			tx_wake_thresh;
+	u16			rx_offset;
+	u16			rx_dma_offset;
+
+	u8			rss_hash_key[HW_HASH_KEY_SIZE];
+	u8			rss_hash_key_valid:1;
+	u8			rss_hash_key_updated:1;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -307,6 +353,9 @@ struct bnge_napi {
 #define BNGE_MAX_UC_ADDRS	4
 
 struct bnge_vnic_info {
+	u16		fw_vnic_id;
+#define BNGE_MAX_CTX_PER_VNIC	8
+	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
 	u8		*uc_list;
 	dma_addr_t	rss_table_dma_addr;
 	__le16		*rss_table;
@@ -329,5 +378,6 @@ struct bnge_vnic_info {
 #define BNGE_VNIC_RSS_FLAG	1
 #define BNGE_VNIC_MCAST_FLAG	4
 #define BNGE_VNIC_UCAST_FLAG	8
+	u32		vnic_id;
 };
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index 162a66c7983..0e7684e2071 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -184,6 +184,7 @@ struct bnge_ctx_mem_info {
 struct bnge_ring_struct {
 	struct bnge_ring_mem_info	ring_mem;
 
+	u16			fw_ring_id;
 	union {
 		u16		grp_idx;
 		u16		map_idx; /* Used by NQs */
-- 
2.47.3


