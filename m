Return-Path: <netdev+bounces-236107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7FEC387CC
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C80724ED093
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6843EA8D;
	Thu,  6 Nov 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhQYlDIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC4199FAC
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389247; cv=none; b=kv9aZ07fEAg+5s2XgX9llYS+i0dulXbbz+GkGuN8gbGKeBEzxnX/ce6xFZQyyyJWASrdU05dku+MAsJ3Z8a9UQfJocChNMdCVaa61WfALpKyv2IP/CnC0duMzwkEoaBl0FDCKB/FKD713HYGVRvfLc92fo8qA/cghswxEsQNqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389247; c=relaxed/simple;
	bh=n6lSUXfAB4i2eFrZMCABfuTd2lPN1NW5Q7i9tLtwr64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K7aRDie5Fqcna4pzjxlS0iQXknAoOoB9IQrJksVbbx98pRAaV522hOp0mf1o8xQBX4qQoMh8xMh1A7snXdnVAfKeZ65LZXI+/NxWx1ldHJYSPgKP0Zwrr0SRkYBdKYyRd/tR9AcRWvPmslXFh4/vM0w1Jb35oIBtfovw1tBH3QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhQYlDIu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-341aec498fdso485050a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389245; x=1762994045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAQXbBQ8JCGq0Mht50ZWeFWEt3eK+jXHYanKfFjt1cs=;
        b=yhQYlDIuOOwKC0Izl4y8rjFIkClKVbNYRoKpNAxX+CbbQmFhCSaURhgbCDQMmzpbZ1
         ucM9lsJq68bLJb/sKR6H8SSQcitFz2A6Aec05T+JKbIm3fPvezdboPZ0IOmZ/N0CdE/n
         PSN3aLUM9lAmlr5vQvSQJLQNraL8QKOtPVuQhDQ4IO4MIQr4VJilU+vTTYa1JpZjNuaT
         GcbC6SUMow68rWHReRHBnqKqasKSkpLv27KR3AtTXubV5wLHyI6iAmYsGtD2D2VIZlZe
         mPualc3/Cd0UNya+lQGM9luuPVcNj/FxkRma5+WPdtm7/9ZLY75rFrMWs+s8jirwTNYq
         bLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389245; x=1762994045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAQXbBQ8JCGq0Mht50ZWeFWEt3eK+jXHYanKfFjt1cs=;
        b=Gp87ssnxD4dYyRce1vdPtwsYro8zW6k+87ozSIg93Vy2DYncAY9YwQTG8Vxlutdemy
         I/zcqG1qLF/i7GJTNX+SX30p+75LsqMImE2CGyDv7g/LefZ7Mut7GKt3zjNW26yaGkJ7
         pAfpP7FLT+m6yB04bC5MdjUJUysBC+9O8vGZNc5JztRy8FiLqGJdMn1Tlpzl8l5zCKwK
         Du73dcuMpb0j6NRzaexwkmHq55Abvyrtk7lty6PiSMsJ1/pmhIoAvvArSLBOh3bKHYUF
         PBGYtlUvsD+KP6dIuaBYrrLNF9nvmq60ukQWmD1Z5PQau8WfGRplHRftoVJ6IvZiA9ja
         N7bA==
X-Forwarded-Encrypted: i=1; AJvYcCWwXxXu1G5h3fCNdJ1mySIxWdxW8eTBDT0ZsmwAh2dogYYJrL+mKvsO9nr9QyMevqmYtnFTkyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1TOHr12mFjMMcMGJRwdLevMAXk7QBDwbpT4U2L7tncCgMs8q
	M4TxLI3a22XUbZpY8/Rt2sI8uhXKP/tbDWFIp4D8srTk0pQEza3vl5uU7YvWzeNdd1fKgiWoZIo
	m9vrjuw==
X-Google-Smtp-Source: AGHT+IF9leyfdO0DUBI69RBY277NewZjexGjdYX3+SrMSGt85TBh2/9S/x5f+OahjtFo1wdM6XyQoWN+op8=
X-Received: from pjbbh5.prod.google.com ([2002:a17:90b:485:b0:33d:ee1f:6fb7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5628:b0:340:a961:80c9
 with SMTP id 98e67ed59e1d1-341a6dec5e6mr5732161a91.30.1762389244818; Wed, 05
 Nov 2025 16:34:04 -0800 (PST)
Date: Thu,  6 Nov 2025 00:32:40 +0000
In-Reply-To: <20251106003357.273403-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106003357.273403-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/6] tcp: Call tcp_syn_ack_timeout() directly.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since DCCP has been removed, we do not need to use
request_sock_ops.syn_ack_timeout().

Let's call tcp_syn_ack_timeout() directly.

Now other function pointers of request_sock_ops are
protocol-dependent.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/request_sock.h      | 1 -
 net/ipv4/inet_connection_sock.c | 4 +++-
 net/ipv4/tcp_ipv4.c             | 1 -
 net/ipv4/tcp_timer.c            | 3 +--
 net/ipv6/tcp_ipv6.c             | 1 -
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index cd4d4cf71d0d..9b9e04f6bb89 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -36,7 +36,6 @@ struct request_sock_ops {
 				      struct sk_buff *skb,
 				      enum sk_rst_reason reason);
 	void		(*destructor)(struct request_sock *req);
-	void		(*syn_ack_timeout)(const struct request_sock *req);
 };
 
 struct saved_syn {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 3b83b66b2284..6a86c1ac3011 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1096,9 +1096,11 @@ static void reqsk_timer_handler(struct timer_list *t)
 			young <<= 1;
 		}
 	}
+
 	syn_ack_recalc(req, max_syn_ack_retries, READ_ONCE(queue->rskq_defer_accept),
 		       &expire, &resend);
-	req->rsk_ops->syn_ack_timeout(req);
+	tcp_syn_ack_timeout(req);
+
 	if (!expire &&
 	    (!resend ||
 	     !tcp_rtx_synack(sk_listener, req) ||
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 40a76da5364a..3de3b4638914 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1660,7 +1660,6 @@ struct request_sock_ops tcp_request_sock_ops __read_mostly = {
 	.send_ack	=	tcp_v4_reqsk_send_ack,
 	.destructor	=	tcp_v4_reqsk_destructor,
 	.send_reset	=	tcp_v4_send_reset,
-	.syn_ack_timeout =	tcp_syn_ack_timeout,
 };
 
 const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 2dd73a4e8e51..0672c3d8f4f1 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -458,7 +458,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int max_retries;
 
-	req->rsk_ops->syn_ack_timeout(req);
+	tcp_syn_ack_timeout(req);
 
 	/* Add one more retry for fastopen.
 	 * Paired with WRITE_ONCE() in tcp_sock_set_syncnt()
@@ -752,7 +752,6 @@ void tcp_syn_ack_timeout(const struct request_sock *req)
 
 	__NET_INC_STATS(net, LINUX_MIB_TCPTIMEOUTS);
 }
-EXPORT_IPV6_MOD(tcp_syn_ack_timeout);
 
 void tcp_reset_keepalive_timer(struct sock *sk, unsigned long len)
 {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 06eb90e4078e..1bea011ff717 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -796,7 +796,6 @@ struct request_sock_ops tcp6_request_sock_ops __read_mostly = {
 	.send_ack	=	tcp_v6_reqsk_send_ack,
 	.destructor	=	tcp_v6_reqsk_destructor,
 	.send_reset	=	tcp_v6_send_reset,
-	.syn_ack_timeout =	tcp_syn_ack_timeout,
 };
 
 const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
-- 
2.51.2.1026.g39e6a42477-goog


