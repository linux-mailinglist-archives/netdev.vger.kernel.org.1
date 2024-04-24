Return-Path: <netdev+bounces-90719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586818AFD46
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6001F2279D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B79363;
	Wed, 24 Apr 2024 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thG5DMT8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6A7EF
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918110; cv=none; b=dgUAdcmEqsUk96EQI/F+/8BvsNtLfARBs5jSLIj5Hiv5vFBwFpX/f0B27vx2G6m+UKp9Y+N6GaRx/TkRLeO8KLXqZZMRXRMmL7Tcq6CAAqq+6OnTMdUOZhuvm2lgEjs+e4EFpmAnVBNtrQgcDdxMHFkUtQtLaXYJzUAiAFh+Cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918110; c=relaxed/simple;
	bh=6XtW0KJgqBppYV22P7XMT1ak80/Kvtl9z03TgIpKic4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpNucYt10WExtJkVMhYoDI/uQuJoNSOnZqwfGLhC+U5Pbj1vlwaDbQLVVTSvFJH2BVd537Y6TBpER8swYhUuSHRY62ybuTjVci7dOCXFUaZi/U4LqXUGf9kBx4i3VxNGwSBOoJW4ILLcKZ4NR+5J1MFBOWV1E7ft1jRcSMgBMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thG5DMT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ED7C116B1;
	Wed, 24 Apr 2024 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713918110;
	bh=6XtW0KJgqBppYV22P7XMT1ak80/Kvtl9z03TgIpKic4=;
	h=From:To:Cc:Subject:Date:From;
	b=thG5DMT8KGhp2s7ZmXQUJA4iKvWvIPI5fGWwaLdNfMGKVq2nQ3CdKfH+Yyxz2u3MR
	 9JJmB5/IXKlVUikJV4PJp55M0MVm/j5QhtsYzzczW6DIQneBcbdZ/GKWxSEj3MfjOS
	 5PO9tbKV61GpIy06U+WXIj5DQA5cqiFE0s2QpYjChrk1C1ex0TgFpR9WLl/T3IOonL
	 u2Qln7SkgYnOdtXdVnoE4es+7Jq0GzQrUN7VgrXIcv6eRnxGby6bYzai+Kh7bz84gL
	 hamWa0S7g8UdipYpVZmvOFR829Qy5dBdTVEUvoT7AEJCo+Du3sqD5m8kg4quacgfAI
	 BUzsexPc6AN3A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	edwin.peer@broadcom.com
Subject: [PATCH net] eth: bnxt: fix counting packets discarded due to OOM and netpoll
Date: Tue, 23 Apr 2024 17:21:48 -0700
Message-ID: <20240424002148.3937059-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I added OOM and netpoll discard counters, naively assuming that
the cpr pointer is pointing to a common completion ring.
Turns out that is usually *a* completion ring but not *the*
completion ring which bnapi->cp_ring points to. bnapi->cp_ring
is where the stats are read from, so we end up reporting 0
thru ethtool -S and qstat even though the drop events have happened.
Make 100% sure we're recording statistics in the correct structure.

Fixes: 907fd4a294db ("bnxt: count discards due to memory allocation errors")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: edwin.peer@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 44 ++++++++++-------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a30df865be7b..88cba1e52903 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1811,7 +1811,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		skb = bnxt_copy_skb(bnapi, data_ptr, len, mapping);
 		if (!skb) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->sw_stats.rx.rx_oom_discards += 1;
+			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
 			return NULL;
 		}
 	} else {
@@ -1821,7 +1821,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		new_data = __bnxt_alloc_rx_frag(bp, &new_mapping, GFP_ATOMIC);
 		if (!new_data) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->sw_stats.rx.rx_oom_discards += 1;
+			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
 			return NULL;
 		}
 
@@ -1837,7 +1837,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		if (!skb) {
 			skb_free_frag(data);
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->sw_stats.rx.rx_oom_discards += 1;
+			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
 			return NULL;
 		}
 		skb_reserve(skb, bp->rx_offset);
@@ -1848,7 +1848,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bufs, true);
 		if (!skb) {
 			/* Page reuse already handled by bnxt_rx_pages(). */
-			cpr->sw_stats.rx.rx_oom_discards += 1;
+			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
 			return NULL;
 		}
 	}
@@ -2127,11 +2127,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &xdp,
 							     cp_cons, agg_bufs,
 							     false);
-			if (!frag_len) {
-				cpr->sw_stats.rx.rx_oom_discards += 1;
-				rc = -ENOMEM;
-				goto next_rx;
-			}
+			if (!frag_len)
+				goto oom_next_rx;
 		}
 		xdp_active = true;
 	}
@@ -2157,9 +2154,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				else
 					bnxt_xdp_buff_frags_free(rxr, &xdp);
 			}
-			cpr->sw_stats.rx.rx_oom_discards += 1;
-			rc = -ENOMEM;
-			goto next_rx;
+			goto oom_next_rx;
 		}
 	} else {
 		u32 payload;
@@ -2170,29 +2165,21 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			payload = 0;
 		skb = bp->rx_skb_func(bp, rxr, cons, data, data_ptr, dma_addr,
 				      payload | len);
-		if (!skb) {
-			cpr->sw_stats.rx.rx_oom_discards += 1;
-			rc = -ENOMEM;
-			goto next_rx;
-		}
+		if (!skb)
+			goto oom_next_rx;
 	}
 
 	if (agg_bufs) {
 		if (!xdp_active) {
 			skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs, false);
-			if (!skb) {
-				cpr->sw_stats.rx.rx_oom_discards += 1;
-				rc = -ENOMEM;
-				goto next_rx;
-			}
+			if (!skb)
+				goto oom_next_rx;
 		} else {
 			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &xdp, rxcmp1);
 			if (!skb) {
 				/* we should be able to free the old skb here */
 				bnxt_xdp_buff_frags_free(rxr, &xdp);
-				cpr->sw_stats.rx.rx_oom_discards += 1;
-				rc = -ENOMEM;
-				goto next_rx;
+				goto oom_next_rx;
 			}
 		}
 	}
@@ -2270,6 +2257,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	*raw_cons = tmp_raw_cons;
 
 	return rc;
+
+oom_next_rx:
+	cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
+	rc = -ENOMEM;
+	goto next_rx;
 }
 
 /* In netpoll mode, if we are using a combined completion ring, we need to
@@ -2316,7 +2308,7 @@ static int bnxt_force_rx_discard(struct bnxt *bp,
 	}
 	rc = bnxt_rx_pkt(bp, cpr, raw_cons, event);
 	if (rc && rc != -EBUSY)
-		cpr->sw_stats.rx.rx_netpoll_discards += 1;
+		cpr->bnapi->cp_ring.sw_stats.rx.rx_netpoll_discards += 1;
 	return rc;
 }
 
-- 
2.44.0


