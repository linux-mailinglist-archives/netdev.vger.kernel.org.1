Return-Path: <netdev+bounces-38454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB4D7BB006
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 03:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 2CB4EB20A2D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA8137B;
	Fri,  6 Oct 2023 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSrlqtBk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD117C5
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 01:18:52 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54478E4
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:18:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2773b10bd05so362583a91.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 18:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696555130; x=1697159930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXYhdFvbwQ5MQSa0jNJRcebVgA0GpRC3BtwkUpEgpr4=;
        b=QSrlqtBkiJvFRNviee2QMGqmNMvODsNcCuPf3dNqYi7mWoD2n0oB0E4FMfXYF1aCwz
         rHowobdCIrS3AIhnAK7hpEHcOXgrUb+PP71907nHM8u1pOMKapNoydGtt8P00zjlH05W
         vc6tQjae8pz6xfdAcffjFLIVLJcD3j7fCFxADgPGRvUaE8IpE05WAJFuVs7hsH/R+eu+
         szqLsTPF15Lyzlq3RVkjstcmdLZXkKI178uNg4QVCN0ZvenMV1iScB5mabQ04+s+a/qJ
         naafJrQkOO43U9oQOKUZoapXwPTjpCCxN2Tdk7gtnPc31jJFuwGAxkydjN+ydcaVMP0o
         jqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696555130; x=1697159930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXYhdFvbwQ5MQSa0jNJRcebVgA0GpRC3BtwkUpEgpr4=;
        b=D1kYcUjY8OFe5rH5yTwOqfvUBS9UYcR5vDDFEGNtr6fobXQa+ofClfg4e9TXkxeIfS
         im/w3Wu7xqao6/3hFvFQLIO0Z6xVlZwQly3P6LScGRy0d1EOY3LKQzLJqFQxq85qQGnf
         85VeA5kYYgtIIRr9TPLzvGAOOMFuseuls64X2JswRV9VC8YcgYP9qjweRhQ2cr5pkpuZ
         WYtaPqDuhPnsS1XJj5LzhU9tZTzlgvg7EsmR7EUcPSkKl5pdHQaKiuBr/s5AcSyoX5mU
         KnroQaJ4e8srcZwzLuuPUQJREYntjRNkHbx4hxvXcyFQhiPcmShVZo4IjsjU8A+0lVbB
         tVWw==
X-Gm-Message-State: AOJu0YxXFhM1z148D09HNzyFiVvNFenFkzEjruelg4Z1LvDt4Lftsvwm
	qe5J0TrdyzyXbsbKfBMrYnI=
X-Google-Smtp-Source: AGHT+IEsSagHpNw8ffXsD76cpl5mYAuTkZ57lZjIiMKJSX36tVOxbL9bfIuru+T3lm7EGZ/euq9qSQ==
X-Received: by 2002:a17:903:22ce:b0:1bb:83ec:832 with SMTP id y14-20020a17090322ce00b001bb83ec0832mr7310190plg.2.1696555129635;
        Thu, 05 Oct 2023 18:18:49 -0700 (PDT)
Received: from dmoe.c.googlers.com.com (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001c20c608373sm2413776plf.296.2023.10.05.18.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 18:18:49 -0700 (PDT)
From: David Morley <morleyd.kernel@gmail.com>
To: David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Morley <morleyd@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next v3 1/2] tcp: record last received ipv6 flowlabel
Date: Fri,  6 Oct 2023 01:18:40 +0000
Message-ID: <20231006011841.3558307-2-morleyd.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231006011841.3558307-1-morleyd.kernel@gmail.com>
References: <20231006011841.3558307-1-morleyd.kernel@gmail.com>
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

From: David Morley <morleyd@google.com>

In order to better estimate whether a data packet has been
retransmitted or is the result of a TLP, we save the last received
ipv6 flowlabel.

To make space for this field we resize the "ato" field in
inet_connection_sock as the current value of TCP_DELACK_MAX can be
fully contained in 8 bits and add a compile_time_assert ensuring this
field is the required size.

v2: addressed kernel bot feedback about dccp_delack_timer()
v3: addressed build error introduced by commit bbf80d713fe7 ("tcp:
derive delack_max from rto_min")

Signed-off-by: David Morley <morleyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Tested-by: David Morley <morleyd@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h |  5 ++++-
 include/net/tcp.h                  |  2 ++
 net/dccp/timer.c                   |  4 ++--
 net/ipv4/tcp.c                     |  4 ++--
 net/ipv4/tcp_input.c               | 15 +++++++++++++++
 net/ipv4/tcp_timer.c               |  2 +-
 6 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 5d2fcc137b88..d6d9d1c1985a 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -114,7 +114,10 @@ struct inet_connection_sock {
 		__u8		  quick;	 /* Scheduled number of quick acks	   */
 		__u8		  pingpong;	 /* The session is interactive		   */
 		__u8		  retry;	 /* Number of attempts			   */
-		__u32		  ato;		 /* Predicted tick of soft clock	   */
+		#define ATO_BITS 8
+		__u32		  ato:ATO_BITS,	 /* Predicted tick of soft clock	   */
+				  lrcv_flowlabel:20, /* last received ipv6 flowlabel	   */
+				  unused:4;
 		unsigned long	  timeout;	 /* Currently scheduled timeout		   */
 		__u32		  lrcvtime;	 /* timestamp of last received data packet */
 		__u16		  last_seg_size; /* Size of last incoming segment	   */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index af9cb37fbe53..2083f99f9e96 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -131,6 +131,8 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 #define TCP_FIN_TIMEOUT_MAX (120 * HZ) /* max TCP_LINGER2 value (two minutes) */
 
 #define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */
+static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
+
 #if HZ >= 100
 #define TCP_DELACK_MIN	((unsigned)(HZ/25))	/* minimal time to delay before sending an ACK */
 #define TCP_ATO_MIN	((unsigned)(HZ/25))
diff --git a/net/dccp/timer.c b/net/dccp/timer.c
index b3255e87cc7e..a4cfb47b60e5 100644
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -196,8 +196,8 @@ static void dccp_delack_timer(struct timer_list *t)
 	if (inet_csk_ack_scheduled(sk)) {
 		if (!inet_csk_in_pingpong_mode(sk)) {
 			/* Delayed ACK missed: inflate ATO. */
-			icsk->icsk_ack.ato = min(icsk->icsk_ack.ato << 1,
-						 icsk->icsk_rto);
+			icsk->icsk_ack.ato = min_t(u32, icsk->icsk_ack.ato << 1,
+						   icsk->icsk_rto);
 		} else {
 			/* Delayed ACK missed: leave pingpong mode and
 			 * deflate ATO.
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e54f91eb943b..706b8b271ff6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3762,8 +3762,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
-	info->tcpi_ato = jiffies_to_usecs(min(icsk->icsk_ack.ato,
-					      tcp_delack_max(sk)));
+	info->tcpi_ato = jiffies_to_usecs(min_t(u32, icsk->icsk_ack.ato,
+						tcp_delack_max(sk)));
 	info->tcpi_snd_mss = tp->mss_cache;
 	info->tcpi_rcv_mss = icsk->icsk_ack.rcv_mss;
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 22c2a7c2e65e..c7c15d4b95e5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -765,6 +765,16 @@ void tcp_rcv_space_adjust(struct sock *sk)
 	tp->rcvq_space.time = tp->tcp_mstamp;
 }
 
+static void tcp_save_lrcv_flowlabel(struct sock *sk, const struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	if (skb->protocol == htons(ETH_P_IPV6))
+		icsk->icsk_ack.lrcv_flowlabel = ntohl(ip6_flowlabel(ipv6_hdr(skb)));
+#endif
+}
+
 /* There is something which you must keep in mind when you analyze the
  * behavior of the tp->ato delayed ack timeout interval.  When a
  * connection starts up, we want to ack as quickly as possible.  The
@@ -813,6 +823,7 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 		}
 	}
 	icsk->icsk_ack.lrcvtime = now;
+	tcp_save_lrcv_flowlabel(sk, skb);
 
 	tcp_ecn_check_ce(sk, skb);
 
@@ -4506,6 +4517,9 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	if (TCP_SKB_CB(skb)->seq == tcp_sk(sk)->duplicate_sack[0].start_seq &&
 	    sk_rethink_txhash(sk))
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
+
+	/* Save last flowlabel after a spurious retrans. */
+	tcp_save_lrcv_flowlabel(sk, skb);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
@@ -4822,6 +4836,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	u32 seq, end_seq;
 	bool fragstolen;
 
+	tcp_save_lrcv_flowlabel(sk, skb);
 	tcp_ecn_check_ce(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3f61c6a70a1f..0862b73dd3b5 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -322,7 +322,7 @@ void tcp_delack_timer_handler(struct sock *sk)
 	if (inet_csk_ack_scheduled(sk)) {
 		if (!inet_csk_in_pingpong_mode(sk)) {
 			/* Delayed ACK missed: inflate ATO. */
-			icsk->icsk_ack.ato = min(icsk->icsk_ack.ato << 1, icsk->icsk_rto);
+			icsk->icsk_ack.ato = min_t(u32, icsk->icsk_ack.ato << 1, icsk->icsk_rto);
 		} else {
 			/* Delayed ACK missed: leave pingpong mode and
 			 * deflate ATO.
-- 
2.42.0.609.gbb76f46606-goog


