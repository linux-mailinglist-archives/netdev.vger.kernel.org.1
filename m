Return-Path: <netdev+bounces-190247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA78AB5D3F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C0D4A0D49
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00A2C086A;
	Tue, 13 May 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3pom3pJc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915562BF96F
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165180; cv=none; b=ow0QUezGEi7CkhROegL4uKb6HGGA6J9E8ZfUiMn91GSni0iEDiKZWotbzmV11Ed/mMb+1D5u/hmpAyJP2TO5TZed5tpPRBW3WY2oRzZliGiA9NcaUCecYfei+JNGdIk9059cHqiRmuCFxU+o36tkZutEXe3DscbcERIC7LyQpjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165180; c=relaxed/simple;
	bh=RSAenodTiuiPAqCTqOEffBLr5PA9sYV34PH9Vc5pup0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MF+bqpxE40M6Q94earI/qrYNW08OO3FMXMvczPqcmF7iWpCVsrKJyFrbk/uQ/OutKSJdUR4+Mmf13pYx62VhHytgSgT/iUTUadPJc0oKBF4e7E10JcNSX87xBqJxrPoOYUeiE6DFJuoYv2ElT4AUQP+7OFDoaymAU7CUs6lYII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3pom3pJc; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-47ae87b5182so112491171cf.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165177; x=1747769977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rVdksWi24cwBwtgRx54BEvToF9/PIiCuOzPeG0IvBM=;
        b=3pom3pJcS3svqgTqG0puFh2ORr7DUpYkHiO93XEggqgN1Cv/PERuxV/l+6oqGKty0/
         gLDQWc8DZWFqm001wqqUu4tXHOEXSxVUr9P5wG1OyWV1aVfst6NbjQ2D3Zi4evfc8VxZ
         fqEl6B0lyCiRkp7AVuPlox6QSn50MWH/UPcyOD7xllZLRGVEakNuEOJv4rdU4MicUHHv
         +BoMvrwpj6b3M8fXjAZCZRLFOBm3mD0os45OoNNyllY5t5Fnf1KsHhyMj2usH6v0iX20
         Vw3VfsHBR7KpramB9YmzLHtMXa+svfPupB492uV5cYm42J5WD36jdiCItEL5SlvT1ORg
         Y4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165177; x=1747769977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rVdksWi24cwBwtgRx54BEvToF9/PIiCuOzPeG0IvBM=;
        b=bPrndChSHgTsZChGddcoTqEuoe6U54GoShcw+6Y44A9+oAWYJEPkYGSFh3lQrdYND7
         iM18eh0FD4aixGIouRNb7mtGfGrIjAxvfGYBD99g37Q+U599l3NgG7YD28xHRM0zeKZ4
         pcN4vtaVdkvB+cAD+Ax9hz9YeKPJjS3rnHa7VEcXZMKx3cD9MF9DhTlnMSOyiIi+xKP1
         Du77yCLdUj4jJ6zepHa4tztFj86m5QFLtMd4eadtfghmwB6cUMe2E7dX5jH3EXM5n6xz
         ucG7Q5SYNlqTBS3ITSX9NRmE03tJH449OPxCHrnfeii3Ka3fyUifQoC0dQtREXsNsw58
         9OfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8jI6tDXWkncqitSqqHe9oiDStPMBxwT0Q4cYuf77167mkWHi79a7frXjk9wLse/+DfDJs2uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGDzidaWDWzZlXVSypuWFAI2EP3MzWu69tEujUaEhSikEKgrZ
	9EJlAwhfdz1LMNpYnhM5GDkJYyi6tjK/IUBxnI1hiRm2znbuLDaziZRRGP0r91eimiRKFbsDxLc
	xl/WLmEFRmQ==
X-Google-Smtp-Source: AGHT+IESF0/qPWYPzLqF5iG8bbKEu2tdR+MDeqUQxVLHkLgAGw10tthCgTsJesgQjVte4B2BY+hodU9UWKKb+g==
X-Received: from qtbay31.prod.google.com ([2002:a05:622a:229f:b0:48d:7e8a:cdc1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1b13:b0:47a:eade:95d3 with SMTP id d75a77b69052e-49495cccfbemr12690871cf.33.1747165177496;
 Tue, 13 May 2025 12:39:37 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:18 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-11-edumazet@google.com>
Subject: [PATCH net-next 10/11] tcp: always use tcp_limit_output_bytes limitation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This partially reverts commit c73e5807e4f6 ("tcp: tsq: no longer use
limit_output_bytes for paced flows")

Overriding the tcp_limit_output_bytes sysctl value
for FQ enabled flows has the following problem:

It allows TCP to queue around 2 ms worth of data per flow,
defeating tcp_rcv_rtt_update() accuracy on the receiver,
forcing it to increase sk->sk_rcvbuf even if the real
RTT is around 100 us.

After this change, we keep enough packets in flight to fill
the pipe, and let receive queues small enough to get
good cache behavior (cpu caches and/or NIC driver page pools).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 13295a59d22e65305d8c4094313e4aa37306cbff..3ac8d2d17e1ff42aaeb9adf0a9e0c99c13d141a8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2619,9 +2619,8 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 	limit = max_t(unsigned long,
 		      2 * skb->truesize,
 		      READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift));
-	if (sk->sk_pacing_status == SK_PACING_NONE)
-		limit = min_t(unsigned long, limit,
-			      READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_limit_output_bytes));
+	limit = min_t(unsigned long, limit,
+		      READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_limit_output_bytes));
 	limit <<= factor;
 
 	if (static_branch_unlikely(&tcp_tx_delay_enabled) &&
-- 
2.49.0.1045.g170613ef41-goog


