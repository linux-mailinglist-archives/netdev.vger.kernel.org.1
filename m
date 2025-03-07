Return-Path: <netdev+bounces-172789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5963BA56024
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 06:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434453A9548
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 05:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3E166F3D;
	Fri,  7 Mar 2025 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+CRSiFh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9057FD
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326162; cv=none; b=BeLCTk4GwXej00BFPcerb8DA/qUPkTsyHXzuODFwN1S2s55OKABImoiZcqhJNMzEOg4bqq7QSDX32entTb9OQW+JNi945tcE2QdhmwLd/nX6/aqaj4L5a+Gl97rsJiLOrsdMsdjt9tdPMPlKzivvZmYixZUyHm+MdmT9RfDSXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326162; c=relaxed/simple;
	bh=q/EmAd4hSTp/mW4YVgEutZ8yewQwUlnZLPCny71tE+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy0w93/6M+SgucRyqZsObWgPw7RC0b6ZBocvn+de/RRSv6BymZnkI8CESDuGCo11TC9p/azV8EZ6mXY8z9MDX1w2XIgb3+37FYlLo0SP2tXNz8dCsnWyfVQklkeaHmOondozEmBB8ioqCrAdT3dNflJnN6WOf828S9b3a2/ciAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+CRSiFh; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549924bc82aso2723e87.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 21:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741326158; x=1741930958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDw9oiHRuEGnoLlAxBvRVZT+Z3gwxIerZGJ9YIsCCsY=;
        b=P+CRSiFhkBfhv5ODUWUyYQmS3joYX1xOtqXeYj83hqDQECvkdPT2OkmtJ1q9lEQudp
         gHQYPf/1q7rba5eoiYSCFJX71aAArFVmEMZSw2OrnEU9i/BZlpkyZySZF7g2A85nfrNz
         4+H2m+Iw+cCITYAG5DNmbvHMwF9KJVdGfdSFPrfyD+6ixNn/RkJZ1bpANJXDet03HIlF
         LNOis0i3guZXjLlP0HTCruTiojAJ/UYzBd27HzWcrNHSmxXT6Qq2hJUPOGKJZ4M61/zm
         VH24SZ7R39qXR4mFWr6gfOBWdUinakTZYRacIw1bsO6fuvbAytguVkT9pUJkR/Ci3Ky9
         hGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326158; x=1741930958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDw9oiHRuEGnoLlAxBvRVZT+Z3gwxIerZGJ9YIsCCsY=;
        b=v4KJOFjInl5gpewRThsxQgJIqHcwWd52Fl58+B+fxa7UHluigfzCWp/KR1ciQy/1Cs
         J8TOgHURV0hpTJyIiqN/Qocjhtcm250wdo055pEJcyfn9ZCoQWOM+LcuVznijoKZq8t/
         FmZr4Y9p0hyRAmNw6fVXAPdXNNVb+ge/d9xzXziBq5vr2qA9E6yJlRiKmIS8g1AEfQGr
         2LspR0Tab1on03eFB7AgOYbr/RwGFiqeusk+9BFCNAvDGCTbtMnu4UcLnvv4bg8AmnpI
         VQARYrMZ4Xv4aBdyF8KNQ96IXro5RGc0FiX585x6Kk8s9Wa7BCHEMWqqSXHOXLAqZoYH
         9jrQ==
X-Gm-Message-State: AOJu0Yx5f7Gc7ERA3/AUi9QO/j5yiAUZK72S6ZIYg8rNdG2Lw6XGJBJc
	G2hEJZYaraecyV3IpkC8qnzd2KOCtQ0sgbdXfoMsP2iA0AbxV/tNBofk8RBWqTBhKoTEGnhCjUP
	vuz3Nis1sR/01k2kWIImMt/XNEoE82cSABwxx
X-Gm-Gg: ASbGncvNMkNJcSqAiKG+gCKjmXTutxweK4eFd4d4Aq7ghg2rUm5hEeyUfXnxMjssw9C
	kl5zlI35o7HqVtxmacjPMqZZaneIbnCH3vCPuUGhhudMroREF/H6mCBvGX/sdQhND8/XGwW6VXu
	hU5g7+gGIQRwPz3cVTbFoqsYffOwk5cSCJOhciJYNM5Lz6muiQDTTqHAxc
X-Google-Smtp-Source: AGHT+IH95QTTw5bO7Ao+hPgPn4qkRdTkWzZBeph1YkD746G1l9cUIKTXz0RW/MygvHUNBdPFKZs8S6v78c56FhFZd9I=
X-Received: by 2002:a05:6512:1389:b0:543:e3c3:5a5e with SMTP id
 2adb3069b0e04-54991430d5bmr198992e87.4.1741326157373; Thu, 06 Mar 2025
 21:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224061554.1906002-1-chiachangwang@google.com>
 <20250224061554.1906002-2-chiachangwang@google.com> <20250224124956.GB53094@unreal>
In-Reply-To: <20250224124956.GB53094@unreal>
From: Chiachang Wang <chiachangwang@google.com>
Date: Fri, 7 Mar 2025 13:42:25 +0800
X-Gm-Features: AQ5f1JpdBQmQVO4GSjMGaWz45ZwBNS4SeMu3U9QZ2mkJRksJS6hZt8w9TwWxUk0
Message-ID: <CAOb+sWEdZ-kY6-qnG2u0h_JzeVyrf0b_eT+L=2t-5zCGaXedHA@mail.gmail.com>
Subject: Re: [PATCH ipsec v3 1/1] xfrm: Migrate offload configuration
To: Leon Romanovsky <leonro@nvidia.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	stanleyjhu@google.com, yumike@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Thank you for your review and suggestions. I noticed your patches
haven't been merged into the tree yet. I'm unsure if rebasing my patch
onto yours would work correctly with the kernel upstream. It seems
your patches are suitable for merging. Since I'm not familiar with the
timeline for your patch's inclusion, could you please advise on how
long it might take for them to be in the tree? This would help me
rebase my patch properly. or there are any other alternative way
rather than waiting your patch?

Appreciate for your help!

Chiachang


Leon Romanovsky <leonro@nvidia.com> =E6=96=BC 2025=E5=B9=B42=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Feb 24, 2025 at 06:15:54AM +0000, Chiachang Wang wrote:
> > Add hardware offload configuration to XFRM_MSG_MIGRATE
> > using an option netlink attribute XFRMA_OFFLOAD_DEV.
> >
> > In the existing xfrm_state_migrate(), the xfrm_init_state()
> > is called assuming no hardware offload by default. Even the
> > original xfrm_state is configured with offload, the setting will
> > be reset. If the device is configured with hardware offload,
> > it's reasonable to allow the device to maintain its hardware
> > offload mode. But the device will end up with offload disabled
> > after receiving a migration event when the device migrates the
> > connection from one netdev to another one.
> >
> > The devices that support migration may work with different
> > underlying networks, such as mobile devices. The hardware setting
> > should be forwarded to the different netdev based on the
> > migration configuration. This change provides the capability
> > for user space to migrate from one netdev to another.
> >
> > Test: Tested with kernel test in the Android tree located
> >       in https://android.googlesource.com/kernel/tests/
> >       The xfrm_tunnel_test.py under the tests folder in
> >       particular.
> > Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> > ---
> >
> > v2 -> v3:
> > - Modify af_key to fix kbuild error
> > v1 -> v2:
> > - Address review feedback to correct the logic in the
> >   xfrm_state_migrate in the migration offload configuration
> >   change.
> > - Revise the commit message for "xfrm: Migrate offload configuration"
> > ---
> >  include/net/xfrm.h     |  8 ++++++--
> >  net/key/af_key.c       |  2 +-
> >  net/xfrm/xfrm_policy.c |  4 ++--
> >  net/xfrm/xfrm_state.c  | 14 +++++++++++---
> >  net/xfrm/xfrm_user.c   | 15 +++++++++++++--
> >  5 files changed, 33 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index ed4b83696c77..9e916d812af7 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -1876,12 +1876,16 @@ struct xfrm_state *xfrm_migrate_state_find(stru=
ct xfrm_migrate *m, struct net *n
> >                                               u32 if_id);
> >  struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
> >                                     struct xfrm_migrate *m,
> > -                                   struct xfrm_encap_tmpl *encap);
> > +                                   struct xfrm_encap_tmpl *encap,
> > +                                   struct net *net,
> > +                                   struct xfrm_user_offload *xuo,
> > +                                   struct netlink_ext_ack *extack);
> >  int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
> >                struct xfrm_migrate *m, int num_bundles,
> >                struct xfrm_kmaddress *k, struct net *net,
> >                struct xfrm_encap_tmpl *encap, u32 if_id,
> > -              struct netlink_ext_ack *extack);
> > +              struct netlink_ext_ack *extack,
> > +              struct xfrm_user_offload *xuo);
> >  #endif
> >
> >  int km_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr, __be1=
6 sport);
> > diff --git a/net/key/af_key.c b/net/key/af_key.c
> > index c56bb4f451e6..efc2a91f4c48 100644
> > --- a/net/key/af_key.c
> > +++ b/net/key/af_key.c
> > @@ -2630,7 +2630,7 @@ static int pfkey_migrate(struct sock *sk, struct =
sk_buff *skb,
> >       }
> >
> >       return xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
> > -                         kma ? &k : NULL, net, NULL, 0, NULL);
> > +                         kma ? &k : NULL, net, NULL, 0, NULL, NULL);
> >
> >   out:
> >       return err;
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index 6551e588fe52..82f755e39110 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -4630,7 +4630,7 @@ int xfrm_migrate(const struct xfrm_selector *sel,=
 u8 dir, u8 type,
> >                struct xfrm_migrate *m, int num_migrate,
> >                struct xfrm_kmaddress *k, struct net *net,
> >                struct xfrm_encap_tmpl *encap, u32 if_id,
> > -              struct netlink_ext_ack *extack)
> > +              struct netlink_ext_ack *extack, struct xfrm_user_offload=
 *xuo)
> >  {
> >       int i, err, nx_cur =3D 0, nx_new =3D 0;
> >       struct xfrm_policy *pol =3D NULL;
> > @@ -4663,7 +4663,7 @@ int xfrm_migrate(const struct xfrm_selector *sel,=
 u8 dir, u8 type,
> >               if ((x =3D xfrm_migrate_state_find(mp, net, if_id))) {
> >                       x_cur[nx_cur] =3D x;
> >                       nx_cur++;
> > -                     xc =3D xfrm_state_migrate(x, mp, encap);
> > +                     xc =3D xfrm_state_migrate(x, mp, encap, net, xuo,=
 extack);
> >                       if (xc) {
> >                               x_new[nx_new] =3D xc;
> >                               nx_new++;
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index ad2202fa82f3..0b5f7e90f4f3 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -2122,22 +2122,30 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);
> >
> >  struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
> >                                     struct xfrm_migrate *m,
> > -                                   struct xfrm_encap_tmpl *encap)
> > +                                   struct xfrm_encap_tmpl *encap,
> > +                                   struct net *net,
> > +                                   struct xfrm_user_offload *xuo,
> > +                                   struct netlink_ext_ack *extack)
> >  {
> >       struct xfrm_state *xc;
> > -
> > +     bool offload =3D (xuo);
>
> There is no need in extra variable, rely on validity of pointer.
>
> >       xc =3D xfrm_state_clone(x, encap);
> >       if (!xc)
> >               return NULL;
> >
> >       xc->props.family =3D m->new_family;
> >
> > -     if (xfrm_init_state(xc) < 0)
> > +     if (__xfrm_init_state(xc, true, offload, NULL) < 0)
> >               goto error;
>
> Please rebase this patch on top of https://lore.kernel.org/netdev/cover.1=
739972570.git.leon@kernel.org/
> The __xfrm_init_state() was changed there. You can use xfrm_init_state()
> instead.
>
> >
> > +     x->km.state =3D XFRM_STATE_VALID;
> >       memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
> >       memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
>
> It should be placed inside xfrm_state_clone() and worth to rename it.
>
> >
> > +     /* configure the hardware if offload is requested */
> > +     if (offload && xfrm_dev_state_add(net, xc, xuo, extack))
> > +             goto error;
> > +
> >       /* add state */
> >       if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) =
{
> >               /* a care is needed when the destination address of the
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index 5877eabe9d95..4c2c74078e65 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -3069,6 +3069,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, s=
truct nlmsghdr *nlh,
> >       int n =3D 0;
> >       struct net *net =3D sock_net(skb->sk);
> >       struct xfrm_encap_tmpl  *encap =3D NULL;
> > +     struct xfrm_user_offload *xuo =3D NULL;
> >       u32 if_id =3D 0;
> >
> >       if (!attrs[XFRMA_MIGRATE]) {
> > @@ -3099,11 +3100,21 @@ static int xfrm_do_migrate(struct sk_buff *skb,=
 struct nlmsghdr *nlh,
> >       if (attrs[XFRMA_IF_ID])
> >               if_id =3D nla_get_u32(attrs[XFRMA_IF_ID]);
> >
> > +     if (attrs[XFRMA_OFFLOAD_DEV]) {
> > +             xuo =3D kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> > +                           sizeof(*xuo), GFP_KERNEL);
> > +             if (!xuo) {
> > +                     err =3D -ENOMEM;
> > +                     goto error;
> > +             }
> > +     }
> > +
> >       err =3D xfrm_migrate(&pi->sel, pi->dir, type, m, n, kmp, net, enc=
ap,
> > -                        if_id, extack);
> > +                        if_id, extack, xuo);
> >
> > +error:
> >       kfree(encap);
> > -
> > +     kfree(xuo);
> >       return err;
> >  }
> >  #else
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >
> >

