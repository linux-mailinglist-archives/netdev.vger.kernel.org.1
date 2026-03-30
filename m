Return-Path: <netdev+bounces-273191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KunLEF+ymmR9QUAu9opvQ
	(envelope-from <netdev+bounces-273191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:44:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E13935C32D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8E230BBCDF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB03D6693;
	Mon, 30 Mar 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="ISpnQpXh"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E483D648B;
	Mon, 30 Mar 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877437; cv=none; b=FPHfEp9BuMaDXVYUNSIoV439PVO94JxC9INH/HEV2HjwK9ytVfpjXFt2OaxeHoP5lMFd7WrIOFxZhra0GHXp8dw0LSrD9UU4pZH3c/lnevBQEO3gf6TvU4GbU5V4CvDBzjDikDzta9kSTLTBGPLASkMiVd58sdlTl9xQHTxPfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877437; c=relaxed/simple;
	bh=0e7CxAM2B0e/ZcmE8icgZD0xm4N1qDxKGBCYWQmW3tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+g9QA68qo93eTyoC5QCuIC4mldUefeJXFIo8QXQ5/xTAUvtgCfLBpHOPJP8fChdf8xvqis2fSIsdfU7Zd2KPfhWNXlv0IxRMmNJSzdJ3dbIFeG4TF1ACFfYC1vBu7P4YHpnzFgViI3ArpWIK/a78UmsAnP9DgWM8XLLqO6RRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=ISpnQpXh; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 18BA5E838DF;
	Mon, 30 Mar 2026 15:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1774877434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5yRNc1A1B4HMPv9zUaBJm62Mi7gwot6reBfCNHYpPc=;
	b=ISpnQpXhVK0aZ8DQB4lfqTWW6ejQkaQQK5RypDyUYN9oT0C7axgV9wdck74ujFEaeu37JG
	oiBxOE8qBEVy91TPjNkqQ4oM6uLwAKsmtFmuVxs4ELEI91Y/iErChL1klzhUYHGE1TjqZL
	qZ7Kq2lNSWYYs77jLmy6amuTeBUxijvoLvhs8uCqe/u57fq+/7O5C90oHBZ5g2uC5Z1319
	aHaQ1Ntd0oz6h/GjSv8qxp5vgQXCcQc0EhCzsXl2/smCFvKWpwB4HJqxygMnu9vmmf5l7w
	Xc/GTamCUmnWzrxesLLknb9fg3JgudhOKaluTiJJ0TTksezt/Ykmk9J8SVObOw==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id 3O6PRCGT1_Ft; Mon, 30 Mar 2026 15:30:34 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 30 Mar 2026 15:30:33 +0200 (CEST)
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
Subject: [PATCH net-next v2 2/3] net: pse-pd: add lazy PSE control resolution for modular drivers
Date: Mon, 30 Mar 2026 15:29:51 +0200
Message-ID: <20260330132952.2950531-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330132952.2950531-1-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
 <20260330132952.2950531-1-github@szelinsky.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273191-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid]
X-Rspamd-Queue-Id: 1E13935C32D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a PSE controller driver is built as a module and was not probed
during PHY registration, the PHY ends up with psec=NULL. Add
pse_control_try_resolve() to lazily resolve the PSE control on first
ethtool access.

Call pse_control_try_resolve() in both the GET and SET ethtool PSE
handlers, before checking phydev->psec. The function is serialized by
RTNL (enforced via ASSERT_RTNL), preventing concurrent callers from
double-allocating a PSE control.

If resolution fails (e.g. the module still has not loaded), a debug
message is emitted via phydev_dbg() and the handler falls through to
the existing "No PSE is attached" error path.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Acked-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 36 +++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h    |  5 +++++
 net/ethtool/pse-pd.c          |  4 ++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 566b07c336bf..390df23a991c 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1569,6 +1569,42 @@ struct pse_control *of_pse_control_get(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(of_pse_control_get);
 
+/**
+ * pse_control_try_resolve - attempt to resolve a deferred PSE control
+ * @phydev: the PHY device whose PSE control may need resolution
+ *
+ * When a PSE controller driver is built as a module, it may not have
+ * probed when PHYs were registered on the MDIO bus. This function
+ * retries PSE control acquisition and should be called before
+ * accessing phydev->psec in ethtool handlers.
+ *
+ * Context: Caller must hold RTNL.
+ */
+void pse_control_try_resolve(struct phy_device *phydev)
+{
+	struct device_node *np;
+	struct pse_control *psec;
+
+	ASSERT_RTNL();
+
+	if (phydev->psec)
+		return;
+
+	np = phydev->mdio.dev.of_node;
+	if (!np || !of_property_present(np, "pses"))
+		return;
+
+	psec = of_pse_control_get(np, phydev);
+	if (IS_ERR(psec)) {
+		phydev_dbg(phydev, "failed to resolve PSE control: %pe\n",
+			   psec);
+		return;
+	}
+
+	phydev->psec = psec;
+}
+EXPORT_SYMBOL_GPL(pse_control_try_resolve);
+
 /**
  * pse_get_sw_admin_state - Convert the software admin state to c33 or podl
  *			    admin state value used in the standard
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index b86cce740551..d2f9b7c1acdf 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -350,6 +350,7 @@ int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
 struct pse_control *of_pse_control_get(struct device_node *node,
 				       struct phy_device *phydev);
 void pse_control_put(struct pse_control *psec);
+void pse_control_try_resolve(struct phy_device *phydev);
 
 int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
@@ -379,6 +380,10 @@ static inline void pse_control_put(struct pse_control *psec)
 {
 }
 
+static inline void pse_control_try_resolve(struct phy_device *phydev)
+{
+}
+
 static inline int pse_ethtool_get_status(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 struct ethtool_pse_control_status *status)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2eb9bdc2dcb9..adffc230acd6 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -42,6 +42,8 @@ static int pse_get_pse_attributes(struct phy_device *phydev,
 		return -EOPNOTSUPP;
 	}
 
+	pse_control_try_resolve(phydev);
+
 	if (!phydev->psec) {
 		NL_SET_ERR_MSG(extack, "No PSE is attached");
 		return -EOPNOTSUPP;
@@ -249,6 +251,8 @@ ethnl_set_pse_validate(struct phy_device *phydev, struct genl_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	pse_control_try_resolve(phydev);
+
 	if (!phydev->psec) {
 		NL_SET_ERR_MSG(info->extack, "No PSE is attached");
 		return -EOPNOTSUPP;
-- 
2.43.0


