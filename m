Return-Path: <netdev+bounces-132520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F98991FE1
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88E71C20AD2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629E17CA1F;
	Sun,  6 Oct 2024 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmQNYOXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A42F9E4;
	Sun,  6 Oct 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235487; cv=none; b=QaVruFD2jZIKmRTFZr8jQiMUq4gdqSou8+uMSwkWmEOD4CPIjFeTgiL4OfZ3F5qW6kwjT3v1SisBeeVz5er5Zb4LkkvfT28iB2Au5nQtUV9hkUq+vRW4SA8YGpjNWLTYl31WTqMh82KJlUeIJlNSslcbdvdHevdgH5b8v7Kp1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235487; c=relaxed/simple;
	bh=2fGz3KDCfRGPhSy/5QFDgAdl2Tf/XHGIHJZ5BSKta64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWg84jblvpg/LSv4Tv7GbgY01ktJOpwixNBnY4sFyCTHm7WwYDRtCIo4EjJ0pZl2sosGj/2dAS44+8qXv6hcbVMq+YgHTFeEootuYcAn8u3YOy5solHJjn3MjXIu1h2AKOPIw/5bno8QD6esg39RV8NKHJO6P9Uahuzh92bQ9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmQNYOXK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea06275ef2so267283a12.0;
        Sun, 06 Oct 2024 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728235486; x=1728840286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbYAwkvWDSG9D9+tHniJsFSvQn8xIlp1Sld5HghW6Ws=;
        b=nmQNYOXKuNZKNjZ8iAVZlPJg0l+7MWWVwnaGWMhLS8/iKN71wFOldD39YyEQ7jz6ww
         0DCOA5rdbR3UAxwhfqEsB0RfQjCChgG8Tqp/9Ao30mPzlA2Z6fImmdyZEWZjRrYSYwOC
         SA4jRDWLo1D2urkeh1pALxVuFyGhjJ6oGFD8DcUcCWlVTxijf90opVlFKu45ZIF2Apb/
         KVhPuNBNOV05tUiZsZh26Ugc5QAt4kTpegs6wblVF33uuQDShI50fYQKS6kPunV5EPBh
         jZ9gi+h5XJ0cdRXluL1tsSQ6uTBKkT6I8YQTbDpwr/zPuwWwxMrRME8vDyX74jaKAS58
         yyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728235486; x=1728840286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbYAwkvWDSG9D9+tHniJsFSvQn8xIlp1Sld5HghW6Ws=;
        b=cdHcPPC5dLDm/mJdzhUoTn7HSj4xeNv/r0eZ4kxm0/WOdB3VCRVFV46tdZTrGlPdNh
         dbJORMAH8odDNphcw66MlbKCXhkD6WUFUhMvCJvBa3G/MTrtv5TYmHv0HzenbWtKSfFU
         cEyklDvzoWkQKkfzJjWGRmn0dIGOmTlaOc38YC+CJxMh9vF2Ujycv5cZ0nHx/B6FSjeb
         hvuVXBqiPmUvVBz09jS7ZQT2JTj+3fXl+euD+tyS/yQpsLxbpGAxkDQ5Kk80ZnTOgyVM
         f5wrcpDUMMR1nVnYUvryev69hoWNlgocYidIwt5Rjg0ayVd78AfC0wiy9vj4lB64yhvt
         X+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBxyJrHvCBoNPX/Sd2qOt7FvKcITgGzMPzxyt3gBlrB0zFeMXKxQ+6y/N8Mg5o+KZIM6jhp+c4@vger.kernel.org, AJvYcCX0WSzGpplf77rqigoTHTvmfEwhA2nMRhmWQ6qOC1492bgy9aNwITWoPeTi3iT5kpkzH3M2ZeH5VfTHK30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+m5kN9pLBZR+kP9iC0w7L1BXG8Lcr6Z2JrOmT/7E9jZ1ukEb
	y+98Oa9cOf1+KWy1PRfoULhugpKMdkdr/SoskJ6khcGhHf2Atr14Fbw1bzhYU1677DUM82Xtsk3
	Lnc/Oz4XmD2o/3vJcFCkeYojWphk=
X-Google-Smtp-Source: AGHT+IEKWiJBjLKDIaFaOkfEDPUqRHlD/TfcUp548Ta0mblv55/mAWH4xtREyw4zmdXVZiry7Yu1PYw8VwIpPFTooZw=
X-Received: by 2002:a17:90a:bc92:b0:2e0:9147:7db5 with SMTP id
 98e67ed59e1d1-2e1e63bf552mr10986428a91.38.1728235485708; Sun, 06 Oct 2024
 10:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005014514.1541240-1-ingamedeo@gmail.com> <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
In-Reply-To: <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
From: Amedeo Baragiola <ingamedeo@gmail.com>
Date: Sun, 6 Oct 2024 10:24:34 -0700
Message-ID: <CAK_HC7bOe2KhVnDiG4Z3tpkodiCkewEct7r2gXanjGBC8WwFsQ@mail.gmail.com>
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree, just patch actually changes the behaviour when a BR_FDB_LOCAL
dst is found and drops the traffic because promisc is *always* set to
false when a BR_FDB_LOCAL dst is found in br_handle_frame_finish().
I guess the problem I was trying to solve was that since the
introduction of the promisc flag we still use brdev->flags &
IFF_PROMISC in br_pass_frame_up() which is essentially the value of
promisc (except in the BR_FDB_LOCAL case above) instead of promisc
itself.

Amedeo


On Sat, Oct 5, 2024 at 7:06=E2=80=AFAM Nikolay Aleksandrov <razor@blackwall=
.org> wrote:
>
> On 05/10/2024 04:44, Amedeo Baragiola wrote:
> > Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack inp=
ut hook for promisc packets")
> > a second argument (promisc) has been added to br_pass_frame_up which
> > represents whether the interface is in promiscuous mode. However,
> > internally - in one remaining case - br_pass_frame_up checks the device
> > flags derived from skb instead of the argument being passed in.
> > This one-line changes addresses this inconsistency.
> >
> > Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
> > ---
> >  net/bridge/br_input.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index ceaa5a89b947..156c18f42fa3 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool=
 promisc)
> >        * packet is allowed except in promisc mode when someone
> >        * may be running packet capture.
> >        */
> > -     if (!(brdev->flags & IFF_PROMISC) &&
> > -         !br_allowed_egress(vg, skb)) {
> > +     if (!promisc && !br_allowed_egress(vg, skb)) {
> >               kfree_skb(skb);
> >               return NET_RX_DROP;
> >       }
>
> This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
> is found it will always drop the traffic after this patch (w/ promisc) if=
 it
> doesn't pass br_allowed_egress(). It would've been allowed before, but cu=
rrent
> situation does make the patch promisc bit inconsistent, i.e. we get
> there because of BR_FDB_LOCAL regardless of the promisc flag.
>
> Because we can have a BR_FDB_LOCAL dst and still pass up such skb because=
 of
> the flag instead of local_rcv (see br_br_handle_frame_finish()).
>
> CCing also Pablo for a second pair of eyes and as the original patch
> author. :)
>
> Pablo WDYT?
>
> Just FYI we definitely want to see all traffic if promisc is set, so
> this patch is a no-go.
>
> Cheers,
>  Nik



--=20
Thanks,
Amedeo

