Return-Path: <netdev+bounces-106160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC40491505B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5C71F2274F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E819B5B6;
	Mon, 24 Jun 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTXd9+Bj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A519B59D
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240215; cv=none; b=FhyVif3Ev1ehIL3E0ZCOb02gNYgl98CgpPR+qigFp5QSEYu91QKbgtLBKkjm6eVAHq2NY6Vn7xszBa8K6UgNlA+mBbOzk3chzxFlYxBWWvZ4EOS3an948bLWO3ubvkf2mTMq47oFgX3bM2eyQI87jPiRHs5lXDm7j/NzNK18ZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240215; c=relaxed/simple;
	bh=vsPdBCfQJvroYxD/JgEA4rnCV3hKpFLduy6pDAi/hzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvGL7tdWL2UV33vZJDobYFzJr+TUgOls11KO9d79LvpHdjfUeWehKAaxNeJWZLpd2DfhMULJp3GqrQ88CAutVhh6gDYOz2FImrJpF0BTbJclhGYyrBIL26Yfy8+h1897Ztz3XTUELu0+ECKrhKk7z+Zc6dMqYyf+QKEfVt8/Sbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTXd9+Bj; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-48f4709e146so641441137.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719240213; x=1719845013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+q2rHRAzBOSl/+HWXJ9dAOppmZunisvEfc44hFVIfQ=;
        b=nTXd9+BjkQ1ggeGBIo8m2miNo2hE/EMc+QRfRrZtG921ZiBbW+85ztAaIE8HgEKf/O
         5YTcVJ6fNgDc+39PuF1TeP9ilxcvDDaggqG/lAc+c1SIT/rZB4oDxq6hpG4UXMmjGEFK
         GW+hLp4sWYqIh0Mx90kYGmckjzYGOtn1FpNRGuZMVzFa7Cp38vwKldgpx8lSwZ7d1hdo
         11LcslmApyvCNaZlsPq81OsfZhJpvRRzWk72KnykKLXX06y6Mbn3XERzHfwo0QmE+cWP
         SbvS8GimTrQawfMAruuy51m+6bmE0kKo4Tt1XEhQMU96aGGKxHaK9SP4T27ph19bj23m
         d1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240213; x=1719845013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+q2rHRAzBOSl/+HWXJ9dAOppmZunisvEfc44hFVIfQ=;
        b=n0pKvXMS5ToK58iSC65U1uLjMq2QLJ5Y3dPuJIPsNvQhxJX0okGe5EON+pH1Xkbr8j
         pMCxvkjLbzOdRmyS7lJw4hfBhOtXD4tol1ML3zKnnheDEsJJhUMiSEFdODmwmC3OkBSZ
         raEI1DBFbH2uixe1+y+Ri1S6RuUXgcdidxvv2CzzibxdeWvCb5RJ2HM8aURgIVqv2xpc
         56bSR3dgRazE8NPupegQh+6QApggIzmrn/VRi3uSCFFTFMBLAaj4HveQOBFpUvK/rtUJ
         UcDTZwcrlQinwr5ybvY1ivfJrdn+Cq9wkyjwXNKP/Arw+/0p+poGPftCVeMRQCdfUdp7
         YqAw==
X-Gm-Message-State: AOJu0Yznt/ux75BJlIYC2aidrYqLTuH08/WVz0LAAaysLwNpfjPcY2OL
	hod5IhU9jKoNHk9mkVDvfsWAhTaqVv6+JZswT8E0i8ePejBwKxrS
X-Google-Smtp-Source: AGHT+IFbrQnzd5xW8ulwF5sd2+4esrDnHvF2Y78HeLJ8bxOIda/Hq/Q5L8xdQzPp6JFKy9fXMf7ILg==
X-Received: by 2002:a05:6102:30ad:b0:48f:4b81:6583 with SMTP id ada2fe7eead31-48f529ce3eamr4114479137.2.1719240212984;
        Mon, 24 Jun 2024 07:43:32 -0700 (PDT)
Received: from ahoy.c.googlers.com.com (162.116.74.34.bc.googleusercontent.com. [34.74.116.162])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80f729a7369sm1391815241.32.2024.06.24.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:43:32 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net] tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO
Date: Mon, 24 Jun 2024 14:43:23 +0000
Message-ID: <20240624144323.2371403-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

Testing determined that the recent commit 9e046bb111f1 ("tcp: clear
tp->retrans_stamp in tcp_rcv_fastopen_synack()") has a race, and does
not always ensure retrans_stamp is 0 after a TFO payload retransmit.

If transmit completion for the SYN+data skb happens after the client
TCP stack receives the SYNACK (which sometimes happens), then
retrans_stamp can erroneously remain non-zero for the lifetime of the
connection, causing a premature ETIMEDOUT later.

Testing and tracing showed that the buggy scenario is the following
somewhat tricky sequence:

+ Client attempts a TFO handshake. tcp_send_syn_data() sends SYN + TFO
  cookie + data in a single packet in the syn_data skb. It hands the
  syn_data skb to tcp_transmit_skb(), which makes a clone. Crucially,
  it then reuses the same original (non-clone) syn_data skb,
  transforming it by advancing the seq by one byte and removing the
  FIN bit, and enques the resulting payload-only skb in the
  sk->tcp_rtx_queue.

+ Client sets retrans_stamp to the start time of the three-way
  handshake.

+ Cookie mismatches or server has TFO disabled, and server only ACKs
  SYN.

+ tcp_ack() sees SYN is acked, tcp_clean_rtx_queue() clears
  retrans_stamp.

+ Since the client SYN was acked but not the payload, the TFO failure
  code path in tcp_rcv_fastopen_synack() tries to retransmit the
  payload skb.  However, in some cases the transmit completion for the
  clone of the syn_data (which had SYN + TFO cookie + data) hasn't
  happened.  In those cases, skb_still_in_host_queue() returns true
  for the retransmitted TFO payload, because the clone of the syn_data
  skb has not had its tx completetion.

+ Because skb_still_in_host_queue() finds skb_fclone_busy() is true,
  it sets the TSQ_THROTTLED bit and the retransmit does not happen in
  the tcp_rcv_fastopen_synack() call chain.

+ The tcp_rcv_fastopen_synack() code next implicitly assumes the
  retransmit process is finished, and sets retrans_stamp to 0 to clear
  it, but this is later overwritten (see below).

+ Later, upon tx completion, tcp_tsq_write() calls
  tcp_xmit_retransmit_queue(), which puts the retransmit in flight and
  sets retrans_stamp to a non-zero value.

+ The client receives an ACK for the retransmitted TFO payload data.

+ Since we're in CA_Open and there are no dupacks/SACKs/DSACKs/ECN to
  make tcp_ack_is_dubious() true and make us call
  tcp_fastretrans_alert() and reach a code path that clears
  retrans_stamp, retrans_stamp stays nonzero.

+ Later, if there is a TLP, RTO, RTO sequence, then the connection
  will suffer an early ETIMEDOUT due to the erroneously ancient
  retrans_stamp.

The fix: this commit refactors the code to have
tcp_rcv_fastopen_synack() retransmit by reusing the relevant parts of
tcp_simple_retransmit() that enter CA_Loss (without changing cwnd) and
call tcp_xmit_retransmit_queue(). We have tcp_simple_retransmit() and
tcp_rcv_fastopen_synack() share code in this way because in both cases
we get a packet indicating non-congestion loss (MTU reduction or TFO
failure) and thus in both cases we want to retransmit as many packets
as cwnd allows, without reducing cwnd. And given that retransmits will
set retrans_stamp to a non-zero value (and may do so in a later
calling context due to TSQ), we also want to enter CA_Loss so that we
track when all retransmitted packets are ACked and clear retrans_stamp
when that happens (to ensure later recurring RTOs are using the
correct retrans_stamp and don't declare ETIMEDOUT prematurely).

Fixes: 9e046bb111f1 ("tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()")
Fixes: a7abf3cd76e1 ("tcp: consider using standard rtx logic in tcp_rcv_fastopen_synack()")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
---
 net/ipv4/tcp_input.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 01d208e0eef31..a603d5f793b6f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2782,13 +2782,37 @@ static void tcp_mtup_probe_success(struct sock *sk)
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMTUPSUCCESS);
 }
 
+/* Sometimes we deduce that packets have been dropped due to reasons other than
+ * congestion, like path MTU reductions or failed client TFO attempts. In these
+ * cases we call this function to retransmit as many packets as cwnd allows,
+ * without reducing cwnd. Given that retransmits will set retrans_stamp to a
+ * non-zero value (and may do so in a later calling context due to TSQ), we
+ * also enter CA_Loss so that we track when all retransmitted packets are ACKed
+ * and clear retrans_stamp when that happens (to ensure later recurring RTOs
+ * are using the correct retrans_stamp and don't declare ETIMEDOUT
+ * prematurely).
+ */
+static void tcp_non_congestion_loss_retransmit(struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (icsk->icsk_ca_state != TCP_CA_Loss) {
+		tp->high_seq = tp->snd_nxt;
+		tp->snd_ssthresh = tcp_current_ssthresh(sk);
+		tp->prior_ssthresh = 0;
+		tp->undo_marker = 0;
+		tcp_set_ca_state(sk, TCP_CA_Loss);
+	}
+	tcp_xmit_retransmit_queue(sk);
+}
+
 /* Do a simple retransmit without using the backoff mechanisms in
  * tcp_timer. This is used for path mtu discovery.
  * The socket is already locked here.
  */
 void tcp_simple_retransmit(struct sock *sk)
 {
-	const struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *skb;
 	int mss;
@@ -2828,14 +2852,7 @@ void tcp_simple_retransmit(struct sock *sk)
 	 * in network, but units changed and effective
 	 * cwnd/ssthresh really reduced now.
 	 */
-	if (icsk->icsk_ca_state != TCP_CA_Loss) {
-		tp->high_seq = tp->snd_nxt;
-		tp->snd_ssthresh = tcp_current_ssthresh(sk);
-		tp->prior_ssthresh = 0;
-		tp->undo_marker = 0;
-		tcp_set_ca_state(sk, TCP_CA_Loss);
-	}
-	tcp_xmit_retransmit_queue(sk);
+	tcp_non_congestion_loss_retransmit(sk);
 }
 EXPORT_SYMBOL(tcp_simple_retransmit);
 
@@ -6295,8 +6312,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 			tp->fastopen_client_fail = TFO_DATA_NOT_ACKED;
 		skb_rbtree_walk_from(data)
 			 tcp_mark_skb_lost(sk, data);
-		tcp_xmit_retransmit_queue(sk);
-		tp->retrans_stamp = 0;
+		tcp_non_congestion_loss_retransmit(sk);
 		NET_INC_STATS(sock_net(sk),
 				LINUX_MIB_TCPFASTOPENACTIVEFAIL);
 		return true;
-- 
2.45.2.741.gdbec12cfda-goog


