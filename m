Return-Path: <netdev+bounces-167322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28529A39C17
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F213B47C3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A54C2417FF;
	Tue, 18 Feb 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXdsh8/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813F2417F6
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881518; cv=none; b=HOAJ4WxN4UAT4UWshjBTuv322V8Fl9iPbP/IToN/qRNYU/7MZyO297EJVoH2X3sEB/et9kz6uFcE6CylN/qD4Hc8cQBzishjMsSADuJF9Iq4n1/qMO5lWrWF7lvef/D1A4fXsSngaIukgU4enr9P0ON/feTwIxIJNZvw1P7o93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881518; c=relaxed/simple;
	bh=5d/yfDMx+vbAdrc9Pxu6YpWSrcaSDQaBtCbMVdYGCTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvVTu9N5AuqEumtcn4QFJCFDIrVj/ZYaK0YvgrdDfYBEdVNA8m7o9aflfi4b2Eof3WZ250cbSd99d02ES9XvY1BjruboXWP+44ldCG1lIganARIQ7bORFZzNwUTlvs8Ix1RboSlHOY9fK4+RSPlggBNrqZDxvcAweZGQorCHFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lXdsh8/h; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so2692268276.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739881515; x=1740486315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89QAT0ZhfsEc4yXc1OMv7rDWxt18UAYuhIx/I7+65G4=;
        b=lXdsh8/haC1odNmMO2Ia/IlA3ESjSR+1gA2K7jAo/9XNRCRJO5e7aL3DvxKksE4Bsr
         XeDptL+ITTZg/yc1/NYXlGHT970xyM8eSRNzSWB5tnKqcVSeR6njTPOitTdPotmJMP9e
         PQu2OY/0NlArG/tlY9fg1NsYVHTIRth3FMBvYt/bXU+FUBSHJj4VqSIHBuucUyWSr8Gj
         lc9C/BnYva7VrTV77bHq8zJG6qQSyMfFByptTdYKqKWa14quGvz9NOiLvqDTu5jKO+yP
         eLc7UFkdZuOUcIkj6TLciX83Z7Z6qJ9GmC2q3B0BHQjfAIFmWXdIu0LEeNjUrMh7v4gE
         y6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739881515; x=1740486315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89QAT0ZhfsEc4yXc1OMv7rDWxt18UAYuhIx/I7+65G4=;
        b=LLeqScELJIR4ywUyFeJL+m4vglL+GmmO02mbmZgWDhcJsvwu5yDD6u+hnPFptBD2w5
         jwNkl3Lxs6xExeU3cF0TKQPAnIV5tnF878xdCkiI81JM5iRkyqXOMsRivnFiEGD7Y40H
         BlOhgQYPHrq7Gdlg6eLCFp+LXNq9kYCsFux0bj7L7U1BCzmLARQ/A2HZBUNCjpFU64L8
         Ih2gVzYs2l9vgxXsw6/lAebr2qLmrjUuIMFC0zH6lbYGAy9XEkMAdGOOxCNTF6HHvtTz
         DhE8vCbPfsZ0LGIjH9EDl9UrI/2znc0TTW95p+330mYRlO7e1UyJVilOw5CNgrLO0oYi
         wLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsS+E8aUEdTLIQST4Vkp64HdvS9Yvj+9/73ggjP5DBuHT3GmMegHuj+OGNQoY2/mXY6yfDAvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqXqUy9O20Df20OGIloi9ZF0JvKLYZ9WeGoMstMadM3oBR0Qf
	DwQ3dnjpDaTHQeI5Fphxvp9gHxPtdpHCdubIvWLZzRMSAPwIy0MajAuVENmq0GuEhzDGuOepBVD
	XG7FrMlIibKYkiTYWIkm2aFG/tATrXQokxz7G
X-Gm-Gg: ASbGnctTf7M+WjuDiAsDh4J2estg5UoP2DrCh3S5ZBN7QNB5s8aZtqRmWx1FznaRSOD
	kz5MN9csIS9iFqzQmKk/z0tuzjuHwkfrajawmOCPLYS/3SaRqmr5IhueugvzhQ9PvUkzPAGA=
X-Google-Smtp-Source: AGHT+IGTTTUXyz28p5IfFjpKS7EaFa3iqQsYzhp4ew646h9Vw7naGgFckbLjKSjQKEaJ99JXYQSsdA1dcvpnP+uh+SM=
X-Received: by 2002:a05:6902:1283:b0:e38:c0ed:8128 with SMTP id
 3f1490d57ef6-e5dc900e95bmr10444153276.3.1739881515290; Tue, 18 Feb 2025
 04:25:15 -0800 (PST)
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
 <2025021807-ultimate-ascent-f5e0@gregkh> <CADg1FFdLA8LCafbQA=x5onSj6FKS=0ihpYPpSjQmDpGG2iOb5A@mail.gmail.com>
 <2025021812-expedited-fanning-d5d0@gregkh>
In-Reply-To: <2025021812-expedited-fanning-d5d0@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Tue, 18 Feb 2025 20:24:48 +0800
X-Gm-Features: AWEUYZnWnBW8G7TexUswPhHo_H7wI3bUymhYmNj3r2t0V9rNgx_L5eAPQ8uKEK8
Message-ID: <CADg1FFdXNEDN7hXX2bw91YKbJzpk4ZiLP+ut9QBRkuK=vDmDJw@mail.gmail.com>
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

On Tue, Feb 18, 2025 at 6:56=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Feb 18, 2025 at 06:01:42PM +0800, Hsin-chen Chuang wrote:
> > Hi Greg,
> >
> > On Tue, Feb 18, 2025 at 5:21=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, Feb 18, 2025 at 04:57:38PM +0800, Hsin-chen Chuang wrote:
> > > > Hi Greg,
> > > >
> > > > On Tue, Feb 18, 2025 at 4:23=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Tue, Feb 18, 2025 at 12:24:07PM +0800, Hsin-chen Chuang wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > On Mon, Feb 17, 2025 at 4:53=E2=80=AFPM Greg KH <gregkh@linuxfo=
undation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wr=
ote:
> > > > > > > > On Fri, Feb 14, 2025 at 7:37=E2=80=AFPM Greg KH <gregkh@lin=
uxfoundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuan=
g wrote:
> > > > > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > > >
> > > > > > > > > > Expose the isoc_alt attr with device group to avoid the=
 racing.
> > > > > > > > > >
> > > > > > > > > > Now we create a dev node for btusb. The isoc_alt attr b=
elongs to it and
> > > > > > > > > > it also becomes the parent device of hci dev.
> > > > > > > > > >
> > > > > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attri=
bute to control USB alt setting")
> > > > > > > > >
> > > > > > > > > Wait, step back, why is this commit needed if you can cha=
nge the alt
> > > > > > > > > setting already today through usbfs/libusb without needin=
g to mess with
> > > > > > > > > the bluetooth stack at all?
> > > > > > > >
> > > > > > > > In short: We want to configure the alternate settings witho=
ut
> > > > > > > > detaching the btusb driver, while detaching seems necessary=
 for
> > > > > > > > libusb_set_interface_alt_setting to work (Please correct me=
 if I'm
> > > > > > > > wrong!)
> > > > > > >
> > > > > > > I think changing the alternate setting should work using usbf=
s as you
> > > > > > > would send that command to the device, not the interface, so =
the driver
> > > > > > > bound to the existing interface would not need to be removed.
> > > > > >
> > > > > > I thought USBDEVFS_SETINTERFACE was the right command to begin =
with,
> > > > > > but it seems not working in this case.
> > > > > > The command itself attempts to claim the interface, but the int=
erface
> > > > > > is already claimed by btusb so it failed with Device or resourc=
e busy
> > > > > >
> > > > > > drivers/usb/core/devio.c:
> > > > > >   USBDEVFS_SETINTERFACE -> proc_setintf -> checkintf -> claimin=
tf
> > > > >
> > > > > Ah, ok, thanks for checking.  So as you control this device, why =
not
> > > > > just disconnect it, change the setting, and then reconnect it?
> > > >
> > > > After dis/reconnecting, a Bluetooth chipset would lose all its stat=
e:
> > > > Existing connections/scanners/advertisers are all dropped.
> > >
> > > If you are changing the alternate USB configuration, all state should=
 be
> > > dropped, right?  If not, huh how does the device know to keep that
> > > state?
> >
> > No, the Bluetooth chip doesn't drop any info when the alt is changed.
> > It only affects the data transfer bandwidth on that interface.
> >
> > >
> > > > This is as bad as (just an analogy) "Whenever you access a http web
> > > > page, you need to bring your ethernet interface down and up, and af=
ter
> > > > the page is downloaded, do that again".
> > >
> > > Your ethernet interface does not contain state like this, we handle
> > > chainging IP addresses and devices all the time, so perhaps wrong
> > > analogy :)
> > >
> > > > > Also, see my other review comment, how does BlueZ do this today?
> > > >
> > > > BlueZ handles that in their MGMT command, that is, through Control
> > > > channel -> BlueZ kernel space code -> driver callbacks.
> > > > Once a Bluetooth chipset is opened with the User channel, it can't =
be
> > > > used with the Control channel simultaneously, and vice versa.
> > >
> > > So why not use that same control channel in your code?  Why are you
> >
> > Because we're using the User channel, and they can't be used at the sam=
e time.
>
> This doesn't make sense.  Either BlueZ has this same problem, or it
> doesn't.  As you say it does not, then again, why can't you use the
> exact same user/kernel api to achieve this?
>
> The user/kernel api is "fixed" right now, if you wish to replace the
> userspace side of the BlueZ code with your own, then you should/must use
> that same user/kernel api.  Don't go adding duplicate interfaces please.

I would say the kernel provides 2 sets of the API, Control and User,
and now the User channel is missing something.
I think it makes sense to add support for it.

>
> > > reinventing a new control channel for something that is obviously the=
re
> > > already?
> >
> > Not quite the same as "reinventing". The Control channel command does
> > much more than just setting the alt; It just doesn't work with the
> > User channel.
> >
> > >
> > > So in short, what's preventing you from using the same exact driver
> > > callbacks, OR the same exact kernel api.  Surely you all are not
> >
> > The answer is the same as the above. This feature is missing in the
> > User channel, and I'm completing it with this patch.
>
> Again, that seems to be your userspace's issue, not the kernel's.  Just
> use the same api that bluez uses here.
>
> > > replacing all of the in-kernel BlueZ code with an external kernel dri=
ver
> > > just for this, right?  If so, that's not ok at all.
> >
> > Sorry I don't quite get it. What do you mean by the external kernel dri=
ver?
>
> You said you are not using the bluez kernel code, right?  So you must
> have some kernel code to implement this instead for the same
> functionality.  Otherwise you are using the bluez kernel api here.

No, we don't have kernel code for Bluetooth. We have everything in user spa=
ce.

>
> Again, just use the same api please, don't go adding new one-off apis
> through sysfs for this when it is not needed.
>
> I'll also step back further and say, why not use bluez?  What is so
> wrong with that that you all need a totally different bluetooth stack?
> Why not just fix the bluez code for anything that is currently missing
> or lacking there that required you to write a new one.

I think the main purpose is moving the stack to the user space.
When the user hits a Bluetooth issue, it's much easier to reset the stack.
Also, a simple Bluetooth bug just won't crash your kernel and we could
even crash MORE to detect an incorrect chipset behavior earlier.
Of course BlueZ has its own advantages, but it's just all trade-offs.

>
> And yes, I know the inclination of Android to constantly rewrite the
> bluetooth stack, it's on the what, third or fourth iteration already?
> What's to guarantee that this really will be the last one?  :)

That's incorrect. Android is still using and maintaining the same
stack since it left BlueZ.

--=20
Best Regards,
Hsin-chen

