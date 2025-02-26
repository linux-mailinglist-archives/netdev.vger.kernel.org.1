Return-Path: <netdev+bounces-170024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130F7A46E8C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A9B188321F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE225D8E9;
	Wed, 26 Feb 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mflsRMg4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E825D8E1
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608932; cv=none; b=kAmPluiNdDGfBvvJdUhGZDC+/uilXeoKjWb8OuMJIlYAYJlbfQLQEFRGFHdHc604hCPjUuW+7lW6BS/tw8Tb0/pIg/jNTTLWzmXAfFDKSWGjMG5DKMPrlseJWe4ZC+Zbv9KnFwRfQ3xGE+q36XjojatvaqSyYNwxTuZdM8Lyzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608932; c=relaxed/simple;
	bh=XSzbhzUCKmv7IRps459MPdKjJ8sRAr736yzYA8hRTs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPOWSK8+54U01XwrU00FYcU918TuEDRiTnYwTGdw+oUZBB8htgk4fg312S7Uqhz/y44I0nkt7SM03nB7mWdBHsr/q23W7egUCE9Pdi6JPQm+57KC63mFAnc517x5BarTxrr6I9I8YxCr4s8qDXQl9JEpS8o6mzzoYG7yHbnS5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mflsRMg4; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-521c478d433so127424e0c.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740608930; x=1741213730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tB3aKQ5Qdg/yHCe6O6N4irTTerSpKdg90NLbWIAGDGc=;
        b=mflsRMg4CRks46cxOihfy5asZwi7PX8mWzBjig5aioLDXPN1QUErpNADBIQcf/AQ3P
         q0BMtehbF+02HV0xW2V13RNrBJo9egcjG4hFWwIgDA+P5j6Q6q9+bXSs4jV76358qKtF
         tCE74OolINGVMJmcHNR8DTZjr7ZxDziOPwxQbwRPhz4rKMFI2RMjQSeD+236IY92eSAl
         LtL9gVliTuru8hOkRX9fH3cKmXANhBkubUAmrwv289cURrLgBd55SM5R5AxY/KxC3Ihw
         agazY2cy/5jTBDN7ZkeuH8hYn/Too7TZPvlG6x8TqUM44w2ShcQd4kF4O97R3OWP8wER
         mqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740608930; x=1741213730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tB3aKQ5Qdg/yHCe6O6N4irTTerSpKdg90NLbWIAGDGc=;
        b=Nzr8QzJNjFZ3e3yQsVBQQselaZGlBeFQKfXfylOd7jX/jALTTMtnXS88kXxeZtPwmP
         KrMf9qcsVR5pewlTar30YBxGZxXhhIkUlyqjzHnrMa3Zfc03oZAjfyKgyMxysbOkAGkz
         G7nLOa/sWdnLgnc6rv0cCETXiBnT5Z9HE/n23UK2oHr9gvPC3anEbHWk6OMbX6aHhPkt
         iNMx3ZXRTZjbou89u51FxLh5dy2Irw+kLrWit9WPGY583TwpeYEX8I8nVPqLz1AOg8aA
         q3pLIy7jmjFB5MIhQu+oObU/X9PwyAy9gCS1+FDeBjV7jloVRvPm2xdBGp7Gxf5LbBp3
         gqJA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3TVwsi6ZQtoVHEA3vt+QlokaFUTVmLEDDoTPKdA3GQSFWRL19yYGyT7z6+er9PiAuPTu4P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaJKdlOt8qIXH7QIrRRoVb1inLNsTy+p3aunStqJ2FOHJ2Fj1
	dhwoHCSzN4Nr2QJebSnxT0wPBi2KW5BCftQN3CmSwxFKms7tUEE0YYS1lU+KazmJoIYb9bfdPgy
	ffp0AJTnTZUkw612mXn1TL0FvaJAOzw==
X-Gm-Gg: ASbGncuK1q1vrr/X3w/kJQ4SaREGzjCLqyp4h2kRO/cqrARfWeU6+VA24zLOCOrmQ40
	vzF1u1ph19shVLasS0WZ7O0oDFUv4LnhpkNNTsrOj0klqLAPGx9Pv5Dy+SryezvzG5I6wiHf45u
	TKorc7MA==
X-Google-Smtp-Source: AGHT+IEdxx4RAUWUw2ym9Ie0VzFjtB74QZrtvu++aPd9E7KQDm75ZO4nAdNCkeu19knzxCkJC6+z57YzC1Pe83my2I0=
X-Received: by 2002:a67:e70c:0:b0:4bb:5d61:1264 with SMTP id
 ada2fe7eead31-4bfc027abcemr14084218137.24.1740608929895; Wed, 26 Feb 2025
 14:28:49 -0800 (PST)
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
 <4604b36b-4822-4755-a45c-c37d47a3adc2@blackwall.org>
In-Reply-To: <4604b36b-4822-4755-a45c-c37d47a3adc2@blackwall.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 26 Feb 2025 23:28:38 +0100
X-Gm-Features: AQ5f1JpPMTlIuFyeibQ-xUxWiDDFdJZ4I4hhDZs5vJb4vG1pCz1Kgv5Z0SH1fxg
Message-ID: <CAA85sZutt0Eydh4B5AUb2xgvPkPF2Wa2yU4iXprgmRFPVM5qUQ@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Sathya Perla <sathya.perla@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:11=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 2/26/25 14:26, Ian Kumlien wrote:
> > On Wed, Feb 26, 2025 at 1:00=E2=80=AFPM Nikolay Aleksandrov <razor@blac=
kwall.org> wrote:
> >>
> >> On 2/26/25 13:52, Ian Kumlien wrote:
> >>> On Wed, Feb 26, 2025 at 11:33=E2=80=AFAM Nikolay Aleksandrov
> >>> <razor@blackwall.org> wrote:
> >>>>
> >>>> On 2/26/25 11:55, Ian Kumlien wrote:
> >>>>> On Wed, Feb 26, 2025 at 10:24=E2=80=AFAM Ian Kumlien <ian.kumlien@g=
mail.com> wrote:
> >>>>>>
> >>>>>> On Wed, Feb 26, 2025 at 2:05=E2=80=AFAM Jakub Kicinski <kuba@kerne=
l.org> wrote:
> >>>>>>>
> >>>>>>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> >>>>>>>> Same thing happens in 6.13.4, FYI
> >>>>>>>
> >>>>>>> Could you do a minor bisection? Does it not happen with 6.11?
> >>>>>>> Nothing jumps out at quick look.
> >>>>>>
> >>>>>> I have to admint that i haven't been tracking it too closely until=
 it
> >>>>>> turned out to be an issue
> >>>>>> (makes network traffic over wireguard, through that node very slow=
)
> >>>>>>
> >>>>>> But i'm pretty sure it was ok in early 6.12.x - I'll try to do a b=
isect though
> >>>>>> (it's a gw to reach a internal server network in the basement, so =
not
> >>>>>> the best setup for this)
> >>>>>
> >>>>> Since i'm at work i decided to check if i could find all the boot
> >>>>> logs, which is actually done nicely by systemd
> >>>>> first known bad: 6.11.7-300.fc41.x86_64
> >>>>> last known ok: 6.11.6-200.fc40.x86_64
> >>>>>
> >>>>> Narrows the field for a bisect at least, =3D)
> >>>>>
> >>>>
> >>>> Saw bridge, took a look. :)
> >>>>
> >>>> I think there are multiple issues with benet's be_ndo_bridge_getlink=
()
> >>>> because it calls be_cmd_get_hsw_config() which can sleep in multiple
> >>>> places, e.g. the most obvious is the mutex_lock() in the beginning o=
f
> >>>> be_cmd_get_hsw_config(), then we have the call trace here which is:
> >>>> be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_compl -> =
usleep_range()
> >>>>
> >>>> Maybe you updated some tool that calls down that path along with the=
 kernel and system
> >>>> so you started seeing it in Fedora 41?
> >>>
> >>> Could be but it's pretty barebones
> >>>
> >>>> IMO this has been problematic for a very long time, but obviously it=
 depends on the
> >>>> chip type. Could you share your benet chip type to confirm the path?
> >>>
> >>> I don't know how to find the actual chip information but it's identif=
ied as:
> >>> Emulex Corporation OneConnect NIC (Skyhawk) (rev 10)
> >>>
> >>
> >> Good, that confirms it. The skyhawk chip falls in the "else" of the bl=
ock in
> >> be_ndo_bridge_getlink() which calls be_cmd_get_hsw_config().
> >>
> >>>> For the blamed commit I'd go with:
> >>>>  commit b71724147e73
> >>>>  Author: Sathya Perla <sathya.perla@broadcom.com>
> >>>>  Date:   Wed Jul 27 05:26:18 2016 -0400
> >>>>
> >>>>      be2net: replace polling with sleeping in the FW completion path
> >>>>
> >>>> This one changed the udelay() (which is safe) to usleep_range() and =
the spinlock
> >>>> to a mutex.
> >>>
> >>> So, first try will be to try without that patch then, =3D)
> >>>
> >>
> >> That would be a good try, yes. It is not a straight-forward revert tho=
ugh since a lot
> >> of changes have happened since that commit. Let me know if you need he=
lp with that,
> >> I can prepare the revert to test.
> >
> > Yeah, looked at the size of it and... well... I dunno if i'd have the t=
ime =3D)
> >
>
> Can you try the attached patch?
> It is on top of net-next (but also applies to Linus' tree):
>  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>
> It partially reverts the mentioned commit above (only mutex -> spinlock a=
nd usleep -> udelay)
> because the commit does many more things.
>
> Also +CC original patch author which I forgot to do.

Thanks, built and installed but it refuses to boot it - will have to
check during the weekend...
(boots the latest fedora version even if this one is the selected one
according to grubby)

> Thanks,
>  Nik
>

