Return-Path: <netdev+bounces-91177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD6D8B1948
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D26C288C02
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA438182CC;
	Thu, 25 Apr 2024 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrgxLLze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407051BF3F;
	Thu, 25 Apr 2024 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014840; cv=none; b=Nie2gtvkUbKUYEM++t56TN/mItdGrcgShmN+hVugSbjxmXmbASh1HJAi8UFb2cUxONQKtwnsnc5GWt5OM2Eoy0TngIATrkdQAyoQPF0AVuWs/uHP/YRnI83XUxIy9q+q4o3JcUwDv++kXAtkhMsbGlV+O8PxieWJg11SAD1Rg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014840; c=relaxed/simple;
	bh=55/RHpoHlC9YB5YVGgh9ZYOK/TFTKOarJZAiAFO7TY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zm6J1WOi13OOpoU6NKkk1r7iqaY0YfofYngClE0z+UyPuyA81IDY2E7OXVUof/WuUpjQcNJ6CblzHErhszoMl/a7+dYhEdgsR8Co+wuReFzwGTepd33g8B3i5Yw6N4Hhlp/EPYeiU6Kd5//lH8E9HIM29shJvFu0SNGDZfbilJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrgxLLze; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ee12766586so484481b3a.0;
        Wed, 24 Apr 2024 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014838; x=1714619638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaTwbGXoanfrftf7v2SqxH09D9DVaPBxLL1b8FwqlRU=;
        b=NrgxLLze8Kx5EvU5YSQws+6K5ygkMhm2i/oezvIRMth6R3uI0Jw+t9PVngOusts4KJ
         b/G639qhGtEf1jaie5rcJJX0ws6BC0k9/fondio0otz90txO73slBRIw9CrS2I3sxa1G
         XD4InGqG3W+D33bf7LFEcZB8gx27PosOOjwWhYIV+IyFEXcp9NNopa6f9ZWTy+8nzTfi
         9yJAG8fDq7SP/CMsCvNuEnVM1iFUy6fhJT93+jn+3u2NXfwx73He1OjitFS9Fwu9OnVk
         LsrqhknESOqrEyDrPIS5o+mlHGiAWtljqtu7nGVadPDVEMiTD5J6webxNn2Nd3vhbBYN
         MmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014838; x=1714619638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaTwbGXoanfrftf7v2SqxH09D9DVaPBxLL1b8FwqlRU=;
        b=YVS8EFug0YRl9CAB/wQBIQ32ll0GipvmQp9OLVgtBYLtTXm7DZsRz84A1u0OMB3CJy
         kmsUIXpVyVrA5ZyPWPlA1+i9d76SRnk0ZNZnDb87QIBDXPKe6KyYJ5MVfK6PsHOJnVMO
         UL37175Xyvja98OrglOtQ5q4qrhpzZ5YlW6q0O4fLHmp3dC93JEe05bOQmJNyho4ajpy
         JwI8BhnlQXKrDh4vbBpl0ReI9DryzcylPsmBwQdOjtu+LUmOKsh1pOUScWaHXtReDGl/
         bPtwBW6ICXAlcEatewE5uDreFFYepcvZzqNPHj8srLRV8BNBqR2AY1O7kgrSLmfvo3u4
         RX0g==
X-Forwarded-Encrypted: i=1; AJvYcCWO2nMNaSCQJrHb8f5KIy+8eAnaL972gLg872wKKGOvD65hhTBVHHX/yYXryWjne6/p5t3K8yPP+ZGkuJMCImbl2Y91g90nBTi2U/tTamyhXlb2Rocl+OZIPwoaANt8J5V7sqBIJIQ3Lzi3
X-Gm-Message-State: AOJu0YwgAwTmqTgZePBAtfPVdDf9ATuCebk51Fefmd89Qy3HKg0qM1AF
	CupXPkWvvK0+fD1mjogVcdpJyJUoqOMNYYlANFZeLvgb3Hba/p1O
X-Google-Smtp-Source: AGHT+IHuLs/zkS5fTQu4UHxIOZWKIzjOIFxBoc0IvIZDFYIu3I0o6oP8He3xm3fTHI02JKi8A5Aj7g==
X-Received: by 2002:a05:6a00:17a0:b0:6ec:f869:34c with SMTP id s32-20020a056a0017a000b006ecf869034cmr2627838pfg.16.1714014838442;
        Wed, 24 Apr 2024 20:13:58 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm12588884pfb.140.2024.04.24.20.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:13:58 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v9 2/7] rstreason: prepare for passive reset
Date: Thu, 25 Apr 2024 11:13:35 +0800
Message-Id: <20240425031340.46946-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Adjust the parameter and support passing reason of reset which
is for now NOT_SPECIFIED. No functional changes.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/request_sock.h |  4 +++-
 net/dccp/ipv4.c            | 10 ++++++----
 net/dccp/ipv6.c            | 10 ++++++----
 net/dccp/minisocks.c       |  3 ++-
 net/ipv4/tcp_ipv4.c        | 12 +++++++-----
 net/ipv4/tcp_minisocks.c   |  3 ++-
 net/ipv6/tcp_ipv6.c        | 15 +++++++++------
 net/mptcp/subflow.c        |  8 +++++---
 8 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 004e651e6067..bdc737832da6 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -18,6 +18,7 @@
 #include <linux/refcount.h>
 
 #include <net/sock.h>
+#include <net/rstreason.h>
 
 struct request_sock;
 struct sk_buff;
@@ -34,7 +35,8 @@ struct request_sock_ops {
 	void		(*send_ack)(const struct sock *sk, struct sk_buff *skb,
 				    struct request_sock *req);
 	void		(*send_reset)(const struct sock *sk,
-				      struct sk_buff *skb);
+				      struct sk_buff *skb,
+				      enum sk_rst_reason reason);
 	void		(*destructor)(struct request_sock *req);
 	void		(*syn_ack_timeout)(const struct request_sock *req);
 };
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 9fc9cea4c251..ff41bd6f99c3 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -24,6 +24,7 @@
 #include <net/xfrm.h>
 #include <net/secure_seq.h>
 #include <net/netns/generic.h>
+#include <net/rstreason.h>
 
 #include "ackvec.h"
 #include "ccid.h"
@@ -521,7 +522,8 @@ static int dccp_v4_send_response(const struct sock *sk, struct request_sock *req
 	return err;
 }
 
-static void dccp_v4_ctl_send_reset(const struct sock *sk, struct sk_buff *rxskb)
+static void dccp_v4_ctl_send_reset(const struct sock *sk, struct sk_buff *rxskb,
+				   enum sk_rst_reason reason)
 {
 	int err;
 	const struct iphdr *rxiph;
@@ -706,7 +708,7 @@ int dccp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	dccp_v4_ctl_send_reset(sk, skb);
+	dccp_v4_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	kfree_skb(skb);
 	return 0;
 }
@@ -869,7 +871,7 @@ static int dccp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 		} else if (dccp_child_process(sk, nsk, skb)) {
-			dccp_v4_ctl_send_reset(sk, skb);
+			dccp_v4_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 			goto discard_and_relse;
 		} else {
 			sock_put(sk);
@@ -909,7 +911,7 @@ static int dccp_v4_rcv(struct sk_buff *skb)
 	if (dh->dccph_type != DCCP_PKT_RESET) {
 		DCCP_SKB_CB(skb)->dccpd_reset_code =
 					DCCP_RESET_CODE_NO_CONNECTION;
-		dccp_v4_ctl_send_reset(sk, skb);
+		dccp_v4_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index c8ca703dc331..85f4b8fdbe5e 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -29,6 +29,7 @@
 #include <net/secure_seq.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
+#include <net/rstreason.h>
 
 #include "dccp.h"
 #include "ipv6.h"
@@ -256,7 +257,8 @@ static void dccp_v6_reqsk_destructor(struct request_sock *req)
 	kfree_skb(inet_rsk(req)->pktopts);
 }
 
-static void dccp_v6_ctl_send_reset(const struct sock *sk, struct sk_buff *rxskb)
+static void dccp_v6_ctl_send_reset(const struct sock *sk, struct sk_buff *rxskb,
+				   enum sk_rst_reason reason)
 {
 	const struct ipv6hdr *rxip6h;
 	struct sk_buff *skb;
@@ -656,7 +658,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	dccp_v6_ctl_send_reset(sk, skb);
+	dccp_v6_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 discard:
 	if (opt_skb != NULL)
 		__kfree_skb(opt_skb);
@@ -762,7 +764,7 @@ static int dccp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 		} else if (dccp_child_process(sk, nsk, skb)) {
-			dccp_v6_ctl_send_reset(sk, skb);
+			dccp_v6_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 			goto discard_and_relse;
 		} else {
 			sock_put(sk);
@@ -801,7 +803,7 @@ static int dccp_v6_rcv(struct sk_buff *skb)
 	if (dh->dccph_type != DCCP_PKT_RESET) {
 		DCCP_SKB_CB(skb)->dccpd_reset_code =
 					DCCP_RESET_CODE_NO_CONNECTION;
-		dccp_v6_ctl_send_reset(sk, skb);
+		dccp_v6_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 64d805b27add..251a57cf5822 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -15,6 +15,7 @@
 #include <net/sock.h>
 #include <net/xfrm.h>
 #include <net/inet_timewait_sock.h>
+#include <net/rstreason.h>
 
 #include "ackvec.h"
 #include "ccid.h"
@@ -202,7 +203,7 @@ struct sock *dccp_check_req(struct sock *sk, struct sk_buff *skb,
 	DCCP_SKB_CB(skb)->dccpd_reset_code = DCCP_RESET_CODE_TOO_BUSY;
 drop:
 	if (dccp_hdr(skb)->dccph_type != DCCP_PKT_RESET)
-		req->rsk_ops->send_reset(sk, skb);
+		req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 
 	inet_csk_reqsk_queue_drop(sk, req);
 out:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 88c83ac42129..418d11902fa7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -70,6 +70,7 @@
 #include <net/xfrm.h>
 #include <net/secure_seq.h>
 #include <net/busy_poll.h>
+#include <net/rstreason.h>
 
 #include <linux/inet.h>
 #include <linux/ipv6.h>
@@ -723,7 +724,8 @@ static bool tcp_v4_ao_sign_reset(const struct sock *sk, struct sk_buff *skb,
  *	Exception: precedence violation. We do not implement it in any case.
  */
 
-static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
+static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
+			      enum sk_rst_reason reason)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct {
@@ -1934,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb);
+	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2276,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb);
+				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2355,7 +2357,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb);
+		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
@@ -2407,7 +2409,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb);
+		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 146c061145b4..7d543569a180 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/xfrm.h>
 #include <net/busy_poll.h>
+#include <net/rstreason.h>
 
 static bool tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_win)
 {
@@ -878,7 +879,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 * avoid becoming vulnerable to outside attack aiming at
 		 * resetting legit local connections.
 		 */
-		req->rsk_ops->send_reset(sk, skb);
+		req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	} else if (fastopen) { /* received a valid RST pkt */
 		reqsk_fastopen_remove(sk, req, true);
 		tcp_reset(sk, skb);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index bb7c3caf4f85..017f6293b5f4 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -60,6 +60,7 @@
 #include <net/secure_seq.h>
 #include <net/hotdata.h>
 #include <net/busy_poll.h>
+#include <net/rstreason.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -69,7 +70,8 @@
 
 #include <trace/events/tcp.h>
 
-static void	tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb);
+static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
+			      enum sk_rst_reason reason);
 static void	tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 				      struct request_sock *req);
 
@@ -1008,7 +1010,8 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	kfree_skb(buff);
 }
 
-static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
+static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
+			      enum sk_rst_reason reason)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
@@ -1677,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb);
+	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1862,7 +1865,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb);
+				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1939,7 +1942,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb);
+		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
@@ -1995,7 +1998,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb);
+		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b94d1dca1094..32fe2ef36d56 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -20,6 +20,8 @@
 #include <net/transp_v6.h>
 #endif
 #include <net/mptcp.h>
+#include <net/rstreason.h>
+
 #include "protocol.h"
 #include "mib.h"
 
@@ -308,7 +310,7 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb);
+		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	return NULL;
 }
 
@@ -376,7 +378,7 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb);
+		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	return NULL;
 }
 #endif
@@ -911,7 +913,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb);
+	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3


