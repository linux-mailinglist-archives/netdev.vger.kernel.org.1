Return-Path: <netdev+bounces-74811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAD78668BA
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2AE1C21588
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83573134B2;
	Mon, 26 Feb 2024 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZyjUA7k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAD14AAD
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917798; cv=none; b=qiqhrhU2RNkR8UcxrYTf/iV0nw2qlyiWks/fJZxu4WsmPeD3L4MDPA7vYYl9UtPcmi5vnY8PXI+XlkF8T0mf3HLZveQcwSgUFUqdJDiZvJav0VUEOdZjVyo1+1WxxnSm/wb4MqEH3fwjYLjf8U8h3ZshQWkxwwHLJM0BYLQO6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917798; c=relaxed/simple;
	bh=zUJKASVQRhkjXina43WvHkVHnrsnpqc0yOw+Zk/3Lvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AclI/VUSzE3hy/yJdmKkMNUTt50/KVcqc7HrSPaMmLlUrmTa6bsbqomnrnbogCgXyHTGatsVN5uyPJieNz/rGSzw5EukTJzM+fEv6by9o80CmhzWi8LG7vGr2j1P8SXHPAN03xIYxTm9AEjIwHNwcLb84WfXtE+MXmfkeGJQAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZyjUA7k; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29a2d0f69a6so1851816a91.3
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917796; x=1709522596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqAc5pOiR2QsfttJTIYOyiLrFFIgSuUpPWR1dWccF7o=;
        b=KZyjUA7kG+rCuk+hftbCyhUadHyEFo8P2VDpxokzyjG2q2fd0rh46S6MFdFrzU/peG
         zcLHq6bgKgA4S7tBOUKZJb5VDm0xaX8KHydisyBd6DueHup4wK5aYlo3rzk4QMEHoTZW
         52QyBVo/7IgsCDV5ge/lgjfoYYvdTIUIlryTIYQwIITbffivy+wR40m84g2kd05hrl4v
         dKNydLH/qJZX2Rq6e7eRSLhrKgPSeq5pgd5H+xGkRhTIBeccxQ2SKA6ss1GAQkHR71uS
         et8vY58ohWgDtvYKxzh+YFCAtNmjpPFFwpY8bLC/m/qhA/wQYaVUbeu70lkMUOiOMn8v
         0Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917796; x=1709522596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqAc5pOiR2QsfttJTIYOyiLrFFIgSuUpPWR1dWccF7o=;
        b=JVO+ywp9EFR3hWTFBrHnlzTfsD1lnjLVt9qHlvllaN8XHLsG6UnBme47zE2cmMKkH+
         zQxRK1VFIyWHT9TQvvQTu2Z8liItBnefHkMyrqFVrcWF/blO6w5zIgiIo3g3759anrdi
         LbP/lS/mTycyuIzyh1F8v9kWdkKSK3hdq3cABr7N9K/WNdMNRvWtUZjAtLoA2ej/qi/X
         z4ALS+K3yA9Fpv/pLanx6zI5NjdZKcqnhdj5WDVfhVh64xQ4o2m9U3MweHhcefRqW27c
         AzxawtqXXdnn+CmuUx6wllJ+MPWWy1bQ4OgYu0vPKQQjQa6B5cudliWu8AfQUhllww7Y
         DQ+g==
X-Gm-Message-State: AOJu0YyOYpzBiU9s7lEPx+O2aAnRZm0jaYpdxSocxkHocevYz6q9Yrxg
	XiN21je4vgkXqrqrj25+2d0GvILm9VH7mLSZcKnRvQbg/FziEZi/
X-Google-Smtp-Source: AGHT+IH3rdpaPstIg451VV9WKzuac3vxxfXmFcsP2C4u/6MfDCo/dU1S7gB8IwQ/xFpkZWyAiG20ZQ==
X-Received: by 2002:a17:90a:4747:b0:299:7824:6a06 with SMTP id y7-20020a17090a474700b0029978246a06mr4804435pjg.8.1708917796254;
        Sun, 25 Feb 2024 19:23:16 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:23:15 -0800 (PST)
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
Subject: [PATCH net-next v10 09/10] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Mon, 26 Feb 2024 11:22:26 +0800
Message-Id: <20240226032227.15255-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240226032227.15255-1-kerneljasonxing@gmail.com>
References: <20240226032227.15255-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
--
v10
Link: https://lore.kernel.org/netdev/20240223194445.7537-1-kuniyu@amazon.com/
1. nit, fix the indendation problem (Kuniyuki)
2. add reviewed-by tag (Kuniyuki)
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

v8
Link: https://lore.kernel.org/netdev/CANn89i+Uikp=NvB7SVQpYnX-2FqJrH3hWw3sV0XpVcC55MiNUg@mail.gmail.com/
1. add reviewed-by tag (Eric)
---
 include/net/tcp.h        |  4 ++--
 net/ipv4/tcp_ipv4.c      |  3 ++-
 net/ipv4/tcp_minisocks.c | 10 +++++-----
 net/ipv6/tcp_ipv6.c      |  3 ++-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index af2a4dcd4518..6ae35199d3b3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -396,8 +396,8 @@ enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
 			   bool *lost_race);
-int tcp_child_process(struct sock *parent, struct sock *child,
-		      struct sk_buff *skb);
+enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
+				       struct sk_buff *skb);
 void tcp_enter_loss(struct sock *sk);
 void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost, int flag);
 void tcp_clear_retrans(struct tcp_sock *tp);
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
index 9e85f2a0bddd..52040b0e2616 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -911,11 +911,11 @@ EXPORT_SYMBOL(tcp_check_req);
  * be created.
  */
 
-int tcp_child_process(struct sock *parent, struct sock *child,
-		      struct sk_buff *skb)
+enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
+				       struct sk_buff *skb)
 	__releases(&((child)->sk_lock.slock))
 {
-	int ret = 0;
+	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
 	int state = child->sk_state;
 
 	/* record sk_napi_id and sk_rx_queue_mapping of child. */
@@ -923,7 +923,7 @@ int tcp_child_process(struct sock *parent, struct sock *child,
 
 	tcp_segs_in(tcp_sk(child), skb);
 	if (!sock_owned_by_user(child)) {
-		ret = tcp_rcv_state_process(child, skb);
+		reason = tcp_rcv_state_process(child, skb);
 		/* Wakeup parent, send SIGIO */
 		if (state == TCP_SYN_RECV && child->sk_state != state)
 			parent->sk_data_ready(parent);
@@ -937,6 +937,6 @@ int tcp_child_process(struct sock *parent, struct sock *child,
 
 	bh_unlock_sock(child);
 	sock_put(child);
-	return ret;
+	return reason;
 }
 EXPORT_SYMBOL(tcp_child_process);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0c180bb8187f..4f8464e04b7f 100644
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


