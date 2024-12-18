Return-Path: <netdev+bounces-153000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB1B9F6901
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89499166519
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8DA1B424F;
	Wed, 18 Dec 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXavGO9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3E156238;
	Wed, 18 Dec 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533218; cv=none; b=SfEVb7cUQPq6FMS0568TJCn1wyhHUZm4oodry76sPVMbcY2UUv1zHVPDq0z/f8MtMBmKvLT12EzbLUia8NqG7VUVh7LCoQQf5rCBW2l3+Z3eCb6jtMhdz4VA3uY0ZdTF349/zlKf44kyPXaDay7mipokAyi8838sON1I7TemjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533218; c=relaxed/simple;
	bh=f+k9+rN62m9qDWt394hRkV40mI6z1QMtf2CbQzoW0+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmYfBhZ78osHaLUixk4KFa3G10a2S+qK5tPp6ta3yrQsbYTZLUDfb3ftjCV53qQd28TyrRchdNmY6SrV5JYyOEETm9jciuiWuhCgmTZpQ7kP/k10PieLlSFzXsEaVLqnddDvBkgC+WGNL4e/KDRlX6MjwP+F6EmIoaM5JbB2yD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXavGO9M; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725ecc42d43so5640072b3a.3;
        Wed, 18 Dec 2024 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533216; x=1735138016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEKtTmaOJMjBYDbB7DZx12WJWyN2uUzQkj7ulahT+MU=;
        b=lXavGO9MRL8DbIRRH4UMu3qlNvYNNFGeK3bVYspwO17dtQeWOvdU9h1FedKMDkmJ0D
         4ysgp2+2KiPw51P52f/pZhUWt9MLQsWb35S4Q9ncq7rtRgwDyn7nSnu8aL8ZMZi7XOIw
         9TVEkugNjSqypHSp54mBozbnproaO5Gx2s4SDFp5iUGeIZ9oaiFyeeDRYZYbAvjOyvyC
         j3/kCKFNFPb8lP2AKkPWMEYnUKvqWrk4semBCpcYvcgM+XxQG0/Hnyj632+iIqcqOy+y
         4T05br6keEXuOGg2Ejv2EJmMm8w5/+abBtuzPV+YFayIggVVWhZfXHw3gaqbV6yN7mBm
         hDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533216; x=1735138016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEKtTmaOJMjBYDbB7DZx12WJWyN2uUzQkj7ulahT+MU=;
        b=v+qUKJLSxnmpzoUuy4pybTa5Gv9ywT8XgOrzC1DhJgeNLB7F0eGpSHfgJcCWCqNBZd
         hMZuqpdRQOlp2KbFNXNf9C+I9i+uBS87zTzx1izH3p1flga6Z2gKTvyamllLkGxQ4vZY
         fnTavutog8t+6Kofugk7fsokO+YBOQWTm9vH06edRdlevKyZRA+jxp84sx5dsVPVIdZi
         JIXROZyHgCKA+j4yoVRO8fUkBmJIjbrIAcYyVS3ZbZMiL+fsH2FKo8GxvhDBw0E0Ejcy
         dly0lKcJvGbsB2NPIW1KHAPpN9fBd4B7coAu011qVgHRwBpRfuM/wK58H67eeUIao+Sj
         YxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbjTuT3d7UwQqvtSzfiRrg8bmpWEf36SddZtAYNXFCd/exsNqmHQYo4x+6wRqGq/BUmM5Ags7Hyhw=@vger.kernel.org, AJvYcCWrtM8hyWP3LKdu74pdZdr7wJZgFC/31PSC2RC9fh3o9RrP59Fv019FhIaRbs/h+z7tPFKN6fkg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ZVjOhgWK9xi2a2clpu/IpYQVAsO9TJuFjJtYY5y3XvlS18qS
	e/qq+EanETyvsROHV15Amv0MBSJM71Uvt1A0HuJCccS7qUdvallJ
X-Gm-Gg: ASbGncuv7TqiYcEsdO+8U/kYHqH++WDhOKMip1Wo3YbMRybERcaqoZKc0IHI+AoXVlR
	ImXEBpTiTcIxjSCWTkmyGam90RdMG6xW8xWXH6jnU+ZpEXLQhyNp4bGmzzLhLBb4QHrCTrBQvFH
	8j0obI8V890eF88dgGL7KCXZCFk9khwWiiCKWMbBG6oki3nRIh9McXF2dFrp+9qyJHoAbVwqTCM
	KRPlr7CuGD0+UsxM1TfH02/cyRMFwy+jlrZEPX1dSAREg==
X-Google-Smtp-Source: AGHT+IH8D3ZsHyPk7hmi5ozBRg6R3YCx01W67p64ytXQEMVFh9Rd+01Igp12+BbZVp/TY3zSxoNcHA==
X-Received: by 2002:aa7:9316:0:b0:725:df1a:275 with SMTP id d2e1a72fcca58-72a8d2c9c99mr5412619b3a.23.1734533215515;
        Wed, 18 Dec 2024 06:46:55 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:46:54 -0800 (PST)
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
	ap420073@gmail.com,
	Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH net-next v6 1/9] bnxt_en: add support for rx-copybreak ethtool command
Date: Wed, 18 Dec 2024 14:45:22 +0000
Message-Id: <20241218144530.2963326-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218144530.2963326-1-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
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

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Tested-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

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

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 ++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 49 ++++++++++++++++++-
 3 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b86f980fa7ea..c31894b9187e 100644
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
@@ -16188,6 +16191,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_init_l2_fltr_tbl(bp);
 	bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
+	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_rdma_aux_device_init(bp);
 	rc = bnxt_set_dflt_rings(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7df7a2233307..b73de5683063 100644
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
@@ -2342,7 +2345,7 @@ struct bnxt {
 	enum dma_data_direction	rx_dir;
 	u32			rx_ring_size;
 	u32			rx_agg_ring_size;
-	u32			rx_copy_thresh;
+	u32			rx_copybreak;
 	u32			rx_ring_mask;
 	u32			rx_agg_ring_mask;
 	int			rx_nr_pages;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index d87681d71106..4cdfff5d531c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4327,6 +4327,50 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
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
@@ -4777,7 +4821,8 @@ static int bnxt_run_loopback(struct bnxt *bp)
 	cpr = &rxr->bnapi->cp_ring;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		cpr = rxr->rx_cpr;
-	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
+	pkt_size = min(bp->dev->mtu + ETH_HLEN, max(BNXT_DEFAULT_RX_COPYBREAK,
+						    bp->rx_copybreak));
 	skb = netdev_alloc_skb(bp->dev, pkt_size);
 	if (!skb)
 		return -ENOMEM;
@@ -5350,6 +5395,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


