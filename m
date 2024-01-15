Return-Path: <netdev+bounces-63516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A795082D8FC
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 13:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A274C1C212F4
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D06EAF7;
	Mon, 15 Jan 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dcnndGmw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A212919
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XxhEd9cflsB7O8erhUt2gxrz3iW0YEFDEzAzcjUsR2Y=; b=dcnndGmwyjXUryikmNOSEheDlr
	FaJHbhb1vCZtpRQGjcoSBk7qQB8TiLvJ2bQJ3S7UhWq6vvY9f0rgtqPNS6p0rrurnNHRbSmGs+C4D
	rDZgX0SNIoH4YYNkdyP3FKYj0fYMPexw7gyxBUTfxpgFMpX7UWbsjgM3DmbUNVcn9nyRuyVSp/uUv
	wOvCdwTYdNpaEwor4DODcIOyTv4POl5z8GoAAiRaGYSzS78OTtTIoPx03r5rb+ShzoAWz/UrCREyE
	fAVWAQS5+sEdlrGxgVr1Ah4tfIqTgHVJUb4IWVdiENYo1HQz/5wC6Hy86QehtwJxWIyySdJGg0qDW
	yOwAid1Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42080 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rPMJW-0002OP-1l;
	Mon, 15 Jan 2024 12:43:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rPMJW-001Ahf-L0; Mon, 15 Jan 2024 12:43:38 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: sfp-bus: fix SFP mode detect from bitrate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rPMJW-001Ahf-L0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Jan 2024 12:43:38 +0000

The referenced commit moved the setting of the Autoneg and pause bits
early in sfp_parse_support(). However, we check whether the modes are
empty before using the bitrate to set some modes. Setting these bits
so early causes that test to always be false, preventing this working,
and thus some modules that used to work no longer do.

Move them just before the call to the quirk.

Fixes: 8110633db49d ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 6fa679b36290..db39dec7f247 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -151,10 +151,6 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 	unsigned int br_min, br_nom, br_max;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
 
-	phylink_set(modes, Autoneg);
-	phylink_set(modes, Pause);
-	phylink_set(modes, Asym_Pause);
-
 	/* Decode the bitrate information to MBd */
 	br_min = br_nom = br_max = 0;
 	if (id->base.br_nominal) {
@@ -339,6 +335,10 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 		}
 	}
 
+	phylink_set(modes, Autoneg);
+	phylink_set(modes, Pause);
+	phylink_set(modes, Asym_Pause);
+
 	if (bus->sfp_quirk && bus->sfp_quirk->modes)
 		bus->sfp_quirk->modes(id, modes, interfaces);
 
-- 
2.30.2


