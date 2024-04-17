Return-Path: <netdev+bounces-88615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6818A7EAE
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B59B1F22C1A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159A312C486;
	Wed, 17 Apr 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blBMaL5k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D22128392;
	Wed, 17 Apr 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343923; cv=none; b=lWHJN1lv4r1hL68OwNaKJRH4cXqRK58wVzptS5Gpb7Gb6S76+M5R13yhHLEa/4KKVPrSMCx9jb2KuS4H8oaaVba1kF6Xj9R7l+dwyGFwxDQmwXknla8gfViFWiil66NGHFtVFYBFzbButJT95QNE0ThmfflAa2cr238LUM782So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343923; c=relaxed/simple;
	bh=R72y8G3W+r5Gv772gRuKqyNYdMiisYHVyoC5CLyv1S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhABmBOrxSGUtQ6dX4jJxPKJyePvYiQxvKHmTfnYJ/E3J+N1RK+NJyLDNlLZeCUfVYC85r/Ye3BHUuRc246gMhrQJBpKmhd7UKbND1qoCnK6tE0tF/2+zy0tGPx//ZhQoChB/aWbusiFJXV91RtuunSfpfVlwt/PFiavfWMVy+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blBMaL5k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e84c46669cso40975ad.0;
        Wed, 17 Apr 2024 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343919; x=1713948719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6oTHYgz5TngiL2FyP+veB9hzruY6XcRakjEoX1j6fI=;
        b=blBMaL5kbVnfraWM9Geh3G0EuWneRTA/p7s65S2soNde9NTlcuk2Vw4l/TtxxEbUVB
         2D9SyvAZqrdlU4B+eN+vyo6uYWlQbAXhteQokhcPHS9774FM8fgl89k3e/rIDuOnki+N
         83/CXF9J8M7ZQ0DUwOYNi6IPV7V6agOLVMoJpIhRV9Dq4GNSXNTD9btw0HuvOowoa9bx
         XqJhRC4qCh6geqQUfLYwcAadeckuSSrEqlAfzU3XmVSHCPK8FRYx9hjEPCbDaVyFSfFw
         lZ8b4ag3+PcwfyARogFhx6LPMP1XoyaUFstaJppJ8E/MONL80bNIxa+S+AFIQiR45IqF
         q9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343919; x=1713948719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6oTHYgz5TngiL2FyP+veB9hzruY6XcRakjEoX1j6fI=;
        b=elb6RtK4Rlxlhq4ZXgs8zWF1TSvf5cr/0rYeBXCSPXzi1CUJ3KE2Yh3IHAeSzED3sB
         k8kdlCB1NSvryhTey8PNgukN+rOpCyPLCkax1fxOVHInm7jCHmiJOzDvEiH9fcz/D869
         aNnYNKsagIZdeSmVzqchPXLyc9V7qJo+7WwoSookmy+7IhYgWtt54qm9blh+2KA+jjDb
         4M4bhZFQZHwzcbuQJBlyT+xApyxsZimeySOS0xPkUHRSL2nygl9OhrudGfvrP3QTuAJr
         atyM9peL6+zd17UR5yzenBDp8gL3iw5yTuWdFBoB1kQyaRAvVZyOgeLteL4/BYugQtmw
         ukyw==
X-Forwarded-Encrypted: i=1; AJvYcCWWglOWuyAMx9QW3PUXszRD8TnWpmJ4625U733yD/RFIfpmWG4IVsJytPeaEJUrXY6yhtKUT8iWHD1/Cuff4W+m2Y4vShZ2uaGXFzz/CrPGVEDdc+iUa7748jxDfsDh+p57Y4TW+tEVFKCv
X-Gm-Message-State: AOJu0YyUgSnbX5WwUR2pQlIA0ox99uhe8CtKxcZAg64GkrK+ERUkvtmz
	MHSoqvI4DiA/qzyomqSJx7K2XM4tpcahpiYY4egNJMXP+igwjUOA
X-Google-Smtp-Source: AGHT+IExa6oZqg6NUTTlCgqbNP1qE+qIjU1y2HKIEeeAZUNvrcw0t89PU1MWcAfPg6/VbdgbvCNm8Q==
X-Received: by 2002:a17:903:41c6:b0:1e5:86ca:2712 with SMTP id u6-20020a17090341c600b001e586ca2712mr22452241ple.2.1713343919278;
        Wed, 17 Apr 2024 01:51:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:51:58 -0700 (PDT)
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
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 2/7] rstreason: prepare for passive reset
Date: Wed, 17 Apr 2024 16:51:38 +0800
Message-Id: <20240417085143.69578-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
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
index f53c7ada2ace..0bc19aca2759 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/xfrm.h>
 #include <net/busy_poll.h>
+#include <net/rstreason.h>
 
 static bool tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_win)
 {
@@ -879,7 +880,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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


