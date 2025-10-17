Return-Path: <netdev+bounces-230474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED6BE8846
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83FF3504EFD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4017F2DC78A;
	Fri, 17 Oct 2025 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A1AgL6yo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4A332EAC
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702707; cv=none; b=ndVi/Rbrir95ST8lsPDEr21beERN2AcV+AFLHlTq7e9f7ISTXhuJj/F3EV7tjptpHfPTjDPtExfJHiujsYkB10EGPxYi1+ipu0oSfJs4nmE5J4qaDCnVIxkob3r/dqrsSDMtg/lYtagllvag1RdDNzkCmLgn0KFlK/JcCLhnDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702707; c=relaxed/simple;
	bh=QDSPWv+KqsT7psq8M2PkW+OohrDg8Ty9fk21GbK3wm0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=chFwaEZzIB2cCjGcPVSOg+FDMmczTIRX58WHQoO4WOnCmge9FewoptoZw1zx97xMgkwV1hr5owiroBB9XNpQef7BSuYwXVBgquoHTkVCK/iWJ2hgE6GcXnQHAauDGt1a7xyMoho+ERTJkuQ+mk0IzHt7SdQPtVRMjoRWjBwnqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A1AgL6yo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S7o6kaIE75Lvkn1Hzsa0EHqdnim3Q6JNR3QONO2lEd0=; b=A1AgL6yoYlhCaXvlRRCKMen+6J
	m7k4cJGOC14N7C0C5vRzSs/bT7KWPqEpw1h91BImYgYB5h3uX81i01LWyaOKXyIwX86mRKibLxKKt
	rnfuiAfk2EkVOwsdjEUucJx5Ud6mKrrcScBNXZWQYSnKqFaBkiLMlNiVOHcyrr7+FdMZ1bzefy5Hz
	dmwiEewKRmsNTN/1R3xgMTuSIJQF57FntFspxo3/sbcVtWXjH9tesutwheL6moXe9AzEtBqjXCAwl
	rE2cUpkqoousaa50RYZvtywW2zyI7I/mJBckP8vxQa00zCYrhbBzyZcnE5MCm5aKbV/4Q92gSFl30
	rko6Wa9A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35850 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v9jCb-000000007qJ-0783;
	Fri, 17 Oct 2025 13:04:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v9jCZ-0000000B2PP-2cuM;
	Fri, 17 Oct 2025 13:04:55 +0100
In-Reply-To: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/6] net: phylink: add phylink managed wake-on-lan
 PHY speed control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v9jCZ-0000000B2PP-2cuM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 17 Oct 2025 13:04:55 +0100

Some drivers, e.g. stmmac, use the speed_up()/speed_down() APIs to
gain additional power saving during Wake-on-LAN where the PHY is
managing the state.

Add support to phylink for this, which can be enabled by the MAC
driver. Only change the PHY speed if the PHY is configured for
wake-up, but without any wake-up on the MAC side, as MAC side
means changing the configuration once the negotiation has
completed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 12 ++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 939438a6d6f5..26bd4b7619dd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2576,6 +2576,12 @@ static bool phylink_phy_supports_wol(struct phylink *pl,
 	return phydev && (pl->config->wol_phy_legacy || phy_can_wakeup(phydev));
 }
 
+static bool phylink_phy_pm_speed_ctrl(struct phylink *pl)
+{
+	return pl->config->wol_phy_speed_ctrl && !pl->wolopts_mac &&
+	       pl->phydev && phy_may_wakeup(pl->phydev);
+}
+
 /**
  * phylink_suspend() - handle a network device suspend event
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2625,6 +2631,9 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 	} else {
 		phylink_stop(pl);
 	}
+
+	if (phylink_phy_pm_speed_ctrl(pl))
+		phy_speed_down(pl->phydev, false);
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
 
@@ -2664,6 +2673,9 @@ void phylink_resume(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	if (phylink_phy_pm_speed_ctrl(pl))
+		phy_speed_up(pl->phydev);
+
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 59cb58b29d1d..38363e566ac3 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -157,6 +157,7 @@ enum phylink_op_type {
  * @lpi_timer_default: Default EEE LPI timer setting.
  * @eee_enabled_default: If set, EEE will be enabled by phylink at creation time
  * @wol_phy_legacy: Use Wake-on-Lan with PHY even if phy_can_wakeup() is false
+ * @wol_phy_speed_ctrl: Use phy speed control on suspend/resume
  * @wol_mac_support: Bitmask of MAC supported %WAKE_* options
  */
 struct phylink_config {
@@ -178,6 +179,7 @@ struct phylink_config {
 
 	/* Wake-on-Lan support */
 	bool wol_phy_legacy;
+	bool wol_phy_speed_ctrl;
 	u32 wol_mac_support;
 };
 
-- 
2.47.3


