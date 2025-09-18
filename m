Return-Path: <netdev+bounces-224589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C00EB866BD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E3A3B50BA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4622D4C8;
	Thu, 18 Sep 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK0CoBNb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CD1643B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220281; cv=none; b=kBw22aS7zElrMhHjiEKNeuDoVEydk6yuSICnBzSjKJ2t2ac0NRGfSLbc3l49YszUDGJeVNub/6P2uDMaQMznpzD8fPMs3VbHhA018e8lLJxbDdoZg95xd5kWXRSZ0kZ7GRVgPD+92G3I/+12/DQuvlFmNLn4h6IQb98ffLlyMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220281; c=relaxed/simple;
	bh=DL8MajtqR23KTPjaCR4A8ULBoaP0K3IJMbMY/bITxkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZstQNZhOLAIYvM7jMD+EMCyuHXG4hfINa9CmNgoqZS5x4xE+cebYLNs/yzAZlID7jorm3q2sSI3nV80Y5QVjCnzbqGkWkN/+f7nOKvrO25Om1E9tXztKIhLt9RMl/hxerBKd3aN1l0RRZ+T8E9rLPP379mhJUvtyKFOHQ3FjGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK0CoBNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0E8C4CEE7;
	Thu, 18 Sep 2025 18:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758220281;
	bh=DL8MajtqR23KTPjaCR4A8ULBoaP0K3IJMbMY/bITxkM=;
	h=From:To:Cc:Subject:Date:From;
	b=YK0CoBNbJqyhdGjB+87Yhpoi9lLlaEjB76kj1vkArqjyDRTt7XZHGByPw8D7YabjH
	 WfshCIuth/2zsYQRNGEaZbo/aDsrZ/bmrV0M1r1Nt490qMgvVPWYZ9NkOidsKGwqNq
	 /Fk47wI7B7cLKu/j85p1383xRWApkJO7DCA5nEMKd40VembPRKthuOknJ2YUg8gT8b
	 sqCZ63rwDrUVGuL43+5J/0zp5shSrbQBiKB50FFD/U3ZCi8RxGBx7NLAI8QQJUpUPT
	 xrc8a3eZ6d7R/VZ1rkK2pzJgDvWvNmIAVDaEkd4RpgjmyuAOucr9PajJ211Uw0WEzm
	 evjjyvssA/mjQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com
Subject: [PATCH net-next] net: phy: micrel: use %pe in print format
Date: Thu, 18 Sep 2025 11:31:19 -0700
Message-ID: <20250918183119.2396019-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New cocci check complains:

  drivers/net/phy/micrel.c:4308:6-13: WARNING: Consider using %pe to print PTR_ERR()
  drivers/net/phy/micrel.c:5742:6-13: WARNING: Consider using %pe to print PTR_ERR()

Link: https://lore.kernel.org/1758192227-701925-1-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: hkallweit1@gmail.com
CC: linux@armlinux.org.uk
CC: richardcochran@gmail.com
---
 drivers/net/phy/micrel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index e403cbbcead5..8693d3a77ce0 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4295,8 +4295,8 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
 	shared->ptp_clock = ptp_clock_register(&shared->ptp_clock_info,
 					       &phydev->mdio.dev);
 	if (IS_ERR(shared->ptp_clock)) {
-		phydev_err(phydev, "ptp_clock_register failed %lu\n",
-			   PTR_ERR(shared->ptp_clock));
+		phydev_err(phydev, "ptp_clock_register failed %pe\n",
+			   shared->ptp_clock);
 		return -EINVAL;
 	}
 
@@ -5729,8 +5729,8 @@ static int lan8841_probe(struct phy_device *phydev)
 	ptp_priv->ptp_clock = ptp_clock_register(&ptp_priv->ptp_clock_info,
 						 &phydev->mdio.dev);
 	if (IS_ERR(ptp_priv->ptp_clock)) {
-		phydev_err(phydev, "ptp_clock_register failed: %lu\n",
-			   PTR_ERR(ptp_priv->ptp_clock));
+		phydev_err(phydev, "ptp_clock_register failed: %pe\n",
+			   ptp_priv->ptp_clock);
 		return -EINVAL;
 	}
 
-- 
2.51.0


