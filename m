Return-Path: <netdev+bounces-114668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA794364E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 21:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42271B25991
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280912E1D9;
	Wed, 31 Jul 2024 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XccSou1N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE64AEF2;
	Wed, 31 Jul 2024 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453387; cv=none; b=Pv/WeFZHGaE34ozACx3ITrOGyDabGB7j8RvsteyfjOXmCZvdM3xejfPev56iQBlqPVgY80rlgJp6v99WY5BFeqPWr35SNH26joiCRdx/93XnTZNqj5tGhqZ4mh4aOKh80wpl6ucD+O3FvrHBRvl4MkjGMC8ZIvTdlLf0gz+RRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453387; c=relaxed/simple;
	bh=aR4zViEuQpZ6YG2+gA6uZgTsoo2ObhIDmE4hTAOFXLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q376KEozhjkjgDTg5iEkN2fFVVzoxDFku0kAws8TaxN1Mh2umrXE0GJ+PhSljLZUxUE5sgV+IRF2kGTkfBj57bsxfe4NjVx1mlrKOuwJJlKVrNdSxWmk6TdelOs6UolcrLdOMomG1H7EjHbB9Tih7YXfuCSP2JXQH6ACqW47s2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XccSou1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B305AC116B1;
	Wed, 31 Jul 2024 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453387;
	bh=aR4zViEuQpZ6YG2+gA6uZgTsoo2ObhIDmE4hTAOFXLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XccSou1NMaIGA2rRPgQ/rltheyaLPgmT09uLRp0aRimlG/8XUwdosUGw2gzhxjiIk
	 8AZI1IkpOGYn2f1vkH/Xy+Bqw0t6fPCRzmhoS54kiRie1mt+8vPFvwRI+8ET7Hs4yw
	 iVAaTSSF/uC9+1N2ayh1r7nrVo4x95cIji4rjorK9B30jBw9xdokYpIUKDSkycOP/A
	 yg/dQO7VFZhmDwS9YzbaloMWcm2zlGcIpPPR70U+mNcaGP3Fr6ZDz2JGoJb6HQ3/y9
	 ptX9rfb993115fHAxHkDxHavYzlcoo+pm/tVr/dRrh7Y6IXGymtQ7Qbk6f204ViNOS
	 P2P/9M42U50eg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next] net: Use of_property_read_bool()
Date: Wed, 31 Jul 2024 13:16:00 -0600
Message-ID: <20240731191601.1714639-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_read_bool() to read boolean properties rather than
of_find_property(). This is part of a larger effort to remove callers
of of_find_property() and similar functions. of_find_property() leaks
the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman_port.c   | 6 +++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c      | 8 ++++----
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c  | 8 ++++----
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index 406e75e9e5ea..f17a4e511510 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1748,7 +1748,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 	struct resource res;
 	struct resource *dev_res;
 	u32 val;
-	int err = 0, lenp;
+	int err = 0;
 	enum fman_port_type port_type;
 	u16 port_speed;
 	u8 port_id;
@@ -1795,7 +1795,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 	if (of_device_is_compatible(port_node, "fsl,fman-v3-port-tx")) {
 		port_type = FMAN_PORT_TYPE_TX;
 		port_speed = 1000;
-		if (of_find_property(port_node, "fsl,fman-10g-port", &lenp))
+		if (of_property_read_bool(port_node, "fsl,fman-10g-port"))
 			port_speed = 10000;
 
 	} else if (of_device_is_compatible(port_node, "fsl,fman-v2-port-tx")) {
@@ -1808,7 +1808,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 	} else if (of_device_is_compatible(port_node, "fsl,fman-v3-port-rx")) {
 		port_type = FMAN_PORT_TYPE_RX;
 		port_speed = 1000;
-		if (of_find_property(port_node, "fsl,fman-10g-port", &lenp))
+		if (of_property_read_bool(port_node, "fsl,fman-10g-port"))
 			port_speed = 10000;
 
 	} else if (of_device_is_compatible(port_node, "fsl,fman-v2-port-rx")) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3e51b3a9b0a5..9dc9de39bb8f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1271,8 +1271,8 @@ static int prueth_probe(struct platform_device *pdev)
 			goto exit_iep;
 		}
 
-		if (of_find_property(eth0_node, "ti,half-duplex-capable", NULL))
-			prueth->emac[PRUETH_MAC0]->half_duplex = 1;
+		prueth->emac[PRUETH_MAC0]->half_duplex =
+			of_property_read_bool(eth0_node, "ti,half-duplex-capable");
 
 		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
 	}
@@ -1285,8 +1285,8 @@ static int prueth_probe(struct platform_device *pdev)
 			goto netdev_exit;
 		}
 
-		if (of_find_property(eth1_node, "ti,half-duplex-capable", NULL))
-			prueth->emac[PRUETH_MAC1]->half_duplex = 1;
+		prueth->emac[PRUETH_MAC1]->half_duplex =
+			of_property_read_bool(eth1_node, "ti,half-duplex-capable");
 
 		prueth->emac[PRUETH_MAC1]->iep = prueth->iep0;
 	}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index e180c1166170..54b7e27608ce 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -1045,8 +1045,8 @@ static int prueth_probe(struct platform_device *pdev)
 			goto exit_iep;
 		}
 
-		if (of_find_property(eth0_node, "ti,half-duplex-capable", NULL))
-			prueth->emac[PRUETH_MAC0]->half_duplex = 1;
+		prueth->emac[PRUETH_MAC0]->half_duplex =
+			of_property_read_bool(eth0_node, "ti,half-duplex-capable");
 
 		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
 	}
@@ -1059,8 +1059,8 @@ static int prueth_probe(struct platform_device *pdev)
 			goto netdev_exit;
 		}
 
-		if (of_find_property(eth1_node, "ti,half-duplex-capable", NULL))
-			prueth->emac[PRUETH_MAC1]->half_duplex = 1;
+		prueth->emac[PRUETH_MAC1]->half_duplex =
+			of_property_read_bool(eth1_node, "ti,half-duplex-capable");
 
 		prueth->emac[PRUETH_MAC1]->iep = prueth->iep1;
 	}
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index e342f387c3dd..da531a914914 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2396,7 +2396,7 @@ static int axienet_probe(struct platform_device *pdev)
 		goto cleanup_clk;
 	}
 
-	if (!of_find_property(pdev->dev.of_node, "dmas", NULL)) {
+	if (!of_property_present(pdev->dev.of_node, "dmas")) {
 		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
 		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
 
-- 
2.43.0


