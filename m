Return-Path: <netdev+bounces-157422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3883FA0A43D
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A1A16A15C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39A1AC435;
	Sat, 11 Jan 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoXYrewB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C31494D9;
	Sat, 11 Jan 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606803; cv=none; b=nOGtIJl7zjbevqK9iZqfeC2U2CUM0zPm0svwFw5VGrpSRbuqYq23gbiIPs3P64aMrFD9ysufHYVotFGx9qSWJxUczkNe88g8MmHPoe1V2zLRoDZSxAjFUl7iXfjliUl3wwhZ4quXMU4IYrmFSfoq1YHIr6UZ3ayEG6oNxsyG5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606803; c=relaxed/simple;
	bh=eeLpDNb1dB/nhj7WTgSaQW7Dn31sRGs4YapMtT+HtSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kP47Cv27Sxf3Csyga9W84Db2prnS2bFZ7NXgTApgZswvCHUmJWyOQ5Lv/huY36WNInClCOxqsVPP8Msiq3mGQ6+8FILmLRBOJ2SUR8oYWXThRXE2XrnfCx5KCV6ITmExB4/gwuR2pIT/y64M2e9RMDGgq1Tj+R+oEC7aEUoPdjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoXYrewB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2162c0f6a39so70853835ad.0;
        Sat, 11 Jan 2025 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606801; x=1737211601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB4GagNp0wIoPpoRAQtIq8+OKkkrtMO/POdDGJFE/s0=;
        b=GoXYrewBqVOvfK1FMz4CQhlB0V2PPCgE6UzQ47cFiSKYxbTvD2p5ncusRt2+Zscilj
         4pDd8M9cBiTr/rMItxQncrMo8iAj4hPWsWn+vwc9cY95L6BkAieq6RI1fuQgOVL5MCiW
         5MMlbUrEuzLOJsBGMKYfRg/rbBB7qj0N4dmK2A6ojGl9g0ScTt/ohYnu6L21j8h7Az1w
         bJFUt2GZQmovi3KayTI/IRABL9VCI0+WZDxoVRXKA/dsfIMTBn2ZogzYiVdr9JRYhL0q
         iLoW+fyb0pcusLlHdh0Wupb6tks4GePg2tYXLE8hO4X9Uf4jRBn8NTGqs9KhWhpVrIPF
         pQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606801; x=1737211601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB4GagNp0wIoPpoRAQtIq8+OKkkrtMO/POdDGJFE/s0=;
        b=gOPNEPZVVPSV/T6R+qGa97ZzG8Z9hZjLvxZ+8n/dRMQpdA77P0q5YmJAYMTkt9kfFT
         3bppM13Hr6F+qDSqm3voMRaLGpzBYIYibgW5ndV+1fHWWO/TN6E2M23CFTlyDNKOvnLQ
         c9rB6zf6OuDD0P5cnY5/rnjr2tFJNoFCHxgubg6JsFX3//6Vxtb/6LAXQWLQe+S4bauW
         emHeMGAYiEOvl2+my5tBDLqFrUQyd1QytDvFq+Y1MV0ZRogvJzHp+/1tKPoDI5uYWjAt
         +m77qWhxCLR88l8OHGDFtCeqLTX8oqNLsU8fdzQ5Mh2gbBn9y97/DNQsPwhCIpB9mCai
         imQA==
X-Forwarded-Encrypted: i=1; AJvYcCWXl654dtdqYQMRAxELymlMlhtQK1S+JHV2dZCKltp8W9+BAh5DhUV+bd9bX34UytXWHLYIBkUKC8s=@vger.kernel.org, AJvYcCXxp9KPQaBwCgQxMmN8iUy5J7Upq1tPFiTrRMp2/m6wQqfSpwIQwA4svn5h6bBsFk/QNQHUO2lQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZ4YN8KXvJ6VSYzW75WvcWBpiSeQyr1ipNDz6fcrTI1u2AkGG
	xCVpDm92XNKgo0/G+0WRpkuNF2uCgbGcMaEPad+v9f1U8jx7E4PB
X-Gm-Gg: ASbGncu21QX5TjSasEl60vQJVr3Wn24K0ySiGzZwR/oSZMXhnVyh+NJpY79AfNWNP3x
	3p80MuXhebraekVTnKBkB0caBasbxkb/QoGmWuSDq3cDenQQRRKztIffCEupa7URdYuDVMpB4CQ
	N25mlWjNLZgeJjSAqr8b9d5Jenk16SBsNIsbdkWrpNH5d1IVarVrYH1yBP+RB+dlqi7DQbLXD/l
	k1BMou522M4o0xEElmwqCTiSRIBeet0bbzku5ditzuTbQ==
X-Google-Smtp-Source: AGHT+IGdceYXlbeGTkNw5l06KUhAsLecG4XHCiC5aIAyPHSHXKqy1PsACoW44TB6wtF35ew6vYnrrg==
X-Received: by 2002:a05:6a20:9150:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-1e8b15f7db0mr10329770637.13.1736606800808;
        Sat, 11 Jan 2025 06:46:40 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:46:40 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
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
	linux-doc@vger.kernel.org
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
	ap420073@gmail.com,
	Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH net-next v8 06/10] bnxt_en: add support for rx-copybreak ethtool command
Date: Sat, 11 Jan 2025 14:45:09 +0000
Message-Id: <20250111144513.1289403-7-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111144513.1289403-1-ap420073@gmail.com>
References: <20250111144513.1289403-1-ap420073@gmail.com>
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
But it will be set by `ethtool -G eth0 hds-thresh N`
in the next patch.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Tested-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v8:
 - Add Review tag from Jakub.

v7:
 - return -EBUSY when interface is not running.

v6:
 - No changes.

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

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 +++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 44 ++++++++++++++++++-
 3 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 46edea75e062..9b5ca1e3d99a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -81,7 +81,6 @@ MODULE_DESCRIPTION("Broadcom NetXtreme network driver");
 
 #define BNXT_RX_OFFSET (NET_SKB_PAD + NET_IP_ALIGN)
 #define BNXT_RX_DMA_OFFSET NET_SKB_PAD
-#define BNXT_RX_COPY_THRESH 256
 
 #define BNXT_TX_PUSH_THRESH 164
 
@@ -1343,13 +1342,13 @@ static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi, u8 *data,
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
@@ -1842,7 +1841,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		return NULL;
 	}
 
-	if (len <= bp->rx_copy_thresh) {
+	if (len <= bp->rx_copybreak) {
 		skb = bnxt_copy_skb(bnapi, data_ptr, len, mapping);
 		if (!skb) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
@@ -2176,7 +2175,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		}
 	}
 
-	if (len <= bp->rx_copy_thresh) {
+	if (len <= bp->rx_copybreak) {
 		if (!xdp_active)
 			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
 		else
@@ -4601,6 +4600,11 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
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
@@ -4615,7 +4619,6 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	rx_space = rx_size + ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	bp->rx_copy_thresh = BNXT_RX_COPY_THRESH;
 	ring_size = bp->rx_ring_size;
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
@@ -4660,7 +4663,9 @@ void bnxt_set_ring_params(struct bnxt *bp)
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
@@ -6566,16 +6571,14 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 
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
@@ -16233,6 +16236,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_init_l2_fltr_tbl(bp);
 	bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
+	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_rdma_aux_device_init(bp);
 	rc = bnxt_set_dflt_rings(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 094c9e95b463..7edb92ce5976 100644
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
@@ -2347,7 +2350,7 @@ struct bnxt {
 	enum dma_data_direction	rx_dir;
 	u32			rx_ring_size;
 	u32			rx_agg_ring_size;
-	u32			rx_copy_thresh;
+	u32			rx_copybreak;
 	u32			rx_ring_mask;
 	u32			rx_agg_ring_mask;
 	int			rx_nr_pages;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 75a59dd72bce..e9e63d95df17 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4328,6 +4328,45 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
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
+			if (netif_running(dev))
+				return -EBUSY;
+			bp->rx_copybreak = rx_copybreak;
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
@@ -4790,7 +4829,8 @@ static int bnxt_run_loopback(struct bnxt *bp)
 	cpr = &rxr->bnapi->cp_ring;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		cpr = rxr->rx_cpr;
-	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
+	pkt_size = min(bp->dev->mtu + ETH_HLEN, max(BNXT_DEFAULT_RX_COPYBREAK,
+						    bp->rx_copybreak));
 	skb = netdev_alloc_skb(bp->dev, pkt_size);
 	if (!skb)
 		return -ENOMEM;
@@ -5372,6 +5412,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


