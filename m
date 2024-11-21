Return-Path: <netdev+bounces-146664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F29D4EF6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CF1F21CCB
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5D1DF98A;
	Thu, 21 Nov 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QuCwusy7"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E011DF74C;
	Thu, 21 Nov 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200241; cv=none; b=ur/HU/zP84r6itfIt8Ri15jUK0r74XP7PvFfiav+YQY0gPXKYUt3wKRg5itfDVt4qIuz3E09IDBELmXcJ4g/DQiV8GAJdVp+VdEzqaWe8agcd4FXhGDqj7vYN/fVzGuoTQ8lD0AzjKnZ97fTRQn4+Wvib92pBwdW5RWn4GcY6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200241; c=relaxed/simple;
	bh=OVOfaZFZVSk9ljv9ZOCPW4tDpDDQDn5SpqypUiNhPME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pC2IFlXZRzk8BNIInZC565un7xDLTnOe86tCvXoaUOha6zvMZqpYJvrzGrkzDQXi+bYTDALUDW1BlVBijDX79Nrh+kkrTIkbmO8BL5qnwO9Eu2+HKO/KmFFWrri1VQFjCwKzuzaTHovXMQSAtZSC6mtjtsEBWgb7peRmPDn5Z+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QuCwusy7; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F94540009;
	Thu, 21 Nov 2024 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBYfM8Qow2vJ/07+gWETNGXed90ocsCYB+Bq/z8BBNo=;
	b=QuCwusy7FyNROlrYqZUHOKV/wUMfKrrpKRxtytIv8UEvog2FSSEjZVT/lOxIoFz5x0Z4c2
	J7H9hwp6wmYpr2R77xz3sEv/xWDgVG89e56e4dqRcShpLlr63dDumGRZ7z3ffgprbr8EVZ
	0CY9YtJ/rVWQi0LXZaRdaqrcmz6Gz3BshhYn+Cwqpr8+4v718ZYt9FHY9CdPRz4dIi2dvp
	KDjoboCrIhNPosp6mczyds6xhtLwf/88Vq0lQ0bgzQkqSO/YKRZ1zIX56gfrniUxeG3n3M
	L58tkGwnOlfYLSZYt8J51C+y1dQRZmieE5fkjtqVy6LhKizAKDtzfdnrkrVZMg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:38 +0100
Subject: [PATCH RFC net-next v3 12/27] net: pse-pd: Add support for
 reporting events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-12-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for devm_pse_irq_helper() to register PSE interrupts. This aims
to report events such as over-current or over-temperature conditions
similarly to how the regulator API handles them but using a specific PSE
ethtool netlink socket.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

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
 drivers/net/mdio/fwnode_mdio.c       |  26 ++++----
 drivers/net/pse-pd/pse_core.c        | 126 ++++++++++++++++++++++++++++++++++-
 include/linux/ethtool_netlink.h      |   9 +++
 include/linux/pse-pd/pse.h           |  18 ++++-
 include/uapi/linux/ethtool.h         |  11 +++
 include/uapi/linux/ethtool_netlink.h |  11 +++
 net/ethtool/pse-pd.c                 |  46 +++++++++++++
 7 files changed, 230 insertions(+), 17 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index b156493d7084..7d571895a8eb 100644
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
 
@@ -121,15 +122,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
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
@@ -162,6 +157,12 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
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
@@ -173,12 +174,13 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
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
index 411868bccbcc..8b5a9e7fd9c5 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -6,6 +6,7 @@
 //
 
 #include <linux/device.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/of.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/regulator/driver.h>
@@ -23,6 +24,7 @@ static DEFINE_IDA(pse_ida);
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
@@ -553,6 +556,120 @@ int devm_pse_controller_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pse_controller_register);
 
+struct pse_irq {
+	struct pse_controller_dev *pcdev;
+	struct pse_irq_desc desc;
+	unsigned long *notifs;
+};
+
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
@@ -595,7 +712,8 @@ void pse_control_put(struct pse_control *psec)
 EXPORT_SYMBOL_GPL(pse_control_put);
 
 static struct pse_control *
-pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
+pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
+			 struct phy_device *phydev)
 {
 	struct pse_control *psec;
 	int ret;
@@ -634,6 +752,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 	psec->pcdev = pcdev;
 	list_add(&psec->list, &pcdev->pse_control_head);
 	psec->id = index;
+	psec->attached_phydev = phydev;
 	kref_init(&psec->refcnt);
 
 	return psec;
@@ -689,7 +808,8 @@ static int psec_id_xlate(struct pse_controller_dev *pcdev,
 	return pse_spec->args[0];
 }
 
-struct pse_control *of_pse_control_get(struct device_node *node)
+struct pse_control *of_pse_control_get(struct device_node *node,
+				       struct phy_device *phydev)
 {
 	struct pse_controller_dev *r, *pcdev;
 	struct of_phandle_args args;
@@ -739,7 +859,7 @@ struct pse_control *of_pse_control_get(struct device_node *node)
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
index f2294a1d9b58..be6e967f9ac3 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -8,6 +8,7 @@
 #include <linux/ethtool.h>
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
+#include <linux/regulator/driver.h>
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
@@ -17,6 +18,13 @@
 struct phy_device;
 struct pse_controller_dev;
 
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
@@ -155,6 +163,7 @@ struct pse_pi {
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
  * @id: Index of the PSE
+ * @irq: PSE interrupt
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -169,6 +178,7 @@ struct pse_controller_dev {
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
 	u32 id;
+	int irq;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -177,8 +187,11 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev);
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
@@ -196,7 +209,8 @@ bool pse_has_c33(struct pse_control *psec);
 
 #else
 
-static inline struct pse_control *of_pse_control_get(struct device_node *node)
+static inline struct pse_control *of_pse_control_get(struct device_node *node,
+						     struct phy_device *phydev)
 {
 	return ERR_PTR(-ENOENT);
 }
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index fc1f54b065f9..a4c93d6de218 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -998,6 +998,17 @@ enum ethtool_c33_pse_pw_d_status {
 	ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT,
 };
 
+/**
+ * enum ethtool_pse_events - event list of the PSE controller.
+ * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
+ * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
+ */
+
+enum ethtool_pse_events {
+	ETHTOOL_PSE_EVENT_OVER_CURRENT =	1 << 0,
+	ETHTOOL_PSE_EVENT_OVER_TEMP =		1 << 1,
+};
+
 /**
  * enum ethtool_podl_pse_admin_state - operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 9a4c293a9a82..91c1bd9349b0 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -114,6 +114,7 @@ enum {
 	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
 	ETHTOOL_MSG_PHY_GET_REPLY,
 	ETHTOOL_MSG_PHY_NTF,
+	ETHTOOL_MSG_PSE_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -977,6 +978,16 @@ enum {
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
 };
 
+/* PSE NOTIFY */
+enum {
+	ETHTOOL_A_PSE_NTF_UNSPEC,
+	ETHTOOL_A_PSE_NTF_HEADER,	/* nest - ETHTOOL_A_HEADER_* */
+	ETHTOOL_A_PSE_NTF_EVENTS,	/* u32 */
+
+	__ETHTOOL_A_PSE_NTF_CNT,
+	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
+};
+
 enum {
 	ETHTOOL_A_RSS_UNSPEC,
 	ETHTOOL_A_RSS_HEADER,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 5edb8b0a669e..19ab6bd35ad4 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -319,3 +319,49 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
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
+	ethnl_info_init_ntf(&info, ETHTOOL_MSG_MM_NTF);
+	info.extack = extack;
+
+	reply_len = ethnl_reply_header_size();
+	/* _C33_PSE_NTF_EVENTS */
+	reply_len += nla_total_size(sizeof(u32));
+	skb = genlmsg_new(reply_len, GFP_KERNEL);
+	reply_payload = ethnl_bcastmsg_put(skb, ETHTOOL_MSG_MM_NTF);
+	if (!reply_payload)
+		goto err_skb;
+
+	ret = ethnl_fill_reply_header(skb, netdev,
+				      ETHTOOL_A_PSE_NTF_HEADER);
+	if (ret < 0)
+		goto err_skb;
+
+	ret = nla_put_u32(skb, ETHTOOL_A_PSE_NTF_EVENTS, notifs);
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

-- 
2.34.1


