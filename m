Return-Path: <netdev+bounces-230861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98755BF0A7A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3302D3E81AA
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A992459F8;
	Mon, 20 Oct 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWN4iWE3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6070B1C2334;
	Mon, 20 Oct 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957302; cv=none; b=DYnC8KgwSjRW5U1c/fa8lW21TygcPd/QQn6DxZo9PDfiIucqwwx6ioqLCBg+Hh1uUnL5ajxP42GezOihHo+oHn1H2lVUf7D5MC8dDS6/B23Ov3Vf7vUcZHawxfbAlNSRwhrkKZXG111RiONtzm5qLdFs4BS+2YBgcyO1JvoE1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957302; c=relaxed/simple;
	bh=R/XOimWAWa2N4HyOQsjFOKp4+nAIIkzSLl05o6cSXs4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsLjDwmN1w9mgl9DqDnInJvGdFtIaJ/ei7bhNOPmIZAKvHYYp0HSB7Ap0zblYRa58eaV69es3Ji/sfCFFA2IXES7jGGqNIN6gstVZYGIGZu9kAx+F0ZItarrGdhKftrezXrgFCM4b0oGV7x/Ot9P8ZzimA3HN6xl7o1mLKuBDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWN4iWE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE9DC4CEF9;
	Mon, 20 Oct 2025 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760957302;
	bh=R/XOimWAWa2N4HyOQsjFOKp4+nAIIkzSLl05o6cSXs4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=vWN4iWE3M66SXFxNO2sCX+65HkRG/M+0Du4uXfg0EIPmcsDlVA+wgPGnfCFDFO7lb
	 LxvUJ4Nb3tKpmfcYc9hOwazXKSBIt9iIcVKUHk+LnlVfTbJnZ+duSsSZ5KT4CVQyCF
	 uBWyXoDtfB3iVt+7Pnrivb9FxwDtSBdktK83vrZg=
Date: Mon, 20 Oct 2025 12:48:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>, Michal Pecio <michal.pecio@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>, yicongsrfy@163.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <2025102007-garland-splendid-abc9@gregkh>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
 <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
 <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
 <2fae9966-5e3a-488b-8ab5-51d46488e097@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fae9966-5e3a-488b-8ab5-51d46488e097@suse.com>

On Mon, Oct 20, 2025 at 11:59:06AM +0200, Oliver Neukum wrote:
> On 18.10.25 17:21, Michal Pecio wrote:
> 
> > index e85105939af8..1d2c5ebc81ab 100644
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -1202,6 +1202,8 @@ extern ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf);
> >    * @post_reset: Called by usb_reset_device() after the device
> >    *	has been reset
> >    * @shutdown: Called at shut-down time to quiesce the device.
> > + * @preferred: Check if this driver is preferred over generic class drivers
> > + *	applicable to the device. May probe device with control transfers.
> >    * @id_table: USB drivers use ID table to support hotplugging.
> >    *	Export this with MODULE_DEVICE_TABLE(usb,...).  This must be set
> >    *	or your driver's probe function will never get called.
> > @@ -1255,6 +1257,8 @@ struct usb_driver {
> >   	void (*shutdown)(struct usb_interface *intf);
> > +	bool (*preferred)(struct usb_device *udev);
> 
> I am sorry, but this is a bit clunky. If you really want to
> introduce such a method, why not just return the preferred configuration?

And note, this idea has come up many many times over the past 25 years,
ever since we first added USB support to Linux.  In the end, it was
always deemed "not going to work" for a variety of real-world reasons.

I suggest reviewing the archives of the mailing list and then, if this
series is resent, documenting why this attempt is different than the
others and why it will now work properly.

thanks,

greg k-h

