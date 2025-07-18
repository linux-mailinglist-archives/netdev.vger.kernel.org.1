Return-Path: <netdev+bounces-208207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7AFB0A95E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D30A41FE3
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111D2E7171;
	Fri, 18 Jul 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxMwMO0w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7531C7017
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859546; cv=none; b=tm6yAWLPPVISXgRJWf9C/O+fiDoe1fncgsfOSNE6fA1UPXr29InAldT4J+kjJwRFUp4HxeX8cuBZ+N3kV7pAdirPkw9OFedpsZVvCbPAmJ+UFHfxxc4UVLvoNusU9kCTgjHCd68YhM5gGZ3VGCixrDe48onoLssd8ftp+Hweu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859546; c=relaxed/simple;
	bh=c8dR5IZiYjEpOHpXVT+lccuXbYqVyPdyyciqTdGyPP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heZnxhkHbXiAzX28lAzsyc3HQZw72Qsb21Foav8YxQjDvcvPXdEMQoz/MjK1C3NKM/VnzhHb3+tDubOy2yzO51rNcDUF74EHMuk+wDEpFHz66F5exeChX2fgf6Qxge+OyO3jMpxfSl8We/JVeVY2eSb29LoZA6PsGoUAuZADEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxMwMO0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752859541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dvlbKmSns3n4/H902vQs0IWi1iOjvbeV8Rx/MZFWUE=;
	b=KxMwMO0wRLnUYf0ir/9Mk6dp1ukYC3a/sVembqVGkM6xXD+py1nhcCh6wt77rRkVHiUuSu
	OQV55PXxkqYhPQ/A+MErKCFIaB/Xu90uTcgAUBDjfdXFOeGVyZt8nQuSv0aaHHUtdHqSdj
	7VZjo8PwrG6G117nEwpio3dq5M5v7WU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-8vaMj4J5NFGWRx4rp09a9Q-1; Fri,
 18 Jul 2025 13:25:36 -0400
X-MC-Unique: 8vaMj4J5NFGWRx4rp09a9Q-1
X-Mimecast-MFC-AGG-ID: 8vaMj4J5NFGWRx4rp09a9Q_1752859534
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FB461800366;
	Fri, 18 Jul 2025 17:25:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF963180035E;
	Fri, 18 Jul 2025 17:25:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
Date: Fri, 18 Jul 2025 19:25:12 +0200
Message-ID: <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
In-Reply-To: <cover.1752859383.git.pabeni@redhat.com>
References: <cover.1752859383.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The nipa CI is reporting frequent failures in the mptcp_connect
self-tests.

In the failing scenarios (TCP -> MPTCP) the involved sockets are
actually plain TCP ones, as fallback for passive socket at 2whs
time cause the MPTCP listener to actually create a TCP socket.

The transfer is stuck due to the receiver buffer being zero.
With the stronger check in place, tcp_clamp_window() can be invoked
while the TCP socket has sk_rmem_alloc == 0, and the receive buffer
will be zeroed, too.

Pass to tcp_clamp_window() even the current skb truesize, so that
such helper could compute and use the actual limit enforced by
the stack.

Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp_input.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 672cbfbdcec1..c98de02a3c57 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock *sk)
 }
 
 /* 4. Recalculate window clamp after socket hit its memory bounds. */
-static void tcp_clamp_window(struct sock *sk)
+static void tcp_clamp_window(struct sock *sk, int truesize)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct net *net = sock_net(sk);
-	int rmem2;
+	int rmem2, needed;
 
 	icsk->icsk_ack.quick = 0;
 	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
+	needed = atomic_read(&sk->sk_rmem_alloc) + truesize;
 
 	if (sk->sk_rcvbuf < rmem2 &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
 	    !tcp_under_memory_pressure(sk) &&
 	    sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)) {
-		WRITE_ONCE(sk->sk_rcvbuf,
-			   min(atomic_read(&sk->sk_rmem_alloc), rmem2));
+		WRITE_ONCE(sk->sk_rcvbuf, min(needed, rmem2));
 	}
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+	if (needed > sk->sk_rcvbuf)
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U * tp->advmss);
 }
 
@@ -5552,7 +5552,7 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);
 
 	if (!tcp_can_ingest(sk, in_skb))
-		tcp_clamp_window(sk);
+		tcp_clamp_window(sk, in_skb->truesize);
 	else if (tcp_under_memory_pressure(sk))
 		tcp_adjust_rcv_ssthresh(sk);
 
-- 
2.50.0


