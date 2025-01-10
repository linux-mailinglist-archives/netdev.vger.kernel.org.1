Return-Path: <netdev+bounces-157179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C769DA0938D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF6B3A934D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9E1211290;
	Fri, 10 Jan 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqkbyCMx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A7211276
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519601; cv=none; b=MvIdiEkERGBRd8VFqS1Crkk/PmhsjRSJzSP6l/iIk3q90zU0pdral0FMZRlHV9CHXYMGR5siL/0hILZn/2qR4P6Kh9uEHfT4wNDcMo6YTjx+mro+sX2Fe2q3zb3rajYogApha9FaYk+6OU3WKTHHbV6OC79IMHJrBSjXMGYu6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519601; c=relaxed/simple;
	bh=fAj3SIoN1NOZi2bg5USp+VhVX2DMj74elwRBJIxES6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qNLkluylm1HcSd/Alvh0RXNlegr0rbRZ3ln1euPDf7RIJ1/R7A1ei6ZEdf94VyO/Te7swyC2HdcS4AyVQvAoll6m0d9aNFX6T36fnoYPjl1En0ryYcrav/h0IS1/ttTxONm4DV1bESyQ+ZjwIlpxjMIyTyV+YpC7fKrjpJqoNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hqkbyCMx; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-468f6f2f57aso26621791cf.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 06:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736519598; x=1737124398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MShUowdvrdvE0bZpUlV/TBDtENDgPKABR7tVk3EqboY=;
        b=hqkbyCMxvOUalkZzBoz3mEs0bZmxbwxAvL1+ZUHArv7gL4RuOVpCjpVIpPRlwqmNlo
         PBYdzSY47rLal35ta2IKQMJt/vQGNESULNHT9bWvguhBow7VUf/d5iV8jDScQ39WhBOE
         Aq4CQ/5FcQSf+rWar77fH2yqcg+ILZrabjTmah0EQKdF9I83nsI/vdzZB6EsavOP9Ulm
         30qpdkI1iVHZPSX6GoI0m5Xqo03kMqYW03JJIGitO1JJEMOlmvAMlQ3PExoAuglntVe9
         tiQ4clK86LV+ZnhABgF3eEFLYOk2nH2WjrM9eI3Y6g7FvqnPjaErmAtU7UgYVKFHbzqt
         9BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519598; x=1737124398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MShUowdvrdvE0bZpUlV/TBDtENDgPKABR7tVk3EqboY=;
        b=a0GHD+892esIgJWMOwLU4d+S58oATq6tLznM7E8mEEXv+2AaYsQbazhRRiv3guq8lx
         tYS8PLNOVsAJuhrys8nuofHBAxWz5f5gUdhjiOrjSRdArD7za23mOS21WljXqI/gHR3U
         7ckEfh32/qmSudk7XtWLStU5hGQaxlYfkvJ5sEcvqNXPB74Hu11EEpqPmlvYFzDzbCKI
         9heLWPPRQif2bqB7G6ndXMNLyJ25kHdIohT7ZFQ0EV8MlxHL99vLVJn7w3woVgD7r1/g
         4PtXdhJwY5wbDm0tqVHy9eidUQ94NygnRBf26sTfXI4tP+yiqr1vK5C4OFjqGBNp+4Jr
         P9ZQ==
X-Gm-Message-State: AOJu0YwvWgXaHYoZTOWC9sn7en+EC3+jDU5LbKoUM1hoi2MT/tBj3As6
	ioIdIE3Ttif8uQ0TVfvdgk1wjnMuDV3SlFNtNKScBnJ4VmUdbC/UHmSIjqcWin/WDI7/z9PV+5K
	3ISdC3HdY2A==
X-Google-Smtp-Source: AGHT+IF3nf3NP2afcZVriuUPQyRraCuZVT2yuLQKhsUDPm/i6PQEI/I6xz0qrVVk3GJEVSwbAXfMG6P2gQUHuQ==
X-Received: from qtbnv13.prod.google.com ([2002:a05:622a:7bcd:b0:467:518e:d31b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:180c:b0:466:b1b2:6f0d with SMTP id d75a77b69052e-46c710e1398mr182501821cf.36.1736519598547;
 Fri, 10 Jan 2025 06:33:18 -0800 (PST)
Date: Fri, 10 Jan 2025 14:33:14 +0000
In-Reply-To: <20250110143315.571872-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250110143315.571872-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: add drop_reason support to tcp_disordered_ack()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
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


