Return-Path: <netdev+bounces-267224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIxIOvI/s2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:36:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8427AF59
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64B743040327
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DEE3C73FA;
	Thu, 12 Mar 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="dKeeBfCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D134F48D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354927; cv=none; b=hZVAiel3L54SV26nvn0LYdJ/QCYPLiQNyii6KAKs4tF8bUsp7fmCCj9QL6hWh2evJxt9QGw/zFVJi8bCgoSqeAmSL80JDZV9S/zZN8PWPsZ5aOCYxaGohTCavEyX6nVSOErjKyiSOFGfSBBkiYVDSQsJiBuTy+xo9YYkCBXeDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354927; c=relaxed/simple;
	bh=u5+oNe0978EChMIR3JwT6yRD4AgHvONvCIidjJFO510=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upfJUy2e+UXrWjrGzco/vPek0sNVrBVroaRe5xe6O4sgCZMtO2B1JCDjasXUl1Aut58edZj08vzTRKECV08aq1peEIGUIj9r8oHItEN3ApWr7SJ35EYScz73SAYlknEWeo7InTYEnzga/oRhtF7mINcsK7y9R/HOPrPomZZ0r8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=dKeeBfCp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso7847565ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354921; x=1773959721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zCgPu0ORD9SdVm8ZaahrImfIReOfvGCBgxdZWuhJl0=;
        b=dKeeBfCp3LlawKoLjYO3fcNBxlPjL3ekw4igZA1XJHURn1z7iV2tCVJ9kOjJnN0N6X
         Zswt86yh1rP2rr0MRZRpAgi8rwiihviltDxP/N4h5Fab2ZF+qagp3enNyfuhCYQockka
         oVlTizd5mt411yhd3xe/PxwerJlkelb/bQl8D2aqiZRuvbwkkUG361JaLrZ5fqLHExxL
         1g6wZ4m7Xhxx7yw8YFh/VmITH57pNH4vEmxLpeg2vVrZc4RIJMYLLJlDjUC1ckrh1Ho3
         +KyqsFP7tMwHbpxZfPZUptBsO6PYogRBr6YAAq/hizVDefKS0qFegl3CvyR3ren9Zln3
         NyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354921; x=1773959721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3zCgPu0ORD9SdVm8ZaahrImfIReOfvGCBgxdZWuhJl0=;
        b=fCgo6R+/5ncvMBk3z6wbdVlhu7AmeFt83MjGKpN8Un5Ml+BypWOdJNBSG7cBTlfIVo
         48+EL3V6KYJBCUn9etmqm/RY7VataSuVDMdkCiw0OD8LS20P/ciOHy62gJN+khLN2+Xx
         EV33fiOcO3rdsWfTLULTW6G6tSVmXevclysHZzxPvMDwWDoltUb7z8nNEOc+6zzYaOvC
         g18eCGh48x9+vaacDQ56/LGkF9jgHp+jUJv7F/ANShb0HJK8l8UpGyGIbZr6HsSEKtCV
         BklfWFu+Gn8Qoq/nLWw9r5hI1m95UHd44tiCg7dstfioAzGudxH8uAr/AKDnU6O1kH3t
         xI1A==
X-Gm-Message-State: AOJu0YyWCZ8EgsukRVY5+evkrjL47d4Q0ie66ipTITSWkGUfe4Gkb3xq
	Z2RsjxVpzpxNa/z+bJujyKPSbEMXlvjyDLsa5XXfYs8Ra+uKB6reJAetuA9aReOmdSomOGICLLo
	8bSCT4n8=
X-Gm-Gg: ATEYQzy3aUAWZ4OQA2U1Z5At/cQ8upuYO016eXa0Jfz3XbkV/WbVKiiTZP3KIKtPy/f
	DHJEDguc3p/FL1LY3as+Hg/fQh8T/lEqyDyUKYrEr2Z4cufjz1uX5bN1XN3TfoaNces0v1uFpJl
	lsN/qq+wJFYGfrdBzsKIf+k0HgFuyE2esPFsj2tktr+IZj8E+adPdd3pI2lX4n6+oTtZ5c+v/yU
	/SJKPOKcPhuLSPdQyujK0uJXqi62VzbikdweHoHkSOmaMjGRQTntLF4eb9n85sv6oMox8NpxJuC
	/0Ac6CKVwTsSKhmd5mhOYTkE8VK2SfdItnDU1ciEj5YxQk1W8yvkLOsXd3W/us2fSFK1jaOg5Ey
	PYlVeqmK2LiG+LdJq8+Go1GytvBHLODwDPDKjDikguklL33YOH5rExC+Aqrvc12ReAkOgb94gEi
	evAIE=
X-Received: by 2002:a17:903:19e6:b0:2ae:4cb8:484a with SMTP id d9443c01a7336-2aeca9f5549mr9600935ad.17.1773354921438;
        Thu, 12 Mar 2026 15:35:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7edcd1sm33845ad.49.2026.03.12.15.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:21 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 08/12] net: bnxt: Implement software USO
Date: Thu, 12 Mar 2026 15:34:45 -0700
Message-ID: <20260312223457.1999489-9-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267224-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama.to:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 03F8427AF59
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

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 rfcv2:
   - set the unmap len on the last descriptor, so that when completions fire
     only the last completion unmaps the region.

 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 200 ++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index b296769ee4fe..6e186d514a2b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -19,11 +19,211 @@
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
+	struct bnxt_sw_tx_bd *last_unmap_buf = NULL;
+	unsigned int hdr_len, mss, num_segs;
+	unsigned int last_unmap_len = 0;
+	struct pci_dev *pdev = bp->pdev;
+	dma_addr_t last_unmap_addr = 0;
+	unsigned int total_payload;
+	int i, bds_needed, slots;
+	struct tso_dma_map map;
+	u32 vlan_tag_flags = 0;
+	struct tso_t tso;
+	u16 cfa_action;
+	u16 prod;
+
+	hdr_len = tso_start(skb, &tso);
+	mss = skb_shinfo(skb)->gso_size;
+	total_payload = skb->len - hdr_len;
+	num_segs = DIV_ROUND_UP(total_payload, mss);
+
+	/* Zero the csum fields so tso_build_hdr will propagate zeroes into
+	 * every segment header. HW csum offload will recompute from scratch.
+	 */
+	udp_hdr(skb)->check = 0;
+	if (!tso.ipv6)
+		ip_hdr(skb)->check = 0;
+
+	if (unlikely(num_segs <= 1))
+		return NETDEV_TX_OK;
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
+	slots = BNXT_SW_USO_MAX_SEGS - (txr->tx_inline_prod - txr->tx_inline_cons);
+
+	if (unlikely(slots < num_segs)) {
+		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
+				   bp->tx_wake_thresh);
+		return NETDEV_TX_BUSY;
+	}
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
+		void *this_hdr;
+		int bd_count;
+		__le32 csum;
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
+		tx_buf->is_sw_gso = last ? BNXT_SW_GSO_LAST : BNXT_SW_GSO_MID;
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
+		csum = cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM |
+				   TX_BD_FLAGS_IP_CKSUM);
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
-- 
2.52.0


