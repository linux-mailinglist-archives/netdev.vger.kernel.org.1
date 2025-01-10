Return-Path: <netdev+bounces-157204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5760EA09668
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC07A3D07
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E142D211A0F;
	Fri, 10 Jan 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="QSXJjmt6"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0021018D
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524218; cv=none; b=TK9v8YsfAhLdzvcEdknZMMrxao8uL9pYWlpmNhiQAdwO6rsj0WnT5kitypVkyCqC3GqnYoC1E3Q2PCYmyC1lOkqkoHJ9D7c5lJMEWLG61ikV5Ctmf2g2ZaZD5crsC6S5LS+mkz9UDVgO+b1XP4oBp2plGQrMG+dh6yqUk02fvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524218; c=relaxed/simple;
	bh=DSsW3vrm0aYSEVzZsqYe16f8khyyQpSVAk08r3ZuTCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwqx+3+lzVbOAviNkAz1D+5TtxJQ3dVRiTKNyhkI8kh+eqlbUXEOIFJcC/UUpD2l3D33E79Dh/uFHa7nApAbFYAeVwG2P6kgSliue6Ubpr1BsWjEj3/l2WbIrP+sl2cddMOVPb3bFkrowRU6OnkmXoTv857rOuM9nR3XGbDg9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=QSXJjmt6; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Swyt6ce3R2DPW0msbNHf2SwxBBxz7FeCeQXxpm6euP8=; b=QSXJjmt6f3pIsIChmujYpekByI
	X2jrjMek4q2bhdzI7BrU254R2RegmVBs3opFpB+ply0UyLluuBxaDOHsguDZvtHfDJFtKVUbo9INl
	MRfQjS+pgWOkIRgOi2t8CeKMG2KWMDG3vfnqUTZqYdllCaPKLRX3GbQBIJpbsj/MailI=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tWGJb-000000006oP-0Z46;
	Fri, 10 Jan 2025 15:48:47 +0100
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
Subject: [PATCH net-next v2 3/5] net: phy: micrel: Add loopback support
Date: Fri, 10 Jan 2025 15:48:26 +0100
Message-Id: <20250110144828.4943-4-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110144828.4943-1-gerhard@engleder-embedded.com>
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
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
index eeb33eb181ac..bf7d601f8ab0 100644
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
+	phy_modify(phydev, MII_BMCR, ~0, ctl);
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


