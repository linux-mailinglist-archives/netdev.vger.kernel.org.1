Return-Path: <netdev+bounces-179489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE8A7D0FD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A116F269
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF222259A;
	Sun,  6 Apr 2025 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9WWz5yL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E7221568;
	Sun,  6 Apr 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977712; cv=none; b=V7uk7AiDeKU79MUmdoy3taebQf8iaB+w0KzqxPQz6XxpbnBeOa2BWvtAnZr5EYCDqfC4wR8poZqn5DeDxwJmxjvJNB3Jkeot6xux28tRlWbIHdBmhU8GZx1AR2ViNKZnPaAOZM74ee2if6jiS3Y3qxO+kklK0sNxDfZY4dbDxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977712; c=relaxed/simple;
	bh=NT2sXNZqDAukcq0PFqxxa/qxqIGrO6ItNe3Kbvd6Iz4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8pUjYsA1uUGH6j6vKwvmKUuwE5OO61aNQ1EOgzutWRqZuH01BMFjlpRgKjhS8DQCDZQ7SCuvskyDepBF6CkU1WK/u+BUEs1r0/vvXlhvhYwMtC7pvnmWC8MgZRCdtvYi+f8mzzZaVdr9ZmIyVqq6sin9ZDAc3kKkgN9s+yARTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9WWz5yL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so18769935e9.1;
        Sun, 06 Apr 2025 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977708; x=1744582508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NheK5r8NI2wjWbCB6pBIM1rY7N6lb54Ew5FqwDMD4TY=;
        b=k9WWz5yLK2pErwKqEWJ6AQ3GHN75QiDQoWrvNlukvgcnL2fDsEjTHK451peIoAY/Ts
         0xN1CfS1INg0s10dQn+QIfVDLeGPsg7LNgTVaI8gxwvpUzzmVGSGlDMC6olySIWca5Cs
         PULJSi7ahY8sDtuY5KMU1sdgJe3mt5xFAQWMldW5HPuziWzL73C3QAFIQtJT6uBccK0h
         Yq44tTdjiYhwcZuJEBtQInsVHtQxOSbIj3ychlkvIyhMZD4wcZYogGlYDrWLJQn5HHbH
         nHElq6xHv91bDsEjMQSaIQXmn0sLGQqlKJqBuFwbP1kQV0ySPkUOG2s3Wjm28CmNJnqI
         A1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977708; x=1744582508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NheK5r8NI2wjWbCB6pBIM1rY7N6lb54Ew5FqwDMD4TY=;
        b=CG0bALcr7k9AVgSNSR4lEAnRdYVOtvY/vHQZAMkK0k7nONtgaD0B5G/P2MvhD1najv
         LRqe36MVgTGwBCrT9SHOHNjcWQJF45wwNPbtYAZu2/rU0JNqZJ1dzxanwOJdCZO8RR6o
         go0M9A6WOk4pNVoBXJILiz6ANBWt1nesy7W0GwaUSj7NFMgvPSMDO0V3DRdK3ZbnxbC6
         /fSu45SFDZ6RZwAbHC2tSNF3OQlkSQha86wZ3WRYI+culRIekzdJC9QH+xtjl0tbilI2
         0KTQB5GTL20U/vIukyWLLHx9JAhwooOOCq4Sux/0RwgwT4NvjS8tskC2XMQUWTEd30rN
         WXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVg920Q/W7Cch7vZMH420UEl4gHOQOpbvKmYh34lSdXcnHBTgznRdOCC8Zs/8qbGUs1wFe/hQ1p0f1Iuly@vger.kernel.org, AJvYcCUpNGYzzzKHu49GG8LjFR+g6dkBw1oWY6XSQynDCufjsOI0VSoa0zqLSiGuEcWBEBfW0/xW24SsX4hS@vger.kernel.org, AJvYcCWZ5MgtL2YkSQRfqFPNfGo9ZA30zjwW/Q02iuy6mqIVAn2rtFhDKkZUJRrtTllL6BPGb5tl1VlR@vger.kernel.org
X-Gm-Message-State: AOJu0YwacNEo4VEvZrN70Is8bpV6uNCY/8TtvsTag1hx32RXtrVnD0e8
	qyl2KqbD1czzqLlzhgWoW4EiYTLVttyMnRwuaGV2WZDl6nsX3M/n
X-Gm-Gg: ASbGncsy5bPFjcEltM23e+Vnam/4CeGhIkKIDZz41EmaNjsQlB0Y0LnKlXca5822qG+
	gahos2f6ezOk6j1TABjtYWjtnamPLlngiAUxQPq5BWEr8aGBXXE8wsYftB/p4CbAiVHI3C4PqJ8
	n6hGyybKSntt8sfgyy3RMK/+4PPjCBL5y5dw8W7P5RduhPwR5OywUK8wIohgXXB4VKA64QSorVz
	QlpA6vaU/KT1FF3QYgpqb6KmmEyK4KZRXZM4bwwphEmjtLaFbP3EVD/wyotgqjnbSEj9WGW7rSV
	psxT6AuP/xiRpNEEwxnWB977RHaomBr8H0jFnmU6O6dduC8Yqr7KsrppZ330MkmKdjipT4sBzbC
	eUwgDKn0Qsitydw==
X-Google-Smtp-Source: AGHT+IHaz2i92ocrx4+wErQZTjeioBLSqGXinrgyqWLyRujet6CpsWu8yc7v9VQuGpHgAyRsELf1uA==
X-Received: by 2002:a05:600c:4705:b0:43d:53c:1ad6 with SMTP id 5b1f17b1804b1-43ecfa02754mr67372745e9.26.1743977708364;
        Sun, 06 Apr 2025 15:15:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 07/11] net: phylink: support late PCS provider attach
Date: Mon,  7 Apr 2025 00:14:00 +0200
Message-ID: <20250406221423.9723-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support in phylink for late PCS provider attach to a phylink
instance. This works by creating a global notifier for the PCS provider
and making each phylink instance that makes use of fwnode subscribe to
this notifier.

The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
a new PCS provider is added.

phylink will then react to this event and will call the new function
fwnode_phylink_pcs_get_from_fwnode() that will check if the PCS fwnode
provided by the event is present in the phy-handle property of the
phylink instance.

If a related PCS is found, then such PCS is added to the phylink
instance PCS list.

Then we link the PCS to the phylink instance if it's not disable and we
refresh the supported interfaces of the phylink instance.

Finally we check if we are in a major_config_failed scenario and trigger
an interface reconfiguration in the next phylink resolve.

If link was previously torn down due to removal of PCS, the link will be
established again as the PCS came back and is not available to phylink.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/pcs/pcs.c     | 34 +++++++++++++++++++++++++
 drivers/net/phy/phylink.c | 52 +++++++++++++++++++++++++++++++++++++++
 include/linux/pcs/pcs.h   | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
index 14a5cd3eeda1..a7352effa92f 100644
--- a/drivers/net/pcs/pcs.c
+++ b/drivers/net/pcs/pcs.c
@@ -22,6 +22,13 @@ struct fwnode_pcs_provider {
 
 static LIST_HEAD(fwnode_pcs_providers);
 static DEFINE_MUTEX(fwnode_pcs_mutex);
+static BLOCKING_NOTIFIER_HEAD(fwnode_pcs_notify_list);
+
+int register_fwnode_pcs_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&fwnode_pcs_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(register_fwnode_pcs_notifier);
 
 struct phylink_pcs *fwnode_pcs_simple_get(struct fwnode_reference_args *pcsspec,
 					  void *data)
@@ -55,6 +62,10 @@ int fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
 
 	fwnode_dev_initialized(fwnode, true);
 
+	blocking_notifier_call_chain(&fwnode_pcs_notify_list,
+				     FWNODE_PCS_PROVIDER_ADD,
+				     fwnode);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fwnode_pcs_add_provider);
@@ -147,6 +158,29 @@ struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode, int index)
 }
 EXPORT_SYMBOL_GPL(fwnode_pcs_get);
 
+struct phylink_pcs *
+fwnode_phylink_pcs_get_from_fwnode(struct fwnode_handle *fwnode,
+				   struct fwnode_handle *pcs_fwnode)
+{
+	struct fwnode_reference_args pcsspec;
+	int i = 0;
+	int ret;
+
+	while (true) {
+		ret = fwnode_parse_pcsspec(fwnode, i, NULL, &pcsspec);
+		if (ret)
+			break;
+
+		if (pcsspec.fwnode == pcs_fwnode)
+			break;
+
+		i++;
+	}
+
+	return fwnode_pcs_get(fwnode, i);
+}
+EXPORT_SYMBOL_GPL(fwnode_phylink_pcs_get_from_fwnode);
+
 static int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode,
 				    unsigned int *num_pcs)
 {
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e6bb6e5cb63e..b189d42b6a9b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -12,6 +12,7 @@
 #include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
+#include <linux/pcs/pcs.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
 #include <linux/phylink.h>
@@ -68,6 +69,7 @@ struct phylink {
 
 	/* List of available PCS */
 	struct list_head pcs_list;
+	struct notifier_block fwnode_pcs_nb;
 
 	/* What interface are supported by the current link.
 	 * Can change on removal or addition of new PCS.
@@ -1915,6 +1917,51 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+static int pcs_provider_notify(struct notifier_block *self,
+			       unsigned long val, void *data)
+{
+	struct phylink *pl = container_of(self, struct phylink, fwnode_pcs_nb);
+	struct fwnode_handle *pcs_fwnode = data;
+	struct phylink_pcs *pcs;
+
+	/* Check if the just added PCS provider is
+	 * in the phylink instance phy-handle property
+	 */
+	pcs = fwnode_phylink_pcs_get_from_fwnode(dev_fwnode(pl->config->dev),
+						 pcs_fwnode);
+	if (IS_ERR(pcs))
+		return NOTIFY_DONE;
+
+	/* Add the PCS */
+	rtnl_lock();
+
+	list_add(&pcs->list, &pl->pcs_list);
+
+	/* Link phylink if we are started */
+	if (!pl->phylink_disable_state)
+		pcs->phylink = pl;
+
+	/* Refresh supported interfaces */
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
+
+	mutex_lock(&pl->state_mutex);
+	/* Force an interface reconfig if major config fail */
+	if (pl->major_config_failed)
+		pl->reconfig_interface = true;
+	mutex_unlock(&pl->state_mutex);
+
+	rtnl_unlock();
+
+	phylink_run_resolve(pl);
+
+	return NOTIFY_OK;
+}
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
@@ -1969,6 +2016,11 @@ struct phylink *phylink_create(struct phylink_config *config,
 				 pl->supported_interfaces,
 				 pcs->supported_interfaces);
 
+	if (!phy_interface_empty(config->pcs_interfaces)) {
+		pl->fwnode_pcs_nb.notifier_call = pcs_provider_notify;
+		register_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
+	}
+
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
index c7a4d63bcd6d..480c155a3f03 100644
--- a/include/linux/pcs/pcs.h
+++ b/include/linux/pcs/pcs.h
@@ -4,7 +4,24 @@
 
 #include <linux/phylink.h>
 
+enum fwnode_pcs_notify_event {
+	FWNODE_PCS_PROVIDER_ADD,
+};
+
 #if IS_ENABLED(CONFIG_FWNODE_PCS)
+/**
+ * register_fwnode_pcs_notifier - Register a notifier block for fwnode
+ *				  PCS events
+ * @nb: pointer to the notifier block
+ *
+ * Registers a notifier block to the fwnode_pcs_notify_list blocking
+ * notifier chain. This allows phylink instance to subscribe for
+ * PCS provider events.
+ *
+ * Returns 0 or a negative error.
+ */
+int register_fwnode_pcs_notifier(struct notifier_block *nb);
+
 /**
  * fwnode_pcs_get - Retrieves a PCS from a firmware node
  * @fwnode: firmware node
@@ -20,6 +37,25 @@
 struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode,
 				   int index);
 
+/**
+ * fwnode_phylink_pcs_get_from_fwnode - Retrieves the PCS provided
+ *					by the firmware node from a
+ *					firmware node
+ * @fwnode: firmware node
+ * @pcs_fwnode: PCS firmware node
+ *
+ * Parse 'pcs-handle' in 'fwnode' and get the PCS that match
+ * 'pcs_fwnode' firmware node.
+ *
+ * Returns a pointer to the phylink_pcs or a negative
+ * error pointer. Can return -EPROBE_DEFER if the PCS is not
+ * present in global providers list (either due to driver
+ * still needs to be probed or it failed to probe/removed)
+ */
+struct phylink_pcs *
+fwnode_phylink_pcs_get_from_fwnode(struct fwnode_handle *fwnode,
+				   struct fwnode_handle *pcs_fwnode);
+
 /**
  * fwnode_phylink_pcs_parse - generic PCS parse for fwnode PCS provider
  * @fwnode: firmware node
@@ -39,12 +75,24 @@ int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
 			     struct phylink_pcs **available_pcs,
 			     unsigned int *num_pcs);
 #else
+static int register_fwnode_pcs_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode,
 						 int index)
 {
 	return ERR_PTR(-ENOENT);
 }
 
+static struct phylink_pcs *
+fwnode_phylink_pcs_get_from_fwnode(struct fwnode_handle *fwnode,
+				   struct fwnode_handle *pcs_fwnode)
+{
+	return ERR_PTR(-ENOENT);
+}
+
 static inline int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
 					   struct phylink_pcs **available_pcs,
 					   unsigned int *num_pcs)
-- 
2.48.1


