Return-Path: <netdev+bounces-250078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1903DD23ACF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B069C303CA96
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C543C35E551;
	Thu, 15 Jan 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQmn7lQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D635EDC7
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470116; cv=none; b=VK0zKH6X01bBkiW2VLAkNZCbu6/q6CGnI13ASKQyzMu8TIJqBwF6o/5pngTPRJVF+6tKSox/pZemt5tQCgL3IbWb8AuKGcKBCpCpEcn3bufUUbXL5ByCJ8ziwQxwDLS/A2JtDG2ExGc+7sVmABGeHmazwPta3BnaG2/IIGhFGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470116; c=relaxed/simple;
	bh=7AK9IKPYpwqNTWnDU4m+x01AySNNdS0hqmF0+1Igkqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tTkbcSTIHnBkGXVX2cdBh04HJ4m8DGsgH98q/W3k3DJXVU9IBLSDxAj1hxI2+f/t/BkyEYUOS7ip6uG3VH7chnKOUcnzJhiVFnu6+JkvVlTMhPAt6yyTyhQAgi2XZTjycjY5wW/HMofSKL8HE9barXlUejKOKagl7KxXm+UFTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQmn7lQm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-793b952f32aso6979837b3.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470114; x=1769074914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jRPAOAafeqFSMvBOWYwdGH+mQ7DcEl/+3enva4oSb0=;
        b=QQmn7lQm5dGTxdv+cxx975KQqq/iNpnFuezZS9W2hg0iEhhcRLwcLMGB4uU11qyx4G
         3pCgUw8LAiS6edqbG4ThygWCZkwMn2B5KJnKw1fI8HJtOBjIL+vaNnQf2vx3/yvWtM9b
         8fnHvaMrwmVTPyZm3HmuS3K47xIQXmRvftBHY21CYSr4r03HMamgDVrbOZTsg5zDaevo
         244kxAaP1elTRVWhAb86ZppkM0HaBccXHvY0KVQ7NQi7Se+Aex2ep9enfsZIhjeYj/zX
         VOQxOpQUIBajrauVABP8/wVCsR7bsawizEckke50x/RrvSpsv6p5pIx9ZeDA1oGDuOk2
         n0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470114; x=1769074914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jRPAOAafeqFSMvBOWYwdGH+mQ7DcEl/+3enva4oSb0=;
        b=iZaCM3twK5C10FUuNsBltxeU+0Vp4D8ZMUgJ8YHDAac9OCVA45VKIVTOwC3/L3k7k2
         cpK88axNcJYH4JPDLntbwBRWmjW1S8rG0N3yCDSbN8DMZ7ptPB4cqFHnjInyQhwdwl6P
         QynazDHFdTw660V7hsmB3ZkfNHMup1h2oxaWfQzeNhh/615aIAfto80aalkX5/+jurk2
         tCf/3TbM+Mz0Dq+6eM2/WMqm8g+T6E7UPpkt++362CaohJeDyNtSVFbQnNZZGqfvOsad
         5Rglvx8Efl+Tr3BXlw/ghPPVU1x8YjOkvw/0qrXpYvnP8cwd6x733goWckH4HMNkX9Wv
         iohg==
X-Forwarded-Encrypted: i=1; AJvYcCWY87Wpcgw5rUrH7zp13U2nkzoK9eYzoFDxLZ8ePbc3hazKLgB9tqdKUoxlZP1K7oHsHfF7da8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynX2iGs6gq7w3Z0qpAcOtI1HPOTLrOEOLLI9HjYL8qnDGiDR9w
	91qr7F90lSvovW12Ca4HzXhYoBCtILLu3WWVXuAj8fSUwXKdMVUN1KEWsUwGA0W3eikaLRqX8by
	vc2imbyz33Tr9aA==
X-Received: from ywtt22.prod.google.com ([2002:a05:690c:a596:b0:789:2e24:b795])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:4a0e:b0:786:3ee8:6703 with SMTP id 00721157ae682-793a1d6769fmr43197377b3.48.1768470114351;
 Thu, 15 Jan 2026 01:41:54 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:39 +0000
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115094141.3124990-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] ipv6: annotate data-races around sysctl.ip6_rt_gc_interval
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add READ_ONCE() on lockless reads of net->ipv6.sysctl.ip6_rt_gc_interval

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_fib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 2111af022d946d0b9e1a35abdcbac39cbe00f921..174d38c70ac454ac4bd2399a4567862e887150e3 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1374,14 +1374,14 @@ static void fib6_start_gc(struct net *net, struct fib6_info *rt)
 	if (!timer_pending(&net->ipv6.ip6_fib_timer) &&
 	    (rt->fib6_flags & RTF_EXPIRES))
 		mod_timer(&net->ipv6.ip6_fib_timer,
-			  jiffies + net->ipv6.sysctl.ip6_rt_gc_interval);
+			  jiffies + READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval));
 }
 
 void fib6_force_start_gc(struct net *net)
 {
 	if (!timer_pending(&net->ipv6.ip6_fib_timer))
 		mod_timer(&net->ipv6.ip6_fib_timer,
-			  jiffies + net->ipv6.sysctl.ip6_rt_gc_interval);
+			  jiffies + READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval));
 }
 
 static void __fib6_update_sernum_upto_root(struct fib6_info *rt,
@@ -2413,6 +2413,7 @@ static void fib6_gc_all(struct net *net, struct fib6_gc_args *gc_args)
 void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 {
 	struct fib6_gc_args gc_args;
+	int ip6_rt_gc_interval;
 	unsigned long now;
 
 	if (force) {
@@ -2421,8 +2422,8 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 		mod_timer(&net->ipv6.ip6_fib_timer, jiffies + HZ);
 		return;
 	}
-	gc_args.timeout = expires ? (int)expires :
-			  net->ipv6.sysctl.ip6_rt_gc_interval;
+	ip6_rt_gc_interval = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval);
+	gc_args.timeout = expires ? (int)expires : ip6_rt_gc_interval;
 	gc_args.more = 0;
 
 	fib6_gc_all(net, &gc_args);
@@ -2431,8 +2432,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 
 	if (gc_args.more)
 		mod_timer(&net->ipv6.ip6_fib_timer,
-			  round_jiffies(now
-					+ net->ipv6.sysctl.ip6_rt_gc_interval));
+			  round_jiffies(now + ip6_rt_gc_interval));
 	else
 		timer_delete(&net->ipv6.ip6_fib_timer);
 	spin_unlock_bh(&net->ipv6.fib6_gc_lock);
-- 
2.52.0.457.g6b5491de43-goog


