Return-Path: <netdev+bounces-219654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45810B4284E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8743581D4E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1B32ED40;
	Wed,  3 Sep 2025 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpfMhLM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBC19343B
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921698; cv=none; b=NRUzrus9MmGpNEYr3M40u+gHwf1EfgQMQ9TtZRQFpacLNdIY2dTMg0WkjIvipG/wnF8kmWVB9lexN2YH4k6qElFRSxuDwrkM5HE2ieIhuFuFG0UlUDnrVPo6B3y2wXbSvbY9IhUMN8TRr1V2WYO6JPVJgqzdbobHz+MmE7ugoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921698; c=relaxed/simple;
	bh=c4mp1P+AVhQChX8bvcyDr7A98eKYXWOZgDj6BeMFYCo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FjdHpOMTrl7cw1boE4eOcdMLU2knWbfyE+n6XZSfUSQ20X4UERD4m8irNqYHjT/yVRD7cre5+b+E4AmAdAcuRh3W3JhaocxFY3B9a9+R7wp/EvFOSzy3bTmN4jknhdi3C9zOyLEe8zOXRrbpf7AB4cK7CSA0gQzskRIbs+zXGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpfMhLM2; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b49715fdfbso4816561cf.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756921696; x=1757526496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vy9TngyXyqSloUyUMMVxxS/JAmJEYz2dOW30au4wF9Y=;
        b=zpfMhLM2DERqMlb51G/ojBaVy9onk92RVgauep/kyHl0aoU/Nw9OAt2CAejiwjy1DP
         kKcblWLOgXPL88PYvFkUrP0OZNTnRSdB2fRWK3otnk3WPeVZRcvtJQG3kLSidZLU1UF0
         cUPN3CdPDZWy22dNjs6B5cbxJjsxE5Ma1WWkuW7MXYmAk6ROPC+hZKEPeqSjqvivj8EW
         AfiefLjbkWBgHV3F8heoeQ8i7UYmYbpy6dZh3h5UUoqVTTnvi4XRmOq/iYfEXYQFFFet
         N2I98wqTDSRB0mpnK0ru0dDF78b1Vzyk6S+YPRTbtSnsUPQ1jFovCt9tDxzW/krVGl/d
         LEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756921696; x=1757526496;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vy9TngyXyqSloUyUMMVxxS/JAmJEYz2dOW30au4wF9Y=;
        b=QVpX2nZ2wsKGTa2Wv23KL060njUgoI59w7vOsBb+5l26EK8/U9GvpOv7QwNfhVfRic
         vPVIYcWYLHm1aSUPvftyMgam6htPEoG4gPv0imdT64Vi36y54A1Y6gvUgPSowee1wBk3
         XqRhdvpEhCJ79qfxOaYTZcHvtUlRNutmxQ6b4hbwwhN7dCcSFqzQn8ADkNKei18fVRQU
         8Z08kheaUESzF6LUkEtpVYT2h3RXcjyTY3M29loYcOZDDXVbxAWVjJ/XyJcRI9dnwFu6
         J5eJFG/gbzYAv6XejQkrx2xYmoT27vesAuYHte7IhsZBwc/NYK5a6mnomGzdwixIPEVE
         xXfA==
X-Forwarded-Encrypted: i=1; AJvYcCXfkf8LUpXBmRtkUohfEXBO7FI7vDMOi6Dw1nl4cwFTl2RjZnvSJMPEznUNDW0thgIfg4sKks8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCi6/Ktss5QCfcOSdKOnGl8X9fWv203u0ChoqPa2/qLbpFcF3s
	Khfmb/3qVFlQdUu70gZ80sdm5cazrptJ6niysBzPdARzHxJOQblYmIzjfnYq4c5QdXUW0H7l6AT
	sf3C07t82c9QzYw==
X-Google-Smtp-Source: AGHT+IFZaP11d/IsGmahtsp7YRCwSrbP6l1H4aDgjBRxpG2FXTB0kWUF+zJyaxtOgXDyIXEd7cYRBd5JK+skAQ==
X-Received: from qkbef1.prod.google.com ([2002:a05:620a:8081:b0:7f8:fedc:9cd6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr83391301cf.81.1756921695696;
 Wed, 03 Sep 2025 10:48:15 -0700 (PDT)
Date: Wed,  3 Sep 2025 17:48:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903174811.1930820-1-edumazet@google.com>
Subject: [PATCH net-next] net: call cond_resched() less often in __release_sock()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While stress testing TCP I had unexpected retransmits and sack packets
when a single cpu receives data from multiple high-throughput flows.

super_netperf 4 -H srv -T,10 -l 3000 &

Tcpdump extract:

 00:00:00.000007 IP6 clnt > srv: Flags [.], seq 26062848:26124288, ack 1, win 66, options [nop,nop,TS val 651460834 ecr 3100749131], length 61440
 00:00:00.000006 IP6 clnt > srv: Flags [.], seq 26124288:26185728, ack 1, win 66, options [nop,nop,TS val 651460834 ecr 3100749131], length 61440
 00:00:00.000005 IP6 clnt > srv: Flags [P.], seq 26185728:26243072, ack 1, win 66, options [nop,nop,TS val 651460834 ecr 3100749131], length 57344
 00:00:00.000006 IP6 clnt > srv: Flags [.], seq 26243072:26304512, ack 1, win 66, options [nop,nop,TS val 651460844 ecr 3100749141], length 61440
 00:00:00.000005 IP6 clnt > srv: Flags [.], seq 26304512:26365952, ack 1, win 66, options [nop,nop,TS val 651460844 ecr 3100749141], length 61440
 00:00:00.000007 IP6 clnt > srv: Flags [P.], seq 26365952:26423296, ack 1, win 66, options [nop,nop,TS val 651460844 ecr 3100749141], length 57344
 00:00:00.000006 IP6 clnt > srv: Flags [.], seq 26423296:26484736, ack 1, win 66, options [nop,nop,TS val 651460853 ecr 3100749150], length 61440
 00:00:00.000005 IP6 clnt > srv: Flags [.], seq 26484736:26546176, ack 1, win 66, options [nop,nop,TS val 651460853 ecr 3100749150], length 61440
 00:00:00.000005 IP6 clnt > srv: Flags [P.], seq 26546176:26603520, ack 1, win 66, options [nop,nop,TS val 651460853 ecr 3100749150], length 57344
 00:00:00.003932 IP6 clnt > srv: Flags [P.], seq 26603520:26619904, ack 1, win 66, options [nop,nop,TS val 651464844 ecr 3100753141], length 16384
 00:00:00.006602 IP6 clnt > srv: Flags [.], seq 24862720:24866816, ack 1, win 66, options [nop,nop,TS val 651471419 ecr 3100759716], length 4096
 00:00:00.013000 IP6 clnt > srv: Flags [.], seq 24862720:24866816, ack 1, win 66, options [nop,nop,TS val 651484421 ecr 3100772718], length 4096
 00:00:00.000416 IP6 srv > clnt: Flags [.], ack 26619904, win 1393, options [nop,nop,TS val 3100773185 ecr 651484421,nop,nop,sack 1 {24862720:24866816}], length 0

After analysis, it appears this is because of the cond_resched()
call from  __release_sock().

When current thread is yielding, while still holding the TCP socket lock,
it might regain the cpu after a very long time.

Other peer TLP/RTO is firing (multiple times) and packets are retransmit,
while the initial copy is waiting in the socket backlog or receive queue.

In this patch, I call cond_resched() only once every 16 packets.

Modern TCP stack now spends less time per packet in the backlog,
especially because ACK are no longer sent (commit 133c4c0d3717
"tcp: defer regular ACK while processing socket backlog")

Before:

clnt:/# nstat -n;sleep 10;nstat|egrep "TcpOutSegs|TcpRetransSegs|TCPFastRetrans|TCPTimeouts|Probes|TCPSpuriousRTOs|DSACK"
TcpOutSegs                      19046186           0.0
TcpRetransSegs                  1471               0.0
TcpExtTCPTimeouts               1397               0.0
TcpExtTCPLossProbes             1356               0.0
TcpExtTCPDSACKRecv              1352               0.0
TcpExtTCPSpuriousRTOs           114                0.0
TcpExtTCPDSACKRecvSegs          1352               0.0

After:

clnt:/# nstat -n;sleep 10;nstat|egrep "TcpOutSegs|TcpRetransSegs|TCPFastRetrans|TCPTimeouts|Probes|TCPSpuriousRTOs|DSACK"
TcpOutSegs                      19218936           0.0

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9a8290fcc35d..0a93443a7402 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3187,23 +3187,27 @@ void __release_sock(struct sock *sk)
 	__acquires(&sk->sk_lock.slock)
 {
 	struct sk_buff *skb, *next;
+	int nb = 0;
 
 	while ((skb = sk->sk_backlog.head) != NULL) {
 		sk->sk_backlog.head = sk->sk_backlog.tail = NULL;
 
 		spin_unlock_bh(&sk->sk_lock.slock);
 
-		do {
+		while (1) {
 			next = skb->next;
 			prefetch(next);
 			DEBUG_NET_WARN_ON_ONCE(skb_dst_is_noref(skb));
 			skb_mark_not_on_list(skb);
 			sk_backlog_rcv(sk, skb);
 
-			cond_resched();
-
 			skb = next;
-		} while (skb != NULL);
+			if (!skb)
+				break;
+
+			if (!(++nb & 15))
+				cond_resched();
+		}
 
 		spin_lock_bh(&sk->sk_lock.slock);
 	}
-- 
2.51.0.338.gd7d06c2dae-goog


