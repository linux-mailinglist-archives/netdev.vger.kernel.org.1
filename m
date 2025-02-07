Return-Path: <netdev+bounces-164051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFAA2C716
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654B416C16A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE623F298;
	Fri,  7 Feb 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcOxjPpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19723F264
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942120; cv=none; b=IMSkEbSkn7SqqDWnZukPwj/5B1tspQUusK3wguYdjbRvOxDFMR/FfxW7Vnds1l19MmMaPnbIMaI55sUvm1Bd9X1vZt+z+AUvYrjivb22VPAWmyy71eRsGNciFjtkmYBxNNkgl297yAQ9AtwjCwxfLEjcAcdMjKS6Ez/VtdZONQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942120; c=relaxed/simple;
	bh=2TPbAf1GwBwt9eLwX6O9RE0KbXbsF8H9n+HGujmwY6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKLZ9FylyNaVgnraJKd+2ymjwEXYWMleEaH6HOv8IZQ1AqFAqJ8OrVCg8H6twb6kJQdpClBNBLz2qpQDEu5t7MlmVMR8VOf8M5DbOdS+7Zggx/cIWRv0loPEJVgt0TPnWK7VdJzfWHeJXeEwxjCfZ2gG4dUmDaBd0U+o2nphtVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcOxjPpi; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-467b19b5641so41511451cf.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942117; x=1739546917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnvHEkvVf0r/3tf5ctn6BlTYjcq4aMLyLisb+17Vxvs=;
        b=XcOxjPpimulYTutS8lMrRNzyKndoCRJaj2yq3qRzOsZfo368I6LFu/rt7d9m5orWfp
         RhTmNp+ByNXzULjPKJLaDsFu5eKdlM+aHHUTt6x6q1WaB9KQ0OQEZgAB+n8Hcmum41U0
         Y9aoQkD2dkvwj+3C1BU3nUHI0mLxzTySOni9o/cGWE7JhZh3IySQ5lPghGrZVVtDKFe2
         n1sNgQxzR95d1ibwLRWz2Rn3HHFq+0QTxokr3d6PxMDpf6qaKvKjJ5Vsui2w+aY5HIow
         4v7wcWBTGmX9K60RtRmQ6BB4DmGh5t6o3CRCHPuUdIQoYsEvfDEtf+9GuscwgQUG8BFA
         H3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942117; x=1739546917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnvHEkvVf0r/3tf5ctn6BlTYjcq4aMLyLisb+17Vxvs=;
        b=w8pHfxy0Ld7yUCPIwwuz4qd8b6W0wxtyU0xrmzO/1CstY5JSMF8JQjWWFH7ePUMQI+
         fckXiou9PfnmtAT64ayEE598rOU3F51tCiQTNNli0egXHTzDxDFcyzyVFc7Hx5YaJZW1
         SggF6a8dMl3520qT/wN5Xn83JRNTErJoWh94O4D541Dj01b96t17I0zzlQqZ8UnZIDqc
         7lsv47e75JWWN/FVUwAXLgO6oe9yjpcSfZxWf3Wg7phylBLRmSc8P2+JKqilCVnK1Pi9
         BD0hypHho6Ld4zlk71Pzou65VjCtoytbPmYSaCB9rSFKl8Nv5AsI94+jQ+Z0as1Yq6s3
         Lh2A==
X-Gm-Message-State: AOJu0Yy0onkP1FLnZhm1OTISCrY//axLvY15zsUEtkV46XlP9WBKpFN2
	Zd6Z2vCa6yIi42j/GH1b/bY19IpPsXrK60KDe4wHWxivcijz27pQdyXRFGa0x8XnzjFu6RdTe4w
	ARTKQijvu8Q==
X-Google-Smtp-Source: AGHT+IF82FffKMfM9fMCF4EgPDTRZ6HXnwwcI1dqtc+wNiyfPbCEkFACUd+NzmPA1t3ZFgKU7a+rlBX5ZdROKw==
X-Received: from qtku15.prod.google.com ([2002:a05:622a:17cf:b0:467:9ddd:c373])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15d3:b0:467:5a0b:de08 with SMTP id d75a77b69052e-471679945b4mr49429571cf.8.1738942116983;
 Fri, 07 Feb 2025 07:28:36 -0800 (PST)
Date: Fri,  7 Feb 2025 15:28:28 +0000
In-Reply-To: <20250207152830.2527578-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207152830.2527578-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] tcp: use tcp_reset_xmit_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to reduce TCP_RTO_MAX occurrences, replace:

    inet_csk_reset_xmit_timer(sk, what, when, TCP_RTO_MAX)

With:

    tcp_reset_xmit_timer(sk, what, when, false);

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_fastopen.c |  4 ++--
 net/ipv4/tcp_input.c    | 12 +++++-------
 net/ipv4/tcp_ipv4.c     |  3 +--
 net/ipv4/tcp_output.c   |  6 +++---
 net/ipv4/tcp_timer.c    | 14 +++++++-------
 5 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 0f523cbfe329efeaee2ef206b0779e9911ef22cd..e4c95238df58f133249a7829af4c9131e52baf10 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -274,8 +274,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	 * because it's been added to the accept queue directly.
 	 */
 	req->timeout = tcp_timeout_init(child);
-	inet_csk_reset_xmit_timer(child, ICSK_TIME_RETRANS,
-				  req->timeout, TCP_RTO_MAX);
+	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
+			     req->timeout, false);
 
 	refcount_set(&req->rsk_refcnt, 2);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index dc872728589fec5753e1bea9b89804731f284d05..5a79253bfa1906e1fe26625f6644e765e962b0e9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2252,8 +2252,7 @@ static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
 		unsigned long delay = max(usecs_to_jiffies(tp->srtt_us >> 4),
 					  msecs_to_jiffies(10));
 
-		inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-					  delay, TCP_RTO_MAX);
+		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, delay, false);
 		*ack_flag &= ~FLAG_SET_XMIT_TIMER;
 		return true;
 	}
@@ -6469,9 +6468,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		    after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
 			/* Previous FIN/ACK or RST/ACK might be ignored. */
 			if (icsk->icsk_retransmits == 0)
-				inet_csk_reset_xmit_timer(sk,
-						ICSK_TIME_RETRANS,
-						TCP_TIMEOUT_MIN, TCP_RTO_MAX);
+				tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
+						     TCP_TIMEOUT_MIN, false);
 			SKB_DR_SET(reason, TCP_INVALID_ACK_SEQUENCE);
 			goto reset_and_undo;
 		}
@@ -6586,8 +6584,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			 */
 			inet_csk_schedule_ack(sk);
 			tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
-			inet_csk_reset_xmit_timer(sk, ICSK_TIME_DACK,
-						  TCP_DELACK_MAX, TCP_RTO_MAX);
+			tcp_reset_xmit_timer(sk, ICSK_TIME_DACK,
+					     TCP_DELACK_MAX, false);
 			goto consume;
 		}
 		tcp_send_ack(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cc2b5194a18d2e64595f474f62c6f2fd3eff319f..e065f7097611b70f41e75502d7d6f9248af1c85f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -465,8 +465,7 @@ void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
 	remaining = icsk->icsk_rto - usecs_to_jiffies(delta_us);
 
 	if (remaining > 0) {
-		inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-					  remaining, TCP_RTO_MAX);
+		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, remaining, false);
 	} else {
 		/* RTO revert clocked out retransmission.
 		 * Will retransmit now.
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ea5104952a053c17f5522e78d2b557a01389bc4d..e198435a9ca66a0920e1dbcff35d875c1e384037 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4162,8 +4162,8 @@ int tcp_connect(struct sock *sk)
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_ACTIVEOPENS);
 
 	/* Timer for repeating the SYN until an answer. */
-	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-				  inet_csk(sk)->icsk_rto, TCP_RTO_MAX);
+	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
+			     inet_csk(sk)->icsk_rto, false);
 	return 0;
 }
 EXPORT_SYMBOL(tcp_connect);
@@ -4256,7 +4256,7 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 			icsk->icsk_ack.retry++;
 		inet_csk_schedule_ack(sk);
 		icsk->icsk_ack.ato = TCP_ATO_MIN;
-		inet_csk_reset_xmit_timer(sk, ICSK_TIME_DACK, delay, TCP_RTO_MAX);
+		tcp_reset_xmit_timer(sk, ICSK_TIME_DACK, delay, false);
 		return;
 	}
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index b412ed88ccd9a81a2689cf38f13899551b1078e3..c73c7db362cb2bea8044ad928232f50bdc4b9bd7 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -481,8 +481,8 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
 		tp->retrans_stamp = tcp_time_stamp_ts(tp);
-	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-			  req->timeout << req->num_timeout, TCP_RTO_MAX);
+	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
+			  req->timeout << req->num_timeout, false);
 }
 
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
@@ -626,9 +626,9 @@ void tcp_retransmit_timer(struct sock *sk)
 		/* Retransmission failed because of local congestion,
 		 * Let senders fight for local resources conservatively.
 		 */
-		inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-					  TCP_RESOURCE_PROBE_INTERVAL,
-					  TCP_RTO_MAX);
+		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
+				     TCP_RESOURCE_PROBE_INTERVAL,
+				     false);
 		goto out;
 	}
 
@@ -675,8 +675,8 @@ void tcp_retransmit_timer(struct sock *sk)
 		icsk->icsk_backoff++;
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
 	}
-	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-				  tcp_clamp_rto_to_user_timeout(sk), TCP_RTO_MAX);
+	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
+			     tcp_clamp_rto_to_user_timeout(sk), false);
 	if (retransmits_timed_out(sk, READ_ONCE(net->ipv4.sysctl_tcp_retries1) + 1, 0))
 		__sk_dst_reset(sk);
 
-- 
2.48.1.502.g6dc24dfdaf-goog


