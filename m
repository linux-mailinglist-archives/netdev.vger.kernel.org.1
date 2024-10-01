Return-Path: <netdev+bounces-130853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D598BC3B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF06B22685
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05D1C244C;
	Tue,  1 Oct 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e7qe9UYU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6D1BFE01;
	Tue,  1 Oct 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786290; cv=none; b=UTGykhyUH2/Z6a1NHBwewHSkIJS3JOgss9IHubLEWTrN1j3fXMSUtwm1bcZQpeqlc5NwF9SQ5mYYi07aKPj4XH6cE7UkI0yqQqy8mnNU08DA0g//0mLOv0gDgMtgCUXmAx4TA2j0L4O+0mLKDjEZaWbd9nTcqymzIJQYlpZIW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786290; c=relaxed/simple;
	bh=j0vLyCJPFlst34XH3yVWN9TjDQ7Y3e3Ov6+1OgCePC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZcVxsyqVxkl2JfFdbGGm5tjSPYZt4t2Qp38fbfNUZfwCmuCvfS5mgWhbSVp3qjc1O0+BeeufCMJxWx5EeFldub5kpOmWdhTo3LcBFZDphR6hgOMd9k0E135VE01S2N56L16+6aM84Jm0ZdeNRLSybn1jIzAV0rMOXvUi5jz6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e7qe9UYU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727786289; x=1759322289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0vLyCJPFlst34XH3yVWN9TjDQ7Y3e3Ov6+1OgCePC4=;
  b=e7qe9UYUn4gjSW6VV1nPnk6gbaSluYDuJYbtk6b1kVdQj1hJLJ71lDPl
   MMaBxG+w8oeBM5tnpwLLqpezWq+kqniZZmkYrWTnQb+D3L6KJYy30fKUx
   qr60piiaJM1YfV12A01tZ+reRXWToVsurVXrX/qRsgnhq0ZU4KjFCLX+q
   aCQifl21Jawmaboxw0cYJB9isVl5vROEyolwNR04RgTC4Dfqb/Sj7B1Uy
   NpUFLv2FU8n4GmrmQH2kezjXC7yYaxlb3iTXV/XCkiiL5G5Fu8LJQZ6rb
   c8uYL7Murc9scEvJxmwq5Bmzar7XZybe3kQ/gLFAyk8Ql9u59dxHQvDAw
   Q==;
X-CSE-ConnectionGUID: 86dEivHoSmeGFOG6ZTvc9A==
X-CSE-MsgGUID: Cf+g6TfrQYKg3KHaPObPgw==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="32443953"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 05:38:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 05:37:49 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 05:37:45 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v3 1/7] net: phy: microchip_t1s: restructure cfg read/write functions arguments
Date: Tue, 1 Oct 2024 18:07:28 +0530
Message-ID: <20241001123734.1667581-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
References: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Restructure lan865x_write_cfg_params() and lan865x_read_cfg_params()
functions arguments to more generic which will be useful for the next
patch which updates the improved initial configuration for LAN8650/1
Rev.B0 published in the Configuration Note.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 3614839a8e51..24f992aba7d7 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -112,7 +112,7 @@ static int lan865x_revb0_indirect_read(struct phy_device *phydev, u16 addr)
 /* This is pulled straight from AN1760 from 'calculation of offset 1' &
  * 'calculation of offset 2'
  */
-static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2])
+static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[])
 {
 	const u16 fixup_regs[2] = {0x0004, 0x0008};
 	int ret;
@@ -130,13 +130,15 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2]
 	return 0;
 }
 
-static int lan865x_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
+static int lan865x_read_cfg_params(struct phy_device *phydev,
+				   const u16 cfg_regs[], u16 cfg_params[],
+				   u8 count)
 {
 	int ret;
 
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs); i++) {
+	for (int i = 0; i < count; i++) {
 		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-				   lan865x_revb0_fixup_cfg_regs[i]);
+				   cfg_regs[i]);
 		if (ret < 0)
 			return ret;
 		cfg_params[i] = (u16)ret;
@@ -145,13 +147,14 @@ static int lan865x_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 	return 0;
 }
 
-static int lan865x_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
+static int lan865x_write_cfg_params(struct phy_device *phydev,
+				    const u16 cfg_regs[], u16 cfg_params[],
+				    u8 count)
 {
 	int ret;
 
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs); i++) {
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
-				    lan865x_revb0_fixup_cfg_regs[i],
+	for (int i = 0; i < count; i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, cfg_regs[i],
 				    cfg_params[i]);
 		if (ret)
 			return ret;
@@ -162,8 +165,8 @@ static int lan865x_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 
 static int lan865x_setup_cfgparam(struct phy_device *phydev)
 {
+	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
 	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
-	u16 cfg_results[5];
 	s8 offsets[2];
 	int ret;
 
@@ -171,7 +174,8 @@ static int lan865x_setup_cfgparam(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = lan865x_read_cfg_params(phydev, cfg_params);
+	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+				      cfg_params, ARRAY_SIZE(cfg_params));
 	if (ret)
 		return ret;
 
@@ -190,7 +194,8 @@ static int lan865x_setup_cfgparam(struct phy_device *phydev)
 			  FIELD_PREP(GENMASK(15, 8), 17 + offsets[0]) |
 			  (22 + offsets[0]);
 
-	return lan865x_write_cfg_params(phydev, cfg_results);
+	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+					cfg_results, ARRAY_SIZE(cfg_results));
 }
 
 static int lan865x_revb0_config_init(struct phy_device *phydev)
-- 
2.34.1


