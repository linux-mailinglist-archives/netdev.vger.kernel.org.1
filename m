Return-Path: <netdev+bounces-98543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3B8D1BAF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72662853D6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6C16DEB0;
	Tue, 28 May 2024 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4/g/Gw4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C016D9DC
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900787; cv=none; b=QjbYbKbwwxmb1mkIvfN0gQOFTO0rNnf0Xa1rUoQgw9b/mtDAApuZw8sjhz/e1Sf1pUD0IQEgmli6KwXta3tILDKvu3Nx0jkT8B1bZi9dLr9jhNIKy5CrEzMebrQq7qEfjI6IJRZUSgkbuQi/e9Nx0zEN9ryeRWtelfpj7ZMQ/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900787; c=relaxed/simple;
	bh=trtAk8lizIse2l/32VYpD13iiRP2HGWcygfLxzAMAM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=diu+pZhgRSQhVrQLOagqlrFLOj+uL7XNucDNWfnnsW5YeVuPCooZVAOLt/U8OhKk6VOvK1NjpLU6PYcUi/h9ma1o5dLky54w6q0L4LJbL7VBwH1JNFriCX5Pg8/sutqFyNIQt86FyrsNFg4KW35HG28eqUjyqnwYgsJtC92sVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4/g/Gw4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a0827391aso13666517b3.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716900785; x=1717505585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYbSWIKPeossOaeDLXogCd/TcTOGKtxRUHT/8R+xsns=;
        b=C4/g/Gw4kH3mMdDTcpgHP1CAxjT7A8m6A+zuQNLtODjRhzTuZlh5u/7IVgPRuFTRry
         5xUNsDl2uW7hX2kR9k/3BMBRyeXUiux2FoSf81YBUKLEiiPL6tQrdBSnxMfkiVOGDJ8k
         gKyadlythSqFy1F9xa/Q/QPlwJ199X/uw+3T9wxM2PmwQiYVgWzTi1QxaFqrcPeAPCpa
         mjsWaIyv6LRz30DB/bwK1cf1QgSA9oMfqCmMMcc15m1qkS7ISbth0u7ATnqM8jgaCer+
         zTSFvExFLfBSEirWvYAujFyHpqtPGNCZTqnBOrmmcYq/lc5aUHcD7PQV5R6Wvtr5xVFB
         XSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716900785; x=1717505585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYbSWIKPeossOaeDLXogCd/TcTOGKtxRUHT/8R+xsns=;
        b=IGD+azPvculNPQVWYNX8Jrb1FhcjMtYyL2H44X22qsRiC03Lu/do4SW0NF4WqdFVrq
         2EFPIGgMZ79ysBsVb5+sDniqZakbC+jIYdv2x8XkJSZtN7sgl7KyhdwkzryCywW8ccM7
         3si1IGbo59W2Q4gk+UouNkQNx3kGipJmIhmwrZSeqmdFgEhNtxjEH0GojZ/3XHC0x2Gl
         9rp90GnIzzuI6N5EA/9/SVbhUdO7QF9Ech6PKZosuG9R5pqca7WvFma1nrgj522QrVtW
         YteKgL+uf89bfSV72J6+NYPuuzyjpGf9xnR5vOK+hQMXC32aRAhwc5kt1Q3cXkKiW/Rj
         v+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXaNiLkdW/uWx9g5o8AhTZZ4Hp8Xn9gDhP++/Opq+aQUoITY046rEIxJn+uOh+V/4/GVqBQiA0g/JFlCotLeauXzWf6oDpV
X-Gm-Message-State: AOJu0Yw/NDgWEb4v8wRofeDlL/w2soWMQnyRVpCeb9HEHIvyOQ7TQqB3
	4+t0C9T2RyE+m7uiY544urMFp9JAXvV1rZrIfGyf1LrPQOLoZhcG3hRPKjxxMg4ZXBBboyZpGcH
	9d0A8lEUFIg==
X-Google-Smtp-Source: AGHT+IEiAG5DGE+HHCNs6311h6T81J2Y85qtiyzM4Wa0h6BmUIc5i2s6iAxOsYhaX3qp7Hc089sg6ijVHV5Jgg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:7402:b0:61b:1dbf:e3f with SMTP
 id 00721157ae682-62a08dc705bmr33818617b3.4.1716900785707; Tue, 28 May 2024
 05:53:05 -0700 (PDT)
Date: Tue, 28 May 2024 12:52:53 +0000
In-Reply-To: <20240528125253.1966136-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528125253.1966136-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528125253.1966136-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] tcp: fix races in tcp_v[46]_err()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, David Laight <David.Laight@aculab.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These functions have races when they:

1) Write sk->sk_err
2) call sk_error_report(sk)
3) call tcp_done(sk)

As described in prior patches in this series:

An smp_wmb() is missing.
We should call tcp_done() before sk_error_report(sk)
to have consistent tcp_poll() results on SMP hosts.

Use tcp_done_with_error() where we centralized the
correct sequence.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c | 11 +++--------
 net/ipv6/tcp_ipv6.c | 10 +++-------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 30ef0c8f5e92d301c31ea1a05f662c1fc4cf37af..158fad0cbe43d2029461f6cef3ee698c2acce528 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -611,15 +611,10 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 
 		ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
 
-		if (!sock_owned_by_user(sk)) {
-			WRITE_ONCE(sk->sk_err, err);
-
-			sk_error_report(sk);
-
-			tcp_done(sk);
-		} else {
+		if (!sock_owned_by_user(sk))
+			tcp_done_with_error(sk, err);
+		else
 			WRITE_ONCE(sk->sk_err_soft, err);
-		}
 		goto out;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4c3605485b68e7c333a0144df3d685b3db9ff45d..10c804b3638a99a9ae4cf3d81bd4481ac06703f9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -490,14 +490,10 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 		ipv6_icmp_error(sk, skb, err, th->dest, ntohl(info), (u8 *)th);
 
-		if (!sock_owned_by_user(sk)) {
-			WRITE_ONCE(sk->sk_err, err);
-			sk_error_report(sk);		/* Wake people up to see the error (see connect in sock.c) */
-
-			tcp_done(sk);
-		} else {
+		if (!sock_owned_by_user(sk))
+			tcp_done_with_error(sk, err);
+		else
 			WRITE_ONCE(sk->sk_err_soft, err);
-		}
 		goto out;
 	case TCP_LISTEN:
 		break;
-- 
2.45.1.288.g0e0cd299f1-goog


