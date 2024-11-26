Return-Path: <netdev+bounces-147528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886719D9F0C
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A48165520
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6181DEFE1;
	Tue, 26 Nov 2024 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjKBS43O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B3160884
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732658076; cv=none; b=sYWidOzE9anBeBQHMh2t12jaSYE9sUdx94aebHxV6VAYswpTYJpTBvNRsl8ziMCtuYqVivl+Dh6fStOv45zQpPou+hiFgxApnfbdaJy7MAXzK/1B2inuvPCx0IRnnNi//EQ7yshvW4MJCafpubDTiSPzj6YEXxY43frsvMVPWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732658076; c=relaxed/simple;
	bh=AFrpQREeKJUVEInX3v0hu0yPGLZCzbOkvDsefsWIZRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmJv94xMG7pM8BT3z7m+tMXGU/rGJLLu+GJvlonY0f0COfj4XN9VR4ho3HRf4RDbHfa4wlwLx9p3EhN3K3pAp4XPj9U7mKwrtK9zSOsTEZUNBWw3bMiBX9P0Ok5VsvRl3HVHYYd4OhKu1STQbMCA13pk9cBdEByHybvbOrs5HGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjKBS43O; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de880c77eso1824650e87.1
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732658072; x=1733262872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JjJ3dt95EA7mVzRH47zkdO0ubeMUr3AwSruH0KqrE0=;
        b=AjKBS43ONDAlXunyVnyVD/LyW0NnIPCOO5Q5wkvIZksrQaGZVhHWMsPkgh/SazFxWp
         s3Bsvwm/kLVOJrXFVUdlcnwU1PzVFZ1T4PJL/Eep4RzHee7/E7bgTtbGckmTEa8KvInO
         L3icSkHlebFx0tMwmCj4Obf6Il16nSZR7R+XRXopj+Ge/byDvZgra5t5M8CGb7GtzTh1
         7acADZAQvd6CdivfJKHkVWWu4dmdfVHecZJBK40Q/NpudliSUkFq6CB8TyJVk9uFpLqI
         pvNUgudmGViYKNnihzSbXvVAvpnm6gd8x48pOp1su/sR7svQ5BmRyNrllw0ZJgASciOz
         NUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732658072; x=1733262872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JjJ3dt95EA7mVzRH47zkdO0ubeMUr3AwSruH0KqrE0=;
        b=aNjnTiShs3POXPgrX14nYF5vaiefDWBK3x1zC+KS//ByTy+LLQ3kLkhBtNw1g1nlXK
         +PsVVHUG/6Hl84QMfCJloez6j8vhI5/9QY+kXcULPIvU40CCWwtVNKTaWVgxRSUzGZVX
         3dOoxdcfcaaxadXVWEgYtw3/PXoUIkdIelpRnh38BSoc0fIpfXNM0dv7Pi6xG61fjhkG
         DLnXHVeWJsNDogMu/RN3O2VYncEEqVzlXiP9iCkD3b9xjECOkMexh07yKNX6QXCrBItN
         2RlT4SFs9NhDyVXuu051ghSSzbOPzdUOTmrQscEFwlVHbg++ilyFfxLNkNL6QvpBO38n
         yg2g==
X-Gm-Message-State: AOJu0YyvLs/LN/m+tDXhl4vC9oWPxjtfoaaWbgsNYc0beq8Lbyvoo+/y
	ED2JAiDI1Nu3IbSFd75TxlXW6varDX0D3bl0HVbFwkbua3VgG2wCGAHnYlDyFY8/lgXvbU+jlLM
	wqZ7qMRSzLBcqOWhw0iYMjt81Ows2AJipsBlL
X-Gm-Gg: ASbGnctkI5rGPA/XezoAtZ+WQM7HeFF78I/23JWblFHSN+O/sCv74WhQdUCT4tebpOs
	Xo/dpC3PnMkoHoaav74mkQkf6FV2IioQQ6UoZUv/bOk6W6K8foz5PvHPhEKuD
X-Google-Smtp-Source: AGHT+IHCbjVaptbAWeeDThZP7HQmyjN3jASLy5b8Aa61s+xL4PlW7WDJGvuhUh76wWfvqd468h6WQ9rfT8Xjwyr0LcE=
X-Received: by 2002:a05:6512:104f:b0:53d:a024:ddb2 with SMTP id
 2adb3069b0e04-53df00d3c06mr359694e87.24.1732658071850; Tue, 26 Nov 2024
 13:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121215257.3879343-2-wangfe@google.com> <20241124081549.GD160612@unreal>
In-Reply-To: <20241124081549.GD160612@unreal>
From: Feng Wang <wangfe@google.com>
Date: Tue, 26 Nov 2024 13:54:20 -0800
Message-ID: <CADsK2K_na0Ugwv2PPT_s4oHSAx2rtZvtYY58C4MQkjE6G5y4Ew@mail.gmail.com>
Subject: Re: [PATCH v6] xfrm: add SA information to the offloaded packet when
 if_id is set
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please see embedded answers below. Thanks.

On Sun, Nov 24, 2024 at 12:15=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Thu, Nov 21, 2024 at 09:52:58PM +0000, Feng Wang wrote:
> > In packet offload mode, append Security Association (SA) information
> > to each packet, replicating the crypto offload implementation.
>
> Please write explicitly WHY "replicating ..." is right thing to do and
> why current code is not enough.
>
> The best thing will be to see how packet traversal in the netdev stack
> till it gets to the wire.
>
I explained why doing this change in the third paragraph based on
Steffen's suggestion, I can move it here.

> >
> > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > from the validate_xmit_xfrm function, thus aligning with the existing
> > code path for packet offload mode.
>
> This chunk was dropped mysteriously. It doesn't exist in the current patc=
h.
> What type of testing did you perform? Can you please add it to the
> commit message?
>
I didn't drop any code in the current patch,  I created a test and the
patch will be upstreamed after this change is checked in.
The link is https://lore.kernel.org/all/20241104233315.3387982-1-wangfe@goo=
gle.com/
Do I need to add the test details in this commit?

> According to the strongswan documentation https://docs.strongswan.org/doc=
s/5.9/features/routeBasedVpn.html,
> "Traffic that=E2=80=99s routed to an XFRM interface, while no policies an=
d SAs with matching interface ID exist,
> will be dropped by the kernel."
>
> It looks like the current code doesn't handle this case, does it?
>
The current code will drop the packet if the interface ID is not matched.

> >
> > This SA info helps HW offload match packets to their correct security
> > policies. The XFRM interface ID is included, which is used in setups
> > with multiple XFRM interfaces where source/destination addresses alone
> > can't pinpoint the right policy.
>
> Please add an examples of iproute2 commands on how it is achieved,
> together with tcprdump examples of before and after.
>
A test patch will be upstreamed.  There is no need for tcpdump because
this change won't change packet content.

> >
> > Enable packet offload mode on netdevsim and add code to check the XFRM
> > interface ID.
>
> You still need to add checks in existing drivers to make sure that SAs
> with if_id won't be offloaded.
>
There is no existing driver supporting packet offload mode except netdevsim=
.

> IMHO, netdevsim implementation is not a replacement to support
> out-of-tree code, but a way to help testing features without need to
> have complex HW, but still for the code which is in-tree.
>
We discussed this before, and I followed your and Steffen's comment to
add netdevsim simulation code to satisfy the requirement.

> Thanks
>

> >
> > Signed-off-by: wangfe <wangfe@google.com>
> > ---
> > v6: https://lore.kernel.org/all/20241119220411.2961121-1-wangfe@google.=
com/
> >   - Fix code style to follow reverse x-mas tree order declaration.
> > v5: https://lore.kernel.org/all/20241112192249.341515-1-wangfe@google.c=
om/
> >   - Add SA information only when XFRM interface ID is non-zero.
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
> >  net/xfrm/xfrm_output.c            | 22 +++++++++++++++++++++
> >  3 files changed, 54 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipse=
c.c
> > index 88187dd4eb2d..5677b2acf9c0 100644
> > --- a/drivers/net/netdevsim/ipsec.c
> > +++ b/drivers/net/netdevsim/ipsec.c
> > @@ -153,7 +153,8 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
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
> > @@ -169,6 +170,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
> >       memset(&sa, 0, sizeof(sa));
> >       sa.used =3D true;
> >       sa.xs =3D xs;
> > +     sa.if_id =3D xs->if_id;
> >
> >       if (sa.xs->id.proto & IPPROTO_ESP)
> >               sa.crypt =3D xs->ealg || xs->aead;
> > @@ -227,16 +229,31 @@ static bool nsim_ipsec_offload_ok(struct sk_buff =
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
> >  {
> >       struct sec_path *sp =3D skb_sec_path(skb);
> >       struct nsim_ipsec *ipsec =3D &ns->ipsec;
> > +     struct xfrm_offload *xo;
> >       struct xfrm_state *xs;
> >       struct nsim_sa *tsa;
> >       u32 sa_idx;
> > @@ -275,6 +292,19 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk=
_buff *skb)
> >               return false;
> >       }
> >
> > +     if (xs->if_id) {
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
> > index e5722c95b8bb..3e9a1b17f37e 100644
> > --- a/net/xfrm/xfrm_output.c
> > +++ b/net/xfrm/xfrm_output.c
> > @@ -704,6 +704,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *sk=
b)
> >  {
> >       struct net *net =3D dev_net(skb_dst(skb)->dev);
> >       struct xfrm_state *x =3D skb_dst(skb)->xfrm;
> > +     struct xfrm_offload *xo;
> > +     struct sec_path *sp;
> >       int family;
> >       int err;
> >
> > @@ -728,7 +730,27 @@ int xfrm_output(struct sock *sk, struct sk_buff *s=
kb)
> >                       kfree_skb(skb);
> >                       return -EHOSTUNREACH;
> >               }
> > +             if (x->if_id) {
> > +                     sp =3D secpath_set(skb);
> > +                     if (!sp) {
> > +                             XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERRO=
R);
> > +                             kfree_skb(skb);
> > +                             return -ENOMEM;
> > +                     }
> > +
> > +                     sp->olen++;
> > +                     sp->xvec[sp->len++] =3D x;
> > +                     xfrm_state_hold(x);
> >
> > +                     xo =3D xfrm_offload(skb);
> > +                     if (!xo) {
> > +                             secpath_reset(skb);
> > +                             XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERRO=
R);
> > +                             kfree_skb(skb);
> > +                             return -EINVAL;
> > +                     }
> > +                     xo->flags |=3D XFRM_XMIT;
> > +             }
> >               return xfrm_output_resume(sk, skb, 0);
> >       }
> >
> > --
> > 2.47.0.371.ga323438b13-goog
> >
> >

