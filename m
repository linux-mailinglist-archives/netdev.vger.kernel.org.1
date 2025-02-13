Return-Path: <netdev+bounces-166114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4DEA348F3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993697A11D1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B761C863C;
	Thu, 13 Feb 2025 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NS6cZPk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB9166F32;
	Thu, 13 Feb 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462734; cv=none; b=X5t5QpYZ9S0J5hJ8TyeE/L7KDAKIAi6HIecZFVfdoQa/G1+II0YzrwdKW2oOdLcjFhNC+Ie8P39QB2nrsvhFgEph+EWFwAG4QK/ZhlrGTGVw4DrykiKMnBw1ma+khXzw+z24NAMkTWlRZ8HI15sWryimnXjqF0gH1B8/Hk/6Pk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462734; c=relaxed/simple;
	bh=KqLSD5pr31DT34vaQrITHjUd6zYfdu5KKwcHPMP10TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5MqbBI5RBc6O8YNyo8l19KQ8JWgHwbYB0G7v7YZ5bxZ794RPLcKmdB1DN5gWPtmU7COHejp6OIyu93/wXDXSrcXJVfEl/PlYCqu/G6ASKuCIn6Lc7E9IR+gcrTL9PypmMVkg/EZ4e6BF+tixC3yqDuxx856n4MIMUDEWULrz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NS6cZPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E90C4CED1;
	Thu, 13 Feb 2025 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739462733;
	bh=KqLSD5pr31DT34vaQrITHjUd6zYfdu5KKwcHPMP10TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2NS6cZPk3ivMsd0gRCvi8DZbL1qhq2MYNgphXrteL9o+WcQ8efGeYKoS1jExDPNrg
	 fr0MtF64ijizH5xwA7+R44XJ6tAn8D1K3oWZadl6on62SwNPfUsF1Q01U2j8A9SvI8
	 4re55Xiopq+TdPM17CGgBcRlc5v7msb22bu8gg+k=
Date: Thu, 13 Feb 2025 17:05:30 +0100
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
Message-ID: <2025021338-freewill-nimbly-7218@gregkh>
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh>
 <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh>
 <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
 <2025021318-regretful-factsheet-79a1@gregkh>
 <CABBYNZL4tEBTT3Hrf3JUGNuseLg1SNLmazo88EitmMfhUWUQxw@mail.gmail.com>
 <2025021347-exalted-calculate-b313@gregkh>
 <CABBYNZJSwQJ-KWacoXDGVJ5gni260FTi=XEpNw3ER2CJhpVrKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJSwQJ-KWacoXDGVJ5gni260FTi=XEpNw3ER2CJhpVrKg@mail.gmail.com>

On Thu, Feb 13, 2025 at 10:56:46AM -0500, Luiz Augusto von Dentz wrote:
> Hi Greg,
> 
> On Thu, Feb 13, 2025 at 10:39 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 13, 2025 at 09:22:28AM -0500, Luiz Augusto von Dentz wrote:
> > > Hi Greg,
> > >
> > > On Thu, Feb 13, 2025 at 8:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Feb 13, 2025 at 09:33:34PM +0800, Hsin-chen Chuang wrote:
> > > > > On Thu, Feb 13, 2025 at 8:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > A: http://en.wikipedia.org/wiki/Top_post
> > > > > > Q: Were do I find info about this thing called top-posting?
> > > > > > A: Because it messes up the order in which people normally read text.
> > > > > > Q: Why is top-posting such a bad thing?
> > > > > > A: Top-posting.
> > > > > > Q: What is the most annoying thing in e-mail?
> > > > > >
> > > > > > A: No.
> > > > > > Q: Should I include quotations after my reply?
> > > > > >
> > > > > > http://daringfireball.net/2007/07/on_top
> > > > > >
> > > > > > On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > > > > > > The btusb driver data is allocated by devm_kzalloc and is
> > > > > > > automatically freed on driver detach, so I guess we don't have
> > > > > > > anything to do here.
> > > > > >
> > > > > > What?  A struct device should NEVER be allocated with devm_kzalloc.
> > > > > > That's just not going to work at all.
> > > > >
> > > > > Noted. Perhaps that needs to be refactored together.
> > > > >
> > > > > >
> > > > > > > Or perhaps we should move btusb_disconnect's content here? Luiz, what
> > > > > > > do you think?
> > > > > >
> > > > > > I think something is really wrong here.  Why are you adding a new struct
> > > > > > device to the system?  What requires that?  What is this new device
> > > > > > going to be used for?
> > > > >
> > > > > The new device is only for exposing a new sysfs attribute.
> > > >
> > > > That feels crazy.
> > > >
> > > > > So originally we had a device called hci_dev, indicating the
> > > > > implementation of the Bluetooth HCI layer. hci_dev is directly the
> > > > > child of the usb_interface (the Bluetooth chip connected through USB).
> > > > > Now I would like to add an attribute for something that's not defined
> > > > > in the HCI layer, but lower layer only in Bluetooth USB.
> > > > > Thus we want to rephrase the structure: usb_interface -> btusb (new
> > > > > device) -> hci_dev, and then we could place the new attribute in the
> > > > > new device.
> > > > >
> > > > > Basically I kept the memory management in btusb unchanged in this
> > > > > patch, as the new device is only used for a new attribute.
> > > > > Would you suggest we revise the memory management since we added a
> > > > > device in this module?
> > > >
> > > > If you add a new device in the tree, it HAS to work properly with the
> > > > driver core (i.e. life cycles are unique, you can't have empty release
> > > > functions, etc.)  Put it on the proper bus it belongs to, bind the
> > > > needed drivers to it, and have it work that way, don't make a "fake"
> > > > device for no good reason.
> > >
> > > Well we could just introduce it to USB device, since alternate setting
> > > is a concept that is coming from there, but apparently the likes of
> > > /sys/bus/usb/devices/usbX/bAlternateSetting is read-only, some
> > > Bluetooth profiles (HFP) requires switching the alternate setting and
> > > because Google is switching to handle this via userspace thus why
> > > there was this request to add a new sysfs to control it.
> >
> > That's fine, just don't add devices where there shouldn't be devices, or
> > if you do, make them actually work properly (i.e. do NOT have empty
> > release callbacks...)
> >
> > If you want to switch alternate settings in a USB device, do it the
> > normal way from userspace that has been there for decades!  Don't make
> > up some other random sysfs file for this please, that would be crazy,
> > and wrong.
> >
> > So what's wrong with the current api we have today that doesn't work for
> > bluetooth devices?
> 
> Perhaps it is just lack of knowledge then, how userspace can request
> to switch alternate settings? If I recall correctly Hsin-chen tried
> with libusb, or something like that, but it didn't work for some
> reason.

The USBDEVFS_SETINTERFACE usbfs ioctl should do this.  If not, pleaase
let us know.  libusb supports this through the
libusb_set_interface_alt_setting() function.

Here's an 11 year old stackoverflow question about this:
	https://stackoverflow.com/questions/17546709/what-does-libusb-set-interface-alt-setting-do

thanks,

greg k-h

