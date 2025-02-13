Return-Path: <netdev+bounces-166042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8FA340AF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8A4188E54D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85824BBEF;
	Thu, 13 Feb 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bU/Syh21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8E24BC1D;
	Thu, 13 Feb 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454320; cv=none; b=FFdc7WJ8LWkMB7SKUG2GXAPvIl6gm/W/8Hu/RZKT+xV9kjpomGsCxB+nudnrNCTEsqoSADTHcda8oHjjSnRNPWHxK0kUbF4ENh/OxaGdL9rA1fxK+3qzwWgRhtLng+m+ZLmnEVidEUwemE6ByVtZ7a2FP7up/xw57IzHLE716TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454320; c=relaxed/simple;
	bh=94vF1Z2FInWjQjiuwptK3HfrtPNljBB+6zmYkZoSvMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ2jyM0Z7LSd3YtJJ8LotJwmUhvTipZ5X0lqiRwaBrvZ1q6P6QUdWMOVu2CHNErnuI/udqMmFz60lNm05NVPVZlbkc9ssRIWFj69Xc62wezWrKBlWfVaU72hMHDU+GLWFpR3Gg2jrKb1MgN8zDgOxEBfRmze/e8jwg6lCScR50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bU/Syh21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A73C4CED1;
	Thu, 13 Feb 2025 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739454319;
	bh=94vF1Z2FInWjQjiuwptK3HfrtPNljBB+6zmYkZoSvMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bU/Syh21an6cbZXbPUvrXxU42IRPt6/zNjZGI97HM17dU7pzctUSlBfppEzB7RHMn
	 YbtW3uS0OldlEXVWqTv5KJ4VYpAqQZvgvSKIJNbbQei5cFav5XlaPFjKb4688fvq+Q
	 699uSTyheVgS9OsMfAYXPmkvJhu3eI3KayHSM6jQ=
Date: Thu, 13 Feb 2025 14:45:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@google.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
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
Message-ID: <2025021318-regretful-factsheet-79a1@gregkh>
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh>
 <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh>
 <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>

On Thu, Feb 13, 2025 at 09:33:34PM +0800, Hsin-chen Chuang wrote:
> On Thu, Feb 13, 2025 at 8:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> >
> > A: No.
> > Q: Should I include quotations after my reply?
> >
> > http://daringfireball.net/2007/07/on_top
> >
> > On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > > The btusb driver data is allocated by devm_kzalloc and is
> > > automatically freed on driver detach, so I guess we don't have
> > > anything to do here.
> >
> > What?  A struct device should NEVER be allocated with devm_kzalloc.
> > That's just not going to work at all.
> 
> Noted. Perhaps that needs to be refactored together.
> 
> >
> > > Or perhaps we should move btusb_disconnect's content here? Luiz, what
> > > do you think?
> >
> > I think something is really wrong here.  Why are you adding a new struct
> > device to the system?  What requires that?  What is this new device
> > going to be used for?
> 
> The new device is only for exposing a new sysfs attribute.

That feels crazy.

> So originally we had a device called hci_dev, indicating the
> implementation of the Bluetooth HCI layer. hci_dev is directly the
> child of the usb_interface (the Bluetooth chip connected through USB).
> Now I would like to add an attribute for something that's not defined
> in the HCI layer, but lower layer only in Bluetooth USB.
> Thus we want to rephrase the structure: usb_interface -> btusb (new
> device) -> hci_dev, and then we could place the new attribute in the
> new device.
> 
> Basically I kept the memory management in btusb unchanged in this
> patch, as the new device is only used for a new attribute.
> Would you suggest we revise the memory management since we added a
> device in this module?

If you add a new device in the tree, it HAS to work properly with the
driver core (i.e. life cycles are unique, you can't have empty release
functions, etc.)  Put it on the proper bus it belongs to, bind the
needed drivers to it, and have it work that way, don't make a "fake"
device for no good reason.

thanks,

greg k-h

