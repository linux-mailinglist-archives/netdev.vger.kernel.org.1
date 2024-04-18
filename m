Return-Path: <netdev+bounces-89454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511908AA4D5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F8284214
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642F199E8B;
	Thu, 18 Apr 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnEFmimC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A88181BB4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476765; cv=none; b=XQdh2o/SbdS+u+w4Fa5HxbdN53pnH9E5ZJSEYsP/a65tRmu9wy7afPcsC1N/SR49gDsRRazaoo3mU1gVWS9OgL9XbUZwXw+YNd3jS9rK42iG5KbRvJmYLBCZ40IQH4uvW0nrO9k3++usLLh3liVO+rDkyFThPDRpdQ3NyphHBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476765; c=relaxed/simple;
	bh=0QvbYUCmS3Y5yWtcw8fAcmhNLv/CIBi03WYGD8JyacQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=adUCfmdTnTJ48xgekDOsEeYwOYO5ZqpgQuDviWOduBk0wWZEB9sdimA/ZyVUszPgCbUPhQ2LFRzFqtz0OmLVsF7OjuazKfKXmH9UKJTXbwqnLWHxKNeQ515khxPMYxZq0bVwPwPtmDn7UxpsPq4llcg3Hr79S9CbNeaGj901tvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnEFmimC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45c577ca9so2118962276.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713476763; x=1714081563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpU3XVyHGTC+Qdd3+I9IE7FQBPQE6c+vlk4oBmqR0ww=;
        b=PnEFmimCPfsD8AOlqq82ggbSUxsUASB6GF7zZvKej5X9d/5nsYPBZ8WMJKoZg7BdLu
         FF80269mMZUYTljM2Vu2Rn9OOgPtvPOUwPOuiTRNxleUzP5HxJNEvZZIXc4z74fb8BDO
         cSbLoOVvLOZt4pLNo9axhVQp+6HBhWESQ0UT1eJjyEtd2BqiI9Q6uH5rqgWY/CIgu+op
         IRYWxxTo98kFxmr2gFTjLUFW7bGzm6/9meSZKz/81AVYqfOrb1EJN6VWGuxi7ibMXsSe
         i3qL0C9x0fxFbsoPrJqcdUbTw04d9cIgz6FSGFycApEvBkoaqK4o+khzFSLUi7DlJjqp
         K/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713476763; x=1714081563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpU3XVyHGTC+Qdd3+I9IE7FQBPQE6c+vlk4oBmqR0ww=;
        b=IUuk2Gcvros9RGfRTk9afJ3JL9Z4aKkY72sYGabINi0yJ+eM975wbIfysYmSEjMZhk
         P6NPjUEMouY1/jefFNEk5hHosGhMRHYfDECQqe3W6qXikz6MP8gnDYiZTusYOAyufas9
         mhDSuWpUUFFm9FZkAJGw2D6Z1oMqEBojr5wXs6WJ7xYGX5702iwKpbBz8lfFONDj1cDL
         wKMwvfnImU6blv73Q8iwFcUDIvizAJ4cmlRrobGIzGqLxe60BawsCo0Bu+CpoQBmOded
         fwXmNnYOAtwqoziYM9aECGpG7z1rrlVacjL8REAgqvQs8Y2hEYT/1ym5TbjVNM8GBna4
         g6yg==
X-Gm-Message-State: AOJu0Yxrna5+2uCGsr3SLH93hhZpCHTwwIlaEpdU+8Cn2VJrUENX8hCG
	BURQIktqKFiPhGGvykLmBsqVDt/YAoqWKjGNr23sK2fPxj9DxlRdUKwM9ifOA3BcsHNpiEanE88
	q17aL3pjfug==
X-Google-Smtp-Source: AGHT+IFSkgPN0SqquCnvmyRvDrQnzryu+nYG++w5ADfmWVpWDqCFXElFWt2JVWMGxllq8Yil3N3S9INF5edxDA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2906:0:b0:dc6:b7c2:176e with SMTP id
 p6-20020a252906000000b00dc6b7c2176emr791820ybp.4.1713476763277; Thu, 18 Apr
 2024 14:46:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 21:45:58 +0000
In-Reply-To: <20240418214600.1291486-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418214600.1291486-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418214600.1291486-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] tcp: remove dubious FIN exception from tcp_cwnd_test()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kevin Yang <yyd@google.com>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_cwnd_test() has a special handing for the last packet in
the write queue if it is smaller than one MSS and has the FIN flag.

This is in violation of TCP RFC, and seems quite dubious.

This packet can be sent only if the current CWND is bigger
than the number of packets in flight.

Making tcp_cwnd_test() result independent of the first skb
in the write queue is needed for the last patch of the series.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 61119d42b0fd27a3736e136b1e81f6fc2d4cb44b..acbc76ca3e640354880c62c2423cfe4ba99f0be3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2073,16 +2073,10 @@ static unsigned int tcp_mss_split_point(const struct sock *sk,
 /* Can at least one segment of SKB be sent right now, according to the
  * congestion window rules?  If so, return how many segments are allowed.
  */
-static inline unsigned int tcp_cwnd_test(const struct tcp_sock *tp,
-					 const struct sk_buff *skb)
+static u32 tcp_cwnd_test(const struct tcp_sock *tp)
 {
 	u32 in_flight, cwnd, halfcwnd;
 
-	/* Don't be strict about the congestion window for the final FIN.  */
-	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN) &&
-	    tcp_skb_pcount(skb) == 1)
-		return 1;
-
 	in_flight = tcp_packets_in_flight(tp);
 	cwnd = tcp_snd_cwnd(tp);
 	if (in_flight >= cwnd)
@@ -2706,10 +2700,9 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *skb;
 	unsigned int tso_segs, sent_pkts;
-	int cwnd_quota;
+	u32 cwnd_quota, max_segs;
 	int result;
 	bool is_cwnd_limited = false, is_rwnd_limited = false;
-	u32 max_segs;
 
 	sent_pkts = 0;
 
@@ -2743,7 +2736,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		tso_segs = tcp_init_tso_segs(skb, mss_now);
 		BUG_ON(!tso_segs);
 
-		cwnd_quota = tcp_cwnd_test(tp, skb);
+		cwnd_quota = tcp_cwnd_test(tp);
 		if (!cwnd_quota) {
 			if (push_one == 2)
 				/* Force out a loss probe pkt. */
@@ -2772,9 +2765,8 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		limit = mss_now;
 		if (tso_segs > 1 && !tcp_urg_mode(tp))
 			limit = tcp_mss_split_point(sk, skb, mss_now,
-						    min_t(unsigned int,
-							  cwnd_quota,
-							  max_segs),
+						    min(cwnd_quota,
+							max_segs),
 						    nonagle);
 
 		if (skb->len > limit &&
-- 
2.44.0.769.g3c40516874-goog


