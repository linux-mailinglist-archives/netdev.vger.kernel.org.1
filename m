Return-Path: <netdev+bounces-201881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF333AEB548
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAAC3AC43E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9B2980A5;
	Fri, 27 Jun 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RaKZsnHB"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9522539E
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021254; cv=none; b=Sfng741tsVOdY33y3bne1v0DexDj+awtMJMaw8iaT6/lGCj7y/gi7uEgQmBa7nv6+gfCy17jWEIY2azJvXDyscCR/bbUnTAHXFErg0tJf80PCwYLFEwtH5TgB04rdDk8BF/nex+s411A4XeSkbJqmIVloyjVDwbsyB3qnTy8oCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021254; c=relaxed/simple;
	bh=Vmj0r9TNJDCT9tnc6aJchAO90BBsqBKAdvYEXU6O9TM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YmiW++XTeXY0hOfogVlmsOE51473h6FWJYRhrYr88I7HF8uWxF06+BXbK6bjyDg3t9IA2FtT5bncgjwbAcmwvWumvnVyupvKT5QAhb14QF0ubu8pGGG01qaPRhfcijStVozR6uOmRpCVDFn2sDd6yhvnXu3Usu1C9Ndg+hVkR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RaKZsnHB; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250627104729epoutp0412f93de404cff743d129edd22e3e7917~M4IyQOCQ_1327813278epoutp04K
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:47:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250627104729epoutp0412f93de404cff743d129edd22e3e7917~M4IyQOCQ_1327813278epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751021249;
	bh=+ENfZgyXG6LRtkLsvTjegXsc5nM6Q4iQE+wp1eC5dN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaKZsnHBQhzPzhll7diBsWNpYwslu5ag+o4Pq55XHtFel3nZEloSlHKVv01uKpJst
	 HyaAbVsoi74wGkJljZTX6HU+bfvRq727Qn64anrfUJ8M8mgjxmbQBv1oIDTd+13Ar6
	 YBacmht1sq4d7I937yUQhjyH8Bhdu3D0YMBBn/tw=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20250627104728epcas1p2f75c66d193e2cb3c329fb5025a9f3eb1~M4Ixw2o880109001090epcas1p2Z;
	Fri, 27 Jun 2025 10:47:28 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.240]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bTC1X3sshz3hhT4; Fri, 27 Jun
	2025 10:47:28 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250627104728epcas1p1dee12902e3d634214a5c6753ad7613c6~M4Iw6a5Zd2849828498epcas1p17;
	Fri, 27 Jun 2025 10:47:28 +0000 (GMT)
Received: from U20PB1-1082.tn.corp.samsungelectronics.net (unknown
	[10.91.135.33]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250627104727epsmtip29628f80885f7058e77ba591a62afc5e1~M4Iw1Xdbi2384223842epsmtip2o;
	Fri, 27 Jun 2025 10:47:27 +0000 (GMT)
From: "Peter GJ. Park" <gyujoon.park@samsung.com>
To: pabeni@redhat.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	gyujoon.park@samsung.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, oneukum@suse.com
Subject: [PATCH v2] net: usb: usbnet: fix use-after-free in race on
 workqueue
Date: Fri, 27 Jun 2025 19:47:21 +0900
Message-Id: <20250627104721.2710603-1-gyujoon.park@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250627104728epcas1p1dee12902e3d634214a5c6753ad7613c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250627104728epcas1p1dee12902e3d634214a5c6753ad7613c6
References: <87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>
	<CGME20250627104728epcas1p1dee12902e3d634214a5c6753ad7613c6@epcas1p1.samsung.com>

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


