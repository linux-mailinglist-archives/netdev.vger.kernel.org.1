Return-Path: <netdev+bounces-150113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE79E8F72
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB61887478
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EFC2165EE;
	Mon,  9 Dec 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHITg4Dn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F052163B9
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738054; cv=none; b=KzwbJrfOLmnORi2GiDF8d4G08P4ewWslBNTd0QT4dvcUk7j0AoSueAKFmSw+EJDZhU2l8QdEI27Yiz0q4r8Sm8Zsat0EUGRUsqNDjbOG42438O+r/0ZlLVlsG/4OMiB8Qe9MyrklWfuT/GGEZRL65EdLfAuLmAmO3gD+RGpZoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738054; c=relaxed/simple;
	bh=adWliryBqBnkD1/9Xw4i1TnHLqPQRCSjbcn/J9tDniA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjB9qBH2KY2fIeA0znaKfhZlS0ejkRpvMeKh7wPm1QRkiQ1E+2iUeJo27N3lP9Do7a5STMvz0ZDEMWV8PpxXzQXaLKkhTRXotSftpE+5GigD//qajADaHt+BtOeo5PT9rC5SDCkYu7U6NNq8iyfnZZIHiU7s3knoJ6Sm+8kTqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHITg4Dn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so5044862a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 01:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733738050; x=1734342850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z90vmIbv+VR85bTSUpCLb0JjbFfwE0x6MOgS/fn7Gwc=;
        b=UHITg4Dn6VdaJANjk/G0kbfOlxcBZo83WmKqe0txw3UV3LPfuSxwToUvaAfpeXjI5T
         QZGn+D5bM0yIBzjjCcYGv1zxinKG7HrHp3HBzWy+u+81SaPFjak4zKDxvs2w34jYw/t9
         IcMspicUOPstN9U1aLb/NgaCRJqkvIDAYql8qiaGIUxSo/EimloRs4VSqIH126/KqvG8
         CUBEwvHb96xrmfWz+k3r7Vt56nXlsyGSZ0wvGP7zkylTBVppaDVUGbXqPpDWMi1JYFFK
         ftMcNSTvB8VpubJLuDcEa2W+Z37zHgprztDwUVpeMdX30CU2Sl85LkPPmvteDbKAl514
         qbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738050; x=1734342850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z90vmIbv+VR85bTSUpCLb0JjbFfwE0x6MOgS/fn7Gwc=;
        b=nqXtlmzhRb5MDiPnvh2hLUTmeWPEhapvIlTMq2yrEwl3vPTWm4QEqsA7eqfR8jvj81
         FzRFbo7HUcylJ9n+i93/muMsvJ5GUVwvpfjPIby+B4lIb9Xz+m78EVHROKDQUdTJAjDD
         LQJba8aGKLak4uMw2fpOG8/fv1guTff2JkNYSLo6DJvoG4f0mQ4TvQhn2f6N7UsOVQNB
         m3z51v9BuKPOF1MHgoxTcqvCw4Px1s0MJg18nbQJvoofqv/fGb6u944AUiKxUYtFxXkl
         2iPUcwE3Kt5Us553M1+g1Iz9nKhGg53tgoOv6TI7Kk5tc7ENQzP2X2mJOH1Ot+tPj53h
         kMhg==
X-Forwarded-Encrypted: i=1; AJvYcCXZJx1nqV5XMUqtSLpdv9osGE5NPWJOtGSwXcjd4i/bnBNhbRO8TBS+f6PYpQT7hR6//c00L48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiHc3JREqsNH3In4p4b5Ob1eEi9otRzJcCqw4eyQZD9mCn5F7
	KsQPXzjGqGwNASDXJndnl4/Th/yTyIwmjkVTKCYig8cOIf1H0UMce4X1uMEbeUVF7rIODFXa+i6
	5jeShCKtbRHFeQKkwfOLFR9ZZWJuU9MouNHXm
X-Gm-Gg: ASbGncv2TEcwV5Rm3ZrSaEu30b/YoRzgi9hfojffvh7Q+jzECrH7dpNBrsRFacLP1nP
	/2L2Ap3Ww0CnU72riITiierByXY7BKEnfUw==
X-Google-Smtp-Source: AGHT+IEo5pDEU4N38AAz+DWSXyy4OXHLbF9n6MUBw0Fy4ysO4o+APnR74a4o/PKw+R6yXoobxUTVZ3aAbhaGeBkQzrQ=
X-Received: by 2002:a05:6402:1f4d:b0:5d2:723c:a57e with SMTP id
 4fb4d7f45d1cf-5d3be6b2d84mr14268418a12.16.1733738050016; Mon, 09 Dec 2024
 01:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207162248.18536-1-edumazet@google.com> <20241207162248.18536-2-edumazet@google.com>
 <Z1XeHQJkeJQ1OBFz@shredder>
In-Reply-To: <Z1XeHQJkeJQ1OBFz@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Dec 2024 10:53:59 +0100
Message-ID: <CANn89iL-GyiBd80UOn5-sqeCHXkbVJ=vXTk91c7vAmTsO6M8iA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] rtnetlink: add ndo_fdb_dump_context
To: Ido Schimmel <idosch@idosch.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 6:57=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wro=
te:
>
> On Sat, Dec 07, 2024 at 04:22:46PM +0000, Eric Dumazet wrote:
> > rtnl_fdb_dump() and various ndo_fdb_dump() helpers share
> > a hidden layout of cb->ctx.
> >
> > Before switching rtnl_fdb_dump() to for_each_netdev_dump()
> > in the following patch, make this more explicit.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> A couple of nits in case you have v2
>
> > ---
> >  .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  3 ++-
> >  drivers/net/ethernet/mscc/ocelot_net.c        |  3 ++-
> >  drivers/net/vxlan/vxlan_core.c                |  5 ++--
> >  include/linux/rtnetlink.h                     |  7 ++++++
> >  net/bridge/br_fdb.c                           |  3 ++-
> >  net/core/rtnetlink.c                          | 24 +++++++++----------
> >  net/dsa/user.c                                |  3 ++-
> >  7 files changed, 30 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/driv=
ers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index a293b08f36d46dfde7e25412951da78c15e2dfd6..de383e6c6d523f01f02cb3c=
3977b1c448a3ac9a7 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > @@ -781,12 +781,13 @@ static int dpaa2_switch_fdb_dump_nl(struct fdb_du=
mp_entry *entry,
> >                                   struct ethsw_dump_ctx *dump)
> >  {
> >       int is_dynamic =3D entry->type & DPSW_FDB_ENTRY_DINAMIC;
> > +     struct ndo_fdb_dump_context *ctx =3D (void *)dump->cb->ctx;
>
> Any reason not to maintain reverse xmas tree here?

None, will fix in v2.

>
> >       u32 portid =3D NETLINK_CB(dump->cb->skb).portid;
> >       u32 seq =3D dump->cb->nlh->nlmsg_seq;
> >       struct nlmsghdr *nlh;
> >       struct ndmsg *ndm;
> >
> > -     if (dump->idx < dump->cb->args[2])
> > +     if (dump->idx < ctx->fdb_idx)
> >               goto skip;
> >
> >       nlh =3D nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
>
> [...]
>
> > diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> > index 14b88f55192085def8f318c7913a76d5447b4975..a91dfea64724615c9db7786=
46e52cb8573f47e06 100644
> > --- a/include/linux/rtnetlink.h
> > +++ b/include/linux/rtnetlink.h
> > @@ -178,6 +178,13 @@ void rtnetlink_init(void);
> >  void __rtnl_unlock(void);
> >  void rtnl_kfree_skbs(struct sk_buff *head, struct sk_buff *tail);
> >
> > +/* Shared by rtnl_fdb_dump() and various ndo_fdb_dump() helpers. */
> > +struct ndo_fdb_dump_context {
> > +     unsigned long s_h;
> > +     unsigned long s_idx;
> > +     unsigned long fdb_idx;
> > +};
> > +
> >  extern int ndo_dflt_fdb_dump(struct sk_buff *skb,
> >                            struct netlink_callback *cb,
> >                            struct net_device *dev,
> > diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > index 82bac2426631bcea63ea834e72f074fa2eaf0cee..902694c0ce643ec448978e4=
c4625692ccb1facd9 100644
> > --- a/net/bridge/br_fdb.c
> > +++ b/net/bridge/br_fdb.c
> > @@ -955,6 +955,7 @@ int br_fdb_dump(struct sk_buff *skb,
> >               struct net_device *filter_dev,
> >               int *idx)
> >  {
> > +     struct ndo_fdb_dump_context *ctx =3D (void *)cb->ctx;
> >       struct net_bridge *br =3D netdev_priv(dev);
> >       struct net_bridge_fdb_entry *f;
> >       int err =3D 0;
>
> Unlikely that the context will ever grow past 48 bytes, but might be
> worthwhile to add:
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index cdedb46edc2f..8fe252c298a2 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4919,6 +4919,8 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struc=
t netlink_callback *cb)
>         int fidx =3D 0;
>         int err;
>
> +       NL_ASSERT_CTX_FITS(struct ndo_fdb_dump_context);
> +

Good idea, will be included in v2, thanks !

