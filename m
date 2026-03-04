Return-Path: <netdev+bounces-263519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA74HgWLp2kUiQAAu9opvQ
	(envelope-from <netdev+bounces-263519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:29:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4A1F95B9
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D216830AC2BD
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075DD329C7B;
	Wed,  4 Mar 2026 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewR1Z+zt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0393176EE
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587672; cv=none; b=VLGpOjE97oGtKYAREFOg0oecB62mal84kYPOWlBmedDcC2QtO6Niz2aGpdGLkmGo5yuZXoBlh2k1KE4NHIccBH2wjIzC+f7VeS+/KjUQf936OrcPPR5WK8d4BoFi9TgUESqfRylww7XjmRh5eliPOKhlNykaJYlISEqQp9yeP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587672; c=relaxed/simple;
	bh=KUZB677fj64ErOTTv2t3Z8EXBwfjrjd9x8cic5yPMGw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oihoo7FtlNPN08PgYMel42vjngEUAGizKYFFpJnYQ/C2t/ytlex18/3UGcjyPMl0MlXqq80IoNiMnBrz6nDR6TsQ3Ig2iw+LtKcQcNPd3zzmEj0qaY2u+1/EYnJDewl/4bTHSBn3n6eveyrY9Oieo/qkQymlRFao5t11Clq25ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ewR1Z+zt; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64ca3de57f1so6938740d50.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 17:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772587669; x=1773192469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=glBDZ7pZyXb+Yv+XoAjBDtDP6IdGnFzP0uekTFhKGMk=;
        b=ewR1Z+ztvTvfTCidqVFt/ZTMHvNbffANSHOWfrWuJG4KHFRZ8f9gxZicroAnIZn49C
         5ATsuZhVd5g2ellgN2M76nPjUgsV4q+jJDGkKUyEeOLhj1mYmPSaOajYModfka8/DROK
         /+Z5Lih9Y6k3w5Xis6oXWLjxXfIll9HlFLHns1NSaMAdxu/iLclpjeWoNpbXIgxhdgmO
         qVCNYWHAbT6EBoYwM5/NVmTJmpm6hWNP8FILNebtI16dyZ6k+yMpoae4bYcttvQ+g6eK
         Rm89ZaAbx5YQqOX5W4kqcDeb348EM1CPt4cyGhPkZ8HaAv9AVaQv2Q0y1cFSmlUcDr8k
         I9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772587669; x=1773192469;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glBDZ7pZyXb+Yv+XoAjBDtDP6IdGnFzP0uekTFhKGMk=;
        b=JBcMK2pJTwqc+YNxYVoGnbgjuau9G72SJsEZGUq6UYLJ2+xX6+1PeZpaN/SZQxBDwQ
         LJvZMAng8KFOb/ZMFINNIgpHvXJKbLkRHIhQA/uAo77Lc+SXAoQ4DV4HdiLwncjIYQG3
         qLYWxS0/OUHeGtR9nN00QoJc5TUoNw3tw/0zr6rbi/qNNdRYlV6YSVwTlj5bZCX92LTy
         q3MA8fQaHeT1CUPJOBKKKxW+nXtokoldmByPz5kl46Kx6+T0mCnSq/bA3Gnf0g2JQqzS
         mX/q2kCnf4rlwBCL13Ro2/hc2rM5qrmbj1PP6bi1r0MKIwNl0fwfbMjcGX144rgd7sNe
         JuFw==
X-Forwarded-Encrypted: i=1; AJvYcCUS7M+lUL8EKB0NjbEgTTnMyPYz9GXj1N070y4AFDDZhVun7gNxFKLMgHeO+LSHbZxgMn49cAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BplyRBR6mmxf+Ogb86Ei5Gl8BrIPJ9Dz4Wil8ejFO+iputr9
	sInL5bRntjdAbJpqTI4fNvdIMKW3oC8XkkZ3MgIvKGxlNckL2ExRk7x5Vv1zfy6UME9O/jmr6vm
	OO4KZU4v4BZrJcQ==
X-Received: from yxw1.prod.google.com ([2002:a53:ac81:0:b0:64c:f18f:1096])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1697:b0:64c:ed24:13da with SMTP id 956f58d0204a3-64cf9bbef4dmr480056d50.57.1772587669149;
 Tue, 03 Mar 2026 17:27:49 -0800 (PST)
Date: Wed,  4 Mar 2026 01:27:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304012747.881644-1-edumazet@google.com>
Subject: [PATCH net-next] net: use ktime_t in struct scm_timestamping_internal
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C2A4A1F95B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263519-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Instead of using struct timespec64 in scm_timestamping_internal,
use ktime_t, saving 24 bytes in kernel stack.

This makes tcp_update_recv_tstamps() small enough to be inlined.

The ktime_t -> timespec64 conversions happen after socket lock
has been released in tcp_recvmsg(), and only if the application
requested them.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 0/2 grow/shrink: 5/4 up/down: 146/-277 (-131)
Function                                     old     new   delta
tcp_zerocopy_receive                        2383    2425     +42
mptcp_recvmsg                               1565    1607     +42
tcp_recvmsg_locked                          3797    3823     +26
put_cmsg_scm_timestamping64                  131     149     +18
put_cmsg_scm_timestamping                    131     149     +18
__pfx_tcp_update_recv_tstamps                 16       -     -16
do_tcp_getsockopt                           4024    4006     -18
tcp_recv_timestamp                           474     430     -44
tcp_zc_handle_leftover                       417     371     -46
__sock_recv_timestamp                       1087    1031     -56
tcp_update_recv_tstamps                       97       -     -97
Total: Before=25223788, After=25223657, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/socket.h |  2 +-
 include/net/tcp.h      | 11 ++++++--
 net/core/scm.c         | 12 ++++++---
 net/ipv4/tcp.c         | 61 +++++++++++++++---------------------------
 net/socket.c           | 23 ++++++++--------
 5 files changed, 51 insertions(+), 58 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index ec715ad4bf25f5f759d2cab3c6b796fed84df932..ec4a0a0257939a5363c55bed3ccb20182965b2e3 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -415,7 +415,7 @@ struct __kernel_timespec;
 struct old_timespec32;
 
 struct scm_timestamping_internal {
-	struct timespec64 ts[3];
+	ktime_t ts[3];
 };
 
 extern void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9cf8785ef0b42460a2389b4aa75570b3aa31cbb4..fea6081cf6c798fe5f3f3b3ab3335619d7324f6e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -503,8 +503,15 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int flags);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
-void tcp_update_recv_tstamps(struct sk_buff *skb,
-			     struct scm_timestamping_internal *tss);
+
+static inline void
+tcp_update_recv_tstamps(struct sk_buff *skb,
+			struct scm_timestamping_internal *tss)
+{
+	tss->ts[0] = skb->tstamp;
+	tss->ts[2] = skb_hwtstamps(skb)->hwtstamp;
+}
+
 void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss);
 void tcp_data_ready(struct sock *sk);
diff --git a/net/core/scm.c b/net/core/scm.c
index a29aa8fb8065665f8a8f2255ec3e55df973a6b0a..eec13f50ecaf6fa7caf9316bf17ab401d98d0efc 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -318,8 +318,10 @@ void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_int
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(tss.ts); i++) {
-		tss.ts[i].tv_sec = tss_internal->ts[i].tv_sec;
-		tss.ts[i].tv_nsec = tss_internal->ts[i].tv_nsec;
+		struct timespec64 tv = ktime_to_timespec64(tss_internal->ts[i]);
+
+		tss.ts[i].tv_sec = tv.tv_sec;
+		tss.ts[i].tv_nsec = tv.tv_nsec;
 	}
 
 	put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_NEW, sizeof(tss), &tss);
@@ -332,8 +334,10 @@ void put_cmsg_scm_timestamping(struct msghdr *msg, struct scm_timestamping_inter
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(tss.ts); i++) {
-		tss.ts[i].tv_sec = tss_internal->ts[i].tv_sec;
-		tss.ts[i].tv_nsec = tss_internal->ts[i].tv_nsec;
+		struct timespec64 tv = ktime_to_timespec64(tss_internal->ts[i]);
+
+		tss.ts[i].tv_sec = tv.tv_sec;
+		tss.ts[i].tv_nsec = tv.tv_nsec;
 	}
 
 	put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_OLD, sizeof(tss), &tss);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1790d2fa75ade77cda8d0a593e689ea4432734dd..3d77d90c14fe13777d17563e17596066c44c66bd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1871,20 +1871,6 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 }
 EXPORT_IPV6_MOD(tcp_set_rcvlowat);
 
-void tcp_update_recv_tstamps(struct sk_buff *skb,
-			     struct scm_timestamping_internal *tss)
-{
-	if (skb->tstamp)
-		tss->ts[0] = ktime_to_timespec64(skb->tstamp);
-	else
-		tss->ts[0] = (struct timespec64) {0};
-
-	if (skb_hwtstamps(skb)->hwtstamp)
-		tss->ts[2] = ktime_to_timespec64(skb_hwtstamps(skb)->hwtstamp);
-	else
-		tss->ts[2] = (struct timespec64) {0};
-}
-
 #ifdef CONFIG_MMU
 static const struct vm_operations_struct tcp_vm_ops = {
 };
@@ -2376,22 +2362,23 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	u32 tsflags = READ_ONCE(sk->sk_tsflags);
-	bool has_timestamping = false;
 
-	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
+	if (tss->ts[0]) {
 		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
+			struct timespec64 tv = ktime_to_timespec64(tss->ts[0]);
+
 			if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
 				if (new_tstamp) {
 					struct __kernel_timespec kts = {
-						.tv_sec = tss->ts[0].tv_sec,
-						.tv_nsec = tss->ts[0].tv_nsec,
+						.tv_sec = tv.tv_sec,
+						.tv_nsec = tv.tv_nsec,
 					};
 					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
 						 sizeof(kts), &kts);
 				} else {
 					struct __kernel_old_timespec ts_old = {
-						.tv_sec = tss->ts[0].tv_sec,
-						.tv_nsec = tss->ts[0].tv_nsec,
+						.tv_sec = tv.tv_sec,
+						.tv_nsec = tv.tv_nsec,
 					};
 					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
 						 sizeof(ts_old), &ts_old);
@@ -2399,41 +2386,37 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			} else {
 				if (new_tstamp) {
 					struct __kernel_sock_timeval stv = {
-						.tv_sec = tss->ts[0].tv_sec,
-						.tv_usec = tss->ts[0].tv_nsec / 1000,
+						.tv_sec = tv.tv_sec,
+						.tv_usec = tv.tv_nsec / 1000,
 					};
 					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
 						 sizeof(stv), &stv);
 				} else {
-					struct __kernel_old_timeval tv = {
-						.tv_sec = tss->ts[0].tv_sec,
-						.tv_usec = tss->ts[0].tv_nsec / 1000,
+					struct __kernel_old_timeval otv = {
+						.tv_sec = tv.tv_sec,
+						.tv_usec = tv.tv_nsec / 1000,
 					};
 					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
-						 sizeof(tv), &tv);
+						 sizeof(otv), &otv);
 				}
 			}
 		}
 
-		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+		if (!(tsflags & SOF_TIMESTAMPING_SOFTWARE &&
 		    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
-		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
-			has_timestamping = true;
-		else
-			tss->ts[0] = (struct timespec64) {0};
+		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))))
+			tss->ts[0] = 0;
 	}
 
-	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
+	if (tss->ts[2]) {
+		if (!(tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
 		    (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
-		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
-			has_timestamping = true;
-		else
-			tss->ts[2] = (struct timespec64) {0};
+		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))))
+			tss->ts[2] = 0;
 	}
 
-	if (has_timestamping) {
-		tss->ts[1] = (struct timespec64) {0};
+	if (tss->ts[0] | tss->ts[2]) {
+		tss->ts[1] = 0;
 		if (sock_flag(sk, SOCK_TSTAMP_NEW))
 			put_cmsg_scm_timestamping64(msg, tss);
 		else
diff --git a/net/socket.c b/net/socket.c
index 05952188127f5bce41494e99e86418249e9022f2..68829d09bcf1468dee49864c5e4ea52362c3c6c7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -912,11 +912,10 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 {
 	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
-	struct scm_timestamping_internal tss;
-	int empty = 1, false_tstamp = 0;
 	struct skb_shared_hwtstamps *shhwtstamps =
 		skb_hwtstamps(skb);
-	int if_index;
+	struct scm_timestamping_internal tss;
+	int if_index, false_tstamp = 0;
 	ktime_t hwtstamp;
 	u32 tsflags;
 
@@ -961,12 +960,12 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	memset(&tss, 0, sizeof(tss));
 	tsflags = READ_ONCE(sk->sk_tsflags);
-	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
-	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
-	      skb_is_err_queue(skb) ||
-	      !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
-	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
-		empty = 0;
+	if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+	    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+	    skb_is_err_queue(skb) ||
+	    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
+		tss.ts[0] = skb->tstamp;
+
 	if (shhwtstamps &&
 	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
 	     (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
@@ -983,15 +982,15 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 			hwtstamp = ptp_convert_timestamp(&hwtstamp,
 							 READ_ONCE(sk->sk_bind_phc));
 
-		if (ktime_to_timespec64_cond(hwtstamp, tss.ts + 2)) {
-			empty = 0;
+		if (hwtstamp) {
+			tss.ts[2] = hwtstamp;
 
 			if ((tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
 			    !skb_is_err_queue(skb))
 				put_ts_pktinfo(msg, skb, if_index);
 		}
 	}
-	if (!empty) {
+	if (tss.ts[0] | tss.ts[2]) {
 		if (sock_flag(sk, SOCK_TSTAMP_NEW))
 			put_cmsg_scm_timestamping64(msg, &tss);
 		else
-- 
2.53.0.473.g4a7958ca14-goog


