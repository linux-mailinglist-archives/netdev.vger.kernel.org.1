Return-Path: <netdev+bounces-157024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD6A08BFD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC5116AB9E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737C120767F;
	Fri, 10 Jan 2025 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="qFyaLGZM"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6B209F58
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501283; cv=none; b=X44v4+dsgTWdmWRznKAP37P7Fp58lFvMqayq18+4qQcei6IGbdX0si8/lVRng1M4qvzUV/AA8/WQlvjA5mAqZsGolKK5roCvBJ+lFBDRbANJVfgQ0YhUfxuB/aeeNx/zZi6jeurl0gxraUZpgZlLyz9ggKCmkM0bb3kXbt7QPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501283; c=relaxed/simple;
	bh=SBZJt+lQyII07aeRALe9ntvWddrSHQ9WBb6kk3nsdeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkMl0cwUEO8MyEva7Ja3jMapyV2kl8fR/hMyAND7OOWVwlyXWaCPtFnjFV4UVvCpN1luZQXAFgtChBWGZm+tbn+mhuHeP3Sjg/g2CoUuwQCLdsA5P5C0VLvWh1bd+wQ9guU2skjtgtn0t45ysPNZoCCHSOU5oo47xlF7wKG0vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=qFyaLGZM; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025011009275750561e10314c45e5e6
        for <netdev@vger.kernel.org>;
        Fri, 10 Jan 2025 10:27:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=g1mHaH2E5LhDnZ2IkphFI3VHm+rRwgKjSgxf6hFHmlc=;
 b=qFyaLGZMKKRSogSfeKofVXnitfgqr9lL/c1n4a/30K0JY2WEvIC1nAXA7lRsmYXXgV0KU6
 2VQynBCKBTxcz80kIMU5uSKxXEIN4NNaiLDorZ2f2JqBXLY306L6WmPdQXv+nITizMDuoOUY
 NHQtESwum3YqDXEHUgnxYX5tFBAW3bAR+u/KYwxbhKJUVNNi+xn7b9/GZTces8i4domyhGFq
 vXYShnvYoql0sLxDkvFbvgWw9eqpmW/n0T9E4K0Ln9di6zpTFhE0s92LsGMYze3HuZaC1KGd
 W7ArwpbZYeNKWG0iOKt1chfAzlMa+sv1Jq6NjiJccuddjR3Iv4zg0sjA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@kernel.org>,
	Chintan Vankar <c-vankar@ti.com>,
	Julien Panis <jpanis@baylibre.com>
Subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW only if !DSA
Date: Fri, 10 Jan 2025 10:26:21 +0100
Message-ID: <20250110092624.287209-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Only configure VLAN-aware CPSW mode if no port is used as DSA CPU port.
VLAN-aware mode interferes with some DSA tagging schemes and makes stacking
DSA switches downstream of CPSW impossible. Previous attempts to address
the issue linked below.

Link: https://lore.kernel.org/netdev/20240227082815.2073826-1-s-vadapalli@ti.com/
Link: https://lore.kernel.org/linux-arm-kernel/4699400.vD3TdgH1nR@localhost/
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index dcb6662b473d..e445acb29e16 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -32,6 +32,7 @@
 #include <linux/dma/ti-cppi5.h>
 #include <linux/dma/k3-udma-glue.h>
 #include <net/page_pool/helpers.h>
+#include <net/dsa.h>
 #include <net/switchdev.h>
 
 #include "cpsw_ale.h"
@@ -724,13 +725,23 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 	u32 val, port_mask;
 	struct page *page;
 
+	/* Control register */
+	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
+	      AM65_CPSW_CTL_P0_RX_PAD;
+	for (port_idx = 0; port_idx < common->port_num; port_idx++) {
+		struct am65_cpsw_port *port = &common->ports[port_idx];
+
+		if (netdev_uses_dsa(port->ndev))
+			break;
+	}
+	/* VLAN aware CPSW mode is incompatible with some DSA tagging schemes */
+	if (port_idx == common->port_num)
+		val |= AM65_CPSW_CTL_VLAN_AWARE;
+	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
+
 	if (common->usage_count)
 		return 0;
 
-	/* Control register */
-	writel(AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
-	       AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
-	       common->cpsw_base + AM65_CPSW_REG_CTL);
 	/* Max length register */
 	writel(AM65_CPSW_MAX_PACKET_SIZE,
 	       host_p->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN);
-- 
2.47.1


