Return-Path: <netdev+bounces-216895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54982B35C11
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE5D7B644E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CCE34A339;
	Tue, 26 Aug 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYFxS+08"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433C34A323;
	Tue, 26 Aug 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207705; cv=none; b=hcln1GYSW+ECKnTaY/P1iyKF3wrXiaH+RPI1NuL8mimCn+dm5Fnapw8Uq7Kku/wO9ZRqSeK2P83VdFklIGT/ydm09vYUu6CMx3HCI1w0PC5ZyvcuXnDOL5kFhpY6+jYSIBblaSjoRSYCRMgr2klpEdYgmVl2BoDERViurOLUpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207705; c=relaxed/simple;
	bh=QVZZS4EaKoeW1P1dljej9T+AcX0xYWAlp0bsj+bzMc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqUXH0mR4JzR2/z+Hrdx2i8ln66/t6uaAXAx2ZsKzmre81KAj61T6j36xe3kOv4WhLGg+pXBjV/Xu0+CaYpT1VKHB9Xpz/s2dN1LR+z58phNJcqwuNZ8SN1W5JoUhCDftSqv+qVJv5AArC/K3ODQ9Q3/L7EbTeVqMmm2TSNMioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYFxS+08; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756207704; x=1787743704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVZZS4EaKoeW1P1dljej9T+AcX0xYWAlp0bsj+bzMc8=;
  b=IYFxS+08KketiBYgo1SfmqYip/MMA3jO+RVwu8+OYSJMLlyYZSqMX4y6
   GHA9hoP/b40eU2z3UqnN/Ry1iK7d/HDVxkbxibwgWFxAd1Fzzp6e/D3Y0
   E8IGMFcObCZDaMKRvlo8Xe3SzBgu+HshdSc0kQytUiu8tDWzKhaxGxNpr
   ZMxGa4w6PSqa9citMV8sJicmui0IkAInTaBmFMhM6zhfXK8+h8VgHh05n
   fMdzH40A8dflSz0RUayT09HqmO49PCtSDpAnlaFPMSkE1Y0B3hVn+wLsK
   8Ea9ue9LdH82LIcIUZafPvnHLR312OAfufx4nwYIZ6NmRubS2hft2RaHa
   w==;
X-CSE-ConnectionGUID: Rr78bWwbSvyzZ8iyBpD1/Q==
X-CSE-MsgGUID: CLj+21msRzq093cUv39c7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62269292"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62269292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:28:24 -0700
X-CSE-ConnectionGUID: M2VEiX2LT6+6NrHvRnYJPA==
X-CSE-MsgGUID: rGN5pbGbRtKMC2KiXrj69g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173725821"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 04:28:21 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Karol Jurczenia <karol.jurczenia@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next 5/7] net: stmmac: set TE/RE bits for ARP Offload when interface down
Date: Tue, 26 Aug 2025 13:32:45 +0200
Message-Id: <20250826113247.3481273-6-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Jurczenia <karol.jurczenia@intel.com>

When the network interface is brought down and ARP Offload is enabled,
set the TE (Transmitter Enable) and RE (Receiver Enable) bits.

Ensure that the Network Interface Card (NIC) can continue handling ARP
responses in hardware even when the interface is down.

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e000dc7f0349..3823432b16f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -949,7 +949,9 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
-	stmmac_mac_set(priv, priv->ioaddr, false);
+	if (!(priv->plat->flags & STMMAC_FLAG_ARP_OFFLOAD_EN))
+		stmmac_mac_set(priv, priv->ioaddr, false);
+
 	if (priv->dma_cap.eee)
 		stmmac_set_eee_pls(priv, priv->hw, false);
 
@@ -4178,6 +4180,10 @@ static int stmmac_release(struct net_device *dev)
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
+	/* Disable MAC Rx/Tx */
+	stmmac_mac_set(priv, priv->ioaddr, priv->plat->flags &
+					   STMMAC_FLAG_ARP_OFFLOAD_EN);
+
 	/* Powerdown Serdes if there is */
 	if (priv->plat->serdes_powerdown)
 		priv->plat->serdes_powerdown(dev, priv->plat->bsp_priv);
-- 
2.34.1


