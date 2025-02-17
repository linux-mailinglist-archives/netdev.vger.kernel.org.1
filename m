Return-Path: <netdev+bounces-166923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC52A37E52
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717A33AD012
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1B21FDA9D;
	Mon, 17 Feb 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPMcr1vm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750861FDA96
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783901; cv=none; b=iwzy0CbRR+m/UxJCitOo4myldGiObVP2Zjs9ewrGunVW/QHItnlkJZtBdTuJph9tz98aC7JB5c3SSkfeM3NSYjNVTL9vyNXNtqWKrLsW1Gu4+xS3r7uZLi+R7/EirvgvUMeoFz2iECKOy3NgHMm4VjBRHzWKYCZtFgHcMk4eOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783901; c=relaxed/simple;
	bh=JyC3DsKd7jW/3RxPZY6kje384o9WR4UklJlEwhSelB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMkyrvm98IUzTECW6ToyTvXjj89Y8zfj4yqx/b7ssPRILBS8bxHhYXGrj1cfdJt7gE4P0Oz2GMaePAqtw9Okigov/T/ZE+/kZ1p+incB8V6jo2pTm2O8lHPkw5zhLftD3NXNo10RakbJqfHdvP952Ikp6LasFiv67c5VM+rkbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPMcr1vm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so3020144276.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 01:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739783898; x=1740388698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZzX8tGLTQD9vuUORGnzCnOyePntqbaoJmyRLXunXls=;
        b=jPMcr1vmY3apL9c5u/R2qyhrqVgPM/RRvtk7Yx5yHYdGM+26MXPwDHG6fen85aavXk
         qCiBc4T0MdIRQF4aB12GT6dA1RnMTDOwZSWIfDERKzEwUaQO35Oq3iBW83Y45/KDr0Ja
         oCxvojbj2rRF4Iy/rMaP4LRtYI/8neG++xCNUUr3mL+aHIpZJmgtFBLjerO1TzkoJolu
         yrNKkUl6oAjiBKgjz4kO+D5cmwSXG+b3KYTDNEE0pt/0urbNQApNfVFp1+BGTZE6ChsI
         sN0302cZqjs8KYSvV0So7soVbTyNyEUmjxYbp0yX9S8qxzBBSymNctXJ6Wrcxg4w7bRy
         oFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783898; x=1740388698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZzX8tGLTQD9vuUORGnzCnOyePntqbaoJmyRLXunXls=;
        b=qrkhZ68C3MkWFDqw5O5/u7dktAlQ03sDiW1PSbRQVYxGTgq0teQnG6NdjI341A0IGz
         i8ocbdQ2NiDxX+WTDEtE7CoR/EdQt4rNrg6VMnM+8XJXkekm/krpLVitgWo2rzldjcrB
         0jpSo8Hfs9jZaN4rc1Bq2TMwRKFyaT320M5ErQngyDT/sF5+Y1VbvNYRmOi8uye1uTEc
         gTrq9lZC5wjzGiGKKChIp59IkrXiza1CjCf+pBtq16TdA5h8VBmuCnRrpLzSJMyUFKB/
         41O0T70LOl5VJVE9RvOh9sJonSFN2DmREtTY16mDb64XywGWcEug3wLKheLe6VCsrfPv
         +RkA==
X-Forwarded-Encrypted: i=1; AJvYcCUVivHGrFMo/s8vgVG1dpnOrWE0UbDzf21N2jz5O4wDXYCEUY2ULgplhxh5AnLy9pn9mQpgdwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+blOwW4JByTO3+drBUHW/cbx4N2f5WLyZo9xbCcYzAvz3asQ
	5ydG4PxYXT7ue6gfGOM7Risng5vJSLPF0eHIkf+5gJbK516yYUIRRgTZPuYqbRqbdBAOjUi59+W
	TuxBS1h7ke2mG53f8Tk6FpsBXVTcshZiUSJQD
X-Gm-Gg: ASbGnctryRyRcNtBrsfTdJQuVgcClEPS3uyRa2T5WgAl7PzX7QTjIf61APuwwYARsv9
	Lh7nyZbT1YuQYOzO7REcSufnRq6HBRJUY6b1O6F60ofvHQfgw3MFaL+TWiPd0x19JOahUQ0CXFg
	==
X-Google-Smtp-Source: AGHT+IH3Yhhhb5o4OOHhwkCE2P+VxdpO+BObbKbP0i7sGJ2qYMSa9fy76gnizP4Jt2bIUOnaBYsc2ith6LgrCmWmmNs=
X-Received: by 2002:a05:6902:1102:b0:e58:98d0:2d27 with SMTP id
 3f1490d57ef6-e5dc90265a1mr5427194276.7.1739783898211; Mon, 17 Feb 2025
 01:18:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021425-surgical-wackiness-0940@gregkh> <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>
 <2025021705-speckled-ooze-c4d0@gregkh>
In-Reply-To: <2025021705-speckled-ooze-c4d0@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 17 Feb 2025 17:17:50 +0800
X-Gm-Features: AWEUYZl7o3FAHCQLs9yJwCOplO6bcmFh381n0TsGn9s_rXdfVZOBNJ4tE-ab4D0
Message-ID: <CADg1FFd3nWiZqA8huodnsjezgrAL-p9t2BLHf3MzO3cJD6xZ+w@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 4:53=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wrote:
> > On Fri, Feb 14, 2025 at 7:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > Expose the isoc_alt attr with device group to avoid the racing.
> > > >
> > > > Now we create a dev node for btusb. The isoc_alt attr belongs to it=
 and
> > > > it also becomes the parent device of hci dev.
> > > >
> > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to cont=
rol USB alt setting")
> > >
> > > Wait, step back, why is this commit needed if you can change the alt
> > > setting already today through usbfs/libusb without needing to mess wi=
th
> > > the bluetooth stack at all?
> >
> > In short: We want to configure the alternate settings without
> > detaching the btusb driver, while detaching seems necessary for
> > libusb_set_interface_alt_setting to work (Please correct me if I'm
> > wrong!)
>
> I think changing the alternate setting should work using usbfs as you
> would send that command to the device, not the interface, so the driver
> bound to the existing interface would not need to be removed.
>
> Try it out and see yourself to verify this before you continue down any
> of this.  There's no need to use libfs for just a single usbfs command,
> right?

I will give it a try. Great thanks for this suggestion!

>
> thanks,
>
> greg k-h


On Mon, Feb 17, 2025 at 4:55=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wrote:
> > On Fri, Feb 14, 2025 at 7:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > Expose the isoc_alt attr with device group to avoid the racing.
> > > >
> > > > Now we create a dev node for btusb. The isoc_alt attr belongs to it=
 and
> > > > it also becomes the parent device of hci dev.
> > > >
> > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to cont=
rol USB alt setting")
> > >
> > > Wait, step back, why is this commit needed if you can change the alt
> > > setting already today through usbfs/libusb without needing to mess wi=
th
> > > the bluetooth stack at all?
> >
> > In short: We want to configure the alternate settings without
> > detaching the btusb driver, while detaching seems necessary for
> > libusb_set_interface_alt_setting to work (Please correct me if I'm
> > wrong!)
> >
> > Background:
> > The Bluetooth Core Specification defines a protocol for the operating
> > system to communicate with a Bluetooth chipset, called HCI (Host
> > Controller Interface) (Host=3DOS, Controller=3Dchipset).
> > We could say the main purpose of the Linux Bluetooth drivers is to set
> > up and get the HCI ready for the "upper layer" to use.
> >
> > Who could be the "upper layer" then? There are mainly 2: "Control" and
> > "User" channels.
> > Linux has its default Bluetooth stack, BlueZ, which is splitted into 2
> > parts: the kernel space and the user space. The kernel space part
> > provides an abstracted Bluetooth API called MGMT, and is exposed
> > through the Bluetooth HCI socket "Control" channel.
> > On the other hand Linux also exposes the Bluetooth HCI socket "User"
> > channel, allowing the user space APPs to send/receive the HCI packets
> > directly to/from the chipset. Google's products (Android, ChromeOS,
> > etc) use this channel.
> >
> > Now why this patch?
> > It's because the Bluetooth spec defines something specific to USB
> > transport: A USB Bluetooth chipset must/should support these alternate
> > settings; When transferring this type of the Audio data this alt must
> > be used, bla bla bla...
> > The Control channel handles this in the kernel part. However, the
> > applications built on top of the User channel are unable to configure
> > the alt setting, and I'd like to add the support through sysfs.
>
> So the "problem" is that Google doesn't want to use BlueZ, which is
> fine, you do you :)
>
> But how does BlueZ handle this same problem today?  What api to the
> kernel does it use to change the interface that you can't also do with
> your "BlueZ replacement"?
>
> Surely this isn't a new issue suddenly, but if it is, it needs to be
> solved so BOTH userspace stacks can handle it.

BlueZ handles that in their MGMT command, that is, through Control
channel -> BlueZ kernel space code -> driver callbacks.
Once a Bluetooth chipset is opened with the User channel, it can't be
used with the Control channel simultaneously, and vice versa.

>
> thanks,
>
> greg k-h

--=20
Best Regards,
Hsin-chen

