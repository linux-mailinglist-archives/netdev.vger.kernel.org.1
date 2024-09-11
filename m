Return-Path: <netdev+bounces-127433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF5975625
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117CF1C2616B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4363A1A76AB;
	Wed, 11 Sep 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbHCfzWQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD11AB6EF;
	Wed, 11 Sep 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066582; cv=none; b=skTZvcHQ+ZATy861min0Jwte7NJ8+//YPjsK9xryfJmHzlKrYU8BmcrufvHLvX5sGAn4BhHjz52vmKffqgddMKgoT5SsD747aeTjkB7EufosmrJy4gZYcdb5YDduP44iBiX6/EV3OnMvc0WkQJB+DTnMlj9FJyNTbsJzEf55yQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066582; c=relaxed/simple;
	bh=jNEuektr9cxfdgrOio3CsvBFVNok/dz37JrRSqsN358=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9C+HgauIul40elv51YmT/TQYsjH31mQ6AG8uqluGpSR9oV9cg0tiEXyFUfNKHVtqRGY5letdnUu1Si8K+fi9PYFHO7KnCxfGco7DlgV3uL+a8zzjbSPjwXloAluS/mI6ZkeT9o5SK/JR6syEmIzh1qIzBjrrSNbG7K4UNKhhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbHCfzWQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718816be6cbso4874219b3a.1;
        Wed, 11 Sep 2024 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066580; x=1726671380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNG2hx/XNKiQz0+4KMHEnpam4YQGht6jgnU1nTj2+2k=;
        b=WbHCfzWQpyN27vFvX6SrhXLcwNM2JKuHhgK8pnZIU0oY7bGT9OHNg53+K31gYVi6Gg
         rPjiudz9kbe2cCdLrIFyfNXfLNCVXAx+R6CLhvR2BVwZGCiCah0jIwl7yh1hx5WYBhhR
         ATTDr2DF7dxyfH3v7aVMGhwaokmOD4SAp4V+1j1QhYpeeBvs1jXE9lmWBB1HPAE5FdDm
         zc+PBysPnADF2z84kyelPZRqoABNQBFSqCK8eccRliWGdve8osbp+AmEpwHyqW8uRK6y
         FR/RQL13GESBOxoNPHgrRkRvUhZtgIWTj47jKJZxu3pQiBpnNL7T3u0qulV4ZFERyNEt
         Myjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066580; x=1726671380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNG2hx/XNKiQz0+4KMHEnpam4YQGht6jgnU1nTj2+2k=;
        b=IIgI/OJq6TbqzMyIazxbGi3yEWl+QaaaxQLtAZApnYzQobFEBmVVUSzL1jMyV7khDY
         ymPxZDpShb1DbooltSrjnA7LQJ9oGFizhrM9dMUATXx5XlWPLARdwDqKw+S/uEGkPCuc
         MVwDcwiJzhkkTjnNyDrPDE+bP3KeNTEdufoNc/TQaKsuCIt2T7paxQXxokIz26bCUXz3
         0A2SE6sxdAyMIUJ87+Qv/7LL24KDFGEugipnEFP/QbBPSuIDJ8240NhkiIl1iRGiGVjQ
         XP98WIFTDm95uWJxJV7/IoiWixdDIRfBq9jFCAf6U2wrSkmjjVSpIpaTBOpctertbbCc
         c0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUOtdDFl+h27u/4cJcO6/gijywgFu9+wCIAMXhdJBg0vjuicb+zrVJZ8sOACjG3PNYj+1M1AGoGUyQ=@vger.kernel.org, AJvYcCVwAcCF+dCtlB5P2yKylgfMYTjZmxqwPiYdd+M8ubc+ERFWv4Zp8c/U+PZ8EkIfJs5+SJzoKhEj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pXQ4BCAIcERHN3D6LcTOloe3CNvsjiMzGQcjDtFy5GjDp5gO
	u5ESdBREQt/GHt7G6x1u/WgDO5rNWXHL1ccWgQpdZmN0eJ4E3Dg7
X-Google-Smtp-Source: AGHT+IF592StJiWtw7O0kU+OyBSfiXv3x72HMOLRbu9S4Pec2fG0HB5K/qEUwiIG4K6XKlH63YGDcg==
X-Received: by 2002:a05:6a21:513:b0:1cf:337e:98f6 with SMTP id adf61e73a8af0-1cf5e13350amr4689266637.29.1726066579476;
        Wed, 11 Sep 2024 07:56:19 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af278aasm664995ad.28.2024.09.11.07.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:56:18 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	kory.maincent@bootlin.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	aleksander.lobakin@intel.com,
	ap420073@gmail.com
Subject: [PATCH net-next v2 1/4] bnxt_en: add support for rx-copybreak ethtool command
Date: Wed, 11 Sep 2024 14:55:52 +0000
Message-Id: <20240911145555.318605-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911145555.318605-1-ap420073@gmail.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
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

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Define max/vim rx_copybreak value.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 24 ++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  6 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 47 ++++++++++++++++++-
 3 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..8da211e083a4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -81,7 +81,6 @@ MODULE_DESCRIPTION("Broadcom NetXtreme network driver");
 
 #define BNXT_RX_OFFSET (NET_SKB_PAD + NET_IP_ALIGN)
 #define BNXT_RX_DMA_OFFSET NET_SKB_PAD
-#define BNXT_RX_COPY_THRESH 256
 
 #define BNXT_TX_PUSH_THRESH 164
 
@@ -1330,13 +1329,13 @@ static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi, u8 *data,
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
@@ -1829,7 +1828,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		return NULL;
 	}
 
-	if (len <= bp->rx_copy_thresh) {
+	if (len <= bp->rx_copybreak) {
 		skb = bnxt_copy_skb(bnapi, data_ptr, len, mapping);
 		if (!skb) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
@@ -1931,6 +1930,7 @@ static void bnxt_deliver_skb(struct bnxt *bp, struct bnxt_napi *bnapi,
 		bnxt_vf_rep_rx(bp, skb);
 		return;
 	}
+
 	skb_record_rx_queue(skb, bnapi->index);
 	napi_gro_receive(&bnapi->napi, skb);
 }
@@ -2162,7 +2162,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		}
 	}
 
-	if (len <= bp->rx_copy_thresh) {
+	if (len <= bp->rx_copybreak) {
 		if (!xdp_active)
 			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
 		else
@@ -4451,6 +4451,11 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
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
@@ -4465,7 +4470,6 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	rx_space = rx_size + ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	bp->rx_copy_thresh = BNXT_RX_COPY_THRESH;
 	ring_size = bp->rx_ring_size;
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
@@ -4510,7 +4514,8 @@ void bnxt_set_ring_params(struct bnxt *bp)
 				  ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
 				  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		} else {
-			rx_size = SKB_DATA_ALIGN(BNXT_RX_COPY_THRESH + NET_IP_ALIGN);
+			rx_size = SKB_DATA_ALIGN(bp->rx_copybreak +
+						 NET_IP_ALIGN);
 			rx_space = rx_size + NET_SKB_PAD +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		}
@@ -6424,8 +6429,8 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
 		req->enables |=
 			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
-		req->jumbo_thresh = cpu_to_le16(bp->rx_copy_thresh);
-		req->hds_threshold = cpu_to_le16(bp->rx_copy_thresh);
+		req->jumbo_thresh = cpu_to_le16(bp->rx_copybreak);
+		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
 	return hwrm_req_send(bp, req);
@@ -15864,6 +15869,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_init_l2_fltr_tbl(bp);
 	bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
+	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_rdma_aux_device_init(bp);
 	rc = bnxt_set_dflt_rings(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 69231e85140b..cff031993223 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -34,6 +34,10 @@
 #include <linux/firmware/broadcom/tee_bnxt_fw.h>
 #endif
 
+#define BNXT_DEFAULT_RX_COPYBREAK 256
+#define BNXT_MIN_RX_COPYBREAK 65
+#define BNXT_MAX_RX_COPYBREAK 1024
+
 extern struct list_head bnxt_block_cb_list;
 
 struct page_pool;
@@ -2299,7 +2303,7 @@ struct bnxt {
 	enum dma_data_direction	rx_dir;
 	u32			rx_ring_size;
 	u32			rx_agg_ring_size;
-	u32			rx_copy_thresh;
+	u32			rx_copybreak;
 	u32			rx_ring_mask;
 	u32			rx_agg_ring_mask;
 	int			rx_nr_pages;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f71cc8188b4e..201c3fcba04e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4319,6 +4319,49 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
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
+		if (rx_copybreak < BNXT_MIN_RX_COPYBREAK ||
+		    rx_copybreak > BNXT_MAX_RX_COPYBREAK)
+			return -EINVAL;
+		if (rx_copybreak != bp->rx_copybreak) {
+			bp->rx_copybreak = rx_copybreak;
+			if (netif_running(dev)) {
+				bnxt_close_nic(bp, false, false);
+				bnxt_set_ring_params(bp);
+				bnxt_open_nic(bp, false, false);
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
@@ -4769,7 +4812,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
 	cpr = &rxr->bnapi->cp_ring;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		cpr = rxr->rx_cpr;
-	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
+	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copybreak);
 	skb = netdev_alloc_skb(bp->dev, pkt_size);
 	if (!skb)
 		return -ENOMEM;
@@ -5342,6 +5385,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


