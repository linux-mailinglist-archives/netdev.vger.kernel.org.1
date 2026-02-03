Return-Path: <netdev+bounces-256382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBkmBfAxgml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:35:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A198FDCDEF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4624F31794A5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7151A35E544;
	Tue,  3 Feb 2026 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0oL+5ezK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F8324B16
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139744; cv=none; b=e4ueKB8rO7ieL3Czk+9dBRE2uA3jSwpfT5MBNNzbZlZWmUZnXmKuBmK1cvXNezypJ2IJe1dBLy92MbdC8F8Kwj//tqA99hOQ5i6q+fOfBYJsIhxMG2u1RcwPU/6E3AH5r6ckAPAdS+VRq+2knKwuXhOP1thwQeZJqb2o0ORtlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139744; c=relaxed/simple;
	bh=mWyMx4Wb/HCw51vDYbHGsY4S6C9v30+HtBdi1q1SCSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa9F41irhjodFU/M27/RZmNtMjgNWI8RwVK7sXvn1+UqF/QgPeosLLNEWzBIrmVM/VFjWWbPRormsJtaE28xKSxbmcnwvkEB/SWvuADsFOPbxNkK2a43GBJ9fEaRrs83e6iloOlF89C5lXCPkzEvnu7PNV1A0de2hx0P/LXAygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0oL+5ezK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 40EAC1A2BC6;
	Tue,  3 Feb 2026 17:28:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 10D3160728;
	Tue,  3 Feb 2026 17:28:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A7D8A119A8891;
	Tue,  3 Feb 2026 18:28:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770139734; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KecJRPe2Bv70TIJpdknGkVxhofD7qopvizBIlkrUTDs=;
	b=0oL+5ezK79vBEpfRX9ZMmL99O5b7ITFB+focEqMtyIuOjKO0HftypZfxC+GmiV3wGeyUi+
	cNq6JDVr+wFjGMmGwl2pyzaWGOuUED8TuwlsBkrseEX4/I42tfPlMcqFUy2X2I6q07HGUN
	ZqunLmyZVgbRNhv17NHnaOXAeR8jHrRzOalZJEJEG6mLwbqo3BJ/JlVu9i00dq1XqjLsUK
	KS4cE2lX+VAc/prdbkzM1huEoO0bbnzzCCxDoZ4TFJ8EIIyPYtiD7omwqPKT2Tm+KtkLWZ
	EcVQou92bUb9DOvavoBfUp56qddqW/7RGq90K/MMiRGAN6XN14R4sGtfsogORg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v4 02/13] net: phy: phy_port: Cleanup the of-parsing logic for phy_port
Date: Tue,  3 Feb 2026 18:28:26 +0100
Message-ID: <20260203172839.548524-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
References: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256382-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A198FDCDEF
X-Rspamd-Action: no action

We don't need to maintain a mediums bitfield, let's drop it and drop a
bogus check for empty mediums, as we already check it above.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_port.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
index ec93c8ca051e..a269e9ea12c4 100644
--- a/drivers/net/phy/phy_port.c
+++ b/drivers/net/phy/phy_port.c
@@ -53,7 +53,7 @@ struct phy_port *phy_of_parse_port(struct device_node *dn)
 	enum ethtool_link_medium medium;
 	struct phy_port *port;
 	const char *med_str;
-	u32 pairs = 0, mediums = 0;
+	u32 pairs = 0;
 	int ret;
 
 	ret = fwnode_property_read_string(fwnode, "media", &med_str);
@@ -85,17 +85,12 @@ struct phy_port *phy_of_parse_port(struct device_node *dn)
 		return ERR_PTR(-EINVAL);
 	}
 
-	mediums |= BIT(medium);
-
-	if (!mediums)
-		return ERR_PTR(-EINVAL);
-
 	port = phy_port_alloc();
 	if (!port)
 		return ERR_PTR(-ENOMEM);
 
 	port->pairs = pairs;
-	port->mediums = mediums;
+	port->mediums = BIT(medium);
 
 	return port;
 }
-- 
2.49.0


