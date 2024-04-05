Return-Path: <netdev+bounces-85083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8015D8994B4
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 07:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446B7282ED0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 05:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05AF21350;
	Fri,  5 Apr 2024 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDsLW/bW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE02137E
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 05:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712294547; cv=none; b=VSBq6UWw++Xmn28JDNGy4kszbZjGDH/gHOk/0fyUZ7Gl0Y3vy5BzHJTOg9ZLtHcZFKha3aSXhnVh64xNWsN064iT+e4jghgKaGiG/ex/Zk/7t0vhkDcewG03uRSgwf3GggxT/W654BLtbEVb5sN6ZPueQC2dnO5ro15vyYZBCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712294547; c=relaxed/simple;
	bh=iASyBVpS+iAOtI8cPHc/EUwP+RbFb4ahtT2kjom9mC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UtXXgeqeLMuxfUp9TP7KzJj/XvhXhFXn3TkZIZfIHIsk9pHiwtp8x0pttYHPGKkNAdSQwACY7F3pxPYWbpz5ZmOs7XUUYeGpzFSu1Ez0Yjr8LcauXvCMl6mZYD0pg4iACoSd/XpOoYeB+gC7LOkT2NvgBUrzwcLJ4WbJfWjk0xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDsLW/bW; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-5a550ce1a41so1016920eaf.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712294545; x=1712899345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfx8bFYohrifaR52qXmWJPDuLTak+Ov0D7xGl/yPM6o=;
        b=GDsLW/bWFoCacfXzWK2+3yDe0QBrk7wt50xWCwv3YgQeKsK7MBnFDeg4MNcLRI/Z5s
         8xqR3ijPS2ZqbarZu37+aOSwsvRfUpACzQbZyCEeOJvfLk3BcNTdpBfYgNLNB+KMojfR
         V+/W2GpKTp1D5B10LEcGYhVJ86v0wb9xzHS9n7gvQczPtifX/rrFduAykm8YpijTRJaL
         CFvk/1MF++9SlcsH0+9v3RI1IlXjCFYvHgP/q2NNHHTE4FWRYpocJQlPH1ZB49rTPtP7
         ZU+04FqOqpvZe9+3U/5Bkbwtfm3qeyZlXU9hvLgmtYs0UaeQYgNMLduDn/vN1AIE0OJv
         DKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712294545; x=1712899345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mfx8bFYohrifaR52qXmWJPDuLTak+Ov0D7xGl/yPM6o=;
        b=OchVxV6ot554rq0mjpQu3xcEz6/E89rTeFfA0VZo/jGNH3wfmFvKC5rleWzuaEXEsm
         o3Bay+DZcElgL/3wS6ARCrUCO1TJCSTI/QBxkM9yVJKXRMdn9Gi2EvmgAH2YYC0R5nzA
         hT4TathK96Jroya3nQeWDodkHnvHhRT0UXHBCQ+ryAf/f2DcVo2i5VxpnE4SVzQki05P
         Kk4WvJMpC6gOK8MKyyxH5iKmh5SqfgeaRRAdmRiEe8Kxvwz2YSoQsWeiFM2Yiw5aTOC4
         uI7OdUa7kQ8nn7J1SCXOdBB6Ew8vHIkdwaKJQ+A2plssrXnY7CSvsQ+6RssJPdXd3Pfj
         kZQg==
X-Gm-Message-State: AOJu0Yw5kBrjB5gmYLBO5Vv+Tkhx+thjmznQ8p8x5po0Tmjcu6IfmWtB
	bUBOFPFWDfMOV6i8ZMdO+yybfvQ8l8BHO/I42coyMOg/XmxwHRA3OvHjnMVIEJPpwA==
X-Google-Smtp-Source: AGHT+IHY34nJZLmOgj+GQO/fUw9FO/T2EwjY2+MK9neRmdfQtSH01O3YVxxtdtIGIR2OuSnDj2G/0w==
X-Received: by 2002:a05:6820:2608:b0:5a9:ce39:b1ea with SMTP id cy8-20020a056820260800b005a9ce39b1eamr592601oob.1.1712294544894;
        Thu, 04 Apr 2024 22:22:24 -0700 (PDT)
Received: from localhost.localdomain ([2604:abc0:1234:22::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a4adf0d000000b005a9d071cac9sm157787oou.46.2024.04.04.22.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 22:22:24 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: netdev@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>
Subject: [PATCH 1/2] USB: serial: option: add Lonsung U8300/U9300 product
Date: Thu,  4 Apr 2024 22:20:46 -0700
Message-Id: <20240405052045.3620819-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the USB serial option driver to support Longsung U8300/U9300.

ID 1c9e:9b05 OMEGA TECHNOLOGY (U8300)
ID 1c9e:9b3c OMEGA TECHNOLOGY (U9300)

U8300
 /: Bus
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=option, 480M (Debug)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 5, Class=Vendor Specific Class, Driver=, 480M (ADB)
        ID 1c9e:9b05 OMEGA TECHNOLOGY

U9300
 /: Bus
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=, 480M (ADB)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
        ID 1c9e:9b3c OMEGA TECHNOLOGY

Tested successfully using Modem Manager on U9300.
Tested successfully AT commands using If=1, If=2 and If=3 on U9300.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/usb/serial/option.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 55a65d941ccb..27a116901459 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -412,6 +412,10 @@ static void option_instat_callback(struct urb *urb);
  */
 #define LONGCHEER_VENDOR_ID			0x1c9e
 
+/* Longsung products */
+#define LONGSUNG_U8300_PRODUCT_ID		0x9b05
+#define LONGSUNG_U9300_PRODUCT_ID		0x9b3c
+
 /* 4G Systems products */
 /* This one was sold as the VW and Skoda "Carstick LTE" */
 #define FOUR_G_SYSTEMS_PRODUCT_CARSTICK_LTE	0x7605
@@ -2054,6 +2058,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, ZOOM_PRODUCT_4597) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, IBALL_3_5G_CONNECT) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U8300_PRODUCT_ID),
+	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U9300_PRODUCT_ID),
+	  .driver_info = RSVD(0) | RSVD(4) },
 	{ USB_DEVICE(HAIER_VENDOR_ID, HAIER_PRODUCT_CE100) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(HAIER_VENDOR_ID, HAIER_PRODUCT_CE81B, 0xff, 0xff, 0xff) },
 	/* Pirelli  */
-- 
2.39.2


