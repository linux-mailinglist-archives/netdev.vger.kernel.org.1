Return-Path: <netdev+bounces-190239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0967EAB5D39
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763777AAD57
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50C2C0316;
	Tue, 13 May 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlxxYFVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA62C0308
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165167; cv=none; b=FGjaGEbrOl1LSWfULiKRT9hLFr9soYSpsWi8ZN3N9U4aCsfv8577omykVal8xxvExuO4oMRwFALsKqexjJPZqdn7GmW2knzIhsjPsPmxj+32Hde6R9vchei61XOm9EteZxXYe5G0Yb5poawB0DwN41b2a+xfJvFaIAip0m5Sq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165167; c=relaxed/simple;
	bh=jRf+7u2RRwLwqhHuyF2nxThNpgy4+RbQT87f1pvQDFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LgaxHurzAyWVKFHRnxUcPHqpboyi4spWs9FT4m0o1fnfTRyuAtnR+LuyDDBvoS4tzHErMOOBnUiZw9wsJ9WFATh0UYrHmsJpkW/yBxz5x1FR94gP+sKNgoS6jFYOXh0P30HCsQN5oe6Zhj50JzS/NKmxuDOQo0+aMUM8jQm16ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlxxYFVI; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4768488f4d7so94530181cf.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165165; x=1747769965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1FgGYRDaK/k/JF69BopcGQ4G8P4d4JO8HvYicn5zc2g=;
        b=BlxxYFVIMlPIBhA+rA9iro8Ffo2RfIKYFwPp1dUZprWAdqVk1PmTNs3E4ZbqL2VkxD
         0L3liZCEvTn/2pGbBjbzZpPsk/xAP8C63TcpbmEDo78h1pUdd0r45NxfCxkl09UJLAPb
         3dukxEma1pSJqFpDZHAZjUqLIJtmHYRLxJSPNW6jMYAMhOlD1iBtG0g43GDe2175BA5f
         0IPF9dr8MbmRgIGRyrzfUlLB3kCYWHyhKF0FgwG3xgLa8HjOZNujIrHzu1gxVRn1AldF
         u/N6P0qpWnIqFkeYnMZky/9ztXiBuDORc0nLiDs52jjJB6VwAG13pkftCZeRi4Gkq5OS
         NiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165165; x=1747769965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FgGYRDaK/k/JF69BopcGQ4G8P4d4JO8HvYicn5zc2g=;
        b=POT6gtMoVG17508OEXhdRXnQKj0k7D7T9lk5iluKDfcgR3I11eGmjnTHz2/jbm3zdF
         DY1o/C4nmomMzFOGY7OLuG30lyNVq3+PpFAKbePsPPPWa1ilJJDXAV/eEGeK8s1kb4lI
         93y1NsV/EUfsSk+QwET/Ajiw8BHT8Zf5VmMtG5v2BYPw4aHBxIpiK1H9txylJsRl/TUd
         s218jbTDu2QAMCDYnSLjDua3gw3EIejZfNTTd6Blx4vUhB6OcCt/ijrqSHkg2bn2FHPO
         y+KcS7KzhArr/sLTGyKVZXLkViXeHnvmI8pJD8XTdeQQoO5D7A56Ovx9ypuauL9z3iSB
         nu2g==
X-Forwarded-Encrypted: i=1; AJvYcCU6GR3ZxIdrWp8I0Rijkq9VMwM11CtsLFL9ttGge+MJRTAvvCwNDeJEKqLlTcuGMh6d7M5tG60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYWlCG52/gLCic0fchVSRiwGsu0QtK6Pb7vRlGk9yoZWWvAAE
	vJHqKrgzqWfeSoOYwhwYPqNWZwq6i5eCiuxThrysK9sIecq/8+hDIasR8gAj+TxkWiGyzv2SU4S
	6XVxMS/oRNg==
X-Google-Smtp-Source: AGHT+IHBmUYXsMcG7Tmc/2G7+5jIaCihnPa3/WLLjgmIeHbmhaA0bFjS0TBG3B3VqmrKCafvN01XAMUSjnFx+w==
X-Received: from qtbeo15.prod.google.com ([2002:a05:622a:544f:b0:479:157e:a318])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:22a9:b0:494:599c:e7c8 with SMTP id d75a77b69052e-49495cdf55fmr12553291cf.37.1747165164934;
 Tue, 13 May 2025 12:39:24 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:10 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-3-edumazet@google.com>
Subject: [PATCH net-next 02/11] tcp: fix sk_rcvbuf overshoot
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Current autosizing in tcp_rcv_space_adjust() is too aggressive.

Instead of betting on possible losses and over estimate BDP,
it is better to only account for slow start.

The following patch is then adding a more precise tuning
in the events of packet losses.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 59 +++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 88beb6d0f7b5981e65937a6727a1111fd341335b..89e886bb0fa11666ca4b51b032d536f233078dca 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -747,6 +747,29 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 	}
 }
 
+static void tcp_rcvbuf_grow(struct sock *sk)
+{
+	const struct net *net = sock_net(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	int rcvwin, rcvbuf, cap;
+
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
+	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
+		return;
+
+	/* slow start: allow the sender to double its rate. */
+	rcvwin = tp->rcvq_space.space << 1;
+
+	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
+
+	rcvbuf = min_t(u32, tcp_space_from_win(sk, rcvwin), cap);
+	if (rcvbuf > sk->sk_rcvbuf) {
+		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
+		/* Make the window clamp follow along.  */
+		WRITE_ONCE(tp->window_clamp,
+			   tcp_win_from_space(sk, rcvbuf));
+	}
+}
 /*
  * This function should be called every time data is copied to user space.
  * It calculates the appropriate TCP receive buffer space.
@@ -771,42 +794,10 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 	trace_tcp_rcvbuf_grow(sk, time);
 
-	/* A bit of theory :
-	 * copied = bytes received in previous RTT, our base window
-	 * To cope with packet losses, we need a 2x factor
-	 * To cope with slow start, and sender growing its cwin by 100 %
-	 * every RTT, we need a 4x factor, because the ACK we are sending
-	 * now is for the next RTT, not the current one :
-	 * <prev RTT . ><current RTT .. ><next RTT .... >
-	 */
-
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
-	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		u64 rcvwin, grow;
-		int rcvbuf;
-
-		/* minimal window to cope with packet losses, assuming
-		 * steady state. Add some cushion because of small variations.
-		 */
-		rcvwin = ((u64)copied << 1) + 16 * tp->advmss;
-
-		/* Accommodate for sender rate increase (eg. slow start) */
-		grow = rcvwin * (copied - tp->rcvq_space.space);
-		do_div(grow, tp->rcvq_space.space);
-		rcvwin += (grow << 1);
-
-		rcvbuf = min_t(u64, tcp_space_from_win(sk, rcvwin),
-			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
-		if (rcvbuf > sk->sk_rcvbuf) {
-			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
-
-			/* Make the window clamp follow along.  */
-			WRITE_ONCE(tp->window_clamp,
-				   tcp_win_from_space(sk, rcvbuf));
-		}
-	}
 	tp->rcvq_space.space = copied;
 
+	tcp_rcvbuf_grow(sk);
+
 new_measure:
 	tp->rcvq_space.seq = tp->copied_seq;
 	tp->rcvq_space.time = tp->tcp_mstamp;
-- 
2.49.0.1045.g170613ef41-goog


