Return-Path: <netdev+bounces-211309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A21E1B17DA2
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF17A7B9708
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313B14F9D6;
	Fri,  1 Aug 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiZ/uzOF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA12A8C1;
	Fri,  1 Aug 2025 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033605; cv=none; b=JxjEl7GNWOUe4ARkN3H6Vh85V6Kxh5W1OwgQ86ECYvlAWiwRCLke/XTkbXZtOxWMyhxAW+TfzSHpX9w2HoGWn9YiPvBDtnp7wEMhKT8eoVhQsbI8/Yh16TNTZIbvkDTIlUqlcD//itBYNwDw4BxcSD305CHKxORrIn6zfm1HDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033605; c=relaxed/simple;
	bh=mV0ZXXgxZIeyFp/araM3WvFl/5l55Yf4J9gG6lChfv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoRFW44NXcj7WqjInFZRVgH6MZIF0soskyZrJQo4Y7l6Weu1WShdt9SS9NNhYcd9qgeANyRV91ly1Q7ivWkojtSEmZOQD5ORfmyfgwHWVv5delLzjmWj7w173Ebkgoki9iGmc2b5F01n/7QOe8ShoJ1UbBUyfdBb5AbUPtiMQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiZ/uzOF; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso2006094276.1;
        Fri, 01 Aug 2025 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754033602; x=1754638402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuQdnRxoa4kTzJjnMFJOAhBD5j99W0Mpc2jJTSjDCWA=;
        b=MiZ/uzOF7otXj2dMCl3Vv6HSbFua/bub5gNY7T9MYCprPAFEpIz76YEiJJ3mH6xJZg
         LWIqj+zw0Apw0TyoVqlhDfgRe5FSSk4HffB3fMCBlEbLiaDhEDyWdeGV8DxWvFnVVHMW
         j+wBvYdT5S8t49fowJKTSw11VU1BmIrJ0I9XOXn49cs7Ene+bkCLv6Z1YE1DFAw6f2XA
         /CqddJfmwIo9RSh2eCmIbDF0StRpl6JLlmoa6n0Ma+3dKERC58ziPu9TEMbYeTA1X1zZ
         rtGcwV2YjPZ/BVRatQl2y3oHEVuO/ufbrVrACqEPOxqyKUYAiPLwMYkx34hRpXQ7d61d
         5rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754033602; x=1754638402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuQdnRxoa4kTzJjnMFJOAhBD5j99W0Mpc2jJTSjDCWA=;
        b=bjEXO49/LFUQWpIxZ5La2MTHjd8XONRTsxLo0A+7TChe2ORQPDsymAaFM0uH34mN44
         H1YMKxGJEwKwbkUCx6t3SmT1cZrZ4k8HvE+Me5q8dBXdWdC9UHRwAPF0XEl0B3TmpYci
         PpAPE64fKeqMaZ2v3cM1MnMHeBmPnlFF8xL3uiM7U1XD/Q4Ssf+zFKVK922MLZ3aIPUi
         vnDzJHJQ9yYw7rAnKD3GTOTf+UcxW69FuccGwff2kDUvbB1//Xk0m0xixmhwBQRZIEDa
         GTM9uGTaOOAsHXFh1jBb+VEBCQi/rffHyOElc96Gstp1uhiW5/LK7wtnHHySnYX3QeI7
         OPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWVz5645OXwSzsn0k1YPGaALo4Y2EToq/I5dfCIVCGk4M5h9O16IstzpP6h6Cj+g5W/WfhClRm@vger.kernel.org, AJvYcCV9ge3wFfejjle6ZctEguWK2qxsfW8jovxKWnhyz4KqMZx0fQdoxw5PGgkqeX83YHQTVUsx2fJh4reAKks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwppRoKpbggwGF7DXqcmDC1C6isD46KsCrzQ4yrGnMdjDSqBBjF
	y0T5QSPIsLhcWg/EvKmDHb2Wpa9Rsx9SR3qTKRl5wMX/YweEI/Elko/YKex640Y4iKRLZuSMMIr
	mV/cSh8WKDHA9mKCR6THwXDMFbCNnkSw=
X-Gm-Gg: ASbGncuH3osN68tR3gA4ujCo3lP+r1rxF8kDs4McFQWdzPfr/9u5CvmjfbPr3GI55xK
	t0AEkEyHxFJ6xW7/uu7XJotkcB6xY1ojwIkAjjtSzIjVInjGfljRMH9whhSeY0Wt+NJVyIvfMqx
	HLjURrRTcM6Fw03/JbhyhX8kSGDD1jkG/EJhnyyzabit4123CBvuyhM6vlMuAqy8ZQCskNk1zDc
	8sgwxc=
X-Google-Smtp-Source: AGHT+IElJlBpqcp+5heYrVN/m5BPv+TtmxDBQj5coSYbN0Gt8SPgIg2jveAOovjF+M1Kx8INkmNwi5LxSVVLMZPXUHw=
X-Received: by 2002:a05:6902:288e:b0:e8e:c3d:db8b with SMTP id
 3f1490d57ef6-e8fd53a9df8mr6045621276.13.1754033601894; Fri, 01 Aug 2025
 00:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3YgyBpkEgDApyL4LXsLPBhO4r5DU+oX1pF_p6_BsvyVNw@mail.gmail.com>
 <20250801040757.1599996-1-kuniyu@google.com>
In-Reply-To: <20250801040757.1599996-1-kuniyu@google.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 1 Aug 2025 15:33:11 +0800
X-Gm-Features: Ac12FXyk5OPdwqMZubM2oRqqOPwZXOxpbynjsvsGkPdnR2J9hmGIlh6mQSXsi_0
Message-ID: <CADxym3bCWf3EHF+drDPntjcXAiU3XKOtCDuwp-hX+jj6LjD6wg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ip: lookup the best matched listen socket
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kafai@fb.com, kraig@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Menglong Dong <menglong8.dong@gmail.com>
> Date: Fri, 1 Aug 2025 09:31:43 +0800
> > On Fri, Aug 1, 2025 at 1:52=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > >
> > > On Thu, Jul 31, 2025 at 6:01=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Thu, Jul 31, 2025 at 5:33=E2=80=AFAM Menglong Dong <menglong8.do=
ng@gmail.com> wrote:
> > > > >
> > > > > For now, the socket lookup will terminate if the socket is reuse =
port in
> > > > > inet_lhash2_lookup(), which makes the socket is not the best matc=
h.
> > > > >
> > > > > For example, we have socket1 and socket2 both listen on "0.0.0.0:=
1234",
> > > > > but socket1 bind on "eth0". We create socket1 first, and then soc=
ket2.
> > > > > Then, all connections will goto socket2, which is not expected, a=
s socket1
> > > > > has higher priority.
> > > > >
> > > > > This can cause unexpected behavior if TCP MD5 keys is used, as de=
scribed
> > > > > in Documentation/networking/vrf.rst -> Applications.
> > > > >
> > > > > Therefor, we lookup the best matched socket first, and then do th=
e reuse
> > > > > port logic. This can increase some overhead if there are many reu=
se port
> > > > > socket :/
> > >
> > > This kills O(1) lookup for reuseport...
> > >
> > > Another option would be to try hard in __inet_hash() to sort
> > > reuseport groups.
> >
> > Good idea. For the reuse port case, we can compute a score
> > for the reuseport sockets and insert the high score to front of
> > the list. I'll have a try this way.
>
> I remember you reported the same issue in Feburary and
> I hacked up a patch below based on a draft diff in my stash.

Yeah, I reported before in this link:
https://lore.kernel.org/netdev/20250227123137.138778-1-dongml2@chinatelecom=
.cn/

And I made a wrong commit log in that patch, which made the
patch you hacked up didn't solve the problem :/

>
> This fixes the issue, but we still have corner cases where
> SO_REUSEPORT/SO_BINDTODEVICE are changed after listen(),
> which should not be allowed given TCP does not have ->rehash()
> and confuses/breaks the reuseport logic/rule.

Do we need to save the score? Which will make the logic
more complex :/

I just wrote a similar patch, which should work too:

---------------------------------------patch
begin---------------------------------
diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..da500f4ae142 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct
hlist_nulls_node *n)
 #define hlist_nulls_next_rcu(node) \
     (*((struct hlist_nulls_node __rcu __force **)&(node)->next))

+/**
+ * hlist_nulls_pprev_rcu - returns the element of the list after @node.
+ * @node: element of the list.
+ */
+#define hlist_nulls_pprev_rcu(node) \
+    (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
+
 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initializ=
ation
  * @n: the element to delete from the hash list.
@@ -145,6 +152,33 @@ static inline void
hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
     }
 }

+/**
+ * hlist_nulls_add_before_rcu
+ * @n: the new element to add to the hash list.
+ * @next: the existing element to add the new element before.
+ *
+ * Description:
+ * Adds the specified element to the specified hlist
+ * before the specified node while permitting racing traversals.
+ *
+ * The caller must take whatever precautions are necessary
+ * (such as holding appropriate locks) to avoid racing
+ * with another list-mutation primitive, such as hlist_nulls_add_head_rcu(=
)
+ * or hlist_nulls_del_rcu(), running on this same list.
+ * However, it is perfectly legal to run concurrently with
+ * the _rcu list-traversal primitives, such as
+ * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consistency
+ * problems on Alpha CPUs.
+ */
+static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node *n,
+                          struct hlist_nulls_node *next)
+{
+    WRITE_ONCE(n->pprev, next->pprev);
+    n->next =3D next;
+    rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
+    WRITE_ONCE(next->pprev, &n->next);
+}
+
 /* after that hlist_nulls_del will work */
 static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..42aa1919eeee 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -885,6 +885,11 @@ static inline void
__sk_nulls_add_node_tail_rcu(struct sock *sk, struct hlist_nu
     hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
 }

+static inline void __sk_nulls_add_node_before_rcu(struct sock *sk,
struct sock *next)
+{
+    hlist_nulls_add_before_rcu(&sk->sk_nulls_node, &next->sk_nulls_node);
+}
+
 static inline void sk_nulls_add_node_rcu(struct sock *sk, struct
hlist_nulls_head *list)
 {
     sock_hold(sk);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..53a72a8b6094 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -334,6 +334,21 @@ static inline int compute_score(struct sock *sk,
const struct net *net,
     return score;
 }

+static inline int compute_reuseport_score(struct sock *sk)
+{
+    int score =3D 0;
+
+    if (sk->sk_bound_dev_if)
+        score++;
+
+    if (sk->sk_family =3D=3D PF_INET)
+        score +=3D 5;
+    if (READ_ONCE(sk->sk_incoming_cpu))
+        score++;
+
+    return score;
+}
+
 /**
  * inet_lookup_reuseport() - execute reuseport logic on AF_INET
socket if necessary.
  * @net: network namespace.
@@ -739,6 +754,27 @@ static int inet_reuseport_add_sock(struct sock *sk,
     return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
 }

+static void inet_hash_reuseport(struct sock *sk, struct hlist_nulls_head *=
head)
+{
+    const struct hlist_nulls_node *node;
+    int score, curscore;
+    struct sock *sk2;
+
+    curscore =3D compute_reuseport_score(sk);
+    /* lookup the socket to insert before */
+    sk_nulls_for_each_rcu(sk2, node, head) {
+        if (!sk2->sk_reuseport)
+            continue;
+        score =3D compute_reuseport_score(sk2);
+        if (score <=3D curscore) {
+            __sk_nulls_add_node_before_rcu(sk, sk2);
+            return;
+        }
+    }
+
+    __sk_nulls_add_node_tail_rcu(sk, head);
+}
+
 int __inet_hash(struct sock *sk, struct sock *osk)
 {
     struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
@@ -761,11 +797,11 @@ int __inet_hash(struct sock *sk, struct sock *osk)
             goto unlock;
     }
     sock_set_flag(sk, SOCK_RCU_FREE);
-    if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
-        sk->sk_family =3D=3D AF_INET6)
-        __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
-    else
+    if (!sk->sk_reuseport)
         __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
+    else
+        inet_hash_reuseport(sk, &ilb2->nulls_head);
+
     sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
     spin_unlock(&ilb2->lock);
------------------------------patch end------------------------------------=
--

>
> ---8<---
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c8a4b283df6f..8436e352732f 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -885,6 +885,18 @@ static inline void __sk_nulls_add_node_tail_rcu(stru=
ct sock *sk, struct hlist_nu
>         hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
>  }
>
> +static inline void __sk_nulls_insert_after_node_rcu(struct sock *sk,
> +                                                   struct hlist_nulls_no=
de *prev)
> +{
> +       struct hlist_nulls_node *n =3D &sk->sk_nulls_node;
> +
> +       n->next =3D prev->next;
> +       n->pprev =3D &prev->next;
> +       if (!is_a_nulls(n->next))
> +               WRITE_ONCE(n->next->pprev, &n->next);
> +       rcu_assign_pointer(hlist_nulls_next_rcu(prev), n);
> +}
> +
>  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_n=
ulls_head *list)
>  {
>         sock_hold(sk);
> diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
> index 6e4faf3ee76f..4a3e9d6887a6 100644
> --- a/include/net/sock_reuseport.h
> +++ b/include/net/sock_reuseport.h
> @@ -23,12 +23,14 @@ struct sock_reuseport {
>         unsigned int            synq_overflow_ts;
>         /* ID stays the same even after the size of socks[] grows. */
>         unsigned int            reuseport_id;
> -       unsigned int            bind_inany:1;
> -       unsigned int            has_conns:1;
> +       unsigned short          bind_inany:1;
> +       unsigned short          has_conns:1;
> +       unsigned short          score;
>         struct bpf_prog __rcu   *prog;          /* optional BPF sock sele=
ctor */
>         struct sock             *socks[] __counted_by(max_socks);
>  };
>
> +unsigned short reuseport_compute_score(struct sock *sk, bool bind_inany)=
;
>  extern int reuseport_alloc(struct sock *sk, bool bind_inany);
>  extern int reuseport_add_sock(struct sock *sk, struct sock *sk2,
>                               bool bind_inany);
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index 4211710393a8..df3d1a6f3178 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -6,6 +6,7 @@
>   * selecting the socket index from the array of available sockets.
>   */
>
> +#include <net/addrconf.h>
>  #include <net/ip.h>
>  #include <net/sock_reuseport.h>
>  #include <linux/bpf.h>
> @@ -185,6 +186,25 @@ static struct sock_reuseport *__reuseport_alloc(unsi=
gned int max_socks)
>         return reuse;
>  }
>
> +unsigned short reuseport_compute_score(struct sock *sk, bool bind_inany)
> +{
> +       unsigned short score =3D 0;
> +
> +       if (sk->sk_family =3D=3D AF_INET)
> +               score +=3D 10;
> +
> +       if (ipv6_only_sock(sk))
> +               score++;
> +
> +       if (!bind_inany)
> +               score++;
> +
> +       if (sk->sk_bound_dev_if)
> +               score++;
> +
> +       return score;
> +}
> +
>  int reuseport_alloc(struct sock *sk, bool bind_inany)
>  {
>         struct sock_reuseport *reuse;
> @@ -233,6 +253,7 @@ int reuseport_alloc(struct sock *sk, bool bind_inany)
>         reuse->bind_inany =3D bind_inany;
>         reuse->socks[0] =3D sk;
>         reuse->num_socks =3D 1;
> +       reuse->score =3D reuseport_compute_score(sk, bind_inany);
>         reuseport_get_incoming_cpu(sk, reuse);
>         rcu_assign_pointer(sk->sk_reuseport_cb, reuse);
>
> @@ -278,6 +299,7 @@ static struct sock_reuseport *reuseport_grow(struct s=
ock_reuseport *reuse)
>         more_reuse->bind_inany =3D reuse->bind_inany;
>         more_reuse->has_conns =3D reuse->has_conns;
>         more_reuse->incoming_cpu =3D reuse->incoming_cpu;
> +       more_reuse->score =3D reuse->score;
>
>         memcpy(more_reuse->socks, reuse->socks,
>                reuse->num_socks * sizeof(struct sock *));
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ceeeec9b7290..042a65372d00 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -739,6 +739,44 @@ static int inet_reuseport_add_sock(struct sock *sk,
>         return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
>  }
>
> +static void inet_reuseport_hash_sock(struct sock *sk,
> +                                    struct inet_listen_hashbucket *ilb2)
> +{
> +       struct inet_bind_bucket *tb =3D inet_csk(sk)->icsk_bind_hash;
> +       const struct hlist_nulls_node *node;
> +       struct sock *sk2, *sk_anchor =3D NULL;
> +       unsigned short score, hiscore;
> +       struct sock_reuseport *reuse;
> +
> +       reuse =3D rcu_dereference_protected(sk->sk_reuseport_cb, 1);
> +       score =3D reuse->score;
> +
> +       sk_nulls_for_each_rcu(sk2, node, &ilb2->nulls_head) {
> +               if (!sk2->sk_reuseport)
> +                       continue;
> +
> +               if (inet_csk(sk2)->icsk_bind_hash !=3D tb)
> +                       continue;
> +
> +               reuse =3D rcu_dereference_protected(sk2->sk_reuseport_cb,=
 1);
> +               if (likely(reuse))
> +                       hiscore =3D reuse->score;
> +               else
> +                       hiscore =3D reuseport_compute_score(sk2,
> +                                                         inet_rcv_saddr_=
any(sk2));
> +
> +               if (hiscore <=3D score)
> +                       break;
> +
> +               sk_anchor =3D sk2;
> +       }
> +
> +       if (sk_anchor)
> +               __sk_nulls_insert_after_node_rcu(sk, &sk_anchor->sk_nulls=
_node);
> +       else
> +               __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> +}
> +
>  int __inet_hash(struct sock *sk, struct sock *osk)
>  {
>         struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);
> @@ -759,13 +797,14 @@ int __inet_hash(struct sock *sk, struct sock *osk)
>                 err =3D inet_reuseport_add_sock(sk, ilb2);
>                 if (err)
>                         goto unlock;
> -       }
> -       sock_set_flag(sk, SOCK_RCU_FREE);
> -       if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> -               sk->sk_family =3D=3D AF_INET6)
> -               __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
> -       else
> +
> +               sock_set_flag(sk, SOCK_RCU_FREE);
> +               inet_reuseport_hash_sock(sk, ilb2);
> +       } else {
> +               sock_set_flag(sk, SOCK_RCU_FREE);
>                 __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> +       }
> +
>         sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  unlock:
>         spin_unlock(&ilb2->lock);
> ---8<---
>
>
> Tested:
>
> ---8<---
> [root@fedora ~]# cat a.py
> from socket import *
>
> s1 =3D socket()
> s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> s1.setsockopt(SOL_SOCKET, SO_BINDTODEVICE, b'lo')
> s1.listen()
> s1.setblocking(False)
>
> s2 =3D socket()
> s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> s2.bind(s1.getsockname())
> s2.listen()
> s2.setblocking(False)
>
> for i in range(3):
>     c =3D socket()
>     c.connect(s1.getsockname())
>     try:
>         print("assigned properly:", s1.accept())
>     except:
>         print("wrong assignment")
> [root@fedora ~]# python3 a.py
> assigned properly: (<socket.socket fd=3D6, family=3D2, type=3D1, proto=3D=
0, laddr=3D('127.0.0.1', 36733), raddr=3D('127.0.0.1', 39478)>, ('127.0.0.1=
', 39478))
> assigned properly: (<socket.socket fd=3D5, family=3D2, type=3D1, proto=3D=
0, laddr=3D('127.0.0.1', 36733), raddr=3D('127.0.0.1', 39490)>, ('127.0.0.1=
', 39490))
> assigned properly: (<socket.socket fd=3D6, family=3D2, type=3D1, proto=3D=
0, laddr=3D('127.0.0.1', 36733), raddr=3D('127.0.0.1', 39506)>, ('127.0.0.1=
', 39506))
> ---8<---

