Return-Path: <netdev+bounces-116195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1029496C7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7671C21523
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013313C677;
	Tue,  6 Aug 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="GgLoChU3"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A2129A7E
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965342; cv=none; b=OIwZV1acZiriAYkatKjDAsuzj0mabXbmF21KUucgrazZWJUh3/TvFsEO7bFXZXXQe4a3k43ujUvad/9eDC5fF8K3fZlubptlsBGfWrARDZJbSegrikxq+igeuxxiFM4ofVBfKi9PWarp+Q7LlFSVGV6qN4GXG9eya137OQjXWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965342; c=relaxed/simple;
	bh=HyXhN5Oq9+XkjKdLjBy4TdzJZ6j/ftELzMKQNXAsgMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoJejr1gm84LRup/E6MeLToCiy6SdzX/k0+UXnsCJW5N4Z96S9T9EHQlpmE2gBKKVjDdj8wy7+1Uy7vUMVfymx4/xZsY2PBeX2rHxd71c2k2ntqqSDGHjA7qj26v+aJIFgjY7HWkVe3D7ZEbBZAOthQsd5cHrBxzUFCW86kIcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=GgLoChU3; arc=none smtp.client-ip=17.57.155.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1722965339; bh=LQj4fNq3AjfFWvm1KyFJr4g623c+mzg/R005U5xgbCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GgLoChU35++XkkN3GrbT/kFEPqn0+lF1348CnCZKB3Eykr9KXn/sFabZsAPv1dvWi
	 B3HaGziTQsnMKWOlGgwyJ+poXf1KIdF4OKt/Xwd6bAs3of4CHUKywGenIlkB9aUaGu
	 z4L+sPGZxtR0nSQjtzw0atHUFKa2/jhabv9cUuX/gbUTOuTMwz/zgHTJ7zSv6w0ZJk
	 QntofCX8B97QpiEFdUZyvKFybkIm+j3p6mFrAFgQyMmBFkyo5PJrMJjHsCW1bVryp3
	 IHrR3h9TJMSVFG8aIweC8XFXmHfs8yk+dBk77N7/tOK7oZBdetLHfur3RfPrCPFGbI
	 jSPLgYy7Ow+Gw==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id E8EDD440377;
	Tue,  6 Aug 2024 17:28:56 +0000 (UTC)
From: Foster Snowhill <forst@pen.gy>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next 5/5] usbnet: ipheth: fix carrier detection in modes 1 and 4
Date: Tue,  6 Aug 2024 19:28:09 +0200
Message-ID: <20240806172809.675044-5-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240806172809.675044-1-forst@pen.gy>
References: <20240806172809.675044-1-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9ZlTGVy62X3C_iXbE3MKDXxwY5igPsOQ
X-Proofpoint-ORIG-GUID: 9ZlTGVy62X3C_iXbE3MKDXxwY5igPsOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_14,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408060123

Apart from the standard "configurations", "interfaces" and "alternate
interface settings" in USB, iOS devices also have a notion of
"modes". In different modes, the device exposes a different set of
available configurations.

Depending on the iOS version, and depending on the current mode, the
length and contents of the carrier state control message differs:

* 1 byte (seen on iOS 4.2.1, 8.4):
    * 03: carrier off (mode 0)
    * 04: carrier on (mode 0)
* 3 bytes (seen on iOS 10.3.4, 15.7.6):
    * 03 03 03: carrier off (mode 0)
    * 04 04 03: carrier on (mode 0)
* 4 bytes (seen on iOS 16.5, 17.6):
    * 03 03 03 00: carrier off (mode 0)
    * 04 03 03 00: carrier off (mode 1)
    * 06 03 03 00: carrier off (mode 4)
    * 04 04 03 04: carrier on (mode 0 and 1)
    * 06 04 03 04: carrier on (mode 4)

Before this change, the driver always used the first byte of the
response to determine carrier state.

From this larger sample, the first byte seems to indicate the number of
available USB configurations in the current mode (with the exception of
the default mode 0), and in some cases (namely mode 1 and 4) does not
correlate with the carrier state.

Previous logic erroneously counted `04 03 03 00` as "carrier on" and
`06 04 03 04` as "carrier off" on iOS versions that support mode 1 and
mode 4 respectively.

Only modes 0, 1 and 4 expose the USB Ethernet interfaces necessary for
the ipheth driver.

Check the second byte of the control message where possible, and fall
back to checking the first byte on older iOS versions.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
---
 drivers/net/usb/ipheth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index cdc72559790a..46afb95ffabe 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -355,13 +355,14 @@ static int ipheth_carrier_set(struct ipheth_device *dev)
 			0x02, /* index */
 			dev->ctrl_buf, IPHETH_CTRL_BUF_SIZE,
 			IPHETH_CTRL_TIMEOUT);
-	if (retval < 0) {
+	if (retval <= 0) {
 		dev_err(&dev->intf->dev, "%s: usb_control_msg: %d\n",
 			__func__, retval);
 		return retval;
 	}
 
-	if (dev->ctrl_buf[0] == IPHETH_CARRIER_ON) {
+	if ((retval == 1 && dev->ctrl_buf[0] == IPHETH_CARRIER_ON) ||
+	    (retval >= 2 && dev->ctrl_buf[1] == IPHETH_CARRIER_ON)) {
 		netif_carrier_on(dev->net);
 		if (dev->tx_urb->status != -EINPROGRESS)
 			netif_wake_queue(dev->net);
-- 
2.45.1


