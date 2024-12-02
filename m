Return-Path: <netdev+bounces-148207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7429E0D2B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8F2165034
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B271DE898;
	Mon,  2 Dec 2024 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZkHnQUE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759701DE4C3
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172090; cv=none; b=PFcATASp5hNzitSMn+hm1RuXcK+7Pdx+YeBMOI3jG76ep7iXZ3i32kcwa6mEcZq2O4iwyPDRCk6ZxH02wPvP3YafNmnLPH23pCukqIF78BAQkSlFGsUCh0/Hn+z03tPyNcwpncA1taj7KL+UkzZc+vdzqRmai8QVr3QMcl8xnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172090; c=relaxed/simple;
	bh=KIdbkdIFaXSbJKucAAX9IC7JO4pcKcJsK9zYppY8ifU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1loGBuBtP+RtZGMyO1XCHWc4XLaVM37+mwLlF559md+lxkcZcRE5ESTLlFWoFAdQR0ezwDDlCNzfEnDWB2kd1oQF2EA9s4tsHE8EuNR60cJYF2ATyL7wX6al3JCpIkqA9N+6glxRBkjlreS0aMpenEO8knr9+LHV/+I9LM5NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZkHnQUE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso1371040a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733172087; x=1733776887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L6ohtx3ayyqt3b2ZEfRw+gjXygT94F18Gbl8j2AkM4=;
        b=LZkHnQUEtEgpE1URIa/FBKxFC4P/7iHpEovDKi+JvEWL/X9FBnhAox7wxyTSNxUXns
         hSdczsA3hwUavNjD1jofhkoFdm3OXAuXu1l9c6wJ6V0R+mRW9mlb3a1j+mbzd2nQUrCv
         dv1OVru3NZC3nFrwI19Tr7sV0JT5oV/dk9Dwqd6r8mX+x/l021LrbSpQ26kckT+DQGfm
         t6Ax8tWqHRBWOtRwX0GlBagELaGW34Gpb/3b4ppXDNy5nKb2TMPoPAmEE24H8ppJUtln
         gwtmj+tpFIzu/L38UnhthINEhNOjJnD6I7uxmvT4J7i+U1Zx8YGIkPn9mxfLtB0voFcw
         hwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172087; x=1733776887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L6ohtx3ayyqt3b2ZEfRw+gjXygT94F18Gbl8j2AkM4=;
        b=vZSxZKGFF0iovcCplbmPzSxJ/dY+Ju+rxrbhkgJg0AKPFouTb0U4F3xNMGK2W6lZZF
         hKOgdj/5l0bWQWFBlctnvqcpMPlAzivSKzt2FsZoWZItnwF4D7XUHQ+j0qqHcySdmPvm
         TiwSf0AkvysKQ9KOrVjIEwnxgDeuU8bBwAIzOlf9Ae3MqAU3zR5m37rt5ikVUBSi6CPx
         PrrMsvBxvUY5xGa9H2CM9htYJ0mdgnlskhF+F9LEdD6ZB9olmq958iZXdqM0k3PTm7Rt
         vAeCZFTjkwqG7Afpz8igMF0Z58aCJSHsG+yNC8SpMZViNUc1BF7BStWdRN5ShyF+HomJ
         34+w==
X-Gm-Message-State: AOJu0YyOLEi7GJJcQDEd8NCgzaeO1y56yICyow/1zmo2UPMZZ+2AHxLg
	DCMRiy2N74HyMINsrNrebGtf8Hf/F3a587Gfx8XgRhWwkKPx+Y/A7cPx6GZKyuPzuoK3Qfk4sU6
	Rcedmd2seAe01Ek48bZAJHPKQcz3PJ4vIyrs8
X-Gm-Gg: ASbGncvsbRUZcy5vNCQ/EzZQmehfnaLjWLoJfiHzGtfISjoLkIJdNqnmXrl96VI3Feo
	ZKCZHpyKIfbZzKOmlMM3dOgqivx0UsVKtgmSnZ38vg5u5m9uC07r1G1SPfGKdCbJ7
X-Google-Smtp-Source: AGHT+IHFntYZBd9ovLWsYLl4dLpxLDVlUqdEtN5/2Am+3kXZvUTo5iN5wIVX1pBTykkhvbfSK6wipQoZm2mHkfJq9gE=
X-Received: by 2002:a17:906:23ea:b0:aa5:3ce5:1e2b with SMTP id
 a640c23a62f3a-aa581065a6amr2096345866b.60.1733172086487; Mon, 02 Dec 2024
 12:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121215257.3879343-2-wangfe@google.com> <20241124081549.GD160612@unreal>
 <CADsK2K_na0Ugwv2PPT_s4oHSAx2rtZvtYY58C4MQkjE6G5y4Ew@mail.gmail.com> <20241127090032.GD1245331@unreal>
In-Reply-To: <20241127090032.GD1245331@unreal>
From: Feng Wang <wangfe@google.com>
Date: Mon, 2 Dec 2024 12:41:14 -0800
Message-ID: <CADsK2K85L8Q3Q26w2n3WBDpN4VhY0jB8nQgXOhFmutwEHqk60g@mail.gmail.com>
Subject: Re: [PATCH v6] xfrm: add SA information to the offloaded packet when
 if_id is set
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updated the comments, thanks.

On Wed, Nov 27, 2024 at 1:00=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Nov 26, 2024 at 01:54:20PM -0800, Feng Wang wrote:
> > Please see embedded answers below. Thanks.
> >
> > On Sun, Nov 24, 2024 at 12:15=E2=80=AFAM Leon Romanovsky <leon@kernel.o=
rg> wrote:
> > >
> > > On Thu, Nov 21, 2024 at 09:52:58PM +0000, Feng Wang wrote:
> > > > In packet offload mode, append Security Association (SA) informatio=
n
> > > > to each packet, replicating the crypto offload implementation.
> > >
> > > Please write explicitly WHY "replicating ..." is right thing to do an=
d
> > > why current code is not enough.
> > >
> > > The best thing will be to see how packet traversal in the netdev stac=
k
> > > till it gets to the wire.
> > >
> > I explained why doing this change in the third paragraph based on
> > Steffen's suggestion, I can move it here.
>
> Steffen didn't say "let's replicate ...". All that he said that he wants
> to see API complete.
>
I will move the third paragraph here to explain the reason.

> >
> > > >
> > > > The XFRM_XMIT flag is set to enable packet to be returned immediate=
ly
> > > > from the validate_xmit_xfrm function, thus aligning with the existi=
ng
> > > > code path for packet offload mode.
> > >
> > > This chunk was dropped mysteriously. It doesn't exist in the current =
patch.
> > > What type of testing did you perform? Can you please add it to the
> > > commit message?
> > >
> > I didn't drop any code in the current patch,  I created a test and the
> > patch will be upstreamed after this change is checked in.
> > The link is https://lore.kernel.org/all/20241104233315.3387982-1-wangfe=
@google.com/
> > Do I need to add the test details in this commit?
>
> No, you need to create test that knows to handle case with and without
> if_id properly. You should add test to the patchset as first patch and
> implementation as second one.
>
I probably don't fully understand what you mean. Before my CL, there
is no handling of if_id. My CL adds this handling and my test shows
how to test it.
What does a test without if_id handling show? Show the code not unable
to handle if_id?  And I checked other features, they only add a test
after a new feature is checked in.

> >
> > > According to the strongswan documentation https://docs.strongswan.org=
/docs/5.9/features/routeBasedVpn.html,
> > > "Traffic that=E2=80=99s routed to an XFRM interface, while no policie=
s and SAs with matching interface ID exist,
> > > will be dropped by the kernel."
> > >
> > > It looks like the current code doesn't handle this case, does it?
> > >
> > The current code will drop the packet if the interface ID is not matche=
d.
>
> How? Who will drop it?
>
The main function is xfrm_policy_match(), you can trace it.
> >
> > > >
> > > > This SA info helps HW offload match packets to their correct securi=
ty
> > > > policies. The XFRM interface ID is included, which is used in setup=
s
> > > > with multiple XFRM interfaces where source/destination addresses al=
one
> > > > can't pinpoint the right policy.
> > >
> > > Please add an examples of iproute2 commands on how it is achieved,
> > > together with tcprdump examples of before and after.
> > >
> > A test patch will be upstreamed.  There is no need for tcpdump because
> > this change won't change packet content.
>
> Of course it is needed, it will show that without if_id patch packets
> are unencrypted, while after applying the patch, we will see encrypted
> packets.
>
The netdevsim code doesn't really change the packet content because
there is no real hardware encryption engine.
So there is no encrypted packet.

> >
> > > >
> > > > Enable packet offload mode on netdevsim and add code to check the X=
FRM
> > > > interface ID.
> > >
> > > You still need to add checks in existing drivers to make sure that SA=
s
> > > with if_id won't be offloaded.
> > >
> > There is no existing driver supporting packet offload mode except netde=
vsim.
>
> It is not true, please check the code.
>
I have searched the tree,  and there is no packet offload mode driver
implementation.  If you know it, please let me know.
> >
> > > IMHO, netdevsim implementation is not a replacement to support
> > > out-of-tree code, but a way to help testing features without need to
> > > have complex HW, but still for the code which is in-tree.
> > >
> > We discussed this before, and I followed your and Steffen's comment to
> > add netdevsim simulation code to satisfy the requirement.
>
> I didn't suggest netdevsim and always requested to upstream real driver.
> Netdevsim is Steffen's suggestion to overcome kernel rule of no adding
> code without in-kernel users.
>
> Thanks
>
> >
> > > Thanks
> > >
> >
> > > >
> > > > Signed-off-by: wangfe <wangfe@google.com>
> > > > ---
> > > > v6: https://lore.kernel.org/all/20241119220411.2961121-1-wangfe@goo=
gle.com/
> > > >   - Fix code style to follow reverse x-mas tree order declaration.
> > > > v5: https://lore.kernel.org/all/20241112192249.341515-1-wangfe@goog=
le.com/
> > > >   - Add SA information only when XFRM interface ID is non-zero.
> > > > v4: https://lore.kernel.org/all/20241104233251.3387719-1-wangfe@goo=
gle.com/
> > > >   - Add offload flag check and only doing check when XFRM interface
> > > >     ID is non-zero.
> > > > v3: https://lore.kernel.org/all/20240822200252.472298-1-wangfe@goog=
le.com/
> > > >   - Add XFRM interface ID checking on netdevsim in the packet offlo=
ad
> > > >     mode.
> > > > v2:
> > > >   - Add why HW offload requires the SA info to the commit message
> > > > v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@goo=
gle.com/
> > > > ---
> > > > ---
> > > >  drivers/net/netdevsim/ipsec.c     | 32 +++++++++++++++++++++++++++=
+++-
> > > >  drivers/net/netdevsim/netdevsim.h |  1 +
> > > >  net/xfrm/xfrm_output.c            | 22 +++++++++++++++++++++
> > > >  3 files changed, 54 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/=
ipsec.c
> > > > index 88187dd4eb2d..5677b2acf9c0 100644
> > > > --- a/drivers/net/netdevsim/ipsec.c
> > > > +++ b/drivers/net/netdevsim/ipsec.c
> > > > @@ -153,7 +153,8 @@ static int nsim_ipsec_add_sa(struct xfrm_state =
*xs,
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > -     if (xs->xso.type !=3D XFRM_DEV_OFFLOAD_CRYPTO) {
> > > > +     if (xs->xso.type !=3D XFRM_DEV_OFFLOAD_CRYPTO &&
> > > > +         xs->xso.type !=3D XFRM_DEV_OFFLOAD_PACKET) {
> > > >               NL_SET_ERR_MSG_MOD(extack, "Unsupported ipsec offload=
 type");
> > > >               return -EINVAL;
> > > >       }
> > > > @@ -169,6 +170,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state =
*xs,
> > > >       memset(&sa, 0, sizeof(sa));
> > > >       sa.used =3D true;
> > > >       sa.xs =3D xs;
> > > > +     sa.if_id =3D xs->if_id;
> > > >
> > > >       if (sa.xs->id.proto & IPPROTO_ESP)
> > > >               sa.crypt =3D xs->ealg || xs->aead;
> > > > @@ -227,16 +229,31 @@ static bool nsim_ipsec_offload_ok(struct sk_b=
uff *skb, struct xfrm_state *xs)
> > > >       return true;
> > > >  }
> > > >
> > > > +static int nsim_ipsec_add_policy(struct xfrm_policy *policy,
> > > > +                              struct netlink_ext_ack *extack)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void nsim_ipsec_del_policy(struct xfrm_policy *policy)
> > > > +{
> > > > +}
> > > > +
> > > >  static const struct xfrmdev_ops nsim_xfrmdev_ops =3D {
> > > >       .xdo_dev_state_add      =3D nsim_ipsec_add_sa,
> > > >       .xdo_dev_state_delete   =3D nsim_ipsec_del_sa,
> > > >       .xdo_dev_offload_ok     =3D nsim_ipsec_offload_ok,
> > > > +
> > > > +     .xdo_dev_policy_add     =3D nsim_ipsec_add_policy,
> > > > +     .xdo_dev_policy_delete  =3D nsim_ipsec_del_policy,
> > > > +
> > > >  };
> > > >
> > > >  bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
> > > >  {
> > > >       struct sec_path *sp =3D skb_sec_path(skb);
> > > >       struct nsim_ipsec *ipsec =3D &ns->ipsec;
> > > > +     struct xfrm_offload *xo;
> > > >       struct xfrm_state *xs;
> > > >       struct nsim_sa *tsa;
> > > >       u32 sa_idx;
> > > > @@ -275,6 +292,19 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struc=
t sk_buff *skb)
> > > >               return false;
> > > >       }
> > > >
> > > > +     if (xs->if_id) {
> > > > +             if (xs->if_id !=3D tsa->if_id) {
> > > > +                     netdev_err(ns->netdev, "unmatched if_id %d %d=
\n",
> > > > +                                xs->if_id, tsa->if_id);
> > > > +                     return false;
> > > > +             }
> > > > +             xo =3D xfrm_offload(skb);
> > > > +             if (!xo || !(xo->flags & XFRM_XMIT)) {
> > > > +                     netdev_err(ns->netdev, "offload flag missing =
or wrong\n");
> > > > +                     return false;
> > > > +             }
> > > > +     }
> > > > +
> > > >       ipsec->tx++;
> > > >
> > > >       return true;
> > > > diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdev=
sim/netdevsim.h
> > > > index bf02efa10956..4941b6e46d0a 100644
> > > > --- a/drivers/net/netdevsim/netdevsim.h
> > > > +++ b/drivers/net/netdevsim/netdevsim.h
> > > > @@ -41,6 +41,7 @@ struct nsim_sa {
> > > >       __be32 ipaddr[4];
> > > >       u32 key[4];
> > > >       u32 salt;
> > > > +     u32 if_id;
> > > >       bool used;
> > > >       bool crypt;
> > > >       bool rx;
> > > > diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> > > > index e5722c95b8bb..3e9a1b17f37e 100644
> > > > --- a/net/xfrm/xfrm_output.c
> > > > +++ b/net/xfrm/xfrm_output.c
> > > > @@ -704,6 +704,8 @@ int xfrm_output(struct sock *sk, struct sk_buff=
 *skb)
> > > >  {
> > > >       struct net *net =3D dev_net(skb_dst(skb)->dev);
> > > >       struct xfrm_state *x =3D skb_dst(skb)->xfrm;
> > > > +     struct xfrm_offload *xo;
> > > > +     struct sec_path *sp;
> > > >       int family;
> > > >       int err;
> > > >
> > > > @@ -728,7 +730,27 @@ int xfrm_output(struct sock *sk, struct sk_buf=
f *skb)
> > > >                       kfree_skb(skb);
> > > >                       return -EHOSTUNREACH;
> > > >               }
> > > > +             if (x->if_id) {
> > > > +                     sp =3D secpath_set(skb);
> > > > +                     if (!sp) {
> > > > +                             XFRM_INC_STATS(net, LINUX_MIB_XFRMOUT=
ERROR);
> > > > +                             kfree_skb(skb);
> > > > +                             return -ENOMEM;
> > > > +                     }
> > > > +
> > > > +                     sp->olen++;
> > > > +                     sp->xvec[sp->len++] =3D x;
> > > > +                     xfrm_state_hold(x);
> > > >
> > > > +                     xo =3D xfrm_offload(skb);
> > > > +                     if (!xo) {
> > > > +                             secpath_reset(skb);
> > > > +                             XFRM_INC_STATS(net, LINUX_MIB_XFRMOUT=
ERROR);
> > > > +                             kfree_skb(skb);
> > > > +                             return -EINVAL;
> > > > +                     }
> > > > +                     xo->flags |=3D XFRM_XMIT;
> > > > +             }
> > > >               return xfrm_output_resume(sk, skb, 0);
> > > >       }
> > > >
> > > > --
> > > > 2.47.0.371.ga323438b13-goog
> > > >
> > > >

