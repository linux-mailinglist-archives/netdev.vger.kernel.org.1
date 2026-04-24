Return-Path: <netdev+bounces-280946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLnCEKQC62lsHQAAu9opvQ
	(envelope-from <netdev+bounces-280946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:41:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD06459FFC
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00709301A908
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181A344DBB;
	Fri, 24 Apr 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjkMf7c6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378C335546
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009146; cv=none; b=Tn257lvMtu+oDwDOlVFXABNuQSHz5g4eTL+qkBBNWlDPbKQfXAAHNRYQ23dJbAYp735jMr1Ux3YUGd2zRUZs9MLE5gucOOMp5hO9VH8PtqEFFQLMUKubj+bNmTidhbFml1hH4x3BN9qhoesReI++EXIIgnaXlYymzFGktql99rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009146; c=relaxed/simple;
	bh=lQ+U1tcVbyeZug+eKSTDL0bawb7D1nNd0QN1i0sAakY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XssGZXAn0Uotidp/3NxLn1XkaBa0PO7XHdTvYfzTbXFkXdwpjpCg0q971adpLEd6rPjN4fGgjIWJ3m2NreS308L5fzTmvrehJkwW3ho26M+JnKBN+hzlkhWcYWBEQn9PwHe2aQpdlfvoTUCc0Urgawik1ozvSHnDviLQTreTNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjkMf7c6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso4950160a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009144; x=1777613944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qr4OV8WE431vBkkMubZJHNjOwEiMdfOPU9mrOywPhc=;
        b=fjkMf7c6gdXsvn04WFGKMkIYnZ00K7eI7ak3jQb42afGkQOnzHBGl92ZEE1daN8Tzs
         JjRMZWFPpLxyaoHVtROp96OUMInMRU8FVShcSyMxgIiCpHzKUP+6WXyyzISVhTwZjyLg
         5OlBw0iJp6WwtwuFLh/b1JpB2SBexihyNJvHySEmcsRtlUdIybft6CIGKt7RsnDyCagW
         CrWbCWqXDQNqXw0KWPqF1epMhEdsrjwTvd5iaLJ29+NlErLkPh8bSgvqgtaN5l2acRNd
         sHDJc+si9zPp0kuUcT6eFWgZzNdBbHrlZTj/+ENtMeeRKK3s0YGHyzylPqOLSSobw4er
         G1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009144; x=1777613944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qr4OV8WE431vBkkMubZJHNjOwEiMdfOPU9mrOywPhc=;
        b=CXvSvXs7c+8ZhFppWcwGd1rf3whFcM3Nsq0DrxPAmHYP+K0lKnSKgVDmKu+rI7vPu8
         Lfqt+zdsE31zS1AjnxS3nroJAjfAVGeRz2TYvUtx0R5ZzlZRAmK1s2PIUSpTOIalQ8Lu
         ft3If8/jLnwgOWfW3/47uIyiAcL8ombOw7sTn5gTJvXYeIycdUOpcMsNG24+sTU0LDYC
         pVqR+OUsUYuarx6HJ3gBmJuZF/kd2SPuL9bIv0S3OC1MCs+Iv512D9eBykTS/wJ7DkJz
         lI3qkg/uZIFB7ImRk4STMCk7Tfu/TkZE8isvqfZxJQlGLXKd0XtiW6sy+L2/4v983sRr
         R9tA==
X-Forwarded-Encrypted: i=1; AFNElJ9k7dL+9SjuRnAQ4aqx2/3CoB42Jv4MhM5YqQQ1SxSXJ6/4APIdeS30Jn1M/qrRFb2IKBTaP2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqyPRjZdcA00t2kRizaIwahXPcZ7TxH0IMzgDEVrptHHcnj86
	RP45Lj3Tt4kOv3Ajep56+k086RkeODvcYycyyxGxbP+r8QBGtRb7zFYb
X-Gm-Gg: AeBDieurEtSwO7366zfbCV4MP27nvajU95vBmRDqd9c6EcHrq/XndQO45t1ZSXlV4gI
	VCXSatGvjWwW4FLC9bKfHMLOnv5Z5Tp4i4dIrUZI14oFw02NGYKFVGoc5CnCntrMmJBxPA+3wbV
	RyZURDIQ13PoGvqYZEDQuMJoH/W2txP/llnNOHdGyEJTh4KTOBFECuvIxMOXb9vqrNgmI29GDfD
	FDa+KDc6CxtgnjVNiveTduthxoimiW3AVCCoHnmsm6cfp6BqKxJVTldEMNFQjyeRyt4QKYEk4L8
	LxdP5zVG0evg89BJiU8XwINidPkCofDapyCWs8qj3l2ExJuSoZCVAEnPOD/pROenpBCwsu0pZHk
	UwezMRv27NLF0BCc2HlaYdcPMY7izQX2Fs1ef/7ISsu0AIg64EZCG+SruFPlRIBPXQbi+gCUnXt
	W1Xu4hZtGsjgqmmKkS0hiJhVMOubV8IH4CwmBGhJ4o5DqwXSRxKp5Bqy8LYsH5atwqEZU+OPJd0
	Ewb/CokOUSto9/a0sIttKLYYvB5GlZIOSkVICtd
X-Received: by 2002:a17:903:1450:b0:2b7:a350:463f with SMTP id d9443c01a7336-2b7a3505063mr59745865ad.10.1777009144366;
        Thu, 23 Apr 2026 22:39:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:39:03 -0700 (PDT)
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
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on 32-bit architectures
Date: Fri, 24 Apr 2026 13:38:16 +0800
Message-Id: <20260424053816.27965-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFD06459FFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280946-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email]

From: Jason Xing <kernelxing@tencent.com>

In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
uintptr_t cast:

    skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);

On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
the descriptor address are silently dropped. In unaligned mode the chunk
offset is encoded in bits 48-63 of the descriptor address
(XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is lost
entirely. The completion queue then returns a truncated address to
userspace, making buffer recycling impossible.

Fix this by handling the 32-bit case in the destructor_arg helpers:

- xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
  xsk_addrs struct via kmem_cache_zalloc() to store the full u64
  address. Leave num_descs as 0 (zalloc) so that the subsequent
  xsk_inc_num_desc() brings it to the correct count of 1.

- xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
  when destructor_arg is NULL (not yet set), false when it points to
  an xsk_addrs struct.

- xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
  before touching any other skb fields; on failure return early so
  the skb destructor is never changed from sock_wfree.

The existing xsk_consume_skb() already handles 32-bit correctly after
these changes: xsk_skb_destructor_is_addr() returns false for any
allocated xsk_addrs, so the kmem_cache_free path is always taken.

The overhead is one extra kmem_cache_zalloc per first descriptor on
32-bit only; 64-bit builds are completely unchanged.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ed96f6ec8ff2..fe88f47741b5 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 
 static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
 {
-	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	if (IS_ENABLED(CONFIG_64BIT))
+		return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	else
+		return !skb_shinfo(skb)->destructor_arg;
 }
 
 static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
@@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
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
@@ -644,14 +659,20 @@ void xsk_destruct_skb(struct sk_buff *skb)
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
+	if (err)
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


