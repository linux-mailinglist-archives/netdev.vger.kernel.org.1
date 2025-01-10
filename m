Return-Path: <netdev+bounces-157154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D839A0914C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16913A051E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F6720D4F2;
	Fri, 10 Jan 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="BuUI4ao+"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774E20B7FA
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513949; cv=none; b=P2hkej5tunnayYKJfyfFhaHvW1+gvzV2n13eMTHqOaraS3kPB2sPDtUqWTkgSAVm4/btQ7jjlPwuzlA+5BGM9kX89OowYoDsgpl1nsHuhO7WOGa19Txfxpz6Dj/n0QIMa9cQ9DEEW3gUVQ4EN8JtAK20NdFfaAH1nk+eFleStqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513949; c=relaxed/simple;
	bh=lvMWRIs9JE+cAXJ88WjaKH2s3PZL4Ouc3Iv3lU7ea2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIRraCeHnHlWOjCMBj4Ow7+yx7/OfFzqAfqwDev8NuHdDojyvtUhz6wrvYvYKEdsO4DzcTAbDRD6hSL7kSxReYBYbCmsDkQKPMDaQLWhMH6rIxebEMo2zIoB0nv1T13F3A5pIDk6sFWAUI+oyXKSf9LfJkCMeCMlwE+jjlK/1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=BuUI4ao+; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250110125902e0e74e8650fbe8c1a3
        for <netdev@vger.kernel.org>;
        Fri, 10 Jan 2025 13:59:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ENvb/DZyWeZB5XTn+VuDooIyfOo8+Zvd1/734xZlFG8=;
 b=BuUI4ao+xv6sCiVIYdY9s29XXioDyl63xLQUoCThP9XQNZCAG4nrjCQCu242Uur6278ofv
 bKVeId2EY9QEqKlG7z8aI7LAzS1dve7xyyJm14s4pDzWRf3L93i1vslFp2FCYtGJcUE8cVDP
 5dNB47rV5RkpHvH2WWoDqT82r2+l/LrjuUgjhkoxQ2JcAohgfNVJcjvAriXTS0g8o9xTT+Ug
 +Y07fQsQAb64uQgSS1RC+l8Csv/w9zZygxzYrZCqAZClp0h8qbbfuCz6xgX60Dxpg9EBkXN0
 hqowXCzb7O3oEnPvGFpMqe1NWHi9bqPZ0xyw+HqiYqhJm/Q0HV25ShzA==;
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
Subject: [PATCH net-next v3] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW only if !DSA
Date: Fri, 10 Jan 2025 13:57:35 +0100
Message-ID: <20250110125737.546184-1-alexander.sverdlin@siemens.com>
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
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
v3: Moved the AM65_CPSW_CTL_VLAN_AWARE deassertion into
    am65_cpsw_nuss_ndo_slave_open()
v2: Thanks to Siddharth it does look much clearer now (conditionally clear
    AM65_CPSW_CTL_VLAN_AWARE instead of setting)

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5465bf872734..9e52928ebfd4 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -32,6 +32,7 @@
 #include <linux/dma/ti-cppi5.h>
 #include <linux/dma/k3-udma-glue.h>
 #include <net/page_pool/helpers.h>
+#include <net/dsa.h>
 #include <net/switchdev.h>
 
 #include "cpsw_ale.h"
@@ -1014,6 +1015,15 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
 
 	common->usage_count++;
 
+	/* VLAN aware CPSW mode is incompatible with some DSA tagging schemes.
+	 * Therefore disable VLAN_AWARE mode if any of the ports is a DSA Port.
+	 */
+	if (netdev_uses_dsa(ndev)) {
+		reg = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
+		reg &= ~AM65_CPSW_CTL_VLAN_AWARE;
+		writel(reg, common->cpsw_base + AM65_CPSW_REG_CTL);
+	}
+
 	am65_cpsw_port_set_sl_mac(port, ndev->dev_addr);
 	am65_cpsw_port_enable_dscp_map(port);
 
-- 
2.47.1


