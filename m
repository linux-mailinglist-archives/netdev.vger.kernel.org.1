Return-Path: <netdev+bounces-205373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC5AFE636
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B01888652
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0209B2BE7CB;
	Wed,  9 Jul 2025 10:42:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5F28ECCD
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057753; cv=none; b=lL18zy3JrtdeaofK4bimMlYrU+v72tEoyG5VJ86gXRXMYE993oYDfaejbPhcuXFKuvsQrmc8+hJMCv9ERjnXKAu0YdDOtVQcIaGg2R4v/+wDn6ja6pDq1TTdMrJDc0fMzr27lb33KJuBEJ2K2qKSRleOb7EpxbkBd77b1ay6txA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057753; c=relaxed/simple;
	bh=IyPWsI1Cj47xSOp5+E79wdgdEyYTtJq4mJUYWfGQ6lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpNSTnhybnudzoAxojRbVCXqr84T9JAnG8a28CTS07cRvqPN+tEXb5Hxj6mpbLMJIuie8lDoTn0xeCZV82QkTToA/yuxRXCNM3m0uSD3bcCCEuLy+oFwZGdeSHRrywz5bklvkPwmsoAJqhdn1pCZopoVDe51P8y/KJE+VOxff9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFh-0004mq-8w; Wed, 09 Jul 2025 12:42:13 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFf-007ZJj-2T;
	Wed, 09 Jul 2025 12:42:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFf-00FyRU-2D;
	Wed, 09 Jul 2025 12:42:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH net v2 1/3] net: phy: enable polling when driver implements get_next_update_time
Date: Wed,  9 Jul 2025 12:42:08 +0200
Message-Id: <20250709104210.3807203-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709104210.3807203-1-o.rempel@pengutronix.de>
References: <20250709104210.3807203-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Currently, phy_polling_mode() enables polling only if:
- the PHY is in interrupt-less mode, or
- the driver provides an update_stats() callback.

This excludes drivers that implement get_next_update_time()
to support adaptive polling but do not provide update_stats().
As a result, the state machine timer will not run, and the
get_next_update_time() callback is never used.

This patch extends the polling condition to include drivers that
implement get_next_update_time(). This change is required to support
adaptive polling in the SMSC LAN9512/LAN8700 PHY family, which cannot
reliably use interrupts.

No in-tree drivers rely on this mechanism yet, so existing behavior is
unchanged. If any out-of-tree driver incorrectly implements
get_next_update_time(), enabling polling is still the correct behavior.

Fixes: 8bf47e4d7b87 ("net: phy: Add support for driver-specific next update time")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- update commit message
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 543a94751a6b..3d4e5c41235e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1632,7 +1632,7 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
 		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
 			return true;
 
-	if (phydev->drv->update_stats)
+	if (phydev->drv->update_stats || phydev->drv->get_next_update_time)
 		return true;
 
 	return phydev->irq == PHY_POLL;
-- 
2.39.5


