Return-Path: <netdev+bounces-266477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JdyAO37sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB425C617
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09461307E875
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A5299A94;
	Wed, 11 Mar 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="znmiR9Y4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19583101C0
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206447; cv=none; b=sXJokQRJ1bo7obbRJ9ZfI8qYBBsl12LbaAl90jwJunoc55As6ug8yLx39QRO1ZN1eXGmh1ODFeZpQ3WbdCWHIqO2BGuECsxB+pTedAd3/Y1WzmMSpnBeLqdJnyPjEHjMgxKOxO4dkO9/rlpENSujhWYP8N9ydY/btutL5qzxflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206447; c=relaxed/simple;
	bh=yNkaIRhbEU32KWp/5g7JkcCDuRlTrdrKF+AklDpAXKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZFWccZLvP8jVyB7fWmJ00tyxHmhJF4ex4DVjFJ6pRpdqcb8dgiI8q6OyFJMtdM7pi2CwRJgnXsAT0jHdqglp0/+HoY4ZwQoXmgU2erLT0DFx7HluuqPa2+RiBeUbHuMF7i3zymEqmtKW/n3skZ5QvPigYIvpwHdi43JzfYoSiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=znmiR9Y4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3597b55adebso7222956a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206446; x=1773811246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bW+euxPY8B4J2inGbQ6ic4oAmSpOI8j6HQd+Yiri5A=;
        b=znmiR9Y4EzFB1rNnEhH1bnGWgMDx4rykQ24z6fKztrp+UG2ao0N1Vqus31ERkfXHbZ
         +XpqHFZGhj+I4+1mbW42mvGeq2uqEOeOYQaYdKnf7Rx+SNdXd2n2i5WHkTfIrYyMzR4O
         i4eCrK3HS2tIUSStP19z7MLJmLtiDQC/mJO6TgxD7TrZIUFc7p6/xZrdbtaQt8j61isJ
         WKXqZvzC2AWFvXZaZHwXM61cq6Rh6HKGyIWWzrMkoI4uICD6QN7VEtg/yW1cj/xS0Fi8
         H6L+1+sMfyEq869UlDYHzFcPct6TktOVoNWjdSnCG8KaRzPqKrv43dWeBiepJP5Jofyx
         Gb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206446; x=1773811246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bW+euxPY8B4J2inGbQ6ic4oAmSpOI8j6HQd+Yiri5A=;
        b=m9/gB/Fb8KAVzNHuqx13WdxfvxlIWwDfMayMIkhBJEEH4DKyrA1OhVw5RYUum3ssP8
         vSzdQhQo7PJfNCLKBz7pd+LVhkuBozL19USQtQlhUUAz+oUWpOEmgcSgpSZRM/M1k7gJ
         jzcUqESTxpRu5U3rCKD1DqTxqYQhhB0Ks/n3+VYQ5vPrS5ZBfu+iMmYk9oEUNzzwMgN7
         h0uWPM0rdyGQ9WGOv9y+RqQdqIh8bJ510ozvYNTUgzQlVNI4hxlKWzrP3/ws6Dw1XhMs
         XvQi0QImK5Py9dCLfisCacoPfxbDW3bINXqd4TPHxTsEKL4qVLLQH3ZpjAbJ/xSr9KZr
         T9gA==
X-Forwarded-Encrypted: i=1; AJvYcCV6V40R9tlajwd0NyBm2zCzy1ucRCNJz9q4PujQK0mjS2CkCYeQbp/aORei36xa1DK+5N+j/Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvCRfmwhGZM4r9jEy1UYYGmLvBOak0vbjFTsPKPsRxOYaN1xf
	/H7zMNqYpdAp1WsblU1SBt86BoTkPK5NdDHgo3gsTMwXnZx9p7ozTUl/I5I6CTIWznfy2cUeSeE
	SWGvkDw==
X-Received: from pjbiq15.prod.google.com ([2002:a17:90a:fb4f:b0:35a:b8:777a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5111:b0:359:d54:846f
 with SMTP id 98e67ed59e1d1-35a011d0b9cmr1498535a91.7.1773206445854; Tue, 10
 Mar 2026 22:20:45 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:59 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-13-kuniyu@google.com>
Subject: [PATCH v3 net-next 12/15] udp: Remove dead check in
 __udp[46]_lib_lookup() for BPF.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 75DB425C617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266477-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

BPF socket lookup for SO_REUSEPORT does not support UDP-Lite.

In __udp4_lib_lookup() and __udp6_lib_lookup(), it checks if
the passed udptable pointer is the same as net->ipv4.udp_table,
which is only true for UDP.

Now, the condition is always true.

Let's remove the check.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c | 3 +--
 net/ipv6/udp.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 14b372b211be..fd0bad44d111 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -699,8 +699,7 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 		goto done;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
-	    udptable == net->ipv4.udp_table) {
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
 		sk = inet_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
 					       saddr, sport, daddr, hnum, dif,
 					       udp_ehashfn);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index eeb77363a556..5ba399218d07 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -370,8 +370,7 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 		goto done;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
-	    udptable == net->ipv4.udp_table) {
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
 		sk = inet6_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
 						saddr, sport, daddr, hnum, dif,
 						udp6_ehashfn);
-- 
2.53.0.473.g4a7958ca14-goog


