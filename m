Return-Path: <netdev+bounces-279147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBTFE91B4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:09:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D5414787
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FF9308D6E8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125543EDABA;
	Thu, 16 Apr 2026 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSI1Ur9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51CC3E1D1F
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369816; cv=none; b=m6/fNMi7I99IcBqYP9SC/QvdZl9ztqOLN+Gzu7HbfNJ6V1f4YcQ0G6nw5dr2hPauUnPbsDOBgiOVzET+B/5UPnQKQzg/RUN6h5M05jtND02LkqSpb4XABwLvKGsaYcemH8IfRNVHtlkpfffpHo4kN6gOqF7RHJMp3mdO0fK4O80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369816; c=relaxed/simple;
	bh=cwq2iya90vysSzJUz/ny/lP7bPREp3m/3U94t+JlMvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jy6jgZ0o2TbCbJ7avcnf+ddK6i1iXFAtTvCuvchm3A4nWvG8brGQKW5U7Ly8mHSi2zEz+sOCZ8Dd//rgl1FnFJqlu1O7W9h4lJPkEYIYReD4m7u3NrO293NA8Heq0hVgDCbt5zCrSon80ftYSHwqcWv/CeMIKcui8Qn3/jNdhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSI1Ur9L; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d3bb62cd2bso2383267285a.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369806; x=1776974606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW4Y9Ecb+eenvHSDbZzqj4qxRM8FLxAcpJFzlq3TDN0=;
        b=sSI1Ur9L07mcWH/xB14igRlp4xvmDZcdtinO3kF/cmzXmlUK+owAzD4WembWotQmfl
         WM4Be4qyGrYgV8GX1yCdtiooTdcVgVScl+tN1nn6OIALyRn3/nAz2+XMXqj1NIyMowNv
         mC7DMu3lMyQIabgUrIwtD6hyTZJSpDDsjho7I+3aSNwLqsuyyFqJTZBif10AB0G4ET+8
         8RD5Kj1ZV3X/RLAPO71oORooTSi/T9qXhsXkaQPDcLs2+f25ZXUS1LNQ6jjXAqGDPg4h
         dkkvvFIpS4mh5hSS0DgPXlMXQKTtoLBqhMQw2JUSwM2Qph8waBt30e5lMZvCXS5EZf1z
         BkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369806; x=1776974606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW4Y9Ecb+eenvHSDbZzqj4qxRM8FLxAcpJFzlq3TDN0=;
        b=lcTwAWV1oRooABffapQMYR1SPr3r9qd99xxzYNU9gExqss1LSixFPSC7m87qNNao4K
         DgtxEakYwZP9Mp06Uzrls5719on9DngzJlK16Pcs+BEcrzkIdyBb70AJlNve8D2egZDn
         13ewsACnVs+rPusaRkIJ9nR0P0q+FjpkWW4rqDMwlRx3XWqzaU7NqjbZP/QeGXNss5At
         vWOch+/SD6G+LtgO78eysVSPdLGpG6TSFaJHDX/D1OGo1EjCpO7V6mL8+2i7auV8+MHC
         I52i5fJaHtw3OBtygwlKMmhL8qQ8ImCUZEKaz5oupNOD9kJ3GO/PQHPqYNB5V+Kfoxat
         6s5w==
X-Forwarded-Encrypted: i=1; AFNElJ/30mQkOhpnHchhiE4J5OCGeMehE9edm99J4vMzqfXFmnUTtqIV0Wyf8aJ2BbE6aFndYMp3EW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNp1OQuTPizbTcqzTsXvl2JwY10+SXmJT8wMui7nrKI5LORbEi
	DUWAaEhu7uvfSL6UNHGzlHZDkL0wWnXGrmq3kk608Q9941cECkX/I+zJzJiMJ9gva9eRm/2HwRI
	yCd9YnSaVNOzs3g==
X-Received: from qkau28-n1.prod.google.com ([2002:a05:620a:a1dc:10b0:8cd:90d8:e2b6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:269a:b0:8cd:9707:630e with SMTP id af79cd13be357-8e749371156mr136982585a.19.1776369805940;
 Thu, 16 Apr 2026 13:03:25 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:08 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-4-edumazet@google.com>
Subject: [PATCH net 03/14] tcp: add data-races annotations around
 tp->reordering, tp->snd_cwnd
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279147-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D2D5414787
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE(), WRITE_ONCE() data_race() annotations to keep KCSAN happy.

Fixes: bb7c19f96012 ("tcp: add related fields into SCM_TIMESTAMPING_OPT_STATS")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h      |  2 +-
 net/ipv4/tcp.c         |  8 ++++----
 net/ipv4/tcp_input.c   | 14 ++++++++------
 net/ipv4/tcp_metrics.c |  2 +-
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 674af493882c802ebe03e0cac6e40b7c704aa0de..ecbadcb3a7446cb18c245e670ba49ff574dfaff7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1513,7 +1513,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
 static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
 {
 	WARN_ON_ONCE((int)val <= 0);
-	tp->snd_cwnd = val;
+	WRITE_ONCE(tp->snd_cwnd, val);
 }
 
 static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e39e0734d958f39aa83a33f5c608ce3b94232fb1..24ba80d244b1fb69102b587b568cebe7b78dff9d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4445,13 +4445,13 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	rate64 = tcp_compute_delivery_rate(tp);
 	nla_put_u64_64bit(stats, TCP_NLA_DELIVERY_RATE, rate64, TCP_NLA_PAD);
 
-	nla_put_u32(stats, TCP_NLA_SND_CWND, tcp_snd_cwnd(tp));
-	nla_put_u32(stats, TCP_NLA_REORDERING, tp->reordering);
-	nla_put_u32(stats, TCP_NLA_MIN_RTT, tcp_min_rtt(tp));
+	nla_put_u32(stats, TCP_NLA_SND_CWND, READ_ONCE(tp->snd_cwnd));
+	nla_put_u32(stats, TCP_NLA_REORDERING, READ_ONCE(tp->reordering));
+	nla_put_u32(stats, TCP_NLA_MIN_RTT, data_race(tcp_min_rtt(tp)));
 
 	nla_put_u8(stats, TCP_NLA_RECUR_RETRANS,
 		   READ_ONCE(inet_csk(sk)->icsk_retransmits));
-	nla_put_u8(stats, TCP_NLA_DELIVERY_RATE_APP_LMT, !!tp->rate_app_limited);
+	nla_put_u8(stats, TCP_NLA_DELIVERY_RATE_APP_LMT, data_race(!!tp->rate_app_limited));
 	nla_put_u32(stats, TCP_NLA_SND_SSTHRESH, tp->snd_ssthresh);
 	nla_put_u32(stats, TCP_NLA_DELIVERED, tp->delivered);
 	nla_put_u32(stats, TCP_NLA_DELIVERED_CE, tp->delivered_ce);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 021f745747c59d8b9e200c5954af7807a4d08866..6bb6bf049a35ac91fd53e3e66691f64fc4c93648 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1293,8 +1293,9 @@ static void tcp_check_sack_reordering(struct sock *sk, const u32 low_seq,
 			 tp->sacked_out,
 			 tp->undo_marker ? tp->undo_retrans : 0);
 #endif
-		tp->reordering = min_t(u32, (metric + mss - 1) / mss,
-				       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_max_reordering));
+		WRITE_ONCE(tp->reordering,
+			   min_t(u32, (metric + mss - 1) / mss,
+				 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_max_reordering)));
 	}
 
 	/* This exciting event is worth to be remembered. 8) */
@@ -2439,8 +2440,9 @@ static void tcp_check_reno_reordering(struct sock *sk, const int addend)
 	if (!tcp_limit_reno_sacked(tp))
 		return;
 
-	tp->reordering = min_t(u32, tp->packets_out + addend,
-			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_max_reordering));
+	WRITE_ONCE(tp->reordering,
+		   min_t(u32, tp->packets_out + addend,
+			 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_max_reordering)));
 	tp->reord_seen++;
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRENOREORDER);
 }
@@ -2579,8 +2581,8 @@ void tcp_enter_loss(struct sock *sk)
 	reordering = READ_ONCE(net->ipv4.sysctl_tcp_reordering);
 	if (icsk->icsk_ca_state <= TCP_CA_Disorder &&
 	    tp->sacked_out >= reordering)
-		tp->reordering = min_t(unsigned int, tp->reordering,
-				       reordering);
+		WRITE_ONCE(tp->reordering,
+			   min_t(unsigned int, tp->reordering, reordering));
 
 	tcp_set_ca_state(sk, TCP_CA_Loss);
 	tp->high_seq = tp->snd_nxt;
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 06b1d5d3b6df7b8fa3fc631b8662160c8729a9df..7a9d6d9006f651e91054d3369b47758a6c35253b 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -496,7 +496,7 @@ void tcp_init_metrics(struct sock *sk)
 	}
 	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
 	if (val && tp->reordering != val)
-		tp->reordering = val;
+		WRITE_ONCE(tp->reordering, val);
 
 	crtt = tcp_metric_get(tm, TCP_METRIC_RTT);
 	rcu_read_unlock();
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


