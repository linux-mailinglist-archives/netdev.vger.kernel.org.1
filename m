Return-Path: <netdev+bounces-288753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPV1B7zfCWqctgQAu9opvQ
	(envelope-from <netdev+bounces-288753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0C561FE4
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48D3C30074E7
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522523BB119;
	Sun, 17 May 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7x8m+/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA323BA236
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779031974; cv=none; b=qNhtbM4Y0+4fLTXhtZjF0y7JUY6UxPFVVAHhPN4F9AJCXzNsemlIDWde0SpCYu7t5iPA8FH/S/0RZNmna6T/IWzcpXrbdnHggmCz7ssNGx41qiol626vcoJtZrJ7MzZf3JmotyxwsHRxZPM9sY42MfrgySBwzDcBJBDX0BX5WKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779031974; c=relaxed/simple;
	bh=2tkufOR/jZKZCuzrYVZ9yOd0S0iuhquPk021GjzpyPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LU2ebC+Km4VXy58q2EEHQqmyQeSBAyGlndR7/fQ4MhDTE1TSK4+xSgbU3Ib8aVMAWClxi+jZlYGkMBQgQR2SeAKYdcZQZfQlZBp162P6vtJSjqg2HTcsaJcWPA6NYfDLqQP8JIRF6yPxarIZug4IoRxQPpzheaPYUllcIBr6pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7x8m+/o; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso6109405e9.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779031971; x=1779636771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IBYS5kaBpkah/bhI00bNcuuOGJFf/yupomVsCsUVeo=;
        b=d7x8m+/oSOMfJ6omepMqLjcdURQiIt8C9q+HCee4V3Mjjl16gDeuNVyVTj0Yf6NdGI
         yEjKZACoyqftj39Dh5rAdh52fjmYDFleGLbGhd8O0lGaR0PX0ShFI7pPMUgBV0bC4owR
         nXk9oPN+yNl/DfuT2ascy79rnjFNteWw41sRRujd8UqOJlxznVPf+x9XwAeuA3GRVdS8
         rfUQtXNL24EJi2TyNxN/venQcj5mcj853ra6AgPdTf5aJvQvg67iW95ROLlK6NzNAN4A
         +TeWhu0aqZV652Wrs8OXtTjqJxqRQx81rZT/zWfADR69nxQeYf7ZWNIGL3EwioQou6cV
         hnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779031971; x=1779636771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9IBYS5kaBpkah/bhI00bNcuuOGJFf/yupomVsCsUVeo=;
        b=ITzKIaz8rpZwerJej4HT8mhoq/ECsER7VQjUYW0VtPggXmCMRivLkZhcD7BcVqbIkQ
         EtRy1M/3rZe46tvTry1ovBoadePi5K7Id2hYBlp2J32U6vEshmX5qsyUiH7fvlWoPyIR
         470TzvDiLd2xmTQ7mtINzM7lCA6fdjKULDxxv5VRPsLc5vndWKsE0W7WMtuL8ZmLKnER
         FvumSnXU+fzxmWVLE02JDDnufTCIqBdpTy1NeJtINmYzcqXOk5zxw+mm/1Ub1CVTUKKM
         JpczDL/50nW4oksQQ/HEZMHpcsrSoR8mehWxoEe/2bQfvO6eKOyX2QBOKgufKWIo7xpU
         BuFA==
X-Gm-Message-State: AOJu0Yy6g12RpZ5jC6DxycM2bImYDR9nhajqTlBj15XqDW/4xSHebU/z
	nAiXgtGAMd91fb2+bE1iOfj4rHX808mBMu6kbol5aKyoAYwpW+yVLhs=
X-Gm-Gg: Acq92OEEJ/Sev6g3ljAr0460v+2qVEljawwubkyD6Jix6+JCw8o8vxbUEo0xiRmUzK7
	GE51HbteCIUMbUSMQJtbNo+yA4etvhBIkNEMtHAD5S6/KiNgEzjL/Eb6pouKz/2QPrEeiUiZhv2
	DgmtEC0FWtizpdke1Kf6MkMVxFymfoivIfz7kD8HS3Ymo2Xl3xh6J0VNlUAgCgEXwyst0LGoHvd
	mw6yRULMgCW3ksdibx88U7FSvPydHjSeNSioWtXjPqQ7g2bwbzWVaPCvi+0n0Y+Aom1wIJqy4iV
	b5mp7WWqNGQ/4mYypf6XDnMeWI9Ah0eJW7bFmNcHhmEitMirrdczyJd8mJS4h/D7+3XVsx7A3XE
	b+++jGm+C472EocsTBKeQkZpxtsdUmIwqdK007vGrnGWMOs/UhSumO7BroEOqudIXLDzM2OVk/H
	uYcgyIDV6bKzneMU4NtpmlwAVJ5Cdu0h9YN7h90jpN0jJWp5M3YxhbIxf50CGT2D/Kw1aiVy8In
	wEWjTLPxA==
X-Received: by 2002:a05:600c:4fc9:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48fe60e368amr150797915e9.6.1779031971102;
        Sun, 17 May 2026 08:32:51 -0700 (PDT)
Received: from kestro-laptop-linux.kestro.home (94-224-231-213.access.telenet.be. [94.224.231.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab290e1sm95307395e9.2.2026.05.17.08.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 08:32:50 -0700 (PDT)
From: Jan Volckaert <janvolck@gmail.com>
To: bjorn@mork.no,
	johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Volckaert <janvolck@gmail.com>
Subject: [PATCH v2 1/2] NET: usb: qmi_wwan: add MeiG SRM813Q
Date: Sun, 17 May 2026 17:32:36 +0200
Message-ID: <20260517153237.55995-2-janvolck@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517153237.55995-1-janvolck@gmail.com>
References: <af3nDLa1A1JcTftq@hovoldconsulting.com>
 <20260517153237.55995-1-janvolck@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54A0C561FE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288753-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
 drivers/net/usb/qmi_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.43.0


