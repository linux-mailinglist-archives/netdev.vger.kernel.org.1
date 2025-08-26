Return-Path: <netdev+bounces-216894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D28B35CB8
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A868363523
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284534A30E;
	Tue, 26 Aug 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ad1zxpXY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D3334375;
	Tue, 26 Aug 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207702; cv=none; b=InTRur+mj0w98uJpxRq1HGOyPnrWTod/AeLqccaOKcY+4oNSnRRkx61pOsWQdnRdNIHzaieH2TWKZGg/ayhCSgVU32eCxYZyCOIWdJShSZ+w7qCwP8PokKZirkvFiC147T0106TryAsQgOdCvpS5MBTpatPblx2Q8gSgcx8hpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207702; c=relaxed/simple;
	bh=nv4QcLuZQQCjp8kTJkT5bO5LjWqekXnB5tBaUYryBaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdUmZ56qB+iPX3rL2J57YyOeHTDZ7uIv+ZKktaDuVLcDpNScHMJllsobKrorMxVwNCt9fB+J6kBAaUpglnshoHIXquR4Xd6aesQFt4uLzvWkGf2J3ZtCl4X+IlMT+RRuJXiJQYH2V9/DBC/bBeIwAEzyDCtOO7exZ7Fyt1xN10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ad1zxpXY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756207702; x=1787743702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nv4QcLuZQQCjp8kTJkT5bO5LjWqekXnB5tBaUYryBaE=;
  b=Ad1zxpXYoew5R0Db/6ar+6eTSMrCHWGitFS91aMarggGsiQCXiHBWQM2
   4bP+e20QlMg/VunFHlf3Q9U2ky0tJ+zdlAVNw/CAMr83t766AAq4Easb8
   Bq7hWpkL/8O9dMk8pETZKfsqJ753SwXK+CI+1/64BqtkQsygqS2d6CIa1
   hG1HW3aSGgNpmSjjGszkzyAnWMnMx4YNWLtZmMZgw9gNlG7vme8qJh0zD
   N6WzRCh1fSSWgqkXYLeuf0CNVqLIyVPtfRZhyMmvL69yp0EzGD8yohV4F
   Ozile0MXq6EnXLlDi0qh0KChvtjlh+Fz0ZS3RHNuoNJlbSRJGgJMhFAwY
   g==;
X-CSE-ConnectionGUID: x3aq9Al6SLOq/5RjKSjd2Q==
X-CSE-MsgGUID: nrkduwpBR0SL9QFxqoFhGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62269284"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62269284"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:28:22 -0700
X-CSE-ConnectionGUID: 5vOBlKTFRLahY/tT/CgV4w==
X-CSE-MsgGUID: cP7xnXONRRKd+mBUTUGcpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173725815"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 04:28:18 -0700
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
Subject: [PATCH net-next 4/7] net: stmmac: enable ARP Offload on mac_link_up()
Date: Tue, 26 Aug 2025 13:32:44 +0200
Message-Id: <20250826113247.3481273-5-konrad.leszczynski@intel.com>
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

Add Address Resolution Protocol (ARP) Offload support in
stmmac_mac_link_up() to enable ARP Offload beside the selftests.

Introduce STMMAC_FLAG_ARP_OFFLOAD_EN flag, which is used to enable the
feature with the stmmac_set_arp_offload().

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 +++++++++++++++++
 include/linux/stmmac.h                          |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9cf7f85c10b6..e000dc7f0349 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -39,6 +39,7 @@
 #include <linux/phylink.h>
 #include <linux/udp.h>
 #include <linux/bpf_trace.h>
+#include <linux/inetdevice.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
@@ -963,6 +964,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 			       bool tx_pause, bool rx_pause)
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+	struct in_device *in_dev;
+	struct in_ifaddr *ifa;
 	unsigned int flow_ctrl;
 	u32 old_ctrl, ctrl;
 	int ret;
@@ -1075,6 +1078,20 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		stmmac_hwtstamp_correct_latency(priv, priv);
+
+	if (priv->plat->flags & STMMAC_FLAG_ARP_OFFLOAD_EN) {
+		in_dev = in_dev_get(priv->dev);
+		if (!in_dev)
+			return;
+
+		ifa = in_dev->ifa_list;
+		if (!ifa)
+			return;
+
+		stmmac_set_arp_offload(priv, priv->hw, true,
+				       ntohl(ifa->ifa_address));
+		in_dev_put(in_dev);
+	}
 }
 
 static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 26ddf95d23f9..aae522f37710 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -185,6 +185,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 #define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(12)
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(13)
+#define STMMAC_FLAG_ARP_OFFLOAD_EN		BIT(14)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.34.1


