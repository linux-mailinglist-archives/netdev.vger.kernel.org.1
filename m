Return-Path: <netdev+bounces-191824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A2ABD6E2
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FD9189C79A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D23E274FE2;
	Tue, 20 May 2025 11:33:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8D21A45A;
	Tue, 20 May 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740782; cv=none; b=F3OJ+kpOJS3QS7XCUX52OlL58thNkbFgHeUvbLuW7VurxrRwh3A5YWNSKHyHloAuccB7jwtYhao+f/VHMBgTXLaYGIe6Qv4INXUVItW1hLxAkJTh9NFl5SE4LJlWS8HgpQFnr84/1pzCScZ32GOpouo4oVA3wDQpFaQhlVKUFAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740782; c=relaxed/simple;
	bh=k1fG5ajRDy2nag7Bj63UX37XmQ7V6ulqT0aGln+oI1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iJ6TZn3+8FP2Cu9s+qCfYlP5vCqCOTh8OcnjivHQbKbhAh2REQKL/LfcRjd6iX4oJFgzZ6YLv0Y7/eRpZKNKL8qu7u2yq1PB3oDGWFl0ZxTKDmqQ82vnRwXsQuKpUX7rk3pnPbSl/J2jPMSem0RdJkGwfNcNKM+bnBxdIAVHk5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 20 May
 2025 14:32:53 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 May
 2025 14:32:53 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net-next] net: usb: aqc111: fix error handling of usbnet read calls
Date: Tue, 20 May 2025 14:32:39 +0300
Message-ID: <20250520113240.2369438-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Syzkaller, courtesy of syzbot, identified an error (see report [1]) in
aqc111 driver, caused by incomplete sanitation of usb read calls'
results. This problem is quite similar to the one fixed in commit
920a9fa27e78 ("net: asix: add proper error handling of usb read errors").

For instance, usbnet_read_cmd() may read fewer than 'size' bytes,
even if the caller expected the full amount, and aqc111_read_cmd()
will not check its result properly. As [1] shows, this may lead
to MAC address in aqc111_bind() being only partly initialized,
triggering KMSAN warnings.

Fix the issue by verifying that the number of bytes read is
as expected and not less.

[1] Partial syzbot report:
BUG: KMSAN: uninit-value in is_valid_ether_addr include/linux/etherdevice.h:208 [inline]
BUG: KMSAN: uninit-value in usbnet_probe+0x2e57/0x4390 drivers/net/usb/usbnet.c:1830
 is_valid_ether_addr include/linux/etherdevice.h:208 [inline]
 usbnet_probe+0x2e57/0x4390 drivers/net/usb/usbnet.c:1830
 usb_probe_interface+0xd01/0x1310 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d1/0xd90 drivers/base/dd.c:658
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:800
...

Uninit was stored to memory at:
 dev_addr_mod+0xb0/0x550 net/core/dev_addr_lists.c:582
 __dev_addr_set include/linux/netdevice.h:4874 [inline]
 eth_hw_addr_set include/linux/etherdevice.h:325 [inline]
 aqc111_bind+0x35f/0x1150 drivers/net/usb/aqc111.c:717
 usbnet_probe+0xbe6/0x4390 drivers/net/usb/usbnet.c:1772
 usb_probe_interface+0xd01/0x1310 drivers/usb/core/driver.c:396
...

Uninit was stored to memory at:
 ether_addr_copy include/linux/etherdevice.h:305 [inline]
 aqc111_read_perm_mac drivers/net/usb/aqc111.c:663 [inline]
 aqc111_bind+0x794/0x1150 drivers/net/usb/aqc111.c:713
 usbnet_probe+0xbe6/0x4390 drivers/net/usb/usbnet.c:1772
 usb_probe_interface+0xd01/0x1310 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
...

Local variable buf.i created at:
 aqc111_read_perm_mac drivers/net/usb/aqc111.c:656 [inline]
 aqc111_bind+0x221/0x1150 drivers/net/usb/aqc111.c:713
 usbnet_probe+0xbe6/0x4390 drivers/net/usb/usbnet.c:1772

Reported-by: syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3b6b9ff7b80430020c7b
Tested-by: syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com
Fixes: df2d59a2ab6c ("net: usb: aqc111: Add support for getting and setting of MAC address")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. In aqc111 there are many calls to aqc111_read_cmd[_nopm]
functions in other parts of the driver and most of them are not
checked at all. I've chosen to forego error handling of them, as
it seems it's missing deliberately. Correct me if I am wrong.

 drivers/net/usb/aqc111.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index ff5be2cbf17b..453a2cf82753 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -30,10 +30,13 @@ static int aqc111_read_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
 	ret = usbnet_read_cmd_nopm(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR |
 				   USB_RECIP_DEVICE, value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < size)) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
+	}
 
 	return ret;
 }
@@ -46,10 +49,13 @@ static int aqc111_read_cmd(struct usbnet *dev, u8 cmd, u16 value,
 	ret = usbnet_read_cmd(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR |
 			      USB_RECIP_DEVICE, value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < size)) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
+	}
 
 	return ret;
 }

