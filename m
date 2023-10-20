Return-Path: <netdev+bounces-43023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238527D1006
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69752821F4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9711A721;
	Fri, 20 Oct 2023 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0kZRhHV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A121C2A4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:07 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2C99F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cfec5e73dso184847276.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806685; x=1698411485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=02DDzjYqg6linF5vGARgW5m1vaLNWs9el4aSYve3p2U=;
        b=Z0kZRhHV6hAoo7NprhqXZGA3+tAL9onC3xyNANtGo+LAQG/mJZbANiBrsXbY+xndWH
         OMz7irIZDusmIza+TyfBw216sxwQkwMhohPIUQZ4+eyz78bXpAF9CDUgQnklmVrVVchm
         fMqJiHVFYP1vu4egXvpK3P9gQskmak8XtMB00CSyR7FDY0G5grfS56RXWI7QqrC+tNEB
         NvOq1ToWHbFIvX4BlPF41PoXXluDRQ00ABqBzMuaQWth7FO4VUVr7eYtMML0ymS7QZwm
         Jmlekihgk3lpASLxOREOzwLlPyXUNVehzdI2CKdV18Mo0Dri6tl9sVX53sBDoXPUmHR9
         irYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806685; x=1698411485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02DDzjYqg6linF5vGARgW5m1vaLNWs9el4aSYve3p2U=;
        b=r3aIVhD+MLeCwqJ9yDJPLw+6jsfCQpM3Zheyv3NoaXb5trcChCpqFajsCaoDhmBFSN
         KRPSc8+AaQfD9Zyha49GBYXgYGY+oluaQpKwKa8djCa8a5hhx2UB5VINEf7W3PZu0Mx3
         /l6IODKwKUU77POx5BC/LmLdNYqAXWEb2fJydGH3PJULiYejLmG4vUQ77mU17RWXlnOD
         syfqfbwMJU1FcPyA4UoOj8Un2Vy1SU6j3CEH6bnIrAnMDrWORgbORviVSTtZ55Y/11WI
         mrYlkD6MvY6G1YzsaV19BbredC9VexITsGd9QY+ckMwjY2ZiMYF39I0axSsRkFqEHs1s
         GmUg==
X-Gm-Message-State: AOJu0YzrquXonFoYv5KQi5RIwksCun5gug6/n8UVBNmcHfBMS92+kyCo
	3hdv7NEo758jhZppu8mONNe1pFLin//opg==
X-Google-Smtp-Source: AGHT+IHXcIiD/t/mEQg/IjAuSYIeOtJe8Rap1fB7N6OSEOL/LnSYZZMrK4rgBkIycNRyIRHFFjrDVebbgrJ61w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1083:b0:d9a:47ea:69a5 with SMTP
 id v3-20020a056902108300b00d9a47ea69a5mr50083ybu.1.1697806685440; Fri, 20 Oct
 2023 05:58:05 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:44 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-10-edumazet@google.com>
Subject: [PATCH net-next 09/13] tcp: add tcp_rtt_tsopt_us()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Before adding usec TS support, add tcp_rtt_tsopt_us() helper
to factorize code.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7e38fc1d62ff16d7afd7f2ba58a1990f01e17b6..5666f61371678ce1c7bf466e0d54c0b7a396841b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -693,6 +693,21 @@ static inline void tcp_rcv_rtt_measure(struct tcp_sock *tp)
 	tp->rcv_rtt_est.time = tp->tcp_mstamp;
 }
 
+static s32 tcp_rtt_tsopt_us(const struct tcp_sock *tp)
+{
+	u32 delta, delta_us;
+
+	delta = tcp_time_stamp_ts(tp) - tp->rx_opt.rcv_tsecr;
+
+	if (likely(delta < INT_MAX / (USEC_PER_SEC / TCP_TS_HZ))) {
+		if (!delta)
+			delta = 1;
+		delta_us = delta * (USEC_PER_SEC / TCP_TS_HZ);
+		return delta_us;
+	}
+	return -1;
+}
+
 static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 					  const struct sk_buff *skb)
 {
@@ -704,15 +719,10 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 
 	if (TCP_SKB_CB(skb)->end_seq -
 	    TCP_SKB_CB(skb)->seq >= inet_csk(sk)->icsk_ack.rcv_mss) {
-		u32 delta = tcp_time_stamp_ts(tp) - tp->rx_opt.rcv_tsecr;
-		u32 delta_us;
-
-		if (likely(delta < INT_MAX / (USEC_PER_SEC / TCP_TS_HZ))) {
-			if (!delta)
-				delta = 1;
-			delta_us = delta * (USEC_PER_SEC / TCP_TS_HZ);
-			tcp_rcv_rtt_update(tp, delta_us, 0);
-		}
+		s32 delta = tcp_rtt_tsopt_us(tp);
+
+		if (delta >= 0)
+			tcp_rcv_rtt_update(tp, delta, 0);
 	}
 }
 
@@ -3146,17 +3156,10 @@ static bool tcp_ack_update_rtt(struct sock *sk, const int flag,
 	 * left edge of the send window.
 	 * See draft-ietf-tcplw-high-performance-00, section 3.3.
 	 */
-	if (seq_rtt_us < 0 && tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
-	    flag & FLAG_ACKED) {
-		u32 delta = tcp_time_stamp_ts(tp) - tp->rx_opt.rcv_tsecr;
-
-		if (likely(delta < INT_MAX / (USEC_PER_SEC / TCP_TS_HZ))) {
-			if (!delta)
-				delta = 1;
-			seq_rtt_us = delta * (USEC_PER_SEC / TCP_TS_HZ);
-			ca_rtt_us = seq_rtt_us;
-		}
-	}
+	if (seq_rtt_us < 0 && tp->rx_opt.saw_tstamp &&
+	    tp->rx_opt.rcv_tsecr && flag & FLAG_ACKED)
+		seq_rtt_us = ca_rtt_us = tcp_rtt_tsopt_us(tp);
+
 	rs->rtt_us = ca_rtt_us; /* RTT of last (S)ACKed packet (or -1) */
 	if (seq_rtt_us < 0)
 		return false;
-- 
2.42.0.655.g421f12c284-goog


