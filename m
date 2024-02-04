Return-Path: <netdev+bounces-68923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB2848D7D
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589881F224DA
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3D22325;
	Sun,  4 Feb 2024 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YJXqn2qo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123072556E
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048825; cv=none; b=Oq/U5a/UJyY8au8rxojT9pXDZrVulF3w2ETOfsZUj7BuKMoKnBb9btZn+hmFa7fBbuuEn4dlPCa3lqW02ilL1fZcb0aD+yDjeTVI+9ltVK0XOjUrk5IUQktz9tRsmqdGY+N7hWTJz0c3q1SMIMWg7sjYGf9BAsGSOUsVisL+k44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048825; c=relaxed/simple;
	bh=Qbjf0JT9hYoBy0aIjTyuugeXnqNtP+7bBqJlN4UUpEc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kfRK3d+UxzEQrFMvWKt2jg3oYiATASD3vICGmb7jy2gpUtPGDDhB+TnN8PJeJ8K+2udCz09SHTgrOCTcZPOMQYhhxnIKy10+6nDhd3Ctwimje4H7aaW+CdRrTXURRZ8YYu4yVIYS3QNWGb2F4Y+d/LQMlIn3MyPu6SvMCIpR4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YJXqn2qo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TeSX0Rei3geurLIn6oAwy0QNopjAv7Bbg6lKiahSH1s=; b=YJXqn2qojcMXn1u8LaCWjOxPAp
	7b8xZ+9+rCAS5kQRoB6wIvPYxNXqiLVWvESM1xQM9HN3gQvmkm6OhsrQgJyIs/5tf4Mocb/uwbsjJ
	myLphA06U6OT9cvBffTRLdibaVaEUNBzK4haKBGnjqoR4HMWANPaRhOm3XiZ7UsMuXPaqRRrG87qP
	ep54QTUaKEu0wYztftkE+qGp6XVbfSOMLU/FzuHfkjS584KUTEmFeLgJl2f+8X2dDWJ8xORN93sK8
	48QbM2/jpkDIXPd2viv/JnwerG2qpRWUGXzqZ+ZV5D3vCGWCaROejDXkf2x0wiMSfXHd65tx4PxGz
	flE2S+UA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39974 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rWbNJ-0007xM-1q;
	Sun, 04 Feb 2024 12:13:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rWbNI-002cCz-4x; Sun, 04 Feb 2024 12:13:28 +0000
In-Reply-To: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH net-next v2 6/6] net: dsa: b53: remove eee_enabled/eee_active
 in b53_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 04 Feb 2024 12:13:28 +0000

b53_get_mac_eee() sets both eee_enabled and eee_active, and then
returns zero.

dsa_slave_get_eee(), which calls this function, will then continue to
call phylink_ethtool_get_eee(), which will return -EOPNOTSUPP if there
is no PHY present, otherwise calling phy_ethtool_get_eee() which in
turn will call genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Thus, when there is no PHY, dsa_slave_get_eee() will fail with
-EOPNOTSUPP, meaning eee_enabled and eee_active will not be returned to
userspace. When there is a PHY, eee_enabled and eee_active will be
overwritten by phylib, making the setting of these members in
b53_get_mac_eee() entirely unnecessary.

Remove this code, thus simplifying b53_get_mac_eee().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/b53/b53_common.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index adc93abf4551..9e4c9bd6abcc 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2227,16 +2227,10 @@ EXPORT_SYMBOL(b53_eee_init);
 int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 {
 	struct b53_device *dev = ds->priv;
-	struct ethtool_keee *p = &dev->ports[port].eee;
-	u16 reg;
 
 	if (is5325(dev) || is5365(dev))
 		return -EOPNOTSUPP;
 
-	b53_read16(dev, B53_EEE_PAGE, B53_EEE_LPI_INDICATE, &reg);
-	e->eee_enabled = p->eee_enabled;
-	e->eee_active = !!(reg & BIT(port));
-
 	return 0;
 }
 EXPORT_SYMBOL(b53_get_mac_eee);
-- 
2.30.2


