Return-Path: <netdev+bounces-166100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A45A34852
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C439163372
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B01632DD;
	Thu, 13 Feb 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yKtY76j5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91678145A11;
	Thu, 13 Feb 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461163; cv=none; b=El12uo/VmffOXB8V318Gy35CKnQDTwd5KjfbVTnzw/Ajvte+3on4WefOTx0O7pKAx3ZJfbh7EUQePNHyr/23uzYWESI3tRImY3HEpvILiLNyBmQ/MdqSvquX8FysTyzTyNWuRO36A0UXtIgy0atoGVML5B9Nv8AHjLrk0I8/K0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461163; c=relaxed/simple;
	bh=6q/QewPzbnUsX7jiMLeE2mjex5cyWOE6tyicxoA6Dog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCza6QyG4Fs4goIQVTPmUlPfdLJ2bqxPvzODx+vn35jAkasY881rRtm2biTmaObUBV/NSaeDTrtneeQYdjN5JN7tAc5gNdHMlnnTKwEnq3P5dH90L1J74CmlrZozccntUD72OH6tJSyi5XjWw7Io65F6hTKv4lt6zEnJMcJETR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yKtY76j5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FD7C4CED1;
	Thu, 13 Feb 2025 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739461163;
	bh=6q/QewPzbnUsX7jiMLeE2mjex5cyWOE6tyicxoA6Dog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yKtY76j52li0sEk5y5KPMU6muU6YekOq4KWdWkuzQRyQUaU6VWQp/uBAqzQ5ctSTy
	 s0AbUnLkrGyTjPyPDtNcI38J2dZuq3C0P2N37SQ0mX+MsCcy9gMS9kRJ0VFRQ5AO+P
	 O9OUyCgR3u9oJQTN7RffyfCc3+zp3+3/NLUR10fk=
Date: Thu, 13 Feb 2025 15:35:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hsin-chen Chuang <chharry@google.com>, linux-bluetooth@vger.kernel.org,
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
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
Message-ID: <2025021347-exalted-calculate-b313@gregkh>
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh>
 <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh>
 <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
 <2025021318-regretful-factsheet-79a1@gregkh>
 <CABBYNZL4tEBTT3Hrf3JUGNuseLg1SNLmazo88EitmMfhUWUQxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZL4tEBTT3Hrf3JUGNuseLg1SNLmazo88EitmMfhUWUQxw@mail.gmail.com>

On Thu, Feb 13, 2025 at 09:22:28AM -0500, Luiz Augusto von Dentz wrote:
> Hi Greg,
> 
> On Thu, Feb 13, 2025 at 8:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 13, 2025 at 09:33:34PM +0800, Hsin-chen Chuang wrote:
> > > On Thu, Feb 13, 2025 at 8:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > A: http://en.wikipedia.org/wiki/Top_post
> > > > Q: Were do I find info about this thing called top-posting?
> > > > A: Because it messes up the order in which people normally read text.
> > > > Q: Why is top-posting such a bad thing?
> > > > A: Top-posting.
> > > > Q: What is the most annoying thing in e-mail?
> > > >
> > > > A: No.
> > > > Q: Should I include quotations after my reply?
> > > >
> > > > http://daringfireball.net/2007/07/on_top
> > > >
> > > > On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > > > > The btusb driver data is allocated by devm_kzalloc and is
> > > > > automatically freed on driver detach, so I guess we don't have
> > > > > anything to do here.
> > > >
> > > > What?  A struct device should NEVER be allocated with devm_kzalloc.
> > > > That's just not going to work at all.
> > >
> > > Noted. Perhaps that needs to be refactored together.
> > >
> > > >
> > > > > Or perhaps we should move btusb_disconnect's content here? Luiz, what
> > > > > do you think?
> > > >
> > > > I think something is really wrong here.  Why are you adding a new struct
> > > > device to the system?  What requires that?  What is this new device
> > > > going to be used for?
> > >
> > > The new device is only for exposing a new sysfs attribute.
> >
> > That feels crazy.
> >
> > > So originally we had a device called hci_dev, indicating the
> > > implementation of the Bluetooth HCI layer. hci_dev is directly the
> > > child of the usb_interface (the Bluetooth chip connected through USB).
> > > Now I would like to add an attribute for something that's not defined
> > > in the HCI layer, but lower layer only in Bluetooth USB.
> > > Thus we want to rephrase the structure: usb_interface -> btusb (new
> > > device) -> hci_dev, and then we could place the new attribute in the
> > > new device.
> > >
> > > Basically I kept the memory management in btusb unchanged in this
> > > patch, as the new device is only used for a new attribute.
> > > Would you suggest we revise the memory management since we added a
> > > device in this module?
> >
> > If you add a new device in the tree, it HAS to work properly with the
> > driver core (i.e. life cycles are unique, you can't have empty release
> > functions, etc.)  Put it on the proper bus it belongs to, bind the
> > needed drivers to it, and have it work that way, don't make a "fake"
> > device for no good reason.
> 
> Well we could just introduce it to USB device, since alternate setting
> is a concept that is coming from there, but apparently the likes of
> /sys/bus/usb/devices/usbX/bAlternateSetting is read-only, some
> Bluetooth profiles (HFP) requires switching the alternate setting and
> because Google is switching to handle this via userspace thus why
> there was this request to add a new sysfs to control it.

That's fine, just don't add devices where there shouldn't be devices, or
if you do, make them actually work properly (i.e. do NOT have empty
release callbacks...)

If you want to switch alternate settings in a USB device, do it the
normal way from userspace that has been there for decades!  Don't make
up some other random sysfs file for this please, that would be crazy,
and wrong.

So what's wrong with the current api we have today that doesn't work for
bluetooth devices?

thanks,

greg k-h

