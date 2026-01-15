Return-Path: <netdev+bounces-250098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98AD23F4B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C73D301BCE3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8C836A039;
	Thu, 15 Jan 2026 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="YyV1blUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B736A02C
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473231; cv=none; b=AWcxmbNMWb3mtWLOb6FS0Vp4AleDRHrBCtwCgsfQ94cKgc88faQPrS28jHc3J1i1+WxcaDyIFzxxGACLJuDNVZMQ3OWlWqUM9eILVvKmTIzXDCRDRwJkfI3VlCfwfExfeUJ4Le0kqsdB1tdPI3RQ3K5EfbBsX00cGKiDawVdTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473231; c=relaxed/simple;
	bh=ZQoiDx1VasiRP8sjYlbu3vM191XA3L9E6eJ5jNKn7JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXMpBcO2boE4y0fp3Nta5yFlvdQHavLniXc+k54AGz2YHz+wTAeAtx1bksczdIgdElXVQd9QDIbaABPNqXP1pqMhZRFE7NX3A0oR9OBwlSFjPNhJW0/8l/sg377QBjLXriSu18MWMNq71H+zu+3acwiS7c3fs77NnXIYKjY428I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=YyV1blUX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so493239f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1768473228; x=1769078028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2byt/TLxKGGJ/Iy+4SQi6BFEJq5ArmOC2nKlag89AY=;
        b=YyV1blUXNVs6sJoy9io+hEac0k1LlSOUs717U1WS6VJ9U+FYEP+fRmGmbIbGWmJjdE
         18SRq70T3wWjkCp5TH8AF5qG1DMpF62gIFZ4lgR3iUBwFqS7u001ujlcWYnYZa1vHsE+
         78RxUWurgLWuYtMyy9Pjhr5p1/4DJdDvrZF6slvCUDJv3n0vDAMLnmprwbcmPpH9M6Cc
         nxrIF8tT5T4ZmSuF7+Dxi8f0TgM/zJ6G+HTaLQoUaff1jAeWjRiIvTnsFLuvCftBHgB4
         Kc6Jan+OFFPZLSQb6YBmo3mPOQvGuwsjCSplPbY0BDySniid45EnBVzUu1HLnS2SY5Y1
         uyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768473228; x=1769078028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2byt/TLxKGGJ/Iy+4SQi6BFEJq5ArmOC2nKlag89AY=;
        b=ZG5RUKqxbJlIX29VwK9Zrj3HLG63sSbZcc2ROw0VPSAf2TnXL5z+K8RjnyOLwG8A7q
         AeUTVmhx+IAtvkeZQOavnPHhOUp2XAHg5oNZmJHPYrWCO1anEio1QWWD3KDen9rRv7vG
         QXY0hWO0+hJLpYkIJ1rzi5hrXNRvu3zn9AZ3HJYjssTcXIJFJC2uJ4BCvruxxU16fVDT
         plsR7dk8oRfDS9DREUNX3YFBQtXpb97KT89ERd9nwpVqeF6d518eAghiN347emxIyjUM
         fWpI/iM6s84sFmmdSuTMTwUBbTOpKvwTk5buuDkJqTX51hjUXK/46HDDm6vYUJP4Y2Nq
         OWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3rWL+irCGhP1h1zbS3X4NrSVg33dTHMkAf8ph1abyifn+kswlo8p9yKxVnUdFz0fMESl+rGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBUQRc0xdotSICRejTKE4dC68tZ+YX5BYagge0StIGcwMR+2uV
	PNLot98GQtweclKseg/ulVIYkCHNZQYmXUo9GuR7ZjlejsEH3jqh1MCY+nSw/CPAvKHjF04p169
	nr3ZNqv2nyrDKOmLNuXWRo4xsWsZkBlv0DKn8qjPVXj1LO9UDvSFdX8bGFA==
X-Gm-Gg: AY/fxX6fGZvDkDOXAvYAbxa3ffK7RzVvHMeK3NEto0jLnsW2/cm6UwrjfWxZ0/HBlgB
	zXKrbsrBQx3JO7n8MLuKKLqOoyXfR6z6YqrxDaBlULBPlRktX0+xXmaiFHkT4eqlb1DtoU926W+
	EDmBpiE3Dnh/FfKHZMweT2eudGl15uDFKZbSa5CuLGXqpfqNQGJzqVnCY7R5R0Gp9k0Pe5Oyauy
	+sX1/eef/GzgTunQ7fwhBkxVDeyamgv24heNl+SQIyUC7qYhRc+k+lNXqZrV7C7z6zFx+su+LQI
	vUWnCBbdnY7D51y88gibiXHZXSI1PQ==
X-Received: by 2002:a05:6000:184a:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-4342c5007a5mr7497846f8f.23.1768473227993; Thu, 15 Jan 2026
 02:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
 <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com> <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com>
In-Reply-To: <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com>
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Thu, 15 Jan 2026 19:33:36 +0900
X-Gm-Features: AZwV_QjXhQ8UCY3-LYq6PWCUFRSzlZCIiBa0jwxAQe8gm_eFepjbZD7PFtr70YM
Message-ID: <CAA3_Gnqo37RxLi2McF0=oRPZSw_P3Kya_3m3JBA2s6c0vaf5sw@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>, 
	=?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Eric and other maintainers,

I hope you=E2=80=99re doing well. I=E2=80=99m following up on our email, se=
nt during
the holiday season, in case it got buried.

When you have a moment, could you please let us know if you had a
chance to review it?

Thank you in advance, and I look forward to your response.

Best regards,
Kota Toda

2025=E5=B9=B412=E6=9C=8822=E6=97=A5(=E6=9C=88) 17:20 =E5=B0=8F=E6=B1=A0=E6=
=82=A0=E7=94=9F <yuki.koike@gmo-cybersecurity.com>:
>
> Hello, Eric and other maintainers,
>
> I'm deeply sorry to have left the patch suggestion for this long period.
> I became extremely busy, and that took its toll on my health, causing
> me to take sick leave for nearly half a year (And my colleague Kota
> had been waiting for me to come back).
> As fortunately I've recovered and returned to work, I hope to move
> forward with this matter as well.
>
> Recalling the issue Eric raised, I understand it was a concern about
> potential race conditions arising from the `bond_header_ops` and
> `header_slave_dev` added to the `struct bonding`. For example, one
> could imagine a situation where `header_slave_dev` is rewritten to a
> different type, and at that exact moment a function from the old
> `bond_header_ops` gets called, or vice versa.
>
> However, I am actually skeptical that this can happen. The reason is
> that `bond_setup_by_slave` is only called when there are no slaves at
> all:
>
> ```
> bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>              struct netlink_ext_ack *extack)
> ...
>   if (!bond_has_slaves(bond)) {
> ...
>       if (slave_dev->type !=3D ARPHRD_ETHER)
>         bond_setup_by_slave(bond_dev, slave_dev);
> ```
>
> In other words, in order to trigger a race condition, one would need
> to remove the slave once and make the slave list empty first. However,
> as shown below, in `bond_release_and_destroy`, when the slave list
> becomes empty, it appears that the bond interface itself is removed.
> This makes it seem impossible to "quickly remove a slave and
> re-register it.":
>
> ```
> static int bond_slave_netdev_event(unsigned long event,
>            struct net_device *slave_dev)
> ...
>   switch (event) {
>   case NETDEV_UNREGISTER:
>     if (bond_dev->type !=3D ARPHRD_ETHER)
>       bond_release_and_destroy(bond_dev, slave_dev);
> ...
> }
> ...
> /* First release a slave and then destroy the bond if no more slaves are =
left.
>  * Must be under rtnl_lock when this function is called.
>  */
> static int bond_release_and_destroy(struct net_device *bond_dev,
>             struct net_device *slave_dev)
> {
>   struct bonding *bond =3D netdev_priv(bond_dev);
>   int ret;
>
>   ret =3D __bond_release_one(bond_dev, slave_dev, false, true);
>   if (ret =3D=3D 0 && !bond_has_slaves(bond) &&
>       bond_dev->reg_state !=3D NETREG_UNREGISTERING) {
>     bond_dev->priv_flags |=3D IFF_DISABLE_NETPOLL;
>     netdev_info(bond_dev, "Destroying bond\n");
>     bond_remove_proc_entry(bond);
>     unregister_netdevice(bond_dev);
>   }
>   return ret;
> }
> ```
>
> Moreover, as noted in the comments, these functions are executed under
> the netlink-side lock. Therefore, my conclusion is that a race
> condition cannot actually occur. I also think that the fact that, even
> before our patch, these code paths had almost no explicit locking
> anywhere serves as circumstantial evidence for this view. As Kota
> said, as far as I saw, the past syzkaller-bot's report is seemingly
> only NULL pointer dereference due to the root cause we reported, and
> this patch should fix them.
>
> That said, even so, I agree that the kind of countermeasures Eric
> suggests are worth applying if they do not cause problems in terms of
> execution speed or code size. However, I am concerned that addressing
> this with READ_ONCE or RCU would imply a somewhat large amount of
> rewriting.
> `header_ops` is designed to allow various types of devices to be
> handled in an object-oriented way, and as such it is used throughout
> many parts of the Linux kernel. Using READ_ONCE or RCU every time
> header_ops is accessed simply because we are worried about a race
> condition in bond=E2=80=99s header_ops seems to imply changes like the
> following, for example:
>
> ```
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 92dc1f1788de..d9aad38746ad 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1538,7 +1538,7 @@ static void neigh_hh_init(struct neighbour *n)
>   * hh_cache entry.
>   */
>   if (!hh->hh_len)
> - dev->header_ops->cache(n, hh, prot);
> + READ_ONCE(dev->header_ops->cache)(n, hh, prot);
>
>   write_unlock_bh(&n->lock);
>  }
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3131,35 +3131,41 @@ static inline int dev_hard_header(struct
> sk_buff *skb, struct net_device *dev,
>    const void *daddr, const void *saddr,
>    unsigned int len)
>  {
> - if (!dev->header_ops || !dev->header_ops->create)
> + int (*create)(struct sk_buff *skb, struct net_device *dev,
> +      unsigned short type, const void *daddr,
> +      const void *saddr, unsigned int len);
> + if (!dev->header_ops || !(create =3D READ_ONCE(dev->header_ops->create)=
))
>   return 0;
>
> - return dev->header_ops->create(skb, dev, type, daddr, saddr, len);
> + return create(skb, dev, type, daddr, saddr, len);
>  }
>
>  static inline int dev_parse_header(const struct sk_buff *skb,
>     unsigned char *haddr)
>  {
> + int (*parse)(const struct sk_buff *skb, unsigned char *haddr);
>   const struct net_device *dev =3D skb->dev;
>
> - if (!dev->header_ops || !dev->header_ops->parse)
> + if (!dev->header_ops || !(parse =3D READ_ONCE(dev->header_ops->parse)))
>   return 0;
> - return dev->header_ops->parse(skb, haddr);
> + return parse(skb, haddr);
>  }
> ... (and so on)
> ```
>
> It looks like we would end up rewriting on the order of a dozen or so
> places with this kind of pattern, but from the perspective of the
> maintainers (or in terms of Linux kernel culture), would this be
> considered an acceptable change?
> If this differs from what you intended, please correct me.
>
> Best regards,
> Yuki Koike
>
> 2025=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=9C=A8) 0:10 Eric Dumazet <edumazet=
@google.com>:
> >
> > On Wed, May 28, 2025 at 7:36=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=
=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> > >
> > > Thank you for your review.
> > >
> > > 2025=E5=B9=B45=E6=9C=8826=E6=97=A5(=E6=9C=88) 17:23 Eric Dumazet <edu=
mazet@google.com>:
> > > >
> > > > On Sun, May 25, 2025 at 10:08=E2=80=AFPM =E6=88=B8=E7=94=B0=E6=99=
=83=E5=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> > > > >
> > > > > In bond_setup_by_slave(), the slave=E2=80=99s header_ops are unco=
nditionally
> > > > > copied into the bonding device. As a result, the bonding device m=
ay invoke
> > > > > the slave-specific header operations on itself, causing
> > > > > netdev_priv(bond_dev) (a struct bonding) to be incorrectly interp=
reted
> > > > > as the slave's private-data type.
> > > > >
> > > > > This type-confusion bug can lead to out-of-bounds writes into the=
 skb,
> > > > > resulting in memory corruption.
> > > > >
> > > > > This patch adds two members to struct bonding, bond_header_ops an=
d
> > > > > header_slave_dev, to avoid type-confusion while keeping track of =
the
> > > > > slave's header_ops.
> > > > >
> > > > > Fixes: 1284cd3a2b740 (bonding: two small fixes for IPoIB support)
> > > > > Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > > > > Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > > > > Co-Developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > > > > Reviewed-by: Paolo Abeni <pabeni@redhat.com>
> > > > > Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > > > > ---
> > > > >  drivers/net/bonding/bond_main.c | 61
> > > > > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > >  include/net/bonding.h           |  5 +++++
> > > > >  2 files changed, 65 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bondin=
g/bond_main.c
> > > > > index 8ea183da8d53..690f3e0971d0 100644
> > > > > --- a/drivers/net/bonding/bond_main.c
> > > > > +++ b/drivers/net/bonding/bond_main.c
> > > > > @@ -1619,14 +1619,65 @@ static void bond_compute_features(struct =
bonding *bond)
> > > > >      netdev_change_features(bond_dev);
> > > > >  }
> > > > >
> > > > > +static int bond_hard_header(struct sk_buff *skb, struct net_devi=
ce *dev,
> > > > > +        unsigned short type, const void *daddr,
> > > > > +        const void *saddr, unsigned int len)
> > > > > +{
> > > > > +    struct bonding *bond =3D netdev_priv(dev);
> > > > > +    struct net_device *slave_dev;
> > > > > +
> > > > > +    slave_dev =3D bond->header_slave_dev;
> > > > > +
> > > > > +    return dev_hard_header(skb, slave_dev, type, daddr, saddr, l=
en);
> > > > > +}
> > > > > +
> > > > > +static void bond_header_cache_update(struct hh_cache *hh, const
> > > > > struct net_device *dev,
> > > > > +        const unsigned char *haddr)
> > > > > +{
> > > > > +    const struct bonding *bond =3D netdev_priv(dev);
> > > > > +    struct net_device *slave_dev;
> > > > > +
> > > > > +    slave_dev =3D bond->header_slave_dev;
> > > >
> > > > I do not see any barrier ?
> > > >
> > > > > +
> > > > > +    if (!slave_dev->header_ops || !slave_dev->header_ops->cache_=
update)
> > > > > +        return;
> > > > > +
> > > > > +    slave_dev->header_ops->cache_update(hh, slave_dev, haddr);
> > > > > +}
> > > > > +
> > > > >  static void bond_setup_by_slave(struct net_device *bond_dev,
> > > > >                  struct net_device *slave_dev)
> > > > >  {
> > > > > +    struct bonding *bond =3D netdev_priv(bond_dev);
> > > > >      bool was_up =3D !!(bond_dev->flags & IFF_UP);
> > > > >
> > > > >      dev_close(bond_dev);
> > > > >
> > > > > -    bond_dev->header_ops        =3D slave_dev->header_ops;
> > > > > +    /* Some functions are given dev as an argument
> > > > > +     * while others not. When dev is not given, we cannot
> > > > > +     * find out what is the slave device through struct bonding
> > > > > +     * (the private data of bond_dev). Therefore, we need a raw
> > > > > +     * header_ops variable instead of its pointer to const heade=
r_ops
> > > > > +     * and assign slave's functions directly.
> > > > > +     * For the other case, we set the wrapper functions that pas=
s
> > > > > +     * slave_dev to the wrapped functions.
> > > > > +     */
> > > > > +    bond->bond_header_ops.create =3D bond_hard_header;
> > > > > +    bond->bond_header_ops.cache_update =3D bond_header_cache_upd=
ate;
> > > > > +    if (slave_dev->header_ops) {
> > > > > +        bond->bond_header_ops.parse =3D slave_dev->header_ops->p=
arse;
> > > > > +        bond->bond_header_ops.cache =3D slave_dev->header_ops->c=
ache;
> > > > > +        bond->bond_header_ops.validate =3D slave_dev->header_ops=
->validate;
> > > > > +        bond->bond_header_ops.parse_protocol =3D
> > > > > slave_dev->header_ops->parse_protocol;
> > > >
> > > > All these updates probably need WRITE_ONCE(), and corresponding
> > > > READ_ONCE() on reader sides, at a very minimum ...
> > > >
> > > > RCU would even be better later.
> > > >
> > > I believe that locking is not necessary in this patch. The update of
> > > `header_ops` only happens when a slave is newly enslaved to a bond.
> > > Under such circumstances, members of `header_ops` are not called in
> > > parallel with updating. Therefore, there is no possibility of race
> > > conditions occurring.
> >
> > bond_dev can certainly be live, and packets can flow.
> >
> > I have seen enough syzbot reports hinting at this precise issue.

