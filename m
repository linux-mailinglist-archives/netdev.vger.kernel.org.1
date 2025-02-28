Return-Path: <netdev+bounces-170615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06AA49554
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7197A9B99
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59725A330;
	Fri, 28 Feb 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF4Vv/l/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFD2580CE;
	Fri, 28 Feb 2025 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735486; cv=none; b=t9MN9fr3spAY5k09jwCVc0uuwvYbb0inB7E4x9l8UDISORDKW8XysQg4YAyXE6u3OMYu2anE39/oR8XnaY1l1xLBnvvj+l7QlRQVMpZq+bP0MYD30XOdo7KJ18Xqhuena5rMb2MsIdbKwRIt160V1KKjKZeGJtWdHg4XfPxenH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735486; c=relaxed/simple;
	bh=wCoAdbeX6SsMfq6oSGc/4uHSFzdb5+Tdx5YzVZ5IrcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9IEyEIlvCjaqgqGFcv13hcG2zDPClnkqXiDG7pZPPt2CprP2pL9GJc10Vts5yezJ3ON8ms14//j28tb9UwouDmQ5b0ZlFVIZX6PAICqB3gEZFoxTwv7pYlRTkS+9zBRBWTum2jnvr2RKv3fUHgLaIKDHN5tAhs3VW1VC/B3Sik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF4Vv/l/; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6f6ae4846c7so16936277b3.1;
        Fri, 28 Feb 2025 01:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740735483; x=1741340283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC0miZ0PpBEkIR2fGp0c3f/yHzMZejz8LlFF0rJC9zA=;
        b=XF4Vv/l/D8fkXrse/KOjUxhULRwO4XgHq92w+92JNP9kLGaK/Uj+5ZV5Zi02ubrQ/J
         ibF16NreOA9QuryDk4Mq+WRTZGKl4S+8UiXZy8je/X3vJ8LyBvO9/tNiPhM18Z/M/GlP
         UUQN+AtxJo1yusCywoIqutong2zNceAcFy7s41HJSJDyRHhUMwfx0HO0nuWFqbQ21XBS
         76CXo+oxMFfTbK3QuwnHZp6LUnOI8VsQoXbe/pm6K20fsq7gLmXwzeDs6W0dnIn6KHwg
         udyDLHFNaf83K+vnBTp2VnCwmbhY69L1bO0m7UZzL89Te2gZXzgYvpqAfKbmcBYZt59w
         dZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740735483; x=1741340283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC0miZ0PpBEkIR2fGp0c3f/yHzMZejz8LlFF0rJC9zA=;
        b=jvbQUzdQgKGrhYcOfKN4xxFhYoIuRYvNXE2gefAP5iCflREd+W8CqjCZqorQtu7n8B
         LriBJUJZK9ViTvC6uitsXDF+tlzGgo9OIcttbdLusvwtYVAdElBeTwDSmOnOt/aHr6FK
         70tm9bXd2q8UdxeaREWsSm+S8lcZeKZ0+KYSbXnrGrvo+Sk9mTcEYtWiCJFwvT78q9Za
         2gfkuNJ64dUMe+eTSkLTjQgtWCszZfq0kTNvll8Shq9VfJydIfUWjrB/Jg2pElMzR+No
         CVul/xJOlewo9D7lL+3TFbfHUNOfFJxVaVJK2TL+b/CjmCcU+MM2RoEYBTF/1odE3d9X
         /ZtA==
X-Forwarded-Encrypted: i=1; AJvYcCUzfFUTrBq9aR6d76w3R0df4rDvlD1XYjkPJwTy4pVJ0256jSLwikUPxKcnqOv92MvoOVyC0Xyw2LL2Jqs=@vger.kernel.org, AJvYcCW9ave03b9qd4qvKltKmvVF6veyG/c6QzXwo7beQbQa7dpMZd9c8bp9NqdVMMUABghV0FsKNRh7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SmcLn+f+SeqBoleWMHvfVvC18W2N0q/baj2V1JQw3q+1oshi
	TgnIsAeNAl6mZCCh8hSzLuebNGVRu+OCpfp9OS2yExcGGZ02XYqIwqB2EgXqC78pYooyQwf4FXm
	eZpdE0+iuX5O1JVtNmtRMHU2e0jk=
X-Gm-Gg: ASbGncuodWcbHS/ARC8uqrtjZEL3ZcyYsNAONASPAs1+pXFeMXpHnbpp8a42IHmnmUm
	aYb4+g/hpTmkM8xHA9GjSh39nvurA2lubvekufOuj6ixHv3m6MfJbioyJBVCAsbASvlaHMW/JKs
	LtpSbtr7k=
X-Google-Smtp-Source: AGHT+IFYBc9mBF2+hcruHXBRBZGAay0j/UWOuh49WMymR3mqjN77Pej7PFJzp66kmiHeeISMO8V/ziEucsZG2fJAoCA=
X-Received: by 2002:a05:690c:62c7:b0:6f7:56f7:239a with SMTP id
 00721157ae682-6fd4a0393c8mr33890727b3.5.1740735483025; Fri, 28 Feb 2025
 01:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227123137.138778-1-dongml2@chinatelecom.cn> <20250228002953.68029-1-kuniyu@amazon.com>
In-Reply-To: <20250228002953.68029-1-kuniyu@amazon.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 28 Feb 2025 17:36:31 +0800
X-Gm-Features: AQ5f1JqGwRejjTEqIrWvXRyj6JDmAU0cR3n3Exf1NHOkApj_RMrmLjCZaFKPVPA
Message-ID: <CADxym3a2mQnxbJgFCEoAb3U8s_xLAZmU9+bYN-a7mpHNLgjKVw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: ip: add sysctl_ip_reuse_exact_match
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dongml2@chinatelecom.cn, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kerneljasonxing@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com, yyd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 8:30=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Menglong Dong <menglong8.dong@gmail.com>
> Date: Thu, 27 Feb 2025 20:31:37 +0800
> > For now, the socket lookup will terminate if the socket is reuse port i=
n
> > inet_lhash2_lookup(), which makes the socket is not the best match.
> >
> > For example, we have socket1 listening on "0.0.0.0:1234" and socket2
> > listening on "192.168.1.1:1234", and both of them enabled reuse port. T=
he
> > socket1 will always be matched when a connection with the peer ip
> > "192.168.1.xx" comes if the socket1 is created later than socket2. This
> > is not expected, as socket2 has higher priority.
> >
> > This can cause unexpected behavior if TCP MD5 keys is used, as describe=
d
> > in Documentation/networking/vrf.rst -> Applications.
>
> Could you provide a minimal repro setup ?
> I somehow fail to reproduce the issue.
>

Thanks for your replying :/

Sorry that I described it wrong in the commit log. I problem is that:

socket1 and socket2 both listen on "0.0.0.0:1234", but socket1 bind
on "eth0". We create socket1 first, and then socket2. Then, all connections
will goto socket2, which is not expected, as socket1 has higher priority.

You can reproduce it with following code:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

#include <linux/ip.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>

int main(int argc, char** argv)
{
    int listenfd, connfd;
    struct sockaddr_in servaddr, client;
    socklen_t clen;
    char buff[4096];
    int one =3D 1;
    int n;

    if ((listenfd =3D socket(AF_INET, SOCK_STREAM, 0)) =3D=3D -1) {
        printf("create socket error: %s(errno: %d)\n", strerror(errno), err=
no);
        exit(0);
    }
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family =3D AF_INET;
    servaddr.sin_addr.s_addr =3D htonl(INADDR_ANY);
    servaddr.sin_port =3D htons(6666);
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one));
    if (bind(listenfd, (struct sockaddr*)&servaddr, sizeof(servaddr)) =3D=
=3D -1) {
        printf("bind socket error: %s(errno: %d)\n", strerror(errno), errno=
);
        exit(0);
    }

    if (argc > 1) {
        setsockopt(listenfd, SOL_SOCKET, SO_BINDTODEVICE, argv[1],
               strlen(argv[1]) + 1);
    }

    if (listen(listenfd, 10) =3D=3D -1) {
        printf("listen socket error: %s(errno: %d)\n", strerror(errno), err=
no);
        exit(0);
    }
    printf("=3D=3D=3D=3D=3D=3Dwaiting for client's request=3D=3D=3D=3D=3D=
=3D\n");
    while (1) {
        clen =3D sizeof(struct sockaddr);
        if ((connfd =3D accept(listenfd, (struct sockaddr*)&client,
&clen)) =3D=3D -1) {
            printf("accept socket error: %s(errno: %d)",
strerror(errno), errno);
            continue;
        }

        printf("recv msg from client: %x\n", client.sin_addr.s_addr);
    }
    close(listenfd);
    return 0;
}


>
> > Introduce the sysctl_ip_reuse_exact_match to make it find a best matche=
d
> > socket when reuse port is used.
>
> I think we should not introduce a new sysctl knob and an extra lookup,
> rather we can solve that in __inet_hash() taking d894ba18d4e4
> ("soreuseport: fix ordering for mixed v4/v6 sockets") further.
>
> Could you test this patch ?

Sorry for my incorrect commit log, and this patch can't solve
the problem that I had. Maybe we can compare the score of
the socket in the list when we insert the socket to the listening
hash table to place it in a proper place. However, it will make
the inserting complex :/

Thanks!
Menglong Dong

>
> ---8<---
> $ git show
> commit 4dbc44a153afe51a2b2698a55213e625a02e23c8
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Thu Feb 27 19:53:43 2025 +0000
>
>     tcp: Place non-wildcard sockets before wildcard ones in lhash2.
>
>     Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
> index 5eea47f135a4..115248bfe463 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -136,6 +136,9 @@ struct inet_bind_hashbucket {
>  struct inet_listen_hashbucket {
>         spinlock_t              lock;
>         struct hlist_nulls_head nulls_head;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       struct hlist_nulls_node *wildcard_node;
> +#endif
>  };
>
>  /* This is for listening sockets, thus all sockets which possess wildcar=
ds. */
> diff --git a/include/net/sock.h b/include/net/sock.h
> index efc031163c33..4e8e10d2067b 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -863,6 +863,16 @@ static inline void __sk_nulls_add_node_tail_rcu(stru=
ct sock *sk, struct hlist_nu
>         hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
>  }
>
> +static inline void __sk_nulls_add_node_before_rcu(struct sock *sk, struc=
t hlist_nulls_node *next)
> +{
> +       struct hlist_nulls_node *n =3D &sk->sk_nulls_node;
> +
> +       WRITE_ONCE(n->pprev, next->pprev);
> +       WRITE_ONCE(n->next, next);
> +       WRITE_ONCE(next->pprev, &n->next);
> +       WRITE_ONCE(*(n->pprev), n);
> +}
> +
>  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_n=
ulls_head *list)
>  {
>         sock_hold(sk);
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ecda4c65788c..acfb693bb1d4 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -729,6 +729,7 @@ int __inet_hash(struct sock *sk, struct sock *osk)
>  {
>         struct inet_hashinfo *hashinfo =3D tcp_or_dccp_get_hashinfo(sk);
>         struct inet_listen_hashbucket *ilb2;
> +       bool add_tail =3D false;
>         int err =3D 0;
>
>         if (sk->sk_state !=3D TCP_LISTEN) {
> @@ -737,21 +738,47 @@ int __inet_hash(struct sock *sk, struct sock *osk)
>                 local_bh_enable();
>                 return 0;
>         }
> +
>         WARN_ON(!sk_unhashed(sk));
>         ilb2 =3D inet_lhash2_bucket_sk(hashinfo, sk);
>
>         spin_lock(&ilb2->lock);
> +
>         if (sk->sk_reuseport) {
>                 err =3D inet_reuseport_add_sock(sk, ilb2);
>                 if (err)
>                         goto unlock;
> +
> +               if (inet_rcv_saddr_any(sk))
> +                       add_tail =3D true;
>         }
> +
>         sock_set_flag(sk, SOCK_RCU_FREE);
> -       if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> -               sk->sk_family =3D=3D AF_INET6)
> -               __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
> -       else
> -               __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +       if (sk->sk_family =3D=3D AF_INET6) {
> +               if (add_tail || !ilb2->wildcard_node)
> +                       __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_hea=
d);
> +               else
> +                       __sk_nulls_add_node_before_rcu(sk, ilb2->wildcard=
_node);
> +       } else
> +#endif
> +       {
> +               if (!add_tail)
> +                       __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> +#if IS_ENABLED(CONFIG_IPV6)
> +               else if (ilb2->wildcard_node)
> +                       __sk_nulls_add_node_before_rcu(sk, ilb2->wildcard=
_node);
> +#endif
> +               else
> +                       __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_hea=
d);
> +       }
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +       if (add_tail && (sk->sk_family =3D=3D AF_INET || !ilb2->wildcard_=
node))
> +               ilb2->wildcard_node =3D &sk->sk_nulls_node;
> +#endif
> +
>         sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  unlock:
>         spin_unlock(&ilb2->lock);
> @@ -794,6 +821,15 @@ void inet_unhash(struct sock *sk)
>                 if (rcu_access_pointer(sk->sk_reuseport_cb))
>                         reuseport_stop_listen_sock(sk);
>
> +#if IS_ENABLED(CONFIG_IPV6)
> +               if (&sk->sk_nulls_node =3D=3D ilb2->wildcard_node) {
> +                       if (is_a_nulls(sk->sk_nulls_node.next))
> +                               ilb2->wildcard_node =3D NULL;
> +                       else
> +                               ilb2->wildcard_node =3D sk->sk_nulls_node=
.next;
> +               }
> +#endif
> +
>                 __sk_nulls_del_node_init_rcu(sk);
>                 sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>                 spin_unlock(&ilb2->lock);
> @@ -1183,6 +1219,9 @@ static void init_hashinfo_lhash2(struct inet_hashin=
fo *h)
>                 spin_lock_init(&h->lhash2[i].lock);
>                 INIT_HLIST_NULLS_HEAD(&h->lhash2[i].nulls_head,
>                                       i + LISTENING_NULLS_BASE);
> +#if IS_ENABLED(CONFIG_IPV6)
> +               h->lhash2[i].wildcard_node =3D NULL;
> +#endif
>         }
>  }
>
> ---8<---

