Return-Path: <netdev+bounces-167282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1EFA399BE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF393B01BB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19F239070;
	Tue, 18 Feb 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v3StM/7N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A522D4C9;
	Tue, 18 Feb 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876197; cv=none; b=qfWWoRgs3SVfLI1v+yIx3wVNSUxo7DXPduv2lH/Q7WGlF0/0fvRAQ2jd9CABe4P19OUGcZkPeSwOxPEWBOkeC9PUkuBnMy83SqdxnDbCsxPENPvjT8lqTY4fgS81bkRV/aum4uuKj11MUhUV7kTgIepws1OgHZc2eIOmfkvXM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876197; c=relaxed/simple;
	bh=5dBeLYBFlKkV+skNCFXTINM4Xy6rV6zd2RaAjvxqZHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jym4EDMS6epPD3y7Xo5dFBR3lGQDOhn8/li9DMM+l7tH4iYnJYy0QyOBKF+kAJ5olVS3SkW1aShrXksmTsZwwg3h6tp6xtmxsc4ZfTKrgdPMgAffb7p3YyWcRvvPVmcc8rRzasOQgJ7qXjBSETalUyvmH0unLlOWIDyA2XCv5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v3StM/7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7921CC4CEE6;
	Tue, 18 Feb 2025 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739876197;
	bh=5dBeLYBFlKkV+skNCFXTINM4Xy6rV6zd2RaAjvxqZHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v3StM/7NsQHoahS09HxhSqKye5jQEyO6xbO8/gdozWoc3mvyAep9HmlkCdDY3N9xI
	 /u9YKkNRzburupOyh/QpSeu74Cj9ZFSEnh2+OQ2Ki3p9ikbyy2wyskXlTnPw0+WOQy
	 Ly9p0+ZDwqkKSO7ezRT3P7r7+ci2Qy/hmsTurgok=
Date: Tue, 18 Feb 2025 11:56:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs
 isoc_alt
Message-ID: <2025021812-expedited-fanning-d5d0@gregkh>
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021425-surgical-wackiness-0940@gregkh>
 <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>
 <2025021717-prepay-sharpener-37fb@gregkh>
 <CADg1FFf7fONc+HJT8rq55rVFRnS_UxnEPnAGQ476WVe+208_pA@mail.gmail.com>
 <2025021829-clamor-lavish-9126@gregkh>
 <CADg1FFd=PbnNSBWk4KGV85jvvRQBBGG4QD2VHM6ABY-mqC8+Lg@mail.gmail.com>
 <2025021807-ultimate-ascent-f5e0@gregkh>
 <CADg1FFdLA8LCafbQA=x5onSj6FKS=0ihpYPpSjQmDpGG2iOb5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg1FFdLA8LCafbQA=x5onSj6FKS=0ihpYPpSjQmDpGG2iOb5A@mail.gmail.com>

On Tue, Feb 18, 2025 at 06:01:42PM +0800, Hsin-chen Chuang wrote:
> Hi Greg,
> 
> On Tue, Feb 18, 2025 at 5:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 18, 2025 at 04:57:38PM +0800, Hsin-chen Chuang wrote:
> > > Hi Greg,
> > >
> > > On Tue, Feb 18, 2025 at 4:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 12:24:07PM +0800, Hsin-chen Chuang wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Mon, Feb 17, 2025 at 4:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wrote:
> > > > > > > On Fri, Feb 14, 2025 at 7:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> > > > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > >
> > > > > > > > > Expose the isoc_alt attr with device group to avoid the racing.
> > > > > > > > >
> > > > > > > > > Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> > > > > > > > > it also becomes the parent device of hci dev.
> > > > > > > > >
> > > > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
> > > > > > > >
> > > > > > > > Wait, step back, why is this commit needed if you can change the alt
> > > > > > > > setting already today through usbfs/libusb without needing to mess with
> > > > > > > > the bluetooth stack at all?
> > > > > > >
> > > > > > > In short: We want to configure the alternate settings without
> > > > > > > detaching the btusb driver, while detaching seems necessary for
> > > > > > > libusb_set_interface_alt_setting to work (Please correct me if I'm
> > > > > > > wrong!)
> > > > > >
> > > > > > I think changing the alternate setting should work using usbfs as you
> > > > > > would send that command to the device, not the interface, so the driver
> > > > > > bound to the existing interface would not need to be removed.
> > > > >
> > > > > I thought USBDEVFS_SETINTERFACE was the right command to begin with,
> > > > > but it seems not working in this case.
> > > > > The command itself attempts to claim the interface, but the interface
> > > > > is already claimed by btusb so it failed with Device or resource busy
> > > > >
> > > > > drivers/usb/core/devio.c:
> > > > >   USBDEVFS_SETINTERFACE -> proc_setintf -> checkintf -> claimintf
> > > >
> > > > Ah, ok, thanks for checking.  So as you control this device, why not
> > > > just disconnect it, change the setting, and then reconnect it?
> > >
> > > After dis/reconnecting, a Bluetooth chipset would lose all its state:
> > > Existing connections/scanners/advertisers are all dropped.
> >
> > If you are changing the alternate USB configuration, all state should be
> > dropped, right?  If not, huh how does the device know to keep that
> > state?
> 
> No, the Bluetooth chip doesn't drop any info when the alt is changed.
> It only affects the data transfer bandwidth on that interface.
> 
> >
> > > This is as bad as (just an analogy) "Whenever you access a http web
> > > page, you need to bring your ethernet interface down and up, and after
> > > the page is downloaded, do that again".
> >
> > Your ethernet interface does not contain state like this, we handle
> > chainging IP addresses and devices all the time, so perhaps wrong
> > analogy :)
> >
> > > > Also, see my other review comment, how does BlueZ do this today?
> > >
> > > BlueZ handles that in their MGMT command, that is, through Control
> > > channel -> BlueZ kernel space code -> driver callbacks.
> > > Once a Bluetooth chipset is opened with the User channel, it can't be
> > > used with the Control channel simultaneously, and vice versa.
> >
> > So why not use that same control channel in your code?  Why are you
> 
> Because we're using the User channel, and they can't be used at the same time.

This doesn't make sense.  Either BlueZ has this same problem, or it
doesn't.  As you say it does not, then again, why can't you use the
exact same user/kernel api to achieve this?

The user/kernel api is "fixed" right now, if you wish to replace the
userspace side of the BlueZ code with your own, then you should/must use
that same user/kernel api.  Don't go adding duplicate interfaces please.

> > reinventing a new control channel for something that is obviously there
> > already?
> 
> Not quite the same as "reinventing". The Control channel command does
> much more than just setting the alt; It just doesn't work with the
> User channel.
> 
> >
> > So in short, what's preventing you from using the same exact driver
> > callbacks, OR the same exact kernel api.  Surely you all are not
> 
> The answer is the same as the above. This feature is missing in the
> User channel, and I'm completing it with this patch.

Again, that seems to be your userspace's issue, not the kernel's.  Just
use the same api that bluez uses here.

> > replacing all of the in-kernel BlueZ code with an external kernel driver
> > just for this, right?  If so, that's not ok at all.
> 
> Sorry I don't quite get it. What do you mean by the external kernel driver?

You said you are not using the bluez kernel code, right?  So you must
have some kernel code to implement this instead for the same
functionality.  Otherwise you are using the bluez kernel api here.

Again, just use the same api please, don't go adding new one-off apis
through sysfs for this when it is not needed.

I'll also step back further and say, why not use bluez?  What is so
wrong with that that you all need a totally different bluetooth stack?
Why not just fix the bluez code for anything that is currently missing
or lacking there that required you to write a new one.

And yes, I know the inclination of Android to constantly rewrite the
bluetooth stack, it's on the what, third or fourth iteration already?
What's to guarantee that this really will be the last one?  :)

thanks,

greg k-h

