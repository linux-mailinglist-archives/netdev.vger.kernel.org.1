Return-Path: <netdev+bounces-217853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D32FB3A29B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D31E566727
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F931B101;
	Thu, 28 Aug 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UW1KwOjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943431AF18;
	Thu, 28 Aug 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392083; cv=none; b=PPe1VZC3a33kjwxMLVhL8UaEIU7lAVH1230rbw4FKGruRVNEwLRQ/kh4ZY0AbHN7VZu7xeKubcHm6FNz89zAV05a9D7/1OgeO5yWe/x+W52OAbI0oG25flvHC3mZfZgrvdg4IudpdYLP81mwCVXU5eCzVrNcq0ADcpux8bTLEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392083; c=relaxed/simple;
	bh=/wwOIa8YeuKhU78bbwDt4af1abVveZsf06IsGyLyLa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jo/LJY5xfaP/jR/XJ0QyG6csAB6fKE2T7YoOuL5dt8FZSJGhlt1eZJXp2F6dW7PFniKySM0iuQjW1c2VJb3J4TNg3SGAR8MaVLsnp3SxvSVyvFNKRoWtRZ9Ro7Qe7VYO4TY/3rvbXwnQeRTmfIWYBSkiTsKo3awMEi2tja1wtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UW1KwOjJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756392082; x=1787928082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/wwOIa8YeuKhU78bbwDt4af1abVveZsf06IsGyLyLa8=;
  b=UW1KwOjJq/lLEOUYsysJNROZedj8nj3K80E3/BE2XPzGuckDLcYK8u14
   vx0MQzfxI3o+eA1VkfBWP5CXGK+ZiAzFVZnjInkQJzkQ1ox7rpt6PjEEa
   K1OJLgfpwmj0PL3Yu9zHLy+bLBuRa9aOW3fYjbATXt1rykGOMGdpI3q9H
   qiNKj0IxDgDGBP7qh6hn5fiIsK96lRupIMuzEk+uKv/bAOOxcrMgiHoXn
   XmuZgqFZyl3lAFeYd6kvrNI+RuvbHdnwebj7PGIph5uW3QIm64Zz1C7PF
   Jg1w3mA4ULNCk1Lvv3jY9vH3g/TJfdMd6gkBgtCCiBmHNQ1DogpgZ0cnJ
   g==;
X-CSE-ConnectionGUID: p3m1vcryRqmgskVTTbHL+Q==
X-CSE-MsgGUID: W0v/jubqTQ6/i1o9nSBuDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58515391"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58515391"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:41:22 -0700
X-CSE-ConnectionGUID: zTzqkvglRQOPhoxH/MlEaw==
X-CSE-MsgGUID: Lk6InVBgRlOoCM/dqjziwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207276088"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2025 07:41:18 -0700
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
Subject: [PATCH net-next 2/4] net: stmmac: set TE/RE bits for ARP Offload when interface down
Date: Thu, 28 Aug 2025 16:45:56 +0200
Message-Id: <20250828144558.304304-3-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828144558.304304-1-konrad.leszczynski@intel.com>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
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

Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 244ef484bb88..8977e5aebc71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -950,7 +950,9 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
-	stmmac_mac_set(priv, priv->ioaddr, false);
+	if (!(priv->plat->flags & STMMAC_FLAG_ARP_OFFLOAD_EN))
+		stmmac_mac_set(priv, priv->ioaddr, false);
+
 	if (priv->dma_cap.eee)
 		stmmac_set_eee_pls(priv, priv->hw, false);
 
@@ -4183,6 +4185,10 @@ static int stmmac_release(struct net_device *dev)
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


