Return-Path: <netdev+bounces-136124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F09A0646
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7632A1F25173
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2E206078;
	Wed, 16 Oct 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e858bfZL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2D206945
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072725; cv=none; b=qoxd2ddRJyBgKy+JzTdwsGyOOuUA37mi9Fy3AD1xALuAmyR0bO8n+ue5aEK+sGL8uhJXLRhZ5XkWtKILJvq3i4/AFUsE874X/RHQMT536jIzbhvj9ALS9T0AragdtXBOb6rCC5Jx4SVuyZh+1CDJX/g9BXA77Mtq3j26YHrwH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072725; c=relaxed/simple;
	bh=FvdU3DWKUgbVK0XVFHzYPLnVuo12X0juTD45vbPEdxc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=s6WW7zirBUOhmxL3H5LDj2oS9vw2EYBWl69VnBn2vdA16STJAG6PmOaqZuJUtOcSSQHpe7rBuysxmssvmLJkNX/IZx6Tr4zrVRiAj60xn04XFYIgl2O285gTq8Q1zTtC3MA8VnIAMkuT30IHut4GC0QyhQ47g1p17GN58odXaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e858bfZL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nSSQDQ5g/lLOl8168V5Cn4WsFtWFef0UUUyBDXjq6Mk=; b=e858bfZLJxPDHYL1PrYo3lNYNW
	iVn1cBeGb03tBfKC07tagwIqBzHYtqayOakzEDTI6D0aagi+yBsspCdk9DsstY2JGjF594Vs9+PN9
	FQLx+oayk51jiPOLmECfKwqKYtkL77+8krgVaufBRZ/AcFKuCkUJWBPVt3TKy8xv35E0E8sTzKEII
	Wy32cm0/0b7vHKi5TY9YFF++0iLSTHVtUF63AIcGSHcVSJgE5ifCsIgVCNlT2SLgBg9qErx6RXdOS
	UkRVk8/+jGFxby6tRHtUmAz6+8vmOIl/LHL4rbAjcNtBm6fYLc0ad+CDt0KsCWuOPSfOfg9BC2xC5
	oYPoKnlw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59086 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t10nf-0004s6-2L;
	Wed, 16 Oct 2024 10:58:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t10nf-000AWi-PR; Wed, 16 Oct 2024 10:58:39 +0100
In-Reply-To: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 4/5] net: phylink: remove use of pl->pcs in
 phylink_validate_mac_and_pcs()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t10nf-000AWi-PR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Oct 2024 10:58:39 +0100

When the mac_select_pcs() method is not implemented, there is no way
for pl->pcs to be set to a non-NULL value. This was here to support
the old phylink_set_pcs() method which has been removed a few years
ago. Simplify the code in phylink_validate_mac_and_pcs().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index aa1139efc7e4..94f3c5fd09ed 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -649,8 +649,8 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 					unsigned long *supported,
 					struct phylink_link_state *state)
 {
+	struct phylink_pcs *pcs = NULL;
 	unsigned long capabilities;
-	struct phylink_pcs *pcs;
 	int ret;
 
 	/* Get the PCS for this interface mode */
@@ -658,8 +658,6 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs))
 			return PTR_ERR(pcs);
-	} else {
-		pcs = pl->pcs;
 	}
 
 	if (pcs) {
-- 
2.30.2


