Return-Path: <netdev+bounces-109540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA855928B36
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE73B22425
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE089176247;
	Fri,  5 Jul 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I14TCJzV"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0718172795;
	Fri,  5 Jul 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191806; cv=none; b=H+WvRHusskbDnMxySz7zbgLUKrtKQGVAVd7oIpOYpmUSgJOtM0W2fi+vb1nTv1xxJn0A4esZqsKYHBLyHWIeqnhY2Q3SylEfg+eA6VcsAz6p6XsJmaqtNuWtg6lzicbjHZxU1OUDwUJ4v6YjbABi1geiRB+wW/UU8QncUujcA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191806; c=relaxed/simple;
	bh=+2WN+NYjSMsgHmGWO4YvJZgrZiundbvft3OZ2kmKeTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmlbQVlA0R/EkYe4uGCeEnIwy9XFXzUmivXGXn8ogdPpI4XFdAccbyx3tfhg0aOq2dejoR3zPWVcavhUoLbkqRZK+3+P1kLOLJs4m7/j7y1IX8MFz7ic3ZLRID6wWV/FZw8TKdPwtUadAT4KOx6/OtsCKx9Ww4W0jpsR0RoF3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I14TCJzV; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D82F9E0010;
	Fri,  5 Jul 2024 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720191802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWebhCTCdNfyJ+pzyOhjRRpJXXGxv764Nn1aO830kCo=;
	b=I14TCJzVy/mAd9+mFF/IjKO8XWOrO4Iy5ZmDsrLNFgxeTUrFQTLLmFz3iLnL3yB+VU69F7
	25LqYA/+1jK5iJ3FqzVdkktklDfrtm+MHGPcqpZGwuV82Cfed0Tz/32bjP6gVZQZzAkXud
	+9iiVSxjj6nC2Z7uof+pnsB4wgcFRrAUtOHZJJwe5egfew06YiwLwH1le9+UEeeFiA5aDc
	IqBTYE0yxZ0Z9DsyTILjC70jXrGGa+x6wAf5gZ8TO9UEd8+pKN6qrZGAzYJ0Thyw7tNVVp
	1hRRwi38CYbf1PK4KF8I65sGGV2i7w8nDbkbaerye5sJEkRlv6pPD8+2G24qQA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 05 Jul 2024 17:03:13 +0200
Subject: [PATCH net-next v16 12/14] net: ethtool: tsinfo: Add support for
 reading tsinfo for a specific hwtstamp provider
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-feature_ptp_netnext-v16-12-5d7153914052@bootlin.com>
References: <20240705-feature_ptp_netnext-v16-0-5d7153914052@bootlin.com>
In-Reply-To: <20240705-feature_ptp_netnext-v16-0-5d7153914052@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Either the MAC or the PHY can provide hwtstamp, so we should be able to
read the tsinfo for any hwtstamp provider.

Enhance 'get' command to retrieve tsinfo of hwtstamp providers within a
network topology.

Add support for a specific dump command to retrieve all hwtstamp
providers within the network topology, with added functionality for
filtered dump to target a single interface.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Pointer attached_dev is used to know if the phy is on the net topology.
This might not be enough and might need Maxime Chevallier link topology
patch series:
https://lore.kernel.org/netdev/20240213150431.1796171-1-maxime.chevallier@bootlin.com/

Change in v8:
- New patch

Change in v9:
- Fix nit in done callback.

Change in v10:
- Add documentation.
- Add extack error messages.
- Add NLA_POLICY_* checks.
- Fix few nits.
- Add ETHTOOL_A_TSINFO_GHWTSTAMP netlink attributes instead of a bit in
  ETHTOOL_A_TSINFO_TIMESTAMPING bitset.
- Add tsinfo_parse_hwtstamp_provider function for more readability.
- Move netdev_support_hwtstamp_qualifier function in core ptp instead of
  core net.
- Add refcount put to release the ptp object.
- Use rcu lock to avoid memory leak.

Change in v12:
- Add missing return description in the kdoc.
- Fix possible leak due to uninitialised variable.
- Add a missing static.

Change in v13:
- Remove useless EXPORT_SYMBOL().
- Fix issues reported by sparse and smatch.
- Fix issues when building PTP as a module.
- Rename HWTSTAMP_PROVIDER_NEST to HWTSTAMP_PROVIDER.

Change in v16:
- Used call_rcu() instead of synchronize_rcu() to free the hwtstamp_provider
  struct.
- Fix documentation typo.
- Fix few nit.
- Fix possible issue regardings stats.
- Remove hwtstamp config get and set from tsinfo.
---
 Documentation/networking/ethtool-netlink.rst |   7 +-
 drivers/ptp/ptp_clock_consumer.c             |  66 ++++++++
 include/linux/ethtool.h                      |   4 +
 include/linux/ptp_clock_kernel.h             |  53 ++++++
 include/uapi/linux/ethtool_netlink.h         |  11 +-
 net/ethtool/common.c                         |  32 ++++
 net/ethtool/common.h                         |   3 +
 net/ethtool/netlink.c                        |   6 +-
 net/ethtool/netlink.h                        |   5 +-
 net/ethtool/ts.h                             |  52 ++++++
 net/ethtool/tsinfo.c                         | 239 ++++++++++++++++++++++++++-
 11 files changed, 464 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index bfe2eda8580d..20429015de03 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1235,9 +1235,10 @@ Gets timestamping information like ``ETHTOOL_GET_TS_INFO`` ioctl request.
 
 Request contents:
 
-  =====================================  ======  ==========================
-  ``ETHTOOL_A_TSINFO_HEADER``            nested  request header
-  =====================================  ======  ==========================
+  ========================================  ======  ============================
+  ``ETHTOOL_A_TSINFO_HEADER``               nested  request header
+  ``ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER``    nested  PTP hw clock provider
+  ========================================  ======  ============================
 
 Kernel response contents:
 
diff --git a/drivers/ptp/ptp_clock_consumer.c b/drivers/ptp/ptp_clock_consumer.c
index f521b07da231..0eec0e910d1a 100644
--- a/drivers/ptp/ptp_clock_consumer.c
+++ b/drivers/ptp/ptp_clock_consumer.c
@@ -114,3 +114,69 @@ int ptp_clock_index(struct ptp_clock *ptp)
 	return ptp->index;
 }
 EXPORT_SYMBOL(ptp_clock_index);
+
+struct ptp_clock *netdev_ptp_clock_find(struct net_device *dev,
+					unsigned long *indexp)
+{
+	struct ptp_clock *ptp;
+	unsigned long index;
+
+	xa_for_each_start(&ptp_clocks_map, index, ptp, *indexp) {
+		if ((ptp->phc_source == HWTSTAMP_SOURCE_NETDEV &&
+		     ptp->netdev == dev) ||
+		    (ptp->phc_source == HWTSTAMP_SOURCE_PHYLIB &&
+		     ptp->phydev->attached_dev == dev)) {
+			*indexp = index;
+			return ptp;
+		}
+	}
+
+	return NULL;
+};
+
+bool
+netdev_support_hwtstamp_qualifier(struct net_device *dev,
+				  enum hwtstamp_provider_qualifier qualifier)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	if (!ops)
+		return false;
+
+	/* Return true with precise qualifier and with NIC without
+	 * qualifier description to not break the old behavior.
+	 */
+	if (!ops->supported_hwtstamp_qualifiers &&
+	    qualifier == HWTSTAMP_PROVIDER_QUALIFIER_PRECISE)
+		return true;
+
+	if (ops->supported_hwtstamp_qualifiers & BIT(qualifier))
+		return true;
+
+	return false;
+}
+
+bool netdev_support_hwtstamp(struct net_device *dev,
+			     struct hwtstamp_provider *hwtstamp)
+{
+	struct ptp_clock *tmp_ptp;
+	unsigned long index = 0;
+
+	netdev_for_each_ptp_clock_start(dev, index, tmp_ptp, 0) {
+		if (tmp_ptp != hwtstamp->ptp)
+			continue;
+
+		if (ptp_clock_from_phylib(hwtstamp->ptp) &&
+		    hwtstamp->qualifier == HWTSTAMP_PROVIDER_QUALIFIER_PRECISE)
+			return true;
+
+		if (ptp_clock_from_netdev(hwtstamp->ptp) &&
+		    netdev_support_hwtstamp_qualifier(dev,
+						      hwtstamp->qualifier))
+			return true;
+
+		return false;
+	}
+
+	return false;
+}
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f9cdd567a4b3..30996f004324 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -719,6 +719,7 @@ struct ethtool_rxfh_param {
  * @cmd: command number = %ETHTOOL_GET_TS_INFO
  * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
  * @phc_index: device index of the associated PHC, or -1 if there is none
+ * @phc_qualifier: qualifier of the associated PHC
  * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
  * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
  */
@@ -726,6 +727,7 @@ struct kernel_ethtool_ts_info {
 	u32 cmd;
 	u32 so_timestamping;
 	int phc_index;
+	enum hwtstamp_provider_qualifier phc_qualifier;
 	enum hwtstamp_tx_types tx_types;
 	enum hwtstamp_rx_filters rx_filters;
 };
@@ -746,6 +748,7 @@ struct kernel_ethtool_ts_info {
  *	argument to @create_rxfh_context and friends.
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
+ * @supported_hwtstamp_qualifiers: bitfield of supported hwtstamp qualifier.
  * @get_drvinfo: Report driver/device information. Modern drivers no
  *	longer have to implement this callback. Most fields are
  *	correctly filled in by the core using system information, or
@@ -959,6 +962,7 @@ struct ethtool_ops {
 	u32	rxfh_max_context_id;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
+	u32	supported_hwtstamp_qualifiers;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
 	int	(*get_regs_len)(struct net_device *);
 	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6d9e6cd5c832..a8babc15f5b3 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -450,6 +450,45 @@ void ptp_clock_put(struct device *dev, struct ptp_clock *ptp);
 
 void remove_hwtstamp_provider(struct rcu_head *rcu_head);
 
+/**
+ * netdev_ptp_clock_find() - obtain the next PTP clock in the netdev
+ *			     topology
+ *
+ * @dev:    Pointer of the net device.
+ * @indexp:  Pointer of ptp clock index start point.
+ *
+ * Return: Pointer of the PTP clock found, NULL otherwise.
+ */
+
+struct ptp_clock *netdev_ptp_clock_find(struct net_device *dev,
+					unsigned long *indexp);
+
+/**
+ * netdev_support_hwtstamp_qualifier() - Verify if the net device support the
+ *					 hwtstamp qualifier
+ *
+ * @dev:        Pointer of the net device.
+ * @qualifier:  hwtstamp provider qualifier.
+ *
+ * Return: True if the net device support the htstamp qualifier false otherwise.
+ */
+
+bool netdev_support_hwtstamp_qualifier(struct net_device *dev,
+				       enum hwtstamp_provider_qualifier qualifier);
+
+/**
+ * netdev_support_hwtstamp() - Verify if the hwtstamp belong to the netdev
+ *			       topology
+ *
+ * @dev:       Pointer of the net device
+ * @hwtstamp:  Pointer of the hwtstamp provider
+ *
+ * Return: True if the hwtstamp belong to the netdev topology false otherwise.
+ */
+
+bool netdev_support_hwtstamp(struct net_device *dev,
+			     struct hwtstamp_provider *hwtstamp);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -538,6 +577,16 @@ static inline void ptp_clock_put(struct device *dev, struct ptp_clock *ptp)
 static inline struct ptp_clock *ptp_clock_get_by_index(struct device *dev,
 						       int index)
 { return NULL; }
+static inline struct ptp_clock *netdev_ptp_clock_find(struct net_device *dev,
+						      unsigned long *indexp)
+{ return NULL; }
+static inline bool
+netdev_support_hwtstamp_qualifier(struct net_device *dev,
+				  enum hwtstamp_provider_qualifier qualifier)
+{ return false; }
+static inline bool netdev_support_hwtstamp(struct net_device *dev,
+					   struct hwtstamp_provider *hwtst)
+{ return false; }
 static inline void remove_hwtstamp_provider(struct rcu_head *rcu_head)
 { return; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
@@ -554,6 +603,10 @@ static inline void ptp_cancel_worker_sync(struct ptp_clock *ptp)
 { }
 #endif
 
+#define netdev_for_each_ptp_clock_start(dev, index, entry, start) \
+	for (index = start, entry = netdev_ptp_clock_find(dev, &index); \
+	     entry; index++, entry = netdev_ptp_clock_find(dev, &index))
+
 #if IS_BUILTIN(CONFIG_PTP_1588_CLOCK)
 /*
  * These are called by the network core, and don't work if PTP is in
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 840dabdc9d88..b72f53dcca56 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -492,8 +492,16 @@ enum {
 	ETHTOOL_A_EEE_MAX = (__ETHTOOL_A_EEE_CNT - 1)
 };
 
-/* TSINFO */
+enum {
+	ETHTOOL_A_TS_HWTSTAMP_PROVIDER_UNSPEC,
+	ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX,		/* u32 */
+	ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER,	/* u32 */
 
+	__ETHTOOL_A_TS_HWTSTAMP_PROVIDER_CNT,
+	ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX = (__ETHTOOL_A_TS_HWTSTAMP_PROVIDER_CNT - 1)
+};
+
+/* TSINFO */
 enum {
 	ETHTOOL_A_TSINFO_UNSPEC,
 	ETHTOOL_A_TSINFO_HEADER,			/* nest - _A_HEADER_* */
@@ -502,6 +510,7 @@ enum {
 	ETHTOOL_A_TSINFO_RX_FILTERS,			/* bitset */
 	ETHTOOL_A_TSINFO_PHC_INDEX,			/* u32 */
 	ETHTOOL_A_TSINFO_STATS,				/* nest - _A_TSINFO_STAT */
+	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,		/* nest - *_TS_HWTSTAMP_PROVIDER_* */
 
 	/* add new constants above here */
 	__ETHTOOL_A_TSINFO_CNT,
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 461017a37955..532332e708fb 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -629,10 +629,42 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
 	return 0;
 }
 
+int ethtool_get_ts_info_by_phc(struct net_device *dev,
+			       struct kernel_ethtool_ts_info *info,
+			       struct hwtstamp_provider *hwtstamp)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	memset(info, 0, sizeof(*info));
+	info->cmd = ETHTOOL_GET_TS_INFO;
+	info->phc_qualifier = hwtstamp->qualifier;
+
+	if (!netdev_support_hwtstamp(dev, hwtstamp))
+		return -ENODEV;
+
+	if (ptp_clock_from_phylib(hwtstamp->ptp) &&
+	    phy_has_tsinfo(ptp_clock_phydev(hwtstamp->ptp)))
+		return phy_ts_info(ptp_clock_phydev(hwtstamp->ptp), info);
+
+	if (ptp_clock_from_netdev(hwtstamp->ptp) && ops->get_ts_info)
+		return ops->get_ts_info(dev, info);
+
+	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_SOFTWARE;
+	info->phc_index = -1;
+
+	return 0;
+}
+
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
+	struct hwtstamp_provider *hwtstamp;
+
+	hwtstamp = rtnl_dereference(dev->hwtstamp);
+	if (hwtstamp)
+		return ethtool_get_ts_info_by_phc(dev, info, hwtstamp);
 
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index b9daeecbd84d..83bf82a4e75a 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -45,6 +45,9 @@ bool convert_legacy_settings_to_link_ksettings(
 int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max);
 int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max);
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
+int ethtool_get_ts_info_by_phc(struct net_device *dev,
+			       struct kernel_ethtool_ts_info *info,
+			       struct hwtstamp_provider *hwtst);
 
 extern const struct ethtool_phy_ops *ethtool_phy_ops;
 extern const struct ethtool_pse_ops *ethtool_pse_ops;
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 81fe2e5b95f6..1c32eea1a751 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1021,9 +1021,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_TSINFO_GET,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_default_start,
-		.dumpit	= ethnl_default_dumpit,
-		.done	= ethnl_default_done,
+		.start	= ethnl_tsinfo_start,
+		.dumpit	= ethnl_tsinfo_dumpit,
+		.done	= ethnl_tsinfo_done,
 		.policy = ethnl_tsinfo_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_tsinfo_get_policy) - 1,
 	},
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 46ec273a87c5..0ebe42dc1bf0 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -436,7 +436,7 @@ extern const struct nla_policy ethnl_pause_get_policy[ETHTOOL_A_PAUSE_STATS_SRC
 extern const struct nla_policy ethnl_pause_set_policy[ETHTOOL_A_PAUSE_TX + 1];
 extern const struct nla_policy ethnl_eee_get_policy[ETHTOOL_A_EEE_HEADER + 1];
 extern const struct nla_policy ethnl_eee_set_policy[ETHTOOL_A_EEE_TX_LPI_TIMER + 1];
-extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_HEADER + 1];
+extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1];
 extern const struct nla_policy ethnl_cable_test_act_policy[ETHTOOL_A_CABLE_TEST_HEADER + 1];
 extern const struct nla_policy ethnl_cable_test_tdr_act_policy[ETHTOOL_A_CABLE_TEST_TDR_CFG + 1];
 extern const struct nla_policy ethnl_tunnel_info_get_policy[ETHTOOL_A_TUNNEL_INFO_HEADER + 1];
@@ -464,6 +464,9 @@ int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_start(struct netlink_callback *cb);
 int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info);
+int ethnl_tsinfo_start(struct netlink_callback *cb);
+int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_tsinfo_done(struct netlink_callback *cb);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/ts.h b/net/ethtool/ts.h
new file mode 100644
index 000000000000..1fb7b6d9d99a
--- /dev/null
+++ b/net/ethtool/ts.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _NET_ETHTOOL_TS_H
+#define _NET_ETHTOOL_TS_H
+
+#include "netlink.h"
+
+struct hwtst_provider {
+	int index;
+	u32 qualifier;
+};
+
+static const struct nla_policy
+ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {
+	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
+		NLA_POLICY_MIN(NLA_S32, 0),
+	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER] =
+		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
+};
+
+static inline int ts_parse_hwtst_provider(const struct nlattr *nest,
+					  struct hwtst_provider *hwtst,
+					  struct netlink_ext_ack *extack,
+					  bool *mod)
+{
+	struct nlattr *tb[ARRAY_SIZE(ethnl_ts_hwtst_prov_policy)];
+	int ret;
+
+	ret = nla_parse_nested(tb,
+			       ARRAY_SIZE(ethnl_ts_hwtst_prov_policy) - 1,
+			       nest,
+			       ethnl_ts_hwtst_prov_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, nest, tb,
+			      ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX) ||
+	    NL_REQ_ATTR_CHECK(extack, nest, tb,
+			      ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER))
+		return -EINVAL;
+
+	ethnl_update_u32(&hwtst->index,
+			 tb[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX],
+			 mod);
+	ethnl_update_u32(&hwtst->qualifier,
+			 tb[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER],
+			 mod);
+
+	return 0;
+}
+
+#endif /* _NET_ETHTOOL_TS_H */
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 03d12d6f79ca..1ff992fcaf6a 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -1,13 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
 
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
+#include "ts.h"
 
 struct tsinfo_req_info {
 	struct ethnl_req_info		base;
+	struct hwtst_provider		hwtst;
 };
 
 struct tsinfo_reply_data {
@@ -16,35 +19,76 @@ struct tsinfo_reply_data {
 	struct ethtool_ts_stats		stats;
 };
 
+#define TSINFO_REQINFO(__req_base) \
+	container_of(__req_base, struct tsinfo_req_info, base)
+
 #define TSINFO_REPDATA(__reply_base) \
 	container_of(__reply_base, struct tsinfo_reply_data, base)
 
 #define ETHTOOL_TS_STAT_CNT \
 	(__ETHTOOL_A_TS_STAT_CNT - (ETHTOOL_A_TS_STAT_UNSPEC + 1))
 
-const struct nla_policy ethnl_tsinfo_get_policy[] = {
+const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
 	[ETHTOOL_A_TSINFO_HEADER]		=
 		NLA_POLICY_NESTED(ethnl_header_policy_stats),
+	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER] =
+		NLA_POLICY_NESTED(ethnl_ts_hwtst_prov_policy),
 };
 
+static int
+tsinfo_parse_request(struct ethnl_req_info *req_base, struct nlattr **tb,
+		     struct netlink_ext_ack *extack)
+{
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
+	bool mod = false;
+
+	req->hwtst.index = -1;
+
+	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER])
+		return 0;
+
+	return ts_parse_hwtst_provider(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER],
+				       &req->hwtst, extack, &mod);
+}
+
 static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
 			       struct ethnl_reply_data *reply_base,
 			       const struct genl_info *info)
 {
 	struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
 	struct net_device *dev = reply_base->dev;
 	int ret;
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
+
 	if (req_base->flags & ETHTOOL_FLAG_STATS) {
 		ethtool_stats_init((u64 *)&data->stats,
 				   sizeof(data->stats) / sizeof(u64));
 		if (dev->ethtool_ops->get_ts_stats)
 			dev->ethtool_ops->get_ts_stats(dev, &data->stats);
 	}
-	ret = __ethtool_get_ts_info(dev, &data->ts_info);
+
+	if (req->hwtst.index != -1) {
+		struct hwtstamp_provider hwtstamp;
+
+		hwtstamp.ptp = ptp_clock_get_by_index(&dev->dev, req->hwtst.index);
+		if (!hwtstamp.ptp) {
+			ret = -ENODEV;
+			goto out;
+		}
+		hwtstamp.qualifier = req->hwtst.qualifier;
+
+		ret = ethtool_get_ts_info_by_phc(dev, &data->ts_info,
+						 &hwtstamp);
+		ptp_clock_put(&dev->dev, hwtstamp.ptp);
+	} else {
+		ret = __ethtool_get_ts_info(dev, &data->ts_info);
+	}
+
+out:
 	ethnl_ops_complete(dev);
 
 	return ret;
@@ -87,8 +131,11 @@ static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
 			return ret;
 		len += ret;	/* _TSINFO_RX_FILTERS */
 	}
-	if (ts_info->phc_index >= 0)
+	if (ts_info->phc_index >= 0) {
+		/* _TSINFO_HWTSTAMP_PROVIDER */
+		len += 2 * nla_total_size(sizeof(u32));
 		len += nla_total_size(sizeof(u32));	/* _TSINFO_PHC_INDEX */
+	}
 	if (req_base->flags & ETHTOOL_FLAG_STATS)
 		len += nla_total_size(0) + /* _TSINFO_STATS */
 		       nla_total_size_64bit(sizeof(u64)) * ETHTOOL_TS_STAT_CNT;
@@ -163,9 +210,29 @@ static int tsinfo_fill_reply(struct sk_buff *skb,
 		if (ret < 0)
 			return ret;
 	}
-	if (ts_info->phc_index >= 0 &&
-	    nla_put_u32(skb, ETHTOOL_A_TSINFO_PHC_INDEX, ts_info->phc_index))
-		return -EMSGSIZE;
+	if (ts_info->phc_index >= 0) {
+		struct nlattr *nest;
+
+		ret = nla_put_u32(skb, ETHTOOL_A_TSINFO_PHC_INDEX,
+				  ts_info->phc_index);
+		if (ret)
+			return -EMSGSIZE;
+
+		nest = nla_nest_start(skb, ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER);
+		if (!nest)
+			return -EMSGSIZE;
+
+		if (nla_put_u32(skb, ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX,
+				ts_info->phc_index) ||
+		    nla_put_u32(skb,
+				ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER,
+				ts_info->phc_qualifier)) {
+			nla_nest_cancel(skb, nest);
+			return -EMSGSIZE;
+		}
+
+		nla_nest_end(skb, nest);
+	}
 	if (req_base->flags & ETHTOOL_FLAG_STATS &&
 	    tsinfo_put_stats(skb, &data->stats))
 		return -EMSGSIZE;
@@ -173,6 +240,165 @@ static int tsinfo_fill_reply(struct sk_buff *skb,
 	return 0;
 }
 
+struct ethnl_tsinfo_dump_ctx {
+	struct tsinfo_req_info		*req_info;
+	struct tsinfo_reply_data	*reply_data;
+	unsigned long			pos_ifindex;
+	unsigned long			pos_phcindex;
+	enum hwtstamp_provider_qualifier pos_phcqualifier;
+};
+
+static int ethnl_tsinfo_dump_one_ptp(struct sk_buff *skb, struct net_device *dev,
+				     struct netlink_callback *cb,
+				     struct ptp_clock *ptp)
+{
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct tsinfo_reply_data *reply_data;
+	struct tsinfo_req_info *req_info;
+	void *ehdr = NULL;
+	int ret = 0;
+
+	reply_data = ctx->reply_data;
+	req_info = ctx->req_info;
+	req_info->hwtst.index = ptp_clock_index(ptp);
+
+	for (; ctx->pos_phcqualifier < HWTSTAMP_PROVIDER_QUALIFIER_CNT;
+	     ctx->pos_phcqualifier++) {
+		if (!netdev_support_hwtstamp_qualifier(dev,
+						       ctx->pos_phcqualifier))
+			continue;
+
+		ehdr = ethnl_dump_put(skb, cb,
+				      ETHTOOL_MSG_TSINFO_GET_REPLY);
+		if (!ehdr)
+			return -EMSGSIZE;
+
+		memset(reply_data, 0, sizeof(*reply_data));
+		reply_data->base.dev = dev;
+		req_info->hwtst.qualifier = ctx->pos_phcqualifier;
+		ret = tsinfo_prepare_data(&req_info->base,
+					  &reply_data->base,
+					  genl_info_dump(cb));
+		if (ret < 0)
+			break;
+
+		ret = ethnl_fill_reply_header(skb, dev,
+					      ETHTOOL_A_TSINFO_HEADER);
+		if (ret < 0)
+			break;
+
+		ret = tsinfo_fill_reply(skb, &req_info->base,
+					&reply_data->base);
+		if (ret < 0)
+			break;
+	}
+
+	reply_data->base.dev = NULL;
+	if (!ret && ehdr)
+		genlmsg_end(skb, ehdr);
+	else
+		genlmsg_cancel(skb, ehdr);
+	return ret;
+}
+
+static int ethnl_tsinfo_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
+				     struct netlink_callback *cb)
+{
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct ptp_clock *ptp;
+	int ret = 0;
+
+	netdev_for_each_ptp_clock_start(dev, ctx->pos_phcindex, ptp,
+					ctx->pos_phcindex) {
+		ret = ethnl_tsinfo_dump_one_ptp(skb, dev, cb, ptp);
+		if (ret < 0 && ret != -EOPNOTSUPP)
+			break;
+		ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
+	}
+
+	return ret;
+}
+
+int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
+	int ret = 0;
+
+	rtnl_lock();
+	if (ctx->req_info->base.dev) {
+		ret = ethnl_tsinfo_dump_one_dev(skb,
+						ctx->req_info->base.dev,
+						cb);
+	} else {
+		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
+			ret = ethnl_tsinfo_dump_one_dev(skb, dev, cb);
+			if (ret < 0 && ret != -EOPNOTSUPP)
+				break;
+			ctx->pos_phcindex = 0;
+		}
+	}
+	rtnl_unlock();
+
+	return ret;
+}
+
+int ethnl_tsinfo_start(struct netlink_callback *cb)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct nlattr **tb = info->info.attrs;
+	struct tsinfo_reply_data *reply_data;
+	struct tsinfo_req_info *req_info;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
+
+	req_info = kzalloc(sizeof(*req_info), GFP_KERNEL);
+	if (!req_info)
+		return -ENOMEM;
+	reply_data = kzalloc(sizeof(*reply_data), GFP_KERNEL);
+	if (!reply_data) {
+		ret = -ENOMEM;
+		goto free_req_info;
+	}
+
+	ret = ethnl_parse_header_dev_get(&req_info->base,
+					 tb[ETHTOOL_A_TSINFO_HEADER],
+					 sock_net(cb->skb->sk), cb->extack,
+					 false);
+	if (ret < 0)
+		goto free_reply_data;
+
+	ctx->req_info = req_info;
+	ctx->reply_data = reply_data;
+	ctx->pos_ifindex = 0;
+	ctx->pos_phcindex = 0;
+	ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
+
+	return 0;
+
+free_reply_data:
+	kfree(reply_data);
+free_req_info:
+	kfree(req_info);
+
+	return ret;
+}
+
+int ethnl_tsinfo_done(struct netlink_callback *cb)
+{
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct tsinfo_req_info *req_info = ctx->req_info;
+
+	ethnl_parse_header_dev_put(&req_info->base);
+	kfree(ctx->reply_data);
+	kfree(ctx->req_info);
+
+	return 0;
+}
+
 const struct ethnl_request_ops ethnl_tsinfo_request_ops = {
 	.request_cmd		= ETHTOOL_MSG_TSINFO_GET,
 	.reply_cmd		= ETHTOOL_MSG_TSINFO_GET_REPLY,
@@ -180,6 +406,7 @@ const struct ethnl_request_ops ethnl_tsinfo_request_ops = {
 	.req_info_size		= sizeof(struct tsinfo_req_info),
 	.reply_data_size	= sizeof(struct tsinfo_reply_data),
 
+	.parse_request		= tsinfo_parse_request,
 	.prepare_data		= tsinfo_prepare_data,
 	.reply_size		= tsinfo_reply_size,
 	.fill_reply		= tsinfo_fill_reply,

-- 
2.34.1


