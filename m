Return-Path: <netdev+bounces-154732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA029FF9D3
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4600C160B21
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C729418BBAC;
	Thu,  2 Jan 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="R8RW09Mv"
X-Original-To: netdev@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D86FB0
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824445; cv=pass; b=G9wu/SoEJMLRk8KLmDAaAJaOO5JhVdr8jkgF+HuyqOQzo73TjNavBm8GSlp5CWnZv8DKxNPixrhnqhsaCUJdwsBC8xmcWaw36QbXSXUwpgqHDO1AVQDAZIn7uuudM+lYt1gstUFBpAK+t+6znkdRq/D0tKam2Gcm9mlP/6wqHMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824445; c=relaxed/simple;
	bh=ZS2MY7fKCiUz+ujIqEudKkwegQhFKxAfag+BVnhm56c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxJUW0e4Tf5VqzPeAIq3M+71n/mLWUZW/aPSeqsUBj6khhkFY8NZ4r7sMjtaNWBmzMJLDvh6fV1jMAkj0a9WSVxX2sIYPWZucqIGm5JDGaB1o9MRbiTDRtMYhUHf89mAAEidN30Z4tXT9CxFjxFOyi3W1Ay96oi2JnS6TjfJ66s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=R8RW09Mv; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=instance-europe-west4-qlfc.prod.antispam.mailspamprotection.com; s=arckey; t=1735824443;
	 b=cR46KQuHumc6uI32Bs6SkuXS/fXHlSD9+f09RFBiYvh8vm5KK/4pMc1IsunmKUxAXmJoARyNMo
	  v4u4EWEVMyguYDtW0tZHZZha0zOD74Syc29uIkCfRtlXQtKQJSDYTRO7mnoajaAPDdmT46/JaE
	  kZD1J7cFW/hoy50+QdPL98ZW13vZe9+dACjJic5e0zpKI3qxrQf4smEDp1faQpTyAgL48TmsF5
	  NammwAxOd5YMsqs4CNun/x9Mq3Ng2Ws3GuxNTUhMKcq+tEp57n3q5/tt0q7EDCn6YJmehNDwSr
	  xx5lYJPxpq0Og7gQfmaW+KSThnOF5uQVh/qzlZpL+z1kLQ==;
ARC-Authentication-Results: i=1; instance-europe-west4-qlfc.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=instance-europe-west4-qlfc.prod.antispam.mailspamprotection.com; s=arckey; t=1735824443;
	bh=ZS2MY7fKCiUz+ujIqEudKkwegQhFKxAfag+BVnhm56c=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature;
	b=PiqA0VHGXPYdeDeW07TfuCMrk2e2VPIY5076gTrwP02FUShad/Wdux9/VhKWxGqNlrVgRxxzEg
	  2sEchLDhCfhDL8XiWMlwBVyk35+FU2SWm9Qqd1/j7ELC32f2uK+7lQbDRlrxHjwcjgRxXabA1C
	  y43/ybvF+eX13IuvvUyV/xNmqNCOYso6GXSRJdmPoYA6X/7Qjkt9VQkdqeCXXakC4oUTsTvOBY
	  D8sciJaNZhO75glvUZJuko85U7pZFtNYdHpL8r+5Q5x47+n7KDdffVt2zISSCNLcOUSJq6xTKq
	  PlOsKpsMTVpR3SOVuhCArCFNiCvseIPrBK3YPnkV01taRA==;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-qlfc.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTLE7-0000000A62f-2Ol6
	for netdev@vger.kernel.org;
	Thu, 02 Jan 2025 13:27:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=mu/CtyZr2r4pEqSHivgarAfDwgsXwCSqZ1S21pjfXCk=; b=R8RW09Mv1KZJzFDPCp9JcpZOYD
	VlxAUJTvDixWKlExmPZ+8DMY2lWPBx62W77hUHeiLS8DKIHp+ueU/RPL9TDiqGf1Na8WJlKShXhGZ
	Z/Qpwqx5WAwnVLT6+kCP2rdxKWLpejwE1ZFQb+EtHpIoiJLdlBaJCMJYLyJo6v6CvnfI=;
Received: from [87.11.41.26] (port=65119 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tTLE2-00000000Q0U-3zdm;
	Thu, 02 Jan 2025 13:26:58 +0000
From: Francesco Valla <francesco@valla.it>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Subject:
 Re: [PATCH] net: phy: don't issue a module request if a driver is available
Date: Thu, 02 Jan 2025 14:26:58 +0100
Message-ID: <7103704.9J7NaK4W3v@fedora.fritz.box>
In-Reply-To: <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
References:
 <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
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
X-SGantispam-id: 88c5060f014e8872c6bb2ef493324eee
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
Authentication-Results: instance-europe-west4-qlfc.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Thursday, 2 January 2025 at 12:06:15 Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> On Thu, Jan 02, 2025 at 12:51:22AM +0100, Francesco Valla wrote:
> > Whenever a new PHY device is created, request_module() is called
> > unconditionally, without checking if a driver for the new PHY is already
> > available (either built-in or from a previous probe). This conflicts
> > with async probing of the underlying MDIO bus and always throws a
> > warning (because if a driver is loaded it _might_ cause a deadlock, if
> > in turn it calls async_synchronize_full()).
> 
> Why aren't any of the phylib maintainers seeing this warning? Where does
> the warning come from?
> 

I'm not sure. For me, it was pretty easy to trigger. I'm on a BeaglePlay (AM62X)
and I am working on boot time optimization and with different configurations for
async probing. When the async probe of the Ethernet NIC (i.e.: am65-cpsw-nuss)
runs, it in turn triggers the probe of the associated davincio_mdio device,
which then brings me to the following WARNING:

[    0.287271] davinci_mdio 8000f00.mdio: davinci mdio revision 9.7, bus freq 1000000
[    0.287574] ------------[ cut here ]------------
[    0.287581] WARNING: CPU: 2 PID: 48 at /kernel/module/kmod.c:144 __request_module+0x19c/0x204
[    0.287605] Modules linked in:
[    0.287619] CPU: 2 UID: 0 PID: 48 Comm: kworker/u16:2 Not tainted 6.12.4-00004-g89f77a9313d4-dirty #1
[    0.287630] Hardware name: BeagleBoard.org BeaglePlay (DT)
[    0.287637] Workqueue: async async_run_entry_fn
[    0.287653] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.287663] pc : __request_module+0x19c/0x204
[    0.287671] lr : __request_module+0x198/0x204
[    0.287679] sp : ffff8000817b2e70
[    0.287684] x29: ffff8000817b2ef0 x28: ffff000001b994b0 x27: 0000000000000000
[    0.287698] x26: 0000000000000000 x25: ffff8000817b3277 x24: 0000000000000000
[    0.287712] x23: ffff000001b99000 x22: 0000000000000000 x21: ffff0000038a8800
[    0.287726] x20: 0000000000000001 x19: ffff800080d4dc18 x18: 0000000000000002
[    0.287739] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    0.287753] x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000001
[    0.287767] x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000000
[    0.287780] x8 : ffff8000817b2ee8 x7 : 0000000000000000 x6 : 0000000000000000
[    0.287794] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000030
[    0.287806] x2 : 0000000000000008 x1 : ffff8000800c66dc x0 : 0000000000000001
[    0.287820] Call trace:
[    0.287821] omap_i2c 20000000.i2c: bus 0 rev0.12 at 400 kHz
[    0.287826]  __request_module+0x19c/0x204
[    0.287835]  phy_request_driver_module+0x11c/0x17c
[    0.287849]  phy_device_create+0x234/0x260
[    0.287860]  get_phy_device+0x78/0x154
[    0.287870]  fwnode_mdiobus_register_phy+0x11c/0x1d8
[    0.287880]  __of_mdiobus_parse_phys+0x174/0x2a0
[    0.287890]  __of_mdiobus_register+0x104/0x240
[    0.287899]  davinci_mdio_probe+0x284/0x44c
[    0.287909]  platform_probe+0x68/0xc4
[    0.287921]  really_probe+0xbc/0x29c
[    0.287930]  really_probe_debug+0x88/0x110
[    0.287940]  __driver_probe_device+0xbc/0xd4
[    0.287948]  driver_probe_device+0xd8/0x15c
[    0.287957]  __device_attach_driver+0xb8/0x134
[    0.287965]  bus_for_each_drv+0x88/0xe8
[    0.287974]  __device_attach+0xa0/0x190
[    0.287982]  device_initial_probe+0x14/0x20
[    0.287991]  bus_probe_device+0xac/0xb0
[    0.287998]  device_add+0x588/0x74c
[    0.288011]  of_device_add+0x44/0x60
[    0.288027]  of_platform_device_create_pdata+0x8c/0x120
[    0.288039]  of_platform_device_create+0x18/0x24
[    0.288050]  am65_cpsw_nuss_probe+0x670/0xcf4
[    0.288062]  platform_probe+0x68/0xc4
[    0.288072]  really_probe+0xbc/0x29c
[    0.288079]  really_probe_debug+0x88/0x110
[    0.288088]  __driver_probe_device+0xbc/0xd4
[    0.288096]  driver_probe_device+0xd8/0x15c
[    0.288105]  __driver_attach_async_helper+0x4c/0xb4
[    0.288113]  async_run_entry_fn+0x34/0xe0
[    0.288124]  process_one_work+0x148/0x288
[    0.288137]  worker_thread+0x2cc/0x3d4
[    0.288147]  kthread+0x110/0x114
[    0.288159]  ret_from_fork+0x10/0x20
[    0.288171] ---[ end trace 0000000000000000 ]---

This is expected, as request_module() is not meant to be called from an async
context:

https://lore.kernel.org/lkml/20130118221227.GG24579@htj.dyndns.org/

It should be noted that:
 - the davincio_mdio device is a child of the am65-cpsw-nuss device
 - the am65-cpsw-nuss driver is NOT marked with neither PROBE_PREFER_ASYNCHRONOUS
   nor PROBE_FORCE_SYNCHRONOUS and the behavior is being triggered specifying
   driver_async_probe=am65-cpsw-nuss on the command line.

> > +static bool phy_driver_exists(u32 phy_id)
> > +{
> > +	bool found = false;
> > +	struct phy_drv_node *node;
> > +
> > +	down_read(&phy_drv_list_sem);
> > +	list_for_each_entry(node, &phy_drv_list, list) {
> > +		if (phy_id_compare(phy_id, node->drv->phy_id, node->drv->phy_id_mask)) {
> > +			found = true;
> > +			break;
> > +		}
> > +	}
> > +	up_read(&phy_drv_list_sem);
> > +
> > +	return found;
> > +}
> > +
> 
> Why do we need this, along with the associated additional memory
> allocations? What's wrong with bus_for_each_drv() which the core
> code provides?
> 
> 

Because I didn't think of it, but it would be much better. I'll refactor the
logic using bus_for_each_drv() + a simple match callback.

Thank you!

Regards,
Francesco




