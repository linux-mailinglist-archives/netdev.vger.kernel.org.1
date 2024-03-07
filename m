Return-Path: <netdev+bounces-78540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917F8759D9
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 23:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57632816CA
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C708313B7A4;
	Thu,  7 Mar 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VF1Ck7c8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8B13B787
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848820; cv=none; b=fKgzZYMomCqtfhPMQA9Cl0lqTbcY3nC1NM7r3C3kjF9qlSvf8lPnKxAQ+HlMmiCmutrvjBg428AUgAF7KSL97U3cAUCgKuXoS+86eQNQVzdI48b71Gx3nW6YogiI/V+OYCoKU4WpKEKqr41rHG/U/GDBy9g1Ltdc6TW2J8lHxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848820; c=relaxed/simple;
	bh=f9fMzSivZ97O3PcuJLnjYviveOJeY1wVqucvUp7Nk3k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=crRFhCBXbK0vdWHu2mnWTqIgBvkLCGke8l8eyYbu8dLLmS/FlE2j1Bu2MgNIe0EGNN97hrI3rImvMjvqfdUCER7NJni9Kc9p/Ay7Xs84YvkD4m1k+t+/kUbfwLwxKkwlTtan7xZJuNMX+rfCbXlqlBv/gyWcbtDxUJ4vSHclEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VF1Ck7c8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fb719f48so14732447b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 14:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709848818; x=1710453618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P3Ml9Tln0cORlDTuYm4a4u43eZobvrdgLIcj4mCzi0E=;
        b=VF1Ck7c8Zu5oyLZpFn4SkTfjpOsShrylc0GBcEQwbCx1fCiKTzTc93yWoqfYoMZENl
         3vHQJ06HRzeTq5LLczkjs+TMDyG2fHUh/48+lOcCNo0Mo3LmUSNBDpiRhIW6PsnpR1yn
         x84vsMD6lXKB9+0PoYZPcaIQBOFskL2kZJ3By6h8+KPNQMftsOtw3ewuevn8f1ibjRsy
         vaTKu/hIGFUjln+JrLYug4tynlf9E6z2DwmBpBMoaPFk3Mjcw/lWgNEetaC70erqVJm5
         xgbsBO6JvDdH6u4FNzq/C76J5Jtxo6F9az9mmua5eMippAI3qPmPDc3tEb/4g3S/l6MC
         XwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709848818; x=1710453618;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3Ml9Tln0cORlDTuYm4a4u43eZobvrdgLIcj4mCzi0E=;
        b=fpoGLq9UCsIgMMYu5BBWn+tS7+/fI4Re1o8xCXC1NMXuZ5Hjm3QcKOZE9CXZ96m9Vm
         DcIBBMPivjzJi0JWb2QRWGmL0OF5F5KcfKuq3HTESHn1tu+51UAR3xkOfNh6ALdGQjYO
         M+6RT1RigpzHYt/B0BQapg9QAWigVpU3mwcWrqbGBOH98GYkXOjNujZp6A7Amf+Zw97t
         9h6niNLsPYvpcMTqm5qrX7c9npKlO3V5umSxdVoGHJKN/8oyKWqcAwt/6HAGhovNuUGr
         yOcEDL08UbzR6hFLYiwMEViB7wMFnGh9aSRP1mW/uKvgal+aBJFLM8hkHY3M4POH6Jlw
         MwlA==
X-Gm-Message-State: AOJu0YzRcZRB5vTcQ7oWFsJG8Vz4UHay10WHXuqdOc3/+jM5ViStWyDd
	yAzSXgGauyjlFf3BccYpq+UDhMj/uKm0IXEMdSrAb+qqlvJqt60/cXC6J+fGyxG93tLCpo7UNze
	T3tD6cY/6Hg==
X-Google-Smtp-Source: AGHT+IGxb7gb+AL2ziserGPxW+IcZtRHXzv2b/jOdXNHZ3kENoPX822kCcVwhL/6skJcj6Ysc7H9ry4UjluyLA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:f0b:b0:dcd:2f2d:7a0f with SMTP
 id et11-20020a0569020f0b00b00dcd2f2d7a0fmr779910ybb.9.1709848818260; Thu, 07
 Mar 2024 14:00:18 -0800 (PST)
Date: Thu,  7 Mar 2024 22:00:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307220016.3147666-1-edumazet@google.com>
Subject: [PATCH net-next] udp: no longer touch sk->sk_refcnt in early demux
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Martin KaFai Lau <kafai@fb.com>, Joe Stringer <joe@wand.net.nz>, 
	Alexei Starovoitov <ast@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

After commits ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")
and 7ae215d23c12 ("bpf: Don't refcount LISTEN sockets in sk_assign()")
UDP early demux no longer need to grab a refcount on the UDP socket.

This save two atomic operations per incoming packet for connected
sockets.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Joe Stringer <joe@wand.net.nz>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 5 +++--
 net/ipv6/udp.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a8acea17b4e5344d022ae8f8eb674d1a36f8035a..e43ad1d846bdc2ddf5767606b78bbd055f692aa8 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2570,11 +2570,12 @@ int udp_v4_early_demux(struct sk_buff *skb)
 					     uh->source, iph->saddr, dif, sdif);
 	}
 
-	if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
+	if (!sk)
 		return 0;
 
 	skb->sk = sk;
-	skb->destructor = sock_efree;
+	DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
+	skb->destructor = sock_pfree;
 	dst = rcu_dereference(sk->sk_rx_dst);
 
 	if (dst)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3f2249b4cd5f6a594dd9768e29f20f0d9a57faed..fad6667fad6644db8c679ae9b723ccda15edaede 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1101,11 +1101,12 @@ void udp_v6_early_demux(struct sk_buff *skb)
 	else
 		return;
 
-	if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
+	if (!sk)
 		return;
 
 	skb->sk = sk;
-	skb->destructor = sock_efree;
+	DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
+	skb->destructor = sock_pfree;
 	dst = rcu_dereference(sk->sk_rx_dst);
 
 	if (dst)
-- 
2.44.0.278.ge034bb2e1d-goog


