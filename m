Return-Path: <netdev+bounces-187638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA2DAA8717
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 16:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DA01898FB2
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796061EF372;
	Sun,  4 May 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="c/gC/XtD"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D11EA7CA;
	Sun,  4 May 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746370584; cv=none; b=EAShb8F89KUEQ0VMJ9fOHA4XJPmXlYDwCxb+mi5LvBT33zfxsFojc+VoKwaTTuIGUCY5U5KBAJBuFpuD3j+4jqVQWicGlfx5aNfUcqGU23bP4kftjaFY3bxCAlWilQLPneKNep+9XXyPfznSLff1CKMQS9uelygm3cRdSFYAbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746370584; c=relaxed/simple;
	bh=WCQHaEUPqnU87ia7YVYTrV2sMCOmmgp0K5SmZTy0bgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FvXfkThCy4bDG852OqVGZf8hv/wHFLOlYmRSavz4I9YrRWk6Go1t0MIVvLUYUuv3n+5dv0uKQfwyrUYVjOLRerWxOXhpUhLAhLUquz/rvS3AL56uuWOx/neKNMGS9MXJaOpB6v1Issl8ATP3dwhqq8khIkEVv1xhsaJwsRraLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=c/gC/XtD; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F75310293387;
	Sun,  4 May 2025 16:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746370579; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+MTHgXBXI80d/WGYJk4hwCsY15MRflC8xTOXUuFqwn8=;
	b=c/gC/XtDxtqkwskhTWhCb74kn3+AJw7DCJZYuwLStFtY9g/fYR177LCLBNwcf85QcPL1YT
	DhlAUSSmXFfe1Gk03Pael7isO68W+wX7cbZqU59cKnGvd/7Rhekv+z2aU5S/TcV4gI+9Aa
	SzGY+1Dj766onXig1LmlVfy73/a68ukZ34tSRFttujcVXPgPejC9Fm0is870Wc9Hpgpfqs
	swyrCD3haIID3lsQUG8mU9D95GyytC4KI6C36uucSF5A5Q7+2I/zBJUzTDRjkyfUhLEY1w
	tXnI7hR5kGgW5mGgDf/Q4rkGum3Eoyf+f3kMbVUgHCVBnHM3Rjllo9qH5r2diw==
From: Lukasz Majewski <lukma@denx.de>
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
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v11 6/7] ARM: mxs_defconfig: Update mxs_defconfig to 6.15-rc1
Date: Sun,  4 May 2025 16:55:37 +0200
Message-Id: <20250504145538.3881294-7-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250504145538.3881294-1-lukma@denx.de>
References: <20250504145538.3881294-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This file is the updated version of mxs_defconfig for the v6.15-rc1
linux-next.

Detailed description of removed configuration entries:
-CONFIG_MTD_M25P80=y -> it has been replaced MTD_SPI_NOR (which is enabled)
-CONFIG_SMSC_PHY=y -> is enabled implicit by USB_NET_SMSC95XX
-CONFIG_GPIO_SYSFS=y -> it has been deprecated by moving to EXPERT and
                        its replacement GPIO_CDEV is enabled by default

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Suggested-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v5:
- New patch

Changes for v6:
- Add detailed description on the removed configuration options
  after update

Changes for v7:
- None

Changes for v8:
- None

Changes for v9:
- None

Changes for v10:
- None

Changes for v11:
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


