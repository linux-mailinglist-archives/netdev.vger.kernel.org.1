Return-Path: <netdev+bounces-35843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D377AB538
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id DF4D51F23012
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05244177C;
	Fri, 22 Sep 2023 15:50:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C64175C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:50:48 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900EB18F;
	Fri, 22 Sep 2023 08:50:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8CA260005;
	Fri, 22 Sep 2023 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695397845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x83fHh6H9Ejet0Z4EhLSqqegQOV8H3OnbJOyhbAIAl4=;
	b=JjUUFpxIMbkpHH+WmhJUr4qjuGQwEeXwU3eFnUibEtA6dYmU73emG98lmEX5hsI+NZj5iG
	R8JbLQf8mpP6KHppz7I4uPkYzL3cu8eRcrqECRJXGdnch1Qr9XFER1dHQKHNNZU14Ke3Ah
	1pXbSDTvUJ9AnsTafWXjx0F1o/w0CdGQh6TU6gRaOwbHCoNxyzHS4E8TRRXgcsd80x1GuQ
	Z8uL7TBY+bLIMF8HubGSLDdn096BI8BxpAYTVLHcnqCRaQkHEHvBF54GL13pvR6LHyP20q
	KkNaqe8hod0VProK6KDdu6V1RZBrbeUgIPwZ7zKu3NaMpCsnfhse74cocueEdQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	David Girault <david.girault@qorvo.com>,
	Romuald Despres <romuald.despres@qorvo.com>,
	Frederic Blain <frederic.blain@qorvo.com>,
	Nicolas Schodet <nico@ni.fr.eu.org>,
	Guilhem Imberton <guilhem.imberton@qorvo.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v4 08/11] ieee802154: Add support for limiting the number of associated devices
Date: Fri, 22 Sep 2023 17:50:26 +0200
Message-Id: <20230922155029.592018-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922155029.592018-1-miquel.raynal@bootlin.com>
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Coordinators may refuse associations. We need a user input for
that. Let's add a new netlink command which can provide a maximum number
of devices we accept to associate with as a first step. Later, we could
also forward the request to userspace and check whether the association
should be accepted or not.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/cfg802154.h   |  8 ++++++++
 include/net/nl802154.h    |  2 ++
 net/ieee802154/core.c     |  1 +
 net/ieee802154/nl802154.c | 28 ++++++++++++++++++++++++++++
 net/ieee802154/pan.c      |  8 ++++++++
 5 files changed, 47 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index c844ae63bc04..0d3e9af00198 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -506,6 +506,7 @@ struct wpan_dev {
 	struct mutex association_lock;
 	struct ieee802154_pan_device *parent;
 	struct list_head children;
+	unsigned int max_associations;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
@@ -583,6 +584,13 @@ struct ieee802154_pan_device *
 cfg802154_device_is_child(struct wpan_dev *wpan_dev,
 			  struct ieee802154_addr *target);
 
+/**
+ * cfg802154_set_max_associations - Limit the number of future associations
+ * @wpan_dev: the wpan device
+ * @max: the maximum number of devices we accept to associate
+ */
+void cfg802154_set_max_associations(struct wpan_dev *wpan_dev, unsigned int max);
+
 /**
  * cfg802154_get_free_short_addr - Get a free address among the known devices
  * @wpan_dev: the wpan device
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index 8a47c14c72f0..8b26faae49e8 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -80,6 +80,7 @@ enum nl802154_commands {
 	NL802154_CMD_STOP_BEACONS,
 	NL802154_CMD_ASSOCIATE,
 	NL802154_CMD_DISASSOCIATE,
+	NL802154_CMD_SET_MAX_ASSOCIATIONS,
 
 	/* add new commands above here */
 
@@ -149,6 +150,7 @@ enum nl802154_attrs {
 	NL802154_ATTR_SCAN_DURATION,
 	NL802154_ATTR_SCAN_DONE_REASON,
 	NL802154_ATTR_BEACON_INTERVAL,
+	NL802154_ATTR_MAX_ASSOCIATIONS,
 
 	/* add attributes here, update the policy in nl802154.c */
 
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 1670a71327a7..2d6fe45efa05 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -295,6 +295,7 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 		rdev->devlist_generation++;
 		mutex_init(&wpan_dev->association_lock);
 		INIT_LIST_HEAD(&wpan_dev->children);
+		wpan_dev->max_associations = SZ_16K;
 
 		wpan_dev->netdev = dev;
 		break;
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 5820fe425ddd..e16e57fc34d0 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -234,6 +234,7 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 				 NL802154_SCAN_DONE_REASON_ABORTED),
 	[NL802154_ATTR_BEACON_INTERVAL] =
 		NLA_POLICY_MAX(NLA_U8, IEEE802154_ACTIVE_SCAN_DURATION),
+	[NL802154_ATTR_MAX_ASSOCIATIONS] = { .type = NLA_U32 },
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 	[NL802154_ATTR_SEC_ENABLED] = { .type = NLA_U8, },
@@ -1696,6 +1697,26 @@ static int nl802154_disassociate(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int nl802154_set_max_associations(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	unsigned int max_assoc;
+
+	if (!info->attrs[NL802154_ATTR_MAX_ASSOCIATIONS]) {
+		NL_SET_ERR_MSG(info->extack, "No maximum number of association given");
+		return -EINVAL;
+	}
+
+	max_assoc = nla_get_u32(info->attrs[NL802154_ATTR_MAX_ASSOCIATIONS]);
+
+	mutex_lock(&wpan_dev->association_lock);
+	cfg802154_set_max_associations(wpan_dev, max_assoc);
+	mutex_unlock(&wpan_dev->association_lock);
+
+	return 0;
+}
+
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 static const struct nla_policy nl802154_dev_addr_policy[NL802154_DEV_ADDR_ATTR_MAX + 1] = {
 	[NL802154_DEV_ADDR_ATTR_PAN_ID] = { .type = NLA_U16 },
@@ -2833,6 +2854,13 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_CHECK_NETDEV_UP |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_MAX_ASSOCIATIONS,
+		.doit = nl802154_set_max_associations,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 	{
 		.cmd = NL802154_CMD_SET_SEC_PARAMS,
diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
index e99c64054dcb..8d4a7b955b2a 100644
--- a/net/ieee802154/pan.c
+++ b/net/ieee802154/pan.c
@@ -103,3 +103,11 @@ __le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
 	return addr;
 }
 EXPORT_SYMBOL_GPL(cfg802154_get_free_short_addr);
+
+void cfg802154_set_max_associations(struct wpan_dev *wpan_dev, unsigned int max)
+{
+	lockdep_assert_held(&wpan_dev->association_lock);
+
+	wpan_dev->max_associations = max;
+}
+EXPORT_SYMBOL_GPL(cfg802154_set_max_associations);
-- 
2.34.1


