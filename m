Return-Path: <netdev+bounces-205561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4BAFF42F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B12F4E0574
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5352024501B;
	Wed,  9 Jul 2025 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFCFOaXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86358221DB4
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098261; cv=none; b=l3qkgZ+5Mzct78I+OKU2Xc6MozS3agwfXJu0OzFxpXGU55f9a3qI4A2m3r+g5/ssaUW6friZEBivjtTCzoUFibmi0qxi7lN49qUjrjnHF4zqtuLQqPsBJ/ByK6TDh7lnU3psQwDR1aEmabCko08M4vGQLrTy9h5AzVNusXHkiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098261; c=relaxed/simple;
	bh=LlqYq2E+eMtgSIkSa5/mJdQpocoEHOR5BSutY8E/j60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOwwYRcHIpicerdkPrvkJXhuoFPZq/PS5Yh7Fysjfuq3cRnaQDov0OGE5goCXwy5kTtovQCC2rkGBQ17p34rgKkCxgsFFMsQeJe+mmRkcLMcA81yRDLvW8k5bcYj9+7HUUvONzIMg18JlAz0bB/1/EZP5qFMemyjLJbvWQhPaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFCFOaXa; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3df2df6a25aso1247295ab.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752098259; x=1752703059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynLjU0l5erXlZ7/1UHGtAeSTYM15fIc1gsh6NHsk3NE=;
        b=LFCFOaXaZf7IJ7tOu8QvO1AJVZw8EWSwq0zOrMj2mSy+Ferd/XlXVWIYna9lE5uAA8
         66VaD9dgTc3ggBbGlJ0Ra/AaL4dHw2Jo4s7ZWlRt2dXGW16fatlkZ1XTlecPU6s7cbW/
         2SasFpyssO0V/Gj35pDXDZ/cGaJtrXXFGDJ9Mqwv20X426YDipNrhXCkElSBhMijC8Uw
         00U/nj49aftRTbhoBbbkz41aS9KpXNEtW8GxX/LLIxsyedkOqLzD/BpkIphQYXNJC9Ps
         44STfk12Aob0JtO8G57yljNTGRPXK5cECjvq3SRQu64T4NufdvbKk1xZifYsLN34+dqM
         hTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098259; x=1752703059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynLjU0l5erXlZ7/1UHGtAeSTYM15fIc1gsh6NHsk3NE=;
        b=qF3Cff8u/RmhfTVVPXDGvSb/MdluhTtmYLHejtdYMp2kzi7Rr72Gwri0TZtLOshIyY
         clN1MuhuGgcq9tt70K7u+Pm5dEinlL07IeDlR1q4LRj/klZhZl9eJ4bT6ZH65lRMMm0c
         HSu8efbMkQHswrjbr915kATKZCvZJB8Z/YWe9N81xY1iwzskiWhq9IHSxsE0UISHleuy
         XEgjtNk4U/PwZEo+cZtCUAVRy8nReEx45ZF329Re3QvmjHwFuobSV9/q6l+fSjIvaoyX
         P9JP2uX4tg62dUrPXspzMHyFQMue2AdnGn8ZnuvG785/qDx7XB7MD1pQBSaVQHZPdr52
         3i0w==
X-Gm-Message-State: AOJu0YzeBdzWgvdY+66FmnhqrUR1BhoRPLrUF1kmo4hMHZcd0/YrR0eq
	78HfG7bhfAvjDJpmupDcbdguiFhHEyjNy5vPklXBbwZJoDvDJEmJJdQU0s4cD8f3KwanKQrPynM
	rO+oRP4152gkc0Np3m5EzjM2fmQwCB3mq9DMS6kShJw==
X-Gm-Gg: ASbGncu2f31W/6+0/mKsI5iA30ht1wx/3MUS2P38sqrBmgf8Tze/yyE6B0KzXmuz7/l
	D4JA8CK13lzpPKt1ajh+GEvleExOnnot10f97cF6W7pCs9dOOXdilwo9P3opkCFKf/fT+z9Ge5C
	xt/JuoKo+KrPabo9pvyBBCYmqpXIRgybkTsJqCqj7tbE97
X-Google-Smtp-Source: AGHT+IHlMJjdGfMaeV2oYd4xX2Ag69A6a40zKNRfn27btFqn2qrYg0UzrwqLjBQYfOZnjLy8YDQy5hCMU7KVXyWTk1A=
X-Received: by 2002:a05:6e02:3c88:b0:3df:5354:a804 with SMTP id
 e9e14a558f8ab-3e2461e1794mr3240095ab.18.1752098258554; Wed, 09 Jul 2025
 14:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706145803.47491-2-mramonius@gmail.com> <aG3NfmO5wsQWKaoz@fedora>
In-Reply-To: <aG3NfmO5wsQWKaoz@fedora>
From: Erwan Dufour <mrarmonius@gmail.com>
Date: Wed, 9 Jul 2025 23:57:27 +0200
X-Gm-Features: Ac12FXzXTF1MBJ-f63gKWDefVP5uvtE7aV4GCbyL2MQVoTBexSvwC0enOWCp01k
Message-ID: <CAN2vEgv2tKCZKJSjLNZHMGxDFycqMAkns=tjG6+Ps+N1PmZQ9g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xfrm: bonding: Add XFRM packet-offload for active-backup
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, jv@jvosburgh.net, 
	saeedm@nvidia.com, tariqt@nvidia.com, erwan.dufour@withings.com, 
	cratiu@nvidia.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liu,

Thank you very much for your feedback,
Sorry for the duplicate =E2=80=94 my first email contained HTML, which is
rejected by netdev@vger.kernel.org.

> I see you delete ipsec->xs here. Do you mean to prevent reuse of IV?

Yes=E2=80=94we do need to destroy the SA attached to the bond device.
Destruction is required because we can=E2=80=99t simply swap out the
Initialization Vector (IV) or Salt and re=E2=80=91attach the SA to the devi=
ce.
As Steffen noted, re=E2=80=91using an IV+salt =3D nonce is a critical secur=
ity
error, as spelled out in=E2=80=AFRFC=E2=80=AF4106 for AES=E2=80=91GCM. "For=
 a given key, the
IV MUST NOT repeat" from RFC4106. For this cipher we carve out part of
the key (4 octets for salt) supplied when the SA is created. Later,
when we offload crypto or packet processing, the NIC keeps its own
independent counter on each physical interface, and that counter is
appended to the IV for every packet.

Re=E2=80=91using the same SA therefore means re=E2=80=91using the same key =
and
recreating the same IV while the counter resets to zero, which can
produce repeated IVs and thus a security vulnerability.


> But I can't find you add the xs back to new slave.
> Here you do xdo_dev_policy_add(). What about the xdo_dev_state_add()?

As described in RFC=E2=80=AF4106, it is recommended to use Internet Key
Exchange (IKE), as specified in RFC=E2=80=AF2409, to ensure the uniqueness =
of
the key/nonce combination.
In our case, we do not want to re-use an SA whose nonce (salt + IV)
would be repeated for all packets sent over the primary link before
the fallback. To prevent this, our solution is to expire the SA and
let IKE generate a new one.

There are two types of SA expiration in IKE: soft and hard. A soft
expiration signals that the SA should be replaced, but it can still be
used for a short time until it is replaced by IKE or removed by the
kernel. In my case, I chose hard expiration by explicitly deleting the
SA to ensure it is never used on the new link.
Therefore, when an SA is expired, it is not necessarily deleted. The
expiration function simply broadcasts a notification to all processes
listening to XFRM, indicating that the SA needs to be renewed. IKE
will then handle the destruction and replacement of the SA.
Since we expire the SA only after ensuring that the new primary slave
has been selected, we can be confident that when IKE attempts to add a
new SA, it will find a valid real_dev =E2=80=94 and the correct one

I tested the new code with IKE charond_systemd which is often used
with strongswan_swanctl. And of course, it's working !



> Here the xdo_dev_state_delete() is called when km.state =3D=3D XFRM_STATE=
_DEAD.
> Why we remove this?

This piece of code was used to remove the SA we had added to the
device, in case the device was in the DEAD state. The device could be
in that state if it had been deleted in parallel with the change of
the primary slave. The destruction function on the device would have
failed because real_dev was null at that point.

But as you've seen, in the new code we no longer add the SA to the
device in any case, so there's no need to remove it from the device
since it was never added in the first place.

That=E2=80=99s why I decided to remove this part of the code =E2=80=94 it=
=E2=80=99s no longer
needed and could potentially trigger an error in the
xdo_dev_state_delete function.



I hope I=E2=80=99ve answered your questions and that my responses are clear=
.



@Steffen Klassert, may I take advantage of your kindness and ask if
you know the reasons why IKE was implemented in userland rather than
in the kernel? Since it's a standardized protocol, I thought it could
have been part of the kernel(RFC=E2=80=AF2409).

Thanks,

Best regards,

Le mer. 9 juil. 2025 =C3=A0 04:01, Hangbin Liu <liuhangbin@gmail.com> a =C3=
=A9crit :
>
> Hi Erwan,
>
> On Sun, Jul 06, 2025 at 04:58:04PM +0200, Erwan Dufour wrote:
> > From: Erwan Dufour <erwan.dufour@withings.com>
> >
> > New features added:
> > - Use of packet offload added for XFRM in active-backup
> > - Behaviour modification when changing primary slave to prevent reuse o=
f IV.
>
> ...
>
> >
> > -static void bond_ipsec_add_sa_all(struct bonding *bond)
> > +static void bond_ipsec_add_sa_sp_all(struct bonding *bond)
> >  {
> >       struct net_device *bond_dev =3D bond->dev;
> >       struct net_device *real_dev;
> >       struct bond_ipsec *ipsec;
> >       struct slave *slave;
> > +     int err;
> >
> >       slave =3D rtnl_dereference(bond->curr_active_slave);
> >       real_dev =3D slave ? slave->dev : NULL;
> >       if (!real_dev)
> >               return;
> >
> > -     mutex_lock(&bond->ipsec_lock);
> > +     mutex_lock(&bond->ipsec_lock_sa);
> >       if (!real_dev->xfrmdev_ops ||
> >           !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> >           netif_is_bond_master(real_dev)) {
> > -             if (!list_empty(&bond->ipsec_list))
> > +             if (!list_empty(&bond->ipsec_list_sa))
> >                       slave_warn(bond_dev, real_dev,
> >                                  "%s: no slave xdo_dev_state_add\n",
> >                                  __func__);
> > -             goto out;
> > +             goto out_sa;
> >       }
> >
> > -     list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > -             /* If new state is added before ipsec_lock acquired */
> > +     list_for_each_entry(ipsec, &bond->ipsec_list_sa, list) {
> > +             /* If new state is added before ipsec_lock_sa acquired */
> >               if (ipsec->xs->xso.real_dev =3D=3D real_dev)
> >                       continue;
> >
> > -             if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
> > -                                                          ipsec->xs, N=
ULL)) {
> > -                     slave_warn(bond_dev, real_dev, "%s: failed to add=
 SA\n", __func__);
> > +             err =3D __xfrm_state_delete(ipsec->xs);
> > +             if (!err)
> > +                     km_state_expired(ipsec->xs, 1, 0);
> > +
> > +             xfrm_audit_state_delete(ipsec->xs, err ? 0 : 1, true);
>
> I see you delete ipsec->xs here. Do you mean to prevent reuse of IV?
> But I can't find you add the xs back to new slave.
>
> > +     }
> > +out_sa:
> > +     mutex_unlock(&bond->ipsec_lock_sa);
> > +
> > +     mutex_lock(&bond->ipsec_lock_sp);
> > +     if (!real_dev->xfrmdev_ops ||
> > +         !real_dev->xfrmdev_ops->xdo_dev_policy_add ||
> > +         netif_is_bond_master(real_dev)) {
> > +             if (!list_empty(&bond->ipsec_list_sp))
> > +                     slave_warn(bond_dev, real_dev,
> > +                                "%s: no slave xdo_dev_policy_add\n",
> > +                                __func__);
> > +             goto out_sp;
> > +     }
> > +     list_for_each_entry(ipsec, &bond->ipsec_list_sp, list) {
> > +             if (ipsec->xp->xdo.real_dev =3D=3D real_dev)
> > +                     continue;
> > +
> > +             if (real_dev->xfrmdev_ops->xdo_dev_policy_add(real_dev,
> > +                                                           ipsec->xp,
> > +                                                           NULL)) {
> > +                     slave_warn(bond_dev, real_dev,
> > +                                "%s: failed to add SP\n", __func__);
> >                       continue;
>
> Here you do xdo_dev_policy_add(). What about the xdo_dev_state_add()?
>
> >               }
> >
> > -             spin_lock_bh(&ipsec->xs->lock);
> > -             /* xs might have been killed by the user during the migra=
tion
> > -              * to the new dev, but bond_ipsec_del_sa() should have do=
ne
> > -              * nothing, as xso.real_dev is NULL.
> > -              * Delete it from the device we just added it to. The pen=
ding
> > -              * bond_ipsec_free_sa() call will do the rest of the clea=
nup.
> > -              */
> > -             if (ipsec->xs->km.state =3D=3D XFRM_STATE_DEAD &&
> > -                 real_dev->xfrmdev_ops->xdo_dev_state_delete)
> > -                     real_dev->xfrmdev_ops->xdo_dev_state_delete(real_=
dev,
> > -                                                                 ipsec=
->xs);
>
> Here the xdo_dev_state_delete() is called when km.state =3D=3D XFRM_STATE=
_DEAD.
> Why we remove this?
>
> > -             ipsec->xs->xso.real_dev =3D real_dev;
> > -             spin_unlock_bh(&ipsec->xs->lock);
> > +             write_lock_bh(&ipsec->xp->lock);
> > +             ipsec->xp->xdo.real_dev =3D real_dev;
> > +             write_unlock_bh(&ipsec->xp->lock);
> >       }
> > -out:
> > -     mutex_unlock(&bond->ipsec_lock);
> > +
> > +out_sp:
> > +     mutex_unlock(&bond->ipsec_lock_sp);
> >  }
>
> Thanks
> Hangbin

