Return-Path: <netdev+bounces-190241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC3EAB5D3A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEDD3BEC5E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95A2C0333;
	Tue, 13 May 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdQemvcX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D12C0308
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165170; cv=none; b=CPlINUKOo0wQYm5PF03g9RYietBlSlULb4EW8Z/z6eBieXWlZy3KdrfxW4iRs+7j078oxrEtErPgKeTkOD3MWnzQqAkjKr9LO93x9IUpDEwewjeEV8LUp6op1sAeVvdWiW2hMfTOsaQwJwvKCcDMuGHPXwI5mRiDBCDh++00SkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165170; c=relaxed/simple;
	bh=GKVX/N2wnM2YsM8IAdqvAmeDukOHwSJBU6eTDfLDSWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tG6GUGo5+L0A1zhwRM3nHn2TALffl0YI/cMJzsk9rZJ0iFbaGemE6cW+gzrEOwklMweB/9gEd6kuxz6mxEIsWqAyFhbCBolR+DTOJ7Ya5xuEGOkRpWdfDNybMIJwoLbqgY+9wuc+BgbN0LTQPJaQ/ILkH1ecdzMlcdRDJMM2loc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdQemvcX; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4769a8d15afso97642021cf.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165168; x=1747769968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A328vxwB0WgWj4zQSlReo28XGIYb26I0gH1ymhc0z3Y=;
        b=kdQemvcX+MFm11+JFIqovYie+DXUdyU4tSDoO74caV77jLjVMInUFTe0egh27I8rM2
         baXzPeIczk4Epi7Q+Xkq58omAtVSp8kDKk+qCRjs1wJcmMWWLB25WU9u5UkgFAiWjk1u
         TryQEHTsiw5/8LcjdA6hgjYJmhJxhN0FJULsn3Ej3RdFriz6JBEy2A/ZHtPRLYL7oZgQ
         HzVOB/D3tWuFjWtsuenkdgODH9Fv5aLqF6bDg9vba4pUJW8Bf4Br/Ilj12tHOylfp31E
         3eVvAnP0U7A5+r3+mxVUmEzgLHSwdJmpLcRvOHnOrqH1OJsJ9Nvw8nJ/aJUl3+GegmhJ
         WcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165168; x=1747769968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A328vxwB0WgWj4zQSlReo28XGIYb26I0gH1ymhc0z3Y=;
        b=a7FSjQkEcftUCIJvK+Q7g7jvBwcgxk6g0wsKStITQoYgaaOJwEc2tJqsmiUHIbdm82
         x3R7+jIgdenb/1C81rvtavCLgbnz8jrdQo4NjKJks6eT0hBK6VZzdg9ZZ8nK3KBfKFpT
         wRevFMbKqn7AscuvQv2FVOUCbVLplB/GrlOS8y+Vax4Y39D765nhzyf84EPsvyvEJ1/p
         gs3n6yQjz6E6m0JADNzpQBXQZwt5uOj9KjYB9gPk6HQGuGl5NrSpvrJN8it/1tG6VT0r
         ev0SZ13OIHzHZMjcXMwh81dZnJPufaV6wWQONrgjXzx3cDdABu5DQkJc7w3LNgRt7SuO
         LXZA==
X-Forwarded-Encrypted: i=1; AJvYcCXmSN2GJ6Z2ytsdcwScmS74ZOQF7y07TtLud8vGcPjEtzXdrFfdSq9NqIsnw8iLIf7SckbY9W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmvckoXc/iRB0u8D4YEWZqJdnj3RfIu0eHD8qgH6FfnYuALtW
	JV0pfxBT8t9zY1RyDm6tTACsFRab4tG0TYLlKXQoP4AcMgRhzOWqvEkYRn+qG7lcYhKUq0Oamz7
	uMm0PRKtG/A==
X-Google-Smtp-Source: AGHT+IHffBqfIU5RFivAUh4wqP5CdVDZdlOf0+JyVNArhumT0qK4DGASHp6epud0diV9Q8YEkXNJ1J0BfCFuew==
X-Received: from qtbay7.prod.google.com ([2002:a05:622a:2287:b0:47a:f8e7:4a4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2296:b0:476:8a5f:8cfb with SMTP id d75a77b69052e-49495d1fd16mr13109941cf.38.1747165168095;
 Tue, 13 May 2025 12:39:28 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:12 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-5-edumazet@google.com>
Subject: [PATCH net-next 04/11] tcp: add receive queue awareness in tcp_rcv_space_adjust()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If the application can not drain fast enough a TCP socket queue,
tcp_rcv_space_adjust() can overestimate tp->rcvq_space.space.

Then sk->sk_rcvbuf can grow and hit tcp_rmem[2] for no good reason.

Fix this by taking into acount the number of available bytes.

Keeping sk->sk_rcvbuf at the right size allows better cache efficiency.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
---
 include/linux/tcp.h  | 2 +-
 net/ipv4/tcp_input.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a8af71623ba7ca16f211cb9884f431fc9462ce9e..29f59d50dc73f8c433865e6bc116cb1bac4eafb7 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -340,7 +340,7 @@ struct tcp_sock {
 	} rcv_rtt_est;
 /* Receiver queue space */
 	struct {
-		u32	space;
+		int	space;
 		u32	seq;
 		u64	time;
 	} rcvq_space;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f799200db26492730fbd042a68c8d206d85455d4..5d64a6ecfc8f78de3665afdea112d62c417cee27 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -780,8 +780,7 @@ static void tcp_rcvbuf_grow(struct sock *sk)
 void tcp_rcv_space_adjust(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 copied;
-	int time;
+	int time, inq, copied;
 
 	trace_tcp_rcv_space_adjust(sk);
 
@@ -792,6 +791,9 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 	/* Number of bytes copied to user in last RTT */
 	copied = tp->copied_seq - tp->rcvq_space.seq;
+	/* Number of bytes in receive queue. */
+	inq = tp->rcv_nxt - tp->copied_seq;
+	copied -= inq;
 	if (copied <= tp->rcvq_space.space)
 		goto new_measure;
 
-- 
2.49.0.1045.g170613ef41-goog


