Return-Path: <netdev+bounces-296549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HiT6EDC/Jmr4cAIAu9opvQ
	(envelope-from <netdev+bounces-296549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:10:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CED365676F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:10:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MAun5uOJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296549-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296549-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AEB73006218
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DC42F5A13;
	Mon,  8 Jun 2026 13:09:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA722BE7AB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:09:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924180; cv=none; b=NXlK81YJ0cUugN1LW3nfnsjH4rl1Ugj5MQxowyUEInLvYaWNz+tKV7Utx8JGA9KRYQKQsCP26DQmXc5XeyRkMS2J4uAKJs29jw3VpHiMsAe0JJhwNkcNXuw+PjDcCob3mnZzbDJm/8vgszcTlrilBHBsTpXsyjqNGZIQvwUX7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924180; c=relaxed/simple;
	bh=lRazxOF33TypZQ+yoZuOMlFEutzYMuetWHVfX/sUbvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXS9NmY/E+6zWHPYLu2kjpYuFOP7KYY1zXaDr7Lo+ABz7sL6YKeiZnG439Gb5hXS2/6xFD0oUq7KgCejC/Ze/QZGAp4TVTyNkKbudGGJzV4AUr3ZNb2QBER+Nkq/MIJRMnY/aFrSi83Q8/imKZsT4hVtqNUTvKPB1nt1ZknSb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAun5uOJ; arc=none smtp.client-ip=209.85.221.67
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45ef5b33e73so262825f8f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924177; x=1781528977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRnX6fgWadYrHNX2ai/38vXCw1N7+Aa0KSotiSXq08k=;
        b=MAun5uOJ8twoP8E+XHOrGuMt0oxJIo0tDM05l9id9ZaQmlStFLSC1Z7i7usMK2HPRL
         BBvD32KBolsYdwMHh74taLHHrrIAbWRG66/NswJbQLKWMq8362WzXmTLvP4fP2mczuLO
         kXqnbtj/yhfqGgSAEvK7AcwMn2Xz1F2EKJHP5/K1ljN76TTvj+sweNqFE0FBEOESPDCU
         4e0xMbmMVuLAjxH2MEZ4n4xuutMK6kFBG/+J3gBxRDinGgo9G+xw8An5VBP3DTxMbpVM
         ocqwO2nD4RhjA3c3zNevv2dgOojUb+10gVELklQPAu7/NGFJ/3ION2wnW60RzY8d18ws
         WeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924177; x=1781528977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRnX6fgWadYrHNX2ai/38vXCw1N7+Aa0KSotiSXq08k=;
        b=A1DOLRXHVwMBc2nZUqR7DMftt176lV/gIl5ybWCiVDZRfh8cfZqkNsEd1CPBY2Bs5n
         QtVjBSzHTr15YlvB9gSRZA/Fm8AMW4wtLCS+uZ8ROj3Dm/oBx4Eg/nmm3XAp7KIsDPqC
         vU4miHYR8HsWynzAohXEfZOEBiHUlkMwM1dUIy9QnoRUT5ddGjc2axcIJfwUawV3F9Zw
         cTLPtMZ1nCArrVFSqsnYMy4dRVj9CmtRHR5FGNnGxF42zbuw0Uea/XgFzU8EhxAbY4OR
         so560w0z/wK7O4gUPnQ5igxfueMZsjot/6rc+L23pgtPputH6428DChUg7EatXsDlFnT
         AKoQ==
X-Gm-Message-State: AOJu0YyA5rlUnGGZYpI9cptmxUt5F/dtzDmYSlIskrUkOcAAYZOKUotT
	HWJB3ldFSecit5cmv0U7CVdqaJkTVg2vxvV6PoZ8VQDy6Ov/0ypaW4q1E0Az4S3M
X-Gm-Gg: Acq92OGpKWr0/Nrku8PfoUiiqPsma6dGsQRPsFTN8rTA/p7ZzUqDb1250JfqqBvucY8
	ouW/zipGBC7Yaao9LN8sNtWrGGlXD5sS2qWqDG/dCb91kb1K58qzJkYW3K7x34T4KXU4DKhaYhU
	AS+i5okxWYEujxv8Zad5GDHMzuIQGjWwo3aM4WJ2oPVAMUUBShWLX2wP5jLVz/zZj7NOVvEcciG
	5HEYiIISNpGpxTrTHoIK9hXTA+HIWIquuUg2o3Tfo+dNcLbzUi8p1ZdyD9QtM5UqsdU8MQ1EmDT
	dMRvQqwd0TA430wgNf5BXNSCsj06U1nxBERSrdqfbz8xO/OmS2Ky9KHYHFA6+0zfLC3YStiaBgv
	hIz8aHc5rBAfVlEvbX3Jo6ejmef1QEA8jhaVpFzmEhdye/N9r/hSUlL4OsVzj57nc28epw+ZeID
	rnrGHmFNmfssntY9JEE6owHxrlIyojW4Y=
X-Received: by 2002:a05:600c:3b0c:b0:490:bbe8:c2eb with SMTP id 5b1f17b1804b1-490c2610c9amr126544395e9.8.1780924176662;
        Mon, 08 Jun 2026 06:09:36 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:09:36 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 04/10] tcp: decouple TSO segment length from MSS
Date: Mon,  8 Jun 2026 15:07:49 +0200
Message-ID: <20260608130755.5626-5-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CED365676F

This patch decouples the TSO segment length from the MSS to allow for MSS >
65535 despite the TSO segment length being capped to 16 bits. Ideally
TSO/GSO would support jumbogram segments so that the decoupling isn't
necessary, but that would require a much bigger change.

Add a new helper function tcp_tso_seglen that returns the segment length
for a given MSS, capped at 65535 - MAX_TCP_HEADER, and use it where the MSS
is treated as the segment length. This leaves enough room for TCP/IPv6
headers, including TCP options and extension headers.

Change the signatures of some functions to accept max_len instead of segs
where segs is only used to calculate the maximum length of a TSO packet.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 include/net/tcp.h     | 12 ++++++--
 net/ipv4/tcp.c        | 10 ++++---
 net/ipv4/tcp_output.c | 67 +++++++++++++++++++++++++------------------
 net/ipv4/tcp_timer.c  |  4 +--
 4 files changed, 57 insertions(+), 36 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f063eccbbba3..b3a50f6d3381 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -747,8 +747,8 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb);
 void tcp_mark_push(struct tcp_sock *tp, struct sk_buff *skb);
 void __tcp_push_pending_frames(struct sock *sk, unsigned int cur_mss,
 			       int nonagle);
-int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs);
-int tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs);
+int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int max_len);
+int tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int max_len);
 void tcp_retransmit_timer(struct sock *sk);
 void tcp_xmit_retransmit_queue(struct sock *);
 void tcp_simple_retransmit(struct sock *);
@@ -1219,6 +1219,14 @@ static inline void tcp_skb_pcount_add(struct sk_buff *skb, int segs)
 	TCP_SKB_CB(skb)->tcp_gso_segs += segs;
 }
 
+/* Return the segment length we want for the given MSS. We cap the segment
+ * length to prevent the segments from becoming jumbograms.
+ */
+static inline u16 tcp_tso_seglen(u32 mss_now)
+{
+	return min_t(u32, GSO_BY_FRAGS - MAX_TCP_HEADER, mss_now);
+}
+
 /* This is valid iff skb is in write queue and tcp_skb_pcount() > 1. */
 static inline int tcp_skb_mss(const struct sk_buff *skb)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 890182a151e1..5ac2befbdc58 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -960,6 +960,7 @@ static unsigned int tcp_xmit_size_goal(struct sock *sk, u32 mss_now,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 new_size_goal, size_goal;
+	u16 gso_size;
 
 	if (!large_allowed)
 		return mss_now;
@@ -968,12 +969,13 @@ static unsigned int tcp_xmit_size_goal(struct sock *sk, u32 mss_now,
 	new_size_goal = tcp_bound_to_half_wnd(tp, sk->sk_gso_max_size);
 
 	/* We try hard to avoid divides here */
-	size_goal = tp->gso_segs * mss_now;
+	gso_size = tcp_tso_seglen(mss_now);
+	size_goal = tp->gso_segs * gso_size;
 	if (unlikely(new_size_goal < size_goal ||
-		     new_size_goal >= size_goal + mss_now)) {
-		tp->gso_segs = min_t(u16, new_size_goal / mss_now,
+		     new_size_goal >= size_goal + gso_size)) {
+		tp->gso_segs = min_t(u16, new_size_goal / gso_size,
 				     sk->sk_gso_max_segs);
-		size_goal = tp->gso_segs * mss_now;
+		size_goal = tp->gso_segs * gso_size;
 	}
 
 	return max(size_goal, mss_now);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d3b8e61d3c5e..a66a3622006d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1748,7 +1748,7 @@ static void tcp_queue_skb(struct sock *sk, struct sk_buff *skb)
 /* Initialize TSO segments for a packet. */
 static int tcp_set_skb_tso_segs(struct sk_buff *skb, unsigned int mss_now)
 {
-	int tso_segs;
+	int tso_size, tso_segs;
 
 	if (skb->len <= mss_now) {
 		/* Avoid the costly divide in the normal
@@ -1758,8 +1758,9 @@ static int tcp_set_skb_tso_segs(struct sk_buff *skb, unsigned int mss_now)
 		tcp_skb_pcount_set(skb, 1);
 		return 1;
 	}
-	TCP_SKB_CB(skb)->tcp_gso_size = mss_now;
-	tso_segs = DIV_ROUND_UP(skb->len, mss_now);
+	tso_size = tcp_tso_seglen(mss_now);
+	TCP_SKB_CB(skb)->tcp_gso_size = tso_size;
+	tso_segs = DIV_ROUND_UP(skb->len, tso_size);
 	tcp_skb_pcount_set(skb, tso_segs);
 	return tso_segs;
 }
@@ -2207,12 +2208,14 @@ static bool tcp_minshall_check(const struct tcp_sock *tp)
  * if ((skb->len % mss) != 0)
  *        tp->snd_sml = TCP_SKB_CB(skb)->end_seq;
  * But we can avoid doing the divide again given we already have
- *  skb_pcount = skb->len / mss_now
+ *  skb_pcount = skb->len / tcp_skb_seglen(skb)
  */
 static void tcp_minshall_update(struct tcp_sock *tp, unsigned int mss_now,
 				const struct sk_buff *skb)
 {
-	if (skb->len < tcp_skb_pcount(skb) * mss_now)
+	u32 seglen = tcp_skb_pcount(skb) == 1 ? mss_now : tcp_skb_mss(skb);
+
+	if (skb->len < tcp_skb_pcount(skb) * seglen)
 		tp->snd_sml = TCP_SKB_CB(skb)->end_seq;
 }
 
@@ -2245,7 +2248,7 @@ static bool tcp_nagle_check(bool partial, const struct tcp_sock *tp,
  * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowance
  * is below 1500 bytes after 6 * ~500 usec = 3ms.
  */
-static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+static u32 tcp_tso_autosize(const struct sock *sk, unsigned int tso_size,
 			    int min_tso_segs)
 {
 	unsigned long bytes;
@@ -2259,7 +2262,7 @@ static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
 
 	bytes = min_t(unsigned long, bytes, sk->sk_gso_max_size);
 
-	return max_t(u32, bytes / mss_now, min_tso_segs);
+	return max_t(u32, bytes / tso_size, min_tso_segs);
 }
 
 /* Return the number of segments we want in the skb we are transmitting.
@@ -2274,14 +2277,14 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 			ca_ops->min_tso_segs(sk) :
 			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
 
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
+	tso_segs = tcp_tso_autosize(sk, tcp_tso_seglen(mss_now), min_tso);
 	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
 /* Returns the portion of skb which can be sent right away */
 static unsigned int tcp_mss_split_point(const struct sock *sk,
 					const struct sk_buff *skb,
-					unsigned int mss_now,
+					unsigned int seglen,
 					unsigned int max_segs,
 					int nonagle)
 {
@@ -2289,7 +2292,7 @@ static unsigned int tcp_mss_split_point(const struct sock *sk,
 	u32 partial, needed, window, max_len;
 
 	window = tcp_wnd_end(tp) - TCP_SKB_CB(skb)->seq;
-	max_len = mss_now * max_segs;
+	max_len = seglen * max_segs;
 
 	if (likely(max_len <= window && skb != tcp_write_queue_tail(sk)))
 		return max_len;
@@ -2299,7 +2302,7 @@ static unsigned int tcp_mss_split_point(const struct sock *sk,
 	if (max_len <= needed)
 		return max_len;
 
-	partial = needed % mss_now;
+	partial = needed % seglen;
 	/* If last segment is not a full MSS, check if Nagle rules allow us
 	 * to include this last segment in this skb.
 	 * Otherwise, we'll split the skb at last MSS boundary
@@ -2337,7 +2340,8 @@ static int tcp_init_tso_segs(struct sk_buff *skb, unsigned int mss_now)
 {
 	int tso_segs = tcp_skb_pcount(skb);
 
-	if (!tso_segs || (tso_segs > 1 && tcp_skb_mss(skb) != mss_now))
+	if (!tso_segs ||
+	    (tso_segs > 1 && tcp_skb_mss(skb) != tcp_tso_seglen(mss_now)))
 		return tcp_set_skb_tso_segs(skb, mss_now);
 
 	return tso_segs;
@@ -2444,7 +2448,7 @@ static int tso_fragment(struct sock *sk, struct sk_buff *skb, unsigned int len,
 static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 				 bool *is_cwnd_limited,
 				 bool *is_rwnd_limited,
-				 u32 max_segs)
+				 u32 max_len)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 	u32 send_win, cong_win, limit, in_flight, threshold;
@@ -2479,7 +2483,7 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	limit = min(send_win, cong_win);
 
 	/* If a full-sized TSO skb can be sent, do it. */
-	if (limit >= max_segs * tp->mss_cache)
+	if (limit >= max_len)
 		goto send_now;
 
 	/* Middle in queue won't get any more data, full sendable already? */
@@ -2956,10 +2960,10 @@ static void tcp_grow_skb(struct sock *sk, struct sk_buff *skb, int amount)
 static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 			   int push_one, gfp_t gfp)
 {
+	u32 cwnd_quota, max_segs, max_len;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *skb;
 	unsigned int tso_segs, sent_pkts;
-	u32 cwnd_quota, max_segs;
 	int result;
 	bool is_cwnd_limited = false, is_rwnd_limited = false;
 
@@ -3007,7 +3011,9 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 				break;
 		}
 		cwnd_quota = min(cwnd_quota, max_segs);
-		missing_bytes = cwnd_quota * mss_now - skb->len;
+
+		max_len = max(mss_now, cwnd_quota * tcp_tso_seglen(mss_now));
+		missing_bytes = max_len - skb->len;
 		if (missing_bytes > 0)
 			tcp_grow_skb(sk, skb, missing_bytes);
 
@@ -3026,13 +3032,13 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		} else {
 			if (!push_one &&
 			    tcp_tso_should_defer(sk, skb, &is_cwnd_limited,
-						 &is_rwnd_limited, max_segs))
+						 &is_rwnd_limited, max_len))
 				break;
 		}
 
 		limit = mss_now;
 		if (tso_segs > 1 && !tcp_urg_mode(tp))
-			limit = tcp_mss_split_point(sk, skb, mss_now,
+			limit = tcp_mss_split_point(sk, skb, tcp_tso_seglen(mss_now),
 						    cwnd_quota,
 						    nonagle);
 
@@ -3193,10 +3199,10 @@ void tcp_send_loss_probe(struct sock *sk)
 	if (WARN_ON(!pcount))
 		goto rearm_timer;
 
-	if ((pcount > 1) && (skb->len > (pcount - 1) * mss)) {
+	if ((pcount > 1) && (skb->len > (pcount - 1) * tcp_tso_seglen(mss))) {
 		if (unlikely(tcp_fragment(sk, TCP_FRAG_IN_RTX_QUEUE, skb,
-					  (pcount - 1) * mss, mss,
-					  GFP_ATOMIC)))
+					  (pcount - 1) *  tcp_tso_seglen(mss),
+					  mss, GFP_ATOMIC)))
 			goto rearm_timer;
 		skb = skb_rb_next(skb);
 	}
@@ -3204,7 +3210,7 @@ void tcp_send_loss_probe(struct sock *sk)
 	if (WARN_ON(!skb || !tcp_skb_pcount(skb)))
 		goto rearm_timer;
 
-	if (__tcp_retransmit_skb(sk, skb, 1))
+	if (__tcp_retransmit_skb(sk, skb, mss))
 		goto rearm_timer;
 
 	tp->tlp_retrans = 1;
@@ -3539,13 +3545,14 @@ static void tcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to,
  * state updates are done by the caller.  Returns non-zero if an
  * error occurred which prevented the send.
  */
-int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
+int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int max_len)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int cur_mss;
 	int diff, len, err;
 	int avail_wnd;
+	int segs;
 
 	/* Inconclusive MTU probe */
 	if (icsk->icsk_mtup.probe_size)
@@ -3595,7 +3602,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		avail_wnd = cur_mss;
 	}
 
-	len = cur_mss * segs;
+	len = max_len;
 	if (len > avail_wnd) {
 		len = rounddown(avail_wnd, cur_mss);
 		if (!len)
@@ -3684,10 +3691,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	return err;
 }
 
-int tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
+int tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int max_len)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	int err = __tcp_retransmit_skb(sk, skb, segs);
+	int err = __tcp_retransmit_skb(sk, skb, max_len);
 
 	if (err == 0) {
 #if FASTRETRANS_DEBUG > 0
@@ -3721,6 +3728,7 @@ void tcp_xmit_retransmit_queue(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	bool rearm_timer = false;
 	u32 max_segs;
+	u32 mss_now;
 	int mib_idx;
 
 	if (!tp->packets_out)
@@ -3728,9 +3736,11 @@ void tcp_xmit_retransmit_queue(struct sock *sk)
 
 	rtx_head = tcp_rtx_queue_head(sk);
 	skb = tp->retransmit_skb_hint ?: rtx_head;
-	max_segs = tcp_tso_segs(sk, tcp_current_mss(sk));
+	mss_now = tcp_current_mss(sk);
+	max_segs = tcp_tso_segs(sk, mss_now);
 	skb_rbtree_walk_from(skb) {
 		__u8 sacked;
+		u32 max_len;
 		int segs;
 
 		if (tcp_pacing_check(sk))
@@ -3748,6 +3758,7 @@ void tcp_xmit_retransmit_queue(struct sock *sk)
 		 * we need to make sure not sending too bigs TSO packets
 		 */
 		segs = min_t(int, segs, max_segs);
+		max_len = max_t(u32, mss_now, segs * tcp_tso_seglen(mss_now));
 
 		if (tp->retrans_out >= tp->lost_out) {
 			break;
@@ -3769,7 +3780,7 @@ void tcp_xmit_retransmit_queue(struct sock *sk)
 		if (tcp_small_queue_check(sk, skb, 1))
 			break;
 
-		if (tcp_retransmit_skb(sk, skb, segs))
+		if (tcp_retransmit_skb(sk, skb, max_len))
 			break;
 
 		NET_ADD_STATS(sock_net(sk), mib_idx, tcp_skb_pcount(skb));
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..2e5331441469 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -595,7 +595,7 @@ void tcp_retransmit_timer(struct sock *sk)
 			goto out;
 		}
 		tcp_enter_loss(sk);
-		tcp_retransmit_skb(sk, skb, 1);
+		tcp_retransmit_skb(sk, skb, tcp_current_mss(sk));
 		__sk_dst_reset(sk);
 		goto out_reset_timer;
 	}
@@ -628,7 +628,7 @@ void tcp_retransmit_timer(struct sock *sk)
 	tcp_enter_loss(sk);
 
 	tcp_update_rto_stats(sk);
-	if (tcp_retransmit_skb(sk, tcp_rtx_queue_head(sk), 1) > 0) {
+	if (tcp_retransmit_skb(sk, tcp_rtx_queue_head(sk), tcp_current_mss(sk)) > 0) {
 		/* Retransmission failed because of local congestion,
 		 * Let senders fight for local resources conservatively.
 		 */
-- 
2.47.3


