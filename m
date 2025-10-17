Return-Path: <netdev+bounces-230482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E044BE8C18
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E461AA4C5D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A5345738;
	Fri, 17 Oct 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="BaSxQt/e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FAB3451AB
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706630; cv=none; b=GEZipSfyBHXM21Ihg/GztKRw/vGVXjSUo9+/VTkA8leF7L1O9P3BERUr3lpwIMyePz/04dl8p2Cn4zMxCbHcZ0FQGr2dqJO9gUKNASDjRDmiO2YqtyLnSPufj5efxvln1H8DPP5PRuacZq/Yf9qHtJnGsMZATSfF/nfFicBNZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706630; c=relaxed/simple;
	bh=439D4x4RewosLmOifKb8w/D7qCnx3Fln5kuNMbO8pxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+EDLguGVu5oITYgmaHG+OkrW72wmI5nJ6wRFHEcn6oOTkuJghmh3mfa5Od9BiLMEZNs7h5jcGdTKbjDNV1rqIrEGWkQ61v05AdoWHum+oWw61P9nEDe+UBIcsho1911DKv+5NRY/kiDKTPbAjJf8PeYxhuDsrPBUSlYCUGWqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=BaSxQt/e; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88e68c0a7bfso373326285a.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760706627; x=1761311427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3n12fDi8NT3PL5BkJsb+zATv8iKj3oJFPgatJxL6saw=;
        b=BaSxQt/eNed5m0chPoCyNucSmmD28R59Si2dbjx+PwIRE8Dihx8tqS+RARYRwXKBWh
         TC5cC9ho/sVLB8s9EOPsplmCR3VweeGI1mvHgIiF1hv5VJxEVyabyIDTcVBdoFgkICDF
         09vYVtKNqSdPualE2oXS9GrCRgFn91KhW37muojt7+xfBH7uFYFKHrqE7jlUL/nN5Gvi
         /oCkop+zjJ8UxaAkaM2CYEAFlD3mdLQO1ZkuIjeuIw7+ZMhPvUeNAdA+0PXRLr1Sh97S
         yXqt0zvy7hYRuYEC0bwmRzcnsfM8DhGIfIcaR5V5ai/ZVweqY4pXSkbhkDnGMT0IBv58
         bXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706627; x=1761311427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n12fDi8NT3PL5BkJsb+zATv8iKj3oJFPgatJxL6saw=;
        b=Aq8mzGQnJz+IKmrdUEIX0nIbcpf0+u7Qef5BUiT3q6fMZv0kHj/KKym8zu3JPIAVrg
         XQwLahBgAiHw0i3LPMeUSro8yf4UreR8qmKc+J7ppCyHPWaXgF+rXXhqKmalnltDtffV
         i+Ys8oTuTD8qHu3gGFzjdHkUzEV5AUj6RW8drpuCE7CZEM1PHP9kavjWtB+6LxTG/h5L
         unTxVrzNXttBuTRzFxJ16Y6B4633dFw+BLaq4vuVoAyqXzxlSkeQOLTy/JXUR4ilydop
         /tTiVbdpU2IT95N0hp07pyvQug7NvEprb+wSVTb1tAUXztpE2iCkMRiajIE1ejATmGx0
         oKRg==
X-Forwarded-Encrypted: i=1; AJvYcCVy7Iff0ImLhKNTVnwoI2pJTytGEcT6xzn41GnENilr28u3tTVqP60wYKYuyCRs3KRbtX/Tblc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy86ZIpX1XRHzRnlNTX7GQGSMgrdY6INTsL8Hk0dUkI8Y6aevbE
	vHjWoDuSntdvLtl5PIWSdTXBRxGIXhLawEtt61Ur5hUDdL3zislxgPW0NN8iOG4wBQ==
X-Gm-Gg: ASbGncuBdv13dwoVE9w1CS6+zr5ne9ZIK7hfiMTbBINokjE7t+lRc3Q5GQW4Iwap89Z
	K1zR5AUk7DSuaYn5VkOqVRcSNGwobEAKUq+KXFHPxQm49scq7dxfjqv2RHHQHD/LSBzxMtk///o
	mje95OSpuI3uNuVSLgjpPpqcjmXx5Sc0Rg4b4mAXeQAIyPA9V9MTMgSBY4OH0WXAQCZZ/R4HXeM
	n6UPvfJwfxQDp2dKeN82B3oF47i0sXaIwVt0SNv8AVtXP4ZeUUoorkoqphsjNtxxGcpCbhB3gW+
	7z4dw2GAzL2gyu+A66AIJnIUG7dyj5U1G7s/Kf2L/6hbXqGYjlK8Esus+ETQ4Pmk5KUSvDqfTlp
	ZhZR46eNmiPN+VISkWVl88+AFjhJdgOI1a7Nbk51BMlkavRiorRSil1QUZzkV5uyHroZDz1yzmV
	nxEeFBfWQD+yKuwuPtY7fryUA=
X-Google-Smtp-Source: AGHT+IEpkGgt8qwkxX2G4nNg9sTqQYAmhd3dwwQtJvwgWPzzvMXMssW2nEo8a9VhAs8cB00VbditYw==
X-Received: by 2002:a05:620a:1a2a:b0:85c:dda4:1cc8 with SMTP id af79cd13be357-8906fd18369mr434075485a.45.1760706627085;
        Fri, 17 Oct 2025 06:10:27 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::ba76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f37f45129sm415854285a.38.2025.10.17.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:10:26 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:10:22 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: yicongsrfy@163.com
Cc: michal.pecio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017024229.1959295-1-yicongsrfy@163.com>

On Fri, Oct 17, 2025 at 10:42:29AM +0800, yicongsrfy@163.com wrote:
> > > +	/* The vendor mode is not always config #1, so to find it out. */
> > > +	c = udev->config;
> > > +	num_configs = udev->descriptor.bNumConfigurations;
> > > +	for (i = 0; i < num_configs; (i++, c++)) {
> > > +		struct usb_interface_descriptor	*desc = NULL;
> > > +
> > > +		if (!c->desc.bNumInterfaces)
> > > +			continue;
> > > +		desc = &c->intf_cache[0]->altsetting->desc;
> > > +		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC)
> > > +			break;
> > > +	}
> > > +
> > > +	if (i == num_configs)
> > > +		return -ENODEV;
> > > +
> > > +	return c->desc.bConfigurationValue;
> > > +}
> >
> > I wonder how many copies of this code would justify making it some
> > sort of library in usbnet or usbcore?
> 
> Yes, there are many similar code instances in the USB subsystem.
> However, I'm primarily focused on the networking subsystem,
> so my abstraction work here might not be thorough enough.
> Hopefully, an experienced USB developer may can optimize this issue.

Would it help to have a USB quirks flag that tells the core to prefer 
configurations with a USB_CLASS_VENDOR_SPEC interface class when we 
choose the device's configuration?  Or something similar to that (I'm 
not sure exactly what you are looking for)?

Alan Stern

