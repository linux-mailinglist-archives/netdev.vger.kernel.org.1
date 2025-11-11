Return-Path: <netdev+bounces-237735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88852C4FC82
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D07DB4F700A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE63624AF;
	Tue, 11 Nov 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VGm9wws6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3273A9C14
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894774; cv=none; b=Kt+ZnQ4YMXlh2dzjXNVPWMRxPaVXEmAZ6TehyLSKDH0kXqgZ4JWIsrZmzUUnn1czqqIpK+z1AOptyfnth2BVkB4nXruFPBovLO5t7GBF4fkH9TGVJqgu2BDzQo9XAKAoC1vtvi9Psv+pO+R24yKJwaKtqExMT0e3+uYuj1l3LD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894774; c=relaxed/simple;
	bh=i063WljZ3lzTzAst/rinUGamXj5DY+Gu5ch60Zl9x04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMp+t9AlGeuAKU8jM+kQsE/r2S/m4qaISHaaPgvQJ9kWIGNxMUvzF14wqb2MAPk7GjZVVxpUJrz3ARq/gBNbaHa3fvMrj53G0MH+9WEeApnoOohGrQouQVqRC/X2XCTdsuT6pHcmntkPxYMLL03Tq/w7HihcawI7H+a8OUSL/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VGm9wws6; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3437af8444cso142036a91.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894771; x=1763499571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1qaV3jxa5cRlwIWadrQzDqMVljQEtIBr0L3ybuSTTg=;
        b=Qf1jUBif2H7wKlKAIU6nfcETyeyuICjtSPUrZBfRV/tbCOkTaYjyRcPCMv43XxjgKr
         8H1f/2X6tIKI/pZKgna6wMTVEsrHxGPgGVjT7Mir0kUiSdCZIZw2f+B/g2khdYUv7XHh
         eVrtiUNyH9EbK6jABpTO8zU4A13c+k97ok91qAyFLswuT0y4LSk4PFnuakjTg0I3sm64
         4p80mNC6eOoNURaIPsm+ezvTh1cJG2z+omNPSFbg4nttYoJanFyOb8Ues9rvr/0v/nsg
         /Zk4/37e4MfKO06hTLpILTFIDRoh9Ds/HUBtfiDXh1QVQw0f00ARdex3oYO4119AnKNi
         X86g==
X-Gm-Message-State: AOJu0Yy3u0XkX5lB8kw1O7umML31UK7x0COICV/7sq3MhEN2AEDQAWWV
	MfoLmXJuh+2DtEL2pJNXD1j8XwqgUyi56c0uRTEr2CqMgP5AFZb0JBOkNUfsOaLOvamvWP4+6mm
	kqJH5StCs1gcWYEWEgsnVJr006ruXUhPPujhVqMUWv4QM1SBNSQpm6cJVt5IforlK+MW+oEi42J
	kf796fvTAG0KBnobOl4ofyzTxBZBLuax1L6iJd5B81ycJNjk/x7bJpD9J7CaDEyYpLYvMeOIBI3
	awxLTZo0KKteW1A5uUq
X-Gm-Gg: ASbGncvbYcDEY71kFcCW2nb2x0vcM59ykhhC6X/O6iP1CjZvfIBi3Ir8nqpC2ATnJow
	3xbFeJpeuuUeee1t+YfUh+e+ZObb3dkcCPa1eMF2JXolWjrpZDjxeAWA7Tn0Xm41KvTBjwRRWko
	iCmPS2bc6YP8edC9KbjT8jSLEesxZA3aD7kr/z9TBsFdlGMhtK1cnaI2k8JZ8+HWcgfOnU98g7s
	LSTK6+dDCXmr8viZRn+pC5I9xWtTyhGGo2vuw9MQmPyl7aE6TAJeyhYON//AqKZljTJ38a0A20g
	aKq4W7KT1PUNEuLBxM17F3zZ6IWe6XQimpkilu7FNcuBoRIxFjiuZEWPFV5QjY8SJXTLJJeJK9M
	FnCG3jPUueVIcucia1yrDAr0dD5GnA3QdrsOB4TOj9h1f0DvYE4DJkMTR/WgpY22h390c2c9cOt
	k9qycFh1sG17EUrZ2pI0CLE0X3NAOxR2iXjL/0NhcLvkg=
X-Google-Smtp-Source: AGHT+IEnPmL69cCANa0FDLC3aujCR8GKyoGajz8G+kaP/AKMccLwB0mcO03VlIidsfMwhoq2XN6+KIgmN5Tk
X-Received: by 2002:a17:90b:4d01:b0:340:ad5e:c9 with SMTP id 98e67ed59e1d1-343dde225b9mr876460a91.16.1762894771338;
        Tue, 11 Nov 2025 12:59:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-343e07e793fsm1891a91.8.2025.11.11.12.59.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:59:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7ad1e8ab328so121435b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894769; x=1763499569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1qaV3jxa5cRlwIWadrQzDqMVljQEtIBr0L3ybuSTTg=;
        b=VGm9wws6jVpHt3t5jFkvCX2PZWcrsyyWebTmZYsPoM9xs1ritAvMFjmji5DorAxbDw
         BRyKjTxDZmtW3sFigtOaA1bMvum/x9K0sQaUX7vSyqDhG5j3Xgp2MGMdItTyLCw5n0WN
         rDXuAigBAmuNUv/73WhbfO4oOmxyMloJOlX5Y=
X-Received: by 2002:a05:6a20:729f:b0:34f:b660:7722 with SMTP id adf61e73a8af0-3590be099b6mr567604637.54.1762894769397;
        Tue, 11 Nov 2025 12:59:29 -0800 (PST)
X-Received: by 2002:a05:6a20:729f:b0:34f:b660:7722 with SMTP id adf61e73a8af0-3590be099b6mr567570637.54.1762894768853;
        Tue, 11 Nov 2025 12:59:28 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:28 -0800 (PST)
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
Subject: [net-next 07/12] bng_en: Add TPA related functions
Date: Wed, 12 Nov 2025 02:27:57 +0530
Message-ID: <20251111205829.97579-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add the functions to handle TPA events in RX path.
This helps the next patch enable TPA functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 123 ++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 295 ++++++++++++++++++
 2 files changed, 418 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 87b5b2163e5..a1f8d3b6dfe 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -378,11 +378,37 @@ static void bnge_free_one_agg_ring_bufs(struct bnge_net *bn,
 	}
 }
 
+static void bnge_free_one_tpa_info_data(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	int i;
+
+	for (i = 0; i < bn->max_tpa; i++) {
+		struct bnge_tpa_info *tpa_info = &rxr->rx_tpa[i];
+		u8 *data = tpa_info->data;
+
+		if (!data)
+			continue;
+
+		tpa_info->data = NULL;
+		page_pool_free_va(rxr->head_pool, data, false);
+	}
+}
+
 static void bnge_free_one_rx_ring_pair_bufs(struct bnge_net *bn,
 					    struct bnge_rx_ring_info *rxr)
 {
+	struct bnge_tpa_idx_map *map;
+
+	if (rxr->rx_tpa)
+		bnge_free_one_tpa_info_data(bn, rxr);
+
 	bnge_free_one_rx_ring_bufs(bn, rxr);
 	bnge_free_one_agg_ring_bufs(bn, rxr);
+
+	map = rxr->rx_tpa_idx_map;
+	if (map)
+		memset(map->agg_idx_bmap, 0, sizeof(map->agg_idx_bmap));
 }
 
 static void bnge_free_rx_ring_pair_bufs(struct bnge_net *bn)
@@ -453,11 +479,70 @@ static void bnge_free_all_rings_bufs(struct bnge_net *bn)
 	bnge_free_tx_skbs(bn);
 }
 
+static void bnge_free_tpa_info(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		kfree(rxr->rx_tpa_idx_map);
+		rxr->rx_tpa_idx_map = NULL;
+		if (rxr->rx_tpa) {
+			for (j = 0; j < bn->max_tpa; j++) {
+				kfree(rxr->rx_tpa[j].agg_arr);
+				rxr->rx_tpa[j].agg_arr = NULL;
+			}
+		}
+		kfree(rxr->rx_tpa);
+		rxr->rx_tpa = NULL;
+	}
+}
+
+static int bnge_alloc_tpa_info(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	if (!bd->max_tpa_v2)
+		return 0;
+
+	bn->max_tpa = max_t(u16, bd->max_tpa_v2, MAX_TPA);
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		rxr->rx_tpa = kcalloc(bn->max_tpa, sizeof(struct bnge_tpa_info),
+				      GFP_KERNEL);
+		if (!rxr->rx_tpa)
+			goto err_free_tpa_info;
+
+		for (j = 0; j < bn->max_tpa; j++) {
+			struct rx_agg_cmp *agg;
+
+			agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
+			if (!agg)
+				goto err_free_tpa_info;
+			rxr->rx_tpa[j].agg_arr = agg;
+		}
+		rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
+					      GFP_KERNEL);
+		if (!rxr->rx_tpa_idx_map)
+			goto err_free_tpa_info;
+	}
+	return 0;
+
+err_free_tpa_info:
+	bnge_free_tpa_info(bn);
+	return -ENOMEM;
+}
+
 static void bnge_free_rx_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	bnge_free_tpa_info(bn);
 	for (i = 0; i < bd->rx_nr_rings; i++) {
 		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
 		struct bnge_ring_struct *ring;
@@ -582,6 +667,12 @@ static int bnge_alloc_rx_rings(struct bnge_net *bn)
 				goto err_free_rx_rings;
 		}
 	}
+
+	if (bn->priv_flags & BNGE_NET_EN_TPA) {
+		rc = bnge_alloc_tpa_info(bn);
+		if (rc)
+			goto err_free_rx_rings;
+	}
 	return rc;
 
 err_free_rx_rings:
@@ -1127,6 +1218,29 @@ static int bnge_alloc_one_agg_ring_bufs(struct bnge_net *bn,
 	return -ENOMEM;
 }
 
+static int bnge_alloc_one_tpa_info_data(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	dma_addr_t mapping;
+	u8 *data;
+	int i;
+
+	for (i = 0; i < bn->max_tpa; i++) {
+		data = __bnge_alloc_rx_frag(bn, &mapping, rxr,
+					    GFP_KERNEL);
+		if (!data)
+			goto err_free_tpa_info_data;
+
+		rxr->rx_tpa[i].data = data;
+		rxr->rx_tpa[i].data_ptr = data + bn->rx_offset;
+		rxr->rx_tpa[i].mapping = mapping;
+	}
+	return 0;
+err_free_tpa_info_data:
+	bnge_free_one_tpa_info_data(bn, rxr);
+	return -ENOMEM;
+}
+
 static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
 {
 	struct bnge_rx_ring_info *rxr = &bn->rx_ring[ring_nr];
@@ -1141,8 +1255,17 @@ static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
 		if (rc)
 			goto err_free_one_rx_ring_bufs;
 	}
+
+	if (rxr->rx_tpa) {
+		rc = bnge_alloc_one_tpa_info_data(bn, rxr);
+		if (rc)
+			goto err_free_one_agg_ring_bufs;
+	}
+
 	return 0;
 
+err_free_one_agg_ring_bufs:
+	bnge_free_one_agg_ring_bufs(bn, rxr);
 err_free_one_rx_ring_bufs:
 	bnge_free_one_rx_ring_bufs(bn, rxr);
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 781cba50bdc..0e189ddb9d8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -154,6 +154,46 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+#define BNGE_NO_FW_ACCESS(bd)	(pci_channel_offline((bd)->pdev))
+
+#define MAX_TPA		256
+#define MAX_TPA_MASK	(MAX_TPA - 1)
+#define MAX_TPA_SEGS	0x3f
+
+#define BNGE_AGG_IDX_BMAP_SIZE	(MAX_TPA / BITS_PER_LONG)
+struct bnge_tpa_idx_map {
+	u16		agg_id_tbl[1024];
+	unsigned long	agg_idx_bmap[BNGE_AGG_IDX_BMAP_SIZE];
+};
+
+struct bnge_tpa_info {
+	void			*data;
+	u8			*data_ptr;
+	dma_addr_t		mapping;
+	u16			len;
+	unsigned short		gso_type;
+	u32			flags2;
+	u32			metadata;
+	enum pkt_hash_types	hash_type;
+	u32			rss_hash;
+	u32			hdr_info;
+
+#define BNGE_TPA_INNER_L3_OFF(hdr_info)	\
+	(((hdr_info) >> 18) & 0x1ff)
+
+#define BNGE_TPA_INNER_L2_OFF(hdr_info)	\
+	(((hdr_info) >> 9) & 0x1ff)
+
+#define BNGE_TPA_OUTER_L3_OFF(hdr_info)	\
+	((hdr_info) & 0x1ff)
+
+	u16			cfa_code; /* cfa_code in TPA start compl */
+	u8			agg_count;
+	u8			vlan_valid:1;
+	u8			cfa_code_valid:1;
+	struct rx_agg_cmp	*agg_arr;
+};
+
 /* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1. We need one extra
  * BD because the first TX BD is always a long BD.
  */
@@ -250,6 +290,10 @@ struct bnge_net {
 #define BNGE_STATE_NAPI_DISABLED	0
 
 	u32			msg_enable;
+	u16			max_tpa;
+	__be16			vxlan_port;
+	__be16			nge_port;
+	__be16			vxlan_gpe_port;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -315,6 +359,254 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 	bnge_writeq(bd, (db)->db_key64 | DBR_TYPE_NQ_ARM |	\
 		    DB_RING_IDX(db, idx), (db)->doorbell)
 
+#define TPA_AGG_AGG_ID(rx_agg)				\
+	((le32_to_cpu((rx_agg)->rx_agg_cmp_v) &		\
+	 RX_AGG_CMP_AGG_ID) >> RX_AGG_CMP_AGG_ID_SHIFT)
+
+struct rx_tpa_start_cmp {
+	__le32 rx_tpa_start_cmp_len_flags_type;
+	#define RX_TPA_START_CMP_TYPE				(0x3f << 0)
+	#define RX_TPA_START_CMP_FLAGS				(0x3ff << 6)
+	 #define RX_TPA_START_CMP_FLAGS_SHIFT			 6
+	#define RX_TPA_START_CMP_FLAGS_ERROR			(0x1 << 6)
+	#define RX_TPA_START_CMP_FLAGS_PLACEMENT		(0x7 << 7)
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_SHIFT		 7
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_JUMBO		 (0x1 << 7)
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_HDS		 (0x2 << 7)
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_GRO_JUMBO	 (0x5 << 7)
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_GRO_HDS	 (0x6 << 7)
+	#define RX_TPA_START_CMP_FLAGS_RSS_VALID		(0x1 << 10)
+	#define RX_TPA_START_CMP_FLAGS_TIMESTAMP		(0x1 << 11)
+	#define RX_TPA_START_CMP_FLAGS_ITYPES			(0xf << 12)
+	 #define RX_TPA_START_CMP_FLAGS_ITYPES_SHIFT		 12
+	 #define RX_TPA_START_CMP_FLAGS_ITYPE_TCP		 (0x2 << 12)
+	#define RX_TPA_START_CMP_LEN				(0xffff << 16)
+	 #define RX_TPA_START_CMP_LEN_SHIFT			 16
+
+	u32 rx_tpa_start_cmp_opaque;
+	__le32 rx_tpa_start_cmp_misc_v1;
+	#define RX_TPA_START_CMP_V1				(0x1 << 0)
+	#define RX_TPA_START_CMP_RSS_HASH_TYPE			(0x7f << 9)
+	 #define RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT		 9
+	#define RX_TPA_START_CMP_V3_RSS_HASH_TYPE		(0x1ff << 7)
+	 #define RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT	 7
+	#define RX_TPA_START_CMP_AGG_ID				(0x7f << 25)
+	 #define RX_TPA_START_CMP_AGG_ID_SHIFT			 25
+	#define RX_TPA_START_CMP_AGG_ID_P5			(0xffff << 16)
+	 #define RX_TPA_START_CMP_AGG_ID_SHIFT_P5		 16
+	#define RX_TPA_START_CMP_METADATA1			(0xf << 28)
+	 #define RX_TPA_START_CMP_METADATA1_SHIFT		 28
+	#define RX_TPA_START_METADATA1_TPID_SEL			(0x7 << 28)
+	#define RX_TPA_START_METADATA1_TPID_8021Q		(0x1 << 28)
+	#define RX_TPA_START_METADATA1_TPID_8021AD		(0x0 << 28)
+	#define RX_TPA_START_METADATA1_VALID			(0x8 << 28)
+
+	__le32 rx_tpa_start_cmp_rss_hash;
+};
+
+#define TPA_START_HASH_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
+	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_RSS_VALID))
+
+#define TPA_START_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_RSS_HASH_TYPE) >>				\
+	  RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define TPA_START_V3_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_V3_RSS_HASH_TYPE) >>			\
+	  RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define TPA_START_AGG_ID(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_CMP_AGG_ID_P5) >> RX_TPA_START_CMP_AGG_ID_SHIFT_P5)
+
+#define TPA_START_ERROR(rx_tpa_start)					\
+	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
+	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_ERROR))
+
+#define TPA_START_VLAN_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_misc_v1 &			\
+	 cpu_to_le32(RX_TPA_START_METADATA1_VALID))
+
+#define TPA_START_VLAN_TPID_SEL(rx_tpa_start)				\
+	(le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_METADATA1_TPID_SEL)
+
+struct rx_tpa_start_cmp_ext {
+	__le32 rx_tpa_start_cmp_flags2;
+	#define RX_TPA_START_CMP_FLAGS2_IP_CS_CALC		(0x1 << 0)
+	#define RX_TPA_START_CMP_FLAGS2_L4_CS_CALC		(0x1 << 1)
+	#define RX_TPA_START_CMP_FLAGS2_T_IP_CS_CALC		(0x1 << 2)
+	#define RX_TPA_START_CMP_FLAGS2_T_L4_CS_CALC		(0x1 << 3)
+	#define RX_TPA_START_CMP_FLAGS2_IP_TYPE			(0x1 << 8)
+	#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_VALID		(0x1 << 9)
+	#define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT		(0x3 << 10)
+	 #define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT_SHIFT	 10
+	#define RX_TPA_START_CMP_V3_FLAGS2_T_IP_TYPE		(0x1 << 10)
+	#define RX_TPA_START_CMP_V3_FLAGS2_AGG_GRO		(0x1 << 11)
+	#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL		(0xffff << 16)
+	 #define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_SHIFT	 16
+
+	__le32 rx_tpa_start_cmp_metadata;
+	__le32 rx_tpa_start_cmp_cfa_code_v2;
+	#define RX_TPA_START_CMP_V2				(0x1 << 0)
+	#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK	(0x7 << 1)
+	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT	 1
+	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_NO_BUFFER	 (0x0 << 1)
+	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT (0x3 << 1)
+	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_FLUSH	 (0x5 << 1)
+	#define RX_TPA_START_CMP_CFA_CODE			(0xffff << 16)
+	 #define RX_TPA_START_CMPL_CFA_CODE_SHIFT		 16
+	#define RX_TPA_START_CMP_METADATA0_TCI_MASK		(0xffff << 16)
+	#define RX_TPA_START_CMP_METADATA0_VID_MASK		(0x0fff << 16)
+	 #define RX_TPA_START_CMP_METADATA0_SFT			 16
+	__le32 rx_tpa_start_cmp_hdr_info;
+};
+
+#define TPA_START_CFA_CODE(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	 RX_TPA_START_CMP_CFA_CODE) >> RX_TPA_START_CMPL_CFA_CODE_SHIFT)
+
+#define TPA_START_IS_IPV6(rx_tpa_start)				\
+	(!!((rx_tpa_start)->rx_tpa_start_cmp_flags2 &		\
+	    cpu_to_le32(RX_TPA_START_CMP_FLAGS2_IP_TYPE)))
+
+#define TPA_START_ERROR_CODE(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK) >>			\
+	 RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT)
+
+#define TPA_START_METADATA0_TCI(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_METADATA0_TCI_MASK) >>			\
+	 RX_TPA_START_CMP_METADATA0_SFT)
+
+struct rx_tpa_end_cmp {
+	__le32 rx_tpa_end_cmp_len_flags_type;
+	#define RX_TPA_END_CMP_TYPE				(0x3f << 0)
+	#define RX_TPA_END_CMP_FLAGS				(0x3ff << 6)
+	 #define RX_TPA_END_CMP_FLAGS_SHIFT			 6
+	#define RX_TPA_END_CMP_FLAGS_PLACEMENT			(0x7 << 7)
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_SHIFT		 7
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_JUMBO		 (0x1 << 7)
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_HDS		 (0x2 << 7)
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO	 (0x5 << 7)
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS		 (0x6 << 7)
+	#define RX_TPA_END_CMP_FLAGS_RSS_VALID			(0x1 << 10)
+	#define RX_TPA_END_CMP_FLAGS_ITYPES			(0xf << 12)
+	 #define RX_TPA_END_CMP_FLAGS_ITYPES_SHIFT		 12
+	 #define RX_TPA_END_CMP_FLAGS_ITYPE_TCP			 (0x2 << 12)
+	#define RX_TPA_END_CMP_LEN				(0xffff << 16)
+	 #define RX_TPA_END_CMP_LEN_SHIFT			 16
+
+	u32 rx_tpa_end_cmp_opaque;
+	__le32 rx_tpa_end_cmp_misc_v1;
+	#define RX_TPA_END_CMP_V1				(0x1 << 0)
+	#define RX_TPA_END_CMP_AGG_BUFS				(0x3f << 1)
+	 #define RX_TPA_END_CMP_AGG_BUFS_SHIFT			 1
+	#define RX_TPA_END_CMP_TPA_SEGS				(0xff << 8)
+	 #define RX_TPA_END_CMP_TPA_SEGS_SHIFT			 8
+	#define RX_TPA_END_CMP_PAYLOAD_OFFSET			(0xff << 16)
+	 #define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT		 16
+	#define RX_TPA_END_CMP_AGG_ID				(0xffff << 16)
+	 #define RX_TPA_END_CMP_AGG_ID_SHIFT			 16
+
+	__le32 rx_tpa_end_cmp_tsdelta;
+	#define RX_TPA_END_GRO_TS				(0x1 << 31)
+};
+
+#define TPA_END_AGG_ID(rx_tpa_end)					\
+	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
+	 RX_TPA_END_CMP_AGG_ID) >> RX_TPA_END_CMP_AGG_ID_SHIFT)
+
+#define TPA_END_TPA_SEGS(rx_tpa_end)					\
+	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
+	 RX_TPA_END_CMP_TPA_SEGS) >> RX_TPA_END_CMP_TPA_SEGS_SHIFT)
+
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO				\
+	cpu_to_le32(RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO &		\
+		    RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS)
+
+#define TPA_END_GRO(rx_tpa_end)						\
+	((rx_tpa_end)->rx_tpa_end_cmp_len_flags_type &			\
+	 RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO)
+
+#define TPA_END_GRO_TS(rx_tpa_end)					\
+	(!!((rx_tpa_end)->rx_tpa_end_cmp_tsdelta &			\
+	    cpu_to_le32(RX_TPA_END_GRO_TS)))
+
+struct rx_tpa_end_cmp_ext {
+	__le32 rx_tpa_end_cmp_dup_acks;
+	#define RX_TPA_END_CMP_TPA_DUP_ACKS			(0xf << 0)
+	#define RX_TPA_END_CMP_PAYLOAD_OFFSET_P5		(0xff << 16)
+	 #define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT_P5		 16
+	#define RX_TPA_END_CMP_AGG_BUFS_P5			(0xff << 24)
+	 #define RX_TPA_END_CMP_AGG_BUFS_SHIFT_P5		 24
+
+	__le32 rx_tpa_end_cmp_seg_len;
+	#define RX_TPA_END_CMP_TPA_SEG_LEN			(0xffff << 0)
+
+	__le32 rx_tpa_end_cmp_errors_v2;
+	#define RX_TPA_END_CMP_V2				(0x1 << 0)
+	#define RX_TPA_END_CMP_ERRORS				(0x3 << 1)
+	#define RX_TPA_END_CMP_ERRORS_P5			(0x7 << 1)
+	#define RX_TPA_END_CMPL_ERRORS_SHIFT			 1
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_NO_BUFFER	 (0x0 << 1)
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_NOT_ON_CHIP	 (0x2 << 1)
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT	 (0x3 << 1)
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_RSV_ERROR	 (0x4 << 1)
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_FLUSH	 (0x5 << 1)
+
+	u32 rx_tpa_end_cmp_start_opaque;
+};
+
+#define TPA_END_ERRORS(rx_tpa_end_ext)					\
+	((rx_tpa_end_ext)->rx_tpa_end_cmp_errors_v2 &			\
+	 cpu_to_le32(RX_TPA_END_CMP_ERRORS))
+
+#define TPA_END_PAYLOAD_OFF(rx_tpa_end_ext)				\
+	((le32_to_cpu((rx_tpa_end_ext)->rx_tpa_end_cmp_dup_acks) &	\
+	 RX_TPA_END_CMP_PAYLOAD_OFFSET_P5) >>				\
+	RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT_P5)
+
+#define TPA_END_AGG_BUFS(rx_tpa_end_ext)				\
+	((le32_to_cpu((rx_tpa_end_ext)->rx_tpa_end_cmp_dup_acks) &	\
+	 RX_TPA_END_CMP_AGG_BUFS_P5) >> RX_TPA_END_CMP_AGG_BUFS_SHIFT_P5)
+
+#define EVENT_DATA1_RESET_NOTIFY_FATAL(data1)				\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK) ==\
+	 ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_EXCEPTION_FATAL)
+
+#define EVENT_DATA1_RESET_NOTIFY_FW_ACTIVATION(data1)			\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK) ==\
+	ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_ACTIVATION)
+
+#define EVENT_DATA2_RESET_NOTIFY_FW_STATUS_CODE(data2)			\
+	((data2) &							\
+	ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA2_FW_STATUS_CODE_MASK)
+
+#define EVENT_DATA1_RECOVERY_MASTER_FUNC(data1)				\
+	(!!((data1) &							\
+	   ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_MASTER_FUNC))
+
+#define EVENT_DATA1_RECOVERY_ENABLED(data1)				\
+	(!!((data1) &							\
+	   ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_RECOVERY_ENABLED))
+
+#define BNGE_EVENT_ERROR_REPORT_TYPE(data1)				\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MASK) >>\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_SFT)
+
+#define BNGE_EVENT_INVALID_SIGNAL_DATA(data2)				\
+	(((data2) &							\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_MASK) >>\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_SFT)
+
 struct bnge_stats_mem {
 	u64		*sw_stats;
 	u64		*hw_masks;
@@ -395,6 +687,9 @@ struct bnge_rx_ring_info {
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
 	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
 
+	struct bnge_tpa_info	*rx_tpa;
+	struct bnge_tpa_idx_map *rx_tpa_idx_map;
+
 	struct bnge_ring_struct	rx_ring_struct;
 	struct bnge_ring_struct	rx_agg_ring_struct;
 	struct page_pool	*page_pool;
-- 
2.47.3


