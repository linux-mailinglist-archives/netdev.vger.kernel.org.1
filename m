Return-Path: <netdev+bounces-44656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A92A7D8EFD
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9221C21068
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10378F7D;
	Fri, 27 Oct 2023 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+iOBHWU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07378F51
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:54:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4298116;
	Thu, 26 Oct 2023 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698389667; x=1729925667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FLxMqcP+5XqmQmOKGaFAfXKYkByQwryiGge0XuweW0I=;
  b=S+iOBHWU7sLWy/h2VgIQH+9iZP+9j7oLhUVH41XnTFVrQIllWxQutJQk
   Fls8wDniKpSMzmfpp4AGgCR0hCaH6MQ8iIc+kvKuwSvgFeosaj4Y0z1qc
   6CQYAnK3kO6RgJ9gi5Lv2DwztrYn1FyMGRc+yy1pJRDcCexcYc3mPjSyV
   4kmboAXynFj2hH9DvG+KjCNi2IulzZPiNbm6Qq4jXz6Fin7xMVymudr35
   kVxjs++M2k0Dq+Gc9ihrL58Dq1QFJXp/h17lPREbUD5K8EdwXzU4x3V3Q
   nH8IpCmYqUkp0dLiJy6Tq2VMBbJ7BoYO/aHUIN2HqW6qSAqTdUFfZ40Ou
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="539357"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="539357"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="753016032"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="753016032"
Received: from ssid-ilbpg3-teeminta.png.intel.com ([10.88.227.74])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2023 23:54:21 -0700
From: Gan Yi Fang <yi.fang.gan@intel.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Ahmad Tarmizi Noor Azura <noor.azura.ahmad.tarmizi@intel.com>,
	Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net-next 1/1] net: stmmac: add check for advertising linkmode request for set-eee
Date: Fri, 27 Oct 2023 14:50:54 +0800
Message-Id: <20231027065054.3808352-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>

Add check for advertising linkmode set request with what is currently
being supported by PHY before configuring the EEE. Unsupported setting
will be rejected and a message will be prompted. No checking is
required while setting the EEE to off.

Signed-off-by: Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index f628411ae4ae..6c090d4b7117 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -867,8 +867,24 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 		netdev_warn(priv->dev,
 			    "Setting EEE tx-lpi is not supported\n");
 
-	if (!edata->eee_enabled)
+	if (!edata->eee_enabled) {
 		stmmac_disable_eee_mode(priv);
+	} else {
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
+
+		ethtool_convert_legacy_u32_to_link_mode(supported,
+							edata->supported);
+		ethtool_convert_legacy_u32_to_link_mode(advertised,
+							edata->advertised);
+
+		/*Check if the advertise speed is supported.*/
+		if (!bitmap_subset(advertised,
+				   supported,
+				   __ETHTOOL_LINK_MODE_MASK_NBITS)){
+			return -EOPNOTSUPP;
+		}
+	}
 
 	ret = phylink_ethtool_set_eee(priv->phylink, edata);
 	if (ret)
-- 
2.34.1


