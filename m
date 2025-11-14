Return-Path: <netdev+bounces-238680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB59C5D82F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBC5D4F260E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E00324B22;
	Fri, 14 Nov 2025 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iv12OwbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A0324707
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129213; cv=none; b=rNUfKyxj/ShIk+GNPjIaTEFF4xWEtEZILqKfd2Su5WC5y0ki2EO9K87zVq7UH2peg1bB4H2lFu3iQpUjWT8szI0vwSEak9zTbSrur9crl3ZdKyW30m2fL0ZybXQwj0NHxPmUv7tqqAKFuqMBY53JPbRDdycLfH9jeo1XPQbM0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129213; c=relaxed/simple;
	bh=oNQL9iYvNRTZVBqXboiLPRAwsvpu0u63F6sdYKZYY7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fWZdsCcYP+9Q9syCZcAC59kP5b8vesKuE91Sb5A9DafAi7nNiq/hwIVmarHP5BHUeD78sUnghAk6VaDItayCSaHPJJ2NHDrn/4jpw7UjizoIO6rwwGx3+I7o9yu+uv/XrWeILye/2/3sDZnMNUmg7loHx4oH178Fil4X0bynJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iv12OwbB; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b23a64f334so606376485a.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 06:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763129210; x=1763734010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p199NXv4y1rAS/mf/rNg1mVOWhh1nlFD9giH3bYyspE=;
        b=Iv12OwbBTLvxOIbmtCIM1V8J/69D9QpLItfO9r5F3AJd+MO5Fws1bBjszWNXh5Pzkj
         cvEQx++jCosZou6UlLN3wolMgn47y1Z4YWxnwBxPrgjcuFTSeU+mxORfcjHvWmYdncbE
         c8iGBveSNNneQWHwMmaRZzj0uK4Yb7ndhn4QpEMFYy4z/+INZ0jK9t5+hi0RsYBUZTG8
         XiqsuwBbXq/dES+oJ0gBB4P3BFFuzrZ3g63BnV8vLau5v7RMS0Iqe4c7J8Qr3Zds7m3t
         zH28nLJnokFAhd91+QQKrJni32syJT3uP7somMXyQ0A8WrBkAh+jixWa/uMQaTm2XlQX
         IMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763129210; x=1763734010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p199NXv4y1rAS/mf/rNg1mVOWhh1nlFD9giH3bYyspE=;
        b=WKO7XqtlW8yOW8smAYB81nCn9eCj2EUERigpUWAj3R4RrfBHEH9OeY/2jtQx1/d7yU
         8BHutRnMV5ffS+v2ikbOBOrdWV/iUpvqOu+yn0xo7gMRK9quXFR8/1f/PE9S+Wh5Nhhc
         uFz+nGc8a79/5yQaLlW6ySydpi0WDOHI/9I0Ay3F4k1yyBGX1jH4rysdr7rhoZCTksct
         yRGqMnOj13iOQs5LtxSd7+nHc54CywOnZMRWQnDog0b3QB2c3utrxTWoi8K6I5yXzAU5
         ASHdsisDyOc9t8YsQHemRHBGFg0hN4j9iuaks150ay9stdA2qxvw36NPjCEU95NTCUUu
         jXbw==
X-Forwarded-Encrypted: i=1; AJvYcCU9MoZJAR9OxBDZoOtRSzF9uznuBIDsH3gxzekV6cjHraubeVpq33LMrZBiFtpsQ5lJ8mkTrbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+o1EIWSLH748kUjGyNpVsjDLv9WElRuYzSL1wpemZnDcLO0Q
	BOv2mvmEE6qLsMloXWVLViLakMaydBRtzBoarcSq42zAi9By2Rfj/vFbBXjh9A30gq4Rj7dr43j
	PdGlzcBHcgzuv0A==
X-Google-Smtp-Source: AGHT+IFnKwSlCOoJNm5BxGPhmRz/amuoNvsx4cXYb+6Q6QrBidCBXIIeFW3Sr/GWP3mQXZfKTbeDmXlGgmRWpQ==
X-Received: from qkpi5.prod.google.com ([2002:a05:620a:27c5:b0:8a2:d4df:9888])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1911:b0:8a4:107a:6772 with SMTP id af79cd13be357-8b2c31dd43amr401388485a.76.1763129209801;
 Fri, 14 Nov 2025 06:06:49 -0800 (PST)
Date: Fri, 14 Nov 2025 14:06:45 +0000
In-Reply-To: <20251114140646.3817319-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114140646.3817319-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114140646.3817319-2-edumazet@google.com>
Subject: [PATCH 1/2] rbtree: inline rb_first()
From: Eric Dumazet <edumazet@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a very small function, inlining it save cpu cycles
by reducing register pressure and removing call/ret overhead.

It also reduces vmlinux text size by 744 bytes on a typical x86_64 build.

Before:

size vmlinux
   text	   data	    bss	    dec	    hex	filename
34812525	22177365	5685248	62675138	3bc58c2	vmlinux

After:

size vmlinux
   text	   data	    bss	    dec	    hex	filename
34811781	22177365	5685248	62674394	3bc55da	vmlinux

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/rbtree.h | 16 +++++++++++++++-
 lib/rbtree.c           | 16 ----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 8d2ba3749866f500a492d267e5e13556f6aa3f55..484554900f7d3201d41fb29e04fb65fe331eee79 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -43,7 +43,21 @@ extern void rb_erase(struct rb_node *, struct rb_root *);
 /* Find logical next and previous nodes in a tree */
 extern struct rb_node *rb_next(const struct rb_node *);
 extern struct rb_node *rb_prev(const struct rb_node *);
-extern struct rb_node *rb_first(const struct rb_root *);
+
+/*
+ * This function returns the first node (in sort order) of the tree.
+ */
+static inline struct rb_node *rb_first(const struct rb_root *root)
+{
+	struct rb_node	*n;
+
+	n = root->rb_node;
+	if (!n)
+		return NULL;
+	while (n->rb_left)
+		n = n->rb_left;
+	return n;
+}
 extern struct rb_node *rb_last(const struct rb_root *);
 
 /* Postorder iteration - always visit the parent after its children */
diff --git a/lib/rbtree.c b/lib/rbtree.c
index 5114eda6309c9d867a3e1ed9358bf9b3b275eb71..b946eb4b759d3b65f5bc5d54d0377348962bdc56 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -460,22 +460,6 @@ void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
 }
 EXPORT_SYMBOL(__rb_insert_augmented);
 
-/*
- * This function returns the first node (in sort order) of the tree.
- */
-struct rb_node *rb_first(const struct rb_root *root)
-{
-	struct rb_node	*n;
-
-	n = root->rb_node;
-	if (!n)
-		return NULL;
-	while (n->rb_left)
-		n = n->rb_left;
-	return n;
-}
-EXPORT_SYMBOL(rb_first);
-
 struct rb_node *rb_last(const struct rb_root *root)
 {
 	struct rb_node	*n;
-- 
2.52.0.rc1.455.g30608eb744-goog


