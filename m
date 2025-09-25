Return-Path: <netdev+bounces-226206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B6BB9E03F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E297AF22D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C03125A2A4;
	Thu, 25 Sep 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGtZsNvi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39B2550BA
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788270; cv=none; b=Q5MrOvfBDwPCkG/FKX/nZ3lRSMWbynJxrCtkJN8zPoSsL/7qoXsE1RcW7wUMKzW+EkTan1NcLRgy1Cc/S9FikT+VWsCBr8S1pSZobh88qhSCvDvmGt0gTJT2CHwr2p2xDQ6XHNlcHeOQaHjkO4nv2xOclNlUDT6PHkFCMWrqfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788270; c=relaxed/simple;
	bh=H0fbgH7DJPth+W9ZqITE2SoYOiWoqj9BDnVJsQSQkMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxFDPDpITX+QFmP/kz01bxDyyWwmMle7d4rAANWx+HRqZpjkkNKrPvpmmv0FnvAeAekeKidY96rJTI5psZlIgVZ26Irx5WthTuVa8WKr987gi8fIUnpvRxee8ijEgTBZVgfCpwlmSH8BAyx+gzZYY8mzGaAgaY7pUIBVLehxPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGtZsNvi; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-425635acc4dso7176935ab.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758788267; x=1759393067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8N4ZuEqPCGod1NU9zpeLpepfC8w/KeKKKiSkfCh5XA=;
        b=kGtZsNviBzayU41nHhUoPQPsfH7eEqtk1+SIcXJ4lBFtU43jiUr7AfGAIkwkqKhWGM
         g5Xz9KxLmO55La5j5wVTg7Eec17zN/RmM35uvRUJIUXIsU2oovAEB+0Hmu49OVKDKslZ
         ba1eyj43Qqj8r01RbxVvBvcIr3VdsicmBCfUD0yUKam1JANo9RG6MKkdlIv1QUe10DIZ
         pz71o2xMjtlMvxorj246Dz3VkNrmgV1btBwYva20qpoNnyVndg9DB/AW+Ecyd1hL5s63
         GWZ9jZvEC3W+doIgr59J1MUf6nBU1xtLl6PAaAeFZRHRQQTJcjhWGjy9ly1+kZeWYnIH
         WQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788267; x=1759393067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8N4ZuEqPCGod1NU9zpeLpepfC8w/KeKKKiSkfCh5XA=;
        b=rPXWsvC6BQmskTVVDTrGpli6HCGJ6PbDNl5gHLt9Do9EP86VKBMyHUpoiuQIHw6uiK
         zsm8lfIho2cm9x56EiR21ukoDJ8PxkyeDhFce8mlA3u4fQ/5lcA/WKn4lIySBvmO0l7m
         2vJccNj2+IYKf9P0Z9q8JYMqCPLhTdzt4TJ1vdvarWRds2sXNWKBwHgr5OfAgnlXeuff
         AYLK85Be2mLSD5HK/iJ4uLrCSYEA9UKMifDHx9NqONsmIU94AfK5QlrwWG4Qka2LfRZL
         EgMbh9FnImkdBtAlROdt1mhfhv7+MlAkPYSMWxgPk5VdMIxYpBclPv/ze2ySoFZouzvy
         NdTA==
X-Forwarded-Encrypted: i=1; AJvYcCUp8RbeAwzC2JfZ/ey7nLoVi2uWSBg7BG9vI/z9c7yDwUIUJuKRtXvg/0I9J5dA6GyU2wEZ7b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwymHH1M34HtL6C+oxTl1DYKBHoYjDqRXZkER2pSqx9hkY751FQ
	MZa6s7x9IVtQTkALtc4fi5FaF++7BTZKJfGQj0n0NAtNTUZpN4XAvsBPIQwR8xtne3aOL9p+xVA
	e8IlV5dHBWYiGqOylLGvAuDKtTBKYd0A=
X-Gm-Gg: ASbGncuWKgnFWxbFUlOhG7GNwqwgiIg3Dbzvasosyloz5txfCge7tuwxGpUy1793rKn
	dJTngTB2I6DC+3E6WfY2Q+qvbxLZnjSgA+fdcQXOZf1Jnl4mKh8J0pLh03p0dI+OA+QS3iktSJ9
	qvt9936dxdG8aITxPfihnOR/N6YX6dKI5nCHRc47kQi+s+hEfbvx6/Gat15CpFZk+dOq6UYkvWW
	4RJjA==
X-Google-Smtp-Source: AGHT+IFrRHVJbHV0X71ZH6nhqx8zPSxjiS/Xeyf35SVCxEP8dKn08ft7srGJJZ4wGZl203i6WNtdnN9c3GuigZ1+ZG4=
X-Received: by 2002:a92:c70f:0:b0:425:80d0:82c6 with SMTP id
 e9e14a558f8ab-42595654edemr34892585ab.26.1758788266872; Thu, 25 Sep 2025
 01:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-3-maciej.fijalkowski@intel.com> <aNGL5qS8aIfcSDnD@mini-arch>
 <CAL+tcoDp0k74jJtUo179J7mkcf1KCAPMy+fWh-Mn7oC236n-kQ@mail.gmail.com>
 <aNQBuQYHGHuekAhV@boxer> <CAL+tcoDkcKNKCe9B1bQvsZEiKmJEVSKJy_gQ-PONu9qqUXF9AQ@mail.gmail.com>
In-Reply-To: <CAL+tcoDkcKNKCe9B1bQvsZEiKmJEVSKJy_gQ-PONu9qqUXF9AQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Sep 2025 16:17:10 +0800
X-Gm-Features: AS18NWAKk4Xsqie09CRcZXrJaEdBBojlkrGnuYQKdbk9c4QkpLwJ8hPKc_FZU2Q
Message-ID: <CAL+tcoD6AhCS-LMKm9R77-ajm0v+Qq9E9JA0KdFuiwJQxCJ1iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:17=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Sep 24, 2025 at 10:36=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Tue, Sep 23, 2025 at 05:25:01PM +0800, Jason Xing wrote:
> > > On Tue, Sep 23, 2025 at 1:48=E2=80=AFAM Stanislav Fomichev <stfomiche=
v@gmail.com> wrote:
> > > >
> > > > On 09/22, Maciej Fijalkowski wrote:
> > > > > Devices that set IFF_TX_SKB_NO_LINEAR will not execute branch tha=
t
> > > > > handles metadata, as we set @first_frag only for !IFF_TX_SKB_NO_L=
INEAR
> > > > > code in xsk_build_skb().
> > > > >
> > > > > Same functionality can be achieved with checking if xsk_get_num_d=
esc()
> > > > > returns 0. To replace current usage of @first_frag with
> > > > > XSKCB(skb)->num_descs check, pull out the code from
> > > > > xsk_set_destructor_arg() that initializes sk_buff::cb and call it=
 before
> > > > > skb_store_bits() in branch that creates skb against first process=
ed
> > > > > frag. This so error path has the XSKCB(skb)->num_descs initialize=
d and
> > > > > can free skb in case skb_store_bits() failed.
> > > > >
> > > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > ---
> > > > >  net/xdp/xsk.c | 20 +++++++++++---------
> > > > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index 72194f0a3fc0..064238400036 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -605,6 +605,13 @@ static u32 xsk_get_num_desc(struct sk_buff *=
skb)
> > > > >       return XSKCB(skb)->num_descs;
> > > > >  }
> > > > >
> > > > > +static void xsk_init_cb(struct sk_buff *skb)
> > > > > +{
> > > > > +     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb)=
);
> > > > > +     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > > > +     XSKCB(skb)->num_descs =3D 0;
> > > > > +}
> > > > > +
> > > > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > > > >  {
> > > > >       struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->x=
sk_meta;
> > > > > @@ -620,9 +627,6 @@ static void xsk_destruct_skb(struct sk_buff *=
skb)
> > > > >
> > > > >  static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr=
)
> > > > >  {
> > > > > -     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb)=
);
> > > > > -     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > > > -     XSKCB(skb)->num_descs =3D 0;
> > > > >       skb_shinfo(skb)->destructor_arg =3D (void *)(uintptr_t)addr=
;
> > > > >  }
> > > > >
> > > > > @@ -672,7 +676,7 @@ static struct sk_buff *xsk_build_skb_zerocopy=
(struct xdp_sock *xs,
> > > > >                       return ERR_PTR(err);
> > > > >
> > > > >               skb_reserve(skb, hr);
> > > > > -
> > > > > +             xsk_init_cb(skb);
> > > > >               xsk_set_destructor_arg(skb, desc->addr);
> > > > >       } else {
> > > > >               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache=
, GFP_KERNEL);
> > > > > @@ -725,7 +729,6 @@ static struct sk_buff *xsk_build_skb(struct x=
dp_sock *xs,
> > > > >       struct xsk_tx_metadata *meta =3D NULL;
> > > > >       struct net_device *dev =3D xs->dev;
> > > > >       struct sk_buff *skb =3D xs->skb;
> > > > > -     bool first_frag =3D false;
> > > > >       int err;
> > > > >
> > > > >       if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > > > > @@ -742,8 +745,6 @@ static struct sk_buff *xsk_build_skb(struct x=
dp_sock *xs,
> > > > >               len =3D desc->len;
> > > > >
> > > > >               if (!skb) {
> > > > > -                     first_frag =3D true;
> > > > > -
> > > > >                       hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev-=
>needed_headroom));
> > > > >                       tr =3D dev->needed_tailroom;
> > > > >                       skb =3D sock_alloc_send_skb(&xs->sk, hr + l=
en + tr, 1, &err);
> > > > > @@ -752,6 +753,7 @@ static struct sk_buff *xsk_build_skb(struct x=
dp_sock *xs,
> > > > >
> > > > >                       skb_reserve(skb, hr);
> > > > >                       skb_put(skb, len);
> > > > > +                     xsk_init_cb(skb);
> > > > >
> > > > >                       err =3D skb_store_bits(skb, 0, buffer, len)=
;
> > > > >                       if (unlikely(err))
> > > > > @@ -797,7 +799,7 @@ static struct sk_buff *xsk_build_skb(struct x=
dp_sock *xs,
> > > > >                       list_add_tail(&xsk_addr->addr_node, &XSKCB(=
skb)->addrs_list);
> > > > >               }
> > > > >
> > > > > -             if (first_frag && desc->options & XDP_TX_METADATA) =
{
> > > > > +             if (!xsk_get_num_desc(skb) && desc->options & XDP_T=
X_METADATA) {
> > > > >                       if (unlikely(xs->pool->tx_metadata_len =3D=
=3D 0)) {
> > > > >                               err =3D -EINVAL;
> > > > >                               goto free_err;
> > > > > @@ -839,7 +841,7 @@ static struct sk_buff *xsk_build_skb(struct x=
dp_sock *xs,
> > > > >       return skb;
> > > > >
> > > > >  free_err:
> > > > > -     if (first_frag && skb)
> > > >
> > > > [..]
> > > >
> > > > > +     if (skb && !xsk_get_num_desc(skb))
> > > > >               kfree_skb(skb);
> > > > >
> > > > >       if (err =3D=3D -EOVERFLOW) {
> > > >
> > > > For IFF_TX_SKB_NO_LINEAR case, the 'goto free_err' is super confusi=
ng.
> > > > xsk_build_skb_zerocopy either returns skb or an IS_ERR. Can we
> > > > add a separate label to jump directly to 'if err =3D=3D -EOVERFLOW'=
 for
> > > > the IFF_TX_SKB_NO_LINEAR case?
> >
> > Right, I got hit with this when running xdpsock within VM now against
> > virtio-net driver. Since I removed @first_frag and sock_alloc_send_skb(=
)
> > managed to give me -EAGAIN at start, skb was treated as valid pointer a=
nd
> > then I got splat when accessing either cb or skb_shared_info.
> >
> > So either we NULL the skb for xsk_build_skb_zerocopy() error path (whic=
h
> > would be fine even for -EOVERFLOW as error path uses xs->skb pointer, n=
ot
> > the local one) or we introduce separate label as you suggest. No strong
> > opinions here.
> >
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 72e34bd2d925..f56182c61c99 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -732,7 +732,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >                 skb =3D xsk_build_skb_zerocopy(xs, desc);
> > > >                 if (IS_ERR(skb)) {
> > > >                         err =3D PTR_ERR(skb);
> > > > -                       goto free_err;
> > > > +                       goto out;
> > > >                 }
> > > >         } else {
> > > >                 u32 hr, tr, len;
> > > > @@ -842,6 +842,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >         if (first_frag && skb)
> > > >                 kfree_skb(skb);
> > > >
> > > > +out:
> > > >         if (err =3D=3D -EOVERFLOW) {
> > > >                 /* Drop the packet */
> > > >                 xsk_inc_num_desc(xs->skb);
> > > >
> > > > After that, it seems we can look at skb_shinfo(skb)->nr_frags? Inst=
ead
> > > > of adding new xsk_init_cb, seems more robust?
> >
> > Thanks! I'll do it.
> >
> > >
> > > +1. It would be simpler.
> > >
> > > And I think this patch should be a standalone one because it actually
> > > supports the missing feature for the VM scenario.
> >
> > Hi Jason,
> > in commit message, I wrote about enabling tx metadata for
> > xsk_build_skb_zerocopy() but code did not reflect that as you point out=
 in
> > your later reply.
> >
> > Unless there are any objections I will actually enable it there.
>
> Oh, if you made up your mind enabling it in the next version, how
> about changing the title of this series because the core changes are

Well, don't bother to modify it since in fact the related non linear
driver (for now that is only virtio_net) doesn't support it, I assume
:)

Please go ahead.

Thanks,
Jason

