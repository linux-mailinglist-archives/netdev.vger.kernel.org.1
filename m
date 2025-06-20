Return-Path: <netdev+bounces-199825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4EFAE1F88
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA64A171D54
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048E2DFA35;
	Fri, 20 Jun 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2IphvFaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F95291891
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434955; cv=none; b=ENvx8YjE8WbI51+po/t/24WQSAubDBiFUdgrrif3DQtxUWYAb4vczzZkeAM7mkX8xm/xz4AbulXs5TYyQNsSq8593UMfahQYf6mLTVOB1nr8DDDCL+eHABZQIpdUh22KHqt676YuaplR5f28H12qN+xg2M+M4nitsqp0/qXJC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434955; c=relaxed/simple;
	bh=qQ/c/1J1G4ieUsRCR0iS0XMv6J+erdBDV4muk6+upXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M9a33ShsY10xqeImdi/VK3M0wo0URedcrmeJdv1clC+lgw60Cml480DuIvSIMfu7iFh7vAlikIMhkBxPRh9m0k3E3S0FVSTX0l547tLojcrYsBhpeHeMvkYBoEJ7k72JLa+LYOh6dtgOWTP3VtlzDMlGHtCA5c77uW0pkiWohvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2IphvFaq; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a6f64eebecso34232851cf.2
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434952; x=1751039752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qS7jkDXwEwEA32PknJUDC7UwFSe5JfcGS8szn8QDUE=;
        b=2IphvFaqI2H5Jh24S2K+zJ4ha+CRdtKiMRwLEyoGFIvXzx6zxVP250+/4h1PysfyLb
         Apj5lmFjqLY4hc94KnfP4hUdeQmb4M4RAPYTJdupVhbg5FGV96gYmjHgbS+VRiukSuo0
         q7Tnc26rUmoHLnQNivTdzArunnL2RVaZNb4hcw03G3K7kdXcteomRtu1N/Iym2HP/Tlk
         On3s75lhZv1Yf9xKOZ/TjnZKz63Yr0ijv+Pp13G49r015IbqK+5gq8KuVyEG0xZbqDw9
         TFeEdpyDX9o5DTRyAep7BeubMC1Ex64aD8rkOfAPpimUKyXItM3m5ZO28bDWRlDVuNJS
         pOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434952; x=1751039752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qS7jkDXwEwEA32PknJUDC7UwFSe5JfcGS8szn8QDUE=;
        b=lkOQmtyhvAwpIZ7vtvKuwAxKjYs/T3tyYlwp0u/2abx7Kw/kbK7h/0YzllzMYTlICX
         AhpuIQBeDDVFMcRSzVBEcINcuLMY2xYVr0XhnYK4Kw+NTbwjhU+PswtpDGJjNXCIsW9T
         sLbtmP3i0sQbafkWq5e09nfwHaU5YstNFHTMWCYZ+0nPt1xuiapXi/OoDbexJv6q15Cy
         NDt5C99gAIuX01wn9pGecptz/4o/zbra7kPk8s9CvYpBVFrFhIsBnt76Fjv0t7PwRGV8
         mHCUx0HP4TegIXLZS1gNST82086Jj4F2oTcZC1k8U1jrEwsHiuupGaYzhL2edFXKZ5iT
         4ZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPV/2XaGBEyFPGN3RT4KDIK2JTmPFHTblGthcV8ZYpt4ytmWHIiNCL9i1ASaWINhQG6EDSp7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7Onc7rp8YtZx9Cz6E10G3VdbcOpMtjR0Ye4l9vxrSu3MmNAW
	EZr1xVqanTF6ngFUHuyqsKfoCKWsYy07deMS7hkIWVzu5Asxit0PH4SyKUSajLhZoJt2Fchr3ZI
	pMWmBq93c7xWFNA==
X-Google-Smtp-Source: AGHT+IETX1KDipVravoxaiWXqgZavf8hXlVHBJq/3/aLAjft8+3oR1HWs2ay8PueCRNoh53VfmCe9QCW9otLbA==
X-Received: from qtbcb20.prod.google.com ([2002:a05:622a:1f94:b0:4a4:310b:7f12])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:255:b0:4a3:fcc7:c72e with SMTP id d75a77b69052e-4a77a1a498emr38876291cf.9.1750434952372;
 Fri, 20 Jun 2025 08:55:52 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:55:35 +0000
In-Reply-To: <20250620155536.335520-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620155536.335520-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620155536.335520-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net: make sk->sk_sndtimeo lockless
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Followup of commit 285975dd6742 ("net: annotate data-races around
sk->sk_{rcv|snd}timeo").

Remove lock_sock()/release_sock() from sock_set_sndtimeo(),
and add READ_ONCE()/WRITE_ONCE() where it is needed.

Also SO_SNDTIMEO_OLD and SO_SNDTIMEO_NEW can call sock_set_timeout()
without holding the socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h         |  2 +-
 net/bluetooth/iso.c        |  4 ++--
 net/bluetooth/l2cap_sock.c |  4 ++--
 net/bluetooth/sco.c        |  4 ++--
 net/core/sock.c            | 12 ++++--------
 net/sctp/socket.c          |  2 +-
 net/smc/af_smc.c           |  4 ++--
 7 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index ca532227cbfda1eb51f67532cbbbdc79a41c98d6..337d78bc780ec53947f7bd1f583e3d1e5a3c599f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2595,7 +2595,7 @@ static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
 
 static inline long sock_sndtimeo(const struct sock *sk, bool noblock)
 {
-	return noblock ? 0 : sk->sk_sndtimeo;
+	return noblock ? 0 : READ_ONCE(sk->sk_sndtimeo);
 }
 
 static inline int sock_rcvlowat(const struct sock *sk, int waitall, int len)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3c2c98eecc62675be10161ba40046be871bb3bb7..34e89bb5f3841b67c753a07ec12fe1c5bdd6f646 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -413,7 +413,7 @@ static int iso_connect_bis(struct sock *sk)
 		sk->sk_state = BT_CONNECT;
 	} else {
 		sk->sk_state = BT_CONNECT;
-		iso_sock_set_timer(sk, sk->sk_sndtimeo);
+		iso_sock_set_timer(sk, READ_ONCE(sk->sk_sndtimeo));
 	}
 
 	release_sock(sk);
@@ -503,7 +503,7 @@ static int iso_connect_cis(struct sock *sk)
 		sk->sk_state = BT_CONNECT;
 	} else {
 		sk->sk_state = BT_CONNECT;
-		iso_sock_set_timer(sk, sk->sk_sndtimeo);
+		iso_sock_set_timer(sk, READ_ONCE(sk->sk_sndtimeo));
 	}
 
 	release_sock(sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5aa55fa695943a79bcdd38e5661af9b637fe18ba..113656489db5d8a094d25599506d531b79285036 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -255,7 +255,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type,
-				 sk->sk_sndtimeo);
+				 READ_ONCE(sk->sk_sndtimeo));
 	if (err)
 		return err;
 
@@ -1725,7 +1725,7 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
-	return sk->sk_sndtimeo;
+	return READ_ONCE(sk->sk_sndtimeo);
 }
 
 static struct pid *l2cap_sock_get_peer_pid_cb(struct l2cap_chan *chan)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 2945d27e75dce6839e404906f13eb1765c80249a..d382d980fd9a73bac80f8fd9b2702c2e85d29688 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -338,7 +338,7 @@ static int sco_connect(struct sock *sk)
 
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
 			       sco_pi(sk)->setting, &sco_pi(sk)->codec,
-			       sk->sk_sndtimeo);
+			       READ_ONCE(sk->sk_sndtimeo));
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto unlock;
@@ -367,7 +367,7 @@ static int sco_connect(struct sock *sk)
 		sk->sk_state = BT_CONNECTED;
 	} else {
 		sk->sk_state = BT_CONNECT;
-		sco_sock_set_timer(sk, sk->sk_sndtimeo);
+		sco_sock_set_timer(sk, READ_ONCE(sk->sk_sndtimeo));
 	}
 
 	release_sock(sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 502042a0d3b5f80529ca8be50e9d9d6585091054..3e69f3b970af080e22999f2ce36d85434486fe15 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -818,12 +818,10 @@ EXPORT_SYMBOL(sock_set_priority);
 
 void sock_set_sndtimeo(struct sock *sk, s64 secs)
 {
-	lock_sock(sk);
 	if (secs && secs < MAX_SCHEDULE_TIMEOUT / HZ - 1)
 		WRITE_ONCE(sk->sk_sndtimeo, secs * HZ);
 	else
 		WRITE_ONCE(sk->sk_sndtimeo, MAX_SCHEDULE_TIMEOUT);
-	release_sock(sk);
 }
 EXPORT_SYMBOL(sock_set_sndtimeo);
 
@@ -1287,6 +1285,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_DEVMEM_DONTNEED:
 		return sock_devmem_dontneed(sk, optval, optlen);
 #endif
+	case SO_SNDTIMEO_OLD:
+	case SO_SNDTIMEO_NEW:
+		return sock_set_timeout(&sk->sk_sndtimeo, optval,
+					optlen, optname == SO_SNDTIMEO_OLD);
 	}
 
 	sockopt_lock_sock(sk);
@@ -1448,12 +1450,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 				       optlen, optname == SO_RCVTIMEO_OLD);
 		break;
 
-	case SO_SNDTIMEO_OLD:
-	case SO_SNDTIMEO_NEW:
-		ret = sock_set_timeout(&sk->sk_sndtimeo, optval,
-				       optlen, optname == SO_SNDTIMEO_OLD);
-		break;
-
 	case SO_ATTACH_FILTER: {
 		struct sock_fprog fprog;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 1e5739858c2067381ccc713756ff56e585d152ad..96852ccb6decf714d7a243f83141b7371f7a034d 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9493,7 +9493,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newsk->sk_rcvbuf = sk->sk_rcvbuf;
 	newsk->sk_lingertime = sk->sk_lingertime;
 	newsk->sk_rcvtimeo = sk->sk_rcvtimeo;
-	newsk->sk_sndtimeo = sk->sk_sndtimeo;
+	newsk->sk_sndtimeo = READ_ONCE(sk->sk_sndtimeo);
 	newsk->sk_rxhash = sk->sk_rxhash;
 
 	newinet = inet_sk(newsk);
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3760131f1484503323b2843fe5304a2283c10c4d..6375a86fe2b5f4e9c5aa9f2a71650e5708692be7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -486,7 +486,7 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 {
 	/* options we don't get control via setsockopt for */
 	nsk->sk_type = osk->sk_type;
-	nsk->sk_sndtimeo = osk->sk_sndtimeo;
+	nsk->sk_sndtimeo = READ_ONCE(osk->sk_sndtimeo);
 	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
 	nsk->sk_mark = READ_ONCE(osk->sk_mark);
 	nsk->sk_priority = READ_ONCE(osk->sk_priority);
@@ -1585,7 +1585,7 @@ static void smc_connect_work(struct work_struct *work)
 {
 	struct smc_sock *smc = container_of(work, struct smc_sock,
 					    connect_work);
-	long timeo = smc->sk.sk_sndtimeo;
+	long timeo = READ_ONCE(smc->sk.sk_sndtimeo);
 	int rc = 0;
 
 	if (!timeo)
-- 
2.50.0.rc2.701.gf1e915cc24-goog


