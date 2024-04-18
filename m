Return-Path: <netdev+bounces-89138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B388D8A985A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702AF2819B6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50E15E5A8;
	Thu, 18 Apr 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFinodbg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32F15DBBB;
	Thu, 18 Apr 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438901; cv=none; b=QHmufMFzdZzlQlXiWKABO2n+tny/DtZzjeaEJUvtKiYtz2Kc9En8HJDK3YYp5HS16RrDYmX5ov0hvcOE0HAn6kKCsnPRfetpRZ38Drdc6Ogngky4PfNlEkACkt7/G8apt2U1FSDASk2HPyfhJuD8gROG4jOqm8JT5nPxwFCS0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438901; c=relaxed/simple;
	bh=uSFfOT3JgHjx0OGrj0HE3NDNs+YSdJ2cF84HuuXu6Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7E3Z1nYkA6HyYil1mFXiF0d/bhQyQmM1eb94aGBWfoaj4UqBGM2Qt6+QKpAUV/v1D+AdOW6S9X4nujy1jw8CczpAi4lXa76PoC5ZwQLr7KwF9n6SF2TVv4Lq7Dxeq4pwBwqNNIG3NaiHhhU2Pe1NCg02j6zXcbJVpRRHZLE65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFinodbg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571bddd74c1so447794a12.0;
        Thu, 18 Apr 2024 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713438898; x=1714043698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVdNWc2S6grNgifjUV9Z9PoYPoQ+C6xx7h8NtvOHzac=;
        b=UFinodbgKStNt8wjWteEDku7yZRfsYm6pmYZztnoOW+ThRfSgiCa6UZ08ySVe1Je8F
         IQ3ZP9D8CvV1dlD5HZ/qwa7D0rvW15fA9ubGwG3PcmidG1rdOP4xX1XPyemY0oh35TsC
         WP4hOsAlktaZYrnFyL5qwxWiH5daq8xFubL2LVeHTy8o5mK+T22CLHq9QTArFPtT2kik
         Sx2COa45xlJot7HrdUgpd7ZsKxN/RzDhYZ9q0X2Hm95NLGYVXCB+IySOevsXFQ7QgdK8
         gXPBUjs6EU2f2b8Zf1i6SEbC5TpuYdCGpONA3Qm3WR1AVt2W4jWlVox3RRHfnZ5JEH9y
         r7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438898; x=1714043698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVdNWc2S6grNgifjUV9Z9PoYPoQ+C6xx7h8NtvOHzac=;
        b=Ltea6XnZyXTV+a3ICGtfEBR7Y9bZXJ/huRjz3y0p1eizmsJ5FsGPSdvpB+emuML4S0
         aXFG/QJy1vYaGE0fIvG6pdjZxMBbpQBfQcjCPlpqqFDfwEVJR0CQqWwGkGsFdpeyO4Bt
         fYxGWpYIKncM7oVYPGvMhYbyoy3XXA5ztvT+w1gMLPzJKYrjN082abfhAUgpgU5xgboE
         Bu10CdqtFiUM0hvWhjyjhM5X5YfyzuxIyZ9eVjGbbnhTSZ2di3eYmikdj6gmXry3MF49
         SAwlkFXpuMLudCS81iMzoRks6tEK+FLqWXwWYfQsO2wgKsbWyVVVtA0aiivz1lTz4Pvg
         xvOA==
X-Forwarded-Encrypted: i=1; AJvYcCWm1AH3Z09RfKztGPOYUTdvP/etT4fJDUvXhLKIheegnDErhGXF391cjgyuUg1tLJKVFk62/UXMGowuI63tCZj9bmox8wYbbSaO
X-Gm-Message-State: AOJu0Yy2BAXzI3mbV1l016p9m5vcQ2nGw4zPHMudVzV1Hw6kFMBF23KH
	dSGYC60V3yDoDwLZZOqf3F0VX+Hdc4kAXDWUvG3WX0SGeXiTKZ1l
X-Google-Smtp-Source: AGHT+IEofVHYSPRLBpoWd7CTlJceAMB223w6wktxRVkqcQR7JZp5pW8+xcylTjyd4vaBwG0x2yko9g==
X-Received: by 2002:a50:8e1d:0:b0:56e:323b:d7e7 with SMTP id 29-20020a508e1d000000b0056e323bd7e7mr1454301edw.34.1713438897880;
        Thu, 18 Apr 2024 04:14:57 -0700 (PDT)
Received: from ThinkStation-P340.tmt.telital.com ([2a01:7d0:4800:7:ec45:6e6c:9755:ee1b])
        by smtp.gmail.com with ESMTPSA id i7-20020a056402054700b0056e78e90a1dsm742576edx.49.2024.04.18.04.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:14:57 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net 1/1] net: usb: qmi_wwan: add Telit FN920C04 compositions
Date: Thu, 18 Apr 2024 13:12:07 +0200
Message-Id: <20240418111207.4138126-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Telit FN920C04 compositions:

0x10a0: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a0 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=92c4c4d8
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

0x10a4: rmnet + tty (AT) + tty (AT) + tty (diag)
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a4 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=92c4c4d8
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

0x10a9: rmnet + tty (AT) + tty (diag) + DPL (data packet logging) + adb
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#=  9 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a9 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=92c4c4d8
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
index edc34402e787..a5469cf5cf67 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1368,6 +1368,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
-- 
2.37.1


