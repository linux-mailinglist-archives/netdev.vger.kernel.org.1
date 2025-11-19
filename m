Return-Path: <netdev+bounces-239972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E9C6E96C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3D7262E00E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227D3596F4;
	Wed, 19 Nov 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GKDa5HN+"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AF3538AB
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556496; cv=none; b=WbldBT0KfGDELvG+E2lbcLfjf3CVbx0Whro2atzXq4e7O8IxCcewV4iBPH640h0AyxcSFj/V28FWhXIt7E/T6fqvnkG0uoSY0yaxEAUS1y9AyG6uqUwM/o76J5ucGNYZMmEMKDkozvHGxj74te5WtrDEBk621Qrk7OEYyrk5S1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556496; c=relaxed/simple;
	bh=BpOYrPqHUpGBZi3pCFKEmSfptgqfG57CasHF0PLBQ+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4Lf7jB3fcJrAUQ5dzOJjs15GD0cOrF0B1yyKgu5lV+dJHAgbZ8OvotuKXGpRTm2judqT8uva6btYpyKX3WXDVDx5fXmr1iw2MPh8FFbzZKO8rpn5lARGaXPVsDw12RQV8gqi17hTwugGPmXEsGMT2iMbwoUa6ZDXc7SzJFBctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GKDa5HN+; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763556490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcxB4nsKijz1vDOOf2ALo6qZ9llZ5vrLI38qGHOiLJQ=;
	b=GKDa5HN+4Y6Ok/5c6uh//YUkWesCc+Abz3AzCVo9xoyRAKBeOpEjBCo4hT/r1Racfo7x2f
	VNiPtz1QwpZFL1HBxckX8+crJ8kthReDYCzk42L91Yeb9t8+eFCHvUF6l+CbbS5m5AbvXJ
	xHtBfgwTzornqtM7TehbfqDAj/zvJWY=
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
Subject: [PATCH net-next v3 2/9] phy: add hwtstamp_get callback to phy drivers
Date: Wed, 19 Nov 2025 12:47:18 +0000
Message-ID: <20251119124725.3935509-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
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


