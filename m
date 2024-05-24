Return-Path: <netdev+bounces-98027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21388CEA66
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 21:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211861C211B6
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400285C8EF;
	Fri, 24 May 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttD+Hyr/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5687604D
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579397; cv=none; b=Xhpo0sM5rkyXlWoFtaD0HRKNaeqokU8RSg4uWt26qORkwjXFCr2x5ZoJmUMoULZcgRlQlNZDEL4AM1MPOBBja0rNtMBW0jyymbm017S90OpSuTPPU1J3XwsW5lJLVORtIEw/TX1baf9FMQ6qh+/vppEjK9r+DPVFFfRli9TjH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579397; c=relaxed/simple;
	bh=NNKtVgAJ0fOb11+13x4CJW8Z2WkJKm/n/BQsKlvjR4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yi+COovuoia5we1y7mT+vOO3AbykrtyZadwHutD79EZKQx4bPC5QCOWusIzkCgaVn6Q9MW/HyyulIlsk+aMPeIJt2qOaBgUCyI1I268Tl+IQ717QugsO6IHMS2FDy0jrzfglp8JX91swketPaDLbG2r+RXA1THn7TVic4P8Guvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttD+Hyr/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4d82f868bso1174191276.3
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716579394; x=1717184194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqLo2nlXRPQhxezjJrQjfZ90CXKZrZSy/sGGf0J8h68=;
        b=ttD+Hyr/ob+URP3L6kFGsNsNymh/F2ZBnB2G/oMy7hSkXZKINRbIeXR9pMTyjLpe9U
         FUUec9NDja9U+tDWNNjY8PEC7ZAqNH2M6ETqab2xZzntrHQbp3QSl8MbOoOXHwN8K7lK
         sLyMwrucnNc4+LzwK6+PsAXyTJ+43nmP8vvISZXMl/mp5FYM0UL/UXBNlea8EDn1X2ja
         Kqihx0JLLi1NIc8qatZM4/isQ88dqW2q8ugRroUDUl1sWSzng2PS46mT/fWgX8E5479m
         /vILu+cXnemgvWXddE96jUeBNjrQm235FuSLSUem0AN2HjBXTEymweLW3bMn8WeFNoc0
         SeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579394; x=1717184194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqLo2nlXRPQhxezjJrQjfZ90CXKZrZSy/sGGf0J8h68=;
        b=wu/EXZ56dhnyg4+8UADTXs2y7bBZQ0idEoMLC3sCe6fPAjWS311+KcVJMGDXrTNnxy
         MO+n/xEt3Oi9sNz+O7zqrWzapO9NkgWuWpwjNwy4cZCLjhvHXgQmd1CLyxQhx74MH+bV
         hRwswX0jzdZyanJZXGc8D5I5rRmmtapfC4NOoDu8fSQm8vxPfoE/ng4yBnQjZb1Rbk40
         iuGqNmxt5nFKCiOj1LqSALhnOtMmPds1Qf4QIAdMccixh6EI5YhgY07sAWiXf/m8uFkK
         jxQ+VYIK5SCE6+wBxA0IQqgLrx5buyfb0+951VOj4O/NpmC/w4ql/ayIG52bpi0kzFFj
         x4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh8uLI1DGEuaPpY/IHpcsfAM3VmNqENHWuZcLZV3uMo/eRY/DRD7ZYkDnFpAggpbvrgenEGOMHuYEntFGmkziWSrJUWQj0
X-Gm-Message-State: AOJu0YzkW2k//ntUocvFMo3k41ALkCPJrO7DWOQ+YYXyV4cDHeAjNEaS
	4lJ2Fk9J4KMVomYj8z8xNhqU3xreOBt2p3zV6tceRYyNP8OOm/pTWDIWmqxYJ4WhbJO4Sq4BnDr
	rB781XROs3w==
X-Google-Smtp-Source: AGHT+IGYWRf8iYGrHrFV7yG9i/Yhow44ChFHzN7gUysYxRgx5R3cClwwgxfmyk0Jw3CPN7oDjT49aP81kGEFGA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c01:b0:df3:19c6:d344 with SMTP
 id 3f1490d57ef6-df7721560d4mr876719276.1.1716579394667; Fri, 24 May 2024
 12:36:34 -0700 (PDT)
Date: Fri, 24 May 2024 19:36:27 +0000
In-Reply-To: <20240524193630.2007563-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524193630.2007563-2-edumazet@google.com>
Subject: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_reset() ends with a sequence that is carefuly ordered.

We need to fix [e]poll bugs in the following patches,
it makes sense to use a common helper.

Suggested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp.c       |  2 +-
 net/ipv4/tcp_input.c | 25 +++++++++++++++++--------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 060e95b331a286ad7c355be11dc03250d2944920..2e7150f6755a5f5bf7b45454da0b33c5fac78183 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -677,6 +677,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 /* tcp_input.c */
 void tcp_rearm_rto(struct sock *sk);
 void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
+void tcp_done_with_error(struct sock *sk);
 void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 681b54e1f3a64387787738ab6495531b8abe1771..2a8f8d8676ff1d30ea9f8cd47ccf9236940eb299 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -598,7 +598,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		 */
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
-	/* This barrier is coupled with smp_wmb() in tcp_reset() */
+	/* This barrier is coupled with smp_wmb() in tcp_done_with_error() */
 	smp_rmb();
 	if (READ_ONCE(sk->sk_err) ||
 	    !skb_queue_empty_lockless(&sk->sk_error_queue))
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c04a9c8be9dfaa0ec2437b3748284e57588b216..5af716f1bc74e095d22f64d605624decfe27cefe 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4436,6 +4436,22 @@ static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
 	return SKB_NOT_DROPPED_YET;
 }
 
+
+void tcp_done_with_error(struct sock *sk)
+{
+	/* Our caller wrote a value into sk->sk_err.
+	 * This barrier is coupled with smp_rmb() in tcp_poll()
+	 */
+	smp_wmb();
+
+	tcp_write_queue_purge(sk);
+	tcp_done(sk);
+
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk_error_report(sk);
+}
+EXPORT_SYMBOL(tcp_done_with_error);
+
 /* When we get a reset we do this. */
 void tcp_reset(struct sock *sk, struct sk_buff *skb)
 {
@@ -4460,14 +4476,7 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb)
 	default:
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	}
-	/* This barrier is coupled with smp_rmb() in tcp_poll() */
-	smp_wmb();
-
-	tcp_write_queue_purge(sk);
-	tcp_done(sk);
-
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk_error_report(sk);
+	tcp_done_with_error(sk);
 }
 
 /*
-- 
2.45.1.288.g0e0cd299f1-goog


