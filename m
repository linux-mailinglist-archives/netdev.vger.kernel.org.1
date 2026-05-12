Return-Path: <netdev+bounces-287221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGAKF2FHA2ri2QEAu9opvQ
	(envelope-from <netdev+bounces-287221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:29:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8E523A8B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ED2F30556CD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743493B1ECC;
	Tue, 12 May 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monogon-tech.20251104.gappssmtp.com header.i=@monogon-tech.20251104.gappssmtp.com header.b="wHP16DnW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E236A345
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599624; cv=none; b=o9c3RoK1Njuwpc6VJYskfqYCv2AM0ef1DLrFXypfqYia7va6BeJR5HEjHFolGJAy1kLvONFo3QXZ4wW+VztxD+4uINs4R8DfReiZ9CHMd14sBKFV+A+nk67oq2mk9HbGIOGHKEby3Wom8tWNbSm8+CfiNVpEXns0h4mA9/bfX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599624; c=relaxed/simple;
	bh=AbU3s2361m2WA/869CalrXUBM53xZtwAPLzZXsVmTus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n86CEvCead1V40G057J6u7nC1Am4eGBlVcPp0rR5tEAxOCD49xB6MAv4EQhE9egP+OGFuB3QmJadALxCh12UBuBcDCvAxRlBCfmKcwoPta/cpS4md3wK1mx9LHPCoa/C/V2egtFhz+YNfJVzmHa1ld/OI5dKLG+vopJYgtlbOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech; spf=pass smtp.mailfrom=monogon.tech; dkim=pass (2048-bit key) header.d=monogon-tech.20251104.gappssmtp.com header.i=@monogon-tech.20251104.gappssmtp.com header.b=wHP16DnW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monogon.tech
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso4646769f8f.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monogon-tech.20251104.gappssmtp.com; s=20251104; t=1778599621; x=1779204421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBLaLy9cz7siWYOspXYDH6TBQZgbRZIgkLsPqUvuuZY=;
        b=wHP16DnWMQI0zd6k7uwWIXds80ApqoHTxjIMTt2+ekgyjZPrSswqckq6w1YjVn4S68
         dTxGpHlLJfej4p/4aocPnUge+XDADsF2lXZFoTBuhaudyEyS7gGoSw++l9gAeblTvbUW
         ShhpoIVPmmuhO4PHsu9TOtjbhFSdthe1+8VZ/bI/YAdvdgz7nhlsADUzSWwv9x275pv9
         YUzDFu2OijqauRW2hUPWVAd7rC+a5mR5j7aDZK67INnJy6JqucGnD5PBv779SDolhQU5
         ysyz6Ydfi4NvXIM8dYZw2lbFaYBSA2CIUPnbnU8vPmJLecc+UHwnJWpS/Pd8KhAERZcX
         rVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599621; x=1779204421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBLaLy9cz7siWYOspXYDH6TBQZgbRZIgkLsPqUvuuZY=;
        b=i6ajophkS4qp3DUepDs1eF/W/uIfEZCU3tSnOPVMzqdwHQ/NrjmoNYkwq3AjaI7h82
         fCSPtc0/jaAPRTJ0RS0VZdHQaNBd5caQC/X5Omgd7076DjJIpHUAdOjUW1lTMIY5nP6K
         Urp3bK3xopcEbPKFzIoZhBhnmSoLUiKdp1rxqP5l0eMoSO53+n7ayB8TRL90Gj5BmL6U
         0GXs+jCA+EvUJjJoQk6FhlgxBtuyQ2rinkBZSobN2wSffh296v413lYfLNMjm7bMx2/8
         9WABnu3mHQdCj8c2WYA06D1UmQzcZ0eusJjBSmtuSD9agwPvdRsjNNGepHqMhn8BG8Tv
         rQsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nZKe3TOvrGCQMEKNYGfEiVf3oqCLbMD+MA3SES5E6Kj4oq/LIhoSrwjGBlhEsZ84PNvJ93zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnCN80DE5RfW9OxPR/9b5sueZGybMlB6UsnQutgmSr5/HUuu2E
	I/8/zLHYHKl1XmORDzRfqbp+R3IjBuEuzhJMeyV3CMWx0KaIbv9kKNznSV7i6kbSZWY=
X-Gm-Gg: Acq92OGaI5SbOwUVDQVPPTLIiotdNZXUqh/eruxjIvGUWzQl7AQjgeExh8xHXg9O1jo
	8EbRSLO69wEPPpQV4YiJMzex/TykpLz39b7Ff+u1iMqLNpwDMEVZ+Q/JdPDqLo5HRuU66b8h1eF
	S67IUjHKig9aZ8ZHOZh5ysUMHNu8pedF5cTMxRE9mhjntW2Jpwl3SfdyUkAU95S+rjTXGp+N3/z
	qM7EedP0qp6/89FlnLGaVK2ULDciakIXUZXP7rJ8xhaA6fF72l9MlKdfl8TJqWQGHE9rbZj3o6d
	fAuO1fw9Ko1IsQZ3R1brdux7BKKwA/jldV9dRbBIws8QYLinBzMyM+gO3BI0ztSKIdioYbalPuN
	Iuiep6LQyiq5vr9FibzP9TsMJ4kHGo/FnnBmZyTcI8+RJsWAA868VaRMLeLnWX5WHP8507bIsGd
	A8o6V2GCdz21tbpuems2XwCCBzdkJ7MsDxfXie1lVKzQ==
X-Received: by 2002:a05:6000:611:b0:44a:247e:67b4 with SMTP id ffacd0b85a97d-4515b9f31camr45918391f8f.18.1778599620798;
        Tue, 12 May 2026 08:27:00 -0700 (PDT)
Received: from localhost ([213.239.141.92])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45491304505sm33531123f8f.22.2026.05.12.08.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 08:27:00 -0700 (PDT)
From: Lorenz Brun <lorenz@monogon.tech>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] xsk: switch xdp_build_skb_from_zc() to napi_alloc_skb()
Date: Tue, 12 May 2026 17:26:56 +0200
Message-ID: <20260512152658.2818805-1-lorenz@monogon.tech>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2C8E523A8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[monogon-tech.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[monogon.tech : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287221-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenz@monogon.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[monogon-tech.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,monogon-tech.20251104.gappssmtp.com:dkim,monogon.tech:email,monogon.tech:mid]
X-Rspamd-Action: no action

xdp_build_skb_from_zc() allocated xdp->frame_sz bytes from the per-cpu
system_page_pool and built the skb head with napi_build_skb(). The
latter places skb_shared_info at the tail of the buffer, but the
helper sized the allocation as if the whole frame_sz were usable for
data. Whenever the packet plus reserved headroom approached frame_sz,
the head memcpy overran shinfo with packet content, corrupting
->flags (SKBFL_ZEROCOPY_ENABLE) and ->nr_frags, which then drove
skb_copy_ubufs() off the end of frags[] on the RX path:

  UBSAN: array-index-out-of-bounds in include/linux/skbuff.h:2541
  index 113 is out of range for type 'skb_frag_t [17]'
   skb_copy_ubufs+0x7da/0x960
   ip_local_deliver_finish+0xcd/0x110
   ice_napi_poll+0xe4/0x2a0 [ice]

The overrun bytes come from the packet, so an on-wire sender can
corrupt kernel memory remotely whenever the XDP program returns
XDP_PASS.

Rather than patch the sizing math, switch to the pattern used by other
in-tree AF_XDP zero-copy drivers like mlx5 and i40e which use
napi_alloc_skb() sized to the actual packet plus skb_put_data().
This sizes the head exactly for the data being copied, drops the
system_page_pool local_lock from this path, and removes the
structural mismatch between frame_sz and the skb head buffer. Frags
are allocated with alloc_page() per frag, matching the other drivers.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c |  2 +-
 include/net/libeth/xsk.h                 |  2 +-
 include/net/xdp.h                        |  3 +-
 net/core/xdp.c                           | 72 ++++++++----------------
 4 files changed, 29 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c35..6c01a14fde150 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -653,7 +653,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 
 construct_skb:
 		/* XDP_PASS path */
-		skb = xdp_build_skb_from_zc(first);
+		skb = xdp_build_skb_from_zc(&rx_ring->q_vector->napi, first);
 		if (!skb) {
 			xsk_buff_free(first);
 			first = NULL;
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 82b5d21aae878..922b4587acd3f 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -468,7 +468,7 @@ __libeth_xsk_run_pass(struct libeth_xdp_buff *xdp,
 	if (act != LIBETH_XDP_PASS)
 		return act != LIBETH_XDP_ABORTED;
 
-	skb = xdp_build_skb_from_zc(&xdp->base);
+	skb = xdp_build_skb_from_zc(napi, &xdp->base);
 	if (unlikely(!skb)) {
 		libeth_xsk_buff_free_slow(xdp);
 		return true;
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c358..fb2452243fd36 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -375,7 +375,8 @@ void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
 struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
-struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
+struct sk_buff *xdp_build_skb_from_zc(struct napi_struct *napi,
+				      struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba7..54005b64e6cbb 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -677,16 +677,14 @@ EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
  * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
  * @skb: skb to copy frags to
  * @xdp: XSk &xdp_buff from which the frags will be copied
- * @pp: &page_pool backing page allocation, if available
  *
  * Copy all frags from XSk &xdp_buff to the skb to pass it up the stack.
- * Allocate a new buffer for each frag, copy it and attach to the skb.
+ * Allocate a new page for each frag, copy it and attach to the skb.
  *
- * Return: true on success, false on netmem allocation fail.
+ * Return: true on success, false on page allocation fail.
  */
 static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
-					    const struct xdp_buff *xdp,
-					    struct page_pool *pp)
+					    const struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = skb_shinfo(skb);
 	const struct skb_shared_info *xinfo;
@@ -699,20 +697,18 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 	for (u32 i = 0; i < nr_frags; i++) {
 		const skb_frag_t *frag = &xinfo->frags[i];
 		u32 len = skb_frag_size(frag);
-		u32 offset, truesize = len;
 		struct page *page;
 
-		page = page_pool_dev_alloc(pp, &offset, &truesize);
+		page = alloc_page(GFP_ATOMIC | __GFP_NOWARN);
 		if (unlikely(!page)) {
 			sinfo->nr_frags = i;
 			return false;
 		}
 
-		memcpy(page_address(page) + offset, skb_frag_address(frag),
-		       LARGEST_ALIGN(len));
-		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
+		memcpy(page_address(page), skb_frag_address(frag), len);
+		__skb_fill_page_desc_noacc(sinfo, i, page, 0, len);
 
-		tsize += truesize;
+		tsize += PAGE_SIZE;
 		if (page_is_pfmemalloc(page))
 			flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 	}
@@ -725,49 +721,34 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 
 /**
  * xdp_build_skb_from_zc - create an skb from XSk &xdp_buff
+ * @napi: NAPI instance the buffer was received on (provides the skb cache)
  * @xdp: source XSk buff
  *
  * Similar to xdp_build_skb_from_buff(), but for XSk frames. Allocate an skb
- * head, new buffer for the head, copy the data and initialize the skb fields.
- * If there are frags, allocate new buffers for them and copy.
- * Buffers are allocated from the system percpu pools to try recycling them.
- * If new skb was built successfully, @xdp is returned to XSk pool's freelist.
- * On error, it remains untouched and the caller must take care of this.
+ * sized to the packet from the NAPI cache, copy the head data, and copy
+ * any frags into freshly allocated pages.
+ *
+ * If a new skb was built successfully, @xdp is returned to the XSk pool's
+ * freelist. On error, it remains untouched and the caller must take care
+ * of this.
  *
  * Return: new &sk_buff on success, %NULL on error.
  */
-struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
+struct sk_buff *xdp_build_skb_from_zc(struct napi_struct *napi,
+				      struct xdp_buff *xdp)
 {
 	const struct xdp_rxq_info *rxq = xdp->rxq;
-	u32 len = xdp->data_end - xdp->data_meta;
-	u32 truesize = xdp->frame_sz;
-	struct sk_buff *skb = NULL;
-	struct page_pool *pp;
-	int metalen;
-	void *data;
+	u32 totallen = xdp->data_end - xdp->data_meta;
+	u32 metalen = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
 
-	if (!IS_ENABLED(CONFIG_PAGE_POOL))
+	skb = napi_alloc_skb(napi, totallen);
+	if (unlikely(!skb))
 		return NULL;
 
-	local_lock_nested_bh(&system_page_pool.bh_lock);
-	pp = this_cpu_read(system_page_pool.pool);
-	data = page_pool_dev_alloc_va(pp, &truesize);
-	if (unlikely(!data))
-		goto out;
-
-	skb = napi_build_skb(data, truesize);
-	if (unlikely(!skb)) {
-		page_pool_free_va(pp, data, true);
-		goto out;
-	}
-
-	skb_mark_for_recycle(skb);
-	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+	skb_put_data(skb, xdp->data_meta, totallen);
 
-	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
-
-	metalen = xdp->data - xdp->data_meta;
-	if (metalen > 0) {
+	if (metalen) {
 		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
 	}
@@ -775,18 +756,15 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 	skb_record_rx_queue(skb, rxq->queue_index);
 
 	if (unlikely(xdp_buff_has_frags(xdp)) &&
-	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
+	    unlikely(!xdp_copy_frags_from_zc(skb, xdp))) {
 		napi_consume_skb(skb, true);
-		skb = NULL;
-		goto out;
+		return NULL;
 	}
 
 	xsk_buff_free(xdp);
 
 	skb->protocol = eth_type_trans(skb, rxq->dev);
 
-out:
-	local_unlock_nested_bh(&system_page_pool.bh_lock);
 	return skb;
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
-- 
2.51.2


