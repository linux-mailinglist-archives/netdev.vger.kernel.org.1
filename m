Return-Path: <netdev+bounces-88677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6283F8A8309
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F0C1C20F00
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8213D26B;
	Wed, 17 Apr 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT9y2ROx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74713D24E
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356488; cv=none; b=DEiTCRHB0vtOf2vReEFArIkBg1BeclBi9FWujMovB37RpQBu2313ojID4KRj4GLhpStdWoMIXArtaMGYE/aQ2B0pFrk22n9UmydUdch+0a2n2SGt+CbilbbdOj8l6RdUDtEknNKPfOInMGsxrrXFUwsrj6Q6KIZwhyWbBXhx34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356488; c=relaxed/simple;
	bh=esShElYFZxUhjKZSvxLLVxFg6HzMryXrTuFktnP3W4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IC/lgXZyNcRZZX6hcCcyHgVlIbsG+doeTnr5/zoPkrbaFvfEDrGwtyASqKN87myACWWWChVZ1w9/9k5kqAUW0xcS4iwisEbkSJ5FbaDvX+Zf00Qbl5LPjBekWK6SMS2BG92DdiR8lyMSTcn7PnvQj7OZgvQDy3fwRSAguKU/edk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT9y2ROx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5252e5aa01so539999866b.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713356485; x=1713961285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/4xZRAwBLy33akzdT95ik1nm+yFhLQQ/KeyO6VLvvE=;
        b=nT9y2ROxEqGAGF4ryhhRc6BF43k5RsQRSSod/+MCUeX+JqQmbXGz1sY//2r+iH2dah
         2rwB6izxNdjujs1Oa6gI97/rX6vxM6Q7G2MBemEQVZMVKzEPrfYQY3uKfBoPv+3JwnNM
         LFcT2dbhqZAZAggE+DgX0gYL5yzViQwYFoji8+R0GTqUMLy3gyHNS70HKBU08oOxbON6
         XsuNRxMmUkGXC9wtfESY2+ZV+f+IGI94fpEGAkwAV9d1xiiS2Vz0CGp92FJLUMsh7zQ+
         5fp7WqzxBNAWGLgWMqNkSZGCopykbSYpsvDnpJ2AbsZ/dtcZPSZcj9y12bnKL06MTO0z
         ggDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713356485; x=1713961285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/4xZRAwBLy33akzdT95ik1nm+yFhLQQ/KeyO6VLvvE=;
        b=tLYNeGQfC3/A/z3fgKzwlR/4oC8wGqwiTrH3FCSRVJoQi0WDz/xrlUYZtn5/gMJACJ
         MH6+t2wj6PAcnIow5NE2WTiHI9BZwUT8IWaRIcMqdtIPciTglMrs4EHCmAVMbpjsM3w7
         tRyBR7en+Ssv6Kx2pkfMZ5jI3MGMAeMtjzRtt5cnLJsXgYrRxJ58Rrszwln/3IRJwxpQ
         3BmN4FObjYR5Kyl57yQqe0FQB6U8cAdtPWIHOxzafvKWxFU2T49te04fZGjXH3Aw09qQ
         IWybQ3M9l8jVDEKnVK7wTKQdrFrkHsowSl0ibppSTneCx7fY4bFuh1IseQ1sQNNwlMrH
         i0DA==
X-Forwarded-Encrypted: i=1; AJvYcCUnWnlcKnVBS/EEi8Am7edKFiXgBNzgcUmUIczfuqqQNiMVK2QRcKQL/eqV7PwVOCoLeXu5nCk2LWZgyU+8LuFTEtqPSq+b
X-Gm-Message-State: AOJu0Yxbo8Lxe38VbFXgW3MIhagyTFpKKsRewCDbyGDxzmuH8aF9furE
	BhDVtuI+DqQQZZcJIhqWA5ggSOXkfts1QLdqRyRDsMr01RuX1m4y0WZdaVOFvs7fcH5LrG+9/5t
	WMC1fA+KB6p9m18Jh0eCY2AebbmQ=
X-Google-Smtp-Source: AGHT+IFRBDT3M4Yzq0anVqc3mHwQisyWrrQx/dEIzdTgRQ/sSOCw90mrYdoZJbaAjL1+s7HwaJ8rl/VuwKZuZOq9VFo=
X-Received: by 2002:a17:907:934c:b0:a52:5a6c:a359 with SMTP id
 bv12-20020a170907934c00b00a525a6ca359mr7583969ejc.63.1713356484403; Wed, 17
 Apr 2024 05:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417062721.45652-1-kerneljasonxing@gmail.com>
 <20240417062721.45652-3-kerneljasonxing@gmail.com> <CANn89iLKxuBcriFNjtAS8DuhyLq2MPzGdvZxzijzhYdKM+Cw6w@mail.gmail.com>
 <CAL+tcoBZ0MCntKO2POZ9g6kZ7euMXZY94FWN85siH1tZ6w5Lrg@mail.gmail.com>
 <CANn89iJovrpBc8vFadJZdA89=H5Qt8uvj2Cu3jr=HHP2pELw2Q@mail.gmail.com>
 <CANn89iJm3Pokx2hJy4af-frhV2+cadRYBSydG2Pc5w3C7d8RrA@mail.gmail.com> <CAL+tcoCW2-T3tkNdV6phLTwEj6Hejp5FR13ZB6jDScUCpTV0yQ@mail.gmail.com>
In-Reply-To: <CAL+tcoCW2-T3tkNdV6phLTwEj6Hejp5FR13ZB6jDScUCpTV0yQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 20:20:47 +0800
Message-ID: <CAL+tcoDzUn=Qe9=Ar+VUPt1vgGvSAh+KBHZRO30yKPGwP87VDg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: rps: protect filter locklessly
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:14=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Apr 17, 2024 at 7:58=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Apr 17, 2024 at 1:52=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > @@ -4668,7 +4668,7 @@ bool rps_may_expire_flow(struct net_device *dev=
,
> > > u16 rxq_index,
> > >                 cpu =3D READ_ONCE(rflow->cpu);
> > >                 if (rflow->filter =3D=3D filter_id && cpu < nr_cpu_id=
s &&
> > >                     ((int)(READ_ONCE(per_cpu(softnet_data,
> > > cpu).input_queue_head) -
> > > -                          READ_ONCE(rflow->last_qtail)) <
> > > +                          rflow->last_qtail) <
> > >                      (int)(10 * flow_table->mask)))
> > >                         expire =3D false;
> > >         }
> >
> > Oh well, rps_may_expire_flow() might be called from other contexts, so
> > only the  READ_ONCE()
> > from get_rps_cpu() is not really necessary.
>
> Thanks for telling me the access logic about qtail in the previous email.
>
> Yes, I'm writing exactly what you're saying now :) I can keep
> protecting rflow->cpu and rflow->filter locklessly.
>

I can keep these three patches just like now only without that
READ_ONCE(), I have to update my statement.

[...]
> I can remove the unneeded annotations around qtail as you suggested
> with those two patches if I can, or you can submit it first. It's up
> to you :)

The 'qtail' also needs protection. What I was saying is not true.

>
> Thanks,
> Jason

