Return-Path: <netdev+bounces-145622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ACF9D027D
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 09:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F5BB22D07
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B101422AB;
	Sun, 17 Nov 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="V598YzfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704E12C499
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731832346; cv=none; b=hzqcb0UcdWr2CMXFOHW5wM1XmkKucnHPBfFyU8q9ZmsAA/vtg+LKoY7/xcloooQ/piR9ZsxdXsnVvnfc8aOWtkakT/DT5iFRiHfr3+19s2MF+Yck6tzDy2IhEw5dM9RIqWwbdeFvSojaML4xzzxQ2Qs8CsKTfFjZg5Cj80Zn/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731832346; c=relaxed/simple;
	bh=eU5NyTFEX/54/n12G9K/uPw2uOx1/C9JJOPt0bYsQiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJfwZ8GYCqQOZJpYBYIcm6HIJx7nRmrIrHwjSYdqkJABXfnmiqt3GxSN5ix+u2OljNbZczGS4DUCTJPXCONc5hnSyY4FdBOAxLb8Ei/wJtSqaHzhDKTTwr/eUdwIAj/EUdUkgwfEBcq3ayK+2C6pcz107vzSFZ0EJen+IFd7H1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=V598YzfH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43169902057so26483955e9.0
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 00:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1731832342; x=1732437142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFOA/yNMB3vCwH1wnNsMgep9hJHa+oh6MsEyHh9pwYw=;
        b=V598YzfHGLFg4CmJUHOCk8H4xYIOW5IAjPqGlgWf5NyzELZPzrhR6OaZcU4Ws/5n7O
         DqYhtkxaHhfmc6mogy7t/W8iorhlT9+csdf/2tOPLK9kxSMPefE7YNesnT+UMnoj4ITJ
         BWAXgmJvLP1GkANDU1oX7i8zwHu6omsRYApwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731832342; x=1732437142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFOA/yNMB3vCwH1wnNsMgep9hJHa+oh6MsEyHh9pwYw=;
        b=d5yQ4D2x+NVZIRMhnFKgEMAzDsS+HRL1TCA8mryLSRnlGiD6Ps/vwjCiBkFwYqPN/K
         yZjxFie1XirSbD9ZrPpezy4NEjFp7lGtCqud2GY5PQshXupUupFTcWgwQ8TrK4Y7BJmw
         +adnuAaqBYKm4Cgp/K54D8wIxKKQD2LgLgxa/0xObH1c00MvsdIG6jtr6q2kNXcxNrGx
         b4wYI/oklSyKDpiab/u+y2Ba+LPotPYnvUOi3aHmcH0g149wQOTsZfqdAdZDOPr9Ea2N
         lt7x5X0lMglHkmgFMYWTMuQlcaeBJFCm//0oCk5C2D/LKydp4E66JHQj+IOj5leiAD5b
         dNRg==
X-Forwarded-Encrypted: i=1; AJvYcCVxIiefETER7nnI+4H8njNtdhX4AzwbneVucMT0NHpEPj+igi5BPDWIZeYevhXFY7kOCkUGphc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUq11C2wME7RjBIfZyQSiqn0l5LrDi6mhxHIKUH6ljehShDs0p
	xYsmEAJH4oqobOZdTC8prTnvM8l6U53uaqiN14EAKa5O3KCA+bGNZ4SIFhc1wx1VKNuSpqZjlBo
	ByBtqZg==
X-Google-Smtp-Source: AGHT+IHDnj1MMhfE18u/+gecgHN/Su5hE0ego5ddaxfSYgYFHEtmLtoDQ1h+sTFoZudsRUpAWcd0PQ==
X-Received: by 2002:a5d:6c69:0:b0:37c:d12c:17e5 with SMTP id ffacd0b85a97d-38225a05af2mr5179598f8f.23.1731832342260;
        Sun, 17 Nov 2024 00:32:22 -0800 (PST)
Received: from able.tailbefcf.ts.net (94-43-143-139.dsl.utg.ge. [94.43.143.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae1685csm9466919f8f.83.2024.11.17.00.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 00:32:21 -0800 (PST)
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
Subject: [PATCH 2/5] USB: serial: qcserial: add EM7565 (9X50) IDs and configurations
Date: Sun, 17 Nov 2024 12:31:12 +0400
Message-ID: <20241117083204.57738-2-intelfx@intelfx.name>
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
distributed as part of the 9X50 SDK, tested and augmented via
investigation of author's own EM7565 device.

The "MBIM USBIF" configurations correspond to the `AT!USBCOMP=1,1,xxx`
on-device USB composition setting. When activated, the VID:PID resets
to 1199:90b1 ("application" mode) + 1199:90b0 ("boot" mode, i.e. QDL).

The "PCIE USBIF" configurations correspond to the `AT!USBCOMP=1,2,xxx`
on-device USB composition setting. Similarly, when activated, VID:PID
resets to 1199:90c3 ("application" mode) + 1199:90c2 ("boot" mode).

The existing 1199:9091 and 1199:9090 VID:PID pairs correspond to the
"Legacy/Generic" configuration, activated by the `AT!USBCOMP=1,3,xxx`
on-device USB composition setting.

The supported interfaces and their numbers in both these configurations
were confirmed by manual testing. Additional available interfaces
(not claimed by the qcserial driver, such as ADB) found by investigation
were documented in the comments for posterity.

The "MBIM USBIF" and "PCIE USBIF" labels come from on-device help:

---8<---
AT!USBCOMP=?
!USBCOMP:
AT!USBCOMP=<Config Index>,<Config Type>,<Interface bitmask>
  <Config Index>      - configuration index to which the composition applies, should be 1

  <Config Type>       - 1:MBIM USBIF, 2:PCIE USBIF, 3:Legacy-Generic, 4:RNDIS

  <Interface bitmask> - DIAG     - 0x00000001,
                        NMEA     - 0x00000004,
                        MODEM    - 0x00000008,
                        RMNET0   - 0x00000100,
                        MBIM     - 0x00001000,
  e.g.
  10D  - diag, nmea, modem, rmnet interfaces enabled
  1009 - diag, modem, mbim interfaces enabled

  The default configuration is:
  at!usbcomp=1,3,10F

OK
---8<---

Additionally, a fourth PID pair (1199:90c1, 1199:90c0) has been
extracted from on-device help:

---8<---
AT!USBPID=?
APP   BOOT
9091, 9090
90B1, 90B0
90C1, 90C0

OK
---8<---

It is not clear which configuration it corresponds to, but it is
included in the patch for completeness.

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 drivers/usb/serial/qcserial.c | 73 +++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 13c664317a05..c7167242e235 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -26,12 +26,18 @@ enum qcserial_layouts {
 	QCSERIAL_G1K = 1,	/* Gobi 1000 */
 	QCSERIAL_SWI = 2,	/* Sierra Wireless */
 	QCSERIAL_HWI = 3,	/* Huawei */
+	QCSERIAL_SWI_9X50_MBIM = 4, /* Sierra Wireless 9x50 "MBIM USBIF" */
+	QCSERIAL_SWI_9X50_PCIE = 5, /* Sierra Wireless 9x50 "PCIE USBIF" */
 };
 
 #define DEVICE_G1K(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_G1K
 #define DEVICE_SWI(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI
+#define DEVICE_SWI_9X50_PCIE(v, p) \
+	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI_9X50_PCIE
+#define DEVICE_SWI_9X50_MBIM(v, p) \
+	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI_9X50_MBIM
 #define DEVICE_HWI(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_HWI
 
@@ -165,6 +171,12 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x907b)},	/* Sierra Wireless EM74xx */
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
+	{DEVICE_SWI(0x1199, 0x90B0)},	/* Sierra Wireless EM7565 QDL */
+	{DEVICE_SWI_9X50_MBIM(0x1199, 0x90B1)},	/* Sierra Wireless EM7565 "MBIM USBIF" */
+	{DEVICE_SWI(0x1199, 0x90c0)},	/* Sierra Wireless EM7565 QDL */
+	{DEVICE_SWI_9X50_PCIE(0x1199, 0x90c1)},	/* Sierra Wireless EM7565 (unknown configuration, found in on-device AT command help) */
+	{DEVICE_SWI(0x1199, 0x90c2)},	/* Sierra Wireless EM7565 QDL */
+	{DEVICE_SWI_9X50_PCIE(0x1199, 0x90c3)},	/* Sierra Wireless EM7565 "PCIE USBIF" */
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
 	{DEVICE_SWI(0x1199, 0x90e4)},	/* Sierra Wireless EM86xx QDL*/
 	{DEVICE_SWI(0x1199, 0x90e5)},	/* Sierra Wireless EM86xx */
@@ -345,9 +357,11 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 		/*
 		 * Sierra Wireless layout:
 		 * 0: DM/DIAG (use libqcdm from ModemManager for communication)
+		 * 1: ADB
 		 * 2: NMEA
 		 * 3: AT-capable modem port
 		 * 8: QMI/net
+		 * 12, 13: MBIM
 		 */
 		switch (ifnum) {
 		case 0:
@@ -403,6 +417,65 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 				intf->desc.bInterfaceProtocol);
 		}
 		break;
+	case QCSERIAL_SWI_9X50_MBIM:
+		/*
+		 * Sierra Wireless 9X50 "MBIM USBIF" layout:
+		 * 0, 1: MBIM
+		 * 2: AT-capable modem port
+		 * 3: NMEA
+		 * 4: DM
+		 * 7: ADB
+		 */
+		switch (ifnum) {
+		case 2:
+			dev_dbg(dev, "Modem port found\n");
+			sendsetup = true;
+			break;
+		case 3:
+			dev_dbg(dev, "NMEA GPS interface found\n");
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
+	case QCSERIAL_SWI_9X50_PCIE:
+		/*
+		 * Sierra Wireless 9X50 "PCIE USBIF" layout:
+		 * 0: AT-capable modem port
+		 * 1: NMEA
+		 * 2: DM
+		 * 5: ADB
+		 * No other interfaces possible, presumably this configuration
+		 * means that data exchange is happening via PCIe (but we are
+		 * not making this an error).
+		 */
+		switch (ifnum) {
+		case 0:
+			dev_dbg(dev, "Modem port found\n");
+			sendsetup = true;
+			break;
+		case 1:
+			dev_dbg(dev, "NMEA GPS interface found\n");
+			sendsetup = true;
+			break;
+		case 2:
+			dev_dbg(dev, "DM/DIAG interface found\n");
+			break;
+		default:
+			dev_err(dev,
+			        "unexpected interface for PCIE-USBIF layout type: %u\n",
+			        (unsigned)ifnum);
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


