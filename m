Return-Path: <netdev+bounces-35837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4D7AB52D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 17BC8282247
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B24174F;
	Fri, 22 Sep 2023 15:50:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06141237
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:50:39 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3845B139;
	Fri, 22 Sep 2023 08:50:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E01760005;
	Fri, 22 Sep 2023 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695397835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IxKwcciKmXYopG6DK4wl0+zc2JwbUGpdFQ1jD2Tirc=;
	b=WbPARJvzeU8DMIsfVOYiXXxi0rr2wKm+hSxT/GawIanmh8jQM82hWTqnDw9XC4SG8syHdg
	/YQ5Ctxfn3/z/IhnIakLpeGgw4T8tm214MbUmZavpcmjRVDRsKW/iTHe7xRG3BlUshW5zJ
	vJu/607/KNC4UILYxVM2gluLMzyTjEsG+TGZ6dWpTeyLiAZK9Vx/WuwD3Kricmwjz01Lcu
	9Jfq/fNrZvqsHW401+am19HO7HmDnF7M9a/33M0hwYG8424PaLD/KTTQwbX/DaMkH88OIQ
	SNPqrJtOB4b5T3iPhX32uNLy8tzdKdjI0Ef1cRBuwIjjat+sa4ZWcDkzcCfqnw==
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
Subject: [PATCH wpan-next v4 02/11] ieee802154: Internal PAN management
Date: Fri, 22 Sep 2023 17:50:20 +0200
Message-Id: <20230922155029.592018-3-miquel.raynal@bootlin.com>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce structures to describe peer devices in a PAN as well as a few
related helpers. We basically care about:
- Our unique parent after associating with a coordinator.
- Peer devices, children, which successfully associated with us.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/cfg802154.h | 47 ++++++++++++++++++++++++++
 net/ieee802154/Makefile |  2 +-
 net/ieee802154/core.c   |  2 ++
 net/ieee802154/pan.c    | 73 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 net/ieee802154/pan.c

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index f79ce133e51a..a89f1c9cea3f 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -303,6 +303,22 @@ struct ieee802154_coord_desc {
 	bool gts_permit;
 };
 
+/**
+ * struct ieee802154_pan_device - PAN device information
+ * @pan_id: the PAN ID of this device
+ * @mode: the preferred mode to reach the device
+ * @short_addr: the short address of this device
+ * @extended_addr: the extended address of this device
+ * @node: the list node
+ */
+struct ieee802154_pan_device {
+	__le16 pan_id;
+	u8 mode;
+	__le16 short_addr;
+	__le64 extended_addr;
+	struct list_head node;
+};
+
 /**
  * struct cfg802154_scan_request - Scan request
  *
@@ -478,6 +494,11 @@ struct wpan_dev {
 
 	/* fallback for acknowledgment bit setting */
 	bool ackreq;
+
+	/* Associations */
+	struct mutex association_lock;
+	struct ieee802154_pan_device *parent;
+	struct list_head children;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
@@ -529,4 +550,30 @@ static inline const char *wpan_phy_name(struct wpan_phy *phy)
 void ieee802154_configure_durations(struct wpan_phy *phy,
 				    unsigned int page, unsigned int channel);
 
+/**
+ * cfg802154_device_is_associated - Checks whether we are associated to any device
+ * @wpan_dev: the wpan device
+ * @return: true if we are associated
+ */
+bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev);
+
+/**
+ * cfg802154_device_is_parent - Checks if a device is our coordinator
+ * @wpan_dev: the wpan device
+ * @target: the expected parent
+ * @return: true if @target is our coordinator
+ */
+bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
+				struct ieee802154_addr *target);
+
+/**
+ * cfg802154_device_is_child - Checks whether a device is associated to us
+ * @wpan_dev: the wpan device
+ * @target: the expected child
+ * @return: the PAN device
+ */
+struct ieee802154_pan_device *
+cfg802154_device_is_child(struct wpan_dev *wpan_dev,
+			  struct ieee802154_addr *target);
+
 #endif /* __NET_CFG802154_H */
diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index f05b7bdae2aa..7bce67673e83 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
 obj-y += 6lowpan/
 
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
-                header_ops.o sysfs.o nl802154.o trace.o
+                header_ops.o sysfs.o nl802154.o trace.o pan.o
 ieee802154_socket-y := socket.o
 
 CFLAGS_trace.o := -I$(src)
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 57546e07e06a..cd69bdbfd59f 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -276,6 +276,8 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 		wpan_dev->identifier = ++rdev->wpan_dev_id;
 		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
 		rdev->devlist_generation++;
+		mutex_init(&wpan_dev->association_lock);
+		INIT_LIST_HEAD(&wpan_dev->children);
 
 		wpan_dev->netdev = dev;
 		break;
diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
new file mode 100644
index 000000000000..1677bb89c5ff
--- /dev/null
+++ b/net/ieee802154/pan.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IEEE 802.15.4 PAN management
+ *
+ * Copyright (C) 2023 Qorvo US, Inc
+ * Authors:
+ *   - David Girault <david.girault@qorvo.com>
+ *   - Miquel Raynal <miquel.raynal@bootlin.com>
+ */
+
+#include <linux/kernel.h>
+#include <net/cfg802154.h>
+#include <net/af_ieee802154.h>
+
+/* Checks whether a device address matches one from the PAN list.
+ * This helper is meant to be used only during PAN management, when we expect
+ * extended addresses to be used.
+ */
+static bool cfg802154_device_in_pan(struct ieee802154_pan_device *pan_dev,
+				    struct ieee802154_addr *ext_dev)
+{
+	if (!pan_dev || !ext_dev)
+		return false;
+
+	if (ext_dev->mode == IEEE802154_ADDR_SHORT)
+		return false;
+
+	switch (ext_dev->mode) {
+	case IEEE802154_ADDR_SHORT:
+		return pan_dev->short_addr == ext_dev->short_addr;
+	case IEEE802154_ADDR_LONG:
+		return pan_dev->extended_addr == ext_dev->extended_addr;
+	default:
+		return false;
+	}
+}
+
+bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev)
+{
+	bool is_assoc;
+
+	mutex_lock(&wpan_dev->association_lock);
+	is_assoc = !list_empty(&wpan_dev->children) || wpan_dev->parent;
+	mutex_unlock(&wpan_dev->association_lock);
+
+	return is_assoc;
+}
+
+bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
+				struct ieee802154_addr *target)
+{
+	lockdep_assert_held(&wpan_dev->association_lock);
+
+	if (cfg802154_device_in_pan(wpan_dev->parent, target))
+		return true;
+
+	return false;
+}
+
+struct ieee802154_pan_device *
+cfg802154_device_is_child(struct wpan_dev *wpan_dev,
+			  struct ieee802154_addr *target)
+{
+	struct ieee802154_pan_device *child;
+
+	lockdep_assert_held(&wpan_dev->association_lock);
+
+	list_for_each_entry(child, &wpan_dev->children, node)
+		if (cfg802154_device_in_pan(child, target))
+			return child;
+
+	return NULL;
+}
-- 
2.34.1


