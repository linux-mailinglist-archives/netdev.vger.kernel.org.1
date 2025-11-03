Return-Path: <netdev+bounces-235152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE886C2CDEA
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1615F4236CE
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C331A7F6;
	Mon,  3 Nov 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQE8dIU/"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11832314A78
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182631; cv=none; b=gl2V8/P0djXqNGoMdHg1I2LvhDbBP0xK93q4EGoAa5kMBi0fa2VP5K7w8JgnPb+6i8EEjw5gHqLi8hYjf3VO6G+oUyNYQu2n45MxNTcxS/p9R9lShgbyjLVk+4EToyegvxGVzO8F0PlzkQ6i/ae6ljqOItvCppP9krly2QCbBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182631; c=relaxed/simple;
	bh=02mvbBJrB8t8QuU5hPTe4ELFPMWYks4qeITywjdZPu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsNjEFNwGTYgcd1Wf+2WLSEGPxI9uq2gQcy1hyme/c9RUW4Rra4PtBHTSbF58SqFqrwBHRKE0Pfobtd+Z7p5pXHZ4q/KhxuioltQkHxX+jwpCwijbcSsZDYqD43QcLicSclHqXlkS4jekyq1QYt+aNuShbJSS94+7rzTWNXHxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQE8dIU/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762182626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWuVspmUhSJsExmenHKhxq2bnNciqFsbmxhyM13tHTg=;
	b=TQE8dIU/ZknqxJkubcDLYx4CCgOVVMkyUI+O+ye0aI5X2Wqnc7Z0SrQVn5nE7VKD/5x+rd
	uX3qmLYVQgUECB2Wf3lG8XaCw/DIZ8GqAnR/2ukz8XwSFNQPPwoge99nIOE2aUobjPvLN/
	s/VPVDc6iiWHOX7H1c4kLwijPd9mtFA=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Manish Chopra <manishc@marvell.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/7] net: octeon: mgmt: convert to use ndo_hwtstamp callbacks
Date: Mon,  3 Nov 2025 15:09:49 +0000
Message-ID: <20251103150952.3538205-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The driver implemented SIOCSHWTSTAMP ioctl command only. But it stores
timestamping configuration, so it is possible to report it to users.
Implement both ndo_hwtstamp_set and ndo_hwtstamp_get callbacks. After
this the ndo_eth_ioctl effectively becomes phy_do_ioctl - adjust
callback accordingly.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 62 ++++++++++---------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index 393b9951490a..c190fc6538d4 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -690,19 +690,16 @@ static irqreturn_t octeon_mgmt_interrupt(int cpl, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int octeon_mgmt_ioctl_hwtstamp(struct net_device *netdev,
-				      struct ifreq *rq, int cmd)
+static int octeon_mgmt_hwtstamp_set(struct net_device *netdev,
+				    struct kernel_hwtstamp_config *config,
+				    struct netlink_ext_ack *extack)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	struct hwtstamp_config config;
-	union cvmx_mio_ptp_clock_cfg ptp;
 	union cvmx_agl_gmx_rxx_frm_ctl rxx_frm_ctl;
+	union cvmx_mio_ptp_clock_cfg ptp;
 	bool have_hw_timestamps = false;
 
-	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	/* Check the status of hardware for tiemstamps */
+	/* Check the status of hardware for timestamps */
 	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
 		/* Get the current state of the PTP clock */
 		ptp.u64 = cvmx_read_csr(CVMX_MIO_PTP_CLOCK_CFG);
@@ -733,10 +730,12 @@ static int octeon_mgmt_ioctl_hwtstamp(struct net_device *netdev,
 		have_hw_timestamps = true;
 	}
 
-	if (!have_hw_timestamps)
+	if (!have_hw_timestamps) {
+		NL_SET_ERR_MSG_MOD(extack, "HW doesn't support timestamping");
 		return -EINVAL;
+	}
 
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 	case HWTSTAMP_TX_ON:
 		break;
@@ -744,7 +743,7 @@ static int octeon_mgmt_ioctl_hwtstamp(struct net_device *netdev,
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		p->has_rx_tstamp = false;
 		rxx_frm_ctl.u64 = cvmx_read_csr(p->agl + AGL_GMX_RX_FRM_CTL);
@@ -766,33 +765,34 @@ static int octeon_mgmt_ioctl_hwtstamp(struct net_device *netdev,
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
-		p->has_rx_tstamp = have_hw_timestamps;
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
-		if (p->has_rx_tstamp) {
-			rxx_frm_ctl.u64 = cvmx_read_csr(p->agl + AGL_GMX_RX_FRM_CTL);
-			rxx_frm_ctl.s.ptp_mode = 1;
-			cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_CTL, rxx_frm_ctl.u64);
-		}
+		p->has_rx_tstamp = true;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
+		rxx_frm_ctl.u64 = cvmx_read_csr(p->agl + AGL_GMX_RX_FRM_CTL);
+		rxx_frm_ctl.s.ptp_mode = 1;
+		cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_CTL, rxx_frm_ctl.u64);
 		break;
 	default:
 		return -ERANGE;
 	}
 
-	if (copy_to_user(rq->ifr_data, &config, sizeof(config)))
-		return -EFAULT;
-
 	return 0;
 }
 
-static int octeon_mgmt_ioctl(struct net_device *netdev,
-			     struct ifreq *rq, int cmd)
+static int octeon_mgmt_hwtstamp_get(struct net_device *netdev,
+				    struct kernel_hwtstamp_config *config)
 {
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return octeon_mgmt_ioctl_hwtstamp(netdev, rq, cmd);
-	default:
-		return phy_do_ioctl(netdev, rq, cmd);
-	}
+	struct octeon_mgmt *p = netdev_priv(netdev);
+
+	/* Check the status of hardware for timestamps */
+	if (!OCTEON_IS_MODEL(OCTEON_CN6XXX))
+		return -EINVAL;
+
+	config->tx_type = HWTSTAMP_TX_ON;
+	config->rx_filter = p->has_rx_tstamp ?
+			    HWTSTAMP_FILTER_ALL :
+			    HWTSTAMP_FILTER_NONE;
+
+	return 0;
 }
 
 static void octeon_mgmt_disable_link(struct octeon_mgmt *p)
@@ -1370,11 +1370,13 @@ static const struct net_device_ops octeon_mgmt_ops = {
 	.ndo_start_xmit =		octeon_mgmt_xmit,
 	.ndo_set_rx_mode =		octeon_mgmt_set_rx_filtering,
 	.ndo_set_mac_address =		octeon_mgmt_set_mac_address,
-	.ndo_eth_ioctl =			octeon_mgmt_ioctl,
+	.ndo_eth_ioctl =		phy_do_ioctl,
 	.ndo_change_mtu =		octeon_mgmt_change_mtu,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller =		octeon_mgmt_poll_controller,
 #endif
+	.ndo_hwtstamp_get =		octeon_mgmt_hwtstamp_get,
+	.ndo_hwtstamp_set =		octeon_mgmt_hwtstamp_set,
 };
 
 static int octeon_mgmt_probe(struct platform_device *pdev)
-- 
2.47.3


