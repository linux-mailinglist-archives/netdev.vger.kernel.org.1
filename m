Return-Path: <netdev+bounces-217854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99564B3A29F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC0567AAC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B831CA67;
	Thu, 28 Aug 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWIb746O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3331B130;
	Thu, 28 Aug 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392086; cv=none; b=BxOxEOg30wCbbzTmafnB80KY0tbMzkMi/BLMjtO3uYPenPQyvw6MwM79WJ9FvpRfxMeVujSeto5jv7awyO4wknmUCcp5mewNgvZKe7IOUTP9ZznhPl1qn5QhkdpXXnfu363cAfs2nlZ5mzk1VA7z4B4TkqpZOwqepLq+wyGp1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392086; c=relaxed/simple;
	bh=EH3MQczFR1osST+LDNrfbkacgumXNnVwKSgenYdIlsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoXUaijR95ZkamC0GCxdCEjV7uIi0EGvFpNstRj5EoHYMQwwSVWX+s7yamHvyPQ+RHlm1EgFIlsPuNPs9jaOHdJnmEpuLvR5cckzXXuFQJGhDL1L5Fx2yf9Ky4XX0xcWEzR/6VKui4UoF4CYnxMdi98tBTyS3GCxM5lGOPpKIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWIb746O; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756392085; x=1787928085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EH3MQczFR1osST+LDNrfbkacgumXNnVwKSgenYdIlsE=;
  b=FWIb746O2h6Y9YJYGOJQ8R7mqYSzE2UGiER3/hnccb7keILP7PKhfQoE
   5Z+I66yufMUqqA1IeGxYPc18xzWiJptnzLUoh7j0zVLuOfU18WxS7aNfz
   uIs39BXQuD8x2EPUy+bTPWRXsQYEpZkHJC5Yi+6HT0PIX6Hsb8PIvr3jj
   n77aiYvEEDM95yHEvLnFJ37OaYhcX0qeGNJ1jMtb1Oo/ED8cOtw6Jgn+y
   h1gbELdZFt/+NZx5e1b97KatAfMxuRqUN91srA1G2Ock+QqjlW3x32Mrf
   sZ3BxSAEv/5sc5+RSX8s4eOeZzn/Q8qJhAaYJ0K9co4U0t2sMKsaIjtkB
   w==;
X-CSE-ConnectionGUID: bjuiVysfSSSKE/ZbowC9qA==
X-CSE-MsgGUID: lr0/fbpQRGSzUrK9jDvAAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58515399"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58515399"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:41:25 -0700
X-CSE-ConnectionGUID: Tvut63OpT1W0iNGIsuUMpg==
X-CSE-MsgGUID: fp4mY0VUTgWms6s3hA7DmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207276100"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2025 07:41:21 -0700
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
	Piotr Warpechowski <piotr.warpechowski@intel.com>,
	Karol Jurczenia <karol.jurczenia@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next 3/4] net: stmmac: enhance VLAN protocol detection for GRO
Date: Thu, 28 Aug 2025 16:45:57 +0200
Message-Id: <20250828144558.304304-4-konrad.leszczynski@intel.com>
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

From: Piotr Warpechowski <piotr.warpechowski@intel.com>

Enhance protocol extraction in stmmac_has_ip_ethertype() by introducing
MAC offset parameter and changing:

__vlan_get_protocol() ->  __vlan_get_protocol_offset()

Add correct header length for VLAN tags, which enable Generic Receive
Offload (GRO) in VLAN.

Co-developed-by: Karol Jurczenia <karol.jurczenia@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8977e5aebc71..630ffb8dd0c3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4590,13 +4590,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
  */
 static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
 {
-	int depth = 0;
+	int depth = 0, hlen;
 	__be16 proto;
 
-	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
-				    &depth);
+	proto = __vlan_get_protocol_offset(skb, skb->protocol,
+					   skb_mac_offset(skb), &depth);
+	hlen = eth_type_vlan(skb->protocol) ? VLAN_ETH_HLEN : ETH_HLEN;
 
-	return (depth <= ETH_HLEN) &&
+	return (depth <= hlen) &&
 		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
 }
 
-- 
2.34.1


