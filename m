Return-Path: <netdev+bounces-230552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBBBBEB09E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB15E1AE4447
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BE8301480;
	Fri, 17 Oct 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik8IJV+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148972F12C6
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721324; cv=none; b=HPjw+t5C/wOhlMRRTAyJPMH5HOqNkkzoE505xVhAV1TLvTgo1VNQurDTIXTyM6eWRPycJOTQ21RTQXeBIw08jeOhfH2yHc4x8TYgbQE8xJEVvsDvPECEakqzPAOnCSVv6CDWeKn3bQm/nRpBs03CE1n51Z6/2ArK66+yDol4BGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721324; c=relaxed/simple;
	bh=PTe+dRMjjEdRz7HMYRB8/b977V5NY2J45HmjgRVliVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agDu1/PyGXNj1Z9R4ZRV6KV/PM7JzhkeaL5P/EpYjeccjnQ5s7KHg9RCusv5C3eVajaUzRw1R7WyWU2GYtmyjHNDfV6eTLFAuK1gAlt+TYAXh7V28KANQ8bMukHGWM6IQdoVh8YnzPfM/aAGwuSPQOhG8xOCX1vR18+SQopALis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik8IJV+r; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso1478815a12.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760721320; x=1761326120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erzvErFOuLAlu2WyRngTfkGBQrXV/AI4uNuvvvLtDAM=;
        b=Ik8IJV+rCGPxvPfFc0ax/4m7CQRXfq1I/YZNlTlReNsZbdbsgMYSbBTHU877jI7bV3
         mi8/OPAJp59VlTQ9FnXTmt14tUsZCemSOV2UPLJXnFoJ31WggpfcByJ2lXpdKRVtS8Ml
         S7nj/spySATy7dEgZTVNgm3QlHF9V0xAhoX6kso5gzjvbOWHw+ATSPIL2LDEtKW0/Vh4
         2ZM9hBcwgbaGacWANnhmp3/GWf4aUDN6pG6ai3OqmWj8j1MzX7W5E8DBk0Sfy8viTuct
         mzZYnan8Hz0UlxMuGBh3OEkH2ntJ5Yf/XWorag8UAWs8M2yYp8tRc8DIvou/Mwowv/0k
         0Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721320; x=1761326120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erzvErFOuLAlu2WyRngTfkGBQrXV/AI4uNuvvvLtDAM=;
        b=UgHYuBXVidqvYdFq2RVwNR2olroSRU35TVyuzyK1j6+p1TvdLT/Tv3tBb5mXnCKRT0
         QUjzM50YO44aLM6l3a0h2wL2LZWadzOwH469xTAffsHPKsxobkFzCozqE4LZsRUewkPu
         ep7XCNe0fRmVebWfBbB3ywKky5/I+1gvMYlOZ73xet4PlL8DwhiibEG+/orYKSzq41WT
         2ZrexjSzNHAWmxHVuDXM/bXDyp88XUkzYTXwOII2Och29+h4jQMFfODNdpbU0o5mKMwW
         xg8Hpy7DFi2aGhKcR8H8yBXZSG4gj4rskJAr/qG69HBC7aoS3ciR3n67RiI0EIJOTC+/
         ky8A==
X-Forwarded-Encrypted: i=1; AJvYcCXZC8DsD8BfVnZvhUup1ZnISG/Z05qw0XioF40+eDFDbddInfpX5otseCD5HAmo2W2+aw7uazg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+uQ/IwadOMmnQ58WvdN1R47+0YqiwbCeS9HUcaY3+cCGqEgx
	Fod5FT98z20bmVVDaJo9sCrt5ujd60Ko7PHCSJVAOWzxVUNEtDwGBVx0
X-Gm-Gg: ASbGnctqYqLzMRQJrqO9w5qdZmONWQGAFnGrkiLQxoj+5GICGXTFpfZKDH3dcHF5d0r
	W1JBzo4Gi2DcxTwxT6e1nANFzB+pqzMuoo7M76IFlnZxkYjLC5jWbCGel5VIKUM6hj6psOUQ+WQ
	QYN6Ro+1vRFQZKn7mNI+Q8TmqtpFb+1ye5npeauEScrHRZ7DfIWTB7x7a5PknUlcdk2TiNTeA+l
	VRM1krg7FhpfiW1V/+f6jxlMEpHNb9deugtI4ePzZ4SukgHtVrcUmJ/qQeYJSZC1d6PWlKo1mE0
	NH3gBYtaR5jEZZlKdEYFOPRoVldBHb6jEI4EVbERjf66vkRnKvXO2eGRq5e+5KQo4QV6C94LP3H
	mBbk1WeJLiF0IvAL1/UtJNZy5+9a+RnlpGC/w3ZqUW6+oWcM1a3eUeCgj8ilVBTAgMErVzX4cv2
	WZPLL0lOn6st732Z2E77WVZP/7j40=
X-Google-Smtp-Source: AGHT+IE5Zw3rQxm/Y37fbi6ptZgeE5aH3alHgFtNRGifq3aMvpVdl0YWLVe15T9b0wrPXZ7jYbyBTQ==
X-Received: by 2002:aa7:cb0f:0:b0:639:720d:72d with SMTP id 4fb4d7f45d1cf-63c1f6d5bc3mr2793191a12.29.1760721320098;
        Fri, 17 Oct 2025 10:15:20 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a928dasm203300a12.2.2025.10.17.10.15.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Oct 2025 10:15:19 -0700 (PDT)
Date: Fri, 17 Oct 2025 19:15:11 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device
 driver for config selection
Message-ID: <20251017191511.6dd841e9.michal.pecio@gmail.com>
In-Reply-To: <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
	<20251017024229.1959295-1-yicongsrfy@163.com>
	<db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 09:10:22 -0400, Alan Stern wrote:
> On Fri, Oct 17, 2025 at 10:42:29AM +0800, yicongsrfy@163.com wrote:
> > > > +	/* The vendor mode is not always config #1, so to find it out. */
> > > > +	c = udev->config;
> > > > +	num_configs = udev->descriptor.bNumConfigurations;
> > > > +	for (i = 0; i < num_configs; (i++, c++)) {
> > > > +		struct usb_interface_descriptor	*desc = NULL;
> > > > +
> > > > +		if (!c->desc.bNumInterfaces)
> > > > +			continue;
> > > > +		desc = &c->intf_cache[0]->altsetting->desc;
> > > > +		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC)
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	if (i == num_configs)
> > > > +		return -ENODEV;
> > > > +
> > > > +	return c->desc.bConfigurationValue;
> > > > +}  
> > >
> > > I wonder how many copies of this code would justify making it some
> > > sort of library in usbnet or usbcore?  
> > 
> > Yes, there are many similar code instances in the USB subsystem.
> > However, I'm primarily focused on the networking subsystem,
> > so my abstraction work here might not be thorough enough.
> > Hopefully, an experienced USB developer may can optimize this issue.  
> 
> Would it help to have a USB quirks flag that tells the core to prefer 
> configurations with a USB_CLASS_VENDOR_SPEC interface class when we 
> choose the device's configuration?  Or something similar to that (I'm 
> not sure exactly what you are looking for)?

Either that or just patch usb_choose_configuration() to prefer vendor
config *if* an interface driver is available. But not 100% sure if that
couldn't backfire, so maybe only if the driver asked for it, indeed.

I was looking into making a PoC of that (I have r8152 with two configs)
but there is a snag: r8152-cfgselector bails out if a vendor-specific
check indicates the chip isn't a supported HW revision.

So to to fully replicate r8152-cfgselector, core would neet to get new
"pre_probe" callback in the interface driver. It gets complicated.

A less complicated improvement could be moving the common part of all
cfgselectors into usbnet. Not sure if it's worth it yet for only two?

Regards,
Michal 

