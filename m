Return-Path: <netdev+bounces-160546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D09A1A211
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895AE3A7589
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA76420DD63;
	Thu, 23 Jan 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urTlaauc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D220CCD6
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628999; cv=none; b=VgsTUHW4tOOL2IOlFo7GkTKfh7AJQxok4tY5iaDV6RmB9E2seL3cCNbq+KG7UBtPkYdxHdfHJAbGCepIIcnHNxGg3fXXwjWdCGCE1AfbWRznnm2YE4LUMtgeSKwV0Kfuxi9mjd5sl3vWYQ9GpxlXh6DfnxnhjqDNYg7mxJ7eL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628999; c=relaxed/simple;
	bh=6jzJuqAit8vGydskOcptJTa653MDJ+uA0FACYZguRpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeIKDHrWvGAnU9egoETf3G3DkAyMdy7XRWRET8ZhpcEULclbGNMWobGb1XKOGnKn06CbqO8Lyewy63fGOOOsv2AcDYhJS7OV2CzGR/liA+gQfkZSEqs3kc89qwaCLTiq/DmjscAdIP7VGO4Tuw7nAG8CiXwckxhctKHVy5MUui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urTlaauc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso1615981a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 02:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737628996; x=1738233796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L+F1uti3TU+pcV6F9KKXdN3pOJnUvdils+I/b7AGuM=;
        b=urTlaaucnPqQZF6ful8wInzjEKY1mtPm7fkEGJ4uzQ1Yb1r16qvLUYMG4qfzaRWieg
         dnwVc0ORmpIAqtS46D0177BBMSmp8TwkREjskl03EvfS8yl5dTLbnnTLi+4XB89gIgHU
         a25UbID/pDxNZ3krRowX+jV81/Mnz536UykK3PZ4llivudH6laXC5npsbMG3oo8EAyi3
         uydrsuvFPLa5dJqkr9VGAz5knee4Veo2Gng+l8YWtWTNWf7bSPnss+PC0egnvEMul7Vn
         0eQ4vHKRQ4lsb8UJP2XMmojBVYhZI+wTPEtA9otWj3em0ZB3ciM2yFRZJdmGnGjMENPN
         Av3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737628996; x=1738233796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L+F1uti3TU+pcV6F9KKXdN3pOJnUvdils+I/b7AGuM=;
        b=FO+/z5eEx0vPyCRSIDj4JFpH6GhZO5V8OuU5K6+7einfRMLfJaJ7/i+R9DTrcyjOGl
         ABSUBLVAsBHh46ajvFfHICsHHfN2UhROkR7FpjqaGGcMH8dgbcaG43rj5iGWbvHhmJ1Y
         1OsSZ9vLcbQqifaDD8uq5ZZY3oTyCk3fwu4cQNgQqV3ottmjVa7dVefWHRpsR1uO4fh6
         0RlbbQqgEVJgUP1RKnrxTeJ0Z0pzDW2Ld39LYOhqdh10IiGxxF9jWERW619CZ1EnZKay
         Q9+uFp79ZkrRcaZzBEFrpBWYDD8DWv2Qpb9zi4mzoC7/WxZ6PafseUw/lCc7idcOBngb
         OIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKpDwUgtSOsLjRucU8WYG+T/QFEI/9HFOfzylth2ho3J0bKdcDKGKTalWh1Dy5ftDINgpqg1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpkPjL1ABP4/PL21MwLddUJF6dbRcVbuE0e3+Dj7AruOCERqt
	DT/izpF7fG/Hnq1e5CW0MirV1WZEnQn6A7/vRyj6s/A5L87df4pPe0sG3vLAbwl9DX3m1X1WTC0
	w1+vvO6a2yMD4PR87PH0WFRLsYHolJ+LdKliM
X-Gm-Gg: ASbGncu/9cTS7CsjZiz9UHjN5iS4RgXDdZU7Arr0LX5czGQ5f2qFswiqG01tmJYnbEE
	OwhU72ihNpiZFiLvtroRGX9nMhLSAJj0atjZOOpQqQ+8QE3B3jbBbSiHKOV2YTVY=
X-Google-Smtp-Source: AGHT+IF4rR7FhYICGHFnG5vMiIF7nKzKyOznEm61dzG0oDNa2BL+PjDGCPM9pWzQO/kixZFRN3eqgyi9ryO6lJ54yk4=
X-Received: by 2002:a05:6402:1e8a:b0:5dc:11b5:c2b1 with SMTP id
 4fb4d7f45d1cf-5dc11b5c40emr648127a12.25.1737628995908; Thu, 23 Jan 2025
 02:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121115010.110053-1-tbogendoerfer@suse.de>
 <3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com> <CANn89iLwOWvzZqN2VpUQ74a5BXRgvZH4_D2iesQBdnGWmZodcg@mail.gmail.com>
 <de2d5f6e-9913-44c1-9f4e-3e274b215ebf@redhat.com>
In-Reply-To: <de2d5f6e-9913-44c1-9f4e-3e274b215ebf@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jan 2025 11:43:05 +0100
X-Gm-Features: AWEUYZn6dwfSi5JrnulCKChi3Bv7nwz-Yas5zpaJLmTI1bBeqS-wpb3nMVlfZkY
Message-ID: <CANn89iJODT0+qe678jOfs4ssy10cNXg5ZsYbvgHKDYyZ6q_rgg@mail.gmail.com>
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned skbs
To: Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 11:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/23/25 11:07 AM, Eric Dumazet wrote:
> > On Thu, Jan 23, 2025 at 9:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 1/21/25 12:50 PM, Thomas Bogendoerfer wrote:
> >>> gro_cells_receive() passes a cloned skb directly up the stack and
> >>> could cause re-ordering against segments still in GRO. To avoid
> >>> this queue cloned skbs and use gro_normal_one() to pass it during
> >>> normal NAPI work.
> >>>
> >>> Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> >>> Suggested-by: Eric Dumazet <edumazet@google.com>
> >>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> >>> --
> >>> v2: don't use skb_copy(), but make decision how to pass cloned skbs i=
n
> >>>     napi poll function (suggested by Eric)
> >>> v1: https://lore.kernel.org/lkml/20250109142724.29228-1-tbogendoerfer=
@suse.de/
> >>>
> >>>  net/core/gro_cells.c | 9 +++++++--
> >>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> >>> index ff8e5b64bf6b..762746d18486 100644
> >>> --- a/net/core/gro_cells.c
> >>> +++ b/net/core/gro_cells.c
> >>> @@ -2,6 +2,7 @@
> >>>  #include <linux/skbuff.h>
> >>>  #include <linux/slab.h>
> >>>  #include <linux/netdevice.h>
> >>> +#include <net/gro.h>
> >>>  #include <net/gro_cells.h>
> >>>  #include <net/hotdata.h>
> >>>
> >>> @@ -20,7 +21,7 @@ int gro_cells_receive(struct gro_cells *gcells, str=
uct sk_buff *skb)
> >>>       if (unlikely(!(dev->flags & IFF_UP)))
> >>>               goto drop;
> >>>
> >>> -     if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) =
{
> >>> +     if (!gcells->cells || netif_elide_gro(dev)) {
> >>>               res =3D netif_rx(skb);
> >>>               goto unlock;
> >>>       }
> >>> @@ -58,7 +59,11 @@ static int gro_cell_poll(struct napi_struct *napi,=
 int budget)
> >>>               skb =3D __skb_dequeue(&cell->napi_skbs);
> >>>               if (!skb)
> >>>                       break;
> >>> -             napi_gro_receive(napi, skb);
> >>> +             /* Core GRO stack does not play well with clones. */
> >>> +             if (skb_cloned(skb))
> >>> +                     gro_normal_one(napi, skb, 1);
> >>> +             else
> >>> +                     napi_gro_receive(napi, skb);
> >>
> >> I must admit it's not clear to me how/why the above will avoid OoO. I
> >> assume OoO happens when we observe both cloned and uncloned packets
> >> belonging to the same connection/flow.
> >>
> >> What if we have a (uncloned) packet for the relevant flow in the GRO,
> >> 'rx_count - 1' packets already sitting in 'rx_list' and a cloned packe=
t
> >> for the critical flow reaches gro_cells_receive()?
> >>
> >> Don't we need to unconditionally flush any packets belonging to the sa=
me
> >> flow?
> >
> > It would only matter if we had 2 or more segments that would belong
> > to the same flow and packet train (potential 'GRO super packet'), with
> > the 'cloned'
> > status being of mixed value on various segments.
> >
> > In practice, the cloned status will be the same for all segments.
>
> I agree with the above, but my doubt is: does the above also mean that
> in practice there are no OoO to deal with, even without this patch?
>
> To rephrase my doubt: which scenario is addressed by this patch that
> would lead to OoO without it?

Fair point, a detailed changelog would be really nice.

