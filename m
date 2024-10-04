Return-Path: <netdev+bounces-132212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D298A990FA1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A12B1F22CBF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C761DACAD;
	Fri,  4 Oct 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+HHRkIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A251D89E3
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069414; cv=none; b=FaDkAtwgYJWe6i9d69/uthGGVTzGtfxlWMT09f8/PABqRURw7jvppxgfmtzVijg174u8w2wKGvLgzMLXpyFxjgZvZH1aalErJwDxZ2yyq5t2quupQs2smvdtN0Vw80InH+eMeqLtq1OvEzz3WjVyB6fuU4i3TFZSl2B9P5F+Vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069414; c=relaxed/simple;
	bh=YX2xiHUcOWw6p941/qNR30xo2Wcqd7/MFQUvcn8jSd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HqjUFl6bqkrS/tqFaCf8Gje35UwacQloc2NRjCbLAPWH3UF9CaqfYt2ywD64+tG5vg7pTTljcHkgI6LIqQ/iS4rASq60rXnDu0wX5uEnZq/BD+iUbjt1CsAwr93sHZ1NeAK/TAdp4Zcerbj2yqPDLmauvDnkTEWhZDjcYotJaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+HHRkIG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e26ba37314so38987837b3.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728069412; x=1728674212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OL+8Wei0Hl/fpXNg0qcOSx2N31q/ONluFFFu9ekOhMI=;
        b=g+HHRkIGcPBDSrPf3CY8LpBBsMcsArLuNBYMHezFfMzYFwXgdXCL9VTNyKfFKQZ66L
         oTvZNsNPZqxnkQvAmMTN9jU/3qnjupaMIdydlhSECMdShYvdsMCnL2U9HrvytlY+GXma
         KWuEm32ChbVTtVTjm3Qkq6prmARNz2dtnixFq/r2GHlbye+I0xze91U3zjlemKAV8JF6
         0T4v4LNCp9oPkXnkVLg4qGpR3m7Dh7E7+/VqjgnkBx1C709tyAsJCg55rgBCa9x5k3kO
         DPAyX1gfIPd9eMvovs7D+asz7l1Nm35kasYGwPFO1m+jr0ezoUPI7P+KWJdGhg8rph+B
         6Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069412; x=1728674212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OL+8Wei0Hl/fpXNg0qcOSx2N31q/ONluFFFu9ekOhMI=;
        b=V/1cMYKEudWxqDjs1ig+/5tPeKCVPogUTXm1AqlfSsYLlqXdrMMQccuCkKLscFXSEv
         8a5BumtkyyBkvFpWWbwfaehP5gDgWYro7OXylZoADfGOfAn3S/VBoil7d9v1dWfu5Iay
         alh39ESm+Dgl6nQ3RpfyzN7glcivSOYgS/fLOLhowQVOJjLGIP9N/nslNnqy5/kg/VkE
         jxFImx//GwRmHpt/ZHz2FvDPefQaky3xk/pdTYRg2jUVUx9/jFj3MeinkVRlKT5NkRiO
         EoqCtkep1VWZBVyVc5dvblAKO1FrsLlqFBHuCkhoVWITKLNIU8cJTjyPQIyPb/p8tAbt
         QFpQ==
X-Gm-Message-State: AOJu0Yzn0b3PVrn4Tzzxd9Bc/JQ+gLgutAQKDS7Ui6kCGwkZhD8LKWGR
	4QgrhFXyqyMyAFgFfraRjAk5SnHcdDyj0pb4dUsrFWcOo5bYVcQCWGCvHlJ/oNfHB3EFyrwIio5
	5dkdwbz0Hzg==
X-Google-Smtp-Source: AGHT+IEdSoCUooVsjdRLkyXOS8ewX7pfdU2/08LEQtlAyHaD4+IC0cbXJeD4y8BBPiXqbSZyN0YnATplzITVRw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:b293:0:b0:e16:67c4:5cd4 with SMTP id
 3f1490d57ef6-e28936d0681mr2409276.4.1728069412044; Fri, 04 Oct 2024 12:16:52
 -0700 (PDT)
Date: Fri,  4 Oct 2024 19:16:42 +0000
In-Reply-To: <20241004191644.1687638-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004191644.1687638-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004191644.1687638-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] net: add skb_set_owner_edemux() helper
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
index c868b8b57e3489cd81efafa3856da09397059080..5facbf33316ab0a424b320850198c7cd6bc1a642 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1752,6 +1752,15 @@ void sock_efree(struct sk_buff *skb);
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
index 039be95c40cf6fa429d33e0f42ee606188045992..0582306bb576291c43c9eb0700130b36ba44cc25 100644
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
index 4fd746bd4d54f621601b20c3821e71370a4a615a..60c16fa4c9007006ff8ba49b695d227652a2eafb 100644
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


