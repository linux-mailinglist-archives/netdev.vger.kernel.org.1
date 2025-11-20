Return-Path: <netdev+bounces-240501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BF7C75CD7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A00EC3551FB
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9CF2EA743;
	Thu, 20 Nov 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="amw+Rcfv"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F52E7178
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660763; cv=none; b=Z/xaDNLfr6d1ZZpgZ9C9ooBdMADTYcJYkFXg6hlFUYc+XW79Du7BiLdDm0fkqQY5fbduslzfIH7okSi+mDXuzRbKEuZgDeNi/6xLVPvlJeOCTxz8oxhgIotr0qthEECBM48LTMsmoKNYBiw4zBsJe5RvWl7TxEoFP+EADtk+bok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660763; c=relaxed/simple;
	bh=Ml0hDxuyDL5lwBLQI1B5XazAldG2sdL8YIrTfURgI6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEW8BWIoX/Xj1fRLvykmzPfDzGjzfhbACCWeIgvkpys1hX+p7Rlg9bsgYgCqNU9sAUZgL5vH46TAi/C19bU/NHCbVe5zYWfxf/jSw82rT/5fL2y1Fn6uhPa5QUxKk5v842xr/LOL+Qo/x1CbPRTMV2waMcFGO8m3zMFK65nQfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=amw+Rcfv; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763660759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6ZVk3tq458QM8TFucA/Jy/z7mDdAe+KT4wqPQ4qCtU=;
	b=amw+RcfvpMkVidLzogi41mtDgtBavnPttMtxmDd03br3rdxp9h+ERJt3h8Nfymi+id/qZX
	WbX7YQHssg609Dg2MZCmJbANCEm1m+I3Cyqc2YiJYG9L1jouBtF9cx+p6ZUzgEApVwbdkS
	SyufLCbM7KGzouz+fNwyi18u+GF1GLw=
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
Subject: [PATCH net-next v4 2/7] phy: add hwtstamp_get callback to phy drivers
Date: Thu, 20 Nov 2025 17:45:35 +0000
Message-ID: <20251120174540.273859-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
References: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
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
 2 files changed, 8 insertions(+)

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
 
-- 
2.47.3


