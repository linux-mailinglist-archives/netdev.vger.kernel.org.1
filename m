Return-Path: <netdev+bounces-233775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C37CC181CB
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 04:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01383AB4D0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166D2D9EF0;
	Wed, 29 Oct 2025 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hA9S1gfO"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262E2E8B8F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706916; cv=none; b=k/bSmwsdGDB0FqXjsJKHDWFmQC7c0KgAw6JWlXLahxd6FdxJ2DgmDssQyRxD9WDotIscclNRLgmhTQVY1T4DmGe6V9ndXXY3R+nxj9YADuZ9WvAte/6zWiU+ztupecm4DIOUhU31yGfpBzStSYPeeQldlyrOZsd4MI9kb0I+EPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706916; c=relaxed/simple;
	bh=nIIzyE0Pu/J14uROCtq0qh6XCJX7FHrFa0dauYOTuPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShGgbg5P1BZgoZIbs130YF3bPlSxwXV29PXjWatTQPJKQwnhqQIFLyjuK8emXPBzjeg/zJGz7IGLyJ1YiAtoinHawkYjSRwFTNwBefEvW8iKW59ebrO8wouBwQe65IX2UJ9fzhrBbdeGLYjY0EELuOh8I8qrvIK6CFwlH/KpL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hA9S1gfO; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761706912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2gwqudV/sys8oDRKQNPhreFsYRzosPCliQm9FJVo/8=;
	b=hA9S1gfO/8NN/rKEh/qxZ5BxNP49qM3kYFzpogViDoY2PleSdNwzF6pdg3wsNYoeS9bs5s
	6COWb+yaxlgq7V6l98Tixu9ORIG+3XM2xdj3v8SnTxiSC2/VncmxBE88nJLgTN0HTWD5Lt
	A8GR/vZwdPK8aM/WZwPtiGqX/hAHAps=
From: Yi Cong <cong.yi@linux.dev>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH net-next 2/2] net: phy: motorcomm: correct the default tx delay config for the rgmii
Date: Wed, 29 Oct 2025 11:00:43 +0800
Message-Id: <20251029030043.39444-3-cong.yi@linux.dev>
In-Reply-To: <20251029030043.39444-1-cong.yi@linux.dev>
References: <20251029030043.39444-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

According to the dataSheet, rx delay default value is set to 750 ps.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/phy/motorcomm.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 620c879d89e4..15e59b980704 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -213,6 +213,33 @@
 #define YT8521_RC1R_RGMII_2_100_NS		14
 #define YT8521_RC1R_RGMII_2_250_NS		15
 
+/* The value of the register and the actual tx delay
+ * have a nonlinear relationship at 1000Mbps(ext_reg 0xA003[3:0]):
+ * ------------------------------------------
+ * ext_reg0xA003[3:0]    |    tx delay(PS)
+ * ------------------------------------------
+ *    b'0100                     0
+ *    b'0101                     150
+ *    b'0110                     300
+ *    b'0111                     450
+ *    b'0000                     600
+ *    b'0001                     750
+ *    b'0010                     900
+ *    b'0011                     1050
+ *    b'1100                     1200
+ *    b'1101                     1350
+ *    b'1110                     1500
+ *    b'1111                     1650
+ *    b'1000                     1800
+ *    b'1001                     1950
+ *    b'1010                     2100
+ *    b'1011                     2250
+ * ------------------------------------------
+ * According to the dataSheet, it set to 4b'1 and
+ * the delay value is 750 ps(b'0001)
+ */
+#define YT8521_RC1R_RGMII_NONLINEAR_0_750_NS	1
+
 /* LED CONFIG */
 #define YT8521_MAX_LEDS				3
 #define YT8521_LED0_CFG_REG			0xA00C
@@ -893,7 +920,7 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 					   YT8521_RC1R_RGMII_0_000_NS);
 	tx_reg = ytphy_get_delay_reg_value(phydev, "tx-internal-delay-ps",
 					   ytphy_rgmii_delays, tb_size, NULL,
-					   YT8521_RC1R_RGMII_1_950_NS);
+					   YT8521_RC1R_RGMII_NONLINEAR_0_750_NS);
 
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_RGMII:
-- 
2.25.1


