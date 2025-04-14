Return-Path: <netdev+bounces-182066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB67A87A94
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCE37A6264
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5091B0F2C;
	Mon, 14 Apr 2025 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoirN+Oe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758081CD2C;
	Mon, 14 Apr 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619993; cv=none; b=OWf8zTtlxEm2xV0N5HY6skyaiUlF6xKt6QAeP8YhIxrq2l8H41ZltmVWsoQb8zaEwkrFtx6TKGykWcEvUyLkc1N1DDL90o/mRQtomD7OYiB4sk895On4K8X2C3cyn0BkW86eyRujJyfDqv5Of75zcuDwYl6DvgpmDRzRDCrMNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619993; c=relaxed/simple;
	bh=tYlCHkZYxFMo5HnN3oYW/bPNS8c2jeQzFHS04BtH8WU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l8oFDud57tOkuMPE3aH3CAvzisSBUJqPvtE7XFSqMyn8y57d4w2/2AUd+aG/ufw6YkVugAD6uxXoqGd8Q/rnEd7b+JcmwPwejtOAQ/BtsBQaqC3eYfl47rGc/wWs6X87aNJ6I4zglnpWSs4QF3198FqZvJUlXX/te5j6UBPP8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoirN+Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5A5C4CEE2;
	Mon, 14 Apr 2025 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744619991;
	bh=tYlCHkZYxFMo5HnN3oYW/bPNS8c2jeQzFHS04BtH8WU=;
	h=From:To:Cc:Subject:Date:From;
	b=hoirN+OekqkfoV+KE+im5ZoZrW/giBmE0s6JC9eozXlTsAqYyw8WTTcIgHaiw1VHe
	 QuzgPqKlTVJSvzs295SLcJNF3pep7ZAs+oeUJ8e1W9H9JRgdaRRKHxYN5c1VLZChXn
	 mNbLUmPNcSR3UwGrdI680mT8oO5KPcL84kPJV87TZvx6ba0AvB0PxAoWiO30Si774v
	 V4YnnjvvaUSMr66C9nYYRF8Zy5Q1U0CIr+bcoj2tDqcq4Ip6IV5h7xy15H3PkVtGIj
	 nU/R3u/EQZd0SxOn33SwiqXj4sDBvWCsoFOQeY+AwjmFvh4S0R+CFhkkFFRHzCm41E
	 0bREf8ckw56yg==
From: Michael Walle <mwalle@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net] net: ethernet: ti: am65-cpsw: fix port_np reference counting
Date: Mon, 14 Apr 2025 10:39:42 +0200
Message-Id: <20250414083942.4015060-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A reference to the device tree node is stored in a private struct, thus
the reference count has to be incremented. Also, decrement the count on
device removal and in the error path.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index e78de79a5d78..636f4cb66aa1 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2666,7 +2666,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 				of_property_read_bool(port_np, "ti,mac-only");
 
 		/* get phy/link info */
-		port->slave.port_np = port_np;
+		port->slave.port_np = of_node_get(port_np);
 		ret = of_get_phy_mode(port_np, &port->slave.phy_if);
 		if (ret) {
 			dev_err(dev, "%pOF read phy-mode err %d\n",
@@ -2720,6 +2720,17 @@ static void am65_cpsw_nuss_phylink_cleanup(struct am65_cpsw_common *common)
 	}
 }
 
+static void am65_cpsw_remove_dt(struct am65_cpsw_common *common)
+{
+	struct am65_cpsw_port *port;
+	int i;
+
+	for (i = 0; i < common->port_num; i++) {
+		port = &common->ports[i];
+		of_node_put(port->slave.port_np);
+	}
+}
+
 static int
 am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 {
@@ -3622,6 +3633,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
+	am65_cpsw_remove_dt(common);
 err_of_clear:
 	if (common->mdio_dev)
 		of_platform_device_destroy(common->mdio_dev, NULL);
@@ -3661,6 +3673,7 @@ static void am65_cpsw_nuss_remove(struct platform_device *pdev)
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
 	am65_cpsw_disable_serdes_phy(common);
+	am65_cpsw_remove_dt(common);
 
 	if (common->mdio_dev)
 		of_platform_device_destroy(common->mdio_dev, NULL);
-- 
2.39.5


