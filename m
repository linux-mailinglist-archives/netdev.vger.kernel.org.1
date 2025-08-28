Return-Path: <netdev+bounces-217852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2013FB3A274
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16171C81755
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AAD31AF07;
	Thu, 28 Aug 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7y2naef"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43431A07F;
	Thu, 28 Aug 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392080; cv=none; b=OBkC7yLvspagGHVLn/ZEOOXtlHzy8PYFtzAWZblSAxHVkvTDpbEKG+KxTmYde3uh4stQly+zbjEB9Us+gUM8+AF74mmrdahvFFfG/U7Qadq8QvEz1ipKM0ND/CiJ0go5jwWzFSLgdjwmeK+UPGvWRGSg+5X80k/RVA570udWhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392080; c=relaxed/simple;
	bh=Emkincztq+ESuTAwOM8FQsWK3EeOxFJGFgYatXf5yd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZ51mLf6ImyLQzOqZaytcTMV8uR/rJ4KtbyFM9Vny/la+HBK89vF2Xs4t7f+yYvfYyKsApgQj8Jx4zTtIJc3L9hx0Q0jYjrnCDgvGXbEK/0rmyRgjRUFRqkp5UszNoXs9RYND7Et0X8W/gA99iXE7yDFu3c4rrB0kev7k7VpYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7y2naef; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756392079; x=1787928079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Emkincztq+ESuTAwOM8FQsWK3EeOxFJGFgYatXf5yd0=;
  b=V7y2naef5BIIo+cX7mCfi+4gILtt3Athiny4jppKjjDhHergVyJnDLzK
   htKYX0iklN60D8nm7phZfuswmzbo4CcjPtcYsKqcm09KdIk05LI4QC9RB
   WlRKtnPWOLixtCDrAPERLqdjaWj8T5H3f9BguIcdRwU2ivhFyYsiumMxx
   9X92XfrKD3F7Whox6vc/cGN5VT3WtouX6wI1sytD9SFf3NrQp/9/100Cd
   Q6VodUzRGQCwU7+dCJCWcvh0tmZqibBj+Ud6H9GJCTTx8h3cZh++8CyEx
   Z8Al6QnC34kM9Rx7e080DVFPVC/oYteoifUFzZ/IXkosLqwDZwWTgQvy7
   Q==;
X-CSE-ConnectionGUID: xs/sag7XTJyGGx0qR2Oj9w==
X-CSE-MsgGUID: 4vGWZFVhTjO6K5Z4W6MPuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58515383"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58515383"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:41:19 -0700
X-CSE-ConnectionGUID: loQC8UQ7RQmPhLYSJaEcgg==
X-CSE-MsgGUID: jnWiftY9Rxy6OuLutuC4Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207276077"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2025 07:41:15 -0700
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
Subject: [PATCH net-next 1/4] net: stmmac: enable ARP Offload on mac_link_up()
Date: Thu, 28 Aug 2025 16:45:55 +0200
Message-Id: <20250828144558.304304-2-konrad.leszczynski@intel.com>
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

Add Address Resolution Protocol (ARP) Offload support in
stmmac_mac_link_up() to enable ARP Offload beside the selftests.

Introduce STMMAC_FLAG_ARP_OFFLOAD_EN flag, which is used to enable the
feature with the stmmac_set_arp_offload().

Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
 include/linux/stmmac.h                         |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa3d26c28502..244ef484bb88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -40,6 +40,7 @@
 #include <linux/phylink.h>
 #include <linux/udp.h>
 #include <linux/bpf_trace.h>
+#include <linux/inetdevice.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
@@ -964,6 +965,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 			       bool tx_pause, bool rx_pause)
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+	struct in_device *in_dev;
+	struct in_ifaddr *ifa;
 	unsigned int flow_ctrl;
 	u32 old_ctrl, ctrl;
 	int ret;
@@ -1076,6 +1079,21 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		stmmac_hwtstamp_correct_latency(priv, priv);
+
+	if (priv->plat->flags & STMMAC_FLAG_ARP_OFFLOAD_EN) {
+		in_dev = in_dev_get(priv->dev);
+		if (!in_dev)
+			return;
+
+		rcu_read_lock();
+		ifa = rcu_dereference(in_dev->ifa_list);
+		if (ifa)
+			stmmac_set_arp_offload(priv, priv->hw, true,
+					       ntohl(ifa->ifa_address));
+		rcu_read_unlock();
+
+		__in_dev_put(in_dev);
+	}
 }
 
 static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index e284f04964bf..afb45d8eb840 100644
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


