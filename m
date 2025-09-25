Return-Path: <netdev+bounces-226525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C954BA177D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B123BF4D2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB362749DF;
	Thu, 25 Sep 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raschen.org header.i=@raschen.org header.b="FAHQKuOc"
X-Original-To: netdev@vger.kernel.org
Received: from www642.your-server.de (www642.your-server.de [188.40.219.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4F263F38;
	Thu, 25 Sep 2025 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.219.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834688; cv=none; b=tM2q9yWWFVpiuCxk93quTiN5Phga2euIbTHl9A07H/Ic5vw+zUvIdJdZ/Ij33ymJVW0+5jJWLnp3/77mak4YKcOIBAN413V60UGoAwS6A8Jdo+PuHHy20kwRLL98cq2ChWUImprnwh6gjBHFqlxgv50TzeUm+vliXHx5E705xYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834688; c=relaxed/simple;
	bh=PJA8i195WXxQigdsQuZPO61AlxwJ4EvrodBNERVbgfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TiuQEkiflLjEy+qiPTkdiAZj5Wi/kJQZ9wPN9s8hzfj1XgtCfk8xQDAFoj4bwBUanaUWTop6RjR7VBccGuVq/ZqhId/QkkHCuolTx4JfB5OgFU6vI71+nAZEjvNL184vLMKSTqtpu2HV1lnDaYJkocgoNWxQo9xpQcIZuzYNxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raschen.org; spf=pass smtp.mailfrom=raschen.org; dkim=pass (2048-bit key) header.d=raschen.org header.i=@raschen.org header.b=FAHQKuOc; arc=none smtp.client-ip=188.40.219.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raschen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raschen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=raschen.org
	; s=default2505; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=lRKe25XhJacBkOZi9mK3sD2wANF36h3/HXZ9eLBGgYY=; b=FAHQKuOczfqPK+aqKr6adzThxU
	55wOTVgD6c547mYfAbfBd6Q4MUJY/4yR487cGyHKA2hGD9AT4km6yQzL723kqgPgsQAjbrOww0Y69
	EgxB/Ah1W8vS2NMO0iJsKoZOIbIfncZxEbZn0LQL6JqjWuSQWqov+UTw4bPWEdjMHJFPKu5bQZj+A
	CvqY7/MU2JdaKBiYkkOqgGitk7DiUKjTWhebWZ001wMNHRuAm+D6rRglFK3yc08r3h3rON4/1d19R
	YUR/rZJX+J0carhqTRHdCPd034MGaHEBkXFx+ua965+P0j8OIiMPeZXcnNwKaMJDyaWSOqoN7YD4H
	I7fCiiQw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www642.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <josef@raschen.org>)
	id 1v1sxs-000K6H-1P;
	Thu, 25 Sep 2025 22:53:20 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <josef@raschen.org>)
	id 1v1sxs-000MKE-1X;
	Thu, 25 Sep 2025 22:53:20 +0200
From: Josef Raschen <josef@raschen.org>
To: 
Cc: josef@raschen.org,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
Date: Thu, 25 Sep 2025 22:52:22 +0200
Message-ID: <20250925205231.67764-1-josef@raschen.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27773/Thu Sep 25 10:27:35 2025)

Currently, for a LAN8870 phy, before link up, a call to ethtool to set
master-slave fails with 'operation not supported'. Reason: speed, duplex
and master/slave are not properly initialized.

This change sets proper initial states for speed and duplex and publishes
master-slave states. A default link up for speed 1000, full duplex and
slave mode then works without having to call ethtool.

Signed-off-by: Josef Raschen <josef@raschen.org>
---
 drivers/net/phy/microchip_t1.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 62b36a318100..5fcbfa730910 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -1319,7 +1319,12 @@ static int lan887x_phy_init(struct phy_device *phydev)
 		return ret;
 
 	/* PHY interface setup */
-	return lan887x_config_phy_interface(phydev);
+	ret = lan887x_config_phy_interface(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Make configuration visible for ethtool. */
+	return genphy_c45_pma_baset1_read_master_slave(phydev);
 }
 
 static int lan887x_phy_config(struct phy_device *phydev,
@@ -1489,7 +1494,12 @@ static int lan887x_config_aneg(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return lan887x_phy_reconfig(phydev);
+	ret = lan887x_phy_reconfig(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Make configuration changes visible for ethtool. */
+	return genphy_c45_pma_baset1_read_master_slave(phydev);
 }
 
 static int lan887x_probe(struct phy_device *phydev)
@@ -1503,6 +1513,10 @@ static int lan887x_probe(struct phy_device *phydev)
 	priv->init_done = false;
 	phydev->priv = priv;
 
+	/* Set default link parameters. */
+	phydev->duplex = DUPLEX_FULL;
+	phydev->speed = SPEED_1000;
+
 	return lan887x_phy_setup(phydev);
 }
 
-- 
2.43.0


