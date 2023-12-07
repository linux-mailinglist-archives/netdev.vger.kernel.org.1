Return-Path: <netdev+bounces-54938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5487808FA7
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705171F21080
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D14D106;
	Thu,  7 Dec 2023 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGeNXCD8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA3110E3
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:13:44 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cf4696e202so14565247b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701972824; x=1702577624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DMgMvmhtRkqOkIEw/cVgn7RixHEDJERnvGc/AD5EK18=;
        b=tGeNXCD82WdJi0AshFFQd//sbo7Fayl7w2124LCubhl1jYb284hco1B9bqnNabTcEa
         3odKQzgrMywXrYbazvaOdWdsx1c/LTHE1xky6LjTh5MD4p9EiwwOtgC0nQxhgQG7G99f
         6ngqkgrgktMa2IyqdpXowBVXNNI0+7TwpU+dDKcX+TVwpxhJOcXqzJ2Uxooq9HTgDYgT
         xI7s9Jmwz0rgINpHITh5N3j5VSLm3Niwq17+6poDyqLZCDy2Wmo4a9cIfmyuNJ+2vE/d
         mgjL5Gg/0M1a6k9j/V6t/Q8pnXHfXS44+YVr1GG/kUiCtg0Kb9NamxLiJ57EO+BBvPjf
         EbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701972824; x=1702577624;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMgMvmhtRkqOkIEw/cVgn7RixHEDJERnvGc/AD5EK18=;
        b=KWeccpiWJYyGRm9GDu9iGto4e4/A4dB96KtkeCM+VtF/nAhW+7HF/GiBPISvB5OU4A
         SEvh2kEsIP04Y/KZ/vz2InUwr8TqZlFdQ3PZ/EFIsFIBARQ+nGxcNf058MzNZciSO3I9
         i/ILWg8o4dBlWfA3DqCWp7XirsLcHrov/5VOk9MoNNTjxTJKLXxyY+Wn5KaYXe8Yl74b
         Hv1baPPVaSkh7juKtm0eo2uQwT/kg2TZCgVKig/oPeXmRB9SPmtogH1d2oHAFlEYerHC
         Yr2+iI+M8xlAOoDQCbvKpqLVZJi/viDkNnVNHOIQGg5dR63vhBWb2SesouNkyTzbPI5W
         OIVg==
X-Gm-Message-State: AOJu0YwGZVaPWMJwg9eTlWaEU+f5HM9tNGU3Sxz3fevsnrA2rpsQtoFe
	IYmc84nujvhN3v2UmWeSEF/B8mAg25Zc1A==
X-Google-Smtp-Source: AGHT+IG5BW4XnDIEqx6tnl5PdJ0FJN7AAYpj6H+9FrMLTzqgVy4M4I9G9Zl5nN/s4fDS1wmHMyYekcmPV/Jaxw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:3146:b0:5d7:4619:82dd with SMTP
 id fc6-20020a05690c314600b005d7461982ddmr43451ywb.6.1701972824120; Thu, 07
 Dec 2023 10:13:44 -0800 (PST)
Date: Thu,  7 Dec 2023 18:13:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231207181342.525181-1-edumazet@google.com>
Subject: [PATCH net] tcp: fix tcp_disordered_ack() vs usec TS resolution
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	David Morley <morleyd@google.com>
Content-Type: text/plain; charset="UTF-8"

After commit 939463016b7a ("tcp: change data receiver flowlabel after one dup")
we noticed an increase of TCPACKSkippedPAWS events.

Neal Cardwell tracked the issue to tcp_disordered_ack() assumption
about remote peer TS clock.

RFC 1323 & 7323 are suggesting the following:
  "timestamp clock frequency in the range 1 ms to 1 sec per tick
   between 1ms and 1sec."

This has to be adjusted for 1 MHz clock frequency.

This hints at reorders of SACK packets on send side,
this might deserve a future patch.
(skb->ooo_okay is always set for pure ACK packets)

Fixes: 614e8316aa4c ("tcp: add support for usec resolution in TCP TS values")
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Morley <morleyd@google.com>
---
 net/ipv4/tcp_input.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 90de838a274519110ce0ac84552c4caedb826eb7..701cb87043f28079286044208128c2d687908991 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4368,6 +4368,23 @@ EXPORT_SYMBOL(tcp_do_parse_auth_options);
  * up to bandwidth of 18Gigabit/sec. 8) ]
  */
 
+/* Estimates max number of increments of remote peer TSval in
+ * a replay window (based on our current RTO estimation).
+ */
+static u32 tcp_tsval_replay(const struct sock *sk)
+{
+	/* If we use usec TS resolution,
+	 * then expect the remote peer to use the same resolution.
+	 */
+	if (tcp_sk(sk)->tcp_usec_ts)
+		return inet_csk(sk)->icsk_rto * (USEC_PER_SEC / HZ);
+
+	/* RFC 7323 recommends a TSval clock between 1ms and 1sec.
+	 * We know that some OS (including old linux) can use 1200 Hz.
+	 */
+	return inet_csk(sk)->icsk_rto * 1200 / HZ;
+}
+
 static int tcp_disordered_ack(const struct sock *sk, const struct sk_buff *skb)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -4375,7 +4392,7 @@ static int tcp_disordered_ack(const struct sock *sk, const struct sk_buff *skb)
 	u32 seq = TCP_SKB_CB(skb)->seq;
 	u32 ack = TCP_SKB_CB(skb)->ack_seq;
 
-	return (/* 1. Pure ACK with correct sequence number. */
+	return	/* 1. Pure ACK with correct sequence number. */
 		(th->ack && seq == TCP_SKB_CB(skb)->end_seq && seq == tp->rcv_nxt) &&
 
 		/* 2. ... and duplicate ACK. */
@@ -4385,7 +4402,8 @@ static int tcp_disordered_ack(const struct sock *sk, const struct sk_buff *skb)
 		!tcp_may_update_window(tp, ack, seq, ntohs(th->window) << tp->rx_opt.snd_wscale) &&
 
 		/* 4. ... and sits in replay window. */
-		(s32)(tp->rx_opt.ts_recent - tp->rx_opt.rcv_tsval) <= (inet_csk(sk)->icsk_rto * 1024) / HZ);
+		(s32)(tp->rx_opt.ts_recent - tp->rx_opt.rcv_tsval) <=
+		tcp_tsval_replay(sk);
 }
 
 static inline bool tcp_paws_discard(const struct sock *sk,
-- 
2.43.0.472.g3155946c3a-goog


