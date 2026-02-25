Return-Path: <netdev+bounces-260935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OKOMg72nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:15:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 186D8197DEE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 851AA300A4D7
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A46311587;
	Wed, 25 Feb 2026 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afBIlRJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6B2AD2B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025354; cv=none; b=KceD+vUFxo763DoCTjZ74uU4FiWrucxhCKwVvdtOrYldyESSnjc3mwmIaldZ30x07U1iJ+SXJEUD0DmyDRvykWPxDxL6Uldb3m+L4OgPY0lS4qR8kz+qeM65CpJwwYI2/FLQaCNIDfjOoINbEmTOgRLQIoxR5hhqF4LH2RTsg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025354; c=relaxed/simple;
	bh=Bioj/LT6Ye4MnU/iZsQONBrTpBt2yqnBBlURi/SKlqc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZCrcHskuXZpkOfR+Bz8GLl08SZOg5KA9tVO+YOlZg6gfkCxf8uXMfEb+tdsicjU2ONyao1TMrg3hh0Q+4WWOzpCfVT3SbeG2bHkBm2zbHPPwQo86c3ijV8GcRBMIUlZRFf9cNEpUTfLaVHtZoRQ3ZhP3kg35cYr2oYUUQmef14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afBIlRJO; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb42f56c4aso5698006085a.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772025352; x=1772630152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pH54Py2h6QGaBxSmZqHKQM1trABNRFEKkrsabbQ7dS0=;
        b=afBIlRJOcQtkTMEA9X9KHvmRtBBhud3MJfAXULpzTYSESUBg+J2a/zWtaYdMpWGSsx
         tpCqHL/V3qcfetcmwead1uSq+GtXlHcbjkxFJYd4ePA7eo/9BhEZvqzzIEww6I7P7BoU
         3MbuIwRuH1BFvRIAvcH0nqjOg4Ndeg4VLRB5DDNpD4Kujl8Y9CnGkkAEQswf18mFT+dl
         ff6bUkHqFals6wB81B2QwdIFctz0irO96ZVeP0oXHFZaoLd1GFE+56DLlu7WcyOP5H6c
         YycPPkhdCRXs29sZYDNFZfJJ9jCPtasbJL5/TVvgb6iweJmhU45oqHBYt3L/Wpj0CT43
         QHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772025352; x=1772630152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pH54Py2h6QGaBxSmZqHKQM1trABNRFEKkrsabbQ7dS0=;
        b=J+cFKwqXTVGMCBc5U6U2czoPmuNJy+/d9TpRMtTJtxNgqeMJKyY1wNwNoA/5XwK5p0
         c2i0LWbGeL/Qi9gS3zJVOkzl77Bo0gprFNnm1JR+5hSGbpQZA81wt3PHKrVH4gOeoqu8
         KL7QkNJ29ZDPt9NvQmI51UpwqVuz22+PCYVCC7dnm9sr0aPONICnxs2XUMdjo+WlcR/M
         CkZ+cdy7jxEhBuqAGV0koLFM6CVI0TK5/B2NXKSOxfhpfPZsaFHHVCCf9SBURf6XNBuu
         1DnyCTcpJtobz0EVDsPSm+vFQBtnXx5SAvOLYbCCeeKHd81FCeVsuhJoM2r3FcGw95gm
         9jNA==
X-Forwarded-Encrypted: i=1; AJvYcCXPuKyb77qCdBrN2d0kfwEyPQZ2KzdRJaY5fMQEVXgBOdONaiWW3I4I+7AARxMRWK+woaJJxIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAZDrtcypEn/dyOku67QabIdu5YxRa+s+KhtpXKaWSMZaFmYj
	TtS53cevo8VtFT90PI9m6JVOQ85XVqGzd5b4bU4beVcfYa9uQBalpKnS6pV4l4Db+WMvw0iksyr
	FDv4Wiwk/9Nn9wg==
X-Received: from qkntc8.prod.google.com ([2002:a05:620a:2cc8:b0:8cb:3dc3:8e87])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:450b:b0:8b2:d26f:14b0 with SMTP id af79cd13be357-8cb8c9d2859mr2076865485a.3.1772025351410;
 Wed, 25 Feb 2026 05:15:51 -0800 (PST)
Date: Wed, 25 Feb 2026 13:15:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225131547.1085509-1-edumazet@google.com>
Subject: [PATCH net] net: annotate data-races around sk->sk_{data_ready,write_space}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260935-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,iogearbox.net,cloudflare.com];
	NEURAL_HAM(-0.00)[-0.896];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,87f770387a9e5dc6b79b];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 186D8197DEE
X-Rspamd-Action: no action

skmsg (and probably other layers) are changing these pointers
while other cpus might read them concurrently.

Add corresponding READ_ONCE()/WRITE_ONCE() annotations
for UDP, TCP and AF_UNIX.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Reported-by: syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/699ee9fc.050a0220.1cd54b.0009.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
 net/core/skmsg.c         | 14 +++++++-------
 net/ipv4/tcp.c           |  4 ++--
 net/ipv4/tcp_bpf.c       |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++++++------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/udp.c           |  2 +-
 net/ipv4/udp_bpf.c       |  2 +-
 net/unix/af_unix.c       |  8 ++++----
 8 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ddde93dd8bc6d4e7941daff8b18229376f0d459d..12fbb0545c7123373de4581838debaf9a6c1f870 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1205,8 +1205,8 @@ void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
 		return;
 
 	psock->saved_data_ready = sk->sk_data_ready;
-	sk->sk_data_ready = sk_psock_strp_data_ready;
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_data_ready, sk_psock_strp_data_ready);
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
@@ -1216,8 +1216,8 @@ void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 	if (!psock->saved_data_ready)
 		return;
 
-	sk->sk_data_ready = psock->saved_data_ready;
-	psock->saved_data_ready = NULL;
+	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
+	WRITE_ONCE(psock->saved_data_ready, NULL);
 	strp_stop(&psock->strp);
 }
 
@@ -1296,8 +1296,8 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 		return;
 
 	psock->saved_data_ready = sk->sk_data_ready;
-	sk->sk_data_ready = sk_psock_verdict_data_ready;
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
@@ -1308,6 +1308,6 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 	if (!psock->saved_data_ready)
 		return;
 
-	sk->sk_data_ready = psock->saved_data_ready;
+	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
 	psock->saved_data_ready = NULL;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6ce03a9adb4a97f554bd6b6cf887f4ad9dbfe5c3..1153780945ab369c45bef6b740c8e87c8bae4ea3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1446,7 +1446,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	err = sk_stream_error(sk, flags, err);
 	/* make sure we wake any epoll edge trigger waiter */
 	if (unlikely(tcp_rtx_and_write_queues_empty(sk) && err == -EAGAIN)) {
-		sk->sk_write_space(sk);
+		READ_ONCE(sk->sk_write_space)(sk);
 		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
 	}
 	if (binding)
@@ -4181,7 +4181,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	case TCP_NOTSENT_LOWAT:
 		WRITE_ONCE(tp->notsent_lowat, val);
-		sk->sk_write_space(sk);
+		READ_ONCE(sk->sk_write_space)(sk);
 		break;
 	case TCP_INQ:
 		if (val > 1 || val < 0)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ca8a5cb8e569d78d7b1df03eb904ac5cc115cf47..d3d6a47af5270178b4dfe2a158c61090a948f4e0 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -725,7 +725,7 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 			WRITE_ONCE(sk->sk_prot->unhash, psock->saved_unhash);
 			tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
 		} else {
-			sk->sk_write_space = psock->saved_write_space;
+			WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
 			/* Pairs with lockless read in sk_clone_lock() */
 			sock_replace_proto(sk, psock->sk_proto);
 		}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7b41abb82aad33d8cab4fcfa989cc4771149b41..2e7bea7fe8cab23e80458c78e3edd81f33ee4b2b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5416,7 +5416,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
-		sk->sk_data_ready(sk);
+		READ_ONCE(sk->sk_data_ready)(sk);
 		tcp_drop_reason(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		return;
 	}
@@ -5626,7 +5626,7 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 void tcp_data_ready(struct sock *sk)
 {
 	if (tcp_epollin_ready(sk, sk->sk_rcvlowat) || sock_flag(sk, SOCK_DONE))
-		sk->sk_data_ready(sk);
+		READ_ONCE(sk->sk_data_ready)(sk);
 }
 
 static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
@@ -5682,7 +5682,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 			inet_csk(sk)->icsk_ack.pending |=
 					(ICSK_ACK_NOMEM | ICSK_ACK_NOW);
 			inet_csk_schedule_ack(sk);
-			sk->sk_data_ready(sk);
+			READ_ONCE(sk->sk_data_ready)(sk);
 
 			if (skb_queue_len(&sk->sk_receive_queue) && skb->len) {
 				reason = SKB_DROP_REASON_PROTO_MEM;
@@ -6105,7 +6105,9 @@ static void tcp_new_space(struct sock *sk)
 		tp->snd_cwnd_stamp = tcp_jiffies32;
 	}
 
-	INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);
+	INDIRECT_CALL_1(READ_ONCE(sk->sk_write_space),
+			sk_stream_write_space,
+			sk);
 }
 
 /* Caller made space either from:
@@ -6316,7 +6318,7 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 				BUG();
 			WRITE_ONCE(tp->urg_data, TCP_URG_VALID | tmp);
 			if (!sock_flag(sk, SOCK_DEAD))
-				sk->sk_data_ready(sk);
+				READ_ONCE(sk->sk_data_ready)(sk);
 		}
 	}
 }
@@ -7783,7 +7785,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 			sock_put(fastopen_sk);
 			goto drop_and_free;
 		}
-		sk->sk_data_ready(sk);
+		READ_ONCE(sk->sk_data_ready)(sk);
 		bh_unlock_sock(fastopen_sk);
 		sock_put(fastopen_sk);
 	} else {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d9c5a43bd2818c17d79d8433ac5dd2bdd199b812..dafb63b923d0d08cb1a0e9a37d8ec025386a960a 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -1004,7 +1004,7 @@ enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 		reason = tcp_rcv_state_process(child, skb);
 		/* Wakeup parent, send SIGIO */
 		if (state == TCP_SYN_RECV && child->sk_state != state)
-			parent->sk_data_ready(parent);
+			READ_ONCE(parent->sk_data_ready)(parent);
 	} else {
 		/* Alas, it is possible again, because we do lookup
 		 * in main socket hash table and lock on listening
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b96e47f1c8a2a92296acc0a9c724019c44c097ea..422c96fea2493247910e9ea11f3cda03833c5c33 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1787,7 +1787,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 		 * using prepare_to_wait_exclusive().
 		 */
 		while (nb) {
-			INDIRECT_CALL_1(sk->sk_data_ready,
+			INDIRECT_CALL_1(READ_ONCE(sk->sk_data_ready),
 					sock_def_readable, sk);
 			nb--;
 		}
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 91233e37cd97a2b0f0c891723b20b1235cc628d1..779a3a03762f1e3ff4da40597c9e4d7a7a4f04d6 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -158,7 +158,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 	int family = sk->sk_family == AF_INET ? UDP_BPF_IPV4 : UDP_BPF_IPV6;
 
 	if (restore) {
-		sk->sk_write_space = psock->saved_write_space;
+		WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
 		sock_replace_proto(sk, psock->sk_proto);
 		return 0;
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f6d56e70c7a2c387fda6d06f30653cd662463f39..6965b9a49d68a28c688992e3cf09dbdbe80b9c59 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1785,7 +1785,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	spin_unlock(&other->sk_receive_queue.lock);
 	unix_state_unlock(other);
-	other->sk_data_ready(other);
+	READ_ONCE(other->sk_data_ready)(other);
 	sock_put(other);
 	return 0;
 
@@ -2278,7 +2278,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	scm_stat_add(other, skb);
 	skb_queue_tail(&other->sk_receive_queue, skb);
 	unix_state_unlock(other);
-	other->sk_data_ready(other);
+	READ_ONCE(other->sk_data_ready)(other);
 	sock_put(other);
 	scm_destroy(&scm);
 	return len;
@@ -2351,7 +2351,7 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 
 	sk_send_sigurg(other);
 	unix_state_unlock(other);
-	other->sk_data_ready(other);
+	READ_ONCE(other->sk_data_ready)(other);
 
 	return 0;
 out_unlock:
@@ -2477,7 +2477,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		spin_unlock(&other->sk_receive_queue.lock);
 
 		unix_state_unlock(other);
-		other->sk_data_ready(other);
+		READ_ONCE(other->sk_data_ready)(other);
 		sent += size;
 	}
 
-- 
2.53.0.414.gf7e9f6c205-goog


