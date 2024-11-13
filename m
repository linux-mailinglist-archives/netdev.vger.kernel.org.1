Return-Path: <netdev+bounces-144500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C49C79FC
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541371F25061
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5132022C5;
	Wed, 13 Nov 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8Aj37N2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731117ADF8;
	Wed, 13 Nov 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519170; cv=none; b=MMnlFn9YHw1jC6t7Xdu9Rqbne/pbSpQoAdEh9uFVT53Q2CCIMUDlZ8tOpDQkaoYrAiUW7W0a1Nrz7L01Tc4WciRczkcSA7ls5zMntKqMfzsUOw1lwwFVdYTi7MPc7xHjx4yOYWhKeSl2XXx+azwK5ozt94Ljn/9jGSaGOAZ8Bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519170; c=relaxed/simple;
	bh=TcH9wkD8r2aLtwF4RMloBl4W7UURqK0qm0SH/gG1siY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5L5FdDp6TJ7oQZgKS0RCXEsSYhKkfOqWKUOzFlhuOZ9xkzLmP7nThRrn5L7m1Xm8wlDgAUOGo2FnZPcaSZeztQR4GeM5IksqeFxHfNF2pqcHMqJNB7wLkxpzNqn8fzOLpM+sgYo/2kSLN99ypmuTmWcuCUSMkABvdqJX1Ia3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8Aj37N2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20caccadbeeso77813895ad.2;
        Wed, 13 Nov 2024 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519168; x=1732123968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtqA7W2vqCXP9dXBoVyFgPK7k8pDmFv8ZFg53+ASeAQ=;
        b=C8Aj37N2nPDiNhhnCXR5d7NP1Imkair1Pt9OinG1TKTp6wklWyVYrkk3DDDwycnkUz
         QUfh3/KeRTvYuR1eM+/KYjoNL6eurYrvBV1nZsI80LLnUwbcXjRxnZ1mgCyOW0div168
         XMV/NY0ToZqhBHgCsbK7glh8Hj8ukUzVpatlPyI4vqFf7E04r9c5/PepuIKu7iJkvAV6
         t/IJFbcMGAHgyRW6Ybwl0Ue68YpoflSitnSM4kU0ajlB12FJq31FStoJMOjR4h/pD9S4
         O313qZfTEBdQgBZQl10vJShNxNydz2gq3Eeitl3SzKr43LU3qsTmFANbnZAoka6QaT11
         Vcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519168; x=1732123968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtqA7W2vqCXP9dXBoVyFgPK7k8pDmFv8ZFg53+ASeAQ=;
        b=uBDcGVYxWrWzZid3qI4dm4miFtl4YsrU9HbedrP4nYIYVYvuFGBgH4W6yeSkFvlxmv
         DaGFmx1w5VTq+DDqCtwLYGTmWOfs28dnexhDoAMvAjw+Esz4dBNazKw7PqYjReVidHlc
         +t7SaFN1eogRsqH1hShWqIzjbxzdLaBAglwREuqqYQAcnsVtcihLFT2PKhRE8EHGD+TV
         TomZl2Gjpj+PGwuZICu/OOPRDiRQovd9ZPtU3Y2W83g4vdWRgy0/oZZTLC6uBqTOtkCJ
         9k6MRGR0uwXX/p/Fk3iqtvOZ2RpJKp4hs6mwz0ytSkGAdop85COrl0XP4KyhaXfjQRW1
         gLdw==
X-Forwarded-Encrypted: i=1; AJvYcCVLaWP9xzXMlIoZU3HQr5pAJaUTUmztxmthzm4QwwNvEPv7yfJ9+5lrrUhAtH0fNeMV1NyeowDo@vger.kernel.org, AJvYcCX0BNj1PmXgQwAxPOZ2qJtYZ1nnaPHejv1ZWMjE3KEMz8rJ5WN8vV6CfVWeyGdlr/F/ka4ZU7/N9uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXbmFnN4h+i4GR/24kDZ+KNU799O+4jiRTv128HPaInZL6u7m
	08siQwODj7TEGWpGnqSV1WseXQCCCcxkxDyiibTjDW19YOjXzF1n
X-Google-Smtp-Source: AGHT+IEG7otUQKyDsTesziLoOsHFhk18xPzBK4UERQ6LZcjRRfQZCqQHf7haeTiYN0QU9V+WkyXO5g==
X-Received: by 2002:a17:902:ccc3:b0:20c:b8a5:38e8 with SMTP id d9443c01a7336-211b662d80amr43323675ad.23.1731519168069;
        Wed, 13 Nov 2024 09:32:48 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7df5sm113140765ad.19.2024.11.13.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:32:47 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v5 1/7] bnxt_en: add support for rx-copybreak ethtool command
Date: Wed, 13 Nov 2024 17:32:15 +0000
Message-Id: <20241113173222.372128-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113173222.372128-1-ap420073@gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bnxt_en driver supports rx-copybreak, but it couldn't be set by
userspace. Only the default value(256) has worked.
This patch makes the bnxt_en driver support following command.
`ethtool --set-tunable <devname> rx-copybreak <value> ` and
`ethtool --get-tunable <devname> rx-copybreak`.

By this patch, hds_threshol is set to the rx-copybreak value.
But it will be set by `ethtool -G eth0 header-data-split-thresh N`
in the next patch.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v5:
 - Do not set HDS if XDP is attached.
 - rx_size and pkt_size are always bigger than 256.

v4:
 - Remove min rx-copybreak value.
 - Add Review tag from Brett.
 - Add Test tag from Stanislav.

v3:
 - Update copybreak value after closing nic and before opening nic when
   the device is running.

v2:
 - Define max/vim rx_copybreak value.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 ++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 49 ++++++++++++++++++-
 3 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4c1302a8f72d..d521b8918c02 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -81,7 +81,6 @@ MODULE_DESCRIPTION("Broadcom NetXtreme network driver");
 
 #define BNXT_RX_OFFSET (NET_SKB_PAD + NET_IP_ALIGN)
 #define BNXT_RX_DMA_OFFSET NET_SKB_PAD
-#define BNXT_RX_COPY_THRESH 256
 
 #define BNXT_TX_PUSH_THRESH 164
 
@@ -1328,13 +1327,13 @@ static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi, u8 *data,
 	if (!skb)
 		return NULL;
 
-	dma_sync_single_for_cpu(&pdev->dev, mapping, bp->rx_copy_thresh,
+	dma_sync_single_for_cpu(&pdev->dev, mapping, bp->rx_copybreak,
 				bp->rx_dir);
 
 	memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
 	       len + NET_IP_ALIGN);
 
-	dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copy_thresh,
+	dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copybreak,
 				   bp->rx_dir);
 
 	skb_put(skb, len);
@@ -1827,7 +1826,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		return NULL;
 	}
 
-	if (len <= bp->rx_copy_thresh) {
+	if (len <= bp->rx_copybreak) {
 		skb = bnxt_copy_skb(bnapi, data_ptr, len, mapping);
 		if (!skb) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
@@ -2161,7 +2160,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		}
 	}
 
-	if (len <= bp->rx_copy_thresh) {
+	if (len <= bp->rx_copybreak) {
 		if (!xdp_active)
 			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
 		else
@@ -4452,6 +4451,11 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 		bp->flags |= BNXT_FLAG_GRO;
 }
 
+static void bnxt_init_ring_params(struct bnxt *bp)
+{
+	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+}
+
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
  * be set on entry.
  */
@@ -4466,7 +4470,6 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	rx_space = rx_size + ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	bp->rx_copy_thresh = BNXT_RX_COPY_THRESH;
 	ring_size = bp->rx_ring_size;
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
@@ -4511,7 +4514,9 @@ void bnxt_set_ring_params(struct bnxt *bp)
 				  ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
 				  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		} else {
-			rx_size = SKB_DATA_ALIGN(BNXT_RX_COPY_THRESH + NET_IP_ALIGN);
+			rx_size = SKB_DATA_ALIGN(max(BNXT_DEFAULT_RX_COPYBREAK,
+						     bp->rx_copybreak) +
+						 NET_IP_ALIGN);
 			rx_space = rx_size + NET_SKB_PAD +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		}
@@ -6417,16 +6422,14 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 
 	req->flags = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLACEMENT);
 	req->enables = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID);
+	req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
 
-	if (BNXT_RX_PAGE_MODE(bp)) {
-		req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
-	} else {
+	if (!BNXT_RX_PAGE_MODE(bp) && (bp->flags & BNXT_FLAG_AGG_RINGS)) {
 		req->flags |= cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV4 |
 					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
 		req->enables |=
 			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
-		req->jumbo_thresh = cpu_to_le16(bp->rx_copy_thresh);
-		req->hds_threshold = cpu_to_le16(bp->rx_copy_thresh);
+		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
 	return hwrm_req_send(bp, req);
@@ -15872,6 +15875,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_init_l2_fltr_tbl(bp);
 	bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
+	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_rdma_aux_device_init(bp);
 	rc = bnxt_set_dflt_rings(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 649955fa3e37..d1eef880eec5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -34,6 +34,9 @@
 #include <linux/firmware/broadcom/tee_bnxt_fw.h>
 #endif
 
+#define BNXT_DEFAULT_RX_COPYBREAK 256
+#define BNXT_MAX_RX_COPYBREAK 1024
+
 extern struct list_head bnxt_block_cb_list;
 
 struct page_pool;
@@ -2300,7 +2303,7 @@ struct bnxt {
 	enum dma_data_direction	rx_dir;
 	u32			rx_ring_size;
 	u32			rx_agg_ring_size;
-	u32			rx_copy_thresh;
+	u32			rx_copybreak;
 	u32			rx_ring_mask;
 	u32			rx_agg_ring_mask;
 	int			rx_nr_pages;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index cfd2c65b1c90..adf30d1f738f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4318,6 +4318,50 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 	return 0;
 }
 
+static int bnxt_set_tunable(struct net_device *dev,
+			    const struct ethtool_tunable *tuna,
+			    const void *data)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	u32 rx_copybreak;
+
+	switch (tuna->id) {
+	case ETHTOOL_RX_COPYBREAK:
+		rx_copybreak = *(u32 *)data;
+		if (rx_copybreak > BNXT_MAX_RX_COPYBREAK)
+			return -ERANGE;
+		if (rx_copybreak != bp->rx_copybreak) {
+			if (netif_running(dev)) {
+				bnxt_close_nic(bp, false, false);
+				bp->rx_copybreak = rx_copybreak;
+				bnxt_set_ring_params(bp);
+				bnxt_open_nic(bp, false, false);
+			} else {
+				bp->rx_copybreak = rx_copybreak;
+			}
+		}
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int bnxt_get_tunable(struct net_device *dev,
+			    const struct ethtool_tunable *tuna, void *data)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+	switch (tuna->id) {
+	case ETHTOOL_RX_COPYBREAK:
+		*(u32 *)data = bp->rx_copybreak;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int bnxt_read_sfp_module_eeprom_info(struct bnxt *bp, u16 i2c_addr,
 					    u16 page_number, u8 bank,
 					    u16 start_addr, u16 data_length,
@@ -4768,7 +4812,8 @@ static int bnxt_run_loopback(struct bnxt *bp)
 	cpr = &rxr->bnapi->cp_ring;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		cpr = rxr->rx_cpr;
-	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
+	pkt_size = min(bp->dev->mtu + ETH_HLEN, max(BNXT_DEFAULT_RX_COPYBREAK,
+						    bp->rx_copybreak));
 	skb = netdev_alloc_skb(bp->dev, pkt_size);
 	if (!skb)
 		return -ENOMEM;
@@ -5341,6 +5386,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.get_link_ext_stats	= bnxt_get_link_ext_stats,
 	.get_eee		= bnxt_get_eee,
 	.set_eee		= bnxt_set_eee,
+	.get_tunable		= bnxt_get_tunable,
+	.set_tunable		= bnxt_set_tunable,
 	.get_module_info	= bnxt_get_module_info,
 	.get_module_eeprom	= bnxt_get_module_eeprom,
 	.get_module_eeprom_by_page = bnxt_get_module_eeprom_by_page,
-- 
2.34.1


