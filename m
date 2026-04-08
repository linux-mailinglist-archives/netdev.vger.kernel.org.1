Return-Path: <netdev+bounces-276740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EMhIJXf1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:07:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E33C4A52
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D65E302C1D8
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4353A543E;
	Wed,  8 Apr 2026 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="QPJhXZhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE0381B1C
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689595; cv=none; b=UfdSlf1LNxkkWkNA1qJAcJLMajKMObyAvC7kZ1WU/sb9OGis4KVGG0nQSEQZSw9OgENvuoZ7lxLk5JVxkSGQu1aMciAtABZJtmHFxxCvAy2/D7bIhz/oX9rv5p7JCPUntfu/oA4GP2amsV3vz5oqAb7bdkOe24EYu0B4kajV1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689595; c=relaxed/simple;
	bh=r0znbPiRamQbWgnOeDNrPZwKEc4KFxR7p34H/kzdSl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyN8/ivpZXoa05RPefj4GzjYh39aKuBQzW8mObHlQQ5kBdFqAQMjtrS2+7PEiRG8SxsBT6Q0df+HCl4bP4pooy9PRlQZsfIEtY1Kixvjn0/jBZErxylUgJVJjtsz8XZQk23vSPXwJVy/18A+CF+dl85xXJEDty0AOXTprgraQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=QPJhXZhT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b23f90f53aso3338235ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689589; x=1776294389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilY9w1UZiWm/ILI/BayVivC49jozyBguzBsmp+OC5C8=;
        b=QPJhXZhTMkQRWPUOBwd3lU6ZKyD2JQ0nGDZ7nxhfh5XpxfOWideCVxEZAT5E5IJLpK
         9n9HtY9nvHxb++LHwsQFDn5idkpVF/U67cR1CQUYuHlyNLwpizw4nYGtSWFX8m4ySHIs
         pjvmSxLX5Basax2WPImq9hFoZv55LOTIpjB+rJ/OVS8LMVgYqiEktOqbldWs8xtxHpn7
         SZLzJMMbuP8a9AoOynd29xiNkSkHMYDHVmvA3NE4pKU7u5bHn/lIYk4vqsy5MYf57lzY
         jqnj1gmjWyQVPY5NnURaxsRCbgaKFAdezcfV5fJb5OBO5k+hS5Ta2zSUxpT5yNZA4YuC
         2jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689589; x=1776294389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ilY9w1UZiWm/ILI/BayVivC49jozyBguzBsmp+OC5C8=;
        b=qvGJQ15eZ0V5rqR9q6V0cluVCjbnSbwP8DdzKGTBuJZb70U/sXvP12u+PIJWv71fy3
         bkaw/QRZsxNvSTmTbR9IEOXG8olL2uAxxF0P9pQrSdsYsaAFV2hHjNUMwTizTA7JIzxc
         4N/UAvaeABmFYY8KcsFu3rq0IIyfWvgPgvOl1wlB3kZ8ZwopAqPLCu66abqDaEc6u8RT
         6QMjd82wK0WkfpZilo5KRfmIsb2+4f2TZA8xMgzGFVSk5XIO9kPtDbSNwncS6z8jtxpu
         8Vp700lvAvtRR7Bux++ZlwEpQ5ymHJ+WYKeONfXEjRtc5iW1w9ddiz+C+5ir0Qa83zOo
         bQzw==
X-Gm-Message-State: AOJu0YzKLbKGETOqTYkOwvCHPecaYoO827DgcekxIZDebxT/xO/0KvDs
	Z64JNax3B+PSs9owZAaZLlDPGLtNscEsUIhlzA6kEu9p3bDLnf9eAjpLYn2EZK1KsTtKeucNr2a
	XFw+mQkQ=
X-Gm-Gg: AeBDieumTvZEsgKLBNuyrTk9wUB4wHhRrgXa/g7c8/3DPslizkL8SIiZ3F53iiUU5Es
	bKTayjyefTbTV4Ddt26r/hkth48Y1NPGkvj8uq9JhNI5HYcRJgI5k1ymFPALwkGPWLSPd4/pwyB
	KqHHjXuRlsIzok7gvChxs3775xzRTt7oAAboLqYdLdFwsa2wfxlZoxqN37FQWNtq1LQ38qQDpiY
	xeEG3ZIEX8avHGK+6OrWcpcgXLlPgBW5G6iY4mVfPetfTKQ87OqKRD+V6YMq/oJaAhUSZHMe/r0
	bYpe5esb/05lMk6KGlv0DBCfka9cg67qR7PqbOpd7jALeQ/GAo0uG3ecYkyvWRJOUVZD0SGMGYA
	LP4FGDhOg4cjQjqAaqJzIlG9nvI5qZ3JEWapSe0aLp9+33x7RRxdLaeYDn2WBZfXImhOXdup0ue
	IBr9k=
X-Received: by 2002:a17:902:ccc9:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2b2816ca44emr266936545ad.14.1775689588753;
        Wed, 08 Apr 2026 16:06:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2a488caa2sm127336085ad.14.2026.04.08.16.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:28 -0700 (PDT)
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
Subject: [net-next v10 08/10] net: bnxt: Add SW GSO completion and teardown support
Date: Wed,  8 Apr 2026 16:05:57 -0700
Message-ID: <20260408230607.2019402-9-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408230607.2019402-1-joe@dama.to>
References: <20260408230607.2019402-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276740-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email,dama.to:mid,dama-to.20251104.gappssmtp.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 5E7E33C4A52
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
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v10:
   - Wrap tx_inline_cons in WRITE_ONCE to pair with READ_ONCE in
     bnxt_inline_avail.

 v9:
   - Always allocate header buffer for non-HW-USO NICs. Avoids a possible
     NULL deref if USO is toggled off and the device is brought down, up,
     and USO is re-enabled (suggested by AI).
   - Adjust bnxt_min_tx_desc_cnt to take a feature parameter. This is needed
     to prevent stale features from being examined (suggested by AI).

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

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 75 ++++++++++++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  9 +++
 3 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bd93edb09ee0..26aae48a7d0e 100644
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
@@ -869,6 +872,22 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
+
+		if (unlikely(head_buf->is_sw_gso)) {
+			u16 inline_cons = txr->tx_inline_cons + 1;
+
+			WRITE_ONCE(txr->tx_inline_cons, inline_cons);
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
@@ -3412,6 +3431,7 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 	for (i = 0; i < max_idx;) {
 		struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[i];
+		struct bnxt_sw_tx_bd *head_buf = tx_buf;
 		struct sk_buff *skb;
 		int j, last;
 
@@ -3466,7 +3486,20 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 							    DMA_TO_DEVICE, 0);
 			}
 		}
-		dev_kfree_skb(skb);
+		if (head_buf->is_sw_gso) {
+			u16 inline_cons = txr->tx_inline_cons + 1;
+
+			WRITE_ONCE(txr->tx_inline_cons, inline_cons);
+			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
+				tso_dma_map_complete(&pdev->dev,
+						     &head_buf->sw_gso_cstate);
+			} else {
+				skb = NULL;
+			}
+			head_buf->is_sw_gso = 0;
+		}
+		if (skb)
+			dev_kfree_skb(skb);
 	}
 	netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, idx));
 }
@@ -3992,9 +4025,9 @@ static void bnxt_free_tx_inline_buf(struct bnxt_tx_ring_info *txr,
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
@@ -4097,6 +4130,13 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 				sizeof(struct tx_push_bd);
 			txr->data_mapping = cpu_to_le64(mapping);
 		}
+		if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
+			rc = bnxt_alloc_tx_inline_buf(txr, pdev,
+						      BNXT_SW_USO_MAX_SEGS *
+						      TSO_HEADER_SIZE);
+			if (rc)
+				return rc;
+		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
 		spin_lock_init(&txr->xdp_tx_lock);
@@ -4635,10 +4675,13 @@ static int bnxt_init_rx_rings(struct bnxt *bp)
 
 static int bnxt_init_tx_rings(struct bnxt *bp)
 {
+	netdev_features_t features;
 	u16 i;
 
+	features = bp->dev->features;
+
 	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
-				   BNXT_MIN_TX_DESC_CNT);
+				   bnxt_min_tx_desc_cnt(bp, features));
 
 	for (i = 0; i < bp->tx_nr_rings; i++) {
 		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
@@ -13837,6 +13880,11 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
 		features &= ~NETIF_F_NTUPLE;
 
+	if ((features & NETIF_F_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
+		features &= ~NETIF_F_GSO_UDP_L4;
+
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
@@ -13882,6 +13930,9 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 	int rc = 0;
 	bool re_init = false;
 
+	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
+				   bnxt_min_tx_desc_cnt(bp, features));
+
 	flags &= ~BNXT_FLAG_ALL_CONFIG_FEATS;
 	if (features & NETIF_F_GRO_HW)
 		flags |= BNXT_FLAG_GRO;
@@ -16907,8 +16958,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
 			   NETIF_F_GSO_PARTIAL | NETIF_F_RXHASH |
 			   NETIF_F_RXCSUM | NETIF_F_GRO;
-	if (bp->flags & BNXT_FLAG_UDP_GSO_CAP)
-		dev->hw_features |= NETIF_F_GSO_UDP_L4;
+	dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 	if (BNXT_SUPPORTS_TPA(bp))
 		dev->hw_features |= NETIF_F_LRO;
@@ -16941,8 +16991,15 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index 6826bf762d26..9ded88196bb4 100644
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
index 6ba8ccc451de..47528c20f311 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -29,6 +29,15 @@ static inline u16 bnxt_inline_avail(struct bnxt_tx_ring_info *txr)
 	       (u16)(txr->tx_inline_prod - READ_ONCE(txr->tx_inline_cons));
 }
 
+static inline int bnxt_min_tx_desc_cnt(struct bnxt *bp,
+				       netdev_features_t features)
+{
+	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    (features & NETIF_F_GSO_UDP_L4))
+		return BNXT_SW_USO_MAX_DESCS;
+	return BNXT_MIN_TX_DESC_CNT;
+}
+
 netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 				 struct bnxt_tx_ring_info *txr,
 				 struct netdev_queue *txq,
-- 
2.52.0


