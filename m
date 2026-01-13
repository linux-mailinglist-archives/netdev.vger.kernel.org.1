Return-Path: <netdev+bounces-249586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14736D1B59F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D55830021EA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308632143E;
	Tue, 13 Jan 2026 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="EtTk97qV"
X-Original-To: netdev@vger.kernel.org
Received: from srv5.3e8.eu (srv5.3e8.eu [94.16.113.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CC318BBD;
	Tue, 13 Jan 2026 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.113.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338471; cv=none; b=dc2F0iYKNKpeeKSbOMUhdrO4b/qb3zoudSLQlI38lKmqWH1r3joUY/g3R/XbfxNq3KlcAD2tq6PVT5R2Z76ta8ao+LgS/mUcbHgrXuCmRupenOBId+B90gDCdNHjunf/reCc9IJQRqizRGqVRKgq3bVFkdkHteoCk7BmO8Kx2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338471; c=relaxed/simple;
	bh=hVvt1hy0fhPrDke3dMsM0EaUiJ8dO4HektY/hMvgHgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ig5VhHbbG0JfvvapSwDuL0emiFCZOW/MZhKcuw2yHvWQSaf87yLUuZvpo+EnUZYrQS3JY5+a25x6aLKpDtMXTr3cjQAKojjqdW5UfTyHtb3mcPDQGr2BhgGOMb6jSgd/3O4KGP2YlCn4PfRJvkfaYMWKgTHAtI1a/6rXb/jPeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=EtTk97qV; arc=none smtp.client-ip=94.16.113.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from jan-pc (p200300ed47159ba0e29a2b5a09ffd5c0.dip0.t-ipconnect.de [IPv6:2003:ed:4715:9ba0:e29a:2b5a:9ff:d5c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv5.3e8.eu (Postfix) with ESMTPSA id 1DEBF1201AE;
	Tue, 13 Jan 2026 21:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1768337812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DSzAqKIi7H+h3ZgX5UzhooE7Rl4zTVAZh+rL++kKiKo=;
	b=EtTk97qVhDDz6+Qjg+Dv3/qw0vxPo4MHf7YZQE69CsDexV8dmTzPKRg135qeVZkx7lLqpY
	ODjMlmvnMiU19aLgHepDcyDY7ItMHG974ppn6tIg4CkFBulJxJ4qYnLV2g3/vX+AitBrLg
	5DzIbzgxH3ZYjSbHGYiQvwJESJASdBFnu1EqCin3CBEFYYuYH985LrvMuQoWzf3y8veaiP
	yYFyZlEYAyoXmF1t9y+CXR9bnsytZ8HkOWBj48budJ+38ztf03IZnJrofCajD31RzPlVjC
	yuM/9rTOutBg2ZPl4IH7Wz6D2RYh8z1Hcy6Ex/R+PRGQUo3VEGOTjGgU5PsAxw==
From: Jan Hoffmann <jan@3e8.eu>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Hoffmann <jan@3e8.eu>
Subject: [PATCH net-next] net: phy: realtek: fix in-band capabilities for 2.5G PHYs
Date: Tue, 13 Jan 2026 21:55:44 +0100
Message-ID: <20260113205557.503409-1-jan@3e8.eu>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like the configuration of in-band AN only affects SGMII, and it
is always disabled for 2500Base-X. Adjust the reported capabilities
accordingly.

This is based on testing using OpenWrt on Zyxel XGS1010-12 rev A1 with
RTL8226-CG, and Zyxel XGS1210-12 rev B1 with RTL8221B-VB-CG. On these
devices, 2500Base-X in-band AN is known to work with some SFP modules
(containing an unknown PHY). However, with the built-in Realtek PHYs,
no auto-negotiation takes place, irrespective of the configuration of
the PHY.

Fixes: 10fbd71fc5f9b ("net: phy: realtek: implement configuring in-band an")
Signed-off-by: Jan Hoffmann <jan@3e8.eu>
---
 drivers/net/phy/realtek/realtek_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 5a7f472bf58e..7b7a48e5082a 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1429,6 +1429,7 @@ static unsigned int rtl822x_inband_caps(struct phy_device *phydev,
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_2500BASEX:
+		return LINK_INBAND_DISABLE;
 	case PHY_INTERFACE_MODE_SGMII:
 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
 	default:
-- 
2.52.0


