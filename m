Return-Path: <netdev+bounces-73538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB185CE6A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F89282A22
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8652B9CC;
	Wed, 21 Feb 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWtayUBH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C312837F
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484297; cv=none; b=dEiuPMJfT1anu96lvKQot8taunsS/ib8vn2OcObmcdwTAnC4LiBfvLNqHtHyMPkIe/AovlBTw9lglGY2U4dBeJfvJ1qDyRExPszJteNJOutaEi0UdfeV6AaK9q1VVcbZrUUJkNqUgeV0KOQUa2x9tpoH7yrIWwVj05NviI3tA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484297; c=relaxed/simple;
	bh=ZwHDPF/CvsDu+GUqTG1yxCkMD92Rjk9NKTkuXfnczYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AN+EuO/RBndFejLOYxLPhAsRL9GxsiuNEgvdfJj9KHp8w3E3aktv0Eieito7JVlPh0msoCnHimc/wr4CG5qD1T6TjxC/FFzcwqTZWTBE/KlnRrXN9o0rvJTNY2FVn00CwvtkieGFtQI6qso26Ze1gnbVr3AoJl/RGAkAe5lV0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWtayUBH; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4103880a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484296; x=1709089096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wsc0AM2eL+AajhMGwF/JnhRj6xqyGGgalVKC2FYGpRM=;
        b=NWtayUBHjenCNxElARwgU/Xw88vNwGL6s/LkSL56FLfoui07ySUI1+AVTGLUBs1t41
         K8KsEwNHRem3D3/i5r+/sM1yZweYq2agfAlR46H+dxcmjxRt7W/Cfm4IXGaON0EwbG5k
         RaJY9ZjOSxVrHIpnKoKBtxRBmS7H+HYn6736AebEppf3aEgEx/COAJBJy87OVzOOkSkg
         ONWZuKX4SReWvDWi5XqygiFGuy1UrmacpsxgTc/xsT3s8cAiLchY94B0KoO6DIpmubtf
         6ncPw4UDD05NBaWN6j3cMlCLWCgvnZyN0eJAsDUaNW0SczcpGBNJxXYt5nMqX7UWISvy
         tTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484296; x=1709089096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wsc0AM2eL+AajhMGwF/JnhRj6xqyGGgalVKC2FYGpRM=;
        b=ppHnkPQomlZ847BuFjPeg+YnOwy4UJCbL6SKeShEMJMXTDoa50kaUqkO+CpqdzLpGA
         sevvukj1DhOAq0T/2ixTRAf0ws29zE9VoT493xXFtPJ1tYSCC6CR4FNl5X77d02wn3sA
         /Rys98Ut9h9K32BsQIZvAftoEa5L0q7tm4E6dfQky5rN7kTxBD5Pfe15Ufg7cRjsU3xp
         ugCFPexvOpzDR/gcCwpB6WFvVEwkV1XR7z7VBT5SMByyJBJfyAfwppDdY5A27gkkTVIT
         dxJQPo9IH1DZ4v8OcYBlBlaAVBmhuM8thI0ajAT5LwsgJQ/8E5TUhzGVgw38heijiEVR
         dBTQ==
X-Gm-Message-State: AOJu0YwUk5952nqydTMplrcxQhchU6MEmwnSaDg+OzxAc68aPLSUE+fh
	RzqbD4zPRinGrIgaQ8poEV7M8n+UDfbkktnbtNns+uaDKQli4Nuw
X-Google-Smtp-Source: AGHT+IFIwUEjqRGsuheqgc0i3G1qp2b78Sd+H92DBQ5nZ83dtxJiH9YX1JdrQUulvS4ibIeXcUtp7g==
X-Received: by 2002:a05:6a21:1394:b0:1a0:aa34:8733 with SMTP id oa20-20020a056a21139400b001a0aa348733mr5876161pzb.17.1708484295683;
        Tue, 20 Feb 2024 18:58:15 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:58:15 -0800 (PST)
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
Subject: [PATCH net-next v7 09/11] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Wed, 21 Feb 2024 10:57:29 +0800
Message-Id: <20240221025732.68157-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240221025732.68157-1-kerneljasonxing@gmail.com>
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
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


