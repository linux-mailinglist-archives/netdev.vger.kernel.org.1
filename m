Return-Path: <netdev+bounces-160536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E11A1A16E
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293EC7A4805
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9020CCCC;
	Thu, 23 Jan 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPGgTeYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99920C014
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626843; cv=none; b=sCtthOWqpCT4Ylg+zPLqls9kscqG3GldHaUEjJE9uPFtd3q/zTn24CENy6jGXtMwk8zZHzLlG6AJUOpItsIC2ew33524b4ELxirttXGU0aSxYabKs+AmCA9YsuhcCt+GlqJBQm66fUJ1VneBJN7aOkDW9hXrPoEUshuhxJ/lf6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626843; c=relaxed/simple;
	bh=aRULEqSSc4efALJOuOI4WS5FDchRBBnwoKC6nffq7sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYKRcFSS7W7qsNQiwDPBELOgujLTrud4JxWYCcqaPITbS1p3o+EMJ1/Hntmm11XB+7tWIi8NbhLb/rRsj0S5m2kztX6jgzdfDazY3q+IHI+GQZ4ewOD19CCWtUw7ocd7WPx7drbskGXDt6F/L8eqjDyt82YO639MsLA7M9fpXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rPGgTeYU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso1373000a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737626839; x=1738231639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMiVQCdtIjVqiDL8riIp6he9DJ8xevPUzJ+HsgEieus=;
        b=rPGgTeYUaHMGGxIBjg04vtKRWW5qOHMSGWsGbLBlfHqGqS7SP3qCOJ+oIEDU+5IdWC
         Z0QlzU7EyabfRFyTU2TAxK4dC9kpHwmqGIXho3S1A++nV5boqGUxeDe4+BPOIXOgV33x
         YBvefcmdz9XMdcXN52+Eexq4B2uKsQR8DOXA3O6fQgppbQaMPATmMdzzjaJoDBHuRxUC
         xLi/SzeV8R2wTpJD/kboaVk67C/0h+pIdA65QHWZQDXP4PxhNn6DSlCgw0HuUfyF9RTO
         FCmgHhpONIL1Cb8ZI5AkmnGMtzlzxWpwXAZVKwKph8Mcid27nQyjri7VI/CmCtSFV2iE
         nPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737626839; x=1738231639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMiVQCdtIjVqiDL8riIp6he9DJ8xevPUzJ+HsgEieus=;
        b=gjMjvJAYShCZbyzwZ9B1ewdh2jCPZWW63IR5WDDdbg9XW6B2DQkXDVO9vBeDeofzpQ
         LlULytT1/PDYRQvEJ0aeDY7SYVRnV87+1OPTHvwX/m7mos2AvyfgdoAri/wouYH+Appe
         GKP13BW05Kmesx8ss0gOlJcm547OD51j6CftWspvgcFgzfBeZ7Yq+vfkqswxcsrT/UFh
         DHZd0AQ2Thnbkb9cWQ8HC1Lf203kxaQ/m9Xmxaq6dUH23B+z3qTuGYLAyhtyhUWaLAx/
         NvHhh7/RWg6W1hhnr/C4Km14Una7HXUBi40OjfGnD2jmZiT4ofht4jBr02zQU8bAuU5H
         MG6A==
X-Forwarded-Encrypted: i=1; AJvYcCWTZN+QAvJtuJ2pGz2vUcNgUa1+D5d5nIDBAjMlAmo+XaO2yk2l7h/Rx9k39bHtApUHdA+fQ8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVD75aWgBwqNb+y89fkTKhxr92Qp3F12q8w11jUs8KgrD/f1rC
	zQCch50uymoo+gPm2mDUnyCJ5IFbZc1F1M36OVTnFl0g0m0b3ii/1eifzWP1bWeUQT6lo7zCSzA
	gcbLGb7LKSFz6TyOTRh7tMUocJk1m1a6l6+YIdacFemt311dIFAkm
X-Gm-Gg: ASbGncsS/5RTtAzJUH9Q+CmbsRqdwCu6BgygIjNq/UBnTjuD6xDiYlz0rU2gmVe/mVQ
	v0gR6O+cFXa3VutEw+aoXVWz4FUl+/mqJoIXlDDqZ7FsoELt45B5uwnC2n57BXSI=
X-Google-Smtp-Source: AGHT+IFe/vGBvBiWvmnPceyqE7f+4cgaVhm4S4jYqz/JYDUA+sYEftXJ4iuiYTqNFe/DFeTLTcjDfeOCL6jZu5GsUuk=
X-Received: by 2002:a05:6402:2347:b0:5d0:e2c8:dc8d with SMTP id
 4fb4d7f45d1cf-5db7d3392d6mr23475878a12.20.1737626838629; Thu, 23 Jan 2025
 02:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121115010.110053-1-tbogendoerfer@suse.de> <3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com>
In-Reply-To: <3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jan 2025 11:07:07 +0100
X-Gm-Features: AWEUYZnHV5CbW-Fu-JbUAXyfhzL27qOuvRNo4_PR_4XwTbhmaTIgF90HTu5ry9o
Message-ID: <CANn89iLwOWvzZqN2VpUQ74a5BXRgvZH4_D2iesQBdnGWmZodcg@mail.gmail.com>
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned skbs
To: Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 9:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/21/25 12:50 PM, Thomas Bogendoerfer wrote:
> > gro_cells_receive() passes a cloned skb directly up the stack and
> > could cause re-ordering against segments still in GRO. To avoid
> > this queue cloned skbs and use gro_normal_one() to pass it during
> > normal NAPI work.
> >
> > Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > --
> > v2: don't use skb_copy(), but make decision how to pass cloned skbs in
> >     napi poll function (suggested by Eric)
> > v1: https://lore.kernel.org/lkml/20250109142724.29228-1-tbogendoerfer@s=
use.de/
> >
> >  net/core/gro_cells.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> > index ff8e5b64bf6b..762746d18486 100644
> > --- a/net/core/gro_cells.c
> > +++ b/net/core/gro_cells.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/skbuff.h>
> >  #include <linux/slab.h>
> >  #include <linux/netdevice.h>
> > +#include <net/gro.h>
> >  #include <net/gro_cells.h>
> >  #include <net/hotdata.h>
> >
> > @@ -20,7 +21,7 @@ int gro_cells_receive(struct gro_cells *gcells, struc=
t sk_buff *skb)
> >       if (unlikely(!(dev->flags & IFF_UP)))
> >               goto drop;
> >
> > -     if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> > +     if (!gcells->cells || netif_elide_gro(dev)) {
> >               res =3D netif_rx(skb);
> >               goto unlock;
> >       }
> > @@ -58,7 +59,11 @@ static int gro_cell_poll(struct napi_struct *napi, i=
nt budget)
> >               skb =3D __skb_dequeue(&cell->napi_skbs);
> >               if (!skb)
> >                       break;
> > -             napi_gro_receive(napi, skb);
> > +             /* Core GRO stack does not play well with clones. */
> > +             if (skb_cloned(skb))
> > +                     gro_normal_one(napi, skb, 1);
> > +             else
> > +                     napi_gro_receive(napi, skb);
>
> I must admit it's not clear to me how/why the above will avoid OoO. I
> assume OoO happens when we observe both cloned and uncloned packets
> belonging to the same connection/flow.
>
> What if we have a (uncloned) packet for the relevant flow in the GRO,
> 'rx_count - 1' packets already sitting in 'rx_list' and a cloned packet
> for the critical flow reaches gro_cells_receive()?
>
> Don't we need to unconditionally flush any packets belonging to the same
> flow?

It would only matter if we had 2 or more segments that would belong
to the same flow and packet train (potential 'GRO super packet'), with
the 'cloned'
status being of mixed value on various segments.

In practice, the cloned status will be the same for all segments.

Same issue would happen when/if dev->features NETIF_F_GRO is flipped
back and forth : We do not really care.

