Return-Path: <netdev+bounces-172689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA4A55B82
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86059178E94
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2E310F2;
	Fri,  7 Mar 2025 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yoxavBy9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43423BB
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306323; cv=none; b=bfUcocYLpdHo6bdE1z3eoyqDj/vHLkQhk7R+QgE8WOHs+WrjxAUoUS1ipT4z+oQ78l7wuYuV2JeczUAP+K/1iVntiOwDgl6/45ZmctAwt1eTqHxMPo9HC04cdvpm2XpHUuHSRTKLGwh0zdN+5Nph73OWSVIXStReYp4/IYIqdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306323; c=relaxed/simple;
	bh=9UWqAQZvTA0l4QWnKhIpg4adxgfC7KT8Y8Jh7sVpEYs=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=oWzrUykAjmLDQipl2dQxzqa2OGicFo5rdRbiJUWr28Hj8vdvOuvic9E0WdFibdr5QZEw5u2PMEQGpdJAGJHvmj0IFd4AxNWgM3VOI0echGDSO1qD8cTXXVpj4c++gr05QyqoGguWgkPjdX+jRgNu4NDMgXD23VYmnum7xKq76IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yoxavBy9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6aEgnpw6gQBxCmSgxUBsuH9P0cxS5+KhOP2L7j4QauA=; b=yoxavBy9uMeaqY5Luix2nzWH9K
	jSgO1V/jHBPZ65NR7Fk5R+2DTz30tS2MJUgN16e2mn6pUy1DxEWnUW+nW+hrVsHpJMT/MqrN0OD9h
	Zhr40BaND0BIuUZVZc4VwsLYASrglP1gWGmeQqytogdFtVSXHrhVWs2GmMFjgsS6oKXad9NoabOpP
	rTU97JRvvHe46czyKVpBCt52PDxcAKSW66e1+J4Bt0I2pRo8hgh4r8N8xlImqMQhfI7Tjvgwf6tuO
	1K8tLtoFqE7QjNbWknn/kRWwJmkpo2ZHXtu+svmOKa/aHIp/Y1jBlQwi2n+XIxzWK3rQUZoohsaNa
	kZpcF4CA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43876 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tqLJd-0006ft-2l;
	Fri, 07 Mar 2025 00:11:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tqLJJ-005aQm-Mv; Fri, 07 Mar 2025 00:11:29 +0000
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
Subject: [PATCH net-next] net: stmmac: remove write-only priv->speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tqLJJ-005aQm-Mv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 07 Mar 2025 00:11:29 +0000

priv->speed is only ever written to in two locations, but never
read. Therefore, it serves no useful purpose. Remove this unnecessary
struct member.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 04197496ee87..bddfa0f4aa21 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -282,7 +282,6 @@ struct stmmac_priv {
 	/* Generic channel for NAPI */
 	struct stmmac_channel channel[STMMAC_CH_MAX];
 
-	int speed;
 	unsigned int pause_time;
 	struct mii_bus *mii;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2ce18f52b717..982b7d82fd53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1029,8 +1029,6 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		}
 	}
 
-	priv->speed = speed;
-
 	if (priv->plat->fix_mac_speed)
 		priv->plat->fix_mac_speed(priv->plat->bsp_priv, speed, mode);
 
@@ -7859,7 +7857,6 @@ int stmmac_suspend(struct device *dev)
 	if (stmmac_fpe_supported(priv))
 		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
 
-	priv->speed = SPEED_UNKNOWN;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(stmmac_suspend);
-- 
2.30.2


