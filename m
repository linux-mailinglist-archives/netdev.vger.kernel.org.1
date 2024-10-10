Return-Path: <netdev+bounces-134364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0806998EBC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829EA2800AF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950D11CB30D;
	Thu, 10 Oct 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIlIFBN0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1E19ABC6
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582507; cv=none; b=fQDqdOZcwd6FNeRgd5tV0VmmLpVtM4hL67S63fgEGdMGFaotVcM/6bKohRBQ1Sf4zRD6twCB+ujcd6YnLaAJO1/w5FE8ba7+m5w6q7bnj4y3b632flI54pANa017VfovZQUppu0oiXOh/dI9wvlkrLZGEpW/FxrlugolpdmwyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582507; c=relaxed/simple;
	bh=sKfvKok3fq3eyG/tK+2hXfkWNQA6GdeD6b6mflzlR3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G0R9y+8paXoSr8P5zXC7tZjdvKf7Egbvr4d1G15OiJE0fanAPIaKrQn5FGQ/Q59qgUddBKVbweXkpkk9lWHEcUgC1mtra2fpooWLH+VdyAHr6199CwiTHnlnsLr39P1Y1skR/Ssc2MuPNYS9LrQJSf4jC65s6nCcE2JvSgaPJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIlIFBN0; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b117cdb27bso105783485a.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728582505; x=1729187305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=toLrgx1ltD35Rto733JypjJAuYnc+WvmBoor6BwKd1w=;
        b=nIlIFBN0RegfILQyIoBJXjYGAjbcULXxOhRyAiV/7zf7YGcUwZwau8awVPrH3ZYGmh
         CcCW3LquNw09x15VulJNeXMFAVv1WNorfSsTbp+pPHgQqhAzYjRbrUqYpdWIWIKLo7AD
         sZVMA2KjqmPnP8bsd5rtiGJP3uryzqvv5dEVfY8XYij1uYt8vsaudKm/UF1cvpNCA+07
         usSaA2WxqXohgCmuIhxOBsSm44CC1eCJMdnI+hW5L+Z4pXyVoBQv1gKJFz+l5Kby3RKI
         PFG/MDVI1phPE1NewZW/lHNcriqXJ1YbSlz3qrN8XmZZvapWSF+j577MIV7czz1THV3L
         k7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582505; x=1729187305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toLrgx1ltD35Rto733JypjJAuYnc+WvmBoor6BwKd1w=;
        b=Tt7vkxe9GMc9mmLGAtNnUcoJJNBr8aE09xA9qg/JntjiSOzZhIlzhqER+iwW0xdnwN
         CjU/QWadShK1AfdBW8vwRrDhr+Q1em3CE2gWxYonacfHy+B6aJ3CuyvKtLQ1rGOerM4z
         dxKq1HmCQUXKKzMCmv4HWNmn88nozkmTbmfq3dyVwjNCtss2TOI4kmZXOb4giE4Scz03
         TriVTm7zPwRrpy5kL7p7elEPdGdr1mmExaSr6n04Sq1CTPCLD8QaT40nDqE/R5VaGZ5K
         AZ6Z6dXqX5qiBY9qugWboFHYCvY//vREeH8H7viBDNNr72/aBIZ6U7V05bVsAYoAy+Ya
         rJLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+GBxRV/V/nK3jjXgIte4l2Q+5HeYNYN0GveyYVUPnruuwrg2s64DjLLq6oZQntWh0c/FB99o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKV2yvzntWhrPjh+yeSN2bnMBFg7Y7xl1XRmv+7QzT5YrZPZC
	xbia/LIM16XzccgSt8Lw3RRtDIqoT3f1Qto3C5gw3xsaBY3VDI8nj1oKaHz1jUcqqhmQw35A08o
	HL7ii1moc4w==
X-Google-Smtp-Source: AGHT+IH62eArbiEmYhE6g3pKu9rRM3SROHYyzoXcn8OCPe3+NNi33Y3J8FjiF8vYfWho59d5iBGzDei+OgJa9Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:620a:137a:b0:7b1:11a1:ab6c with SMTP
 id af79cd13be357-7b111a1b804mr226285a.5.1728582504963; Thu, 10 Oct 2024
 10:48:24 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:48:15 +0000
In-Reply-To: <20241010174817.1543642-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010174817.1543642-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/5] net: add skb_set_owner_edemux() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Brian Vazquez <brianvv@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
index 703ec6aef927337f7ca6798ff3c3970529af53f9..e5bb64ad92c769f3edb8c2dc72cafb336837cabb 100644
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
index 083d438d8b6faff60e2e3cf1f982eb306a923cf7..f8c0d4eda888cf190b87fb42e94eef4fb950bf1f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2592,14 +2592,11 @@ void __sock_wfree(struct sk_buff *skb)
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
index 1251510f0e58da6b6403d2097b498f3e4cb6d255..4cf64ed13609fdcb72b3858ca9e20a1e65bd3d94 100644
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
2.47.0.rc1.288.g06298d1525-goog


