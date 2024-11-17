Return-Path: <netdev+bounces-145625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9149D0284
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 09:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F41FB24FF0
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE10618FC7E;
	Sun, 17 Nov 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="a79QmQYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693018D63A
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731832355; cv=none; b=fsXk6aDqjr0756n1TD8SpEX2MGX9g/O7oDHFSMswIBb0SaFJHCcpBej8xpBx5eqcsFRtqYXtBDrgPizY9aCZYmjxsuxyD+92UgW0vLolQLPom2VDDKa4cA9PBkDh7sRpvbqi121cpGSdlrblzM2JauvxA6t9NNEMekd+z/lvFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731832355; c=relaxed/simple;
	bh=dyNI/yaxOyFxwYyVMFZqRo27ArIvOxCuFzInU9ylG7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl3JV7YZHy4GAOQ5WajdXzrIxtqu637+HSEjwrvlN3VlaFFFGUwCOSLMdR3ztDOA/tmxz2yQmeNiFI/P42otPF3fXDAuf2xv+9ZiedqVTT5N8+k1CWKwl9X2DnG48VUny0SBJnOCDOhGt/lvGgCOGOXVaIJmmVpaZfV6oD1H2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=a79QmQYM; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-382378f359dso633992f8f.1
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 00:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1731832352; x=1732437152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xom3uBb5b9/sYwGOmidk6WilUn/pK9olyKnKJBxv3Jg=;
        b=a79QmQYMfHZ6nx6XBt4pmHPa94SR115ZRmIDk3alW3qihd3zAkqgXBU2Aw6SyIwA8z
         m61pOrouoBkC0DsWpNGn2HHJsy/DarzlJ7+7x8uSv2Teiu+hDeamfqXI/LsXaixOTwkg
         PC23/IboCrl1WlrUFKgKnKePwHH+qWjjN5PtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731832352; x=1732437152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xom3uBb5b9/sYwGOmidk6WilUn/pK9olyKnKJBxv3Jg=;
        b=oH38IGiEWN354WNBcsoWxf14mudeLkSJR5YhBVQXzdDJ23srZbrDSMSnuwQxFYNvOi
         LR2N3D8n/9d3GDNClY5RcXIt20KdMfcUslXO5/v+TJdO09MPKaW1TZ3pRBf8pIl6YLbK
         OPwPxbq3teGyNhMjUa2zcIFAEy6ElwwsEe0qHRwVGlVk8MZmOrTDQBiIURhGqQxMIdc6
         +jPE2EmH/2c4LUCTIyzTlRmWsDI8d3HUczVtPGsIwU2u0sI1yucrxwTnL01tOlnmM5MT
         YPh3PMqe2Bv6022K13VRIFmLVA7SyzUxkSd9pBc22M3ISrJpMb3nMuzQMrnp0lUT9Ze9
         qeVA==
X-Forwarded-Encrypted: i=1; AJvYcCUv0MkzyvGrXZjkydJFwGCC90uivLu1QP0dwW/2oRyuY1qEn1b0W0n0AHcBV5vLgh+siTwHo2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mVtu0TRtuk2jyEuMcBvHwKIBwznfMf9grTg1OF86U7ROqgkX
	H2LAzJiAEfhP0fZ59aW9Fxvy4s5BoyCWZIeMYTKj3Dl2TJVkMZBOJP01pZZAjKU=
X-Google-Smtp-Source: AGHT+IGntOurmOmmYz21EdJYG0aSCDtMfDVxiahWE3w+UBoOUvKoLdFK/jvUS9+ZXwLjtqUEaZQKxw==
X-Received: by 2002:a5d:5987:0:b0:381:eb8a:7ddd with SMTP id ffacd0b85a97d-38225a67e3amr5585197f8f.15.1731832352508;
        Sun, 17 Nov 2024 00:32:32 -0800 (PST)
Received: from able.tailbefcf.ts.net (94-43-143-139.dsl.utg.ge. [94.43.143.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae1685csm9466919f8f.83.2024.11.17.00.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 00:32:32 -0800 (PST)
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
Subject: [PATCH 5/5] USB: serial: qcserial: enable ZLP for non-QDL interfaces
Date: Sun, 17 Nov 2024 12:31:15 +0400
Message-ID: <20241117083204.57738-5-intelfx@intelfx.name>
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
distributed as part of the 9X50 SDK, tested using author's own EM7565
device.

The SDK qcserial.c driver enables ZLP unconditionally, however this was
found to break QDL mode (as exercised by the qmi-firmware-update tool
from libqmi[1], as well as the SDK-provided firmware update utility).
Thus, ZLP is limited to non-QDL interfaces.

[1]: https://www.freedesktop.org/wiki/Software/libqmi/

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 drivers/usb/serial/qcserial.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index b2ae0b16bc2b..d51d022d76b1 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -32,6 +32,11 @@ enum qcserial_layouts {
 	QCSERIAL_SWI_SDX55_RMNET = 7, /* Sierra Wireless SDX55 */
 };
 
+enum qcserial_flags {
+	QC_SENDSETUP = (1 << 0),
+	QC_ZLP = (1 << 1),
+};
+
 #define DEVICE_G1K(v, p) \
 	USB_DEVICE(v, p), .driver_info = QCSERIAL_G1K
 #define DEVICE_SWI(v, p) \
@@ -262,7 +267,7 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 	__u8 nintf;
 	__u8 ifnum;
 	int altsetting = -1;
-	bool sendsetup = false;
+	unsigned long flags = 0;
 
 	/* we only support vendor specific functions */
 	if (intf->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
@@ -301,6 +306,9 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 	/* default to enabling interface */
 	altsetting = 0;
 
+	/* default to enabling ZLP */
+	flags |= QC_ZLP;
+
 	/*
 	 * Composite mode; don't bind to the QMI/net interface as that
 	 * gets handled by other drivers.
@@ -386,11 +394,11 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 			break;
 		case 2:
 			dev_dbg(dev, "NMEA GPS interface found\n");
-			sendsetup = true;
+			flags |= QC_SENDSETUP;
 			break;
 		case 3:
 			dev_dbg(dev, "Modem port found\n");
-			sendsetup = true;
+			flags |= QC_SENDSETUP;
 			break;
 		default:
 			/* don't claim any unsupported interface */
@@ -446,11 +454,11 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 		switch (ifnum) {
 		case 2:
 			dev_dbg(dev, "Modem port found\n");
-			sendsetup = true;
+			flags |= QC_SENDSETUP;
 			break;
 		case 3:
 			dev_dbg(dev, "NMEA GPS interface found\n");
-			sendsetup = true;
+			flags |= QC_SENDSETUP;
 			break;
 		case 4:
 			dev_dbg(dev, "DM/DIAG interface found\n");
@@ -475,11 +483,11 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 		switch (ifnum) {
 		case 0:
 			dev_dbg(dev, "Modem port found\n");
-			sendsetup = true;
+			flags |= QC_SENDSETUP;
 			break;
 		case 1:
 			dev_dbg(dev, "NMEA GPS interface found\n");
-			sendsetup = true;
+			flags |= QC_SENDSETUP;
 			break;
 		case 2:
 			dev_dbg(dev, "DM/DIAG interface found\n");
@@ -502,7 +510,7 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 		switch (ifnum) {
 		case 3:
 			dev_dbg(dev, "Modem port found\n");
-			sendsetup = true;
+			flags |= QC_SENDSETUP;
 			break;
 		case 4:
 			dev_dbg(dev, "DM/DIAG interface found\n");
@@ -522,7 +530,7 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 		switch (ifnum) {
 		case 1:
 			dev_dbg(dev, "Modem port found\n");
-			sendsetup = true;
+			flags |= QC_SENDSETUP;
 			break;
 		case 2:
 			dev_dbg(dev, "DM/DIAG interface found\n");
@@ -551,7 +559,7 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 	}
 
 	if (!retval)
-		usb_set_serial_data(serial, (void *)(unsigned long)sendsetup);
+		usb_set_serial_data(serial, (void *)flags);
 
 	return retval;
 }
@@ -559,15 +567,17 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 static int qc_attach(struct usb_serial *serial)
 {
 	struct usb_wwan_intf_private *data;
-	bool sendsetup;
+	unsigned long flags = 0;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	sendsetup = !!(unsigned long)(usb_get_serial_data(serial));
-	if (sendsetup)
+	flags = (unsigned long)(usb_get_serial_data(serial));
+	if (flags & QC_SENDSETUP)
 		data->use_send_setup = 1;
+	if (flags & QC_ZLP)
+		data->use_zlp = 1;
 
 	spin_lock_init(&data->susp_lock);
 
-- 
2.47.0.5.gd823fa0eac


