Return-Path: <netdev+bounces-190244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6DEAB5D3D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5107619E528B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884E2C0857;
	Tue, 13 May 2025 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kj7Fc/Jn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C72C084B
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165175; cv=none; b=Z6zPkGYqsg/TnRUuzUv73wLgDD9BWB1mGV208F+OzibBb2tFoQLeOfMmgd0WadgRA9VQXpt++rSw7k9MxKQO1/yRTjVTcWBv5KAIFGcgt9z8MI+6C/LoO0zgDXNZIVmaIUkKB0woh5LCrFaCSz4fWhUoxf8rR+2cN9LBtpYEjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165175; c=relaxed/simple;
	bh=+Z6NLXnyEf5LFaFBnpY9PaAgqFz8FTg2l2PP1gJzVBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sWSyazo17fC81HdQovUchHcU3c9d7kNSP7EbOSgD84fNkS8unAYw3/HU5JG3fDbDdgVIB+/r247tncDf/z3Wr5YOb8m09ax+bsEH5jeZl7z2xlLQMnIGXgndq+V0z5ML5KHHj+ZQR6Q62s5Z4GFqMmg9WypsclvA708i3nEA2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kj7Fc/Jn; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-476870bad3bso102292651cf.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165173; x=1747769973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tsa9h5fsBsCfrkab97/4Y1li71bsXnZpj7BSz6tB7E=;
        b=Kj7Fc/Jn65wuQc5SQehSLQkpkZtZfyH/uMEJiCqvqdpyaA6/E1f4WQFSpFndjjYpal
         J2GR9VSH5yCHJlrhl8IqMMxwQsJyhzzadpfQS1fulDLR0/C+WNbm8cYPOvwOaMck41B+
         oELqVJ29jCb8vv4pRqLYud4GO4A2cT2GVZeCwjbUfgbZ5VEbhB6kdC4AzlAiZ/CcdPDn
         4gryRj3Wb7CKAKKT4sbamN34UX8/I43Pm1snUcpESFComyY/5BGeouxyG3Q6ErfcwzXs
         Xyvb5gwMNz5lAWxNanAfZ+7vDk+3/exwtcUEca1rAXKIZA9nloYnEnGdDMTkWIWA9I7Q
         sotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165173; x=1747769973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tsa9h5fsBsCfrkab97/4Y1li71bsXnZpj7BSz6tB7E=;
        b=eRPtTmNBORD4+nFjuQq/qxKB6CxnsRLbOvcH8eFyaJOdn2OochGJJiyFcVQC+vqrOf
         OeyLiDxZf9fMFwejXK1l5pXI9q0HmbViieNTArNMJKm7sojHDp/TzY6tYvQXeq3t/d0G
         sKbMpXqTF6wcmTliQO89PteSaocongvJQPrdZiM9IeoC0Cjq6ZjnDynfNq7FBPGkoFe0
         gbqbk3gJfdw4SNulXkTKnDG9nE0rIasHsP/8j4NB6WR0dZ5zC2C/Mf0X/3PuhGgKWQ4A
         kAx0zv8yXjcQosnnezxaCgc8RwhiZdAJSHVRWXNpPeS2Wnz68YQjtdbQBL2zQPXMbaBu
         dpFg==
X-Forwarded-Encrypted: i=1; AJvYcCXm1aAyzGszP9xWLE8anwUp0TaXa9VqLbkJhxsiubcymeRWUWMpdw4YHaXao0FJcu6b1Y0sJSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOB3MxaTl10wIc7Qa2DbeQChU7DJvy6YvwGYa/K7W/WCOKE2JX
	x1LsfK27jD3Y/0EhwXF/R9xo2qFDRN7oP6bjhqVbL7qkofXGn9eCM/yNfqxGY5toqWbO/pLepIG
	NQ8JJNbPZ+Q==
X-Google-Smtp-Source: AGHT+IHm5hFD6O2/YljBeZTt9Kuec8IuheZOl+SqaUBj8C/mNjjOZTFwB88VI3O0W+axEzmIpdEZwRvrYO6VZw==
X-Received: from qtbay7.prod.google.com ([2002:a05:622a:2287:b0:47a:f8e7:4a4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:98f:b0:475:16db:b911 with SMTP id d75a77b69052e-49495d04d81mr13419631cf.52.1747165172968;
 Tue, 13 May 2025 12:39:32 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:15 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-8-edumazet@google.com>
Subject: [PATCH net-next 07/11] tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_rcv_rtt_update() goal is to maintain an estimation of the RTT
in tp->rcv_rtt_est.rtt_us, used by tcp_rcv_space_adjust()

When TCP TS are enabled, tcp_rcv_rtt_update() is using
EWMA to smooth the samples.

Change this to immediately latch the incoming value if it
is lower than tp->rcv_rtt_est.rtt_us, so that tcp_rcv_space_adjust()
does not overshoot tp->rcvq_space.space and sk->sk_rcvbuf.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 32b8b332c7d82e8c6a0716b26f2e048d68667864..4723d696492517143a2f3c035bfda6b05198a824 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -664,10 +664,12 @@ EXPORT_IPV6_MOD(tcp_initialize_rcv_mss);
  */
 static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 {
-	u32 new_sample = tp->rcv_rtt_est.rtt_us;
-	long m = sample;
+	u32 new_sample, old_sample = tp->rcv_rtt_est.rtt_us;
+	long m = sample << 3;
 
-	if (new_sample != 0) {
+	if (old_sample == 0 || m < old_sample) {
+		new_sample = m;
+	} else {
 		/* If we sample in larger samples in the non-timestamp
 		 * case, we could grossly overestimate the RTT especially
 		 * with chatty applications or bulk transfer apps which
@@ -678,17 +680,9 @@ static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 		 * else with timestamps disabled convergence takes too
 		 * long.
 		 */
-		if (!win_dep) {
-			m -= (new_sample >> 3);
-			new_sample += m;
-		} else {
-			m <<= 3;
-			if (m < new_sample)
-				new_sample = m;
-		}
-	} else {
-		/* No previous measure. */
-		new_sample = m << 3;
+		if (win_dep)
+			return;
+		new_sample = old_sample - (old_sample >> 3) + sample;
 	}
 
 	tp->rcv_rtt_est.rtt_us = new_sample;
-- 
2.49.0.1045.g170613ef41-goog


