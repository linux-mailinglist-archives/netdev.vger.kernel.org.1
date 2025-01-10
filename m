Return-Path: <netdev+bounces-157144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B877A09004
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F75E167DBF
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07924205E37;
	Fri, 10 Jan 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="hc2OrcqO"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1E2063DC
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510958; cv=none; b=dxaggNy97uE52cfeQtEFt6XwQ1V5e2XQlCHSlay/bYyxV3oJj+68SXKvlRstOoShM+DsGuxUKC5hac56hTZQb6dboBO4S0wOz5patlZX3/fx87IbP/Nu5MPNy5xRFhf6AlonWEAdBAonosOmDOnQUcdr5t9LIRp1jSS7weT1Kts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510958; c=relaxed/simple;
	bh=Ykh7RxzEeRrpH0T75KKSsW8N9egAGDRlJfdvLYE5ctA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgYPqROc8ISRtmPZ9WoNOD3Gxa4d49OKV+eUDu0AsGu4n3vHPWJPtE91MpDsFQyP6zdPTuFS8m/h4Ve8WC5RlAVOYENJuhb8P4IO2tJJMKbivhtudEa0yMfsJHT9xRENZIOeeUKDgYGDYCtAGlB/hUPdUUo4MYQUcM7vou7MgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=hc2OrcqO; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202501101128585c64dabbd2e0fe9dda
        for <netdev@vger.kernel.org>;
        Fri, 10 Jan 2025 12:28:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=IRbabMtbT7WAvxmJ6HVy6JIV44wcam6j1fimOXGYrD0=;
 b=hc2OrcqOAXXy+Fl7LWewSEAieF0TkUb9SK7QvO4ANdWg2ilRmH9jrl77N4WHUr5OtxxFRS
 VyywOLtR49dMjUHkdNF5bEwM7sZSrDntQPg9NNuCMzcpCxHFWTxftvjYSOtktsPoh+LQt4c0
 uJYDT0a0DacsUiKKuYRF/0dUCtGt37hda/1GchvJWQk1V2UCj1n9qJ/vv/hkBBksEISgsNpx
 yBkHMKEW5kVi4MJDpbx4/BtChUCQKjDgTJh6q/nonCTqlfukf8jBGo6TAVvcsPMk3gKRVklU
 /40+KnwAA6X3r/LNXQiMuKpoWwkWLpERoWKlYBanejNNiGZMDQYI+YtA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@kernel.org>,
	Chintan Vankar <c-vankar@ti.com>,
	Julien Panis <jpanis@baylibre.com>
Subject: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW only if !DSA
Date: Fri, 10 Jan 2025 12:27:17 +0100
Message-ID: <20250110112725.415094-1-alexander.sverdlin@siemens.com>
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
Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2: Thanks to Siddharth it does look much clearer now (conditionally clear
    AM65_CPSW_CTL_VLAN_AWARE instead of setting)

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5465bf872734..58c840fb7e7e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -32,6 +32,7 @@
 #include <linux/dma/ti-cppi5.h>
 #include <linux/dma/k3-udma-glue.h>
 #include <net/page_pool/helpers.h>
+#include <net/dsa.h>
 #include <net/switchdev.h>
 
 #include "cpsw_ale.h"
@@ -724,13 +725,22 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 	u32 val, port_mask;
 	struct page *page;
 
+	/* Control register */
+	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
+	      AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD;
+	/* VLAN aware CPSW mode is incompatible with some DSA tagging schemes.
+	 * Therefore disable VLAN_AWARE mode if any of the ports is a DSA Port.
+	 */
+	for (port_idx = 0; port_idx < common->port_num; port_idx++)
+		if (netdev_uses_dsa(common->ports[port_idx].ndev)) {
+			val &= ~AM65_CPSW_CTL_VLAN_AWARE;
+			break;
+		}
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


