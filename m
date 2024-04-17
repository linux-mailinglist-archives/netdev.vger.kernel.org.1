Return-Path: <netdev+bounces-88616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D628A7EAF
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216A92858C0
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BD12E1E5;
	Wed, 17 Apr 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiKC/Y61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA412DD87;
	Wed, 17 Apr 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343925; cv=none; b=OmjLeQKpJ0W8xwz+oTDbRrtH47QIawpfSn3EkFyO//NfdNsNdQCNVoOzmSkniZpl2nPI1Ksp5zUVanuwuY9+uYAcklkltu6uDqiaPfZQFEd6lbMxlE7tNE2iY4pxHM1+VEEAa6xPlEH6WlTCSss5DFCiNIyNYW9OmMJ1k7xvXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343925; c=relaxed/simple;
	bh=UQ8OKu/6XO1gzteA1wAsmRbCyz+zioVQYep7p/MIbLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqcSULb972EVIQCKFIcDzJRzuyK19jA75BEW0sgrhHPBBSlqvndOW0uazlZpwxbUgZm1z56/b14QI55mdcDEsqFg63l6D1vvct7AMmuIZUni9//8T/TXouqcMyLw3QJexXSHoWS3TvSzXmd7sH1mmYoRY9SO/ntjNVXyM8rT0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiKC/Y61; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e5b6e8f662so40006165ad.0;
        Wed, 17 Apr 2024 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343923; x=1713948723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLE5sB7nZh8FDwAJ64hDtj2qNR1n4lihjWtB4CW/Oiw=;
        b=UiKC/Y61fUssbcZD/dOKEuiU8w+XHaReHfTr3uzOyXVjioSaoZNc+qLggheDENzdlD
         /bLfcZp4kXzkisvNJvLjh343kM0TZZcC5Pskji4xytSjna1SIsBgCa1bo2NJoPtRKew2
         jk9TLkZ+9OnhvzBha1K/CehQslq0vM7PcdlPAZ1xl2xE9slQYTGOpZlADSJYiBGYQ3JF
         eHYejvuaSw5uM9B8FMAm1dqpZX8hkviozvVTNqhkhlv4DQbbFWJlJiBAcU0P+a9MAxmf
         S0sQFEGQ82XifyfzeifQdHBeEVeIwM215TjXQWY9YtOSdjBJnKA6s/D9/bc1mX/2ouGk
         a1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343923; x=1713948723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLE5sB7nZh8FDwAJ64hDtj2qNR1n4lihjWtB4CW/Oiw=;
        b=mv6Ov2zzdj8uDGij69CXdKp4kEiWtJuQAwJAsK88np7CurljX2TDCfq8D/qoGFlzzz
         DvbKyc192fHUcB4Yro7Akah7mzUlJ6DgiilqJdHa8OVHkUz+5qdoKUpTdEUe+mrhY2O4
         VX/WQR6F446TFUJ1zTPHfmuLzDLPk1qGh0+qo2dIe4rcse04Gk8Rga8ak0K5ObGzBf1Q
         PFlYy+hDSih/9f243iRU6aOQC0GV2htugU5fv3ohz6OEkZ/U42Oqi3OdEyZt8rEBvW7z
         eI6zqAEKrwiNM/zmpTQ7rcgAchKhMBkdMfDdApAMcByIQgw4Uz9ML5SJvxy+Zanyizve
         HN6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDbEA8ODXZSSx0FK8djWx8KKJHKb+kyVypoa2MC4RPx6Rs2UNcOdpO8oApoy/rPDuUwVHS6U4I6FJmKffAsRcG/cIpDhgbN20YQegeYj3Q9go2KcS62tNWEshLJ6DilD3dMysYLLjeYkbh
X-Gm-Message-State: AOJu0YwzOnORoPwQDSo7UDKxkGopRgAxGfZLj7nf2EcZ8hpbvpN8v2uY
	wgd6D9ldyH7unoDuK4kI6VYxLG2wFmeU8Ojufq+FQsMn6gFbHWwm
X-Google-Smtp-Source: AGHT+IFa5lfJYFFVILWTX8ejV1r/P3kymr9FZxo4jp8BgQQ/eJGecMnxWJD5BsfFsZQTu0oQme3FCQ==
X-Received: by 2002:a17:903:124b:b0:1e5:d0e3:b960 with SMTP id u11-20020a170903124b00b001e5d0e3b960mr15971748plh.11.1713343923518;
        Wed, 17 Apr 2024 01:52:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:52:03 -0700 (PDT)
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
Subject: [PATCH net-next v6 3/7] rstreason: prepare for active reset
Date: Wed, 17 Apr 2024 16:51:39 +0800
Message-Id: <20240417085143.69578-4-kerneljasonxing@gmail.com>
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

Like what we did to passive reset:
only passing possible reset reason in each active reset path.

No functional changes.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h     |  3 ++-
 net/ipv4/tcp.c        | 15 ++++++++++-----
 net/ipv4/tcp_output.c |  3 ++-
 net/ipv4/tcp_timer.c  |  9 ++++++---
 net/mptcp/protocol.c  |  4 +++-
 net/mptcp/subflow.c   |  5 +++--
 6 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b935e1ae4caf..adeacc9aa28a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -670,7 +670,8 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 void tcp_send_probe0(struct sock *);
 int tcp_write_wakeup(struct sock *, int mib);
 void tcp_send_fin(struct sock *sk);
-void tcp_send_active_reset(struct sock *sk, gfp_t priority);
+void tcp_send_active_reset(struct sock *sk, gfp_t priority,
+			   enum sk_rst_reason reason);
 int tcp_send_synack(struct sock *);
 void tcp_push_one(struct sock *, unsigned int mss_now);
 void __tcp_send_ack(struct sock *sk, u32 rcv_nxt);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f23b97777ea5..4ec0f4feee00 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -275,6 +275,7 @@
 #include <net/xfrm.h>
 #include <net/ip.h>
 #include <net/sock.h>
+#include <net/rstreason.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -2811,7 +2812,8 @@ void __tcp_close(struct sock *sk, long timeout)
 		/* Unread data was tossed, zap the connection. */
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(sk, TCP_CLOSE);
-		tcp_send_active_reset(sk, sk->sk_allocation);
+		tcp_send_active_reset(sk, sk->sk_allocation,
+				      SK_RST_REASON_NOT_SPECIFIED);
 	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		sk->sk_prot->disconnect(sk, 0);
@@ -2885,7 +2887,8 @@ void __tcp_close(struct sock *sk, long timeout)
 		struct tcp_sock *tp = tcp_sk(sk);
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONLINGER);
 		} else {
@@ -2903,7 +2906,8 @@ void __tcp_close(struct sock *sk, long timeout)
 	if (sk->sk_state != TCP_CLOSE) {
 		if (tcp_check_oom(sk, 0)) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONMEMORY);
 		} else if (!check_net(sock_net(sk))) {
@@ -3007,7 +3011,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any());
+		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NOT_SPECIFIED);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
@@ -4564,7 +4568,8 @@ int tcp_abort(struct sock *sk, int err)
 		smp_wmb();
 		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 		tcp_done(sk);
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 61119d42b0fd..276d9d541b01 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3586,7 +3586,8 @@ void tcp_send_fin(struct sock *sk)
  * was unread data in the receive queue.  This behavior is recommended
  * by RFC 2525, section 2.17.  -DaveM
  */
-void tcp_send_active_reset(struct sock *sk, gfp_t priority)
+void tcp_send_active_reset(struct sock *sk, gfp_t priority,
+			   enum sk_rst_reason reason)
 {
 	struct sk_buff *skb;
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 976db57b95d4..83fe7f62f7f1 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <net/tcp.h>
+#include <net/rstreason.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 {
@@ -127,7 +128,8 @@ static int tcp_out_of_resources(struct sock *sk, bool do_reset)
 		    (!tp->snd_wnd && !tp->packets_out))
 			do_reset = true;
 		if (do_reset)
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 		tcp_done(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
 		return 1;
@@ -768,7 +770,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 				goto out;
 			}
 		}
-		tcp_send_active_reset(sk, GFP_ATOMIC);
+		tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);
 		goto death;
 	}
 
@@ -795,7 +797,8 @@ static void tcp_keepalive_timer (struct timer_list *t)
 		    icsk->icsk_probes_out > 0) ||
 		    (user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			tcp_write_err(sk);
 			goto out;
 		}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8bc34f0d973..065967086492 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -21,6 +21,7 @@
 #endif
 #include <net/mptcp.h>
 #include <net/xfrm.h>
+#include <net/rstreason.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
@@ -2569,7 +2570,8 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 		slow = lock_sock_fast(tcp_sk);
 		if (tcp_sk->sk_state != TCP_CLOSE) {
-			tcp_send_active_reset(tcp_sk, GFP_ATOMIC);
+			tcp_send_active_reset(tcp_sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			tcp_set_state(tcp_sk, TCP_CLOSE);
 		}
 		unlock_sock_fast(tcp_sk, slow);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 32fe2ef36d56..ac867d277860 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -414,7 +414,7 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
-	tcp_send_active_reset(ssk, GFP_ATOMIC);
+	tcp_send_active_reset(ssk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
 		mptcp_schedule_work(sk);
@@ -1350,7 +1350,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			tcp_set_state(ssk, TCP_CLOSE);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
-			tcp_send_active_reset(ssk, GFP_ATOMIC);
+			tcp_send_active_reset(ssk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
-- 
2.37.3


