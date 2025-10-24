Return-Path: <netdev+bounces-232283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE8BC03D11
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E32AB4E309B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82F22C324D;
	Thu, 23 Oct 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLuJjlgF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E172280308
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261483; cv=none; b=TFRdbX/88k+eiv6xxBf7UrgQoTIgrJZzY4/EYLlZJ9PcoL3z3nuxiFiTTmPepbFQZqCguv3vZEzUgGoQErJbj4aVwWzrrgJnS2JLNwt0wBlOLRUh/UU5IVAndA6A6+Vfy9dhUwpkYxQ78EgJ6cW0yIm31qoeOeO6Yyxerpb3mnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261483; c=relaxed/simple;
	bh=6ehkFxthd/yz/j9dV51oDbONs9a7Qc2qrSRcvnQ29fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JmNHeF7LEXx8wCpYlWygDyWrOYlLxZmvNgrUUCjeCS57feST0O4CkFjba38tZKirzgVPP9Y8pfhf7ri5TdfsnatCF2XjOGGzZD/o4wSEZs6aEfwSM3GJkTQhbQLXLWnHZBpZ6Ty+7ASUN63X295wNlkGlb+H9XGoYYfOPA5UHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLuJjlgF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so1401938a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261481; x=1761866281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWkJ19UGsDBKGV/6MvO+tX72qkba4uvwTReaH4gZoVE=;
        b=FLuJjlgFrnGV4BTuI9aO4VyCSWpDMMGUUsruP+Cd4d+sHFQkEjULp/xOc+d67M/fKR
         gG0P10SGxgU3MZAWWf6Itf3kCxy/lAWcHbSar4d2kxy6r+i52Upa/Qem4h86VNnjphMk
         hNB/v4C+jMS3aOQc+QXfG0ctX/adbm6ntTrRk+kPLAbNvP52+BuU0V6S7h5wCgKwLE5+
         lIf3/DLIyPgcdYcc9m2ph4BluRwTNPYm1AP9J80/5yjhPs0fy6GvEsTUTuHG7woFOfpY
         JbfHqg8vp+f7GUk6eGu3KmmM3wJb2CoAzpkGAzb4lN/BB+vEXEwe0MxMYAp2TOtO4AC4
         yAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261481; x=1761866281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWkJ19UGsDBKGV/6MvO+tX72qkba4uvwTReaH4gZoVE=;
        b=EoWu/WxkGcoBHPmG1Xl+YUkAz3LE5ngtO3GM/TqKJOYV8hF1phnB/NLrsId3v/EhCw
         Llx0Um6nWDMcCV7ErG7BfP0zc2TpDCwN20GAspNzAhyh1zlYgYvtfgv1baLgWYppnijU
         5FI/NQNPxiWzD2t6D85ss1nqp6hw0p9V0q/+cgORPdawLKmVXQ8Z5ulHe8wujm98Ix6O
         VLDZ9dpNgEkvbp6vXgk5xMM73MwwXkJDz1O+qwJtc8xExnxSl1rRyC2R9lZXkrvMYMFz
         H24eNtxu4unfkCoqznX8T2ITC8ZBb5Tq10w/LFLlxWwP+20zBQuK0wXwcPL+1y9N9kZA
         PLMg==
X-Forwarded-Encrypted: i=1; AJvYcCWfkOaSFj5oI4rCCXiJXG0G+0ISEAO1QqJGVCxwpEaTzQMtRbAMW2ZZKfVcvKNZTMQdEOhwga0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2uLJtoj+DCQAG9GtLvU3IAw+5HfQvk4sW9OYjBvgqXoMhIww
	EYJdjFt9e9ao1BfZJZFU30XiiPckKYP1H5H0KgEwmPxbbNkrlujnWu5H++/BgKsz3GoCIyImlGa
	hzj7LCg==
X-Google-Smtp-Source: AGHT+IHG42Mc0fxDipnB1GsCfXAB/US00kjeorUE8UayVr+6IVdwiUWKfxUPHEkDwolm/zcdw7sTQ4S2OFs=
X-Received: from pjbee13.prod.google.com ([2002:a17:90a:fc4d:b0:33b:caf7:2442])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8f:b0:33b:bed8:891e
 with SMTP id 98e67ed59e1d1-33fafc1cdf1mr5648847a91.19.1761261481465; Thu, 23
 Oct 2025 16:18:01 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:54 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 5/8] sctp: Use sk_clone() in sctp_accept().
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
index e8771faa5bbf..77f6ae0fc231 100644
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
index 70c75ac8da55..826f17747f17 100644
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
2.51.1.851.g4ebd6896fd-goog


