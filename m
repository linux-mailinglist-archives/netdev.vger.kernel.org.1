Return-Path: <netdev+bounces-228592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382BBCF4C8
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82A84047F1
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12F26A1BE;
	Sat, 11 Oct 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWAqsgO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8126057A
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760183870; cv=none; b=MhxgQNALl5pl5dU3cu3+isXJh1/LuOfH88K0XDUYH98gdjzLroztG64rkl5ft/wVc9LUw78pWd3d2s5SyPqDivxGvdZDkgeS5LzVzLptiKy6aHk9RabAUCa1YK95+wT9B+B9tVB06Ai7jXFSmsIyWCEMDC1KFUEWoidCB+3bv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760183870; c=relaxed/simple;
	bh=oBR1NlmsqD22Ll5n/jjPEM39WICwDEtzGeqrz8rN3UA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KFoFaz8HbuK6YH5dT50wwo+TwUcF4rjTGvUZhmug15/nGfQOf60HnOFBMDhbOOKKG92Rky6vobJ+fUd4xg1J4OXlKh4P2KWJuPkrVliXgKGs6pKJMIgzlGpSFseXLKc2dqtx7srkiFHp5dpdWYTYRsvB5xV9a+l/cGFaxoTh55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWAqsgO1; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-870d82c566fso1529076785a.1
        for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760183864; x=1760788664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TuAxqE5vMGFj6sGjfiUrpGMMoPyrQusYD7Fz1TAJu2s=;
        b=QWAqsgO1jNngoJ8R7P/VZt8zmTjiSNdJvIsNjP86eN42GL2/iZqw5q2jFJKy7gtUu7
         MWdO9jiMacKLWiFIDCnDuGf18aMDCyvZmFaM5oEfy+WwQZ1bN7JgLRuiI7BJpoKPMlh4
         yXbJIizkpPfp94uUeDuJVfEgU4ITnnnoz1kZ3N67CIv4/bA65O/s7GCpEXdq9BblXyUx
         i58QuGeczYVgfh59qbD/NuXu4aD+QwO7t0Bfp84Yvg0lPaOxGKmXvIQYRuSr585picND
         jkG8PDpNOvUNaME6qR6DaD54O8Yx92uIzLU9Sv5EKlzfrk0XD+dCzzS96wYt/yPRIh5w
         2Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760183864; x=1760788664;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuAxqE5vMGFj6sGjfiUrpGMMoPyrQusYD7Fz1TAJu2s=;
        b=HMamxKA11wocbhtxneUAw7EjEo6/iKzv/KMHgr4p6dcVlAWsMPG+xXb4sohQUaexnV
         9Iq2N17j+9U6tfjwnkT6EKR6rDQIM8BXdZATwLvvXop9RpfnE5pLNIT1RZp+DRKTCM9W
         Kzh+cruhHeN9Qmp6+80EecEkXGi1o6RvI6BfDI14PkgHv9SaJwcvP0sFuEvTgusZG/hr
         +Tau5GUOrLTX4j1y6Jtvb4H3M6RkzDMbLjTcjJ+DnV5SkCoGJj45GreBIWV5pYkqQr8V
         fwHkJWJqbXjfsReIFSODPUXiYVlcOfKQfQ35pOHMO5MiBzchFGbyAmSqnYIxF3erBupR
         9LWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd2nB9JG55BwTT4lXXSJwIkUBO8DAftVtqimZLA0idzqCVYrik5yM+9sgKZdSoKF3CMPPaQRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqq/Eh+CJdy4KiCqYM+vB9kA+0BQqUGa+EVzeyIgW2EMprTdzq
	yIsIuOzgRn+8Q+BqxDNqDrgDhA2gqpqC/kF/+4CPoBaZCJTYcDL1BgxAegCmU3lK2cdUuQSkvZU
	77rFOFZe5KfPASQ==
X-Google-Smtp-Source: AGHT+IFrhz/IZ18FQfBacPDGdJosOu4hKxTmXmBeXH7k9i2zn/fihkPAlMUwNGOhy/JxQCeX6nVqqZ/eBjh1Ww==
X-Received: from qknpw7.prod.google.com ([2002:a05:620a:63c7:b0:884:b2d7:4260])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a04:b0:849:c282:d507 with SMTP id af79cd13be357-8836f56fee1mr1737272085a.42.1760183864287;
 Sat, 11 Oct 2025 04:57:44 -0700 (PDT)
Date: Sat, 11 Oct 2025 11:57:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251011115742.1245771-1-edumazet@google.com>
Subject: [PATCH net] tcp: fix tcp_tso_should_defer() vs large RTT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Neal reported that using neper tcp_stream with TCP_TX_DELAY
set to 50ms would often lead to flows stuck in a small cwnd mode,
regardless of the congestion control.

While tcp_stream sets TCP_TX_DELAY too late after the connect(),
it highlighted two kernel bugs.

The following heuristic in tcp_tso_should_defer() seems wrong
for large RTT:

delta = tp->tcp_clock_cache - head->tstamp;
/* If next ACK is likely to come too late (half srtt), do not defer */
if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
      goto send_now;

If next ACK is expected to come in more than 1 ms, we should
not defer because we prefer a smooth ACK clocking.

While blamed commit was a step in the good direction, it was not
generic enough.

Another patch fixing TCP_TX_DELAY for established flows
will be proposed when net-next reopens.

Fixes: 50c8339e9299 ("tcp: tso: restore IW10 after TSO autosizing")
Reported-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb3576ac0ad7d7330ef272e1d9dc1f19bb8f86bb..bbeed379a3c5342c7de0d2416f97ad944e3e35b0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2369,7 +2369,8 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 				 u32 max_segs)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 send_win, cong_win, limit, in_flight;
+	u32 send_win, cong_win, limit, in_flight, threshold;
+	u64 srtt_in_ns, expected_ack, how_far_is_the_ack;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *head;
 	int win_divisor;
@@ -2431,10 +2432,20 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	head = tcp_rtx_queue_head(sk);
 	if (!head)
 		goto send_now;
-	delta = tp->tcp_clock_cache - head->tstamp;
-	/* If next ACK is likely to come too late (half srtt), do not defer */
-	if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
-		goto send_now;
+
+	srtt_in_ns = (u64)(NSEC_PER_USEC >> 3) * tp->srtt_us;
+	/* When is the ACK expected ? */
+	expected_ack = head->tstamp + srtt_in_ns;
+	/* How far from now is the ACK expected ? */
+	how_far_is_the_ack = expected_ack - tp->tcp_clock_cache;
+
+	/* If next ACK is likely to come too late,
+	 * ie in more than min(1ms, half srtt), do not defer.
+	 */
+	threshold = min(srtt_in_ns >> 1, NSEC_PER_MSEC);
+
+	if ((s64)(how_far_is_the_ack - threshold) > 0)
+	     goto send_now;
 
 	/* Ok, it looks like it is advisable to defer.
 	 * Three cases are tracked :
-- 
2.51.0.740.g6adb054d12-goog


