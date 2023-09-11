Return-Path: <netdev+bounces-32759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BD79A374
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7E42810CD
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066F23CE;
	Mon, 11 Sep 2023 06:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD11257B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 06:25:26 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40476109
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 23:25:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so65942611fa.3
        for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694413522; x=1695018322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/EUlCb86WY6Qb/+QyxXPivTkZ7TtVbjn5pZACa0+yM=;
        b=ZZffSLH6lVam3NFNKmiSa5hdWNbfK0DbrWRJXamLMeaHBCycfafDTAoqWGSmboxdBV
         kPLoroNUxZEZDkphWkNgaJKDnnm9AOeBcHQU0j7Cn59dEXFcCMj7UYOfAHfIaRRrYF2C
         ohZ9UC9cLKdxmfxePODLE0aA5a8i4iw0hwNJqmcS3Nap1UNnBRyGnZ68VsIJoCh7Zp2s
         PKqvkNvcv/xa1VmzqxNF6ukWHNVqsQAS2BFFBbzxMutZhlcE/IHcVNE1F3ysqyk+AJaP
         HmPP/reyLx1K0KuAKppDj5ZrUvDfoN1w+oGRLibU21aWk6nr1J3q+vQ2nILqocRpp7kT
         u/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694413522; x=1695018322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/EUlCb86WY6Qb/+QyxXPivTkZ7TtVbjn5pZACa0+yM=;
        b=sF4JmIkRHxBMu94xbeYXEj1j9bEp6XlOvxEh3BB23oa8KI7+rdajVmKrb3srvBrlef
         hKBbQjd2lNk4LrcFLvi8qYGfWdCZjjcJbEXnMD2tCdUqdKB5yo49JwxzssG+PmfGEeOv
         YaQ/1RCLrOfXFG7nUhTPmLdMP+SGzJybSyoM9ejvFObcraD22e+IitJV7inWYkm4uhWg
         rbHKJDQ7wl0Yfe/83THfB4F7GkF9p8R3Gk90e3ce/Uus4PBoP423upG7N3ctABS0eRkb
         LWSVAYoUjkPZxJMd2T0lPNZigpepsWt4vnJFmFRrYvjOAs2M8vDpbh/+cKTWrbSFCosj
         vqNw==
X-Gm-Message-State: AOJu0YxZ2Ny3hWUJHX22/nCghLzzZLCq6pV9bJID36xsfIalRcygDYZ1
	dFfMiigbVz955bGkTsfO1lStsb5i8IVmD4zVsD8=
X-Google-Smtp-Source: AGHT+IGADPDAaEJK4oQO8B/eEBBft0iXEstAt5ba6Lk2cFtHFLYXD3wmu2crRmvlyCSMs0wL4yZ/eLj8noq/KNaTmss=
X-Received: by 2002:a2e:9c50:0:b0:2ba:7b3b:4b7d with SMTP id
 t16-20020a2e9c50000000b002ba7b3b4b7dmr6391502ljj.17.1694413521974; Sun, 10
 Sep 2023 23:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906103508.6789-1-liangchen.linux@gmail.com>
 <ZPj98UXjJdsEsVJQ@d3> <CAKhg4tL+stODiv8hG0YWmU8zCKR4CsDOEvv7XD-S9PMdas5i_w@mail.gmail.com>
 <ZPowVxHPwe+Dvn0i@d3>
In-Reply-To: <ZPowVxHPwe+Dvn0i@d3>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 11 Sep 2023 14:25:08 +0800
Message-ID: <CAKhg4t+s1aCvR1zfkaXMFcUAvDAYsZqgOss4i=RaWV_6yn4HHw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] pktgen: Introducing a parameter for
 non-shared skb testing
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 4:19=E2=80=AFAM Benjamin Poirier
<benjamin.poirier@gmail.com> wrote:
>
> On 2023-09-07 11:54 +0800, Liang Chen wrote:
> > On Thu, Sep 7, 2023 at 6:32=E2=80=AFAM Benjamin Poirier
> > <benjamin.poirier@gmail.com> wrote:
> > >
> > > On 2023-09-06 18:35 +0800, Liang Chen wrote:
> > > > Currently, skbs generated by pktgen always have their reference cou=
nt
> > > > incremented before transmission, leading to two issues:
> > > >   1. Only the code paths for shared skbs can be tested.
> > > >   2. Skbs can only be released by pktgen.
> > > > To enhance testing comprehensiveness, introducing the "skb_single_u=
ser"
> > > > parameter, which allows skbs with a reference count of 1 to be
> > > > transmitted. So we can test non-shared skbs and code paths where sk=
bs
> > > > are released within the network stack.
> > >
> > > If my understanding of the code is correct, pktgen operates in the sa=
me
> > > way with parameter clone_skb =3D 0 and clone_skb =3D 1.
> > >
> >
> > Yeah. pktgen seems to treat user count of 2 as not shared, as long as
> > the skb is not reused for burst or clone_skb. In that case the only
> > thing left to do with the skb is to check if user count is
> > decremented.
> >
> > > clone_skb =3D 0 is already meant to work on devices that don't suppor=
t
> > > shared skbs (see IFF_TX_SKB_SHARING check in pktgen_if_write()). Inst=
ead
> > > of introducing a new option for your purpose, how about changing
> > > pktgen_xmit() to send "not shared" skbs when clone_skb =3D=3D 0?
> > >
> >
> > Using clone_skb =3D 0 to enforce non-sharing makes sense to me. However=
,
> > we are a bit concerned that such a change would affect existing users
> > who have been assuming the current behavior.
>
> I looked into it more and mode netif_receive only supports clone_skb =3D =
0
> and normally reuses the same skb all the time. In order to support
> shared/non-shared, I think a new parameter is needed, indeed.
>

Sure, we will introduce a new parameter and store the value in the
flag, as you suggested below. Thanks.

> Here are some comments on the rest of the patch:
>
> > ---
> >  net/core/pktgen.c | 39 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 36 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > index f56b8d697014..8f48272b9d4b 100644
> > --- a/net/core/pktgen.c
> > +++ b/net/core/pktgen.c
> > @@ -423,6 +423,7 @@ struct pktgen_dev {
> >       __u32 skb_priority;     /* skb priority field */
> >       unsigned int burst;     /* number of duplicated packets to burst =
*/
> >       int node;               /* Memory node */
> > +     int skb_single_user;    /* allow single user skb for transmission=
 */
> >
> >  #ifdef CONFIG_XFRM
> >       __u8    ipsmode;                /* IPSEC mode (config) */
> > @@ -1805,6 +1806,17 @@ static ssize_t pktgen_if_write(struct file *file=
,
> >               return count;
> >       }
> >
> > +     if (!strcmp(name, "skb_single_user")) {
> > +             len =3D num_arg(&user_buffer[i], 1, &value);
> > +             if (len < 0)
> > +                     return len;
> > +
> > +             i +=3D len;
> > +             pkt_dev->skb_single_user =3D value;
> > +             sprintf(pg_result, "OK: skb_single_user=3D%u", pkt_dev->s=
kb_single_user);
> > +             return count;
> > +     }
> > +
>
> Since skb_single_user is a boolean, it seems that it should be a flag
> (pkt_dev->flags), not a parameter.
>
> Since "non shared" skbs don't really have a name, I would suggest to
> avoid inventing a new name and instead call the flag "SHARED" and make
> it on by default. So the user would unset the flag to enable the new
> behavior.
>
> This patch should also document the new option in
> Documentation/networking/pktgen.rst
>

Sure, "SHARED" sounds good to me as well, and the relevant document
will be supplied.

> >       sprintf(pkt_dev->result, "No such parameter \"%s\"", name);
> >       return -EINVAL;
> >  }
> > @@ -3460,6 +3472,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_d=
ev)
> >               return;
> >       }
> >
> > +     /* If clone_skb, burst, or count parameters are configured,
> > +      * it implies the need for skb reuse, hence single user skb
> > +      * transmission is not allowed.
> > +      */
> > +     if (pkt_dev->skb_single_user && (pkt_dev->clone_skb ||
> > +                                      burst > 1 || pkt_dev->count))
> > +             pkt_dev->skb_single_user =3D 0;
> > +
>
> count > 0 does not imply reuse. That restriction can be lifted.
>

If 'count' is set, pktgen_wait_for_skb waits for the completion of the
last sent skb by polling the user count. So it still has an implicit
dependency on the user count.

> Instead of silently disabling the option, how about adding these checks
> to pktgen_if_write()? The "clone_skb" parameter works that way, for
> example.
>

Yes, silently disabling the option can be confusing for users. We will
make this a parameter condition check instead.

> >       /* If no skb or clone count exhausted then get new one */
> >       if (!pkt_dev->skb || (pkt_dev->last_ok &&
> >                             ++pkt_dev->clone_count >=3D pkt_dev->clone_=
skb)) {
> > @@ -3483,7 +3503,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_de=
v)
> >       if (pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) {
> >               skb =3D pkt_dev->skb;
> >               skb->protocol =3D eth_type_trans(skb, skb->dev);
> > -             refcount_add(burst, &skb->users);
> > +             if (!pkt_dev->skb_single_user)
> > +                     refcount_add(burst, &skb->users);
> >               local_bh_disable();
> >               do {
> >                       ret =3D netif_receive_skb(skb);
> > @@ -3491,6 +3512,12 @@ static void pktgen_xmit(struct pktgen_dev *pkt_d=
ev)
> >                               pkt_dev->errors++;
> >                       pkt_dev->sofar++;
> >                       pkt_dev->seq_num++;
> > +
> > +                     if (pkt_dev->skb_single_user) {
> > +                             pkt_dev->skb =3D NULL;
> > +                             break;
> > +                     }
> > +
>
> The assignment can be moved out of the loop, with the other 'if' in the
> previous hunk.
>

Sure.

> >                       if (refcount_read(&skb->users) !=3D burst) {
> >                               /* skb was queued by rps/rfs or taps,
> >                                * so cannot reuse this skb
> > @@ -3509,7 +3536,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_de=
v)
> >               goto out; /* Skips xmit_mode M_START_XMIT */
> >       } else if (pkt_dev->xmit_mode =3D=3D M_QUEUE_XMIT) {
> >               local_bh_disable();
> > -             refcount_inc(&pkt_dev->skb->users);
> > +             if (!pkt_dev->skb_single_user)
> > +                     refcount_inc(&pkt_dev->skb->users);
> >
> >               ret =3D dev_queue_xmit(pkt_dev->skb);
> >               switch (ret) {
> > @@ -3517,6 +3545,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_de=
v)
> >                       pkt_dev->sofar++;
> >                       pkt_dev->seq_num++;
> >                       pkt_dev->tx_bytes +=3D pkt_dev->last_pkt_size;
> > +                     if (pkt_dev->skb_single_user)
> > +                             pkt_dev->skb =3D NULL;
>
> >                       break;
> >               case NET_XMIT_DROP:
> >               case NET_XMIT_CN:
>
> This code can lead to a use after free of pkt_dev->skb when
> dev_queue_xmit() returns ex. NET_XMIT_DROP. The skb has been freed by
> the stack but pkt_dev->skb is still set.
>
> It can be triggered like this:
> ip link add dummy0 up type dummy
> tc qdisc add dev dummy0 clsact
> tc filter add dev dummy0 egress matchall action drop
> And then run pktgen on dummy0 with "skb_single_user 1" and "xmit_mode
> queue_xmit"

Sure. Thanks for pointing out this issue! It will be fixed in v2.


Thanks,
Liang

