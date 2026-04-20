Return-Path: <netdev+bounces-279690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML96Ngfk5WkupAEAu9opvQ
	(envelope-from <netdev+bounces-279690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:29:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339042823C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF59B3032DFD
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F593388364;
	Mon, 20 Apr 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye30wetU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D31388E4E
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673736; cv=none; b=S6ceOxoA+Yl5ZddvFGn2UUbPVMk+/2QEg9iZNJjpCS3CLbz3uoSf/4IOF002dLhxdTrALKKHvYqGFg7t9FaaHev4vEOMGQUrA+IKtlJ/PtU5Lqe8t3JstSFW92u4YK0gfHSsHthGInPDwKVPlkpTBTkKLkrM+HERytNdhUS5iDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673736; c=relaxed/simple;
	bh=lqwv1bH8Jw1ECCA2rL1nMFEli2HTbp8f93hcHsXXRV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vl6yiI0vnSesfL3G4N6xCKEGvMIpF1c18XBKJF947lYrxqg/In3AbTaYVVOYYNXyvpSumH6iGIwQdOJLGGJmRR6nDRr8gvrMyVYTgn0ed4KcLZ0gOPUtU1u9OyYlvn6iXtfc7AqCY0ji8zo2R4YEQ+x2hCsi+sLQHFmUgbprrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye30wetU; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso92829a12.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673734; x=1777278534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGgn6dYRd9W8wi9ShyWx8cM0aKPHhjB6jSUkwtxx/s4=;
        b=Ye30wetUmZIh70TffW4tGcIubiknGWO8Zoby0nLsQlCEAr3m/FIiGevdJhWtwJnlD3
         Y1mIZxAULuURn5fnOYx6DAW416TQz+Ui+6zRJ8QsttUZEhuC2HnIoMoQzgxCJU2jyzUS
         HtOaQjLIzy3uZzT+otaXU3IHdD4Xm5KOP76Yqa3vP3pa+rqrUswvEj6QOALMUJ7W0TSv
         2L/Vjj+pa95rkcEfLvud1FRkP/wlfQGbvFMZVbaKtgkOO3JVbfNzxF0Cs7UTcP7zTWL+
         HBDHiIkB0naa8Jb4eOUlbRUPWfAp/WiKtD6xFWLRPzxUln2SJqsFNOWhRgWBLPuOCK54
         b6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673734; x=1777278534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AGgn6dYRd9W8wi9ShyWx8cM0aKPHhjB6jSUkwtxx/s4=;
        b=Im2KeJTISAbZ9FQ9mGSiFkQ4Jmr/P7fpN+AzWR6RBfG4oJ6dDa48veiMLWMHTb8NM/
         v37ezaQSMhDGSSDFsZuKfRzJPddRyhv/Ic2SifGZjK3cbEUPUACRcwmgdtZnZBD5hv4B
         F+y3bH4/dMClkfnMOVk7auFA2xxjhYHFLbapmq6UoHDt/kesu/fvtgze6yZClah9yKG3
         fWTrVgpmc6YNi6+RUrT6ebP4HwNKHlwioGY2unfkr7psTcFve7+osTe27b1ZGkNl6WVM
         zyL0mJQsB4SIc6vrSjTIJrZmbLY/oGcHGX7T4eaGaTXqcBdu2pm4L4ojvo7T0VKbl3hC
         rPow==
X-Forwarded-Encrypted: i=1; AFNElJ8BA3n4KTQ8GBvFj9ol+/JgCeGYkCS9VEwXN0zXTpSKC7rCeOiatehiLnJ2vgzHPOq/tIc5P5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dqNvnwBAWYmhbhUoB1zV/HUmeXNrvfQxn5ZzE+VnOaeUiN/E
	dJeVztVl3HLVg7+Z+5Lbba+yDIFx/Wc6TRJzFXImw1BFs04tpA0nY7x8
X-Gm-Gg: AeBDiesV1PQpuBt7nglcnoK3A82yA/OTSvvEk7FcIh3NjiZI9imoZA6edWxbp71Aalk
	hUgCWV4IvlP8ACHm4rHXGwJN1M8kXmgqHYlf5fq1KUSHx27mxGQv9amu71XRnPbpzcRkL2JefJx
	XuSCg/gXeH7m8klrdg8IuNcH07buliATQtgxjB3B2qm5uHWyWmtm7IZ0lqfz8KqdDpYzZ5pEykF
	6rE7MEky+xgtmWUiqJfKPmqF3pAPHMAb27jm/HmRSUwwOSQTxb6BCADb/BpSZm3tce8bcssn3Yz
	9LTXZmAorgTIAGmmwGmHbyuI0ZTUgZHtC4cg8hsUkNxH8cXw/dP9Tx0ZJGZgIdBDsIkWFrTKS46
	h5SEL5wcgJPu+TGnGMx1rHhD7pQecPpxw353NF/kwu1gGYXXf4k0lEm+u9Z7RcrfNIpsXF5y4VF
	456zA1o54ZVzx3vQllBXR3+C/BwcpPophr+I6VRGdOzgeLQGiydUGg2aGnNpMJABDeg/JpXqOlG
	KGLCYhM
X-Received: by 2002:a05:6a20:3c90:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3a08d748ad4mr13957846637.22.1776673734330;
        Mon, 20 Apr 2026 01:28:54 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:53 -0700 (PDT)
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
Subject: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on 32-bit architectures
Date: Mon, 20 Apr 2026 16:28:05 +0800
Message-Id: <20260420082805.14844-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9339042823C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_addrs
struct (the same path already used for multi-descriptor SKBs) to store
the full u64 address.

Extend xsk_drop_untrans_skb() to free the xsk_addrs allocation on 32-bit
when the skb is dropped before transmission. Note that here we don't use
0x1UL method to judge in this case.

Also extend xsk_skb_destructor_is_addr() to cover 32-bit case like above.

The overhead is one extra kmem_cache_zalloc per first descriptor on
32-bit only; 64-bit builds are completely unchanged.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6b17974ca825..bd49dbd9875b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -556,9 +556,23 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 	return ret;
 }
 
+/*
+ * On 64-bit, destructor_arg can store an inline address directly
+ * (tagged with bit 0 set). On 32-bit, all addresses go through an
+ * allocated xsk_addrs struct instead. In that case this function
+ * returns true only when destructor_arg is NULL (set_addr has not
+ * yet been called or has failed).
+ *
+ * For all callers:
+ *   return true: no xsk_addrs struct to handle
+ *   return false: destructor_arg points to an xsk_addrs struct
+ */
 static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
 {
-	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	if (IS_ENABLED(CONFIG_64BIT))
+		return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	else
+		return !skb_shinfo(skb)->destructor_arg;
 }
 
 static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
@@ -566,9 +580,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
 	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
 }
 
-static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
 {
+	if (!IS_ENABLED(CONFIG_64BIT)) {
+		struct xsk_addrs *xsk_addr;
+
+		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+		if (!xsk_addr)
+			return -ENOMEM;
+		xsk_addr->addrs[0] = addr;
+		skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
+		return 0;
+	}
+
 	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+	return 0;
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
@@ -644,14 +670,14 @@ void xsk_destruct_skb(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 
-static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
-			      u64 addr)
+static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
+			     u64 addr)
 {
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
-	xsk_skb_destructor_set_addr(skb, addr);
+	return xsk_skb_destructor_set_addr(skb, addr);
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
@@ -719,6 +745,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 
 static void xsk_drop_untrans_skb(struct sk_buff *skb)
 {
+	if (!IS_ENABLED(CONFIG_64BIT) && !xsk_skb_destructor_is_addr(skb)) {
+		struct xsk_addrs *xsk_addr;
+
+		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
+	}
 	skb->destructor = sock_wfree;
 	kfree_skb(skb);
 }
@@ -746,7 +778,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_skb_init_misc(skb, xs, desc->addr);
+		err = xsk_skb_init_misc(skb, xs, desc->addr);
+		if (unlikely(err)) {
+			xsk_drop_untrans_skb(skb);
+			return ERR_PTR(err);
+		}
+
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err)) {
@@ -845,7 +882,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
+			err = xsk_skb_init_misc(skb, xs, desc->addr);
+			if (unlikely(err))
+				goto free_err;
+
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
-- 
2.41.3


