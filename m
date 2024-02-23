Return-Path: <netdev+bounces-74348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A700F860F4E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB06B23101
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4785D728;
	Fri, 23 Feb 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQyz6nk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F930D533
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684193; cv=none; b=ttLKbOeHdHfmzdbZI40QlfA7ntJ/hVXrG7X/wcjnlZ3gJJ2ehRHhmCuONhxls6XHuEzhrqSWwhNXpBS4lK+LIb09lwWB/KBI7+o4jTbe9RwHFq0fUcO21CwALc49jKFvBWrt7DmAYeZvhI5eTFhEWVsHkoHr6DfhGT0rBewa1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684193; c=relaxed/simple;
	bh=wEHuE1rauwop6W079PH7gANF6oPZtTcaf6JWO+EgyiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQVY78qY9yV94vYrx+nqB4gHDsuOlWmTxLVBQniWtW+AHpp3VZ1dGPp6frwR1mPoPA7JSzHWBvtZhF3ZSbsxHBY9Dkl0H2CejGYRFqirJsC9eFDxEIvas47EVFSIsMgXrIy/PEgyM3+3svfLHFyBZTTHBSvDR5Y1bSi1BZ3dN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQyz6nk1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d71cb97937so7761845ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684192; x=1709288992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N16M0/5IG3v1j3LIKq8uEOTY7VMyNxn3foEajFTtlQU=;
        b=FQyz6nk1qZ0mhlsk6s6yPbq1pQEl03JVF097n820/KI3MbsCOqIFVDHHQTKiIGG2oh
         kwoj9Utgw3gwlA2/yoAAf7T9gaZeJW9nB1pAvkxwj7QlTZpNzmqg/pSdOjX7oRQ7Nno6
         J2VqjjnjVY6oNd7yCKzqBHUmghoxtRio+44CKmq5EK5aK/D96ViMwR2myuhbb6q474qC
         I1iHx2KtqarmlEAfI68ooV9bGCd4EQ0Uk0uNS9a25LrjqqzUBDY31EPpLMhacEktjKJ1
         DJhX+v++ZqLtXIkzfSwmNi04xoq9NtKWR+4Ng6B6Fu5/83FlosVub4y2nNxdUuD7M7xe
         98Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684192; x=1709288992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N16M0/5IG3v1j3LIKq8uEOTY7VMyNxn3foEajFTtlQU=;
        b=K0b02eyZlm70MX732237ScMGXMxSojR4xFgXUnRCd8nbrCzQBnL6w9KEkdRHlW3e/U
         KzO6V3wxMkH1llTFtsSHrvri4qyZytBnIZh4aEPAVWnWFvNtm+d/OmzBYAWpytC1gJIA
         YRVig9o9xnfpXJbmgyJ0y9iU2eEksADPOSlQFCa0F99AHlGELk9gLd/Gq51MDeSuvrUa
         OVVZQSdgN0O860N01Ktq3EbEgm35T6LuGvtynIpurCRgvbCH2wUv5DLvy3j895tWX6qR
         RYB+HXIo8NS1EbXpxspNTQChjQuoFUW/oe4fuLJzvZEo/CdZ0jUd4sUzLMa/jnqVIZGp
         d3YQ==
X-Gm-Message-State: AOJu0YyP1+Qg/hirDBv3mh73GI8r9L5Ixr0ktNb4BeffGqf2xO5fQfuj
	Jp+rh+HO2IMq2lZhAC8eI1uFtGmhoWWwdcdN0CqXVEQARTAzwr8r
X-Google-Smtp-Source: AGHT+IH5PdhrpEYxhkK2nz4xD1q0DHP+ktmzMTIO5KI8mjl5qJYM1uj1PsyzcR8gkvEZNvDjJEv0uQ==
X-Received: by 2002:a17:902:8649:b0:1dc:4d63:7a0d with SMTP id y9-20020a170902864900b001dc4d637a0dmr1047915plt.41.1708684191830;
        Fri, 23 Feb 2024 02:29:51 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:51 -0800 (PST)
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
Subject: [PATCH net-next v9 09/10] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Fri, 23 Feb 2024 18:28:50 +0800
Message-Id: <20240223102851.83749-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240223102851.83749-1-kerneljasonxing@gmail.com>
References: <20240223102851.83749-1-kerneljasonxing@gmail.com>
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
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

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


