Return-Path: <netdev+bounces-146332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758849D2EA0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092151F22FDB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9CD14831D;
	Tue, 19 Nov 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYc2oZ0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF1150980
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043732; cv=none; b=m3PCzaztKIoYIwDjFJVOqXF6YkwNQtQW+TVFL0KOudDo3tbCQboRZgQl2kqlp0OTxeAJ1KiHzAYGYbzANejwAXarx25NkFBHtxkWuBcSfD4nDzI9UiT6Jpq/F5c02fiyZ/CbJyQ+LVUop7kLrCSx5BZhK5kkZ7aad6NUdn04DPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043732; c=relaxed/simple;
	bh=ZpWhC2HOn3WwyJwaXVi3/ygb9ufW+4160x24sOob5ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsDNw+JIsR18g0akmNWInnfc/OhIW9rnNYVuy9cHb2huvwl+uM7G1yW9t3J8PofEqAQjriooDTybziFgd/6hjr70RwgNOcr6+wh2ZmC2lBmzBQN2BcECbj9eHFxv5u9yczil7fpg+zjY1pG8vRRPOQ/xQ7VEHF0DYOzId5YGcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZYc2oZ0A; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so48416671fa.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 11:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732043728; x=1732648528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTg7O5MUyVWzLPb57sikHxysw+p6eGj+XCG04oB4uYw=;
        b=ZYc2oZ0ARAswmgIZfVfJUzzjlMx70qwm5zucj30U13mtgIvJuYYumzGhD1Jc4VKKYi
         CEK6k8pznhXiPJHtJM3f9MiFv6/66wYtDqWiCvX4xa0V0RQ6oBGb7ERMtI5z0/vW8AN/
         OKKU+SqKEoWf7iA0pVqrATcHrk5K/B7dzBNOYzdmgonLHv3mhsCaOdu4oo8fePwTBI8p
         y0CXZ50fy8tqmVtH7aHdSW8AFo1Qn/DFCXaA2TL13PKr7Itt2P8wN/2f9OjjhbNhuxrT
         /GoEpOw/eHjdV985z25srIoyF9Ode+JVhEPU70ZbZPdz3jJ1faD7ODQ5oRKKHRknMZf8
         uXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732043728; x=1732648528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTg7O5MUyVWzLPb57sikHxysw+p6eGj+XCG04oB4uYw=;
        b=RfEFEhskhHYCJYusdrhEvYMWffEiZGZwVj6j9ei8kFfZdVQuyLZl41M9D9La6IMwj8
         yLvncxA/AKg+h95qo6Ed6BKM32qO9X3GMFPnzl27aaKefPeOmZB50lfF8q3V0pU0LjQ/
         uq3dt4zOaEYv01KekDxHBK/Z5jQGwDNNQQLfHXyu3nAWP1JstSA+pAJf+J9oSaKn+uij
         yXixCnSgWx4Z2XGbMVPkJ4JWfZ/tk8UOQVNramYq3QIlQLgDniciEVz4rISXHJ5cFMQZ
         04Eia/1zCbZoop7wHsSFY1VR1xeVMj7HBBqytk2l8CaGg5bh52obTMAWIU8vPBXTC9ws
         dEzw==
X-Gm-Message-State: AOJu0Yxa0bSB/RAKdVhuP/E5ee6VPwa6OPTLSByLVaKNpZWVrS5vF7Ni
	LIvKZRWLIjMfpeGcuvBiNUG+e9FcxBB2Ac4+6ajOOwN6A73oSnUVIk7joFmMBGJVlAYQNTpUIdL
	LZzVKGX0BBkIm6rHnIHnVdOA+3pbdvXMdBN+q
X-Google-Smtp-Source: AGHT+IHHQxHQTxfE+wxJzUvMBNGvQ2vtZxsGH2Z4Sa1/K8nrp/J9v+77cXIAbvMLZV0Y1qP9fSjBwaL/UWAkftVQzQg=
X-Received: by 2002:a05:651c:199e:b0:2fa:d7ea:a219 with SMTP id
 38308e7fff4ca-2ff8dcb2d6emr1449831fa.37.1732043728092; Tue, 19 Nov 2024
 11:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112192249.341515-1-wangfe@google.com> <20241114102706.GB499069@unreal>
In-Reply-To: <20241114102706.GB499069@unreal>
From: Feng Wang <wangfe@google.com>
Date: Tue, 19 Nov 2024 11:15:16 -0800
Message-ID: <CADsK2K_Lu1HUyutODQceKWkGgjEYVwowYY4qDm20qyohOh_2DA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leonro@nvidia.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Sorry about the format issue,  I thought I used the correct format.
Now I try to do it again, if it still has an issue, please let me
know.
I will create a new patch based on your comments.

Thanks,

Feng

On Sat, Nov 16, 2024 at 10:22=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com=
> wrote:
>
> On Tue, Nov 12, 2024 at 11:22:49AM -0800, Feng Wang wrote:
> > From: wangfe <wangfe@google.com>
> >
> > In packet offload mode, append Security Association (SA) information
> > to each packet, replicating the crypto offload implementation.
> > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > from the validate_xmit_xfrm function, thus aligning with the existing
> > code path for packet offload mode.
> >
> > This SA info helps HW offload match packets to their correct security
> > policies. The XFRM interface ID is included, which is used in setups
> > with multiple XFRM interfaces where source/destination addresses alone
> > can't pinpoint the right policy.
> >
> > Enable packet offload mode on netdevsim and add code to check the XFRM
> > interface ID.
> >
> > Signed-off-by: wangfe <wangfe@google.com>
> > ---
> > v4: https://lore.kernel.org/all/20241104233251.3387719-1-wangfe@google.=
com/
> >   - Add offload flag check and only doing check when XFRM interface
> >     ID is non-zero.
> > v3: https://lore.kernel.org/all/20240822200252.472298-1-wangfe@google.c=
om/
> >   - Add XFRM interface ID checking on netdevsim in the packet offload
> >     mode.
> > v2:
> >   - Add why HW offload requires the SA info to the commit message
> > v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@google.=
com/
> > ---
> > ---
> >  drivers/net/netdevsim/ipsec.c     | 32 ++++++++++++++++++++++++++++++-
> >  drivers/net/netdevsim/netdevsim.h |  1 +
> >  net/xfrm/xfrm_output.c            | 21 ++++++++++++++++++++
> >  3 files changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipse=
c.c
> > index f0d58092e7e9..afd2005bf7a8 100644
> > --- a/drivers/net/netdevsim/ipsec.c
> > +++ b/drivers/net/netdevsim/ipsec.c
> > @@ -149,7 +149,8 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
> >               return -EINVAL;
> >       }
> >
> > -     if (xs->xso.type !=3D XFRM_DEV_OFFLOAD_CRYPTO) {
> > +     if (xs->xso.type !=3D XFRM_DEV_OFFLOAD_CRYPTO &&
> > +         xs->xso.type !=3D XFRM_DEV_OFFLOAD_PACKET) {
> >               NL_SET_ERR_MSG_MOD(extack, "Unsupported ipsec offload typ=
e");
> >               return -EINVAL;
> >       }
> > @@ -165,6 +166,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
> >       memset(&sa, 0, sizeof(sa));
> >       sa.used =3D true;
> >       sa.xs =3D xs;
> > +     sa.if_id =3D xs->if_id;
> >
> >       if (sa.xs->id.proto & IPPROTO_ESP)
> >               sa.crypt =3D xs->ealg || xs->aead;
> > @@ -224,10 +226,24 @@ static bool nsim_ipsec_offload_ok(struct sk_buff =
*skb, struct xfrm_state *xs)
> >       return true;
> >  }
> >
> > +static int nsim_ipsec_add_policy(struct xfrm_policy *policy,
> > +                              struct netlink_ext_ack *extack)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void nsim_ipsec_del_policy(struct xfrm_policy *policy)
> > +{
> > +}
> > +
> >  static const struct xfrmdev_ops nsim_xfrmdev_ops =3D {
> >       .xdo_dev_state_add      =3D nsim_ipsec_add_sa,
> >       .xdo_dev_state_delete   =3D nsim_ipsec_del_sa,
> >       .xdo_dev_offload_ok     =3D nsim_ipsec_offload_ok,
> > +
> > +     .xdo_dev_policy_add     =3D nsim_ipsec_add_policy,
> > +     .xdo_dev_policy_delete  =3D nsim_ipsec_del_policy,
> > +
> >  };
> >
> >  bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
> > @@ -237,6 +253,7 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_=
buff *skb)
> >       struct xfrm_state *xs;
> >       struct nsim_sa *tsa;
> >       u32 sa_idx;
> > +     struct xfrm_offload *xo;
> >
> >       /* do we even need to check this packet? */
> >       if (!sp)
> > @@ -272,6 +289,19 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk=
_buff *skb)
> >               return false;
> >       }
> >
> > +     if (xs->if_id) {
>
> If you are checking this, you will need to make sure that XFRM_XMIT is
> set when if_id !=3D 0. It is not how it is implemented now.
>
I will change the code to add the SA only when if_id is non-zero,
then it will make sense.

> > +             if (xs->if_id !=3D tsa->if_id) {
> > +                     netdev_err(ns->netdev, "unmatched if_id %d %d\n",
> > +                                xs->if_id, tsa->if_id);
> > +                     return false;
> > +             }
> > +             xo =3D xfrm_offload(skb);
> > +             if (!xo || !(xo->flags & XFRM_XMIT)) {
> > +                     netdev_err(ns->netdev, "offload flag missing or w=
rong\n");
> > +                     return false;
> > +             }
> > +     }
> > +
> >       ipsec->tx++;
> >
> >       return true;
> > diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/=
netdevsim.h
> > index bf02efa10956..4941b6e46d0a 100644
> > --- a/drivers/net/netdevsim/netdevsim.h
> > +++ b/drivers/net/netdevsim/netdevsim.h
> > @@ -41,6 +41,7 @@ struct nsim_sa {
> >       __be32 ipaddr[4];
> >       u32 key[4];
> >       u32 salt;
> > +     u32 if_id;
> >       bool used;
> >       bool crypt;
> >       bool rx;
> > diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> > index e5722c95b8bb..a12588e7b060 100644
> > --- a/net/xfrm/xfrm_output.c
> > +++ b/net/xfrm/xfrm_output.c
> > @@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *sk=
b)
> >       struct xfrm_state *x =3D skb_dst(skb)->xfrm;
> >       int family;
> >       int err;
> > +     struct xfrm_offload *xo;
> > +     struct sec_path *sp;
> >
> >       family =3D (x->xso.type !=3D XFRM_DEV_OFFLOAD_PACKET) ? x->outer_=
mode.family
> >               : skb_dst(skb)->ops->family;
> > @@ -728,6 +730,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *s=
kb)
> >                       kfree_skb(skb);
> >                       return -EHOSTUNREACH;
> >               }
> > +             sp =3D secpath_set(skb);
> > +             if (!sp) {
> > +                     XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> > +                     kfree_skb(skb);
> > +                     return -ENOMEM;
> > +             }
> > +
> > +             sp->olen++;
> > +             sp->xvec[sp->len++] =3D x;
> > +             xfrm_state_hold(x);
>
> Not an expert and just looked how XFRM_XMIT is assigned in other places,
> and simple skb_ext_add(skb, SKB_EXT_SEC_PATH) is used, why is it
> different here?
>
> The additional issue is that you are adding extension and flag to all
> offloaded packets, which makes me wonder what to do with this check in
> validate_xmit_xfrm():
>
Set the XFRM_XMIT flag makes validate_xmit_xfrm returns immediately
without need to do any further check.

>   136         /* The packet was sent to HW IPsec packet offload engine,
>   137          * but to wrong device. Drop the packet, so it won't skip
>   138          * XFRM stack.
>   139          */
>   140         if (x->xso.type =3D=3D XFRM_DEV_OFFLOAD_PACKET && x->xso.de=
v !=3D dev) {
>   141                 kfree_skb(skb);
>   142                 dev_core_stats_tx_dropped_inc(dev);
>   143                 return NULL;
>   144         }
>
> Also because you are adding it to all packets, you are adding extra
> overhead for all users, even these who didn't ask this if_id thing.
>
> And again, you should block creation of SAs with if_id !=3D 0 for already
> existing in-kernel IPsec implementations.
>
> Thanks
>
I will add SA information only when id is non-zero,  thus no overhead
for other uses, and no need to block creating of SAs with if_id is 0,

> > +
> > +             xo =3D xfrm_offload(skb);
> > +             if (!xo) {
> > +                     secpath_reset(skb);
> > +                     XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> > +                     kfree_skb(skb);
> > +                     return -EINVAL;
> > +             }
> > +             xo->flags |=3D XFRM_XMIT;
> >
> >               return xfrm_output_resume(sk, skb, 0);
> >       }
> > --
> > 2.47.0.277.g8800431eea-goog
> >
> >

