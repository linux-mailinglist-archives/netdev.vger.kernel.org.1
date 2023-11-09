Return-Path: <netdev+bounces-46752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411EE7E6307
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 06:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44C7280ED0
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 05:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA163B8;
	Thu,  9 Nov 2023 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKzsamSc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6063A9
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 05:03:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05261D58;
	Wed,  8 Nov 2023 21:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699506239; x=1731042239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxgTlz8DTOjfWlg4jszUqQlmMAps8QNPlUyELVJIm1M=;
  b=eKzsamScKLOWc88vsxUaLUmovGLUDUBtgB5KXlHuxBybKL1NKchXW9RJ
   k1j1Q98QTDpWon0Ct2yqzv1YywlhwLwksHiPnx3WPsbyu3kX9K5MIDRlr
   62D55Kq8kLcsD+wCHlUgLBcP+Tfh9nl+awh6eHPk+h3KrxjLTEvOmOVAh
   J+eBb4GaiolhwDR+YO29n8Kw6j1eCS5r+1zGlQ7C7gsXEC2IztxZRZNOY
   49nnVX3rUkgWFwYl7nYHRgr4nwYTrFIog3OFZV4t1Lq/NByTmgv0fHnzg
   nQw8Mdxp0nnPNxk9RNjUIDFd8zhGI810XS8cz6FFRGUtngu/fG7BsXXio
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369249823"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="369249823"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 21:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="4425719"
Received: from ssid-ilbpg3-teeminta.png.intel.com ([10.88.227.74])
  by orviesa002.jf.intel.com with ESMTP; 08 Nov 2023 21:03:55 -0800
From: Gan Yi Fang <yi.fang.gan@intel.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net 1/1] net: stmmac: fix MAC and phylink mismatch issue after resume with STMMAC_FLAG_USE_PHY_WOL enabled
Date: Thu,  9 Nov 2023 13:00:27 +0800
Message-Id: <20231109050027.2545000-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gan, Yi Fang" <yi.fang.gan@intel.com>

The issue happened when flag STMMAC_FLAG_USE_PHY_WOL is enabled.
It can be reproduced with steps below:
1. Advertise only one speed on the host
2. Enable the WoL on the host
3. Suspend the host
4. Wake up the host

When the WoL is disabled, both the PHY and MAC will suspend and wake up
with everything configured well. When WoL is enabled, the PHY needs to be
stay awake to receive the signal from remote client but MAC will enter
suspend mode.

When the MAC resumes from suspend, phylink_resume() will call
phylink_start() to start the phylink instance which will trigger the
phylink machine to invoke the mac_link_up callback function. The
stmmac_mac_link_up() will configure the MAC_CTRL_REG based on the current
link state. Then the stmmac_hw_setup() will be called to configure the MAC.

This sequence might cause mismatch of the link state between MAC and
phylink. This patch moves the phylink_resume() after stmamc_hw_setup() to
ensure the MAC is initialized before phylink is being configured.

As phylink_resume() is called all the time, refactor the code and
remove the redundant check.

Fixes: 90702dcd19c0 ("net: stmmac: fix MAC not working when system resume back with WoL active")
Cc: <stable@vger.kernel.org> # 5.15+
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd53a617..9b009fa5478f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7844,16 +7844,6 @@ int stmmac_resume(struct device *dev)
 			return ret;
 	}
 
-	rtnl_lock();
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-		phylink_resume(priv->phylink);
-	} else {
-		phylink_resume(priv->phylink);
-		if (device_may_wakeup(priv->device))
-			phylink_speed_up(priv->phylink);
-	}
-	rtnl_unlock();
-
 	rtnl_lock();
 	mutex_lock(&priv->lock);
 
@@ -7868,6 +7858,11 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
 
+	phylink_resume(priv->phylink);
+
+	if (device_may_wakeup(priv->device) && !(priv->plat->pmt))
+		phylink_speed_up(priv->phylink);
+
 	stmmac_enable_all_queues(priv);
 	stmmac_enable_all_dma_irq(priv);
 
-- 
2.34.1


