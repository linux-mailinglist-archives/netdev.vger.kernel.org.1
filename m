Return-Path: <netdev+bounces-230113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5667CBE4300
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D06AE358BA5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7BD34BA21;
	Thu, 16 Oct 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYvYZzsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0F345758
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628024; cv=none; b=IEwTZeM7/YXw2YKBJrs24QJhpyGg8duCwhrzhhTwV5XxHkiTd5ujhRwbVnM4PA7YodDdBdIlNryMtJL7HaJsQGJfhxW5FOMqQ291E6YkWXjhrlm33PbT7ngkgyZv7+F6NZhu6DBqJFhAKe1y2pkjvZc90f2HpTpiBeT00Mw3PoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628024; c=relaxed/simple;
	bh=ATZ4y7TGhMFFVfLuYp1L59CJyT+Zpkj0IHhOiBU0xfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPS8O87Ego+LFa7B5csXyvYsS5dK9Zvk8OBB2u6tA6Vy3ExHY4jwztrw/pDz2WRJsuqNCyAuCXMNfxy2wOV4wp6zV8/rLyXz2kR9XsGy3btIvszmRMXhj6UOC6XYQGTWwQMzfy5VMF1y5alsSSLzmjXNl3KGpfxwn+i6MTkeZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYvYZzsG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471131d6121so6599565e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760628019; x=1761232819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsxOTb9JUZ5u9wtirbsy6voO2DgSTWHj8em1tU1OCo0=;
        b=SYvYZzsGeE/NUzQVtqYZk4kA7R/WQt7bdLfTWlO5TS+d7bCvkuvCdNPyaSXwh4+FOJ
         j0NVRFxPEB7wM3H1kuzvNriDmrfZzMKJSLwQ/xcseposlEUKPMelgy48vR2UCQBHaIbS
         Lgf5Sq9WmPz0/ql6VWKv1WHCK0IbKj6QOKwGb8RssN4lMrCq0m+Wq7e9Nk8CQj+31blf
         0/k0lxhNFC6kQcvQSg4qzv8gmur1vZRDfhfJhFKLWXRQ9lCyCuGTwBHbYGFxMf/EKjc5
         d7/6+xD5ufyl/HqC/7U6BphzQxEY5qlAMLDLJ2ob4D35grnSTFE0eJ+nlRfMa37z37vu
         2tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628019; x=1761232819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsxOTb9JUZ5u9wtirbsy6voO2DgSTWHj8em1tU1OCo0=;
        b=gNPWsaaZYXE55FcWGTPcYEhrzKS9f6bdty53PA/Rj66tvAwbrpi7/LRBCPYCArEd65
         KgvjNN2K3EcEKfv5gtu2tka7y800U0n7i64II1fnOuXlHAT7PUoUalzVUQXxIvgWB5cW
         LHyI55f/YPoWWFUYcfT1uXRJEWsIDJImwHBETtosRyG9Wg1d+/0NkdR230v/EmP3UEhW
         e+g/XPEdpDaEeSk8D79bM+8BuDigDtqLpqcNgP/zXH80YijXml5h1v+LkSQHx5yUUJSW
         oseJW0alVmoQdlXULidLWJu/GsMPknIq/9Sy11runs0JBBBYZzQe7vQBL0eohjKYidGr
         BX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc1u07BRpXOx4BIiCuidLSjKXCW1g5TPy7gG80ps3dd5D7doOIyNe5cESgg8wWg4CyJ4niXTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyny03s9OiIWNeMQxzsqgIuk0Krb+NNdUU+mWr3C3coJ3BhJstG
	mDGQcVtaCZ5ybFhTOzx2l8nxXTPDy2bcbWyr9q+OljfeDqauuJJmbAqP
X-Gm-Gg: ASbGncu7ZrWN1TyySoqkocbvW7VKOY4fqTe0pVq/KgsKDcR2AENoJkD+v5JyNC6JeQD
	851v8efdwhOKK9I+n4fm0Wd+ET+fUOM5W6/myKFHbeAHIVpVDAMNn2kaH1OvOiqRKvPCYPMhgmb
	hcRaEiEPoWS6XBWDuY5b0HFqTjAfqN2Aof5r5zr9/q2gYHWrgp6oWKNHk5pRtwhECHD/AMLazpC
	YL5Oyja9By1mfPZmLf+U79h8GSSIVxGJ94ONb+NoIguL/tV1s8WAAq0ZBeVACoFFuIdAf9c2Plm
	yxJ0WVgu+6L81KpfPwoDj9LUvAV0TxLzkMlN5M3hJbr9MhPL5j/mEBFhpldjp3k9EX0Br0g38Mw
	mNHegz9wteRdUrWCpbjBC1bv2veiYCrnJXSOBBJ0iLJzPnBHQgqNZz1FGGSHZOcUuMokNJN0T/S
	T81WqF76dIBlcB0ut7YFKz7bENa6v7n2un+ByOQI0V2/2uoOSR9oXO4Vdq8tQ=
X-Google-Smtp-Source: AGHT+IGoQBnhXiAzUGAeieOJ6ygBO5sWpNQghhB9hLlC0RH4zbkjC/i4Y1s21AiWVS88Am0XrA2OQg==
X-Received: by 2002:a05:600c:474b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47117877525mr3602295e9.15.1760628018992;
        Thu, 16 Oct 2025 08:20:18 -0700 (PDT)
Received: from Ansuel-XPS24.lan (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4711435b06fsm39973125e9.0.2025.10.16.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:20:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frank-w@public-files.de>
Subject: [net-next PATCH] net: phy: as21xxx: fill in inband caps and better handle inband
Date: Thu, 16 Oct 2025 17:20:07 +0200
Message-ID: <20251016152013.4004-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that it's possible to enable inband by not enabling
DPC_RA on a Banana Pi R4 Pro (MT7988a). This was also confirmed on an
Airoha SoC (AN7583) to make sure we are not facing some internal
workaround with the USXGMII PCS. (on the Airoha SoC the PCS is configured
to enable AN when inband is enabled and to disable AN when it's
disabled)

With this new information, fill in the .inband_caps() OP and set the
.config_inband() to enable DPC_RA when inband is enabled.

Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 43 +++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 005277360656..2dd808186642 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -625,12 +625,8 @@ static int as21xxx_probe(struct phy_device *phydev)
 		return ret;
 
 	/* Enable PTP clk if not already Enabled */
-	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
-			       VEND1_PTP_CLK_EN);
-	if (ret)
-		return ret;
-
-	return aeon_dpc_ra_enable(phydev);
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
+				VEND1_PTP_CLK_EN);
 }
 
 static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
@@ -943,6 +939,21 @@ static int as21xxx_match_phy_device(struct phy_device *phydev,
 	return ret;
 }
 
+static unsigned int as21xxx_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	return LINK_INBAND_ENABLE | LINK_INBAND_DISABLE;
+}
+
+static int as21xxx_config_inband(struct phy_device *phydev,
+				 unsigned int modes)
+{
+	if (modes == LINK_INBAND_ENABLE)
+		return aeon_dpc_ra_enable(phydev);
+
+	return 0;
+}
+
 static struct phy_driver as21xxx_drivers[] = {
 	{
 		/* PHY expose in C45 as 0x7500 0x9410
@@ -958,6 +969,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
 		.name		= "Aeonsemi AS21011JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -970,6 +983,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21011PB1),
 		.name		= "Aeonsemi AS21011PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -982,6 +997,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21010PB1),
 		.name		= "Aeonsemi AS21010PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -994,6 +1011,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21010JB1),
 		.name		= "Aeonsemi AS21010JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1006,6 +1025,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21210PB1),
 		.name		= "Aeonsemi AS21210PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1018,6 +1039,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21510JB1),
 		.name		= "Aeonsemi AS21510JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1030,6 +1053,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21510PB1),
 		.name		= "Aeonsemi AS21510PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1042,6 +1067,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21511JB1),
 		.name		= "Aeonsemi AS21511JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1054,6 +1081,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21210JB1),
 		.name		= "Aeonsemi AS21210JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1066,6 +1095,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21511PB1),
 		.name		= "Aeonsemi AS21511PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
-- 
2.51.0


