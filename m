Return-Path: <netdev+bounces-33040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBC79C798
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658AA281863
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 07:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853417722;
	Tue, 12 Sep 2023 07:04:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2D17721
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:04:19 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8BE78;
	Tue, 12 Sep 2023 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694502259;
  x=1726038259;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=WdrUuVSZ9WRITa1Q6VvDaXcLq4GleKiHNXwuo+2pzBs=;
  b=I0G9dSQd+fYDB0/k6n48d/G+GfHoZVB0Hn0UFJdoYZDTQSSXgZPJLK8p
   +RXGYufmdwdtGmlSF8zpW0Zg1CP5c/gvhP02SNGy44iI2OtQvIS2IDOw6
   oEZnDEsH/IUZAk88nk5nIo9N5kpGFHCf0dKRNC9dlUyEipSMuO9HM/RCC
   U5oKjQQsp78Q/ZIwgCAaJZwbU/X3V8MLdB/R5yu3fxTET/UPF/C8KokkX
   tla4bt+dbHR1ls5VpcTbjWKcYCeikZx5HPhuzYpY/etV/at3fBhEy+vkv
   sBbmlZ1RzGEAi3XFxd5xya9QRc8N0ilAIVZxP6Io+JoHSmIxaHGNUrwXr
   g==;
From: Stefan x Nilsson <stefan.x.nilsson@axis.com>
Date: Tue, 12 Sep 2023 09:04:13 +0200
Subject: [PATCH net-next] qmi_wwan: Add rawip module param
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230912-qmiraw-v1-1-21bc812fa0cf@axis.com>
X-B4-Tracking: v=1; b=H4sIAGwNAGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyML3cLczKLEct0ki6TkpMTUFEOTxCQloOKCotS0zAqwQdGxtbUAUEv
 f0lgAAAA=
To: =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@axis.com>, Stefan x Nilsson
	<stefan.x.nilsson@axis.com>
X-Mailer: b4 0.12.3

Certain QMI modems will start communicating in rawip mode after
bootup, and will not work properly if communication starts off in
ethernet mode. So add a module parameter, rawip_as_default, that
can be used to load the qmi driver in rawip mode.

The advantage compared to changing rawip at a later point using
sysfs is that the os will not detect the device and start talking
to it while the driver is still in incorrect mode.

Signed-off-by: Stefan x Nilsson <stefan.x.nilsson@axis.com>
---
 drivers/net/usb/qmi_wwan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 344af3c5c836..968c60ececf8 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -46,6 +46,10 @@
  * commands on a serial interface
  */
 
+/* Module parameters */
+static bool rawip_as_default;
+module_param(rawip_as_default, bool, 0644);
+
 /* driver specific data */
 struct qmi_wwan_state {
 	struct usb_driver *subdriver;
@@ -843,6 +847,13 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
 	}
 	dev->net->netdev_ops = &qmi_wwan_netdev_ops;
 	dev->net->sysfs_groups[0] = &qmi_wwan_sysfs_attr_group;
+
+	/* Set the driver into rawip mode if requested by module param */
+	if (rawip_as_default) {
+		info->flags |= QMI_WWAN_FLAG_RAWIP;
+		qmi_wwan_netdev_setup(dev->net);
+	}
+
 err:
 	return status;
 }

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230828-qmiraw-b8bcbaed14ab

Best regards,
-- 
Stefan x Nilsson <stefan.x.nilsson@axis.com>


