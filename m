Return-Path: <netdev+bounces-132544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C28E99212C
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26204B21097
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922A18BB89;
	Sun,  6 Oct 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vO3t9osn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3218A95D
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246754; cv=none; b=faS2zwyQ/RDxrNixMrDEfqfCd+c2ER9TvQLE/QkbqZZ1oVm7E5OfJmvMlvM5DefalQtIAgGxpvMykjn/lijwCYjJ/nCv6c2qwSYqFgmv7GxskPRmCt+pZsDNg93NL5JCr9eg9wohxpRe1olmKnK2H4R7KirXvVMFRpoiZnOOno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246754; c=relaxed/simple;
	bh=2D8rkK6G7fg6pTqt3zPivlNXZN/I4VKO0r4n8jFuur8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tu5Jo2bN3oVXckG+Gi1NtGfjTEtMAvU7NIr7BOOCx+iDDgzDlNtu+FhGfWoi41ACtjoq6PjVFquoqg4UfiAB5lN1vsNjGlmhM6Ts6xo8/QzA29FvIKXVRtI9YpX8tCRRHXl+iBXaWQKs9MS8PTZVc8a0VeCOayFR4VH9rfYZ0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vO3t9osn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20e22243dso5648377b3.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728246752; x=1728851552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzaMe9nGRzd2Bab5mcUyBD5Y+/aRG6rpLBHUK8GLFL8=;
        b=vO3t9osnsX6m/I42u0n4eS6LO8HDTWoZsWsk97W21/MdTFktVApdN6sknDvCF6fhda
         QEhUNvd7WQxc95qF8QP74PFgz9bsUVTLtDQ+2Bk3H8qnSg55O7j5k5R1arwd/s7iaVbo
         Tt6/6Pzjw4RihB/rj5nB5/tzTbkxOh/Tkl6znmEOKvd19EfypWtBeIR5l6c8l8Zycxru
         MpCQ4vZOM5xitng6ZsHesYwmCHw/QLm1K/RDhuqhiQiPgR8VWwBHWYwdi+GjDw6uV0/o
         irkAUq8/bHzm5bwItGTequrk5Tk5klICeWndBDWgsG1nYfI+JOqWJTr2luEy/KnYxuDX
         3mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246752; x=1728851552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzaMe9nGRzd2Bab5mcUyBD5Y+/aRG6rpLBHUK8GLFL8=;
        b=xFmCY0Ow66kDQ/mw7pCTqHXM0eAawuUpDHzGOLj9SnzKo9K106StZpxDnyEePKW8aK
         zx6+8romrBR/2COaD5Sb0vOm19HO8di2bqZjpkDsd97/VO3lWbR0LEz0m7kI29O/H85W
         KBhOSIMDsrx5zMOb1sWXJt5P/BsMn1TzEiprL6na6MPwqhi+zZK9XihD8lGlK8w5C1DA
         GKaGbJVozNOMKPC6Axymc5Egl2n/zhwi9V7sNkxaSlT0g+Pb4EXGQim7KGh+CwXMjwRc
         9pigtQbPNShISEe0IjRktWpPEJNmEWbpV/rN16FnOHNPDsx0LRonScAZiccxD0C2mfkh
         7umQ==
X-Gm-Message-State: AOJu0Yx6uZYWhmF/s2LvEWMzNYsnDFSGFW7QIsqWH7mR3uiMofNJuzaZ
	kaDdTrYRDcB1hbh2Q/SF1ToAxhcd7p8qEw3cKmM1XBW1F41Z3fLF85Tqk9/vmncI7y1da90QngN
	cn+Uj4xG8NA==
X-Google-Smtp-Source: AGHT+IEh5ELrxrSik9+rUjwIE5nWJ6l7Im2F87HzfWohFEPzc4kKunEE6oVAPdZqUL9vdcn0kJe+hFxROcXX8w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:848d:0:b0:e11:5e87:aa9 with SMTP id
 3f1490d57ef6-e2893939442mr6596276.8.1728246752252; Sun, 06 Oct 2024 13:32:32
 -0700 (PDT)
Date: Sun,  6 Oct 2024 20:32:22 +0000
In-Reply-To: <20241006203224.1404384-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241006203224.1404384-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241006203224.1404384-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/5] net: add skb_set_owner_edemux() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This can be used to attach a socket to an skb,
taking a reference on sk->sk_refcnt.

This helper might be a NOP if sk->sk_refcnt is zero.

Use it from tcp_make_synack().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h    | 9 +++++++++
 net/core/sock.c       | 9 +++------
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 562bb47bf3d8a58f31576a66811ffb25dfed1a8b..eaa42e20449c83465fc378f5e66b2c11929708fd 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1758,6 +1758,15 @@ void sock_efree(struct sk_buff *skb);
 #ifdef CONFIG_INET
 void sock_edemux(struct sk_buff *skb);
 void sock_pfree(struct sk_buff *skb);
+
+static inline void skb_set_owner_edemux(struct sk_buff *skb, struct sock *sk)
+{
+	skb_orphan(skb);
+	if (refcount_inc_not_zero(&sk->sk_refcnt)) {
+		skb->sk = sk;
+		skb->destructor = sock_edemux;
+	}
+}
 #else
 #define sock_edemux sock_efree
 #endif
diff --git a/net/core/sock.c b/net/core/sock.c
index 846f494a17cf9614bb96505eec743df17574c138..d540acc8b154052ca523853b67056ebb0097c68e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2594,14 +2594,11 @@ void __sock_wfree(struct sk_buff *skb)
 void skb_set_owner_w(struct sk_buff *skb, struct sock *sk)
 {
 	skb_orphan(skb);
-	skb->sk = sk;
 #ifdef CONFIG_INET
-	if (unlikely(!sk_fullsock(sk))) {
-		skb->destructor = sock_edemux;
-		sock_hold(sk);
-		return;
-	}
+	if (unlikely(!sk_fullsock(sk)))
+		return skb_set_owner_edemux(skb, sk);
 #endif
+	skb->sk = sk;
 	skb->destructor = sock_wfree;
 	skb_set_hash_from_sk(skb, sk);
 	/*
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 08772395690d13a0c3309a273543a51aa0dd3fdc..20d6adb919461849ebda30c30f018ae8c5d5861a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3731,7 +3731,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
-		skb_set_owner_w(skb, req_to_sk(req));
+		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
 		/* Under synflood, we do not attach skb to a socket,
-- 
2.47.0.rc0.187.ge670bccf7e-goog


