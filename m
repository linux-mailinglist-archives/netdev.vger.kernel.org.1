Return-Path: <netdev+bounces-215497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58CAB2EE04
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D23C6800C1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E82D4816;
	Thu, 21 Aug 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APGYqLiP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C5221F24
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756967; cv=none; b=hshobO9PR4ffWJOzVPyVbBMYT15fGynCu5yoHdEpfu20/tSXCfpesxLJgBlR/tk5KWXc4edrb+ZG3Poe/99WkRjo/9mn6Zr5HpSR6Gg5yOA8PoAM6S5kfkUB9gZhXhThbANMGrAPcwoeuVd/7MYTA+Ne/LPpcB/pdIsoOfRsOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756967; c=relaxed/simple;
	bh=VOyeCyosHifBPEOPHUr4fnoBy5uScFCPipmqak2hLnE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iRrTLMZVpyIH7iJBGB3yJEimEAkNaS7EHCOXOliVDkKUbZu9FURhV+si8pB8i8ZKz3YutipK2oU3JtQNlMYTl2xl3UgXBnWF/12f4KtjW6mEDBmVq6nINg5ZGiI+8DvqWIJl9czUGj3ISZSig5hDEl2ROOUHDvpgWXmQkd9KaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APGYqLiP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325017f25aaso22919a91.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755756965; x=1756361765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6BINARX3jgHpRkRGzpT18tkVke2JIIkBe/vu5yrL60=;
        b=APGYqLiPZP4cuM+pjCAFRIHDskvAvYUZhXYdCafY30BEnJGmOldM0TWDomNOWi5pX2
         0UEe52D2HjaHTmRK1QRuzUWNpTELSaHXe+m+F+raI7vV84fc580aIGP9lD2c529GCSwo
         +g7GLpoR67p6UD681WpbgbIgEiHakt65Mq3Pxs8uoiGVCLZwlQ+CiATjuPMY7jfGc2hg
         QXHU1ID6B5Wz+tPLXORd+l6b+IfeeehWlHYeqQK1QKztItXPQF5qOgvFFXicc2u1lsgs
         kL2fCXs4a+++v2sGMXxdDZCijkpfPjpN7ZT78sI/NUwczqDKLn1qLae+o1eSzr3hM+u9
         ooGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755756965; x=1756361765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6BINARX3jgHpRkRGzpT18tkVke2JIIkBe/vu5yrL60=;
        b=iS/PJJMKUND+TTlAByiiYpvRIIbaBHZr6oiQ/dH4uHBKU/ioh6SSFOblYv1HcowWYm
         /IBdv//7P3Dd24yG68vp8ikAQTQFaqXBgZNxbhxkqrTJ/0PeRcptUp5BPgPI5oUHMl9X
         mv2P5tfYWNQZpBGG6Xr7w9c8sRzwxKnNsd+8CYdLSN7xN7uMSnlYbkxaY2iSv0qcevgv
         qDo+6O7OBcRZuiCWUH7vfXUPCA4ARG3qd/jctkGcVmV5+bOomQkBi4CMgISgQf2J5ANS
         7gg68f05hRBWnYhba+wtALTP9M+ruDkthXt81wIkK14mOC0yARByzB2IXADTpJfeaJQa
         J6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUVwy7RGbEc+QiLB1jqcqFTFcKe6KZQ7fZUENMAd4GvZNSe7HOZTvn+QkZQxhO59q7Zd80oET0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb84RgDVSoo3TY/gqRAdB5t6xVKFCDxkLhnE3AHHAkaIO6HnSU
	k1nxPeXsDcalCpVn1KzNionRQq1Sa9y3KvrLkNjJdjqM/Tf6wXO33E0d+O1Ola5nMEuSy/8HB8V
	OTBO2mg==
X-Google-Smtp-Source: AGHT+IHe9ku0ed5HNrVsyEm7umRTT6+rvTHwakRbYGWgHzYFGbkDa1KU05uxgSau8xEO+UjuWrY95V8V88Q=
X-Received: from pjj13.prod.google.com ([2002:a17:90b:554d:b0:31f:b2f:aeed])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec2:b0:321:9377:7730
 with SMTP id 98e67ed59e1d1-324ed12f563mr2136431a91.19.1755756965496; Wed, 20
 Aug 2025 23:16:05 -0700 (PDT)
Date: Thu, 21 Aug 2025 06:15:15 +0000
In-Reply-To: <20250821061540.2876953-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821061540.2876953-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/7] tcp: Remove hashinfo test for inet6?_lookup_run_sk_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 6c886db2e78c ("net: remove duplicate sk_lookup helpers")
started to check if hashinfo == net->ipv4.tcp_death_row.hashinfo
in __inet_lookup_listener() and inet6_lookup_listener() and
stopped invoking BPF sk_lookup prog for DCCP.

DCCP has gone and the condition is always true.

Let's remove the hashinfo test.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_hashtables.c  | 3 +--
 net/ipv6/inet6_hashtables.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index fef71dd72521..374adb8a2640 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -436,8 +436,7 @@ struct sock *__inet_lookup_listener(const struct net *net,
 	unsigned int hash2;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
-	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
 		result = inet_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
 						   saddr, sport, daddr, hnum, dif,
 						   inet_ehashfn);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index dbb10774764a..d6c3db31dcab 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -211,8 +211,7 @@ struct sock *inet6_lookup_listener(const struct net *net,
 	unsigned int hash2;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
-	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
 		result = inet6_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
 						    saddr, sport, daddr, hnum, dif,
 						    inet6_ehashfn);
-- 
2.51.0.rc1.193.gad69d77794-goog


