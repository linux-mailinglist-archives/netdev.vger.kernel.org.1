Return-Path: <netdev+bounces-207246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B1DB065EE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50C71AA67C7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE405298992;
	Tue, 15 Jul 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDct1Nyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDEB286D4E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603813; cv=none; b=dYjtMy4eNJkc31RpCi8/gGrB4g4blZFYojZJY8Ty9rGkRax/JVBpg/DmWI+O+TH6Rrtmx/77SNJVVKzrlNYi2LSF4JO9evfk5Ai3jk3D2CRn9dJIawsbScFbbIwKyn0rjcTvajyds+qynEPlJy3uVTrTAlFvDPG1ZoeJKEeQ6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603813; c=relaxed/simple;
	bh=kNNysuLuNDzrFjKaf0wAb7ASzJmi+SI2mSCQmQ/ryxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UADN6AnANc58OZXLubq3uRVFa03SteBJicTOqBAJa6d0IJMe4MwumEum4gic30sycYdL6+kSufhZofXon8xN4r1TGfI/qnZPkIdY675rgvDty1sSQmauEyqYaCwGkSk1g901Oi5Kc+VIKBEvpL6mRPWo5Yrp/Jr+y//SLg45wB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDct1Nyn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso5023888276.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752603811; x=1753208611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPL0er502vW5nyvUZ3Uyjv8dLynogs6zQ9XIARUTxYw=;
        b=GDct1NynGZRAzTJvAm302UIFQJ4abzF6rLB8gsR6cywvqAHrBOtTDQqsQlDA+nfSFu
         bN1YpHFwWx0htGsroSPqJWNiI76Zy9Pw346tQGbVzYht/HvAr2F27/4ylD5GvkQCHpUg
         7QuGJVlAF5bDmOcc8ehLZ4wzIJgMNTQtkBF6UkhYsJfoH+CGnUcNwJwrYmQ95dSHjcj8
         1nBLKfAaYwb2ux5jJWXc+yztMf4INCFqpNv9gwOu5Kc6goKg8+6cWb9SF/Vrk7yfDwc2
         xIHoY+tz3U6JTwqBKSUZUi6rP19229sITHrzuMPQ0w+Kmyb+bLO/Nqfm4ozLjIJJdfBk
         riQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752603811; x=1753208611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPL0er502vW5nyvUZ3Uyjv8dLynogs6zQ9XIARUTxYw=;
        b=CPMK2Cbe7mLFaB5kYb79oL4evYN/H5OLvTglGmxDfMEVa1/thXnj2wk+VqVtv9YCNQ
         PrroSNR1C4o+ls3hmfMFsQyT0Cl8CAF0B1fxI8mszCtXKUmJ6s4ksf8v7rbrgUEREICE
         aX77oLL6zWLz4ikqzoGWq/+JbYlX70jzA8qcEBjE6B3GjNVpxBB6M9SAktfhpoIwB9Xm
         o6lzGH4/BRNsyxgL+HHvSCGXw1hR72Jm6TEALDDes3cvctcdHxaC73iD7OjOUeUJkydF
         Wl6HAsKHRl6ZWyKgFs/iP8+Cs97gCrLaW59tyjdOQcLTqfN54bTkTdaFGiHguyjvNj9V
         zfvQ==
X-Gm-Message-State: AOJu0Yx3GQxBTCtcz6f+CfUQvCghmtgAG77xl4mpB0BAsTznpRea58jQ
	unxKWrSoxGOhVv3zP781HtoG3rMVumniT+rFhRn2dVdWghrGtnVu5/6qrakpQs+SC/Ak9ia14zu
	XTaKdib/9AbvzKlyilV7qvhrcfxYlqrX0V7LTw9MO9g==
X-Gm-Gg: ASbGncsVChr3+S+3vBItBipN655sNwYEertBDdcwPuJxLr0aP9djcHutlMKxt/zX4BD
	OR1ys5SVo52/2G7L14F+HNh2mHOiiCYlrr1MdM3xELaQEQJl8fhqNkml37LsXO1FKMwOBgPqf82
	QEdmSNUFao1JpZw/4BS2qa2f+pAjeNpVQkWSLOR4boXNjOepoUkIlkkbGB8L/11m67MIYnxf77e
	7F5wGyGoOADk/mIk+w=
X-Google-Smtp-Source: AGHT+IHxF21F46U6+UGKxmwL6cQ2WmDlvzctB0nJVsL94yaQI0Gk2RCGwTaXZXstkLWhJ67aGYVUOUN4/tqr/smb9h0=
X-Received: by 2002:a05:6e02:2505:b0:3e0:4f66:3106 with SMTP id
 e9e14a558f8ab-3e2822fd090mr1845955ab.2.1752603799231; Tue, 15 Jul 2025
 11:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706145803.47491-2-mramonius@gmail.com> <aG3NfmO5wsQWKaoz@fedora>
 <CAN2vEgv2tKCZKJSjLNZHMGxDFycqMAkns=tjG6+Ps+N1PmZQ9g@mail.gmail.com>
In-Reply-To: <CAN2vEgv2tKCZKJSjLNZHMGxDFycqMAkns=tjG6+Ps+N1PmZQ9g@mail.gmail.com>
From: Erwan Dufour <mrarmonius@gmail.com>
Date: Tue, 15 Jul 2025 20:23:08 +0200
X-Gm-Features: Ac12FXyeUFkTzB169DczJZ4a0D4pc2lgPzsfzmiD-qWOB3AAEzGrrVEx1HdA3EQ
Message-ID: <CAN2vEgtRNDMcPjU9S8-kZxv=rx_cv-xb1db_b0W8HwfstKb-Yw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xfrm: bonding: Add XFRM packet-offload for active-backup
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, jv@jvosburgh.net, 
	saeedm@nvidia.com, tariqt@nvidia.com, erwan.dufour@withings.com, 
	cratiu@nvidia.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liu,
I=E2=80=99m following up on the email to check if you need any more informa=
tion?

If not, could someone review the code to see if we can add packet
offload on active-backup bonding ?

Best regards,


Le mer. 9 juil. 2025 =C3=A0 23:57, Erwan Dufour <mrarmonius@gmail.com> a =
=C3=A9crit :
>
> Hi Liu,
>
> Thank you very much for your feedback,
> Sorry for the duplicate =E2=80=94 my first email contained HTML, which is
> rejected by netdev@vger.kernel.org.
>
> > I see you delete ipsec->xs here. Do you mean to prevent reuse of IV?
>
> Yes=E2=80=94we do need to destroy the SA attached to the bond device.
> Destruction is required because we can=E2=80=99t simply swap out the
> Initialization Vector (IV) or Salt and re=E2=80=91attach the SA to the de=
vice.
> As Steffen noted, re=E2=80=91using an IV+salt =3D nonce is a critical sec=
urity
> error, as spelled out in=E2=80=AFRFC=E2=80=AF4106 for AES=E2=80=91GCM. "F=
or a given key, the
> IV MUST NOT repeat" from RFC4106. For this cipher we carve out part of
> the key (4 octets for salt) supplied when the SA is created. Later,
> when we offload crypto or packet processing, the NIC keeps its own
> independent counter on each physical interface, and that counter is
> appended to the IV for every packet.
>
> Re=E2=80=91using the same SA therefore means re=E2=80=91using the same ke=
y and
> recreating the same IV while the counter resets to zero, which can
> produce repeated IVs and thus a security vulnerability.
>
>
> > But I can't find you add the xs back to new slave.
> > Here you do xdo_dev_policy_add(). What about the xdo_dev_state_add()?
>
> As described in RFC=E2=80=AF4106, it is recommended to use Internet Key
> Exchange (IKE), as specified in RFC=E2=80=AF2409, to ensure the uniquenes=
s of
> the key/nonce combination.
> In our case, we do not want to re-use an SA whose nonce (salt + IV)
> would be repeated for all packets sent over the primary link before
> the fallback. To prevent this, our solution is to expire the SA and
> let IKE generate a new one.
>
> There are two types of SA expiration in IKE: soft and hard. A soft
> expiration signals that the SA should be replaced, but it can still be
> used for a short time until it is replaced by IKE or removed by the
> kernel. In my case, I chose hard expiration by explicitly deleting the
> SA to ensure it is never used on the new link.
> Therefore, when an SA is expired, it is not necessarily deleted. The
> expiration function simply broadcasts a notification to all processes
> listening to XFRM, indicating that the SA needs to be renewed. IKE
> will then handle the destruction and replacement of the SA.
> Since we expire the SA only after ensuring that the new primary slave
> has been selected, we can be confident that when IKE attempts to add a
> new SA, it will find a valid real_dev =E2=80=94 and the correct one
>
> I tested the new code with IKE charond_systemd which is often used
> with strongswan_swanctl. And of course, it's working !
>
>
>
> > Here the xdo_dev_state_delete() is called when km.state =3D=3D XFRM_STA=
TE_DEAD.
> > Why we remove this?
>
> This piece of code was used to remove the SA we had added to the
> device, in case the device was in the DEAD state. The device could be
> in that state if it had been deleted in parallel with the change of
> the primary slave. The destruction function on the device would have
> failed because real_dev was null at that point.
>
> But as you've seen, in the new code we no longer add the SA to the
> device in any case, so there's no need to remove it from the device
> since it was never added in the first place.
>
> That=E2=80=99s why I decided to remove this part of the code =E2=80=94 it=
=E2=80=99s no longer
> needed and could potentially trigger an error in the
> xdo_dev_state_delete function.
>
>
>
> I hope I=E2=80=99ve answered your questions and that my responses are cle=
ar.
>
>
>
> @Steffen Klassert, may I take advantage of your kindness and ask if
> you know the reasons why IKE was implemented in userland rather than
> in the kernel? Since it's a standardized protocol, I thought it could
> have been part of the kernel(RFC=E2=80=AF2409).
>
> Thanks,
>
> Best regards,
>
> Le mer. 9 juil. 2025 =C3=A0 04:01, Hangbin Liu <liuhangbin@gmail.com> a =
=C3=A9crit :
> >
> > Hi Erwan,
> >
> > On Sun, Jul 06, 2025 at 04:58:04PM +0200, Erwan Dufour wrote:
> > > From: Erwan Dufour <erwan.dufour@withings.com>
> > >
> > > New features added:
> > > - Use of packet offload added for XFRM in active-backup
> > > - Behaviour modification when changing primary slave to prevent reuse=
 of IV.
> >
> > ...
> >
> > >
> > > -static void bond_ipsec_add_sa_all(struct bonding *bond)
> > > +static void bond_ipsec_add_sa_sp_all(struct bonding *bond)
> > >  {
> > >       struct net_device *bond_dev =3D bond->dev;
> > >       struct net_device *real_dev;
> > >       struct bond_ipsec *ipsec;
> > >       struct slave *slave;
> > > +     int err;
> > >
> > >       slave =3D rtnl_dereference(bond->curr_active_slave);
> > >       real_dev =3D slave ? slave->dev : NULL;
> > >       if (!real_dev)
> > >               return;
> > >
> > > -     mutex_lock(&bond->ipsec_lock);
> > > +     mutex_lock(&bond->ipsec_lock_sa);
> > >       if (!real_dev->xfrmdev_ops ||
> > >           !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> > >           netif_is_bond_master(real_dev)) {
> > > -             if (!list_empty(&bond->ipsec_list))
> > > +             if (!list_empty(&bond->ipsec_list_sa))
> > >                       slave_warn(bond_dev, real_dev,
> > >                                  "%s: no slave xdo_dev_state_add\n",
> > >                                  __func__);
> > > -             goto out;
> > > +             goto out_sa;
> > >       }
> > >
> > > -     list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > > -             /* If new state is added before ipsec_lock acquired */
> > > +     list_for_each_entry(ipsec, &bond->ipsec_list_sa, list) {
> > > +             /* If new state is added before ipsec_lock_sa acquired =
*/
> > >               if (ipsec->xs->xso.real_dev =3D=3D real_dev)
> > >                       continue;
> > >
> > > -             if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
> > > -                                                          ipsec->xs,=
 NULL)) {
> > > -                     slave_warn(bond_dev, real_dev, "%s: failed to a=
dd SA\n", __func__);
> > > +             err =3D __xfrm_state_delete(ipsec->xs);
> > > +             if (!err)
> > > +                     km_state_expired(ipsec->xs, 1, 0);
> > > +
> > > +             xfrm_audit_state_delete(ipsec->xs, err ? 0 : 1, true);
> >
> > I see you delete ipsec->xs here. Do you mean to prevent reuse of IV?
> > But I can't find you add the xs back to new slave.
> >
> > > +     }
> > > +out_sa:
> > > +     mutex_unlock(&bond->ipsec_lock_sa);
> > > +
> > > +     mutex_lock(&bond->ipsec_lock_sp);
> > > +     if (!real_dev->xfrmdev_ops ||
> > > +         !real_dev->xfrmdev_ops->xdo_dev_policy_add ||
> > > +         netif_is_bond_master(real_dev)) {
> > > +             if (!list_empty(&bond->ipsec_list_sp))
> > > +                     slave_warn(bond_dev, real_dev,
> > > +                                "%s: no slave xdo_dev_policy_add\n",
> > > +                                __func__);
> > > +             goto out_sp;
> > > +     }
> > > +     list_for_each_entry(ipsec, &bond->ipsec_list_sp, list) {
> > > +             if (ipsec->xp->xdo.real_dev =3D=3D real_dev)
> > > +                     continue;
> > > +
> > > +             if (real_dev->xfrmdev_ops->xdo_dev_policy_add(real_dev,
> > > +                                                           ipsec->xp=
,
> > > +                                                           NULL)) {
> > > +                     slave_warn(bond_dev, real_dev,
> > > +                                "%s: failed to add SP\n", __func__);
> > >                       continue;
> >
> > Here you do xdo_dev_policy_add(). What about the xdo_dev_state_add()?
> >
> > >               }
> > >
> > > -             spin_lock_bh(&ipsec->xs->lock);
> > > -             /* xs might have been killed by the user during the mig=
ration
> > > -              * to the new dev, but bond_ipsec_del_sa() should have =
done
> > > -              * nothing, as xso.real_dev is NULL.
> > > -              * Delete it from the device we just added it to. The p=
ending
> > > -              * bond_ipsec_free_sa() call will do the rest of the cl=
eanup.
> > > -              */
> > > -             if (ipsec->xs->km.state =3D=3D XFRM_STATE_DEAD &&
> > > -                 real_dev->xfrmdev_ops->xdo_dev_state_delete)
> > > -                     real_dev->xfrmdev_ops->xdo_dev_state_delete(rea=
l_dev,
> > > -                                                                 ips=
ec->xs);
> >
> > Here the xdo_dev_state_delete() is called when km.state =3D=3D XFRM_STA=
TE_DEAD.
> > Why we remove this?
> >
> > > -             ipsec->xs->xso.real_dev =3D real_dev;
> > > -             spin_unlock_bh(&ipsec->xs->lock);
> > > +             write_lock_bh(&ipsec->xp->lock);
> > > +             ipsec->xp->xdo.real_dev =3D real_dev;
> > > +             write_unlock_bh(&ipsec->xp->lock);
> > >       }
> > > -out:
> > > -     mutex_unlock(&bond->ipsec_lock);
> > > +
> > > +out_sp:
> > > +     mutex_unlock(&bond->ipsec_lock_sp);
> > >  }
> >
> > Thanks
> > Hangbin

