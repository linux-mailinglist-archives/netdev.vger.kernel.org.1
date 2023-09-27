Return-Path: <netdev+bounces-36563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED87B07EB
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7D1682812B8
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311FF3AC01;
	Wed, 27 Sep 2023 15:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9621170F
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 15:15:08 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1852F4
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:15:06 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-775751c35d4so84464785a.0
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695827706; x=1696432506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sD4WKXBQaVFamFapX0kob4ZJEemipK0YXHyWxjLGdU4=;
        b=IK04HQR9nPzzL0o2BZWm6IgetezMJ/wWi1qQu5Rda28BcXHpQ9LP38rmEkcnjIc+an
         nappOqCK3c/cB1EFMuIGJnAZNpZr/r6yLdZFSX1nCPdSjt3uONtFDCeiJRlNUAp//Rh6
         PMBlPVnfg9QfUvhC4SrBDNdAh0NV14drp74H2JqlyLbLUMwYZHhv1GghnSod7zsAr46c
         WYdiu+FVh1y9sXAOS9epD15ucUJQqgt8cRJS64L5g2Uss6ATiFi1muqqqwLkWQQnjrM1
         NnG05U9RijJa70W0+XZjCv7ajnSwMD7gbgdnM3/IO0OhVDyJuEqsMIZXnSTd0gdXYgoA
         EDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827706; x=1696432506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sD4WKXBQaVFamFapX0kob4ZJEemipK0YXHyWxjLGdU4=;
        b=BLx7hFTn52mJPAZV8dzZWxQszPCPD5ROeXqtE7wVe/j6QFVr1CPVyiD1WKS3LthNx3
         WqzI6T7C/9lIUcBHBtUguv8VS+9bvnUButmvwGOCIk2dd8cDGqFwwykuSeT/9qJmkOvJ
         gN8xYOIV/oN/kVTmG7JY3T2VRpan6ITtFWpjzdtD5dHpGuV0BQe0/a8qw7SpnnxuAdUK
         YZj5DE5ZbXnPHUBqD3vsigNanHNy7bGUVjH8q38eBhZ4btQ6uX97ZjxmSB6zrDBq3uPE
         QfrpJcRL1sfdlkuleF21+ESSkaWzpshJx5RKZgj8K2QJ1203kO4pz3/167Mz7949g3T7
         dfHA==
X-Gm-Message-State: AOJu0YwDPXMW0+eVBISSsbfn1R5ndbu9dmbmZq5W583ERbReU54eALQu
	wT9mHG1RtF6srhWf1VKqEgz9svqLbC2yVg==
X-Google-Smtp-Source: AGHT+IEpE+3lGHPW3t6feYkUFsQRq8OJ/mPNANGy1A6+PE7yfB0s3EBd/FxEkcS8hLN2j+hGy3pmXQ==
X-Received: by 2002:a05:620a:f0b:b0:76e:f3a3:4ac6 with SMTP id v11-20020a05620a0f0b00b0076ef3a34ac6mr2079595qkl.35.1695827705627;
        Wed, 27 Sep 2023 08:15:05 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:416:3cb2:ba69:4389:2a97])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b00767e2668536sm5533069qkm.17.2023.09.27.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:15:05 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net 1/2] tcp: fix quick-ack counting to count actual ACKs of new data
Date: Wed, 27 Sep 2023 11:15:00 -0400
Message-ID: <20230927151501.1549078-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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
2.42.0.515.g380fc7ccd1-goog


