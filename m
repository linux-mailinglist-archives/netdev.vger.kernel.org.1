Return-Path: <netdev+bounces-215293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42922B2DF7E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EBE5E7AA0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66110274FD1;
	Wed, 20 Aug 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gsLXXZKT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA7264624
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700300; cv=none; b=Sjeq5BZv2Brlqs+JjABGrBFqPNX+T47ipgWkFqUdpDhlOApyG8bVK+DNrq/x5f+1ScpShgVind+XrGft7RE+rDHn35rLvThs3dpM/v5809kHh0r+QMP8gb+p96TaPhG6+m7rs8M71yLklXfPTOKo7tENjQHiCjhjqyQBtrvo4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700300; c=relaxed/simple;
	bh=Yom4OxrpButJaoNnWb8BHxERG2GyL+cditjnKw2ur5U=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=otBcyNgZLuZenS9B4jpoqT4cuBandzpsEQMG6wURLUH7B6658mRTY2XbOGntciX6BcfNH42T4SuJwFgB/uoLajDth+M5FN1SPcWEwFzWbG+z9vzBzW5GBP3uhpm7qofbv5KlWHeMdLgN9oVSxCV38XPONdB+l68EGxq7oQ/Tq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gsLXXZKT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tfEpnPPX806gGAT1vDmLicnTjJZMCA1iEnGz+aQZSNc=; b=gsLXXZKTmzn67jwPEK8Sj0SaAV
	MFte2Pv70kKISWgw+gC5shRJmuqEoheNHGzwps+3LkNUwZe7tUxTyGCWQx483tOkmQvTyZL41NEZY
	jYyQF7bTKypZTIB9aTguBQmXlCdqt7yVqqMcOjqR7PRcMgClxd4ISdsSi0NdAtwqTMG4G65T0C4xD
	YcPoylgT6L6dQdkUuKHdURzNhWXNjWKWXwwSKe2toulViTjxUX4kfWWZtiKVA0bPAt6+S0NhDmFXZ
	YJFPj44hEorc/g3COAkzy4DXIDfmHo7Yj03BkMUQYGDg73bQs2Rd8i+fQdARMb81xRg7bcnHPt1tP
	ZyrlHlgA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45032 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uojqW-0004sM-1c;
	Wed, 20 Aug 2025 15:31:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uojpo-00BMoL-4W; Wed, 20 Aug 2025 15:30:40 +0100
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
Subject: [PATCH net-next] net: stmmac: fix stmmac_simple_pm_ops build errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uojpo-00BMoL-4W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 20 Aug 2025 15:30:40 +0100

The kernel test robot reports that various drivers have an undefined
reference to stmmac_simple_pm_ops. This is caused by
EXPORT_SYMBOL_GPL_SIMPLE_DEV_PM_OPS() defining the struct as static
and omitting the export when CONFIG_PM=n, unlike DEFINE_SIMPLE_PM_OPS()
which still defines the struct non-static.

Switch to using DEFINE_SIMPLE_PM_OPS() + EXPORT_SYMBOL_GPL(), which
means we always define stmmac_simple_pm_ops, and it will always be
visible for dwmac-* to reference whether modular or built-in.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508132051.a7hJXkrd-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202508132158.dEwQdick-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202508140029.V6tDuUxc-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202508161406.RwQuZBkA-lkp@intel.com/
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a55e43804670..fa3d26c28502 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8024,8 +8024,9 @@ int stmmac_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(stmmac_resume);
 
-EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmmac_simple_pm_ops, stmmac_suspend,
-			     stmmac_resume);
+/* This is not the same as EXPORT_GPL_SIMPLE_DEV_PM_OPS() when CONFIG_PM=n */
+DEFINE_SIMPLE_DEV_PM_OPS(stmmac_simple_pm_ops, stmmac_suspend, stmmac_resume);
+EXPORT_SYMBOL_GPL(stmmac_simple_pm_ops);
 
 #ifndef MODULE
 static int __init stmmac_cmdline_opt(char *str)
-- 
2.30.2


