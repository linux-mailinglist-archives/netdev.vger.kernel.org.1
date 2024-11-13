Return-Path: <netdev+bounces-144353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B49C6C6F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EFB2B8E8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19E1FBC84;
	Wed, 13 Nov 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KcygCHPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9431FB8A8
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492464; cv=none; b=fTKcO01O7tuUtpddJVbs8vqmdFEvaMemcxICrkk7HCZvtZr5mnmI2iqjKfTaAMa2as0saQtJrRFNLv/dnesz4J1uIWMsiw+rpLnlEznqmxqUmpsfF/U7wb466iAABoKwa3Wg1NuOTZI3lLdXQZPrOecKFHqmKO5mWgx0cno5TPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492464; c=relaxed/simple;
	bh=GWG6gvtmCPC1Y5uRJ9mbu+122kW9cf3X2bQVkcO5Vms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGqJ98tWu9w67VdTNijybb6PaNPLpwfI5HJMVim3JjQ+kxvPRDJXOUO3+ogmKejft5eZ5+szOmWmXkBMw+xrpqFINIt1FBZFmspEK5k9c7ViPgE+eV8MHpX8ZzgYF6kHLmKtnWPnMShvnTFOo2eint097zEcgpzXcImZaI+ZOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KcygCHPe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so8927466a12.0
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1731492460; x=1732097260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7inWUNM4zxYB/M1nB//FcjspkiJ3ANQGOmabnSGUMdE=;
        b=KcygCHPeCZrubH1oeDgzZJa2ccP5jX+MTwqK74ZnX2nX91jcQjw0ZD1YIOBm3Mj00f
         Gc1/48m9fdOZivCNfvAd+sqtcsuFLJdzDqx29ox6KdRFEZiWq6BMeaK1W7l/Zg7Q3FGo
         +RZN5cBl6O90HbPkWUBO/P7gHqmsHFlJrP+pQrnQVBFDPZmvgDtjc73Ip3+k8By8Xp0T
         3pc3WWXMLbvPq+xCCLfskebNhuSZeP9HrqBjIBl9it67h7f07mnCvOYUSO1Q3Qpi/wm2
         f/Jc+SCEZUql3Kd1Kruv9AlrQj9YSMSbYNILS2zLGDPGJKGi/c7KA1tZXeqCXgRN5Q73
         /S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492460; x=1732097260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7inWUNM4zxYB/M1nB//FcjspkiJ3ANQGOmabnSGUMdE=;
        b=hUVQONko3hdbiD9/njzaNkbCsvzonUFct/O8Nd9eS/BCLMPhnUUy5NzYAJTIX2azMI
         QdaJf0WixMaI7BcYnc9mQ9EIxZdZbdHk8koQR+SNQcH+9WgRw2VkHaHXcAvpyz7dvdup
         3Mt2N27h9qfqWy3oGXrL9ozxjtkAUQvyxmZWgYhLtXH8UdRok33vmA9k0CIVd/paogeO
         wnCzFQ7w3jEJW16p9BOOfD5P8duD8oRL3TJbC8HSlxhAKeO1AksWlxaWlztlQ45b7Aoo
         e5hFjiuUkD0rciwMgQbI17Ue6iT9XH8F0onY6KUK7gFPHBVMyyvLlhYXlrsxGt9+/fh9
         2W+Q==
X-Gm-Message-State: AOJu0YzlQ8ToSZ9CAaKG1Zqq2/Bm4XM6RI0sV/kBXa4swHx31tVd8pL/
	XwaR/Uw6kNAog+nfqJpYGwyjavehGM3ijnWhPQ48XtWi7GEMPGT1kR88ocUnS7c=
X-Google-Smtp-Source: AGHT+IFjnWw1i0Y0bWeyKljWjPn7GFPKN/DAnTahfOW/Wi179tDstWNE0W/uYMSmHD/XN5wFzaU+LQ==
X-Received: by 2002:a17:907:9344:b0:a9e:c263:29a7 with SMTP id a640c23a62f3a-a9eefeecd74mr1675605166b.23.1731492460401;
        Wed, 13 Nov 2024 02:07:40 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a18b15sm841722566b.18.2024.11.13.02.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:07:39 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 13 Nov 2024 11:06:42 +0100
Subject: [PATCH RFC net-next v2 1/2] tcp: Measure TIME-WAIT reuse delay
 with millisecond precision
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-1-b0a335247304@cloudflare.com>
References: <20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com>
In-Reply-To: <20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Adrien Vasseur <avasseur@cloudflare.com>, 
 Lee Valentine <lvalentine@cloudflare.com>, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-355e8

Prepare ground for TIME-WAIT socket reuse with subsecond delay.

Today TS.Recent last update timestamp, recorded in seconds and stored
tp->ts_recent_stamp and tw->tw_ts_recent_stamp fields, has two purposes.

Firstly, it is used to track the age of the last recorded TS.Recent value
to detect when that value becomes outdated due to potential wrap-around of
the other TCP timestamp clock (RFC 7323, section 5.5).

For this purpose a second-based timestamp is completely sufficient as even
in the worst case scenario of a peer using a high resolution microsecond
timestamp, the wrap-around interval is ~36 minutes long.

Secondly, it serves as a threshold value for allowing TIME-WAIT socket
reuse. A TIME-WAIT socket can be reused only once the virtual 1 Hz clock,
ktime_get_seconds, is past the TS.Recent update timestamp.

The purpose behind delaying the TIME-WAIT socket reuse is to wait for the
other TCP timestamp clock to tick at least once before reusing the
connection. It is only then that the PAWS mechanism for the reopened
connection can detect old duplicate segments from the previous connection
incarnation (RFC 7323, appendix B.2).

In this case using a timestamp with second resolution not only blocks the
way toward allowing faster TIME-WAIT reuse after shorter subsecond delay,
but also makes it impossible to reliably delay TW reuse by one second.

As Eric Dumazet has pointed out [1], due to timestamp rounding, the TW
reuse delay will actually be between (0, 1] seconds, and 0.5 seconds on
average. We delay TW reuse for one full second only when last TS.Recent
update coincides with our virtual 1 Hz clock tick.

We assume here that a full one second delay was the original intention in
[2] because it accounts for the worst case scenario of the other TCP using
the slowest recommended 1 Hz timestamp clock.

Considering the above, change the resolution of the TS.Recent update
timestamp stored in TW socket (tw_ts_recent_stamp) to milliseconds to
(i) reliably delay TIME-WAIT reuse by one second, and (ii) prepare for
configurable subsecond reuse delay in a subsequent change.

Limit the resolution change to just the true TIME-WAIT state, that is when
TW socket is in TCP_TIME_WAIT substate. This approach offers a tradeoff
between the added complexity of converting between time units and the risk
of touching both TIME-WAIT reuse and PAWS mechanism code paths at once. At
the same time, it leaves the path to fully converting TS.Recent update
timestamp to milliseconds open.

A low effort alternative would be to introduce a new field to hold a
millisecond timestamp for measuring the TW reuse delay. However, this would
cause the struct tcp_timewait_socket size to go over 256 bytes and overflow
into another cache line.

[1] https://lore.kernel.org/netdev/CANn89iKB4GFd8sVzCbRttqw_96o3i2wDhX-3DraQtsceNGYwug@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8439924316d5bcb266d165b93d632a4b4b859af

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/tcp.h      |  9 ++++++++-
 net/ipv4/tcp_ipv4.c      |  6 +++---
 net/ipv4/tcp_minisocks.c | 20 ++++++++++++++------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f88daaa76d836654b2a2e217d0d744d3713d368e..3844ccb2a1fa7eb5e96b466681a0652cadec9354 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -542,7 +542,14 @@ struct tcp_timewait_sock {
 	/* The time we sent the last out-of-window ACK: */
 	u32			  tw_last_oow_ack_time;
 
-	int			  tw_ts_recent_stamp;
+	/**
+	 * @tw_ts_recent_stamp: Timestamp of last TS.Recent update (RFC 7323).
+	 *
+	 * Timestamp resolution depends on @tw_sk.tw_substate state. Has second
+	 * resolution in %TCP_FIN_WAIT2 state and millisecond resolution
+	 * %TCP_TIME_WAIT state.
+	 */
+	u32			  tw_ts_recent_stamp;
 	u32			  tw_tx_delay;
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key	  *tw_md5_key;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a38c8b1f44dbd95fcea08bd81e0ceaa70177ac8a..501e9265b6ebab475ae0a957175286fb153918e6 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -119,7 +119,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	const struct inet_timewait_sock *tw = inet_twsk(sktw);
 	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
 	struct tcp_sock *tp = tcp_sk(sk);
-	int ts_recent_stamp;
+	u32 ts_recent_stamp;
 
 	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2)
 		reuse = 0;
@@ -163,8 +163,8 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	 */
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
 	if (ts_recent_stamp &&
-	    (!twp || (reuse && time_after32(ktime_get_seconds(),
-					    ts_recent_stamp)))) {
+	    (!twp || (reuse && time_after32(tcp_clock_ms(),
+					    ts_recent_stamp + MSEC_PER_SEC)))) {
 		/* inet_twsk_hashdance_schedule() sets sk_refcnt after putting twsk
 		 * and releasing the bucket lock.
 		 */
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bb1fe1ba867ac3ed8610ceb9fef7e74cd465b3ea..6d7e3c974d2ae4fd9e147d8fa222e4c20728b896 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -104,8 +104,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	struct tcp_options_received tmp_opt;
 	bool paws_reject = false;
 	int ts_recent_stamp;
+	u8 tw_substate;
 
 	tmp_opt.saw_tstamp = 0;
+	tw_substate = READ_ONCE(tw->tw_substate);
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
 	if (th->doff > (sizeof(*th) >> 2) && ts_recent_stamp) {
 		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL);
@@ -114,12 +116,15 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 			if (tmp_opt.rcv_tsecr)
 				tmp_opt.rcv_tsecr -= tcptw->tw_ts_offset;
 			tmp_opt.ts_recent	= READ_ONCE(tcptw->tw_ts_recent);
-			tmp_opt.ts_recent_stamp	= ts_recent_stamp;
+			if (tw_substate == TCP_TIME_WAIT)
+				tmp_opt.ts_recent_stamp = ts_recent_stamp / MSEC_PER_SEC;
+			else
+				tmp_opt.ts_recent_stamp	= ts_recent_stamp;
 			paws_reject = tcp_paws_reject(&tmp_opt, th->rst);
 		}
 	}
 
-	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2) {
+	if (tw_substate == TCP_FIN_WAIT2) {
 		/* Just repeat all the checks of tcp_rcv_state_process() */
 
 		/* Out of window, send ACK */
@@ -158,7 +163,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 
 		if (tmp_opt.saw_tstamp) {
 			WRITE_ONCE(tcptw->tw_ts_recent_stamp,
-				  ktime_get_seconds());
+				  tcp_clock_ms());
 			WRITE_ONCE(tcptw->tw_ts_recent,
 				   tmp_opt.rcv_tsval);
 		}
@@ -207,7 +212,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 			WRITE_ONCE(tcptw->tw_ts_recent,
 				   tmp_opt.rcv_tsval);
 			WRITE_ONCE(tcptw->tw_ts_recent_stamp,
-				   ktime_get_seconds());
+				   tcp_clock_ms());
 		}
 
 		inet_twsk_put(tw);
@@ -320,8 +325,11 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		tcptw->tw_snd_nxt	= tp->snd_nxt;
 		tcptw->tw_rcv_wnd	= tcp_receive_window(tp);
 		tcptw->tw_ts_recent	= tp->rx_opt.ts_recent;
-		tcptw->tw_ts_recent_stamp = tp->rx_opt.ts_recent_stamp;
-		tcptw->tw_ts_offset	= tp->tsoffset;
+		if (state == TCP_TIME_WAIT && tp->rx_opt.ts_recent_stamp)
+			tcptw->tw_ts_recent_stamp = tcp_time_stamp_ms(tp);
+		else
+			tcptw->tw_ts_recent_stamp = tp->rx_opt.ts_recent_stamp;
+		tcptw->tw_ts_offset = tp->tsoffset;
 		tw->tw_usec_ts		= tp->tcp_usec_ts;
 		tcptw->tw_last_oow_ack_time = 0;
 		tcptw->tw_tx_delay	= tp->tcp_tx_delay;

-- 
2.43.0


