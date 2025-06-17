Return-Path: <netdev+bounces-198559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6552ADCAB9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDCD1639AA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1DE2E7639;
	Tue, 17 Jun 2025 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QBGoXRga"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669022DF3C7;
	Tue, 17 Jun 2025 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162346; cv=none; b=JOtAFzWPojoESdhNEwLhsEmqNhavSA+AeQ0wrdGegKY0WgoCNbuPF13asp0N9U7G91umht/ecOF69wqNFcKKkzJfxhXKd+2wQuwwEpE3pB6C6c/QMzbC6iSAS2l6uc4DDhIHd3+qoEnTqh8O5QoAYg6NCjLHG1D69VmBazVlenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162346; c=relaxed/simple;
	bh=mGW3LND7KheYJukE6oCnQChuQ/QYa6VL5eTf2yD0iKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSN0BLsPyifWzmtLUfxLE/cGqOoi7Rlxqa2rZdOMf/KCvJuIEf9zotx1WCIk3uzlUrNy+unZIJLfKtX4zEzX4belFJ2qTr5Z2Rz95sGOBzg+UqP37F5xM82NrF6pYW+qrmbSAf5w+ygZKNk2jzant6Do3HMflvDnYXtcWAaUz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QBGoXRga; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F905432ED;
	Tue, 17 Jun 2025 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750162336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6odeFilFysMrSS1RYUzNyZXM8YKdUkfw9w1rYfqtfI=;
	b=QBGoXRgaO22rAsx7Wl+Lzv045ptw1CCMyQTd53LAmlOvpLAX/Szz6uwndIOpi348LgA201
	Sm8y3ib0143VhYTbP/X9WPVIFQTdNOYrsvOUbDodGSz1TuIcp0RI1rAgfeu5zgb68VN8tb
	AlGZp8C8Nk6Y0xBWQUwaUC4suvwp+qS3QwWFT0PhdZNmWEDGx8GDXU1a5xYH5BydBj8i80
	uQ5vy2g9/nexY+DAU6e5i2iinuiJTaZzv+iguB1TK0Krlb2vDRUpHnmwRC9Z+7flgoamcy
	hkj46v4OkMAwHgrkmLBMGiKR803+noYDuQNx7EaFBhk00B9VPJ4n9l42ASMTZA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 17 Jun 2025 14:12:01 +0200
Subject: [PATCH net-next v14 02/13] net: pse-pd: Add support for reporting
 events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-feature_poe_port_prio-v14-2-78a1a645e2ee@bootlin.com>
References: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
In-Reply-To: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for devm_pse_irq_helper() to register PSE interrupts and report
events such as over-current or over-temperature conditions. This follows a
similar approach to the regulator API but also sends notifications using a
dedicated PSE ethtool netlink socket.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Change in v14:
- Move ethnl_pse_send_ntf() under rtnl_lock following Jakub suggestion.
- Add pse_control_get_netdev() helper.
- Remove useless extack.
- Removed Oleksij reviewed-by due to few code change.

Change in v12:
- Rebase on net next.

Change in v11:
- Split the part that add attached_phydev to another patch.
- Fully describe the PSE events in the ethtool spec.
- Made small fixes reported by Jakub in the ethnl_pse_send_ntf.

Change in v10:
- Removed Oleksij reviewed-by due to few code change.
- Take a reference of the netdev pointer to avoid any use after free in
  the ethnl_pse_send_ntf function.

Change in v9:
- Add a missing check after skb creation.

Change in v7:
- Use flags definition for pse events in ethtool specs.
- Change irq name by prepending the device name.

Change in v6:
- Update pse-ntf netlink to u32 instead of bitset.
- Update commit message.

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
 Documentation/netlink/specs/ethtool.yaml       |  34 +++++
 Documentation/networking/ethtool-netlink.rst   |  19 +++
 drivers/net/pse-pd/pse_core.c                  | 179 +++++++++++++++++++++++++
 include/linux/ethtool_netlink.h                |   7 +
 include/linux/pse-pd/pse.h                     |  20 +++
 include/uapi/linux/ethtool_netlink_generated.h |  19 +++
 net/ethtool/pse-pd.c                           |  39 ++++++
 7 files changed, 317 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index ed9bcdec01cc..92b34a19f308 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -118,6 +118,17 @@ definitions:
         doc: |
           Hardware timestamp comes from one PHY device
           of the network topology
+  -
+    name: pse-event
+    doc: PSE event list for the PSE controller
+    type: flags
+    entries:
+      -
+        name: over-current
+        doc: PSE output current is too high
+      -
+        name: over-temp
+        doc: PSE in over temperature state
 
 attribute-sets:
   -
@@ -1555,6 +1566,19 @@ attribute-sets:
         name: hwtstamp-flags
         type: nest
         nested-attributes: bitset
+  -
+    name: pse-ntf
+    attr-cnt-name: --ethtool-a-pse-ntf-cnt
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: events
+        type: uint
+        enum: pse-event
+        doc: List of events reported by the PSE controller
 
 operations:
   enum-model: directional
@@ -2413,3 +2437,13 @@ operations:
           attributes: *tsconfig
         reply:
           attributes: *tsconfig
+    -
+      name: pse-ntf
+      doc: Notification for PSE events.
+
+      attribute-set: pse-ntf
+
+      event:
+        attributes:
+          - header
+          - events
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b6e9af4d0f1b..433737865bc2 100644
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
+.. kernel-doc:: include/uapi/linux/ethtool_netlink_generated.h
+    :identifiers: ethtool_pse_event
+
 RSS_GET
 =======
 
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 4610c1f0ddd6..16cc1dc07246 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -7,10 +7,14 @@
 
 #include <linux/device.h>
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/of.h>
+#include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/rtnetlink.h>
+#include <net/net_trackers.h>
 
 static DEFINE_MUTEX(pse_list_mutex);
 static LIST_HEAD(pse_controller_list);
@@ -210,6 +214,48 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+/**
+ * pse_control_find_net_by_id - Find net attached to the pse control id
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ *
+ * Return: pse_control pointer or NULL. The device returned has had a
+ *	   reference added and the pointer is safe until the user calls
+ *	   pse_control_put() to indicate they have finished with it.
+ */
+static struct pse_control *
+pse_control_find_by_id(struct pse_controller_dev *pcdev, int id)
+{
+	struct pse_control *psec;
+
+	mutex_lock(&pse_list_mutex);
+	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
+		if (psec->id == id) {
+			kref_get(&psec->refcnt);
+			mutex_unlock(&pse_list_mutex);
+			return psec;
+		}
+	}
+	mutex_unlock(&pse_list_mutex);
+	return NULL;
+}
+
+/**
+ * pse_control_get_netdev - Return netdev associated to a PSE control
+ * @psec: PSE control pointer
+ *
+ * Return: netdev pointer or NULL
+ */
+static struct net_device *pse_control_get_netdev(struct pse_control *psec)
+{
+	ASSERT_RTNL();
+
+	if (!psec || !psec->attached_phydev)
+		return NULL;
+
+	return psec->attached_phydev->attached_dev;
+}
+
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
@@ -559,6 +605,139 @@ int devm_pse_controller_register(struct device *dev,
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
+ * pse_isr - IRQ handler for PSE
+ * @irq: irq number
+ * @data: pointer to user interrupt structure
+ *
+ * Return: irqreturn_t - status of IRQ
+ */
+static irqreturn_t pse_isr(int irq, void *data)
+{
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
+		unsigned long notifs, rnotifs;
+		struct net_device *netdev;
+		struct pse_control *psec;
+
+		/* Do nothing PI not described */
+		if (!pcdev->pi[i].rdev)
+			continue;
+
+		notifs = h->notifs[i];
+		dev_dbg(h->pcdev->dev,
+			"Sending PSE notification EVT 0x%lx\n", notifs);
+
+		psec = pse_control_find_by_id(pcdev, i);
+		rtnl_lock();
+		netdev = pse_control_get_netdev(psec);
+		if (netdev)
+			ethnl_pse_send_ntf(netdev, notifs);
+		rtnl_unlock();
+		pse_control_put(psec);
+
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
+ * @pcdev: a pointer to the PSE
+ * @irq: the irq value to be passed to request_irq
+ * @irq_flags: the flags to be passed to request_irq
+ * @d: PSE interrupt description
+ *
+ * Return: 0 on success and errno on failure
+ */
+int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
+			int irq_flags, const struct pse_irq_desc *d)
+{
+	struct device *dev = pcdev->dev;
+	size_t irq_name_len;
+	struct pse_irq *h;
+	char *irq_name;
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
+
+	/* IRQ name len is pcdev dev name + 5 char + irq desc name + 1 */
+	irq_name_len = strlen(dev_name(pcdev->dev)) + 5 + strlen(d->name) + 1;
+	irq_name = devm_kzalloc(dev, irq_name_len, GFP_KERNEL);
+	if (!irq_name)
+		return -ENOMEM;
+
+	snprintf(irq_name, irq_name_len, "pse-%s:%s", dev_name(pcdev->dev),
+		 d->name);
+
+	h->notifs = devm_kcalloc(dev, pcdev->nr_lines,
+				 sizeof(*h->notifs), GFP_KERNEL);
+	if (!h->notifs)
+		return -ENOMEM;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pse_isr,
+					IRQF_ONESHOT | irq_flags,
+					irq_name, h);
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
diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
index aba91335273a..1dcc4059b5ab 100644
--- a/include/linux/ethtool_netlink.h
+++ b/include/linux/ethtool_netlink.h
@@ -43,6 +43,8 @@ void ethtool_aggregate_rmon_stats(struct net_device *dev,
 				  struct ethtool_rmon_stats *rmon_stats);
 bool ethtool_dev_mm_supported(struct net_device *dev);
 
+void ethnl_pse_send_ntf(struct net_device *netdev, unsigned long notif);
+
 #else
 static inline int ethnl_cable_test_alloc(struct phy_device *phydev, u8 cmd)
 {
@@ -120,6 +122,11 @@ static inline bool ethtool_dev_mm_supported(struct net_device *dev)
 	return false;
 }
 
+static inline void ethnl_pse_send_ntf(struct phy_device *phydev,
+				      unsigned long notif)
+{
+}
+
 #endif /* IS_ENABLED(CONFIG_ETHTOOL_NETLINK) */
 
 static inline int ethnl_cable_test_result(struct phy_device *phydev, u8 pair,
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 8b0866fad2ad..6eb064722aa8 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -7,12 +7,15 @@
 
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
+#include <uapi/linux/ethtool_netlink_generated.h>
+#include <linux/regulator/driver.h>
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
 /* Maximum power in mW according to IEEE 802.3-2022 Table 145-16 */
 #define MAX_PI_PW 99900
 
+struct net_device;
 struct phy_device;
 struct pse_controller_dev;
 struct netlink_ext_ack;
@@ -37,6 +40,19 @@ struct ethtool_c33_pse_pw_limit_range {
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
@@ -228,6 +244,7 @@ struct pse_pi {
  * @types: types of the PSE controller
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
+ * @irq: PSE interrupt
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -241,6 +258,7 @@ struct pse_controller_dev {
 	enum ethtool_pse_types types;
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
+	int irq;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -249,6 +267,8 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev);
 struct device;
 int devm_pse_controller_register(struct device *dev,
 				 struct pse_controller_dev *pcdev);
+int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
+			int irq_flags, const struct pse_irq_desc *d);
 
 struct pse_control *of_pse_control_get(struct device_node *node,
 				       struct phy_device *phydev);
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 9a02f579de22..3864aa0de8c7 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -49,6 +49,16 @@ enum hwtstamp_source {
 	HWTSTAMP_SOURCE_PHYLIB,
 };
 
+/**
+ * enum ethtool_pse_event - PSE event list for the PSE controller
+ * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high
+ * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state
+ */
+enum ethtool_pse_event {
+	ETHTOOL_PSE_EVENT_OVER_CURRENT = 1,
+	ETHTOOL_PSE_EVENT_OVER_TEMP = 2,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -718,6 +728,14 @@ enum {
 	ETHTOOL_A_TSCONFIG_MAX = (__ETHTOOL_A_TSCONFIG_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PSE_NTF_HEADER = 1,
+	ETHTOOL_A_PSE_NTF_EVENTS,
+
+	__ETHTOOL_A_PSE_NTF_CNT,
+	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -822,6 +840,7 @@ enum {
 	ETHTOOL_MSG_PHY_NTF,
 	ETHTOOL_MSG_TSCONFIG_GET_REPLY,
 	ETHTOOL_MSG_TSCONFIG_SET_REPLY,
+	ETHTOOL_MSG_PSE_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 4f6b99eab2a6..5443b4e0065a 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -315,3 +315,42 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
 	.set			= ethnl_set_pse,
 	/* PSE has no notification */
 };
+
+void ethnl_pse_send_ntf(struct net_device *netdev, unsigned long notifs)
+{
+	void *reply_payload;
+	struct sk_buff *skb;
+	int reply_len;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (!netdev || !notifs)
+		return;
+
+	reply_len = ethnl_reply_header_size() +
+		    nla_total_size(sizeof(u32)); /* _PSE_NTF_EVENTS */
+
+	skb = genlmsg_new(reply_len, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	reply_payload = ethnl_bcastmsg_put(skb, ETHTOOL_MSG_PSE_NTF);
+	if (!reply_payload)
+		goto err_skb;
+
+	ret = ethnl_fill_reply_header(skb, netdev, ETHTOOL_A_PSE_NTF_HEADER);
+	if (ret < 0)
+		goto err_skb;
+
+	if (nla_put_uint(skb, ETHTOOL_A_PSE_NTF_EVENTS, notifs))
+		goto err_skb;
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
2.43.0


