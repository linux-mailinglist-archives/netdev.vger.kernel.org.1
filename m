Return-Path: <netdev+bounces-99742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05538D62F8
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC9B24323
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69032158D91;
	Fri, 31 May 2024 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKDlF2j/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8C158D78
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162006; cv=none; b=kICrMR1II0A6qaHhK7DJb5qxSYYFMjRvzzjjOAG4whfpdj03i0E04MPuel04HzjG/x7TrSXO07BKTW0y2ALm+ho8MfwaXmK8hZ/ou0fJoQsHwV6/yMkQ/XSONmAWmSA3+maGi/eZ7WRHofeeSZzg9zutr/pFxEbd0JajA0o3dYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162006; c=relaxed/simple;
	bh=axsyOLYpOtl0YxEdYGMHnEtHTAu+l+pYsDqihrt736I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OjGoiyO2k+2JSrn1GP2N/H4G3R3rbu2t+AS4TpqMRiqYj0J1s62z17fKqWgHCtqMkTzSqlWYY2YxD9dM8dxqt9Kluy6NM7nhaPRbx4P+mzDvoLFZxY4vQDqtpPxrMRvcEywmMVWAxsF77ZXYArZmAH+y2+rygYiaqHPUFKzLKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKDlF2j/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa78a1b142so823992276.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717162003; x=1717766803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrxp3Oe2K9pjE9tLTXKFddbG7yejIdhQMSQxRP/jLo0=;
        b=dKDlF2j/XORPebnxo8OsnfeCSdqv07l+/NWVy/nikp9zmLw1QOMGqxNK9eDddEi8DL
         0DUa7WR48cmgszSVZqCnmLsxF/wTZ5bqLICrXy0eKyyShuLIjq7YFQFd6pvh6WrBdkOi
         zGcRaGFgdihOxCMHg0RQZ5KjVZP1vIsZ4kPFw5ApTStza6m4LBRwKoGkl7akQVH05tDN
         v96BHJMo5AWTQ2X6dPdh6TnoseJ4F4cC7zkMWlb6+VDy7tlFFz7rwWCcAX9nXWdXN/io
         0j1znJApuKWqTCvkIdAjRwho4Eo4b5WaB3Byrm4uPVx5M0cuOKtpHoLfA65NnZ9gt7rh
         obNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162003; x=1717766803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrxp3Oe2K9pjE9tLTXKFddbG7yejIdhQMSQxRP/jLo0=;
        b=qRm4s89GeiQjrlvwcD4/MK9hbGcxLa56iS7V50xs2gjGwCyX6OM6ey2t66H86+V03R
         Jfdnw54rSp55Y2j9DC1ngLRdBsckXW82PR/ac3LR6/J7oSNHTiUEbSWkoOD2A3BaqZZZ
         BLFARYWm5LB2MKWrK2upnKzdHca/hUAwz2rJXhRn1irxQz3UgD//QwJu/JZLZwcvj4hh
         mOOC3pjDQ+ooZVG4v5tZbd3Easina100o1Y6j/925/iLVMhsmV1eE9Ef7YCHexeYMeVz
         2T+4M5eVAEOAw7HBN+nar37a4Qi8SAUdsfVAEE5SNptLlfTTxG8aF8fWWrEFILe12IIg
         w+9w==
X-Gm-Message-State: AOJu0Yx9kcGwI1s2+fCIqYAsQgolKWOEP+nPZf3HZKWjRpHIFeDT73ut
	h4JIZIo5AqqM7P2wBVKG1IAHQB4zj68F+pRiqSH9xtWq59KzTRGxxYmhB23L2xF4akwlitKs9DD
	lTV/fVlroqQ==
X-Google-Smtp-Source: AGHT+IF91IUHjRJVYVh+keDpVURabuBE4/WeBS7u9ymj0OE5liefOe+n6hbZElWOYmoBWB2SJxqidWzDcCUEMA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1247:b0:dee:6f9d:b753 with SMTP
 id 3f1490d57ef6-dfa73bfd47fmr83277276.6.1717162003628; Fri, 31 May 2024
 06:26:43 -0700 (PDT)
Date: Fri, 31 May 2024 13:26:32 +0000
In-Reply-To: <20240531132636.2637995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240531132636.2637995-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531132636.2637995-2-edumazet@google.com>
Subject: [PATCH net 1/5] ipv6: ioam: block BH from ioam6_output()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Justin Iurman <justin.iurman@uliege.be>
Content-Type: text/plain; charset="UTF-8"

As explained in commit 1378817486d6 ("tipc: block BH
before using dst_cache"), net/core/dst_cache.c
helpers need to be called with BH disabled.

Disabling preemption in ioam6_output() is not good enough,
because ioam6_output() is called from process context,
lwtunnel_output() only uses rcu_read_lock().

We might be interrupted by a softirq, re-enter ioam6_output()
and corrupt dst_cache data structures.

Fix the race by using local_bh_disable() instead of
preempt_disable().

Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ioam6_iptunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 7563f8c6aa87cf9f7841ee78dcea2a16f60ac344..bf7120ecea1ebe834e70073710be0c1692d7ad1d 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -351,9 +351,9 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 
 	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
-		preempt_disable();
+		local_bh_disable();
 		dst = dst_cache_get(&ilwt->cache);
-		preempt_enable();
+		local_bh_enable();
 
 		if (unlikely(!dst)) {
 			struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -373,9 +373,9 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 				goto drop;
 			}
 
-			preempt_disable();
+			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
-			preempt_enable();
+			local_bh_enable();
 		}
 
 		skb_dst_drop(skb);
-- 
2.45.1.288.g0e0cd299f1-goog


