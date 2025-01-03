Return-Path: <netdev+bounces-155050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48907A00D47
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D87518842AF
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456C11B87FA;
	Fri,  3 Jan 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="YLgZLsuP"
X-Original-To: netdev@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45EC11CA0
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927056; cv=pass; b=sj3tbK8b2xSYKbUFYOByYMY5yNiVsYlNe/jqaC8kxKsvRznclDA9WK9FE72AdMBiz7WKwLdAHB/wyIy0N+/MKN3JOvMWyziUOI34+uRcE/1+ac+ny29q7Ddp+1Vmm6Bbw4IhSz1++jpFe1lJUIMzrb7UjienT+vY4Yq7lYDjdaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927056; c=relaxed/simple;
	bh=aOoYUPlGTAFYWxeNQioGTQWqTo+tCqxqJNRACoo5e7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkj0m4nW9bPi6O0358YOJNcptUSoz/SOUoZBy8pintBwVmUUBZAaR1/f0UvHikuRbU97p+nJghxyKFHPBH8uXbkfpx8QgoLXw2PV47iu2EfaqZ/hzXn3oCEpHmd+yae2ZhTC3gj48YNl6xnbWVsQE97uIf/OVA0mOLtCg/PeZJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=YLgZLsuP; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com; s=arckey; t=1735927053;
	 b=BVJIMwmJf4OCOTYb5anfVk526POeXrV+JLI+Gz2ekv4U/vbHWOD8znsnELf/a7BP7BsF/ICX9y
	  WzcTnIXDbG8LOJPc24zMKi+2ZpFejo9Bt4TRVib9KL9MMjunGi8Wd6ksU86LrjMydiJY6upnI1
	  fKokzvCQV9ykG2RMgnqHDKzI6+jTwC1LGEjYeKLA1eVIk0bB7+wZYm3wZy431aEuARDx3/gzD7
	  hb2ooDVA9P/cvLC8RKOYXos4GgD9PrKVHnSxHRuQ05j0KZXPRlOLTL4TRu5zRCD3m0Kgn52MVv
	  jJ+9Rkk+Yke3og8iQIj0FFuqwU2vZWNa90U/bKnAzNoG5Q==;
ARC-Authentication-Results: i=1; instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com; s=arckey; t=1735927053;
	bh=aOoYUPlGTAFYWxeNQioGTQWqTo+tCqxqJNRACoo5e7w=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature;
	b=oN4dOpAkLgEGz8GU2R5Lt2CbmZKx4T3S2KjHVnL8pa/aZy8Hs+6ODjxR/spIDKrEou9TsKPA5W
	  sHjmki9JcxgcOMImFlbRUiX/XEmAMel0NCmn1DmAkCCW4Pn/PF1fQGo8qkodBG9FDWWjIMbb1I
	  y+FyfIWQ2sVV43Xaq2rn3UE3/RwhVare6Abd6yOfFOy7rMrp4W3NcOSQWzuI9BkoXhW95/Huvf
	  nWvtV9ygnjG3tAKTbBG9ZWXIYf4jouMZBy/m5ZXruPPmDHVGKESScyvxdlAH3/9NLTnSgKUspg
	  uYyy44lfGfCpvF+KbXuLA0/V3s3jteNfjeYHIg0R/Zq+OA==;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTlvN-00000009ZlB-3TS8
	for netdev@vger.kernel.org;
	Fri, 03 Jan 2025 17:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=qUlQTvGb13hpIrv5eAf4vGWYhIu/WLh30z8E5A2M5LI=; b=YLgZLsuPJ+FvD36s9KTLX2567k
	1ZbV4HwNjzk0CiM7i6stI0UPrGPU4XJQbQY9AgYCa4xT5D7KDUb/CUYMc2rQqu3QP/ytl9lr76/Uy
	C40slVIofVERb5mELPezGdvRmQ9/JcVRhwlVnT9eYIA3TjL5NizZ+mxhQsxogxyH3s0Y=;
Received: from [87.11.41.26] (port=59478 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTlvC-00000000LS6-1o60;
	Fri, 03 Jan 2025 17:57:18 +0000
From: Francesco Valla <francesco@valla.it>
To: Niklas Cassel <cassel@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Saravana Kannan <saravanak@google.com>
Subject:
 Re: [PATCH] net: phy: don't issue a module request if a driver is available
Date: Fri, 03 Jan 2025 18:57:17 +0100
Message-ID: <2193347.yiUUSuA9gR@fedora.fritz.box>
In-Reply-To: <1898857d-d580-4fa5-8f19-6e91114975a1@lunn.ch>
References:
 <20250101235122.704012-1-francesco@valla.it> <Z3f1coRBcuKd1Eao@ryzen>
 <1898857d-d580-4fa5-8f19-6e91114975a1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 64ae13b17b317fc0b499193578058609
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
Authentication-Results: instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi,

On Friday, 3 January 2025 at 16:37:33 Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Jan 03, 2025 at 03:34:26PM +0100, Niklas Cassel wrote:
> > On Fri, Jan 03, 2025 at 03:12:14PM +0100, Andrew Lunn wrote:
> > > > FWIW, the patch in $subject does make the splat go away for me.
> > > > (I have the PHY driver built as built-in).
> > > > 
> > > > The patch in $subject does "Add a list of registered drivers and check
> > > > if one is already available before resorting to call request_module();
> > > > in this way, if the PHY driver is already there, the MDIO bus can perform
> > > > the async probe."
> > > 
> > > Lets take a step backwards.
> > > 
> > > How in general should module loading work with async probe? Lets
> > > understand that first.
> > > 
> > > Then we can think about what is special about PHYs, and how we can fit
> > > into the existing framework.
> > 
> > I agree that it might be a good idea, if possible, for request_module()
> > itself to see if the requested module is already registered, and then do
> > nothing.
> > 
> > Adding Luis (modules maintainer) to CC.
> > 
> > Luis, phylib calls request_module() unconditionally, regardless if there
> > is a driver registered already (phy driver built as built-in).
> > 
> > This causes the splat described here to be printed:
> > https://lore.kernel.org/netdev/7103704.9J7NaK4W3v@fedora.fritz.box/T/#u
> > 
> > But as far as I can tell, this is a false positive, since the call cannot
> > possibly load any module (since the driver is built as built-in and not
> > as a module).
> 
> Please be careful here. Just because it is built in for your build
> does not mean it is built in for everybody. The code needs to be able
> to load the module if it is not built in.
> 

I fully agree here - moreover, the same WARN would be triggered if async probe
is used for a NIC driver which is built as a module, with PHY drivers
themselves being modules.

> Also, i've seen broken builds where the driver is both built in and
> exists as a module. User space will try to load the module, and the
> linker will then complain about duplicate symbols and the load fails.
> So it is not a false positive. There is also the question of what
> exactly causes the deadlock. Is simply calling user space to load a
> module which does not exist sufficient to cause the deadlock? That is
> what is happening in your system, with built in modules.
> 

The deadlock (which I did NOT observed) would be caused by a module init
function calling async_synchronize_full(); quoting from __request_module():

    /*
     * We don't allow synchronous module loading from async.  Module
     * init may invoke async_synchronize_full() which will end up
     * waiting for this task which already is waiting for the module
     * loading to complete, leading to a deadlock.
     */
    WARN_ON_ONCE(wait && current_is_async());

The deadlock was observed way back and the code above was added in 2013 [1];
some more work has been done during the years [2].

> Also, the kernel probably has no idea if the module has already been
> loaded nor not when request_module() is called. What we pass to the
> request_module() is not the name of the module, but a string which
> represents one of the IDs the PHY has. It is then userspace that maps
> that string to a kernel module via modules.alias. And there is a many
> to one mapping, many IDs map to one module. So it could be the module
> has already been loaded due to some other string.
> 
> So, back to my original question. How should module loading work with
> async probe?
>

Today it is not meant to work [1]; that was mainly the reason for my
original patch. Maybe the best solution would be to work on that.


[1] https://lore.kernel.org/all/20130118221227.GG24579@htj.dyndns.org/
[2] https://lore.kernel.org/lkml/YfsruBT19o3j0KD2@bombadil.infradead.org/T/#m4a8579a9e9a2508bea66223906e1917e164e6c70


Thank you!


Regards,
Francesco




