Return-Path: <netdev+bounces-278714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNFfJyBN32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BCF402028
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC8FF3042C9C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBCA3D47BF;
	Wed, 15 Apr 2026 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzqOqvwh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B33CFF65
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241718; cv=none; b=jwJ5h8T/bIADoI0Oy6ZokPanEden1NwkHB9Y3cu0l0r3GH/xFTsBLN5fc8kYrCcApBABbhDeFiTG4gdGUsUo1iY+sxGRrKN6zo3tadyatSp9c37wxDYKCpyN/BNq3efoomQutHnOkU/TsYAGlG33/5c3p0ntGSyJI2tXVpt0mTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241718; c=relaxed/simple;
	bh=ZUvWTrIxNz70VSezRKFX4blS66wvJCWytkqwkeJwkLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZwegsatuxwQ5lnisT0HDyFWW6z7V3gXT++V/VFlfA1mMSMslsKe1pp5xengGET/ZY90OAJwWRjErYaQmdHeGu5W2dPARYh8C8Bx/X0lifnYXpSErvX6tJ2sDoNbXBhEmUWYhivqWVEZRsG8NdWI/o6CsER9gyMN9icKPcs02po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzqOqvwh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2920218a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241717; x=1776846517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCwTbhoxO2es8i0LbayXcV+D6Aj0lOcdld/MQ+SztSQ=;
        b=FzqOqvwhWKFeSQ/ZdOfhKI6yxd1El5L/rMkbv0LmeDT18j0XT++byCJn89iVyF7IL0
         ZYp7X4RGJh9JSwM0TUe9toZlfRfHluSofQY73gdxs3ivwzCq19BOFIIVabdhYGbiIly5
         +xc2szXtnTSxNc/O2ee0ceIaPkp5fEbFtmug3fruc5cQdZsa5ybei6gk5ON2FSTglZnL
         1aZ8dtW9P9PU3GflLxL5QQm+NYX7JDSMMDn2WV09e/0xSfhpv+T9daVGqskZnMd4GzbR
         1ddGgo8HLq2tS5Cf0EZ8lo2qKP/ct0slZm+zrWaGgHsoN50NFwFYH+/pAD0HMCR/T5P6
         8StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241717; x=1776846517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCwTbhoxO2es8i0LbayXcV+D6Aj0lOcdld/MQ+SztSQ=;
        b=X5SgwZEube/Va/twOyLdi2ayy7AtW0puFYDJ+FIibCHftFC9k5+Vo202INh7t6SyIE
         s3DDAzM3ytlS9hiZb6ltTfzrn+FJTWHNqUZJCDm1+y9oJia4W4NbSWCvuRj1Oj6ygDKx
         9aYNrQz7+TyMSvIwaZCrbuFct5XS6mrsoyuEWN0ct1vakVo5Ew+x6nTBGmFo1ulE4iZt
         WAZfqsrtz6UjYLRcjTqoi5CKZo/E1aAV2kjnla7BiVzXt4jaXSalNvZTUbmvnnpvqmlW
         Uha6vDCwtznITPepCKQnZRxsXjdVOEJlLjNTudD2eW8B1PolutOZPNycOxJ8n8+80HYO
         gBrg==
X-Forwarded-Encrypted: i=1; AFNElJ+rG/zHmLP64QwSnYWzXPq4volb5qGpG9cpJC1Hcm2WZcshhjdsjwhzwNn2iTr0FC/xoIcpL4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSrCpwMM4qJXEso6EYp+d7VY9esBKZZiVP41eqjHct6Q9i5W6
	Huex7BD63O47WqmhDQvGIQwJR+C8hRG2eLzNaYvbHPXIjUn0JV0MHyXSWGjQ7ZsfKAhBig==
X-Gm-Gg: AeBDiet5l1eDe7cirX2TV5dIKhOC2nvBii91znPvCH+930TodasSA/VO3kyJe9PFO6B
	oguUdudFwVVXueR8nB1l7klAp8PVOjVgSRze4XB9xQXSzLgsHvhslEyCyVKBAIPAHKwXm4DPcCJ
	x7dGJxM2M228/hmQhoeSse9jDgjqxnLUjVbhYMc88SGFpGI79HScyNLdWsTfc7V4Q9sKGxZTGQ/
	7e/3RXLoiiB9Vw9hLInKZ3iE6rGnc9aPuT0Ik8utQNfzC/NakMZjx+aRzg8HfTn8+mKoWNzNT8H
	NQQLalzXxs8T+Ovzqi8DApWzEcQyrtFnBUG6/AnHQncWexuwvaDH3XXj8T9jVBn07+umh1oXud1
	c5gLdY6uTpofBc90QhoMV7DkphlpQi26HxLuAU8xyslzLXxz5szQfoxIeu5YUIo8DD5fCvZRR3J
	Un67WSdxayhzNZKWDvPu7ykoVX/oWD7yLvti7rnSgGrfTYn+HpKCB8BDrekAGGN4Q3yh94WMUcl
	g+C2CCI
X-Received: by 2002:a17:903:3c27:b0:2b4:696b:7bb7 with SMTP id d9443c01a7336-2b4696b7c10mr77559355ad.15.1776241716629;
        Wed, 15 Apr 2026 01:28:36 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:35 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 14/14] xsk: optimize xsk_build_skb for batch copy-mode fast path
Date: Wed, 15 Apr 2026 16:26:54 +0800
Message-Id: <20260415082654.21026-15-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E0BCF402028
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Three targeted optimizations for the batch copy-mode TX hot path:

Replace skb_store_bits() with memcpy() for single-buffer first-desc
path.  After skb_reserve() + skb_put(), the SKB is freshly allocated
with all data in the linear area and no frags, so skb_store_bits()
degenerates to memcpy(skb->data, buffer, len) but carries unnecessary
function call overhead, offset validation, and frag iteration logic.

Inline UMEM address computation in Phase 3 and pass the pre-computed
buffer pointer to xsk_build_skb(), avoiding the per-packet non-inlined
xp_raw_get_data() (EXPORT_SYMBOL) call chain:
xsk_buff_raw_get_data -> xp_raw_get_data -> __xp_raw_get_addr +
__xp_raw_get_data.
In the batch loop the pool->addrs and pool->unaligned are invariant,
so we cache them once and compute each buffer address inline.

Prefetch the *next* descriptor's UMEM data buffer at the top of the
Phase 3 loop, hiding the memory latency of the upcoming memcpy.

It improves 3-4% performance stably.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  3 ++-
 net/core/skbuff.c      | 18 ++++++++++++++++--
 net/xdp/xsk.c          | 15 ++++++---------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 0609e3b04279..5e05236c7fba 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -139,7 +139,8 @@ void __xsk_map_flush(struct list_head *flush_list);
 INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
 struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
-			      struct xdp_desc *desc);
+			      struct xdp_desc *desc,
+			      void *buffer);
 int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
 int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5726b1566b2b..bef5270e6332 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -752,14 +752,28 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err
 	if (total_truesize)
 		refcount_add(total_truesize, &xs->sk.sk_wmem_alloc);
 
-	/* Phase 3: Build SKBs with packet data */
+	/* Phase 3: Build SKBs with packet data. */
+	struct xsk_buff_pool *pool = xs->pool;
+	void *pool_addrs = pool->addrs;
+	bool unaligned = pool->unaligned;
+
 	for (j = 0; j < alloc_descs; j++) {
+		u64 addr = descs[j].addr;
+		void *buffer;
+
+		if (unaligned)
+			addr = xp_unaligned_add_offset_to_addr(addr);
+		buffer = pool_addrs + addr;
+
+		if (j + 1 < alloc_descs)
+			prefetch(pool_addrs + descs[j + 1].addr);
+
 		if (!xs->skb) {
 			skb = skbs[skb_count - 1 - k];
 			k++;
 		}
 
-		skb = xsk_build_skb(xs, skb, &descs[j]);
+		skb = xsk_build_skb(xs, skb, &descs[j], buffer);
 		if (IS_ERR(skb)) {
 			*err = PTR_ERR(skb);
 			break;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index be341290e42c..3bf81b838075 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -811,7 +811,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
-			      struct xdp_desc *desc)
+			      struct xdp_desc *desc,
+			      void *buffer)
 {
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
@@ -825,11 +826,10 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			goto free_err;
 		}
 	} else {
-		u32 hr, tr, len;
-		void *buffer;
+		u32 hr, tr, len = desc->len;
 
-		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
-		len = desc->len;
+		if (!buffer)
+			buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
 
 		if (!skb) {
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
@@ -844,10 +844,7 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_reserve(skb, hr);
 			skb_put(skb, len);
-
-			err = skb_store_bits(skb, 0, buffer, len);
-			if (unlikely(err))
-				goto free_err;
+			memcpy(skb->data, buffer, len);
 
 			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
-- 
2.41.3


