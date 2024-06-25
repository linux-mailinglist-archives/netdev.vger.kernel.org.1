Return-Path: <netdev+bounces-106435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873AC91653C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1F5283CA7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF614A0B8;
	Tue, 25 Jun 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxBfCKV1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5714A0AA;
	Tue, 25 Jun 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311227; cv=none; b=lvUuaGExilbX6o1NftpMMgusRzbS+kGeDgx6YbTHbbALLiP8SM+KdhpAcv321GEKnE6x/YaZICUaiXvWximG03aY7ddTwMzt+FIonsOzayN01/vUB+6gYQx1cZOuryZOZ5/5no4HVzhjZjSEo2NW04aC/WPnlzI79lwloAkyajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311227; c=relaxed/simple;
	bh=7Qtgp71+BzcIUEJgdn5Nm+SHa7E/QAv5ZzijEMiTZIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sv6x2RhliqeDlbJV22pxClWJVFR01lBsxldCKtxllp05oww1DkpoiVaDAIpzlB/KnyrTpxPLP3lkJPkJe7oQtxSv+jcNd5MRGJJ4TCyMTCXc4BnqLGbteXa91MILvJVdME+FpHj314gzRkOT0qK6GWbRZ/l20iBb4kNlFy6K6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxBfCKV1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso6318352a12.2;
        Tue, 25 Jun 2024 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719311224; x=1719916024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndUU3uZ6Zd9u4W/+552CURvE9KjzN6S1wQnmLnM8yl8=;
        b=ZxBfCKV1wo/dufUMKZS8i8nJ+jza7rXALArkiGm8e0BvCBugSWGlLUKxovDXc/uWZV
         AjUt8ttuiwLFYQr1dXDFllSKO21PS5s6qBaZr8sbG32aUyohDTa6LfA9xIK36Adi0gEK
         D6J0m4aVzyMsLj0Y9dPd2DzsaACdNEz2fyMcdTAf1tSyvXkvp2v1a9nxyYVHAMndaMIq
         HHEVm9yorMh6vVJRWD866dO0cNh/0CEMJEsha0ue2UsZM1xE+xDkbD0sMpqrvtqzlP4c
         DlwtYlO/Oatmf2tQCP/DYn63NN1uXRhbx7WCi5OuF9W+B+FMcww5SGESonahEC/WTSq4
         dD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719311224; x=1719916024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndUU3uZ6Zd9u4W/+552CURvE9KjzN6S1wQnmLnM8yl8=;
        b=mIasLmwqnNPCSH3i2Hs9f1jr2/E3GTfj6zJcBYLdsf6OPZBn7sYRUmkYlms9zmvayC
         VO4KLlR+/rC4rMN4BsB4azcGXu1S2+ClNj6cQC5b1qREWNfB6XnUpPDw+UFM9FhBTgBE
         uuK1ds8ORCAoh2gxSOYJ+SzLhDAD+f+F94aqxGXQV0qoqgTbEsfwyfRlMv0ilY5DcfG4
         rsRFPn//LMAY1N8ezRK1FHHlJ+ZfgwpLP4rFhVUX0dUvymQjHzJRNEkksh/puQVKRLuQ
         wokwa0eMT7BE99lV1ewlRsJ1DrzdmO2hoIHaIi4rM7RiqSHF17PCX5lliFvbIsJGeyCW
         dImQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvaRvPjM3ABJAgsGvZJpMzP+f6tCv1DUtqW6M+y4de3bTkSnAPKOMxTkDFylVrJuYXFBW13LUZYxyjHjIGCvEoY+MfieNHxHf3
X-Gm-Message-State: AOJu0Yy0QPe/2xfcWrwbrz42xF8PEhcRdNdx89Gx5Hta4cRBgaipLJOz
	NUlxMbQAGEi/TA8x75lVMH1sOmX4GCZcFEb9HhQAwh8h/HuZpHit
X-Google-Smtp-Source: AGHT+IGnvry/TKO+R6+cTKLpTEIbeUzpq7lzSSIBNA8seZoSJKdTTTXFg/T7X3vsUH5CQYX+gf+QWw==
X-Received: by 2002:aa7:c34f:0:b0:57d:4f47:d9ee with SMTP id 4fb4d7f45d1cf-57d4f47dbb1mr5642090a12.31.1719311223606;
        Tue, 25 Jun 2024 03:27:03 -0700 (PDT)
Received: from ThinkStation-P340.tmt.telital.com ([2a01:7d0:4800:7:e733:8331:ea5b:c314])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303da254sm5745444a12.1.2024.06.25.03.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:27:03 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net 1/1] net: usb: qmi_wwan: add Telit FN912 compositions
Date: Tue, 25 Jun 2024 12:22:36 +0200
Message-Id: <20240625102236.69539-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Telit FN912 compositions:

0x3000: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=03 Lev=01 Prnt=03 Port=07 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=3000 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN912
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

0x3001: rmnet + tty (AT) + tty (diag) + DPL (data packet logging) + adb
T:  Bus=03 Lev=01 Prnt=03 Port=07 Cnt=01 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=3001 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN912
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
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 663e46348ce3..386d62769ded 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1372,6 +1372,8 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1260, 2)},	/* Telit LE910Cx */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1261, 2)},	/* Telit LE910Cx */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x3000, 0)},	/* Telit FN912 series */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x3001, 0)},	/* Telit FN912 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
-- 
2.37.1


