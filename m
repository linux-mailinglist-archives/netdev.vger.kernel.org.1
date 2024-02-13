Return-Path: <netdev+bounces-71398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F049985329E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77BC281938
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D756767;
	Tue, 13 Feb 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ1iFLBr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5556B6A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833181; cv=none; b=A9m7Yz8kfwUYqzB32/siCqLnbpjXpoRO6IpP69J6z7VqTycTw2NcmgVNa/foFuva3fqqbUhoR4ak3QIbHY+a+d76fP2lRorpQRbQL8kiEbbWACRHXJ3CQNv1xZDuV4uP+vimFKLogvk6DP341ykGNgo2uFTsBfBUPbeaKfQeH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833181; c=relaxed/simple;
	bh=fG6+f/knrZVVea72s9t5w9HbeU82G1WSAfUU5RZev88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7F03dpn152jxZi710HrkgBXx/PPE0S2SPDLeu7rAoUcNZpZY848MfEiWeSDbCR+7qwL75bhoKP117sEJmXSDnuF93lEx4pp3s2Aaq5s2EYiL2HrbaTc38yJOSyEovI2wKYBLcIdGy0VusPe86cYCaIkMZ4z+HFJZ14A8WpzvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ1iFLBr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e104196e6eso177637b3a.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833179; x=1708437979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLFyXQ7/UOg1JD4lPqBFMiUbTXIwLZt03FM53+WqP7A=;
        b=kZ1iFLBrl7OlxfxO6th8P2FipurI4qcjRoq0W0Hocr4uvsxq/eCOR/TaBeDBuE0UnK
         CE6FSmXt7UcRno8kRRgJcFZKpiwSeSQ/6q07f6jQJf8fj+yHBFUlhESE5nAizKwvEH7Q
         2P04qvWMXDkOs+FueEy4SVdxeNM6qF1DWDR5NtYm5e/+MVYdwPErQNHlKQeTS7g+2g0K
         PZLtMLEBXWQEb+11LYwosUzf91wMql75GJIejBc5gMSgOAKg/iyOfXOhqNGCsgN7Zwcr
         Xs4KngU8ASp3cjZ3XG3T3WReXah2CoA9tp/e1BbELfIGYI1dM+81wLtSace+GODZFDVI
         D1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833179; x=1708437979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLFyXQ7/UOg1JD4lPqBFMiUbTXIwLZt03FM53+WqP7A=;
        b=p4oTm9jB0wAagKnNjnTajY9VJ9Lg6fck9HugZYJ+1ylu98K/EbwrI5IT2OrUL+HUyw
         61ptY5TkHyytHcAYawz8j6bW4cILKRg10X5of6NN3EynKBCCqleTfxOtC+EbioV3fdPS
         u4Yr1oMuTFZsRMPnPd1JD0kkpHjy+Uqd7NbHUy7KOjYS99up9yyXa9ztsiQhaUotewf6
         XtJeBEuFfyCiXwrmiDqJlnWs97jPP+ox9hzSZopK7nS9Yz19pN8fPP+Du7D9lfUCGNxe
         RkgspAlLV2ij2BGlczYNI1g9CntRsSZZ7oQn9gpCYuSqGb33VFZpt+tGZTvtTP+Uo6jg
         JgKw==
X-Gm-Message-State: AOJu0YyuDZ7aG+38TvTLPeHpSSWZeKl+79cQ/tzUX9PuaHqsARPheQgF
	iu6OV7vCUkVpoWnRwpRH4yS3paRqZPoPZzk4XbpHB8FcLWynGFFb
X-Google-Smtp-Source: AGHT+IEW1zqpJklppEQtmyXvEtdk5nADZgWQ5nGdzK160psWkadBUON3QlMZox6pNtkrJo74NhDbTg==
X-Received: by 2002:a05:6a00:2f97:b0:6e0:9ce2:b598 with SMTP id fm23-20020a056a002f9700b006e09ce2b598mr10879687pfb.31.1707833179157;
        Tue, 13 Feb 2024 06:06:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTUKwqLWHfWXhVRaYAQ1c6liByFM5OwhedkoMAQfirIVCQSVRQ/+3Q7b4cVwZcY1SSZ5IIkEg7rLELSN9kIYQYLLZbmBTcl3B9L4ShDMZh8aKbAs1jyMMPknl+mFGkhc7p4pMNmx8lwPUAgfA7YNKwLhTvF7NZVtXZgmhPqAT//W8D0hS+Lw7kH+XLe1SjC8hO1lB1IaYIHBXv/kZGzVgxktQK7j+KlMczHnUIgxtHzz+39FrTBremww6QqTe5ag+S
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id q19-20020a632a13000000b005dc8702f0a9sm1306247pgq.1.2024.02.13.06.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:06:18 -0800 (PST)
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
Subject: [PATCH net-next v4 4/6] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Tue, 13 Feb 2024 22:05:06 +0800
Message-Id: <20240213140508.10878-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213140508.10878-1-kerneljasonxing@gmail.com>
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
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


