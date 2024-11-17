Return-Path: <netdev+bounces-145623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBC9D027E
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 09:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F040284A66
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 08:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D2158DD9;
	Sun, 17 Nov 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="V6bsp8Ob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523731494DB
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731832349; cv=none; b=bnx3Z8dZpp12UHbwuV/39EflYT30jdJ9RkO+MIsQp0CIdYNKsfoGTwl9i4OOcBBKuMBJUmLw9gLY4OCJ+mHdyKsMXhBhkLgqP79gMezSa0IsvUqXGoid10JmaacXWTGKuvVcEjB9FEBuF3ixnpUdDBqXSNpZKAC+bgh2mhfID5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731832349; c=relaxed/simple;
	bh=bctWgxAXidA+mT+mxTODN07yskzEsrZh07njUIX3POo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXRWkVIkTMOzVOJXKfvExOvVC4H2VRMHPgm5OcK6IIKQr9s3sS0JGnkmcgt62Yqe9rc4y2Sp3JPc54LFXGpQ+GYA7aR14Abxp6Lu1SJ64DqT7gBble1jEU8uUHs0vcBWra32GDfF5paUEO+UefyjIrayajUJKFxArRUQyRTQq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=V6bsp8Ob; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-382296631f1so1333174f8f.3
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1731832345; x=1732437145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK4WZjisXiLa4RGvV3QpavT3gWK1y9Oz1eyCL48Z860=;
        b=V6bsp8Ob/fQPreLTvKOnUZKk6skJcHrJ2GqdmiQcbnzH4+xbD6s2S+hW9TdU7Ibq4S
         shPDQS1HZLSmuOvvcr8UNUOf05LAKtY+1p+Fn5ZG8SHUso+x6xVcEvaWdNTz77Coodsb
         xEtEr6WC3RMwUdkGe8lfir2e80o+LxHoEFHuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731832345; x=1732437145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK4WZjisXiLa4RGvV3QpavT3gWK1y9Oz1eyCL48Z860=;
        b=QOQCUrG6Am0Ul1IKTKapE10rAl2q+p6mroYLHC0w5o6JgUnjX82ZSH/YrA6bYDfvso
         ifB9iKYNWZWXT4ipObGyOMXACOL/Qwk+nKVI5oh0rC6OPvF8siG5TXNYklwGriGtFbbB
         D+DxpBp/ZZecAotvcnjJBUdNYWJv6cgy/fl9FsXYN2Lu8LCeQRobc9P9l/j8iRdIEjrj
         qJjjl8tE98tsgn3ioE0kaHSeZNLT5aXRZuryOGRaPrvxXb/CRHbGtBK640w02u/5cQpT
         idaTf5xuVxQKGH7GXX4EGX84/F6JjHBRwObYZLZiB6LqXEkAfreczOJT2wIOli9+3nrZ
         kEEg==
X-Forwarded-Encrypted: i=1; AJvYcCWDQE7o7mUrao9z10Se2fqJhC4RmMZel6E4N1H35N8e07TV/dukfDyzTD/qsBmOLNts7VkU34Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMyrRpagjFJmG0COVrbhv4+ZhPp8qyoi/LJV59NcjOVOGJ1x/
	L/iqWVkKAem0qid+VnTzpN2TSt00uoeeZcPOfv9GGyGlL8o3j0OHLYB1YiGxSE0=
X-Google-Smtp-Source: AGHT+IFCKRSWGFYQbti82L7zlgY59h7hQq8RHOb43YX795Ddzzq+WFz4YJqy/z4OU4bhQAmCe1QkKw==
X-Received: by 2002:a05:6000:714:b0:37d:5405:817b with SMTP id ffacd0b85a97d-3822590b819mr7612385f8f.7.1731832345156;
        Sun, 17 Nov 2024 00:32:25 -0800 (PST)
Received: from able.tailbefcf.ts.net (94-43-143-139.dsl.utg.ge. [94.43.143.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae1685csm9466919f8f.83.2024.11.17.00.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 00:32:24 -0800 (PST)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: linux-kernel@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 3/5] USB: serial: qcserial: add EM9xxx (SDX55) IDs and configurations
Date: Sun, 17 Nov 2024 12:31:13 +0400
Message-ID: <20241117083204.57738-3-intelfx@intelfx.name>
X-Mailer: git-send-email 2.47.0.5.gd823fa0eac
In-Reply-To: <20241117083204.57738-1-intelfx@intelfx.name>
References: <20241117083204.57738-1-intelfx@intelfx.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a port of the corresponding change from the qcserial.c driver
distributed as part of the 9X50 SDK. It was not tested by the author.

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 drivers/usb/serial/qcserial.c | 55 ++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index c7167242e235..f1b0ef9935bb 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -28,6 +28,8 @@ enum qcserial_layouts {
 	QCSERIAL_HWI = 3,	/* Huawei */
 	QCSERIAL_SWI_9X50_MBIM = 4, /* Sierra Wireless 9x50 "MBIM USBIF" */
 	QCSERIAL_SWI_9X50_PCIE = 5, /* Sierra Wireless 9x50 "PCIE USBIF" */
+	QCSERIAL_SWI_SDX55 = 6, /* Sierra Wireless SDX55 */
+	QCSERIAL_SWI_SDX55_RMNET = 7, /* Sierra Wireless SDX55 */
 };
 
 #define DEVICE_G1K(v, p) \
@@ -38,6 +40,10 @@ enum qcserial_layouts {
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI_9X50_PCIE
 #define DEVICE_SWI_9X50_MBIM(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI_9X50_MBIM
+#define DEVICE_SWI_SDX55(v, p) \
+	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI_SDX55
+#define DEVICE_SWI_SDX55_RMNET(v, p) \
+	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI_SDX55_RMNET
 #define DEVICE_HWI(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_HWI
 
@@ -177,11 +183,18 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI_9X50_PCIE(0x1199, 0x90c1)},	/* Sierra Wireless EM7565 (unknown configuration, found in on-device AT command help) */
 	{DEVICE_SWI(0x1199, 0x90c2)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI_9X50_PCIE(0x1199, 0x90c3)},	/* Sierra Wireless EM7565 "PCIE USBIF" */
-	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
 	{DEVICE_SWI(0x1199, 0x90e4)},	/* Sierra Wireless EM86xx QDL*/
 	{DEVICE_SWI(0x1199, 0x90e5)},	/* Sierra Wireless EM86xx */
 	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
 	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
+	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9190 QDL */
+	{DEVICE_SWI_SDX55(0x1199, 0x90d3)},	/* Sierra Wireless EM9190 */
+	{DEVICE_SWI(0x1199, 0x90d8)},	/* Sierra Wireless EM9190 QDL */
+	{DEVICE_SWI_SDX55_RMNET(0x1199, 0x90d9)},	/* Sierra Wireless EM9190 */
+	{DEVICE_SWI(0x1199, 0x90e0)},	/* Sierra Wireless EM929x QDL */
+	{DEVICE_SWI_SDX55(0x1199, 0x90e1)},	/* Sierra Wireless EM929x */
+	{DEVICE_SWI(0x1199, 0x90e2)},	/* Sierra Wireless EM929x QDL */
+	{DEVICE_SWI_SDX55(0x1199, 0x90e3)},	/* Sierra Wireless EM929x */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */
@@ -476,6 +489,46 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 			break;
 		}
 		break;
+	case QCSERIAL_SWI_SDX55:
+		/*
+		 * Sierra Wireless SDX55 layout:
+		 * 3: AT-capable modem port
+		 * 4: DM
+		 */
+		switch (ifnum) {
+		case 3:
+			dev_dbg(dev, "Modem port found\n");
+			sendsetup = true;
+			break;
+		case 4:
+			dev_dbg(dev, "DM/DIAG interface found\n");
+			break;
+		default:
+			/* don't claim any unsupported interface */
+			altsetting = -1;
+			break;
+		}
+		break;
+	case QCSERIAL_SWI_SDX55_RMNET:
+		/*
+		 * Sierra Wireless SDX55 layout:
+		 * 1: AT-capable modem port
+		 * 2: DM
+		 */
+		switch (ifnum) {
+		case 1:
+			dev_dbg(dev, "Modem port found\n");
+			sendsetup = true;
+			break;
+		case 2:
+			dev_dbg(dev, "DM/DIAG interface found\n");
+			break;
+		default:
+			/* don't claim any unsupported interface */
+			altsetting = -1;
+			break;
+		}
+		break;
 	default:
 		dev_err(dev, "unsupported device layout type: %lu\n",
 			id->driver_info);
-- 
2.47.0.5.gd823fa0eac


