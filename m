Return-Path: <netdev+bounces-21039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095147623A7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3806A1C20FD4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5E26B1A;
	Tue, 25 Jul 2023 20:40:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306A25937
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD7FC433C7;
	Tue, 25 Jul 2023 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690317611;
	bh=ud1chLoFe+VFXLyMYNzCTP55aWLaNfDqCtujCPEbZLM=;
	h=From:To:Cc:Subject:Date:From;
	b=b2jkYwIFBM86tzbrzQ0/O6LPwNds5JN6XmzkIBywaeurcOuY62ju3ymuOPULiITNh
	 sfStsmtNaFhoTVG5YC3+1pWmSaXCdiSVtfE+K+WsgdP9M1CoV4mIjBFY6hFOC5mez1
	 aP/RQqhjavZl/jq799o7lhhRMx1nvWjUwgrEHdKe96FfEq0aLUYxgXtzsauzexvfOO
	 ZT0Xv/nAqxYdGELf2hTZh0E42jXbWeEaK3vWh47rJycBGCcO7DNKDN/nLd89S8sR9P
	 1dX2tmdnj+yKPKsl+4gZVkFqo6CK/oPPSUotFNM5YQxaZYxJIW9EjBgOv9NYYCYBGb
	 hkug796qVFAeQ==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sean Anderson <sean.anderson@seco.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] dpaa: avoid linking objects into multiple modules
Date: Tue, 25 Jul 2023 22:39:40 +0200
Message-Id: <20230725204004.3366679-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Each object file contains information about which module it gets linked
into, so linking the same file into multiple modules now causes a warning:

scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch

Chang the way that dpaa2 is built by moving the two common files into a
separate module with exported symbols instead.

To avoid a link failure when the switch driver is built-in, but the dpio driver
is a loadable module, add the same dependency in there that exists for
the ethernet driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add missing module description
---
 drivers/net/ethernet/freescale/Makefile          |  4 +---
 drivers/net/ethernet/freescale/dpaa2/Kconfig     |  1 +
 drivers/net/ethernet/freescale/dpaa2/Makefile    |  9 +++++----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c | 12 ++++++++++++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
index de7b318422330..c63e0c090f8f7 100644
--- a/drivers/net/ethernet/freescale/Makefile
+++ b/drivers/net/ethernet/freescale/Makefile
@@ -22,6 +22,4 @@ ucc_geth_driver-objs := ucc_geth.o ucc_geth_ethtool.o
 obj-$(CONFIG_FSL_FMAN) += fman/
 obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
 
-obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
-
-obj-y += enetc/
+obj-y += enetc/ dpaa2/
diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig b/drivers/net/ethernet/freescale/dpaa2/Kconfig
index d029b69c3f183..4e26b5a4bc5c4 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
@@ -32,6 +32,7 @@ config FSL_DPAA2_PTP_CLOCK
 
 config FSL_DPAA2_SWITCH
 	tristate "Freescale DPAA2 Ethernet Switch"
+	depends on FSL_MC_BUS && FSL_MC_DPIO
 	depends on BRIDGE || BRIDGE=n
 	depends on NET_SWITCHDEV
 	help
diff --git a/drivers/net/ethernet/freescale/dpaa2/Makefile b/drivers/net/ethernet/freescale/dpaa2/Makefile
index 1b05ba8d1cbff..c042d2c27926c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Makefile
+++ b/drivers/net/ethernet/freescale/dpaa2/Makefile
@@ -3,15 +3,16 @@
 # Makefile for the Freescale DPAA2 Ethernet controller
 #
 
-obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o
+obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o fsl-dpaa2-common.o
 obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= fsl-dpaa2-ptp.o
-obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o
+obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o fsl-dpaa2-common.o
 
-fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o dpaa2-mac.o dpmac.o dpaa2-eth-devlink.o dpaa2-xsk.o
+fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o dpaa2-eth-devlink.o dpaa2-xsk.o
 fsl-dpaa2-eth-${CONFIG_FSL_DPAA2_ETH_DCB} += dpaa2-eth-dcb.o
 fsl-dpaa2-eth-${CONFIG_DEBUG_FS} += dpaa2-eth-debugfs.o
 fsl-dpaa2-ptp-objs	:= dpaa2-ptp.o dprtc.o
-fsl-dpaa2-switch-objs	:= dpaa2-switch.o dpaa2-switch-ethtool.o dpsw.o dpaa2-switch-flower.o dpaa2-mac.o dpmac.o
+fsl-dpaa2-switch-objs	:= dpaa2-switch.o dpaa2-switch-ethtool.o dpsw.o dpaa2-switch-flower.o
+fsl-dpaa2-common-objs	+= dpaa2-mac.o dpmac.o
 
 # Needed by the tracing framework
 CFLAGS_dpaa2-eth.o := -I$(src)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index a69bb22c37eab..c51dbd84d199e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -348,6 +348,7 @@ void dpaa2_mac_start(struct dpaa2_mac *mac)
 
 	phylink_start(mac->phylink);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_start);
 
 void dpaa2_mac_stop(struct dpaa2_mac *mac)
 {
@@ -358,6 +359,7 @@ void dpaa2_mac_stop(struct dpaa2_mac *mac)
 	if (mac->serdes_phy)
 		phy_power_off(mac->serdes_phy);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_stop);
 
 int dpaa2_mac_connect(struct dpaa2_mac *mac)
 {
@@ -450,6 +452,7 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_connect);
 
 void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
 {
@@ -462,6 +465,7 @@ void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
 	of_phy_put(mac->serdes_phy);
 	mac->serdes_phy = NULL;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_disconnect);
 
 int dpaa2_mac_open(struct dpaa2_mac *mac)
 {
@@ -510,6 +514,7 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	return err;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_open);
 
 void dpaa2_mac_close(struct dpaa2_mac *mac)
 {
@@ -519,6 +524,7 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_close);
 
 static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
 	[DPMAC_CNT_ING_ALL_FRAME]		= "[mac] rx all frames",
@@ -557,6 +563,7 @@ int dpaa2_mac_get_sset_count(void)
 {
 	return DPAA2_MAC_NUM_STATS;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_sset_count);
 
 void dpaa2_mac_get_strings(u8 *data)
 {
@@ -568,6 +575,7 @@ void dpaa2_mac_get_strings(u8 *data)
 		p += ETH_GSTRING_LEN;
 	}
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_strings);
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 {
@@ -587,3 +595,7 @@ void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 		*(data + i) = value;
 	}
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_ethtool_stats);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DPAA2 Ethernet core library");
-- 
2.39.2


