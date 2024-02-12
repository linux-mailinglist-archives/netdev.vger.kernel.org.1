Return-Path: <netdev+bounces-70901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1FE850FC2
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73309283CDD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4884B13AD4;
	Mon, 12 Feb 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjiHgdO/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345B522C
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730191; cv=none; b=oZ2G3jJvDffFvtXrzJBKUS8klrJoOBzQH7pYBJeFjIn6Lka2sHGSXw2M83K5N9u04dYVd7SZ7zvXkrhBWxk5gnEB0KZSqIqcqsMs9CSa3ECmDYtQ5TOhQPUE16ovGUfP7yBvG5RIRjdgEApuEp1TjBKP0e0u1LR2pFBbCd0uiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730191; c=relaxed/simple;
	bh=fG6+f/knrZVVea72s9t5w9HbeU82G1WSAfUU5RZev88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7kIoz8qeehzr/erV6r0PalY2DYDuBjVrWjopU+FaogFIkdbOCYTDXJQ+cZ3ca2GGRfoIlfUb4AF7s00i5d23acVyqo8GqfGSrA6tr8WIfIoS0bMwdpFIMmswxLq7WwHjKrjGC7Zm5osl35Zz2ySTExWnACbECP2p4KwmU0J30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjiHgdO/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d74045c463so22809625ad.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 01:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730189; x=1708334989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLFyXQ7/UOg1JD4lPqBFMiUbTXIwLZt03FM53+WqP7A=;
        b=kjiHgdO/M2/J0C0QhyCXQvQHeJqexKrlPCoUWY1uPlsRV6ZP2p8STzWJ2eTvL0eruk
         ReSX//6/a+8sx4oSZmTgR2KIQPX245MAJkien9RUU82EPv3vpYAiWLQWij17drbflhCM
         y59tjMQ7qbUjlDjD9n7qccTlTfWVQDhwnSgaK59ar+eYfAsAFtYl4Ytj225Www8ilj1c
         +gvficKS2B7baYGCutzy0DNcHtY1L2MaJHvJ8AN3oxcUpFx20sz4Gkx3bsYC87jgFnnY
         teNn2FXMx3OM8ju5ZIyXxbweSOCSIYokGJzLA2t1ciYoDFA6odo/OKHx4iN0ZqTUx8Np
         ryQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730189; x=1708334989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLFyXQ7/UOg1JD4lPqBFMiUbTXIwLZt03FM53+WqP7A=;
        b=USt32HhugB7RxkxryMyFLAipe/IBT5tbVjvOrs0JCrPOO278ynJVd7rQR6GhJsoI+B
         g8VHfRq1xnkkfJ4gwMbh9vW7exM8nsJJ1zMcQuLIRr8zR8t2JE2Dc/p6ElN3KE6BMV8X
         cnxf3NPcGK8KsVjvbeekyoXQ6XhKTLwTa6sAQtJuc6vRa3MepOwx1CCZThWKQ2U9bwz0
         20NC9EKLolXjflz79GyqosmgCs/oZRL6/c1kyqdWM+LvkVKfVnRZu0YcI0jDurzWLPh/
         WsLoftuI/sc+V69Jd+LXTThB/BayLQRtXjSp2Pj7h3WkwquJteSjuYHCo9y6NDoHm5k/
         QKwg==
X-Gm-Message-State: AOJu0Yw6ReBocCFxmQF4zro//qFDJuuFTxkzF+x9utBrkx6Evu4BWMve
	YiK5V7OyjXodnvZwgRH8AjGcR8nYaP/L9vhRWIJHqAxfjti1Qr/c
X-Google-Smtp-Source: AGHT+IEFaplLhyIInBnGDVvSSu2lgL2qZ2UFDdZZqje7f9BfQBN0LtFTsRgfTnwAU7Q0HgqLTIWoCw==
X-Received: by 2002:a17:903:3287:b0:1d8:ef8d:a7ec with SMTP id jh7-20020a170903328700b001d8ef8da7ecmr5867465plb.2.1707730189053;
        Mon, 12 Feb 2024 01:29:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6R/zs4VjOa/nBwJb48fgGitdRixoD6Imhxvr62srMnCVz3bIjbM3PkInayKz7zCVXRq03awykZT0YMmWbWsSyBmiTSJvZtlZJ8q4SDKVFkNNM7xXhCaC6IdUPYaF23MuxbA4jtCxyJO1T+vvZa2Yszfo+QtDE5QaKtsZ64RXK1CKjo1ArBWKbwLufChPM8imMzgLWk5QPT0+fiyRgUyTkPfDRYQNY42XrsF+JUdo=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id mg12-20020a170903348c00b001da18699120sm4220211plb.43.2024.02.12.01.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:29:48 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 4/6] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Mon, 12 Feb 2024 17:28:25 +0800
Message-Id: <20240212092827.75378-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212092827.75378-1-kerneljasonxing@gmail.com>
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
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
index 27639ffcae2f..4924d41fb2b1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1669,7 +1669,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
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


