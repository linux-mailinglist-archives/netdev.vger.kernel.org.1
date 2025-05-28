Return-Path: <netdev+bounces-194009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9180BAC6C9A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A37A1BC6145
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A328BA86;
	Wed, 28 May 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUzVmy7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF3283C86
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445023; cv=none; b=Lz1JJMV62najFxItVb8IEKekttOYnv8XA2h/oFd265fn6JtpIfOwLHYicGWEQtdNH1mVp4JX21iNuOBJazymD/r9yGhPlPCx6BEBzYT2WaIVIyJu5l6QHiOr91IcNqOwHMzWwJ6KfzU0Qfwh1ynhBAPfnQcyg8kYOvkNqipvmqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445023; c=relaxed/simple;
	bh=daJUFB82BXFmTD9y4m1Fz807QYg9ksryLBhg8OMWiJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXD+32Kh0kXv9grzfLLUuA2A1dCbAMnrBO0SM5/l0SBkqj5i2g5IiJe7sI402mLEarGuqHD6dFzNHLXZLRkkIiK1N9iPboCkJdvq+DpVg3Acy7dZ+XtUZ52YpK803gMxlBl7OGs6VtHzwXqvNcjdO55x4IufE49KvnwXNUwC594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUzVmy7F; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476977848c4so44951081cf.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748445020; x=1749049820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi/xcDxaQ9K4mUzGpiKOG5t5QTXiOvRNG848IheBH08=;
        b=UUzVmy7FEmRfiNTq5Rb2W3bttkvGM/6X64HONcEn71dqWkxWKHv37DtwNxfFy4u0u/
         513PwjUUvF4o3zrZN34yuoPtr9RRqwGBIDyoz3K/PJkiy2qNeHpmDjULKQzymL9a2jHh
         s6q3hymUI9FHPzFfFz76nIUidSuGMbOwGXLNAulHvscy1+Ez6grNtWGaCwpiwg+xzKl1
         HkjSVwDs83QvWog3ag/AfWFNqb2E8HW6/3LOMtmd9FbqOGBSAJepjh2FIc+I3cRMIlNw
         zKYHhFGqt1hTUFBufX4sPLXwIG9ID00BxCoXQbzn7MGFuVDUeyFJemjv3aRRq47IeQPV
         axcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748445020; x=1749049820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi/xcDxaQ9K4mUzGpiKOG5t5QTXiOvRNG848IheBH08=;
        b=q06SuwMqbxZC2TfaFccd10Org7WyOXdqDcazKGXrWrWi2pEovuP+HUMFUi8Q2//99u
         h8oUIpuRXqSKnSyp9YzFYuzyLB35TOJEv9NV9WNOHXgtolDweosygnmTNhPjfBvzGQs/
         5MNDKn8tdH+A2i2ajbMZ75ujKtNKh8qBg/PSWWOAX66LgJrUO2kKcjKV8h3qFcbzI5b+
         aTilTVcGMa86SrQLuNRe42b2Y2fi0+j0hqTOHluRW/h82PKFMbFtYxL1bb6CsdR5MCmf
         9tzaGUdyVGOvyXlsAfjnjlwJMbdalYeiiNT81Usb/zH21hsVv+tBEMfHX3532z1fspyL
         UWIA==
X-Gm-Message-State: AOJu0YzkYSuEcqnJN7baGlOaDfyx0QO1+qBD70umgn0fDxcA2O0X/X8z
	D4HKsqWDWxrbEvNT6ghGkVfDMi+qdgIbcZ1DM/2f+8m43e3rkOjavyeMBHy2a11lAfujhlS08UA
	vc+p1EPj5S4wq5RQkPZIA1wDZmLM5Ll/YezDj2OnI
X-Gm-Gg: ASbGncuoJvjrs+8Krdw+g3pN2xqYWiKl8WeJa6WEXbTe+rWTpR6FoBRbhWS24E2mmcu
	8KHbdYOO/yolecE2ctP3pbfmkHM85h0npnF2Cb1rtawfbUkQnYAGa3nBpR+WIfzpKQzTJeQwvK1
	8lcU8F5Vl6rTRYm7I0UssgVCTNB6GOdNBMdf/h0/POSzw=
X-Google-Smtp-Source: AGHT+IH5EBOb08sW8N1Ba8E/7tAm5rYg/KOK50Obzu7bpAMNg7mESqtUYP22/aoC17d7nhA0CYjtqlB2r08g4ApQqwo=
X-Received: by 2002:ac8:7097:0:b0:4a4:2fad:7cdd with SMTP id
 d75a77b69052e-4a42fad94fcmr11370611cf.24.1748445019966; Wed, 28 May 2025
 08:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com> <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
In-Reply-To: <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 May 2025 08:10:08 -0700
X-Gm-Features: AX0GCFtNSEvgJH7-KYab03XUXlyKd6cY4cl931-PX3TVLDnGRItEqAr_PdyoWIM
Message-ID: <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 7:36=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=
=AA <kota.toda@gmo-cybersecurity.com> wrote:
>
> Thank you for your review.
>
> 2025=E5=B9=B45=E6=9C=8826=E6=97=A5(=E6=9C=88) 17:23 Eric Dumazet <edumaze=
t@google.com>:
> >
> > On Sun, May 25, 2025 at 10:08=E2=80=AFPM =E6=88=B8=E7=94=B0=E6=99=83=E5=
=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> > >
> > > In bond_setup_by_slave(), the slave=E2=80=99s header_ops are uncondit=
ionally
> > > copied into the bonding device. As a result, the bonding device may i=
nvoke
> > > the slave-specific header operations on itself, causing
> > > netdev_priv(bond_dev) (a struct bonding) to be incorrectly interprete=
d
> > > as the slave's private-data type.
> > >
> > > This type-confusion bug can lead to out-of-bounds writes into the skb=
,
> > > resulting in memory corruption.
> > >
> > > This patch adds two members to struct bonding, bond_header_ops and
> > > header_slave_dev, to avoid type-confusion while keeping track of the
> > > slave's header_ops.
> > >
> > > Fixes: 1284cd3a2b740 (bonding: two small fixes for IPoIB support)
> > > Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > > Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > > Co-Developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > > Reviewed-by: Paolo Abeni <pabeni@redhat.com>
> > > Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > > ---
> > >  drivers/net/bonding/bond_main.c | 61
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  include/net/bonding.h           |  5 +++++
> > >  2 files changed, 65 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bo=
nd_main.c
> > > index 8ea183da8d53..690f3e0971d0 100644
> > > --- a/drivers/net/bonding/bond_main.c
> > > +++ b/drivers/net/bonding/bond_main.c
> > > @@ -1619,14 +1619,65 @@ static void bond_compute_features(struct bond=
ing *bond)
> > >      netdev_change_features(bond_dev);
> > >  }
> > >
> > > +static int bond_hard_header(struct sk_buff *skb, struct net_device *=
dev,
> > > +        unsigned short type, const void *daddr,
> > > +        const void *saddr, unsigned int len)
> > > +{
> > > +    struct bonding *bond =3D netdev_priv(dev);
> > > +    struct net_device *slave_dev;
> > > +
> > > +    slave_dev =3D bond->header_slave_dev;
> > > +
> > > +    return dev_hard_header(skb, slave_dev, type, daddr, saddr, len);
> > > +}
> > > +
> > > +static void bond_header_cache_update(struct hh_cache *hh, const
> > > struct net_device *dev,
> > > +        const unsigned char *haddr)
> > > +{
> > > +    const struct bonding *bond =3D netdev_priv(dev);
> > > +    struct net_device *slave_dev;
> > > +
> > > +    slave_dev =3D bond->header_slave_dev;
> >
> > I do not see any barrier ?
> >
> > > +
> > > +    if (!slave_dev->header_ops || !slave_dev->header_ops->cache_upda=
te)
> > > +        return;
> > > +
> > > +    slave_dev->header_ops->cache_update(hh, slave_dev, haddr);
> > > +}
> > > +
> > >  static void bond_setup_by_slave(struct net_device *bond_dev,
> > >                  struct net_device *slave_dev)
> > >  {
> > > +    struct bonding *bond =3D netdev_priv(bond_dev);
> > >      bool was_up =3D !!(bond_dev->flags & IFF_UP);
> > >
> > >      dev_close(bond_dev);
> > >
> > > -    bond_dev->header_ops        =3D slave_dev->header_ops;
> > > +    /* Some functions are given dev as an argument
> > > +     * while others not. When dev is not given, we cannot
> > > +     * find out what is the slave device through struct bonding
> > > +     * (the private data of bond_dev). Therefore, we need a raw
> > > +     * header_ops variable instead of its pointer to const header_op=
s
> > > +     * and assign slave's functions directly.
> > > +     * For the other case, we set the wrapper functions that pass
> > > +     * slave_dev to the wrapped functions.
> > > +     */
> > > +    bond->bond_header_ops.create =3D bond_hard_header;
> > > +    bond->bond_header_ops.cache_update =3D bond_header_cache_update;
> > > +    if (slave_dev->header_ops) {
> > > +        bond->bond_header_ops.parse =3D slave_dev->header_ops->parse=
;
> > > +        bond->bond_header_ops.cache =3D slave_dev->header_ops->cache=
;
> > > +        bond->bond_header_ops.validate =3D slave_dev->header_ops->va=
lidate;
> > > +        bond->bond_header_ops.parse_protocol =3D
> > > slave_dev->header_ops->parse_protocol;
> >
> > All these updates probably need WRITE_ONCE(), and corresponding
> > READ_ONCE() on reader sides, at a very minimum ...
> >
> > RCU would even be better later.
> >
> I believe that locking is not necessary in this patch. The update of
> `header_ops` only happens when a slave is newly enslaved to a bond.
> Under such circumstances, members of `header_ops` are not called in
> parallel with updating. Therefore, there is no possibility of race
> conditions occurring.

bond_dev can certainly be live, and packets can flow.

I have seen enough syzbot reports hinting at this precise issue.

