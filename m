Return-Path: <netdev+bounces-219032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B7B3F720
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8324801C2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E862E7BA9;
	Tue,  2 Sep 2025 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXPw86tN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C62E62C4
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799751; cv=none; b=QgizaY9RParMuPs2OVjcOes25bQSTSf5f3RkTbSq49ikpj7ZogGZqu3jqbHCsi4YtyWpflOw0AXuuMjNzksu+GcmV7XmHFbiUZHNvEKab2PVeG0B4BgyGne+6uCVmrcurksXyabfdjrPpcXKudqh+AvQSRkRJ+XYh3VTUIhl1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799751; c=relaxed/simple;
	bh=R5JjKpinWBFnUUW6V+Dh6HjBmrEj9fHJDeaWWnI8TTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS46OZTGGGSWfJUWqSyHINmZc3QoYC1wEDgw6vQ5o+qj5UuR8m8L7HqOCh6zQaHxDRX79qvQeK6XNP4aw3X6xzs4Ir1K649RqbKMOsarVSwEQl+nMIitnWMoMO+TysPGaxpqeNRALP9DWUm/5hv403Xg/ZHldQrmdOp0Cx3Z0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXPw86tN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7f722cb35fdso433786185a.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756799747; x=1757404547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5JjKpinWBFnUUW6V+Dh6HjBmrEj9fHJDeaWWnI8TTo=;
        b=eXPw86tNvPqSWpaNgBAANR+N24d9f2YrjVbDKiR3ud31y0lGVaukJllmZ03xW58fcQ
         3d0FY7imtT/T/qJ34iUIIjw1gLIVs+Uk+bHezJhfdyOEs13ZM2MsrCUp9+1SAK52gDSq
         7lgpr6bmu3SF5T7a3Cw/HmgnYPokuV349vb9QdNBGlMk2hm1jD2LW9qWruMabRKUBOU7
         fydSfLxtL1I3HKXZmBDw8WKb0oi9ugBAbOuhVvAwGzdzRN5diMtrYrFXntNRFUQR4zP+
         Sb5WIdcIi4wAmBrFULv5DPNHfxHFzS32FBMZPPbnCRmvAq1RM3aI3cO8M2z9rJHOmVt3
         ZSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799747; x=1757404547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5JjKpinWBFnUUW6V+Dh6HjBmrEj9fHJDeaWWnI8TTo=;
        b=r7ZvYORVw0yKl0pJ1qnJI/VZwn7mbl/hp1OrCkR9T1mtBgajZCBxwF/yUJ5+4/mqse
         i/CPy9L6y3AXirsrf9acFl8yDZMt6nwmmFtRYMf1w0f/AgGb6zwOwsOu+4Lxf6CIACyg
         RgDR0hwaFQd3VJfZtUwAgA+52ELUDI8m/bgVJnLSpwNXY78qOEeP5+ErabCKHiQRspsj
         A1AMuvdl1078GW+bCOZYwEUBu/e5a6oidCJjT6OtkoJ4Z452NWfLVamVtcAot+YXG5n5
         gPeD7uimW48TWEhiPzV+/rQ/zearwQkcgjZEyVNBiOc+mp1ZGjWU/n2zZAJRu408mzGe
         EvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5khW1Xky0sUhDnDwxbtmykTCEQaf30bufAKgPiTRWot+xgofrcFyqFmOcUubaoDNS7At+3b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeswdaM73qbma0a3dikw2peLWTW9zV53tBSXNDXGq8FqOcBQX+
	l4IVyuyqP469m/Pktv1P7AQV/LBadPOCPXSXUjbav/Ppy3yQnApmWA4jU1We3pVbseZUGaZ22cY
	/+cTAaisef6RP0jpigSYx9xFNAj56BvAlOZVWTeln
X-Gm-Gg: ASbGnctvGvWnvZP/we9lV3Dg9i0WHrPrYE3tc6UliObZq/ERAHMaH/qVX9/X/80aM8A
	aiqIApNc8cEfY/Cu/yab8wbKwja3R3U9+na2hXIu38iRtN/pW5fmqEzqvUm2INYENzoO3M6isyu
	FQRmR7YdYo4xEO1YR5a1avAQkZ9r9ExScaIF0vEAQ+DJPhtZrKigvIZqBea2EGkJI6ueBQ+8VCo
	yn8+zKAg4YJr8aJw3dljIat
X-Google-Smtp-Source: AGHT+IGbwtGdrMFQZ6o9HkrZ8v5t2SSqHd4hp6DHCZ4rLDynbaulRNdShi8IFB6n5mcJNPHAyAg0ACU3bKwX6hPljxQ=
X-Received: by 2002:a05:620a:3950:b0:804:c43:1b68 with SMTP id
 af79cd13be357-8040c431f3emr614482485a.37.1756799746971; Tue, 02 Sep 2025
 00:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <11212ddf-bf32-4b11-afee-e234cdee5938@free.fr> <4e4c9952-e445-41af-8942-e2f1c24a0586@free.fr>
 <90efee88-b9dc-4f87-86f2-6ab60701c39f@free.fr> <6c525868-3e72-4baf-8df4-a1e5982ef783@free.fr>
 <d073ac34a39c02287be6d67622229a1e@vanheusden.com> <6a5cf9cf-9984-4e1b-882f-b9b427d3c096@free.fr>
 <aKxZy7XVRhYiHu7c@stanley.mountain> <0c694353-2904-40c2-bf65-181fe4841ea0@free.fr>
 <CANn89iJ6QYYXhzuF1Z3nUP=7+u_-GhKmCbBb4yr15q-it4rrUA@mail.gmail.com>
 <4542b595-2398-4219-b643-4eda70a487f3@free.fr> <aK9AuSkhr37VnRQS@strlen.de>
 <eb979954-b43c-4e3d-8830-10ac0952e606@free.fr> <1713f383-c538-4918-bc64-13b3288cd542@free.fr>
 <CANn89i+Me3hgy05EK8sSCNkH1Wj5f49rv_UvgFNuFwPf4otu7w@mail.gmail.com>
 <CANn89iLi=ObSPAg69uSPRS+pNwGw9jVSQJfT34ZAp3KtSrx2Gg@mail.gmail.com>
 <cd0461e0-8136-4f90-df7b-64f1e43e78d4@trinnet.net> <80dad7a3-3ca1-4f63-9009-ef5ac9186612@free.fr>
 <CANn89iJGdn2J-UwK9ux+m9r8mRhAND_t2kU6mLCs=RszBhCyRA@mail.gmail.com> <e901a424-fe95-4adc-9777-31d54464d2c5@free.fr>
In-Reply-To: <e901a424-fe95-4adc-9777-31d54464d2c5@free.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Sep 2025 00:55:36 -0700
X-Gm-Features: Ac12FXwRiNH6f-m_ly0qAGDfsRps5QoJbfAaPta3A9HiVXiyeBrarvblQGapAEc
Message-ID: <CANn89iKe3x4yEO940oDLfypDNoejjaX5xf+ksnnpMXpBpApQJA@mail.gmail.com>
Subject: Re: [ROSE] [AX25] 6.15.10 long term stable kernel oops
To: F6BVP <f6bvp@free.fr>
Cc: David Ranch <linux-hams@trinnet.net>, Paolo Abeni <pabeni@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-hams@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>, Dan Cross <crossd@gmail.com>, 
	Folkert van Heusden <folkert@vanheusden.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:45=E2=80=AFAM F6BVP <f6bvp@free.fr> wrote:
>
> I tested the fix and validated it on different kernels versions.
>
> All are doing fine : 6.14.11 , 6.15.11, 6.16.4
>
> Congratulations and many thanks to Eric Dumazet for spending his time on
> repairing AX25 mkiss serial connexions.
>
> Hamradio fans will be able to continue experimenting with AX25 using
> next Linux developments.
>

Great, many thanks again for your report, bisection, and tests.

I will send the formal patch right away.


> Bernard Pidoux
> F6BVP / AI7BG
> http://radiotelescope-lavillette.fr
>
>
> Le 01/09/2025 =C3=A0 18:03, Eric Dumazet a =C3=A9crit :
>
> > Keep calm, I am just saying that the bisection pointed to a fine commit=
,
> > but it took a _lot_ of time to root-cause the issue.
> >
> > And the bug is in ax25, not in Paolo patch.
> >
> > Please test the fix, and thank me for actually working on a fix, while
> > I have more urgent work on my plate.

