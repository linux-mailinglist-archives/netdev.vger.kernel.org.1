Return-Path: <netdev+bounces-206295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0BFB0283F
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 02:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C73A4367A
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F4118C00;
	Sat, 12 Jul 2025 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvGgWwGW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553A2F2D
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752279877; cv=none; b=TDIhf0dIPAnSXy0EBfDygBJi6ngpdAuLNfoFAR3D4pxv4AyyArpQQAYrWLhZWMKRl26K+E4OULNyoszG2bElWpbils6Fv7iS7dLfLvjECUGZSHqVRTOS0rB3HDZHLMr9ZnBD35CHegXMxuA951jy9RIUA+N4G6NFOTxnCC+purA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752279877; c=relaxed/simple;
	bh=g6RuaNATZyFWIF5lIarmliXUwDeG8mnE/GIC61ZwM84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AqZGhgRLro/YWa//+1JgWqymiU3k7AikFELiHUvXZBe0kslGrbuZE3Gm2SUTPE6kwqsbp8hYddpGd+h/TWSTivZev29bwPsrvtJiKOP7jIUbM7LFHl1uOrVg3/TACOVkBJxCRKEkgAyblUnsWvE4mo+IlFd6q6rQkQ7k46OLu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvGgWwGW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752279875; x=1783815875;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=g6RuaNATZyFWIF5lIarmliXUwDeG8mnE/GIC61ZwM84=;
  b=nvGgWwGWFsZ0hZiogxmxn5GuKBgZ2jtKFyo0sygov6rGjrKQ9tsSbWCv
   NNgSg1QWXL1JjxAibzG+zU4jOdx2jiTOHNihGCNuqURO5efbweLnXu1hL
   3AfIHC4xKG2ddom6nEhePXhqx0qPsHAO0R5qtNQ1Dw1c5gYNjRrW3SwuY
   mj9YKpi5ps0J/Bhlqo2hoTXNkgM4QfoLOSPaxGiLcouCgucRLg5Mk0EIy
   KUZ0cNZPO6uRyYB155zSHFijIJl+PLlZTv30cMicXBQcpM8g2LWLGOFHQ
   mIPWvnv1vlbucbwBvZK+s13IACWO+O1UNrUJ6EeGZBUUTSBFdDhcn1tyg
   Q==;
X-CSE-ConnectionGUID: AO5rRS+iQbi7alj1B+vvVA==
X-CSE-MsgGUID: ZJO+1qyeRn+a0Tjpows4Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54517575"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54517575"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 17:24:34 -0700
X-CSE-ConnectionGUID: JYlv3h/OSkmw5B5JeJ3pyg==
X-CSE-MsgGUID: r5w125GeQLCKMFI4HuHtpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="157034182"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 17:24:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Jul 2025 17:23:49 -0700
Subject: [PATCH iwl-net v2] ice: fix Rx page leak on multi-buffer frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-jk-ice-fix-rx-mem-leak-v2-1-fa36a1edba8e@intel.com>
X-B4-Tracking: v=1; b=H4sIABWrcWgC/3WNwQ6CMBBEf4Xs2TWlSAqe/A/DoWkXWYFiWlIxp
 P9uQ7x6nLyZNzsE8kwBrsUOniIHXlwO8lSAGbR7ELLNGaSQtVCiweeIbAh73tBvONOME+kRK13
 Jhqy5qFZBHr885cohvgO/J3S0QpfBwGFd/Oc4jOWBf+72nzuWWKLprVVEpFtR39itNJ3NMkOXU
 voC9WvE2MUAAAA=
X-Change-ID: 20250708-jk-ice-fix-rx-mem-leak-3a328edc4797
To: maciej.fijalkowski@intel.com, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Joe Damato <jdamato@fastly.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, 
 Christoph Petrausch <christoph.petrausch@deepl.com>, 
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-d4ca8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11887;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=g6RuaNATZyFWIF5lIarmliXUwDeG8mnE/GIC61ZwM84=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhozC1cbvZOf5Xwv3fvKVy/Nz67OEtwdqn+/jnbD6wbaGu
 as/sD/O6ShlYRDjYpAVU2RRcAhZed14QpjWG2c5mDmsTCBDGLg4BWAipoYM/x3aNoX9OZB8rduL
 432UxNqc6M8WOUpTV80t3nn27zJuU1uG/4U1p9qr1e/FuB60CEloZH278+uUJcXOHyV2bqtXmRx
 9jgUA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice_put_rx_mbuf() function handles calling ice_put_rx_buf() for each
buffer in the current frame. This function was introduced as part of
handling multi-buffer XDP support in the ice driver.

It works by iterating over the buffers from first_desc up to 1 plus the
total number of fragments in the frame, cached from before the XDP program
was executed.

If the hardware posts a descriptor with a size of 0, the logic used in
ice_put_rx_mbuf() breaks. Such descriptors get skipped and don't get added
as fragments in ice_add_xdp_frag. Since the buffer isn't counted as a
fragment, we do not iterate over it in ice_put_rx_mbuf(), and thus we don't
call ice_put_rx_buf().

Because we don't call ice_put_rx_buf(), we don't attempt to re-use the
page or free it. This leaves a stale page in the ring, as we don't
increment next_to_alloc.

The ice_reuse_rx_page() assumes that the next_to_alloc has been incremented
properly, and that it always points to a buffer with a NULL page. Since
this function doesn't check, it will happily recycle a page over the top
of the next_to_alloc buffer, losing track of the old page.

Note that this leak only occurs for multi-buffer frames. The
ice_put_rx_mbuf() function always handles at least one buffer, so a
single-buffer frame will always get handled correctly. It is not clear
precisely why the hardware hands us descriptors with a size of 0 sometimes,
but it happens somewhat regularly with "jumbo frames" used by 9K MTU.

To fix ice_put_rx_mbuf(), we need to make sure to call ice_put_rx_buf() on
all buffers between first_desc and next_to_clean. Borrow the logic of a
similar function in i40e used for this same purpose. Use the same logic
also in ice_get_pgcnts().

Instead of iterating over just the number of fragments, use a loop which
iterates until the current index reaches to the next_to_clean element just
past the current frame. Check the current number of fragments (post XDP
program). For all buffers up 1 more than the number of fragments, we'll
update the pagecnt_bias. For any buffers past this, pagecnt_bias is left
as-is. This ensures that fragments released by the XDP program, as well as
any buffers with zero-size won't have their pagecnt_bias updated
incorrectly. Unlike i40e, the ice_put_rx_mbuf() function does call
ice_put_rx_buf() on the last buffer of the frame indicating end of packet.

The xdp_xmit value only needs to be updated if an XDP program is run, and
only once per packet. Drop the xdp_xmit pointer argument from
ice_put_rx_mbuf(). Instead, set xdp_xmit in the ice_clean_rx_irq() function
directly. This avoids needing to pass the argument and avoids an extra
bit-wise OR for each buffer in the frame.

Move the increment of the ntc local variable to ensure its updated *before*
all calls to ice_get_pgcnts() or ice_put_rx_mbuf(), as the loop logic
requires the index of the element just after the current frame.

This has the advantage that we also no longer need to track or cache the
number of fragments in the rx_ring, which saves a few bytes in the ring.

Cc: Christoph Petrausch <christoph.petrausch@deepl.com>
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Closes: https://lore.kernel.org/netdev/CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com/
Fixes: 743bbd93cf29 ("ice: put Rx buffers after being done with current frame")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
I've tested this in a setup with MTU 9000, using a combination of iperf3
and wrk generated traffic.

I tested this in a couple of ways. First, I check memory allocations using
/proc/allocinfo:

  awk '/ice_alloc_mapped_page/ { printf("%s %s\n", $1, $2) }' /proc/allocinfo | numfmt --to=iec

Second, I ported some stats from i40e written by Joe Damato to track the
page allocation and busy counts. I consistently saw that the allocate stat
increased without the busy or waive stats increasing. I also added a stat
to track directly when we overwrote a page pointer that was non-NULL in
ice_reuse_rx_page(), and saw it increment consistently.

With this fix, all of these indicators are fixed. I've tested both 1500
byte and 9000 byte MTU and no longer see the leak. With the counters I was
able to immediately see a leak within a few minutes of iperf3, so I am
confident that I've resolved the leak with this fix.

I've now also tested with xdp-bench and confirm that XDP_TX and XDP_REDIR work
properly with the fix for updating xdp_xmit.
---
Changes in v2:
- Fix XDP Tx/Redirect (Thanks Maciej!)
- Link to v1: https://lore.kernel.org/r/20250709-jk-ice-fix-rx-mem-leak-v1-1-cfdd7eeea905@intel.com
---
 drivers/net/ethernet/intel/ice/ice_txrx.h |  1 -
 drivers/net/ethernet/intel/ice/ice_txrx.c | 81 +++++++++++++------------------
 2 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index a4b1e9514632..07155e615f75 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -358,7 +358,6 @@ struct ice_rx_ring {
 	struct ice_tx_ring *xdp_ring;
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
-	u32 nr_frags;
 	u16 max_frame;
 	u16 rx_buf_len;
 	dma_addr_t dma;			/* physical address of ring */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 0e5107fe62ad..1c5a2fa7ea86 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -865,10 +865,6 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
 				   rx_buf->page_offset, size);
 	sinfo->xdp_frags_size += size;
-	/* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
-	 * can pop off frags but driver has to handle it on its own
-	 */
-	rx_ring->nr_frags = sinfo->nr_frags;
 
 	if (page_is_pfmemalloc(rx_buf->page))
 		xdp_buff_set_frag_pfmemalloc(xdp);
@@ -939,20 +935,20 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 /**
  * ice_get_pgcnts - grab page_count() for gathered fragments
  * @rx_ring: Rx descriptor ring to store the page counts on
+ * @ntc: the next to clean element (not included in this frame!)
  *
  * This function is intended to be called right before running XDP
  * program so that the page recycling mechanism will be able to take
  * a correct decision regarding underlying pages; this is done in such
  * way as XDP program can change the refcount of page
  */
-static void ice_get_pgcnts(struct ice_rx_ring *rx_ring)
+static void ice_get_pgcnts(struct ice_rx_ring *rx_ring, unsigned int ntc)
 {
-	u32 nr_frags = rx_ring->nr_frags + 1;
 	u32 idx = rx_ring->first_desc;
 	struct ice_rx_buf *rx_buf;
 	u32 cnt = rx_ring->count;
 
-	for (int i = 0; i < nr_frags; i++) {
+	while (idx != ntc) {
 		rx_buf = &rx_ring->rx_buf[idx];
 		rx_buf->pgcnt = page_count(rx_buf->page);
 
@@ -1125,62 +1121,48 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
 }
 
 /**
- * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all frame frags
+ * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all buffers in frame
  * @rx_ring: Rx ring with all the auxiliary data
  * @xdp: XDP buffer carrying linear + frags part
- * @xdp_xmit: XDP_TX/XDP_REDIRECT verdict storage
- * @ntc: a current next_to_clean value to be stored at rx_ring
+ * @ntc: the next to clean element (not included in this frame!)
  * @verdict: return code from XDP program execution
  *
- * Walk through gathered fragments and satisfy internal page
- * recycle mechanism; we take here an action related to verdict
- * returned by XDP program;
+ * Called after XDP program is completed, or on error with verdict set to
+ * ICE_XDP_CONSUMED.
+ *
+ * Walk through buffers from first_desc to the end of the frame, releasing
+ * buffers and satisfying internal page recycle mechanism. The action depends
+ * on verdict from XDP program.
  */
 static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
-			    u32 *xdp_xmit, u32 ntc, u32 verdict)
+			    u32 ntc, u32 verdict)
 {
-	u32 nr_frags = rx_ring->nr_frags + 1;
+	u32 nr_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
 	u32 idx = rx_ring->first_desc;
 	u32 cnt = rx_ring->count;
-	u32 post_xdp_frags = 1;
 	struct ice_rx_buf *buf;
-	int i;
+	int i = 0;
 
-	if (unlikely(xdp_buff_has_frags(xdp)))
-		post_xdp_frags += xdp_get_shared_info_from_buff(xdp)->nr_frags;
-
-	for (i = 0; i < post_xdp_frags; i++) {
+	while (idx != ntc) {
 		buf = &rx_ring->rx_buf[idx];
+		if (++idx == cnt)
+			idx = 0;
 
-		if (verdict & (ICE_XDP_TX | ICE_XDP_REDIR)) {
+		/* An XDP program could release fragments from the end of the
+		 * buffer. For these, we need to keep the pagecnt_bias as-is.
+		 * To do this, only adjust pagecnt_bias for fragments up to
+		 * the total remaining after the XDP program has run.
+		 */
+		if (verdict != ICE_XDP_CONSUMED)
 			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-			*xdp_xmit |= verdict;
-		} else if (verdict & ICE_XDP_CONSUMED) {
+		else if (i++ <= nr_frags)
 			buf->pagecnt_bias++;
-		} else if (verdict == ICE_XDP_PASS) {
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		}
 
 		ice_put_rx_buf(rx_ring, buf);
-
-		if (++idx == cnt)
-			idx = 0;
-	}
-	/* handle buffers that represented frags released by XDP prog;
-	 * for these we keep pagecnt_bias as-is; refcount from struct page
-	 * has been decremented within XDP prog and we do not have to increase
-	 * the biased refcnt
-	 */
-	for (; i < nr_frags; i++) {
-		buf = &rx_ring->rx_buf[idx];
-		ice_put_rx_buf(rx_ring, buf);
-		if (++idx == cnt)
-			idx = 0;
 	}
 
 	xdp->data = NULL;
 	rx_ring->first_desc = ntc;
-	rx_ring->nr_frags = 0;
 }
 
 /**
@@ -1260,6 +1242,10 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		/* retrieve a buffer from the ring */
 		rx_buf = ice_get_rx_buf(rx_ring, size, ntc);
 
+		/* Increment ntc before calls to ice_put_rx_mbuf() */
+		if (++ntc == cnt)
+			ntc = 0;
+
 		if (!xdp->data) {
 			void *hard_start;
 
@@ -1268,24 +1254,23 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 			xdp_buff_clear_frags_flag(xdp);
 		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
-			ice_put_rx_mbuf(rx_ring, xdp, NULL, ntc, ICE_XDP_CONSUMED);
+			ice_put_rx_mbuf(rx_ring, xdp, ntc, ICE_XDP_CONSUMED);
 			break;
 		}
-		if (++ntc == cnt)
-			ntc = 0;
 
 		/* skip if it is NOP desc */
 		if (ice_is_non_eop(rx_ring, rx_desc))
 			continue;
 
-		ice_get_pgcnts(rx_ring);
+		ice_get_pgcnts(rx_ring, ntc);
 		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
 		if (xdp_verdict == ICE_XDP_PASS)
 			goto construct_skb;
 		total_rx_bytes += xdp_get_buff_len(xdp);
 		total_rx_pkts++;
 
-		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
+		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
+		xdp_xmit |= xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR);
 
 		continue;
 construct_skb:
@@ -1298,7 +1283,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
 			xdp_verdict = ICE_XDP_CONSUMED;
 		}
-		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
+		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
 
 		if (!skb)
 			break;

---
base-commit: 31ec70afaaad11fb08970bd1b0dc9ebae3501e16
change-id: 20250708-jk-ice-fix-rx-mem-leak-3a328edc4797

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


