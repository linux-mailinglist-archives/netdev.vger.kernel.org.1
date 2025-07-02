Return-Path: <netdev+bounces-203542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E6DAF655E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1723AB284
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4472F7D12;
	Wed,  2 Jul 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIOSI6sd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246B2F7CEC
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495776; cv=none; b=Eyw/DxNIl9BPI8KKFfd5ee3RIqOC5BBy9/kPSe8naDQH33bM6SwpjlrBqGgxkcWiOrI5a9aP0+3/0QjDINh+qB0hDbfzTVWWkm3R7tRfbR7SLPPKKslMEUlFbYdD2YVdmoXiEGGgaSz0d6EdI8yqtCOKeuzO1x/VuzlzGh12cmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495776; c=relaxed/simple;
	bh=6J82o7UbJtZzX/tRgSAYZRERt1LCRXIhrcGA+6AZ/7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jXyiV4xXFl8jDTKq0iuhQhlG1Ar7+S3Npo7t7uKoKkaGWBhVrXJ73yCj7HTkbtl1+1xMIUxtteorTauAwoX5M1CD20HQLV7dedWgbRly8M37i9CzMNbfcIBg0543Gjdj39nl587wu28MY8UvVh3L1Bl9bT00KyTUFAOTJXLp7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIOSI6sd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74927be2ec0so7565793b3a.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751495774; x=1752100574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2FJN1SnGO1LFWndHPeQAnfUyDeuU+NPIfm/59D7Ge8=;
        b=fIOSI6sdFpEIq9qGytfwSxbGJGcldhirR8RxXonuJ26pqUfMVyX1hPTcOFM/QYElWU
         B3u5emR2Wmhuj+JfYEprmQJwprjSh26eln3R5WAI4aYmn4QpENudtFfu8zMc1UrtCdKL
         xNO/ROGpTkcKWjp2qwQHytCLJfkNqgrXApHseGIUyRURDsM79i95aUEUHPg/lNKXefzB
         k6vvvliwAcS8A8/K+nzukUf3UFS5hQ0LFguSubDS8rL3AK9y95tTxqXI1/WwTrj5NQ3I
         8ss/B9yxVBeyjmiO43WsBdRXkrLSrfYYoHc3CxRdRz7KJgLZ9LVXpiO27cPwCFkP+Txg
         ty2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495774; x=1752100574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2FJN1SnGO1LFWndHPeQAnfUyDeuU+NPIfm/59D7Ge8=;
        b=tM5nuhPNYuhKPfNN8y6mjo+xMauFtpICEauSdX7hJKw0sDQNwli+TGtQ6FXH5VS2uE
         F16yj2Ymgy1G7c9vNt5vvXQbQmgNA/SNDb5268693Q3V2EIGmos0FAIWhflux3xgKCMy
         6CaD/uQEkevSN+eeuMFt/VXX5nUfndSLPCdrko1JND0ShbH2Wn+BZie/y7vb5kryk8OL
         31tD+iGHoJg/rsaKI+tM5IxuU7HYmoSOuTNc7Fg93QCe/g5Xe79+GCICvXWZZq2thuIT
         z/ziMGJTw5kYUNc2NOCnnr7n9vb2Mq92weOyy5Gr9gbdYhpvx34Lr1+vP06IH9SQyNxG
         ejEw==
X-Forwarded-Encrypted: i=1; AJvYcCWOcSwyoG3dIhI6VZxwM0/pMyQYFG+4vdDZFD/dcglMR75ABvgfH70srj/MKb1Q6NnMWql8SuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHIb5wGVSTSZt77zEKIoGD661oLqnlSueNfz0sPuYEiVESBixj
	Vm+uyk1nfZGsS65uKGh7SB0K2Hhr++Qb2l15A1ZpxZkQuYc8NupY0RgAR1fjeVsWEIjWkoYFErU
	3+OtJlw==
X-Google-Smtp-Source: AGHT+IH9mpDbIdERBpgrxjhNwb75+BS41AtlqdgxLEDO8xnUt3RnHPnV7FXT7kyUiZAo2nn43/Ey/hYHs+k=
X-Received: from pgcv8.prod.google.com ([2002:a05:6a02:5308:b0:b31:cc05:3c03])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1a:b0:220:63bd:2bdb
 with SMTP id adf61e73a8af0-222d7f2c51amr7430407637.40.1751495774511; Wed, 02
 Jul 2025 15:36:14 -0700 (PDT)
Date: Wed,  2 Jul 2025 22:35:16 +0000
In-Reply-To: <20250702223606.1054680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702223606.1054680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702223606.1054680-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/7] af_unix: Use cached value for SOCK_STREAM in unix_inq_len().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Compared to TCP, ioctl(SIOCINQ) for AF_UNIX SOCK_STREAM socket is more
expensive, as unix_inq_len() requires iterating through the receive queue
and accumulating skb->len.

Let's cache the value for SOCK_STREAM to a new field during sendmsg()
and recvmsg().

The field is protected by the receive queue lock.

Note that ioctl(SIOCINQ) for SOCK_DGRAM returns the length of the first
skb in the queue.

SOCK_SEQPACKET still requires iterating through the queue because we do
not touch functions shared with unix_dgram_ops.  But, if really needed,
we can support it by switching __skb_try_recv_datagram() to a custom
version.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/af_unix.h |  1 +
 net/unix/af_unix.c    | 38 ++++++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 1af1841b7601..603f8cd026e5 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -47,6 +47,7 @@ struct unix_sock {
 #define peer_wait		peer_wq.wait
 	wait_queue_entry_t	peer_wake;
 	struct scm_stat		scm_stat;
+	int			inq_len;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	struct sk_buff		*oob_skb;
 #endif
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fa2081713dad..aade29d65570 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2297,6 +2297,7 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 
 	spin_lock(&other->sk_receive_queue.lock);
 	WRITE_ONCE(ousk->oob_skb, skb);
+	WRITE_ONCE(ousk->inq_len, ousk->inq_len + 1);
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	spin_unlock(&other->sk_receive_queue.lock);
 
@@ -2319,6 +2320,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb = NULL;
 	struct sock *other = NULL;
+	struct unix_sock *otheru;
 	struct scm_cookie scm;
 	bool fds_sent = false;
 	int err, sent = 0;
@@ -2342,14 +2344,16 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_namelen) {
 		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
 		goto out_err;
-	} else {
-		other = unix_peer(sk);
-		if (!other) {
-			err = -ENOTCONN;
-			goto out_err;
-		}
 	}
 
+	other = unix_peer(sk);
+	if (!other) {
+		err = -ENOTCONN;
+		goto out_err;
+	}
+
+	otheru = unix_sk(other);
+
 	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 		goto out_pipe;
 
@@ -2418,7 +2422,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		unix_maybe_add_creds(skb, sk, other);
 		scm_stat_add(other, skb);
-		skb_queue_tail(&other->sk_receive_queue, skb);
+
+		spin_lock(&other->sk_receive_queue.lock);
+		WRITE_ONCE(otheru->inq_len, otheru->inq_len + skb->len);
+		__skb_queue_tail(&other->sk_receive_queue, skb);
+		spin_unlock(&other->sk_receive_queue.lock);
+
 		unix_state_unlock(other);
 		other->sk_data_ready(other);
 		sent += size;
@@ -2705,6 +2714,7 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	if (!(state->flags & MSG_PEEK)) {
 		WRITE_ONCE(u->oob_skb, NULL);
+		WRITE_ONCE(u->inq_len, u->inq_len - 1);
 
 		if (oob_skb->prev != (struct sk_buff *)&sk->sk_receive_queue &&
 		    !unix_skb_len(oob_skb->prev)) {
@@ -2809,6 +2819,8 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return -EAGAIN;
 	}
 
+	WRITE_ONCE(u->inq_len, u->inq_len - skb->len);
+
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	if (skb == u->oob_skb) {
 		WRITE_ONCE(u->oob_skb, NULL);
@@ -2989,7 +3001,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			if (unix_skb_len(skb))
 				break;
 
-			skb_unlink(skb, &sk->sk_receive_queue);
+			spin_lock(&sk->sk_receive_queue.lock);
+			WRITE_ONCE(u->inq_len, u->inq_len - skb->len);
+			__skb_unlink(skb, &sk->sk_receive_queue);
+			spin_unlock(&sk->sk_receive_queue.lock);
+
 			consume_skb(skb);
 
 			if (scm.fp)
@@ -3160,9 +3176,11 @@ long unix_inq_len(struct sock *sk)
 	if (READ_ONCE(sk->sk_state) == TCP_LISTEN)
 		return -EINVAL;
 
+	if (sk->sk_type == SOCK_STREAM)
+		return READ_ONCE(unix_sk(sk)->inq_len);
+
 	spin_lock(&sk->sk_receive_queue.lock);
-	if (sk->sk_type == SOCK_STREAM ||
-	    sk->sk_type == SOCK_SEQPACKET) {
+	if (sk->sk_type == SOCK_SEQPACKET) {
 		skb_queue_walk(&sk->sk_receive_queue, skb)
 			amount += unix_skb_len(skb);
 	} else {
-- 
2.50.0.727.gbf7dc18ff4-goog


