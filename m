Return-Path: <netdev+bounces-72808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B9859B01
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CE51F21763
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5DB63A7;
	Mon, 19 Feb 2024 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgsoKnWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812263BF
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313379; cv=none; b=kpsGEtbFQY6jaCIET8+TKziZaGRxSQZFhhGzXxm41L6kYkcmET1c35gLgNWSy1w1Iwcs2OPkaySBIl59vIHhTKmB559e48T7+63+2p7yz8mPms1aa1IZszUb1AA6YlL1rRJX/Xx1LyEcYh/MVAG3Ya/qt1EUkw/PApnw2bdKeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313379; c=relaxed/simple;
	bh=8twNxzQYS1IcyaQkSI9OZdvSEEUEZt7VyoI504ITYPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIGQJqAJ8I9iTv9eKz6FKONaty4qdcMxQe6XWRJOO2UQiTRafapmo2Guwll6KBnNU9j9h0YbT0ZqK32ispS+JASnrZWtm6IT0ZyqRfwopjqEq75J138fumYLbVGuJoBhLn88hZZI4vMgreSDJEaVZx0NCMC3xkohd9u2ZJessds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgsoKnWM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso2578200a12.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313377; x=1708918177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlOGRGys51Zl/spHwwMuYe8BXaGiBYI39oCfCcu0XoU=;
        b=LgsoKnWMOISrw1wQwADsEFxiFdaoiTscIZpixIroqh9huBKDAiFgTbhHHpxjLmt57J
         5aE59OWfU+9ZbojG1eW0/2J3uRLetlX3INI5Ja8/Z+wL3MHnZ1E9lBMti8380dNfHo51
         4suPZU1ohz0LAJiPg8ZwS7xr3B0tebGDXREKblkopZ4fLzA0nQmmeZjXVzz3bKZ5AO95
         6COJioSm3lvSw7B/e5GaApj+DtHWpbackyKNzqUFDGPPft51bRKHYUbzx22Y5ukz/WDq
         b5zMA58ZzN7q+kaoPsm+tH351NDWpf/KE/0OYaGc2GIXrmQXSK2Z8m2EYs8lNBnPIrhP
         yiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313377; x=1708918177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlOGRGys51Zl/spHwwMuYe8BXaGiBYI39oCfCcu0XoU=;
        b=CmCGkGjukcDUIxwb8xxZfFsuLiWlfETJpMrUyzykhyU/S8qjfzStfnKWIMgLSZFTDO
         ALKRFRmPObjCwiVWDSozKbNLjkx+pCiwcno34HR9W3sO3UMRFCrIs9ryzZHdwsdlzz0c
         i1iLmbkmmc60gqlM3uwBjhefEN6kluSP9p2SB7IdjHL6GVMZqZgf58ZLWiHZgRW2f0hL
         2AOAqHrL91zhS51YgtNWbTYrzyZsnZm25iGia7Wrg+jyWD0Y4HLmQrXyd5C1jsr3FK3t
         wo/dQEwxKEgzlblS21twj1XigBXfdScUSop136EV1pXciLHW1ZiWlLpmU0g2gAQ4l4v6
         9EtQ==
X-Gm-Message-State: AOJu0YwpCDtlv5znpMCF5ACxeLPvlX4ZKv0iMoK5oV2DFW7teGorr9DU
	PKdZaINukZBIHrKvv0SZf3U1N74hVFcmO0KcU+U9o6r3yZkH1sRz
X-Google-Smtp-Source: AGHT+IGdjRnGGcci7Nv3OFjFpqSjz0B9blTEYTQvVnknti7P/rP9wvuWKslAUyfl3QMcW8RKNL6ufQ==
X-Received: by 2002:a05:6a20:d809:b0:19e:4f20:3325 with SMTP id iv9-20020a056a20d80900b0019e4f203325mr11887159pzb.46.1708313377235;
        Sun, 18 Feb 2024 19:29:37 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:36 -0800 (PST)
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
Subject: [PATCH net-next v6 09/11] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Mon, 19 Feb 2024 11:28:36 +0800
Message-Id: <20240219032838.91723-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240219032838.91723-1-kerneljasonxing@gmail.com>
References: <20240219032838.91723-1-kerneljasonxing@gmail.com>
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
index 4cfeedfb871f..4a5d5c8fbccc 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1665,7 +1665,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
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


