Return-Path: <netdev+bounces-150264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FE49E9A76
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA5164087
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE21BEF8E;
	Mon,  9 Dec 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2E2SzSi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3823312A;
	Mon,  9 Dec 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758004; cv=none; b=MfgZsVtZEmgbzkrS+ZqqAHlOAsDW6YF4R8qjUF/Ky+ktj7jqOrhqKol1UZHZcMI+PmTvqLuV+bsotJPtk2n0nYuLekw6vekj3GmfCLLoO2NaoefPjK0p1wHPmBE9yWVridLvJsm64e/8ImF4+WSbaB9YbfBmAYNeVY0XwgtBZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758004; c=relaxed/simple;
	bh=32fZ2FltM4y9ebWmx9NWnFF9QHAfLue/T6EkweyWMKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jO5hJe/ecaqsXxUEyiqoEvj2w0w+lQ/qdbegiuv0pnVE4I4/yYyA3IqqSi8vU4N0p3Ljpya8MOWbMahlFXQ9bDSZpFORU9oAVo+3Kk3P9BB129nzfghhKh8D3e8OONIiravnrYmMAL07YlWieFQDKP1+JhW5X3OUr23NWtEF9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2E2SzSi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434ab114753so29895405e9.0;
        Mon, 09 Dec 2024 07:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733758001; x=1734362801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XD5KkTOUR7sdY2Mte2HHFyXLJwYOvwevVjoh92gGMBo=;
        b=B2E2SzSiTLUFLwx5Xdo8ByemV2iZjI8+33YJzDXjsFp2SvTmr2ys7gMg1i9VLA5kJH
         IWf+7pbKuVsH9HzrrMIcEvyfdDX9gdi3FZRNp1qWEnz0PTngjjMv3qLeva3Go2x+XW48
         o6YnHdSJg3v8wnGtVOjrp+IsuDrfzRlmFBxVDfw+53zS2n0R8H+IBSWvDGoPcdqS4f84
         1QsllxcYL2BLPkJwy8gqNms+4V3rigS5U8BOOdxHFVvwU4NA02dPgIliu4cvviRv27SZ
         0em0AHeDmS7bnsoiggmnpm/OPMRx3BDWzyoFM0PitCEdShBxtd0sucLYz+l8ccGaUYy9
         qVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758001; x=1734362801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XD5KkTOUR7sdY2Mte2HHFyXLJwYOvwevVjoh92gGMBo=;
        b=KSHJHII49b7trPNZGi0CjNJG8VGVZIW1i0610plToOCqIcX1b/dZ09zH1KGDC1L+Wx
         DIC1AIuhEfS27c0dNZh5ktr0kZbn5Zsi9WQXP4EbTkovWK3vsLsasSTNCQ/c1Rg1n3QR
         zewB0q6WTL2Ef/u7MzypvSEtxGh9ctZEU5tRXPqS10/LGGMOBfoOcfhsffJBij0sijZF
         yFIGEY1PzQ5q21tNpylph9TsSaULECEG3YysseFry+amF44W3arlujvBEXAaS85gLNBi
         ZcZbmgwpEJUWd/0uaf+7nZndiifE9lxHHe7qfVYNdLNMiJeqov3ywl+vP/qPCr2urmuy
         zWvg==
X-Forwarded-Encrypted: i=1; AJvYcCWH+l+/V6NIaDJKSQPVjo5J/X1aJkBdVlq2DjxO+st5X40/rhImnn9kzY/OE170ANZitAhz9kX0uD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwZSNc+81qLZJpdfm7UWHtsdIjmBTJIKwh+gu1uq7JdKZv9Nu
	MmNZWSvxaslw8hGZT+4ozeCVocqiWAp2L5ffYczIeA/q3vBe38gX
X-Gm-Gg: ASbGncum1Db2A9vyasXySfGBJyX5sAIFrradQWyMSif89JeDI4PC1j6uCOzs99Zy95O
	4d00iACM4GxAtrUJ8Gtg9wBWjk2tsNuAenewUBcyMAV+TG+qrG4/610Kbkxkt42UhWPEtq0xbBU
	rRTCP5Yo9O1dY2wzA8XD80U8UkpDdtLuXQBkPY7U3g5JQT0dtGjTrXyu8Hzh/2gZhqAK2908J68
	IypXgZGGzSWgVucfnVgkJCOxXu6v8IZwVRO3Ws0dLAFz5/YzWqBUmKc7YCTxlyK+yFx3v4Vpg==
X-Google-Smtp-Source: AGHT+IEyd1PvqvJ6dInZc5hW4upBqIdUVgkvugLKCXr2Fllrbysc9NyMJ4JrvFJXDzC6+FwIHhMpbw==
X-Received: by 2002:a05:600c:350c:b0:434:a6af:d333 with SMTP id 5b1f17b1804b1-434fff5567cmr9200955e9.16.1733758000641;
        Mon, 09 Dec 2024 07:26:40 -0800 (PST)
Received: from ThinkStation-P340.tmt.telital.com ([2a01:7d0:4800:7:664c:aec9:433c:7b34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dc152sm158081695e9.25.2024.12.09.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:26:40 -0800 (PST)
From: Daniele Palmas <dnlplm@gmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net 1/1] net: usb: qmi_wwan: add Telit FE910C04 compositions
Date: Mon,  9 Dec 2024 16:18:21 +0100
Message-Id: <20241209151821.3688829-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Telit FE910C04 compositions:

0x10c0: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 13 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c0 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c4: rmnet + tty (AT) + tty (AT) + tty (diag)
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 14 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c4 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c8: rmnet + tty (AT) + tty (diag) + DPL (data packet logging) + adb
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 17 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c8 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 0c011d8f5d4d..9fe7f704a2f7 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1365,6 +1365,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c0, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c4, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c8, 0)}, /* Telit FE910C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
-- 
2.37.1


