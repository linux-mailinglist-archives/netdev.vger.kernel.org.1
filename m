Return-Path: <netdev+bounces-119980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76934957C18
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA441C22A95
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD8D3A1DA;
	Tue, 20 Aug 2024 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="wEKVX1Fm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220739AD6
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125874; cv=none; b=ERFhLwwxACKnGGZJNmwSmywcTsSCthpoapEYNlfivSFpTEDIM3aFljzQ/KFRS4ixzj9+vL/pDADZnRqm2Wp2QwPhsHfMU/TvF1dCT3TxrQelRkmu+7WUlBttfVewClIbyRoYoFTFTkoUFUPOOjnyD2iW6649vQZyBs2wa8eVGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125874; c=relaxed/simple;
	bh=xrpOkY7XIDD94mTGQ+Gc7UeOPt/W+Nkltxv/+xmKjYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiNnQs0I8uo+I7DGpJO7BppWjApXitJjbxXsCNPzZalUh/xFxcuE0RwK5hS1G7+cjwLMTVaWio3ANAGzJ9BoX0mLWfkzlvqrgoeEbOEwYzrXGDePX9axLihLFC3GtcH2MHUhHrgbUj+m45wsMDPsmjpPqbjiLIkeelZ0RUDarGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=wEKVX1Fm; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1724125869; x=1755661869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jkjjceUGdKUOF+bM8ANMLtvyrcmkDeIY7OqLCUcCEsc=;
  b=wEKVX1FmzZx+Jjd4wCr5QtgT6ZPadRwLfGBoWJZGmkxTAnb1bMEJhtky
   TmylfmukfNnwP1fpKRCkB7P1O6E2cBiiQs/Ay2WyW6tn4OT3q1XZHIx4X
   /M9xTEW8eKqHcEvtzHUl9ancVMNfRjSpraESE1d4bmzi2ZfnscBloJ4De
   c=;
X-IronPort-AV: E=Sophos;i="6.10,160,1719878400"; 
   d="scan'208";a="445390513"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:50:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:57014]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.18:2525] with esmtp (Farcaster)
 id 76894b81-1c0b-4484-9067-4d7c99dbdb40; Tue, 20 Aug 2024 03:50:56 +0000 (UTC)
X-Farcaster-Flow-ID: 76894b81-1c0b-4484-9067-4d7c99dbdb40
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 20 Aug 2024 03:50:55 +0000
Received: from 682f678c4465.ant.amazon.com (10.119.0.197) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 20 Aug 2024 03:50:52 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Takamitsu Iwai
	<takamitz@amazon.co.jp>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 2/2] tcp: Don't recv() OOB twice.
Date: Tue, 20 Aug 2024 12:49:20 +0900
Message-ID: <20240820034920.77419-3-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240820034920.77419-1-takamitz@amazon.co.jp>
References: <20240820034920.77419-1-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D005ANA004.ant.amazon.com (10.37.240.178)

commit 36893ef0b661 ("af_unix: Don't stop recv() at consumed ex-OOB
skb.") finds a bug that TCP reads OOB which has been already recv()ed.

This bug is caused because current TCP code does not have a process to
check and skip consumed OOB data. So OOB exists until it is recv()ed
even if it is already consumed through recv() with MSG_OOB option.

We add code to check and skip consumed OOB when reading skbs.

In this patch, we introduce urg_skb in tcp_sock to keep track of skbs
containing consumed OOB. We make tcp_try_coalesce() avoid coalescing skb to
urg_skb to locate OOB data at the last byte of urg_skb.

I tried not to modify tcp_try_coalesce() by decrementing end_seq when
OOB data is recv()ed. But this hack does not work when OOB data is at
the middle of skb by coalescing OOB and normal skbs. Also, when the
next OOB data comes in, we’ll lose the seq# of the consumed OOB to
skip during the normal recv().

Consequently, the code to prevent coalescing is now located within
tcp_try_coalesce().

This patch enables TCP to pass msg_oob selftests when removing
tcp_incompliant braces in inline_oob_ahead_break and
ex_oob_ahead_break tests.

 #  RUN           msg_oob.no_peek.ex_oob_ahead_break ...
 #            OK  msg_oob.no_peek.ex_oob_ahead_break
 ok 11 msg_oob.no_peek.ex_oob_ahead_break
 #  RUN           msg_oob.no_peek.inline_oob_ahead_break ...
 #            OK  msg_oob.no_peek.inline_oob_ahead_break
 ok 15 msg_oob.no_peek.inline_oob_ahead_break

We will rewrite existing other code to use urg_skb and remove urg_data
and urg_seq, which have the same functionality as urg_skb

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
---
 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             |  3 ++-
 net/ipv4/tcp.c                                | 15 ++++++++++-----
 net/ipv4/tcp_input.c                          |  5 +++++
 tools/testing/selftests/net/af_unix/msg_oob.c | 10 ++--------
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..63234e8680e3 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -243,6 +243,7 @@ struct tcp_sock {
 	struct  minmax rtt_min;
 	/* OOO segments go in this rbtree. Socket lock must be held. */
 	struct rb_root	out_of_order_queue;
+	struct sk_buff *urg_skb;
 	u32	snd_ssthresh;	/* Slow start size threshold		*/
 	u8	recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
 	__cacheline_group_end(tcp_sock_read_rx);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2aac11e7e1cc..4eb0929c0744 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -961,7 +961,8 @@ struct tcp_skb_cb {
 	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
 			eor:1,		/* Is skb MSG_EOR marked? */
 			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
-			unused:5;
+			consumed_urg:1, /* urg data in SKB has already read */
+			unused:4;
 	__u32		ack_seq;	/* Sequence number ACK'd	*/
 	union {
 		struct {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..463e89849d6d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1402,8 +1402,10 @@ static int tcp_recv_urg(struct sock *sk, struct msghdr *msg, int len, int flags)
 		msg->msg_flags |= MSG_OOB;
 
 		if (len > 0) {
-			if (!(flags & MSG_TRUNC))
+			if (!(flags & MSG_TRUNC)) {
 				err = memcpy_to_msg(msg, &c, 1);
+				TCP_SKB_CB(tp->urg_skb)->consumed_urg = true;
+			}
 			len = 1;
 		} else
 			msg->msg_flags |= MSG_TRUNC;
@@ -2491,11 +2493,13 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			used = len;
 
 		/* Do we have urgent data here? */
-		if (unlikely(tp->urg_data)) {
-			u32 urg_offset = tp->urg_seq - *seq;
+		if (unlikely(tp->urg_skb == skb || TCP_SKB_CB(skb)->consumed_urg)) {
+			u32 urg_offset = TCP_SKB_CB(skb)->end_seq - *seq - 1;
+
 			if (urg_offset < used) {
 				if (!urg_offset) {
-					if (!sock_flag(sk, SOCK_URGINLINE)) {
+					if (!sock_flag(sk, SOCK_URGINLINE) ||
+					    TCP_SKB_CB(skb)->consumed_urg) {
 						WRITE_ONCE(*seq, *seq + 1);
 						urg_hole++;
 						offset++;
@@ -2530,6 +2534,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 skip_copy:
 		if (unlikely(tp->urg_data) && after(tp->copied_seq, tp->urg_seq)) {
 			WRITE_ONCE(tp->urg_data, 0);
+			tp->urg_skb = NULL;
 			tcp_fast_path_check(sk);
 		}
 
@@ -4726,7 +4731,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rtt_min);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, out_of_order_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssthresh);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 69);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 77);
 
 	/* TX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, segs_out);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 648d0f3ade78..47eb7b7f31c4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4851,6 +4851,10 @@ static bool tcp_try_coalesce(struct sock *sk,
 
 	*fragstolen = false;
 
+	/* avoid coalescing to urgent skb since last byte is OOB data*/
+	if (tcp_sk(sk)->urg_skb)
+		return false;
+
 	/* Its possible this segment overlaps with prior segment in queue */
 	if (TCP_SKB_CB(from)->seq != TCP_SKB_CB(to)->end_seq)
 		return false;
@@ -5857,6 +5861,7 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 			if (skb_copy_bits(skb, ptr, &tmp, 1))
 				BUG();
 			WRITE_ONCE(tp->urg_data, TCP_URG_VALID | tmp);
+			tp->urg_skb = skb;
 			if (!sock_flag(sk, SOCK_DEAD))
 				sk->sk_data_ready(sk);
 		}
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index f3435575dfa5..3eee7930b6ed 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -534,10 +534,7 @@ TEST_F(msg_oob, ex_oob_ahead_break)
 	epollpair(true);
 	siocatmarkpair(false);
 
-	tcp_incompliant {
-		recvpair("hellowol", 8, 10, 0);	/* TCP recv()s "helloworl", why "r" ?? */
-	}
-
+	recvpair("hellowol", 8, 10, 0);
 	epollpair(true);
 	siocatmarkpair(true);
 
@@ -623,10 +620,7 @@ TEST_F(msg_oob, inline_oob_ahead_break)
 	epollpair(false);
 	siocatmarkpair(true);
 
-	tcp_incompliant {
-		recvpair("world", 5, 6, 0);	/* TCP recv()s "oworld", ... "o" ??? */
-	}
-
+	recvpair("world", 5, 6, 0);
 	epollpair(false);
 	siocatmarkpair(false);
 }
-- 
2.39.3 (Apple Git-145)


