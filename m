Return-Path: <netdev+bounces-223650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B0B59D34
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C068164E73
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0368B29D279;
	Tue, 16 Sep 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYCF40pK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E34284B3C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039004; cv=none; b=MWaBgtNHDTv4rA3xxN3OeT1QCsI6Wci4NbmiacjF1BRBgRXy82X+QPoYu2F5SGaNI73r6Tv3+ONI2qIlKuZZh8SJdnxzwr7nJL5ZG78lDltZYzehak1wVwiZE4xC5YDGkcIaXdOaCHZk0Rmi4gdSUuC9Yws1yi6rc1jOqQvMIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039004; c=relaxed/simple;
	bh=PYvVgA2hzQ5qmSWTE5lfIM3EUHTuyZNS4Y9S9SX2MVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tcVQdm2ciYNLIjdaM27iinqh2R6IGbHzOaFds4nvQfqx/+BGjfF4C170wRiCwjqH+eSpixHW2BCNFFmCedCKobmVg99t3c9qW+JD1SZ8jh0mc2lFgYxR9iwsn75/Zkk7W4pI5TUs5Lma5DzSLaPf6g+xMpxc0qULLfGxkn8HXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cYCF40pK; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b7ad72bc9dso40325701cf.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758039000; x=1758643800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXocC8LdBAgZKSDUXnlVODmDdKv8bcG9hAMfu5EJ0LA=;
        b=cYCF40pK31gXOx/x1JGHIRlibXQR82hBsTXj8JCCyl5+l97gnsQqOpjnE1yPXxg+D6
         qwomdyM8UzBlgYY8UUYp3VJf3ipI/uBFWkaL7arn0TPpMMUdptnb/V9TEYgRvxGBO+hX
         shXKZGyTrIJHf3nx8EBqNJvBeEWc1+C0Kd9KILNSdskCxx8RGWVStL8/AT2n1wW18DmD
         hmEbSYHe/TiTR4hV+xWgB+l8HqClYwA7Fhr3Ggxg+3cZFZP08/H6IPNB++NeRKrsmDah
         m2LOVa9M8aYly/hOvGoyJ90m+eoLnHnmIn5aBr58E9tm4Nd9Q3sZY9SOaQH1u055HfBA
         gj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039000; x=1758643800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXocC8LdBAgZKSDUXnlVODmDdKv8bcG9hAMfu5EJ0LA=;
        b=tCafPo4crDWTS60qKGZg75fvLfrZ5QYUp22R1x1FEB6/bhg+4l7pLxsHg+DSduIFIq
         nxHFg2kDFFoCLbn1P9hIPFh1FIPMP52ZQteMIWbzpLEpzjhF0a2au2NiMHOJZ+JHQZ99
         YDBsICfhezx7vwzarXj01QgPNX4vGroX3OpZ78ILjcVQRsBIdGHpMOMuZinvqvdYi4EQ
         CPppfBCGOouWJtZX21Jugu6Qy1bWpA+xTQyb3Pt8uH6qmrSVOmG6g6eSpjKiOxOUCkqF
         knqabpBybDqjtnfTaoNlylEy8N35+AVjvRErtPDzEifOnfcX86+iN7c52VLsuDIGr8an
         0oQA==
X-Forwarded-Encrypted: i=1; AJvYcCWnPSBrGQD73v81n50cA86cfUzmAFQalnukLFy3HlXYDK97znDwltSqBkw8+yn5q5lHnlDp8YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJTsTKF0GevybEAk1wd+HHbEjIcDJaS3VJrMBtACAAmnkFY/h0
	vcVK6LBxaNPqmPOeoeZFT7NXSKZ04seUECOdQt8g5gd27z6U3JhmfCHozLodIU4RO29yZFlsELP
	1L8AM2xhPcR1maQ==
X-Google-Smtp-Source: AGHT+IEAgZ682d05pLAidqXPlK4LG47j9os5l2hHbXe8dKnZqDlNKS/G4b81qoQrfBj+4tgwwtCa3am8d97x3A==
X-Received: from qtbcm16.prod.google.com ([2002:a05:622a:2510:b0:4b6:272a:fbb3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:59cf:0:b0:4b7:a9ef:1987 with SMTP id d75a77b69052e-4b7aef57598mr75278851cf.39.1758039000237;
 Tue, 16 Sep 2025 09:10:00 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:44 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-4-edumazet@google.com>
Subject: [PATCH net-next 03/10] ipv6: np->rxpmtu race annotation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add READ_ONCE() annotations because np->rxpmtu can be changed
while udpv6_recvmsg() and rawv6_recvmsg() read it.

Since this is a very rarely used feature, and that udpv6_recvmsg()
and rawv6_recvmsg() read np->rxopt anyway, change the test order
so that np->rxpmtu does not need to be in a hot cache line.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/raw.c | 2 +-
 net/ipv6/udp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 4ae07a67b4d4f1be6730c252d246e79ff9c73d4c..e369f54844dd9456a819db77435eaef33d162932 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -445,7 +445,7 @@ static int rawv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (flags & MSG_ERRQUEUE)
 		return ipv6_recv_error(sk, msg, len, addr_len);
 
-	if (np->rxpmtu && np->rxopt.bits.rxpmtu)
+	if (np->rxopt.bits.rxpmtu && READ_ONCE(np->rxpmtu))
 		return ipv6_recv_rxpmtu(sk, msg, len, addr_len);
 
 	skb = skb_recv_datagram(sk, flags, &err);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index b70369f3cd3223cfde07556b1cb1636e8bc78d49..e87d0ef861f88af3ff7bf9dd5045c4d4601036e3 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -479,7 +479,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (flags & MSG_ERRQUEUE)
 		return ipv6_recv_error(sk, msg, len, addr_len);
 
-	if (np->rxpmtu && np->rxopt.bits.rxpmtu)
+	if (np->rxopt.bits.rxpmtu && READ_ONCE(np->rxpmtu))
 		return ipv6_recv_rxpmtu(sk, msg, len, addr_len);
 
 try_again:
-- 
2.51.0.384.g4c02a37b29-goog


