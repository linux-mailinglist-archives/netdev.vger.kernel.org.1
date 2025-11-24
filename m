Return-Path: <netdev+bounces-241257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE89C820A9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 548E5348BE9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD43191A9;
	Mon, 24 Nov 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h7qYXdA6"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA131814A
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007956; cv=none; b=i4FAfBcT8RVVUXEKBKshytycKxTl3BRRRr67PD9727GQWJD1noISJdrkZi9+qUWHif6Xpv3KJ8rhifu/Kf8dee2T81RKj59/QZahG1WKbh0KAS8aBHPPszBFTqClYGxxYzc3U12P3fIIxESlHFiuV3Pd2AjaSWWzBta31FBaHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007956; c=relaxed/simple;
	bh=4/82s52ZXYIlFCokfySfV7WyZp46pCuA9HQjsiEkHt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEXq7VC8Wa52JGsSbbaqKp4umQ/acaIorlU+ByVeqe7OUt6+9gBkXWmnd++vjtOGod8d5qqZF2yaap148+WPKvjIQupUZcBmNkoOe7dLNeIA8IXTGL7JZjskIw28V52lOCTDuF4oUsRcrOEKwnfZuCGHB+3hUacyToyZgTti3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h7qYXdA6; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764007950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXm25zxrJP1Y6FXbakT5qMuVARbr2BjARqx7QTf2SZU=;
	b=h7qYXdA6BDNYzXysP4DCLPw5HLIcqWNE3/CI3NQSqkvTbsokvDs4oBfEmL229kmYeSUrTD
	79GLhB5/pX2GdcdxQAP+lgkhfSSUDp/oGlG1uqKNkdUGsp7gR9ZlGaqCmtwioPKQNKB33a
	gMTmgvuL7/dlSp2haKxc3Q96OoArphs=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next v5 2/7] phy: add hwtstamp_get callback to phy drivers
Date: Mon, 24 Nov 2025 18:11:46 +0000
Message-ID: <20251124181151.277256-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
References: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

PHY devices had lack of hwtstamp_get callback even though most of them
are tracking configuration info. Introduce new call back to
mii_timestamper.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/phy.c           | 3 +++
 include/linux/mii_timestamper.h | 5 +++++
 net/core/dev_ioctl.c            | 9 +++++----
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 350bc23c1fdb..13dd1691886d 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -478,6 +478,9 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
 	if (!phydev)
 		return -ENODEV;
 
+	if (phydev->mii_ts && phydev->mii_ts->hwtstamp_get)
+		return phydev->mii_ts->hwtstamp_get(phydev->mii_ts, config);
+
 	return -EOPNOTSUPP;
 }
 
diff --git a/include/linux/mii_timestamper.h b/include/linux/mii_timestamper.h
index 08863c0e9ea3..3102c425c8e0 100644
--- a/include/linux/mii_timestamper.h
+++ b/include/linux/mii_timestamper.h
@@ -29,6 +29,8 @@ struct phy_device;
  *
  * @hwtstamp_set: Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
  *
+ * @hwtstamp_get: Handles SIOCGHWTSTAMP ioctl for hardware time stamping.
+ *
  * @link_state: Allows the device to respond to changes in the link
  *		state.  The caller invokes this function while holding
  *		the phy_device mutex.
@@ -55,6 +57,9 @@ struct mii_timestamper {
 			     struct kernel_hwtstamp_config *kernel_config,
 			     struct netlink_ext_ack *extack);
 
+	int  (*hwtstamp_get)(struct mii_timestamper *mii_ts,
+			     struct kernel_hwtstamp_config *kernel_config);
+
 	void (*link_state)(struct mii_timestamper *mii_ts,
 			   struct phy_device *phydev);
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 0720ccc14df9..53a53357cfef 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -249,10 +249,11 @@ int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
  *
  * Helper for calling the default hardware provider timestamping.
  *
- * Note: phy_mii_ioctl() only handles SIOCSHWTSTAMP (not SIOCGHWTSTAMP), and
- * there only exists a phydev->mii_ts->hwtstamp() method. So this will return
- * -EOPNOTSUPP for phylib for now, which is still more accurate than letting
- * the netdev handle the GET request.
+ * Note: phy_mii_ioctl() only handles SIOCSHWTSTAMP (not SIOCGHWTSTAMP), but
+ * phydev->mii_ts has both hwtstamp_get() and hwtstamp_set() methods. So this
+ * will return -EOPNOTSUPP for phylib only if hwtstamp_get() is not
+ * implemented for now, which is still more accurate than letting the netdev
+ * handle the GET request.
  */
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
-- 
2.47.3


