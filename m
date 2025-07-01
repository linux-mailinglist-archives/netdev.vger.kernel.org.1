Return-Path: <netdev+bounces-202749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC1AEED37
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6C3AB769
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8681F4188;
	Tue,  1 Jul 2025 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ICzDGa0Y"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FF1F239B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751343552; cv=none; b=mz3kdD0rCgKk8B2SoT7yMaQX4KxzFCEG6CNdiFp8f1j71FlL5vGgqzC8H1PD5ExdqErChbsMVZmOTrdlQR+Oj1wfCGHcRrd+8HORuOXRDtT6VboIV07v//NWFGEpfj2I8PDSHoM3RegLKDi5V9sCqYrHg964ZQbg4rvNEvvn7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751343552; c=relaxed/simple;
	bh=O97jXsQ3LXss1Hf1Wk/BaNtoM1HDPTGoTQFSxBBOj5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=CFnf5hjH6OyK/GdzIkKlWB6VeEzmq4+cDkYyRDLL39mNBAVcz/ELkGcwh041UhtkgXToLOPcUkkOpSlqGdxFr6Uh95RuMaIQUvPWcewRbhhhbMeAALjSn82RNwMGQ/Yg2cS/M6+CaSLUjI4IxxdmoHwWjFsmvFvBcYVg/Cc4OcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ICzDGa0Y; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250701041906epoutp04ea4398c07382665fe35fbe1eac0e6ed2~OBa1Ns0Wl2576525765epoutp04k
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 04:19:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250701041906epoutp04ea4398c07382665fe35fbe1eac0e6ed2~OBa1Ns0Wl2576525765epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751343547;
	bh=7gJBhY1hVleBBYsivSqZ/JL+GmeRtwkguYJw1y3Py30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ICzDGa0Yhe9eFpk5r4xx1pvsvYxmA+e5n9gQNbHlHAT1HofyRAA/oXYEOk1EWHfCa
	 wzCsar8q4dfQc2b5RzHODNtkhyHhPDscaOAzhS2zdfZv8cvs6Z/qw2CSeTCk5gjvvS
	 YUFfDqMxFpe9pCttcSgp4y59QpzILIMfBPhkvBzY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20250701041906epcas1p4dd5f93364a7ed512e81c218aa5432673~OBa0yRoDQ1324313243epcas1p4q;
	Tue,  1 Jul 2025 04:19:06 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.240]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bWVCZ0LKFz3hhT9; Tue,  1 Jul
	2025 04:19:06 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250701041905epcas1p427029655596144171f52db23fdc303a4~OBazsr8fw1324313243epcas1p4h;
	Tue,  1 Jul 2025 04:19:05 +0000 (GMT)
Received: from U20PB1-1082.tn.corp.samsungelectronics.net (unknown
	[10.91.135.33]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250701041905epsmtip274923813d6a343fa1e97b7d6f6d08633~OBazqCClB2830828308epsmtip2G;
	Tue,  1 Jul 2025 04:19:05 +0000 (GMT)
Date: Tue, 1 Jul 2025 13:19:00 +0900
From: "Peter GJ. Park" <gyujoon.park@samsung.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: usbnet: fix use-after-free in race on
 workqueue
Message-ID: <20250701041900.ruz5a6ymeyc3hgxf@U20PB1-1082.tn.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>
X-CMS-MailID: 20250701041905epcas1p427029655596144171f52db23fdc303a4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----HF4QkBvyuwHAS03hBZdqIHLab6V36U2Ow6BTJ5ocD4Mu4QMF=_1e99e1_"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625093354epcas1p1c9817df6e1d1599e8b4eb16c5715a6fd
References: <CGME20250625093354epcas1p1c9817df6e1d1599e8b4eb16c5715a6fd@epcas1p1.samsung.com>
	<20250625-usbnet-uaf-fix-v1-1-421eb05ae6ea@samsung.com>
	<87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>

------HF4QkBvyuwHAS03hBZdqIHLab6V36U2Ow6BTJ5ocD4Mu4QMF=_1e99e1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Jun 26, 2025 at 11:21:39AM +0200, Paolo Abeni wrote:
> On 6/25/25 11:33 AM, Peter GJ. Park wrote:
> > When usbnet_disconnect() queued while usbnet_probe() processing,
> > it results to free_netdev before kevent gets to run on workqueue,
> > thus workqueue does assign_work() with referencing freeed memory address.
> >
> > For graceful disconnect and to prevent use-after-free of netdev pointer,
> > the fix adds canceling work and timer those are placed by usbnet_probe()
> >
> > Signed-off-by: Peter GJ. Park <gyujoon.park@samsung.com>
>
> You should include a suitable fixes tag, and you should have specified
> the target tree ('net' in this case) in the prefix subjext
>
It has been applied with v2 patch. Thank you for this.
> > ---
> >  drivers/net/usb/usbnet.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> > index c04e715a4c2ade3bc5587b0df71643a25cf88c55..3c5d9ba7fa6660273137c80106746103f84f5a37 100644
> > --- a/drivers/net/usb/usbnet.c
> > +++ b/drivers/net/usb/usbnet.c
> > @@ -1660,6 +1660,9 @@ void usbnet_disconnect (struct usb_interface *intf)
> >  	usb_free_urb(dev->interrupt);
> >  	kfree(dev->padding_pkt);
> >
> > +	timer_delete_sync(&dev->delay);
> > +	tasklet_kill(&dev->bh);
> > +	cancel_work_sync(&dev->kevent);
> >  	free_netdev(net);
>
> This happens after unregister_netdev(), which calls usbnet_stop() that
> already performs the above cleanup. How the race is supposed to take place?
>
> /P
>
This uaf detected while my syzkaller project for usb kernel driver.

First hub_event work:usb_new_device arrived and processing in wq,
While second new hub_event work:usb_disconnect put into wq.
Then third usbnet:kevent work put by first hub_event work.

Dev pointer free-ed by second work without preceding usbnet_stop(), so the usbnetkevent still queued in wq,
Finally it detected by kasan as use-after-free when wq try to access that poiter.

Here is log snippet.

[ 3041.949116] [5:    kworker/5:1:  130] BUG: KASAN: slab-use-after-free in assign_work+0xe8/0x280
[ 3041.949128] [5:    kworker/5:1:  130] Read of size 8 at addr ffffff88ef60ece8 by task kworker/5:1/130
...
[ 3041.949155] [5:    kworker/5:1:  130] Workqueue:  0x0 (usb_hub_wq)
[ 3041.949167] [5:    kworker/5:1:  130] Call trace:
[ 3041.949170] [5:    kworker/5:1:  130]  dump_backtrace+0x120/0x170
[ 3041.949178] [5:    kworker/5:1:  130]  show_stack+0x2c/0x40
[ 3041.949184] [5:    kworker/5:1:  130]  dump_stack_lvl+0x68/0x84
[ 3041.949193] [5:    kworker/5:1:  130]  print_report+0x13c/0x6f8
[ 3041.949203] [5:    kworker/5:1:  130]  kasan_report+0xdc/0x13c
[ 3041.949211] [5:    kworker/5:1:  130]  __asan_load8+0x98/0xa0
[ 3041.949216] [5:    kworker/5:1:  130]  assign_work+0xe8/0x280
[ 3041.949224] [5:    kworker/5:1:  130]  worker_thread+0x458/0x670
[ 3041.949231] [5:    kworker/5:1:  130]  kthread+0x1d8/0x298
[ 3041.949238] [5:    kworker/5:1:  130]  ret_from_fork+0x10/0x20

[ 3041.949248] [5:    kworker/5:1:  130] Allocated by task 130:
...
[ 3041.949275] [5:    kworker/5:1:  130]  __kmalloc_node+0x74/0x194
[ 3041.949282] [5:    kworker/5:1:  130]  kvmalloc_node+0x160/0x394
[ 3041.949289] [5:    kworker/5:1:  130]  alloc_netdev_mqs+0x6c/0x718
[ 3041.949298] [5:    kworker/5:1:  130]  alloc_etherdev_mqs+0x48/0x60
[ 3041.949305] [5:    kworker/5:1:  130]  usbnet_probe+0xd8/0xf10 [usbnet]
[ 3041.949348] [5:    kworker/5:1:  130]  usb_probe_interface+0x338/0x4fc
...
[ 3041.949516] [5:    kworker/5:1:  130]  usb_new_device+0x7c8/0xbdc
[ 3041.949523] [5:    kworker/5:1:  130]  hub_event+0x1808/0x2564
[ 3041.949530] [5:    kworker/5:1:  130]  process_scheduled_works+0x3cc/0x92c
[ 3041.949538] [5:    kworker/5:1:  130]  worker_thread+0x468/0x670
[ 3041.949546] [5:    kworker/5:1:  130]  kthread+0x1d8/0x298
[ 3041.949552] [5:    kworker/5:1:  130]  ret_from_fork+0x10/0x20

[ 3041.949561] [5:    kworker/5:1:  130] Freed by task 130:
...
[ 3041.949604] [5:    kworker/5:1:  130]  __kmem_cache_free+0xa0/0x260
[ 3041.949610] [5:    kworker/5:1:  130]  kfree+0x60/0x124
[ 3041.949617] [5:    kworker/5:1:  130]  kvfree+0x40/0x54
[ 3041.949622] [5:    kworker/5:1:  130]  netdev_freemem+0x2c/0x40
[ 3041.949630] [5:    kworker/5:1:  130]  netdev_release+0x50/0x6c
[ 3041.949638] [5:    kworker/5:1:  130]  device_release+0x74/0x13c
[ 3041.949645] [5:    kworker/5:1:  130]  kobject_put+0xfc/0x1a8
[ 3041.949654] [5:    kworker/5:1:  130]  put_device+0x28/0x40
[ 3041.949660] [5:    kworker/5:1:  130]  free_netdev+0x234/0x284
[ 3041.949667] [5:    kworker/5:1:  130]  usbnet_disconnect+0x18c/0x250 [usbnet]
[ 3041.949706] [5:    kworker/5:1:  130]  usb_unbind_interface+0x130/0x414
[ 3041.949713] [5:    kworker/5:1:  130]  device_release_driver_internal+0x2e8/0x494
[ 3041.949721] [5:    kworker/5:1:  130]  device_release_driver+0x28/0x3c
[ 3041.949730] [5:    kworker/5:1:  130]  bus_remove_device+0x250/0x268
[ 3041.949737] [5:    kworker/5:1:  130]  device_del+0x304/0x530
[ 3041.949744] [5:    kworker/5:1:  130]  usb_disable_device+0x1d8/0x340
[ 3041.949750] [5:    kworker/5:1:  130]  usb_disconnect+0x1c4/0x4f0
[ 3041.949757] [5:    kworker/5:1:  130]  hub_event+0x1200/0x2564
[ 3041.949764] [5:    kworker/5:1:  130]  process_scheduled_works+0x3cc/0x92c
[ 3041.949772] [5:    kworker/5:1:  130]  worker_thread+0x468/0x670
[ 3041.949780] [5:    kworker/5:1:  130]  kthread+0x1d8/0x298
[ 3041.949786] [5:    kworker/5:1:  130]  ret_from_fork+0x10/0x20

[ 3041.949796] [5:    kworker/5:1:  130] Last potentially related work creation:
...
[ 3041.949820] [5:    kworker/5:1:  130]  __queue_work+0x5d0/0xaf4
[ 3041.949827] [5:    kworker/5:1:  130]  queue_work_on+0x64/0xb0
[ 3041.949833] [5:    kworker/5:1:  130]  usbnet_link_change+0xdc/0x13c [usbnet]
[ 3041.949873] [5:    kworker/5:1:  130]  usbnet_probe+0xe5c/0xf10 [usbnet]
...
[ 3041.950078] [5:    kworker/5:1:  130]  usb_new_device+0x7c8/0xbdc
[ 3041.950085] [5:    kworker/5:1:  130]  hub_event+0x1808/0x2564
[ 3041.950092] [5:    kworker/5:1:  130]  process_scheduled_works+0x3cc/0x92c
[ 3041.950100] [5:    kworker/5:1:  130]  worker_thread+0x468/0x670
[ 3041.950107] [5:    kworker/5:1:  130]  kthread+0x1d8/0x298
[ 3041.950113] [5:    kworker/5:1:  130]  ret_from_fork+0x10/0x20

Best Regards,
GJ

------HF4QkBvyuwHAS03hBZdqIHLab6V36U2Ow6BTJ5ocD4Mu4QMF=_1e99e1_
Content-Type: text/plain; charset="utf-8"


------HF4QkBvyuwHAS03hBZdqIHLab6V36U2Ow6BTJ5ocD4Mu4QMF=_1e99e1_--

