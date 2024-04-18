Return-Path: <netdev+bounces-89456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EAC8AA4D7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FEFB2145D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12459199EA5;
	Thu, 18 Apr 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ii+twmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEB181BB4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476769; cv=none; b=WMSSIcSkbs7ZS3ZbxKEaOKLG4Yl0JG5FHNF+kMyyDtpgRW2Yagr0ttjZffZQukeVJNbmWj7uAZrsgJy8Hs8gBEp17en1JlaFKwxu2GTzGgd6dDgPQEwxs+Wby8L192lVettR60Jz7+A8PI1J/vaaMWrr04lo4O78ZrtnAq8Yb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476769; c=relaxed/simple;
	bh=hDoVCfVGk0Dq+gFBeIcdTNjdbsNVfV9gcPK8H+EsmE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7CbZ8UcQeH4VBfNTsWaniHXw5ANHHiHKuGd9VPea5RhhHz4CumXzpJFf1I/zpblM3+nxNfcfMeH5lHEmV6uyRpydAaS1n46YCCyVZr///RpndW+a/QpqYfftKzT3shc7OVtAEM8wqfGRCmiOCI2gISH2dVwBN9SwCuMVrk2LOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ii+twmX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45d510553so2488988276.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713476766; x=1714081566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuKXNQgTOGJ33cxvyO7WQb/YYkRaGLS5jfInmYFvfRY=;
        b=0ii+twmX8jHQXTRIoodybihRj3kMmlW4FZxTBow9uoOl9JKgzhIKgD3Hon8suptmSj
         4FfIxd1Ax6LftoqM32RyNnDereKK4P/dudpHLD/niUbCjo7QVo6xfc8wo7Mnc4ed1K/Z
         hbMWoCMKuiSCHO7ozrO963XtkJiQng2qgCh5NxrWL5bAC2GW5lH6sscygUAGb7n03WWh
         Z8huwVf9JAxg7aBBcUhlnycbqkE7d3Elc85nCGgYMWDSwMq1rqSj71ID59GTEMM8UnGH
         NNPpnYfFWVSeG38dUR+QkhRrco6YT1GmzII6ndB94ewOANxXrA8RBzEUZwOkpeXdg3pf
         JtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713476766; x=1714081566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuKXNQgTOGJ33cxvyO7WQb/YYkRaGLS5jfInmYFvfRY=;
        b=E9bh34fG7wmsurRQjGd3l8tc72Db4demltDF3Wmq/q/ZED5eJ/tFGTaKGQEYnBBKQK
         9cjloAGZSsDcB/ebmbZgKvkcPSUsxjozSu9u6x4uQgBahYgPCxGk0uH2/0TJTLKrYuxW
         NPyVUCqAI3h7J1WKDTVz/zTIzBRm5BOdMKItD2PpiW2gbe9F5XwQeGHBCkH+/PBZy20F
         ffCfSMG0GgJ/7kJt1aJZoo/Wz6W/skkHqQtTNE/PkOlO9AdqEo3il+HdLVuuqSqZPP8I
         o+qTsAL8doyHKqMla6duceuuEqrDVOdroydUQO1ebEy4QdiRi34K3iCuZkRg353WMkXB
         j0LA==
X-Gm-Message-State: AOJu0YzUzNB382VRQNEz+Km121op0h517xCSxc+j0oyyIKJWNTpFh3DI
	KOxihVwXMYL8eSMkYUi6pmy79U+e9zPgy1ngCiaFxx5SVn/PPeGBz4FDH9kUIYTwfMuMQi2TPBz
	IThKnnYOFWQ==
X-Google-Smtp-Source: AGHT+IGN/6WWg9+UqrvgBrv/nQ1VuyQc3OYMk8TP1SNfo8RqastbNlk5YmGLR6mJTdqb5q6zoPGG/3Z/NEutuA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:9c83:0:b0:de1:d49:7ff6 with SMTP id
 y3-20020a259c83000000b00de10d497ff6mr12792ybo.7.1713476766403; Thu, 18 Apr
 2024 14:46:06 -0700 (PDT)
Date: Thu, 18 Apr 2024 21:46:00 +0000
In-Reply-To: <20240418214600.1291486-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418214600.1291486-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418214600.1291486-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] tcp: try to send bigger TSO packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kevin Yang <yyd@google.com>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While investigating TCP performance, I found that TCP would
sometimes send big skbs followed by a single MSS skb,
in a 'locked' pattern.

For instance, BIG TCP is enabled, MSS is set to have 4096 bytes
of payload per segment. gso_max_size is set to 181000.

This means that an optimal TCP packet size should contain
44 * 4096 = 180224 bytes of payload,

However, I was seeing packets sizes interleaved in this pattern:

172032, 8192, 172032, 8192, 172032, 8192, <repeat>

tcp_tso_should_defer() heuristic is defeated, because after a split of
a packet in write queue for whatever reason (this might be a too small
CWND or a small enough pacing_rate),
the leftover packet in the queue is smaller than the optimal size.

It is time to try to make 'leftover packets' bigger so that
tcp_tso_should_defer() can give its full potential.

After this patch, we can see the following output:

14:13:34.009273 IP6 sender > receiver: Flags [P.], seq 4048380:4098360, ack 1, win 256, options [nop,nop,TS val 3425678144 ecr 1561784500], length 49980
14:13:34.010272 IP6 sender > receiver: Flags [P.], seq 4098360:4148340, ack 1, win 256, options [nop,nop,TS val 3425678145 ecr 1561784501], length 49980
14:13:34.011271 IP6 sender > receiver: Flags [P.], seq 4148340:4198320, ack 1, win 256, options [nop,nop,TS val 3425678146 ecr 1561784502], length 49980
14:13:34.012271 IP6 sender > receiver: Flags [P.], seq 4198320:4248300, ack 1, win 256, options [nop,nop,TS val 3425678147 ecr 1561784503], length 49980
14:13:34.013272 IP6 sender > receiver: Flags [P.], seq 4248300:4298280, ack 1, win 256, options [nop,nop,TS val 3425678148 ecr 1561784504], length 49980
14:13:34.014271 IP6 sender > receiver: Flags [P.], seq 4298280:4348260, ack 1, win 256, options [nop,nop,TS val 3425678149 ecr 1561784505], length 49980
14:13:34.015272 IP6 sender > receiver: Flags [P.], seq 4348260:4398240, ack 1, win 256, options [nop,nop,TS val 3425678150 ecr 1561784506], length 49980
14:13:34.016270 IP6 sender > receiver: Flags [P.], seq 4398240:4448220, ack 1, win 256, options [nop,nop,TS val 3425678151 ecr 1561784507], length 49980
14:13:34.017269 IP6 sender > receiver: Flags [P.], seq 4448220:4498200, ack 1, win 256, options [nop,nop,TS val 3425678152 ecr 1561784508], length 49980
14:13:34.018276 IP6 sender > receiver: Flags [P.], seq 4498200:4548180, ack 1, win 256, options [nop,nop,TS val 3425678153 ecr 1561784509], length 49980
14:13:34.019259 IP6 sender > receiver: Flags [P.], seq 4548180:4598160, ack 1, win 256, options [nop,nop,TS val 3425678154 ecr 1561784510], length 49980

With 200 concurrent flows on a 100Gbit NIC, we can see a reduction
of TSO packets (and ACK packets) of about 30 %.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5e8665241f9345f38ce56afffe473948aef66786..99a1d88f7f47b9ef0334efe62f8fd34c0d693ced 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2683,6 +2683,36 @@ void tcp_chrono_stop(struct sock *sk, const enum tcp_chrono type)
 		tcp_chrono_set(tp, TCP_CHRONO_BUSY);
 }
 
+/* First skb in the write queue is smaller than ideal packet size.
+ * Check if we can move payload from the second skb in the queue.
+ */
+static void tcp_grow_skb(struct sock *sk, struct sk_buff *skb, int amount)
+{
+	struct sk_buff *next_skb = skb->next;
+	unsigned int nlen;
+
+	if (tcp_skb_is_last(sk, skb))
+		return;
+
+	if (!tcp_skb_can_collapse(skb, next_skb))
+		return;
+
+	nlen = min_t(u32, amount, next_skb->len);
+	if (!nlen || !skb_shift(skb, next_skb, nlen))
+		return;
+
+	TCP_SKB_CB(skb)->end_seq += nlen;
+	TCP_SKB_CB(next_skb)->seq += nlen;
+
+	if (!next_skb->len) {
+		TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(next_skb)->end_seq;
+		TCP_SKB_CB(skb)->eor = TCP_SKB_CB(next_skb)->eor;
+		TCP_SKB_CB(skb)->tcp_flags |= TCP_SKB_CB(next_skb)->tcp_flags;
+		tcp_unlink_write_queue(next_skb, sk);
+		tcp_wmem_free_skb(sk, next_skb);
+	}
+}
+
 /* This routine writes packets to the network.  It advances the
  * send_head.  This happens as incoming acks open up the remote
  * window for us.
@@ -2723,6 +2753,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	max_segs = tcp_tso_segs(sk, mss_now);
 	while ((skb = tcp_send_head(sk))) {
 		unsigned int limit;
+		int missing_bytes;
 
 		if (unlikely(tp->repair) && tp->repair_queue == TCP_SEND_QUEUE) {
 			/* "skb_mstamp_ns" is used as a start point for the retransmit timer */
@@ -2744,6 +2775,10 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 			else
 				break;
 		}
+		cwnd_quota = min(cwnd_quota, max_segs);
+		missing_bytes = cwnd_quota * mss_now - skb->len;
+		if (missing_bytes > 0)
+			tcp_grow_skb(sk, skb, missing_bytes);
 
 		tso_segs = tcp_set_skb_tso_segs(skb, mss_now);
 
@@ -2767,8 +2802,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		limit = mss_now;
 		if (tso_segs > 1 && !tcp_urg_mode(tp))
 			limit = tcp_mss_split_point(sk, skb, mss_now,
-						    min(cwnd_quota,
-							max_segs),
+						    cwnd_quota,
 						    nonagle);
 
 		if (skb->len > limit &&
-- 
2.44.0.769.g3c40516874-goog


