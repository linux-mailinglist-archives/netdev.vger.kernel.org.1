Return-Path: <netdev+bounces-276739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EfcEYPg1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:10:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F53C4B20
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F30030D32D3
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623CA379ED7;
	Wed,  8 Apr 2026 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="eeA1a6jl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217A383C7E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689592; cv=none; b=kUjxudDsdhWClE+DXWCytTKdveCjRY0+GLJzEfmyCWXYnHlJwq/q4Es+mgrtNYU9Rb3o4u9KTTW3LpnpVldyDp08ctU7og8IBZac+76vxKFbXb/YxT8XBvW4NMSLjyxC3TWAlmBpZlvY2RqGDZWddgccYDM/ZGiB8Wgf9HsOqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689592; c=relaxed/simple;
	bh=oxJ3LwxSwwc0LnddS9sQc1dmXDbXx5hORvtiE2/j/DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKdSzsLUnvQmTaReGaG8ofhdSqik9XXInHH3TiwmTnWmv1lZvk1HRRKfNIbI7LfGifsOMXAnuljAgWOVpEbAmP6NtwvJRk2oq2Ro/vrJ1/pa6Ked66Ke2yBfdTx7SsRpAIlJSURIAf1yiaqNqDPCTMu4dk7/H34T3h9KNR8bP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=eeA1a6jl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9a9be502so2127475ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689587; x=1776294387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7bTsPTNXSPKGGJZeRPb0v0fjH1kEH3FFQpQ70Mka9c=;
        b=eeA1a6jlLrwZvctAWLaRvCSWfbPfwZXqfe3fUYFS0fpz1ZmuQAK/aU1YYmul4Gg8Pl
         zWfLtT/+xv0+AgmMXMbV6ZmzTQFsh4pdVCQTKhR61iB6uqmyJJk+LvzK+/lDt495OSMq
         +LZ4qaTuScoicc5DAQsrd2GIehlGEMGvmEJhcAgyaTi4YqCO9AB1u+SUNSCXofUcfKKt
         2WjFsVan27MKDYUNQhiZbAkl5VuByjoLaXpJZiKUK2VDN91UCwOC33yj+8NhaWuuGnQG
         78YfdJTURBllFa60n4fxxXE25LytAGv7r0sUtU7TjrPJa12qgQaLTBOB4WtXlmgEgJSV
         6yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689587; x=1776294387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7bTsPTNXSPKGGJZeRPb0v0fjH1kEH3FFQpQ70Mka9c=;
        b=Jp5d+dlJ1WF52a6Anr2LcXobyCAPqkBTEklfFh/BiZpnsXrNlwwnKLtUx5ojaLNTeW
         gbBzVB5HrdDpbmo1D3TjuOKaOy7U2OYdmbklR9EGhAqxsxOF5oVv+90Zo+Vx7nlJICDN
         ddg5sw3Bt1eNgG6EBOwBBvGwoBleBSHCdPLU3uwGQOVbe1P39IEbESMss9cfiTBPFrTh
         AWln14uLKH0dIljgstKh3YSs4yEKCZFyODmKjKcFYi4K30+f8NQAF27WPctGr2RMZirH
         OKxLMHvqzyWC9FrSt2DbG7yjvyMQ5cPvHiGkl4jc0+UszSqJK2dNxoPHKETPfK5ttxG6
         3X/g==
X-Gm-Message-State: AOJu0YzSZ3KBlW14CqX3Bytsn96+pYMEL3tyOc8UkftZsprIy7H5pu64
	j6fxllylByB46RpYVQRG+xfO/caGKAxtR4by0k84QMQ3WBXwyMVteRKwG202hnO9zNq9O3WO7oT
	gaa+NAKs=
X-Gm-Gg: AeBDiesd+feEu++tlCCLd4p0decMAdTN4jUbjXxP6jSUSjtGIQL/3ew66XQeeO79Kxu
	Z/3aH5IF3bJeFrHBBSam1eE/+uqMYp2B6iDbkpOv6jFRNS9RMt5FFITl7iK42ztvvxPuKh3WXiB
	sul6D79Nm6roRJEWx+nw2oBFdvVc0+7T9o+C/cIgJy9Eg13bSiqz382NsBB2vSI0ptPH3xL2Gih
	OAPMNzTnoRRdj0dtWENv3vwJ3BPVQwmcbQevfA88fuvBL5MsOXgzvz3LFz7XD6nw+7c1xrqJgpk
	fB9kg1lMaewBb1N1IhgYwLvRMuV5YiQ5NrxdFUzUjcJpQy4fDKbOTL9zeCs34zS3E2RM9Z5pcbK
	Kd/941Dy0l0WOM47GxdHNGAjTlFimQxnehtGghaVVLWZMVMRY9WcuaTQu5cX4HYyE1Zt/r6gOah
	MRmAOn
X-Received: by 2002:a17:903:1aab:b0:2b0:72c7:3ed8 with SMTP id d9443c01a7336-2b2c7340a5bmr13462005ad.25.1775689586629;
        Wed, 08 Apr 2026 16:06:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27475ff56sm213190855ad.22.2026.04.08.16.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:26 -0700 (PDT)
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
Subject: [net-next v10 07/10] net: bnxt: Implement software USO
Date: Wed,  8 Apr 2026 16:05:56 -0700
Message-ID: <20260408230607.2019402-8-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A53F53C4B20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement bnxt_sw_udp_gso_xmit() using the core tso_dma_map API and
the pre-allocated TX inline buffer for per-segment headers.

The xmit path:
1. Calls tso_start() to initialize TSO state
2. Stack-allocates a tso_dma_map and calls tso_dma_map_init() to
   DMA-map the linear payload and all frags upfront.
3. For each segment:
   - Copies and patches headers via tso_build_hdr() into the
     pre-allocated tx_inline_buf (DMA-synced per segment)
   - Counts payload BDs via tso_dma_map_count()
   - Emits long BD (header) + ext BD + payload BDs
   - Payload BDs use tso_dma_map_next() which yields (dma_addr,
     chunk_len, mapping_len) tuples.

Header BDs set dma_unmap_len=0 since the inline buffer is pre-allocated
and unmapped only at ring teardown.

Completion state is updated by calling tso_dma_map_completion_save() for
the last segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v10:
   - Fixes the inline slot check added in the v9. Uses netif_txq_maybe_stop
     and an inline helper.

 v9:
   - Added inline slot check to prevent possible overwriting of in-flight
     headers (suggested by AI).
   - Set TX_BD_FLAGS_IP_CKSUM conditionally on !tso.ipv6 (suggested by AI).

 v8:
   - Zero csum fields on per-segment header copy after tso_build_hdr()
     instead of on the original skb, avoiding the need for skb_cow_head, as
     suggested by Eric Dumazet.

 v7:
   - Dropped Pavan's Reviewed-by as some changes were made.
   - Updated struct bnxt_sw_tx_bd to embed a tso_dma_map_completion_state
     struct for tracking completion state.
   - Dropped an unnecessary slot check.
   - Eliminated an ugly looking ternary to simplify the code.
   - Call tso_dma_map_completion_save to update completion state.

 v6:
   - Addressed Paolo's feedback where the IOVA API could fail transiently,
     leaving stale state in iova_state. Fix this by always copying the state,
     noting that dma_iova_try_alloc is called unconditionally in the
     tso_dma_map_init function (via tso_dma_iova_try), which zeroes the state
     even if the API can't be used.
   - Since this was a very minor change, I retained Pavan's Reviewed-by.

 v5:
   - Added __maybe_unused to last_unmap_len and last_unmap_addr to silence a
     build warning when CONFIG_NEED_DMA_MAP_STATE is disabled. No functional
     changes.
   - Added Pavan's Reviewed-by.

 v4:
   - Fixed the early return issue Pavan pointed out when num_segs <= 1; use the
     drop label instead of returning.

 v3:
   - Added iova_state and iova_total_len to struct bnxt_sw_tx_bd.
   - Stores iova_state on the last segment's tx_buf during xmit.

 rfcv2:
   - set the unmap len on the last descriptor, so that when completions fire
     only the last completion unmaps the region.

 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 210 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |   6 +
 3 files changed, 219 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6b38b84924e0..fe50576ae525 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -11,6 +11,8 @@
 #ifndef BNXT_H
 #define BNXT_H
 
+#include <net/tso.h>
+
 #define DRV_MODULE_NAME		"bnxt_en"
 
 /* DO NOT CHANGE DRV_VER_* defines
@@ -899,6 +901,7 @@ struct bnxt_sw_tx_bd {
 		u16			rx_prod;
 		u16			txts_prod;
 	};
+	struct tso_dma_map_completion_state sw_gso_cstate;
 };
 
 #define BNXT_SW_GSO_MID		1
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index b296769ee4fe..f317f60414e8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -19,11 +19,221 @@
 #include "bnxt.h"
 #include "bnxt_gso.h"
 
+static u32 bnxt_sw_gso_lhint(unsigned int len)
+{
+	if (len <= 512)
+		return TX_BD_FLAGS_LHINT_512_AND_SMALLER;
+	else if (len <= 1023)
+		return TX_BD_FLAGS_LHINT_512_TO_1023;
+	else if (len <= 2047)
+		return TX_BD_FLAGS_LHINT_1024_TO_2047;
+	else
+		return TX_BD_FLAGS_LHINT_2048_AND_LARGER;
+}
+
 netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 				 struct bnxt_tx_ring_info *txr,
 				 struct netdev_queue *txq,
 				 struct sk_buff *skb)
 {
+	unsigned int last_unmap_len __maybe_unused = 0;
+	dma_addr_t last_unmap_addr __maybe_unused = 0;
+	struct bnxt_sw_tx_bd *last_unmap_buf = NULL;
+	unsigned int hdr_len, mss, num_segs;
+	struct pci_dev *pdev = bp->pdev;
+	unsigned int total_payload;
+	struct tso_dma_map map;
+	u32 vlan_tag_flags = 0;
+	int i, bds_needed;
+	struct tso_t tso;
+	u16 cfa_action;
+	__le32 csum;
+	u16 prod;
+
+	hdr_len = tso_start(skb, &tso);
+	mss = skb_shinfo(skb)->gso_size;
+	total_payload = skb->len - hdr_len;
+	num_segs = DIV_ROUND_UP(total_payload, mss);
+
+	if (unlikely(num_segs <= 1))
+		goto drop;
+
+	/* Upper bound on the number of descriptors needed.
+	 *
+	 * Each segment uses 1 long BD + 1 ext BD + payload BDs, which is
+	 * at most num_segs + nr_frags (each frag boundary crossing adds at
+	 * most 1 extra BD).
+	 */
+	bds_needed = 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
+
+	if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
+		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
+				   bp->tx_wake_thresh);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* BD backpressure alone cannot prevent overwriting in-flight
+	 * headers in the inline buffer. Check slot availability directly.
+	 */
+	if (!netif_txq_maybe_stop(txq, bnxt_inline_avail(txr),
+				  num_segs, num_segs))
+		return NETDEV_TX_BUSY;
+
+	if (unlikely(tso_dma_map_init(&map, &pdev->dev, skb, hdr_len)))
+		goto drop;
+
+	cfa_action = bnxt_xmit_get_cfa_action(skb);
+	if (skb_vlan_tag_present(skb)) {
+		vlan_tag_flags = TX_BD_CFA_META_KEY_VLAN |
+				 skb_vlan_tag_get(skb);
+		if (skb->vlan_proto == htons(ETH_P_8021Q))
+			vlan_tag_flags |= 1 << TX_BD_CFA_META_TPID_SHIFT;
+	}
+
+	csum = cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
+	if (!tso.ipv6)
+		csum |= cpu_to_le32(TX_BD_FLAGS_IP_CKSUM);
+
+	prod = txr->tx_prod;
+
+	for (i = 0; i < num_segs; i++) {
+		unsigned int seg_payload = min_t(unsigned int, mss,
+						 total_payload - i * mss);
+		u16 slot = (txr->tx_inline_prod + i) &
+			   (BNXT_SW_USO_MAX_SEGS - 1);
+		struct bnxt_sw_tx_bd *tx_buf;
+		unsigned int mapping_len;
+		dma_addr_t this_hdr_dma;
+		unsigned int chunk_len;
+		unsigned int offset;
+		dma_addr_t dma_addr;
+		struct tx_bd *txbd;
+		struct udphdr *uh;
+		void *this_hdr;
+		int bd_count;
+		bool last;
+		u32 flags;
+
+		last = (i == num_segs - 1);
+		offset = slot * TSO_HEADER_SIZE;
+		this_hdr = txr->tx_inline_buf + offset;
+		this_hdr_dma = txr->tx_inline_dma + offset;
+
+		tso_build_hdr(skb, this_hdr, &tso, seg_payload, last);
+
+		/* Zero stale csum fields copied from the original skb;
+		 * HW offload recomputes from scratch.
+		 */
+		uh = this_hdr + skb_transport_offset(skb);
+		uh->check = 0;
+		if (!tso.ipv6) {
+			struct iphdr *iph = this_hdr + skb_network_offset(skb);
+
+			iph->check = 0;
+		}
+
+		dma_sync_single_for_device(&pdev->dev, this_hdr_dma,
+					   hdr_len, DMA_TO_DEVICE);
+
+		bd_count = tso_dma_map_count(&map, seg_payload);
+
+		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+
+		tx_buf->skb = skb;
+		tx_buf->nr_frags = bd_count;
+		tx_buf->is_push = 0;
+		tx_buf->is_ts_pkt = 0;
+
+		dma_unmap_addr_set(tx_buf, mapping, this_hdr_dma);
+		dma_unmap_len_set(tx_buf, len, 0);
+
+		if (last) {
+			tx_buf->is_sw_gso = BNXT_SW_GSO_LAST;
+			tso_dma_map_completion_save(&map, &tx_buf->sw_gso_cstate);
+		} else {
+			tx_buf->is_sw_gso = BNXT_SW_GSO_MID;
+		}
+
+		flags = (hdr_len << TX_BD_LEN_SHIFT) |
+			TX_BD_TYPE_LONG_TX_BD |
+			TX_BD_CNT(2 + bd_count);
+
+		flags |= bnxt_sw_gso_lhint(hdr_len + seg_payload);
+
+		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
+		txbd->tx_bd_haddr = cpu_to_le64(this_hdr_dma);
+		txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod,
+						   2 + bd_count);
+
+		prod = NEXT_TX(prod);
+		bnxt_init_ext_bd(bp, txr, prod, csum,
+				 vlan_tag_flags, cfa_action);
+
+		/* set dma_unmap_len on the LAST BD touching each
+		 * region. Since completions are in-order, the last segment
+		 * completes after all earlier ones, so the unmap is safe.
+		 */
+		while (tso_dma_map_next(&map, &dma_addr, &chunk_len,
+					&mapping_len, seg_payload)) {
+			prod = NEXT_TX(prod);
+			txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+			tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+
+			txbd->tx_bd_haddr = cpu_to_le64(dma_addr);
+			dma_unmap_addr_set(tx_buf, mapping, dma_addr);
+			dma_unmap_len_set(tx_buf, len, 0);
+			tx_buf->skb = NULL;
+			tx_buf->is_sw_gso = 0;
+
+			if (mapping_len) {
+				if (last_unmap_buf) {
+					dma_unmap_addr_set(last_unmap_buf,
+							   mapping,
+							   last_unmap_addr);
+					dma_unmap_len_set(last_unmap_buf,
+							  len,
+							  last_unmap_len);
+				}
+				last_unmap_addr = dma_addr;
+				last_unmap_len = mapping_len;
+			}
+			last_unmap_buf = tx_buf;
+
+			flags = chunk_len << TX_BD_LEN_SHIFT;
+			txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
+			txbd->tx_bd_opaque = 0;
+
+			seg_payload -= chunk_len;
+		}
+
+		txbd->tx_bd_len_flags_type |=
+			cpu_to_le32(TX_BD_FLAGS_PACKET_END);
+
+		prod = NEXT_TX(prod);
+	}
+
+	if (last_unmap_buf) {
+		dma_unmap_addr_set(last_unmap_buf, mapping, last_unmap_addr);
+		dma_unmap_len_set(last_unmap_buf, len, last_unmap_len);
+	}
+
+	txr->tx_inline_prod += num_segs;
+
+	netdev_tx_sent_queue(txq, skb->len);
+
+	WRITE_ONCE(txr->tx_prod, prod);
+	/* Sync BDs before doorbell */
+	wmb();
+	bnxt_db_write(bp, &txr->tx_db, prod);
+
+	if (unlikely(bnxt_tx_avail(bp, txr) <= bp->tx_wake_thresh))
+		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
+				   bp->tx_wake_thresh);
+
+	return NETDEV_TX_OK;
+
+drop:
 	dev_kfree_skb_any(skb);
 	dev_core_stats_tx_dropped_inc(bp->dev);
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
index f01e8102dcd7..6ba8ccc451de 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -23,6 +23,12 @@
  */
 #define BNXT_SW_USO_MAX_DESCS	(3 * BNXT_SW_USO_MAX_SEGS + MAX_SKB_FRAGS + 1)
 
+static inline u16 bnxt_inline_avail(struct bnxt_tx_ring_info *txr)
+{
+	return BNXT_SW_USO_MAX_SEGS -
+	       (u16)(txr->tx_inline_prod - READ_ONCE(txr->tx_inline_cons));
+}
+
 netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 				 struct bnxt_tx_ring_info *txr,
 				 struct netdev_queue *txq,
-- 
2.52.0


