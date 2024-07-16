Return-Path: <netdev+bounces-111639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E536931E95
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF2D1F223FF
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD163AE;
	Tue, 16 Jul 2024 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxGvqTuQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B39C322B
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094847; cv=none; b=aaDfVE5OGMCbf7NvadnZKDDNs8AdfT/SFGrU39aGMM4Qcrj/LsmjZ4EHQy3WKiuoc/EwdEkBHEPgx+IJZBsTWK93BF+ecqhMZO7A6BaZz0DYAt0j0xbiKIx2LqFJmx3In4bbVisijDXV8Cu4h3YCQdzki5i9sf3QtYFkpKbaAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094847; c=relaxed/simple;
	bh=rm7/4TMvJM9CsjR2LCBye9H2VHF/rr9uBtUeHt0WqMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Er4L2wHCo3P0vWPhAMtbW+OwIaqIHPk1Taq88ijZgOjBQULdt4gD9X5sqfpeGOHtjQbKIfFdHJkdEx6Kn74mv5PWR351bsRSVUDdXUNl7asmWVYXOJns6QmSr85VaOjUd0JsBc7uUW/6FgOpHh69eOnxF2e6SfySq0kLLStvrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxGvqTuQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65fdbfb8fe9so47449137b3.1
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721094845; x=1721699645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbW+1a3Lpqm3iHtH6XEfkAnexD0Pxnb0QkbIQ/mKzlc=;
        b=IxGvqTuQimPecaeAKC1/j9sXJ1z4u8JBIQY2oGPgQD8BKxkZsmyBN84BcwAwg1eBom
         7Kuuy4w579KAatkWNyw6g71tO0KHxEXa7RkS2KoR67jUNRdPZsbzQNx/+4e2dxffc+iX
         gTXcrNM3m4EC5IUOGbLuB7HYQxp9fuGqJNMBuu33QeI1eLweAPsZ2vmIlGFppd7eDwA5
         HGM/uWSHcOlY2rxpyAA0p2QJG1S23EkOBsj2mh7ZYBlBABLul9GOdaBllP6vmohQAH4u
         ZdSVQ6IdfxpK3jzHGSFVOpGkWZFmJ5TCaWxJYc6PQH5jtgRcDMxgLqVsNzBLsI7HF3WH
         dgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721094845; x=1721699645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbW+1a3Lpqm3iHtH6XEfkAnexD0Pxnb0QkbIQ/mKzlc=;
        b=icfphwl1O9WhDi42eDXlodJTCcy9fz4CH7f1Uesc0sC7aVd2hRZl8Qd30Sc1g9GMCC
         6jt8z3GAwbgHAI3bnKvgk8k9rT32UjfqkOAcZHIfhO3Bba/BZsBET5DU9rMBb4veCbtx
         d2+g4HPJO3ZzE8MhnuQAOpxCI5ajsj7j1VMHM+XcH7gVOQPtbTxgzNPwIPigN76+zk8Q
         s0GftmFtNCi4xi+wdGvwtBnYSCAe+D7U3Ico7LISgC0n1MjR3y/iMx5470TOkjzLIFBY
         IXo351hxAGB7JTHdWghVqGgGvgOnU0PxIHd/Q0/MHp7pkx7NN18O3pmzu9QLjqfvmo0D
         HxPg==
X-Forwarded-Encrypted: i=1; AJvYcCW3VSgTh7MGX34OuKt41GMH9HucMO6npcjNI1Vjoh8C3EdAyQ7QIBWGsaZx6im7rvTZ0jXPVOKZkmfhnceMifIjFl+3JlYx
X-Gm-Message-State: AOJu0YyxIiTPEmnk/Jp4YfadAHvrJEMhs4yPTEOh7sRpVywgRlY00W+k
	lOWl6iPDkbhgUWKttvKIII0aHwsSwPAbbC3U4Eufd8r5/Vmx8rVPcIwFFplTjjAzElJNVM2UkDM
	r2Ka7iO7rcg==
X-Google-Smtp-Source: AGHT+IHDIOL1rhb+Vtx2I26UVtAqiCBLbwEkQTzaHO7G8bmvN0bkX8YmHNP6ntgeys+fjZgkKPHc0ZKuQ9T3aQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:2b02:b0:648:afcb:a7d0 with SMTP
 id 00721157ae682-66381ac56acmr142387b3.8.1721094845121; Mon, 15 Jul 2024
 18:54:05 -0700 (PDT)
Date: Tue, 16 Jul 2024 01:53:57 +0000
In-Reply-To: <20240716015401.2365503-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240716015401.2365503-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716015401.2365503-2-edumazet@google.com>
Subject: [PATCH stable-5.4 1/4] tcp: refactor tcp_retransmit_timer()
From: Eric Dumazet <edumazet@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Jon Maxwell <jmaxwell37@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"

commit 0d580fbd2db084a5c96ee9c00492236a279d5e0f upstream.

It appears linux-4.14 stable needs a backport of commit
88f8598d0a30 ("tcp: exit if nothing to retransmit on RTO timeout")

Since tcp_rtx_queue_empty() is not in pre 4.15 kernels,
let's refactor tcp_retransmit_timer() to only use tcp_rtx_queue_head()

I will provide to stable teams the squashed patches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/ipv4/tcp_timer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index e20fced3c9cf691c83b494e11e551161e17d6619..e0bd7999d6d51602fcd868a72d00618234bd0c27 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -452,6 +452,7 @@ void tcp_retransmit_timer(struct sock *sk)
 	struct net *net = sock_net(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct request_sock *req;
+	struct sk_buff *skb;
 
 	req = rcu_dereference_protected(tp->fastopen_rsk,
 					lockdep_sock_is_held(sk));
@@ -464,7 +465,12 @@ void tcp_retransmit_timer(struct sock *sk)
 		 */
 		return;
 	}
-	if (!tp->packets_out || WARN_ON_ONCE(tcp_rtx_queue_empty(sk)))
+
+	if (!tp->packets_out)
+		return;
+
+	skb = tcp_rtx_queue_head(sk);
+	if (WARN_ON_ONCE(!skb))
 		return;
 
 	if (!tp->snd_wnd && !sock_flag(sk, SOCK_DEAD) &&
@@ -496,7 +502,7 @@ void tcp_retransmit_timer(struct sock *sk)
 			goto out;
 		}
 		tcp_enter_loss(sk);
-		tcp_retransmit_skb(sk, tcp_rtx_queue_head(sk), 1);
+		tcp_retransmit_skb(sk, skb, 1);
 		__sk_dst_reset(sk);
 		goto out_reset_timer;
 	}
-- 
2.45.2.993.g49e7a77208-goog


