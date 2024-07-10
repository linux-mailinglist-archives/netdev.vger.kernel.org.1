Return-Path: <netdev+bounces-110614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7C92D746
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8BE2B21111
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51AA1953BE;
	Wed, 10 Jul 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sSDPqVsp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB534545
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631614; cv=none; b=TbrXogzMKwTut049Hax/M+jx/+DxQN2epvU2Rt4N60HUYgxhYyT5iivrCnAjgki7urIAM/ylkYskUKMHMzH3OXqjhsNQINZ5OnbDyN+vQiwb8nUgSB99HMaZ1y1TcuLpq46pl+IbGqSDcSx9bIDmGEHu4xf8lPkyeBOktIropb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631614; c=relaxed/simple;
	bh=WVTNlL61FZRK12oiQzJCuNGMlZ48P87XRDRfdN8tJXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GL1eQDY/AdjuAweseEPa7QOAyHCu+DPNSJb0/1x+U9aatPh/713kgvtsuloKgwBu5yjovuBQDuwA+X3bGpZTJa9tONI4Zi0gAINZQFc1xOCDMjL2ECCTP+SpjFeCrRlv+lurUznJ1hd5LRAfKKWBAUpCRlCJPaKsciaT1gyXahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sSDPqVsp; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720631613; x=1752167613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vwtF4Yf8UOkTqy44iTcUo6gg5bK1izSRFP3HjHHqDXY=;
  b=sSDPqVspJRwKUveoJrU6lwvSxwrkhUSkkF/AeT/n4Elft9EkJsQgqdTF
   lKJAyyrfQEPBNpLRi7teTwJT4IMh5Krb1HWdyTJ2AT7e9Lisz1CPouLqc
   AQ3uVSyZLuO4t7dDd98ju73VkoN8OkDax3q/1VsCMnDhBZMZ5a1t04BK7
   s=;
X-IronPort-AV: E=Sophos;i="6.09,198,1716249600"; 
   d="scan'208";a="104391639"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:13:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:18989]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.123:2525] with esmtp (Farcaster)
 id 9783cb74-58e5-4f32-9837-809e2886d0f2; Wed, 10 Jul 2024 17:13:29 +0000 (UTC)
X-Farcaster-Flow-ID: 9783cb74-58e5-4f32-9837-809e2886d0f2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 17:13:27 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 17:13:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 1/2] tcp: Don't drop SYN+ACK for simultaneous connect().
Date: Wed, 10 Jul 2024 10:12:45 -0700
Message-ID: <20240710171246.87533-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240710171246.87533-1-kuniyu@amazon.com>
References: <20240710171246.87533-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

RFC 9293 states that in the case of simultaneous connect(), the connection
gets established when SYN+ACK is received. [0]

      TCP Peer A                                       TCP Peer B

  1.  CLOSED                                           CLOSED
  2.  SYN-SENT     --> <SEQ=100><CTL=SYN>              ...
  3.  SYN-RECEIVED <-- <SEQ=300><CTL=SYN>              <-- SYN-SENT
  4.               ... <SEQ=100><CTL=SYN>              --> SYN-RECEIVED
  5.  SYN-RECEIVED --> <SEQ=100><ACK=301><CTL=SYN,ACK> ...
  6.  ESTABLISHED  <-- <SEQ=300><ACK=101><CTL=SYN,ACK> <-- SYN-RECEIVED
  7.               ... <SEQ=100><ACK=301><CTL=SYN,ACK> --> ESTABLISHED

However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such a
SYN+ACK is dropped in tcp_validate_incoming() and responded with Challenge
ACK.

For example, the write() syscall in the following packetdrill script fails
with -EAGAIN, and wrong SNMP stats get incremented.

   0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
  +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)

  +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
  +0 < S  0:0(0) win 1000 <mss 1000>
  +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscale 8>
  +0 < S. 0:0(0) ack 1 win 1000

  +0 write(3, ..., 100) = 100
  +0 > P. 1:101(100) ack 1

  --

  # packetdrill cross-synack.pkt
  cross-synack.pkt:13: runtime error in write call: Expected result 100 but got -1 with errno 11 (Resource temporarily unavailable)
  # nstat
  ...
  TcpExtTCPChallengeACK           1                  0.0
  TcpExtTCPSYNChallenge           1                  0.0

The problem is that bpf_skops_established() is triggered by the Challenge
ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
check if the peer supports a TCP option that is expected to be exchanged
in SYN and SYN+ACK.

Let's accept a bare SYN+ACK for active-open TCP_SYN_RECV sockets to avoid
such a situation.

Note that tcp_ack_snd_check() in tcp_rcv_state_process() is skipped not to
send an unnecessary ACK, but this could be a bit risky for net.git, so this
targets for net-next.

Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 47dacb575f74..1eddb6b9fb2a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5989,6 +5989,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
+		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
+		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
+		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
+		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
+			goto pass;
 syn_challenge:
 		if (syn_inerr)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
@@ -5998,6 +6003,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		goto discard;
 	}
 
+pass:
 	bpf_skops_parse_hdr(sk, skb);
 
 	return true;
@@ -6804,6 +6810,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tcp_fast_path_on(tp);
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
+
+		if (sk->sk_socket)
+			goto consume;
 		break;
 
 	case TCP_FIN_WAIT1: {
-- 
2.30.2


