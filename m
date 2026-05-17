Return-Path: <netdev+bounces-288765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP4dHcgNCmqPwQQAu9opvQ
	(envelope-from <netdev+bounces-288765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38505635C8
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB1AD3006B47
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD79A3D3306;
	Sun, 17 May 2026 18:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246553D1CB1;
	Sun, 17 May 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043699; cv=none; b=n23bXVlJWdt8EH26eC9aloMzZKgSNu9aa1vFyMy47UzWqI2NRPiKrYkRsJG/ogqYSh5nXMPlZX1oXGCe6FaqighJLvvqNSEY4l+xkruCSyUFqtb1QXf6KnTJ9om38m5ZIHhE/bhb/mTXwBIwv33Q0ZjYvk0vAJRjneHKVgU0V+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043699; c=relaxed/simple;
	bh=fI26Y5U4Ia4oGDKWxYsJZYTJ4HXI5HkCkxk3KlTwKik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIvL9wdLFWe/y4k5nfP5tHRW96d7Rmzpu/EabRgfKARNBtgdH4cET+e12ekentB5ZyoheudykUWphPh2W9+ChYgDflFb/CdDqPRXDZk+LBsfiMUmj1+Uoo2eXCWW91++JEbj6KErUU9Crxrrm/s+7oWWWHZCpdrCRBU4Q5T5Y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id CCE2E5A061A; Sun, 17 May 2026 20:41:58 +0200 (CEST)
From: Stefano Brivio <sbrivio@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Emelyanov <xemul@scylladb.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Dmitry Safonov <dima@arista.com>,
	Andrei Vagin <avagin@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net 1/2] tcp: Don't accept data when socket is in repair mode
Date: Sun, 17 May 2026 20:41:57 +0200
Message-ID: <20260517184158.2757505-2-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517184158.2757505-1-sbrivio@redhat.com>
References: <20260517184158.2757505-1-sbrivio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D38505635C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[redhat.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288765-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Once a socket enters repair mode (TCP_REPAIR socket option with
TCP_REPAIR_ON value), it's possible to dump the receive sequence
number (TCP_QUEUE_SEQ) and the contents of the receive queue itself
(using TCP_REPAIR_QUEUE to select it).

If we receive data after the application fetched the sequence number
or saved the contents of the queue, though, the application will now
have outdated information, which defeats the whole functionality,
because this leads to gaps in sequence and data once they're restored
by the target instance of the application, resulting in a hanging or
otherwise non-functional TCP connection.

This type of race condition was discovered in the KubeVirt integration
of passt(1), using a remote iperf3 client connected to an iperf3
server running in the guest which is being migrated. The setup allows
traffic to reach the origin node hosting the guest during the
migration.

If passt dumps sequence number and contents of the queue *before*
further data is received and acknowledged to the peer by the kernel,
once the TCP data connection is migrated to the target node, the
remote client becomes unable to continue sending, because a portion
of the data it sent *and received an acknowledgement for* is now lost.

Schematically:

1. client --seq 1:100--> origin host --> passt --> guest --> server

2. client <--ACK: 100-- origin host

3. migration starts, passt enables repair mode, dumps the sequence
   number (101) and sends it to the target node of the guest migration

4. client --seq 101:201--> origin host (passt not receiving anymore)

5. client <--ACK: 201-- origin host

6. migration completes, and passt restores sequence number 101 on the
   migrated socket

7. client --seq 201:301--> target host (now seeing a sequence jump)

8. client <--ACK: 100-- target host

...and the connection can't recover anymore, because the client can't
resend data that was already (erroneously) acknowledged. We need to
avoid step 5. above.

This would equally affect CRIU (the other known user of TCP_REPAIR),
should data be received while the original container is frozen: the
sequence dumped and the contents of the saved incoming queue would
then depend on the timing.

The race condition is also illustrated in the kselftests introduced
by the next patch.

To prevent this issue, discard data received for a socket in repair
mode, with a new reason, SKB_DROP_REASON_SOCKET_REPAIR.

Fixes: ee9952831cfd ("tcp: Initial repair mode")
Tested-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 include/net/dropreason-core.h |  3 +++
 net/ipv4/tcp_input.c          | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 2f312d1f67d6..19ab9e6ffc33 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -9,6 +9,7 @@
 	FN(SOCKET_CLOSE)		\
 	FN(SOCKET_FILTER)		\
 	FN(SOCKET_RCVBUFF)		\
+	FN(SOCKET_REPAIR)		\
 	FN(UNIX_DISCONNECT)		\
 	FN(UNIX_SKIP_OOB)		\
 	FN(PKT_TOO_SMALL)		\
@@ -158,6 +159,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
+	/** @SKB_DROP_REASON_SOCKET_REPAIR: socket is in repair mode */
+	SKB_DROP_REASON_SOCKET_REPAIR,
 	/**
 	 * @SKB_DROP_REASON_UNIX_DISCONNECT: recv queue is purged when SOCK_DGRAM
 	 * or SOCK_SEQPACKET socket re-connect()s to another socket or notices
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9760..6eca34274f97 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6457,6 +6457,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
  *	  or pure receivers (this means either the sequence number or the ack
  *	  value must stay constant)
  *	- Unexpected TCP option.
+ *	- Socket is in repair mode.
  *
  *	When these conditions are not satisfied it drops into a standard
  *	receive procedure patterned after RFC793 to handle all cases.
@@ -6506,7 +6507,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 
 	if ((tcp_flag_word(th) & TCP_HP_BITS) == tp->pred_flags &&
 	    TCP_SKB_CB(skb)->seq == tp->rcv_nxt &&
-	    !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
+	    !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt) &&
+	    !tp->repair) {
 		int tcp_header_len = tp->tcp_header_len;
 		s32 delta = 0;
 		int flag = 0;
@@ -6632,6 +6634,11 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		goto discard;
 	}
 
+	if (tp->repair) {
+		reason = SKB_DROP_REASON_SOCKET_REPAIR;
+		goto discard;
+	}
+
 	/*
 	 *	Standard slow path.
 	 */
@@ -7125,6 +7132,11 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	int queued = 0;
 	SKB_DR(reason);
 
+	if (tp->repair) {
+		SKB_DR_SET(reason, SOCKET_REPAIR);
+		goto discard;
+	}
+
 	switch (sk->sk_state) {
 	case TCP_CLOSE:
 		SKB_DR_SET(reason, TCP_CLOSE);
-- 
2.43.0


