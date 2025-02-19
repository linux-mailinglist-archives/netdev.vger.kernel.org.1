Return-Path: <netdev+bounces-167565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5BBA3AF26
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23FC1893A1E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD712CDAE;
	Wed, 19 Feb 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCkKPdSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86033E1
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930079; cv=none; b=svsTXsRgzlCW3v7HFBf+i9Xp4nKqrGf7ijQIVSdxoykKxWTrBICPxlZJg/U20SAPcmq3KErDUwFrRTqmlNAMEmFhyQ7mpnyxF7txzdu2FeBMGqqmjqSedK+VbNbJ5RpO9x6viuf+zuM8g6e25/uzju3BMFEsNFUt4BLT0Rp4ptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930079; c=relaxed/simple;
	bh=c8GDYqlbgIMRWWO2sf77W+DHpA5uVuBQxbt73RzgXOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbkqSbALzjFCzppWcNBzw4ng33tpKqjwU2UJGo2FARGhF95c7e2DLS+yZ2PoNOS3xiJ/NG4iXQ/NBMGDDR+ZY+U0JSi+44jUTu0jBEM8MGFH/Yvc43BQlJkXcZNeJS6rQX5vrtHlYdPiA7xihGMPdsR/l70mptwzavQIVy72n0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCkKPdSx; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e46ebe19489so4074399276.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739930076; x=1740534876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7evDSaXnUit0j7oV94MbFS+YZGrtfrFgOO3rHeTxyk=;
        b=RCkKPdSxERhDZOR5t8KVf0n4RJNNocbQlooR0ze1QAocUW2Kaz/A7v3Kw6vcFLbMBU
         YcrVnSYZCvlDa6S0SVDLqNoRgAVTU1Adx6MBcoND9aM/qQ+18D7S4rRJ9CGK0vD/Q259
         LU4ZMsCzTmmwRMgc76N08uR7Tu0jhnoA9p5Eh2fWVk76hIqiGUCR+71KktS3I+c5FzcP
         q/q7M4BTVJD6iW3h42P5usNV3K8768froN5c8fVT+85QvYcHD7bJHgHi5lU5SGaGjCyh
         96YVN03R0JwjK/kEJykKZu20Tok2dF2Q0e4u4LVfY9E8UudF5f8BpC13FwglBtAwZnyE
         Entw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739930076; x=1740534876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7evDSaXnUit0j7oV94MbFS+YZGrtfrFgOO3rHeTxyk=;
        b=jCrYyV6ZA/vaGw/9iFbjzUjVK/8xdxYrHzKQ9qDcSvDDQ0RoOZnFEMz8/c4tBQ2PFS
         bs1kfch6nSvSFVRBxVzaO4W3tHXs8zL8apKgT1JIuQ18vW2Ld35Hdpy86DWFmxHGV2qt
         ziR6B2ItQJXoItsSIjQkrV0oDzEWWzzFmAaNtMkPb7igJm1a6qa1sbQqOuDgEquqgdlA
         BBUBn+mRCacOFFnrraJCTdrhlYSN1LVBCDD8d23BSxVCcWe6pF+37DxnolOkjoDzKVyL
         YauprhKmLGJaGtG9LWJ6sbkJGNtd5vLjrxepaii72fHTk6K6WLhVS4Z2V6AdcrWtqh5N
         p3CA==
X-Forwarded-Encrypted: i=1; AJvYcCUBCgyNZul/bt3Gr1t74q6jWRHmeV3miBjXcUWjCc3AIRYMPeSOX2K9xIRXhzkHo0QP55VBvWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJbAApU7308w3GORhHzkbx/NSwjZ/RmG1DqE0zI5eQIi1o7HW
	hVrDtcTb2oIw2CQyU3YTxS3C/p7xlBI4yOlXhMptfoW8uKyt5/ntlJM4LzMRXPZhQxTOMme6iHb
	jMvhmLOe1UtMEscShiAnjzveUA0ZG75El3J34
X-Gm-Gg: ASbGncuXckR5qSGMUT+zwqT8+ecOf4mAlpnUojdtXOYuIgr31EnlXL0VuuDnwNArdaX
	gUBk97X2ptEF0Y5YegK111XifuahsdG4ASbPGCLNPsGkTjpEd0RIyVd8/KRLWp8st2lZxnqKkMu
	5KJH7UalKrDbbv+SHM6nFxQAxu
X-Google-Smtp-Source: AGHT+IF/kLMYr7be5Y33dHtm4KpedctJM1JrBgkcfSrp8OXbr50OnQgeO4FKsxUlWgnsWYDAUVcmqvHvUuuyhZCxqOg=
X-Received: by 2002:a05:6902:1b12:b0:e5b:21e4:d891 with SMTP id
 3f1490d57ef6-e5e0a0de7c5mr1595011276.29.1739930076241; Tue, 18 Feb 2025
 17:54:36 -0800 (PST)
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
 <2025021812-expedited-fanning-d5d0@gregkh> <CADg1FFdXNEDN7hXX2bw91YKbJzpk4ZiLP+ut9QBRkuK=vDmDJw@mail.gmail.com>
In-Reply-To: <CADg1FFdXNEDN7hXX2bw91YKbJzpk4ZiLP+ut9QBRkuK=vDmDJw@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Wed, 19 Feb 2025 09:54:09 +0800
X-Gm-Features: AWEUYZmNb725GSfA6SGcNuEFOzHPTodWRw4o1ZG5KtE-iCNlbAS_tFXNkGdpOes
Message-ID: <CADg1FFcQzRbVhx+hcWpjzkTCzbE2wY+KLMYz0O-NUUOfv=XyDg@mail.gmail.com>
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

On Tue, Feb 18, 2025 at 8:24=E2=80=AFPM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> Hi Greg,
>
> On Tue, Feb 18, 2025 at 6:56=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Tue, Feb 18, 2025 at 06:01:42PM +0800, Hsin-chen Chuang wrote:
> > > Hi Greg,
> > >
> > > On Tue, Feb 18, 2025 at 5:21=E2=80=AFPM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 04:57:38PM +0800, Hsin-chen Chuang wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Tue, Feb 18, 2025 at 4:23=E2=80=AFPM Greg KH <gregkh@linuxfoun=
dation.org> wrote:
> > > > > >
> > > > > > On Tue, Feb 18, 2025 at 12:24:07PM +0800, Hsin-chen Chuang wrot=
e:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > On Mon, Feb 17, 2025 at 4:53=E2=80=AFPM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang =
wrote:
> > > > > > > > > On Fri, Feb 14, 2025 at 7:37=E2=80=AFPM Greg KH <gregkh@l=
inuxfoundation.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chu=
ang wrote:
> > > > > > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > > > >
> > > > > > > > > > > Expose the isoc_alt attr with device group to avoid t=
he racing.
> > > > > > > > > > >
> > > > > > > > > > > Now we create a dev node for btusb. The isoc_alt attr=
 belongs to it and
> > > > > > > > > > > it also becomes the parent device of hci dev.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs att=
ribute to control USB alt setting")
> > > > > > > > > >
> > > > > > > > > > Wait, step back, why is this commit needed if you can c=
hange the alt
> > > > > > > > > > setting already today through usbfs/libusb without need=
ing to mess with
> > > > > > > > > > the bluetooth stack at all?
> > > > > > > > >
> > > > > > > > > In short: We want to configure the alternate settings wit=
hout
> > > > > > > > > detaching the btusb driver, while detaching seems necessa=
ry for
> > > > > > > > > libusb_set_interface_alt_setting to work (Please correct =
me if I'm
> > > > > > > > > wrong!)
> > > > > > > >
> > > > > > > > I think changing the alternate setting should work using us=
bfs as you
> > > > > > > > would send that command to the device, not the interface, s=
o the driver
> > > > > > > > bound to the existing interface would not need to be remove=
d.
> > > > > > >
> > > > > > > I thought USBDEVFS_SETINTERFACE was the right command to begi=
n with,
> > > > > > > but it seems not working in this case.
> > > > > > > The command itself attempts to claim the interface, but the i=
nterface
> > > > > > > is already claimed by btusb so it failed with Device or resou=
rce busy
> > > > > > >
> > > > > > > drivers/usb/core/devio.c:
> > > > > > >   USBDEVFS_SETINTERFACE -> proc_setintf -> checkintf -> claim=
intf
> > > > > >
> > > > > > Ah, ok, thanks for checking.  So as you control this device, wh=
y not
> > > > > > just disconnect it, change the setting, and then reconnect it?
> > > > >
> > > > > After dis/reconnecting, a Bluetooth chipset would lose all its st=
ate:
> > > > > Existing connections/scanners/advertisers are all dropped.
> > > >
> > > > If you are changing the alternate USB configuration, all state shou=
ld be
> > > > dropped, right?  If not, huh how does the device know to keep that
> > > > state?
> > >
> > > No, the Bluetooth chip doesn't drop any info when the alt is changed.
> > > It only affects the data transfer bandwidth on that interface.
> > >
> > > >
> > > > > This is as bad as (just an analogy) "Whenever you access a http w=
eb
> > > > > page, you need to bring your ethernet interface down and up, and =
after
> > > > > the page is downloaded, do that again".
> > > >
> > > > Your ethernet interface does not contain state like this, we handle
> > > > chainging IP addresses and devices all the time, so perhaps wrong
> > > > analogy :)
> > > >
> > > > > > Also, see my other review comment, how does BlueZ do this today=
?
> > > > >
> > > > > BlueZ handles that in their MGMT command, that is, through Contro=
l
> > > > > channel -> BlueZ kernel space code -> driver callbacks.
> > > > > Once a Bluetooth chipset is opened with the User channel, it can'=
t be
> > > > > used with the Control channel simultaneously, and vice versa.
> > > >
> > > > So why not use that same control channel in your code?  Why are you
> > >
> > > Because we're using the User channel, and they can't be used at the s=
ame time.
> >
> > This doesn't make sense.  Either BlueZ has this same problem, or it
> > doesn't.  As you say it does not, then again, why can't you use the
> > exact same user/kernel api to achieve this?
> >
> > The user/kernel api is "fixed" right now, if you wish to replace the
> > userspace side of the BlueZ code with your own, then you should/must us=
e
> > that same user/kernel api.  Don't go adding duplicate interfaces please=
.
>
> I would say the kernel provides 2 sets of the API, Control and User,
> and now the User channel is missing something.
> I think it makes sense to add support for it.
>
> >
> > > > reinventing a new control channel for something that is obviously t=
here
> > > > already?
> > >
> > > Not quite the same as "reinventing". The Control channel command does
> > > much more than just setting the alt; It just doesn't work with the
> > > User channel.
> > >
> > > >
> > > > So in short, what's preventing you from using the same exact driver
> > > > callbacks, OR the same exact kernel api.  Surely you all are not
> > >
> > > The answer is the same as the above. This feature is missing in the
> > > User channel, and I'm completing it with this patch.
> >
> > Again, that seems to be your userspace's issue, not the kernel's.  Just
> > use the same api that bluez uses here.
> >
> > > > replacing all of the in-kernel BlueZ code with an external kernel d=
river
> > > > just for this, right?  If so, that's not ok at all.
> > >
> > > Sorry I don't quite get it. What do you mean by the external kernel d=
river?
> >
> > You said you are not using the bluez kernel code, right?  So you must
> > have some kernel code to implement this instead for the same
> > functionality.  Otherwise you are using the bluez kernel api here.
>
> No, we don't have kernel code for Bluetooth. We have everything in user s=
pace.
>
> >
> > Again, just use the same api please, don't go adding new one-off apis
> > through sysfs for this when it is not needed.
> >
> > I'll also step back further and say, why not use bluez?  What is so
> > wrong with that that you all need a totally different bluetooth stack?
> > Why not just fix the bluez code for anything that is currently missing
> > or lacking there that required you to write a new one.
>
> I think the main purpose is moving the stack to the user space.
> When the user hits a Bluetooth issue, it's much easier to reset the stack=
.
> Also, a simple Bluetooth bug just won't crash your kernel and we could
> even crash MORE to detect an incorrect chipset behavior earlier.
> Of course BlueZ has its own advantages, but it's just all trade-offs.
>
> >
> > And yes, I know the inclination of Android to constantly rewrite the
> > bluetooth stack, it's on the what, third or fourth iteration already?
> > What's to guarantee that this really will be the last one?  :)
>
> That's incorrect. Android is still using and maintaining the same
> stack since it left BlueZ.
>
> --
> Best Regards,
> Hsin-chen

I'm moving forward and sending out v6 for review as there's no more
comment related to the struct device usage.
We could continue the discussion on v6, thanks.

--=20
Best Regards,
Hsin-chen

