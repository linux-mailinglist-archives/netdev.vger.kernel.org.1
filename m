Return-Path: <netdev+bounces-157754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A97A0B8D9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F3B163BF7
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B262397B8;
	Mon, 13 Jan 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQw7qrLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B0125B2
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776563; cv=none; b=UYzTSSArsWGZmFfgKBxjL4JUw3fJN0FKkuuG8GT8/t5VilzLN03m/oyg5KqfxgHgGF2ipcgiKDLrB/qOMJKbof5CsdnRNn9H3mKjTQfRnLyYHLxhhfhiu565W0xBiXDchaeMX0QM/1hugH4Gro/uyi5Q8FZ7Tts8ibBrn7oTFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776563; c=relaxed/simple;
	bh=Tss+c/6QYRJBC1geYN31vpcWnf9EXnkMEuhMS1z1PmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VRDLJDxvu7eYkAholy8Rlq1OKE3v2EshyYZHtzeuz99w7xdz0GdI0eiPk3+Br+Q6Zt1svaIQkJhRe/hvhpP73e0DvMFMQPtzHXrAL6f9K6hFnm1TsKa3dHyCId0VTiIyE4vqywmeNoxWIo3cXLNAmge7mUPGS/7f1EPZbXDyzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQw7qrLp; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d8860ab00dso72030916d6.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736776561; x=1737381361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EdVAGJJ9HFgwWIAVRFq+e5v8FGcwI8PQJteOCqk6Y+A=;
        b=eQw7qrLpf/23KcGv5gpyySN1ltlMdzoFQJoyyfkdA0T4rm1LnwrcJYvPnfoK0TkcHR
         LLZA2Un8TxrSr82vy9+fN79HJqLn0xrbA5NsCaeoT9NrYSxXa+QKYqQc3i45EDv2A7Rk
         HW+RB6iunfGplyaDoqhDvatoORfYYqNPy7zPbTiPN1wsTStldKK3rDwjAYJ/jrc2vqgW
         EUeV2FnlW27vPYYoiurpkTjmnRmG+rRr/wNJtsSd8QpUOt66bvyWqctFNHbh9hPu1HTS
         BorzYqDMXNIC5tebMZfijkXEh5hNgOQ25sQcMDagzndYcWzYv2Yx10Mqteo4BDfN6VsH
         8FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736776561; x=1737381361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdVAGJJ9HFgwWIAVRFq+e5v8FGcwI8PQJteOCqk6Y+A=;
        b=anHMzOfzhv31K45S3KoA3y3D8YfEfCcLXgn7AnohBirLL09vDDJrQfJCgrienT+Aa1
         eQqJEziLiDFE0Cq/mDUVOk5+P+opBZ5jaLqdicssShlBc92GKyiacd24csWWajGQYLvK
         joTzpf2T3JimvlPUgaE30ZqLOUG7ojWQgqlWh5l74jXzxANpjGfmyRXhXLOY1ZgCsMoH
         E7NsNKPKrVaUKn9arZ0F7f7rK+sf7ct0jfREAu70C7qO3uOdBoqMKiUWHzaTT/bJ5hMv
         FNYygIAgcrcW5KnL+0jqgR9uBmzd3HXc5kRf/SVUBIjvVVDBaMKEHn64MUqBQICOkoNS
         I3kQ==
X-Gm-Message-State: AOJu0YyMLwsF8QdAoNyZwmjQhy4z77WzRZ5YRTbI1prNBGhA4XVezIG1
	4308PeRxJEa3LoD+DLzkEY3LLaI7Eyug9Lxa4S4iKNuajCdiOd+BfSruldgGUQCD3PsgapNwbQa
	qYd3mgsdEpw==
X-Google-Smtp-Source: AGHT+IGigptF8sqvn24HdosS5Uy2pKU1lEDMTreI6DY3o1uZFoZzvp4IgXfniQRiN497SHdrcVaMjBX2WoJY8A==
X-Received: from qvbks22.prod.google.com ([2002:a05:6214:3116:b0:6dc:c098:fa40])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:570b:b0:6d1:9e72:596a with SMTP id 6a1803df08f44-6df9b2dadefmr374515166d6.37.1736776561163;
 Mon, 13 Jan 2025 05:56:01 -0800 (PST)
Date: Mon, 13 Jan 2025 13:55:56 +0000
In-Reply-To: <20250113135558.3180360-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113135558.3180360-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250113135558.3180360-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] tcp: add drop_reason support to tcp_disordered_ack()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following patch is adding a new drop_reason to tcp_validate_incoming().

Change tcp_disordered_ack() to not return a boolean anymore,
but a drop reason.

Change its name to tcp_disordered_ack_check()

Refactor tcp_validate_incoming() to ease the code
review of the following patch, and reduce indentation
level.

This patch is a refactor, with no functional change.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp_input.c | 79 ++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4811727b8a02258ec6fa1fd129beecf7cbb0f90e..24966dd3e49f698e110f8601e098b65afdf0718a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4450,34 +4450,38 @@ static u32 tcp_tsval_replay(const struct sock *sk)
 	return inet_csk(sk)->icsk_rto * 1200 / HZ;
 }
 
-static int tcp_disordered_ack(const struct sock *sk, const struct sk_buff *skb)
+static enum skb_drop_reason tcp_disordered_ack_check(const struct sock *sk,
+						     const struct sk_buff *skb)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	const struct tcphdr *th = tcp_hdr(skb);
-	u32 seq = TCP_SKB_CB(skb)->seq;
+	SKB_DR_INIT(reason, TCP_RFC7323_PAWS);
 	u32 ack = TCP_SKB_CB(skb)->ack_seq;
+	u32 seq = TCP_SKB_CB(skb)->seq;
 
-	return	/* 1. Pure ACK with correct sequence number. */
-		(th->ack && seq == TCP_SKB_CB(skb)->end_seq && seq == tp->rcv_nxt) &&
+	/* 1. Is this not a pure ACK ? */
+	if (!th->ack || seq != TCP_SKB_CB(skb)->end_seq)
+		return reason;
 
-		/* 2. ... and duplicate ACK. */
-		ack == tp->snd_una &&
+	/* 2. Is its sequence not the expected one ? */
+	if (seq != tp->rcv_nxt)
+		return reason;
 
-		/* 3. ... and does not update window. */
-		!tcp_may_update_window(tp, ack, seq, ntohs(th->window) << tp->rx_opt.snd_wscale) &&
+	/* 3. Is this not a duplicate ACK ? */
+	if (ack != tp->snd_una)
+		return reason;
 
-		/* 4. ... and sits in replay window. */
-		(s32)(tp->rx_opt.ts_recent - tp->rx_opt.rcv_tsval) <=
-		tcp_tsval_replay(sk);
-}
+	/* 4. Is this updating the window ? */
+	if (tcp_may_update_window(tp, ack, seq, ntohs(th->window) <<
+						tp->rx_opt.snd_wscale))
+		return reason;
 
-static inline bool tcp_paws_discard(const struct sock *sk,
-				   const struct sk_buff *skb)
-{
-	const struct tcp_sock *tp = tcp_sk(sk);
+	/* 5. Is this not in the replay window ? */
+	if ((s32)(tp->rx_opt.ts_recent - tp->rx_opt.rcv_tsval) >
+	    tcp_tsval_replay(sk))
+		return reason;
 
-	return !tcp_paws_check(&tp->rx_opt, TCP_PAWS_WINDOW) &&
-	       !tcp_disordered_ack(sk, skb);
+	return 0;
 }
 
 /* Check segment sequence number for validity.
@@ -5949,23 +5953,28 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	SKB_DR(reason);
 
 	/* RFC1323: H1. Apply PAWS check first. */
-	if (tcp_fast_parse_options(sock_net(sk), skb, th, tp) &&
-	    tp->rx_opt.saw_tstamp &&
-	    tcp_paws_discard(sk, skb)) {
-		if (!th->rst) {
-			if (unlikely(th->syn))
-				goto syn_challenge;
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
-			if (!tcp_oow_rate_limited(sock_net(sk), skb,
-						  LINUX_MIB_TCPACKSKIPPEDPAWS,
-						  &tp->last_oow_ack_time))
-				tcp_send_dupack(sk, skb);
-			SKB_DR_SET(reason, TCP_RFC7323_PAWS);
-			goto discard;
-		}
-		/* Reset is accepted even if it did not pass PAWS. */
-	}
-
+	if (!tcp_fast_parse_options(sock_net(sk), skb, th, tp) ||
+	    !tp->rx_opt.saw_tstamp ||
+	    tcp_paws_check(&tp->rx_opt, TCP_PAWS_WINDOW))
+		goto step1;
+
+	reason = tcp_disordered_ack_check(sk, skb);
+	if (!reason)
+		goto step1;
+	/* Reset is accepted even if it did not pass PAWS. */
+	if (th->rst)
+		goto step1;
+	if (unlikely(th->syn))
+		goto syn_challenge;
+
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
+	if (!tcp_oow_rate_limited(sock_net(sk), skb,
+				  LINUX_MIB_TCPACKSKIPPEDPAWS,
+				  &tp->last_oow_ack_time))
+		tcp_send_dupack(sk, skb);
+	goto discard;
+
+step1:
 	/* Step 1: check sequence number */
 	reason = tcp_sequence(tp, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
 	if (reason) {
-- 
2.47.1.613.gc27f4b7a9f-goog


