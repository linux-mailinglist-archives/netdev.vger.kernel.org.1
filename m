Return-Path: <netdev+bounces-167266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AC4A397F9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F019D1627CC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0359C233129;
	Tue, 18 Feb 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahP8sGXW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5ED232395
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872932; cv=none; b=SjY2czeRFoeAuHN+woSDWjdghcxc/ptvAT39RiSTUB0uzeMOw/pBsRphZ6gfxB7voNuR+M50+VFKxidzcmtwPsp7yImbkLyU7ZL91PtXz9K1CiYFPiQ4fw9CX8Li/BPQTYw5JB7Dw/8BWxjt5RQYsdN/EXz80uvF762tZ8v7yxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872932; c=relaxed/simple;
	bh=NvQp5HwAN7QMYYhWJ6UDyB7ywCBAUToqik9159XeKxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bp7lJrXJenD2Iz7N5SZ5zQbEgqn/KXVokhZgih0YFQE50+52jL33pQi8sxmAAvwIX8mvXIpMZuUOio9j5hsDrswj42yE4jP7iurl2fkYCdEC4fv56bE0wX1fGlCJb2IWLwS9UJPP/cz9ChUzV3OELHhfYH/IosyUywp8oXosUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahP8sGXW; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e46ebe19489so3412999276.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739872930; x=1740477730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UojaZ74bVRHBooO3qlbn0fWOUa4IFVmfFA7hhTVuG4I=;
        b=ahP8sGXWrkRC0FMnZB3mfrAQyEWO5E8Q2JaJCxmc8HhTvHu1uy6UB8GGkccx5R+h6f
         GKa4U2P9dSkWzP0WyixF7YyyDbymQck0hW4BuLJGMRr2N9G1c4ypHlUpyUoxKqzJWIhi
         GUJDak6rYCpIt3x/UjlDAdYbqEO2Cm03F8VbdIc6SF9kjlTMtUhxcexK2muNQ0K8ymoj
         KhvgfBDwKM0W9S/1jQUcn7PoTSEKSyWmpgOsFO3kTQQWCGP+h/1mdDE/hIzCn1GT0V6N
         +ha6IJaePSsaJzzKhhSkEeFPmWluTwDKQ0U40mHMCASWjrgxS/ohCbh+rpUy94soyoDK
         qRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739872930; x=1740477730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UojaZ74bVRHBooO3qlbn0fWOUa4IFVmfFA7hhTVuG4I=;
        b=njrZl1eilb6qBL/VRhbNm5H2c5jez4UuACMeo0H0iZXQwtq0spba7wCyVZXztF2qYf
         Z36QkoFMLejlmVb7vrA12+Aurc1vTMs0qdtfjhZBK6wAe0DoyFtPZOjIbHSMGBftz3+d
         DVjc4ToBGQXhWQR4JRsl6Kfr7Sp7l5WF3wuvxQgzx7QyftniUk+hpr9zXw/J6iRboiOu
         Cr4jRWV+831yQjjUgqmsWfMbJE75yrJvck4z6XlMHqY/JQuan8/JV27MAiYCTQkqg1E8
         7AvWe1zI3o331vJWmNv2yr/wyNuneWmTBdglZt9ZQPviwVKxyTnm4qn/vcMmCaAcDtdx
         28vw==
X-Forwarded-Encrypted: i=1; AJvYcCWgmj1fU6MX9DF4K5SSoKAz6mqoA1TnyYth5OLgetmvmUtZi0wW/8tS2kFLIVY1oaA/h6A3kXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/c8VcFjUe+z38fz3CBInHXK6KMJFgJZW887bmCfrGEObJFXn
	gukhEtFMlrayjnZlxLdIPm4JBiLRU3jLwgrcZI00LG5KuXRVqvABm7zrEeAA4krYRv520D70ccW
	AMv8iQ77fakYhUtBi/5ljcX9RYhqKpYYdN1/b
X-Gm-Gg: ASbGnct75WHX1j5qduT4f0gaKvAhSTa2ipHp6bjBD4JUcAKZMNUSiJmFhDCnnrTS7yX
	TIGdftZE8T+s/wpFr0aZy4KkF3IbDXUHY28MREwXRHyzEE1QsxSjf01THudyOFlK/1yhDrzXFZg
	==
X-Google-Smtp-Source: AGHT+IHWr0N450gZlrq3oSbAGDQwscklo28mePBVYMtEnuHwMmFxV6tPjDPfKwLGos63CuvF/2jIyrB2eplQWAUo/ZE=
X-Received: by 2002:a05:6902:20c5:b0:e57:339b:357f with SMTP id
 3f1490d57ef6-e5dc92f3b0emr10351292276.35.1739872929915; Tue, 18 Feb 2025
 02:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021425-surgical-wackiness-0940@gregkh> <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>
 <2025021717-prepay-sharpener-37fb@gregkh> <CADg1FFf7fONc+HJT8rq55rVFRnS_UxnEPnAGQ476WVe+208_pA@mail.gmail.com>
 <2025021829-clamor-lavish-9126@gregkh> <CADg1FFd=PbnNSBWk4KGV85jvvRQBBGG4QD2VHM6ABY-mqC8+Lg@mail.gmail.com>
 <2025021807-ultimate-ascent-f5e0@gregkh>
In-Reply-To: <2025021807-ultimate-ascent-f5e0@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Tue, 18 Feb 2025 18:01:42 +0800
X-Gm-Features: AWEUYZkOLeABtpgbIcWJc0jBFtF8ZiJEcML9luDq8_04_AVyKbbdFnv8wgUVFBs
Message-ID: <CADg1FFdLA8LCafbQA=x5onSj6FKS=0ihpYPpSjQmDpGG2iOb5A@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Feb 18, 2025 at 5:21=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Feb 18, 2025 at 04:57:38PM +0800, Hsin-chen Chuang wrote:
> > Hi Greg,
> >
> > On Tue, Feb 18, 2025 at 4:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, Feb 18, 2025 at 12:24:07PM +0800, Hsin-chen Chuang wrote:
> > > > Hi Greg,
> > > >
> > > > On Mon, Feb 17, 2025 at 4:53=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wrote:
> > > > > > On Fri, Feb 14, 2025 at 7:37=E2=80=AFPM Greg KH <gregkh@linuxfo=
undation.org> wrote:
> > > > > > >
> > > > > > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wr=
ote:
> > > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > >
> > > > > > > > Expose the isoc_alt attr with device group to avoid the rac=
ing.
> > > > > > > >
> > > > > > > > Now we create a dev node for btusb. The isoc_alt attr belon=
gs to it and
> > > > > > > > it also becomes the parent device of hci dev.
> > > > > > > >
> > > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute=
 to control USB alt setting")
> > > > > > >
> > > > > > > Wait, step back, why is this commit needed if you can change =
the alt
> > > > > > > setting already today through usbfs/libusb without needing to=
 mess with
> > > > > > > the bluetooth stack at all?
> > > > > >
> > > > > > In short: We want to configure the alternate settings without
> > > > > > detaching the btusb driver, while detaching seems necessary for
> > > > > > libusb_set_interface_alt_setting to work (Please correct me if =
I'm
> > > > > > wrong!)
> > > > >
> > > > > I think changing the alternate setting should work using usbfs as=
 you
> > > > > would send that command to the device, not the interface, so the =
driver
> > > > > bound to the existing interface would not need to be removed.
> > > >
> > > > I thought USBDEVFS_SETINTERFACE was the right command to begin with=
,
> > > > but it seems not working in this case.
> > > > The command itself attempts to claim the interface, but the interfa=
ce
> > > > is already claimed by btusb so it failed with Device or resource bu=
sy
> > > >
> > > > drivers/usb/core/devio.c:
> > > >   USBDEVFS_SETINTERFACE -> proc_setintf -> checkintf -> claimintf
> > >
> > > Ah, ok, thanks for checking.  So as you control this device, why not
> > > just disconnect it, change the setting, and then reconnect it?
> >
> > After dis/reconnecting, a Bluetooth chipset would lose all its state:
> > Existing connections/scanners/advertisers are all dropped.
>
> If you are changing the alternate USB configuration, all state should be
> dropped, right?  If not, huh how does the device know to keep that
> state?

No, the Bluetooth chip doesn't drop any info when the alt is changed.
It only affects the data transfer bandwidth on that interface.

>
> > This is as bad as (just an analogy) "Whenever you access a http web
> > page, you need to bring your ethernet interface down and up, and after
> > the page is downloaded, do that again".
>
> Your ethernet interface does not contain state like this, we handle
> chainging IP addresses and devices all the time, so perhaps wrong
> analogy :)
>
> > > Also, see my other review comment, how does BlueZ do this today?
> >
> > BlueZ handles that in their MGMT command, that is, through Control
> > channel -> BlueZ kernel space code -> driver callbacks.
> > Once a Bluetooth chipset is opened with the User channel, it can't be
> > used with the Control channel simultaneously, and vice versa.
>
> So why not use that same control channel in your code?  Why are you

Because we're using the User channel, and they can't be used at the same ti=
me.

> reinventing a new control channel for something that is obviously there
> already?

Not quite the same as "reinventing". The Control channel command does
much more than just setting the alt; It just doesn't work with the
User channel.

>
> So in short, what's preventing you from using the same exact driver
> callbacks, OR the same exact kernel api.  Surely you all are not

The answer is the same as the above. This feature is missing in the
User channel, and I'm completing it with this patch.

> replacing all of the in-kernel BlueZ code with an external kernel driver
> just for this, right?  If so, that's not ok at all.

Sorry I don't quite get it. What do you mean by the external kernel driver?

--=20
Best Regards,
Hsin-chen

