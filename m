Return-Path: <netdev+bounces-143746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F49C3F14
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4823AB24DD0
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637E1A704B;
	Mon, 11 Nov 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FI6ULg3x"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7D1A7065;
	Mon, 11 Nov 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329967; cv=none; b=u/oMiWKKhxBfZwwEeahpsiPXAcGdvx7YTVX0VQprNnPdQX7fwo305thRSlHmvE477h0CJM4cOtOstagkfYinO7NBhdkORrYcjlwx64xS7DZoX1f/8K3XhqMBtKWmEkhUHFLk8cDYRljDM53xD9+HzDoSBVGGACgZ7s1APlRvOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329967; c=relaxed/simple;
	bh=kVg/6cW9dd+1aR+COVuitIWkxGtXwAKSe+9ojeadEuc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io8g29IDC9iuWD3R6QpHPCdr7vpnCKx1gtfF6NCPzjdu5zqeDkN2GOTiV7hIKfXUOgbO+EtzC0l+Y4aCPOlD7omYVHfo+ioh9rO3VkhYGBEFlBk0qNAwzElgNO43cN38JeI8uV0zASDUtYiuDgYOTJ7b66QkXBHX9nUQWV6RgIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FI6ULg3x; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731329965; x=1762865965;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=kVg/6cW9dd+1aR+COVuitIWkxGtXwAKSe+9ojeadEuc=;
  b=FI6ULg3xh5glCICL1O7kIAubV5Ro1AHDclMjmxhgBeQDLeOyiUGyAtaf
   KsrDW5zXYR3kIX8AMIo5mBpYX+NNZsWFhLYrVZibMmkYc6KK4rDg5YIYm
   3Ifw5MCLrLgx6kOzoKtLkcSJaXJBoiysXQudanCpZ9QTzjpYoeNp9xd3s
   Oj6Hz3uuI03S0tKHpyEl2e6FaeJrWQM1vcRbh48eu8dnWcnVLoSUHKtlw
   R8N1y5xIxr+lOr2ngGONqKAbb/vMZ2JE7iwS6WCw1be+D3InFzqp/DbO0
   NcRv0zwCwvple7lI/1p7ucxMg1GCiTMWRLcpnt4UPdLghYB2M4xY8fLKx
   Q==;
X-CSE-ConnectionGUID: YlFV9OzpTUmqSEDx6Wb8tw==
X-CSE-MsgGUID: /ugJMNJGSqOetvWIpKttLQ==
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="34653177"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2024 05:59:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Nov 2024 05:58:53 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 11 Nov 2024 05:58:49 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: [PATCH net-next v2 2/5] net: phy: microchip_ptp : Add ptp library for Microchip phys
Date: Mon, 11 Nov 2024 18:28:30 +0530
Message-ID: <20241111125833.13143-3-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111125833.13143-1-divya.koppera@microchip.com>
References: <20241111125833.13143-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add ptp library for Microchip phys
1-step and 2-step modes are supported, over Ethernet and UDP(ipv4, ipv6)

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v2
- Removed redundant memsets
- Moved to standard comparision than memcmp for u16
- Fixed sparse/smatch warnings reported by kernel test robot
- Added spinlock to shared code
- Moved redundant part of code out of spinlock protected area
---
 drivers/net/phy/microchip_ptp.c | 998 ++++++++++++++++++++++++++++++++
 1 file changed, 998 insertions(+)
 create mode 100644 drivers/net/phy/microchip_ptp.c

diff --git a/drivers/net/phy/microchip_ptp.c b/drivers/net/phy/microchip_ptp.c
new file mode 100644
index 000000000000..2d0f9e91b933
--- /dev/null
+++ b/drivers/net/phy/microchip_ptp.c
@@ -0,0 +1,998 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Microchip Technology
+
+#include "microchip_ptp.h"
+
+static int mchp_ptp_flush_fifo(struct mchp_ptp_clock *ptp_clock,
+			       enum ptp_fifo_dir dir)
+{
+	struct phy_device *phydev = ptp_clock->phydev;
+	int rc;
+
+	for (int i = 0; i < MCHP_PTP_FIFO_SIZE; ++i) {
+		rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+				  dir == PTP_EGRESS_FIFO ?
+				  MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)) :
+				  MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
+		if (rc < 0)
+			return rc;
+	}
+	return phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			    MCHP_PTP_INT_STS(BASE_PORT(ptp_clock)));
+}
+
+static int mchp_ptp_config_intr(struct mchp_ptp_clock *ptp_clock,
+				bool enable)
+{
+	struct phy_device *phydev = ptp_clock->phydev;
+
+	/* Enable  or disable ptp interrupts */
+	return phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			     MCHP_PTP_INT_EN(BASE_PORT(ptp_clock)),
+			     enable ? MCHP_PTP_INT_ALL_MSK : 0);
+}
+
+static void mchp_ptp_txtstamp(struct mii_timestamper *mii_ts,
+			      struct sk_buff *skb, int type)
+{
+	struct mchp_ptp_clock *ptp_clock = container_of(mii_ts,
+						      struct mchp_ptp_clock,
+						      mii_ts);
+
+	switch (ptp_clock->hwts_tx_type) {
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+		if (ptp_msg_is_sync(skb, type)) {
+			kfree_skb(skb);
+			return;
+		}
+		fallthrough;
+	case HWTSTAMP_TX_ON:
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		skb_queue_tail(&ptp_clock->tx_queue, skb);
+		break;
+	case HWTSTAMP_TX_OFF:
+	default:
+		kfree_skb(skb);
+		break;
+	}
+}
+
+static bool mchp_ptp_get_sig_rx(struct sk_buff *skb, u16 *sig)
+{
+	struct ptp_header *ptp_header;
+	int type;
+
+	skb_push(skb, ETH_HLEN);
+	type = ptp_classify_raw(skb);
+	if (type == PTP_CLASS_NONE)
+		return false;
+
+	ptp_header = ptp_parse_header(skb, type);
+	if (!ptp_header)
+		return false;
+
+	skb_pull_inline(skb, ETH_HLEN);
+
+	*sig = (__force u16)(ntohs(ptp_header->sequence_id));
+
+	return true;
+}
+
+static bool mchp_ptp_match_skb(struct mchp_ptp_clock *ptp_clock,
+			       struct mchp_ptp_rx_ts *rx_ts)
+{
+	struct skb_shared_hwtstamps *shhwtstamps;
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long flags;
+	bool rc = false;
+	u16 skb_sig;
+
+	spin_lock_irqsave(&ptp_clock->rx_queue.lock, flags);
+	skb_queue_walk_safe(&ptp_clock->rx_queue, skb, skb_tmp) {
+		if (!mchp_ptp_get_sig_rx(skb, &skb_sig))
+			continue;
+
+		if (skb_sig != rx_ts->seq_id)
+			continue;
+
+		__skb_unlink(skb, &ptp_clock->rx_queue);
+
+		rc = true;
+		break;
+	}
+	spin_unlock_irqrestore(&ptp_clock->rx_queue.lock, flags);
+
+	if (rc) {
+		shhwtstamps = skb_hwtstamps(skb);
+		shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, rx_ts->nsec);
+		netif_rx(skb);
+	}
+
+	return rc;
+}
+
+static void mchp_ptp_match_rx_ts(struct mchp_ptp_clock *ptp_clock,
+				 struct mchp_ptp_rx_ts *rx_ts)
+{
+	unsigned long flags;
+
+	/* If we failed to match the skb add it to the queue for when
+	 * the frame will come
+	 */
+	if (!mchp_ptp_match_skb(ptp_clock, rx_ts)) {
+		spin_lock_irqsave(&ptp_clock->rx_ts_lock, flags);
+		list_add(&rx_ts->list, &ptp_clock->rx_ts_list);
+		spin_unlock_irqrestore(&ptp_clock->rx_ts_lock, flags);
+	} else {
+		kfree(rx_ts);
+	}
+}
+
+static void mchp_ptp_match_rx_skb(struct mchp_ptp_clock *ptp_clock,
+				  struct sk_buff *skb)
+{
+	struct skb_shared_hwtstamps *shhwtstamps;
+	struct mchp_ptp_rx_ts *rx_ts, *tmp;
+	unsigned long flags;
+	bool match = false;
+	u16 skb_sig;
+
+	if (!mchp_ptp_get_sig_rx(skb, &skb_sig))
+		return;
+
+	/* Iterate over all RX timestamps and match it with the received skbs */
+	spin_lock_irqsave(&ptp_clock->rx_ts_lock, flags);
+	list_for_each_entry_safe(rx_ts, tmp, &ptp_clock->rx_ts_list, list) {
+		/* Check if we found the signature we were looking for. */
+		if (skb_sig != rx_ts->seq_id)
+			continue;
+
+		match = true;
+		break;
+	}
+	spin_unlock_irqrestore(&ptp_clock->rx_ts_lock, flags);
+
+	if (match) {
+		shhwtstamps = skb_hwtstamps(skb);
+		shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, rx_ts->nsec);
+		netif_rx(skb);
+
+		list_del(&rx_ts->list);
+		kfree(rx_ts);
+	} else {
+		skb_queue_tail(&ptp_clock->rx_queue, skb);
+	}
+}
+
+static bool mchp_ptp_rxtstamp(struct mii_timestamper *mii_ts,
+			      struct sk_buff *skb, int type)
+{
+	struct mchp_ptp_clock *ptp_clock = container_of(mii_ts,
+							struct mchp_ptp_clock,
+							mii_ts);
+
+	if (ptp_clock->rx_filter == HWTSTAMP_FILTER_NONE ||
+	    type == PTP_CLASS_NONE)
+		return false;
+
+	if ((type & ptp_clock->version) == 0 || (type & ptp_clock->layer) == 0)
+		return false;
+
+	/* Here if match occurs skb is sent to application, If not skb is added
+	 * to queue and sending skb to application will get handled when
+	 * interrupt occurs i.e., it get handles in interrupt handler. By
+	 * any means skb will reach the application so we should not return
+	 * false here if skb doesn't matches.
+	 */
+	mchp_ptp_match_rx_skb(ptp_clock, skb);
+
+	return true;
+}
+
+static int mchp_ptp_hwtstamp(struct mii_timestamper *mii_ts,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack)
+{
+	struct mchp_ptp_clock *ptp_clock =
+				container_of(mii_ts, struct mchp_ptp_clock,
+					     mii_ts);
+	struct phy_device *phydev = ptp_clock->phydev;
+	struct mchp_ptp_rx_ts *rx_ts, *tmp;
+	int txcfg = 0, rxcfg = 0;
+	unsigned long flags;
+	int rc;
+
+	ptp_clock->hwts_tx_type = config->tx_type;
+	ptp_clock->rx_filter = config->rx_filter;
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		ptp_clock->layer = 0;
+		ptp_clock->version = 0;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		ptp_clock->layer = PTP_CLASS_L4;
+		ptp_clock->version = PTP_CLASS_V2;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+		ptp_clock->layer = PTP_CLASS_L2;
+		ptp_clock->version = PTP_CLASS_V2;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		ptp_clock->layer = PTP_CLASS_L4 | PTP_CLASS_L2;
+		ptp_clock->version = PTP_CLASS_V2;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	/* Setup parsing of the frames and enable the timestamping for ptp
+	 * frames
+	 */
+	if (ptp_clock->layer & PTP_CLASS_L2) {
+		rxcfg = MCHP_PTP_PARSE_CONFIG_LAYER2_EN;
+		txcfg = MCHP_PTP_PARSE_CONFIG_LAYER2_EN;
+	}
+	if (ptp_clock->layer & PTP_CLASS_L4) {
+		rxcfg |= MCHP_PTP_PARSE_CONFIG_IPV4_EN |
+			 MCHP_PTP_PARSE_CONFIG_IPV6_EN;
+		txcfg |= MCHP_PTP_PARSE_CONFIG_IPV4_EN |
+			 MCHP_PTP_PARSE_CONFIG_IPV6_EN;
+	}
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_RX_PARSE_CONFIG(BASE_PORT(ptp_clock)),
+			   rxcfg);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TX_PARSE_CONFIG(BASE_PORT(ptp_clock)),
+			   txcfg);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_RX_TIMESTAMP_EN(BASE_PORT(ptp_clock)),
+			   MCHP_PTP_TIMESTAMP_EN_ALL);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TX_TIMESTAMP_EN(BASE_PORT(ptp_clock)),
+			   MCHP_PTP_TIMESTAMP_EN_ALL);
+	if (rc < 0)
+		return rc;
+
+	if (ptp_clock->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		/* Enable / disable of the TX timestamp in the SYNC frames */
+		rc = phy_modify_mmd(phydev, PTP_MMD(ptp_clock),
+				    MCHP_PTP_TX_MOD(BASE_PORT(ptp_clock)),
+				    MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT,
+				    MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT);
+	else
+		rc = phy_modify_mmd(phydev, PTP_MMD(ptp_clock),
+				    MCHP_PTP_TX_MOD(BASE_PORT(ptp_clock)),
+				    MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT,
+				    (u16)~MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT);
+
+	if (rc < 0)
+		return rc;
+
+	/* Now enable the timestamping interrupts */
+	rc = mchp_ptp_config_intr(ptp_clock,
+				  config->rx_filter != HWTSTAMP_FILTER_NONE);
+	if (rc < 0)
+		return rc;
+
+	/* In case of multiple starts and stops, these needs to be cleared */
+	spin_lock_irqsave(&ptp_clock->rx_ts_lock, flags);
+	list_for_each_entry_safe(rx_ts, tmp, &ptp_clock->rx_ts_list, list) {
+		list_del(&rx_ts->list);
+		kfree(rx_ts);
+	}
+	spin_unlock_irqrestore(&ptp_clock->rx_ts_lock, flags);
+	skb_queue_purge(&ptp_clock->rx_queue);
+	skb_queue_purge(&ptp_clock->tx_queue);
+
+	rc = mchp_ptp_flush_fifo(ptp_clock, PTP_INGRESS_FIFO);
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_ptp_flush_fifo(ptp_clock, PTP_EGRESS_FIFO);
+
+	return rc < 0 ? rc : 0;
+}
+
+static int mchp_ptp_ts_info(struct mii_timestamper *mii_ts,
+			    struct kernel_ethtool_ts_info *info)
+{
+	struct mchp_ptp_clock *ptp_clock = container_of(mii_ts,
+							struct mchp_ptp_clock,
+							mii_ts);
+
+	info->phc_index =
+		ptp_clock->ptp_clock ? ptp_clock_index(ptp_clock->ptp_clock) : -1;
+	if (info->phc_index == -1)
+		return 0;
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON) |
+			 BIT(HWTSTAMP_TX_ONESTEP_SYNC);
+
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
+
+	return 0;
+}
+
+static int mchp_ptp_ltc_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	struct mchp_ptp_clock *ptp_clock = container_of(info,
+							struct mchp_ptp_clock,
+							caps);
+	struct phy_device *phydev = ptp_clock->phydev;
+	struct timespec64 ts;
+	bool add = true;
+	int rc = 0;
+	u32 nsec;
+	s32 sec;
+
+	/* The HW allows up to 15 sec to adjust the time, but here we limit to
+	 * 10 sec the adjustment. The reason is, in case the adjustment is 14
+	 * sec and 999999999 nsec, then we add 8ns to compensate the actual
+	 * increment so the value can be bigger than 15 sec. Therefore limit the
+	 * possible adjustments so we will not have these corner cases
+	 */
+	if (delta > 10000000000LL || delta < -10000000000LL) {
+		/* The timeadjustment is too big, so fall back using set time */
+		u64 now;
+
+		info->gettime64(info, &ts);
+
+		now = ktime_to_ns(timespec64_to_ktime(ts));
+		ts = ns_to_timespec64(now + delta);
+
+		info->settime64(info, &ts);
+		return 0;
+	}
+	sec = div_u64_rem(abs(delta), NSEC_PER_SEC, &nsec);
+	if (delta < 0 && nsec != 0) {
+		/* It is not allowed to adjust low the nsec part, therefore
+		 * subtract more from second part and add to nanosecond such
+		 * that would roll over, so the second part will increase
+		 */
+		sec--;
+		nsec = NSEC_PER_SEC - nsec;
+	}
+
+	/* Calculate the adjustments and the direction */
+	if (delta < 0)
+		add = false;
+
+	if (nsec > 0) {
+		/* add 8 ns to cover the likely normal increment */
+		nsec += 8;
+
+		if (nsec >= NSEC_PER_SEC) {
+			/* carry into seconds */
+			sec++;
+			nsec -= NSEC_PER_SEC;
+		}
+	}
+
+	mutex_lock(&ptp_clock->ptp_lock);
+	if (sec) {
+		sec = abs(sec);
+
+		rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+				   MCHP_PTP_LTC_STEP_ADJ_LO(BASE_CLK(ptp_clock)),
+				   sec);
+		if (rc < 0)
+			goto out_unlock;
+		rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
+				      MCHP_PTP_LTC_STEP_ADJ_HI(BASE_CLK(ptp_clock)),
+				      ((add ? MCHP_PTP_LTC_STEP_ADJ_HI_DIR :
+					0) | ((sec >> 16) & GENMASK(13, 0))));
+		if (rc < 0)
+			goto out_unlock;
+		rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
+				      MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
+				      MCHP_PTP_CMD_CTL_LTC_STEP_SEC);
+		if (rc < 0)
+			goto out_unlock;
+	}
+
+	if (nsec) {
+		rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+				   MCHP_PTP_LTC_STEP_ADJ_LO(BASE_CLK(ptp_clock)),
+				   nsec & GENMASK(15, 0));
+		if (rc < 0)
+			goto out_unlock;
+		rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+				   MCHP_PTP_LTC_STEP_ADJ_HI(BASE_CLK(ptp_clock)),
+				   (nsec >> 16) & GENMASK(13, 0));
+		if (rc < 0)
+			goto out_unlock;
+		rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
+				      MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
+				      MCHP_PTP_CMD_CTL_LTC_STEP_NSEC);
+	}
+
+out_unlock:
+	mutex_unlock(&ptp_clock->ptp_lock);
+
+	return rc;
+}
+
+static int mchp_ptp_ltc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	struct mchp_ptp_clock *ptp_clock = container_of(info,
+							struct mchp_ptp_clock,
+							caps);
+	struct phy_device *phydev = ptp_clock->phydev;
+	u16 rate_lo, rate_hi;
+	bool faster = true;
+	u32 rate;
+	int rc;
+
+	if (!scaled_ppm)
+		return 0;
+
+	if (scaled_ppm < 0) {
+		scaled_ppm = -scaled_ppm;
+		faster = false;
+	}
+
+	rate = MCHP_PTP_1PPM_FORMAT * (upper_16_bits(scaled_ppm));
+	rate += (MCHP_PTP_1PPM_FORMAT * (lower_16_bits(scaled_ppm))) >> 16;
+
+	rate_lo = rate & GENMASK(15, 0);
+	rate_hi = (rate >> 16) & GENMASK(13, 0);
+
+	if (faster)
+		rate_hi |= MCHP_PTP_LTC_RATE_ADJ_HI_DIR;
+
+	mutex_lock(&ptp_clock->ptp_lock);
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_LTC_RATE_ADJ_HI(BASE_CLK(ptp_clock)),
+			   rate_hi);
+	if (rc < 0)
+		goto error;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_LTC_RATE_ADJ_LO(BASE_CLK(ptp_clock)),
+			   rate_lo);
+	if (rc > 0)
+		rc = 0;
+error:
+	mutex_unlock(&ptp_clock->ptp_lock);
+
+	return rc;
+}
+
+static int mchp_ptp_ltc_gettime64(struct ptp_clock_info *info,
+				  struct timespec64 *ts)
+{
+	struct mchp_ptp_clock *ptp_clock = container_of(info,
+							struct mchp_ptp_clock,
+							caps);
+	struct phy_device *phydev = ptp_clock->phydev;
+	time64_t secs;
+	int rc = 0;
+	s64 nsecs;
+
+	mutex_lock(&ptp_clock->ptp_lock);
+	/* Set read bit to 1 to save current values of 1588 local time counter
+	 * into PTP LTC seconds and nanoseconds registers.
+	 */
+	rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
+			      MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
+			      MCHP_PTP_CMD_CTL_CLOCK_READ);
+	if (rc < 0)
+		goto out_unlock;
+
+	/* Get LTC clock values */
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_LTC_READ_SEC_HI(BASE_CLK(ptp_clock)));
+	if (rc < 0)
+		goto out_unlock;
+	secs = rc << 16;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_LTC_READ_SEC_MID(BASE_CLK(ptp_clock)));
+	if (rc < 0)
+		goto out_unlock;
+	secs |= rc;
+	secs <<= 16;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_LTC_READ_SEC_LO(BASE_CLK(ptp_clock)));
+	if (rc < 0)
+		goto out_unlock;
+	secs |= rc;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_LTC_READ_NS_HI(BASE_CLK(ptp_clock)));
+	if (rc < 0)
+		goto out_unlock;
+	nsecs = (rc & GENMASK(13, 0));
+	nsecs <<= 16;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_LTC_READ_NS_LO(BASE_CLK(ptp_clock)));
+	if (rc < 0)
+		goto out_unlock;
+	nsecs |= rc;
+
+	set_normalized_timespec64(ts, secs, nsecs);
+
+	if (rc > 0)
+		rc = 0;
+out_unlock:
+	mutex_unlock(&ptp_clock->ptp_lock);
+
+	return rc;
+}
+
+static int mchp_ptp_ltc_settime64(struct ptp_clock_info *info,
+				  const struct timespec64 *ts)
+{
+	struct mchp_ptp_clock *ptp_clock = container_of(info,
+							struct mchp_ptp_clock,
+							caps);
+	struct phy_device *phydev = ptp_clock->phydev;
+	int rc;
+
+	mutex_lock(&ptp_clock->ptp_lock);
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_LTC_SEC_LO(BASE_CLK(ptp_clock)),
+			   lower_16_bits(ts->tv_sec));
+	if (rc < 0)
+		goto out_unlock;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_LTC_SEC_MID(BASE_CLK(ptp_clock)),
+			   upper_16_bits(ts->tv_sec));
+	if (rc < 0)
+		goto out_unlock;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_LTC_SEC_HI(BASE_CLK(ptp_clock)),
+			   upper_32_bits(ts->tv_sec) & GENMASK(15, 0));
+	if (rc < 0)
+		goto out_unlock;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_LTC_NS_LO(BASE_CLK(ptp_clock)),
+			   lower_16_bits(ts->tv_nsec));
+	if (rc < 0)
+		goto out_unlock;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_LTC_NS_HI(BASE_CLK(ptp_clock)),
+			   upper_16_bits(ts->tv_nsec) & GENMASK(13, 0));
+	if (rc < 0)
+		goto out_unlock;
+
+	/* Set load bit to 1 to write PTP LTC seconds and nanoseconds
+	 * registers to 1588 local time counter.
+	 */
+	rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
+			      MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
+			      MCHP_PTP_CMD_CTL_CLOCK_LOAD);
+	if (rc > 0)
+		rc = 0;
+out_unlock:
+	mutex_unlock(&ptp_clock->ptp_lock);
+
+	return rc;
+}
+
+static bool mchp_ptp_get_sig_tx(struct sk_buff *skb, u16 *sig)
+{
+	struct ptp_header *ptp_header;
+	int type;
+
+	type = ptp_classify_raw(skb);
+	if (type == PTP_CLASS_NONE)
+		return false;
+
+	ptp_header = ptp_parse_header(skb, type);
+	if (!ptp_header)
+		return false;
+
+	*sig = (__force u16)(htons(ptp_header->sequence_id));
+
+	return true;
+}
+
+static void mchp_ptp_match_tx_skb(struct mchp_ptp_clock *ptp_clock,
+				  u32 seconds, u32 nsec, u16 seq_id)
+{
+	struct skb_shared_hwtstamps shhwtstamps;
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long flags;
+	bool rc = false;
+	u16 skb_sig;
+
+	spin_lock_irqsave(&ptp_clock->tx_queue.lock, flags);
+	skb_queue_walk_safe(&ptp_clock->tx_queue, skb, skb_tmp) {
+		if (!mchp_ptp_get_sig_tx(skb, &skb_sig))
+			continue;
+
+		if (skb_sig != seq_id)
+			continue;
+
+		__skb_unlink(skb, &ptp_clock->tx_queue);
+		rc = true;
+		break;
+	}
+	spin_unlock_irqrestore(&ptp_clock->tx_queue.lock, flags);
+
+	if (rc) {
+		shhwtstamps.hwtstamp = ktime_set(seconds, nsec);
+		skb_complete_tx_timestamp(skb, &shhwtstamps);
+	}
+}
+
+static struct mchp_ptp_rx_ts *mchp_ptp_get_rx_ts(struct mchp_ptp_clock *ptp_clock)
+{
+	struct phy_device *phydev = ptp_clock->phydev;
+	struct mchp_ptp_rx_ts *rx_ts = NULL;
+	u32 sec, nsec;
+	int rc;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_RX_INGRESS_NS_HI(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		goto error;
+	if (!(rc & MCHP_PTP_RX_INGRESS_NS_HI_TS_VALID)) {
+		phydev_err(phydev, "RX Timestamp is not valid!\n");
+		goto error;
+	}
+	nsec = (rc & GENMASK(13, 0)) << 16;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_RX_INGRESS_NS_LO(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		goto error;
+	nsec |= rc;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_RX_INGRESS_SEC_HI(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		goto error;
+	sec = rc << 16;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_RX_INGRESS_SEC_LO(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		goto error;
+	sec |= rc;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		goto error;
+
+	rx_ts = kzalloc(sizeof(*rx_ts), GFP_KERNEL);
+	if (!rx_ts)
+		return NULL;
+
+	rx_ts->seconds = sec;
+	rx_ts->nsec = nsec;
+	rx_ts->seq_id = rc;
+
+error:
+	return rx_ts;
+}
+
+static void mchp_ptp_process_rx_ts(struct mchp_ptp_clock *ptp_clock)
+{
+	struct phy_device *phydev = ptp_clock->phydev;
+	int caps;
+
+	do {
+		struct mchp_ptp_rx_ts *rx_ts;
+
+		rx_ts = mchp_ptp_get_rx_ts(ptp_clock);
+		if (rx_ts)
+			mchp_ptp_match_rx_ts(ptp_clock, rx_ts);
+
+		caps = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+				    MCHP_PTP_CAP_INFO(BASE_PORT(ptp_clock)));
+		if (caps < 0)
+			return;
+	} while (MCHP_PTP_RX_TS_CNT(caps) > 0);
+}
+
+static bool mchp_ptp_get_tx_ts(struct mchp_ptp_clock *ptp_clock,
+			       u32 *sec, u32 *nsec, u16 *seq)
+{
+	struct phy_device *phydev = ptp_clock->phydev;
+	int rc;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_TX_EGRESS_NS_HI(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		return false;
+	if (!(rc & MCHP_PTP_TX_EGRESS_NS_HI_TS_VALID))
+		return false;
+	*nsec = (rc & GENMASK(13, 0)) << 16;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_TX_EGRESS_NS_LO(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		return false;
+	*nsec = *nsec | rc;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_TX_EGRESS_SEC_HI(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		return false;
+	*sec = rc << 16;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_TX_EGRESS_SEC_LO(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		return false;
+	*sec = *sec | rc;
+
+	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+			  MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)));
+	if (rc < 0)
+		return false;
+
+	*seq = rc;
+
+	return true;
+}
+
+static void mchp_ptp_process_tx_ts(struct mchp_ptp_clock *ptp_clock)
+{
+	struct phy_device *phydev = ptp_clock->phydev;
+	int caps;
+
+	do {
+		u32 sec, nsec;
+		u16 seq;
+
+		if (mchp_ptp_get_tx_ts(ptp_clock, &sec, &nsec, &seq))
+			mchp_ptp_match_tx_skb(ptp_clock, sec, nsec, seq);
+
+		caps = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+				    MCHP_PTP_CAP_INFO(BASE_PORT(ptp_clock)));
+		if (caps < 0)
+			return;
+	} while (MCHP_PTP_TX_TS_CNT(caps) > 0);
+}
+
+int mchp_config_ptp_intr(struct mchp_ptp_clock *ptp_clock,
+			 u16 reg, u16 val, bool clear)
+{
+	struct phy_device *phydev = ptp_clock->phydev;
+
+	if (clear)
+		return phy_clear_bits_mmd(phydev, PTP_MMD(ptp_clock), reg, val);
+	else
+		return phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock), reg, val);
+}
+EXPORT_SYMBOL_GPL(mchp_config_ptp_intr);
+
+irqreturn_t mchp_ptp_handle_interrupt(struct mchp_ptp_clock *ptp_clock)
+{
+	struct phy_device *phydev;
+	int irq_status;
+
+	if (ptp_clock) {
+		phydev = ptp_clock->phydev;
+		do {
+			irq_status = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
+						  MCHP_PTP_INT_STS(BASE_PORT(ptp_clock)));
+			if (irq_status < 0)
+				return IRQ_NONE;
+
+			if (irq_status & MCHP_PTP_INT_RX_TS_EN)
+				mchp_ptp_process_rx_ts(ptp_clock);
+
+			if (irq_status & MCHP_PTP_INT_TX_TS_EN)
+				mchp_ptp_process_tx_ts(ptp_clock);
+
+			if (irq_status & MCHP_PTP_INT_TX_TS_OVRFL_EN) {
+				mchp_ptp_flush_fifo(ptp_clock, PTP_EGRESS_FIFO);
+				skb_queue_purge(&ptp_clock->tx_queue);
+			}
+
+			if (irq_status & MCHP_PTP_INT_RX_TS_OVRFL_EN) {
+				mchp_ptp_flush_fifo(ptp_clock, PTP_INGRESS_FIFO);
+				skb_queue_purge(&ptp_clock->rx_queue);
+			}
+		} while (irq_status & (MCHP_PTP_INT_RX_TS_EN |
+				       MCHP_PTP_INT_TX_TS_EN |
+				       MCHP_PTP_INT_TX_TS_OVRFL_EN |
+				       MCHP_PTP_INT_RX_TS_OVRFL_EN));
+	} else {
+		/* To handle rogue interrupt scenarios */
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(mchp_ptp_handle_interrupt);
+
+static int mchp_ptp_init(struct mchp_ptp_clock *ptp_clock)
+{
+	struct phy_device *phydev = ptp_clock->phydev;
+	int rc;
+
+	/* Disable PTP */
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
+			   MCHP_PTP_CMD_CTL_DIS);
+	if (rc < 0)
+		return rc;
+
+	/* Disable TSU */
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TSU_GEN_CONFIG(BASE_PORT(ptp_clock)), 0);
+	if (rc < 0)
+		return rc;
+
+	/* Clear PTP interrupt status registers */
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TSU_HARD_RESET(BASE_PORT(ptp_clock)),
+			   MCHP_PTP_TSU_HARDRESET);
+	if (rc < 0)
+		return rc;
+
+	/* Predictor enable */
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_LATENCY_CORRECTION_CTL(BASE_CLK(ptp_clock)),
+			   MCHP_PTP_LATENCY_SETTING);
+	if (rc < 0)
+		return rc;
+
+	/* Configure PTP operational mode */
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_OP_MODE(BASE_CLK(ptp_clock)),
+			   MCHP_PTP_OP_MODE_STANDALONE);
+	if (rc < 0)
+		return rc;
+
+	/* Reference clock configuration */
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_REF_CLK_CFG(BASE_CLK(ptp_clock)),
+			   MCHP_PTP_REF_CLK_CFG_SET);
+	if (rc < 0)
+		return rc;
+
+	/* Classifier configurations */
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_RX_PARSE_CONFIG(BASE_PORT(ptp_clock)), 0);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TX_PARSE_CONFIG(BASE_PORT(ptp_clock)), 0);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TX_PARSE_L2_ADDR_EN(BASE_PORT(ptp_clock)),
+			   0);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_RX_PARSE_L2_ADDR_EN(BASE_PORT(ptp_clock)),
+			   0);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_RX_PARSE_IPV4_ADDR_EN(BASE_PORT(ptp_clock)),
+			   0);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TX_PARSE_IPV4_ADDR_EN(BASE_PORT(ptp_clock)),
+			   0);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_RX_VERSION(BASE_PORT(ptp_clock)),
+			   MCHP_PTP_MAX_VERSION(0xff) | MCHP_PTP_MIN_VERSION(0x0));
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TX_VERSION(BASE_PORT(ptp_clock)),
+			   MCHP_PTP_MAX_VERSION(0xff) | MCHP_PTP_MIN_VERSION(0x0));
+	if (rc < 0)
+		return rc;
+
+	/* Enable TSU */
+	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			   MCHP_PTP_TSU_GEN_CONFIG(BASE_PORT(ptp_clock)),
+			   MCHP_PTP_TSU_GEN_CFG_TSU_EN);
+	if (rc < 0)
+		return rc;
+
+	/* Enable PTP */
+	return phy_write_mmd(phydev, PTP_MMD(ptp_clock),
+			     MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
+			     MCHP_PTP_CMD_CTL_EN);
+}
+
+struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev, u8 mmd,
+				      u16 clk_base_addr, u16 port_base_addr)
+{
+	struct mchp_ptp_clock *clock;
+	int rc;
+
+	clock = devm_kzalloc(&phydev->mdio.dev, sizeof(*clock), GFP_KERNEL);
+	if (!clock)
+		return ERR_PTR(-ENOMEM);
+
+	clock->port_base_addr	= port_base_addr;
+	clock->clk_base_addr	= clk_base_addr;
+	clock->mmd		= mmd;
+
+	/* Register PTP clock */
+	clock->caps.owner          = THIS_MODULE;
+	snprintf(clock->caps.name, 30, "%s", phydev->drv->name);
+	clock->caps.max_adj        = MCHP_PTP_MAX_ADJ;
+	clock->caps.n_ext_ts       = 0;
+	clock->caps.pps            = 0;
+	clock->caps.adjfine        = mchp_ptp_ltc_adjfine;
+	clock->caps.adjtime        = mchp_ptp_ltc_adjtime;
+	clock->caps.gettime64      = mchp_ptp_ltc_gettime64;
+	clock->caps.settime64      = mchp_ptp_ltc_settime64;
+	clock->ptp_clock = ptp_clock_register(&clock->caps,
+					      &phydev->mdio.dev);
+	if (IS_ERR(clock->ptp_clock))
+		return ERR_PTR(-EINVAL);
+
+	/* Initialize the SW */
+	skb_queue_head_init(&clock->tx_queue);
+	skb_queue_head_init(&clock->rx_queue);
+	INIT_LIST_HEAD(&clock->rx_ts_list);
+	spin_lock_init(&clock->rx_ts_lock);
+	mutex_init(&clock->ptp_lock);
+
+	clock->mii_ts.rxtstamp = mchp_ptp_rxtstamp;
+	clock->mii_ts.txtstamp = mchp_ptp_txtstamp;
+	clock->mii_ts.hwtstamp = mchp_ptp_hwtstamp;
+	clock->mii_ts.ts_info = mchp_ptp_ts_info;
+
+	phydev->mii_ts = &clock->mii_ts;
+
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
+	clock->phydev = phydev;
+
+	rc = mchp_ptp_init(clock);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	return clock;
+}
+EXPORT_SYMBOL_GPL(mchp_ptp_probe);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MICROCHIP PHY PTP driver");
+MODULE_AUTHOR("Divya Koppera");
-- 
2.17.1


