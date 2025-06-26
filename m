Return-Path: <netdev+bounces-201635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B08BAEA285
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86903AC2B7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F472ECD22;
	Thu, 26 Jun 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGtMenP0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA818DB1F
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951825; cv=none; b=SKaPQsZvCXsZKRnA1sWV/TX9CePnivUujG3+Ovmu2IHrdi0MtknPPkS6aTaXAPpO2RpcBcopfS6Nv0cEosJKr36dr8MR5jZD0z1B8VgeXSLdo2njRGBWO153iBJJmUZzg5Z1JBcvnh9egqOVxvY4kYOBPDMF83Z4fWukZQwYBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951825; c=relaxed/simple;
	bh=XCI+y1D4GnRZ8lJMZeyA4tYOrjxU75AlVhmr1jvo/Hc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JjkyC95rbIAJ3cxPnbIwKmC31q3njx0dJVWxlYchO7LjXENeZ2mSpkV5ccFBc6zGpABrrVNV7wf+jLmV316TH8B9Y+cnfQ9tUeOFkfFdLIuOYQAuWoaTh2XKUX+SRkPfwLD5MIIuTq+2muqd8iV0B7jXkg6YkhgAjA3QOXOijBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGtMenP0; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7cf6c53390eso81277285a.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750951822; x=1751556622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ7SLoQWgrMlU6UCxVPFFwaZ6FxEZ8GwZNC4hjKjEPc=;
        b=cGtMenP05y35SguOY5AWTvzSs5D6Gak5APE2tMTx8VSaMsGJePNF7JHN1f8AVoOako
         FeExNewb576NDIBGauH3Lg1/EKTmOE0BubgWt5kQjYLI8Owg+uAjypxUbVzqEuTRvhif
         9KeXpx4HXEWl+DC//dKVfKHMd7fKJV6NpMIIl0VsSUiIj+zFr/z1934cMrzzVJjwJAJC
         K7yCzjRTszWfP5tlrTkTk0SDLa6EM0msv+aK+mRC38ueIq4Tt0WvUkac/V51ozcmtDu2
         HjojJg/8QrG/POFklvThTTqHFN77wfa3f52HloDS80vaWOCWzEDJbEnrOPdLscCCWIVy
         d9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951822; x=1751556622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ7SLoQWgrMlU6UCxVPFFwaZ6FxEZ8GwZNC4hjKjEPc=;
        b=cPEiPHZoE3z1Qg5sGOxRRlpUy1Xwn1RJ5NqRs42tl+JLPRd67bRdvCxs9DeFiCqJ2Y
         D+jEe7NanfUnS6n0gnZCc9RLkKhYACPjQXUji1QS1I5vmv9xidIkbxozS88lVmqIlxuN
         Rm27ovKEX+p3DSGhHrIujq6wOEFVTaS9UxtNnr0in7feEyiPAfI45AN+zYrmbik3MI9F
         hdeWjdo72JjC5Of3KgpQ/yvQqtLaYkXnmGaGwOZzLZ8G57e9DBHBTBKOsRjM0UFZklL6
         Vm79Piwz6vWi4CBzQhxsAzFvJDidoEFAGcQuLAzpc3DaH/ZEVGZhlPeupIUN5UD9/H0M
         O9vA==
X-Forwarded-Encrypted: i=1; AJvYcCU9RXz3uwUhXXWJ0Xl95aHn7KWug0iYwcRP8JaLY/fxcDgzkwnUveCxWLmIxipMjnEUV9TXNnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj90UjiPqVzFv8FnQ7F0M0MWKDvTkvuAcJB+8AmRJ0Q+Qhy4Ps
	a2o4Qb3C04UYo0URX3ahSN0TKymxrpmRs27q5UT92N3JzrcEBlfsCB/KOoaVJsuXCvvCP8yThNa
	H3KJ8QPzlR+GolA==
X-Google-Smtp-Source: AGHT+IGnnQCpdfowcfCkETBZjG3qAd+Du+eLvNyyox+wBLtmLNqd1s5BJhx6m2IBcVa+3qznIqMcWNKc4UbA6Q==
X-Received: from qkpx18.prod.google.com ([2002:a05:620a:4492:b0:7ce:c39e:e9db])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:24cb:b0:7d3:8fd2:c0cd with SMTP id af79cd13be357-7d4297cc918mr1126334685a.56.1750951822337;
 Thu, 26 Jun 2025 08:30:22 -0700 (PDT)
Date: Thu, 26 Jun 2025 15:30:17 +0000
In-Reply-To: <20250626153017.2156274-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626153017.2156274-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626153017.2156274-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: remove inet_rtx_syn_ack()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_rtx_syn_ack() is a simple wrapper around tcp_rtx_synack(),
if we move req->num_retrans update.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/request_sock.h      |  2 --
 net/ipv4/inet_connection_sock.c | 11 +----------
 net/ipv4/tcp_minisocks.c        |  2 +-
 net/ipv4/tcp_output.c           |  1 +
 net/ipv4/tcp_timer.c            |  2 +-
 5 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index bad7d16a5515beec7375bddbb74fdb8a6d0b4726..6a5ec1418e8552b4aa9d25d61afa5376187b569d 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -39,8 +39,6 @@ struct request_sock_ops {
 	void		(*syn_ack_timeout)(const struct request_sock *req);
 };
 
-int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req);
-
 struct saved_syn {
 	u32 mac_hdrlen;
 	u32 network_hdrlen;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index d61eef748851796f53592ca6781428266bdaca26..1e2df51427fed88d8a18a61b030f5e6234dadd8f 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -884,15 +884,6 @@ static void syn_ack_recalc(struct request_sock *req,
 		  req->num_timeout >= rskq_defer_accept - 1;
 }
 
-int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req)
-{
-	int err = tcp_rtx_synack(parent, req);
-
-	if (!err)
-		req->num_retrans++;
-	return err;
-}
-
 static struct request_sock *
 reqsk_alloc_noprof(const struct request_sock_ops *ops, struct sock *sk_listener,
 		   bool attach_listener)
@@ -1132,7 +1123,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	req->rsk_ops->syn_ack_timeout(req);
 	if (!expire &&
 	    (!resend ||
-	     !inet_rtx_syn_ack(sk_listener, req) ||
+	     !tcp_rtx_synack(sk_listener, req) ||
 	     inet_rsk(req)->acked)) {
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 43d7852ce07e0440c7f43b7509df9229e666fd19..2994c9222c9cb5ee86b60bdb553f92130e52c70e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -726,7 +726,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
 					  &tcp_rsk(req)->last_oow_ack_time) &&
 
-		    !inet_rtx_syn_ack(sk, req)) {
+		    !tcp_rtx_synack(sk, req)) {
 			unsigned long expires = jiffies;
 
 			expires += reqsk_timeout(req, TCP_RTO_MAX);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 28f840724fe833d594e1b151f8e130d2d54fd766..b616776e3354c7df23890100def1df729fd33d12 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4425,6 +4425,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 			tcp_sk_rw(sk)->total_retrans++;
 		}
 		trace_tcp_retransmit_synack(sk, req);
+		req->num_retrans++;
 	}
 	return res;
 }
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bb37e24b97a78de581e8192b52b78f83ba747446..a207877270fbdef6f86f61093aa476b6cd6f8706 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -478,7 +478,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 * regular retransmit because if the child socket has been accepted
 	 * it's not good to give up too easily.
 	 */
-	inet_rtx_syn_ack(sk, req);
+	tcp_rtx_synack(sk, req);
 	req->num_timeout++;
 	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
-- 
2.50.0.727.gbf7dc18ff4-goog


