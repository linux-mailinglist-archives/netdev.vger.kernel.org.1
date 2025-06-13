Return-Path: <netdev+bounces-197353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30DAD8361
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35DA1604A1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04317248F63;
	Fri, 13 Jun 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SEjDAttS"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F502F41;
	Fri, 13 Jun 2025 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749797283; cv=none; b=Udhm60PTSH6oavoKV5DIidKo1HzmJOB+qXj/qjntGPphytcJngRyP61BePFL2RVIDCU2tKvu+OW5Wj3PswybdYjZUQYFqLs1gVfKOreta5Ze7TGlp3bmmzIVAQ6ieQwVvpaF2Zh2EVHnR0dpm3Bd6euv+L8vvMk5dbSpUS+E6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749797283; c=relaxed/simple;
	bh=ymBMbvtiTZZthEx06S2LAqkMRzZ9usCHAyrYGOc3hhw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UEI01ZP6PwlCOi2Ledr7NYM9WkgmsXyzAtJA6/9Ty37p7wOuhg0/E4cGqCmKM8fwDAY5wH7VhdoHdLgvzARaI/XOfy4MGqL0K85i18Q2jFDH7foii+EeZXgR9JfCiHlBujP2QfgkObLMz6JXh5POfY+mkt49onJ7fBFOxu1GmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=SEjDAttS; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1749797268;
	bh=GNxwzOmyaguiVAK/TnYJRgd/kxFd/pTS562cfZLBego=;
	h=From:To:Cc:Subject:Date;
	b=SEjDAttSQ2mrDGMP2TdhCwUFieG/9nOe2B6bhqLH7xjSkpUOZD+zNJQSgy7Nj7RlB
	 RKKMijnfQ6WveXvgFvxxW98b5aGahvd1rXxm9o7B55F+D41v9/HFv0DrH/DdALCdQD
	 KCFcyQ40Ha3U27GjeHTfptkvuIyESe+Z/ikTiAxg=
Received: from smart.. ([116.2.183.7])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 89D24E5E; Fri, 13 Jun 2025 14:34:29 +0800
X-QQ-mid: xmsmtpt1749796469t9qj238mb
Message-ID: <tencent_0F1668EB507D97CB15755AB59FA378B1C408@qq.com>
X-QQ-XMAILINFO: NGXqqtj/LXpFvy5vICTku3pECHcCiY+V/Rjn8mhkxGbXtkgsZ/oSRLCtEVKUG9
	 qj6zfWEFhhNLSkTE9BvLhhPUD7YEojvC+ICUMyGn+uMsFn1KIWT/hYdGkFZsGM6NuZrxuGfERzp8
	 P/R+q0ernxEx4kz4pjtU8usEd1b2oJZKzLdG5k0/BtSA5FmqNX9/jUTDQ9BAwBQd9N5iy/a9Jg99
	 qBbT9eBhTAyMbhKfq3sjdnGBIxmGy7dJpkith2j27YYOgNyYWxCUkJgqqoFMU2r1CY8gX7Wr+tqE
	 92ltVrUjXM0Avfqg2wX+0iBmpHS4hFEQ6Pzd1++V6FL0O+53CjDgsHjWSOPtAcVWa0OOOVu/g4n4
	 8y3t9MtSs1tVYiz3vreQXcnEj4JRuxskNZ7G9dLa04YzHPlgnchPQxX2QBNELmAc4MXGkibUYFYi
	 QhdzOqsLBmDyVeQfnASZvSSyVGeaA1TCqOfiIh7PJDX1a4uf8yLfDOH+HDqeYem923ucPW2OGbYl
	 c5iW9y73md2KBttOrdl7S/VMCWa3s66NGMzBXiPowTDw+K0DuB6TvXTAO2WMPb0rXEt45Nj4mvfa
	 RQL+UUwbrxeL+rrVJVNprpcWUozHq91UIvDlrm0v6yyo/mlRLYYhMXTRGauMsukltLSH2DZVLSJH
	 sdkyubD+uyRjk9gNWvYsGS8BOQDsTSGt+RgcqJwPpV19oL3rYq1Z+vZOtHKzY7D00QhjHZ/QxTEw
	 7Jwrf0/CWuOpAW+U7cmm3xAkAeUkfBO4fxR2ShaSblSygT9dtyzOV8IEjAKxwDKlzaFzy+fER4KH
	 AvJCyA+snDSh2PirqvyqDucTT1sqZ7TU2CmIyyedgvS9qo3juJ9qDDXUsSWpFHBXS01j+R8kjlbf
	 MVyWx4Y8zr1vRSBZLA+MibO5f3aSudR0BXWO/0gpG5EdFzYgfWcCf1zrZuceb5lJlc59rBvds+ho
	 yPK4Waxgo+avx6O4buweOyzcdiENyOIN6g1rZ8nP1rtSeY7hu9NIvR9ep9RW6sBAh/CkYZGemsv7
	 DMWlB/N+N39kwQSKf+UgydwW2eLDJKdVZUjSIglngtdbr4Y0V/SaixvGJeZ7tWlC/dLWcPHhspnS
	 YNCq7ido6+mzNewnE=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: dataonline <dataonline@foxmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	dataonline <dataonline@foxmail.com>
Subject: [PATCH] net: usb: qmi_wwan: add SIMCom 8230C composition
Date: Fri, 13 Jun 2025 14:34:27 +0800
X-OQ-MSGID: <20250613063427.2167777-1-dataonline@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for SIMCom 8230C which is based on Qualcomm SDX35 chip.
0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet
T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1e0e ProdID=9071 Rev= 5.15
S:  Manufacturer=SIMCOM
S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
S:  SerialNumber=0123456789ABCDEF
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=none
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: dataonline <dataonline@foxmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index b586b1c13a47..f5647ee0adde 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1426,6 +1426,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x22de, 0x9051, 2)}, /* Hucom Wireless HM-211S/K */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
 	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9001, 5)},	/* SIMCom 7100E, 7230E, 7600E ++ */
+	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9071, 3)},	/* SIMCom 8230C ++ */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
-- 
2.34.1


