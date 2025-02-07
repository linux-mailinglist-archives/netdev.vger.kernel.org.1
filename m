Return-Path: <netdev+bounces-164049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F3A2C70F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D51418850FF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18DA23FC79;
	Fri,  7 Feb 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRq3hlYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27923F28C
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942116; cv=none; b=REwFtcNclW727Wt9Sk3kHtVVy67CrJQ3othWr8+S609pj65M4VRFfV+N8cqIs5eLbHan9qoRb5v68k0znEGCEUUz6PczV0j0nyZIPGEZkkv8k7bQ9DlB7rDUTp3JCfT+XHqkJTfL4XqiR1GA79Oxj8NTeeOdBIIW1It7tUdBIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942116; c=relaxed/simple;
	bh=IEIO+ZsyHOlhOT+I7Xe9TeGpieItZRSi3OfIxk3A90g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UlCyWKztnyQZdDSvwZMKySygzSJMzg7AIFJnQj1xH624kQOxy1mVutdg/6OHgyqNeQlGjEMlgzkLe4fX5kgXZHASr4eRKXBgEY7/fo6BPk2lJW0adYhaSAX5Ry/qewrp76RFTBljvPXep6ps/QNk0IZZqVT8CU7hWTWLNECUoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRq3hlYd; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e44150a32dso43419056d6.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942114; x=1739546914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjtdZgIywkKdhw+U6v/N25zweMYcOEuBKhAWh4rC2iY=;
        b=VRq3hlYdK3Lkg9WtQ5++L3G4sO7Zbr0+NC4ulZ433tBQssvFd0pNExGPEBBQDwVrlQ
         o/FLvDarwTL9ax+pTYwqhHT6YyearMqu+XV978Y/pUIdtU0R7kTqvIx5WV9mc28lv3Rb
         08urqjy/Bl4KjkVE8VuugKazfmKAuumK6livam1ZOMq9N6ItaQ5ULrKbGSM4EjnufWER
         H8M6kX7AuB/E8c3DPS2N7Z6axec3KJqdoaB9ZTjDGxChsrgAczQxlgF7UM0SGSNJNenK
         4vvNlQpY57OczJCSAZaWRB3Al9DL3F8ggvZn2W0l2bZkU84eJKxDDeap3AGb3Ih05L12
         M9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942114; x=1739546914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjtdZgIywkKdhw+U6v/N25zweMYcOEuBKhAWh4rC2iY=;
        b=t1l3L1qrnbf5hti1IDMGtdjkjFXcrjOBFCbZNbgeqW+HPBpgJgn7QQvseOWxd+NA24
         DvVZkVRT108Td1YxguZapOXU9LLlQWqRhQr8HJlBdPnaRBuA9Rhim3dxcA5LXJT5dVBs
         rOf/6+9K5vkSU8vM282iy46S82wdVvzs93+AJg4tADFXepq1tVHL21VMhsJ7ga1kMBKe
         F8+UFzEpP3CAaEOqxLXFFdNc+HxiXnqtxfVq8wzRSApK0Xpp+yhKPVvJDK0o3NPZHxzB
         5IH4p2f/9ZrrbzvO1Z5ojBxeWil4UBDZUn8dY7p5zeLFxKAjyNpdeWNKAbcFuCYw5IDr
         3Kdw==
X-Gm-Message-State: AOJu0YzecvqzS4bWR2GZ1ZT/+xCjOPiP43EaZvPNYKFSVuFKEjydHT+m
	IaaXoy278yNHJsCyObNtCngBD4DsSFbcEURYTgwao2o0setolkhfSTygNRZYoWm8Al2gp/3CEKu
	xylgXd5O2hw==
X-Google-Smtp-Source: AGHT+IFBt7fkTu/BrGAiOfqNRGD167c1HAdjYDaEhyqnyGO8rxamVJtbtlWxhEIMMihLeEPMz3Imttzy+t1cyA==
X-Received: from qvbnz11.prod.google.com ([2002:a05:6214:3a8b:b0:6e4:2ef1:361a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:27c6:b0:6d8:846b:cd8d with SMTP id 6a1803df08f44-6e4456d9ce3mr38348656d6.30.1738942114016;
 Fri, 07 Feb 2025 07:28:34 -0800 (PST)
Date: Fri,  7 Feb 2025 15:28:26 +0000
In-Reply-To: <20250207152830.2527578-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207152830.2527578-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] tcp: remove tcp_reset_xmit_timer() @max_when argument
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

All callers use TCP_RTO_MAX, we can factorize this constant,
becoming a variable soon.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 7 +++----
 net/ipv4/tcp_input.c  | 5 ++---
 net/ipv4/tcp_output.c | 7 +++----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b2b04835688f65daa25ca208e29775326520e1e..356f5aa51ce22921320e34adec111fc4e412de8f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1422,11 +1422,10 @@ static inline unsigned long tcp_pacing_delay(const struct sock *sk)
 
 static inline void tcp_reset_xmit_timer(struct sock *sk,
 					const int what,
-					unsigned long when,
-					const unsigned long max_when)
+					unsigned long when)
 {
 	inet_csk_reset_xmit_timer(sk, what, when + tcp_pacing_delay(sk),
-				  max_when);
+				  TCP_RTO_MAX);
 }
 
 /* Something is really bad, we could not queue an additional packet,
@@ -1455,7 +1454,7 @@ static inline void tcp_check_probe_timer(struct sock *sk)
 {
 	if (!tcp_sk(sk)->packets_out && !inet_csk(sk)->icsk_pending)
 		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0,
-				     tcp_probe0_base(sk), TCP_RTO_MAX);
+				     tcp_probe0_base(sk));
 }
 
 static inline void tcp_init_wl(struct tcp_sock *tp, u32 seq)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb82e01da911048b41ca380f913ef55566be79a7..cf5cb710f202b29563de51179eaed0823aff8090 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3282,8 +3282,7 @@ void tcp_rearm_rto(struct sock *sk)
 			 */
 			rto = usecs_to_jiffies(max_t(int, delta_us, 1));
 		}
-		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto,
-				     TCP_RTO_MAX);
+		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto);
 	}
 }
 
@@ -3563,7 +3562,7 @@ static void tcp_ack_probe(struct sock *sk)
 		unsigned long when = tcp_probe0_when(sk, TCP_RTO_MAX);
 
 		when = tcp_clamp_probe0_to_user_timeout(sk, when);
-		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when, TCP_RTO_MAX);
+		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when);
 	}
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bc95d2a5924fdc6ea609fa006432db9b13444706..93401dbf39d223a4943579786be5aa6d14e0ed8d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2911,7 +2911,7 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 	if (rto_delta_us > 0)
 		timeout = min_t(u32, timeout, usecs_to_jiffies(rto_delta_us));
 
-	tcp_reset_xmit_timer(sk, ICSK_TIME_LOSS_PROBE, timeout, TCP_RTO_MAX);
+	tcp_reset_xmit_timer(sk, ICSK_TIME_LOSS_PROBE, timeout);
 	return true;
 }
 
@@ -3545,8 +3545,7 @@ void tcp_xmit_retransmit_queue(struct sock *sk)
 	}
 	if (rearm_timer)
 		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-				     inet_csk(sk)->icsk_rto,
-				     TCP_RTO_MAX);
+				     inet_csk(sk)->icsk_rto);
 }
 
 /* We allow to exceed memory limits for FIN packets to expedite
@@ -4402,7 +4401,7 @@ void tcp_send_probe0(struct sock *sk)
 	}
 
 	timeout = tcp_clamp_probe0_to_user_timeout(sk, timeout);
-	tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, timeout, TCP_RTO_MAX);
+	tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, timeout);
 }
 
 int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
-- 
2.48.1.502.g6dc24dfdaf-goog


