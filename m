Return-Path: <netdev+bounces-181907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB1A86D99
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 16:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EA03A3988
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E113E02D;
	Sat, 12 Apr 2025 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dBOO0Ydf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D71804A
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467462; cv=none; b=GNOJ0YirLpN87xYbgVDbpwjjlgyBOol0B3fk6u7AVQCZmM1UC9Wldo9MiXdI3NP1EhbisOQony/AX2g3S04gj2Uq1QEPLl6c544mLCDLGFsDxwMm9zh5yyrQ+TwKVgjT98OZp4I1j5IuhqM8KctllWTAJ+x7YLiE+yLq/RGKWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467462; c=relaxed/simple;
	bh=lER4b2oqxeAHTQ6KUQM56C/5ev5JvmcDKouPzzCSP8k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rvjdtgSCCEyoTsqhRI9hk44OaghRnLDppvIkDRAhpA/rdRzip5p4lh5SAdA2/L2TnqpOQUGDtOphHme2mZ3P9e1FQJYB4MwsHQgnjz0bIRr9OO3Tfz8TbCePdRq+/vJ2q4uZKggKgJlPweh/tx0fPUdLZnm3lZWGlTi+rr2a3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dBOO0Ydf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9FSsaukLF8royeXNwHBuaIKUVxUX+OAyF91g37Orbx4=; b=dBOO0Ydfxn5g7p0sW8qa3xoVny
	QX/V9c/9/O793CIfBsZEEKhDIaU8vgaljiCmO2d9WJrCgz+iS/zPqi8XVh1xl82Jh1WzQTUQ8Z9LT
	3PNQm8SLNFTmt4QOBGZXyG/PuGYwpMT9Q3XzUbO/shGQSPN30635uKpQBgxi04E5E7g5UVjGaNuh9
	7ekzA+ojoRXlFBGOKSAhu+aqky+asHuMdzd2eyFEprVJBTKqobdWQUmyr0xDognUqevDcH+NyVTAO
	KIE/tQSpMUwm3juY3627jLcxyBgvmkSA/bb03Ds5+eAiNdsVWFZOCiU1REwBIA8roizH4AswoQR7m
	H63pfzdQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60238 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3bfq-0004c0-1u;
	Sat, 12 Apr 2025 15:17:34 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3bfF-000Eli-C5; Sat, 12 Apr 2025 15:16:57 +0100
In-Reply-To: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/4] net: stmmac: anarion: clean up
 anarion_config_dt() error handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3bfF-000Eli-C5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 15:16:57 +0100

When enabled, print a user friendly description of the error when
failing to ioremap() the control resource, and use ERR_CAST() when
propagating the error. This allows us to get rid of the "err" local
variable in anarion_config_dt().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 37fe7c288878..232aae752690 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -65,13 +65,12 @@ anarion_config_dt(struct platform_device *pdev,
 {
 	struct anarion_gmac *gmac;
 	void __iomem *ctl_block;
-	int err;
 
 	ctl_block = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ctl_block)) {
-		err = PTR_ERR(ctl_block);
-		dev_err(&pdev->dev, "Cannot get reset region (%d)!\n", err);
-		return ERR_PTR(err);
+		dev_err(&pdev->dev, "Cannot get reset region (%pe)!\n",
+			ctl_block);
+		return ERR_CAST(ctl_block);
 	}
 
 	gmac = devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
-- 
2.30.2


