Return-Path: <netdev+bounces-98540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2DD8D1BAB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB4C1C21AE6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5885B16D9BD;
	Tue, 28 May 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiIQPBPp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35816D31F
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900783; cv=none; b=Zxg7bdiQlkygoPPkoIP/K1qKEOjPh3INpMbq8s3Lp1Pu+iozj1zFPQFR8mKWID1gB/aLrnHyP12dJdhgtx5eRzUhe4NgSrBd1r21Oq04GzcYh0F+qgkHIDmC1gh0gd9IW3kQldD8VQlWhAChLJyOeIWukyONJHpuMt6O2uAIA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900783; c=relaxed/simple;
	bh=MAoKDpoXetUM99sFDHvBUGkL1Z7tBtSD7nhqH9eF8Hs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XONeHs5FAphxo607gT2BFRY4i/fiibfbah26SlChGQI5eoppEj/KHt8Gb3hUhoT1aAEngdlwUPFpY05WtlChRf3pEJqyy98fTow0zzXnaXcCf0xKvUx7lVPfbhRcjGjfkoRAMLyg1hwCFtsDu2ir5lOkmC9V5Cx4OIwkdunUqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiIQPBPp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a083e617aso13228757b3.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716900781; x=1717505581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1lGXVmkLky4THEpPNXaUJIFX3a/teJc1Gpnh3zc3z0=;
        b=NiIQPBPpQURR8zU/rjEGqFnHaVvfrR0+W9ilurWfGLExPKLBDYBQhy9GDMMDgbqsil
         NRadsmMTKibedT851yumSWAXoZxdTH07ZhsG9S9q78Vxn1DxqPHX4goNZLJNFU7YDxsi
         YZ2hP3A9xkzP4Nmj1oOlL/tNZ4DjvQmr7RNAzOMopJB1AQSvY2DoGzTbARd2tS5nwriJ
         iSHlN9hDnChW10Xclu6bZwXGRMUN4b+f4Zwjg+s2GiboXV4GDA4qEJfgYprl6ag5zCvB
         F7pvn2fVRjauycUsjN7FuAPL6kaA5GLhl3gNTQiSt57887sHgM5ByK66ZPzuHEsVaKz7
         4PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716900781; x=1717505581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1lGXVmkLky4THEpPNXaUJIFX3a/teJc1Gpnh3zc3z0=;
        b=EyzlAGTaRrr4jGwgj7sKfXvZTLjxiB0vl62tPgGmfv32OlPo5V3u39BfmPrwlUs/Q/
         2pJ5CdJHAiofc94VT3exnCbLNWU9dFMHeVn/BANAOpkCklGSzCJkdYNXLkKuXeqZ1rn4
         QRzVphWf4pQLU1rOGL61VUbQtUrdFCiOb5bBGbGWicXn6VpXr2qce3ow4egU0+7giRh7
         HWd70WAj0lDpLVSomSVw9WDu1C3qz3Eu5FolXc+pdyTjU7ZfLeXMIlWz06Ct6RBaXbt+
         SaAzr0PnOkpyJ4wbL5ytFw8fEmdSz5Obgolomp9SQsBRqcomNhk0NowyaRi8kZFc4QUN
         wxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMEZsFFakhsiEXQk8d/UEqOGX2DbdfrNpgffqI0PsKoP6LYSRKM0/G9+rfGte5fFnfmlNAS1PAcsJ9VgSRWkfRGai+9kHZ
X-Gm-Message-State: AOJu0YxrhOqL22m1hu/j38Ip7dWNQivP6NiWkmDVCQZE6UTroT2jIctD
	o25bI+nC5BswT9i/+QtNrOG6dsapIV+eYAcnyLPVHITni66fP+c5o4ztjMH+mEuQkOumiUvNZEU
	Q8twtsiZB+g==
X-Google-Smtp-Source: AGHT+IGeIrikSjo5bUl9Wn4tTFPc47oRSEL4TX3Cn5/TOsf/u6YNxPJ1u9wGAqiknVnvbco8i0sOdAND3RR8MA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b03:b0:de4:5ce2:7d2 with SMTP
 id 3f1490d57ef6-df7721dc43cmr3463586276.4.1716900780840; Tue, 28 May 2024
 05:53:00 -0700 (PDT)
Date: Tue, 28 May 2024 12:52:50 +0000
In-Reply-To: <20240528125253.1966136-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528125253.1966136-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528125253.1966136-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] tcp: add tcp_done_with_error() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, David Laight <David.Laight@aculab.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
 net/ipv4/tcp_input.c | 32 +++++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 060e95b331a286ad7c355be11dc03250d2944920..32815a40dea16637d2cc49d46863b532a44fbab3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -677,6 +677,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 /* tcp_input.c */
 void tcp_rearm_rto(struct sock *sk);
 void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
+void tcp_done_with_error(struct sock *sk, int err);
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
index 9c04a9c8be9dfaa0ec2437b3748284e57588b216..5aadf64e554d8009b2739613c279bbf82a05bbdd 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4436,9 +4436,26 @@ static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
 	return SKB_NOT_DROPPED_YET;
 }
 
+
+void tcp_done_with_error(struct sock *sk, int err)
+{
+	/* This barrier is coupled with smp_rmb() in tcp_poll() */
+	WRITE_ONCE(sk->sk_err, err);
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
+	int err;
+
 	trace_tcp_receive_reset(sk);
 
 	/* mptcp can't tell us to ignore reset pkts,
@@ -4450,24 +4467,17 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb)
 	/* We want the right error as BSD sees it (and indeed as we do). */
 	switch (sk->sk_state) {
 	case TCP_SYN_SENT:
-		WRITE_ONCE(sk->sk_err, ECONNREFUSED);
+		err = ECONNREFUSED;
 		break;
 	case TCP_CLOSE_WAIT:
-		WRITE_ONCE(sk->sk_err, EPIPE);
+		err = EPIPE;
 		break;
 	case TCP_CLOSE:
 		return;
 	default:
-		WRITE_ONCE(sk->sk_err, ECONNRESET);
+		err = ECONNRESET;
 	}
-	/* This barrier is coupled with smp_rmb() in tcp_poll() */
-	smp_wmb();
-
-	tcp_write_queue_purge(sk);
-	tcp_done(sk);
-
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk_error_report(sk);
+	tcp_done_with_error(sk, err);
 }
 
 /*
-- 
2.45.1.288.g0e0cd299f1-goog


