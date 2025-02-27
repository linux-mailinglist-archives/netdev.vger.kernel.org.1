Return-Path: <netdev+bounces-170419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0256A48A6E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A3816B76B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AF026F460;
	Thu, 27 Feb 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="J1+7TtiL"
X-Original-To: netdev@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF091EB5F1
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691584; cv=none; b=Pdw7aIPwQt2KSwV7zPaChT+ONBU8AcX/DgJbVHD4NzhHqFIx3ofCb0WZbk05nj5jte84SLt1b1jwf7yOqXJopI+FA+JlttQRSLoDsUYMzaMZmpjGNLFjDpyUPxv0ksaGllKIy8bI/2SjKrdmIO13/OB8SBxPN351iNGVeNpr2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691584; c=relaxed/simple;
	bh=QEKHIQ5ErvkvJyId9qVE83R+XW0uQ2qd9xh/n86cAXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEOrgy5Iraa0ri3zxg9wyiaWFgveQA0j0I4BucRSKMhZ1ai5jhejHo3ZTAzWclcJzouvUCH/c4g4chy9qxG9TNY6lL/vLYYyVggyQ4n2Jl7X4nYdXElucxSlJvrWFTlU4jQKfqQ9QqKYMgcqjURq+VFtaq32CpUPysIRyayMT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=J1+7TtiL; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RaQrNGqtJlx0rIA/HDsTPrByyWliWNtnWVUHMoJu1t8=; b=J1+7TtiL1o6YiBFoNVDXT1PpUy
	Nog44CGrU3T1DYFG7+NFNXBjTX1H1CgogkvKU8KKzDJdX1do2KdW+CqcLOxDrHjAtxnr932cGHp7f
	QOduDf4RA+Cs4ZQXjE5HeDXPaDRRVakxWwqIkQi8dAszYq+9qu4qgYW2C8OZRMhzkVdQ=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tnkXq-000000000iA-3Uf7;
	Thu, 27 Feb 2025 21:31:47 +0100
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
Subject: [PATCH net-next v9 3/8] net: phy: micrel: Add loopback support
Date: Thu, 27 Feb 2025 21:31:33 +0100
Message-Id: <20250227203138.60420-4-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227203138.60420-1-gerhard@engleder-embedded.com>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
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


