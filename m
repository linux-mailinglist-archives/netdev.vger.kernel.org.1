Return-Path: <netdev+bounces-169212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA512A42FB7
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D8F1884208
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA91E7C0A;
	Mon, 24 Feb 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="FeqMHw2x"
X-Original-To: netdev@vger.kernel.org
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10D8C11
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434512; cv=none; b=K/ljJnO4WKNv3jXd4c92nHjfxVnBLUfPacoE3U9FzXJWcbSs2pQ3N0EHLPzMIZB8uJ8dA10wl5fnnCkk4RftFfo6qwdf3W4qsjSd5dk9Y8wMtT3JaZIZVNPc1aKuJNEX2oxdMgH4YZ0KAx9vO5gtQR0lBIXQ4jICh7h/UTUXYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434512; c=relaxed/simple;
	bh=QEKHIQ5ErvkvJyId9qVE83R+XW0uQ2qd9xh/n86cAXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ioM9h25we6AvVsTJvlmpKAH4jozlpw4Jhk1WXPlks1TTWeDki/+YysMwY3HypZvyWK10V1ewpLYpkTbmQ95LP31QxwKZlF0QcqkPVc2W41/El3LpdzX3T/WdVm9Jma6GHW4I0hL3Ozqz7gEUFFZ4R1Tt29x11ga1+jc6q51e4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=FeqMHw2x; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RaQrNGqtJlx0rIA/HDsTPrByyWliWNtnWVUHMoJu1t8=; b=FeqMHw2xbTPMp2Wfl4YYpGySUs
	UyAst5PNTpJ0Z6PXbA0ZDqhRZ94T2GMmdlj6ZD1105gWxZcrFEeFcNLZgLtE9Z6lX/XTfJs5wLqRa
	ri1QGfyeTclNgXhhaWnPhAFe78+r1zlheyE2tdgQfmCStnnWSNevzg1BS2nYWXe4R744=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tmfno-000000000wu-1hR8;
	Mon, 24 Feb 2025 22:15:48 +0100
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
Subject: [PATCH net-next v8 3/8] net: phy: micrel: Add loopback support
Date: Mon, 24 Feb 2025 22:15:26 +0100
Message-Id: <20250224211531.115980-4-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224211531.115980-1-gerhard@engleder-embedded.com>
References: <20250224211531.115980-1-gerhard@engleder-embedded.com>
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
 drivers/net/phy/micrel.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9c0b1c229af6..f375832e3987 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1030,6 +1030,29 @@ static int ksz9021_config_init(struct phy_device *phydev)
 #define MII_KSZ9031RN_EDPD		0x23
 #define MII_KSZ9031RN_EDPD_ENABLE	BIT(0)
 
+static int ksz9031_set_loopback(struct phy_device *phydev, bool enable,
+				int speed)
+{
+	u16 ctl = BMCR_LOOPBACK;
+	int val;
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
+	return phy_read_poll_timeout(phydev, MII_BMSR, val, val & BMSR_LSTATUS,
+				     5000, 500000, true);
+}
+
 static int ksz9031_of_load_skew_values(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg, size_t field_sz,
@@ -5564,6 +5587,7 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
+	.set_loopback	= ksz9031_set_loopback,
 }, {
 	.phy_id		= PHY_ID_LAN8814,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
-- 
2.39.5


