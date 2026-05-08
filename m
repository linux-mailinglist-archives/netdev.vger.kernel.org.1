Return-Path: <netdev+bounces-285844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PJALOHn/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:40:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 590044F733F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA8630C409E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D13EDAA3;
	Fri,  8 May 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUh6OhU6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D260345CC9
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247148; cv=none; b=p8GRxLEEedhBXakHr8KozTQ+fsHlOG71ZDMow89GTQUb4x9Fg5u28Czxi87EZgxmsbvlrpvOVGG7R+Lj+9HwHhLK7KWTIyuKViZQIgVCA5oR44sL/9fms4JRf1uwg1QJ+JJC1p92Xru+VYyU75fGPJ8T7OFjrY5jvCroj7UGrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247148; c=relaxed/simple;
	bh=MkCAiMy4tek0ZfaDZJvlcgkp2frcWs2a3Py/5WNty68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeGe0RwdS3sAhDs4kT5DjHzBxSdp9KCm+BB649hYfQ6VSU0D/Af+ioJWS6E16Jgr11IQStZH0/0V9EMeMOsr6IH+7mYV9vR4Hplb/WsLsQrhNabpZ7QleRwOpw91rL3sQladjqRP2E7Ovn5v6VNyibQulkiZz7uBVWWeyEUo0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUh6OhU6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so2003971f8f.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778247139; x=1778851939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7DhCUiR2nARnCR0sd7foQ/+6u2FijsNZJHR6uVeC/s=;
        b=IUh6OhU6s/ZfFkOU+1iaUqURvHm/9DvsNMAAF+HNjyNmG1b3u88DcEeSwNiu2wkl3S
         tY+PIwgj/9fniOSUVsFNbpu1SeSU5j2EQWBIWBTQnY7MpBCcO3w7gCZ+WJznpbWVd1y/
         w6SiDVL2K62AWxe7jANHk5uIRtVoQRF2R0gxTRR27x+keaRnKeCkMmy76EjzwVZ8DF96
         BjxxefJp5tbkYxUoQXf+Zk2ebZmYfXIPTYHPuz1fCRawFxoOSm14jvhJEOQ2Oxknrsu6
         0XChIk2rOqWH+TCjDZIto2vc+lP2tmBdor5AZUoUr4te2+7Hk30VlX2+foo59Ya93tVw
         dp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247139; x=1778851939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7DhCUiR2nARnCR0sd7foQ/+6u2FijsNZJHR6uVeC/s=;
        b=Uh8C3GWs7tL18zQiQ76BafmaoUUCoqlpBYZAFIv8XuR19PHeWNUpiZDQ+2/QyccEi9
         GZkyOp+Qv6cBO53+fHlORSbw9/2AlwwZoZ6S/BPN9avprsNCnDso4lZQfAoTttxsBsmI
         L5UDElH0J1g9+etcoEaP2gNmYblfP5mQRjsaID5P7YX1oyQZXtHeI+ogMl8+snjn92Fh
         pXoVpO5+XcIhgB7L42TakEKcIV1fPtKvHTKB32EXAL+8G2Q4RVdVwZWSM4NCg3RtjQ0w
         bAmd9ZxJYW+xU7rMboW4gEl2rzSq3kq0ywxcseWVXoPvvOFjlzC7YgAb6L1C5ChQHpBK
         dibw==
X-Gm-Message-State: AOJu0YxV2ixEi1Md5MVF5rwy6KhqPc136a8CMDpyj9CMqxEN9x1gtFIh
	PlXiWdo5g58yAci45j63AxuIyMuBrWPYPUw3dY36XONnZoR+ZtdIL70=
X-Gm-Gg: Acq92OGj/d1vy3mn+DW4vRivprH8yJz5yCB66KKTeaATmD+Y92/NzlLAPB0v3VIZIwu
	aYULPBEDBF4aiGTc9ctXaUszUXLmWeC3eVPkhbAaaMdznOVdP/cyATpeNjlSkadfHtvitBSyp+y
	Q4Eb80GirVTgx3dcAc3m7qqcxpOkqFUyAX8ZN/BcD4haZzGkSWG89K3R7lm/kM2KMcpZ7aYR/LR
	vyZwCqAM9tfdFAbepzSidbPqdH124q8B+pEcFz+y8k9UTWgaai2zc6ft04Td8F8aq8xJytEhQVM
	mdjLjpPKzMYPpgtmbQOmSp2XzdhhF9JkqNB4fGLwu6cwf1M2Nl5ylq3h/Sl1bOlJuDf4onyapWL
	YP5R9oX3mMfQqzbIzu276zX6b8Q97wHBycC4lJ3Ze3cwkfXaUyuuKBcebheAIaln+FZ45LtSOX9
	9mYZf/ND583lVI54SDDi+77DWrBl3rU/DMvmBotiQT6j4MZ8Eb7btL3g0AtCrAt7Wqhtet5KVRu
	ZNcEHSNc7ovrC6WItMq
X-Received: by 2002:a5d:5f87:0:b0:449:b7dd:4a75 with SMTP id ffacd0b85a97d-452ea177716mr11743626f8f.20.1778247139102;
        Fri, 08 May 2026 06:32:19 -0700 (PDT)
Received: from kestro-laptop-linux.kestro.home (94-224-231-213.access.telenet.be. [94.224.231.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm4270885f8f.33.2026.05.08.06.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:32:18 -0700 (PDT)
From: Jan Volckaert <janvolck@gmail.com>
To: bjorn@mork.no,
	johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Volckaert <janvolck@gmail.com>
Subject: [PATCH] USB: serial: option: NET: usb: qmi_wwan: add MeiG SRM813Q
Date: Fri,  8 May 2026 15:31:59 +0200
Message-ID: <20260508133159.564206-1-janvolck@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 590044F733F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285844-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[janvolck@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add support for the Qualcomm Technology Snapdragon X35-based MeiG SRM813Q module.

The module can be put in different modes via AT commands to enable/disable GPS functionality:

MODEM - PPP mode(2dee:4d63): AT+SER=1,1

If#= 0: RMNET
If#= 1: DIAG/ADB
If#= 2: MODEM
If#= 3: AT

P:  Vendor=2dee ProdID=4d63 Rev=05.15
S:  Manufacturer=MEIG
S:  Product=LTE-A Module
S:  SerialNumber=1bd51f0e
C:  #Ifs= 4 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms

NMEA mode(2dee:4d64): AT+SER=51,1

If#= 0: RMNET
If#= 1: DIAG/ADB
If#= 2: NMEA
If#= 3: AT

P:  Vendor=2dee ProdID=4d64 Rev=05.15
S:  Manufacturer=MEIG
S:  Product=LTE-A Module
S:  SerialNumber=1bd51f0e
C:  #Ifs= 4 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms

Signed-off-by: Jan Volckaert <janvolck@gmail.com>
---
 drivers/net/usb/qmi_wwan.c  | 2 ++
 drivers/usb/serial/option.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 05acac10cd2b..94cdb61dca83 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1452,6 +1452,8 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
 	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
 	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
+	{QMI_QUIRK_SET_DTR(0x2dee, 0x4d63, 0)}, /* MeiG SRM813Q w/ Modem(PPP) */
+	{QMI_QUIRK_SET_DTR(0x2dee, 0x4d64, 0)}, /* MeiG SRM813Q w/ NMEA */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c71461893d20..e3827b1e4f27 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2446,6 +2446,12 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x30) },	/* MeiG Smart SRM825WN (Diag) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825WN (AT) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825WN (NMEA) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d63, 0xff, 0xff, 0x30) },	/* MeiG SRM813Q (Diag) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d63, 0xff, 0xff, 0x40) },	/* MeiG SRM813Q (AT) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x30) },	/* MeiG SRM813Q (Diag) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x40) },	/* MeiG SRM813Q (AT) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x60) },	/* MeiG SRM813Q (NMEA) */
+
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
-- 
2.43.0


