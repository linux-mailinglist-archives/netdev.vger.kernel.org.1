Return-Path: <netdev+bounces-272934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBwALUhPyWm/xQUAu9opvQ
	(envelope-from <netdev+bounces-272934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A44352CEA
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B62C301CC71
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5637C3803E5;
	Sun, 29 Mar 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="eYJ6ou5Y"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72D3803DD;
	Sun, 29 Mar 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774800643; cv=none; b=dJ5ri08+w0v60Sab2KYz73z1y4TXHHFU3k8yQj3ZNJ21D5fkSz9TKUN4cC+rmBw+JIrZI9rnlENWXpQizUi6o/V3pH3jd1fuIQUCWGQLg3uLlfNcyj0nXTBnxqdA17Qt2m2sq7RwIjKGh4Oq2+m7mFjKkdo8KhqIZYauk3jDsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774800643; c=relaxed/simple;
	bh=q/bWozPvpjS3129sQ1aT6MCNM/+CB287UXZCclsrAiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvlRROCGS8MVr6Ay1pBtpANVhw1f9UMaU7A2Q5aMrqi130wxiC1u7eq5D+oN7MF9n1T0w11YVuTvk4EHaL7JBQpyV8xPM1SRsY+6uYxcAGieUMK7oa5K6DeH1ckg3A4ujbCEOBIPDT2GpWb86bdCL51tPAqKODOq2yqtzW8f0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=eYJ6ou5Y; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 2038EE86F82;
	Sun, 29 Mar 2026 18:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1774800640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OX2jiAI6SxjZvU8BVrCpRDDPGBmGKx9O4aTJ81TZaPs=;
	b=eYJ6ou5YxFaF7NJrr+D0dQg0jcWxxDsXle6FvgOsdoI+2Z2PjgPZMvPi3vTOwRyn7flogJ
	7We6W8t4knYJ6WpGKbbV6Zw5lzpbHbkehk2rpWse27Iu4K+tLIvcOhr5onkONfjSmvJV4O
	eqNxnD3P+sXPIWhZ6R2/pnxSS84vzV/rbVgB9D2uIb+ax8JZO3YT2f47jLG8+m82NDxA/x
	NEEFishcyQ206By6qzxPLJriUi5PXl56dZ3PVNrwCmxhhKFWmjmQecHATnjbXAO3Bv5oBx
	gYiEPmw0dfiaPiFCHRDC6UyFux0sGyPXZow/3BcQN6cC2YFD3/xAwA8Mhh3MpQ==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id DJpmlPOCNOeE; Sun, 29 Mar 2026 18:10:40 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 29 Mar 2026 18:10:39 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH 1/3] net: mdio: treat PSE EPROBE_DEFER as non-fatal during PHY registration
Date: Sun, 29 Mar 2026 18:10:12 +0200
Message-ID: <20260329161014.2908509-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329161014.2908509-1-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272934-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35A44352CEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a PSE controller driver is built as a module, it may not be probed
yet when PHYs are registered on the MDIO bus. This causes
fwnode_find_pse_control() -> of_pse_control_get() to return
-EPROBE_DEFER, which currently propagates up and destroys the PHY
device.

Treat -EPROBE_DEFER as non-fatal, allowing the PHY to register
successfully with psec=NULL. The PSE control can be resolved lazily
when first needed.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/mdio/fwnode_mdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518265..2a03b3fc41e6 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -161,8 +161,12 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	psec = fwnode_find_pse_control(child, phy);
 	if (IS_ERR(psec)) {
-		rc = PTR_ERR(psec);
-		goto unregister_phy;
+		if (PTR_ERR(psec) == -EPROBE_DEFER) {
+			psec = NULL;
+		} else {
+			rc = PTR_ERR(psec);
+			goto unregister_phy;
+		}
 	}
 
 	phy->psec = psec;
-- 
2.43.0


