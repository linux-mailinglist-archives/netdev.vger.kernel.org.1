Return-Path: <netdev+bounces-167237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE5CA39539
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D597A125E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DE22B8B6;
	Tue, 18 Feb 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2rjtMJY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8E22B8AC;
	Tue, 18 Feb 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866995; cv=none; b=KUuHq0bIloPbNUKMphOAxvpPw8Klz/VdVG6Kq8stBfsBo7g014nZAsXDg9oBuBty9XmViGQdu6Qia9/Pd827x4pB9Eo+U9g6Ut0EywZz3oZki+3TtznrbInWYVdTiSbbhrbf+aV2k0flGViosp+7aU9QI3cooSvf3jY5yS4lkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866995; c=relaxed/simple;
	bh=neeFVALKbKwQUPHxKrTHs/kVl2XxJWwQWOBdLZElY94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0dxAA4/f8T+FxyXeTum+U+VRDI4Ftd+BQffKeRivUpWQrP3UDjJkX3bZFzcqqgenDNTTJKGK1i3pk4kMCBaEQKBPD2a7B58qr4FkRnPOxInHalh6tB1RZlbm9Ad4NuHX55F/6joLJ8CN8jEOaViTN3lVezrbD+PVGgPwK65Fy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2rjtMJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176AFC4CEE2;
	Tue, 18 Feb 2025 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739866994;
	bh=neeFVALKbKwQUPHxKrTHs/kVl2XxJWwQWOBdLZElY94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2rjtMJYFrD16J2ut1MoO/nzfvlY4PeHMMF470CaK971/Tp4bYfsa1ItIz39BTEaL
	 MSN5czFgQaYui30dNETEwZjLLYUuJNE9NOTYB2WPsw0rkMuI3r+NXvh3k1mJyVIc2E
	 nRWiyvMpLa3tZGZjIW6J6hi9WgDmHzbPTVVlluzE=
Date: Tue, 18 Feb 2025 09:23:11 +0100
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
Message-ID: <2025021829-clamor-lavish-9126@gregkh>
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021425-surgical-wackiness-0940@gregkh>
 <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>
 <2025021717-prepay-sharpener-37fb@gregkh>
 <CADg1FFf7fONc+HJT8rq55rVFRnS_UxnEPnAGQ476WVe+208_pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg1FFf7fONc+HJT8rq55rVFRnS_UxnEPnAGQ476WVe+208_pA@mail.gmail.com>

On Tue, Feb 18, 2025 at 12:24:07PM +0800, Hsin-chen Chuang wrote:
> Hi Greg,
> 
> On Mon, Feb 17, 2025 at 4:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wrote:
> > > On Fri, Feb 14, 2025 at 7:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > >
> > > > > Expose the isoc_alt attr with device group to avoid the racing.
> > > > >
> > > > > Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> > > > > it also becomes the parent device of hci dev.
> > > > >
> > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
> > > >
> > > > Wait, step back, why is this commit needed if you can change the alt
> > > > setting already today through usbfs/libusb without needing to mess with
> > > > the bluetooth stack at all?
> > >
> > > In short: We want to configure the alternate settings without
> > > detaching the btusb driver, while detaching seems necessary for
> > > libusb_set_interface_alt_setting to work (Please correct me if I'm
> > > wrong!)
> >
> > I think changing the alternate setting should work using usbfs as you
> > would send that command to the device, not the interface, so the driver
> > bound to the existing interface would not need to be removed.
> 
> I thought USBDEVFS_SETINTERFACE was the right command to begin with,
> but it seems not working in this case.
> The command itself attempts to claim the interface, but the interface
> is already claimed by btusb so it failed with Device or resource busy
> 
> drivers/usb/core/devio.c:
>   USBDEVFS_SETINTERFACE -> proc_setintf -> checkintf -> claimintf

Ah, ok, thanks for checking.  So as you control this device, why not
just disconnect it, change the setting, and then reconnect it?

Also, see my other review comment, how does BlueZ do this today?

thanks,

greg k-h

