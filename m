Return-Path: <netdev+bounces-249962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F2DD21ADC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6143D301E68F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CBE357717;
	Wed, 14 Jan 2026 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x5Yl7BWn"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32E354AF3
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431481; cv=none; b=UVGtYFpT1pboT5eipYdJIvYv+uIQiI20KO+r7brlN/qV9vEu+z0pz0VV4/KyZQ2NwVhd1Wjg1vLDyP/4r5R55h+DbE2uuJp9WQylcZ4356fQuwsbEsjzLV8aUOXIZmFTDm0U3bhbF4qZA6CvJff8x4Mh7aJzUuCVf2GDrymtvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431481; c=relaxed/simple;
	bh=cEX56O7lFKginQnkeWC5k3VQ5cnyMT/ZHcHCaKr+ehw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqUdykPGyzeMtaVvAnLTkC1SCiM7mYxz9UsD03i2z8U7sCzOSADHgnaF3SfAkC1oXSwdw2gf6cy5390vQTOrm76ALNgHn8UkYw45eh+fBC5hSj3zhlHe9zSUsnie7iPt1BEB84lD0iwqVOnuJ6iUEC/QXctjtpRTvETKLejofuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x5Yl7BWn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 916D84E420E5;
	Wed, 14 Jan 2026 22:57:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65C746074A;
	Wed, 14 Jan 2026 22:57:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0EBC10B68410;
	Wed, 14 Jan 2026 23:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768431472; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+/6GTR/lJRvxq7OYqByep9cN9DNBMPgL+lC49ZimkbA=;
	b=x5Yl7BWnN863GrXNmtdIwijhs2RcnvC2ZsHGN5T74+4fSVbGFJ+mTS0wUaeycV0VkN+QM0
	bss2jf72KyQgkIl47EuuyXz/f1TytJLNj9SA9DRbiQjnYcwqP9XWmyT4j5COecGM0iVCiI
	Tz0reOEDhjJQTmgJYAI7UMmkNMAAxpc+jOda6QO/JeI7BDh+dy+2N3LrDRl/pCAAg2R6Xi
	St+zukWadf2dninDaNmEztOZbjg21SEeiSbxIDXTs3NrzY4Kd//7dIymNQcZ48ZxXa78xp
	iBlqe29faCIoRV07nLwB0RObrltffkQ3JW856OyY2aIDh+El9XW0HOFdMkTpoQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH net-next 3/6] net: phy: Store module caps for PHYs embedded in SFP
Date: Wed, 14 Jan 2026 23:57:25 +0100
Message-ID: <20260114225731.811993-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When a PHY device is embedded in an SFP module, the PHY driver doesn't
have any information about the module.

Most of the SGMII to 100BaseFX modules seem to contain a Broadcom BCM5461
PHY. This device seems to support a wide range of possible
configurations, with RGMII or SGMII inputs, and BaseT, 100BaseFX and
possibly 1000BaseX output.

However, there doesn't seem to be a capability register that returns
reliable-enough values to detect from the PHY driver what configuration
we are in. On the Prolabs or FS SGMII to 100FX modules for example, the
PHY returns 10/100/1000BaseT capabilities.

We can know the exact configuration by looking at the SFP eeprom, and
the list of linkmodes built by parsing it and applying the quirks and
fixups. Let's make that information available to PHY drivers, so that
they may use that in their .get_features() and configuration process.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp.c | 5 +++++
 include/linux/phy.h   | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5b42af1cf6aa..1f9112efef62 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1895,6 +1895,11 @@ static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
 	/* Mark this PHY as being on a SFP module */
 	phy->is_on_sfp_module = true;
 
+	/* We need to populate the parent_sfp_caps now, as it may be used during
+	 * the phy registering process, such as in phydrv->get_features()
+	 */
+	phy->parent_sfp_caps = sfp_get_module_caps(sfp->sfp_bus);
+
 	err = phy_device_register(phy);
 	if (err) {
 		phy_device_free(phy);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3beb5dbba791..a515c014679e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -649,6 +649,8 @@ struct phy_oatc14_sqi_capability {
  * @ports: List of PHY ports structures
  * @n_ports: Number of ports currently attached to the PHY
  * @max_n_ports: Max number of ports this PHY can expose
+ * @parent_sfp_caps: Capabilities of the SFP module that embeds this PHY. Only
+ *		     valid when is_on_sfp_module is true.
  * @lock:  Mutex for serialization access to PHY
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
@@ -791,6 +793,8 @@ struct phy_device {
 	int n_ports;
 	int max_n_ports;
 
+	const struct sfp_module_caps *parent_sfp_caps;
+
 	u8 mdix;
 	u8 mdix_ctrl;
 
-- 
2.49.0


