Return-Path: <netdev+bounces-110299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F292BC35
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3677A284372
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5519306B;
	Tue,  9 Jul 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ArjbLI/Z"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349321922F5;
	Tue,  9 Jul 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533261; cv=none; b=b6CoqAiS+cKAK6vFGWyvfjaEAjzvVIWy8Se4oKDUucHo8M6wEwlJIUt0FTOC0bw2IOfbbEVIsLz0YyZiCTGv8utFa+oqPJ3gCG8QLiHcym+onqyPAJiW3agPmP6DukO7ccZcEqnh1YzIbPScQnEWXRv13YugnmNJZCev23ebCj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533261; c=relaxed/simple;
	bh=3+XUNWh2AW5tZFUNi9W7fbXfPNbA7vs2P1gWcAuiTpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pc7JeogILGs8O/GSEXh/cSWnbKAplv4/SWJPTX8nzwfiN2cp1Om5jjRSPDGlDuPED0F6a6gh7hqjJnq2ls1rn/8y5P+WjE5ARGwGIyBYMnmoDuwgLrs3jEJ/PXHd2ovcfa4AV0Vv7UPSw2paQJ3YdKE9vjPQI7XwGPsoXXfckbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ArjbLI/Z; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EF631BF212;
	Tue,  9 Jul 2024 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720533255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP9FyYixOVfRTgzC/rozjzLUSXeYfkj9qDgUTvvD02U=;
	b=ArjbLI/ZObGfaQ4xG7L3yU4hx+pDAsrFxo5nxEO9PwsBsVk46d3XhcliR7Q72+qy9eIaRO
	GvyYadPHRE/D1Klb+WUnCC5p8CXWuFZSEL9PgXgVW/Vxp/DghSIAhDgokQWfG8GRfA5rK9
	Ppu0TtN2ckZaa3/hCJzggwXE7/K9gCCUXaZk53BWO4m64WYcUmMQZLlvzcu4Odb+WDcHXz
	+UDyZOSWoKyDwHBdZp2qrt/VM2jQQC6+6i1q0mnKCv1Fc/Ib2xxpvxMHOFCtinKV9sAvha
	QTx1BOd8c5GY12UPUQeDHD/0Jly0h2b7SpZk+u2ymkJGPRCTQ4Yy4AGKdJscOA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Jul 2024 15:53:45 +0200
Subject: [PATCH net-next v17 13/14] net: ethtool: Add support for tsconfig
 command to get/set hwtstamp config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-feature_ptp_netnext-v17-13-b5317f50df2a@bootlin.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
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
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Introduce support for ETHTOOL_MSG_TSCONFIG_GET/SET ethtool netlink socket
to read and configure hwtstamp configuration of a PHC provider. Note that
simultaneous hwtstamp isn't supported; configuring a new one disables the
previous setting.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v16:
- Add a new patch to separate tsinfo into a new tsconfig command to get
  and set the hwtstamp config.

Changes in v17:
- Fix a doc misalignment.
---
 Documentation/networking/timestamping.rst |  33 +--
 include/uapi/linux/ethtool_netlink.h      |  18 ++
 net/ethtool/Makefile                      |   3 +-
 net/ethtool/netlink.c                     |  20 ++
 net/ethtool/netlink.h                     |   3 +
 net/ethtool/tsconfig.c                    | 347 ++++++++++++++++++++++++++++++
 6 files changed, 411 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..fccf8656adba 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -493,8 +493,8 @@ implicitly defined. ts[0] holds a software timestamp if set, ts[1]
 is again deprecated and ts[2] holds a hardware timestamp if set.
 
 
-3. Hardware Timestamping configuration: SIOCSHWTSTAMP and SIOCGHWTSTAMP
-=======================================================================
+3. Hardware Timestamping configuration: ETHTOOL_MSG_TSCONFIG_SET/GET
+====================================================================
 
 Hardware time stamping must also be initialized for each device driver
 that is expected to do hardware time stamping. The parameter is defined in
@@ -507,10 +507,15 @@ include/uapi/linux/net_tstamp.h as::
 	};
 
 Desired behavior is passed into the kernel and to a specific device by
-calling ioctl(SIOCSHWTSTAMP) with a pointer to a struct ifreq whose
-ifr_data points to a struct hwtstamp_config. The tx_type and
-rx_filter are hints to the driver what it is expected to do. If
-the requested fine-grained filtering for incoming packets is not
+calling the tsconfig netlink socket ETHTOOL_MSG_TSCONFIG_SET.
+The ``ETHTOOL_A_TSCONFIG_TX_TYPES``, ``ETHTOOL_A_TSCONFIG_RX_FILTERS`` and
+``ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS`` netlink attributes are then used to set
+the struct hwtstamp_config accordingly.
+
+The legacy configuration is the use of the ioctl(SIOCSHWTSTAMP) with a pointer
+to a struct ifreq whose ifr_data points to a struct hwtstamp_config.
+The tx_type and rx_filter are hints to the driver what it is expected to do.
+If the requested fine-grained filtering for incoming packets is not
 supported, the driver may time stamp more than just the requested types
 of packets.
 
@@ -531,9 +536,12 @@ Only a processes with admin rights may change the configuration. User
 space is responsible to ensure that multiple processes don't interfere
 with each other and that the settings are reset.
 
-Any process can read the actual configuration by passing this
-structure to ioctl(SIOCGHWTSTAMP) in the same way.  However, this has
-not been implemented in all drivers.
+Any process can read the actual configuration by requesting tsconfig netlink
+socket ETHTOOL_MSG_TSCONFIG_GET.
+
+The legacy usage is to pass this structure to ioctl(SIOCGHWTSTAMP) in the
+same way as the ioctl(SIOCSHWTSTAMP).  However, this has not been implemented
+in all drivers.
 
 ::
 
@@ -578,9 +586,10 @@ not been implemented in all drivers.
 --------------------------------------------------------
 
 A driver which supports hardware time stamping must support the
-SIOCSHWTSTAMP ioctl and update the supplied struct hwtstamp_config with
-the actual values as described in the section on SIOCSHWTSTAMP.  It
-should also support SIOCGHWTSTAMP.
+ndo_hwtstamp_set NDO or the legacy SIOCSHWTSTAMP ioctl and update the
+supplied struct hwtstamp_config with the actual values as described in
+the section on SIOCSHWTSTAMP. It should also support ndo_hwtstamp_get or
+the legacy SIOCGHWTSTAMP.
 
 Time stamps for received packets must be stored in the skb. To get a pointer
 to the shared time stamp structure of the skb call skb_hwtstamps(). Then
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 0660e5a58b34..b2b04c0c9535 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -58,6 +58,8 @@ enum {
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
 	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
+	ETHTOOL_MSG_TSCONFIG_GET,
+	ETHTOOL_MSG_TSCONFIG_SET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -111,6 +113,8 @@ enum {
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
 	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
+	ETHTOOL_MSG_TSCONFIG_GET_REPLY,
+	ETHTOOL_MSG_TSCONFIG_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -530,6 +534,20 @@ enum {
 
 };
 
+/* TSCONFIG */
+enum {
+	ETHTOOL_A_TSCONFIG_UNSPEC,
+	ETHTOOL_A_TSCONFIG_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER,		/* nest - *_TS_HWTSTAMP_PROVIDER_* */
+	ETHTOOL_A_TSCONFIG_TX_TYPES,			/* bitset */
+	ETHTOOL_A_TSCONFIG_RX_FILTERS,			/* bitset */
+	ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS,		/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TSCONFIG_CNT,
+	ETHTOOL_A_TSCONFIG_MAX = (__ETHTOOL_A_TSCONFIG_CNT - 1)
+};
+
 /* PHC VCLOCKS */
 
 enum {
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 9a190635fe95..9b6d86b10c58 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,5 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o
+		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
+		   tsconfig.o
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 8ebc9afdb245..f9a9cceaf01d 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -341,6 +341,8 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_TSCONFIG_GET]	= &ethnl_tsconfig_request_ops,
+	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -670,6 +672,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= &ethnl_module_request_ops,
 	[ETHTOOL_MSG_PLCA_NTF]		= &ethnl_plca_cfg_request_ops,
 	[ETHTOOL_MSG_MM_NTF]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_TSCONFIG_NTF]	= &ethnl_tsconfig_request_ops,
 };
 
 /* default notification handler */
@@ -768,6 +771,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= ethnl_default_notify,
 	[ETHTOOL_MSG_PLCA_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
+	[ETHTOOL_MSG_TSCONFIG_NTF]	= ethnl_default_notify,
 };
 
 void ethtool_notify(struct net_device *dev, unsigned int cmd, const void *data)
@@ -1179,6 +1183,22 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy	= ethnl_module_fw_flash_act_policy,
 		.maxattr = ARRAY_SIZE(ethnl_module_fw_flash_act_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_TSCONFIG_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
+		.policy = ethnl_tsconfig_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_tsconfig_get_policy) - 1,
+	},
+	{
+		.cmd	= ETHTOOL_MSG_TSCONFIG_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_default_set_doit,
+		.policy = ethnl_tsconfig_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_tsconfig_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 0ebe42dc1bf0..a616f5deff7f 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -409,6 +409,7 @@ extern const struct ethnl_request_ops ethnl_rss_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
+extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -456,6 +457,8 @@ extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADE
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
 extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD + 1];
+extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
+extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
new file mode 100644
index 000000000000..518ee9e420f5
--- /dev/null
+++ b/net/ethtool/tsconfig.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
+
+#include "netlink.h"
+#include "common.h"
+#include "bitset.h"
+#include "../core/dev.h"
+#include "ts.h"
+
+struct tsconfig_req_info {
+	struct ethnl_req_info base;
+};
+
+struct tsconfig_reply_data {
+	struct ethnl_reply_data		base;
+	struct hwtst_provider		hwtst;
+	struct {
+		u32 tx_type;
+		u32 rx_filter;
+		u32 flags;
+	} hwtst_config;
+};
+
+#define TSCONFIG_REPDATA(__reply_base) \
+	container_of(__reply_base, struct tsconfig_reply_data, base)
+
+const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1] = {
+	[ETHTOOL_A_TSCONFIG_HEADER]		=
+		NLA_POLICY_NESTED(ethnl_header_policy),
+};
+
+static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
+				 struct ethnl_reply_data *reply_base,
+				 const struct genl_info *info)
+{
+	struct tsconfig_reply_data *data = TSCONFIG_REPDATA(reply_base);
+	struct hwtstamp_provider *hwtstamp = NULL;
+	struct net_device *dev = reply_base->dev;
+	struct kernel_hwtstamp_config cfg = {};
+	int ret;
+
+	if (!dev->netdev_ops->ndo_hwtstamp_get)
+		return -EOPNOTSUPP;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = dev_get_hwtstamp_phylib(dev, &cfg);
+	if (ret)
+		goto out;
+
+	data->hwtst_config.tx_type = BIT(cfg.tx_type);
+	data->hwtst_config.rx_filter = BIT(cfg.rx_filter);
+	data->hwtst_config.flags = BIT(cfg.flags);
+
+	data->hwtst.index = -1;
+	hwtstamp = rtnl_dereference(dev->hwtstamp);
+	if (hwtstamp) {
+		data->hwtst.index = ptp_clock_index(hwtstamp->ptp);
+		data->hwtst.qualifier = hwtstamp->qualifier;
+	}
+
+out:
+	ethnl_ops_complete(dev);
+	return ret;
+}
+
+static int tsconfig_reply_size(const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	const struct tsconfig_reply_data *data = TSCONFIG_REPDATA(reply_base);
+	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	int len = 0;
+	int ret;
+
+	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+
+	if (data->hwtst_config.flags)
+		/* _TSCONFIG_HWTSTAMP_FLAGS */
+		len += nla_total_size(sizeof(u32));
+
+	if (data->hwtst_config.tx_type) {
+		ret = ethnl_bitset32_size(&data->hwtst_config.tx_type,
+					  NULL, __HWTSTAMP_TX_CNT,
+					  ts_tx_type_names, compact);
+		if (ret < 0)
+			return ret;
+		len += ret;	/* _TSCONFIG_TX_TYPES */
+	}
+	if (data->hwtst_config.rx_filter) {
+		ret = ethnl_bitset32_size(&data->hwtst_config.rx_filter,
+					  NULL, __HWTSTAMP_FILTER_CNT,
+					  ts_rx_filter_names, compact);
+		if (ret < 0)
+			return ret;
+		len += ret;	/* _TSCONFIG_RX_FILTERS */
+	}
+
+	if (data->hwtst.index >= 0)
+		/* _TSINFO_HWTSTAMP_PROVIDER */
+		len += 2 * nla_total_size(sizeof(u32));
+
+	return len;
+}
+
+static int tsconfig_fill_reply(struct sk_buff *skb,
+			       const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	const struct tsconfig_reply_data *data = TSCONFIG_REPDATA(reply_base);
+	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	int ret;
+
+	if (data->hwtst_config.flags) {
+		ret = nla_put_u32(skb, ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS,
+				  data->hwtst_config.flags);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (data->hwtst_config.tx_type) {
+		ret = ethnl_put_bitset32(skb, ETHTOOL_A_TSCONFIG_TX_TYPES,
+					 &data->hwtst_config.tx_type, NULL,
+					 __HWTSTAMP_TX_CNT,
+					 ts_tx_type_names, compact);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (data->hwtst_config.rx_filter) {
+		ret = ethnl_put_bitset32(skb, ETHTOOL_A_TSCONFIG_RX_FILTERS,
+					 &data->hwtst_config.rx_filter,
+					 NULL, __HWTSTAMP_FILTER_CNT,
+					 ts_rx_filter_names, compact);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (data->hwtst.index >= 0) {
+		struct nlattr *nest;
+
+		nest = nla_nest_start(skb, ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER);
+		if (!nest)
+			return -EMSGSIZE;
+
+		if (nla_put_u32(skb, ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX,
+				data->hwtst.index) ||
+		    nla_put_u32(skb,
+				ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER,
+				data->hwtst.qualifier)) {
+			nla_nest_cancel(skb, nest);
+			return -EMSGSIZE;
+		}
+
+		nla_nest_end(skb, nest);
+	}
+	return 0;
+}
+
+/* TSCONFIG_SET */
+const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1] = {
+	[ETHTOOL_A_TSCONFIG_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER] = { .type = NLA_NESTED },
+	[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS] = { .type = NLA_U32 },
+	[ETHTOOL_A_TSCONFIG_RX_FILTERS] = { .type = NLA_NESTED },
+	[ETHTOOL_A_TSCONFIG_TX_TYPES] = { .type = NLA_NESTED },
+};
+
+static int ethnl_set_tsconfig_validate(struct ethnl_req_info *req_base,
+				       struct genl_info *info)
+{
+	const struct net_device_ops *ops = req_base->dev->netdev_ops;
+
+	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
+		return -EOPNOTSUPP;
+
+	return 1;
+}
+
+static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
+			      struct genl_info *info)
+{
+	unsigned long mask = 0, req_rx_filter, req_tx_type;
+	struct kernel_hwtstamp_config hwtst_config = {0};
+	struct hwtstamp_provider *hwtstamp = NULL;
+	struct net_device *dev = req_base->dev;
+	struct nlattr **tb = info->attrs;
+	bool mod = false;
+	int ret;
+
+	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
+	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER]) {
+		struct hwtst_provider __hwtst = {.index = -1};
+		struct hwtstamp_provider *__hwtstamp;
+
+		__hwtstamp = rtnl_dereference(dev->hwtstamp);
+		if (__hwtstamp) {
+			__hwtst.index = ptp_clock_index(__hwtstamp->ptp);
+			__hwtst.qualifier = __hwtstamp->qualifier;
+		}
+
+		ret = ts_parse_hwtst_provider(tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER],
+					      &__hwtst, info->extack,
+					      &mod);
+		if (ret < 0)
+			return ret;
+
+		if (mod) {
+			hwtstamp = devm_kzalloc(&dev->dev, sizeof(*hwtstamp),
+						GFP_KERNEL);
+			if (!hwtstamp)
+				return -ENOMEM;
+
+			hwtstamp->ptp = ptp_clock_get_by_index(&dev->dev,
+							       __hwtst.index);
+			if (!hwtstamp->ptp) {
+				NL_SET_ERR_MSG_ATTR(info->extack,
+						    tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER],
+						    "no phc at such index");
+				ret = -ENODEV;
+				goto err_free_hwtstamp;
+			}
+			hwtstamp->qualifier = __hwtst.qualifier;
+			hwtstamp->dev = &dev->dev;
+
+			/* Does the hwtstamp supported in the netdev topology */
+			if (!netdev_support_hwtstamp(dev, hwtstamp)) {
+				NL_SET_ERR_MSG_ATTR(info->extack,
+						    tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER],
+						    "phc not in this net device topology");
+				ret = -ENODEV;
+				goto err_clock_put;
+			}
+		}
+	}
+
+	/* Get current hwtstamp config if we are not changing the hwtstamp
+	 * source
+	 */
+	if (!mod) {
+		ret = dev_get_hwtstamp_phylib(dev, &hwtst_config);
+		if (ret < 0 && ret != -EOPNOTSUPP)
+			goto err_clock_put;
+	}
+
+	/* Get the hwtstamp config from netlink */
+	if (tb[ETHTOOL_A_TSCONFIG_TX_TYPES]) {
+		ret = ethnl_parse_bitset(&req_tx_type, &mask,
+					 __HWTSTAMP_TX_CNT,
+					 tb[ETHTOOL_A_TSCONFIG_TX_TYPES],
+					 ts_tx_type_names, info->extack);
+		if (ret < 0)
+			goto err_clock_put;
+
+		/* Select only one tx type at a time */
+		if (ffs(req_tx_type) != fls(req_tx_type)) {
+			ret = -EINVAL;
+			goto err_clock_put;
+		}
+
+		hwtst_config.tx_type = ffs(req_tx_type) - 1;
+	}
+	if (tb[ETHTOOL_A_TSCONFIG_RX_FILTERS]) {
+		ret = ethnl_parse_bitset(&req_rx_filter, &mask,
+					 __HWTSTAMP_FILTER_CNT,
+					 tb[ETHTOOL_A_TSCONFIG_RX_FILTERS],
+					 ts_rx_filter_names, info->extack);
+		if (ret < 0)
+			goto err_clock_put;
+
+		/* Select only one rx filter at a time */
+		if (ffs(req_rx_filter) != fls(req_rx_filter)) {
+			ret = -EINVAL;
+			goto err_clock_put;
+		}
+
+		hwtst_config.rx_filter = ffs(req_rx_filter) - 1;
+	}
+	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS]) {
+		ret = nla_get_u32(tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS]);
+		if (ret < 0)
+			goto err_clock_put;
+		hwtst_config.flags = ret;
+	}
+
+	ret = net_hwtstamp_validate(&hwtst_config);
+	if (ret)
+		goto err_clock_put;
+
+	/* Disable current time stamping if we try to enable another one */
+	if (mod && (hwtst_config.tx_type || hwtst_config.rx_filter)) {
+		struct kernel_hwtstamp_config zero_config = {0};
+
+		ret = dev_set_hwtstamp_phylib(dev, &zero_config, info->extack);
+		if (ret < 0)
+			goto err_clock_put;
+	}
+
+	/* Changed the selected hwtstamp source if needed */
+	if (mod) {
+		struct hwtstamp_provider *__hwtstamp;
+
+		__hwtstamp = rcu_replace_pointer_rtnl(dev->hwtstamp, hwtstamp);
+		if (__hwtstamp)
+			call_rcu(&__hwtstamp->rcu_head,
+				 remove_hwtstamp_provider);
+	}
+
+	ret = dev_set_hwtstamp_phylib(dev, &hwtst_config, info->extack);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+
+err_clock_put:
+	if (hwtstamp)
+		ptp_clock_put(&dev->dev, hwtstamp->ptp);
+err_free_hwtstamp:
+	devm_kfree(&dev->dev, hwtstamp);
+
+	return ret;
+}
+
+const struct ethnl_request_ops ethnl_tsconfig_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_TSCONFIG_GET,
+	.reply_cmd		= ETHTOOL_MSG_TSCONFIG_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_TSCONFIG_HEADER,
+	.req_info_size		= sizeof(struct tsconfig_req_info),
+	.reply_data_size	= sizeof(struct tsconfig_reply_data),
+
+	.prepare_data		= tsconfig_prepare_data,
+	.reply_size		= tsconfig_reply_size,
+	.fill_reply		= tsconfig_fill_reply,
+
+	.set_validate		= ethnl_set_tsconfig_validate,
+	.set			= ethnl_set_tsconfig,
+	.set_ntf_cmd		= ETHTOOL_MSG_TSCONFIG_NTF,
+};

-- 
2.34.1


