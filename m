Return-Path: <netdev+bounces-245678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5EBCD5144
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 09:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF57C30069A5
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0E03148A3;
	Mon, 22 Dec 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="UcYgICMm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3EA309EF4
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391642; cv=none; b=TMSpr42317QggnAeqjkA1ijdf8/eIa6ksPdHfxx5jy4G9DK0bZstoiUUMFDRB1I3uAHzkmRDi/kKIij8fqe4Qinr0Ttgq0/sLjokvOnzzpPIUe9b7q6UGZpleZ85BR+Kw+AHSzJ/Sdi8yk4P0dCD9ynD8WoYDhx7s2+FKtviVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391642; c=relaxed/simple;
	bh=TfXKPvtAwYa3TXExy4kQk1h5Bl9Hq5LwnLjyUl82o4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhVUsQStgQF+11aZUM/S/jzLTpAStQKyZNv8Iifp2hdOTdLIMuQn4plEsk7XixvowXOVLGyIl/Ec1VoITEh2zkkwZi8dhS8svpRcukdrQqZUjbdLlfCS7iqqx39848Jwz3CeqiVqz77xKyhOi9VqEWCK0uIckutcWA5ndxibPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=UcYgICMm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso7215805a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 00:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1766391639; x=1766996439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vFrug2aexRUXQele0J+Z94eTfXsf6Puge4QHqxZySA=;
        b=UcYgICMmj9NGOYKtq1yYHngJ0Hk9VwZvRur+o/eiLwPngbTa9XugckifrIX6p6YpYc
         SmNY7t17AdD5xf2HZj7S5DFtxDwGiwBFq32PsXvFKHaRXwXiFbK+5ebqbgzgpRJWYM0+
         dJr16CuYBwTjbpJOX4Jaemv5lMESGg6DBeMsATpJQhNhKZy5D1HlSYFgUQVTim1Bn5F5
         51mQw6qa+UkgiPUan7+bQgQXaogqfy7OUFZZg7/cX7GxrBOkfvpik9wNdyLw46joMeVX
         FfD0smR8tp8iEt338wiLjO0l0+fxJ7vWls+ZF9elLc79HKTRfkcMJSaeNqTrL2KFMM5Y
         LqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766391639; x=1766996439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4vFrug2aexRUXQele0J+Z94eTfXsf6Puge4QHqxZySA=;
        b=Fk8/yW4Aq2SR7PGURa5JIyn5fs+SfjFULQLvcOWPhvG64UfM5VvG7j+foJCtARNbdp
         6LXHcPhreBIQji+96waCK+dskWrbkldfe7HL0Dk9RfbNB9PT6qL7LzZqioQup7tRTclx
         5kYzSfcp2VPYiF8a2ZJVQLhlX4wJb8+5+/h9DOKEgv9fi9Wd06TEjWFNidS4G1DJh4N1
         Fw97Iom/4WxE2zC4v2huUwSUlEvHCGxijYxE+ppFEMgn9WJ5tEYdpgdSzDFTJ1hRhjVN
         wR/+2cET+0C4HZZgg15zQSmK/mNC329UWBZO+mAULqt51x37mGIkaan7brTidUAwEqlj
         fLrw==
X-Forwarded-Encrypted: i=1; AJvYcCXF82XIjW7qd9RSWgmP+r/RUiOoPH5RZlh0BZUWKO8DJL+R4Rfnz1jxJD6TLJVyrVH2/xt6tSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulKtfwFuUYjFCM7q6xEIFxCNe4BnmRaG/fRpoLXjpHlDox0/U
	IxA3vrzzD7I9Z6PC8zdys6IRzxPRub8UztcA/o46FptDEa5c/quFNDL5L7yohpXabkaOZxxFNeS
	p+YvfovGeIqDkfXiUyAA8kMSftd9MZxl/sjJblLF0uw==
X-Gm-Gg: AY/fxX7YtO4gfLX95pR4B6AYiLzZW3g8GyuBAYPAMc3djJuMlmZ1zvFB9OvH1+Iez58
	TCgy8xd/oOuDmORx1FxfdZpMbIdc5ufyyZbPYnmNpIN42TsrWomGS3EPyIJxcOC+WR5XeDKXBGH
	h8poLIZNj1JPeT0PEoHia4OiMEpn5rb+RzLQFGzWTx4tb2SVjsqcDeUMItcAUnpGsbcAdOY7yV7
	Dj5SXAZy/oo6BcRPg3MpAmOoDgZhrErsnKg45aqK417IAlWZXt3LcyGmPLjYsJS/am9asmAXQ==
X-Google-Smtp-Source: AGHT+IEhuT1EpOHmHrxi2B/NBYWIYd2nesuOmJD1H+aT4j28E6IFQZcK1380CiXvJUOUXu5hkAV5YV6sGOhZqT5IgP0=
X-Received: by 2002:a17:907:6ea3:b0:b76:cf68:72a7 with SMTP id
 a640c23a62f3a-b80205ea0e2mr1344813766b.27.1766391638508; Mon, 22 Dec 2025
 00:20:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com> <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
In-Reply-To: <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
From: =?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>
Date: Mon, 22 Dec 2025 17:20:02 +0900
X-Gm-Features: AQt7F2qyOV1gIjrNuXaLe1luyTOq-SD-YtCiBIsiJJaBmLWRU9dL9WBmrTLwjPs
Message-ID: <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: Eric Dumazet <edumazet@google.com>
Cc: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Eric and other maintainers,

I'm deeply sorry to have left the patch suggestion for this long period.
I became extremely busy, and that took its toll on my health, causing
me to take sick leave for nearly half a year (And my colleague Kota
had been waiting for me to come back).
As fortunately I've recovered and returned to work, I hope to move
forward with this matter as well.

Recalling the issue Eric raised, I understand it was a concern about
potential race conditions arising from the `bond_header_ops` and
`header_slave_dev` added to the `struct bonding`. For example, one
could imagine a situation where `header_slave_dev` is rewritten to a
different type, and at that exact moment a function from the old
`bond_header_ops` gets called, or vice versa.

However, I am actually skeptical that this can happen. The reason is
that `bond_setup_by_slave` is only called when there are no slaves at
all:

```
bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
             struct netlink_ext_ack *extack)
...
  if (!bond_has_slaves(bond)) {
...
      if (slave_dev->type !=3D ARPHRD_ETHER)
        bond_setup_by_slave(bond_dev, slave_dev);
```

In other words, in order to trigger a race condition, one would need
to remove the slave once and make the slave list empty first. However,
as shown below, in `bond_release_and_destroy`, when the slave list
becomes empty, it appears that the bond interface itself is removed.
This makes it seem impossible to "quickly remove a slave and
re-register it.":

```
static int bond_slave_netdev_event(unsigned long event,
           struct net_device *slave_dev)
...
  switch (event) {
  case NETDEV_UNREGISTER:
    if (bond_dev->type !=3D ARPHRD_ETHER)
      bond_release_and_destroy(bond_dev, slave_dev);
...
}
...
/* First release a slave and then destroy the bond if no more slaves are le=
ft.
 * Must be under rtnl_lock when this function is called.
 */
static int bond_release_and_destroy(struct net_device *bond_dev,
            struct net_device *slave_dev)
{
  struct bonding *bond =3D netdev_priv(bond_dev);
  int ret;

  ret =3D __bond_release_one(bond_dev, slave_dev, false, true);
  if (ret =3D=3D 0 && !bond_has_slaves(bond) &&
      bond_dev->reg_state !=3D NETREG_UNREGISTERING) {
    bond_dev->priv_flags |=3D IFF_DISABLE_NETPOLL;
    netdev_info(bond_dev, "Destroying bond\n");
    bond_remove_proc_entry(bond);
    unregister_netdevice(bond_dev);
  }
  return ret;
}
```

Moreover, as noted in the comments, these functions are executed under
the netlink-side lock. Therefore, my conclusion is that a race
condition cannot actually occur. I also think that the fact that, even
before our patch, these code paths had almost no explicit locking
anywhere serves as circumstantial evidence for this view. As Kota
said, as far as I saw, the past syzkaller-bot's report is seemingly
only NULL pointer dereference due to the root cause we reported, and
this patch should fix them.

That said, even so, I agree that the kind of countermeasures Eric
suggests are worth applying if they do not cause problems in terms of
execution speed or code size. However, I am concerned that addressing
this with READ_ONCE or RCU would imply a somewhat large amount of
rewriting.
`header_ops` is designed to allow various types of devices to be
handled in an object-oriented way, and as such it is used throughout
many parts of the Linux kernel. Using READ_ONCE or RCU every time
header_ops is accessed simply because we are worried about a race
condition in bond=E2=80=99s header_ops seems to imply changes like the
following, for example:

```
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 92dc1f1788de..d9aad38746ad 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1538,7 +1538,7 @@ static void neigh_hh_init(struct neighbour *n)
  * hh_cache entry.
  */
  if (!hh->hh_len)
- dev->header_ops->cache(n, hh, prot);
+ READ_ONCE(dev->header_ops->cache)(n, hh, prot);

  write_unlock_bh(&n->lock);
 }
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3131,35 +3131,41 @@ static inline int dev_hard_header(struct
sk_buff *skb, struct net_device *dev,
   const void *daddr, const void *saddr,
   unsigned int len)
 {
- if (!dev->header_ops || !dev->header_ops->create)
+ int (*create)(struct sk_buff *skb, struct net_device *dev,
+      unsigned short type, const void *daddr,
+      const void *saddr, unsigned int len);
+ if (!dev->header_ops || !(create =3D READ_ONCE(dev->header_ops->create)))
  return 0;

- return dev->header_ops->create(skb, dev, type, daddr, saddr, len);
+ return create(skb, dev, type, daddr, saddr, len);
 }

 static inline int dev_parse_header(const struct sk_buff *skb,
    unsigned char *haddr)
 {
+ int (*parse)(const struct sk_buff *skb, unsigned char *haddr);
  const struct net_device *dev =3D skb->dev;

- if (!dev->header_ops || !dev->header_ops->parse)
+ if (!dev->header_ops || !(parse =3D READ_ONCE(dev->header_ops->parse)))
  return 0;
- return dev->header_ops->parse(skb, haddr);
+ return parse(skb, haddr);
 }
... (and so on)
```

It looks like we would end up rewriting on the order of a dozen or so
places with this kind of pattern, but from the perspective of the
maintainers (or in terms of Linux kernel culture), would this be
considered an acceptable change?
If this differs from what you intended, please correct me.

Best regards,
Yuki Koike

2025=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=9C=A8) 0:10 Eric Dumazet <edumazet@g=
oogle.com>:
>
> On Wed, May 28, 2025 at 7:36=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=
=AA <kota.toda@gmo-cybersecurity.com> wrote:
> >
> > Thank you for your review.
> >
> > 2025=E5=B9=B45=E6=9C=8826=E6=97=A5(=E6=9C=88) 17:23 Eric Dumazet <eduma=
zet@google.com>:
> > >
> > > On Sun, May 25, 2025 at 10:08=E2=80=AFPM =E6=88=B8=E7=94=B0=E6=99=83=
=E5=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> > > >
> > > > In bond_setup_by_slave(), the slave=E2=80=99s header_ops are uncond=
itionally
> > > > copied into the bonding device. As a result, the bonding device may=
 invoke
> > > > the slave-specific header operations on itself, causing
> > > > netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpre=
ted
> > > > as the slave's private-data type.
> > > >
> > > > This type-confusion bug can lead to out-of-bounds writes into the s=
kb,
> > > > resulting in memory corruption.
> > > >
> > > > This patch adds two members to struct bonding, bond_header_ops and
> > > > header_slave_dev, to avoid type-confusion while keeping track of th=
e
> > > > slave's header_ops.
> > > >
> > > > Fixes: 1284cd3a2b740 (bonding: two small fixes for IPoIB support)
> > > > Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > > > Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > > > Co-Developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > > > Reviewed-by: Paolo Abeni <pabeni@redhat.com>
> > > > Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > > > ---
> > > >  drivers/net/bonding/bond_main.c | 61
> > > > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  include/net/bonding.h           |  5 +++++
> > > >  2 files changed, 65 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/=
bond_main.c
> > > > index 8ea183da8d53..690f3e0971d0 100644
> > > > --- a/drivers/net/bonding/bond_main.c
> > > > +++ b/drivers/net/bonding/bond_main.c
> > > > @@ -1619,14 +1619,65 @@ static void bond_compute_features(struct bo=
nding *bond)
> > > >      netdev_change_features(bond_dev);
> > > >  }
> > > >
> > > > +static int bond_hard_header(struct sk_buff *skb, struct net_device=
 *dev,
> > > > +        unsigned short type, const void *daddr,
> > > > +        const void *saddr, unsigned int len)
> > > > +{
> > > > +    struct bonding *bond =3D netdev_priv(dev);
> > > > +    struct net_device *slave_dev;
> > > > +
> > > > +    slave_dev =3D bond->header_slave_dev;
> > > > +
> > > > +    return dev_hard_header(skb, slave_dev, type, daddr, saddr, len=
);
> > > > +}
> > > > +
> > > > +static void bond_header_cache_update(struct hh_cache *hh, const
> > > > struct net_device *dev,
> > > > +        const unsigned char *haddr)
> > > > +{
> > > > +    const struct bonding *bond =3D netdev_priv(dev);
> > > > +    struct net_device *slave_dev;
> > > > +
> > > > +    slave_dev =3D bond->header_slave_dev;
> > >
> > > I do not see any barrier ?
> > >
> > > > +
> > > > +    if (!slave_dev->header_ops || !slave_dev->header_ops->cache_up=
date)
> > > > +        return;
> > > > +
> > > > +    slave_dev->header_ops->cache_update(hh, slave_dev, haddr);
> > > > +}
> > > > +
> > > >  static void bond_setup_by_slave(struct net_device *bond_dev,
> > > >                  struct net_device *slave_dev)
> > > >  {
> > > > +    struct bonding *bond =3D netdev_priv(bond_dev);
> > > >      bool was_up =3D !!(bond_dev->flags & IFF_UP);
> > > >
> > > >      dev_close(bond_dev);
> > > >
> > > > -    bond_dev->header_ops        =3D slave_dev->header_ops;
> > > > +    /* Some functions are given dev as an argument
> > > > +     * while others not. When dev is not given, we cannot
> > > > +     * find out what is the slave device through struct bonding
> > > > +     * (the private data of bond_dev). Therefore, we need a raw
> > > > +     * header_ops variable instead of its pointer to const header_=
ops
> > > > +     * and assign slave's functions directly.
> > > > +     * For the other case, we set the wrapper functions that pass
> > > > +     * slave_dev to the wrapped functions.
> > > > +     */
> > > > +    bond->bond_header_ops.create =3D bond_hard_header;
> > > > +    bond->bond_header_ops.cache_update =3D bond_header_cache_updat=
e;
> > > > +    if (slave_dev->header_ops) {
> > > > +        bond->bond_header_ops.parse =3D slave_dev->header_ops->par=
se;
> > > > +        bond->bond_header_ops.cache =3D slave_dev->header_ops->cac=
he;
> > > > +        bond->bond_header_ops.validate =3D slave_dev->header_ops->=
validate;
> > > > +        bond->bond_header_ops.parse_protocol =3D
> > > > slave_dev->header_ops->parse_protocol;
> > >
> > > All these updates probably need WRITE_ONCE(), and corresponding
> > > READ_ONCE() on reader sides, at a very minimum ...
> > >
> > > RCU would even be better later.
> > >
> > I believe that locking is not necessary in this patch. The update of
> > `header_ops` only happens when a slave is newly enslaved to a bond.
> > Under such circumstances, members of `header_ops` are not called in
> > parallel with updating. Therefore, there is no possibility of race
> > conditions occurring.
>
> bond_dev can certainly be live, and packets can flow.
>
> I have seen enough syzbot reports hinting at this precise issue.

