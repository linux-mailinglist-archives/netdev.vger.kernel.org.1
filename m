Return-Path: <netdev+bounces-167407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F81A3A281
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00F8188AC5B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7326FDAA;
	Tue, 18 Feb 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OZjeM5Gn"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826CD26E653;
	Tue, 18 Feb 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895568; cv=none; b=tplYOb11BW/T2FKQrXerfDTBkfuUAuWVeFom7yccvJd7kkGtmaXOZfXsZ+hMqj5aLak9LICUz44M7NCYKtCR2xro4eNpU+YEcKzLA8NFLHR+TaQpQpHDXMx1BVFc5SM8LK6wgTE0BJtGdVjiSaYF86VaOUR0H1ogjtx5gAP38C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895568; c=relaxed/simple;
	bh=DVdEIb3xvQxVkQCvfC7Ocp5UFddDH4E0ketTTDMnXBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NjLi92CGvDbI8tp1+Zb06j2E8aIuwh/aU7T+VgGvewrwJHxNSekUqhQkDx+Rn1yoZ7FTZgh8xTLtuMe5GJfPHYYlk0jXVerrWE66g0Eg+lMmQH0JwD75k3pCK+S8Ke6AdKwdIiLgqMV26CreoKh+ehIFS7W452bl5ofGgPCD1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OZjeM5Gn; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B28EF44314;
	Tue, 18 Feb 2025 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739895557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5ajaisYHOWX2NVmE3eoQ6jq4A3noA5wmqvLw9+zi3E=;
	b=OZjeM5GnZi/fPpJg7n2JIy9UdiFwnEAYB0YVBMxhuznWU5FvmocqREsBLUk5nyyOnBPEVE
	UIztgSyJmOFxLsfN46alUAc7jeB8ZhMLuBZvkC64Q+bdn4ye929feH8ULyoR8hYBCiONtz
	hUWf8jsm3S3o9rDLmDV7kJG+UgJ31ZEfy1Qe7jFuo3trg6T3yDHHl7Pb/NSK1GJ+I3XvpQ
	rl3dRDQr034vzJjKid+5ap5aSO3Z1tBBhzgsx6SsVCM8hWreiY8YRwO4gV07qwCaXGDa2a
	gQRAjEOeEnl5F0+69yK0besTsb1jnwcZP33u2trS1TWVmz3q+4GnSnEpTGoyhA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 18 Feb 2025 17:19:06 +0100
Subject: [PATCH net-next v5 02/12] net: pse-pd: Add support for reporting
 events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-feature_poe_port_prio-v5-2-3da486e5fd64@bootlin.com>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
In-Reply-To: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppedvrgdtudemtggstddumeeftdehfeemrgdvieeimeelvgeivgemleeisgdumegvsgguleemfhdtrgegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtudemfedtheefmegrvdeiieemlegviegvmeeliegsudemvggsugelmehftdgrgedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdehpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhuk
 hdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesphgvnhhguhhtrhhonhhigidruggv
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for devm_pse_irq_helper() to register PSE interrupts. This aims
to report events such as over-current or over-temperature conditions
similarly to how the regulator API handles them but using a specific PSE
ethtool netlink socket.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Change in v4:
- Fix netlink notification message issues.
- Use netlink bitset in ethtool_pse_send_ntf.
- Add kdoc.

Change in v3:
- Remove C33 prefix when it is not in the standards.
- Fix pse_to_regulator_notifs which could not report regulator events
  together.
- Fix deadlock issue.
- Save interrupt in pcdev structure for later use.

Change in v2:
- Add support for PSE ethtool notification.
- Saved the attached phy_device in the pse_control structure to know which
  interface should have the notification.
- Rethink devm_pse_irq_helper() without devm_regulator_irq_helper() call.
---
 Documentation/netlink/specs/ethtool.yaml       |  26 ++++
 Documentation/networking/ethtool-netlink.rst   |  19 +++
 drivers/net/mdio/fwnode_mdio.c                 |  26 ++--
 drivers/net/pse-pd/pse_core.c                  | 157 ++++++++++++++++++++++++-
 include/linux/ethtool_netlink.h                |   9 ++
 include/linux/pse-pd/pse.h                     |  24 +++-
 include/uapi/linux/ethtool.h                   |  17 +++
 include/uapi/linux/ethtool_netlink_generated.h |  10 ++
 net/ethtool/common.c                           |   6 +
 net/ethtool/common.h                           |   2 +
 net/ethtool/pse-pd.c                           |  53 +++++++++
 net/ethtool/strset.c                           |   5 +
 12 files changed, 337 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 655d8d10fe24..da78c5daf537 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1526,6 +1526,22 @@ attribute-sets:
         name: hwtstamp-flags
         type: nest
         nested-attributes: bitset
+  -
+    name: pse-ntf
+    attr-cnt-name: __ethtool-a-pse-ntf-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: events
+        type: nest
+        nested-attributes: bitset
 
 operations:
   enum-model: directional
@@ -2382,3 +2398,13 @@ operations:
           attributes: *tsconfig
         reply:
           attributes: *tsconfig
+    -
+      name: pse-ntf
+      doc: Notification for pse events.
+
+      attribute-set: pse-ntf
+
+      event:
+        attributes:
+          - header
+          - events
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 3770a2294509..9fc5e29b3928 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -290,6 +290,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_PHY_NTF``                  Ethernet PHY information change
   ``ETHTOOL_MSG_TSCONFIG_GET_REPLY``       hw timestamping configuration
   ``ETHTOOL_MSG_TSCONFIG_SET_REPLY``       new hw timestamping configuration
+  ``ETHTOOL_MSG_PSE_NTF``                  PSE events notification
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -1896,6 +1897,24 @@ various existing products that document power consumption in watts rather than
 classes. If power limit configuration based on classes is needed, the
 conversion can be done in user space, for example by ethtool.
 
+PSE_NTF
+=======
+
+Notify PSE events.
+
+Notification contents:
+
+  ===============================  ======  ========================
+  ``ETHTOOL_A_PSE_HEADER``         nested  request header
+  ``ETHTOOL_A_PSE_EVENTS``         bitset  PSE events
+  ===============================  ======  ========================
+
+When set, the optional ``ETHTOOL_A_PSE_EVENTS`` attribute identifies the
+PSE events.
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_pse_events
+
 RSS_GET
 =======
 
diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index aea0f0357568..9b41d4697a40 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -18,7 +18,8 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
 
 static struct pse_control *
-fwnode_find_pse_control(struct fwnode_handle *fwnode)
+fwnode_find_pse_control(struct fwnode_handle *fwnode,
+			struct phy_device *phydev)
 {
 	struct pse_control *psec;
 	struct device_node *np;
@@ -30,7 +31,7 @@ fwnode_find_pse_control(struct fwnode_handle *fwnode)
 	if (!np)
 		return NULL;
 
-	psec = of_pse_control_get(np);
+	psec = of_pse_control_get(np, phydev);
 	if (PTR_ERR(psec) == -ENOENT)
 		return NULL;
 
@@ -128,15 +129,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	u32 phy_id;
 	int rc;
 
-	psec = fwnode_find_pse_control(child);
-	if (IS_ERR(psec))
-		return PTR_ERR(psec);
-
 	mii_ts = fwnode_find_mii_timestamper(child);
-	if (IS_ERR(mii_ts)) {
-		rc = PTR_ERR(mii_ts);
-		goto clean_pse;
-	}
+	if (IS_ERR(mii_ts))
+		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
 	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
@@ -169,6 +164,12 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 			goto clean_phy;
 	}
 
+	psec = fwnode_find_pse_control(child, phy);
+	if (IS_ERR(psec)) {
+		rc = PTR_ERR(psec);
+		goto unregister_phy;
+	}
+
 	phy->psec = psec;
 
 	/* phy->mii_ts may already be defined by the PHY driver. A
@@ -180,12 +181,13 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	return 0;
 
+unregister_phy:
+	if (is_acpi_node(child) || is_of_node(child))
+		phy_device_remove(phy);
 clean_phy:
 	phy_device_free(phy);
 clean_mii_ts:
 	unregister_mii_timestamper(mii_ts);
-clean_pse:
-	pse_control_put(psec);
 
 	return rc;
 }
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 4602e26eb8c8..10a5ab30afdd 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/of.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/regulator/driver.h>
@@ -23,6 +24,7 @@ static LIST_HEAD(pse_controller_list);
  * @list: list entry for the pcdev's PSE controller list
  * @id: ID of the PSE line in the PSE controller device
  * @refcnt: Number of gets of this pse_control
+ * @attached_phydev: PHY device pointer attached by the PSE control
  */
 struct pse_control {
 	struct pse_controller_dev *pcdev;
@@ -30,6 +32,7 @@ struct pse_control {
 	struct list_head list;
 	unsigned int id;
 	struct kref refcnt;
+	struct phy_device *attached_phydev;
 };
 
 static int of_load_single_pse_pi_pairset(struct device_node *node,
@@ -557,6 +560,151 @@ int devm_pse_controller_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pse_controller_register);
 
+struct pse_irq {
+	struct pse_controller_dev *pcdev;
+	struct pse_irq_desc desc;
+	unsigned long *notifs;
+};
+
+/**
+ * pse_to_regulator_notifs - Convert PSE notifications to Regulator
+ *			     notifications
+ * @notifs: PSE notifications
+ *
+ * Return: Regulator notifications
+ */
+static unsigned long pse_to_regulator_notifs(unsigned long notifs)
+{
+	unsigned long rnotifs = 0;
+
+	if (notifs & ETHTOOL_PSE_EVENT_OVER_CURRENT)
+		rnotifs |= REGULATOR_EVENT_OVER_CURRENT;
+	if (notifs & ETHTOOL_PSE_EVENT_OVER_TEMP)
+		rnotifs |= REGULATOR_EVENT_OVER_TEMP;
+
+	return rnotifs;
+}
+
+/**
+ * pse_control_find_phy_by_id - Find PHY attached to the a pse control id
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ *
+ * Return: PHY device pointer or NULL
+ */
+static struct phy_device *
+pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
+{
+	struct pse_control *psec;
+
+	mutex_lock(&pse_list_mutex);
+	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
+		if (psec->id == id) {
+			mutex_unlock(&pse_list_mutex);
+			return psec->attached_phydev;
+		}
+	}
+	mutex_unlock(&pse_list_mutex);
+
+	return NULL;
+}
+
+/**
+ * pse_isr - IRQ handler for PSE
+ * @irq: irq number
+ * @data: pointer to user interrupt structure
+ *
+ * Return: irqreturn_t - status of IRQ
+ */
+static irqreturn_t pse_isr(int irq, void *data)
+{
+	struct netlink_ext_ack extack = {};
+	struct pse_controller_dev *pcdev;
+	unsigned long notifs_mask = 0;
+	struct pse_irq_desc *desc;
+	struct pse_irq *h = data;
+	int ret, i;
+
+	desc = &h->desc;
+	pcdev = h->pcdev;
+
+	/* Clear notifs mask */
+	memset(h->notifs, 0, pcdev->nr_lines * sizeof(*h->notifs));
+	mutex_lock(&pcdev->lock);
+	ret = desc->map_event(irq, pcdev, h->notifs, &notifs_mask);
+	mutex_unlock(&pcdev->lock);
+	if (ret || !notifs_mask)
+		return IRQ_NONE;
+
+	for_each_set_bit(i, &notifs_mask, pcdev->nr_lines) {
+		struct phy_device *phydev;
+		unsigned long notifs, rnotifs;
+
+		/* Do nothing PI not described */
+		if (!pcdev->pi[i].rdev)
+			continue;
+
+		notifs = h->notifs[i];
+		dev_dbg(h->pcdev->dev,
+			"Sending PSE notification EVT 0x%lx\n", notifs);
+
+		phydev = pse_control_find_phy_by_id(pcdev, i);
+		if (phydev)
+			ethnl_pse_send_ntf(phydev, notifs, &extack);
+		rnotifs = pse_to_regulator_notifs(notifs);
+		regulator_notifier_call_chain(pcdev->pi[i].rdev, rnotifs,
+					      NULL);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * devm_pse_irq_helper - Register IRQ based PSE event notifier
+ *
+ * @pcdev: a pointer to the PSE
+ * @irq: the irq value to be passed to request_irq
+ * @irq_flags: the flags to be passed to request_irq
+ * @d: PSE interrupt description
+ *
+ * Return: 0 on success and failure value on error
+ */
+int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
+			int irq_flags, const struct pse_irq_desc *d)
+{
+	struct device *dev = pcdev->dev;
+	struct pse_irq *h;
+	int ret;
+
+	if (!d || !d->map_event || !d->name)
+		return -EINVAL;
+
+	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+
+	h->pcdev = pcdev;
+	h->desc = *d;
+	h->desc.name = devm_kstrdup(dev, d->name, GFP_KERNEL);
+	if (!h->desc.name)
+		return -ENOMEM;
+
+	h->notifs = devm_kcalloc(pcdev->dev, pcdev->nr_lines,
+				 sizeof(*h->notifs), GFP_KERNEL);
+	if (!h->notifs)
+		return -ENOMEM;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pse_isr,
+					IRQF_ONESHOT | irq_flags,
+					h->desc.name, h);
+	if (ret)
+		dev_err(pcdev->dev, "Failed to request IRQ %d\n", irq);
+
+	pcdev->irq = irq;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_pse_irq_helper);
+
 /* PSE control section */
 
 static void __pse_control_release(struct kref *kref)
@@ -599,7 +747,8 @@ void pse_control_put(struct pse_control *psec)
 EXPORT_SYMBOL_GPL(pse_control_put);
 
 static struct pse_control *
-pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
+pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
+			 struct phy_device *phydev)
 {
 	struct pse_control *psec;
 	int ret;
@@ -638,6 +787,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 	psec->pcdev = pcdev;
 	list_add(&psec->list, &pcdev->pse_control_head);
 	psec->id = index;
+	psec->attached_phydev = phydev;
 	kref_init(&psec->refcnt);
 
 	return psec;
@@ -693,7 +843,8 @@ static int psec_id_xlate(struct pse_controller_dev *pcdev,
 	return pse_spec->args[0];
 }
 
-struct pse_control *of_pse_control_get(struct device_node *node)
+struct pse_control *of_pse_control_get(struct device_node *node,
+				       struct phy_device *phydev)
 {
 	struct pse_controller_dev *r, *pcdev;
 	struct of_phandle_args args;
@@ -743,7 +894,7 @@ struct pse_control *of_pse_control_get(struct device_node *node)
 	}
 
 	/* pse_list_mutex also protects the pcdev's pse_control list */
-	psec = pse_control_get_internal(pcdev, psec_id);
+	psec = pse_control_get_internal(pcdev, psec_id, phydev);
 
 out:
 	mutex_unlock(&pse_list_mutex);
diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
index aba91335273a..0fa1d8f59cf2 100644
--- a/include/linux/ethtool_netlink.h
+++ b/include/linux/ethtool_netlink.h
@@ -43,6 +43,9 @@ void ethtool_aggregate_rmon_stats(struct net_device *dev,
 				  struct ethtool_rmon_stats *rmon_stats);
 bool ethtool_dev_mm_supported(struct net_device *dev);
 
+void ethnl_pse_send_ntf(struct phy_device *phydev, unsigned long notif,
+			struct netlink_ext_ack *extack);
+
 #else
 static inline int ethnl_cable_test_alloc(struct phy_device *phydev, u8 cmd)
 {
@@ -120,6 +123,12 @@ static inline bool ethtool_dev_mm_supported(struct net_device *dev)
 	return false;
 }
 
+static inline void ethnl_pse_send_ntf(struct phy_device *phydev,
+				      unsigned long notif,
+				      struct netlink_ext_ack *extack)
+{
+}
+
 #endif /* IS_ENABLED(CONFIG_ETHTOOL_NETLINK) */
 
 static inline int ethnl_cable_test_result(struct phy_device *phydev, u8 pair,
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index c773eeb92d04..5d41a1c984bd 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -7,6 +7,7 @@
 
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
+#include <linux/regulator/driver.h>
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
@@ -37,6 +38,19 @@ struct ethtool_c33_pse_pw_limit_range {
 	u32 max;
 };
 
+/**
+ * struct pse_irq_desc - notification sender description for IRQ based events.
+ *
+ * @name: the visible name for the IRQ
+ * @map_event: driver callback to map IRQ status into PSE devices with events.
+ */
+struct pse_irq_desc {
+	const char *name;
+	int (*map_event)(int irq, struct pse_controller_dev *pcdev,
+			 unsigned long *notifs,
+			 unsigned long *notifs_mask);
+};
+
 /**
  * struct pse_control_config - PSE control/channel configuration.
  *
@@ -228,6 +242,7 @@ struct pse_pi {
  * @types: types of the PSE controller
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
+ * @irq: PSE interrupt
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -241,6 +256,7 @@ struct pse_controller_dev {
 	enum ethtool_pse_types types;
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
+	int irq;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -249,8 +265,11 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev);
 struct device;
 int devm_pse_controller_register(struct device *dev,
 				 struct pse_controller_dev *pcdev);
+int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
+			int irq_flags, const struct pse_irq_desc *d);
 
-struct pse_control *of_pse_control_get(struct device_node *node);
+struct pse_control *of_pse_control_get(struct device_node *node,
+				       struct phy_device *phydev);
 void pse_control_put(struct pse_control *psec);
 
 int pse_ethtool_get_status(struct pse_control *psec,
@@ -268,7 +287,8 @@ bool pse_has_c33(struct pse_control *psec);
 
 #else
 
-static inline struct pse_control *of_pse_control_get(struct device_node *node)
+static inline struct pse_control *of_pse_control_get(struct device_node *node,
+						     struct phy_device *phydev)
 {
 	return ERR_PTR(-ENOENT);
 }
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 2feba0929a8a..8793946ff851 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -683,6 +683,7 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_RMON: names of RMON statistics
  * @ETH_SS_STATS_PHY: names of PHY(dev) statistics
  * @ETH_SS_TS_FLAGS: hardware timestamping flags
+ * @ETH_SS_PSE_EVENTS: names of PSE events
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -710,6 +711,7 @@ enum ethtool_stringset {
 	ETH_SS_STATS_RMON,
 	ETH_SS_STATS_PHY,
 	ETH_SS_TS_FLAGS,
+	ETH_SS_PSE_EVENTS,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
@@ -1002,6 +1004,21 @@ enum ethtool_c33_pse_pw_d_status {
 	ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT,
 };
 
+/**
+ * enum ethtool_pse_events - event list of the PSE controller.
+ * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
+ * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
+ *
+ * @ETHTOOL_PSE_EVENT_LAST: Last PSE event of the enum.
+ */
+
+enum ethtool_pse_events {
+	ETHTOOL_PSE_EVENT_OVER_CURRENT =	1 << 0,
+	ETHTOOL_PSE_EVENT_OVER_TEMP =		1 << 1,
+
+	ETHTOOL_PSE_EVENT_LAST = ETHTOOL_PSE_EVENT_OVER_TEMP,
+};
+
 /**
  * enum ethtool_podl_pse_admin_state - operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index fe24c3459ac0..f03b51766311 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -709,6 +709,15 @@ enum {
 	ETHTOOL_A_TSCONFIG_MAX = (__ETHTOOL_A_TSCONFIG_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PSE_NTF_UNSPEC,
+	ETHTOOL_A_PSE_NTF_HEADER,
+	ETHTOOL_A_PSE_NTF_EVENTS,
+
+	__ETHTOOL_A_PSE_NTF_CNT,
+	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -813,6 +822,7 @@ enum {
 	ETHTOOL_MSG_PHY_NTF,
 	ETHTOOL_MSG_TSCONFIG_GET_REPLY,
 	ETHTOOL_MSG_TSCONFIG_SET_REPLY,
+	ETHTOOL_MSG_PSE_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7149d07e90c6..8d207ec6456e 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -517,6 +517,12 @@ const char udp_tunnel_type_names[][ETH_GSTRING_LEN] = {
 static_assert(ARRAY_SIZE(udp_tunnel_type_names) ==
 	      __ETHTOOL_UDP_TUNNEL_TYPE_CNT);
 
+const char pse_event_names[][ETH_GSTRING_LEN] = {
+	[const_ilog2(ETHTOOL_PSE_EVENT_OVER_CURRENT)] = "over-current",
+	[const_ilog2(ETHTOOL_PSE_EVENT_OVER_TEMP)] = "over-temperature",
+};
+static_assert(ARRAY_SIZE(pse_event_names) == __PSE_EVENT_CNT);
+
 /* return false if legacy contained non-0 deprecated fields
  * maxtxpkt/maxrxpkt. rest of ksettings always updated
  */
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 58e9e7db06f9..edef4c230cf1 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -14,6 +14,7 @@
 
 #define __SOF_TIMESTAMPING_CNT (const_ilog2(SOF_TIMESTAMPING_LAST) + 1)
 #define __HWTSTAMP_FLAG_CNT (const_ilog2(HWTSTAMP_FLAG_LAST) + 1)
+#define __PSE_EVENT_CNT (const_ilog2(ETHTOOL_PSE_EVENT_LAST) + 1)
 
 struct link_mode_info {
 	int				speed;
@@ -41,6 +42,7 @@ extern const char ts_tx_type_names[][ETH_GSTRING_LEN];
 extern const char ts_rx_filter_names[][ETH_GSTRING_LEN];
 extern const char ts_flags_names[][ETH_GSTRING_LEN];
 extern const char udp_tunnel_type_names[][ETH_GSTRING_LEN];
+extern const char pse_event_names[][ETH_GSTRING_LEN];
 
 int __ethtool_get_link(struct net_device *dev);
 
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2819e2ba6be2..e471e577d4b6 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -12,6 +12,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include "bitset.h"
 
 struct pse_req_info {
 	struct ethnl_req_info base;
@@ -315,3 +316,55 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
 	.set			= ethnl_set_pse,
 	/* PSE has no notification */
 };
+
+void ethnl_pse_send_ntf(struct phy_device *phydev, unsigned long notifs,
+			struct netlink_ext_ack *extack)
+{
+	struct net_device *netdev = phydev->attached_dev;
+	struct genl_info info;
+	void *reply_payload;
+	struct sk_buff *skb;
+	int reply_len;
+	int ret;
+
+	if (!netdev || !notifs)
+		return;
+
+	ethnl_info_init_ntf(&info, ETHTOOL_MSG_PSE_NTF);
+	info.extack = extack;
+
+	reply_len = ethnl_reply_header_size();
+	/* _C33_PSE_NTF_EVENTS */
+	ret = ethnl_bitset_size(&notifs, NULL, __PSE_EVENT_CNT,
+				pse_event_names, 0);
+	if (ret < 0)
+		return;
+
+	reply_len += ret;
+	skb = genlmsg_new(reply_len, GFP_KERNEL);
+	reply_payload = ethnl_bcastmsg_put(skb, ETHTOOL_MSG_PSE_NTF);
+	if (!reply_payload)
+		goto err_skb;
+
+	ret = ethnl_fill_reply_header(skb, netdev,
+				      ETHTOOL_A_PSE_NTF_HEADER);
+	if (ret < 0)
+		goto err_skb;
+
+	ret = ethnl_put_bitset(skb, ETHTOOL_A_PSE_NTF_EVENTS, &notifs,
+			       NULL, __PSE_EVENT_CNT, pse_event_names, 0);
+	if (ret) {
+		WARN_ONCE(ret == -EMSGSIZE,
+			  "calculated message payload length (%d) not sufficient\n",
+			  reply_len);
+		goto err_skb;
+	}
+
+	genlmsg_end(skb, reply_payload);
+	ethnl_multicast(skb, netdev);
+	return;
+
+err_skb:
+	nlmsg_free(skb);
+}
+EXPORT_SYMBOL_GPL(ethnl_pse_send_ntf);
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index 6b76c05caba4..b71392fa9129 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -115,6 +115,11 @@ static const struct strset_info info_template[] = {
 		.count		= __ETHTOOL_A_STATS_PHY_CNT,
 		.strings	= stats_phy_names,
 	},
+	[ETH_SS_PSE_EVENTS] = {
+		.per_dev	= false,
+		.count		= __PSE_EVENT_CNT,
+		.strings	= pse_event_names,
+	},
 };
 
 struct strset_req_info {

-- 
2.34.1


