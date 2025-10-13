Return-Path: <netdev+bounces-228812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B0BD434B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017B63E47A7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F039226FA70;
	Mon, 13 Oct 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCUFvwFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE39222587
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367570; cv=none; b=n7oO2AcI3MmQ4F+jrtT9Y+68QI07ZJqTuW4Uo95Og4zxYAnQX8U04Vkhc+d/zNw1+7VXyJvi383KyQwSlRwTZa17S4rhYm9TphivyOzMN3XR6O2M+/DG6VqumW3stPcG4LH74/jnPtSnKXc74BqOB8HmETbtH40eFlfCIlyUGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367570; c=relaxed/simple;
	bh=Xvb1AzUoi47W8nL/7fl/biJbW+fec3U2EjG2ql3fBCM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tkYLo1eUn0WyfXkJcgcEwoakZbQYgtd9xWJ5jQchpf1RPabPY8QD0AmtDjCMuUi1+synSqOm+m8SiRXU3PbeNkEj/wIJKPG9HHjWpTVM6HtkDqNGFyESECkFq1GBFcQ3lAiox+IT+dnfmjftGwiceDYiXgjfb4Pe79JyJ3hH8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCUFvwFo; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-87ae13cc97cso2610316085a.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760367568; x=1760972368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Ryov5JoZj1+wAh7+cGmYqDb5CI8EvM6lCq43DJKdmE=;
        b=KCUFvwFoVdgzTSiyGHAP3Yq0lIZoDwGwJixoUu9fRa7WTL+ei2Z7SAEk1GiLZymM0m
         8OnU/6OEDAhwDHt3Kr1yVS2mxHFC315/I35nhMJWsrPmfq/BX2ImDTiRCNP5T7HlT3i6
         Kg4SnUcaIUrLfapwpFMDW1GcYfOP+XMNlPj/Ho2WpcNnXy/L/nmrTkttSdT1WEplFkTn
         dSChg7KgCM3/fWdiNBQr4PlKCh4YjX8/hLEHt4JLcmR8JLNR9kDKNIL53IiryNFHsADm
         q3W1JjR4VQ+uz22oi580UyTEY3ji3lITgyM1hS8l4poMseTXnEiWPk1kMrAHule3sV5R
         ebnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367568; x=1760972368;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ryov5JoZj1+wAh7+cGmYqDb5CI8EvM6lCq43DJKdmE=;
        b=WMq1iQOHS+R/m5c8wrfaqNm5HdZRMAebXDeN+GgP5MFGrkqoqF5NnADBAeIcM0fSPG
         CCiudpuUWgP+cXDwy/lsIzVG6gT4o6KRKK1eA7156ze0yZn3xNz91VwLzB7LxumxRhwD
         un28m28qyxdmnjtdecBKbScNOvsNi3X2vzNtYCjWWYgkQUAxPLKQf9FraojVoeboclQg
         96YneT+0WQZvvBR150Xsf6st+j5mWTq5M749rb0wENqiew+ggxRBdMh6+08emen4u4kR
         w4RQMCSV6ric+d18gT7PE0dZy1wFwkNOL12x/8BWEKQ/HeNtYxU4WvLOybwNTN1utSeG
         aN7w==
X-Forwarded-Encrypted: i=1; AJvYcCUgeYKUsjBIrCtj+cjXM5m6Krd9OBuebGM+8qd6RRoVpRY6S6xmydyiw77BidBQAopyDRB8wCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95s4gMD4Qj4MKXjZLy5njlGBPcgcPzPuz34n36eQhNP6+S5Jm
	lJBM74ohGz8GrJ0u9iX1/hG4WmNMMPqr1x6iw0RslOprVkhsHYd3OXRHjK0HFywTTn/6AiASp5f
	3G1k9AmB+U7qBMA==
X-Google-Smtp-Source: AGHT+IEVmuPhDlFXtWcOInhYFdnlvocymPxJkMuUZQssMFzRcGEsOKSz6ky3XAG1AwGixZ9wrZziyC6Hvn1z0A==
X-Received: from qknul20.prod.google.com ([2002:a05:620a:6d14:b0:855:8dab:897f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a491:b0:883:c768:200a with SMTP id af79cd13be357-883c768280dmr2238893985a.32.1760367567978;
 Mon, 13 Oct 2025 07:59:27 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:59:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013145926.833198-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established flows
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some applications uses TCP_TX_DELAY socket option after TCP flow
is established.

Some metrics need to be updated, otherwise TCP might take time to
adapt to the new (emulated) RTT.

This patch adjusts tp->srtt_us, tp->rtt_min, icsk_rto
and sk->sk_pacing_rate.

This is best effort, and for instance icsk_rto is reset
without taking backoff into account.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    |  2 ++
 net/ipv4/tcp.c       | 31 +++++++++++++++++++++++++++----
 net/ipv4/tcp_input.c |  4 ++--
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5ca230ed526ae02711e8d2a409b91664b73390f2..1e547138f4fb7f5c47d15990954d4d135f465f73 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -461,6 +461,8 @@ enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 void tcp_enter_loss(struct sock *sk);
 void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost, int flag);
 void tcp_clear_retrans(struct tcp_sock *tp);
+void tcp_update_pacing_rate(struct sock *sk);
+void tcp_set_rto(struct sock *sk);
 void tcp_update_metrics(struct sock *sk);
 void tcp_init_metrics(struct sock *sk);
 void tcp_metrics_init(void);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a18aeca7ab07480844946120f51a0555699b4c3..84662904ca96ed5685e56a827d067b62fdac3063 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3583,9 +3583,12 @@ static int tcp_repair_options_est(struct sock *sk, sockptr_t optbuf,
 DEFINE_STATIC_KEY_FALSE(tcp_tx_delay_enabled);
 EXPORT_IPV6_MOD(tcp_tx_delay_enabled);
 
-static void tcp_enable_tx_delay(void)
+static void tcp_enable_tx_delay(struct sock *sk, int val)
 {
-	if (!static_branch_unlikely(&tcp_tx_delay_enabled)) {
+	struct tcp_sock *tp = tcp_sk(sk);
+	s32 delta = (val - tp->tcp_tx_delay) << 3;
+
+	if (val && !static_branch_unlikely(&tcp_tx_delay_enabled)) {
 		static int __tcp_tx_delay_enabled = 0;
 
 		if (cmpxchg(&__tcp_tx_delay_enabled, 0, 1) == 0) {
@@ -3593,6 +3596,22 @@ static void tcp_enable_tx_delay(void)
 			pr_info("TCP_TX_DELAY enabled\n");
 		}
 	}
+	/* If we change tcp_tx_delay on a live flow, adjust tp->srtt_us,
+	 * tp->rtt_min, icsk_rto and sk->sk_pacing_rate.
+	 * This is best effort.
+	 */
+	if (delta && sk->sk_state == TCP_ESTABLISHED) {
+		s64 srtt = (s64)tp->srtt_us + delta;
+
+		tp->srtt_us = clamp_t(s64, srtt, 1, ~0U);
+
+		/* Note: does not deal with non zero icsk_backoff */
+		tcp_set_rto(sk);
+
+		minmax_reset(&tp->rtt_min, tcp_jiffies32, ~0U);
+
+		tcp_update_pacing_rate(sk);
+	}
 }
 
 /* When set indicates to always queue non-full frames.  Later the user clears
@@ -4119,8 +4138,12 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			tp->recvmsg_inq = val;
 		break;
 	case TCP_TX_DELAY:
-		if (val)
-			tcp_enable_tx_delay();
+		/* tp->srtt_us is u32, and is shifted by 3 */
+		if (val < 0 || val >= (1U << (31 - 3)) ) {
+			err = -EINVAL;
+			break;
+		}
+		tcp_enable_tx_delay(sk, val);
 		WRITE_ONCE(tp->tcp_tx_delay, val);
 		break;
 	default:
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 31ea5af49f2dc8a6f95f3f8c24065369765b8987..8fc97f4d8a6b2f8e39cabf6c9b3e6cdae294a5f5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1095,7 +1095,7 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 	tp->srtt_us = max(1U, srtt);
 }
 
-static void tcp_update_pacing_rate(struct sock *sk)
+void tcp_update_pacing_rate(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	u64 rate;
@@ -1132,7 +1132,7 @@ static void tcp_update_pacing_rate(struct sock *sk)
 /* Calculate rto without backoff.  This is the second half of Van Jacobson's
  * routine referred to above.
  */
-static void tcp_set_rto(struct sock *sk)
+void tcp_set_rto(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	/* Old crap is replaced with new one. 8)
-- 
2.51.0.740.g6adb054d12-goog


