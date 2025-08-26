Return-Path: <netdev+bounces-216825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C1B3551D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C59681A8D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166C2F659F;
	Tue, 26 Aug 2025 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BlYZC5tg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB082F6589;
	Tue, 26 Aug 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192539; cv=none; b=rsS6ue4xasJuGLmWwiBGgRuNjkuQ5/XEElckmbaWu7REVP+IFuvzt/fA766dRIoXpdvyjIdPJTD5QRSjSEnJfpuUZZieFu2vunoJAPgJDfQSVx4SvLluAXposFLMDNdVmmbYpeWXF0WKG9RdA7vUUcMytumdM1RA74DVNBKh4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192539; c=relaxed/simple;
	bh=GDqmgHytA/OIUmAi3a+R2kiC3Oc9IvjzIFeK2FU1iLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7eULKy2XvsAQkKx72GLFyRMp4+odDm85i8K+sdfXbJMGhWT8Rxsj55hbeHNk7gHqjDtN4V6LddE1u9We0RHTwJu+kSE/uGe/dXNjSBFTqWYeQlrVBPDChuvy7ThlSY/eeIcoe9aorv2ZL7Eb9zohn5icvdx8SYbkB71mylbrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BlYZC5tg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756192535; x=1787728535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDqmgHytA/OIUmAi3a+R2kiC3Oc9IvjzIFeK2FU1iLs=;
  b=BlYZC5tgamnXCeze0lNks5ryCAE6ptbkJSdgZkB9N5lrE1I2S1DoPe8T
   NldD61UpjBdt/h/djweaJ5QuMGJ9blJJwa6NXr7IBfyolo1nt3/0ZG0Ql
   wG3R6e/DvvCT7edlxbYmHm2bes+HhYeJaRgF8Pfsf99Ca/Xhcl1gsEvSm
   hU6/0B96TxxJV1y2bZxEGylIH+xD9KRAjAOLj9ms6ORClwNlzlCKtVGs4
   VYRhf+wdH5X8pllEVtgTid5PLFzoO8ciMq5APXF2SUOkRYGvCi9yrKNUV
   Ow8n8VtRvH4U9+0NBmfBF2dLa8LS6TYxEPd4eOqCh/h4GzmVaDb1Nzbeb
   w==;
X-CSE-ConnectionGUID: 1L/2GLIuTqq74W58nlieXw==
X-CSE-MsgGUID: OEEO4pFcQSePcMFdk44J+A==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="213069546"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 00:15:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 00:15:03 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 26 Aug 2025 00:15:01 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 1/2] net: phy: micrel: Introduce function __lan8814_ptp_probe_once
Date: Tue, 26 Aug 2025 09:10:59 +0200
Message-ID: <20250826071100.334375-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826071100.334375-1-horatiu.vultur@microchip.com>
References: <20250826071100.334375-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce the function __lan8814_ptp_probe_once as this function will be
used also by lan8842 driver. This change doesn't have any functional
changes.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 04bd744920b0d..42af075894bec 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4242,7 +4242,8 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	phydev->default_timestamp = true;
 }
 
-static int lan8814_ptp_probe_once(struct phy_device *phydev)
+static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
+				    size_t gpios)
 {
 	struct lan8814_shared_priv *shared = phy_package_get_priv(phydev);
 
@@ -4250,18 +4251,18 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	mutex_init(&shared->shared_lock);
 
 	shared->pin_config = devm_kmalloc_array(&phydev->mdio.dev,
-						LAN8814_PTP_GPIO_NUM,
+						gpios,
 						sizeof(*shared->pin_config),
 						GFP_KERNEL);
 	if (!shared->pin_config)
 		return -ENOMEM;
 
-	for (int i = 0; i < LAN8814_PTP_GPIO_NUM; i++) {
+	for (int i = 0; i < gpios; i++) {
 		struct ptp_pin_desc *ptp_pin = &shared->pin_config[i];
 
 		memset(ptp_pin, 0, sizeof(*ptp_pin));
 		snprintf(ptp_pin->name,
-			 sizeof(ptp_pin->name), "lan8814_ptp_pin_%02d", i);
+			 sizeof(ptp_pin->name), "%s_%02d", pin_name, i);
 		ptp_pin->index = i;
 		ptp_pin->func =  PTP_PF_NONE;
 	}
@@ -4271,7 +4272,7 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	shared->ptp_clock_info.max_adj = 31249999;
 	shared->ptp_clock_info.n_alarm = 0;
 	shared->ptp_clock_info.n_ext_ts = LAN8814_PTP_EXTTS_NUM;
-	shared->ptp_clock_info.n_pins = LAN8814_PTP_GPIO_NUM;
+	shared->ptp_clock_info.n_pins = gpios;
 	shared->ptp_clock_info.pps = 0;
 	shared->ptp_clock_info.supported_extts_flags = PTP_RISING_EDGE |
 						       PTP_FALLING_EDGE |
@@ -4318,6 +4319,12 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan8814_ptp_probe_once(struct phy_device *phydev)
+{
+	return __lan8814_ptp_probe_once(phydev, "lan8814_ptp_pin",
+					LAN8814_PTP_GPIO_NUM);
+}
+
 static void lan8814_setup_led(struct phy_device *phydev, int val)
 {
 	int temp;
-- 
2.34.1


