Return-Path: <netdev+bounces-238311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEBFC5732C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 079504E3F3A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA33385A9;
	Thu, 13 Nov 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lwpgvj5a"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0093375CD
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033558; cv=none; b=X2/RudSgwqwpKAyym8qo8UexTB050ICnHDTFlAd5kaZ2ssLgcuTxjs+uWhzqC2LLeL8Eb1+ZI/1rxjmcqVlP2HRG+1BnYdvusUwG68JEG3dFkEx63HZeYSA+RjejtovzIMWep6LmuQtz4zEtk/NQzh08/EHBJc4ZaU8/zVvvApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033558; c=relaxed/simple;
	bh=cAmZGU+kRffh52wTCXtpg9oc1hrnJNcdJ5iOrwbHuf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtLj+u+d7Rp2SNp4jMFSL2Z3sCpBDzqFgXpssVs9MT6rbdNmFzWz2fJnG9zBG/BO78C5tsM250GPy/7GrcOhFJQ8XbOE2NZ2RhQLjLkzIJ0F3YibLzTX3IXNKrD759mCqtt2hSHjPYA3cYdAopQ/otVOe6jj2zxmZnwN534QmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lwpgvj5a; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763033555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov6nBfYfGfmrnhygj0DVLl06zb3pCG2HNbTLE+jLpQA=;
	b=lwpgvj5a0Lo7yyjGrDwLdEbZ7Q+ZsZWqVzjtMDTHdPlBUO5L9WScADfjKVXJC3l/7keBdT
	ZsubSQZmvUaBqM07VYHbr/ULyoEhwRW8+0dIzB0PcaIlCTUsKfBGr9iPUEhOAkJd8LEl3M
	CiADkFKG++NJdvleE2YbJh8gPYIwHhE=
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy drivers
Date: Thu, 13 Nov 2025 11:32:00 +0000
Message-ID: <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
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

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/phy.c           | 20 +++++++++++++++++++-
 include/linux/mii_timestamper.h |  5 +++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 350bc23c1fdb..6cb87e3608e5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -310,7 +310,7 @@ EXPORT_SYMBOL(phy_ethtool_ksettings_get);
 int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 {
 	struct mii_ioctl_data *mii_data = if_mii(ifr);
-	struct kernel_hwtstamp_config kernel_cfg;
+	struct kernel_hwtstamp_config kernel_cfg = {};
 	struct netlink_ext_ack extack = {};
 	u16 val = mii_data->val_in;
 	bool change_autoneg = false;
@@ -404,6 +404,21 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 
 		return 0;
 
+	case SIOCGHWTSTAMP:
+		if (phydev->mii_ts && phydev->mii_ts->hwtstamp_get) {
+			ret = phydev->mii_ts->hwtstamp_get(phydev->mii_ts,
+							   &kernel_cfg);
+			if (ret)
+				return ret;
+
+			hwtstamp_config_from_kernel(&cfg, &kernel_cfg);
+			if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
+				return -EFAULT;
+
+			return 0;
+		}
+		return -EOPNOTSUPP;
+
 	case SIOCSHWTSTAMP:
 		if (phydev->mii_ts && phydev->mii_ts->hwtstamp_set) {
 			if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
@@ -478,6 +493,9 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
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
 
-- 
2.47.3


