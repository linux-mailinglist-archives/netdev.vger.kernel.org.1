Return-Path: <netdev+bounces-229859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF4BE1677
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC40119C658A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14521C9F4;
	Thu, 16 Oct 2025 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0fZWsAj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD321ABDC
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760587329; cv=none; b=hZzGZeaJFhkErY4odC/RK5gn8i4/zGnVyIa8v2cO5I5oSS8vrXzzPPmd/2PQKEj0hKKrdQWtGDKe0Er7RfpfnFh9JeIyEKAup3/M4R5+7fUGNrEACnvEwePbnvPs/4xTUKQmzd6lmuu4GV3K8bjDUFlwNHqeGJIFdCKwN73mwto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760587329; c=relaxed/simple;
	bh=MF2n+IKe3tADmIedNKV9tfQUBADOLt5HROaYCQdo8rQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GAT6u20rJJI17VRy7oIHAjNEBiNs6ZlBJ95MHBy30+crYN6DEevUQjQpU+oiqx1tjlfiwpVXz6sU0YDJYrlMtQTPWU10w679tJuMA2k427JckjiOOH82PSzmE8BM2Zo4Frd97cTIaj90iudBGXygFVCyp46/6zTOI8TVbK6QGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0fZWsAj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-781253de15aso716085b3a.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760587327; x=1761192127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1NZalNTpg8jtC8hWAxha6N7SB00NZDqvULTCnGS9QA=;
        b=a0fZWsAjRVUamvfeqhLEe/dr9hPmOa4bgDUOK7ev5zxMubjvH8yeEI7QRNFuyTLcD8
         YmDTl+1buyEXLhWnJJK/H2EMqs1zOYVwYspq802yqIn04TD5I3X6h963aoiBVSwQxvJB
         xIfhK2shgyN4olXE7F1P6YbO0LjR0J8WhDAZPoAHZJIcqxIt2DULbDaMz+Sk4iNsAiTP
         XkCTh3tlRL+s0/D41t1iQzLQOMZvz0kX8MLFRSWWt6A7LErl/1reB/5j401smVoefnHj
         AvATv6iC4/bQk8ZC514JxeyVL7X4SpBMgSqGHTt3/N9WZux6RiH0x6i6SPYwkIGPjtCT
         CukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760587327; x=1761192127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1NZalNTpg8jtC8hWAxha6N7SB00NZDqvULTCnGS9QA=;
        b=aNR15OmRqM/PBhd37q8lMwCBeqKeSfELN3oNwmTUl9qJHbBSmPOmto4a9zMYps7/aJ
         ZECLKOAl0J0Uqlid0/KYhJb3r5ZeFBwTMpkcZPR3yqJLgywerpMO286FB7kTIGvaWXUe
         hZjG2lC19VJsfc6qnz1uvqnf4+jFjZjHT+epR9ji1VT46r4MDdkEckCOfoNtzj2Z7JjN
         KgNl30QHwISBZFeOVNc0B5soYS/G0jCTR/8k5FDe8hDA6mdlVOwEUbCsDOKIMmO9ibZ2
         5wiTDnAewrjdaC8crQ+pDtzV7q1linsd2zmJN58lhTlNBKpO91m6A484VPB75yKUXr6+
         s9vw==
X-Forwarded-Encrypted: i=1; AJvYcCVczUup2SgTmu6Xv2v4eWNbu3NNg+uyKpmBb6BD93/8IpzBKi/jRtsrRIk+jne23Yqy9BdCW3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3WL8inawEwJtEibnlPYEJtECrFm7IjtLuBLHm6nzgdGMuGIvO
	mS74D2NO1epdLLPKRMfywtx3Ewa7q9wCj9Mfd/MSD8PuVfF4PjHfDfWlVoj5xxHuGghZJ0De50U
	af4Wrtg==
X-Google-Smtp-Source: AGHT+IF5YuOvaSskOG5iQaGXZeR/byVzBT1/H4MkgxcujjTScT46jjqiNWLsxeTL0JefMCtsHUAjJnNwkUc=
X-Received: from pfhs26.prod.google.com ([2002:a62:e71a:0:b0:7a2:11cb:da15])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17aa:b0:783:cb49:c67b
 with SMTP id d2e1a72fcca58-79387d0f40fmr40673502b3a.32.1760587326282; Wed, 15
 Oct 2025 21:02:06 -0700 (PDT)
Date: Thu, 16 Oct 2025 04:00:35 +0000
In-Reply-To: <20251016040159.3534435-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251016040159.3534435-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/4] tcp: Don't acknowledge SYN+ACK payload to TFO
 fallback client.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, SYN+ACK payload is acknowledged and queued even for a TFO
fallback client, which did not send SYN with payload.

For example, this packetdrill script does not fail, even though the
server does not send a TFO cookie.

   0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
  +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
  +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
  +0 < S. 0:1000(1000) ack 1 win 5840 <mss 1040,nop,nop,sackOK,nop,wscale 6>
  +0 > . 1:1(0) ack 1001       // should be ack 1
  +0 read(3, ..., 1000) = 1000 // should fail with -EAGAIN

This is because tcp_rcv_fastopen_synack(), which handles SYN+ACK for
both TFO client and TFO fallback client, calls tcp_fastopen_add_skb()
unconditionally.

RFC 7413 (TCP Fast Open), in Section 3. Protocol Overview [0], states
that the SYN+ACK payload is only allowed when the server acknowledges
SYN data:

   3. If the server accepts the data in the SYN packet, it may send the
      response data before the handshake finishes.

Let's not call tcp_fastopen_add_skb() when the client did not send
SYN with payload.

Note that Linux does not send SYN+ACK with payload but FreeBSD
could as mentioned in the commit below. [1]

Link: https://datatracker.ietf.org/doc/html/rfc7413#section-3 #[0]
Link: https://cgit.freebsd.org/src/commit/?id=3f43239f21e357246696f1e8675178881d9ed5bc #[1]
Fixes: 61d2bcae99f66 ("tcp: fastopen: accept data/FIN present in SYNACK message")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8fc97f4d8a6b2..e1d3066782b57 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6552,6 +6552,9 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 
 	tcp_fastopen_cache_set(sk, mss, cookie, syn_drop, try_exp);
 
+	if (!tp->syn_data)
+		return false;
+
 	if (data) { /* Retransmit unacked data in SYN */
 		if (tp->total_retrans)
 			tp->fastopen_client_fail = TFO_SYN_RETRANSMITTED;
@@ -6564,16 +6567,14 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 				LINUX_MIB_TCPFASTOPENACTIVEFAIL);
 		return true;
 	}
-	tp->syn_data_acked = tp->syn_data;
-	if (tp->syn_data_acked) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENACTIVE);
-		/* SYN-data is counted as two separate packets in tcp_ack() */
-		if (tp->delivered > 1)
-			--tp->delivered;
-	}
 
-	tcp_fastopen_add_skb(sk, synack);
+	/* SYN-data is counted as two separate packets in tcp_ack() */
+	if (tp->delivered > 1)
+		--tp->delivered;
 
+	tp->syn_data_acked = 1;
+	tcp_fastopen_add_skb(sk, synack);
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENACTIVE);
 	return false;
 }
 
-- 
2.51.0.788.g6d19910ace-goog


