Return-Path: <netdev+bounces-81621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBA88A81D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941961C62F43
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170FB13172F;
	Mon, 25 Mar 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1/7OiK6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77636133424
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374123; cv=none; b=al0hBMCZrFgmuBZMJMzYjyXurhi85jcocFrjoq4YNoxgK4Ht61N/bprpotCqeJBeGbePyV5/EkXa9ZGSCc3+b6F5+DHf2005/DowXEV+Vu+wXMBWThR8xZGr+gKCSUT0fenwiMyUWz2ILrgbMLyVkObfMKnbUPi2SXklziwrnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374123; c=relaxed/simple;
	bh=i+SV40WUK7xNRBYALPzkRiXj47sqA7GX6nN6AbCIOM0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hxH+opCG7yz4Ggrq97nqgwYLWeihRQUKNijZSwtnLOhKcmrXfVHjx3LnlRzSODxKAWFopyAka78BCTQkUFp1er13vwnYw5DHTP+AemEKrfD8GpiFyqgbfewxMaz8ZXSvS2hap0bozwpgHRKGM64WzFysZe9k3uOWXtQe8VNE1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1/7OiK6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd169dd4183so5103834276.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374120; x=1711978920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCET6HOYkH30XzrgJAjhLkjjCxlu0fewLc7w3qQSLBo=;
        b=l1/7OiK68+Kv/I9g/GKdDn7rTJ6zcKKdNfVpT6hz+nV0Lwwm1BFiQma9QkjOUnoxGs
         uA/KOU6HGgXwNDcMwLWxIv5Ctu3TlDVUo2jGHMZ6dk4fSbmpOK4F4bNTmzaW8qXBjeQU
         WPtQ93iT/ecmeXA230JGvAk/KBidj2/J+t0NpIlLsNh0ps+QrsC5JYVAKorj3Q4M43so
         lcCgcpMh5yUlqCnD+fblDdv2HSgrc5zvb/YYFFrGuHhQjAt2oa+BE7GlBY/eTS3/N5cL
         xyaHhVUX7xaU9RHG0i/1YcVxxVqoVmsO9RMbgztG0+b0QDA2YMeYYnKEKv1LvoEKpBoN
         /gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374120; x=1711978920;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCET6HOYkH30XzrgJAjhLkjjCxlu0fewLc7w3qQSLBo=;
        b=befob9ApGntMF8tYmjHI4cbeiphUW9s09Til/astJ4HKjVqLfTWRTmwV9wRQaPxxYi
         6VMlLCuuRCkoryOEKxMKPKSjl1vSsnLuBQCqWdQxMhi2pSX9DPFYhMPlis9RLG9SLygM
         SHNuQrsjKaoDSeUflyK+n6UeRGTIck5gS8Mb+nlZdDvn9T55iZdRkBVoHYfitx0/KgE8
         clTTW2jpyaJlVsxkqidiB1PkakII8Jypbt5zSsk0+Ub1Wo/1nPJRK/JYGIOcJaNahrpK
         U5dpIsV8DnAF5BsGOqdUSAhF3IWZ181kffBsKVaQF7C1EKqwB6/slej5YpLecSgjZy1x
         HXcg==
X-Gm-Message-State: AOJu0YwdRUyzXZRhRTmfwNg7OLK2jEijv7k9aXYlgBuxgLG2+hm/h9uE
	tICpsG0NmHjiOOROO42vs5S6kz+K+Nenn4iuNI4hTYAhF+8PZ+5d3OQqYFlcf8ieh4hLtQLXcbE
	R89p1Gbt8hw==
X-Google-Smtp-Source: AGHT+IET91beyVXtzdcvVTaIgD3niAdBn715riqH8/QRStJPP4d1FCmR6vyifiWkxXk7dozJJ8QmiIGbzWDkzw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2801:b0:dd9:1cf2:6b31 with SMTP
 id ed1-20020a056902280100b00dd91cf26b31mr247383ybb.4.1711374120541; Mon, 25
 Mar 2024 06:42:00 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:41:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134155.620531-1-edumazet@google.com>
Subject: [PATCH net-next] net: remove skb_free_datagram_locked()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Last user of skb_free_datagram_locked() went away in 2016
with commit 850cbaddb52d ("udp: use it's own memory
accounting schema").

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h |  6 ------
 net/core/datagram.c    | 19 -------------------
 2 files changed, 25 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0c7c67b3a87b2351a3a65408c6d00b6eadf583bb..b945af8a620881ad07ed465cc1c46a2cf6d95333 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4063,12 +4063,6 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
-void __skb_free_datagram_locked(struct sock *sk, struct sk_buff *skb, int len);
-static inline void skb_free_datagram_locked(struct sock *sk,
-					    struct sk_buff *skb)
-{
-	__skb_free_datagram_locked(sk, skb, 0);
-}
 int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
 int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len);
 int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index a8b625abe242c657dca8cd0188c236553757c6b2..e614cfd8e14a50a08c764dfed30c2e0838413a93 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -324,25 +324,6 @@ void skb_free_datagram(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(skb_free_datagram);
 
-void __skb_free_datagram_locked(struct sock *sk, struct sk_buff *skb, int len)
-{
-	bool slow;
-
-	if (!skb_unref(skb)) {
-		sk_peek_offset_bwd(sk, len);
-		return;
-	}
-
-	slow = lock_sock_fast(sk);
-	sk_peek_offset_bwd(sk, len);
-	skb_orphan(skb);
-	unlock_sock_fast(sk, slow);
-
-	/* skb is now orphaned, can be freed outside of locked section */
-	__kfree_skb(skb);
-}
-EXPORT_SYMBOL(__skb_free_datagram_locked);
-
 int __sk_queue_drop_skb(struct sock *sk, struct sk_buff_head *sk_queue,
 			struct sk_buff *skb, unsigned int flags,
 			void (*destructor)(struct sock *sk,
-- 
2.44.0.396.g6e790dbe36-goog


