Return-Path: <netdev+bounces-111642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAD931E98
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98889B21967
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B04405;
	Tue, 16 Jul 2024 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLv+u/fm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D06BA2F
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094852; cv=none; b=SyPpP44HhNPhBhxMBS+yW5SYoNi0t0wN5d0TNTgH7ZPrcaRqpbm9Cya0R2Fvw5Ae76YkAzB3u3CI65qF4s+WmkvsU1s7PujViYWFm+7uRLb2MHa/FhhO64JAWydSCehDvTVDjRMWH0TGa0C3F2EBbYDIhSCuBQG98lbMwAb8NW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094852; c=relaxed/simple;
	bh=uet/+OGfvg9XFYp/NRb5KWWoNPkhzgq7fQ/OeHtORM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tsxxWNhUJYFnYk6wCUQ5bfLMg6yqVDVJXf4F1Pi4kklxlyk3yyy76xleXwdIocyG5TWEfaK6now+rvHslZot/LyMSHVHvIB6w0+fMEuO8yTa/yjI/lnkz69yIvpGDPooSuoAvFiw4o/NQ1ckup9GsO+DXkbxV0r3gmyaTgVQIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLv+u/fm; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6b61dbb0005so74088516d6.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721094850; x=1721699650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZVdMAxOwZSNDTYnIThXumSVOAN7HqZ/o4fzzTxEf0k=;
        b=FLv+u/fmDoJf8gLV+M0fzx6ns3kGDF0m10TagEk7/4dLxHoswiHQZB8WlUENhv8/nm
         qydbAKQai2kS1tblWZx/D/0/MuPO19pWMf2HdwojUhKKfoEdJeXI3wVj+gGY9kTjN/rX
         CxmKGqhRDSVAfDe2bOFQXCsogTWHwD29UX7DajJVlijW3GHDoyL3wYMsjlD7dOKJymn+
         RiIRqZxq5h4JZKevvyzmDJmJxIyV5QtfU+9Wj86nDkP2BJnxWT8Ly6e2Bzn+BEDCnWm6
         /m9NpcEYNQs6XsdzzvlYWpMUtdYFvKW2S8XVSc6zNSRV60WCVE4THdMdaVvvZ/0vlm1+
         RBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721094850; x=1721699650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZVdMAxOwZSNDTYnIThXumSVOAN7HqZ/o4fzzTxEf0k=;
        b=jbm5G2/tIgl381mfCqfzlflTr5CDIiW1rp4sqy0hl6jjsgkyPD2eQF8+UiodFktvMH
         yEtRjYoxNzKiEY23l7fCwDqmYKSj0exuJtnuPg6zvdePzAT087oMeFiBEQriPUF2kxou
         KOZOGLDLW4KlgM1OaBxLESOS+Ojhw6XCvppFXEAODo2Dmoh0UFZfxfFhLZTIn5cDrcjg
         eG+M4JsBwltOjTK23ABkDFDa6hRdDkUBX9HjaIevDR3vdeSEFiN0uUnNikQhusDNRTxg
         MjXW7ENGwWdJ57NR1XgJWplT1FLumFr7Ru8eivGh+HogUX6j48Eh8zc7bZmSsKIZBDSP
         cmRg==
X-Forwarded-Encrypted: i=1; AJvYcCXpD0XQxHzZwlXZq5Xp1bh8fq24V3TeyZk/XUVzfc5YvJrwU90NodPsBI5bm0UNdQylLCaQtp45zVnL88Rrf5YlFYga7XbG
X-Gm-Message-State: AOJu0YwpoTREG4xtRMEQOZrvLStO2Rdi8Ni825PwNNhPGd8lc3s9XeU6
	cJSXqcx+DzQxASzxDumVLyCZ13IA+hX27vIWHIUBOnMoEkFHQSEdGyPNX957Msb03yfbUQJTVQx
	l3b13OqOMLQ==
X-Google-Smtp-Source: AGHT+IHiCOMDTwpze+I0bxxw2dfcl1BNwsYMeR4VCh9WqrQUA7stzbVkArmTyvBb2tq25tbuKd8PTJl8OqZS0A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:5099:b0:6b2:b82e:78a4 with SMTP
 id 6a1803df08f44-6b77f4c8981mr151976d6.5.1721094849819; Mon, 15 Jul 2024
 18:54:09 -0700 (PDT)
Date: Tue, 16 Jul 2024 01:54:00 +0000
In-Reply-To: <20240716015401.2365503-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240716015401.2365503-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716015401.2365503-5-edumazet@google.com>
Subject: [PATCH stable-5.4 4/4] tcp: avoid too many retransmit packets
From: Eric Dumazet <edumazet@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Jon Maxwell <jmaxwell37@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

commit 97a9063518f198ec0adb2ecb89789de342bb8283 upstream.

If a TCP socket is using TCP_USER_TIMEOUT, and the other peer
retracted its window to zero, tcp_retransmit_timer() can
retransmit a packet every two jiffies (2 ms for HZ=1000),
for about 4 minutes after TCP_USER_TIMEOUT has 'expired'.

The fix is to make sure tcp_rtx_probe0_timed_out() takes
icsk->icsk_user_timeout into account.

Before blamed commit, the socket would not timeout after
icsk->icsk_user_timeout, but would use standard exponential
backoff for the retransmits.

Also worth noting that before commit e89688e3e978 ("net: tcp:
fix unexcepted socket die when snd_wnd is 0"), the issue
would last 2 minutes instead of 4.

Fixes: b701a99e431d ("tcp: Add tcp_clamp_rto_to_user_timeout() helper to improve accuracy")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jon Maxwell <jmaxwell37@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20240710001402.2758273-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_timer.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index cbd4fde47c1f8d29533bf5ce28bddf4c9a00efe7..a386e9b84984ab0be41b0c38ea015e4ae3377edf 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -437,16 +437,28 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 				     const struct sk_buff *skb)
 {
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 user_timeout = READ_ONCE(icsk->icsk_user_timeout);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	const int timeout = TCP_RTO_MAX * 2;
+	int timeout = TCP_RTO_MAX * 2;
 	u32 rtx_delta;
 	s32 rcv_delta;
 
+	if (user_timeout) {
+		/* If user application specified a TCP_USER_TIMEOUT,
+		 * it does not want win 0 packets to 'reset the timer'
+		 * while retransmits are not making progress.
+		 */
+		if (rtx_delta > user_timeout)
+			return true;
+		timeout = min_t(u32, timeout, msecs_to_jiffies(user_timeout));
+	}
+
 	/* Note: timer interrupt might have been delayed by at least one jiffy,
 	 * and tp->rcv_tstamp might very well have been written recently.
 	 * rcv_delta can thus be negative.
 	 */
-	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
+	rcv_delta = icsk->icsk_timeout - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
 
-- 
2.45.2.993.g49e7a77208-goog


