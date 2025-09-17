Return-Path: <netdev+bounces-224209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB029B823C4
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B64626B7C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3DE308F37;
	Wed, 17 Sep 2025 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dETDMApf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326A2F6594
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150447; cv=none; b=uJwEVKOReJkdGQujSOfjN07vEhRTu1AzmCCqZh7DcopBpgNUlemZGqk4C1kJ3ZMz0klrBYtPzRQTTK0cLRLXd9SAIvufehGvb5XJkNVfheDY0v/EndR+uRS2RNC8tDhS3yMDf5UXQH0Zsk1495+EeVoT3RLP6ioxnEeQibXOsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150447; c=relaxed/simple;
	bh=S3jrLtlcMzBvuyu0sINZRmo6ZeqNO8QhvGmFA/nre8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC4vcayGEyqWC8RtAhe+HzXOj3dZIhkki3l/OiLgEK9TVzNcTD4NFux8Z6uP0K7epshsjUMesjDilm93aVnOj1MR4vt0zA8FplPi8L7h4qzdtOaXWaGO3Tz8JzL7/Y80+HFOxb1P5I/w1UbHIaKsu2P8SoKRzdxo+i6c4m4MlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dETDMApf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-560885b40e2so4087e87.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758150443; x=1758755243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDsLp8i6pk3f7wj6TF4L7PgD7vKMWpVCl9g1m8uGMOw=;
        b=dETDMApfseXqPRsTDGt/qvzxnVXourLa5gkekVjMMTJ8YtLuWq7XBCMdSEcZ//nzMv
         qUsEkPVCnK93zJExlcID62YlMba/yKW5fzzG+YrptY9sEiOYkOvBtL1TJ3goLGE3QbWZ
         8RB4ltdgum1VeLNlnIlMsYiOKwS8QuyU+82oiZKbOe7VR1mngb57hqmF3EeIU+CmD2Ve
         BYesfLCo/hnNFXLBq7KvUKeOLzT3l2k6LMy6SKbdmerZj7VVfTzSrA+sTl9VeH6mezNl
         3ZtsDZmzQHhUDSo9KRhUVkwtS6gR1DDrybEy027+UJf5LJfNUQkvu8y15ayqY6ayllFp
         DHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150443; x=1758755243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDsLp8i6pk3f7wj6TF4L7PgD7vKMWpVCl9g1m8uGMOw=;
        b=Dh2P51UkmrNh6CW4Op4EIVMpPSoIl7oG9a9Rkt6n938gF2VWeoKne1NSn+vzDN7esl
         Hcrz2Z78piIGjP56TZuqVasgBUfWta4rBM9yhwOSJ2QCwNTU0i6u1cdxZlBddP5ZP8JU
         FN6VQIEcDJiThswLQ6I60N1nViLIDxz2vQs/P7XYv8ch6OteUeiUgAZ3LYjuFWcIlErS
         iBakom66jKf7PUSeIpdK1VskZPeyYmmR7utLJemj/aYbrcaOzB2Dc62lKxrEGXr5oKSW
         EhEC2rGiMoTcPvcfZCFlC2is/ti8IsbwwwgqZw0sii/iNvIWkZbGNfXoFgD0U6r0VYLr
         g8bA==
X-Forwarded-Encrypted: i=1; AJvYcCU1stjkNmDDULtG5DP2VX9gbDI8u96VhsgdjMUd23Ora6udFseOmi+t/lcz49RDzs1EZ12VFiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZu7lwEZN6apDlkTPTa+VM2L0dWkK5F8Dp3y8mVve5ZVWDcnb
	wWj8qgBNVyIucxrOVCg6g7w0S/nJYJoRxm01HvC5w0tVIUSuxpV8m2Sv5vieIx9MeZTBM40zuHa
	VSRoCvP640tVZizTkEKJUGvh6Tn0laEz/AhNY1AIn
X-Gm-Gg: ASbGncv1uC8Nl+oxShjlS7Dm3gXBFvAHQB5Wr8CWa78zRj81czW5kXBKHuc0VLWch5S
	FtFC9Yb5XJJAAjFP3/wUa6vyzRHH3ME2lzWqRpcnNbI/YHKay/sI1gY+pUqPWIU1TjKPElbkNM5
	FwhK98rVEANG3jxw7hRv8YA7D3RCN2lmGmJRxWafyLVSNvyt+rgOtDzKS1+qIG6LcdMn/K2LMgE
	ZBoB3yPO6CqbMnC67hO5UIqeeOd96QxXisONrcDt3jnVdbZ+0p5v9Z/WfDDUKQ=
X-Google-Smtp-Source: AGHT+IG3T19VMki7JRI65cCujBE6r2A9JlsYiin0vUxoc1mtJaVnauPFCusljRpzpLFUj4JjU7cRz0mnKdvO274X/CI=
X-Received: by 2002:a19:644b:0:b0:578:b6dd:55bd with SMTP id
 2adb3069b0e04-578b6dd575bmr73190e87.7.1758150443268; Wed, 17 Sep 2025
 16:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
 <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-3-c80d735bd453@meta.com>
 <aMSdT7lQDvLNEvsv@mini-arch>
In-Reply-To: <aMSdT7lQDvLNEvsv@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 17 Sep 2025 16:07:11 -0700
X-Gm-Features: AS18NWCZTaLPoL5R1lpvtP-Bki6oIiX2x8JL_5xSqIq2egAaN7Z0fu4kT7WPqUQ
Message-ID: <CAHS8izOg+XyjsWEN8o=yAbiPxvt2XoatVcM0WY2+NDyaDM4Dww@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: ethtool: prevent user from breaking
 devmem single-binding rule
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:23=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 09/11, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Prevent the user from breaking devmem's single-binding rule by rejectin=
g
> > ethtool TCP/IP requests to modify or delete rules that will redirect a
> > devmem socket to a queue with a different dmabuf binding. This is done
> > in a "best effort" approach because not all steering rule types are
> > validated.
> >
> > If an ethtool_rxnfc flow steering rule evaluates true for:
> >
> > 1) matching a devmem socket's ip addr
> > 2) selecting a queue with a different dmabuf binding
> > 3) is TCP/IP (v4 or v6)
> >
> > ... then reject the ethtool_rxnfc request with -EBUSY to indicate a
> > devmem socket is using the current rules that steer it to its dmabuf
> > binding.
> >
> > Non-TCP/IP rules are completely ignored, and if they do match a devmem
> > flow then they can still break devmem sockets. For example, bytes 0 and
> > 1 of L2 headers, etc... it is still unknown to me if these are possible
> > to evaluate at the time of the ethtool call, and so are left to future
> > work (or never, if not possible).
> >
> > FLOW_RSS rules which guide flows to an RSS context are also not
> > evaluated yet. This seems feasible, but the correct path towards
> > retrieving the RSS context and scanning the queues for dmabuf bindings
> > seems unclear and maybe overkill (re-use parts of ethtool_get_rxnfc?).
> >
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >  include/net/sock.h  |   1 +
> >  net/ethtool/ioctl.c | 144 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  net/ipv4/tcp.c      |   9 ++++
> >  net/ipv4/tcp_ipv4.c |   6 +++
> >  4 files changed, 160 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 304aad494764..73a1ff59dcde 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -579,6 +579,7 @@ struct sock {
> >               struct net_devmem_dmabuf_binding        *binding;
> >               atomic_t                                *urefs;
> >       } sk_user_frags;
> > +     struct list_head        sk_devmem_list;
> >
> >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> >       struct module           *sk_owner;
> > diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> > index 0b2a4d0573b3..99676ac9bbaa 100644
> > --- a/net/ethtool/ioctl.c
> > +++ b/net/ethtool/ioctl.c
> > @@ -29,11 +29,16 @@
> >  #include <linux/utsname.h>
> >  #include <net/devlink.h>
> >  #include <net/ipv6.h>
> > +#include <net/netdev_rx_queue.h>
> >  #include <net/xdp_sock_drv.h>
> >  #include <net/flow_offload.h>
> >  #include <net/netdev_lock.h>
> >  #include <linux/ethtool_netlink.h>
> >  #include "common.h"
> > +#include "../core/devmem.h"
> > +
> > +extern struct list_head devmem_sockets_list;
> > +extern spinlock_t devmem_sockets_lock;
> >
> >  /* State held across locks and calls for commands which have devlink f=
allback */
> >  struct ethtool_devlink_compat {
> > @@ -1169,6 +1174,142 @@ ethtool_get_rxfh_fields(struct net_device *dev,=
 u32 cmd, void __user *useraddr)
> >       return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NUL=
L);
> >  }
> >
> > +static bool
> > +__ethtool_rx_flow_spec_breaks_devmem_sk(struct ethtool_rx_flow_spec *f=
s,
> > +                                     struct net_device *dev,
> > +                                     struct sock *sk)
> > +{
> > +     struct in6_addr saddr6, smask6, daddr6, dmask6;
> > +     struct sockaddr_storage saddr, daddr;
> > +     struct sockaddr_in6 *src6, *dst6;
> > +     struct sockaddr_in *src4, *dst4;
> > +     struct netdev_rx_queue *rxq;
> > +     __u32 flow_type;
> > +
> > +     if (dev !=3D __sk_dst_get(sk)->dev)
> > +             return false;
> > +
> > +     src6 =3D (struct sockaddr_in6 *)&saddr;
> > +     dst6 =3D (struct sockaddr_in6 *)&daddr;
> > +     src4 =3D (struct sockaddr_in *)&saddr;
> > +     dst4 =3D (struct sockaddr_in *)&daddr;
> > +
> > +     if (sk->sk_family =3D=3D AF_INET6) {
> > +             src6->sin6_port =3D inet_sk(sk)->inet_sport;
> > +             src6->sin6_addr =3D inet6_sk(sk)->saddr;
> > +             dst6->sin6_port =3D inet_sk(sk)->inet_dport;
> > +             dst6->sin6_addr =3D sk->sk_v6_daddr;
> > +     } else {
> > +             src4->sin_port =3D inet_sk(sk)->inet_sport;
> > +             src4->sin_addr.s_addr =3D inet_sk(sk)->inet_saddr;
> > +             dst4->sin_port =3D inet_sk(sk)->inet_dport;
> > +             dst4->sin_addr.s_addr =3D inet_sk(sk)->inet_daddr;
> > +     }
> > +
> > +     flow_type =3D fs->flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RS=
S);
> > +
> > +     rxq =3D __netif_get_rx_queue(dev, fs->ring_cookie);
> > +     if (!rxq)
> > +             return false;
> > +
> > +     /* If the requested binding and the sk binding is equal then we k=
now
> > +      * this rule can't redirect to a different binding.
> > +      */
> > +     if (rxq->mp_params.mp_priv =3D=3D sk->sk_user_frags.binding)
> > +             return false;
> > +
> > +     /* Reject rules that redirect RX devmem sockets to a queue with a
> > +      * different dmabuf binding. Because these sockets are on the RX =
side
> > +      * (registered in the recvmsg() path), we compare the opposite
> > +      * endpoints: the socket source with the rule destination, and th=
e
> > +      * socket destination with the rule source.
> > +      *
> > +      * Only perform checks on the simplest rules to check, that is, I=
P/TCP
> > +      * rules. Flow hash options are not verified, so may still break =
TCP
> > +      * devmem flows in theory (VLAN tag, bytes 0 and 1 of L4 header,
> > +      * etc...). The author of this function was simply not sure how
> > +      * to validate these at the time of the ethtool call.
> > +      */
> > +     switch (flow_type) {
> > +     case IPV4_USER_FLOW: {
> > +             const struct ethtool_usrip4_spec *v4_usr_spec, *v4_usr_m_=
spec;
> > +
> > +             v4_usr_spec =3D &fs->h_u.usr_ip4_spec;
> > +             v4_usr_m_spec =3D &fs->m_u.usr_ip4_spec;
> > +
> > +             if (((v4_usr_spec->ip4src ^ dst4->sin_addr.s_addr) & v4_u=
sr_m_spec->ip4src) ||
> > +                 (v4_usr_spec->ip4dst ^ src4->sin_addr.s_addr) & v4_us=
r_m_spec->ip4dst) {
> > +                     return true;
> > +             }
> > +
> > +             return false;
> > +     }
> > +     case TCP_V4_FLOW: {
> > +             const struct ethtool_tcpip4_spec *v4_spec, *v4_m_spec;
> > +
> > +             v4_spec =3D &fs->h_u.tcp_ip4_spec;
> > +             v4_m_spec =3D &fs->m_u.tcp_ip4_spec;
> > +
> > +             if (((v4_spec->ip4src ^ dst4->sin_addr.s_addr) & v4_m_spe=
c->ip4src) ||
> > +                 ((v4_spec->ip4dst ^ src4->sin_addr.s_addr) & v4_m_spe=
c->ip4dst))
> > +                     return true;
> > +
>
> The ports need to be checked as well? But my preference overall would
> be to go back to checking this condition during recvmsg. We can pick
> some new obscure errno number to clearly explain to the user what
> happened. EPIPE or something similar, to mean that the socket is cooked.
> But let's see if Mina has a different opinion..

Sorry for the late reply.

IIU it looks to me like AF_XDP set the precedent that the user can
break the socket if they mess with the flow steering rules, and I'm
guessing io_uring zc does something similar. Only devmem tries to have
the socket work regardless on which rxqueue the incoming packets land
on, but that was predicated on the being able to do the tracking
efficiently which seems to not entirely be the case.

I think I'm OK with dropping this patch. We should probably add to the
docs the new restriction on devmem sockets. In our prod code we don't
reprogram rules while the socket is running. I don't think this will
break us, IDK if it will break anyone else, but it is unlikely.

--=20
Thanks,
Mina

