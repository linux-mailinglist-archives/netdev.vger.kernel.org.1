Return-Path: <netdev+bounces-212818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8FB22143
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB247B6465
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586532EA493;
	Tue, 12 Aug 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qKwdXWse";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y9r/KwOa"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41E2E92CA;
	Tue, 12 Aug 2025 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987476; cv=none; b=E9hRpXgXomvOHfq1v+Bx3nOznQvA7sIQtVtusIv02I0K70P3UakVtktaCqZEYTZLZDyuIYdSzUy87ebp2ltGOquZk634gKFrjwDgTdBJYeQ7sKvNSB6M5TSssat+MeTO0XkCSDyENwBXIArcC40WQ9S40bb4Rz0a1rFX1EB7fZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987476; c=relaxed/simple;
	bh=Nf9bbzXb/zZ4hCaJF/mwGTGH6MvvDvY8LckPuhrtSEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TY6OAmgjLj1Npawcz/KNDWJjy3u691tHw6TgOoYC4kHU+pB07oc91TuAU/mypojO/+j+VfNMO7rUye2CyUeKRt5oKC8pl8ObDJCeYyWHQU82rGIlb7SeckRktSWO/YP6VjIT37FWRtRTvxWwFiQBUjwVUdKHbUqmHIipc5XdUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qKwdXWse; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Y9r/KwOa; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c1Pq518jTz9ty9;
	Tue, 12 Aug 2025 10:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0kstWbLYFeX1vpZ7S0KjeaDewBN9VcchjoVPnwz6Js=;
	b=qKwdXWser7f6e3m/nGPEFgdWh95gxP+rFdRsYsfixbBwf9Nle59tumEWHDxRhWuv2YbuV4
	CLcs54JwNzNKqCtPwFK2tcbkN4Jvg5vTHARB4C4TAsda8+GGY3ZFA5BO7RA5geNYrU6QFI
	gWDzk9W1SQcoRFOnVcOxI9zVJkwedn5igljmj1Kj7PBmEfpilyeR7ji3Uyj74PHG+6kOa7
	lWa6XtU7mPG+Fp/jJsQfEoavhObMyrXYjlAh7qJ5LFn7sCLl7eDSfeAIs2TYs9poaxqK/C
	hOBxa2eChioqE3/H6icffFlpltXgRW/0uYCHt0odNUrcU3I2QAExg8qeZdwxPg==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0kstWbLYFeX1vpZ7S0KjeaDewBN9VcchjoVPnwz6Js=;
	b=Y9r/KwOaEfcL74odLXwmsXR7IhEOjr6RDZRtUD5Z68I9GMWagUeNN/K5C7TfpEaZMRyQ1R
	oDE7/loXi8OQG33w4RzCX46/rCQLokK0b3EY1gdwCSK4XHu48n5gU/wkF6JJ/cFTJKAzHe
	NGXDR4UjLBIII98jTYRZvc13ktK/J2we28Uz1uNodBuqja7IqQ9z+R3r8lN3CuitTTLndR
	EPD1vxJ3BFVlD0QnZWDrSA682QFAesugaq8SSK9wUjSDd1ehOFY4f1jiCIVe+yzZzFaBDy
	Kxz+CFouvHzMV4l6uvwrqVv/JG5oK7owrDM72AGL/uIOKUQEpoNejWpnblTPug==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next RESEND v17 11/12] ARM: mxs_defconfig: Update mxs_defconfig to 6.16-rc5
Date: Tue, 12 Aug 2025 10:29:38 +0200
Message-Id: <20250812082939.541733-12-lukasz.majewski@mailbox.org>
In-Reply-To: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1k3uztebxewjibgtyxo9bqzhud3szgki
X-MBO-RS-ID: ee46242541eda1cdb2d

This file is the updated version of mxs_defconfig for the v6.16-rc5
linux-next.

Detailed description of removed configuration entries:
-CONFIG_MTD_M25P80=y -> it has been replaced MTD_SPI_NOR (which is enabled)
-CONFIG_SMSC_PHY=y -> is enabled implicit by USB_NET_SMSC95XX
-CONFIG_GPIO_SYSFS=y -> it has been deprecated by moving to EXPERT and
                        its replacement GPIO_CDEV is enabled by default

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Suggested-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v5:
- New patch

Changes for v6:
- Add detailed description on the removed configuration options
  after update

Changes for v7 - v17:
- None
---
 arch/arm/configs/mxs_defconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 22f7639f61fe..b1a31cb914c8 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -32,9 +32,6 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CAN=m
@@ -45,7 +42,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
@@ -60,7 +56,6 @@ CONFIG_ENC28J60=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=y
-CONFIG_SMSC_PHY=y
 CONFIG_CAN_FLEXCAN=m
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC95XX=y
@@ -77,13 +72,11 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_MXS_AUART=y
 # CONFIG_HW_RANDOM is not set
-# CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MXS=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_MXS=y
-CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_STMP3XXX_RTC_WATCHDOG=y
-- 
2.39.5


