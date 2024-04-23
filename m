Return-Path: <netdev+bounces-90545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F88AE712
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3731F25DE8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8686AC2;
	Tue, 23 Apr 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxlOzrkB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFB85C4E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876984; cv=none; b=JvgUrMM31ELejk6RLr5NOYApdlwos0V1jSaw87mbDwpL2b1MLgvmMqxAmQOYO61dkA4URKLyDQbVDO/TeI3uIlJoLuI2eROv554Gn4DmJuFUyPfw8O+ASMqwnBE4is9Q28i4jj0TdPXnCGGGwSU7dutLwRNrVYLy5YvoYmGmJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876984; c=relaxed/simple;
	bh=QFxslPSEo74p62WKNfUcMHjN0BnOuD+s+Y9P2f7Epo4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EVRo6iIqucbYJFMXJSmi0xYsuVmcbKF17WwpIqiCg2jER+dHxwmm4mjHk+zsddVm/t+6+kyiyMhGp24BPSzBZpuSzDx+fGBO5QSPUp8IrlTj6HlapgqpMap1VtBiViVL4YgiHIW8gDa5WcAFOpuq9qoyE0BC+fYn4Ulige3rHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxlOzrkB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150e36ca0dso93073707b3.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713876982; x=1714481782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4DmhxbQZvPAwteWSi09i5UotY7tqM6eGArkTWrF1j9c=;
        b=NxlOzrkBSjRuqfuA8qipfZagsjtUZz0LX79e6qNeTqno+8TS9MgzMEtKpCMk9ChRjb
         Ioc6VLYsQG7/LRd+an6//UAoqjOD0FnGuoVyhGLMSpmikLLDUwtO70/Me9zq8pVEX/q4
         mzsgLfSZWNRod+DGEeomHVmLNrC6TzXOEaCW4okZyLmNc7cCd+oUcsjF0Ovd6WA5zlLv
         BcMS6VI9f/0Bo+b9HK2KqpIQ1/jZxG5knsRlLdYowm+lrDX/aLw04FenkWh20nmDJTxi
         XgBylU2PlW+oGIobOypsKvkUabMOvKj/sRS3wWsu9DfcEKUdOIS3N2aPo8T1T0Bx+F3O
         OigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876982; x=1714481782;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DmhxbQZvPAwteWSi09i5UotY7tqM6eGArkTWrF1j9c=;
        b=SkyTDhkD9u8s8LsZN1fU9IQot3M9e+tpXczlNxOF/YxYAOIjv6mcXS1JeXrRPloSm7
         I1Kp6YXH79/qZvCILz8zyJIp0fbHhMMw7CfNUrZtmXPfnn1Tzj9d+1h2QoTz6Dxz69qI
         dqGCFIl2IFOIDaHR3D/plWKj7gfIRX48owhPcJiL15tedZfLDepxhi3b9i7MxaPqiJYN
         4IyFLOLqoKK6CDP9BAUXjht4zdalBHLfWuygjmhV9GW4Irox80yNOeeSh/LC5Eoylt+K
         4l98BWSJtOR5CRa+Olh62/niZ0K9n8bcTQR2wYLMpqh0xPrTL3tnxTW3zF6Lbqa91oab
         W2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/+sw7uOixT1sRYaTjTfhKFB/io9IWD1wqLu2MAWpkya0Vyhp6xOipCvyneOGz7TPC5tj8e6dG8cgduY0vOzTFZsfKNpoe
X-Gm-Message-State: AOJu0YxsT95cTcxmqYQZGC1LGr87+AUl/VwOpuPMgzuK6/Ja+3xY1QKy
	5czDUXWk8Jm5DQArdcQroOHd3V9FhAd23dhsq4zM8/5ozZJxc4ceEBMqadSWQDPkaf/V+NJDGY1
	B21nulL2CJw==
X-Google-Smtp-Source: AGHT+IGYsKSO1mFYMW+A3wU7XRUhY6Ayeg9Yu7FR/Quraup3OMhPLcs849NpgePEa6Xf5I0ij/unwGeVczXojg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:725:b0:dbe:30cd:8fcb with SMTP
 id l5-20020a056902072500b00dbe30cd8fcbmr1015050ybt.0.1713876982320; Tue, 23
 Apr 2024 05:56:22 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:56:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423125620.3309458-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: avoid premature drops in tcp_add_backlog()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While testing TCP performance with latest trees,
I saw suspect SOCKET_BACKLOG drops.

tcp_add_backlog() computes its limit with :

    limit = (u32)READ_ONCE(sk->sk_rcvbuf) +
            (u32)(READ_ONCE(sk->sk_sndbuf) >> 1);
    limit += 64 * 1024;

This does not take into account that sk->sk_backlog.len
is reset only at the very end of __release_sock().

Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
sk_rcvbuf in normal conditions.

We should double sk->sk_rcvbuf contribution in the formula
to absorb bubbles in the backlog, which happen more often
for very fast flows.

This change maintains decent protection against abuses.

Fixes: c377411f2494 ("net: sk_add_backlog() take rmem_alloc into account")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 88c83ac4212957f19efad0f967952d2502bdbc7f..e06f0cd04f7eee2b00fcaebe17cbd23c26f1d28f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1995,7 +1995,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 		     enum skb_drop_reason *reason)
 {
-	u32 limit, tail_gso_size, tail_gso_segs;
+	u32 tail_gso_size, tail_gso_segs;
 	struct skb_shared_info *shinfo;
 	const struct tcphdr *th;
 	struct tcphdr *thtail;
@@ -2004,6 +2004,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	bool fragstolen;
 	u32 gso_segs;
 	u32 gso_size;
+	u64 limit;
 	int delta;
 
 	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
@@ -2099,7 +2100,13 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	__skb_push(skb, hdrlen);
 
 no_coalesce:
-	limit = (u32)READ_ONCE(sk->sk_rcvbuf) + (u32)(READ_ONCE(sk->sk_sndbuf) >> 1);
+	/* sk->sk_backlog.len is reset only at the end of __release_sock().
+	 * Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
+	 * sk_rcvbuf in normal conditions.
+	 */
+	limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+
+	limit += ((u32)READ_ONCE(sk->sk_sndbuf)) >> 1;
 
 	/* Only socket owner can try to collapse/prune rx queues
 	 * to reduce memory overhead, so add a little headroom here.
@@ -2107,6 +2114,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	 */
 	limit += 64 * 1024;
 
+	limit = min_t(u64, limit, UINT_MAX);
+
 	if (unlikely(sk_add_backlog(sk, skb, limit))) {
 		bh_unlock_sock(sk);
 		*reason = SKB_DROP_REASON_SOCKET_BACKLOG;
-- 
2.44.0.769.g3c40516874-goog


