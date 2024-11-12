Return-Path: <netdev+bounces-143978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57AD9C4F65
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793631F215A3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 07:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607FF20B7F5;
	Tue, 12 Nov 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iqsw9gt3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA820B800;
	Tue, 12 Nov 2024 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396329; cv=none; b=JIFpvlmd3qogtLhyPDvGs6Ua9utestqt9vmA43ntrjtS4OreQG6KK5hg7y/9wfm4LLXiQxYpgjJCrImpfU5jNtAWkh3Nv4yaPP78XtE/IIl4iN9apx63M6hIfUaZvj5i4B8ikcwBg1uVja9GU5Zphn/x9Z6tApbgcfJKR0G/FDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396329; c=relaxed/simple;
	bh=HJUJ4+L4CnC/4Dsqig6kGVJWQvrMvkHAl3v7go1mWiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZOvHBVQ2YWLMqt6UpP2+Sb0UMMCux8GLq0B9U3BgK0goVlKjK7aJPLP8YQgjEjTdMPaRGIasx4FNGpCFaEqNd1A4fFROhuWTvqqvXv8lEwajCFS3DJgq/kfU6tAPbq8G3Atu/HMNWxLiEcXM/OQrvfPs2W1BxIhTEyMfJNmVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iqsw9gt3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731396328; x=1762932328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HJUJ4+L4CnC/4Dsqig6kGVJWQvrMvkHAl3v7go1mWiQ=;
  b=Iqsw9gt363BmxZ0uDeHt+q790vK8Ry/JYXWAlkT6GvysFwP+mQP3nhjN
   4ojrA4aApDTqrvmCl1MUMbRZGI8Y7vj1DeLr/7VytFJBFtPPrxPBbTF8H
   C97qja7mDZzHlNa/X5Ek7fcAlT0rvRS5IicsMsSIn5TQ+nK7DVYmuCNcV
   +sjUP62SxnQv8qYBAGWyYoCsJSrkyWmU1lxyVSs+kzXrEzSt5hKifJuQ+
   kwvQWv251zZeprYS+LpnzqjXYt8R6sXPha+ZJ04Kw3Sz3l5TixnDf8RT9
   uR6ETk4RX5z2v4BFBLjCiv5TugPDJCns+saREloUfjitXj3hvXql7h84g
   w==;
X-CSE-ConnectionGUID: OBk9Wc/gR2+RN6DhhXOAUg==
X-CSE-MsgGUID: o4Aep1TMR5y57YeXr6H2Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31387823"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31387823"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 23:25:27 -0800
X-CSE-ConnectionGUID: VJxMQNAyRCqk1YIV90zEkQ==
X-CSE-MsgGUID: CEatCA5dQICZymbRza30iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87074244"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa007.fm.intel.com with ESMTP; 11 Nov 2024 23:25:24 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v1 2/2] net: stmmac: update eee_cfg after mac link up/down
Date: Tue, 12 Nov 2024 15:24:47 +0800
Message-Id: <20241112072447.3238892-3-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the eee_cfg values during link-up/down to ensure that
'ethtool --show-eee <devname>' works correctly.

Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
Cc: <stable@vger.kernel.org>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7bf275f127c9..1e16c2d8f951 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1005,6 +1005,8 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 	priv->tx_lpi_enabled = false;
 	priv->eee_enabled = stmmac_eee_init(priv);
 	stmmac_set_eee_pls(priv, priv->hw, false);
+	phy_update_eee(priv->dev->phydev, priv->tx_lpi_enabled, priv->eee_enabled,
+		       priv->tx_lpi_timer);
 
 	if (priv->dma_cap.fpesel)
 		stmmac_fpe_link_state_handle(priv, false);
@@ -1118,6 +1120,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		priv->eee_enabled = stmmac_eee_init(priv);
 		priv->tx_lpi_enabled = priv->eee_enabled;
 		stmmac_set_eee_pls(priv, priv->hw, true);
+		phy_update_eee(phy, priv->tx_lpi_enabled, priv->eee_enabled,
+			       priv->tx_lpi_timer);
 	}
 
 	if (priv->dma_cap.fpesel)
-- 
2.34.1


