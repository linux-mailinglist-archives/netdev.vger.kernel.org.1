Return-Path: <netdev+bounces-164050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F1A2C724
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0433ACA22
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B722405EA;
	Fri,  7 Feb 2025 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FScRAZNW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079B1F754E
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942118; cv=none; b=GMo8OAPnuZGDcmublwl/nStr7v97PNl9Fzj9CJqdpietShyGdAaK8JQuAZLCt4GMuDU5me0pKinGkgHFhi35ZXUX4nFhLnNMNfmcqKw4Goe6A98GPtuzdhTxk4qbQBq3mT4S6Xf4IJngjD7eHDEFbpRldjRnu3ak8GBPKDwgC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942118; c=relaxed/simple;
	bh=jFXxBQsONBwbkBGOgXmwfwpZfVZ3xvNrYhj3kTYM4jQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ffWeoX9iVauYlynu3c8HskUYOdmeg28Gfnh8JApZK5+iF9G0F8N8vsb+gPZKevSDS3oVtxE2YU9OBd5snWK02VzQlPtnGT007fZRlUfdkVVeamykmVXhNAQnkvkyXrksUiFU3C55sbbE+/cK7KsReiHI0pqtWkXyG5kIfV+TOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FScRAZNW; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4679db55860so45241191cf.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942115; x=1739546915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAvQy7+WB1xmbuLj6ApU1xqzkIVeiITuJCh5i5Z/wqY=;
        b=FScRAZNW2fXANCcP+jHbLsYxb5CsisOkLcTpLViHgrz61xE/cyA47oS6tLNBI/znOE
         8fc11MZHeAp9l3f8bf/KluzeFXUlG7HhpZwf4eD6YnIEJFgIqejfpHSyQ0EALwNHmu8e
         gHuCjV4aljmZpiZ18wTbdhRdSeSgNq/zm7+wmphDJMvOctsqDZvtaXRV9d27gCqCEyuc
         2SjOzggINNn8z08LDiRs0YzAzQvD0Diiwh8r1WeMqAWHKM6mDLw+th42zpkE3adjfDhK
         BaIzBa1q+uMs5z7tgoozTxelNvBB/49K5Rl9XyBinCDds54R8JCuHNFsjQItHXHzO313
         bQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942115; x=1739546915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAvQy7+WB1xmbuLj6ApU1xqzkIVeiITuJCh5i5Z/wqY=;
        b=ckTknUl2wyBlnSN9Jag6rh4+8ck2voll9IKppe/o37ER0SDZxcWXEE26U1Ue3FDimP
         3YZ3piDq/kbMsk1KScVtc5ME3CwMXO6EwxoezzF/DPSkc5mglwjJhoGOzOD9MimLudV3
         M3YDrUe3/ceH1YFfziXHlSiKFx3lopAhTdwiX+30Zbahg6EZ+JRsfM5pNiCkjjzw7v86
         v4YgmZGLq9DhCr1QGj8FuT+dI6LAnKDfFDIlNYQtSy/mJgMsC8Yd89ytGKZxUGbxSprx
         g0IBxEP620ZU1Nnh9q+3GlL7ncCkmvD6YAD2JnpqBqZXTkM5dNIsfOCTL/WyTNeXH+OB
         kRXg==
X-Gm-Message-State: AOJu0Yyk2uRH72GMny/hl0ZMPMfRQbpktqVdSdGaQ5qG2ySY6NR0+16F
	yTCoeg3rqnTre56DSbdDR/xeJWn6zuVKiSC2Nrnw/sL57ibRJugYNarIHhh/CjwUzIfZFI07wvz
	rm8lz/RzDTw==
X-Google-Smtp-Source: AGHT+IFNnf4HTKczdqOCCiA/3CClEqSjtxgpXcDE1mkNfNJ1IQURuiSA/cBiTyVctCDbrVfhfu9ZCCKlKlXJSw==
X-Received: from qtku15.prod.google.com ([2002:a05:622a:17cf:b0:467:9ddd:c373])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d4:b0:467:451b:eba3 with SMTP id d75a77b69052e-47167a683e0mr47268701cf.8.1738942115431;
 Fri, 07 Feb 2025 07:28:35 -0800 (PST)
Date: Fri,  7 Feb 2025 15:28:27 +0000
In-Reply-To: <20250207152830.2527578-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207152830.2527578-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] tcp: add a @pace_delay parameter to tcp_reset_xmit_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to factorize calls to inet_csk_reset_xmit_timer(),
to ease TCP_RTO_MAX change.

Current users want to add tcp_pacing_delay(sk)
to the timeout.

Remaining calls to inet_csk_reset_xmit_timer()
do not add the pacing delay. Following patch
will convert them, passing false for @pace_delay.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 10 ++++++----
 net/ipv4/tcp_input.c  |  4 ++--
 net/ipv4/tcp_output.c |  6 +++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 356f5aa51ce22921320e34adec111fc4e412de8f..9472ec438aaa53580bd2f6d5b320005e6dcceb29 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1422,10 +1422,12 @@ static inline unsigned long tcp_pacing_delay(const struct sock *sk)
 
 static inline void tcp_reset_xmit_timer(struct sock *sk,
 					const int what,
-					unsigned long when)
+					unsigned long when,
+					bool pace_delay)
 {
-	inet_csk_reset_xmit_timer(sk, what, when + tcp_pacing_delay(sk),
-				  TCP_RTO_MAX);
+	if (pace_delay)
+		when += tcp_pacing_delay(sk);
+	inet_csk_reset_xmit_timer(sk, what, when, TCP_RTO_MAX);
 }
 
 /* Something is really bad, we could not queue an additional packet,
@@ -1454,7 +1456,7 @@ static inline void tcp_check_probe_timer(struct sock *sk)
 {
 	if (!tcp_sk(sk)->packets_out && !inet_csk(sk)->icsk_pending)
 		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0,
-				     tcp_probe0_base(sk));
+				     tcp_probe0_base(sk), true);
 }
 
 static inline void tcp_init_wl(struct tcp_sock *tp, u32 seq)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cf5cb710f202b29563de51179eaed0823aff8090..dc872728589fec5753e1bea9b89804731f284d05 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3282,7 +3282,7 @@ void tcp_rearm_rto(struct sock *sk)
 			 */
 			rto = usecs_to_jiffies(max_t(int, delta_us, 1));
 		}
-		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto);
+		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto, true);
 	}
 }
 
@@ -3562,7 +3562,7 @@ static void tcp_ack_probe(struct sock *sk)
 		unsigned long when = tcp_probe0_when(sk, TCP_RTO_MAX);
 
 		when = tcp_clamp_probe0_to_user_timeout(sk, when);
-		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when);
+		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when, true);
 	}
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 93401dbf39d223a4943579786be5aa6d14e0ed8d..ea5104952a053c17f5522e78d2b557a01389bc4d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2911,7 +2911,7 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 	if (rto_delta_us > 0)
 		timeout = min_t(u32, timeout, usecs_to_jiffies(rto_delta_us));
 
-	tcp_reset_xmit_timer(sk, ICSK_TIME_LOSS_PROBE, timeout);
+	tcp_reset_xmit_timer(sk, ICSK_TIME_LOSS_PROBE, timeout, true);
 	return true;
 }
 
@@ -3545,7 +3545,7 @@ void tcp_xmit_retransmit_queue(struct sock *sk)
 	}
 	if (rearm_timer)
 		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-				     inet_csk(sk)->icsk_rto);
+				     inet_csk(sk)->icsk_rto, true);
 }
 
 /* We allow to exceed memory limits for FIN packets to expedite
@@ -4401,7 +4401,7 @@ void tcp_send_probe0(struct sock *sk)
 	}
 
 	timeout = tcp_clamp_probe0_to_user_timeout(sk, timeout);
-	tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, timeout);
+	tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, timeout, true);
 }
 
 int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
-- 
2.48.1.502.g6dc24dfdaf-goog


