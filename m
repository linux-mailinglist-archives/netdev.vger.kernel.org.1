Return-Path: <netdev+bounces-187382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56762AA6BEA
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 09:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452483AE081
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F186126A0FD;
	Fri,  2 May 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JG1dbrDT"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C76268694;
	Fri,  2 May 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171927; cv=none; b=d7wDSIdvIpN1AVQXbhyix8aklwx5yyzHWG0SuhiMYLyrwvSBcucPNA8Zg3x0DZ9rL16LLmeFwX1kDDE5Vl46haF91jSsoSMvtGdMzNkunqzvL7IFV9C5VjuK9y6oTkySPvC4UPOAyJXFLwVamJFThd/LAY1pIN/AgbFT+eG2aMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171927; c=relaxed/simple;
	bh=ziNPHbk0kPuyatOilcicNXBitPf60wx2NzpBujzeioU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chItZWK9UYiHXZun01tZuzSzjpiqXzxHcDNVg8U6BQvfiBpALCMjq4BOoJKsvzfiq5dyUolbjmu2o7HsLQdfshJqvPMs3IHO8lHnaFE+wDMZ0+ZWHB3MgPBw/vXmeR2ZKRmdR+l6g6q1Y/ifTvPAl7AkjppktZv9F4GBSdKFJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JG1dbrDT; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B826A10252E20;
	Fri,  2 May 2025 09:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746171922; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=UzxVWBevlnNiKZXvEOq4zPazQW+x2COEum4wiupL/qQ=;
	b=JG1dbrDTiiO0wJmVl+xQ13FMCLs2uezwNLvtjAjcOUAq3Vl4xvnMSNx7KRhuquYYE4PckC
	HK4h0i6KTmZ+MoQI/UwowBaLKGxB44QgrFFKfSVrlHVK6wLHa+TYcfL7dwOEmst+3m7lIn
	njJAotDlrULHGQN2fqaqAdfOc9lsXFsyKKVNfu9SLkor01F/yhNmLXq9spc91u2yJEGJzw
	9tvl1hmRhF6TWm+x83/f3ugswFRCjUh8Af+2t/rrMDKdqCC1VcFLJ9z0JT56w4iQYTAp9s
	1Daftp0OMkYQfZiAXYIFbOXPqYaaaOzN8C30VvDMaM7cOcD1Ze1Kxsj+3DIEnQ==
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
Subject: [net-next v10 6/7] ARM: mxs_defconfig: Update mxs_defconfig to 6.15-rc1
Date: Fri,  2 May 2025 09:44:46 +0200
Message-Id: <20250502074447.2153837-7-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250502074447.2153837-1-lukma@denx.de>
References: <20250502074447.2153837-1-lukma@denx.de>
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


