Return-Path: <netdev+bounces-211300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5443B17BAD
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 06:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A5658504B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 04:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BD1917F4;
	Fri,  1 Aug 2025 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2siW37b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5316A395
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754021281; cv=none; b=tVnjcJjk6V5X1oykgVzijyxe0mnZ43AXx4SG1mEWbSoRD93+mA9gcORO6cgEuT61R8uF3mEJpeozoBTRRGAedada8LgV70pbVdKyqI5vdKf63S36nUHReGS9LAVDzo7ut3b8CU8ONuwPJxmZvzjcFMfhf9LnKXjiJdaEjUVBbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754021281; c=relaxed/simple;
	bh=2viiInw5BigNS6IWeaKOsjKds/VIkaIp04LPlAm+LCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZT9OIw+OYq/P19fDUmoi3FolfzNiMAEqUDVG9kqROQT118wv01fAmZxJBCNkoEvpYgTTMl+k5bm5F1dfalDmPPiagVo+bC11N8Abn7IGQ2RPJREraEr1yoB/kNv66zgjJtvqG5XnlVUCQlmJWVitILMc6/bUHkyEkti/tZprM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2siW37b; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so1402989a91.2
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754021279; x=1754626079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+s8Mijk0QvzV+Oz74rDbeiIOf7F9U9mJfUeVnXP3KVc=;
        b=K2siW37bM8IFH3/g8NIxlPbAZZajLmSQtf1FWw4sa+lRx+NP1p+KagEwjpw7X40sNQ
         sSSWmETEUspjdEAfJqJ+Alzu+3xWcFoTOpxaQDv5PwHP+jT6huTk5m/OSH6A63q0XTuU
         daYADV48QmlNF1/sFxmLsP47SoJiA4mmwgc+wJT5ohsyFcHG7be81BsjYHA62Q1n9eSd
         qNcHqeBMk1gQVWfxQw8TMatmx6GI4fgxl8ziBC7Qsh5tZShM/FPnNvDwwU/GsK284y+W
         xCuoIVybXXHkhyJNpPR7po5pZuhJ9q/iUaMXmprUTIQo8Z16DdtJQa+5Yutk7yE5diQW
         JXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754021279; x=1754626079;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+s8Mijk0QvzV+Oz74rDbeiIOf7F9U9mJfUeVnXP3KVc=;
        b=nQxGQz1+Vm/QF/Gitdo5+zI+KsFDhyDHuhkFHtYOIw2UB0X6LuQyIadRK23s/7zFSl
         AGj8QSdCKpVwjoXuzUKT63Ocafo9sLQAZ3ec5oldaGE/B1WPHPyJmRGREtekwnvpu6U+
         RzvELCrkLJD3osMYDgkJvWcxwD6f3vM8LZxP4kMVZ1BlheXFWhFVqSOTNdIy/t7yMDny
         1s+xIonaj3BDP1fCzWVD/rZnnGBe+0cpZkAmwc5d2yZfEfpnsPvODuGZASb7m+ponKOf
         pCwca3jntZmUntQOFMlCf9hcX53sNMCgrQrFyAkWFr6LobWOfpLnv5FFczBnrdefn2z7
         y2NA==
X-Forwarded-Encrypted: i=1; AJvYcCUV3GhKdSJVvNAG5vkFA6z/h3tVhDrs35y6c/OQQ9DD3HVNe5UTPIdw5YNb7GKNTU4bjmkofMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweIm0qsPipuj1Ef+DcsRviDDKNHtPEUcStt1Mynv7Zr2B8iQMm
	X6MU9xmS/n+lfm114QzxIWAyZ7tBf8TpDeMCloF3ZemkcERi2jnUhAbCD6sydO+phJaLtrFHHCy
	ZIOpMMQ==
X-Google-Smtp-Source: AGHT+IGWQJGuPSbJOHnN83SU5TTHo8b1wLxVgV3oQP3HATmCelBMkngzyt1TjDFWGLnqEgHFLUzdLNeASsE=
X-Received: from pja8.prod.google.com ([2002:a17:90b:5488:b0:31e:fac4:4723])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f8c:b0:31f:10e:2c01
 with SMTP id 98e67ed59e1d1-31f5dd93b46mr14852886a91.8.1754021278576; Thu, 31
 Jul 2025 21:07:58 -0700 (PDT)
Date: Fri,  1 Aug 2025 04:06:37 +0000
In-Reply-To: <CADxym3YgyBpkEgDApyL4LXsLPBhO4r5DU+oX1pF_p6_BsvyVNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CADxym3YgyBpkEgDApyL4LXsLPBhO4r5DU+oX1pF_p6_BsvyVNw@mail.gmail.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801040757.1599996-1-kuniyu@google.com>
Subject: Re: [PATCH net-next] net: ip: lookup the best matched listen socket
From: Kuniyuki Iwashima <kuniyu@google.com>
To: menglong8.dong@gmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kafai@fb.com, kraig@google.com, kuba@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 1 Aug 2025 09:31:43 +0800
> On Fri, Aug 1, 2025 at 1:52=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Thu, Jul 31, 2025 at 6:01=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Jul 31, 2025 at 5:33=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > For now, the socket lookup will terminate if the socket is reuse po=
rt in
> > > > inet_lhash2_lookup(), which makes the socket is not the best match.
> > > >
> > > > For example, we have socket1 and socket2 both listen on "0.0.0.0:12=
34",
> > > > but socket1 bind on "eth0". We create socket1 first, and then socke=
t2.
> > > > Then, all connections will goto socket2, which is not expected, as =
socket1
> > > > has higher priority.
> > > >
> > > > This can cause unexpected behavior if TCP MD5 keys is used, as desc=
ribed
> > > > in Documentation/networking/vrf.rst -> Applications.
> > > >
> > > > Therefor, we lookup the best matched socket first, and then do the =
reuse
> > > > port logic. This can increase some overhead if there are many reuse=
 port
> > > > socket :/
> >
> > This kills O(1) lookup for reuseport...
> >
> > Another option would be to try hard in __inet_hash() to sort
> > reuseport groups.
>=20
> Good idea. For the reuse port case, we can compute a score
> for the reuseport sockets and insert the high score to front of
> the list. I'll have a try this way.

I remember you reported the same issue in Feburary and
I hacked up a patch below based on a draft diff in my stash.

This fixes the issue, but we still have corner cases where
SO_REUSEPORT/SO_BINDTODEVICE are changed after listen(),
which should not be allowed given TCP does not have ->rehash()
and confuses/breaks the reuseport logic/rule.

---8<---
diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..8436e352732f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -885,6 +885,18 @@ static inline void __sk_nulls_add_node_tail_rcu(struct=
 sock *sk, struct hlist_nu
 	hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
 }
=20
+static inline void __sk_nulls_insert_after_node_rcu(struct sock *sk,
+						    struct hlist_nulls_node *prev)
+{
+	struct hlist_nulls_node *n =3D &sk->sk_nulls_node;
+
+	n->next =3D prev->next;
+	n->pprev =3D &prev->next;
+	if (!is_a_nulls(n->next))
+		WRITE_ONCE(n->next->pprev, &n->next);
+	rcu_assign_pointer(hlist_nulls_next_rcu(prev), n);
+}
+
 static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nul=
ls_head *list)
 {
 	sock_hold(sk);
diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
index 6e4faf3ee76f..4a3e9d6887a6 100644
--- a/include/net/sock_reuseport.h
+++ b/include/net/sock_reuseport.h
@@ -23,12 +23,14 @@ struct sock_reuseport {
 	unsigned int		synq_overflow_ts;
 	/* ID stays the same even after the size of socks[] grows. */
 	unsigned int		reuseport_id;
-	unsigned int		bind_inany:1;
-	unsigned int		has_conns:1;
+	unsigned short		bind_inany:1;
+	unsigned short		has_conns:1;
+	unsigned short		score;
 	struct bpf_prog __rcu	*prog;		/* optional BPF sock selector */
 	struct sock		*socks[] __counted_by(max_socks);
 };
=20
+unsigned short reuseport_compute_score(struct sock *sk, bool bind_inany);
 extern int reuseport_alloc(struct sock *sk, bool bind_inany);
 extern int reuseport_add_sock(struct sock *sk, struct sock *sk2,
 			      bool bind_inany);
diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 4211710393a8..df3d1a6f3178 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -6,6 +6,7 @@
  * selecting the socket index from the array of available sockets.
  */
=20
+#include <net/addrconf.h>
 #include <net/ip.h>
 #include <net/sock_reuseport.h>
 #include <linux/bpf.h>
@@ -185,6 +186,25 @@ static struct sock_reuseport *__reuseport_alloc(unsign=
ed int max_socks)
 	return reuse;
 }
=20
+unsigned short reuseport_compute_score(struct sock *sk, bool bind_inany)
+{
+	unsigned short score =3D 0;
+
+	if (sk->sk_family =3D=3D AF_INET)
+		score +=3D 10;
+
+	if (ipv6_only_sock(sk))
+		score++;
+
+	if (!bind_inany)
+		score++;
+
+	if (sk->sk_bound_dev_if)
+		score++;
+
+	return score;
+}
+
 int reuseport_alloc(struct sock *sk, bool bind_inany)
 {
 	struct sock_reuseport *reuse;
@@ -233,6 +253,7 @@ int reuseport_alloc(struct sock *sk, bool bind_inany)
 	reuse->bind_inany =3D bind_inany;
 	reuse->socks[0] =3D sk;
 	reuse->num_socks =3D 1;
+	reuse->score =3D reuseport_compute_score(sk, bind_inany);
 	reuseport_get_incoming_cpu(sk, reuse);
 	rcu_assign_pointer(sk->sk_reuseport_cb, reuse);
=20
@@ -278,6 +299,7 @@ static struct sock_reuseport *reuseport_grow(struct soc=
k_reuseport *reuse)
 	more_reuse->bind_inany =3D reuse->bind_inany;
 	more_reuse->has_conns =3D reuse->has_conns;
 	more_reuse->incoming_cpu =3D reuse->incoming_cpu;
+	more_reuse->score =3D reuse->score;
=20
 	memcpy(more_reuse->socks, reuse->socks,
 	       reuse->num_socks * sizeof(struct sock *));
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..042a65372d00 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -739,6 +739,44 @@ static int inet_reuseport_add_sock(struct sock *sk,
 	return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
 }
=20
+static void inet_reuseport_hash_sock(struct sock *sk,
+				     struct inet_listen_hashbucket *ilb2)
+{
+	struct inet_bind_bucket *tb =3D inet_csk(sk)->icsk_bind_hash;
+	const struct hlist_nulls_node *node;
+	struct sock *sk2, *sk_anchor =3D NULL;
+	unsigned short score, hiscore;
+	struct sock_reuseport *reuse;
+
+	reuse =3D rcu_dereference_protected(sk->sk_reuseport_cb, 1);
+	score =3D reuse->score;
+
+	sk_nulls_for_each_rcu(sk2, node, &ilb2->nulls_head) {
+		if (!sk2->sk_reuseport)
+			continue;
+
+		if (inet_csk(sk2)->icsk_bind_hash !=3D tb)
+			continue;
+
+		reuse =3D rcu_dereference_protected(sk2->sk_reuseport_cb, 1);
+		if (likely(reuse))
+			hiscore =3D reuse->score;
+		else
+			hiscore =3D reuseport_compute_score(sk2,
+							  inet_rcv_saddr_any(sk2));
+
+		if (hiscore <=3D score)
+			break;
+
+		sk_anchor =3D sk2;
+	}
+
+	if (sk_anchor)
+		__sk_nulls_insert_after_node_rcu(sk, &sk_anchor->sk_nulls_node);
+	else
+		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
+}
+
 int __inet_hash(struct sock *sk, struct sock *osk)
 {
 	struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
@@ -759,13 +797,14 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		err =3D inet_reuseport_add_sock(sk, ilb2);
 		if (err)
 			goto unlock;
-	}
-	sock_set_flag(sk, SOCK_RCU_FREE);
-	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
-		sk->sk_family =3D=3D AF_INET6)
-		__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
-	else
+
+		sock_set_flag(sk, SOCK_RCU_FREE);
+		inet_reuseport_hash_sock(sk, ilb2);
+	} else {
+		sock_set_flag(sk, SOCK_RCU_FREE);
 		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
+	}
+
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
 	spin_unlock(&ilb2->lock);
---8<---


Tested:

---8<---
[root@fedora ~]# cat a.py
from socket import *

s1 =3D socket()
s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
s1.setsockopt(SOL_SOCKET, SO_BINDTODEVICE, b'lo')
s1.listen()
s1.setblocking(False)

s2 =3D socket()
s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
s2.bind(s1.getsockname())
s2.listen()
s2.setblocking(False)

for i in range(3):
    c =3D socket()
    c.connect(s1.getsockname())
    try:
        print("assigned properly:", s1.accept())
    except:
        print("wrong assignment")
[root@fedora ~]# python3 a.py
assigned properly: (<socket.socket fd=3D6, family=3D2, type=3D1, proto=3D0,=
 laddr=3D('127.0.0.1', 36733), raddr=3D('127.0.0.1', 39478)>, ('127.0.0.1',=
 39478))
assigned properly: (<socket.socket fd=3D5, family=3D2, type=3D1, proto=3D0,=
 laddr=3D('127.0.0.1', 36733), raddr=3D('127.0.0.1', 39490)>, ('127.0.0.1',=
 39490))
assigned properly: (<socket.socket fd=3D6, family=3D2, type=3D1, proto=3D0,=
 laddr=3D('127.0.0.1', 36733), raddr=3D('127.0.0.1', 39506)>, ('127.0.0.1',=
 39506))
---8<---

