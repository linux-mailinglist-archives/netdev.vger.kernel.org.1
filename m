Return-Path: <netdev+bounces-174342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA75AA5E563
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BAC3BC940
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772711EF081;
	Wed, 12 Mar 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="F/IZ39PE"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4521EEA31
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811428; cv=none; b=bH/OE4s0e8bMIPJ9OF3zWNR08Vv4tTo7ZuJE9bhE6tu9ixJVoy+3W7OBaTjGkR/FQOZEZiU6x62R+FhviLFFBxS2jQV1ypTUdE9tLzH4p6VWEHkgtdwCUoNH+6f5nzSqnGwte+tQCy85T4rFcGSd6V8fE7SLvdGQcCJ0iispmUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811428; c=relaxed/simple;
	bh=5kvf9s60uPvI6Xj2oOfIPizr0Wb0ZVJjoSyR62e9uSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=paokKvXjH3P9MZ6jpwwVydTWhUICh0WPQEbeYZwzSXdQNR+PAENC01ORR7OCqkcnr14MN+EtNT6AnVbO4AiEXEFkJEtDGvf1lh6+i/yF3B6C+Ow0BdB9BhZ4RVrd6z+qmul87MonoM0eEX+8aWVSMtuwdaQeG6/tl/4ZTImTUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=F/IZ39PE; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bfWlk60pkSLiqYTj8D4N1dI3+l12BC1lCWyCYxb7rcY=; b=F/IZ39PEppshXRkO/EgFZNnV7M
	YvmFIIFQ2sPFwbOqjJvraHtJMsKPaIwRO4cq7RHLlWteCujGk3SaEvNzdnRJXu1eqH0WBUEQHpEY8
	OYeb4WesWdT8+YBmrm1hzFY3ZIVQa7DcMDTxipQhGPuVBpZZ5u2K1kQndOfg++E6IufA=;
Received: from 80-121-79-4.adsl.highway.telekom.at ([80.121.79.4] helo=hornet.engleder.at)
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tsSiW-000000006Ue-448j;
	Wed, 12 Mar 2025 21:30:17 +0100
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
Subject: [PATCH net-next v10 3/5] net: phy: micrel: Add loopback support
Date: Wed, 12 Mar 2025 21:30:08 +0100
Message-Id: <20250312203010.47429-4-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312203010.47429-1-gerhard@engleder-embedded.com>
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
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
index 289e1d56aa65..24882d30f685 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1032,6 +1032,29 @@ static int ksz9021_config_init(struct phy_device *phydev)
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
@@ -5565,6 +5588,7 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
+	.set_loopback	= ksz9031_set_loopback,
 }, {
 	.phy_id		= PHY_ID_LAN8814,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
-- 
2.39.5


