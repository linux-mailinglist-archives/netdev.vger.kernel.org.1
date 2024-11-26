Return-Path: <netdev+bounces-147419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B89D978E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F77162FE1
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785101D3564;
	Tue, 26 Nov 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HcpLlNOl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EED1CCEDB
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625565; cv=none; b=roXyav8b7m3BPV/VOxidaTAXlK8IjpyjECFEvbd1HDKt6DE2HVcfqkyS2aonzlEO2KfRxGzNhJCPyUrNO6ATemaZhYdY4IABTCJyV2pu6XzL3maH4/ZYxXDpt+N+NleTyO1LACzGunKEHMmcX/ob72aLDsIk3nESN9JN7lOmV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625565; c=relaxed/simple;
	bh=R/qrYV9kZf2UteVW2o8IyFtTzUcfSr8/H9X4KQ6+5bQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ISdq62zZSh8rrskgLHVpwGbsOrUksdeMKZYfy95RjrjzdcSiA27DS5c2qmL6zMZtu4qinptryKV596qrd+gg2Y1YHyk7vXP7o6VsbDlknZ6W9+IAcEycxo0NWjsnihprKfi0sl287s+swaU/N1qbw69/PISPFrua3OY4K7huFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HcpLlNOl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pQ1MXfPXQhanrVcmJnPAK+U2MoO2zVEDG8Tfvkbzfc8=; b=HcpLlNOl+oUJjQEGnmUOBOt9gA
	PufJYNxX63ZC0k6qv2fJ1gmgzZwX1ZkEcqZkTxRqVBK96WLf6CVzD/ThxzPxGfdrsCsKdsPWJzJ61
	0v10oI+Gtb+Y5kEpfHg6R50i2oaMYA6edWZTAN3/OwquBVPohX1uTvzIsy01oo4ryZc+fQIqy/A1d
	C/s3ZKZl6XNS2BhG/w1MdZNlJx/S9W6Tbd5QOqeZtHqc4SPj3NnKI8Y2/fvEYKHs+DhUdHSH7gW2Q
	diovs8W7k9EwGMlUmzdj+F7fmpBC9cEIq0xEOm8D/PR6aXX949zq6qqoGPFl3WxodML8mQ4feyi5v
	vG8AVFLA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42098 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv3Q-0006sH-21;
	Tue, 26 Nov 2024 12:52:33 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv3P-005yhf-Ho; Tue, 26 Nov 2024 12:52:31 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 04/23] net: phy: avoid
 genphy_c45_ethtool_get_eee() setting eee_enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv3P-005yhf-Ho@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:52:31 +0000

genphy_c45_ethtool_get_eee() is only called from phy_ethtool_get_eee(),
which then calls eeecfg_to_eee(). eeecfg_to_eee() will overwrite
keee.eee_enabled, so there's no point setting keee.eee_enabled in
genphy_c45_ethtool_get_eee(). Remove this assignment.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-c45.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 944ae98ad110..d162f78bc68d 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1521,15 +1521,13 @@ EXPORT_SYMBOL(genphy_c45_eee_is_active);
 int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data)
 {
-	bool is_enabled;
 	int ret;
 
 	ret = genphy_c45_eee_is_active(phydev, data->advertised,
-				       data->lp_advertised, &is_enabled);
+				       data->lp_advertised, NULL);
 	if (ret < 0)
 		return ret;
 
-	data->eee_enabled = is_enabled;
 	data->eee_active = phydev->eee_active;
 	linkmode_copy(data->supported, phydev->supported_eee);
 
-- 
2.30.2


