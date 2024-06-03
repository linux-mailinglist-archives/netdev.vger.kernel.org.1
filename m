Return-Path: <netdev+bounces-100289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D058D867D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937041F25CB8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577B132110;
	Mon,  3 Jun 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="atsvVD3W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115561311A1
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429870; cv=none; b=DgzwqAH4XNrIvamrMjr1KBTwFhr9a6YqV1EMUaPVMWE3TvcIwibRKDsgul3VmekwkG/S+wzVLdg2bfkTJ9KiAecClJmWxbvJTC+dPKd8goGw7zTscDrxuNej4OI3Zn2koQISMHAGcKvIURaa1heJl6d39Eum1qhva6+CD7tiKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429870; c=relaxed/simple;
	bh=hnPPrXfksbbuLHbmwyYVt0nPnM4xDFgWQMAm/sC14GI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cblTAlYOhtPFDtlHYsbUBXBqtYh2ooP79zGxknbg3fhQ3DJiPO0OmAl+0T8YWTYb3tJvBaOGpAzUgfCkoZ817pRLr1x21THbd5T9x4u2Q3ID0kKs84pnYoZUV+1TlERnkemUxkMKwSKovoVhvrNqGJjLpOLDygp59dNXXnphhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=atsvVD3W; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa4b878450so6607962276.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717429868; x=1718034668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uT0Fkr26/sRVvgj+l5drlz+m4ctVXshN7EvacdOwDw0=;
        b=atsvVD3WsgjvXtm6PCIk3X44OqS7aalBXCxVpsPK59dSGMfJWouWuWEr6/Xt2FnxJ8
         RwYt6fOtUQTuH1qsiyK+53AqT7HEyQqmWimVUGd8EUVeELAHT9Bb1tHrIlZ4TylK08gb
         1b7ov40TIaptO7gx2A1ft7Qz/vts4t3QM1kR6T2xZ2EAjFfZboLK1f6ySuwrIvtqiYaa
         sqaGMdUjyh/eGPBfCQjegBI2luXDXzh790ffrXy90VayrNG3GzD7ohia/ybF/lCWbBpb
         ILVJ4+mWvD2WClCFWZqkQ04C25oiA/ODOiJqqeZ0cTFUbzKKH8KaPK26ZDJ654cME43M
         Vk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717429868; x=1718034668;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uT0Fkr26/sRVvgj+l5drlz+m4ctVXshN7EvacdOwDw0=;
        b=clYwAZ78Lv2lrQjkfFjuO0/v4eZp36TIrDulFK+9bGb2j9Pa9kd/BQCys9H9xv6YCo
         WVL7BFpPjETyEPP2W8qTYidgSOTQ9QSWRYG9HWvb2MN4SyzYaqGciKSio/GRCnYyPc//
         AwlK4ADWO40nyNJ4OhRaaTYTLCFwKFN7UU/vI6nPr3r6YpJw2fSbIyvnH0si7UWJyfuw
         q10PJdqBxP5pqwiTGOaLv/pw3McL7panpAA/3t2yiYJWV79alw2A/dwOGSD/aA5klYrh
         wBLm9d2henDtmB5RsrgNkYJ4hsvvKZ12I2vOmrsZMaeGbH6nmoMdijQhIiZ25QeFTLkx
         g90Q==
X-Gm-Message-State: AOJu0Yy2OHOHnAMCXhKnSsv1mzwjNdTFoTfNLlPhBfJe2Omd0N7Z4Oo3
	/pX5Oxpj5PlEOCRf8RGOENL9ooHsn4l0Uze9dIeBXlcDX62qzjsIM4KTBv++58oDwM2k3PitSSt
	eBvSG69Sygg==
X-Google-Smtp-Source: AGHT+IFVCAc+lYz5jKyVfYtM4D8v/MhS3s3ToZ01WdZFCRKkTqqLO0awfP0E+eMjOZvNmpoqEzD7DFu3kSh85A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6607:0:b0:dfa:88df:b389 with SMTP id
 3f1490d57ef6-dfa88dfb5c6mr392422276.7.1717429868082; Mon, 03 Jun 2024
 08:51:08 -0700 (PDT)
Date: Mon,  3 Jun 2024 15:51:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240603155106.409119-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: annotate data-races around tw->tw_ts_recent and tw->tw_ts_recent_stamp
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These fields can be read and written locklessly, add annotations
around these minor races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c      | 12 +++++++-----
 net/ipv4/tcp_minisocks.c | 22 ++++++++++++++--------
 net/ipv6/tcp_ipv6.c      |  6 +++---
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 59d5b064f23346080fb5057196406bbf9932a315..6c4f1cf776c1ebd7c58f9b040722ad609dd90406 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -114,6 +114,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	const struct inet_timewait_sock *tw = inet_twsk(sktw);
 	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
 	struct tcp_sock *tp = tcp_sk(sk);
+	int ts_recent_stamp;
 
 	if (reuse == 2) {
 		/* Still does not detect *everything* that goes through
@@ -152,9 +153,10 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	   If TW bucket has been already destroyed we fall back to VJ's scheme
 	   and use initial timestamp retrieved from peer table.
 	 */
-	if (tcptw->tw_ts_recent_stamp &&
+	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
+	if (ts_recent_stamp &&
 	    (!twp || (reuse && time_after32(ktime_get_seconds(),
-					    tcptw->tw_ts_recent_stamp)))) {
+					    ts_recent_stamp)))) {
 		/* inet_twsk_hashdance() sets sk_refcnt after putting twsk
 		 * and releasing the bucket lock.
 		 */
@@ -178,8 +180,8 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 			if (!seq)
 				seq = 1;
 			WRITE_ONCE(tp->write_seq, seq);
-			tp->rx_opt.ts_recent	   = tcptw->tw_ts_recent;
-			tp->rx_opt.ts_recent_stamp = tcptw->tw_ts_recent_stamp;
+			tp->rx_opt.ts_recent	   = READ_ONCE(tcptw->tw_ts_recent);
+			tp->rx_opt.ts_recent_stamp = ts_recent_stamp;
 		}
 
 		return 1;
@@ -1064,7 +1066,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_tw_tsval(tcptw),
-			tcptw->tw_ts_recent,
+			READ_ONCE(tcptw->tw_ts_recent),
 			tw->tw_bound_dev_if, &key,
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			tw->tw_tos,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 538c06f95918dedf29e0f4790795fcc417f2516f..4c894e540730ab6cbec6e781b72a4cb3cf4c55b4 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -101,16 +101,18 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	struct tcp_options_received tmp_opt;
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 	bool paws_reject = false;
+	int ts_recent_stamp;
 
 	tmp_opt.saw_tstamp = 0;
-	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
+	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
+	if (th->doff > (sizeof(*th) >> 2) && ts_recent_stamp) {
 		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL);
 
 		if (tmp_opt.saw_tstamp) {
 			if (tmp_opt.rcv_tsecr)
 				tmp_opt.rcv_tsecr -= tcptw->tw_ts_offset;
-			tmp_opt.ts_recent	= tcptw->tw_ts_recent;
-			tmp_opt.ts_recent_stamp	= tcptw->tw_ts_recent_stamp;
+			tmp_opt.ts_recent	= READ_ONCE(tcptw->tw_ts_recent);
+			tmp_opt.ts_recent_stamp	= ts_recent_stamp;
 			paws_reject = tcp_paws_reject(&tmp_opt, th->rst);
 		}
 	}
@@ -152,8 +154,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		twsk_rcv_nxt_update(tcptw, TCP_SKB_CB(skb)->end_seq);
 
 		if (tmp_opt.saw_tstamp) {
-			tcptw->tw_ts_recent_stamp = ktime_get_seconds();
-			tcptw->tw_ts_recent	  = tmp_opt.rcv_tsval;
+			WRITE_ONCE(tcptw->tw_ts_recent_stamp,
+				  ktime_get_seconds());
+			WRITE_ONCE(tcptw->tw_ts_recent,
+				   tmp_opt.rcv_tsval);
 		}
 
 		inet_twsk_reschedule(tw, TCP_TIMEWAIT_LEN);
@@ -197,8 +201,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		}
 
 		if (tmp_opt.saw_tstamp) {
-			tcptw->tw_ts_recent	  = tmp_opt.rcv_tsval;
-			tcptw->tw_ts_recent_stamp = ktime_get_seconds();
+			WRITE_ONCE(tcptw->tw_ts_recent,
+				   tmp_opt.rcv_tsval);
+			WRITE_ONCE(tcptw->tw_ts_recent_stamp,
+				   ktime_get_seconds());
 		}
 
 		inet_twsk_put(tw);
@@ -225,7 +231,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	if (th->syn && !th->rst && !th->ack && !paws_reject &&
 	    (after(TCP_SKB_CB(skb)->seq, tcptw->tw_rcv_nxt) ||
 	     (tmp_opt.saw_tstamp &&
-	      (s32)(tcptw->tw_ts_recent - tmp_opt.rcv_tsval) < 0))) {
+	      (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0))) {
 		u32 isn = tcptw->tw_snd_nxt + 65535 + 2;
 		if (isn == 0)
 			isn++;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 5fe4365de89dd145bba521ec88a74bc2154dc760..f4777c03cdd7a1f43c50901eca8e185d1e3a394c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1196,9 +1196,9 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 	tcp_v6_send_ack(sk, skb, tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_tw_tsval(tcptw),
-			tcptw->tw_ts_recent, tw->tw_bound_dev_if, &key,
-			tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel), tw->tw_priority,
-			tw->tw_txhash);
+			READ_ONCE(tcptw->tw_ts_recent), tw->tw_bound_dev_if,
+			&key, tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel),
+			tw->tw_priority, tw->tw_txhash);
 
 #ifdef CONFIG_TCP_AO
 out:
-- 
2.45.1.288.g0e0cd299f1-goog


