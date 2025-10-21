Return-Path: <netdev+bounces-231339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AABF7A5B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 597F4354847
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D0B3491E0;
	Tue, 21 Oct 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fAvmGZ4T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483A3491D4
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063985; cv=none; b=B9WCFKgYj1Spk6jrNXNZMeP3PXVz2TWmfJea38JrsrdS9+qklaYU2YfC5So5/ik6RmKNpRzWSyyUiqVj8f4tewpycr+73mv8X2KrJ4SmPRMoJhEmIrBfBh97/iPexPM3YXSbljckDJwPuwYLBICED+JopO/A08TnaiBVAtOMlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063985; c=relaxed/simple;
	bh=CuQeZe4Y5bn9FzHbLB46TKbarzG3ntEyBt3DxwbZKqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp4ULrlLsLxqd71r10uvZB73oha4swYLAfrQxiMTXta6Xr1aK4pOJ3s7dTT+lcIHXLdKDNusm9hNJfevaMFuKu7R8Sn9BwWkJT5Vtbs6DAcf4lEPZqxbofg95ww1BfnPPpZPePEjqDg1BhNRfOFZHnugjNbytNpSGAHvwPGsBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fAvmGZ4T; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e88cd19bc5so1308651cf.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761063982; x=1761668782; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBIEUW1Ijn6qLPXihQhrTNnQ7Cp+uMufdF3SJ+N/9tw=;
        b=fAvmGZ4TClMRZ9T7NyftoGiXfKXDAS6PVmP/+mpLloPvrVPQL1+w7tEjSTtFcldxmJ
         /aL/QZ9juGa/WmJ8FJ5ivvzQL2IFhorCjWpe2uoSFuOjoEtEc9vIBAU/9zJEyQHg5fVv
         GIpS+xbHWX0CX1SdQ/uD19hG03viQAihcGcuTX4Ho/0vA88Kdo0jvqfxU00KlG1DwgBK
         9ABVl98Ckt1LwktLfceJT0zeVWijZbu19rwdamhAPqTkVwB21han01Ih0U6nviqn8vOH
         iqEF0rgEwOHHk31ww9wFtyy1DdawU75VTQi5+BxQYpjoH6/3rqmdos8LArlzeYIm4uib
         W65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063982; x=1761668782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBIEUW1Ijn6qLPXihQhrTNnQ7Cp+uMufdF3SJ+N/9tw=;
        b=mh823Q/fObJkKobmpNpBpLMluYa0cboujHF1yLYwHcof4bA0D2iY7ephvJVj0gWeLN
         B2Oabk1nkihHmDJyPPoFLtr7yBnB3tdJqkxi42atQGXd96jnspAJ/P6ChEwLB7iLHMUE
         kCcLtijesAAkTF4r+JodJ0vPbWb3R6kpYYvLpGAdjFxAb8iPv/9JJEx8ANRpJk//k9I6
         bvo+QiwN5vELsOGVbQnAS90UgQLNzmPm437a5SkiUY7DIq/5v/LtCpKUD/2F24vKcMcM
         oJT0Xz3sTxBdf1ohzwTLRiXMiwvK5r4jxCDKFji10onvOMOEN2Dd9spjv4J4XsxunSaV
         92oA==
X-Forwarded-Encrypted: i=1; AJvYcCXIrpluQIzqICjMLmHMlTqXAdYE08GEp8qhH8HtAy6QCcFmSVHF0mIkc9Ud9NTwEmdty+iaaaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UYXDyZIv01N5M/UUt6Rfif8nk+1cVD0qnyIQUXkPSIkWtb2X
	1Dd+dVLb8aMpjkDw/QK8Ws2+N8g7nJxCcuf/ZQ4w7yktuMbyeobJ4KPfAibTVHVsng==
X-Gm-Gg: ASbGncv+oZBjnKQceAXNjzRrunVGqYOZLaTAxbemR4QkVT9rPrexqX3PRd2Q7egwgcx
	XHnPiwbG59kYhe1SUY5X4K0GvOemhRukn6iZZqJUjgn8yV1D0f86je6KX+IO3jh5dxJA/ju6YwL
	kLSY2vu5Pz2YLoGyRRl6WqqPBEMZn/p7npdcVRsFZeoebd9lRyTIZ2vDpDdngZzsDIVEdQsnD6t
	lw3+FarscdU5NhKwLTdfvnhKs7+SHXrrJhTgrfPmMdisl8/mRHV5SLlY7nNWQ0VzQl+ww0+rw6Q
	QPskcJBuembEQ4GMSP0koT5c0/f7zzJ38izc6QdeKumll3crMwszYl/THnQlDX2mJAjmjGucul1
	bq11Fp1kBVRzYcVIf380ObFCseQdwePvvaxRp/ieMnAVrplvclqyCrLlCm7XRqsWrzoZuUJRBXF
	Q+4A==
X-Google-Smtp-Source: AGHT+IHA/MSFpgq5NDyGr8WrflLyOACBFE86QRu/uhfrAdUbUBGXWHWfTlUHBZGHXFWlLPjyOYFF1w==
X-Received: by 2002:ac8:7d94:0:b0:4e8:b979:c7c8 with SMTP id d75a77b69052e-4e8b979cc1bmr117233881cf.28.1761063982457;
        Tue, 21 Oct 2025 09:26:22 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::ba76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf5235863sm70942586d6.29.2025.10.21.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:26:22 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:26:19 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Yi Cong <yicongsrfy@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-usb@vger.kernel.org, michal.pecio@gmail.com,
	netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <3fe0a4f7-ba9a-4eb2-9df9-0273584ebbc3@rowland.harvard.edu>
References: <7353775a-bc2c-4c2d-93bc-b8d3e03c3496@rowland.harvard.edu>
 <20251021062629.2919772-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021062629.2919772-1-yicongsrfy@163.com>

On Tue, Oct 21, 2025 at 02:26:29PM +0800, Yi Cong wrote:
> On Mon, 20 Oct 2025 22:59:36 -0400, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Oct 21, 2025 at 10:29:25AM +0800, Yi Cong wrote:
> > > On Mon, 20 Oct 2025 11:56:50 -0400, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > Instead of all this preferred() stuff, why not have the ax88179 driver's
> > > > probe routine check for a different configuration with a vendor-specific
> > > > interface?  If that other config is present and the chip is the right
> > > > type then you can call usb_driver_set_configuration() -- this is exactly
> > > > what it's meant for.
> > >
> > > I tried calling usb_driver_set_configuration inside driver's probe()
> > > to select the configuration, but my USB network card has three
> > > configurations (bNumConfigurations=3), which causes usb_driver_set_configuration
> > > to be called twice within probe():
> > > ```
> > > static int ax88179_probe()
> > > {
> > >         if (bConfigurationValue != I_WANT) {
> > >                 usb_driver_set_configuration(udev, I_WANT)
> > >                 return -ENODEV;
> > >         }
> > >         //else really probe
> > > }
> > > ```
> >
> > Why is it called twice?  The first time probe() runs, it calls
> > usb_driver_set_configuration() with the config that you want.  Then the
> > second time probe() runs, the config you want has been installed, so
> > there's no reason to call usb_driver_set_configuration() again.
> >
> > Unless something is going wrong, that's how it should work.  And the
> > total number of configurations should not matter.
> 
> It might not be caused by the number of configurations, but rather by
> the fact that usb_driver_set_configuration handles configuration changes
> through a work queue.

I don't see why using a work queue should make any difference.  If you 
really want to find out what's going on, you could add a dump_stack() 
call to the probe routine.  And maybe a printk at the point where it 
calls usb_driver_set_configuration().

Alan Stern

> I suspect this is the reason (although I haven't verified it further
> —I just observed this behavior and switched to a different implementation
> by using choose_configuration):
> ```
> int usb_driver_set_configuration(struct usb_device *udev, int config)
> {
> ...
> 	INIT_WORK(&req->work, driver_set_config_work);
> 	schedule_work(&req->work);
> 	return 0;
> }
> ```

