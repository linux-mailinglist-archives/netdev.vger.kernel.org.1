Return-Path: <netdev+bounces-201886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFCAEB597
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F281C21DA1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC4229C35A;
	Fri, 27 Jun 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c6urAryN"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CF2F1FC3
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022007; cv=none; b=TAd44AdhkibkB6s9rn9jCBfIu4FzQLmeg9dVa1KR6sTCdqxh/Qt2Cuh6D7YnxhJDMMym7+m3kp41EFugY3xHX4zBL/0cGk6+BQPvTbSP9+PX0tr4QwVhH9NE4XRihBkSV0t7emFCJ+VBV8o0Frs1CngWCMMaLNXuHtsd6HxCM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022007; c=relaxed/simple;
	bh=vLo5INOPS/WDpIxNx5EixrWME6bTViVtqYq5HO8ajvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=AQFw7RzCmuE+wWEJzvkCZlVVRbf8mvT1WrPTt+NrXT6GLMAXIHuFevc7/1MNySdT0JRK5h1mPtdWWziJq1/XRb1ehs3JpCULYZi6W2tnx5FJ07xNfJ557ognHWXT1d5K3CL5Gxs9+wmXYtAijIakabUJopKrKN2bxzykXPYbOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=c6urAryN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250627110001epoutp0382ef64dd9cc375eaf7845c6e8ae6ac2d~M4Tu62FSm0922109221epoutp03L
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:00:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250627110001epoutp0382ef64dd9cc375eaf7845c6e8ae6ac2d~M4Tu62FSm0922109221epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751022001;
	bh=+ENfZgyXG6LRtkLsvTjegXsc5nM6Q4iQE+wp1eC5dN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6urAryNFOrLbEjPvy+dNYuBLBOACYyYsVD7KypMRs90ko1mcGgdm+K7/UUqIJM22
	 9CdPopiDEALv2u/dDI3JOFQc15+eZ/lj6bv7ouR37IUsnq7Z6umaKMMUh8ctXlrd90
	 20qN/G/YIKVKXrsBGpwesXbOD+oPVrgZje+xjX20=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20250627110001epcas1p21f2a1180b51fc82517facb6b9f247e14~M4TuV63LA0253702537epcas1p2E;
	Fri, 27 Jun 2025 11:00:01 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.36.223]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bTCJ057Wzz6B9m5; Fri, 27 Jun
	2025 11:00:00 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250627105959epcas1p168bbbe460ee1f081e67723505e1f57c9~M4TsoWor_2955029550epcas1p1Z;
	Fri, 27 Jun 2025 10:59:59 +0000 (GMT)
Received: from U20PB1-1082.tn.corp.samsungelectronics.net (unknown
	[10.91.135.33]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250627105959epsmtip21aa89321785c91e7dfb1e50c794acb7e~M4TsjuKwn3127031270epsmtip2N;
	Fri, 27 Jun 2025 10:59:59 +0000 (GMT)
From: "Peter GJ. Park" <gyujoon.park@samsung.com>
To: pabeni@redhat.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	gyujoon.park@samsung.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, oneukum@suse.com
Subject: [PATCH net v2] net: usb: usbnet: fix use-after-free in race on
 workqueue
Date: Fri, 27 Jun 2025 19:59:53 +0900
Message-Id: <20250627105953.2711808-1-gyujoon.park@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250627105959epcas1p168bbbe460ee1f081e67723505e1f57c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250627105959epcas1p168bbbe460ee1f081e67723505e1f57c9
References: <87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>
	<CGME20250627105959epcas1p168bbbe460ee1f081e67723505e1f57c9@epcas1p1.samsung.com>

When usbnet_disconnect() queued while usbnet_probe() processing,
it results to free_netdev before kevent gets to run on workqueue,
thus workqueue does assign_work() with referencing freeed memory address.

For graceful disconnect and to prevent use-after-free of netdev pointer,
the fix adds canceling work and timer those are placed by usbnet_probe()

Signed-off-by: Peter GJ. Park <gyujoon.park@samsung.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 drivers/net/usb/usbnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index c04e715a4c2a..3c5d9ba7fa66 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1660,6 +1660,9 @@ void usbnet_disconnect (struct usb_interface *intf)
 	usb_free_urb(dev->interrupt);
 	kfree(dev->padding_pkt);

+	timer_delete_sync(&dev->delay);
+	tasklet_kill(&dev->bh);
+	cancel_work_sync(&dev->kevent);
 	free_netdev(net);
 }
 EXPORT_SYMBOL_GPL(usbnet_disconnect);
--
2.25.1


