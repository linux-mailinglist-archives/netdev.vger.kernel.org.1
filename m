Return-Path: <netdev+bounces-150369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42759E9FC5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A93281C14
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222E198E75;
	Mon,  9 Dec 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HMjrd9Az"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912DB17DFE3
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773109; cv=none; b=VylgUyzPS9eQEjnaN77IiIbfx+2OrIXhIejxqfNwjiQqJWOUgmW+v12fZO8+tmM2Ckfozr50mSqwgzhzpB5n71Py2JrSPjxAYPfRRaAHcpfBj1shPKW14JLabrdFO1FqtFlwaxWi2CyQu2pxc6yTePnBFhcFgKdVNa1iqs/TkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773109; c=relaxed/simple;
	bh=dbssU6TIUfAeyRKxrNJ+PSzIm440bW472avNH7xBfXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+pxPYmchVrlHJs7KLD07Msrvv/WQouT9b3X8dGbEKXFuYgZSrEv7Bg1wJY+vTT51kGpHrGbjViKzL4wkjjCOX0LlHMzZ/JspcZCrTV21EDFuu24MnzIBuGH/AAFN4iCW1CL0Kvy4V7z19uj49XyR0njoWCbWVp/TQGNVGvnlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HMjrd9Az; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa68b513abcso218981266b.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 11:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1733773106; x=1734377906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pIzCOpcrAx2zhkMIMF6XtATodYKMS1VFygMk/XUcNU=;
        b=HMjrd9AzgA2gI7wWKhdZYso5MUqD5Nqm7459scToAX6hWHN+meAYaIr6+ug68f+Uhs
         VaIg/Np/b7qbqxrjTnZiCHrhrFHv64ElKhgXHYXirN5iZRP8L8dcIVG9nkig57SdGDt2
         qlL2q8OyQx5SkOpxdkRBKmRWYen8Js+wZObWWqZtpIhM11LfvTUrgwGgxJ0iteu6PxDh
         MW8TP40KY4vQAMgOlbBf1aF9p7fOn0I1wfXPiqLgx1rVtRL0aa8wihn+1xD37hTqG01s
         ZcjHJfGWVRLcHcrk0w7z+3hrdAGl9JbvQ8Hhq6VVhCROlYyzryNe6uDegA8VOAPBwHPk
         QRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733773106; x=1734377906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pIzCOpcrAx2zhkMIMF6XtATodYKMS1VFygMk/XUcNU=;
        b=N07lhDXDpW8EOTtaTla4Nh9FEX5flTPs9zhUQjtw2ZoQNKodfwFnbYSkrc2mBcEG1d
         v9G4lhNd3YgIOhwirfN7mrjCSlHA9oF3wnQ0uDGGH8YBRKoXaqzwhw2OCVJI4i4/MjDj
         IUVAmt+qJN80JePDh2A2qMaZ+a1QUWrqGlA77UdHamZqImiHb6e81oM9tFSqfqrt4yID
         a/GuB9dwJpqfFiYna8aGeHqbi8ls4JMknVnsKdf6dhfBFQmfhqvMG55ZWvnr54VU1Ppp
         RbKjo5Mda4/rNZdn0BZTQXVNpm4HQn+cVczLN6qMcmycmWUi04Cd3XjJdHX/ad7h8dyz
         drDQ==
X-Gm-Message-State: AOJu0YwJL5B6MTfrd1Rhl3/Zgb9nx9mxwYIeyM7njaA3xjD4W8XnhNxj
	xZVEVaF+3gdsO2rosZhlGhNHs2yAkCj0uNIssh0UYUS2or654AV2BLRA7SUGyA8=
X-Gm-Gg: ASbGncsJlWpZ9ZUH05T4ncbz+EP2cEah7XWeZa2qMUwmCtZhClQbJQC6cbqMY2+IDO5
	ZN4SFNbnlgeISUgIHS6hiuCQcqL6nxBophBpWJKBlQSeXzGMIl5OnlFOtj1bEKBLCzQfPo9xPpu
	CUzJ/9Ato+ZXsQjxY/a6HWLxGFow0CDx9BWNS0vq2VNh8r19NNaCHpRwV9VXeZf1zx5dUrUN7lt
	V1VRjMk2Y57UIFwNUWnwsFvIIaHGfHNqZOoNelYOY5B9D4=
X-Google-Smtp-Source: AGHT+IH7EsFF0jO6kFRrvzgVi6/fJ1cO8UV9ebuPrbFODrRUiMTpYWfxH7suvY9+07RSaZ022pdAGg==
X-Received: by 2002:a17:906:cc57:b0:aa6:993a:25a2 with SMTP id a640c23a62f3a-aa6993a349amr291194366b.10.1733773105866;
        Mon, 09 Dec 2024 11:38:25 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67f4c4ae4sm257163866b.111.2024.12.09.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:38:25 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 09 Dec 2024 20:38:03 +0100
Subject: [PATCH net-next v2 1/2] tcp: Measure TIME-WAIT reuse delay with
 millisecond precision
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-1-66aca0eed03e@cloudflare.com>
References: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
In-Reply-To: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
 Adrien Vasseur <avasseur@cloudflare.com>, 
 Lee Valentine <lvalentine@cloudflare.com>, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-355e8

Prepare ground for TIME-WAIT socket reuse with subsecond delay.

Today the last TS.Recent update timestamp, recorded in seconds and stored
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

Considering the above, introduce a dedicated field to store a millisecond
timestamp of transition into the TIME-WAIT state. Place it in an existing
4-byte hole inside inet_timewait_sock structure to avoid an additional
memory cost.

Use the new timestamp to (i) reliably delay TIME-WAIT reuse by one second,
and (ii) prepare for configurable subsecond reuse delay in the subsequent
change.

We assume here that a full one second delay was the original intention in
[2] because it accounts for the worst case scenario of the other TCP using
the slowest recommended 1 Hz timestamp clock.

A more involved alternative would be to change the resolution of the last
TS.Recent update timestamp, tw->tw_ts_recent_stamp, to milliseconds.

[1] https://lore.kernel.org/netdev/CANn89iKB4GFd8sVzCbRttqw_96o3i2wDhX-3DraQtsceNGYwug@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8439924316d5bcb266d165b93d632a4b4b859af

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/inet_timewait_sock.h | 4 ++++
 net/ipv4/tcp_ipv4.c              | 5 +++--
 net/ipv4/tcp_minisocks.c         | 7 ++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 62c0a7e65d6bdf4c71a8ea90586b985f9fd30229..67a313575780992a1b55aa26aaa2055111eb7e8d 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -74,6 +74,10 @@ struct inet_timewait_sock {
 				tw_tos		: 8;
 	u32			tw_txhash;
 	u32			tw_priority;
+	/**
+	 * @tw_reuse_stamp: Time of entry into %TCP_TIME_WAIT state in msec.
+	 */
+	u32			tw_entry_stamp;
 	struct timer_list	tw_timer;
 	struct inet_bind_bucket	*tw_tb;
 	struct inet_bind2_bucket	*tw_tb2;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a38c8b1f44dbd95fcea08bd81e0ceaa70177ac8a..3b6ba1d16921e079d5ba08c3c0b98dccace8c370 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -120,6 +120,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
 	struct tcp_sock *tp = tcp_sk(sk);
 	int ts_recent_stamp;
+	u32 reuse_thresh;
 
 	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2)
 		reuse = 0;
@@ -162,9 +163,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	   and use initial timestamp retrieved from peer table.
 	 */
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
+	reuse_thresh = READ_ONCE(tw->tw_entry_stamp) + MSEC_PER_SEC;
 	if (ts_recent_stamp &&
-	    (!twp || (reuse && time_after32(ktime_get_seconds(),
-					    ts_recent_stamp)))) {
+	    (!twp || (reuse && time_after32(tcp_clock_ms(), reuse_thresh)))) {
 		/* inet_twsk_hashdance_schedule() sets sk_refcnt after putting twsk
 		 * and releasing the bucket lock.
 		 */
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7121d8573928cbf6840b3361b62f4812d365a30b..b089b08e9617862cd73b47ac06b5ac6c1e843ec6 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -157,8 +157,11 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 				    rcv_nxt);
 
 		if (tmp_opt.saw_tstamp) {
+			u64 ts = tcp_clock_ms();
+
+			WRITE_ONCE(tw->tw_entry_stamp, ts);
 			WRITE_ONCE(tcptw->tw_ts_recent_stamp,
-				  ktime_get_seconds());
+				   div_u64(ts, MSEC_PER_SEC));
 			WRITE_ONCE(tcptw->tw_ts_recent,
 				   tmp_opt.rcv_tsval);
 		}
@@ -316,6 +319,8 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		tw->tw_mark		= sk->sk_mark;
 		tw->tw_priority		= READ_ONCE(sk->sk_priority);
 		tw->tw_rcv_wscale	= tp->rx_opt.rcv_wscale;
+		/* refreshed when we enter true TIME-WAIT state */
+		tw->tw_entry_stamp	= tcp_time_stamp_ms(tp);
 		tcptw->tw_rcv_nxt	= tp->rcv_nxt;
 		tcptw->tw_snd_nxt	= tp->snd_nxt;
 		tcptw->tw_rcv_wnd	= tcp_receive_window(tp);

-- 
2.43.0


