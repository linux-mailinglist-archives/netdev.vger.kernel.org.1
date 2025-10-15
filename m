Return-Path: <netdev+bounces-229461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8ABDC995
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BA4420095
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D732FB0BA;
	Wed, 15 Oct 2025 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4t8vmcg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABB4438B
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506038; cv=none; b=oVzg9Cpe4Ob0+sjs7JhG+Ya+DZeV3j7edHRMcT3tzOpz+7JjbkFdLFOshpXC84KmMdOy8+ynl9ElNNiBQ/JrhZEft32KL6VOEVyoxWjTsrdrvmyaJhXROeAeBnvIXmpaIvGWEawxS7QVP3t+6xrVMuZrjR+wzikhKUnXPF5MKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506038; c=relaxed/simple;
	bh=2W3gN6TRewnOg/fzXKZYVhkMESd+wxhtXahoUvYsdqk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n/n8HfBIja1PbZSucXap8lw5CMVd3YTXGnoZjtOi9OK1jnC+ooaiiClAr7r5ASm8I9ZTJU/zzNWeyTJcOoXc4ej3lFktlqLcKxWDs+SPHloVn39GJ/tY+UhKFwK6bn2hbg0mDOBZBXjXlERFbXhsnBIlevMZzfTHdJZs1aBW6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4t8vmcg; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-6365645cadeso11694347d50.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760506036; x=1761110836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rw+0kverG215wGe8RQhNHv5DUKqtftfJ5u2Nyg9VGSs=;
        b=d4t8vmcglf+wcCADjN1RjQcMS8TSBRKMyhdMyKqISuzpWaAcLeJ5bxzComP5WFA5dz
         aQLLnY1r+CzTXgUd+ZXlHom7cgg1VRV4Vt8hfm5obr5tr2xt5IcHJvVbT20/2w9eOShJ
         MPuxx5VArBajdOb/0y7AIEfLBLcHhjFFrZn1nQrewuKUOJpl51DgQHoINXFOny/BAc5g
         epVyPsdLXMWUBwVZ7HyRFaWWINbucQVxxODeY4ZU12hHCxp9rHL7DMQqmRkcxoy5DlUa
         kGP1sULz1UqUrGOKoYvNO7ETSyOB6n3/dnWXxgQdnqkEClV5qkCVrGrZ+9wszhE68lo6
         KNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506036; x=1761110836;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rw+0kverG215wGe8RQhNHv5DUKqtftfJ5u2Nyg9VGSs=;
        b=toVTvvk8ZYkPXefejrKkIbH3qm/RwjkrE/0xMCiRwU2UfYTLTJ78G0dWoyu5ZfTXBH
         +i3yQf5uP2U1r7tKoIiC2An7+NUyW8sg6R7f5gCwgYKWQxHI5iVWbiOYz2v8sEqHOGQZ
         ROA75X8uuum5gnhKqSiMiqM8E3yonv0YuGSDCQ07jMOemze3RDxLinQDXLnYLI3KeZns
         5l3Ys0qi++zbQT6zk5xjX0ynZxBjzUorllnY4ROS8Uvli73gQmTY6cKPbvRo4mcJN6Kx
         oVGL4CpaNlZwH4Fbhs3AaLL9qNfcrH+N3RaN3DXvwMIGzRke5vxyoHcVgulHh/nfU9bI
         Xx4A==
X-Forwarded-Encrypted: i=1; AJvYcCWRmF/Az5Pb2wTyHE6Tc1jP5c6LLKBoLuZPfCxmm1hkVYN76BHRMvspuLgCyQNxNv8zEdEZ/S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlfu++YSwWpzdzRokuDLqn4t/rNF7DTfZQurhh4PtoXzGysS68
	p7tzjmUSzwkYYSw/UqYAUhue1d0JThE6rO7IxB3qw/Xndl4Ch7LK+JZxibelYfolI7FXs0XsiJq
	aIZtJsAFWGLwyNA==
X-Google-Smtp-Source: AGHT+IFadogCQ8vsK6QxutuWIEOoCmQsK+BNNfOwevfFULjFbL+kB3D9864RSC2TvZ8sMAkQDTjrH/MeWrwmYg==
X-Received: from ywbju2.prod.google.com ([2002:a05:690c:7442:b0:780:e432:6fe1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:441:b0:63b:a9d6:78c with SMTP id 956f58d0204a3-63ccb932fc3mr19307310d50.45.1760506036180;
 Tue, 14 Oct 2025 22:27:16 -0700 (PDT)
Date: Wed, 15 Oct 2025 05:27:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251015052715.4140493-1-edumazet@google.com>
Subject: [PATCH v3 net] udp: do not use skb_release_head_state() before skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Michal Kubecek <mkubecek@suse.cz>, Sabrina Dubroca <sd@queasysnail.net>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

Michal reported and bisected an issue after recent adoption
of skb_attempt_defer_free() in UDP.

The issue here is that skb_release_head_state() is called twice per skb,
one time from skb_consume_udp(), then a second time from skb_defer_free_flush()
and napi_consume_skb().

As Sabrina suggested, remove skb_release_head_state() call from
skb_consume_udp().

Add a DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb)) in skb_attempt_defer_free()

Many thanks to Michal, Sabrina, Paolo and Florian for their help.

Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
Reported-and-bisected-by: Michal Kubecek <mkubecek@suse.cz>
Closes: https://lore.kernel.org/netdev/gpjh4lrotyephiqpuldtxxizrsg6job7cvhiqrw72saz2ubs3h@g6fgbvexgl3r/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Michal Kubecek <mkubecek@suse.cz>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Florian Westphal <fw@strlen.de>
---
v3: Florian suggested skb_attempt_defer_free() as a better place for the DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb)),
    since it already had the skb_dst(skb) and skb->destructor checks.
v2: Adopted Sabrina suggestion.
    https://lore.kernel.org/netdev/20251014132917.2841932-1-edumazet@google.com/T/#u
v1: https://lore.kernel.org/netdev/aO3_hBg5expKNv6v@krikkit/T/#m8a88669b801d85f57b73710cdb0c8ee63854af11

 net/core/skbuff.c | 1 +
 net/ipv4/udp.c    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..6be01454f262a2acbf3f5905498961d132442d2c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7200,6 +7200,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 
 	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
 	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+	DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
 
 	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + numa_node_id();
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f01b2dc31d9520b693f46400e545ff..30dfbf73729dad1e7b26c74a4791fe0a82682a6d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1851,8 +1851,6 @@ void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 		sk_peek_offset_bwd(sk, len);
 
 	if (!skb_shared(skb)) {
-		if (unlikely(udp_skb_has_head_state(skb)))
-			skb_release_head_state(skb);
 		skb_attempt_defer_free(skb);
 		return;
 	}
-- 
2.51.0.788.g6d19910ace-goog


