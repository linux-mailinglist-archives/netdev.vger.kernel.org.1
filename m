Return-Path: <netdev+bounces-71906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA58558B5
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957B51C23166
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEB4A08;
	Thu, 15 Feb 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT+r2VJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25B6FD2
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960081; cv=none; b=SaLCUhRJO3u18ZCGxb2fwUwPozu1+VH7I6QFPgGNc42aGaiJthiExRQyHZy1O7sMo7ObPI7wkWyU7cI2VGjPb4iKqNSH6Ew+tcJ0fr25rFN1JVBUKQL/84OUgx4fIoyJLALkLWs8IHwGedkwjQf/XvJgtUeMwCm10xga5gRHxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960081; c=relaxed/simple;
	bh=RlZNxA4sfxIRVCe7kkYtkh4lI6FMGXN8uVk2i2aiays=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lObuULsnfg8YW4KeeBw84N9gIspQspmxhz3IKVVOXqjBkSTOOPQ4gmJhi27PMU30DG3T3vYKhGHMyGUba1PqIbojqk+eW+way2i4232YXPtMcsbAR3b2aI88My5dzM2yzrn4dobazB4wdldqdMQs3eRKM4+b9DAy+UUX7sQn/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT+r2VJB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-298cc60ee66so323082a91.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960080; x=1708564880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmLTIis3Q4t+RzbFdedCgs1PadbGr33BZ2kHASAg/PY=;
        b=RT+r2VJBIYPhZYT4WR0qyuueB5LYX4epp/8Hlzzq27vIQsFZEqUla88S2BsB1CT4E/
         oCEk+v+u6AKk/1261cHcR82wa3MU02zokKXhqiIPESx5OK9O7bHFtoTYeWmfT6+cl4hn
         e+c1el1H31KoekgjXqoOaUJY1+f61UqgqFrr9BK/oe1n1uoRrXctSG+YI1RZONwbei2X
         DBiYKTW6v4Wz12uOseRNRGctfMvOcuZB3zMYccGivaxZ+eQUbhSkNGOQmokhOg7RuCu9
         lpkqAdlvy1HnBWYI+TtT1yhyyhfaEvVoQXUo4jQ8qxxhgxE0m9PokR9AnBM0WTvDdT9z
         lZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960080; x=1708564880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmLTIis3Q4t+RzbFdedCgs1PadbGr33BZ2kHASAg/PY=;
        b=To3Ofzw6A4T24osDoYsdgwkzWpuJQ8ubVGunR2IDoxv69Gzc37V4gWMMQB7I52Gfxy
         2i4XmsMAkzjlVh4kxeUGxdOqclLJsCHl/VwvbSPgrT/IF1a4ERFZ3au2wm+MZp5vf5nP
         wOQyOZgk6aVqxFRyoqjITgFUJ7dVh/elxuYxyDMmWqPtyz4W/8wX4R5Gry0f/4Kuhehq
         HkcBzFSmWZeEgDFLtfd+v2Mfik5BAGGVhaXci0KntMbkP/rxlhq5d2uSCYY+odXMhmNo
         kQd7u6ft2CDi7e4851h3LbbjhLJdC7qsJuAfvcZ5kuS+A+Sfhf88qMQKIyY7+v+SfgeI
         VdLw==
X-Gm-Message-State: AOJu0Ywce4pT63YddmO9WKGVaHB0+EePIU7j24xo5M+G5FZkfjqJITa9
	7BC86zFRR2oBqF9Cb5+Jh5IV/Pb92KawVbsppKv5Z57yzpXZficAfjBiLIkwrfbEaA==
X-Google-Smtp-Source: AGHT+IFOOmpY3I/OjH8cpQs+49TBIroGygv7gj/6qteR00dB8LvCz1TIVwGwPR2xfM3YpytW+ShzzA==
X-Received: by 2002:a17:90b:80f:b0:298:b24c:4f79 with SMTP id bk15-20020a17090b080f00b00298b24c4f79mr383006pjb.40.1707960079982;
        Wed, 14 Feb 2024 17:21:19 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:21:19 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 09/11] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Thu, 15 Feb 2024 09:20:25 +0800
Message-Id: <20240215012027.11467-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240215012027.11467-1-kerneljasonxing@gmail.com>
References: <20240215012027.11467-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Update three callers including both ipv4 and ipv6 and let the dropreason
mechanism work in reality.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h        | 2 +-
 net/ipv4/tcp_ipv4.c      | 3 ++-
 net/ipv4/tcp_minisocks.c | 9 +++++----
 net/ipv6/tcp_ipv6.c      | 3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e5af9a5b411b..1d9b2a766b5e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -396,7 +396,7 @@ enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
 			   bool *lost_race);
-int tcp_child_process(struct sock *parent, struct sock *child,
+enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 		      struct sk_buff *skb);
 void tcp_enter_loss(struct sock *sk);
 void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost, int flag);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0a944e109088..c79e25549972 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1926,7 +1926,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
-	if (tcp_rcv_state_process(sk, skb)) {
+	reason = tcp_rcv_state_process(sk, skb);
+	if (reason) {
 		rsk = sk;
 		goto reset;
 	}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd..08d5b48540ea 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -911,11 +911,12 @@ EXPORT_SYMBOL(tcp_check_req);
  * be created.
  */
 
-int tcp_child_process(struct sock *parent, struct sock *child,
+enum skb_drop_reason
+tcp_child_process(struct sock *parent, struct sock *child,
 		      struct sk_buff *skb)
 	__releases(&((child)->sk_lock.slock))
 {
-	int ret = 0;
+	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
 	int state = child->sk_state;
 
 	/* record sk_napi_id and sk_rx_queue_mapping of child. */
@@ -923,7 +924,7 @@ int tcp_child_process(struct sock *parent, struct sock *child,
 
 	tcp_segs_in(tcp_sk(child), skb);
 	if (!sock_owned_by_user(child)) {
-		ret = tcp_rcv_state_process(child, skb);
+		reason = tcp_rcv_state_process(child, skb);
 		/* Wakeup parent, send SIGIO */
 		if (state == TCP_SYN_RECV && child->sk_state != state)
 			parent->sk_data_ready(parent);
@@ -937,6 +938,6 @@ int tcp_child_process(struct sock *parent, struct sock *child,
 
 	bh_unlock_sock(child);
 	sock_put(child);
-	return ret;
+	return reason;
 }
 EXPORT_SYMBOL(tcp_child_process);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1ca4f11c3d6f..b13eb4985152 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1663,7 +1663,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
-	if (tcp_rcv_state_process(sk, skb))
+	reason = tcp_rcv_state_process(sk, skb);
+	if (reason)
 		goto reset;
 	if (opt_skb)
 		goto ipv6_pktoptions;
-- 
2.37.3


