Return-Path: <netdev+bounces-266137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLqDDqUcsGkngAIAu9opvQ
	(envelope-from <netdev+bounces-266137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:29:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D28572504A0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F317730DF3B1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907403E3159;
	Tue, 10 Mar 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMbRzxOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33F3E314D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146695; cv=none; b=p22H7qL3+e0NHsUWLvpu6U4KetBgyImGSPfR/YEwNs0zCMdbCZoKrhZCTC906XFyav8kCJd2DeAwgXdS72DS9lVvbgFmIx2Kkg7RhRncgAWgnvSKSCC5HgCPgk4kQ6HPuJV/hXjOTsgki+1AkGH+PiWx0o63qVPiaC7YLkECUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146695; c=relaxed/simple;
	bh=9c98MSe9H4lZ6GcFpZzF0uCv3PS7rF+HB+bsocmPyJE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XBIqDoqMCAeTUYvWPbjyO8xaocIvn4IfcsH1OUPqTzsFAFoHRMUrX6bbbG3vp9qsPX85ZmJJ3rqhK4Z8AC5sssSrowb4nfGtOssjEN4ydeB6JMASBmk5ZIB0+eLdlUeDvBunQJfDa5+57VRn5L9k0hT4VvxMLaEP9v8I0AVj0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wMbRzxOt; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5091ee9f1d8so102160121cf.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773146693; x=1773751493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e7PH93XASv1pqduGKcttxphgv1HFAG75VwW87VYcdH4=;
        b=wMbRzxOtcaq4aAMyoT8Pc8F8knIEoVebs3sKCWD9bdWnG+5Ls7mSy/uZqb4cGAHuKg
         1FyFbvb9d1EEJP86yOv79sCUZw6WpbbxjxvMZj9PdOuTjIKk2kcUGhaQ7T9zjT/1qjA6
         4eyM3siBUONzw7BFNlEk5t7kzxjmGuBufLk01UjU83dhd0Yc0pDhPOMBH0oN4zWjwdwm
         cbqHYu/hrrSutHvRdokOV3Qsk6J2rlaQoV+4DoKtcvjymLr3joC0gljCJ16zZlPpf3fB
         nIaQba0nYRU5zkWYQNeBcWWfk49tiErOLENB7gM4r6y+4XlX61qgnEkLOPFrLioGD/p7
         LZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146693; x=1773751493;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7PH93XASv1pqduGKcttxphgv1HFAG75VwW87VYcdH4=;
        b=W0FO1LYgc6Yg2P+fI2wK2FZop/y4hFhikyOfwVRlWw5VOTtyfi7yPhQtthS2gopnjs
         5KW2k/9ReBbX4AZJRPgkPba9e0HfTCHasJtFw5GBRCByRorFk22Ru6eNHOXZEr6HKWsV
         HZHE+37P5e+XnIA8uoPARJ0OgyMUJ+dDRnQnGZ2/1d0Je2QOz9IJBS8PPjN8lvJi0Qvt
         RCuXpp9YmB298M1szIf0d7VY7kmtbalhbQ2brUTzUJmD0V1vfUG8xyeTciGfbPemutid
         awmbbP09H9OqVbjRrjWiaN1FeLEStb/rh2S+NPFa0jHjRDJkvifVJFf+i3eOoCwC/wRM
         izcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOh9OPspIkoTWjRbJpNoD+xOebztTkrkL2RD9R7MEwJueqze0SqHvulXDCczBIfcEUX7BdKio=@vger.kernel.org
X-Gm-Message-State: AOJu0YziAdTHqOd18f3j59+iZLjP2fnNho2MW6xBSI7dknJmVCsFiYHC
	HH+mvSlggxWqYoMx5/fKHLUHSVOV9qaCBbahSD7dIpnXT0AUq9C/ZRVj9LggnhAlHLw0YB4dQtD
	XytyARHXgFfaJiQ==
X-Received: from qtbie3.prod.google.com ([2002:a05:622a:6983:b0:509:2b1:d41])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a50e:b0:506:1e25:c0d3 with SMTP id d75a77b69052e-50926097d2emr24623661cf.30.1773146692925;
 Tue, 10 Mar 2026 05:44:52 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:44:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310124451.2280968-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: add tcp_release_cb_cond() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D28572504A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266137-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Majority of tcp_release_cb() calls do nothing at all.

Provide tcp_release_cb_cond() helper so that release_sock()
can avoid these calls.

Also hint the compiler thar __release_sock() and wake_up()
are rarely called.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-77 (-77)
Function                                     old     new   delta
release_sock                                 258     181     -77
Total: Before=25235790, After=25235713, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h   |  7 +++++++
 include/net/tcp.h     | 14 ++++++++++++++
 net/core/sock.c       | 14 ++++++++------
 net/ipv4/tcp_output.c |  5 -----
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index c44cf9ae8d16f5cc7808a6ca78c1dad03354dccf..bcebc4f07532f0e099d9b0751db7d3eedff2ee5d 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -548,6 +548,13 @@ enum tsq_flags {
 	TCPF_ACK_DEFERRED		= BIT(TCP_ACK_DEFERRED),
 };
 
+/* Flags of interest for tcp_release_cb() */
+#define TCP_DEFERRED_ALL (TCPF_TSQ_DEFERRED |		\
+			  TCPF_WRITE_TIMER_DEFERRED |	\
+			  TCPF_DELACK_TIMER_DEFERRED |	\
+			  TCPF_MTU_REDUCED_DEFERRED |	\
+			  TCPF_ACK_DEFERRED)
+
 #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk)
 
 /* Variant of tcp_sk() upgrading a const sock to a read/write tcp socket.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9f0aee9e5d76d3ef5be75586bd289583e48c8baf..48dffcca0a71b70d0c0fd49d89a66c4f6ae72a58 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -375,7 +375,21 @@ int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
 int tcp_wmem_schedule(struct sock *sk, int copy);
 void tcp_push(struct sock *sk, int flags, int mss_now, int nonagle,
 	      int size_goal);
+
 void tcp_release_cb(struct sock *sk);
+
+static inline bool tcp_release_cb_cond(struct sock *sk)
+{
+#ifdef CONFIG_INET
+	if (likely(sk->sk_prot->release_cb == tcp_release_cb)) {
+		if (unlikely(smp_load_acquire(&sk->sk_tsq_flags) & TCP_DEFERRED_ALL))
+			tcp_release_cb(sk);
+		return true;
+	}
+#endif
+	return false;
+}
+
 void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index f4e2ff23d60eb5103a972d1eee7cc8372de86c5d..fdaf66e6dc18c691f3d8df26ec6769b193d43668 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3807,16 +3807,18 @@ EXPORT_SYMBOL(lock_sock_nested);
 void release_sock(struct sock *sk)
 {
 	spin_lock_bh(&sk->sk_lock.slock);
-	if (sk->sk_backlog.tail)
-		__release_sock(sk);
 
-	if (sk->sk_prot->release_cb)
-		INDIRECT_CALL_INET_1(sk->sk_prot->release_cb,
-				     tcp_release_cb, sk);
+	if (unlikely(sk->sk_backlog.tail))
+		__release_sock(sk);
 
+	if (sk->sk_prot->release_cb) {
+		if (!tcp_release_cb_cond(sk))
+			sk->sk_prot->release_cb(sk);
+	}
 	sock_release_ownership(sk);
-	if (waitqueue_active(&sk->sk_lock.wq))
+	if (unlikely(waitqueue_active(&sk->sk_lock.wq)))
 		wake_up(&sk->sk_lock.wq);
+
 	spin_unlock_bh(&sk->sk_lock.slock);
 }
 EXPORT_SYMBOL(release_sock);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a53802f28dd1788eda6c10654e91e918a42b1380..34a25ef610060988c0c0350ca4b97a112f04ddcb 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1320,11 +1320,6 @@ static void tcp_tsq_workfn(struct work_struct *work)
 	}
 }
 
-#define TCP_DEFERRED_ALL (TCPF_TSQ_DEFERRED |		\
-			  TCPF_WRITE_TIMER_DEFERRED |	\
-			  TCPF_DELACK_TIMER_DEFERRED |	\
-			  TCPF_MTU_REDUCED_DEFERRED |	\
-			  TCPF_ACK_DEFERRED)
 /**
  * tcp_release_cb - tcp release_sock() callback
  * @sk: socket
-- 
2.53.0.473.g4a7958ca14-goog


