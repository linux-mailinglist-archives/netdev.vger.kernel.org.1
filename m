Return-Path: <netdev+bounces-131966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9D9900D0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B491F21681
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BF14C582;
	Fri,  4 Oct 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cWweY8In"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599C13BAC3
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037294; cv=none; b=u75zQIkBZkLkl5QJ/WkpsgkxLPUHY9KwW7kTYFb2s3S9gWFV1FeFKAwQJe2qadqnE0J0hxqJVfjMnbHyAFr6cEDhu52ZKlbxnwDf62W8D7yh7mLT49i4AmgZoQ7tS0ogs7x6pt0IazVGE4RB17nWqarg14lhouCRcjnQaDuyhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037294; c=relaxed/simple;
	bh=IE9BHOKo5CL4yXg3xVk969bpkgUOCkIeeh9iFKvRzrU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DkO49NEDs6PRlPx+9nGl2vu6sJW76s/B6UX8YcJwDMtsvGJ75xdPCtWLgxxdJlD2/pgd8hMZjRDbzGgySBlB6XcNKf7lW07AEge3XReYDigjdiUfgh8mtsNGUmfjfweZ5UjQEAc304VYy69lBd/xO+IL+ywc+TvOPNxgN9dAlKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cWweY8In; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U0WGtMwB2JAdMu9ta3WK+7Gh2goMm2xjQo/yI1JHS08=; b=cWweY8In1ONhToGuvycITonKse
	0TJmk1UoB4T73uZpr2D7rCfMRA1jx+oXZfaazEa15vPZB/tBDbSGfKlovBbVW2MYOraNA6vQT2RSX
	JmvgI2dQHf5oIkofdVAw7ybs+C6rtqGd6jxJFEg31A58t+ZD2jLcqhwjpP8uUiFaWHlcV6jp+ZSHx
	9ComnGfrtHbawd5TAY1CqVLa2vDLTm9KiFE1IlmnCnGI2lukdN0wTE0wMTBjt4ZuUZG8gM1ybo8Uk
	SIcGvtynXiMT2xEcVd/BZU8kEHvMpUwVltnzw2sBoF9lwWXSuKDxBcM5E4jBJCdoIWgBkYyWHmr/K
	Tzh3C17g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42302 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfQx-0001hS-02;
	Fri, 04 Oct 2024 11:21:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfQu-006Dfa-0h; Fri, 04 Oct 2024 11:21:12 +0100
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 07/13] net: pcs: xpcs: move searching ID list out of
 line
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfQu-006Dfa-0h@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:21:12 +0100

Move the searching of the physical ID out of xpcs_create() and into
its own xpcs_identify() function, which makes it self contained.
This reduces the complexity in xpcs_craete(), making it easier to
follow, rather than having a lot of once-run code in the big for()
loop.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 41 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index db3f50f195ab..805856cabba1 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1339,6 +1339,26 @@ static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_link_up = xpcs_link_up,
 };
 
+static int xpcs_identify(struct dw_xpcs *xpcs)
+{
+	int i, ret;
+
+	ret = xpcs_read_ids(xpcs);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(xpcs_desc_list); i++) {
+		const struct dw_xpcs_desc *entry = &xpcs_desc_list[i];
+
+		if ((xpcs->info.pcs & entry->mask) == entry->id) {
+			xpcs->desc = entry;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 {
 	struct dw_xpcs *xpcs;
@@ -1395,7 +1415,6 @@ static void xpcs_clear_clks(struct dw_xpcs *xpcs)
 static int xpcs_init_id(struct dw_xpcs *xpcs)
 {
 	const struct dw_xpcs_info *info;
-	int i, ret;
 
 	info = dev_get_platdata(&xpcs->mdiodev->dev);
 	if (!info) {
@@ -1405,25 +1424,7 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 		xpcs->info = *info;
 	}
 
-	ret = xpcs_read_ids(xpcs);
-	if (ret < 0)
-		return ret;
-
-	for (i = 0; i < ARRAY_SIZE(xpcs_desc_list); i++) {
-		const struct dw_xpcs_desc *desc = &xpcs_desc_list[i];
-
-		if ((xpcs->info.pcs & desc->mask) != desc->id)
-			continue;
-
-		xpcs->desc = desc;
-
-		break;
-	}
-
-	if (!xpcs->desc)
-		return -ENODEV;
-
-	return 0;
+	return xpcs_identify(xpcs);
 }
 
 static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
-- 
2.30.2


