Return-Path: <netdev+bounces-48855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63E7EFC11
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F33A1C20B59
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DD4655A;
	Fri, 17 Nov 2023 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXxd0tLo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252ABB0;
	Fri, 17 Nov 2023 15:19:37 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c51682fddeso38508781fa.1;
        Fri, 17 Nov 2023 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700263175; x=1700867975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW/yy30PlOuRE3Ej4NxBIfTdb4xQ3p8Y9PrdBaKyzLs=;
        b=fXxd0tLo5/y+/L1vgz7ry7heZyGs62pV7FvR0EhNMgsTYkAPC3xK69EEDJ/vKUimUQ
         NvzFF4VpgIWo5QsfjDMdPF1n4GdQ0Y89q0b8cJyTnkmCOz5BltNKTmaRkbiOXNgZi/p8
         dVlIWS/fT4tcSrFZlp2cdi80leiu6KP3EKBIfERo9TsGClqqpEo5hYOvGmC/y0IyACIk
         gulh0rs8r3rxmlChSsyvpGaDac3tlhYhHjvuC9yMGBWbp683/l3d39CX8H/MZ+Sh6cBB
         Y4+Wr5eU7QtMfkOBH3nmBGm3lrDzBXl2aQy102KoCszGFZOJz4ygQ+nWRCaMbQ2DUIFM
         SZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700263175; x=1700867975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW/yy30PlOuRE3Ej4NxBIfTdb4xQ3p8Y9PrdBaKyzLs=;
        b=Xt/7LwihRQLaLxrr711IRJ7wYcpXnbo2mvsrut6rXjtjA2r/ByWp5B+Xnt6EeotvmF
         YdY7Bcwwa+NbKf6vJwDRh6RRoqyqrZMoW3WhiaVuKGu1dgNhOI9r44UOAzKwCpMf/XUc
         FsYTTqy3FE6hXFSS5LljZ/547GN0wl49KB4FY8iZfxBetl5os711VKYzwZA2L8VlpF8O
         rQsUS7lvk5AkqQvPWI2zWZDa1MOVcjQfwMP7KIVE+cmEGPo3Mt6WdInLfHWCxQJlaeSw
         tzSz1zOdN6XdcleBYb9/OnsdIWqCpSBhxcrvOwSBjLw2imv+lIVWLkixEv72pjU7G7OD
         0PRg==
X-Gm-Message-State: AOJu0YzTMft6euofdFHb7A8U3BF39PlIeAkcaSZDHMjEhoUx1JLdplA8
	s6H4DSlRhNKX5kFhVLpfB3lvnv9eQSACeA==
X-Google-Smtp-Source: AGHT+IH8aEFie+R43aD71/14qAOta29+7FsLfVGK0Vn3200HJrIvIWGgEFL6ZnM1oj7WGH6ouHKRAQ==
X-Received: by 2002:ac2:4e10:0:b0:501:ba04:f352 with SMTP id e16-20020ac24e10000000b00501ba04f352mr3339819lfr.1.1700263175225;
        Fri, 17 Nov 2023 15:19:35 -0800 (PST)
Received: from rafiki.local ([89.35.145.100])
        by smtp.gmail.com with ESMTPSA id q22-20020ac246f6000000b005095881dc1asm377788lfo.87.2023.11.17.15.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:19:34 -0800 (PST)
From: Lech Perczak <lech.perczak@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Lech Perczak <lech.perczak@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 1/2] usb: serial: option: don't claim interface 4 for ZTE MF290
Date: Sat, 18 Nov 2023 00:19:17 +0100
Message-Id: <20231117231918.100278-2-lech.perczak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117231918.100278-1-lech.perczak@gmail.com>
References: <20231117231918.100278-1-lech.perczak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Interface 4 is used by for QMI interface in stock firmware of MF28D, the
router which uses MF290 modem. Free the interface up, to rebind it to
qmi_wwan driver.
The proper configuration is:

Interface mapping is:
0: QCDM, 1: (unknown), 2: AT (PCUI), 2: AT (Modem), 4: QMI

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=19d2 ProdID=0189 Rev= 0.00
S:  Manufacturer=ZTE, Incorporated
S:  Product=ZTE LTE Technologies MSM
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms

Cc: Johan Hovold <johan@kernel.org>
Cc: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Lech Perczak <lech.perczak@gmail.com>
---
 drivers/usb/serial/option.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 45dcfaadaf98..ff9049db6e65 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1546,7 +1546,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0165, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0167, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0191, 0xff, 0xff, 0xff), /* ZTE EuFi890 */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0196, 0xff, 0xff, 0xff) },
-- 
2.39.2


