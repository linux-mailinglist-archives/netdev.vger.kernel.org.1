Return-Path: <netdev+bounces-164326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9EEA2D5F1
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 12:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA539188CFA2
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDDC1DDC04;
	Sat,  8 Feb 2025 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ModErCWZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A092381C4
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739015575; cv=none; b=iZFo5vhmvPQ/wtGroYOecbvCqAETIkXAlUAqAfxcXtvpg2efi/USKFxAkuWATztJmZW89kQaoJKifwZLc0+9J5nAErKCKtcgSX600Pmjugr6bprVJsS+T/LKgp2j4IxP0/v1eqwLHAXzcCLmV+qrF+p0biLSKgGqUdJXbQ8VEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739015575; c=relaxed/simple;
	bh=l1/zt6/D+XTL/6uRy0UMAwWJTbvsihGOM4ZleM1qTj8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=E4SOu3XsEXHCfMyTjvR9AW1xBVQDGDEMzV6DySP96IgbTple4Tc4O2PbqY7ITFBvxCq1qyPZQB3gAnrzp41hgULMcRhiCovrslTC0HNUHxq4oQgwdQO31R3P8N8ToFy3ZyA/+7/D+19HKnnoLC/+7ulLkxzguBU6aWz3wRayqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ModErCWZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sZHmgWd+Uz0pShSG6Kj0l6as+Mg9RlkAL1snO0rsw5E=; b=ModErCWZyWU7O4F92yMAmHsbKP
	hW63Pj9KnrUPRJ+pxxXaZVZ0jgmYzmHJpX41/vy5WFbptNc2Dwi9tucg39qIYTXCfM+UH1CPhzzrQ
	a0omIfEtaygbRhwdPYyb9GVnUAbNUQvS5E1+T7ulzf6UsVrXddYgNR1QqNGN0M9lU++YuxZYBOTwD
	UzYjqJQ3VE6shwY1CF3rCwCSzFU48EUhLzVMhwyzEJ1ykXp95fNmqFPj8aU2vFfB+e3pAjdK39Wx1
	vk0wgtIva9i+qJhUPoX9eA7fUTmoekYNrX9kxud4xExnxT0d4q+QuD6DZHdmNy8YYoyzUNB9zVpEB
	/lzYnNkQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44010 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tgjO7-0000YJ-10;
	Sat, 08 Feb 2025 11:52:43 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tgjNn-003q0w-Pw; Sat, 08 Feb 2025 11:52:23 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: phylink: make configuring clock-stop dependent on
 MAC support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tgjNn-003q0w-Pw@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 08 Feb 2025 11:52:23 +0000

We should not be configuring the PHYs clock-stop settings unless the
MAC supports phylink managed EEE. Make this dependent on MAC support.

This was noticed in a suspicious RCU usage report from the kernel
test robot (the suspicious RCU usage due to calling phy_detach()
remains unaddressed, but is triggered by the error this was
generating.)

Fixes: 03abf2a7c654 ("net: phylink: add EEE management")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 214b62fba991..b00a315de060 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2265,12 +2265,15 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	/* Allow the MAC to stop its clock if the PHY has the capability */
 	pl->mac_tx_clk_stop = phy_eee_tx_clock_stop_capable(phy) > 0;
 
-	/* Explicitly configure whether the PHY is allowed to stop it's
-	 * receive clock.
-	 */
-	ret = phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
-	if (ret == -EOPNOTSUPP)
-		ret = 0;
+	if (pl->mac_supports_eee_ops) {
+		/* Explicitly configure whether the PHY is allowed to stop it's
+		 * receive clock.
+		 */
+		ret = phy_eee_rx_clock_stop(phy,
+					    pl->config->eee_rx_clk_stop_enable);
+		if (ret == -EOPNOTSUPP)
+			ret = 0;
+	}
 
 	return ret;
 }
-- 
2.30.2


