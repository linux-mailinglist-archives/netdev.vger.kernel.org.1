Return-Path: <netdev+bounces-235232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25AC2DF05
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 20:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42A3E4F3F3B
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F72239E81;
	Mon,  3 Nov 2025 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F986l98h"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4367B34D3A5;
	Mon,  3 Nov 2025 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199209; cv=none; b=nxz06epp4w+QQtATPowIdjoJIifuOQtHlE7A+N8Dj4wpiUcf54GtfY8AAl33abTdtiA7UvGCAHCgUn4jrLPndynqYEqCC88pLiSzT+MU7GUyO+9Wjr9WQ9VyDrKiggVd59iuw3wdCBb7tLb82IFCaKXcdcOkua/dbTlwg5NZnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199209; c=relaxed/simple;
	bh=Nq8wAi1+vvQBgZVT1V6WqkuBliIzYdqllfMklb/kj10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgMlG3PUuc3/l8Pp+2wCee/VYsaj8G4lL377wrNXDbkliIiqAeixTZTL6CjM1jAcWvI/yOBO9m/TLqkIldN+RvsN/jbwt/exMPEiXYug78yiBkH4rT7kVsLdRSXRo/ocO9ct4OJxp06vdWHCJlQg+cayLwTNfa4Fue4qlg7pfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F986l98h; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0C2BAC0000F3;
	Mon,  3 Nov 2025 11:46:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0C2BAC0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1762199207;
	bh=Nq8wAi1+vvQBgZVT1V6WqkuBliIzYdqllfMklb/kj10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F986l98hYVNEiT5SvyktxmIGNwZe35pFPPapz5iK8IwIkHUOSAaN+MOd1Aj3EYkhY
	 SRV/yrtuTrJVFYnN3ulhj+d4u8UJCXjaBUJq1bEYx5T0hoD0JlaAGoCp8yskf0Th2G
	 riF3zePJWYgoUs9i6xWv5yEE3o8u6SVZ88y/1jWg=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id D3AE54002F44;
	Mon,  3 Nov 2025 14:46:45 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Antoine Tenart <atenart@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] net: bcmgenet: Support calling set_pauseparam from panic context
Date: Mon,  3 Nov 2025 11:46:31 -0800
Message-Id: <20251103194631.3393020-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
References: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid making sleeping calls that would not be able to complete the MMIO
writes ignoring pause frame reception and generation at the Ethernet MAC
controller level.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 38f854b94a79..de7156b5ecf7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -75,7 +75,8 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	reg |= RGMII_LINK;
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 
-	spin_lock_bh(&priv->reg_lock);
+	if (!panic_in_progress())
+		spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~((CMD_SPEED_MASK << CMD_SPEED_SHIFT) |
 		       CMD_HD_EN |
@@ -88,7 +89,8 @@ static void bcmgenet_mac_config(struct net_device *dev)
 		reg |= CMD_TX_EN | CMD_RX_EN;
 	}
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
-	spin_unlock_bh(&priv->reg_lock);
+	if (!panic_in_progress())
+		spin_unlock_bh(&priv->reg_lock);
 
 	active = phy_init_eee(phydev, 0) >= 0;
 	bcmgenet_eee_enable_set(dev,
@@ -139,7 +141,8 @@ void bcmgenet_phy_pause_set(struct net_device *dev, bool rx, bool tx)
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->advertising, rx);
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->advertising,
 			 rx | tx);
-	phy_start_aneg(phydev);
+	if (!panic_in_progress())
+		phy_start_aneg(phydev);
 
 	mutex_lock(&phydev->lock);
 	if (phydev->link)
-- 
2.34.1


