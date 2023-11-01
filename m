Return-Path: <netdev+bounces-45541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A23E7DE0DF
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34BFB20A95
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 12:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4984979D3;
	Wed,  1 Nov 2023 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A521FC4
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 12:36:09 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0747D11B;
	Wed,  1 Nov 2023 05:36:06 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SL5y36YB1zrTPC;
	Wed,  1 Nov 2023 20:32:59 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 1 Nov
 2023 20:36:01 +0800
From: Ren Mingshuai <renmingshuai@huawei.com>
To: <oneukum@suse.com>
CC: <khlebnikov@openvz.org>, <davem@davemloft.net>, <caowangbao@huawei.com>,
	<yanan@huawei.com>, <liaichun@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Date: Wed, 1 Nov 2023 20:35:59 +0800
Message-ID: <20231101123559.210756-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected

23ba07991dad said SKB can be NULL without describing the triggering
scenario. Always Check it before dereference to void potential NULL
pointer dereference.
Fix smatch warning:
drivers/net/usb/usbnet.c:1380 usbnet_start_xmit() error: we previously assumed 'skb' could be null (see line 1359)

Signed-off-by: Ren Mingshuai <renmingshuai@huawei.com>
---
 drivers/net/usb/usbnet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 64a9a80b2309..386cb1a4ff03 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1374,6 +1374,11 @@ netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
 		}
 	}
 
+	if (!skb) {
+		netif_dbg(dev, tx_err, dev->net, "tx skb is NULL\n");
+		goto drop;
+	}
+
 	if (!(urb = usb_alloc_urb (0, GFP_ATOMIC))) {
 		netif_dbg(dev, tx_err, dev->net, "no urb\n");
 		goto drop;
-- 
2.33.0


