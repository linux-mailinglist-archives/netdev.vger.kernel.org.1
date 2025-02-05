Return-Path: <netdev+bounces-163235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC517A29A43
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6BA165EFA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F34204092;
	Wed,  5 Feb 2025 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="ipLGggBX"
X-Original-To: netdev@vger.kernel.org
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3A204C1A
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784256; cv=none; b=feo4+fZ3JvkQrRwNf6P9SUHhd7CORAeYgCSU+K1WIMbdC/ZL9O7DmoU0U5Bp8EKk4sZY8oZYHjlDcZpX2NSgKuNvPVOhyt1TIvff1sC0Kgcdr/gFnCz8c5ct+9qVKpjrMyFGY+b+iSFETLSDLvWzblJwIRCZBqPIqUy+D6XRb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784256; c=relaxed/simple;
	bh=O3PPtSwrgcwBYPeJrpQxMPQLoGrotRuqhjpZ/UpkSlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzjYVBw+3CUAUYD/dyCZ06tGy0nKVhI1nyF6O3KJUIxjJD00r4CH6/8Xty5/+bpOajkideR0t/UzYCyVOGHNF70GqphIOt45AlbbGYwP7jXpRefjpRLiCiSq99GaSsrmkbO1fv9yVKRDYI3rJVD+CZBm+S3O9/LZNWsPYnsxu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=ipLGggBX; arc=none smtp.client-ip=81.19.149.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4sU41T3uQhCTEUQZT0XyM9iLxMGZd5WwVCb3nHHzvy8=; b=ipLGggBXMvBdr90ireXhGt83Pl
	Ye/t1uVGlt/HvupDpXzfMDv9Sq0VgivEEY3ycq9+BFDzVNKEt693i5G3XjaeqWaBjKlHfIAU5xo9A
	MpDNJDLBsygrB2ukDJoKrPFbwJUOh47cTkgx8pLN0poir7NH9XAOrhTuBJibhM6htOa8=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tfklC-0000000017b-2m4O;
	Wed, 05 Feb 2025 20:08:31 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v5 3/7] net: phy: micrel: Add loopback support
Date: Wed,  5 Feb 2025 20:08:19 +0100
Message-Id: <20250205190823.23528-4-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205190823.23528-1-gerhard@engleder-embedded.com>
References: <20250205190823.23528-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

The KSZ9031 PHYs requires full duplex for loopback mode. Add PHY
specific set_loopback() to ensure this.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/phy/micrel.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9c0b1c229af6..04c4187e976c 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1030,6 +1030,33 @@ static int ksz9021_config_init(struct phy_device *phydev)
 #define MII_KSZ9031RN_EDPD		0x23
 #define MII_KSZ9031RN_EDPD_ENABLE	BIT(0)
 
+static int ksz9031_set_loopback(struct phy_device *phydev, bool enable,
+				int speed)
+{
+	u16 ctl = BMCR_LOOPBACK;
+	int ret, val;
+
+	if (!enable)
+		return genphy_loopback(phydev, enable, 0);
+
+	if (speed == SPEED_10 || speed == SPEED_100 || speed == SPEED_1000)
+		phydev->speed = speed;
+	else if (speed)
+		return -EINVAL;
+	phydev->duplex = DUPLEX_FULL;
+
+	ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
+
+	phy_write(phydev, MII_BMCR, ctl);
+
+	ret = phy_read_poll_timeout(phydev, MII_BMSR, val, val & BMSR_LSTATUS,
+				    5000, 500000, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int ksz9031_of_load_skew_values(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg, size_t field_sz,
@@ -5564,6 +5591,7 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
+	.set_loopback	= ksz9031_set_loopback,
 }, {
 	.phy_id		= PHY_ID_LAN8814,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
-- 
2.39.5


