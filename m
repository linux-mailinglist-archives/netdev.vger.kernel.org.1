Return-Path: <netdev+bounces-169840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1441AA45F1D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5333B9745
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F8219315;
	Wed, 26 Feb 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDpHKWHA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AB258CD2
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572805; cv=none; b=QUvA31WRzplFvwTG6/OzEsCaGFyhUVbzUcwJTQKKF9pF6P5RK/8HFTXj8wbV46EJH6MT7RkKkfOOQN1Wh+ozEeOyX5iRC7E5UgA6phcWR/e8ON4gyqfKO7QfWoGd3u9C3v9OhARhV9vwhpy8AdqdxMWACWRW6aX3/o6FES3gl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572805; c=relaxed/simple;
	bh=dfGwQT6Z6ADVVp2LOd+a7eUAH5ydhFhelNN8e/ZtFTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN21hubBAUNjDR68QWAt2RCtjkRN75/sdpeVgcn/9HHgAjKUGbcADrQmNc+0zMfRstz/vLlJJQnY9K19UILT2pwo+imt3U7EaLTzeVCNQciG/1RIgrsmh/ThBsa8zrPaD6ekVxJA2p8fYLd4fh4Mlvkqfgdl+0s8wZ2lkpJ8PRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDpHKWHA; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86b31db3c3bso110521241.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740572802; x=1741177602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ4VKhlYK2/ZXD4nfaVh7YFXQG1jb7/tPqW7V+JCSzE=;
        b=aDpHKWHAL+IuiWIGov3gYUUFxsfWsfmqii3ToIrc5ZpYbls7/l1QJ/g28QuMNmtuAg
         aTuTiyLxHDFH5fGm9frwOA1inLnibuOXhb8GJ0YjYC5yobK9EA4M0ydTOxgdFAyp9dGW
         2CKNOXqIoHuidrT2KVbvxl8JrpDkSv+MvXPzUlb80W+PntBeiFwobJY1sE72de53WkMZ
         JJuQor+ksgeLCCiLNsAGCRHH7r4C3eXq8Y+fFpPT3/F+18Xx+cLdq6XnH+hOyeL7k0Fr
         fSLHdwUpptd9IFHccHO8PoX593+HttRWubD8puAS71V1xlvXbvx6Ex3/48NzubcN6lRW
         ftaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740572802; x=1741177602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ4VKhlYK2/ZXD4nfaVh7YFXQG1jb7/tPqW7V+JCSzE=;
        b=S0fnYB1N7nKdpXkS7eVCFNlGPrslz5sswHeo7MvNkJvA1cNGJxufteXDf1Ip9jmB9R
         kFa71hW8cOPFI4zvoXhW8SZvmrQZTUGq4dceB1CiRoKl72LK7ohgbmHDO/EtR3+opf98
         l31qCQV8F/8iUoxmGKUblC9Y1rtMnswdGGuUKl9e6zKH+YDJ2AustDwxKxTZRrssgCdX
         Y9izZ9/StNL7JNneGNuBABZuzIHQb36/sLute6WSTUoHM4iGYkFTVVY9FB++/AwjJ4tI
         ySLJELqe/RVeQ7InmBsngEHv0ndmpeVn90oUaRISwS9JST/vTFs6lGU3qSqSrt8KSGxV
         wwBA==
X-Forwarded-Encrypted: i=1; AJvYcCVIRTVrf9HwLjb98WpOXcfsEUUeZjH78bJyJOZmp4tNcUXP8hMbIdMA3RIB8HJ4SBO3N/xmTkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJipNIxB8dbfs1o+JGAHe9pU9ytimzygE1BS1C+mKQ++UMTDI
	TSC4VcflLBvEJUtKFxzmBw0ovx/ROEsFe9eCMIoljo4A05Ar7reeL/XA/5TvyVYkB6Tb+o86sjR
	CRUkvnFSBr7jjMjlXdN2wCP7TeGdcFg==
X-Gm-Gg: ASbGncvEesqsD26Ard7qKVkvbhP/G09gTgACTmyZVA4O6+RuWUeG7NIT6IDzxst+wVR
	x6/Ga5XCCa85zQuAVwExcywEWym3+RH5AGYTZP4EDc77N/cWpjBXd1CM9w4fRyLITTOAw4FemhZ
	y8VooKoA==
X-Google-Smtp-Source: AGHT+IFWEliztNJ7dEx4yF2jHTH1A2/oyXvEJH/XYMVH4tRt1UhsJsVybxy9RLdHdGKdFDixG+kfemasXWie1M7GBj4=
X-Received: by 2002:a05:6102:26c3:b0:4ba:9689:872e with SMTP id
 ada2fe7eead31-4c01e1d052bmr1211277137.10.1740572802498; Wed, 26 Feb 2025
 04:26:42 -0800 (PST)
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
 <ed6723e3-4e47-4dac-bc42-b65f7d42cbea@blackwall.org>
In-Reply-To: <ed6723e3-4e47-4dac-bc42-b65f7d42cbea@blackwall.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 26 Feb 2025 13:26:31 +0100
X-Gm-Features: AQ5f1Jr9VAx7Kbz0n2CDbmjhdGS4NtKDuEo5ucm4Tufxxlphvik__t46I5D-fDo
Message-ID: <CAA85sZv5rQr4g=72-Tw47wSE_iFPHS4tB8Bgqcs59sdh1Me2sw@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 1:00=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 2/26/25 13:52, Ian Kumlien wrote:
> > On Wed, Feb 26, 2025 at 11:33=E2=80=AFAM Nikolay Aleksandrov
> > <razor@blackwall.org> wrote:
> >>
> >> On 2/26/25 11:55, Ian Kumlien wrote:
> >>> On Wed, Feb 26, 2025 at 10:24=E2=80=AFAM Ian Kumlien <ian.kumlien@gma=
il.com> wrote:
> >>>>
> >>>> On Wed, Feb 26, 2025 at 2:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.=
org> wrote:
> >>>>>
> >>>>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> >>>>>> Same thing happens in 6.13.4, FYI
> >>>>>
> >>>>> Could you do a minor bisection? Does it not happen with 6.11?
> >>>>> Nothing jumps out at quick look.
> >>>>
> >>>> I have to admint that i haven't been tracking it too closely until i=
t
> >>>> turned out to be an issue
> >>>> (makes network traffic over wireguard, through that node very slow)
> >>>>
> >>>> But i'm pretty sure it was ok in early 6.12.x - I'll try to do a bis=
ect though
> >>>> (it's a gw to reach a internal server network in the basement, so no=
t
> >>>> the best setup for this)
> >>>
> >>> Since i'm at work i decided to check if i could find all the boot
> >>> logs, which is actually done nicely by systemd
> >>> first known bad: 6.11.7-300.fc41.x86_64
> >>> last known ok: 6.11.6-200.fc40.x86_64
> >>>
> >>> Narrows the field for a bisect at least, =3D)
> >>>
> >>
> >> Saw bridge, took a look. :)
> >>
> >> I think there are multiple issues with benet's be_ndo_bridge_getlink()
> >> because it calls be_cmd_get_hsw_config() which can sleep in multiple
> >> places, e.g. the most obvious is the mutex_lock() in the beginning of
> >> be_cmd_get_hsw_config(), then we have the call trace here which is:
> >> be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_compl -> us=
leep_range()
> >>
> >> Maybe you updated some tool that calls down that path along with the k=
ernel and system
> >> so you started seeing it in Fedora 41?
> >
> > Could be but it's pretty barebones
> >
> >> IMO this has been problematic for a very long time, but obviously it d=
epends on the
> >> chip type. Could you share your benet chip type to confirm the path?
> >
> > I don't know how to find the actual chip information but it's identifie=
d as:
> > Emulex Corporation OneConnect NIC (Skyhawk) (rev 10)
> >
>
> Good, that confirms it. The skyhawk chip falls in the "else" of the block=
 in
> be_ndo_bridge_getlink() which calls be_cmd_get_hsw_config().
>
> >> For the blamed commit I'd go with:
> >>  commit b71724147e73
> >>  Author: Sathya Perla <sathya.perla@broadcom.com>
> >>  Date:   Wed Jul 27 05:26:18 2016 -0400
> >>
> >>      be2net: replace polling with sleeping in the FW completion path
> >>
> >> This one changed the udelay() (which is safe) to usleep_range() and th=
e spinlock
> >> to a mutex.
> >
> > So, first try will be to try without that patch then, =3D)
> >
>
> That would be a good try, yes. It is not a straight-forward revert though=
 since a lot
> of changes have happened since that commit. Let me know if you need help =
with that,
> I can prepare the revert to test.

Yeah, looked at the size of it and... well... I dunno if i'd have the time =
=3D)

> >> Cheers,
> >>  Nik
> >>
>

