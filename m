Return-Path: <netdev+bounces-122101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7A95FE8B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A1B282B40
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994CDC133;
	Tue, 27 Aug 2024 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0N+K9qY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F609479
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723578; cv=none; b=jCLClT7X9gPJAzuqAghh6WQhjw6y4c6rQmBwX0qW+MjH9nktUyyUo31/WLRkLgQu/Aq7IsEx6XQjZRJyh9Yb3mKLoYQKSIz8Y7iP/A0Cy8mVEpB8CDLJS7+gS9/fwbLpIQcrrYwUJUiAydujg5Q92xKP2LtueOUUgR7+fomiChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723578; c=relaxed/simple;
	bh=A2l7g9sTSW2FjLIqz0umxXShwhJffJsmoZv51JNk4U0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5B3pmlNnr0L800S4HpC/XVG0SA5vGNf338cKLHVX/u+msV7vF0LUn1cLmSwRp2WAZBHnBrayoGt2DsvESPDksC5Uha3SkPwTxgfR2D5K5HLP5HRnOoXjtG0URPMhRtS1YPEM2tMboMlGYNNZnkOPlpjDcdoa0xAZaRVyK6ijn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0N+K9qY; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7a1d8c45a90so644749785a.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724723576; x=1725328376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pR0YplWxZD9dhJ0VESOIl+/POrsPXpKFgbxormy6WYs=;
        b=C0N+K9qY74pAExd92YWCwtTpr7jUUDXbPi5w7eMflXSJit0M+NXqkAN3DzuP43/Fh6
         +1FpwA0Qt8ZMll/DB8DP8p9b+WZlyMm3pHfCrn/2BSnaShTVlX9I6/DzFljPDyuk67At
         5jI1743O7T1ruHHhErARDgKPlx+n3wfN9opBxltw+kI8TCV7CeNqj80QdcLVDJpKlOGr
         Fk2xNO9jpjZJNLC7ilfxXW92c3Wo0FQzC+Mmn7GWcJ3zGVHoQqiEGiM1DACb+6wk09Q5
         js0w+6GIMD8lndREalWd0O7SZkhGJjU7xgF4Ih3/DXzwZ7XTJ3SEKamit0wFFurx7XmX
         CiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724723576; x=1725328376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pR0YplWxZD9dhJ0VESOIl+/POrsPXpKFgbxormy6WYs=;
        b=lkecWGMVSiBqzQmzKGKIFMiwA+mCyiOlaViYlI7inTsfAAyfOlUG/bX1dLMYS52X59
         16dWoB+sFu0yf00GP3LBRWhV+cdZGg5S9QesMcCtPUpQ5+WVw7DM3dYxqJeiC8jqQZio
         Dg9nu2dTTSX01EPNM58akUDHZZmg2QwIC+csy/mmE0NaiCvcyjgM52Po75KAgDZwD6+a
         OAaIwt0FZ0GoldKilLmY328DZchxcfwrBEwgeZLwQMsCN7x2mlrStyO3Bu+9tafNGFYe
         x92gAeNFo4lfjkBtM/R5afNEFIwPewQXHjer3KdSNbZiOpVDunbF7h5uPr62l1IdVeFV
         BIfQ==
X-Gm-Message-State: AOJu0YxVyarcsIF2xPG3VQYSx1v5eTa44Dzg/mkYPEhIBGtNNawmM23G
	7/Ue0IeZEg0rba8i/kwUdF9MaE3SPcvCY9Tk3x0+sz8shOadu5r+IhB7au7EUEgrJP+nUE+4HNL
	9sfl50SVWiw==
X-Google-Smtp-Source: AGHT+IEvIce6GM929VxTa/4yBtbR/ej6f1g6CWscs2EN0dCnrBTDHYZJ7dEDNKXTf/Rouwvho63BjUZDGMGM7A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:2a11:b0:79d:831e:aa2d with SMTP
 id af79cd13be357-7a6896d66c5mr4695885a.2.1724723575699; Mon, 26 Aug 2024
 18:52:55 -0700 (PDT)
Date: Tue, 27 Aug 2024 01:52:50 +0000
In-Reply-To: <20240827015250.3509197-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827015250.3509197-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827015250.3509197-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: annotate data-races around tcptw->tw_rcv_nxt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

No lock protects tcp tw fields.

tcptw->tw_rcv_nxt can be changed from twsk_rcv_nxt_update()
while other threads might read this field.

Add READ_ONCE()/WRITE_ONCE() annotations, and make sure
tcp_timewait_state_process() reads tcptw->tw_rcv_nxt only once.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c      |  2 +-
 net/ipv4/tcp_minisocks.c | 27 +++++++++++++++------------
 net/ipv6/tcp_ipv6.c      |  3 ++-
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7c29158e1abcde9049db4dbd65d9377627f61b96..eb631e66ee03cacd079da5adb36d0639bcf1d9ef 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1073,7 +1073,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 	}
 
 	tcp_v4_send_ack(sk, skb,
-			tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
+			tcptw->tw_snd_nxt, READ_ONCE(tcptw->tw_rcv_nxt),
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_tw_tsval(tcptw),
 			READ_ONCE(tcptw->tw_ts_recent),
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b6d547d29f9a6a91f16c5886630598079bbb50fc..ad562272db2edd901231fdbe8f35e3a5bb077bec 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -52,16 +52,17 @@ tcp_timewait_check_oow_rate_limit(struct inet_timewait_sock *tw,
 	return TCP_TW_SUCCESS;
 }
 
-static void twsk_rcv_nxt_update(struct tcp_timewait_sock *tcptw, u32 seq)
+static void twsk_rcv_nxt_update(struct tcp_timewait_sock *tcptw, u32 seq,
+				u32 rcv_nxt)
 {
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao;
 
 	ao = rcu_dereference(tcptw->ao_info);
-	if (unlikely(ao && seq < tcptw->tw_rcv_nxt))
+	if (unlikely(ao && seq < rcv_nxt))
 		WRITE_ONCE(ao->rcv_sne, ao->rcv_sne + 1);
 #endif
-	tcptw->tw_rcv_nxt = seq;
+	WRITE_ONCE(tcptw->tw_rcv_nxt, seq);
 }
 
 /*
@@ -98,8 +99,9 @@ enum tcp_tw_status
 tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 			   const struct tcphdr *th, u32 *tw_isn)
 {
-	struct tcp_options_received tmp_opt;
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
+	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
+	struct tcp_options_received tmp_opt;
 	bool paws_reject = false;
 	int ts_recent_stamp;
 
@@ -123,20 +125,20 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		/* Out of window, send ACK */
 		if (paws_reject ||
 		    !tcp_in_window(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq,
-				   tcptw->tw_rcv_nxt,
-				   tcptw->tw_rcv_nxt + tcptw->tw_rcv_wnd))
+				   rcv_nxt,
+				   rcv_nxt + tcptw->tw_rcv_wnd))
 			return tcp_timewait_check_oow_rate_limit(
 				tw, skb, LINUX_MIB_TCPACKSKIPPEDFINWAIT2);
 
 		if (th->rst)
 			goto kill;
 
-		if (th->syn && !before(TCP_SKB_CB(skb)->seq, tcptw->tw_rcv_nxt))
+		if (th->syn && !before(TCP_SKB_CB(skb)->seq, rcv_nxt))
 			return TCP_TW_RST;
 
 		/* Dup ACK? */
 		if (!th->ack ||
-		    !after(TCP_SKB_CB(skb)->end_seq, tcptw->tw_rcv_nxt) ||
+		    !after(TCP_SKB_CB(skb)->end_seq, rcv_nxt) ||
 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq) {
 			inet_twsk_put(tw);
 			return TCP_TW_SUCCESS;
@@ -146,12 +148,13 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		 * reset.
 		 */
 		if (!th->fin ||
-		    TCP_SKB_CB(skb)->end_seq != tcptw->tw_rcv_nxt + 1)
+		    TCP_SKB_CB(skb)->end_seq != rcv_nxt + 1)
 			return TCP_TW_RST;
 
 		/* FIN arrived, enter true time-wait state. */
 		WRITE_ONCE(tw->tw_substate, TCP_TIME_WAIT);
-		twsk_rcv_nxt_update(tcptw, TCP_SKB_CB(skb)->end_seq);
+		twsk_rcv_nxt_update(tcptw, TCP_SKB_CB(skb)->end_seq,
+				    rcv_nxt);
 
 		if (tmp_opt.saw_tstamp) {
 			WRITE_ONCE(tcptw->tw_ts_recent_stamp,
@@ -182,7 +185,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	 */
 
 	if (!paws_reject &&
-	    (TCP_SKB_CB(skb)->seq == tcptw->tw_rcv_nxt &&
+	    (TCP_SKB_CB(skb)->seq == rcv_nxt &&
 	     (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq || th->rst))) {
 		/* In window segment, it may be only reset or bare ack. */
 
@@ -229,7 +232,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	 */
 
 	if (th->syn && !th->rst && !th->ack && !paws_reject &&
-	    (after(TCP_SKB_CB(skb)->seq, tcptw->tw_rcv_nxt) ||
+	    (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
 	     (tmp_opt.saw_tstamp &&
 	      (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0))) {
 		u32 isn = tcptw->tw_snd_nxt + 65535 + 2;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index fb2e64ce660f8f0b7fc7bf74fb88276d3e29b0be..d71ab4e1efe1c6598cf3d3e4334adf0881064ce9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1193,7 +1193,8 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 #endif
 	}
 
-	tcp_v6_send_ack(sk, skb, tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
+	tcp_v6_send_ack(sk, skb, tcptw->tw_snd_nxt,
+			READ_ONCE(tcptw->tw_rcv_nxt),
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_tw_tsval(tcptw),
 			READ_ONCE(tcptw->tw_ts_recent), tw->tw_bound_dev_if,
-- 
2.46.0.295.g3b9ea8a38a-goog


