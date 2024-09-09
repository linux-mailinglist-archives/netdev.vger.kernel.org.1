Return-Path: <netdev+bounces-126607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4997201E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0564B21D31
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5416DED5;
	Mon,  9 Sep 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDeaAjZh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B11172BAE
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902088; cv=none; b=TB3jieu61qsbvmhrEgelShjLlQ79uj1e44JIGjRAf2dCeQ5/I7ob/ap8ZZwD5gjoOwvPAef01Ue9rWUaoFdgPPd6Wm7LkpztqcoihI6+QO8Y4uFytsP0gwUJrdLKnEhGLEg60jTZZYHgTBXBw/BZaEHziujUUGm32tdc4biOch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902088; c=relaxed/simple;
	bh=zN/9FwewWB9KQ3atq6S0gc1nfi/dzDgn9bBiYjUhnew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8x6NcAApZ0nB4mikxGY9O55GcjDi2MM7cUEOCE1Zz7PyVUhcMkSzfOKRuP9jjZTPPpiOsJvfbpjWUmuFvK+MfKMKkUP9J+KPgaNMTLvHJjtpISx4MAscvlrPh+gKaeRzidLGGOqtrwEe7sxHy9ORI+mxVzzzK5ozzDaWxH+Yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDeaAjZh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so68908766b.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725902085; x=1726506885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALxNN9dRZoFRC9+y/jfUuWDybKDVKqjBEGo398aNo/A=;
        b=FDeaAjZhE9/OoPNmA9UBDy8HaX9kujwqPipcByAD+s21Q56+6e+R4M56u9ShS+LThn
         bVagx8zE5VloK+S0wzZDlPspk8WBSr5PbgFwJh+Tp0lhWlrRFdBfHdQ3i/vzERnlzcDP
         f/33cbJhvR9menI/BG2Z0Qa5eoB2Xo0G8wNdo0PARAZQ3AYH8RPo9du+kGmse3vTXHdt
         M7CUH9C1lvcZJferG0pDzqIzNHz5LonWzc/X/cK3/bV6ZvS8CYINF8Vg7m+fDsX3z5FU
         utmf1zz0iOKT+8zHeQgEXZ/OtJV9Q7ExWcUuAWNe3O+yrCyIpPszk9BkACGVxPtGgYEK
         AY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902085; x=1726506885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALxNN9dRZoFRC9+y/jfUuWDybKDVKqjBEGo398aNo/A=;
        b=ZsKgkbiN3nJDL3Hg2tyBvx9db+oaq4aAwij+CRQJQujY2Etf/Kd7oDb6C/LapO7urm
         Zt60Xi+Hu0ah7pM8I9C8C4y/NS+K/u8Xh9wBhwxUAfEs5m2+MM8AJ2qkb4PfhVmvmJJ2
         QeIVnN5hFv6G78wAQ/qB/ZivjS6mIJdR7DdaCqqr+GAiw8jQzuSgoWCixemVc7vhipxt
         hCFpJ+wUgs9tGY53rRoXSLYAV82ehzA2aeG/bKMS/6uvg/u1Ior+KikyP+zDfn6kAUPV
         jDIYojJIv6TcOdg6GXCCWtf6nO29+V1czgx5nOOtihKq87pm7d9Y9BGQWJNTfiaIR9HU
         +CVg==
X-Forwarded-Encrypted: i=1; AJvYcCWRB9pjJVUm5axo5r3zdi7c8yTOXrRLA2Amjh1D2+vW70lGcZ9S6LD32kZgSTF4DSekNMC/WxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsqs6UqoX0x0Gmw3Ngk4hd/ac3V1xFtlRO7f/Ebiln1h/ysllz
	F3QG7rmFPXWKAkry9O+4UnC2lH/dyPFjPxvVTFsuzLBMQN8eiEqvTHqpqw8gS9OO2LjnF3U38H9
	HFmqXJvn5cleUQgCTyWE3k66D5Uux2gA56p02
X-Google-Smtp-Source: AGHT+IH0dTzDOVLc7VvGHPOxI/KkLcM1np+lsLFV0QY0GoyCEVa2vNttuQrGJkSAKRrDZzGf9VtlyGjj7VmVmlK627Q=
X-Received: by 2002:a17:907:1c2a:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a8d29b7ef32mr463884466b.13.1725902084680; Mon, 09 Sep 2024
 10:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909160604.1148178-1-sean.anderson@linux.dev>
 <CANn89i+UHJgx5cp6M=6PidC0rdPdr4hnsDaQ=7srijR3ArM1jw@mail.gmail.com> <c17ef59b-330f-404d-ab03-0c45447305b0@linux.dev>
In-Reply-To: <c17ef59b-330f-404d-ab03-0c45447305b0@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Sep 2024 19:14:32 +0200
Message-ID: <CANn89iJp6exvUkDSS6yG7_gLGknYGCyOE5vdkL-q5ZpPktWzqA@mail.gmail.com>
Subject: Re: [PATCH net] net: dpaa: Pad packets to ETH_ZLEN
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:07=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>
> On 9/9/24 12:46, Eric Dumazet wrote:
> > On Mon, Sep 9, 2024 at 6:06=E2=80=AFPM Sean Anderson <sean.anderson@lin=
ux.dev> wrote:
> >>
> >> When sending packets under 60 bytes, up to three bytes of the buffer f=
ollowing
> >> the data may be leaked. Avoid this by extending all packets to ETH_ZLE=
N,
> >> ensuring nothing is leaked in the padding. This bug can be reproduced =
by
> >> running
> >>
> >>         $ ping -s 11 destination
> >>
> >> Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---
> >>
> >>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/=
net/ethernet/freescale/dpaa/dpaa_eth.c
> >> index cfe6b57b1da0..e4e8ee8b7356 100644
> >> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> >> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> >> @@ -2322,6 +2322,12 @@ dpaa_start_xmit(struct sk_buff *skb, struct net=
_device *net_dev)
> >>         }
> >>  #endif
> >>
> >> +       /* Packet data is always read as 32-bit words, so zero out any=
 part of
> >> +        * the skb which might be sent if we have to pad the packet
> >> +        */
> >> +       if (__skb_put_padto(skb, ETH_ZLEN, false))
> >> +               goto enomem;
> >> +
> >
> > This call might linearize the packet.
> >
> > @nonlinear variable might be wrong after this point.
> >
> >>         if (nonlinear) {
> >>                 /* Just create a S/G fd based on the skb */
> >>                 err =3D skb_to_sg_fd(priv, skb, &fd);
> >> --
> >> 2.35.1.1320.gc452695387.dirty
> >>
> >
> > Perhaps this instead ?
> >
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > index cfe6b57b1da0e45613ac1bbf32ddd6ace329f4fd..5763d2f1bf8dd31b80fda06=
81361514dad1dc307
> > 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > @@ -2272,12 +2272,12 @@ static netdev_tx_t
> >  dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
> >  {
> >         const int queue_mapping =3D skb_get_queue_mapping(skb);
> > -       bool nonlinear =3D skb_is_nonlinear(skb);
> >         struct rtnl_link_stats64 *percpu_stats;
> >         struct dpaa_percpu_priv *percpu_priv;
> >         struct netdev_queue *txq;
> >         struct dpaa_priv *priv;
> >         struct qm_fd fd;
> > +       bool nonlinear;
> >         int offset =3D 0;
> >         int err =3D 0;
> >
> > @@ -2287,6 +2287,10 @@ dpaa_start_xmit(struct sk_buff *skb, struct
> > net_device *net_dev)
> >
> >         qm_fd_clear_fd(&fd);
> >
> > +       if (__skb_put_padto(skb, ETH_ZLEN, false))
> > +               goto enomem;
> > +
> > +       nonlinear =3D skb_is_nonlinear(skb);
> >         if (!nonlinear) {
> >                 /* We're going to store the skb backpointer at the begi=
nning
> >                  * of the data buffer, so we need a privately owned skb
>
> Thanks for the suggestion; I was having a hard time figuring out where
> to call this.
>
> Do you have any hints for how to test this for correctness? I'm not sure
> how to generate a non-linear packet under 60 bytes.

I think pktgen can do this, with its frags parameter.

