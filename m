Return-Path: <netdev+bounces-119401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664B955776
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06040B2157C
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4B148855;
	Sat, 17 Aug 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El0UzOc4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211F83CDA;
	Sat, 17 Aug 2024 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894404; cv=none; b=VhvVyRB5EzyDAKfAAd++gHcZGe171BtJY2pmv3MqwQn4SBiWWGbEcWt1bY0Rjw+OD4YAAo9uPuE4Kja4AFTqPG5QPIJrtIXf+dTnwAtNedkI8MSkJ4S6k5603Ku3b74JsGn/qcOxDJHFSSkxL1l6pXF5n29l7TxkxgRBe3ufzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894404; c=relaxed/simple;
	bh=COftzJgG/EMMoQ2fnKwJOfvLWndf1mS/oh2j7AeVKig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMVv4CkroF+majjoO+jUgVrGtiAxxSf2azoxYZATesneaaT/rNIrtL7NgpbGm7+MQ7ICKjV+WrMoWIsDF5ofLYRfx43oxw3rXQqCuTwUBIS10i7NjIa2w8UOYg4/xlAwzraBPEW6R5wSJLLhEDrQZ/dznCvUopDkHvj0u5xBdbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El0UzOc4; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso2762364276.1;
        Sat, 17 Aug 2024 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723894402; x=1724499202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SESKwucFxjDdZ8FkRu+VMQPyl3jzoCLi6zR1M+QPMa0=;
        b=El0UzOc4Fw9JUF4e10sKIDrMAl64g/zwjVz7Iw6wkYqI2m2g6RHtpWhqs9Fph+F0os
         SgTiR4wKCzwvxVowcSDcr5bo+OIEdMhL2mn0lnY6aDaZrVz8L/+EtfuSG/jdDx4NRx1p
         8HsBKdeonh23JYPcfqtwRvIgGx2ZtsaUDElhE6J3zt8YwJQBDOZ10IGRgn16bBT3aoHu
         aCHK3DwQ4NphzDp32oIaDGV3V3UcQr44jx/UtVqDlHGL9YcN2DX2xKI6AaWjhU4cmpxX
         uik+J5IxUWXnxZsZ1wq/28gbKKsw3a1EMHpd3MHdDmmnwQItBtDdpXpj0sqjyKUgD4ni
         ZgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723894402; x=1724499202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SESKwucFxjDdZ8FkRu+VMQPyl3jzoCLi6zR1M+QPMa0=;
        b=wI9kR+o30E+zy2NJXgS3QEE4Sh9Vs8LU/rqHWQsS3aSTT7PL5lIkmjY3Rm+2qEj7J/
         ISJyyCH0f7tKXGNu9Lr/7UZ2Lqp6WlfdQTOTP/mJeUMkK1D2tW8l0jEDrWZKTGVE3r+L
         rf4A0DNamlIN3ynSqKw2aiAVhfMHU/tXn9Ipa2H2wBW5mW6Pv5nfrOK0wpe8TFJbq2sI
         5R4fXlsok65GS+E/0Ko5mmC7Z+r2oMy8WkEg7LFIa9Nk4ktt3FbJrdD+2sCjvAbDspfJ
         fvfrMq/YDCl7JG2AKoUD1AjpwESOSqYpGnlb9K7VjUi+b0EFztDJKlYkfIo3SWv68FHm
         G6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXd28ELPL1s6wBeE3/rEPY4VDEt6ZcXkzcD7g9M90GYd2nI2auswW/+cdDRZEvfJoI3uXpPGk5WrNUKooXgHdNRqPnxBItZaUv2/b906CPSInGAZXJ1gaXTY/UItCRvgwuOGErt
X-Gm-Message-State: AOJu0YzCg+VDxQ4v3fVMIYonKj0kNm6z62wSQ3CwpOBO17xxgYUAs+74
	Qq6sYKi8t8WxQYu5w7cpEtC8RAZ8vksBzhwKUsWUznYffDH/wIfsJsEME3MoF2Bsm8KHfGJS4wD
	0hoEDtpFOzsuyvtemQEEbva8iB7g=
X-Google-Smtp-Source: AGHT+IEWZk1oHXltyZ1g79/emSVqRf5qSTKVkqIEaYhWNNk4GjD5HhRUVElse+KO330nH/ASwpW7c49M3bSmPGvsu4M=
X-Received: by 2002:a05:6902:e12:b0:e13:ddd5:c6d4 with SMTP id
 3f1490d57ef6-e13ddd5ea77mr531236276.38.1723894401550; Sat, 17 Aug 2024
 04:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-7-dongml2@chinatelecom.cn> <20240816192243.050d0b1f@kernel.org>
In-Reply-To: <20240816192243.050d0b1f@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 17 Aug 2024 19:33:23 +0800
Message-ID: <CADxym3ZEvUYwfvh2O5M+aYmLSMe_eZ8n=X_qBj8DiN8hh2OkaQ@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] net: vxlan: add skb drop reasons to vxlan_rcv()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, idosch@nvidia.com, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 10:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 15 Aug 2024 20:42:58 +0800 Menglong Dong wrote:
> >  #define VXLAN_DROP_REASONS(R)                        \
> > +     R(VXLAN_DROP_FLAGS)                     \
> > +     R(VXLAN_DROP_VNI)                       \
> > +     R(VXLAN_DROP_MAC)                       \
>
> Drop reasons should be documented.

Yeah, I wrote the code here just like what we did in
net/openvswitch/drop.h, which makes the definition of
enum ovs_drop_reason a call of VXLAN_DROP_REASONS().

I think that we can define the enum ovs_drop_reason just like
what we do in include/net/dropreason-core.h, which can make
it easier to document the reasons.

> I don't think name of a header field is a great fit for a reason.
>

Enn...Do you mean the "VXLAN_DROP_" prefix?

> >       /* deliberate comment for trailing \ */
> >
> >  enum vxlan_drop_reason {
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index e971c4785962..9a61f04bb95d 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -1668,6 +1668,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_so=
ck *vs, void *oiph,
> >  /* Callback from net/ipv4/udp.c to receive packets */
> >  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
> >  {
> > +     enum skb_drop_reason reason =3D pskb_may_pull_reason(skb, VXLAN_H=
LEN);
>
> Do not call complex functions inline as variable init..

Okay!

>
> >       struct vxlan_vni_node *vninode =3D NULL;
> >       struct vxlan_dev *vxlan;
> >       struct vxlan_sock *vs;
> > @@ -1681,7 +1682,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_b=
uff *skb)
> >       int nh;
> >
> >       /* Need UDP and VXLAN header to be present */
> > -     if (!pskb_may_pull(skb, VXLAN_HLEN))
> > +     if (reason !=3D SKB_NOT_DROPPED_YET)
>
> please don't compare against "not dropped yet", just:
>

Okay!

>         if (reason)
>
> > @@ -1815,8 +1831,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_b=
uff *skb)
> >       return 0;
> >
> >  drop:
> > +     SKB_DR_RESET(reason);
>
> the name of this macro is very confusing, I don't think it should exist
> in the first place. nothing should goto drop without initialing reason
>

It's for the case that we call a function which returns drop reasons.
For example, the reason now is assigned from:

  reason =3D pskb_may_pull_reason(skb, VXLAN_HLEN);
  if (reason) goto drop;

  xxxxxx
  if (xx) goto drop;

The reason now is SKB_NOT_DROPPED_YET when we "goto drop",
as we don't set a drop reason here, which is unnecessary in some cases.
And, we can't set the drop reason for every "drop" code path, can we?
So, we need to check if the drop reason is SKB_NOT_DROPPED_YET
when we call kfree_skb_reason().

We use "SKB_DR_OR(drop_reason, NOT_SPECIFIED);" in tcp_v4_rcv()
for this purpose. And we can remove SKB_DR_RESET and replace it
with "SKB_DR_OR(drop_reason, NOT_SPECIFIED);" here if you think
it's ok.

Thanks!
Menglong Dong
> >       /* Consume bad packet */
> > -     kfree_skb(skb);
> > +     kfree_skb_reason(skb, reason);
> >       return 0;
> >  }

