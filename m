Return-Path: <netdev+bounces-241951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5EC8AF83
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230353A4AFE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E630E852;
	Wed, 26 Nov 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i/4xeqzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74253314AB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174583; cv=none; b=C4Ntq64aU6DuSbBj19RMt8JAk2yqXDWRPopvui/+uSWdMQRpIiJp0H05/acUdOZ4UCFTBzXe3ChR8VYAYvU5y8CrwXOoVSqw+UQ7eOfO0ugmHPkYmmiVHGKS5THD2w51hTqoNhAJ+qDdl9M7IL1aKPDArFL4/HTY/rfNMQNEWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174583; c=relaxed/simple;
	bh=FKoRH7uLeXCbjMtA5K+2J5GnBBYr2lCespKor84+gPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqXV5fw+3GZmELcaWTJvpwJtjPV/o5UQT7YvFH+dyQysDCO6Suz/TiXNxDr884zEaZqCLLntbgbe8aBZhS96IAuDPSDhicBe0PwSY26HWAh+TQDtnL5ZHQJv+9wB0aja6L380hobQFyRVR4/cegM2EYez1FvVEgPjtV9Lx9n8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=i/4xeqzJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-343806688c5so5790849a91.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764174581; x=1764779381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSYGOZhUXL1SBiOPZuTTxDIvK3IV8BvhAtp5BU34Cz4=;
        b=i/4xeqzJDARR/2sbr45XE3pVSeCd3Mm53JQaKNbOmOzNHxNU7oomcWm5309d5GT7WW
         mneUZQOsFCjAQ1q3t4EgKzImDASZ0JOJKrrfh40yhZp3+JY4Phhtsr3OVlaxBEiBuz6t
         2JxZ3zz3V/Q7dBiE2CFtw04ABH04pqaEmDPRH/6qEWZBcO0Fknh6A/rwx+5Lfxr1d6xj
         tdmlIa8qke3kd0z6GBGBVS/AH/9iWT0WwS53cKLTvix/AhNz6LCSClWWRpuKKgAh6vJq
         Rl/rx7lvE1QH5yU3ezqgGYHJ9RG0odjL53OtX+GBemKwJKXrK18Qf9P8dpfb/OK/oD/O
         cC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174581; x=1764779381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DSYGOZhUXL1SBiOPZuTTxDIvK3IV8BvhAtp5BU34Cz4=;
        b=oNpAp88QdJBqYH/Cnzcleua1YVGgNAdYwuFfv6VjpdBXoxAj57ZmU5YL/bUdRVSBY5
         sWdBPtI/sTwmPx6LxIun0l11KGAXspEqUP7fn1iXPfipY+Q4eMqvwRYYBoydAHi1uDQs
         MjCDtOBK5NXBtzEP0PnED8f6NA3q5Z2tz33G2QUq60Dm6xb/wa5UAsuTps8QfpUDHqRu
         qve68GzVK9U5Gx3NRAizs4ifJ6MmfKom4SHhyi3DOkdjTnh/YFXT2m7V1wlVBZKOCw74
         KEwWsrJSP46s997jPxffY2usvlEoJo11DV8n5aCWErpSthzc7+H3DTHWRAr7wZQW3O/X
         o5mg==
X-Forwarded-Encrypted: i=1; AJvYcCUTvw3IkiOw0Is2GWdrNRWPUb8fxhjVsuItDOIapkrKkc0vXkB4NlVhdZ6GofPaFyM6Hbt4ggs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZKCiziPYCmGSIrDyYgomM1vywjJ2bFSnZ+NdPRjnB+LFaZWX
	6xia5QiGmF4JTCXfoBxSaZrhJ4JzVdADSPmdZoz9/feOagfAhs7TDx0TNGePTtBZm0LMQv+Y8WW
	pHpaw0FOTX8eBtGB3QVEF9InCMzzCOvrNDUdI7hMg
X-Gm-Gg: ASbGncsUuMAf/lNk1sB7qu/TybiaM1hMiAx9Jb6a/nKLG7baFSvHtUaG0m4kOzVro4k
	KoO/PK1AYiAQLmoG6xT4NutHRySX54c+QGPLWncBX+jtXaGiUmAkGFGoOpxL4Iq0zPAN4WC20SC
	mM6jdzS5EQm4y2vJh4w7ZA+N+29Tk0KkULzWCHaIEAa+oH+ODS/PJaoBzS2k5WPRH0yZwMx4at/
	N1hy5m8+Dj9rw3D++bXcog6v/lcTyeMrrhtXXShnFgwyQu4s0JwrrnKAU33tLwkekO8p+WAerfi
	4Uc=
X-Google-Smtp-Source: AGHT+IEAKuGrJXL9fVITxfkti8HEz++36u3TOcemBUAd2wf4vrpR06oQi2yJ+evaHTLk6+WtsGol0cdBJDp9MzCqkJk=
X-Received: by 2002:a17:90b:3bcc:b0:340:a5b2:c305 with SMTP id
 98e67ed59e1d1-3475ebe6a4amr6137084a91.2.1764174580996; Wed, 26 Nov 2025
 08:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125224604.872351-1-victor@mojatatu.com> <20251125191107.6d9efcfb@phoenix.local>
In-Reply-To: <20251125191107.6d9efcfb@phoenix.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 26 Nov 2025 11:29:29 -0500
X-Gm-Features: AWmQ_bnE9bgwPV3z8E-sesJukKnxBk7uHyLW5m0lU3jtv8_UJASy_xtG3px7Veg
Message-ID: <CAM0EoMkaRoW3ZrAkKzGa7O6wLr_nkYeQpeXbUiw_SCrsFoAQXg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2] net/sched: Introduce qdisc quirk_chk op
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:11=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 25 Nov 2025 19:46:04 -0300
> Victor Nogueira <victor@mojatatu.com> wrote:
>
> > There is a pattern of bugs that end up creating UAFs or null ptr derefs=
.
> > The majority of these bugs follow the formula below:
> > a) create a nonsense hierarchy of qdiscs which has no practical value,
> > b) start sending packets
> > Optional c) netlink cmds to change hierarchy some more; It's more fun i=
f
> > you can get packets stuck - the formula in this case includes non
> > work-conserving qdiscs somewhere in the hierarchy
> > Optional d dependent on c) send more packets
> > e) profit
> >
> > Current init/change qdisc APIs are localised to validate only within th=
e
> > constraint of a single qdisc. So catching #a or #c is a challenge. Our
> > policy, when said bugs are presented, is to "make it work" by modifying
> > generally used data structures and code, but these come at the expense =
of
> > adding special checks for corner cases which are nonsensical to begin w=
ith.
> >
> > The goal of this patchset is to create an equivalent to PCI quirks, whi=
ch
> > will catch nonsensical hierarchies in #a and #c and reject such a confi=
g.
> >
> > With that in mind, we are proposing the addition of a new qdisc op
> > (quirk_chk). We introduce, as a first example, the quirk_chk op to nete=
m.
> > Its purpose here is to validate whether the user is attempting to add 2
> > netem duplicates in the same qdisc tree which will be forbidden unless
> > the root qdisc is multiqueue.
> >
> > Here is an example that should now work:
> >
> > DEV=3D"eth0"
> > NUM_QUEUES=3D4
> > DUPLICATE_PERCENT=3D"5%"
> >
> > tc qdisc del dev $DEV root > /dev/null 2>&1
> > tc qdisc add dev $DEV root handle 1: mq
> >
> > for i in $(seq 1 $NUM_QUEUES); do
> >     HANDLE_ID=3D$((i * 10))
> >     PARENT_ID=3D"1:$i"
> >     tc qdisc add dev $DEV parent $PARENT_ID handle \
> >         ${HANDLE_ID}: netem duplicate $DUPLICATE_PERCENT
> > done
> >
> > Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> > v1 -> v2:
> > - Simplify process of getting root qdisc in netem_quirk_chk
> > - Use parent's major directly instead of looking up parent qdisc in
> >   netem_quirk_chk
> > - Call parse_attrs in netem_quirk_chk to avoid issue caught by syzbot
> >
> > Link to v1:
> > https://lore.kernel.org/netdev/20251124223749.503979-1-victor@mojatatu.=
com/
> > ---
> >  include/net/sch_generic.h |  3 +++
> >  net/sched/sch_api.c       | 12 ++++++++++++
> >  net/sched/sch_netem.c     | 40 +++++++++++++++++++++++++++------------
> >  3 files changed, 43 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 94966692ccdf..60450372c5d5 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -313,6 +313,9 @@ struct Qdisc_ops {
> >                                                    u32 block_index);
> >       void                    (*egress_block_set)(struct Qdisc *sch,
> >                                                   u32 block_index);
> > +     int                     (*quirk_chk)(struct Qdisc *sch,
> > +                                          struct nlattr *arg,
> > +                                          struct netlink_ext_ack *exta=
ck);
> >       u32                     (*ingress_block_get)(struct Qdisc *sch);
> >       u32                     (*egress_block_get)(struct Qdisc *sch);
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index f56b18c8aebf..a850df437691 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1315,6 +1315,12 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,
> >               rcu_assign_pointer(sch->stab, stab);
> >       }
> >
> > +     if (ops->quirk_chk) {
> > +             err =3D ops->quirk_chk(sch, tca[TCA_OPTIONS], extack);
> > +             if (err !=3D 0)
> > +                     goto err_out3;
> > +     }
> > +
> >       if (ops->init) {
> >               err =3D ops->init(sch, tca[TCA_OPTIONS], extack);
> >               if (err !=3D 0)
> > @@ -1378,6 +1384,12 @@ static int qdisc_change(struct Qdisc *sch, struc=
t nlattr **tca,
> >                       NL_SET_ERR_MSG(extack, "Change of blocks is not s=
upported");
> >                       return -EOPNOTSUPP;
> >               }
> > +             if (sch->ops->quirk_chk) {
> > +                     err =3D sch->ops->quirk_chk(sch, tca[TCA_OPTIONS]=
,
> > +                                               extack);
> > +                     if (err !=3D 0)
> > +                             return err;
> > +             }
> >               err =3D sch->ops->change(sch, tca[TCA_OPTIONS], extack);
> >               if (err)
> >                       return err;
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index eafc316ae319..ceece2ae37bc 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
> > @@ -975,13 +975,27 @@ static int parse_attr(struct nlattr *tb[], int ma=
xtype, struct nlattr *nla,
> >
> >  static const struct Qdisc_class_ops netem_class_ops;
> >
> > -static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
> > -                            struct netlink_ext_ack *extack)
> > +static int netem_quirk_chk(struct Qdisc *sch, struct nlattr *opt,
> > +                        struct netlink_ext_ack *extack)
> >  {
> > +     struct nlattr *tb[TCA_NETEM_MAX + 1];
> > +     struct tc_netem_qopt *qopt;
> >       struct Qdisc *root, *q;
> > +     struct net_device *dev;
> > +     bool root_is_mq;
> > +     bool duplicates;
> >       unsigned int i;
> > +     int ret;
> > +
> > +     ret =3D parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*=
qopt));
> > +     if (ret < 0)
> > +             return ret;
> >
> > -     root =3D qdisc_root_sleeping(sch);
> > +     qopt =3D nla_data(opt);
> > +     duplicates =3D qopt->duplicate;
> > +
> > +     dev =3D sch->dev_queue->dev;
> > +     root =3D rtnl_dereference(dev->qdisc);
> >
> >       if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops) {
> >               if (duplicates ||
> > @@ -992,19 +1006,25 @@ static int check_netem_in_tree(struct Qdisc *sch=
, bool duplicates,
> >       if (!qdisc_dev(root))
> >               return 0;
> >
> > +     root_is_mq =3D root->flags & TCQ_F_MQROOT;
> > +
>
> What about HTB or other inherently multi-q qdisc?
> Using netem on HTB on some branches is common practice.

Agreed - this should cover all classful qdiscs. I think the check
comes from the earlier discussion which involves offloadable qdiscs
that have multiple children (where HTB fits as well).
@Victor Nogueira how about check for nested netems with duplicates?

cheers,
jamal

