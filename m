Return-Path: <netdev+bounces-145238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD529CDD50
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76376B2605B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68B1B6D17;
	Fri, 15 Nov 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkLoNxkN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FF1BA89C;
	Fri, 15 Nov 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669159; cv=none; b=hBXgFvFllgIshcrsUHYqZWcMOoEbRYd54uu8Wm1kauPzOBS2qCnL1cS1eZp0fAqZiZMTSCkO5ftfSgOt4Ed+uL9p6w2Yyne8cqWR/Aqp78ljfFh3Tf1gdgGUpo8PToTxY02bSuzxF62OAGgA73c1L1egAZglVZ5jBH9DF2F46VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669159; c=relaxed/simple;
	bh=YqpnsuBVVUj80WoJfL9985bvH3cQ9fyiXqy0b0EDE5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8ZWoqEpGEO+U8v78+r4wb4bonqAu/tPzN2KWZ/xFzu8hK5qY2ggIwKoz0CEBQMcWE1I3CkyC1YVFunh6xRyYi6xlUqeDyjBWiWdX7M9WGAsqTe1NODnGjKIDMyhye/Bd+jCotpnDZ406Cj9uMGetIQCXZ0qwadze0hg5Qbd8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkLoNxkN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731669159; x=1763205159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YqpnsuBVVUj80WoJfL9985bvH3cQ9fyiXqy0b0EDE5E=;
  b=KkLoNxkNZfTnmvBvrawyUqTnQdI20aRMN66idkniHst+XhJINIOqhnUt
   gkFa1GSqxadDLKAdkcnrOEW/lQuGOoBqm4xWmnrga6D7sD1T4HMmZXbRl
   BNAA3knSBLAcgZfIsl4FzSbUPMwKRArsUnyukQV5VS+/rD5rLfjoQy0+M
   Q2pToAG830AAJnx2zEgnp8Y1P6pW98sUMJTvZVci72jeG1mj8/gaaw0+Z
   zHKobXHlY9bUQZR22bBmVR/RSJiQT03WgPH4ms/WyUSz6/cVT0uqlYuhW
   6C70Oj8H+KSLGbc9sMOQCzpRaDwbORRTva/mM0Jmm6GDNwb062/MrxLm2
   w==;
X-CSE-ConnectionGUID: wHp1zBjnTE2M1o9OkT4jAA==
X-CSE-MsgGUID: UQ1mjR0ST+i3Y1RqcC1cMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="34543484"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="34543484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 03:12:38 -0800
X-CSE-ConnectionGUID: tgyKVCdzSoGlFTnzA7d8+g==
X-CSE-MsgGUID: IsgtgJfuRK+d4o9hIYvaqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88112384"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa006.fm.intel.com with ESMTP; 15 Nov 2024 03:12:35 -0800
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2 2/2] net: stmmac: set initial EEE policy configuration
Date: Fri, 15 Nov 2024 19:11:51 +0800
Message-Id: <20241115111151.183108-3-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the initial eee_cfg values to have 'ethtool --show-eee ' display
the initial EEE configuration.

Fixes: 3eeca4e199ce ("net: phy: do not force EEE support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7bf275f127c9..766213ee82c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1205,6 +1205,9 @@ static int stmmac_init_phy(struct net_device *dev)
 			return -ENODEV;
 		}
 
+		if (priv->dma_cap.eee)
+			phy_support_eee(phydev);
+
 		ret = phylink_connect_phy(priv->phylink, phydev);
 	} else {
 		fwnode_handle_put(phy_fwnode);
-- 
2.34.1


