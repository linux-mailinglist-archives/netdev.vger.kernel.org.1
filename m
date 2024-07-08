Return-Path: <netdev+bounces-109965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6892A8BA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F9A8B2147D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF714388F;
	Mon,  8 Jul 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GKGyqLmv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02918143863
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462182; cv=none; b=Hx85YKoui6KdSvRIkKR9DISDVDZzFktY81yH+eM1Yo8LYqq1PU4O9i6G82UE/SkMU/7OUEnJrh6NgEraAWd7DmZYyADw8fRfh/iBn36gvY3F8hSDSOYuU39HUhEd+rH8EInSG+sts+8aO+7C+y3Qy30x9GU4/0eEcRkr4xYCQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462182; c=relaxed/simple;
	bh=kqNUrNudnbgSdUOQV0DtYdGTM5CKxlFGZ4sviKIYZxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGhqa3Fi48FOk9SJPAu3KDV7s8tS9Mp+PWnsUFGKV3PEa1+U5O1mdiva0pHodzXnhfVGhRq7d2vKlq48tYp1qUg+H8P1gtlG+EPGB0AyudqZQQAOjRKhgxPefqiS4AxVHe9ZqAzmaXB2dLzDjYXuVhn/WdOF0WiYE1aGCMnq9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GKGyqLmv; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720462181; x=1751998181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSycSkjbsRzpaGwYm8Un3DhphvqKEc/+tuJU+B5urms=;
  b=GKGyqLmvohgh9id8112y/9NabKYTqv5fp/9K6kJilT1R/O8xw1mSMDK+
   q8JWjn+K2oNAvygawVU/olnMWHc5a/AgXudtef9xvo7G9D3TownnkrMc8
   ak0pCPXnyiFdj/sobLhYyQZ6TGGlsBQdyxliyKlKj82NvQMcxhlC6w8sq
   s=;
X-IronPort-AV: E=Sophos;i="6.09,192,1716249600"; 
   d="scan'208";a="739079435"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:09:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:38116]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.189:2525] with esmtp (Farcaster)
 id 88a2824f-175d-480e-beb4-80a64428eda5; Mon, 8 Jul 2024 18:09:33 +0000 (UTC)
X-Farcaster-Flow-ID: 88a2824f-175d-480e-beb4-80a64428eda5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:09:31 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:09:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, Dmitry Safonov <dima@arista.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/2] tcp: Don't drop SYN+ACK for simultaneous connect().
Date: Mon, 8 Jul 2024 11:08:51 -0700
Message-ID: <20240708180852.92919-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240708180852.92919-1-kuniyu@amazon.com>
References: <20240708180852.92919-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
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

Let's accept a bare SYN+ACK for non-TFO TCP_SYN_RECV sockets to avoid such
a situation.

Note that tcp_ack_snd_check() in tcp_rcv_state_process() is skipped not to
send an unnecessary ACK, but this could be a bit risky for net.git, so this
targets for net-next.

Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 47dacb575f74..50984aedbc8b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5989,6 +5989,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
+		if (sk->sk_state == TCP_SYN_RECV && !tp->syn_fastopen && th->ack &&
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
+		if (!req)
+			goto consume;
 		break;
 
 	case TCP_FIN_WAIT1: {
-- 
2.30.2


