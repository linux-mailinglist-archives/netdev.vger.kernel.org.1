Return-Path: <netdev+bounces-246757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9CACF0F90
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 14:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F7AD30223D5
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549F2C0F73;
	Sun,  4 Jan 2026 13:12:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622327C84B;
	Sun,  4 Jan 2026 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532353; cv=none; b=rjpKbODFwRtFktEpEVXpCwgEEknzWAjd0wyhuUZZjchQJlVJ/lBtc/Qd0+WTlE09TLppN0jQmuuPQnlZ4HYTnsWX2fsCMX6pgDeG8HoorHj1zOEshDccYm2JiQWcIv5A4vAvCmBWqt9279C2fyOmA+LIsbrT7bg3dAvyMWOnkJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532353; c=relaxed/simple;
	bh=h5M1IEx2OxWgpq0hcL62klmTz4Af6FU1uLDVc9R0xlg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AERe82sRqCwilonwwqRAwjtGq7Tx5R9A5hPKuMr+sl2S6lLf+E3orAIMGYn46/86EdbeFSbBfm33XiVJlfxjVWv6h1gR9MRfKyNntc5ZdRLddJ+/boO9OiZnGzENxRIDRG8Eo714twzqyiDI807K22guxk/fiSQQsE6aSXK3OTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcNuF-000000003Q7-1CQz;
	Sun, 04 Jan 2026 13:12:27 +0000
Date: Sun, 4 Jan 2026 13:12:24 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: phy: realtek: get rid of magic number in
 rtlgen_read_status()
Message-ID: <86e976322ee9bf1612eadf4403158a837a0ee076.1767531485.git.daniel@makrotopia.org>
References: <cover.1767531485.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767531485.git.daniel@makrotopia.org>

Use newly introduced helper macros RTL822X_VND2_TO_PAGE and
RTL822X_VND2_TO_PAGE_REG to access RTL_VEND2_PHYSR register over Clause-22
paged access instead of using magic numbers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek/realtek_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 142a5421fe84c..a61e9ed05cdd2 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1153,7 +1153,8 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	if (!phydev->link)
 		return 0;
 
-	val = phy_read_paged(phydev, 0xa43, 0x12);
+	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
+			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));
 	if (val < 0)
 		return val;
 
-- 
2.52.0

