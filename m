Return-Path: <netdev+bounces-230123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21812BE4387
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D7F19C43F2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52B34DCD7;
	Thu, 16 Oct 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cPauW9Xx"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BA34AAE4
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628438; cv=none; b=opm4RN7vEpDbz72HcgViACwjitEnFxJKhk7VqXc8qj/dXmunUeW8R/gFzKPPQFQzXzYTP9DX4sUPPGx/DkMr8anO4ggCkS7RAeroK1pXQwYyXYIZDTlPZ/4RN4s6Er8ozsAf0IJeT/vk0hLhuPe0SO1wNSsAVziXbc+aAuHSFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628438; c=relaxed/simple;
	bh=yTvu7Cs3Qtw4haYYqE731m4HhC/8cSPjYPUcDM45OjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzGflt0I1VvgqivzODh6pn+cnrHMF+02KtIh22FE/FX6IbtG9/eB4Wj+06kBS7Un/KTUEP1I87I3C/nAfdEK3YA4XWu8wrD305Ejx3FyRQT6q8f5NH7WdqNrM3mTBJRN+z/UoakfZ7cC2PJeoRjOmHQ3+/m4NB+bRhEYWQRThM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cPauW9Xx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760628434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+hFokwdHbpcPCHvDt5rFrQSFXCNAMTz6j8T0mRBEF0=;
	b=cPauW9Xxp9Nx+1utVY0BNxOgWGbBB6T/UQgbekR4ljIBjyvTmIHt1FIjC9t7hbRqJVmfpq
	GT5PCu+g4FsIZlR7KThpgFdarmsavmk5zRuGXQyDo/DcQcqS+LNZGTryBgEVmKf6HOfnwe
	8HPZBeQZ6WxW2WWJn0bgOOt9fFhMLiY=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v3 7/7] funeth: convert to ndo_hwtstamp API
Date: Thu, 16 Oct 2025 15:25:15 +0000
Message-ID: <20251016152515.3510991-8-vadim.fedorenko@linux.dev>
In-Reply-To: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
.ndo_eth_ioctl() implementation becomes empty, remove it.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/fungible/funeth/funeth.h |  4 +-
 .../ethernet/fungible/funeth/funeth_main.c    | 40 +++++++------------
 2 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/fungible/funeth/funeth.h b/drivers/net/ethernet/fungible/funeth/funeth.h
index 1250e10d21db..55e705e239f8 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth.h
+++ b/drivers/net/ethernet/fungible/funeth/funeth.h
@@ -4,7 +4,7 @@
 #define _FUNETH_H
 
 #include <uapi/linux/if_ether.h>
-#include <uapi/linux/net_tstamp.h>
+#include <linux/net_tstamp.h>
 #include <linux/mutex.h>
 #include <linux/seqlock.h>
 #include <linux/xarray.h>
@@ -121,7 +121,7 @@ struct funeth_priv {
 	u8 rx_coal_usec;
 	u8 rx_coal_count;
 
-	struct hwtstamp_config hwtstamp_cfg;
+	struct kernel_hwtstamp_config hwtstamp_cfg;
 
 	/* cumulative queue stats from earlier queue instances */
 	u64 tx_packets;
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_main.c b/drivers/net/ethernet/fungible/funeth/funeth_main.c
index ac86179a0a81..792cddac6f1b 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_main.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_main.c
@@ -1014,26 +1014,25 @@ static int fun_get_port_attributes(struct net_device *netdev)
 	return 0;
 }
 
-static int fun_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+static int fun_hwtstamp_get(struct net_device *dev,
+			    struct kernel_hwtstamp_config *config)
 {
 	const struct funeth_priv *fp = netdev_priv(dev);
 
-	return copy_to_user(ifr->ifr_data, &fp->hwtstamp_cfg,
-			    sizeof(fp->hwtstamp_cfg)) ? -EFAULT : 0;
+	*config = fp->hwtstamp_cfg;
+	return 0;
 }
 
-static int fun_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
+static int fun_hwtstamp_set(struct net_device *dev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack)
 {
 	struct funeth_priv *fp = netdev_priv(dev);
-	struct hwtstamp_config cfg;
-
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
 
 	/* no TX HW timestamps */
-	cfg.tx_type = HWTSTAMP_TX_OFF;
+	config->tx_type = HWTSTAMP_TX_OFF;
 
-	switch (cfg.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
 	case HWTSTAMP_FILTER_ALL:
@@ -1051,26 +1050,14 @@ static int fun_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
-		cfg.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
 	}
 
-	fp->hwtstamp_cfg = cfg;
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
-}
-
-static int fun_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return fun_hwtstamp_set(dev, ifr);
-	case SIOCGHWTSTAMP:
-		return fun_hwtstamp_get(dev, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
+	fp->hwtstamp_cfg = *config;
+	return 0;
 }
 
 /* Prepare the queues for XDP. */
@@ -1340,7 +1327,6 @@ static const struct net_device_ops fun_netdev_ops = {
 	.ndo_change_mtu		= fun_change_mtu,
 	.ndo_set_mac_address	= fun_set_macaddr,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= fun_ioctl,
 	.ndo_uninit		= fun_uninit,
 	.ndo_bpf		= fun_xdp,
 	.ndo_xdp_xmit		= fun_xdp_xmit_frames,
@@ -1348,6 +1334,8 @@ static const struct net_device_ops fun_netdev_ops = {
 	.ndo_set_vf_vlan	= fun_set_vf_vlan,
 	.ndo_set_vf_rate	= fun_set_vf_rate,
 	.ndo_get_vf_config	= fun_get_vf_config,
+	.ndo_hwtstamp_get	= fun_hwtstamp_get,
+	.ndo_hwtstamp_set	= fun_hwtstamp_set,
 };
 
 #define GSO_ENCAP_FLAGS (NETIF_F_GSO_GRE | NETIF_F_GSO_IPXIP4 | \
-- 
2.47.3


