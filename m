Return-Path: <netdev+bounces-97729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C68CCEA6
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921C2B224BD
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10A13D240;
	Thu, 23 May 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mUlfm8Lk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F2339A0;
	Thu, 23 May 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454419; cv=none; b=pQ3J4B1ASnWlIrG8jVdjrp+w0taHTj6gv4V0mwsq/MNizCZCs0N9ccip0chC8Ma2S85H4IeBg8624LcW/4gA/siPEcWXLqAapsXxbD3lavjfqJheytM6eZJ5X/wDmpPYXYcntebfNoqZCcxA01cT5meA4EPSm649mkXrDNmVpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454419; c=relaxed/simple;
	bh=f+FM0Szq7PCxoqI/dTytc3od6T5lYIl+Cf/sm7v/EZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=te93kWul4wFr8+NsneF6x5t7Em0Lne3EKx4vwNEyiQ1oceKdMonNo74aC7dM4ytigfyl/b5CJ+C2REXzHGKZtM83YLkPWHLl1+e/slV1UMA3jViK0YPstzVgg8eg7f39CxpZ6cDMzuOJsMwnzszCS+Ntx4/1gPrQXFFpZYC02a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mUlfm8Lk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716454418; x=1747990418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f+FM0Szq7PCxoqI/dTytc3od6T5lYIl+Cf/sm7v/EZk=;
  b=mUlfm8LknpJilAKLZ/v8Ti5dukx8fZ3iSQ0lg4+C2Su+FOgJFUo1mNv4
   5i33v/fqHUQ8xHoCjOmvyh/eIEilGZMkWIOb5rbo8TX5plkxiM7V1cFK/
   ZZ6i5UUxbQOqwbD2HPLB4IPvUb17gsyS5GzlRW6zgwOU9d4IgJ1u4wuwC
   Dq2vtZ/xCsLkvYNEOk6xEdRqBxxlJODgqfRqDFl9+yvdPxzDkcfyu0/U8
   KYdTYG/hel+VECimt/7wlmt7sg5vR8Vgy2svlAp+69WO2z8C/TvrbVlBe
   E7iExowHWJbvSm/7zHTmDQ15lc4C2KXmYlRDaX+mzcMRKnfyi/no8Uu1B
   g==;
X-CSE-ConnectionGUID: W9KaXAE6RECszhEZa8KEWg==
X-CSE-MsgGUID: d514tyr7Q9KlyWa+X27VZA==
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="25876177"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 01:53:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 01:53:21 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 23 May 2024 01:53:17 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <steve.glendinning@shawell.net>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH] net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM
Date: Thu, 23 May 2024 14:23:14 +0530
Message-ID: <20240523085314.167650-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

LED Select (LED_SEL) bit in the LED General Purpose IO Configuration
register is used to determine the functionality of external LED pins
(Speed Indicator, Link and Activity Indicator, Full Duplex Link
Indicator). The default value for this bit is 0 when no EEPROM is
present. If a EEPROM is present, the default value is the value of the
LED Select bit in the Configuration Flags of the EEPROM. A USB Reset or
Lite Reset (LRST) will cause this bit to be restored to the image value
last loaded from EEPROM, or to be set to 0 if no EEPROM is present.

While configuring the dual purpose GPIO/LED pins to LED outputs in the
LED General Purpose IO Configuration register, the LED_SEL bit is changed
as 0 and resulting the configured value from the EEPROM is cleared. The
issue is fixed by using read-modify-write approach.

Fixes: f293501c61c5 ("smsc95xx: configure LED outputs")
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/usb/smsc95xx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index cbea24666479..8e82184be5e7 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -879,7 +879,7 @@ static int smsc95xx_start_rx_path(struct usbnet *dev)
 static int smsc95xx_reset(struct usbnet *dev)
 {
 	struct smsc95xx_priv *pdata = dev->driver_priv;
-	u32 read_buf, write_buf, burst_cap;
+	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
 	netif_dbg(dev, ifup, dev->net, "entering smsc95xx_reset\n");
@@ -1003,10 +1003,13 @@ static int smsc95xx_reset(struct usbnet *dev)
 		return ret;
 	netif_dbg(dev, ifup, dev->net, "ID_REV = 0x%08x\n", read_buf);
 
+	ret = smsc95xx_read_reg(dev, LED_GPIO_CFG, &read_buf);
+	if (ret < 0)
+		return ret;
 	/* Configure GPIO pins as LED outputs */
-	write_buf = LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
-		LED_GPIO_CFG_FDX_LED;
-	ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, write_buf);
+	read_buf |= LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
+		    LED_GPIO_CFG_FDX_LED;
+	ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, read_buf);
 	if (ret < 0)
 		return ret;
 

base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
-- 
2.34.1


