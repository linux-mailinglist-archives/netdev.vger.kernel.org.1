Return-Path: <netdev+bounces-170337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA262A48390
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97ACD1890AF4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A7197A76;
	Thu, 27 Feb 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVRxITrp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52641AAA05
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671566; cv=none; b=gd9eMaMDPQAIW7qNIzlw+8zCd35uojjuKdp43I51OH3+5Ht7jcmAJ7Kt0xiBrej2xjOEgZE3nB3J26fdTuJlqMGJ5oNHL+hZbxKtiJKUMwZQWKjiWvhLNYpn+tavQF/8nJ+vuYnzzJRNj9Q/nmFsT9akvYzREVAKZm4dV1l4tEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671566; c=relaxed/simple;
	bh=WlV/ow/1ha+TIv+O8fIGVU97Vm/CeGp//Ga0S664JU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XinVYg5fiK9oawxuxqxK1bH+avzPTtTMW0knCv8kuam4V9a9OxU6HFWvaWvIaLeWJ2dwiXPf3NJrpAkkXfk5blIv//41D8CtfX86JmDVwbgH2WBZ2nK8B1kfN8ooZKDzgb2FI9KGGrC/gaWNwj67OFJX7wasjHgG9QMksoSlAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVRxITrp; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86712bc0508so470335241.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 07:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740671563; x=1741276363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyKOd+DlX7y4Sn7Js0wNY2q1+p1WK8jCg8z6/4ACci0=;
        b=mVRxITrpmp9IFdvkymqF7h3pGdDVGCABuxBRbG26wn8QMFkHeXv6IKmKj4s6LKNpdc
         YLiz7n//WhWwTB1Y/pvZw6Rvj/Jmk6fdQHqeac2yoJjBBKXX85NCYkQrZIyFyP3MQPj7
         dzLFWaHTnYRFvjV240uELZtEF+NrG6+ufFlQ5wjax8D/va9gE//XXthWqB/gCMl88xRE
         ZuQeMgoSWOAZuzvkYV9Pou1Um+yJfCTzImOM2YS52bj7cZ10tYRVbzSe8pmRWXnA6CL0
         H71QcEec4zzwPEkBC5/SvIgD1H4AYRxJTj/7ha1jT4baifT3CxwXui620+PbHuVpCzRL
         c4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671563; x=1741276363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyKOd+DlX7y4Sn7Js0wNY2q1+p1WK8jCg8z6/4ACci0=;
        b=U5TPeQHM/mPjXysRJREOgilDKJb8U9xlCnSMhnSwusqDld25dgL5fyFqpP9bKUoE9o
         8BZME7Kr1qssykRFuKPPC+KVEn0BCodRr5g51v3C1SxJZ99gZTTl14mRh3Dfm8dFLfT6
         Lve2DVX0yP2hf7JJS7ShrMF19doqPVp+vXh36+oicGzJmtJxSNRuo89Wq/Sr4Vqbgso0
         W0vzWI9APcudiNngAETAqRQDPI6t1pEJehEL1Z4q+kiXFfBTUZfbeTDERKVaLwoRXDFw
         DkGBbgl+ZJV1uGNc00Kg8h4/uSdMt8uhdxD/Bgj5Ad526qWhM86+ubcvKuy0V4cH58Yi
         8iTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUWMw2Ld2Wkw+opcejcIoeiDVR60ijzqyWCHjoP+ZHWiT1stMPW4aS4tzxqfip8u346lux7vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRLbZvIoTPFhr6k6oyPkVYzsOIJIsBdBwDsbDgsdV8+m9SJ5o
	wf05ZyiqpjVrh+Usohr6IvXaWIP8R/ya2+VI+KIza1SBrkueMw2Lc032ynvFGjf79Gdqb7s1/gP
	aEUI0ZiNEn635cFl6G8InbMiRGOknCJB7
X-Gm-Gg: ASbGncu0v2tOMkT3hA+nmq5LzfYuitbnylvsDA8fl4DddB3Wk7DK21yyhVm6PNbPMgf
	+ojEmi129vltuteawgQQeX7yFfp4T+apYwMifbS12odnZ5vLx4JmGPMa+NEj9uPJvYnYBBgpqEG
	f3VzB0Fw==
X-Google-Smtp-Source: AGHT+IEHvpzpbc0GlOIYW3EMwJpO5CCTyRWmmbIBylG1i+S5xCD8Aax71d6cs+5+d6ZbdDFKPpBjqHCMYqAetZ88g8Y=
X-Received: by 2002:a05:6102:e12:b0:4af:c519:4e86 with SMTP id
 ada2fe7eead31-4c01e1845ddmr4627067137.1.1740671563288; Thu, 27 Feb 2025
 07:52:43 -0800 (PST)
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
 <CAA85sZsq4JnatO0TjhN=o6S4adq7pQDC8A5dtRrBKeY9ry0NfQ@mail.gmail.com>
 <5cf5c38f-1a1b-4e67-8f9f-7b37c4f270a6@blackwall.org> <CAA85sZuROGN2Nb5We6g99czgjfkJ36Vz5MjC=cOYrU3A8v4TmQ@mail.gmail.com>
 <4386f1d1-342f-4b4b-a78d-afc98f751a6f@blackwall.org>
In-Reply-To: <4386f1d1-342f-4b4b-a78d-afc98f751a6f@blackwall.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 27 Feb 2025 16:52:30 +0100
X-Gm-Features: AQ5f1JpYF_A54tcln9FCWCfyi-brewkK4VcKvhbS9jeiCsD6h9FRHsP4wOsK9p4
Message-ID: <CAA85sZvjtQvZeyV-AhksBjCnA6NsNJwL9zda2+LNGTvjPfCU=Q@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 3:45=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 2/27/25 16:36, Ian Kumlien wrote:
> > On Thu, Feb 27, 2025 at 3:33=E2=80=AFPM Nikolay Aleksandrov <razor@blac=
kwall.org> wrote:
> >>
> >> On 2/27/25 16:31, Ian Kumlien wrote:
> >>> On Wed, Feb 26, 2025 at 11:28=E2=80=AFPM Ian Kumlien <ian.kumlien@gma=
il.com> wrote:
> >>>>
> >>>> On Wed, Feb 26, 2025 at 2:11=E2=80=AFPM Nikolay Aleksandrov <razor@b=
lackwall.org> wrote:
> >>>>>
> >>>>> On 2/26/25 14:26, Ian Kumlien wrote:
> >>>>>> On Wed, Feb 26, 2025 at 1:00=E2=80=AFPM Nikolay Aleksandrov <razor=
@blackwall.org> wrote:
> >>>>>>>
> >>>>>>> On 2/26/25 13:52, Ian Kumlien wrote:
> >>>>>>>> On Wed, Feb 26, 2025 at 11:33=E2=80=AFAM Nikolay Aleksandrov
> >>>>>>>> <razor@blackwall.org> wrote:
> >>>>>>>>>
> >>>>>>>>> On 2/26/25 11:55, Ian Kumlien wrote:
> >>>>>>>>>> On Wed, Feb 26, 2025 at 10:24=E2=80=AFAM Ian Kumlien <ian.kuml=
ien@gmail.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Wed, Feb 26, 2025 at 2:05=E2=80=AFAM Jakub Kicinski <kuba@=
kernel.org> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> >>>>>>>>>>>>> Same thing happens in 6.13.4, FYI
> >>>>>>>>>>>>
> >>>>>>>>>>>> Could you do a minor bisection? Does it not happen with 6.11=
?
> >>>>>>>>>>>> Nothing jumps out at quick look.
> >>>>>>>>>>>
> >>>>>>>>>>> I have to admint that i haven't been tracking it too closely =
until it
> >>>>>>>>>>> turned out to be an issue
> >>>>>>>>>>> (makes network traffic over wireguard, through that node very=
 slow)
> >>>>>>>>>>>
> >>>>>>>>>>> But i'm pretty sure it was ok in early 6.12.x - I'll try to d=
o a bisect though
> >>>>>>>>>>> (it's a gw to reach a internal server network in the basement=
, so not
> >>>>>>>>>>> the best setup for this)
> >>>>>>>>>>
> >>>>>>>>>> Since i'm at work i decided to check if i could find all the b=
oot
> >>>>>>>>>> logs, which is actually done nicely by systemd
> >>>>>>>>>> first known bad: 6.11.7-300.fc41.x86_64
> >>>>>>>>>> last known ok: 6.11.6-200.fc40.x86_64
> >>>>>>>>>>
> >>>>>>>>>> Narrows the field for a bisect at least, =3D)
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Saw bridge, took a look. :)
> >>>>>>>>>
> >>>>>>>>> I think there are multiple issues with benet's be_ndo_bridge_ge=
tlink()
> >>>>>>>>> because it calls be_cmd_get_hsw_config() which can sleep in mul=
tiple
> >>>>>>>>> places, e.g. the most obvious is the mutex_lock() in the beginn=
ing of
> >>>>>>>>> be_cmd_get_hsw_config(), then we have the call trace here which=
 is:
> >>>>>>>>> be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_comp=
l -> usleep_range()
> >>>>>>>>>
> >>>>>>>>> Maybe you updated some tool that calls down that path along wit=
h the kernel and system
> >>>>>>>>> so you started seeing it in Fedora 41?
> >>>>>>>>
> >>>>>>>> Could be but it's pretty barebones
> >>>>>>>>
> >>>>>>>>> IMO this has been problematic for a very long time, but obvious=
ly it depends on the
> >>>>>>>>> chip type. Could you share your benet chip type to confirm the =
path?
> >>>>>>>>
> >>>>>>>> I don't know how to find the actual chip information but it's id=
entified as:
> >>>>>>>> Emulex Corporation OneConnect NIC (Skyhawk) (rev 10)
> >>>>>>>>
> >>>>>>>
> >>>>>>> Good, that confirms it. The skyhawk chip falls in the "else" of t=
he block in
> >>>>>>> be_ndo_bridge_getlink() which calls be_cmd_get_hsw_config().
> >>>>>>>
> >>>>>>>>> For the blamed commit I'd go with:
> >>>>>>>>>  commit b71724147e73
> >>>>>>>>>  Author: Sathya Perla <sathya.perla@broadcom.com>
> >>>>>>>>>  Date:   Wed Jul 27 05:26:18 2016 -0400
> >>>>>>>>>
> >>>>>>>>>      be2net: replace polling with sleeping in the FW completion=
 path
> >>>>>>>>>
> >>>>>>>>> This one changed the udelay() (which is safe) to usleep_range()=
 and the spinlock
> >>>>>>>>> to a mutex.
> >>>>>>>>
> >>>>>>>> So, first try will be to try without that patch then, =3D)
> >>>>>>>>
> >>>>>>>
> >>>>>>> That would be a good try, yes. It is not a straight-forward rever=
t though since a lot
> >>>>>>> of changes have happened since that commit. Let me know if you ne=
ed help with that,
> >>>>>>> I can prepare the revert to test.
> >>>>>>
> >>>>>> Yeah, looked at the size of it and... well... I dunno if i'd have =
the time =3D)
> >>>>>>
> >>>>>
> >>>>> Can you try the attached patch?
> >>>>> It is on top of net-next (but also applies to Linus' tree):
> >>>>>  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> >>>>>
> >>>>> It partially reverts the mentioned commit above (only mutex -> spin=
lock and usleep -> udelay)
> >>>>> because the commit does many more things.
> >>>>>
> >>>>> Also +CC original patch author which I forgot to do.
> >>>>
> >>>> Thanks, built and installed but it refuses to boot it - will have to
> >>>> check during the weekend...
> >>>> (boots the latest fedora version even if this one is the selected on=
e
> >>>> according to grubby)
> >>>
> >>> So, saw that 6.13.5 was released so, fetched that, applied the patch
> >>> and no more RCU issues in dmesg
> >>>
> >>> Will check more on the suspected performance bit as well when i get
> >>> home later tonight
> >>>
> >>> I also understand Sathya Perla's motivation in saving power on this
> >>> but things around it have been changed
> >>> and it no longer works as intended....
> >>>
> >>
> >> Nice, that's good to hear. Wrt the motivation - sure it's ok, but the =
code was wrong
> >> if they still want to achieve it, they need to work on an alternative =
solution.
> >> We shouldn't keep broken code around.
> >
> > Agreed, but also, was it broken in 4.7 ;)
> >
>
> Since 4.9, yes it has. I just checked out v4.9 and it has all these bugs =
present.
> If you boot 4.9 and issue PF_BRIDGE RTM_GETLINK you'll hit the same probl=
ems.

Ah!, ok!

> > Anyway, seems faster from what i can test here so
> > Tested-by: Ian Kumlien <ian.kumlien@gmail.com>
> >
> > etc etc
>
> Thank you, I'll clean up the patch and submit it.

Thank you, =3D)

