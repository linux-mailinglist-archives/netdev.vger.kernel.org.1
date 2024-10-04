Return-Path: <netdev+bounces-132123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7539908BA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1ADCB22EFB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DD1C3058;
	Fri,  4 Oct 2024 15:50:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BD1C3054;
	Fri,  4 Oct 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057047; cv=none; b=XoH8dkOJyK1GZ+pbbIDIFRQ6Slg307YxBwqX+kzBEWfynjn8mDMRVEmi2ShCXygyp+EVi6Ydtghpe9NxCHhhdfYdRGIOePyhtCkhBw+r/1G2hYULVHy+hN7DShDypbNDyqIAqfmqIVNuwbJ3nbVoTqd/s6b04ItxS+QpcT0kFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057047; c=relaxed/simple;
	bh=cq0Q2a70vlbz28xd+W6U5xTx2t8L5+0c0sUvA/ndYNw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jXfyENv6iCPmCj9eZrOj0tlWJxTTnwKj8P0DTd1I6tcfVbMNAVz09ab4MQMXyHh007+LXPLNgnVtk3EZBWH2ntxFgI3LeB2CAkPJPogh4s8IQfMcx1DmcnorfG1D52LT7+oEHvM6BNXM+hULToaSQ7YQ4infsjO2zU1IrIYAa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swkZl-000000008Hn-3Wmu;
	Fri, 04 Oct 2024 15:50:41 +0000
Date: Fri, 4 Oct 2024 16:50:36 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Only use link-partner advertisement bits for 10GbE modes if they are
actually valid. Check LOCALOK and REMOTEOK bits and clear 10GbE modes
unless both of them are set.
This prevents misinterpreting the stale 2500M link-partner advertisement
bit in case a subsequent linkpartner doesn't do any NBase-T
advertisement at all.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index c4d0d93523ad..d276477cf511 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -927,6 +927,10 @@ static int rtl822x_read_status(struct phy_device *phydev)
 		if (lpadv < 0)
 			return lpadv;
 
+		if (!(lpadv & MDIO_AN_10GBT_STAT_REMOK) ||
+		    !(lpadv & MDIO_AN_10GBT_STAT_LOCOK))
+			lpadv = 0;
+
 		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
 						  lpadv);
 	}
-- 
2.46.2


