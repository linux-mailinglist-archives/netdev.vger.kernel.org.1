Return-Path: <netdev+bounces-247052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ADECF3BE4
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A093061B02
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40627F727;
	Mon,  5 Jan 2026 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lQBtPqNC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9B267B05;
	Mon,  5 Jan 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618514; cv=none; b=XmM89is7G3gk0W5ZBt8k0K+hyGIr6B81YorsAF4TSeYSuVcpqJOipAb/wJ085RReD5w9gaRHvHWocIsbv1C5hD5PPT0inxJYZYfrUNqSNSNODM6nW93czheR4+QY97UvclGbmWh0g7AuzXkmMOfP65XbiObnC3Ys88FoSsntoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618514; c=relaxed/simple;
	bh=s5FDDB6j1j5wRcP4xt5731DfK8g3zvJt1jhVNZD6mWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ha6hC7vS3eclvAsjQCH3QiPIWj4Xwubnfr33rZk68DQ/gQU/eTKAPN0BVyzCGahFmvtQgY4kv/uyquA/34W5yMS9cqtVRPQDcleENTGRb5P6J+RphK53tdqOEOdZGbAOaDBiv6wbdeCEC1mb/pzlunHPPhAhOO95J1jaKuBLz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lQBtPqNC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A02591A2667;
	Mon,  5 Jan 2026 13:08:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7278360726;
	Mon,  5 Jan 2026 13:08:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E14F103C8525;
	Mon,  5 Jan 2026 14:08:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618509; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=s6nJCVMi/wjZ86g8QRLs8HImVrfAUYWEj/LwtV2A+1Y=;
	b=lQBtPqNCUnogRNIv3lG2VhxFIDdH29KzWCc4cBuuwglvk+AqZ56oUqcg3qui+Vx6j0B3mu
	pMDRtqBQLUKJJV1aCM/QxcQWR8BrRY7YC6zkom29JXSY5Pl3C0vI6SUAj5TYAsc2yiTYl1
	19CMTyol7aj0jCTNY4EF1A/vyFW/TEOvGDJ/k9DibYIWTfFbhiKtkWBbOz42xvWMi8R17P
	rGntbbND2E2PQ9Ra46fqLwaJnnW0unS71NOXXhmhbKBqXnUizoRkP9JAUwDgl1XqAHbs26
	p4Px5R8JeErb18Tz706Ntc1hlXQixN6UWRL5Ub7YQurpNVnHSIMxBZ32zkE5KQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:05 +0100
Subject: [PATCH net-next 6/9] net: dsa: microchip: Use regs[] to access
 REG_PTP_RTC_SUB_NANOSEC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-6-a68df7f57375@bootlin.com>
References: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
In-Reply-To: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Accesses to the PTP_RTC_SUB_NANOSEC register are done through a
hardcoded address which doesn't match with the KSZ8463's register
layout.

Add a new entry for the PTP_RTC_SUB_NANOSEC register in the regs[]
tables.
Use the regs[] table to retrieve the PTP_RTC_SUB_NANOSEC register
address when accessing it.
Remove the macro defining the address to prevent further use.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c  | 2 ++
 drivers/net/dsa/microchip/ksz_common.h  | 1 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 4 ++--
 drivers/net/dsa/microchip/ksz_ptp_reg.h | 3 +--
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 595438031d316eda96ee7fa781aebdb65575b336..7af008cafccf716c2114f486938cdc25b7daae73 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -572,6 +572,7 @@ static const u16 ksz8463_regs[] = {
 	[PTP_CLK_CTRL]			= 0x0600,
 	[PTP_RTC_NANOSEC]		= 0x0604,
 	[PTP_RTC_SEC]			= 0x0608,
+	[PTP_RTC_SUB_NANOSEC]		= 0x060C,
 };
 
 static const u32 ksz8463_masks[] = {
@@ -807,6 +808,7 @@ static const u16 ksz9477_regs[] = {
 	[REG_PORT_PME_STATUS]		= 0x0013,
 	[REG_PORT_PME_CTRL]		= 0x0017,
 	[PTP_CLK_CTRL]			= 0x0500,
+	[PTP_RTC_SUB_NANOSEC]		= 0x0502,
 	[PTP_RTC_NANOSEC]		= 0x0504,
 	[PTP_RTC_SEC]			= 0x0508,
 };
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b4305bd47fbebfd917fca978a6f916d13b6115ea..d1baa3ce09b5fee8e0984791a730b70b704fcfdd 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -274,6 +274,7 @@ enum ksz_regs {
 	PTP_CLK_CTRL,
 	PTP_RTC_NANOSEC,
 	PTP_RTC_SEC,
+	PTP_RTC_SUB_NANOSEC,
 };
 
 enum ksz_masks {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 5a94beb410df38f5d0465e1cd896039292f9a5ec..3766d8bde478e6c2cf0ec19e7ac27570c2bb7676 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -596,7 +596,7 @@ static int _ksz_ptp_gettime(struct ksz_device *dev, struct timespec64 *ts)
 	if (ret)
 		return ret;
 
-	ret = ksz_read8(dev, REG_PTP_RTC_SUB_NANOSEC__2, &phase);
+	ret = ksz_read8(dev, regs[PTP_RTC_SUB_NANOSEC], &phase);
 	if (ret)
 		return ret;
 
@@ -683,7 +683,7 @@ static int ksz_ptp_settime(struct ptp_clock_info *ptp,
 	mutex_lock(&ptp_data->lock);
 
 	/* Write to shadow registers and Load PTP clock */
-	ret = ksz_write16(dev, REG_PTP_RTC_SUB_NANOSEC__2, PTP_RTC_0NS);
+	ret = ksz_write16(dev, regs[PTP_RTC_SUB_NANOSEC], PTP_RTC_0NS);
 	if (ret)
 		goto unlock;
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index d1d31514488609df9f5eee4b12bff074965b1c6e..41891ddadaa30ce2cf3ac41273fd335987258230 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -24,8 +24,7 @@
 #define PTP_CLK_ENABLE			BIT(1)
 #define PTP_CLK_RESET			BIT(0)
 
-#define REG_PTP_RTC_SUB_NANOSEC__2	0x0502
-
+/* REG_PTP_RTC_SUB_NANOSEC */
 #define PTP_RTC_SUB_NANOSEC_M		0x0007
 #define PTP_RTC_0NS			0x00
 

-- 
2.52.0


