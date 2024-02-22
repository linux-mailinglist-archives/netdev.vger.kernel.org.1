Return-Path: <netdev+bounces-73962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4CD85F6ED
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309FD281DE9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3645BE3;
	Thu, 22 Feb 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9sDkZrk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605241211
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601438; cv=none; b=qzAxKjK+950LFz2jl0E9HGMvaI2RIyzqy+Dqp90eVqofIrkk48OBsP4ZDWBdWtYPDIIiTNHzWRynBJzScYAtW9VeILPNr0qxzdMM0bI+89gtcbxvbr89m6tnacz9/Mg9h/fUqZavhSyYGnmB9H7bQ74q7EJaj8WAR3j0KiOMVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601438; c=relaxed/simple;
	bh=O4oTQs/aaFIIMLiBJKHYhDb2JP7Jc2T973iz2qUFbi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okNPdglkXL0JIXTVjex0yDTL9vGjGFGFa7aSx4AkTWr4z5Wp6BOVuRZz6rvvF5Gu6lzNFR2/qxKhQUuzD9B7Z2YXUeiAUtJjZpnY59kyPhyuuBFjVg7XeQa6FPIPfVh0f6EalB82XqbEA4fNDYyCQE+tAwOzzbz5hLrmh5zdwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9sDkZrk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc1ff697f9so21808275ad.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601436; x=1709206236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLbSM/Q1lnm2NxJHiR/LAY3PU1dn10NOJqAwvehnkmU=;
        b=G9sDkZrkExYX60xSAF64EYnKB6nH0rXxSGyJhaelL9x1600Nvc0+p3Va6Qscp6Eg8I
         1DauSJ8VviN0WBqKL1DIMJOXsxMbwk1rp6JbRl03sYx+WS9vXh+yBiT1ebUlIqTHaKj9
         qofpms6bKKX89CtaDz6XUuJGVS85l4qDfUEmv/qxhOYWSGf1wXR26NVf5MSO6h6EHaCD
         Afo2MRcv7BEEiLTlrttRPOh+dM+n5NqRvC5mjIaan2zR0z4wRiGRzTtM45bDkCwpPyUk
         pKW0ffuObZ7AWvIUS6jF9JLJNUrcwZ7o/lDPUzUbPs7PSam8RaVc2gnpfV248QhZWElN
         dvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601436; x=1709206236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLbSM/Q1lnm2NxJHiR/LAY3PU1dn10NOJqAwvehnkmU=;
        b=jUkwUxhXRDTT2xWbEW4YbHknkwcypEJVxVULjzW8+vZTTRlUAKeQ3Y/fMwBE4r207G
         exTa8DO5aYkMi6ChnEMYpnuA9e+o8D6T9oSXRPIeVDP9biQCjj/vEV1bJ9JvlVrWI6aD
         oxYctbe6rIFvdancFPoUQxFW0ZJqv6k3NFn/8wBt+knjsPY8r7taSSOFIO5oqgiXHz4+
         6WnSLb76lyL1LUHAjKJ8dwmJPf3PwiwWdhrcZdJhJ1o1Eh1vVKHMhwbrRzzUwSmjn1w9
         kbM/BbDHXYncG8yIuFjZ9C7O3opdvblRX9WhDFz0n+rJT+cO2LyHzzNYjC2RBUwuXfpG
         8Zyg==
X-Gm-Message-State: AOJu0YzUSkinrc+BtR4556MPAWcoW7RRbHSkQfQ66Zz3DnpEP4H764uv
	tyUQ7UFFQwJqrAwau1kZHAvUv1cEZ1mHNz7Vd0PLDNjB9t1iFATi
X-Google-Smtp-Source: AGHT+IEUbah/2V+NSuclgrnRpaySfb2/xumzvX0aEmrcQfKlI/mCSAtkm0dbcJpJvsTteZNnmE2K5Q==
X-Received: by 2002:a17:902:7001:b0:1da:1e83:b961 with SMTP id y1-20020a170902700100b001da1e83b961mr17075140plk.63.1708601435913;
        Thu, 22 Feb 2024 03:30:35 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:35 -0800 (PST)
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
Subject: [PATCH net-next v8 09/10] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Thu, 22 Feb 2024 19:30:02 +0800
Message-Id: <20240222113003.67558-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
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
--
v8
Link: https://lore.kernel.org/netdev/CANn89i+Uikp=NvB7SVQpYnX-2FqJrH3hWw3sV0XpVcC55MiNUg@mail.gmail.com/
1. add reviewed-by tag (Eric)
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


