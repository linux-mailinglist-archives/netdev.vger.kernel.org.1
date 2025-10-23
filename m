Return-Path: <netdev+bounces-232043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0099EC004BA
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527621A66AB4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AAA309DDB;
	Thu, 23 Oct 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zouN61j2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1C2EC0A7
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212290; cv=none; b=LZjcUVtgUejvnHK+hzleHbFm2n1/+3urtFovwtbPgczS6P9aCQ6cP3acGj+B+YdU2xAW82edw/eg1NQgVMs4vjg4EcstSY+iDu0WgdETJo8eMThpJl6Fq6ITEesHIFjg0JsOo4e4Vy7qRf2YY1+lyR3yE6dfWmpkkqJjzU1Bi5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212290; c=relaxed/simple;
	bh=f+YIIuokfwQi+uSqfbjSOcc807AhhxzYBwfrI+K+sTY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bFdvi7Q3xO8Ll1naukglZ2lrcAD9Qw0Ob5I5lzbdyOqJaIkBv6hI3Wft5ZUY3MTX2WuaW8TZzxFXKrlyezWDgUWyk2o4n0a83CbZuu3eENgyAMDf9KNQw4r13HtO6IhJNbAl6l/Rgxl0TabxUSpW2v3sx0+jrMP/LuYlx1a/51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zouN61j2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IJGhy7KxPfdS+64xVDyHXlvPcLaaDSPwNZ283/2YnMk=; b=zouN61j2Rf8Y9hgeNCSs53gPCo
	FtiBQ+w4r8SfR0Dfk3L7aAH8XR20oQNAcQAqyozJS+zGvDdY6ce88CCkT5w5cFoqep9IK9yexSmqF
	wXIYUxDQk64mz/2YKPEez97Ps0cxVg3DlkbwM1CaNUx95FeaZwjg5FJq7l8ettXaJpxQStCQCOsqD
	JC593jEbkUZ6hYSdLZ8XCAFXFGsR4l8PI+EOUKTlc4NZEEnod7yQ5zYPmX32CyX1S43NEiST56bJs
	83ConPvkQvRZRbO7w+VQ/JCycx5jgaTfQNw6Lc9aCMO9VZRHv3NgOQsjyR5va9ERKvM+jpx7ihlo6
	VvxXMBiw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50836 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrlb-0000000066X-3Pr3;
	Thu, 23 Oct 2025 10:37:55 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrla-0000000BMQM-462M;
	Thu, 23 Oct 2025 10:37:55 +0100
In-Reply-To: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 7/8] net: stmmac: use != rather than ^ for comparing
 dev_id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrla-0000000BMQM-462M@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:37:54 +0100

Use the more usual not-equals rather than exclusive-or operator when
comparing the dev_id in stmmac_hwif_find().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 6c5429f37cae..187ae582a933 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -314,7 +314,7 @@ stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 dev_id)
 		if (snpsver < entry->min_id)
 			continue;
 		if (core_type == DWMAC_CORE_XGMAC &&
-		    (dev_id ^ entry->dev_id))
+		    dev_id != entry->dev_id)
 			continue;
 
 		return entry;
-- 
2.47.3


