Return-Path: <netdev+bounces-275531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y5JuA49d02nwhgcAu9opvQ
	(envelope-from <netdev+bounces-275531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 477063A1F39
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5174C301227A
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 07:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13A364023;
	Mon,  6 Apr 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="P1iMrgxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A43164A1;
	Mon,  6 Apr 2026 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459712; cv=none; b=TiI68/yMTWu1UWcMWlP3oBM9HXUG+bAbt8vB3bY7kDViTXyX7GrN949jtt2LcixNwXNes6rPutQXbdlzGfMlBIn6paNFu5xCMreBO/by90aTiRdMugcRvngH54Y9uK9lveMXrLsl2Xu1xSW2DS1utyZSR3d26ZM325b5IId6pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459712; c=relaxed/simple;
	bh=LB3vnPpTE/TUlyjaW5iPG1lrYKniuav6TaCOcSRrGD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7mTU1TW7IF2jlEHsarMYatMHeucffSg3qFapWiwJMnDL1EGgn+ByZtcyGZi7XroF9j635Xta5VmOk/msjEgkTclV4GNw+ZvTLagIblD9MdEmbW4xGXRXg5utTNA7b2OHB8aaHZ860lC/6xyuHxxP63umVrIMfCzrx5NBzXJxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=P1iMrgxE; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D96A2A589E;
	Mon,  6 Apr 2026 09:15:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775459701; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9ViK1ay8NbI2CDWLDB9hK9WGLu5iTogx7vDteWd055Y=;
	b=P1iMrgxEYyoL/dw3+KXa87wZXUsoT2FDek89dq5QiOKyvxsvxHc12oK1jDxVX30U+u75LS
	EZgB5Tf7rPybU00073Eix4BUyWPZ2e39J2hSKT4YieqBWNNzL4CCHCGoaOX2ZMQcaBEFKW
	PrLXM1HmBC5thOtPoDJlQnrwPivQMAKbDHuS+WQSvQvjDfClNnnnIeXQUDGF8v+z5ol3RU
	JTIjarnUB6qUghWGl62pmqz/KNTv7pcHp0YNzSUE30dHZQ4IU8DHo5qll9dsfgFfOjSleT
	guw+L269Mj6lVvafliZq0ZQz09WhG46IVRn4egSjiYzH4qL0OaDe8tBsXiKEZg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 06 Apr 2026 09:13:07 +0200
Subject: [PATCH net-next 1/3] net: phy: add support for disabling
 PHY-autonomous EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-devel-autonomous-eee-v1-1-b335e7143711@tipi-net.de>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
In-Reply-To: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275531-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: 477063A1F39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some PHYs (e.g. Broadcom BCM54xx, Realtek RTL8211F) implement
autonomous EEE where the PHY manages LPI signaling without forwarding
it to the MAC. This conflicts with MAC drivers that implement their own
LPI control.

Add a .disable_autonomous_eee callback to struct phy_driver and call it
from phy_support_eee(). When a MAC driver indicates it supports EEE via
phy_support_eee(), the PHY's autonomous EEE is automatically disabled so
the MAC can manage LPI entry/exit.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy_device.c | 22 ++++++++++++++++++++++
 include/linux/phy.h          | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0edff47478c20dd8537d4b94806be13b2409c711..cda4abf4e68cddb25b4ac69c35c8e095fac3e31c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1375,6 +1375,14 @@ int phy_init_hw(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Re-apply autonomous EEE disable after soft reset */
+	if (phydev->autonomous_eee_disabled &&
+	    phydev->drv->disable_autonomous_eee) {
+		ret = phydev->drv->disable_autonomous_eee(phydev);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(phy_init_hw);
@@ -2898,6 +2906,20 @@ void phy_support_eee(struct phy_device *phydev)
 	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
 	phydev->eee_cfg.tx_lpi_enabled = true;
 	phydev->eee_cfg.eee_enabled = true;
+
+	/* If the PHY supports autonomous EEE, disable it so the MAC can
+	 * manage LPI signaling instead. The flag is stored so it can be
+	 * re-applied after a PHY soft reset (e.g. suspend/resume).
+	 */
+	if (phydev->drv && phydev->drv->disable_autonomous_eee) {
+		int ret = phydev->drv->disable_autonomous_eee(phydev);
+
+		if (ret)
+			phydev_warn(phydev, "Failed to disable autonomous EEE: %pe\n",
+				    ERR_PTR(ret));
+		else
+			phydev->autonomous_eee_disabled = true;
+	}
 }
 EXPORT_SYMBOL(phy_support_eee);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5de4b172cd0ba0048039d73d049b0ff24e8b2e44..199a7aaa341bfd9b13731e996a8de7e1aea586ff 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -612,6 +612,8 @@ struct phy_oatc14_sqi_capability {
  * @advertising_eee: Currently advertised EEE linkmodes
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
  * @eee_active: phylib private state, indicating that EEE has been negotiated
+ * @autonomous_eee_disabled: Set when autonomous EEE has been disabled,
+ *	used to re-apply after PHY soft reset
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
@@ -739,6 +741,7 @@ struct phy_device {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
 	bool enable_tx_lpi;
 	bool eee_active;
+	bool autonomous_eee_disabled;
 	struct eee_config eee_cfg;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
@@ -1359,6 +1362,17 @@ struct phy_driver {
 	void (*get_stats)(struct phy_device *dev,
 			  struct ethtool_stats *stats, u64 *data);
 
+	/**
+	 * @disable_autonomous_eee: Disable PHY-autonomous EEE
+	 *
+	 * Some PHYs manage EEE autonomously, preventing the MAC from
+	 * controlling LPI signaling. This callback disables autonomous
+	 * EEE at the PHY.
+	 *
+	 * Return: 0 on success, negative errno on failure.
+	 */
+	int (*disable_autonomous_eee)(struct phy_device *dev);
+
 	/* Get and Set PHY tunables */
 	/** @get_tunable: Return the value of a tunable */
 	int (*get_tunable)(struct phy_device *dev,

-- 
2.51.0


