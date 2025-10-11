Return-Path: <netdev+bounces-228591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316BBCF40B
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 13:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE04189D2AB
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08B2571A5;
	Sat, 11 Oct 2025 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mBwpVA7u";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sYBdoTme"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E58262FF8
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760180615; cv=none; b=Iqz0Fi/cazlS1erp+lrEWBbUqIoJJU0IrdnPMeJ3BewCcKiiPSaDojdXCeinSUSz9Hm7oNxmTW2z6TXfn1e2VGgtJOaBarT8ujTyhQmRPR9KpZmVkbXIoZayfWNOREvJxr8U2oFxUHYqqdKUo0xG6YkOJpaXQ62bVW4O1IU3A4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760180615; c=relaxed/simple;
	bh=hU5amFH1sYdSOPa2rqyu+5R5NsXEJs7LTFhiTeRptgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAleUa9VHKynpTtOen+YjkshEUg7zgP6Y3LKEpM1EAbDg+OOijcAF0eGrEtC81KpBm6LsF8LOnGMWunIqdTQ1jaY8/7dCGtraAJlP6eJmi2DERANbuPBFCJm3cx0CmKtUI5xN2oDagExR7AwpnvNCBgvj8NvhQdYWZNTuzOPSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mBwpVA7u; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sYBdoTme; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ckLM35qT7z9tVP;
	Sat, 11 Oct 2025 13:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760180607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CSQuojGO5PPwsr0a+64d6W8P1UV65lWZWjx8iH7CmFo=;
	b=mBwpVA7uXDGU213xYU57AnTGqy1M3TrhyFvEBPKwMmF3ehFvppmiDYzbb83lIXI7bqk6aK
	WzQf6csmgYu6zJePyPGDL5+VjBuOvlc1wGxW+E7YKP8PGSBN9Lfq9wefec81YF7Rmva2SG
	vbVki94QpS2snKJU8c0G7zj4g5eKjT+ctJFk7NxQO+sMT06VFt2zoBpPIttRqglLj/Dxwt
	D05pp1ePxVIGXCeQUwrW8gMX/uBIStKoaeJKvTMCvpNeolsbh/BMCn4S/3McPu+F2sJ0nH
	d/rX81QVqRqr9KiPrmZxEHJhfQQBcmml7sXbrdkOzEIHUQXNopbIjjp1q5V5Yg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=sYBdoTme;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760180606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CSQuojGO5PPwsr0a+64d6W8P1UV65lWZWjx8iH7CmFo=;
	b=sYBdoTme+an2tpxAtEQHbMh7oRsRh6iKzPPooNXP/6ohZBXG+OXDoFC6txhJw3oz3R91Nc
	5SKHKpIY2ycZQ4oPd3bLNLN343z4g0bSUwJiuiwetAzGbwfSxuQjARfdbFYL1qIjagNeDG
	5bmUjXvwva/5M4M8Gd0JkqGwO/+mVfxZKZxcMbBgduaaoWYLNdd8nY0lAU/yV1HNBJTgGb
	cE4JgUtYh/kEPE0O2F8REBmCefjiCDQ2NaxQsLQr3g01HCZ5/o9deZrq5WBxiyaMkvBMDn
	ETvMoMK+RAWTYxUop7JpsfLeg7w7nKTNBh7ghTa7Zw+08X43Ip6MwodMlVzcLQ==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [net,PATCH] net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present
Date: Sat, 11 Oct 2025 13:02:49 +0200
Message-ID: <20251011110309.12664-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yuf9zq4p9jpakzrfh6jb9e93mwaoihas
X-MBO-RS-ID: 01c54f5ace3fe6d79fd
X-Rspamd-Queue-Id: 4ckLM35qT7z9tVP

The driver is currently checking for PHYCR2 register presence in
rtl8211f_config_init(), but it does so after accessing PHYCR2 to
disable EEE. This was introduced in commit bfc17c165835 ("net:
phy: realtek: disable PHY-mode EEE"). Move the PHYCR2 presence
test before the EEE disablement and simplify the code.

Fixes: bfc17c165835 ("net: phy: realtek: disable PHY-mode EEE")
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
---
 drivers/net/phy/realtek/realtek_main.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 82d8e1335215d..a724b21b4fe73 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -633,26 +633,25 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 			str_enabled_disabled(val_rxdly));
 	}
 
+	if (!priv->has_phycr2)
+		return 0;
+
 	/* Disable PHY-mode EEE so LPI is passed to the MAC */
 	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
 			       RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
 	if (ret)
 		return ret;
 
-	if (priv->has_phycr2) {
-		ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
-				       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
-				       priv->phycr2);
-		if (ret < 0) {
-			dev_err(dev, "clkout configuration failed: %pe\n",
-				ERR_PTR(ret));
-			return ret;
-		}
-
-		return genphy_soft_reset(phydev);
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
+			       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
+			       priv->phycr2);
+	if (ret < 0) {
+		dev_err(dev, "clkout configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
 	}
 
-	return 0;
+	return genphy_soft_reset(phydev);
 }
 
 static int rtl821x_suspend(struct phy_device *phydev)
-- 
2.51.0


