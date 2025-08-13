Return-Path: <netdev+bounces-213295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC0B24761
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E4D720BBF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376F2F6574;
	Wed, 13 Aug 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kyBOcDDu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203582F49F3;
	Wed, 13 Aug 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081256; cv=none; b=p6vDlcnF5f6XxwEyn4L1txykGXo4FkjK86RGf6Q5FIXmfs5+VjoHuX3ggkcmVzEs1eggZ6JYPV42vUAxwQiButEM9J3olFXHjwH6iY0mUyXuJxW8DNgmnEan8NC1gi2lTylSgjC2kXk78mjJ2+zwumTdsEkNtz1W7H3miSfrMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081256; c=relaxed/simple;
	bh=4M4WTr7aDG7m7x4izcfAcsDMik6L9YC6njBc54p0N+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHbxmMQgPDVAolJJgkx5FI6vEV8jcOEgR7hohciUVUyjeBS/2WHl1b2wLKTcJQOnQha56EGtFTyIZo7hAoXvItsm7/ULvRiYD3J/iW7Yl0QHqIarNGdqgr3On3uPkS5mpaCw7/xpAQzQaq5gMTEGarUj2/XkQRI+evmpbJqKk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kyBOcDDu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755081255; x=1786617255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4M4WTr7aDG7m7x4izcfAcsDMik6L9YC6njBc54p0N+c=;
  b=kyBOcDDufpfOiQ5JTdz4/fkb3JwioI5bxRE3Q3D1G0j9fxVEnVPcSm+D
   dxyLrAshgfoKUGNohVK2CmSbvpYTjQFPQsDxA93Tb41UmVlXlP/Q5I872
   zCEryMh2NXUDW2VnadsC9JjKPQspnI9+IbNWJM5AfAKH3m8/zfvS4NKa0
   3kx1sUegh1h29CYlPvsKxqO8x1sIZHZKRzA8FLmdT2io0IHo5HUSXladd
   KkwkbNTRfC6E1JeKQ/i79Ovqz+bwrfGsu8q3EOTkHClhUVIaRA0cWM7R8
   M8p224FNgHfi1z9u5zujP7njz0yIpP0zqYkYQxXWIDPr4mpMU/fCsA6Uw
   g==;
X-CSE-ConnectionGUID: 7pl1KfoDRtWRHbFbwqg1xg==
X-CSE-MsgGUID: IP/Mkq3KR1yKKoEIgpPfjw==
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="276535070"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2025 03:34:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 13 Aug 2025 03:34:10 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 13 Aug 2025 03:34:07 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net 2/2] microchip: lan865x: fix missing configuration for Rev.B0/B1 as per AN1760
Date: Wed, 13 Aug 2025 16:03:55 +0530
Message-ID: <20250813103355.70838-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813103355.70838-1-parthiban.veerasooran@microchip.com>
References: <20250813103355.70838-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fix missing configuration required for LAN865x silicon revisions B0 and B1,
as documented in Microchip Application Note AN1760 (Revision F, June 2024).

According to the guidance in the application note, register 0x10077 must be
programmed with the value 0x0028 to ensure correct operation on Rev.B0/B1
devices. Without this fixup, the device may not function correctly or may
fail to initialize.

Reference:
https://www.microchip.com/en-us/application-notes/an1760

Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index d03f5a8de58d..a55ca485062f 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -32,6 +32,14 @@
 /* MAC Specific Addr 1 Top Reg */
 #define LAN865X_REG_MAC_H_SADDR1	0x00010023
 
+/* LAN865x Rev.B0/B1 configuration parameters from AN1760
+ * As per the Configuration Application Note AN1760 published in the below link,
+ * https://www.microchip.com/en-us/application-notes/an1760
+ * Revision F (DS60001760G - June 2024)
+ */
+#define LAN865X_REG_FIXUP		0x00010077
+#define LAN865X_FIXUP_VALUE		0x0028
+
 struct lan865x_priv {
 	struct work_struct multicast_work;
 	struct net_device *netdev;
@@ -346,6 +354,14 @@ static int lan865x_probe(struct spi_device *spi)
 		goto free_netdev;
 	}
 
+	/* LAN8650/1 configuration fixup from AN1760 */
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_FIXUP,
+				    LAN865X_FIXUP_VALUE);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to configure fixup: %d\n", ret);
+		goto oa_tc6_exit;
+	}
+
 	/* As per the point s3 in the below errata, SPI receive Ethernet frame
 	 * transfer may halt when starting the next frame in the same data block
 	 * (chunk) as the end of a previous frame. The RFA field should be
-- 
2.34.1


