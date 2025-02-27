Return-Path: <netdev+bounces-170302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2CBA481B7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E6A17DCDB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1D2356BC;
	Thu, 27 Feb 2025 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARVFvUGh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1023315D
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666687; cv=none; b=MOCOE1vf+sL4sGYLH/qnEgYYC2xKjuMJno885Qug4u92S8Rvoqy0LIgqYmHQ0J61uZsMyJHAX/oEirnj+cICAsOXokvfPuvzGtvTmWkjxSCkuk4AMg4tkuMaXwmRyk0qZPO7Eo2X9+AyqjIO4JhZnsu4VmhAMyYv7YkZ3IwuTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666687; c=relaxed/simple;
	bh=T9QzWcLOXOQXQjcM6eYV/Cyk+UlJko/awLN5+bSG5io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anboa7YuLDtUWijKs0aNwgpeTZGbq0KE9Q26Awc9rbVE00szLo0gjlnuD7RSummHbSv+Ks1ygAnvnctGWI9I8qTnsCKshp+KZ8qhz9ywOBpeCyq923bbGr3cEMOfM3Z7tSWR5dTLE+wiUUAF+zy4NNO2g3ufrEwTIiw5pj5W5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARVFvUGh; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-520a48f37b4so906511e0c.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740666685; x=1741271485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3eKcDG9f3N58Qw2/fYvN7NI4YADnHzKwIsHBe2Fbhk=;
        b=ARVFvUGhl3MS2d8HH59j4cysfQy3xYm9VaB6e7oMImBlwd8wfBQ0dLEzTV1DPAsNrg
         1OefeIcndBZ4kwJUSHyes5R96bjWflHaPHchgtBWtrUPFt6IMKQOokC6bqxIZ2kye4iX
         hP1QQebmWMIouihk14AkGkUUIXZzdSINBAIv+g0OBnsodPSEHaLqmQlQ/Iv7Ppyqxx7o
         CC5hmOZ43iOV+YQ8EF9PslBPNERJ2LLyxE36xmWwqII6MJ0TdGbHug7zpzIPxdR/pfWt
         F79G1NViKKPukDY5oSOk/OIG4zgZBKx0Cnx11U2Bi7X2GCAGKEYaBzV5wR5G/O3EdD43
         XZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666685; x=1741271485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3eKcDG9f3N58Qw2/fYvN7NI4YADnHzKwIsHBe2Fbhk=;
        b=m7/h8yVwvppcAHtHXNnkCix9P3+P9PQa7Itgofqg8iiENZRp3s/HTAvJ18jGNf7JtT
         4wk3pW1+SjvXfG0IE0zug7DKsriP7QhhCkVIWFRnSRsSLzECUVbboxNUXKxp0RrVrnO9
         PF198yR13g5vSjeqiHKim9mX69T9SYD7O2WV3mb6gW+BPWz6/CmUh+D1/dSdPEW0HyLd
         dVnlZ27DqC1LbEcHdbR2B/w46fLGIyjAZWd3d3STt//fgsOkOTbr4dnV4Qrc0na7BP5j
         YAgpHYVNEIqbJBt1StiamsSwwCDGzQK0WSUgsx4i+48+/JiD978Ncz6vL7zTLrdZvkzr
         8byg==
X-Forwarded-Encrypted: i=1; AJvYcCVlQ7mTfYCPm7w/MxQuK0TkXjbFDscgKvjhpwNAaFzhB4rcqC7qf6jmTr2wk2ysa26GlKbF2f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICz0aOwygYPe5OIfEqD6ndM/nPI/tnfcXNrIHZcXAAq1mLfNl
	+na9/QhNbQP8r5c9vum/7aiQPFnXIsgme54GY4mu+N0pgX6aEesrbCKMVdPBAd3NAeA6sr6xsnw
	pvc33mIyUDqhWb8TeDjXF1CE+y32jBW3y
X-Gm-Gg: ASbGncvFuhVlYv5CFPBHFYEVi7TlO7g8MuHQluk4+0x/7cpSZCfl+1DjYgV07CeC7u2
	JC6wxbNm7Gfi7pB93xh0HSEwrPpo1GRWTocK3b7pCoDSPCCcJcoMkLlm6coZVgRbRJWTfrX0/BC
	KJK9b1zg==
X-Google-Smtp-Source: AGHT+IEzkcMXiZIJ7YowdawU1WwnjoPS/QTOmFxCkvkmtBOAbLENUgTIu4LU+fss1+L2ouy9GxhqIsO0JTPUqgwSgX0=
X-Received: by 2002:a05:6122:4f9d:b0:520:5e9b:49b3 with SMTP id
 71dfb90a1353d-521efb648e1mr14591382e0c.3.1740666684920; Thu, 27 Feb 2025
 06:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
 <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
 <20250225170545.315d896c@kernel.org> <CAA85sZuYbXDKAEHpXxcDvntSjtkDEBGxU-FbXevZ+YH+eL6bEQ@mail.gmail.com>
 <CAA85sZswKt7cvogeze4FQH_h5EuibF0Zc7=OAS18FxXCiEki-g@mail.gmail.com>
 <a6753983-df29-4d79-a25c-e1339816bd02@blackwall.org> <CAA85sZsSTod+-tS1CuB+iZSfAjCS0g+jx+1iCEWxh2=9y-M7oQ@mail.gmail.com>
 <ed6723e3-4e47-4dac-bc42-b65f7d42cbea@blackwall.org> <CAA85sZv5rQr4g=72-Tw47wSE_iFPHS4tB8Bgqcs59sdh1Me2sw@mail.gmail.com>
 <4604b36b-4822-4755-a45c-c37d47a3adc2@blackwall.org> <CAA85sZutt0Eydh4B5AUb2xgvPkPF2Wa2yU4iXprgmRFPVM5qUQ@mail.gmail.com>
In-Reply-To: <CAA85sZutt0Eydh4B5AUb2xgvPkPF2Wa2yU4iXprgmRFPVM5qUQ@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 27 Feb 2025 15:31:13 +0100
X-Gm-Features: AQ5f1JrSVsBMnubVdYbs19ikWwpCkkrEg-A8EiFVLSR-cjc9PJKd3WNc97mBaNA
Message-ID: <CAA85sZsq4JnatO0TjhN=o6S4adq7pQDC8A5dtRrBKeY9ry0NfQ@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 11:28=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com=
> wrote:
>
> On Wed, Feb 26, 2025 at 2:11=E2=80=AFPM Nikolay Aleksandrov <razor@blackw=
all.org> wrote:
> >
> > On 2/26/25 14:26, Ian Kumlien wrote:
> > > On Wed, Feb 26, 2025 at 1:00=E2=80=AFPM Nikolay Aleksandrov <razor@bl=
ackwall.org> wrote:
> > >>
> > >> On 2/26/25 13:52, Ian Kumlien wrote:
> > >>> On Wed, Feb 26, 2025 at 11:33=E2=80=AFAM Nikolay Aleksandrov
> > >>> <razor@blackwall.org> wrote:
> > >>>>
> > >>>> On 2/26/25 11:55, Ian Kumlien wrote:
> > >>>>> On Wed, Feb 26, 2025 at 10:24=E2=80=AFAM Ian Kumlien <ian.kumlien=
@gmail.com> wrote:
> > >>>>>>
> > >>>>>> On Wed, Feb 26, 2025 at 2:05=E2=80=AFAM Jakub Kicinski <kuba@ker=
nel.org> wrote:
> > >>>>>>>
> > >>>>>>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> > >>>>>>>> Same thing happens in 6.13.4, FYI
> > >>>>>>>
> > >>>>>>> Could you do a minor bisection? Does it not happen with 6.11?
> > >>>>>>> Nothing jumps out at quick look.
> > >>>>>>
> > >>>>>> I have to admint that i haven't been tracking it too closely unt=
il it
> > >>>>>> turned out to be an issue
> > >>>>>> (makes network traffic over wireguard, through that node very sl=
ow)
> > >>>>>>
> > >>>>>> But i'm pretty sure it was ok in early 6.12.x - I'll try to do a=
 bisect though
> > >>>>>> (it's a gw to reach a internal server network in the basement, s=
o not
> > >>>>>> the best setup for this)
> > >>>>>
> > >>>>> Since i'm at work i decided to check if i could find all the boot
> > >>>>> logs, which is actually done nicely by systemd
> > >>>>> first known bad: 6.11.7-300.fc41.x86_64
> > >>>>> last known ok: 6.11.6-200.fc40.x86_64
> > >>>>>
> > >>>>> Narrows the field for a bisect at least, =3D)
> > >>>>>
> > >>>>
> > >>>> Saw bridge, took a look. :)
> > >>>>
> > >>>> I think there are multiple issues with benet's be_ndo_bridge_getli=
nk()
> > >>>> because it calls be_cmd_get_hsw_config() which can sleep in multip=
le
> > >>>> places, e.g. the most obvious is the mutex_lock() in the beginning=
 of
> > >>>> be_cmd_get_hsw_config(), then we have the call trace here which is=
:
> > >>>> be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_compl -=
> usleep_range()
> > >>>>
> > >>>> Maybe you updated some tool that calls down that path along with t=
he kernel and system
> > >>>> so you started seeing it in Fedora 41?
> > >>>
> > >>> Could be but it's pretty barebones
> > >>>
> > >>>> IMO this has been problematic for a very long time, but obviously =
it depends on the
> > >>>> chip type. Could you share your benet chip type to confirm the pat=
h?
> > >>>
> > >>> I don't know how to find the actual chip information but it's ident=
ified as:
> > >>> Emulex Corporation OneConnect NIC (Skyhawk) (rev 10)
> > >>>
> > >>
> > >> Good, that confirms it. The skyhawk chip falls in the "else" of the =
block in
> > >> be_ndo_bridge_getlink() which calls be_cmd_get_hsw_config().
> > >>
> > >>>> For the blamed commit I'd go with:
> > >>>>  commit b71724147e73
> > >>>>  Author: Sathya Perla <sathya.perla@broadcom.com>
> > >>>>  Date:   Wed Jul 27 05:26:18 2016 -0400
> > >>>>
> > >>>>      be2net: replace polling with sleeping in the FW completion pa=
th
> > >>>>
> > >>>> This one changed the udelay() (which is safe) to usleep_range() an=
d the spinlock
> > >>>> to a mutex.
> > >>>
> > >>> So, first try will be to try without that patch then, =3D)
> > >>>
> > >>
> > >> That would be a good try, yes. It is not a straight-forward revert t=
hough since a lot
> > >> of changes have happened since that commit. Let me know if you need =
help with that,
> > >> I can prepare the revert to test.
> > >
> > > Yeah, looked at the size of it and... well... I dunno if i'd have the=
 time =3D)
> > >
> >
> > Can you try the attached patch?
> > It is on top of net-next (but also applies to Linus' tree):
> >  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> >
> > It partially reverts the mentioned commit above (only mutex -> spinlock=
 and usleep -> udelay)
> > because the commit does many more things.
> >
> > Also +CC original patch author which I forgot to do.
>
> Thanks, built and installed but it refuses to boot it - will have to
> check during the weekend...
> (boots the latest fedora version even if this one is the selected one
> according to grubby)

So, saw that 6.13.5 was released so, fetched that, applied the patch
and no more RCU issues in dmesg

Will check more on the suspected performance bit as well when i get
home later tonight

I also understand Sathya Perla's motivation in saving power on this
but things around it have been changed
and it no longer works as intended....

> > Thanks,
> >  Nik
> >

