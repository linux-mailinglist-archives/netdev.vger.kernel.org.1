Return-Path: <netdev+bounces-216896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186FB35CCB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B150363342
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE934DCCA;
	Tue, 26 Aug 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlHeT941"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1753375A6;
	Tue, 26 Aug 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207708; cv=none; b=gDfKSaqfxsxo+UHBGFKdY9WfjtJjgAMuGrpAf5LYPRlnjAEwOLJd8OakmU10KMn4405oFer7PfjAkXCIKbk3Jb1qzzr61yQJELZQcHRWj7V4KyXat4c+wn4udqDPbYF80/T1FZHqZpd1krT0O1OQJ/9pp94tWXDTrn867q1OZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207708; c=relaxed/simple;
	bh=1Jm0cwLTCKnB9EkyLifhKOsXUPACbnGbOswAl/hPTCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3HsflynMR16hbTjbnsAaYWwOSW2Ewh3Kfiz1m0Im340sIF4VUqCsmFDC7eHsiPQ3sIgYpyNSCE65uQa7KVpLi4mNvnGv0GYoLSARsPqZGi0RrZmppqyDLvu9yn0hvqZbO7yMKy5QSZPEprDxv1xhtgZQf/70icsrFV7R79lZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlHeT941; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756207708; x=1787743708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Jm0cwLTCKnB9EkyLifhKOsXUPACbnGbOswAl/hPTCQ=;
  b=SlHeT9413v6ZgiWEj8Yj4UF00JZ4F5yPrCKor/s6zTiuAdQ0YSoYWNnG
   UMzmZ33xuUEsfe+02HwVBUMudBoBSyzDWm8cCN6mIuQx8siggvC74xjQZ
   UT8GJZhLTaLqemNGbuneMsPmC5J9OB/8KDrZYwPvIxma4VtN+G3G6Ireb
   NXcap7KXiXr1kJaP3+aQc5q/mimoAhWPWgCmnLSOovhhMgsJarVU9rvMD
   w4A6ygrx59y8S3ws8XgiPYv4UWyyLOvtUrugxRNla0S/hF06UF5lRt+rE
   PhmLTNdzfGm62Mxk/CVBlY5dXlS2jh0TP8xCnIkC3zWXLbyqIdi+bf/6Y
   g==;
X-CSE-ConnectionGUID: sW+CmwqxSXafZ8qaaae6IA==
X-CSE-MsgGUID: CIeVU0BIRXKACyQmRCI/2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62269300"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62269300"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:28:27 -0700
X-CSE-ConnectionGUID: PNNKCDgMTvOaq9WYRS8crg==
X-CSE-MsgGUID: /ypd5VqpRJmHAavn4JKgZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173725833"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 04:28:24 -0700
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
Subject: [PATCH net-next 6/7] net: stmmac: enhance VLAN protocol detection for GRO
Date: Tue, 26 Aug 2025 13:32:46 +0200
Message-Id: <20250826113247.3481273-7-konrad.leszczynski@intel.com>
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

From: Piotr Warpechowski <piotr.warpechowski@intel.com>

Enhance protocol extraction in stmmac_has_ip_ethertype() by introducing
MAC offset parameter and changing:

__vlan_get_protocol() ->  __vlan_get_protocol_offset()

Add correct header length for VLAN tags, which enable Generic Receive
Offload (GRO) in VLAN.

Co-developed-by: Karol Jurczenia <karol.jurczenia@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3823432b16f1..5ef78fb3f900 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4585,13 +4585,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
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


