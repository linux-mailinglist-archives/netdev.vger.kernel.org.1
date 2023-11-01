Return-Path: <netdev+bounces-45546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B45F7DE126
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC18E1C20DA2
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 12:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18211CAC;
	Wed,  1 Nov 2023 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81EDDA4
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 12:55:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A15101;
	Wed,  1 Nov 2023 05:55:16 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SL6M03b1RzPnmN;
	Wed,  1 Nov 2023 20:51:08 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 1 Nov
 2023 20:55:14 +0800
From: Ren Mingshuai <renmingshuai@huawei.com>
To: <renmingshuai@huawei.com>
CC: <caowangbao@huawei.com>, <davem@davemloft.net>, <khlebnikov@openvz.org>,
	<liaichun@huawei.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <oneukum@suse.com>, <yanan@huawei.com>
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Date: Wed, 1 Nov 2023 20:55:11 +0800
Message-ID: <20231101125511.222629-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231101123559.210756-1-renmingshuai@huawei.com>
References: <20231101123559.210756-1-renmingshuai@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected

>23ba07991dad said SKB can be NULL without describing the triggering
>scenario. Always Check it before dereference to void potential NULL
>pointer dereference.
I've tried to find out the scenarios where SKB is NULL, but failed.
It seems impossible for SKB to be NULL. If SKB can be NULL, please tell
me the reason and I'd be very grateful.

>Fix smatch warning:
>drivers/net/usb/usbnet.c:1380 usbnet_start_xmit() error: we previously assumed 'skb' could be null (see line 1359)
>
>Signed-off-by: Ren Mingshuai <renmingshuai@huawei.com>
>---
> drivers/net/usb/usbnet.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
>index 64a9a80b2309..386cb1a4ff03 100644
>--- a/drivers/net/usb/usbnet.c
>+++ b/drivers/net/usb/usbnet.c
>@@ -1374,6 +1374,11 @@ netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
>                }
>        }
>
>+       if (!skb) {
>+               netif_dbg(dev, tx_err, dev->net, "tx skb is NULL\n");
>+               goto drop;
>+       }
>+
>        if (!(urb = usb_alloc_urb (0, GFP_ATOMIC))) {
>                netif_dbg(dev, tx_err, dev->net, "no urb\n");
>                goto drop;
>--
>2.33.0

