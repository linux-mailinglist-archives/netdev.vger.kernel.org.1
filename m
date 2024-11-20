Return-Path: <netdev+bounces-146414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4E9D34C8
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977EF1F21167
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC00819DF4F;
	Wed, 20 Nov 2024 07:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88219CC36;
	Wed, 20 Nov 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089033; cv=none; b=Gj5XniHdnBgv7dcYYKVyCAxzlp8Kal/FGMMAoWZSgcUeg+P0NxcRkxXLf0cyf2U+sNQcmuKy6p7fowmnv2pp+n61Nk/zWf1YOPuafhb8G9nPyYhpmqQysH+FUUWVeXQc6mRcU84L5CGNpT23+sHKYzx13FFrh8NMNh6QGqV6pY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089033; c=relaxed/simple;
	bh=HtUivY0daNdR37ZaFD1gXCAPMQH467T5jrXDwiaqQIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8f0tm0qB3e6SXLGO5ffTvWV8CDLvcmanTjF+jDJa9aOMa6PNhmETdlzkYw5z/ytRWhW+JUuwdFIVfJvsfyom23VI/HX+JPZk8iS6cCviFxPhMBzT3znbfqKasEyH4vNMsObf+zyoKgAiVm9XvXyDdQK7tvfdetewLX9uj4T/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 20 Nov
 2024 15:50:17 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 20 Nov 2024 15:50:17 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v3 5/7] net: ftgmac100: add pin strap configuration for AST2700
Date: Wed, 20 Nov 2024 15:50:15 +0800
Message-ID: <20241120075017.2590228-6-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
References: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On AST2700, the RMII/RGMII pin strap is configured by setting
MAC 0x50 bit 20. Set to 0 is RGMII and set to 1 is RMII.
Use compatible property to distinguish different generations for
configuration.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 5 +++++
 drivers/net/ethernet/faraday/ftgmac100.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 6dfd29505d2c..bd57942b8b16 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -323,6 +323,7 @@ static void ftgmac100_init_hw(struct ftgmac100 *priv)
 static void ftgmac100_start_hw(struct ftgmac100 *priv)
 {
 	u32 maccr = ioread32(priv->base + FTGMAC100_OFFSET_MACCR);
+	struct phy_device *phydev = priv->netdev->phydev;
 
 	/* Keep the original GMAC and FAST bits */
 	maccr &= (FTGMAC100_MACCR_FAST_MODE | FTGMAC100_MACCR_GIGA_MODE);
@@ -351,6 +352,10 @@ static void ftgmac100_start_hw(struct ftgmac100 *priv)
 	if (priv->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
 		maccr |= FTGMAC100_MACCR_RM_VLAN;
 
+	if (of_device_is_compatible(priv->dev->of_node, "aspeed,ast2700-mac") &&
+	    phydev && phydev->interface == PHY_INTERFACE_MODE_RMII)
+		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
+
 	/* Hit the HW */
 	iowrite32(maccr, priv->base + FTGMAC100_OFFSET_MACCR);
 }
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..c87aa7d7f14c 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -166,6 +166,7 @@
 #define FTGMAC100_MACCR_RX_MULTIPKT	(1 << 16)
 #define FTGMAC100_MACCR_RX_BROADPKT	(1 << 17)
 #define FTGMAC100_MACCR_DISCARD_CRCERR	(1 << 18)
+#define FTGMAC100_MACCR_RMII_ENABLE	(1 << 20) /* defined in ast2700 */
 #define FTGMAC100_MACCR_FAST_MODE	(1 << 19)
 #define FTGMAC100_MACCR_SW_RST		(1 << 31)
 
-- 
2.25.1


