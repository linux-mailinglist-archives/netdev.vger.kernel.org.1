Return-Path: <netdev+bounces-153463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062749F824E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABC51899ADB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690E1AAA1B;
	Thu, 19 Dec 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="UQp0Ztjq"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79D1AA783
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629899; cv=none; b=UN1w9bE8JNlruAzi2Onh5zSybq3sBRPieMj4uxpIkhRvNkkQLDOgaj2Xr0rx1xN1jKm6MWfIICLuxgtiFfo9S2ETvth4DGjbnRbQv2OqqfAVoW94EcZq5tpEGMRk4PBMxlzbtaUN/hCFVyWz9hcQjI/CiZGJ/zBRh1o735taIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629899; c=relaxed/simple;
	bh=VEZbEuADBPGRv4V2QXFXoWDC/Ge4X8hRzfyCBp91+lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3gybAbjP/G1f9ibulc9NgtvjE8UtLopxEIU7tv3CnLj93dpLjBoRFH+L7UaY+4VsD45CGyhLZlH9l0q0oZZQb2tR4YK6PuG7G02uQ8775fO8A2xTzO5xDGvX63P1HUvT3ZybA/EG7juEgoOXtyt7bCJBHbTZxvt+gFUmeuS1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=UQp0Ztjq; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024121917380906a05cf13f7c5ece3d
        for <netdev@vger.kernel.org>;
        Thu, 19 Dec 2024 18:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=it40NgbFFEujfXinS48YKcikqgNCRiHyd1xRTeZkF9o=;
 b=UQp0ZtjqoTCE76r4S0agqQE9ZwsDlZ/EjCfXbnMJweiv9NjUndRLQE/3rIkcJE1plSEaLo
 oB1z1Axnz3N7BKueOiJTGATjxoFnvafmJbci+wIEmHPMTXcUDiucWVVEqSRMPh5f94oJb9Ru
 B7f5PsEUhGKCde0imXMK/gmtVbNSmcCCpYu8ahDVIbNuFyiG6km6nWjOf0x16BXkic1t+y9u
 bYnOrc8i7XD+e5hg1fa5fl8mNLv1sF2yTvp76RCXjfnctiCq1oWFix0a9PdtdIkLCOql9VbM
 q/2W3I9XmBZliKtLzcE7GIFqaRcZXH9EPiq4I7ZemGHg4zTnaSSJYS2A==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs on user ports
Date: Thu, 19 Dec 2024 18:38:01 +0100
Message-ID: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

If the PHYs on user ports are not specified explicitly, but a common
user_mii_bus is being registered and scanned there is no way to limit
Auto Negotiation options currently. If a gigabit switch is deployed in a
way that the ports cannot support gigabit rates (4-wire PCB/magnetics,
for instance), there is no way to limit ports' AN not to advertise gigabit
options. Some PHYs take considerably longer time to AutoNegotiate in such
cases.

Provide a way to limit AN advertisement options by examining "max-speed"
property in the DT node of the corresponding user port and call
phy_set_max_speed() right before attaching the PHY to he port netdevice.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 net/dsa/user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 4a8de48a6f24..9e3f5b0f9af3 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2625,6 +2625,13 @@ static int dsa_user_phy_connect(struct net_device *user_dev, int addr,
 
 	user_dev->phydev->dev_flags |= flags;
 
+	if (dp->dn) {
+		u32 max_speed;
+
+		if (!of_property_read_u32(dp->dn, "max-speed", &max_speed))
+			phy_set_max_speed(user_dev->phydev, max_speed);
+	}
+
 	return phylink_connect_phy(dp->pl, user_dev->phydev);
 }
 
-- 
2.47.1


