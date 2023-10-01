Return-Path: <netdev+bounces-37282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860967B4852
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 33CE628222D
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC1182A3;
	Sun,  1 Oct 2023 15:12:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA6FC06
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:12:45 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38965D9
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 08:12:43 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-493639d6173so5826118e0c.3
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696173162; x=1696777962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rE8v+DuMTzieoPlnWvP+59YRal1uMwXWaOZN7N1t2xM=;
        b=FbNc7NgGndb+CDLfWIMMfwFIQtxYI6UeT+f2RmzN+dJkdrKBAqNyY5DeHA5gKLASxY
         E0Q8PK8y8C4pXY49xhllhTNypYG7IKPC0MyAedpbUnDyHmwQpVSZdLwDfw3/WOfR6Z0o
         t4/Df8IROQBayc+p8fYPbO31/WpLyZh+VvtKzPIuAZ1hZSBGGMgH894jrdA2uzGWCjMn
         goCRrxrYacNrQ8YycmDwCDAtf0XCV3/8S1Jlp0rbTiF1UtoFKKGL73B9PqnNV9eOqm5i
         S5GLXzfXDlnABogt0Yr1vljFu9utIODn/ZwirxxJ/USqNOX0eIFrc7LY/OqSyySKI4ib
         zzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696173162; x=1696777962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE8v+DuMTzieoPlnWvP+59YRal1uMwXWaOZN7N1t2xM=;
        b=rSyymy274hLgfJLNQ0fbX6Tqhqw+aF5uBLIJjxOxaAzMtoyFPnZNoZXiqY+qm1dgvB
         0a9tduxV2FjvlElI6l3S1VpyDShRdzekYPHzzY4Y7/BaUsftNYSBYU4n9WU8v0O66L4t
         xelPllGcC9uwFT1SgkYjpIJhyuGlj4F4tSL2eSYVwF4QErenxSR1BbPt5Y5Sw6ikTRaz
         p23M52NowET/YPc6CHedOkItGZF47iZYbWN/eEHQyLUORXrI0QzK8/e1EbdA0OVZ9gH6
         rz/yjR8ISNVV7noyQx+6RoOLJdvOAuCW118EdrHPB6wuhGviCtAF2sjqiaKh1XT+t30B
         1eRw==
X-Gm-Message-State: AOJu0YyBOD8ANuiD3dStvbMi0FMk8xAZ+fCi+EQWXWD26I+Xe7z9dBCA
	cK0JL78LSZn847jxTH0WPec=
X-Google-Smtp-Source: AGHT+IFsUNUqK9khu1c9hIzKL1/Z9jfvHYdzNBpkQnGq2AsgBtsAhmRF2VT3PczM9vB/54bOEcAQHg==
X-Received: by 2002:a1f:ec43:0:b0:495:febd:9187 with SMTP id k64-20020a1fec43000000b00495febd9187mr7444210vkh.0.1696173162192;
        Sun, 01 Oct 2023 08:12:42 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:416:c6ad:8d4d:efac:c523])
        by smtp.gmail.com with ESMTPSA id n18-20020ae9c312000000b0076f13783743sm1433193qkg.92.2023.10.01.08.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 08:12:41 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH v2 net 1/2] tcp: fix quick-ack counting to count actual ACKs of new data
Date: Sun,  1 Oct 2023 11:12:38 -0400
Message-ID: <20231001151239.1866845-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Neal Cardwell <ncardwell@google.com>

This commit fixes quick-ack counting so that it only considers that a
quick-ack has been provided if we are sending an ACK that newly
acknowledges data.

The code was erroneously using the number of data segments in outgoing
skbs when deciding how many quick-ack credits to remove. This logic
does not make sense, and could cause poor performance in
request-response workloads, like RPC traffic, where requests or
responses can be multi-segment skbs.

When a TCP connection decides to send N quick-acks, that is to
accelerate the cwnd growth of the congestion control module
controlling the remote endpoint of the TCP connection. That quick-ack
decision is purely about the incoming data and outgoing ACKs. It has
nothing to do with the outgoing data or the size of outgoing data.

And in particular, an ACK only serves the intended purpose of allowing
the remote congestion control to grow the congestion window quickly if
the ACK is ACKing or SACKing new data.

The fix is simple: only count packets as serving the goal of the
quickack mechanism if they are ACKing/SACKing new data. We can tell
whether this is the case by checking inet_csk_ack_scheduled(), since
we schedule an ACK exactly when we are ACKing/SACKing new data.

Fixes: fc6415bcb0f5 ("[TCP]: Fix quick-ack decrementing with TSO.")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v2: No change in this patch.
 include/net/tcp.h     | 6 ++++--
 net/ipv4/tcp_output.c | 7 +++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 91688d0dadcd6..7b1a720691aec 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -348,12 +348,14 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 				     bool force_schedule);
 
-static inline void tcp_dec_quickack_mode(struct sock *sk,
-					 const unsigned int pkts)
+static inline void tcp_dec_quickack_mode(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (icsk->icsk_ack.quick) {
+		/* How many ACKs S/ACKing new data have we sent? */
+		const unsigned int pkts = inet_csk_ack_scheduled(sk) ? 1 : 0;
+
 		if (pkts >= icsk->icsk_ack.quick) {
 			icsk->icsk_ack.quick = 0;
 			/* Leaving quickack mode we deflate ATO. */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ccfc8bbf74558..aa0fc8c766e50 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -177,8 +177,7 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
 }
 
 /* Account for an ACK we sent. */
-static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
-				      u32 rcv_nxt)
+static inline void tcp_event_ack_sent(struct sock *sk, u32 rcv_nxt)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -192,7 +191,7 @@ static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
 
 	if (unlikely(rcv_nxt != tp->rcv_nxt))
 		return;  /* Special ACK sent by DCTCP to reflect ECN */
-	tcp_dec_quickack_mode(sk, pkts);
+	tcp_dec_quickack_mode(sk);
 	inet_csk_clear_xmit_timer(sk, ICSK_TIME_DACK);
 }
 
@@ -1387,7 +1386,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 			   sk, skb);
 
 	if (likely(tcb->tcp_flags & TCPHDR_ACK))
-		tcp_event_ack_sent(sk, tcp_skb_pcount(skb), rcv_nxt);
+		tcp_event_ack_sent(sk, rcv_nxt);
 
 	if (skb->len != tcp_header_size) {
 		tcp_event_data_sent(tp, sk);
-- 
2.42.0.582.g8ccd20d70d-goog


