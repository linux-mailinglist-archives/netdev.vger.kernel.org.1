Return-Path: <netdev+bounces-231409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF0EBF8F9F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F324E19C4332
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69ED2BE7AB;
	Tue, 21 Oct 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlJ887hG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEB2BE635
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083074; cv=none; b=gQQLM0JVuwhqc6hhD1V1gjrIPsJBuepmojQeJT+f4p9TRJiNnhfMSzh9tnBAi9HoMzZuR0PpUagdl0CWHDs/MRgGTft74Qo/8+8GcyzX6wG3lvWHIbfapag/s9XlL/tcNU1rpdq0rFAS0Zf3NDI2Rw8T9wqFafSlsM9noCWvSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083074; c=relaxed/simple;
	bh=H6+zcmNer9PSPmUVe6DyG4KrmIb7TeNORC/7N8ufvFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWPa2YJEg/eHepqt5x2B1cBOrU/PFzjx/xanKmMWbxob7Xbi7d+bcSvmNg1x2ElX01HBp7RZEkuO/lJoadGGryqPaM4xdkXRmsg5dxL54fiA5TuUgv+7ir54uVwTwiLizefsaEnSxBj9a0q6PDkhdHssvK8FByQWGs60qF8zrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlJ887hG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b552f91033cso9125235a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083072; x=1761687872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=APwnw9S/ChSIJCoOiqKP6hfnPfq7aHnk6ysPtMDORG4=;
        b=mlJ887hGTPa3RHo3Q+z7a5kwHcKNUcuKEOgqA3FFdzk/miOXG0S82F2QUiSrfdjN+P
         cJpVldaMxZGq+LrAU8y5AvVOUtrN10vR4QtNWHeOBXyeAcMjEv0UIbJD7EU+btHBLaQ5
         kaTGXqpKKrXVbw2j45HGu8qs0az8KOcmHK0bsv8p/NmY3Pszacr0FOGjgvYHM3eupG21
         tqSgFqICECKZi7uY+4wxgCw7WuQR/7u9xbm1t3E9NUOaWSz13LQfQmwlLacezF4Jtosb
         lX6UQFgZV7BtR/QP41BozRJu6eAm5oaodCKD+037V2W3saumlu9b6L39eRjxd9XUe5kN
         aUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083072; x=1761687872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APwnw9S/ChSIJCoOiqKP6hfnPfq7aHnk6ysPtMDORG4=;
        b=k1e1MLKplhgmSaXWqrVu9LpjNZeIKIs95NWy1owXkyxmblcFckgk7SUnvHvr5lbZ5m
         EVUDufVmQsjCx9eOVu3C/aW+/+9Tkg7zcbUSSYa6Xd/c0zZPRxBDFmVSeF8HvraH1zmK
         goY6Qj5btXvvNEdJYd/kkhGUp7GfOKG/YkUQLMKkgzN7IfUnIWmuLH3uSZyc+e5gL5Dx
         xU1Xv/j0Z/Eq5Lt8nJQeREzezoNCknuNWG4Bf/+T4BJ+VTlpHBctdTQphtTy49gRxs0j
         mXCHAWq65NAbDJkDTNVNHU6gQMdvXT3XkmeemSdQsJwgtiGiY/kiiTCr6B9/YRnOKfVA
         xh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBrxsRxa13AAAK7a9DeZEKZ0jrSpxpYAP0vnAKRoOlHnyfh8FNXW71mALvxyA3MnJrBgI0Iws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgXyfk4AV9WwjKir9ZAalmTulK4ZaUEdZO8LRMOVJaWMX/Dk2
	QbNWmqF4yaoIQ74zj9p4qxS7n+ohnJINCzUQlnG0uwdtCQdqjVuJVPy1qaeDiQ+HdazrRnJR+Cb
	oDpfFsA==
X-Google-Smtp-Source: AGHT+IGbKPE+sdnjTMF6C2Ou4ftcU7iEz43kf5pSmV5NsRtwx+mcJuja9yT780JcKBVhwKj4hP7ICLpQDTM=
X-Received: from pjbpj3.prod.google.com ([2002:a17:90b:4f43:b0:332:4129:51b2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c7:b0:338:3cea:608e
 with SMTP id 98e67ed59e1d1-33bcf9080f6mr21201786a91.31.1761083072489; Tue, 21
 Oct 2025 14:44:32 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:22 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/8] sctp: Use sk_clone() in sctp_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_accept() calls sctp_v[46]_create_accept_sk() to allocate a new
socket and calls sctp_sock_migrate() to copy fields from the parent
socket to the new socket.

sctp_v4_create_accept_sk() allocates sk by sk_alloc(), initialises
it by sock_init_data(), and copy a bunch of fields from the parent
socekt by sctp_copy_sock().

sctp_sock_migrate() calls sctp_copy_descendant() to copy most fields
in sctp_sock from the parent socket by memcpy().

These can be simply replaced by sk_clone().

Let's consolidate sctp_v[46]_create_accept_sk() to sctp_clone_sock()
with sk_clone().

We will reuse sctp_clone_sock() for sctp_do_peeloff() and then remove
sctp_copy_descendant().

Note that sock_reset_flag(newsk, SOCK_ZAPPED) is not copied to
sctp_clone_sock() as sctp does not use SOCK_ZAPPED at all.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/af_inet.c |   4 +-
 net/sctp/socket.c  | 113 ++++++++++++++++++++++++++++++---------------
 2 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index e8771faa5bbfd..77f6ae0fc231d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -755,9 +755,7 @@ EXPORT_SYMBOL(inet_stream_connect);
 
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
-	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
-	if (mem_cgroup_sockets_enabled &&
-	    (!IS_ENABLED(CONFIG_IP_SCTP) || sk_is_tcp(newsk))) {
+	if (mem_cgroup_sockets_enabled) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
 
 		mem_cgroup_sk_alloc(newsk);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 70c75ac8da55d..826f17747f176 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4842,6 +4842,74 @@ static int sctp_disconnect(struct sock *sk, int flags)
 	return 0;
 }
 
+static struct sock *sctp_clone_sock(struct sock *sk,
+				    struct sctp_association *asoc,
+				    enum sctp_socket_type type)
+{
+	struct sock *newsk = sk_clone(sk, GFP_KERNEL, false);
+	struct inet_sock *newinet;
+	struct sctp_sock *newsp;
+	int err = -ENOMEM;
+
+	if (!newsk)
+		return ERR_PTR(err);
+
+	/* sk_clone() sets refcnt to 2 */
+	sock_put(newsk);
+
+	newinet = inet_sk(newsk);
+	newsp = sctp_sk(newsk);
+
+	newsp->pf->to_sk_daddr(&asoc->peer.primary_addr, newsk);
+	newinet->inet_dport = htons(asoc->peer.port);
+
+	newsp->pf->copy_ip_options(sk, newsk);
+	atomic_set(&newinet->inet_id, get_random_u16());
+
+	inet_set_bit(MC_LOOP, newsk);
+	newinet->mc_ttl = 1;
+	newinet->mc_index = 0;
+	newinet->mc_list = NULL;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		struct ipv6_pinfo *newnp = inet6_sk(newsk);
+
+		newinet->pinet6 = &((struct sctp6_sock *)newsk)->inet6;
+		newinet->ipv6_fl_list = NULL;
+
+		memcpy(newnp, inet6_sk(sk), sizeof(struct ipv6_pinfo));
+		newnp->ipv6_mc_list = NULL;
+		newnp->ipv6_ac_list = NULL;
+	}
+#endif
+
+	skb_queue_head_init(&newsp->pd_lobby);
+
+	newsp->ep = sctp_endpoint_new(newsk, GFP_KERNEL);
+	if (!newsp->ep)
+		goto out_release;
+
+	SCTP_DBG_OBJCNT_INC(sock);
+	sk_sockets_allocated_inc(newsk);
+	sock_prot_inuse_add(sock_net(sk), newsk->sk_prot, 1);
+
+	err = sctp_sock_migrate(sk, newsk, asoc, type);
+	if (err)
+		goto out_release;
+
+	/* Set newsk security attributes from original sk and connection
+	 * security attribute from asoc.
+	 */
+	security_sctp_sk_clone(asoc, sk, newsk);
+
+	return newsk;
+
+out_release:
+	sk_common_release(newsk);
+	return ERR_PTR(err);
+}
+
 /* 4.1.4 accept() - TCP Style Syntax
  *
  * Applications use accept() call to remove an established SCTP
@@ -4851,18 +4919,13 @@ static int sctp_disconnect(struct sock *sk, int flags)
  */
 static struct sock *sctp_accept(struct sock *sk, struct proto_accept_arg *arg)
 {
-	struct sctp_sock *sp, *newsp;
-	struct sctp_endpoint *ep;
-	struct sock *newsk = NULL;
 	struct sctp_association *asoc;
-	long timeo;
+	struct sock *newsk = NULL;
 	int error = 0;
+	long timeo;
 
 	lock_sock(sk);
 
-	sp = sctp_sk(sk);
-	ep = sp->ep;
-
 	if (!sctp_style(sk, TCP)) {
 		error = -EOPNOTSUPP;
 		goto out;
@@ -4883,43 +4946,19 @@ static struct sock *sctp_accept(struct sock *sk, struct proto_accept_arg *arg)
 	/* We treat the list of associations on the endpoint as the accept
 	 * queue and pick the first association on the list.
 	 */
-	asoc = list_entry(ep->asocs.next, struct sctp_association, asocs);
-
-	newsk = sp->pf->create_accept_sk(sk, asoc, arg->kern);
-	if (!newsk) {
-		error = -ENOMEM;
-		goto out;
-	}
+	asoc = list_entry(sctp_sk(sk)->ep->asocs.next,
+			  struct sctp_association, asocs);
 
-	newsp = sctp_sk(newsk);
-	newsp->ep = sctp_endpoint_new(newsk, GFP_KERNEL);
-	if (!newsp->ep) {
-		error = -ENOMEM;
-		goto out_release;
+	newsk = sctp_clone_sock(sk, asoc, SCTP_SOCKET_TCP);
+	if (IS_ERR(newsk)) {
+		error = PTR_ERR(newsk);
+		newsk = NULL;
 	}
 
-	skb_queue_head_init(&newsp->pd_lobby);
-
-	sk_sockets_allocated_inc(newsk);
-	sock_prot_inuse_add(sock_net(sk), newsk->sk_prot, 1);
-	SCTP_DBG_OBJCNT_INC(sock);
-
-	/* Populate the fields of the newsk from the oldsk and migrate the
-	 * asoc to the newsk.
-	 */
-	error = sctp_sock_migrate(sk, newsk, asoc, SCTP_SOCKET_TCP);
-	if (error)
-		goto out_release;
-
 out:
 	release_sock(sk);
 	arg->err = error;
 	return newsk;
-
-out_release:
-	sk_common_release(newsk);
-	newsk = NULL;
-	goto out;
 }
 
 /* The SCTP ioctl handler. */
-- 
2.51.0.915.g61a8936c21-goog


