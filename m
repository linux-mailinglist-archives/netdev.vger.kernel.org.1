Return-Path: <netdev+bounces-154701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADB79FF7EA
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E643A1A8E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857821917CD;
	Thu,  2 Jan 2025 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="BDHw4tXv"
X-Original-To: netdev@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4D125D6
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813314; cv=pass; b=Rr3VGNsQTCOM2SCW+ekkGVQRg5TElcmW7f+I1DSfr+/V+ibB1VY7SO8r295J6Rjrgbuyouc2xLzMAAiFUJir3Ftqq/C6+twfkt3DrnimsTdBRUMTTcaIoR/+LO8n2FqK0XoXAh8sv/wGlbykxOC66oBJCqrI8fqq8P4TJdcdT4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813314; c=relaxed/simple;
	bh=ddQggaBUrIoq2iXDgGAYv5PKccyzP4WT2pX+n0sFHdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUeCCCwRLwbnROdG4qKFRmx0C1wMn2btW9uhwc+DYMChjSuBuZvLXqxKTm09a+iWfE1yY+k3kk0L7taVfzDVDiBP/rBgYE8g+mm4SjPQjbxrBVy2/Su+LA99oMkEwuwn9wDaiTYCxMkj8RUOLvLUY0zQiXDj05pd3Qpcij2YQeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=BDHw4tXv; arc=pass smtp.client-ip=185.56.87.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=instance-europe-west4-jwcv.prod.antispam.mailspamprotection.com; s=arckey; t=1735813311;
	 b=EZadLLB1gUbAqb+WiuPeVebtfWDKx7jIaLbS30PFJq1uggwYuDvAoHj1Xs85lDFaPt51otzxf8
	  Jnr5SiLmUv9JiChXyQq+hX4pokm/ZSJv0FCCtdiqAoAd8pBVZePX6A4EkZr1mlMn3fFkFDhQkE
	  LejfESD+F7rKeC9dcrT5Nd8uOAaJPdQqv1P+yN9HLJVeTuMAdnAOmPUrUsX+NVZmT8VSZv1WTZ
	  7pBq5Nn/sry1FUtPxf+UC4BxIVZsxG6rYFvDUi+AaN98Idjrvi03EbYOw+ZcAwyOEXGmp5YFfg
	  LPwD5SpadRo4MTmzQchrOfjOnKLfCcUa/JYzO8rzWv55XQ==;
ARC-Authentication-Results: i=1; instance-europe-west4-jwcv.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=instance-europe-west4-jwcv.prod.antispam.mailspamprotection.com; s=arckey; t=1735813311;
	bh=ddQggaBUrIoq2iXDgGAYv5PKccyzP4WT2pX+n0sFHdY=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature;
	b=SCR8Yr6H0l0ZTbQfrhnQCM5g7R66EF5YmTte/DcbS5vx1oZ39yMdD7fe8nqNwjzNRSI65NpP2w
	  j+OG7X7B+GGKN1xNuZpsVcq96Bui02WHnI1O9aEhrMPmMMr1YKAsYNft3wymXOL5kFYdiLfdOP
	  PKNXBnoSdBZ3t7iLMZH6+ypArTazpAEEPooaSZtLZvkUqxYC6OLNO7qE+Sk1v4cyT5PV7z2Ufn
	  CbZ7R55gC1jwMHMdNtajVirUKStKzdvRbgVZFvNLWdlI02RpVUHIx1YjS9CCqhN5CCk/NeB7pC
	  emWvNiEN09GKQRXTbSChIqDphkL+TLXFr/Wgl8n51AGmSQ==;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-jwcv.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTIKj-00000003xaU-33nQ
	for netdev@vger.kernel.org;
	Thu, 02 Jan 2025 10:21:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=RWehvsqxatKsF85L2FEj68SM7Yahzg+1xC89M9swkoY=; b=BDHw4tXvdVUu50q/bxEy7LDGcP
	koqDuJuXrmQPrm7On5WUfpHGiodUmnkO9GuQ6SBTvA1zCxbn86ddJsfwD8nz7bDQtRKcLAyf1fbSA
	7jRQyAAHxsBuGmbHRJZev62lLoQ2VUIn3bqpjfg6fDj/EoJblA2xc119gVMY0RWr5Dgk=;
Received: from [87.11.41.26] (port=59993 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTIKe-00000000MPZ-2jRQ;
	Thu, 02 Jan 2025 10:21:36 +0000
From: Francesco Valla <francesco@valla.it>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Suman Ghosh <sumang@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>
Subject:
 Re: [EXTERNAL] [PATCH] net: phy: don't issue a module request if a driver is
 available
Date: Thu, 02 Jan 2025 11:21:36 +0100
Message-ID: <4771715.vXUDI8C0e8@fedora.fritz.box>
In-Reply-To:
 <SJ0PR18MB5216590A9FD664CF63993E95DB142@SJ0PR18MB5216.namprd18.prod.outlook.com>
References:
 <20250101235122.704012-1-francesco@valla.it>
 <SJ0PR18MB5216590A9FD664CF63993E95DB142@SJ0PR18MB5216.namprd18.prod.outlook.com>
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
X-SGantispam-id: 0f1ae3a7698d30643e14a2239f46a688
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
Authentication-Results: instance-europe-west4-jwcv.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Suman,

On Thursday, 2 January 2025 at 10:35:40 Suman Ghosh <sumang@marvell.com> wrote:
> > 	mutex_init(&dev->lock);
> > 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
> >
> >-	/* Request the appropriate module unconditionally; don't
> >-	 * bother trying to do so only if it isn't already loaded,
> >-	 * because that gets complicated. A hotplug event would have
> >-	 * done an unconditional modprobe anyway.
> >-	 * We don't do normal hotplug because it won't work for MDIO
> >+	/* We don't do normal hotplug because it won't work for MDIO
> > 	 * -- because it relies on the device staying around for long
> > 	 * enough for the driver to get loaded. With MDIO, the NIC
> > 	 * driver will get bored and give up as soon as it finds that @@ -
> >724,7 +745,8 @@ struct phy_device *phy_device_create(struct mii_bus
> >*bus, int addr, u32 phy_id,
> > 		int i;
> >
> > 		for (i = 1; i < num_ids; i++) {
> >-			if (c45_ids->device_ids[i] == 0xffffffff)
> >+			if (c45_ids->device_ids[i] == 0xffffffff ||
> >+			    phy_driver_exists(c45_ids->device_ids[i]))
> > 				continue;
> >
> > 			ret = phy_request_driver_module(dev, @@ -732,7 +754,7 @@
> >struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32
> >phy_id,
> > 			if (ret)
> > 				break;
> > 		}
> >-	} else {
> >+	} else if (!phy_driver_exists(phy_id)) {
> [Suman] Can we add this phy_driver_exists() API call before the if/else check?
> 

Not really, as in case of C45 PHYs we have to check for drivers using (multiple)
IDs, which are different from phy_id.

> > 		ret = phy_request_driver_module(dev, phy_id);
> > 	}
> >
> 


Thank you!

Regards,
Francesco





