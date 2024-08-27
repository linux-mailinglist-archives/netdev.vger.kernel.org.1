Return-Path: <netdev+bounces-122100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADF995FE88
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C98B2118A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 01:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC1BBE4A;
	Tue, 27 Aug 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQp0Gqkr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40717BE5D
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723576; cv=none; b=KxK2d6+FT83QYvJEKXYBSD+wc8vJ1e3S2ttLBYUMtsbNb4ve2weh5hpj6j6Pxza51IeFbf016e32JRUZrBtiVtfTco0EOQks4LAdRQhqly5frtYOl11IzxfUzRwJTd+/WrxpYohN23ZrxWZz8r4iVT28QRgchLLXocJiz48N4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723576; c=relaxed/simple;
	bh=N8nicuLCiRZlkeUxxgCwu3grDXgfOSF8wC9q+gqEMyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tw8tAUENesTopfjeLY90048IrRuzzbUm6P8SQdYOz5+LGATnyslQpOIHXC6zCZ78o+vGHMSrLiK9lKTSu9UqZqG706RIPjp7hNUqE4N0ZTKsEUneyye5qXGQvpG5xZRh2iBMWkI0zbWbgVevgwutmCTD5VRrJA4gpqLgk4o3AEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQp0Gqkr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ad9ffa0d77so109365347b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724723574; x=1725328374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hffRQ3v3sd3ifeUadUjRE0gZvpED0BVQw/7Id6v/1nE=;
        b=HQp0Gqkr1rZY0Ne4f9PZy1+91s7ysellJk4GWM5aLkxVQnRmCmRgRnBiDGdCb5kNtG
         KCNX+VL0Cs6cWSXkKu5VKMfLnhTfEP6AM5SJUcqj9VFIjtUOtYZtSNfQIpF1fb/xvwoq
         TQsL8vp+vcWRcOX7DE2aQ//HfnKMvI+UWbN7hdOtBsayx3XGlV2XAvoNYuwcglLbw6dh
         wK3gSSY7S+WMykIjWI6vcDqa8WCbLMiGqUQbvLX/zAcp14pULqPCcu3OuvgQnBzMO8Mw
         iYbEf5oQmPL6cgbVLUs/iSPo21Z9ez51mQdsN9IwfeiAM3D3OojAvKVRB29wBxGNNywt
         xXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724723574; x=1725328374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hffRQ3v3sd3ifeUadUjRE0gZvpED0BVQw/7Id6v/1nE=;
        b=nNR6r9sY/kJLWkIOTOgC9DiKLhdsgEPpSOfMZ+TxUDqqdImiZPBUe9YUHRPStjXBSP
         8hN8dajPEQXJ6yrN/qvzbZSrzJq+oxZKq9HHlIUqjKyo3vOfyrOkHyzsLU46RtuHdAoS
         EN/JBdjfNBkZZKw+nPPY5/50Vi55P986MX3WvV+tBxlLipxY5E4VUHK4ctpRJbN1lANA
         OPOxAd6dAAbtse974Tvh46/R2h18QtwSIwUVmClZk3VpQk0QSiUOUPCVpXYyZ1P63waY
         4X7kcBiAr/HqMJB9fbKSn8pudDDe0Khf6f+evdtZIl0iOZnyvW8aqozQVhOBnR8H0f4l
         SH3A==
X-Gm-Message-State: AOJu0Yx//NiWZFWv8z0T/OkK7HeIL9n3C1wvaDOrfJmt8E1qJ6BPrtK7
	uuwf50C1CfFymi5LpY76ZRSOJLG0kX+pTbw/agxtBe/Dzs/vi+nR0HaoT2Mnuco0bLiS4mf+Yg2
	mCsUh/4Kl+A==
X-Google-Smtp-Source: AGHT+IEdjYtx1WaSEXrD9CBGbed1n3t/Xa45yCn+MfEMeE2plyCMCNJFveDxbdDLh/G9zvGsAkerosoGzdAZEA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:2e90:b0:62f:1f63:ae4f with SMTP
 id 00721157ae682-6c6251a44efmr410557b3.1.1724723573771; Mon, 26 Aug 2024
 18:52:53 -0700 (PDT)
Date: Tue, 27 Aug 2024 01:52:49 +0000
In-Reply-To: <20240827015250.3509197-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827015250.3509197-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827015250.3509197-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: remove volatile qualifier on tw_substate
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using a volatile qualifier for a specific struct field is unusual.

Use instead READ_ONCE()/WRITE_ONCE() where necessary.

tcp_timewait_state_process() can change tw_substate while other
threads are reading this field.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_timewait_sock.h | 2 +-
 net/ipv4/inet_diag.c             | 4 ++--
 net/ipv4/tcp_ipv4.c              | 4 ++--
 net/ipv4/tcp_minisocks.c         | 4 ++--
 net/ipv6/tcp_ipv6.c              | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index f88b6826901275c899e79272ae39c5c4aeaaf09b..beb533a0e88098a95a1365b51bdc2d9e9dfd1d07 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -58,7 +58,7 @@ struct inet_timewait_sock {
 #define tw_dr			__tw_common.skc_tw_dr
 
 	__u32			tw_mark;
-	volatile unsigned char	tw_substate;
+	unsigned char		tw_substate;
 	unsigned char		tw_rcv_wscale;
 
 	/* Socket demultiplex comparisons on incoming packets. */
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 9712cdb8087c2349bf289efca86172eaef729a55..67639309163d05c034fad80fc9a6096c3b79d42f 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -442,7 +442,7 @@ static int inet_twsk_diag_fill(struct sock *sk,
 	inet_diag_msg_common_fill(r, sk);
 	r->idiag_retrans      = 0;
 
-	r->idiag_state	      = tw->tw_substate;
+	r->idiag_state	      = READ_ONCE(tw->tw_substate);
 	r->idiag_timer	      = 3;
 	tmo = tw->tw_timer.expires - jiffies;
 	r->idiag_expires      = jiffies_delta_to_msecs(tmo);
@@ -1209,7 +1209,7 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 			if (num < s_num)
 				goto next_normal;
 			state = (sk->sk_state == TCP_TIME_WAIT) ?
-				inet_twsk(sk)->tw_substate : sk->sk_state;
+				READ_ONCE(inet_twsk(sk)->tw_substate) : sk->sk_state;
 			if (!(idiag_states & (1 << state)))
 				goto next_normal;
 			if (r->sdiag_family != AF_UNSPEC &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5087e12209a19f4c17f0f63b8bd70fc0ec120dbf..7c29158e1abcde9049db4dbd65d9377627f61b96 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -120,7 +120,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int ts_recent_stamp;
 
-	if (tw->tw_substate == TCP_FIN_WAIT2)
+	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2)
 		reuse = 0;
 
 	if (reuse == 2) {
@@ -2948,7 +2948,7 @@ static void get_timewait4_sock(const struct inet_timewait_sock *tw,
 
 	seq_printf(f, "%4d: %08X:%04X %08X:%04X"
 		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK",
-		i, src, srcp, dest, destp, tw->tw_substate, 0, 0,
+		i, src, srcp, dest, destp, READ_ONCE(tw->tw_substate), 0, 0,
 		3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
 		refcount_read(&tw->tw_refcnt), tw);
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a19a9dbd3409fee8a13858ff7252921e73825aef..b6d547d29f9a6a91f16c5886630598079bbb50fc 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -117,7 +117,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		}
 	}
 
-	if (tw->tw_substate == TCP_FIN_WAIT2) {
+	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2) {
 		/* Just repeat all the checks of tcp_rcv_state_process() */
 
 		/* Out of window, send ACK */
@@ -150,7 +150,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 			return TCP_TW_RST;
 
 		/* FIN arrived, enter true time-wait state. */
-		tw->tw_substate	  = TCP_TIME_WAIT;
+		WRITE_ONCE(tw->tw_substate, TCP_TIME_WAIT);
 		twsk_rcv_nxt_update(tcptw, TCP_SKB_CB(skb)->end_seq);
 
 		if (tmp_opt.saw_tstamp) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 200fea92f12fc99617c64ca817ff1c44d4262085..fb2e64ce660f8f0b7fc7bf74fb88276d3e29b0be 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2258,7 +2258,7 @@ static void get_timewait6_sock(struct seq_file *seq,
 		   src->s6_addr32[2], src->s6_addr32[3], srcp,
 		   dest->s6_addr32[0], dest->s6_addr32[1],
 		   dest->s6_addr32[2], dest->s6_addr32[3], destp,
-		   tw->tw_substate, 0, 0,
+		   READ_ONCE(tw->tw_substate), 0, 0,
 		   3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
 		   refcount_read(&tw->tw_refcnt), tw);
 }
-- 
2.46.0.295.g3b9ea8a38a-goog


