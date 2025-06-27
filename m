Return-Path: <netdev+bounces-201755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B1AEAEBE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2637B3A4C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581301E3DF2;
	Fri, 27 Jun 2025 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oitTAIPy"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D01E32CF
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004723; cv=none; b=Vw+WE65rtuXNVEYpZFvus/uOeHTEstQuoF1vS/3LsgjOM0Hv5EtQSG3BdgYATC5gVfN1hD+JFlUF3QGDo2e1pKZHKx96GElsX+/py7VvdcAZYw7AoGwSlwQcCqDbshZhCc3ML9JOyEUTSoHloUWPWaCgVSkAlsPQYEcts1o3VuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004723; c=relaxed/simple;
	bh=PBa5aIrhNeynzjQwrPQoO/w5yTHGGWIyr1/2Zo/kt9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=JL9lHf//H4oeJNuUlkjbMmfC4JKyt+EuiaKwY8iVIlnWm+E7+uFPEjYEA7MHaa7VpLyYmfzTKrn4FdPJjPFCYojQnXciLeMpUrvp5nAEoEZZDl3Kixd+pSCVAnMptyXzFTc5OLaCUPODx+FxmrBPNFTkhA3HfYTxJwpUUQtczeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oitTAIPy; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250627061158epoutp013aa06897f0440000318744bb30a5c962~M0YOKMxnn3108131081epoutp01U
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:11:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250627061158epoutp013aa06897f0440000318744bb30a5c962~M0YOKMxnn3108131081epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751004718;
	bh=gxAcpvbaItNSwgVo3IuQxbDuC/6qrKZMq5kCbQssHnM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=oitTAIPy+DcqPOIq0Np479U4RbLM1cIiweTv6a16s1NH6vO3V213iowp6a/CWk84p
	 eBfP2qH+QH2CGXftKZ5P/khxznuShDhkDSC1+6+Jqmh0k9Mu7z+daahbTkQCMK2Ufl
	 o92DeatcNFIP/+yFSURQltRylnTG3Fhpz/RpWU4M=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20250627061157epcas1p426c47bc48ef9cf1d5ec82d1740b6d21d~M0YNxsRT11350213502epcas1p4X;
	Fri, 27 Jun 2025 06:11:57 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.36.222]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bT4vd1c1zz6B9mD; Fri, 27 Jun
	2025 06:11:57 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250627061156epcas1p1dfe3323378b314d98b660de33f50e0c2~M0YMyYbkH0457004570epcas1p1p;
	Fri, 27 Jun 2025 06:11:56 +0000 (GMT)
Received: from W10PB10456 (unknown [10.253.158.40]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250627061156epsmtip15d0ded2c164fdd6adb47fc08f85da98f~M0YMu-nOZ0763007630epsmtip1h;
	Fri, 27 Jun 2025 06:11:56 +0000 (GMT)
From: "Peter GJ. Park" <gyujoon.park@samsung.com>
To: "'Paolo Abeni'" <pabeni@redhat.com>, "'Oliver Neukum'"
	<oneukum@suse.com>, "'Andrew Lunn'" <andrew+netdev@lunn.ch>, "'David S.
 Miller'" <davem@davemloft.net>, "'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: usb: usbnet: fix use-after-free in race on
 workqueue
Date: Fri, 27 Jun 2025 15:11:55 +0900
Message-ID: <00d001dbe72a$62281bc0$26785340$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdvnJ/9d85pvJfQpSNWVZW0e73yvqw==
Content-Language: ko
X-CMS-MailID: 20250627061156epcas1p1dfe3323378b314d98b660de33f50e0c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250627061156epcas1p1dfe3323378b314d98b660de33f50e0c2
References: <CGME20250627061156epcas1p1dfe3323378b314d98b660de33f50e0c2@epcas1p1.samsung.com>

>On 6/25/25 11:33 AM, Peter GJ. Park wrote:
>> When usbnet_disconnect() queued while usbnet_probe() processing, it=20
>> results to free_netdev before kevent gets to run on workqueue, thus=20
>> workqueue does assign_work() with referencing freeed memory address.
>>=20
>> For graceful disconnect and to prevent use-after-free of netdev=20
>> pointer, the fix adds canceling work and timer those are placed by=20
>> usbnet_probe()
>>=20
>> Signed-off-by: Peter GJ. Park <gyujoon.park=40samsung.com>
>
>You should include a suitable fixes tag, and you should have specified the=
 target tree ('net' in this case) in the prefix subjext
Prefix net added to subject, but for fixes tag, by looking git blame, the l=
ast line of usbnet_disconnect()are based on initial commit,
thus I couldn't put the fixes tag for it. Please let me know how can I hand=
le this.

>
>> ---
>>  drivers/net/usb/usbnet.c =7C 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c index=
=20
>> c04e715a4c2ade3bc5587b0df71643a25cf88c55..3c5d9ba7fa6660273137c8010674
>> 6103f84f5a37 100644
>> --- a/drivers/net/usb/usbnet.c
>> +++ b/drivers/net/usb/usbnet.c
>> =40=40 -1660,6 +1660,9 =40=40 void usbnet_disconnect (struct usb_interfa=
ce *intf)
>>  	usb_free_urb(dev->interrupt);
>>  	kfree(dev->padding_pkt);
>> =20
>> +	timer_delete_sync(&dev->delay);
>> +	tasklet_kill(&dev->bh);
>> +	cancel_work_sync(&dev->kevent);
>>  	free_netdev(net);
>
>This happens after unregister_netdev(), which calls usbnet_stop() that alr=
eady performs the above cleanup. How the race is supposed to take place?
>

This uaf detected while my syzkaller project for usb kernel driver.

First hub_event work:usb_new_device arrived and processing in wq,
While second new hub_event work:usb_disconnect put into wq.
Then third usbnet:kevent work put by first hub_event work.

Dev pointer free-ed by second work without preceding usbnet_stop(), so the =
usbnetkevent still queued in wq,
Finally it detected by kasan as use-after-free when wq try to access that p=
oiter.

Here is log snippet.

=5B 3041.949116=5D =5B5:    kworker/5:1:  130=5D BUG: KASAN: slab-use-after=
-free in assign_work+0xe8/0x280
=5B 3041.949128=5D =5B5:    kworker/5:1:  130=5D Read of size 8 at addr fff=
fff88ef60ece8 by task kworker/5:1/130
...
=5B 3041.949155=5D =5B5:    kworker/5:1:  130=5D Workqueue:  0x0 (usb_hub_w=
q)
=5B 3041.949167=5D =5B5:    kworker/5:1:  130=5D Call trace:
=5B 3041.949170=5D =5B5:    kworker/5:1:  130=5D  dump_backtrace+0x120/0x17=
0
=5B 3041.949178=5D =5B5:    kworker/5:1:  130=5D  show_stack+0x2c/0x40
=5B 3041.949184=5D =5B5:    kworker/5:1:  130=5D  dump_stack_lvl+0x68/0x84
=5B 3041.949193=5D =5B5:    kworker/5:1:  130=5D  print_report+0x13c/0x6f8
=5B 3041.949203=5D =5B5:    kworker/5:1:  130=5D  kasan_report+0xdc/0x13c
=5B 3041.949211=5D =5B5:    kworker/5:1:  130=5D  __asan_load8+0x98/0xa0
=5B 3041.949216=5D =5B5:    kworker/5:1:  130=5D  assign_work+0xe8/0x280
=5B 3041.949224=5D =5B5:    kworker/5:1:  130=5D  worker_thread+0x458/0x670
=5B 3041.949231=5D =5B5:    kworker/5:1:  130=5D  kthread+0x1d8/0x298
=5B 3041.949238=5D =5B5:    kworker/5:1:  130=5D  ret_from_fork+0x10/0x20

=5B 3041.949248=5D =5B5:    kworker/5:1:  130=5D Allocated by task 130:
...
=5B 3041.949275=5D =5B5:    kworker/5:1:  130=5D  __kmalloc_node+0x74/0x194
=5B 3041.949282=5D =5B5:    kworker/5:1:  130=5D  kvmalloc_node+0x160/0x394
=5B 3041.949289=5D =5B5:    kworker/5:1:  130=5D  alloc_netdev_mqs+0x6c/0x7=
18
=5B 3041.949298=5D =5B5:    kworker/5:1:  130=5D  alloc_etherdev_mqs+0x48/0=
x60
=5B 3041.949305=5D =5B5:    kworker/5:1:  130=5D  usbnet_probe+0xd8/0xf10 =
=5Busbnet=5D
=5B 3041.949348=5D =5B5:    kworker/5:1:  130=5D  usb_probe_interface+0x338=
/0x4fc
...
=5B 3041.949516=5D =5B5:    kworker/5:1:  130=5D  usb_new_device+0x7c8/0xbd=
c
=5B 3041.949523=5D =5B5:    kworker/5:1:  130=5D  hub_event+0x1808/0x2564
=5B 3041.949530=5D =5B5:    kworker/5:1:  130=5D  process_scheduled_works+0=
x3cc/0x92c
=5B 3041.949538=5D =5B5:    kworker/5:1:  130=5D  worker_thread+0x468/0x670
=5B 3041.949546=5D =5B5:    kworker/5:1:  130=5D  kthread+0x1d8/0x298
=5B 3041.949552=5D =5B5:    kworker/5:1:  130=5D  ret_from_fork+0x10/0x20

=5B 3041.949561=5D =5B5:    kworker/5:1:  130=5D Freed by task 130:
...
=5B 3041.949604=5D =5B5:    kworker/5:1:  130=5D  __kmem_cache_free+0xa0/0x=
260
=5B 3041.949610=5D =5B5:    kworker/5:1:  130=5D  kfree+0x60/0x124
=5B 3041.949617=5D =5B5:    kworker/5:1:  130=5D  kvfree+0x40/0x54
=5B 3041.949622=5D =5B5:    kworker/5:1:  130=5D  netdev_freemem+0x2c/0x40
=5B 3041.949630=5D =5B5:    kworker/5:1:  130=5D  netdev_release+0x50/0x6c
=5B 3041.949638=5D =5B5:    kworker/5:1:  130=5D  device_release+0x74/0x13c
=5B 3041.949645=5D =5B5:    kworker/5:1:  130=5D  kobject_put+0xfc/0x1a8
=5B 3041.949654=5D =5B5:    kworker/5:1:  130=5D  put_device+0x28/0x40
=5B 3041.949660=5D =5B5:    kworker/5:1:  130=5D  free_netdev+0x234/0x284
=5B 3041.949667=5D =5B5:    kworker/5:1:  130=5D  usbnet_disconnect+0x18c/0=
x250 =5Busbnet=5D
=5B 3041.949706=5D =5B5:    kworker/5:1:  130=5D  usb_unbind_interface+0x13=
0/0x414
=5B 3041.949713=5D =5B5:    kworker/5:1:  130=5D  device_release_driver_int=
ernal+0x2e8/0x494
=5B 3041.949721=5D =5B5:    kworker/5:1:  130=5D  device_release_driver+0x2=
8/0x3c
=5B 3041.949730=5D =5B5:    kworker/5:1:  130=5D  bus_remove_device+0x250/0=
x268
=5B 3041.949737=5D =5B5:    kworker/5:1:  130=5D  device_del+0x304/0x530
=5B 3041.949744=5D =5B5:    kworker/5:1:  130=5D  usb_disable_device+0x1d8/=
0x340
=5B 3041.949750=5D =5B5:    kworker/5:1:  130=5D  usb_disconnect+0x1c4/0x4f=
0
=5B 3041.949757=5D =5B5:    kworker/5:1:  130=5D  hub_event+0x1200/0x2564
=5B 3041.949764=5D =5B5:    kworker/5:1:  130=5D  process_scheduled_works+0=
x3cc/0x92c
=5B 3041.949772=5D =5B5:    kworker/5:1:  130=5D  worker_thread+0x468/0x670
=5B 3041.949780=5D =5B5:    kworker/5:1:  130=5D  kthread+0x1d8/0x298
=5B 3041.949786=5D =5B5:    kworker/5:1:  130=5D  ret_from_fork+0x10/0x20

=5B 3041.949796=5D =5B5:    kworker/5:1:  130=5D Last potentially related w=
ork creation:
...
=5B 3041.949820=5D =5B5:    kworker/5:1:  130=5D  __queue_work+0x5d0/0xaf4
=5B 3041.949827=5D =5B5:    kworker/5:1:  130=5D  queue_work_on+0x64/0xb0
=5B 3041.949833=5D =5B5:    kworker/5:1:  130=5D  usbnet_link_change+0xdc/0=
x13c =5Busbnet=5D
=5B 3041.949873=5D =5B5:    kworker/5:1:  130=5D  usbnet_probe+0xe5c/0xf10 =
=5Busbnet=5D
...
=5B 3041.950078=5D =5B5:    kworker/5:1:  130=5D  usb_new_device+0x7c8/0xbd=
c
=5B 3041.950085=5D =5B5:    kworker/5:1:  130=5D  hub_event+0x1808/0x2564
=5B 3041.950092=5D =5B5:    kworker/5:1:  130=5D  process_scheduled_works+0=
x3cc/0x92c
=5B 3041.950100=5D =5B5:    kworker/5:1:  130=5D  worker_thread+0x468/0x670
=5B 3041.950107=5D =5B5:    kworker/5:1:  130=5D  kthread+0x1d8/0x298
=5B 3041.950113=5D =5B5:    kworker/5:1:  130=5D  ret_from_fork+0x10/0x20
=5B 3041.950120=5D =5B5:    kworker/5:1:  130=5D
>/P



