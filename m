Return-Path: <netdev+bounces-101166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF7F8FD967
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631CB283FBB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3EE15ECDE;
	Wed,  5 Jun 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVk188Bu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7CE567
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624516; cv=none; b=ZeJc0mRiuvP3JUbCIfQjhdL1Dv9T1xhFg0mYSEr3zdZo01uWEtI3t5LOsmyPWfGLmEl/+jn+Kb/V70Ceenv0K/GeJwtODPewm/OYe+30EMN3AdUMprGsIdNIHbOKLkPGnVhr3bZ7XRpj1TAmhWFFaW2b/lnggBHjdTTeW9adpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624516; c=relaxed/simple;
	bh=UZPbW0IR5w36PFk3ukWzR4v3+jjQ/ha9eGYPOLhBOWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2/0fEcE9ZxXfX8WPYzO5HwUqv9JPmdOzmK00GYDDMuucmP0XoKbzh2cGX7ciNqDs+0jpcZ/OgCKAiyQXekN6S7U9/jusxgP+C8AjU69vQRWaOxYPZszCBB9932hxnUFxdhc2x1ALYMqStavKc8kPagl321yXZRx2gqCUmMVQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVk188Bu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717624513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV6Lkl8TnoF8BuIaryKVon5GWIOQyEZj6XsfC7CIoHI=;
	b=OVk188BufIhcbRZMhThbUUvOhNDmmXP65xtUuyce+Js3CcL4LpZxsCLMIBGlQqZi2dv8AM
	TAtOSATmG4y+MOXI22MoRKIPW1bcptOFVIqjcD/mQFIDD+C8R0QveslsrM9T+QbrsGPvOu
	81x0GFcBtJQXZaBn5Cb1tuRK/C0MsIE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-4FLU0yUfOsSwJY8O_b42Ng-1; Wed, 05 Jun 2024 17:55:12 -0400
X-MC-Unique: 4FLU0yUfOsSwJY8O_b42Ng-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2eaad38d35bso1517591fa.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 14:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717624511; x=1718229311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV6Lkl8TnoF8BuIaryKVon5GWIOQyEZj6XsfC7CIoHI=;
        b=ETaDugOf6wbt1ipuEhAyAfhqE2cYDyUaLhhrw+ylzyRnJT7HZQC4VhKY/meoYxZ9vx
         aQLR6q+oDL+GKUrsynff2CQKEh5EF/08k0yOFKftQ0+C2qCiX86x0iecZBNxf6JLY4qu
         TJdznLbSCyYNXtz6K5dHvTlovaIspIL7PpqI+b4O8S3y2zk6RFEyeD+b/gaGKsA6Ctx6
         +YyV8AbjIb/jSYmiRP8NpZnSurdZuU282z3fEFiDu2ZvS3sXZdjHMYlCb1WMVVlq7FM4
         1hMaDSgVwi1d/QNv8Ly8TYiFVrMp1vYpZiaWl746kMS8vvMX+BbFIvcJ9Wuq4Otiu32+
         ZaFg==
X-Forwarded-Encrypted: i=1; AJvYcCWig+e1PeAGPxDK0WxfCRvuHmLMoWzIkxXwhWfqVLFiSeRFdmnsXrfGXig87pcTNsPaUcGBPtCgVnTfhWvmwv5RwEVM5Adj
X-Gm-Message-State: AOJu0Yxf/7L+GedR3C8UcAlUP9Mtq5vCfPF1/OOG1xmJgYefCph5l0OW
	ZEz1nTN1REiP5imh66V4GT12q7IVUmilCeOkYonV93IEsXBJ/zNeblJzCk4bfJGF+wdv9dCavwS
	WrdC1TO5wDEvjo1CNI2hO4fpkk2Iq0BAlX5shfExhlvCGuBw9S2AJRJ1utltIel7Hs5Fh9GpYqp
	uAYqmhT24M9TDG/idwi3IcE2opn2ID
X-Received: by 2002:a2e:b0cd:0:b0:2e0:aaaa:e551 with SMTP id 38308e7fff4ca-2eac7a526fbmr24710281fa.37.1717624510873;
        Wed, 05 Jun 2024 14:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvLt/CiRPb5P9lD0+sOKcBCQ55vqYildzdGoOchGzeuB+TiwlAiSzLIpChot7zB6HH1kJrimAfbRzc2fsqGUk=
X-Received: by 2002:a2e:b0cd:0:b0:2e0:aaaa:e551 with SMTP id
 38308e7fff4ca-2eac7a526fbmr24710171fa.37.1717624510451; Wed, 05 Jun 2024
 14:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
 <41e4b0e3-ecc0-43ca-a6cd-4a6beb0ceb8f@datenfreihafen.org> <20240603165543.46c7d3b4@kernel.org>
 <CAK-6q+j7vBbeB5ZPdT6szgUzYhDiPyVuadLooOywOU7M0fpfzQ@mail.gmail.com> <cb91e5d3-7596-4564-9e0b-4819e437a692@datenfreihafen.org>
In-Reply-To: <cb91e5d3-7596-4564-9e0b-4819e437a692@datenfreihafen.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 5 Jun 2024 17:54:59 -0400
Message-ID: <CAK-6q+hULQbxFGyJ2t29VqjgnHgvUJ7J+Hsf8Pv-_0QaiNCTCg@mail.gmail.com>
Subject: Re: [PATCH] net: mac802154: Fix racy device stats updates by
 DEV_STATS_INC() and DEV_STATS_ADD()
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Yunshui Jiang <jiangyunshui@kylinos.cn>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 5, 2024 at 4:02=E2=80=AFPM Stefan Schmidt <stefan@datenfreihafe=
n.org> wrote:
>
> Hello Jakub, Alex,
>
> On 04.06.24 15:52, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Jun 3, 2024 at 7:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >>
> >> On Mon, 3 Jun 2024 11:33:28 +0200 Stefan Schmidt wrote:
> >>> Hello.
> >>>
> >>> On 31.05.24 10:07, Yunshui Jiang wrote:
> >>>> mac802154 devices update their dev->stats fields locklessly. Therefo=
re
> >>>> these counters should be updated atomically. Adopt SMP safe DEV_STAT=
S_INC()
> >>>> and DEV_STATS_ADD() to achieve this.
> >>>>
> >>>> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> >>>> ---
> >>>>    net/mac802154/tx.c | 8 ++++----
> >>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> >>>> index 2a6f1ed763c9..6fbed5bb5c3e 100644
> >>>> --- a/net/mac802154/tx.c
> >>>> +++ b/net/mac802154/tx.c
> >>>> @@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struc=
t *work)
> >>>>      if (res)
> >>>>              goto err_tx;
> >>>>
> >>>> -   dev->stats.tx_packets++;
> >>>> -   dev->stats.tx_bytes +=3D skb->len;
> >>>> +   DEV_STATS_INC(dev, tx_packets);
> >>>> +   DEV_STATS_ADD(dev, tx_bytes, skb->len);
> >>>>
> >>>>      ieee802154_xmit_complete(&local->hw, skb, false);
> >>>>
> >>>> @@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, stru=
ct sk_buff *skb)
> >>>>              if (ret)
> >>>>                      goto err_wake_netif_queue;
> >>>>
> >>>> -           dev->stats.tx_packets++;
> >>>> -           dev->stats.tx_bytes +=3D len;
> >>>> +           DEV_STATS_INC(dev, tx_packets);
> >>>> +           DEV_STATS_ADD(dev, tx_bytes, len);
> >>>>      } else {
> >>>>              local->tx_skb =3D skb;
> >>>>              queue_work(local->workqueue, &local->sync_tx_work);
> >>>
> >>> This patch has been applied to the wpan tree and will be
> >>> part of the next pull request to net. Thanks!
> >>
> >> Hi! I haven't looked in detail, but FWIW
> >>
> >> $ git grep LLTX net/mac802154/
> >> $
> >>
> >> and similar patch from this author has been rejected:
> >>
> >> https://lore.kernel.org/all/CANn89iLPYoOjMxNjBVHY7GwPFBGuxwRoM9gZZ-fWU=
UYFYjM1Uw@mail.gmail.com/
> >
> > In the case of ieee802154_tx() yes the tx lock is held so it's like
> > what the mentioned link says. The workqueue is an ordered workqueue
> > and you either have the driver async xmit option (the preferred
> > option) or the driver sync xmit callback on a per driver (implies per
> > interface) basis.
>
> When I reviewed and applied this I did indeed not realize the ordered
> workqueue making this unnecessary.
>
> > I also don't see why there is currently a problem with the current
> > non-atomic way.
>
> For me this looks more like a wrapper that could avoid future problems
> for no cost. I would not mind if the patch stays. But you are right, its
> not strictly needed. Want me to back it out again?

it's fine for me. I think atomic ops, depending on $ARCH will mess up
your pipelines in some kind of way but it is better than using locks
of course (but locks are here required for other things).

- Alex


