Return-Path: <netdev+bounces-283481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOVXAxNa9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570E4B3686
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B26A4303389B
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348D38C2CC;
	Sat,  2 May 2026 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnInySpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743738BF9A
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752474; cv=none; b=c/RfXqG1UmPqqGKeb6b1JWLnmnC6jeh/EfDOIGI44ZIAuPszjvkOuG78l0dZfaEyG9wwhI+CTXZfpi6BQZM30UlVcx72FcxU45+4KZf0U6W7+0pwwSTdHk4fgGIoQy/OckmYP3KZtPEwiHuSfQgSjllSVy7KMzOA2CDgthdC2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752474; c=relaxed/simple;
	bh=6fhkORwl0WrQrAiPU/4A7EcUc7TS9dUQQwqIH2J989g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjhslyjN5pMQSC4nYmIsrQnu7cVSJoRYKxpByq2OKgV8yeKD4Way4MnN/lEco8LaPPFvY5l/VXiSJE11f2qYN0FurfWJYqw0W20MeUr2Kxqye4JKUAjuGM4VNyzuYY02qpM9SsRrUhX9pi6e6ECLwdiCH22PJZ2neL5lAQSoQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnInySpq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so2010271a12.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752471; x=1778357271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sQZWwyOri3Uo6Ueex9Gln19C5muTCApAI1lF9cmGDg=;
        b=bnInySpq5gQwjAMbakO7kt/QFc8Gv+RRFaOrpWoMqguafrg/O445AajLMdRE+f/JO+
         Isvyb9GF5vTk/TEMUzywLx6W1A81sbVMnrQ5dNdGRa7YGcnmlOYbblZUK5xV1gzrDd9v
         ctLEQaAoqU07PsqFixT1+cCBmxISfZjgHa/RgPiRFxt6M7xcHsIDSvxU4lWYC39HTsss
         +tkKGXkJpWVBb6VRG4SaACJdUrSK3202+1l7/Ck+NpfT/0tSihJ9Nc/v7M+R65QD8ssL
         m/u9JhfsHUeS2dpi4PX4uOrVCiA9iijEcaWmKyuEWe1e050czC8cXYDCOQc6eKvAqrFX
         wPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752471; x=1778357271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sQZWwyOri3Uo6Ueex9Gln19C5muTCApAI1lF9cmGDg=;
        b=UzmyDSbxArbrVTooMSCQY8WxAUORsWvxG1Ez7cy39BHLihYV/vtTuujQJ8z3y45hwO
         KbuA/T+ygVKSUGFPSMVu0zcPAaireSYVEOwcPm68YMfjfqPFBej9PJWjDJp5ObTKaL+b
         CU46IzFp8d1VIwa8vvW4PVCkxWgO8rQijDXu92t72LmpDgEvy+psaLfTxngNyU5yXmjE
         ZfWoVHY34efVN5w0XuzqBOAx57uPAhyoGpCZQsdObCmERArIFMXT0zhRwgUKt+Ae0NH3
         mx6M8kn3HDKaJi59ImYpwoQ2ezUztn4eo47qeEkAZXInGsGAgGFVp0Ngl4FRjPfW2AQq
         Rybg==
X-Forwarded-Encrypted: i=1; AFNElJ+RJl12SnaAaH7aTeIEqO95UXVh7bke0kFYhxQTDxM9ApBvVpdQZSBSPMjlDaZWSj6SBtzrXnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpD9UBQ54yJ8C0R9+CwfMrNaRnpbiU7lrciciMWYHGUneYL5i6
	JktR3/I8H8EeJrrDWUvh1KztCkNE77b/jny+0Hgn/k1gp1dBW7y5yO7c
X-Gm-Gg: AeBDievIoWlSDtufWKG3LChsilTWSGi+tLLPVqV22bwtXQDReNQgANpKkN4cfVovzqe
	sUc4763odCi2QOihtdcE+K7OhlFfcHemPTQOiQs9mOpzaj66Ra6eMXWKmGVKaTbAYfoLdjxq+T5
	CbZ7sqyVWUanztHUVclBJe42RlnT8pSkqT8Tviy/jw6crz+D1OJv3lIfPIx+JoXUeZUdsKURprl
	CLf2x0OzhzRwTf8KWcsmuvZpfsoD+/6xYKpj5k6hYuieOaez5HoFUQ+xBTubVxLA9eo8HVYFcRi
	28EWvp4RlNuLssFKaEQR++vxIIo4qci0kpyTYpsvOf6EVhUyO+/o0OMVGSd1jzhadJdwqpiNz2+
	FaNFCQJrO8fnOdy0t5myMVK7+Qac0WUxs+X4WUIMY+V/tZ/tq2e7PomQUYAobH1gzwNlpUuizdn
	tx5S5e350IHOi2rGUb9592RJFL2etKiNTu0Uj2q1dQCVQmZ7XeTXcRhzXWLsjcMduWg883JCqie
	Y1jWaK+3rl6hCi+PlPh+C43jEFX
X-Received: by 2002:aa7:ce01:0:b0:678:9826:b758 with SMTP id 4fb4d7f45d1cf-67c19b2d42emr1153618a12.6.1777752471075;
        Sat, 02 May 2026 13:07:51 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:50 -0700 (PDT)
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
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 8/8] xsk: fix u64 descriptor address truncation on 32-bit architectures
Date: Sat,  2 May 2026 23:07:22 +0300
Message-Id: <20260502200722.53960-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8570E4B3686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283481-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email]

From: Jason Xing <kernelxing@tencent.com>

In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
uintptr_t cast:

    skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);

On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
mode the chunk offset is encoded in bits 48-63 of the descriptor
address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
lost entirely. The completion queue then returns a truncated address to
userspace, making buffer recycling impossible.

Fix this by handling the 32-bit case directly in
xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an
xsk_addrs struct (the same path already used for multi-descriptor
SKBs) to store the full u64 address. The existing tagged-pointer logic
in xsk_skb_destructor_is_addr() stays unchanged: slab pointers returned
from kmem_cache_zalloc() are always word-aligned and therefore have
bit 0 clear, which correctly identifies them as a struct pointer
rather than an inline tagged address on every architecture.

Factor the shared kmem_cache_zalloc + destructor_arg assignment into
__xsk_addrs_alloc() and add a wrapper xsk_addrs_alloc() that handles
the inline-to-list upgrade (is_addr check + get_addr + num_descs = 1).
The three former open-coded kmem_cache_zalloc call sites now reduce to
a single call each.

Propagate the -ENOMEM from xsk_skb_destructor_set_addr() through
xsk_skb_init_misc() so the caller can clean up the skb via kfree_skb()
before skb->destructor is installed.

The overhead is one extra kmem_cache_zalloc per first descriptor on
32-bit only; 64-bit builds are completely unchanged.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 88 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ed96f6ec8ff2..6bcd77068e52 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -566,9 +566,42 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
 	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
 }
 
-static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+static struct xsk_addrs *__xsk_addrs_alloc(struct sk_buff *skb, u64 addr)
 {
-	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+	struct xsk_addrs *xsk_addr;
+
+	xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+	if (unlikely(!xsk_addr))
+		return NULL;
+
+	xsk_addr->addrs[0] = addr;
+	skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
+	return xsk_addr;
+}
+
+static struct xsk_addrs *xsk_addrs_alloc(struct sk_buff *skb)
+{
+	struct xsk_addrs *xsk_addr;
+
+	if (!xsk_skb_destructor_is_addr(skb))
+		return (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+
+	xsk_addr = __xsk_addrs_alloc(skb, xsk_skb_destructor_get_addr(skb));
+	if (likely(xsk_addr))
+		xsk_addr->num_descs = 1;
+	return xsk_addr;
+}
+
+static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+{
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+		return 0;
+	}
+
+	if (unlikely(!__xsk_addrs_alloc(skb, addr)))
+		return -ENOMEM;
+	return 0;
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
@@ -644,14 +677,20 @@ void xsk_destruct_skb(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 
-static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
-			      u64 addr)
+static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
+			     u64 addr)
 {
+	int err;
+
+	err = xsk_skb_destructor_set_addr(skb, addr);
+	if (unlikely(err))
+		return err;
+
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
-	xsk_skb_destructor_set_addr(skb, addr);
+	return 0;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
@@ -749,18 +788,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	} else {
 		struct xsk_addrs *xsk_addr;
 
-		if (xsk_skb_destructor_is_addr(skb)) {
-			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
-						     GFP_KERNEL);
-			if (!xsk_addr)
-				return ERR_PTR(-ENOMEM);
-
-			xsk_addr->num_descs = 1;
-			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
-			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
-		} else {
-			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-		}
+		xsk_addr = xsk_addrs_alloc(skb);
+		if (!xsk_addr)
+			return ERR_PTR(-ENOMEM);
 
 		/* in case of -EOVERFLOW that could happen below,
 		 * xsk_consume_skb() will release this node as whole skb
@@ -849,19 +879,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			struct page *page;
 			u8 *vaddr;
 
-			if (xsk_skb_destructor_is_addr(skb)) {
-				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
-							     GFP_KERNEL);
-				if (!xsk_addr) {
-					err = -ENOMEM;
-					goto free_err;
-				}
-
-				xsk_addr->num_descs = 1;
-				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
-				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
-			} else {
-				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+			xsk_addr = xsk_addrs_alloc(skb);
+			if (!xsk_addr) {
+				err = -ENOMEM;
+				goto free_err;
 			}
 
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
@@ -886,8 +907,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
-	if (!xs->skb)
-		xsk_skb_init_misc(skb, xs, desc->addr);
+	if (!xs->skb) {
+		err = xsk_skb_init_misc(skb, xs, desc->addr);
+		if (unlikely(err))
+			goto free_err;
+	}
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.41.3


