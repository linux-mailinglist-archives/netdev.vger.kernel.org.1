Return-Path: <netdev+bounces-80038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248287CA3D
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 09:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937021C22012
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07391755A;
	Fri, 15 Mar 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgKeKk9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB21798A
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492550; cv=none; b=GtO/LFgnPv4vmnv30NJiX87wB5a70DqGEwZKXMw37ULx5me4T/mlNwZt4K5mud0BXqVA+HgSOfE61BcjXuftkxk3mhoNZsl4rTOwHeoroqfTG8ZApjelQU6utck86scSZOyEaNp8BxU1tUFHztL1ZOOwx6XVVpw7tP8CkH7uodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492550; c=relaxed/simple;
	bh=5H706Y0gmm570HBuRhjK5DaC/uQep1yAMFfTV2AK/tg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VW2pq6HFAL655sfUWwqXbrJRdR1oJP34u4NdJydUQTQp92FPPvBcGGACIGC9gjAX8I0Yc1ok/iAgom/5C3RkBlFUcpHcR3i2KWQhT3VTnXPfZUtRGZtQAflkV2CpF/P43LuCPL1nWqPDXOo1ehgfuVsg83qjQKuGONw0IFlR9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgKeKk9H; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so2585442276.2
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710492548; x=1711097348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+1QL6bniEd1IyAOA4550ZTezM10mQAiMjSPvG6WuKq0=;
        b=rgKeKk9H5u2fPo/elLbUz4t83U5lJWW76CabLWtMKWxoufmv9C8YNrl11v0s6ZqzWg
         OY1OK1mZnFQImM/hekFjXw32jTWDeQw5GUbXF/mA8xhpHikibOFytBmcPcm+ObT/CIo2
         KUGDu9JooCfABjnWDvCJalM994fnCJpwuVVMDZ5ZoNeEJ79C8IymmMO7531gvB4204b9
         M27k1Rgf6Kr5NXJXZ5hbV4JHrBU7lewKPtEw3Q/OnVk0ddNLdRhjat19BcAmoIHLfD40
         RMg8bD0ZUGpk3MvUrQCtRUTybW5+lhOCxgyQhgG8iLpgBtWqyM1WiUXZEJr4j41JiAhP
         MLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710492548; x=1711097348;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1QL6bniEd1IyAOA4550ZTezM10mQAiMjSPvG6WuKq0=;
        b=EiPBNHg/bi40wqIqcLZ4AQMyhMgAIvI3d1I3kQdCS5g4sYb5EwFuwOXLLY6yQIpAEh
         uh0IgswfpxAwO/CuXRzDOteGEOTdeQaoQ1Xk4NFufknQdhKU5wce0PD8njIXkwc+CVAX
         YsNRWxrN9HCQMeNyq/gBagzhZeJ/72shRprd1I2dUO3fqTtfj97DrfxxuzSiRrMtL3f3
         Zd+1Z+ONs+FNXDrSNsifLjF2Fnpbs9NawS5L4eYDBI/ck33bJWGvvN2a6FyIczkGejaI
         3yKfQGPOTeXKiOQG6h7pUV+wCHhvgIFkZ4BUjWdbSZnL6JBDc9F47CxkvVeA9R1e6XQf
         arcg==
X-Gm-Message-State: AOJu0YyBNi3ap/oiSr+3mqsUhAuYsB14dOGbIBEXuCeIxakvFotqMCw+
	zpoE6ZwWVq6rLcvJPghLjuB8gOilOdvgjm8ZVfnR8NYlSyahIm99pHhiZzzjkk1AAlG2Wy56TAM
	saUSTRXr/og==
X-Google-Smtp-Source: AGHT+IHu2YDss3xWdZey1fE7LG4Nf7D0V4sIMP0zcEFXt8T4XtwCDDFfq0KcbLxLczXB/6MaVzIkSTcJYF+oLQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1a46:b0:dcd:2f2d:7a0f with SMTP
 id cy6-20020a0569021a4600b00dcd2f2d7a0fmr229714ybb.9.1710492548094; Fri, 15
 Mar 2024 01:49:08 -0700 (PDT)
Date: Fri, 15 Mar 2024 08:49:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315084906.3288235-1-edumazet@google.com>
Subject: [PATCH net] net: remove skb_free_datagram_locked()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Last user of skb_free_datagram_locked() went away in 2016
with commit 850cbaddb52d ("udp: use it's own memory
accounting schema").

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h |  6 ------
 net/core/datagram.c    | 19 -------------------
 2 files changed, 25 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 3023bc2be6a1c126bdbba2a0bc9b1f11d4131735..499ae20f161af6397ad3f973da42239f639fd90f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4053,12 +4053,6 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
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
2.44.0.291.gc1ea87d7ee-goog


