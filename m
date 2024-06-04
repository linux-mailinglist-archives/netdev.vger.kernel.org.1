Return-Path: <netdev+bounces-100543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF378FB0E3
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE6C2830D7
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED7B144D0F;
	Tue,  4 Jun 2024 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zGLVT47"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AF20ED
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499768; cv=none; b=CZ9jD6m5phdgnEzlYC+Vfiy0TPQUdN8A8r/BMzr6uyO9CHl0nr7K4jLYazxw9j2FZdR+978IK9F5QPssTfdroP/AQBaLaXzrOHGiGbZSxxdFbR0Wfv4n2VzDyQsiwZz8RcFMy0nDHcBFkuUA9wuU9PjObF+uQBpyaO6Niq3HT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499768; c=relaxed/simple;
	bh=Ujkv0dTs34ONTNJ/ZMkU5Lt/PdH7wyQrCV7aoeJ5bpA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PPBGtgDeFc47uR42Q1ekZp9x/uosJ8EiDt3lwT4S/UZxJA3IOFnTVFBLbYxDwjaopRzQXQZoj+jwPHeLyGZVEVRFAVd/iu3JprP4jQxFQrop/NmWSowvDjaHGLnMptyoUZmWFRBpvPL5V/glNZ8Dto7Dw94iBSQH6rroZ5c+uNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zGLVT47; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4d62ff39fso10212786276.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717499766; x=1718104566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9at3AOKzB9s5KCLHOKmmvL81Prdu6De8/2Ftzj29BVA=;
        b=3zGLVT471X0BA1D/IvUPMsIuuzgW3aTH2wnhB5SrmJ3FBFeU8So4M9YL3R3c/7TZv9
         9+oG2vTWqSxCY/mnDgaCQ7Vrpd7kac1UTFW8eSoI+xR/rVtwgjKBkuohejXEj8Y+JNRg
         pYQ8yru+bwjjFinVpZ8GsMw2Vl3WQ/sm9RUOvOlCCkhuZwZ46Dy5V4IzP331+F184n2N
         Q2VxAMG9gR5M9s42WVIj7UfrbiN0NuQ70SnTTKjmvJQtWVulXahBXlMK8I59Tv4VnXk3
         tVY2YdK+iQhSD5097UkEfwyyB0o94uQo7Tz8uGs8V41IheXyK9aCEP6CaAGiJF2bZSVO
         MLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499766; x=1718104566;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9at3AOKzB9s5KCLHOKmmvL81Prdu6De8/2Ftzj29BVA=;
        b=tdzxkzCDVoh2WTStRyX4BOgVhAUN/1a8MsvX6IU1gx0cI5Rcusg2pKtk7x953SFRrQ
         Nv8Y0HYvYkt3dnlVOyBmxBWjmC8VsTpnJYKtt1cKKETf/FW/4aqXyw9ugBTzkypsbNAH
         e0l5Bcd2Mr8QK1kmOFaGnzRr7FIF79zOyrsr1o+KblgmH8Y+9Da2ETsi30BqRONs7qKX
         LfuvGzQav8TtGo8Ii5y5RSgD0+gDXQGnne+Ppx9v+BSd8E0bqq/X4fI3OsM6/OiPiNit
         ++ncZPiJf0WLBiGdGhcD0LGBFPqSerlpoPTqr3lCFXNwqsP0f7mgC1mUY/EBZauluo90
         RhMg==
X-Gm-Message-State: AOJu0YyFsJZbp6MV7Bzu9N9J7XnzT8Yan+3GDP5gfww2IYMUYPuH9Tav
	r8Gdgi9+/47de+1uxC5Wuk99wmWz+/VS1mJNm/Il8tTl9quqpNDA1u95c+fEcRUgbeiLlRMYl24
	02V5MZK3CEg==
X-Google-Smtp-Source: AGHT+IEKHjN0zbLO2RXTPbxHe1rTidMv5AN0W4UOwRfd0Y7XMzrozjrex9uNFu3ySx5cEnkcUvFNZ2wHR9SevQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1884:b0:dfa:56fa:bb4e with SMTP
 id 3f1490d57ef6-dfa73bbcef3mr3910079276.1.1717499765616; Tue, 04 Jun 2024
 04:16:05 -0700 (PDT)
Date: Tue,  4 Jun 2024 11:16:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240604111603.45871-1-edumazet@google.com>
Subject: [PATCH net-next] net: use unrcu_pointer() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Toke mentioned unrcu_pointer() existence, allowing
to remove some of the ugly casts we have when using
xchg() for rcu protected pointers.

Also make inet_rcv_compat const.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/sock.h       | 2 +-
 net/core/gen_estimator.c | 2 +-
 net/core/sock_diag.c     | 8 +++-----
 net/ipv4/cipso_ipv4.c    | 2 +-
 net/ipv4/tcp.c           | 2 +-
 net/ipv4/tcp_fastopen.c  | 7 ++++---
 net/ipv4/udp.c           | 2 +-
 net/ipv6/af_inet6.c      | 2 +-
 net/ipv6/ip6_fib.c       | 2 +-
 net/ipv6/ipv6_sockglue.c | 3 +--
 net/ipv6/route.c         | 6 +++---
 net/sched/act_api.c      | 2 +-
 12 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 953c8dc4e259e84b927cc77edc0e55cdde654e94..b30ea0c342a652b371c6ad45ab6=
e5f835ba31aeb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2095,7 +2095,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
=20
 	sk_tx_queue_clear(sk);
 	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
-	old_dst =3D xchg((__force struct dst_entry **)&sk->sk_dst_cache, dst);
+	old_dst =3D unrcu_pointer(xchg(&sk->sk_dst_cache, RCU_INITIALIZER(dst)));
 	dst_release(old_dst);
 }
=20
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index fae9c4694186eaaac3295f32c7cb2f6b7e5e0906..412816076b8bc5543ed1eb32838=
438d1966cd473 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -206,7 +206,7 @@ void gen_kill_estimator(struct net_rate_estimator __rcu=
 **rate_est)
 {
 	struct net_rate_estimator *est;
=20
-	est =3D xchg((__force struct net_rate_estimator **)rate_est, NULL);
+	est =3D unrcu_pointer(xchg(rate_est, NULL));
 	if (est) {
 		timer_shutdown_sync(&est->timer);
 		kfree_rcu(est, rcu);
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index 6541228380252d597821b084df34176bff4ada83..a08eed9b9142e38d5f4a6a16c13=
9b37d1a84cad1 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -18,7 +18,7 @@
=20
 static const struct sock_diag_handler __rcu *sock_diag_handlers[AF_MAX];
=20
-static struct sock_diag_inet_compat __rcu *inet_rcv_compat;
+static const struct sock_diag_inet_compat __rcu *inet_rcv_compat;
=20
 static struct workqueue_struct *broadcast_wq;
=20
@@ -187,8 +187,7 @@ void sock_diag_broadcast_destroy(struct sock *sk)
=20
 void sock_diag_register_inet_compat(const struct sock_diag_inet_compat *pt=
r)
 {
-	xchg((__force const struct sock_diag_inet_compat **)&inet_rcv_compat,
-	     ptr);
+	xchg(&inet_rcv_compat, RCU_INITIALIZER(ptr));
 }
 EXPORT_SYMBOL_GPL(sock_diag_register_inet_compat);
=20
@@ -196,8 +195,7 @@ void sock_diag_unregister_inet_compat(const struct sock=
_diag_inet_compat *ptr)
 {
 	const struct sock_diag_inet_compat *old;
=20
-	old =3D xchg((__force const struct sock_diag_inet_compat **)&inet_rcv_com=
pat,
-		   NULL);
+	old =3D unrcu_pointer(xchg(&inet_rcv_compat, NULL));
 	WARN_ON_ONCE(old !=3D ptr);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister_inet_compat);
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index dd6d4601505806c79f008db69a98c0aff20eb516..3a95c0f13ce33a29d0289373255=
a9c8302d63edb 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1953,7 +1953,7 @@ int cipso_v4_req_setattr(struct request_sock *req,
 	buf =3D NULL;
=20
 	req_inet =3D inet_rsk(req);
-	opt =3D xchg((__force struct ip_options_rcu **)&req_inet->ireq_opt, opt);
+	opt =3D unrcu_pointer(xchg(&req_inet->ireq_opt, RCU_INITIALIZER(opt)));
 	if (opt)
 		kfree_rcu(opt, rcu);
=20
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5fa68e7f6ddbfd325523365cb41de07d5b938e47..82463c337dcd94bb39e60a7c383=
4ac3b2b0551b1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3079,7 +3079,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_ack.rcv_mss =3D TCP_MIN_MSS;
 	memset(&tp->rx_opt, 0, sizeof(tp->rx_opt));
 	__sk_dst_reset(sk);
-	dst_release(xchg((__force struct dst_entry **)&sk->sk_rx_dst, NULL));
+	dst_release(unrcu_pointer(xchg(&sk->sk_rx_dst, NULL)));
 	tcp_saved_syn_free(tp);
 	tp->compressed_ack =3D 0;
 	tp->segs_in =3D 0;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 8ed54e7334a9c646dfbbc6dc41b9ef11b925de0a..0f523cbfe329efeaee2ef206b07=
79e9911ef22cd 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -49,7 +49,7 @@ void tcp_fastopen_ctx_destroy(struct net *net)
 {
 	struct tcp_fastopen_context *ctxt;
=20
-	ctxt =3D xchg((__force struct tcp_fastopen_context **)&net->ipv4.tcp_fast=
open_ctx, NULL);
+	ctxt =3D unrcu_pointer(xchg(&net->ipv4.tcp_fastopen_ctx, NULL));
=20
 	if (ctxt)
 		call_rcu(&ctxt->rcu, tcp_fastopen_ctx_free);
@@ -80,9 +80,10 @@ int tcp_fastopen_reset_cipher(struct net *net, struct so=
ck *sk,
=20
 	if (sk) {
 		q =3D &inet_csk(sk)->icsk_accept_queue.fastopenq;
-		octx =3D xchg((__force struct tcp_fastopen_context **)&q->ctx, ctx);
+		octx =3D unrcu_pointer(xchg(&q->ctx, RCU_INITIALIZER(ctx)));
 	} else {
-		octx =3D xchg((__force struct tcp_fastopen_context **)&net->ipv4.tcp_fas=
topen_ctx, ctx);
+		octx =3D unrcu_pointer(xchg(&net->ipv4.tcp_fastopen_ctx,
+					  RCU_INITIALIZER(ctx)));
 	}
=20
 	if (octx)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a180cc2788632892cbd12a829a500..c9ca6d285347b8c3032e2a779b3=
9aa426bd6ee4a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2230,7 +2230,7 @@ bool udp_sk_rx_dst_set(struct sock *sk, struct dst_en=
try *dst)
 	struct dst_entry *old;
=20
 	if (dst_hold_safe(dst)) {
-		old =3D xchg((__force struct dst_entry **)&sk->sk_rx_dst, dst);
+		old =3D unrcu_pointer(xchg(&sk->sk_rx_dst, RCU_INITIALIZER(dst)));
 		dst_release(old);
 		return old !=3D dst;
 	}
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 8041dc181bd42e5e1af2d9e9fe6af50057e5b58f..e03fb9a1dbeb46081b50e016064=
bdf296002e092 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -509,7 +509,7 @@ void inet6_cleanup_sock(struct sock *sk)
=20
 	/* Free tx options */
=20
-	opt =3D xchg((__force struct ipv6_txoptions **)&np->opt, NULL);
+	opt =3D unrcu_pointer(xchg(&np->opt, NULL));
 	if (opt) {
 		atomic_sub(opt->tot_len, &sk->sk_omem_alloc);
 		txopt_put(opt);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 31d77885bcae3e3843b6d486cfc21cdbe709bcf0..15f9abe506562eaa6a9c29c746b=
e97ca7a2288d0 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -984,7 +984,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_=
nh,
 		if (pcpu_rt && rcu_access_pointer(pcpu_rt->from) =3D=3D match) {
 			struct fib6_info *from;
=20
-			from =3D xchg((__force struct fib6_info **)&pcpu_rt->from, NULL);
+			from =3D unrcu_pointer(xchg(&pcpu_rt->from, NULL));
 			fib6_info_release(from);
 		}
 	}
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index d4c28ec1bc517b33498b08b59bcda5fe960f652f..cd342d5015c6fb36bd03d4f3fca=
e4a3995ff6097 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -111,8 +111,7 @@ struct ipv6_txoptions *ipv6_update_options(struct sock =
*sk,
 			icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		}
 	}
-	opt =3D xchg((__force struct ipv6_txoptions **)&inet6_sk(sk)->opt,
-		   opt);
+	opt =3D unrcu_pointer(xchg(&inet6_sk(sk)->opt, RCU_INITIALIZER(opt)));
 	sk_dst_reset(sk);
=20
 	return opt;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a504b88ec06b5aec6b0f915c3ff044cd98f864ab..e7749ae49a837fd099b7a9634c9=
3fb8e68733041 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -368,7 +368,7 @@ static void ip6_dst_destroy(struct dst_entry *dst)
 		in6_dev_put(idev);
 	}
=20
-	from =3D xchg((__force struct fib6_info **)&rt->from, NULL);
+	from =3D unrcu_pointer(xchg(&rt->from, NULL));
 	fib6_info_release(from);
 }
=20
@@ -1437,7 +1437,7 @@ static struct rt6_info *rt6_make_pcpu_route(struct ne=
t *net,
 	if (res->f6i->fib6_destroying) {
 		struct fib6_info *from;
=20
-		from =3D xchg((__force struct fib6_info **)&pcpu_rt->from, NULL);
+		from =3D unrcu_pointer(xchg(&pcpu_rt->from, NULL));
 		fib6_info_release(from);
 	}
=20
@@ -1466,7 +1466,7 @@ static void rt6_remove_exception(struct rt6_exception=
_bucket *bucket,
 	/* purge completely the exception to allow releasing the held resources:
 	 * some [sk] cache may keep the dst around for unlimited time
 	 */
-	from =3D xchg((__force struct fib6_info **)&rt6_ex->rt6i->from, NULL);
+	from =3D unrcu_pointer(xchg(&rt6_ex->rt6i->from, NULL));
 	fib6_info_release(from);
 	dst_dev_put(&rt6_ex->rt6i->dst);
=20
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9ee622fb1160fe5de8df9a5fca0c9a412e40e31a..7458b3154426279123a8b178fe4=
0f05ce657b5c2 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -62,7 +62,7 @@ static void tcf_set_action_cookie(struct tc_cookie __rcu =
**old_cookie,
 {
 	struct tc_cookie *old;
=20
-	old =3D xchg((__force struct tc_cookie **)old_cookie, new_cookie);
+	old =3D unrcu_pointer(xchg(old_cookie, RCU_INITIALIZER(new_cookie)));
 	if (old)
 		call_rcu(&old->rcu, tcf_free_cookie_rcu);
 }
--=20
2.45.1.467.gbab1589fc0-goog


