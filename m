Return-Path: <netdev+bounces-292883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG/HJLvOGGqunggAu9opvQ
	(envelope-from <netdev+bounces-292883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:24:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E85FB653
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BB11320A98A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63736F8F3;
	Thu, 28 May 2026 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTwS/PGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288736BCC2
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010215; cv=none; b=pitvmmTrP9EpcBi8+Tb3x31dOV6nnxG2l9kapJYbKVyPxGgU/SmbIBg6yl2QPMivt1n9lWzzt7A6QHdBCTtbI6M1cZzqa7kxMcUMCwSdJzWY4EkeVOzE5e58DNXorz0bJMnPiUYU7Z4RD9MvVTXf3JeBuOzo2kfvjfX6qwR3vLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010215; c=relaxed/simple;
	bh=zrYDMx+kbPEj/9L5GIWV/PIpLDQUJg/TQrFEApRhLXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBQTbjFB/uUubB6wLbE1omcPWbTUdjb2FA5DfHL4g8vVLo2FXIkEvcuLsczqwJoxQ5wHwp97fCPCe4MDRB31zdBcwftTZpjodezGADtQj4mm1yr3Rm3eZ1eKjJiBXqde1xKHuy14tzrILmU4r2nVwVlyZfN2p0WZs2NYiT30P9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTwS/PGd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1428D1F000E9;
	Thu, 28 May 2026 23:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010213;
	bh=t9/KO43zkCYZQ/3VXc0M29H7sXtKTQ3nGjRcUbeC354=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kTwS/PGdqV17YD3HJMhZkj4F38WDHGzryC+VYlNJgEUfDSJBArrnhQzNPmukgDan8
	 CeFZNWwO61xYBxgpRkkiEGjA6IybMC7ypY2olApCQcFkPtLxccE/2KB52Lt4K8bGdb
	 kyDGWXP6ne6xDXojJzk1TvwQwhBkEqt45zoXmLl9Sru2iLCPCy5fiY/+Et4p4Q2hrZ
	 ymyBteycws6AZcwPba5CoF+FSb4LNyqYkw+qyTShYq+pZ566bIZyxfXj7cQlDKmHlC
	 RBgKZd0guUUprcfA2AEdNyR8z1bIeBFtgnZYuzXgS3F+fG4VCw+4nLjEUCtDf8Jsny
	 FkRa84kB75dfg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/14] net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
Date: Thu, 28 May 2026 16:16:29 -0700
Message-ID: <20260528231637.251822-7-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292883-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 303E85FB653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ethnl_default_doit() and ethnl_default_dump_one() are both used
exclusively for GET callbacks (former to get info for a single
device or get global strings). ops-locked devices don't need
rtnl_lock for GET callbacks, stop taking it.

Introduce an opt-out mechanism for devices which use phylink (fbnic)
since phylink currently depends on rtnl_lock protection. Subsequent
patches will add more exceptions, anyway. Practically the new helpers
for judging if command needs rtnl_lock could also call
netdev_need_ops_lock() but I find that it makes the code in the callers
slightly less obvious.

Add a helper for IOCTLs already, even tho its unused so that
we can keep them in sync as the series progresses.

This is the first user-visible step of moving ethtool ops out
from under rtnl. Subsequent patches do the same for SET ops,
as well as the ioctl path.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h                       | 18 +++++++-
 net/ethtool/common.h                          | 46 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  2 +
 net/ethtool/mm.c                              |  5 +-
 net/ethtool/netlink.c                         | 19 ++++++--
 5 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 0caaeb91b094..f4f933b8be26 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -930,6 +930,13 @@ struct kernel_ethtool_ts_info {
 	u32 rx_filters;
 };
 
+/* Bits for ethtool_ops::op_needs_rtnl
+ * LINKSETTINGS cover a number of commands, but in most cases we want to keep
+ * these bits separate, per GET and SET. GET is much easier to "unlock".
+ */
+#define ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS	BIT(0)
+#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(1)
+
 /**
  * struct ethtool_ops - optional netdev operations
  * @supported_input_xfrm: supported types of input xfrm from %RXH_XFRM_*.
@@ -956,6 +963,14 @@ struct kernel_ethtool_ts_info {
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
  * @supported_hwtstamp_qualifiers: bitfield of supported hwtstamp qualifier.
+ * @op_needs_rtnl: mask of %ETHTOOL_OP_NEEDS_RTNL_* bits.
+ *	For use with ops-locked drivers (ignored otherwise). Selects which
+ *	ethtool callbacks driver needs to still be executed under rtnl_lock
+ *	(in addition to the netdev instance lock).
+ *	The following commonly used core APIs currently require rtnl_lock
+ *	(this list may not be exhaustive):
+ *	 - phylink helpers (note that phydev is currently unsupported!)
+ *
  * @get_drvinfo: Report driver/device information. Modern drivers no
  *	longer have to implement this callback. Most fields are
  *	correctly filled in by the core using system information, or
@@ -1155,7 +1170,7 @@ struct kernel_ethtool_ts_info {
  *
  * All operations are optional (i.e. the function pointer may be set
  * to %NULL) and callers must take this into account.  Callers must
- * hold the RTNL lock.
+ * hold the RTNL lock or netdev instance lock (see @op_needs_rtnl).
  *
  * See the structures used by these operations for further documentation.
  * Note that for all operations using a structure ending with a zero-
@@ -1178,6 +1193,7 @@ struct ethtool_ops {
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
 	u32	supported_hwtstamp_qualifiers;
+	u32	op_needs_rtnl;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
 	int	(*get_regs_len)(struct net_device *);
 	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 1609cf4e53eb..391c41ca56be 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -80,6 +80,52 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 
 bool __ethtool_dev_mm_supported(struct net_device *dev);
 
+/**
+ * ethtool_nl_msg_needs_rtnl() - does this Netlink cmd need rtnl_lock?
+ * @dev: target device
+ * @cmd: ETHTOOL_MSG_* Netlink command value
+ *
+ * Return: true if @cmd is a command for which @dev has opted-in to
+ * keeping rtnl_lock held across the call (via op_needs_rtnl).
+ */
+static inline bool
+ethtool_nl_msg_needs_rtnl(const struct net_device *dev, u8 cmd)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	switch (cmd) {
+	case ETHTOOL_MSG_LINKINFO_GET:
+	case ETHTOOL_MSG_LINKMODES_GET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS;
+	case ETHTOOL_MSG_PAUSE_GET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM;
+	}
+	return false;
+}
+
+/**
+ * ethtool_ioctl_needs_rtnl() - does this legacy ioctl cmd need rtnl_lock?
+ * @dev: target device
+ * @ethcmd: ETHTOOL_* ioctl command value
+ *
+ * Return: true if @ethcmd is a command for which @dev has opted-in to
+ * keeping rtnl_lock held across the call (via op_needs_rtnl).
+ */
+static inline bool
+ethtool_ioctl_needs_rtnl(const struct net_device *dev, u32 ethcmd)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	switch (ethcmd) {
+	case ETHTOOL_GLINKSETTINGS:
+	case ETHTOOL_GSET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS;
+	case ETHTOOL_GPAUSEPARAM:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM;
+	}
+	return false;
+}
+
 #if IS_ENABLED(CONFIG_ETHTOOL_NETLINK)
 void ethtool_rss_notify(struct net_device *dev, u32 type, u32 rss_context);
 #else
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index f14de2366854..a2c16d599389 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -2020,6 +2020,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 					  ETHTOOL_RING_USE_HDS_THRS,
 	.rxfh_max_num_contexts		= FBNIC_RPC_RSS_TBL_COUNT,
+	.op_needs_rtnl			= ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS |
+					  ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM,
 	.get_drvinfo			= fbnic_get_drvinfo,
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index 29bbbc149375..7092f1ce8612 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -246,8 +246,9 @@ const struct ethnl_request_ops ethnl_mm_request_ops = {
 };
 
 /* Returns whether a given device supports the MAC merge layer
- * (has an eMAC and a pMAC). Must be called under rtnl_lock() and
- * ethnl_ops_begin().
+ * (has an eMAC and a pMAC). Must be called under whichever lock
+ * netdev_ops_assert_locked() accepts (rtnl for traditional drivers,
+ * the netdev instance lock for ops-locked ones) and ethnl_ops_begin().
  */
 bool __ethtool_dev_mm_supported(struct net_device *dev)
 {
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a91cc4bc964f..ddb35790063d 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -7,6 +7,7 @@
 #include <linux/phy_link_topology.h>
 #include <linux/pm_runtime.h>
 
+#include "common.h"
 #include "module_fw.h"
 #include "netlink.h"
 
@@ -509,6 +510,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	struct ethnl_req_info *req_info = NULL;
 	const u8 cmd = info->genlhdr->cmd;
 	const struct ethnl_request_ops *ops;
+	bool need_rtnl = false;
 	int hdr_len, reply_len;
 	struct sk_buff *rskb;
 	void *reply_payload;
@@ -535,13 +537,17 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	ethnl_init_reply_data(reply_data, ops, req_info->dev);
 
 	if (req_info->dev) {
-		rtnl_lock();
+		need_rtnl = !netdev_need_ops_lock(req_info->dev) ||
+			    ethtool_nl_msg_needs_rtnl(req_info->dev, cmd);
+		if (need_rtnl)
+			rtnl_lock();
 		netdev_lock_ops(req_info->dev);
 	}
 	ret = ops->prepare_data(req_info, reply_data, info);
 	if (req_info->dev) {
 		netdev_unlock_ops(req_info->dev);
-		rtnl_unlock();
+		if (need_rtnl)
+			rtnl_unlock();
 	}
 	if (ret < 0)
 		goto err_dev;
@@ -589,6 +595,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 				  const struct ethnl_dump_ctx *ctx,
 				  const struct genl_info *info)
 {
+	bool need_rtnl;
 	void *ehdr;
 	int ret;
 
@@ -599,11 +606,15 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 		return -EMSGSIZE;
 
 	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
-	rtnl_lock();
+	need_rtnl = !netdev_need_ops_lock(dev) ||
+		    ethtool_nl_msg_needs_rtnl(dev, ctx->ops->request_cmd);
+	if (need_rtnl)
+		rtnl_lock();
 	netdev_lock_ops(dev);
 	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
 	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	if (need_rtnl)
+		rtnl_unlock();
 	if (ret < 0)
 		goto out_cancel;
 	ret = ethnl_fill_reply_header(skb, dev, ctx->ops->hdr_attr);
-- 
2.54.0


