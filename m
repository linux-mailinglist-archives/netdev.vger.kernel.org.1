Return-Path: <netdev+bounces-197852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC5ADA05E
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 02:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E24317209F
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22805367;
	Sun, 15 Jun 2025 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMYLZrv4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8EFBF6
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749946490; cv=none; b=nuMUKiBl55CW7nc+7s5GtDnfLSGZsAZh1pR2lrk5X9DmeGVv6YxFhm3xxhYFfLiyfxRS3VIDRm33DBi0uEicvummCjsGN2taNG3vZ/gm2v4RIU3yNag9jhy5BvUcDHPCln2tr95BWRKemJ9ksGefg5kYQzBVf63Y70rWZqBfCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749946490; c=relaxed/simple;
	bh=Jewap+BEf/R8bAqwzFU4LLWMY6Kfb19uDSGbF8/I5dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtwvBIcho2oWuVK91ot4fAXT+fDiKo4pTvu/g+Ee29UmCJuEa1dov+gUr08TGp/3svdwwz7QRYcne8X9xz3GbriSp54xl7+nB/THzLiun1I5r5+Kb2gIZ3HV5/V5GB0xgYF26HGwDn6F0Nb/XxJu93pOnsEJ+SAygCD1PMu0ui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMYLZrv4; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d0a5ac00aaso57368185a.3
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749946487; x=1750551287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4r4l5XYz7MREiAo5o1ZSq4NWKnNoC2jAflvOjMy/E0=;
        b=UMYLZrv4JVzL/3/r99xvjKz9nF7Zs0zAD1viOTOqNbhVXp7rY/MCsR8tTBHPzGEmL7
         Z3fwTIj97GR5e8LT98Iwrja0W9mrRjhznxr3wbvY6GROVQo8U4HeuTPsGg7WUEuCdLH+
         yofk8J6tDDGchCdF6ulh0XPECpM7HVYkA44Sx+SOVdgC9/eLU6Kx5EyW8s+wC4fRqAmt
         bpzd0csoZi7TRlvP+Jf/Z0tQgEN43UUA1GUal3y2jVtLFrCwg0u0XDUWpF7oFLT5aZmu
         1d9KfqW6s+2SQru37WBzlLVXQyrIgF/ONqDHACK7n+gcjoXCPLb95rCATyot+8VSAETg
         P+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749946487; x=1750551287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4r4l5XYz7MREiAo5o1ZSq4NWKnNoC2jAflvOjMy/E0=;
        b=n0DUIYye5vwspO/hkn+VWMHAWarmEl9FfnGs5Csd/J2q7C7h5prT+zUZB4b2ovlDUn
         yzhqYVYmQcqjNjh4cW+kW4/2R6PNI3TbYI3t4SRJNX9ep3l4wBvVoR1kAzMgExmGK+i8
         POO4H3PkElNt8QGkU1KO6L4CFZyfr3qOPtI8ugFDNBxJs4fX0Ebzmjy70ztGkUCDQ8n+
         hHt0poHOs57LunHOaxQhdQiVu1mUeODG+dJ2YqipaE/0OPukLTlS4+Uh+gxy0HwW6BtZ
         GS/ry3YI1z3kB54i60RSJfRKkl0fWrBs4/KdrrT9a54N8V4+4HscErnAXy8vpFoaFvTG
         VnYA==
X-Gm-Message-State: AOJu0YxAt5WsQdeF8nrUi4TOyuWL/OTLz9/jsKagzF4JcZC0DHeTtqT3
	dXMl8RlrDOi4p+fUbeFS2YXUSKegmDHAwCXlHyli4KswKD1GNgiQFkvI3T0S0A==
X-Gm-Gg: ASbGncvaljke0Gl2jijA/4CBQBiHJUSdcEmq6IWikBlTWzjXshihWqwELhVOnmRxpJE
	Hx2ePhqqkzu+eF4Zasb9qq3mkVmHpOIimM+NrkJO35s6NmoIF5ZevFKZ0o2SfU8p5o7Gj8Pyhjy
	sK6L0BVfitt6imabpGJ9y8bJINBnMXaPPZsTwAUjtxaV/ERm/0QtVQnb8FPQN9orixwJIt7/O2c
	ARZmJedr6ICgcc5FLdPm7vU0pp0yTQzVH4xGakjMTrqKflcK90C0OQ8vhrdPk3E3VG2Yq0CC1bz
	Jl2GKWBVmnbLTrCXkPsOO7NmtaIM87qMqy1cjU+JX64o+cUroEEVdgFRcd61jGhow8qW4M23EsP
	C9es=
X-Google-Smtp-Source: AGHT+IEiSpUyjfWZMF26k7bJcfrGWkdrZEWGYIGCZLQWif5D/jSFlV5U4uHoWZ5I/rLFCCOI70ET3w==
X-Received: by 2002:a05:6214:29c9:b0:6fa:cdc9:8af4 with SMTP id 6a1803df08f44-6fb4778c3cbmr28933136d6.2.1749946487303;
        Sat, 14 Jun 2025 17:14:47 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:315:5a93:3ace:2771:a40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c322c0sm36194686d6.76.2025.06.14.17.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 17:14:47 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next v2 3/3] tcp: remove RFC3517/RFC6675 tcp_clear_retrans_hints_partial()
Date: Sat, 14 Jun 2025 20:14:35 -0400
Message-ID: <20250615001435.2390793-4-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250615001435.2390793-1-ncardwell.sw@gmail.com>
References: <20250615001435.2390793-1-ncardwell.sw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

Now that we have removed the RFC3517/RFC6675 hints,
tcp_clear_retrans_hints_partial() is empty, and can be removed.

Suggested-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 5 -----
 net/ipv4/tcp_input.c  | 2 --
 net/ipv4/tcp_output.c | 1 -
 3 files changed, 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f57d121837949..9f852f5f8b95e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1811,13 +1811,8 @@ static inline void tcp_mib_init(struct net *net)
 }
 
 /* from STCP */
-static inline void tcp_clear_retrans_hints_partial(struct tcp_sock *tp)
-{
-}
-
 static inline void tcp_clear_all_retrans_hints(struct tcp_sock *tp)
 {
-	tcp_clear_retrans_hints_partial(tp);
 	tp->retransmit_skb_hint = NULL;
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e8e130e946f14..05b9571c9c925 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2769,8 +2769,6 @@ void tcp_simple_retransmit(struct sock *sk)
 			tcp_mark_skb_lost(sk, skb);
 	}
 
-	tcp_clear_retrans_hints_partial(tp);
-
 	if (!tp->lost_out)
 		return;
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b0ffefe604b4c..eb50746dc4820 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3247,7 +3247,6 @@ static bool tcp_collapse_retrans(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->eor = TCP_SKB_CB(next_skb)->eor;
 
 	/* changed transmit queue under us so clear hints */
-	tcp_clear_retrans_hints_partial(tp);
 	if (next_skb == tp->retransmit_skb_hint)
 		tp->retransmit_skb_hint = skb;
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


