Return-Path: <netdev+bounces-108150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826291E066
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D72283D1A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217D15ECE9;
	Mon,  1 Jul 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QJGPTjFd"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5715B96D;
	Mon,  1 Jul 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839896; cv=none; b=R6FW6SZXiGaPEaSep1lTqHpeePHn2PzCEIZdSB8/tSm/uAb9mY2mWWhBUmpiqfZR9WSw9fneF11Q41HyxHJGokEAi4y66X7BlkAFs4VNNtmtP57qv+E4O7iCaHy7NfNgzUphgX93ABzTdH+qcXRZ9OETg+Bncw/+4b27Q4NelFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839896; c=relaxed/simple;
	bh=T2reYrMTmf+Fd0m4HL+t0mvKjWTXe1crbuU324G/4CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/mlrog6BoGCZF2y+fG/usCvGpGvpPt5JGDb/7n8JxRxwXA8N40ItgBrCyFl06IspYaLfgN6Lj43hOoAnO2avgh6xVBebmyS7wTlmtBwBAcUzQQ3mLoduQvbSAWMhTPLl3tzaP99bmyIl2b4TxL6QrTsS9bjXVtfztfsAH+YLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QJGPTjFd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0D3CFF80C;
	Mon,  1 Jul 2024 13:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719839893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvBYGfieJNSgOMTMs4ygDpieBcSveTVULv9bAWmHcks=;
	b=QJGPTjFdRzxzaFvTBzpdH24ZUnEvDsEAxL2uZcgCIgN7n+cZ8JoDtwPsU+bZitjyuxe20z
	5JhgnW5B1QE1sRzAcGszDvsVPYEAhUd1bGGd4Ntdsm/DBalV4Jxvp5noUJcOYNiZhMPX9D
	zYvJDMFlrGib3q2+BC/cQSx1jD/LXb8vUkLtLLlb/clRtRIM0L+43px8xI1fpK1+gXri8e
	W38+P9Miymletn292yeuIxLGrCt90sWn++ijZvOH3aScXUQixMk+eOBe6tuL6ezqurmrrJ
	kq3eXAE3HFyscdIM/JdI3Ckk5oRXlAPkkk5saW0b6xyswsbZ6TwVYhDIbITULw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next v14 05/13] net: ethtool: Allow passing a phy index for some commands
Date: Mon,  1 Jul 2024 15:17:51 +0200
Message-ID: <20240701131801.1227740-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
References: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Some netlink commands are target towards ethernet PHYs, to control some
of their features. As there's several such commands, add the ability to
pass a PHY index in the ethnl request, which will populate the generic
ethnl_req_info with the passed phy_index.

Add a helper that netlink command handlers need to use to grab the
targeted PHY from the req_info. This helper needs to hold rtnl_lock()
while interacting with the PHY, as it may be removed at any point.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/ethtool-netlink.rst |  7 +++
 include/uapi/linux/ethtool_netlink.h         |  1 +
 net/ethtool/netlink.c                        | 57 +++++++++++++++++++-
 net/ethtool/netlink.h                        | 28 ++++++++++
 4 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index bfe2eda8580d..0b5712d7c0cb 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -57,6 +57,7 @@ Structure of this header is
   ``ETHTOOL_A_HEADER_DEV_INDEX``  u32     device ifindex
   ``ETHTOOL_A_HEADER_DEV_NAME``   string  device name
   ``ETHTOOL_A_HEADER_FLAGS``      u32     flags common for all requests
+  ``ETHTOOL_A_HEADER_PHY_INDEX``  u32     phy device index
   ==============================  ======  =============================
 
 ``ETHTOOL_A_HEADER_DEV_INDEX`` and ``ETHTOOL_A_HEADER_DEV_NAME`` identify the
@@ -81,6 +82,12 @@ the behaviour is backward compatible, i.e. requests from old clients not aware
 of the flag should be interpreted the way the client expects. A client must
 not set flags it does not understand.
 
+``ETHTOOL_A_HEADER_PHY_INDEX`` identifies the Ethernet PHY the message relates to.
+As there are numerous commands that are related to PHY configuration, and because
+there may be more than one PHY on the link, the PHY index can be passed in the
+request for the commands that needs it. It is, however, not mandatory, and if it
+is not passed for commands that target a PHY, the net_device.phydev pointer
+is used.
 
 Bit sets
 ========
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 840dabdc9d88..754e662ffdf4 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -134,6 +134,7 @@ enum {
 	ETHTOOL_A_HEADER_DEV_INDEX,		/* u32 */
 	ETHTOOL_A_HEADER_DEV_NAME,		/* string */
 	ETHTOOL_A_HEADER_FLAGS,			/* u32 - ETHTOOL_FLAG_* */
+	ETHTOOL_A_HEADER_PHY_INDEX,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_HEADER_CNT,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 81fe2e5b95f6..65cc453b60dd 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -2,6 +2,7 @@
 
 #include <net/sock.h>
 #include <linux/ethtool_netlink.h>
+#include <linux/phy_link_topology.h>
 #include <linux/pm_runtime.h>
 #include "netlink.h"
 #include "module_fw.h"
@@ -31,6 +32,24 @@ const struct nla_policy ethnl_header_policy_stats[] = {
 							  ETHTOOL_FLAGS_STATS),
 };
 
+const struct nla_policy ethnl_header_policy_phy[] = {
+	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
+	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ALTIFNAMSIZ - 1 },
+	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
+							  ETHTOOL_FLAGS_BASIC),
+	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
+};
+
+const struct nla_policy ethnl_header_policy_phy_stats[] = {
+	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
+	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ALTIFNAMSIZ - 1 },
+	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
+							  ETHTOOL_FLAGS_STATS),
+	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
 			enum ethnl_sock_type type)
 {
@@ -119,7 +138,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 			       const struct nlattr *header, struct net *net,
 			       struct netlink_ext_ack *extack, bool require_dev)
 {
-	struct nlattr *tb[ARRAY_SIZE(ethnl_header_policy)];
+	struct nlattr *tb[ARRAY_SIZE(ethnl_header_policy_phy)];
 	const struct nlattr *devname_attr;
 	struct net_device *dev = NULL;
 	u32 flags = 0;
@@ -134,7 +153,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 	/* No validation here, command policy should have a nested policy set
 	 * for the header, therefore validation should have already been done.
 	 */
-	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_header_policy) - 1, header,
+	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_header_policy_phy) - 1, header,
 			       NULL, extack);
 	if (ret < 0)
 		return ret;
@@ -175,11 +194,45 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 		return -EINVAL;
 	}
 
+	if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
+		if (dev) {
+			req_info->phy_index = nla_get_u32(tb[ETHTOOL_A_HEADER_PHY_INDEX]);
+		} else {
+			NL_SET_ERR_MSG_ATTR(extack, header,
+					    "phy_index set without a netdev");
+			return -EINVAL;
+		}
+	}
+
 	req_info->dev = dev;
 	req_info->flags = flags;
 	return 0;
 }
 
+struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
+					const struct nlattr *header,
+					struct netlink_ext_ack *extack)
+{
+	struct phy_device *phydev;
+
+	ASSERT_RTNL();
+
+	if (!req_info->dev)
+		return NULL;
+
+	if (!req_info->phy_index)
+		return req_info->dev->phydev;
+
+	phydev = phy_link_topo_get_phy(req_info->dev, req_info->phy_index);
+	if (!phydev) {
+		NL_SET_ERR_MSG_ATTR(extack, header,
+				    "no phy matching phyindex");
+		return ERR_PTR(-ENODEV);
+	}
+
+	return phydev;
+}
+
 /**
  * ethnl_fill_reply_header() - Put common header into a reply message
  * @skb:      skb with the message
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 46ec273a87c5..4db16048f8d4 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -251,6 +251,9 @@ static inline unsigned int ethnl_reply_header_size(void)
  * @dev:   network device the request is for (may be null)
  * @dev_tracker: refcount tracker for @dev reference
  * @flags: request flags common for all request types
+ * @phy_index: phy_device index connected to @dev this request is for. Can be
+ *	       0 if the request doesn't target a phy, or if the @dev's attached
+ *	       phy is targeted.
  *
  * This is a common base for request specific structures holding data from
  * parsed userspace request. These always embed struct ethnl_req_info at
@@ -260,6 +263,7 @@ struct ethnl_req_info {
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
 	u32			flags;
+	u32			phy_index;
 };
 
 static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
@@ -267,6 +271,27 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
 	netdev_put(req_info->dev, &req_info->dev_tracker);
 }
 
+/**
+ * ethnl_req_get_phydev() - Gets the phy_device targeted by this request,
+ *			    if any. Must be called under rntl_lock().
+ * @req_info:	The ethnl request to get the phy from.
+ * @header:	The netlink header, used for error reporting.
+ * @extack:	The netlink extended ACK, for error reporting.
+ *
+ * The caller must hold RTNL, until it's done interacting with the returned
+ * phy_device.
+ *
+ * Return: A phy_device pointer corresponding either to the passed phy_index
+ *	   if one is provided. If not, the phy_device attached to the
+ *	   net_device targeted by this request is returned. If there's no
+ *	   targeted net_device, or no phy_device is attached, NULL is
+ *	   returned. If the provided phy_index is invalid, an error pointer
+ *	   is returned.
+ */
+struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
+					const struct nlattr *header,
+					struct netlink_ext_ack *extack);
+
 /**
  * struct ethnl_reply_data - base type of reply data for GET requests
  * @dev:       device for current reply message; in single shot requests it is
@@ -409,9 +434,12 @@ extern const struct ethnl_request_ops ethnl_rss_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
+extern const struct ethnl_request_ops ethnl_phy_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
+extern const struct nla_policy ethnl_header_policy_phy[ETHTOOL_A_HEADER_PHY_INDEX + 1];
+extern const struct nla_policy ethnl_header_policy_phy_stats[ETHTOOL_A_HEADER_PHY_INDEX + 1];
 extern const struct nla_policy ethnl_strset_get_policy[ETHTOOL_A_STRSET_COUNTS_ONLY + 1];
 extern const struct nla_policy ethnl_linkinfo_get_policy[ETHTOOL_A_LINKINFO_HEADER + 1];
 extern const struct nla_policy ethnl_linkinfo_set_policy[ETHTOOL_A_LINKINFO_TP_MDIX_CTRL + 1];
-- 
2.45.1


