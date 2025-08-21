Return-Path: <netdev+bounces-215709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5AAB2FF83
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D76643543
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132A2DCC1B;
	Thu, 21 Aug 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cb3JLkcY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19C274B44
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791338; cv=none; b=Z2W1IB+mvNsrkkKpIYHCEjIbdocAdDlu5j23mGNBXqRE8KV0ccbyUEb8KiFrKHlUyfrwS6HPAYPXvulIIEe72CFSnujVx3oXpZZVnsfP186IVgxNS3UrtPhX8mRwm803riRA9/1zoRabq913aC3x7C8XpnKhQnJ67hTwGK8M3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791338; c=relaxed/simple;
	bh=jgGNtlF79XPMA4oBIq8iYKP07IodsbVLLG6x22FPaso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYksWL9mwQ3VcRuWB6NLwCjgs+3plhf6K7AmQUPwW93DWrJ0u4VHK0qsNR0xxXwf40Z3Mn2gp9pmhRExYDM5n8BeWgYNoBewsfDE8A56LFoz3nnozB6Degl2y7b2mKEdX9qAjgf0LAtHPimAOjYpfDFG8YeBoppuG9D0AWdHXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cb3JLkcY; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3e57003ee3fso5026005ab.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791334; x=1756396134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRZoYaiCYlOyv4IB9IG9gsZbgkHTjXPcgKNNXaB54+0=;
        b=fL5cNkQEJHOJ7qQJ/57bVUee8HcDAlPd6D6NIZxfhwqkZkhHt70inmVBaLGZPFGUXf
         tMCq3x13Qm101FUwW/yJlyQpEYxnlFIqtEucb9DdcDSs3DhsFgWaThoLuAlwOGEpHz9i
         D1P7LG1TeMaH3SDZsobN5LoAgye6kTVGxw0OMlBOFi0SRwuL03sbDhCrOZOv+HR1c185
         RmU/QL/nMEg7wPYJ09Dmgt/0J69SkMNjlGia+RqAIlu/bdCVkjh3e5n7gUoWDQ5XSZes
         pnqjXMFGR2JOh+ruLS4cZUlaTkF/25gVaRKuVzzGjFLwIp/OqqA1DoZB5a/fwV+T+btN
         WbNA==
X-Gm-Message-State: AOJu0YxzLiJ4lWL0v+gUwj/OQ5Fp2UDLvYF4Wn3TZZ9O/HCV28pY3QOo
	k+B2ZrucnYDvmR/b5THdVw/WTn57zCrC1jWR0OpHHQUPFYBjWztm7Sn22taAsyUUprOH767eoqr
	P6Vu1bhRZD9XEYkNeF6wd/bNmfF0UZi0RKTv8YijTuVg2dS60MdbyWoKdgeEbgWwTzkJ1/BRUc6
	MwpJXawW9UzO3Qu108NzrLpaH6CNziOUn6X/nTyqbzn8g1bWGcwHt4qwyD0zz/TeRMUr4BcG1N9
	gveW26Yo0NtBjIAbqpb
X-Gm-Gg: ASbGncuvykv0GmoRY62JjUM7Or8jfxsPH6HBwyMKOpol7v2BQIPZ34atadzVGXhPvX+
	YKOQa1SbimNy1AZLuj4XFiiF4XJNFSf733+yD91gNt6f7lYM1/mB4xFalkcTLcu1GsxQ535Be2I
	k5wHd+bA0oJBJBt7E/9dJSTAQ7wGTN4UKa8DNk2waWj7lpmQ9XLTtaexplYjbpBoogJb9BnC9f8
	Zm96xjDFcsUQ7FKqFrZeCYPrJoPRX/XTvry72ejWBZ4g/3bEyP6QSeo/FPjPoGAeXuk/7EMzpye
	1X9lbos1nMvY6sDmdNlfw6kL8EFB7CWHAFU0l4XcrU+3oi7pYK+FuwFp6Hx1otXQSaz7/227jz2
	pjVKkgvNOGckastHur+FGOI5cYF8EBXVu8nBL1jFPCudV6Mhyyeu/KI2D1Y6+4tagXb/2XTgpNo
	c+ZXdVAw==
X-Google-Smtp-Source: AGHT+IF6RiuskG7uEf6ZfCqj5oEbBNsiJAyzxksXygL+7nWGm76kcdvTT4MCotxAVR13D6VHlB5OSQrc9qMo
X-Received: by 2002:a92:cda3:0:b0:3e5:3a15:93b6 with SMTP id e9e14a558f8ab-3e6d4537db3mr46854385ab.8.1755791334389;
        Thu, 21 Aug 2025 08:48:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e57e74ec79sm12601565ab.28.2025.08.21.08.48.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:48:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso2725354b3a.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755791333; x=1756396133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRZoYaiCYlOyv4IB9IG9gsZbgkHTjXPcgKNNXaB54+0=;
        b=Cb3JLkcY4wm+EWxoeL5Grfi9/mQTyY2QLJQWvQCJ/aDs5Q8W02i9518sRo0ma085FY
         RGUhFw/zAjxOD9LgixCMXbn0m3HJPD6t47twX/WCSAKsIXvgY4r5iX8Ju3Jrd75tV5Eq
         GFZDPA2XiVpnV3nT/ugHtXtgwBVQNdOAPpx2Y=
X-Received: by 2002:a05:6a20:9183:b0:243:15b9:7656 with SMTP id adf61e73a8af0-24330af16d3mr4344943637.48.1755791332793;
        Thu, 21 Aug 2025 08:48:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:9183:b0:243:15b9:7656 with SMTP id adf61e73a8af0-24330af16d3mr4344908637.48.1755791332303;
        Thu, 21 Aug 2025 08:48:52 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm5046894a12.46.2025.08.21.08.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:48:51 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v3, net-next 4/9] bng_en: Initialise core resources
Date: Thu, 21 Aug 2025 21:15:12 +0000
Message-ID: <20250821211517.16578-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
References: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 216 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  48 ++++
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   1 +
 3 files changed, 265 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index cc7c2aa59fe6..a5724d389b03 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -700,6 +700,204 @@ static irqreturn_t bnge_msix(int irq, void *dev_instance)
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
+		if (!nqr->cp_ring_arr)
+			continue;
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
+		struct rx_bd *rxbd;
+		int j;
+
+		rxbd = rx_desc_ring[i];
+		if (!rxbd)
+			continue;
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
+static void bnge_init_one_rx_agg_ring_rxbd(struct bnge_net *bn,
+					   struct bnge_rx_ring_info *rxr)
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
+static int bnge_init_one_rx_ring(struct bnge_net *bn, int ring_nr)
+{
+	struct bnge_rx_ring_info *rxr;
+
+	rxr = &bn->rx_ring[ring_nr];
+	bnge_init_one_rx_ring_rxbd(bn, rxr);
+
+	netif_queue_set_napi(bn->netdev, ring_nr, NETDEV_QUEUE_TYPE_RX,
+			     &rxr->bnapi->napi);
+
+	bnge_init_one_rx_agg_ring_rxbd(bn, rxr);
+
+	return 0;
+}
+
+static int bnge_init_rx_rings(struct bnge_net *bn)
+{
+	int i, rc = 0;
+
+#define BNGE_RX_OFFSET (NET_SKB_PAD + NET_IP_ALIGN)
+#define BNGE_RX_DMA_OFFSET NET_SKB_PAD
+	bn->rx_offset = BNGE_RX_OFFSET;
+	bn->rx_dma_offset = BNGE_RX_DMA_OFFSET;
+
+	for (i = 0; i < bn->bd->rx_nr_rings; i++) {
+		rc = bnge_init_one_rx_ring(bn, i);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
+static int bnge_init_tx_rings(struct bnge_net *bn)
+{
+	int i;
+
+	bn->tx_wake_thresh = max_t(int, bn->tx_ring_size / 2,
+				   BNGE_MIN_TX_DESC_CNT);
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
+
+	return 0;
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
@@ -864,6 +1062,17 @@ static void bnge_free_irq(struct bnge_net *bn)
 	}
 }
 
+static int bnge_init_nic(struct bnge_net *bn)
+{
+	bnge_init_nq_tree(bn);
+	bnge_init_rx_rings(bn);
+	bnge_init_tx_rings(bn);
+	bnge_init_ring_grps(bn);
+	bnge_init_vnics(bn);
+
+	return 0;
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -890,10 +1099,17 @@ static int bnge_open_core(struct bnge_net *bn)
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
index 8bc0d09e0419..0859f500b3f4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -117,6 +117,20 @@ struct bnge_sw_rx_agg_bd {
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
@@ -132,6 +146,28 @@ enum {
 
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
 
@@ -180,6 +216,14 @@ struct bnge_net {
 	struct bnge_vnic_info		*vnic_info;
 	int				nr_vnics;
 	int				total_irqs;
+
+	int			tx_wake_thresh;
+	u16			rx_offset;
+	u16			rx_dma_offset;
+
+	u8			rss_hash_key[HW_HASH_KEY_SIZE];
+	u8			rss_hash_key_valid:1;
+	u8			rss_hash_key_updated:1;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -308,6 +352,9 @@ struct bnge_napi {
 #define BNGE_MAX_UC_ADDRS	4
 
 struct bnge_vnic_info {
+	u16		fw_vnic_id;
+#define BNGE_MAX_CTX_PER_VNIC	8
+	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
 	u8		*uc_list;
 	dma_addr_t	rss_table_dma_addr;
 	__le16		*rss_table;
@@ -330,5 +377,6 @@ struct bnge_vnic_info {
 #define BNGE_VNIC_RSS_FLAG	1
 #define BNGE_VNIC_MCAST_FLAG	4
 #define BNGE_VNIC_UCAST_FLAG	8
+	u32		vnic_id;
 };
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index 162a66c79830..0e7684e20714 100644
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


