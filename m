Return-Path: <netdev+bounces-89455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3903E8AA4D6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525181C21CA6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF64199E9F;
	Thu, 18 Apr 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIl27oMt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016E199E96
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476767; cv=none; b=bWOpDAMdmI2BdClaiFMpyG3AXkXsGBiHE3XsUxTs5KB+DdmLB3JrynZNmZkCrCLpX/xqCf/BFM2+X+eBhhbu3N1S8B5vWn0CJxD3PPsEluVhGdFyNumenrVWdSiopLLxs9P0OqwgH9yPC9jHV7uru9pvMzQ4+SHOFA7P9vMh2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476767; c=relaxed/simple;
	bh=UbcqAUt0buDx1m+bLQbQfLd0qDYQeA8peMo6KyKWdDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vxm1Uvy2mwBGtbSar/CleMLsledROswKr2VV5vyJNJ8OwGdKMMxo3TSzhx6xmCW7+wXX1wRmUT/UFVW+URli2T2V2ReAsj2tjHiJub39dkO7SW6iOcYU0dUEHMi6BchrA28tG9mKjWhDn7zMJQTxc5ZL3rFUJ2L80hK76b1MjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIl27oMt; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4348f151299so16596271cf.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713476765; x=1714081565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=82+5W3OIOaAlA1csuN1KdYSS+L3cimNiDraSrsBf0sE=;
        b=hIl27oMtAEeVayRDFKtbIpiFYqGon2cJ3rbc703U7RjDyxdFK1+hydpX90mlzb2nXq
         EV75nG8iMR09pUT5mEr266C4EmAJsE92pKmIaLDhwqW/G9hK9cO0Q7Az2hGbRmvNhlhe
         bivgIgdlC3LxEWlN0EOFfF4OnpA6KbIggfHNcsjDKuE2vDEyAyRo2BQi6bc3bhmtAsRy
         6p1cvRl6zjKOQ+WhRvXDWbxWxqeNXj6J2v5Fx0ft7vRSAo4q5xptTQ1C1rGLX/JAiVBh
         d1JgP1/Tr9auo7dvypxOMJtQTu393p252iZYuDvcUbY86tM4FVvG/511d78BK4xPyTSj
         iLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713476765; x=1714081565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82+5W3OIOaAlA1csuN1KdYSS+L3cimNiDraSrsBf0sE=;
        b=mRn8r1hR8ZzvdYHbpjeebNUie0gkbH4Rmyjh+u6OFGdRyPmmq6rPlJA79zX1vHpTVX
         kYQ3P+aOFLeEp1jwizigA8Du7SfOuTEgw+z1so5h6a12tUanTSZe7k2I1kY6S3FHCiUg
         lppWasvGkGWqKpSaElA8+U0YYDQnBSmnKGGD5BVBPc82XNdpFaW09ZW52bYn2IsaPIkM
         /x3sSLQGpM7RXu/l0kCrpLZ5OWjnxcQXSyQIbSzIkeNwtX99+KQhaHADhkoiIFhljtMz
         UruO9RFO7NYeAkZga8S0CP1TcV/33WQWyf8fYhOeLg65ONcdkRSEJOqRhxV1zQc59SLw
         zKAw==
X-Gm-Message-State: AOJu0YzqVDZSesywRCu7tHJL9/aImOFoMH8Ox7b3LThPJ/DGjvBsy8Tq
	1mZto91VpBZcyHjJeLDicu1Ka2WKV+bw0VqIPqoJ4xy4EH+G8AFfymZMUdfBxFJiYK5Cpo/SWYA
	EKY4mWRO53w==
X-Google-Smtp-Source: AGHT+IG39R1phMrLrUc60jKi4ZBSuKDf9gvanZsV4ZHpp/BLuHYNAL8e9IYmIeEaLLC/bZHjAZ2V26goSGgT1g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:486:b0:437:acca:c692 with SMTP
 id p6-20020a05622a048600b00437accac692mr13168qtx.10.1713476764949; Thu, 18
 Apr 2024 14:46:04 -0700 (PDT)
Date: Thu, 18 Apr 2024 21:45:59 +0000
In-Reply-To: <20240418214600.1291486-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418214600.1291486-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418214600.1291486-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] tcp: call tcp_set_skb_tso_segs() from tcp_write_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kevin Yang <yyd@google.com>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_write_xmit() calls tcp_init_tso_segs()
to set gso_size and gso_segs on the packet.

tcp_init_tso_segs() requires the stack to maintain
an up to date tcp_skb_pcount(), and this makes sense
for packets in rtx queue. Not so much for packets
still in the write queue.

In the following patch, we don't want to deal with
tcp_skb_pcount() when moving payload from 2nd
skb to 1st skb in the write queue.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index acbc76ca3e640354880c62c2423cfe4ba99f0be3..5e8665241f9345f38ce56afffe473948aef66786 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1502,18 +1502,22 @@ static void tcp_queue_skb(struct sock *sk, struct sk_buff *skb)
 }
 
 /* Initialize TSO segments for a packet. */
-static void tcp_set_skb_tso_segs(struct sk_buff *skb, unsigned int mss_now)
+static int tcp_set_skb_tso_segs(struct sk_buff *skb, unsigned int mss_now)
 {
+	int tso_segs;
+
 	if (skb->len <= mss_now) {
 		/* Avoid the costly divide in the normal
 		 * non-TSO case.
 		 */
-		tcp_skb_pcount_set(skb, 1);
 		TCP_SKB_CB(skb)->tcp_gso_size = 0;
-	} else {
-		tcp_skb_pcount_set(skb, DIV_ROUND_UP(skb->len, mss_now));
-		TCP_SKB_CB(skb)->tcp_gso_size = mss_now;
+		tcp_skb_pcount_set(skb, 1);
+		return 1;
 	}
+	TCP_SKB_CB(skb)->tcp_gso_size = mss_now;
+	tso_segs = DIV_ROUND_UP(skb->len, mss_now);
+	tcp_skb_pcount_set(skb, tso_segs);
+	return tso_segs;
 }
 
 /* Pcount in the middle of the write queue got changed, we need to do various
@@ -2097,10 +2101,9 @@ static int tcp_init_tso_segs(struct sk_buff *skb, unsigned int mss_now)
 {
 	int tso_segs = tcp_skb_pcount(skb);
 
-	if (!tso_segs || (tso_segs > 1 && tcp_skb_mss(skb) != mss_now)) {
-		tcp_set_skb_tso_segs(skb, mss_now);
-		tso_segs = tcp_skb_pcount(skb);
-	}
+	if (!tso_segs || (tso_segs > 1 && tcp_skb_mss(skb) != mss_now))
+		return tcp_set_skb_tso_segs(skb, mss_now);
+
 	return tso_segs;
 }
 
@@ -2733,9 +2736,6 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		if (tcp_pacing_check(sk))
 			break;
 
-		tso_segs = tcp_init_tso_segs(skb, mss_now);
-		BUG_ON(!tso_segs);
-
 		cwnd_quota = tcp_cwnd_test(tp);
 		if (!cwnd_quota) {
 			if (push_one == 2)
@@ -2745,6 +2745,8 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 				break;
 		}
 
+		tso_segs = tcp_set_skb_tso_segs(skb, mss_now);
+
 		if (unlikely(!tcp_snd_wnd_test(tp, skb, mss_now))) {
 			is_rwnd_limited = true;
 			break;
-- 
2.44.0.769.g3c40516874-goog


