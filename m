Return-Path: <netdev+bounces-274279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANHYLcqszWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:39:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BF5381BAC
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A214A307812C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DBD3F1653;
	Wed,  1 Apr 2026 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="rkXnBe9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AF38837C
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086696; cv=none; b=ptE3JyNwCrUdivC2PEYOwppylBvu4W1k87gnKSt5bUTi6XS0ZRLuczXW/Exc1RdKm6VlcqN335zixt+MPVsXNBE+SJuwRohqRhZby9fYjojrg5wrLRcsmF4FYBOoV2wAvhXn2zgiB/vtRQzD9DtlFFoH+PVf6zF+Jg0VUz9RuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086696; c=relaxed/simple;
	bh=T+3sW2tSFmqzY9x10JWwuzvpwXTF7YlhM3nH61MWTHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xpkcy85CGtTub/Cx8to16e4uxaljXiQXxaeqybf+vzWpQ7cD3de7f0gpoBS3axfUqeOCJX1UghSvPGyaCV6L3eZdJhw+E2V5HeWlVqNmPuuLWhooZAum4UaYRp4Fwx9A/vA95/yS49y//MaQLXqXgHMqn56jNLutXMotAHfuZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=rkXnBe9W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b23f90f53aso2339995ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775086689; x=1775691489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tilJCjiCIv7TTqfGMSjq79lLDNcMp8yDeSbDDHIsBLs=;
        b=rkXnBe9WhcOtEVwYxUH9UAIlnROkWvA43/uOsiJW+gsc7v8mq4pU7b7oyz667xuRZH
         UIONCArWMmARNnjKKSLViRLmoZvOGq0J/L+Lk1Sbp7RRzhczqHNH2wa2wl/bSzmWtTjZ
         zPHtDzgbFJL6NTFjt2SJbYSZAn1sAzrgpf7stZfKD013HrlGumRkJhpSvScdWl44hDtb
         tEivmxGbrd0fyW7Iu84jwOc4RAhIhlaepUByFUa0gChPJpPnCatcZ+sq6trpJXQ+w+18
         bL+ipM1YL05EhYOODMLhXite60lpEa65b802YOlD8iwVJ+pO2N2Pn8HWfkp7OP1QjDld
         Tskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086689; x=1775691489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tilJCjiCIv7TTqfGMSjq79lLDNcMp8yDeSbDDHIsBLs=;
        b=EUqu95RMkl0+XJRnDwlhRopxmWql2jrrlDxCWw16kDefaBNNreOB88wPUobuyffHQx
         /focnQqAYWrUuISnmzL9/S8gktghdd3aQUo8SgUIt3d6yQt4LY66xlQJbqxwOE3Rbv5M
         28Y4aeIgqJHbt09YnWJb4qAc+ng+aLJshxeabXZIHMHsO1TqP577MpNkbLmEKWAbF/z5
         KVWgmPS1LsNgTpAHizSbL9WrbFCK3A3eyKGmBYMo5MrbXCDU7ifFfJFQpzWfHv9Uo+eQ
         ujxJ2bH0d2bYbGLCaD/1WluppP+HdnZzaytrPYWTsedBh26M3Smh84x2FCULOpG2xBzS
         VHrQ==
X-Gm-Message-State: AOJu0Yx+xaERdaH/m69ZASzl/ICHytWsBa29w9TrqLLCgzCVbyWG3xS6
	KriVcvNJYJ/ZF1AqVTNqsI0huiF6Tkjnru6lLCwqao3MRkZST88uHPquqD/mWzZiRZ/3p2To1GE
	n2yQeC/8=
X-Gm-Gg: ATEYQzwOfQL4aedoaYxcnt958x2Eq6AVb1+lzR8H7xVk28R05v2MhsEv5Q3DeojNu6A
	xE4dRVoOc89IIJlPfGiIORPHa/JSOLmwRC2NMm2idF8WaQKOzpljVsyw3Mlijb47OytiEB1O1d+
	XpIcQGeOnguxqgrSIGqo1do2Qb4GMxIkC6koYlyOFZSwOJEq0FrUtl9z0EXCedPJC2vX+sVDzo0
	/5Qc0zkKsQwYvQqmUmm8E4SuFb+8n6qwGoDVO9NZqOaYSoOgTB6Bg2TZdCKEm51lBkXMqIVJO9X
	Cv4OL/wWMdfr6lLz5GQ1iumo9GPNYw2aLZSZUWtOUZf81emvZNf9yfbDqNpmc79Oqoe+Zg+Scbw
	bBiTUrNQU2pESROv3czZTjDxmGJgNVVLNYJwqDBxOZRVEdbojeeyTp92IKUquOzsKNXbJxJ6RUA
	NPPcf9tlIQ5EDS238=
X-Received: by 2002:a17:903:1b0f:b0:2b2:54e5:b3af with SMTP id d9443c01a7336-2b269d8431amr55925345ad.45.1775086689316;
        Wed, 01 Apr 2026 16:38:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm9204835ad.29.2026.04.01.16.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 16:38:08 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v7 08/10] net: bnxt: Add SW GSO completion and teardown support
Date: Wed,  1 Apr 2026 16:37:36 -0700
Message-ID: <20260401233745.2333858-9-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401233745.2333858-1-joe@dama.to>
References: <20260401233745.2333858-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274279-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 35BF5381BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update __bnxt_tx_int and bnxt_free_one_tx_ring_skbs to handle SW GSO
segments:

- MID segments: adjust tx_pkts/tx_bytes accounting and skip skb free
  (the skb is shared across all segments and freed only once)

- LAST segments: call tso_dma_map_complete() to tear down the IOVA
  mapping if one was used. On the fallback path, payload DMA unmapping
  is handled by the existing per-BD dma_unmap_len walk.

Both MID and LAST completions advance tx_inline_cons to release the
segment's inline header slot back to the ring.

is_sw_gso is initialized to zero, so the new code paths are not run.

Add logic for feature advertisement and guardrails for ring sizing.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v7:
   - Dropped Pavan's Reviewed-by because some changes were made.
   - Added helper bnxt_min_tx_desc_cnt to avoid repeated code computing
     descriptor counts.
   - Updated to use tso_dma_map_complete helper instead of calling the DMA
     IOVA API directly.

 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 v3:
   - completion paths updated to use DMA IOVA APIs to teardown mappings.

 rfcv2:
   - Update the shared header buffer consumer on TX completion.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 68 ++++++++++++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  8 +++
 3 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 815c01d75ecc..92a4c270d2f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -74,6 +74,8 @@
 #include "bnxt_debugfs.h"
 #include "bnxt_coredump.h"
 #include "bnxt_hwmon.h"
+#include "bnxt_gso.h"
+#include <net/tso.h>
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -817,12 +819,13 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	bool rc = false;
 
 	while (RING_TX(bp, cons) != hw_cons) {
-		struct bnxt_sw_tx_bd *tx_buf;
+		struct bnxt_sw_tx_bd *tx_buf, *head_buf;
 		struct sk_buff *skb;
 		bool is_ts_pkt;
 		int j, last;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
+		head_buf = tx_buf;
 		skb = tx_buf->skb;
 
 		if (unlikely(!skb)) {
@@ -869,6 +872,20 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
+
+		if (unlikely(head_buf->is_sw_gso)) {
+			txr->tx_inline_cons++;
+			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
+				tso_dma_map_complete(&pdev->dev,
+						     &head_buf->sw_gso_cstate);
+			} else {
+				tx_pkts--;
+				tx_bytes -= skb->len;
+				skb = NULL;
+			}
+			head_buf->is_sw_gso = 0;
+		}
+
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
 				/* PTP worker takes ownership of the skb */
@@ -3412,6 +3429,7 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 	for (i = 0; i < max_idx;) {
 		struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[i];
+		struct bnxt_sw_tx_bd *head_buf = tx_buf;
 		struct sk_buff *skb;
 		int j, last;
 
@@ -3464,7 +3482,17 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
-		dev_kfree_skb(skb);
+		if (head_buf->is_sw_gso) {
+			txr->tx_inline_cons++;
+			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
+				tso_dma_map_complete(&pdev->dev,
+						     &head_buf->sw_gso_cstate);
+			} else {
+				skb = NULL;
+			}
+		}
+		if (skb)
+			dev_kfree_skb(skb);
 	}
 	netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, idx));
 }
@@ -3990,9 +4018,9 @@ static void bnxt_free_tx_inline_buf(struct bnxt_tx_ring_info *txr,
 	txr->tx_inline_size = 0;
 }
 
-static int __maybe_unused bnxt_alloc_tx_inline_buf(struct bnxt_tx_ring_info *txr,
-						   struct pci_dev *pdev,
-						   unsigned int size)
+static int bnxt_alloc_tx_inline_buf(struct bnxt_tx_ring_info *txr,
+				    struct pci_dev *pdev,
+				    unsigned int size)
 {
 	txr->tx_inline_buf = kmalloc(size, GFP_KERNEL);
 	if (!txr->tx_inline_buf)
@@ -4095,6 +4123,14 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 				sizeof(struct tx_push_bd);
 			txr->data_mapping = cpu_to_le64(mapping);
 		}
+		if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+		    (bp->dev->features & NETIF_F_GSO_UDP_L4)) {
+			rc = bnxt_alloc_tx_inline_buf(txr, pdev,
+						      BNXT_SW_USO_MAX_SEGS *
+						      TSO_HEADER_SIZE);
+			if (rc)
+				return rc;
+		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
 		spin_lock_init(&txr->xdp_tx_lock);
@@ -4636,7 +4672,7 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
 	u16 i;
 
 	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
-				   BNXT_MIN_TX_DESC_CNT);
+				   bnxt_min_tx_desc_cnt(bp));
 
 	for (i = 0; i < bp->tx_nr_rings; i++) {
 		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
@@ -13824,6 +13860,11 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
 		features &= ~NETIF_F_NTUPLE;
 
+	if ((features & NETIF_F_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
+		features &= ~NETIF_F_GSO_UDP_L4;
+
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
@@ -13869,6 +13910,9 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 	int rc = 0;
 	bool re_init = false;
 
+	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
+				   bnxt_min_tx_desc_cnt(bp));
+
 	flags &= ~BNXT_FLAG_ALL_CONFIG_FEATS;
 	if (features & NETIF_F_GRO_HW)
 		flags |= BNXT_FLAG_GRO;
@@ -16877,8 +16921,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
 			   NETIF_F_GSO_PARTIAL | NETIF_F_RXHASH |
 			   NETIF_F_RXCSUM | NETIF_F_GRO;
-	if (bp->flags & BNXT_FLAG_UDP_GSO_CAP)
-		dev->hw_features |= NETIF_F_GSO_UDP_L4;
+	dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 	if (BNXT_SUPPORTS_TPA(bp))
 		dev->hw_features |= NETIF_F_LRO;
@@ -16911,8 +16954,15 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->priv_flags |= IFF_UNICAST_FLT;
 
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
-	if (bp->tso_max_segs)
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
+		u16 max_segs = BNXT_SW_USO_MAX_SEGS;
+
+		if (bp->tso_max_segs)
+			max_segs = min_t(u16, max_segs, bp->tso_max_segs);
+		netif_set_tso_max_segs(dev, max_segs);
+	} else if (bp->tso_max_segs) {
 		netif_set_tso_max_segs(dev, bp->tso_max_segs);
+	}
 
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			    NETDEV_XDP_ACT_RX_SG;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index b87ac2bb43dd..a3d17f436b22 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -33,6 +33,7 @@
 #include "bnxt_xdp.h"
 #include "bnxt_ptp.h"
 #include "bnxt_ethtool.h"
+#include "bnxt_gso.h"
 #include "bnxt_nvm_defs.h"	/* NVRAM content constant and structure defs */
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
@@ -852,12 +853,18 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	u8 tcp_data_split = kernel_ering->tcp_data_split;
 	struct bnxt *bp = netdev_priv(dev);
 	u8 hds_config_mod;
+	int rc;
 
 	if ((ering->rx_pending > BNXT_MAX_RX_DESC_CNT) ||
 	    (ering->tx_pending > BNXT_MAX_TX_DESC_CNT) ||
 	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
 		return -EINVAL;
 
+	if ((dev->features & NETIF_F_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    ering->tx_pending < 2 * BNXT_SW_USO_MAX_DESCS)
+		return -EINVAL;
+
 	hds_config_mod = tcp_data_split != dev->cfg->hds_config;
 	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED && hds_config_mod)
 		return -EINVAL;
@@ -882,9 +889,17 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
 
-	if (netif_running(dev))
-		return bnxt_open_nic(bp, false, false);
+	if (netif_running(dev)) {
+		rc = bnxt_open_nic(bp, false, false);
+		if (rc)
+			return rc;
+	}
 
+	/* ring size changes may affect features (SW USO requires a minimum
+	 * ring size), so recalculate features to ensure the correct features
+	 * are blocked/available.
+	 */
+	netdev_update_features(dev);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
index f01e8102dcd7..370b9f4f1db8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -23,6 +23,14 @@
  */
 #define BNXT_SW_USO_MAX_DESCS	(3 * BNXT_SW_USO_MAX_SEGS + MAX_SKB_FRAGS + 1)
 
+static inline int bnxt_min_tx_desc_cnt(struct bnxt *bp)
+{
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    (bp->dev->features & NETIF_F_GSO_UDP_L4))
+		return BNXT_SW_USO_MAX_DESCS;
+	return BNXT_MIN_TX_DESC_CNT;
+}
+
 netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 				 struct bnxt_tx_ring_info *txr,
 				 struct netdev_queue *txq,
-- 
2.52.0


