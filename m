Return-Path: <netdev+bounces-273206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKhAKDKGymkW9gUAu9opvQ
	(envelope-from <netdev+bounces-273206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:18:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A26D435CAFA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF05C3008627
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB43D75D4;
	Mon, 30 Mar 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR7ILpyj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AA3A6B74;
	Mon, 30 Mar 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879704; cv=none; b=fApz6M5gBYfBE/gy9RUie+S9gK4D7VWcCIaE+TPBBx4XwF+wzL6747TFr3xc9rTjwKtrH5f6FLQK/J6SIGeufgaUs7qYKyfwdY2QIxihIi+0FWG4TMrGrLVzlDirD7LRZvpCEJiDGRhgMvcna8aAWO9Dc8F/+Z6p0OQmXkMDsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879704; c=relaxed/simple;
	bh=fVrSgvhHwa6+IhWmusgqjt9uEfc1lG9SmDZ/8tw+KGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iNZTfJgQ1CGGbOkgFdf9lUn9Ore7WQQlfaGU+G9UTtmdhr38UyXQStKaOpj2u62n5zImqe3NaaQUORtDI0lzVceNBgsYQEcoaVEFckijAtUGg/2jZx88w4JLHu6jg405hl4v61SS/ht9KeHaylEN6ggkrvsXi5emf2rJOJXIeoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR7ILpyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0669AC4CEF7;
	Mon, 30 Mar 2026 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774879704;
	bh=fVrSgvhHwa6+IhWmusgqjt9uEfc1lG9SmDZ/8tw+KGk=;
	h=From:To:Cc:Subject:Date:From;
	b=OR7ILpyj3eLFE6kV+pDRVLgieJRYJY8p23HxM1QNfviXlKQuY+x476tTqD9DSDUam
	 p8SOzN+9+vIJVvPiss1gjY4rFGETG1hJndwgcUtmIYnIyY92cYZ2xd1L1RdSgESyY0
	 AWvxOoUFMHllVfSErotI916Z1E0wp4gU+tOHl9WUmFGwddAd6581aGp/ZAD7Pql/BT
	 FM6VoUTa5SB+u691CzK17rg80nLjnhLcRgQFfXsATqMCK3W2Xbt1UT0Hi4cDvLwWU8
	 Dcs+k70+Dw5LfD6ixHJo+5XO1gePXqcANG1XbQTbF7+SBfk1JTOYVbf1WPhsJzfsjf
	 isvd+Wk8IC3fQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] dpaa2: avoid linking objects into multiple modules
Date: Mon, 30 Mar 2026 16:07:29 +0200
Message-Id: <20260330140818.1081987-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273206-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A26D435CAFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

Each object file contains information about which module it gets linked
into, so linking the same file into multiple modules now causes a warning:

scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch

Change the way that dpaa2 is built by moving the two common files into a
separate module with exported symbols instead.

To avoid a link failure when the switch driver is built-in, but the dpio driver
is a loadable module, add the same dependency in there that exists for
the ethernet driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add missing module description
v3: rename "common" to "mac"
    drop Kconfig change
    rebase to linux-next
---
 drivers/net/ethernet/freescale/dpaa2/Makefile    |  9 +++++----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/Makefile b/drivers/net/ethernet/freescale/dpaa2/Makefile
index 1b05ba8d1cbf..5f74be76434f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Makefile
+++ b/drivers/net/ethernet/freescale/dpaa2/Makefile
@@ -3,15 +3,16 @@
 # Makefile for the Freescale DPAA2 Ethernet controller
 #
 
-obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o
+obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o fsl-dpaa2-mac.o
 obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= fsl-dpaa2-ptp.o
-obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o
+obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o fsl-dpaa2-mac.o
 
-fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o dpaa2-mac.o dpmac.o dpaa2-eth-devlink.o dpaa2-xsk.o
+fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o dpaa2-eth-devlink.o dpaa2-xsk.o
 fsl-dpaa2-eth-${CONFIG_FSL_DPAA2_ETH_DCB} += dpaa2-eth-dcb.o
 fsl-dpaa2-eth-${CONFIG_DEBUG_FS} += dpaa2-eth-debugfs.o
 fsl-dpaa2-ptp-objs	:= dpaa2-ptp.o dprtc.o
-fsl-dpaa2-switch-objs	:= dpaa2-switch.o dpaa2-switch-ethtool.o dpsw.o dpaa2-switch-flower.o dpaa2-mac.o dpmac.o
+fsl-dpaa2-switch-objs	:= dpaa2-switch.o dpaa2-switch-ethtool.o dpsw.o dpaa2-switch-flower.o
+fsl-dpaa2-mac-objs	+= dpaa2-mac.o dpmac.o
 
 # Needed by the tracing framework
 CFLAGS_dpaa2-eth.o := -I$(src)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index ad812ebf3139..1f80a527264a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -544,6 +544,7 @@ void dpaa2_mac_start(struct dpaa2_mac *mac)
 
 	phylink_start(mac->phylink);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_start);
 
 void dpaa2_mac_stop(struct dpaa2_mac *mac)
 {
@@ -554,6 +555,7 @@ void dpaa2_mac_stop(struct dpaa2_mac *mac)
 	if (mac->serdes_phy)
 		phy_power_off(mac->serdes_phy);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_stop);
 
 int dpaa2_mac_connect(struct dpaa2_mac *mac)
 {
@@ -646,6 +648,7 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_connect);
 
 void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
 {
@@ -658,6 +661,7 @@ void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
 	of_phy_put(mac->serdes_phy);
 	mac->serdes_phy = NULL;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_disconnect);
 
 int dpaa2_mac_open(struct dpaa2_mac *mac)
 {
@@ -729,6 +733,7 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	return err;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_open);
 
 void dpaa2_mac_close(struct dpaa2_mac *mac)
 {
@@ -753,6 +758,7 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_close);
 
 static void dpaa2_mac_transfer_stats(const struct dpmac_counter *counters,
 				     size_t num_counters, void *s,
@@ -824,6 +830,7 @@ void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac,
 
 	*ranges = dpaa2_mac_rmon_ranges;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_rmon_stats);
 
 void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac,
 			       struct ethtool_pause_stats *s)
@@ -835,6 +842,7 @@ void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac,
 				     DPAA2_MAC_NUM_PAUSE_STATS,
 				     dpaa2_mac_pause_stats, s);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_pause_stats);
 
 void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac,
 			      struct ethtool_eth_ctrl_stats *s)
@@ -846,6 +854,7 @@ void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac,
 				     DPAA2_MAC_NUM_ETH_CTRL_STATS,
 				     dpaa2_mac_eth_ctrl_stats, s);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_ctrl_stats);
 
 void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac,
 				 struct ethtool_eth_mac_stats *s)
@@ -857,11 +866,13 @@ void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac,
 				     DPAA2_MAC_NUM_ETH_MAC_STATS,
 				     dpaa2_mac_eth_mac_stats, s);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_eth_mac_stats);
 
 int dpaa2_mac_get_sset_count(void)
 {
 	return DPAA2_MAC_NUM_ETHTOOL_STATS;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_sset_count);
 
 void dpaa2_mac_get_strings(u8 **data)
 {
@@ -870,6 +881,7 @@ void dpaa2_mac_get_strings(u8 **data)
 	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
 		ethtool_puts(data, dpaa2_mac_ethtool_stats[i].name);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_strings);
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 {
@@ -921,3 +933,7 @@ void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 		*(data + i) = value;
 	}
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_ethtool_stats);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DPAA2 Ethernet MAC library");
-- 
2.39.5


