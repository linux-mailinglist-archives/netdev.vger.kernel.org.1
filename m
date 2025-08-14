Return-Path: <netdev+bounces-213831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920BB26FF8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979105A1C48
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F922550A4;
	Thu, 14 Aug 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xd8VwE1N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C772550D0
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202161; cv=none; b=mp50VJSpqbaOknb5UdAlFP79uArRXZh79Xg8q+gAcGeHA4zWERd+nTbKE3kOgP0C3HEatxktSEsTYrqBKMDNH6NAroFIkeDBfACN95D1SFZczk+2HCm7cS8mkt5987O5P8GK/oQ1sazzEbIv1T5ipDy/k+utLoqVma3JDYWX5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202161; c=relaxed/simple;
	bh=kNCka+5/ble2uhxoCvBkpMNTXujkGV/J5QaB+v82p+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qqg8MBzfTSxhwHTvVO4NW6hmw02/OW4LjX30BiNHsGshM2VdAKxTGuhvY2bO6VjaxcFzcF7NJPOqoH5wOoI9nXWTy5RyGDRWUGVRAjoMgfU9PNMgq8W2FRPLfdjQ5gxPGVZm3Bbk1TB2mZS8K54kcr2Pzkrn2oUJcx0hpN/HvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xd8VwE1N; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e46a20so2563994a91.3
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202159; x=1755806959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=xd8VwE1NkLUiuBNwXqCyRGX7pLfFBUhgeyEVN8uUJf/LiTTIzPvbqlqonTLSH8f3vd
         +csxUdnpcE5EdFy8Rn3jCWCHQQo148DunH8oXRWrk32jMlGiMrfHW7t3v8pQlK6ojEc9
         utb+hxuGs36VhgrnJ/WoTZAAyAazLsVIVKPCsK0C7zZi1oRlX4GnH+s9chHNfYd92sFH
         ZM2Z99Mh289qXcNI98TXx5RrFEgCC52BjGFyfd/jw2v9GtsFC46Z7RLiRhQM0A0+9qjx
         2K7zuWqDmZ1ls4h3vs20+mrb1uNOPeLO1kBVhHGel/Xl5ge1mjuFZhkrmAyYQ8zT1Hrz
         gonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202159; x=1755806959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=Vbvano4murUHVxQrayjyCG9OZHCMoar+wIcl3PBcfPSS7YISFvDgP7Ca7Py/u1z43U
         yl9OxIajGtmIC/PyxE5zYFceJX1YYPFcqbE7szQQR3Fqute6oAy6OTlP9CKDyhbC2Lo6
         1y5u1MjjIw6tKL2KZBvQ61yBJGk2sY2z4BEmdm+Z9YMMi9C7MfMPil3R4x5Af2l7THyW
         rIwpxwnNc7vKGqMJG8Zyux7lKueULiVeS9KL+LMOQtgGTGn84JtciPdd1H3H2mjigs9v
         BeBCZt7uztkoZplQer2PUagA1AQXXV6x+xM3lSwwf3IzlY7JaAa2zhgRycS8kIuE22ih
         Ttuw==
X-Forwarded-Encrypted: i=1; AJvYcCUqy09D+aQSCoHNVVyFl7LG26V/NKgnbS1RGkW8VR1MjOXz2Zk+Ve12OKnLd2jDWvPfKpK8M68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIH0mCv0SeEJGwQtn+EdiRkGMuG/3pN4D9Gv+XCgJLb8FkqsKp
	dCgCgVJWtq9UP0Mfn2vHM4fCU1RhW6wLVqyXR3ZjGIhqRmtXQg4wFzQepSY+LYRQvgF4v5/2kDy
	+zevAPA==
X-Google-Smtp-Source: AGHT+IH+nzG+2OcnZiv+3/UMTbEq2fBzLGSyOMqRhyX99l+CDhgD+Ism6ZOY2XsIJISoEwSwcdBmJbzd56M=
X-Received: from pjj16.prod.google.com ([2002:a17:90b:5550:b0:320:e3e2:6877])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d82:b0:321:a1fc:a425
 with SMTP id 98e67ed59e1d1-32327a8b7c5mr6718040a91.26.1755202159430; Thu, 14
 Aug 2025 13:09:19 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:35 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-4-kuniyu@google.com>
Subject: [PATCH v4 net-next 03/10] tcp: Simplify error path in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

When an error occurs in inet_csk_accept(), what we should do is
only call release_sock() and set the errno to arg->err.

But the path jumps to another label, which introduces unnecessary
initialisation and tests for newsk.

Let's simplify the error path and remove the redundant NULL
checks for newsk.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fe..724bd9ed6cd4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -706,9 +706,9 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
 
-out:
 	release_sock(sk);
-	if (newsk && mem_cgroup_sockets_enabled) {
+
+	if (mem_cgroup_sockets_enabled) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
 		int amt = 0;
 
@@ -732,18 +732,17 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 		release_sock(newsk);
 	}
+
 	if (req)
 		reqsk_put(req);
 
-	if (newsk)
-		inet_init_csk_locks(newsk);
-
+	inet_init_csk_locks(newsk);
 	return newsk;
+
 out_err:
-	newsk = NULL;
-	req = NULL;
+	release_sock(sk);
 	arg->err = error;
-	goto out;
+	return NULL;
 }
 EXPORT_SYMBOL(inet_csk_accept);
 
-- 
2.51.0.rc1.163.g2494970778-goog


