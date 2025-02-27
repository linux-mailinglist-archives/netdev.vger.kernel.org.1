Return-Path: <netdev+bounces-170305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F69A481F8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D9F174F4F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546422356BD;
	Thu, 27 Feb 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqkn+UFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA21231A22
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667000; cv=none; b=aigugcGwbTafLH+9cxrGxC2sIADL/fCiCOtgEY+UJpbpcZoYoEp+fpLWvfMtMzwtKSR42kD4XBb6oIPqYNq8ORDPpURUYSeI0s/ns7l3+RPR/XfP5zEezZBaREY8+x354vdOtB8Wy+cmOQKzS/ZlUmM7/QfX48Eu5YQ/kWyE55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667000; c=relaxed/simple;
	bh=HMPyiwpYckTTV1urbHrK9OmCVd2tCnx39CacWFYGf3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lER+yEikaLh5QwWCcqCfe0JVDmhBhhx4vjld5JAinQXxV/0px10ZYl7OkVsKR6BLlHSL0UW0CpSmKzQdmfuPe6taUIGX7ttka+fqxJjRVw2GPzmICiII87aW62aMDDHOGDXVbJyedGjahX+hTasR9FxWJT0YQeN66OZmoTVZIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqkn+UFz; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso390294e0c.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740666997; x=1741271797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUUNgnEcsnLngifHJ/Mnd61TwNeu6UZSXDM4c8OYIIg=;
        b=Cqkn+UFzvwkz4Pe0rotXYY3dC5eKyoXYm8SS8Xjev0E/oN8M4HzyX9oh/KbxXnmEtt
         8h7hN63IZGyxGpTxYlJZCJmkVcO1AlNy815Ksol4aKpDeExoaBURR+XIk68WUBMQXNzV
         2+7NhIGOUC248GdTBAhjq87GAFY8H/ztyWfuzj0ybHkBfJYx8B7nE96T5TqIxG9uwWIz
         FX0WaZhbi1xeNrqeOYMp9D6yjs9Q7G//dFrXXZJG9TXdL73meusJAxfhEDnkewHUXNEB
         bv5VmlNjZ59i1qI3S9orbMX5kt7Sfyy+qi0S1891sQWlzBnlSIbR+fQBDtiAEKA2ikLg
         hbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666997; x=1741271797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUUNgnEcsnLngifHJ/Mnd61TwNeu6UZSXDM4c8OYIIg=;
        b=WBfCXwv+YbqQcr2Rno5HvkZvkCOASmdV7P9X/2NyAM9uNE554ezROF4CZIw2fZmj+q
         BmGtELgcc28AFUVrZ2n7hqSzgu4o59QutzoUvJWPI/VwUo0pp8MKzKcDmOLS78F35SbO
         rjSe2/Qqr5rmpJYj8Hnk8YhR8TSTjGuaGu2XPFFcLKpYNMxw9RGurEAPNDQsXxT8M5pM
         Bz+Zr3sSnXHESrgvr+zHHL2gZn1kJSpx1OD5baNYc11MeICJ9y0OAybkVivx4LcT/8gZ
         Fh1522n8XbieaRHQWe66qqL5P4WY8P78cQYqH3X5BVKLTBp7PyAKeZfHFyDMnrhrWtn6
         whEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGhtlDSO7h9SGfZ/X8suztxN8qlSCiK2+gVCq1spclkaP0a5VJ+1mlCPxuhy0GXrvUxgUijfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/ZpcBkPzcsdEDGn7AKVGycaW8RTgLl4aAd/ndruwLqB0T3oS
	D59q6FH0zu5+SGZS5rn664G+xivgRhOXI1fd1mEL6RTsV5jm5nZkFolyPW9hsskeOaKWh0zDJAo
	7ptLvSX5NHsdGwXFmLmoei6AQut//2fQN
X-Gm-Gg: ASbGnct06DPZ/eWH5HLBvfCrLm7/FBdEyhF9WEUZ04fVRnbdmfEoUJGVkD1XvjnXFhq
	0baVMwQxCuxvJd7IE0dODbdGl3vFR1ueKn5xh1JGTxEk1EvsPwDmSoY3gGq2EmDHpCdO4MZm26f
	KD8+1etg==
X-Google-Smtp-Source: AGHT+IGwIK5O3GsrXr0wu3aIjIBkKwQblyFCNr3q0jMIZB3nkRycVDzhmxjGv0rcMAg29HMyGX3ME8T6T1dxazZZoec=
X-Received: by 2002:a05:6122:330e:b0:520:652b:ce18 with SMTP id
 71dfb90a1353d-5224ca44a91mr4322467e0c.0.1740666997231; Thu, 27 Feb 2025
 06:36:37 -0800 (PST)
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
 <CAA85sZsq4JnatO0TjhN=o6S4adq7pQDC8A5dtRrBKeY9ry0NfQ@mail.gmail.com> <5cf5c38f-1a1b-4e67-8f9f-7b37c4f270a6@blackwall.org>
In-Reply-To: <5cf5c38f-1a1b-4e67-8f9f-7b37c4f270a6@blackwall.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 27 Feb 2025 15:36:26 +0100
X-Gm-Features: AQ5f1JoPd09pcvzwZPjZoPHlx4_OWDUukLBI65UBtsKmZ8pQxQTtrOmzQd9Z8bw
Message-ID: <CAA85sZuROGN2Nb5We6g99czgjfkJ36Vz5MjC=cOYrU3A8v4TmQ@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 3:33=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 2/27/25 16:31, Ian Kumlien wrote:
> > On Wed, Feb 26, 2025 at 11:28=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail=
.com> wrote:
> >>
> >> On Wed, Feb 26, 2025 at 2:11=E2=80=AFPM Nikolay Aleksandrov <razor@bla=
ckwall.org> wrote:
> >>>
> >>> On 2/26/25 14:26, Ian Kumlien wrote:
> >>>> On Wed, Feb 26, 2025 at 1:00=E2=80=AFPM Nikolay Aleksandrov <razor@b=
lackwall.org> wrote:
> >>>>>
> >>>>> On 2/26/25 13:52, Ian Kumlien wrote:
> >>>>>> On Wed, Feb 26, 2025 at 11:33=E2=80=AFAM Nikolay Aleksandrov
> >>>>>> <razor@blackwall.org> wrote:
> >>>>>>>
> >>>>>>> On 2/26/25 11:55, Ian Kumlien wrote:
> >>>>>>>> On Wed, Feb 26, 2025 at 10:24=E2=80=AFAM Ian Kumlien <ian.kumlie=
n@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Feb 26, 2025 at 2:05=E2=80=AFAM Jakub Kicinski <kuba@ke=
rnel.org> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> >>>>>>>>>>> Same thing happens in 6.13.4, FYI
> >>>>>>>>>>
> >>>>>>>>>> Could you do a minor bisection? Does it not happen with 6.11?
> >>>>>>>>>> Nothing jumps out at quick look.
> >>>>>>>>>
> >>>>>>>>> I have to admint that i haven't been tracking it too closely un=
til it
> >>>>>>>>> turned out to be an issue
> >>>>>>>>> (makes network traffic over wireguard, through that node very s=
low)
> >>>>>>>>>
> >>>>>>>>> But i'm pretty sure it was ok in early 6.12.x - I'll try to do =
a bisect though
> >>>>>>>>> (it's a gw to reach a internal server network in the basement, =
so not
> >>>>>>>>> the best setup for this)
> >>>>>>>>
> >>>>>>>> Since i'm at work i decided to check if i could find all the boo=
t
> >>>>>>>> logs, which is actually done nicely by systemd
> >>>>>>>> first known bad: 6.11.7-300.fc41.x86_64
> >>>>>>>> last known ok: 6.11.6-200.fc40.x86_64
> >>>>>>>>
> >>>>>>>> Narrows the field for a bisect at least, =3D)
> >>>>>>>>
> >>>>>>>
> >>>>>>> Saw bridge, took a look. :)
> >>>>>>>
> >>>>>>> I think there are multiple issues with benet's be_ndo_bridge_getl=
ink()
> >>>>>>> because it calls be_cmd_get_hsw_config() which can sleep in multi=
ple
> >>>>>>> places, e.g. the most obvious is the mutex_lock() in the beginnin=
g of
> >>>>>>> be_cmd_get_hsw_config(), then we have the call trace here which i=
s:
> >>>>>>> be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_compl =
-> usleep_range()
> >>>>>>>
> >>>>>>> Maybe you updated some tool that calls down that path along with =
the kernel and system
> >>>>>>> so you started seeing it in Fedora 41?
> >>>>>>
> >>>>>> Could be but it's pretty barebones
> >>>>>>
> >>>>>>> IMO this has been problematic for a very long time, but obviously=
 it depends on the
> >>>>>>> chip type. Could you share your benet chip type to confirm the pa=
th?
> >>>>>>
> >>>>>> I don't know how to find the actual chip information but it's iden=
tified as:
> >>>>>> Emulex Corporation OneConnect NIC (Skyhawk) (rev 10)
> >>>>>>
> >>>>>
> >>>>> Good, that confirms it. The skyhawk chip falls in the "else" of the=
 block in
> >>>>> be_ndo_bridge_getlink() which calls be_cmd_get_hsw_config().
> >>>>>
> >>>>>>> For the blamed commit I'd go with:
> >>>>>>>  commit b71724147e73
> >>>>>>>  Author: Sathya Perla <sathya.perla@broadcom.com>
> >>>>>>>  Date:   Wed Jul 27 05:26:18 2016 -0400
> >>>>>>>
> >>>>>>>      be2net: replace polling with sleeping in the FW completion p=
ath
> >>>>>>>
> >>>>>>> This one changed the udelay() (which is safe) to usleep_range() a=
nd the spinlock
> >>>>>>> to a mutex.
> >>>>>>
> >>>>>> So, first try will be to try without that patch then, =3D)
> >>>>>>
> >>>>>
> >>>>> That would be a good try, yes. It is not a straight-forward revert =
though since a lot
> >>>>> of changes have happened since that commit. Let me know if you need=
 help with that,
> >>>>> I can prepare the revert to test.
> >>>>
> >>>> Yeah, looked at the size of it and... well... I dunno if i'd have th=
e time =3D)
> >>>>
> >>>
> >>> Can you try the attached patch?
> >>> It is on top of net-next (but also applies to Linus' tree):
> >>>  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> >>>
> >>> It partially reverts the mentioned commit above (only mutex -> spinlo=
ck and usleep -> udelay)
> >>> because the commit does many more things.
> >>>
> >>> Also +CC original patch author which I forgot to do.
> >>
> >> Thanks, built and installed but it refuses to boot it - will have to
> >> check during the weekend...
> >> (boots the latest fedora version even if this one is the selected one
> >> according to grubby)
> >
> > So, saw that 6.13.5 was released so, fetched that, applied the patch
> > and no more RCU issues in dmesg
> >
> > Will check more on the suspected performance bit as well when i get
> > home later tonight
> >
> > I also understand Sathya Perla's motivation in saving power on this
> > but things around it have been changed
> > and it no longer works as intended....
> >
>
> Nice, that's good to hear. Wrt the motivation - sure it's ok, but the cod=
e was wrong
> if they still want to achieve it, they need to work on an alternative sol=
ution.
> We shouldn't keep broken code around.

Agreed, but also, was it broken in 4.7 ;)

Anyway, seems faster from what i can test here so
Tested-by: Ian Kumlien <ian.kumlien@gmail.com>

etc etc

