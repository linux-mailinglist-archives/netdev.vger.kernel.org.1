Return-Path: <netdev+bounces-154736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E674A9FFA08
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE386162B5B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A919DF98;
	Thu,  2 Jan 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="edTKaS5A"
X-Original-To: netdev@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933B5C96
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826526; cv=pass; b=aw2TbI1jaeHjHPLeoCY9jfgnzZXUtKaD4aAFDrAfJifp2mFkH92w61OnAT62A4KDTRF9ztmi9vEEkDTBPGRaK5sSeuMU1WcZuc7V+orp8Ma7CivGfTUQZx01fY9SRg47XRL4KNUIxn4xUb+SaDpSnnHJAViY74GSGp5Mgk/i9Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826526; c=relaxed/simple;
	bh=6TzWf0IPAqJ/jL2phYforE19i1L/G5VtaXCq9UJ+d1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qt59zhuDlDShMpQvITs+KZPtVdweujvaSk/aCcqMWXweXC3d7bws0QdRCkox7epH/F9aymQCxPJMjfm8qfW7H7Ot+D7p+I73AxY9UGeVMF9qroiUf8UxUPqQZYVEfOENlCUaRt+kNhsi4IsuwmDEzjjbX1bZCIp/tSUg8JfB6L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=edTKaS5A; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=instance-europe-west4-nn1m.prod.antispam.mailspamprotection.com; s=arckey; t=1735826524;
	 b=IdSv7anOr7vZ2E719uSqTLzILVyVfsfNzr5mvbm3uuusTzw8jl5NVcNsG76U40wypSV2FRKYAE
	  VcKKKEe43K3XLMkhpzYzrF7ywoAvUmKK8DV2O5qy64PKZgPm69+SXjDMcAk6o6ufNi0AlzLloV
	  0KEQi+mY6t86fLV0UZxLnJHVTCzPcTKBNrlPdwpEqW/vSV50zd6zucHg1LlE9Y1t4S25pStnfV
	  cly0ERWeTawibwCB5IDy033dusSU3opbghDTpzKDaKl7qScWLBoaz6zqdOFyXRviknE584m62p
	  vfG+7JoGunmJ9ytKhKOI8XfPuMMwlt1QedihYPsV4QvIiA==;
ARC-Authentication-Results: i=1; instance-europe-west4-nn1m.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=instance-europe-west4-nn1m.prod.antispam.mailspamprotection.com; s=arckey; t=1735826524;
	bh=6TzWf0IPAqJ/jL2phYforE19i1L/G5VtaXCq9UJ+d1M=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature;
	b=dr/Uys8HsDGaVU/Gi5QKZb1HGV18gP017rfeKfxjKBce9j60gE6gaYnRK1E93hhftGGAQP2eXf
	  OAHAQG3Z9CHZCDBkogD0I06vW5rl4S9MdGRPRgzZXUCLV7uFoVAghLa9/apvBkIsgSOzdQcEij
	  haO99s5qhQikvI6epc+4Yvy6L6QKUj/V4DpGj5ZVNbhw2NFpYyPUBgguqwgTSio2f85ti+upV4
	  xesB5vVMC8WJZwKErlX4b5kQBUYKpRBKIx1FzzRSwzxaSlobS9QJrMLJfZ82FoiEeVUWsXkvpi
	  QjROJu2K5AeveFi/CNKyh5f5lnVA8DH5nRKvG/hcKaysEA==;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-nn1m.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTLlr-00000004qcs-00vQ
	for netdev@vger.kernel.org;
	Thu, 02 Jan 2025 14:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=j0OxDToB23CE1UFsAy0gpB4ihfqOHrSthAxi6km8w94=; b=edTKaS5AMGRS6xVcd0NAgCHLlg
	RI0kqbfddPHlIGB852a/iZfI42wd+UnTOyWWTPxhFS+gK6UQEJyX9lcmzp/83N4G1fuI9LPev8xhZ
	MfusjnmRlsr18JGAcPFnB+nIpsQjKtT8B6O1dkFiBfNNPSw6CPuDAyPPQPiYzNmqNQmo=;
Received: from [87.11.41.26] (port=63792 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTLlj-00000000Cnz-1RRR;
	Thu, 02 Jan 2025 14:01:47 +0000
From: Francesco Valla <francesco@valla.it>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH] net: phy: don't issue a module request if a driver is available
Date: Thu, 02 Jan 2025 15:01:46 +0100
Message-ID: <2105036.YKUYFuaPT4@fedora.fritz.box>
In-Reply-To: <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
References:
 <20250101235122.704012-1-francesco@valla.it>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
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
X-SGantispam-id: 4d900415f9cc01d252c838f609b71879
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
Authentication-Results: instance-europe-west4-nn1m.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Thursday, 2 January 2025 at 14:52:18 Andrew Lunn <andrew@lunn.ch> wrote:
> On Thu, Jan 02, 2025 at 02:26:58PM +0100, Francesco Valla wrote:
> > On Thursday, 2 January 2025 at 12:06:15 Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> > > On Thu, Jan 02, 2025 at 12:51:22AM +0100, Francesco Valla wrote:
> > > > Whenever a new PHY device is created, request_module() is called
> > > > unconditionally, without checking if a driver for the new PHY is already
> > > > available (either built-in or from a previous probe). This conflicts
> > > > with async probing of the underlying MDIO bus and always throws a
> > > > warning (because if a driver is loaded it _might_ cause a deadlock, if
> > > > in turn it calls async_synchronize_full()).
> > > 
> > > Why aren't any of the phylib maintainers seeing this warning? Where does
> > > the warning come from?
> > > 
> > 
> > I'm not sure. For me, it was pretty easy to trigger.
> 
> Please include the information how you triggered it into the commit
> message.
> 

Ok, will do.

> > This is expected, as request_module() is not meant to be called from an async
> > context:
> > 
> > https://lore.kernel.org/lkml/20130118221227.GG24579@htj.dyndns.org/
> > 
> > It should be noted that:
> >  - the davincio_mdio device is a child of the am65-cpsw-nuss device
> >  - the am65-cpsw-nuss driver is NOT marked with neither PROBE_PREFER_ASYNCHRONOUS
> >    nor PROBE_FORCE_SYNCHRONOUS and the behavior is being triggered specifying
> >    driver_async_probe=am65-cpsw-nuss on the command line.
> 
> So the phylib core is currently async probe incompatible. The whole
> module loading story is a bit shaky in phylib, so we need to be very
> careful with any changes, or you are going to break stuff, in
> interesting ways, with it first appearing to work, because the
> fallback genphy is used rather than the specific PHY driver, but then
> breaking when genphy is not sufficient.
> 
> Please think about this as a generic problem with async probe. Is this
> really specific to phylib? Should some or all of the solution to the
> problem be moved into the driver core? Could we maybe first try an
> async probe using the existing drivers, and then fall back to a sync
> probe which can load additional drivers?

It probably isn't, but considering the way phylib works currently (with the
genphy filling up for missing drivers etc.) I'm not sure if/how this can work.
I need to think about it.

> 
> One other question, how much speadup do you get with async probe of
> PHYs? Is it really worth the effort?

For me it's a reduction of ~170ms, which currently accounts for roughly the 25%
of the time spent before starting userspace (660ms vs 490ms, give or take a
couple of milliseconds). That's due to the large reset time required by the PHYs
to initialize, so I expect it would be much lower on most of the systems.
But, I've done much more to shave much less time in the past, so I think it is
at least worth investigating.

Thank you!

Regards,
Francesco

> 
> 	Andrew
> 





