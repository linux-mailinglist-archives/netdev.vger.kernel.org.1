Return-Path: <netdev+bounces-195988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6927AD2FDF
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE41884872
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD842868A1;
	Tue, 10 Jun 2025 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kLKPkBHd"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D53283C92;
	Tue, 10 Jun 2025 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543530; cv=none; b=LaLidwGvBPyk3p8Ba2reIgOJM1QyLLNdI452+W5AFcfhJFlcB4mBEEfp4+Pw9yr1TSRgED9SoNd5xe7dkJw3yIb70yU5hfIlIexSPSix4F0kROoO2ExxYf/wVjLvWhrz9Tis4HnovFk9ZIU1DO4JRsXxqNBarYqm6kWIlfpcTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543530; c=relaxed/simple;
	bh=hY5DA5dGVwXFcvhy1EvRMUCtDd1KB9G0jBmof2Rlgd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6ZAGQvigSZjLZCW12Gjal19/OGhf/wo2cRrv9+94/VhRyODNHtb6vD8Zj0nsa0lDsZiKc805jABy1ZQwua4DN2saf5Hw3MI8OXF0a48nw/zje1BWuUjuHmmfHaFOyB0nj8IRfBxNUkIuy0BttpYg/SIRsMsqa50AyVItjz3/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kLKPkBHd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9828E44281;
	Tue, 10 Jun 2025 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749543525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smyl9B/0l6DXvip8UbtAUdpzHX6Y7DN2Z+sw88IM9Kc=;
	b=kLKPkBHdBllGD9y78PkQdDsiz/aSOfKU+yFeRStlUPe74+5FUnmW2h9+HBX/WMoXYCGQ51
	G3Jy4ppqkPjjgDcBlEb56SVLsHeNuwgvdnbkQwuUE7KlxnE5Ob8iGU9BCLwnc+7xROkC9V
	d3T8XirK2Ck4pyGNeEDgcdQi0ysZqUWvApMVC+dRCu+OyWU89eNIF5C7CTf6rkEC6Zgbyr
	PZsUrT+60nD6GMcgp5f8Jdq3eggxrpzp6x4xojb9iOnPxCZ6JcZVlMw2gTsw/PP78IkwOt
	xjF05zmvjAHr4ejJk951OaZ9GBOnRPutimGVWNDLM5ChMO4J9Y8+vyQ5VshT/g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 10 Jun 2025 10:11:41 +0200
Subject: [PATCH net-next v13 07/13] net: pse-pd: Add support for budget
 evaluation strategies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250610-feature_poe_port_prio-v13-7-c5edc16b9ee2@bootlin.com>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
In-Reply-To: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieekgfejvdekudfgieehffegfeelgfetudeluedviedtgfdtvdelteeikeffffeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch introduces the ability to configure the PSE PI budget evaluation
strategies. Budget evaluation strategies is utilized by PSE controllers to
determine which ports to turn off first in scenarios such as power budget
exceedance.

The pis_prio_max value is used to define the maximum priority level
supported by the controller. Both the current priority and the maximum
priority are exposed to the user through the pse_ethtool_get_status call.

This patch add support for two mode of budget evaluation strategies.
1. Static Method:

   This method involves distributing power based on PD classification.
   It’s straightforward and stable, the PSE core keeping track of the
   budget and subtracting the power requested by each PD’s class.

   Advantages: Every PD gets its promised power at any time, which
   guarantees reliability.

   Disadvantages: PD classification steps are large, meaning devices
   request much more power than they actually need. As a result, the power
   supply may only operate at, say, 50% capacity, which is inefficient and
   wastes money.

   Priority max value is matching the number of PSE PIs within the PSE.

2. Dynamic Method:

   To address the inefficiencies of the static method, vendors like
   Microchip have introduced dynamic power budgeting, as seen in the
   PD692x0 firmware. This method monitors the current consumption per port
   and subtracts it from the available power budget. When the budget is
   exceeded, lower-priority ports are shut down.

   Advantages: This method optimizes resource utilization, saving costs.

   Disadvantages: Low-priority devices may experience instability.

   Priority max value is set by the PSE controller driver.

For now, budget evaluation methods are not configurable and cannot be
mixed. They are hardcoded in the PSE driver itself, as no current PSE
controller supports both methods.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Change in v11:
- Add function documentation for better clarity.

Change in v10:
- Remove Olkesij Reviewed-by due to patch change.
- Move the PSE notification report in a workqueue to avoid a deadlock
  between pcdev_lock and pse_list_mutex. Indeed the pse_isr is now fully
  running with pcdev_lock acquired as we are now doing actions in case of
  events like disconnection. The pse_list_mutex is acquired to match
  between the pse_control and the network interface. On an other hand
  pse_control_get_internal is holding pse_list_mutex and call
  devm_regulator_get_exclusive which acquire pcdev_lock. That is how we
  could face a deadlock.
  Using workqueue creates asynchronous PSE notification but I don't
  think it is a problem.
- Remove _isr_counter_mismatch unused variable.
- Fixed a return value in case of enabling a port in over budget state.

Change in v8:
- Rename a few functions for better clarity following Oleksij proposals.

Change in v7:
- Move Budget evaluation strategy enum definition out of uAPI, and
  remove ethtool prefix.
- Add support to retry enabling port that failed to be powered in case of
  port disconnection or priority change.
- Update the events name in ethtool specs to match the ones described in
  the UAPI.

Change in v6:
- Remove Budget evaluation strategy from ethtool_pse_control_status struct.

Change in v5:
- Save PI previous power allocated in set current limit to be able to
  restore the power allocated in case of error.

Change in v4:
- Remove disconnection policy features.
- Rename port priority to budget evaluation strategy.
- Add kdoc

Change in v3:
- Add disconnection policy.
- Add management of disabled port priority in the interrupt handler.
- Move port prio mode in the power domain instead of the PSE.

Change in v2:
- Rethink the port priority support.
---
 Documentation/netlink/specs/ethtool.yaml       |  30 +-
 drivers/net/pse-pd/pse_core.c                  | 729 +++++++++++++++++++++++--
 include/linux/pse-pd/pse.h                     |  78 +++
 include/uapi/linux/ethtool_netlink_generated.h |  18 +
 4 files changed, 817 insertions(+), 38 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 357775ab0038..bb09aa4ed1ba 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -120,13 +120,39 @@ definitions:
     name: pse-event
     doc: PSE event list for the PSE controller
     type: flags
+    name-prefix: ethtool-
     entries:
       -
-        name: over-current
+        name: pse-event-over-current
         doc: PSE output current is too high
       -
-        name: over-temp
+        name: pse-event-over-temp
         doc: PSE in over temperature state
+      -
+        name: c33-pse-event-detection
+        doc: |
+          detection process occur on the PSE. IEEE 802.3-2022 33.2.5 and
+          145.2.6 PSE detection of PDs. IEEE 802.3-202 30.9.1.1.5
+          aPSEPowerDetectionStatus
+      -
+        name: c33-pse-event-classification
+        doc: |
+          classification process occur on the PSE. IEEE 802.3-2022 33.2.6
+          and 145.2.8 classification of PDs mutual identification.
+          IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification.
+      -
+        name: c33-pse-event-disconnection
+        doc: |
+          PD has been disconnected on the PSE. IEEE 802.3-2022 33.3.8
+          and 145.3.9 PD Maintain Power Signature. IEEE 802.3-2022
+          33.5.1.2.9 MPS Absent. IEEE 802.3-2022 30.9.1.1.20
+          aPSEMPSAbsentCounter.
+      -
+        name: pse-event-over-budget
+        doc: PSE turned off due to over budget situation
+      -
+        name: pse-event-sw-pw-control-error
+        doc: PSE faced an error managing the power control from software
 
 attribute-sets:
   -
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index dd6775b9816a..c88e626a791d 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -47,11 +47,14 @@ struct pse_control {
  * @id: ID of the power domain
  * @supply: Power supply the Power Domain
  * @refcnt: Number of gets of this pse_power_domain
+ * @budget_eval_strategy: Current power budget evaluation strategy of the
+ *			  power domain
  */
 struct pse_power_domain {
 	int id;
 	struct regulator *supply;
 	struct kref refcnt;
+	u32 budget_eval_strategy;
 };
 
 static int of_load_single_pse_pi_pairset(struct device_node *node,
@@ -301,6 +304,115 @@ static int pse_pi_is_hw_enabled(struct pse_controller_dev *pcdev, int id)
 	return 0;
 }
 
+/**
+ * pse_pi_is_admin_enable_not_applied - Check if PI power is not yet being
+ *					delivered
+ * @pcdev: a pointer to the PSE controller device
+ * @id: Index of the PI
+ *
+ * Detects if a PI is enabled in software with a PD detected, but the hardware
+ * admin state hasn't been applied yet.
+ *
+ * This function is used in the power delivery and retry mechanisms to determine
+ * which PIs need to have power delivery attempted again.
+ *
+ * Return: true if the PI has admin enable flag set in software but not yet
+ *	   reflected in the hardware admin state, false otherwise.
+ */
+static bool
+pse_pi_is_admin_enable_not_applied(struct pse_controller_dev *pcdev,
+				   int id)
+{
+	int ret;
+
+	/* PI not enabled or nothing is plugged */
+	if (!pcdev->pi[id].admin_state_enabled ||
+	    !pcdev->pi[id].isr_pd_detected)
+		return false;
+
+	ret = pse_pi_is_hw_enabled(pcdev, id);
+	/* PSE PI is already enabled at hardware level */
+	if (ret == 1)
+		return false;
+
+	return true;
+}
+
+static int _pse_pi_delivery_power_sw_pw_ctrl(struct pse_controller_dev *pcdev,
+					     int id,
+					     struct netlink_ext_ack *extack);
+
+/**
+ * pse_pw_d_retry_power_delivery - Retry power delivery for pending ports in a
+ *				   PSE power domain
+ * @pcdev: a pointer to the PSE controller device
+ * @pw_d: a pointer to the PSE power domain
+ *
+ * Scans all ports in the specified power domain and attempts to enable power
+ * delivery to any ports that have admin enable state set but don't yet have
+ * hardware power enabled. Used when there are changes in connection status,
+ * admin state, or priority that might allow previously unpowered ports to
+ * receive power, especially in over-budget conditions.
+ */
+static void pse_pw_d_retry_power_delivery(struct pse_controller_dev *pcdev,
+					  struct pse_power_domain *pw_d)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		int prio_max = pcdev->nr_lines;
+		struct netlink_ext_ack extack;
+
+		if (pcdev->pi[i].pw_d != pw_d)
+			continue;
+
+		if (!pse_pi_is_admin_enable_not_applied(pcdev, i))
+			continue;
+
+		/* Do not try to enable PI with a lower prio (higher value)
+		 * than one which already can't be enabled.
+		 */
+		if (pcdev->pi[i].prio > prio_max)
+			continue;
+
+		ret = _pse_pi_delivery_power_sw_pw_ctrl(pcdev, i, &extack);
+		if (ret == -ERANGE)
+			prio_max = pcdev->pi[i].prio;
+	}
+}
+
+/**
+ * pse_pw_d_is_sw_pw_control - Determine if power control is software managed
+ * @pcdev: a pointer to the PSE controller device
+ * @pw_d: a pointer to the PSE power domain
+ *
+ * This function determines whether the power control for a specific power
+ * domain is managed by software in the interrupt handler rather than directly
+ * by hardware.
+ *
+ * Software power control is active in the following cases:
+ * - When the budget evaluation strategy is set to static
+ * - When the budget evaluation strategy is disabled but the PSE controller
+ *   has an interrupt handler that can report if a Powered Device is connected
+ *
+ * Return: true if the power control of the power domain is managed by software,
+ *         false otherwise
+ */
+static bool pse_pw_d_is_sw_pw_control(struct pse_controller_dev *pcdev,
+				      struct pse_power_domain *pw_d)
+{
+	if (!pw_d)
+		return false;
+
+	if (pw_d->budget_eval_strategy == PSE_BUDGET_EVAL_STRAT_STATIC)
+		return true;
+	if (pw_d->budget_eval_strategy == PSE_BUDGET_EVAL_STRAT_DISABLED &&
+	    pcdev->ops->pi_enable && pcdev->irq)
+		return true;
+
+	return false;
+}
+
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
@@ -313,17 +425,255 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
+		ret = pcdev->pi[id].admin_state_enabled;
+		goto out;
+	}
+
 	ret = pse_pi_is_hw_enabled(pcdev, id);
+
+out:
 	mutex_unlock(&pcdev->lock);
 
 	return ret;
 }
 
+/**
+ * pse_pi_deallocate_pw_budget - Deallocate power budget of the PI
+ * @pi: a pointer to the PSE PI
+ */
+static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
+{
+	if (!pi->pw_d || !pi->pw_allocated_mW)
+		return;
+
+	regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated_mW);
+	pi->pw_allocated_mW = 0;
+}
+
+/**
+ * _pse_pi_disable - Call disable operation. Assumes the PSE lock has been
+ *		     acquired.
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
+{
+	const struct pse_controller_ops *ops = pcdev->ops;
+	int ret;
+
+	if (!ops->pi_disable)
+		return -EOPNOTSUPP;
+
+	ret = ops->pi_disable(pcdev, id);
+	if (ret)
+		return ret;
+
+	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
+
+	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d))
+		pse_pw_d_retry_power_delivery(pcdev, pcdev->pi[id].pw_d);
+
+	return 0;
+}
+
+/**
+ * pse_disable_pi_pol - Disable a PI on a power budget policy
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE PI
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
+{
+	unsigned long notifs = ETHTOOL_PSE_EVENT_OVER_BUDGET;
+	struct pse_ntf ntf = {};
+	int ret;
+
+	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
+
+	NL_SET_ERR_MSG_FMT(&ntf.extack,
+			   "Disabling PI %d to free power budget", id);
+
+	ret = _pse_pi_disable(pcdev, id);
+	if (ret)
+		notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
+
+	ntf.notifs = notifs;
+	ntf.id = id;
+	kfifo_in_spinlocked(&pcdev->ntf_fifo, &ntf, 1, &pcdev->ntf_fifo_lock);
+	schedule_work(&pcdev->ntf_work);
+
+	return ret;
+}
+
+/**
+ * pse_disable_pi_prio - Disable all PIs of a given priority inside a PSE
+ *			 power domain
+ * @pcdev: a pointer to the PSE
+ * @pw_d: a pointer to the PSE power domain
+ * @prio: priority
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int pse_disable_pi_prio(struct pse_controller_dev *pcdev,
+			       struct pse_power_domain *pw_d,
+			       int prio)
+{
+	int i;
+
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		int ret;
+
+		if (pcdev->pi[i].prio != prio ||
+		    pcdev->pi[i].pw_d != pw_d ||
+		    pse_pi_is_hw_enabled(pcdev, i) <= 0)
+			continue;
+
+		ret = pse_disable_pi_pol(pcdev, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * pse_pi_allocate_pw_budget_static_prio - Allocate power budget for the PI
+ *					   when the budget eval strategy is
+ *					   static
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ * @pw_req: power requested in mW
+ * @extack: extack for error reporting
+ *
+ * Allocates power using static budget evaluation strategy, where allocation
+ * is based on PD classification. When insufficient budget is available,
+ * lower-priority ports (higher priority numbers) are turned off first.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int
+pse_pi_allocate_pw_budget_static_prio(struct pse_controller_dev *pcdev, int id,
+				      int pw_req, struct netlink_ext_ack *extack)
+{
+	struct pse_pi *pi = &pcdev->pi[id];
+	int ret, _prio;
+
+	_prio = pcdev->nr_lines;
+	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
+		if (_prio <= pi->prio) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PI %d: not enough power budget available",
+					   id);
+			return -ERANGE;
+		}
+
+		ret = pse_disable_pi_prio(pcdev, pi->pw_d, _prio);
+		if (ret < 0)
+			return ret;
+
+		_prio--;
+	}
+
+	pi->pw_allocated_mW = pw_req;
+	return 0;
+}
+
+/**
+ * pse_pi_allocate_pw_budget - Allocate power budget for the PI
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ * @pw_req: power requested in mW
+ * @extack: extack for error reporting
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int pse_pi_allocate_pw_budget(struct pse_controller_dev *pcdev, int id,
+				     int pw_req, struct netlink_ext_ack *extack)
+{
+	struct pse_pi *pi = &pcdev->pi[id];
+
+	if (!pi->pw_d)
+		return 0;
+
+	/* PSE_BUDGET_EVAL_STRAT_STATIC */
+	if (pi->pw_d->budget_eval_strategy == PSE_BUDGET_EVAL_STRAT_STATIC)
+		return pse_pi_allocate_pw_budget_static_prio(pcdev, id, pw_req,
+							     extack);
+
+	return 0;
+}
+
+/**
+ * _pse_pi_delivery_power_sw_pw_ctrl - Enable PSE PI in case of software power
+ *				       control. Assumes the PSE lock has been
+ *				       acquired.
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ * @extack: extack for error reporting
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int _pse_pi_delivery_power_sw_pw_ctrl(struct pse_controller_dev *pcdev,
+					     int id,
+					     struct netlink_ext_ack *extack)
+{
+	const struct pse_controller_ops *ops = pcdev->ops;
+	struct pse_pi *pi = &pcdev->pi[id];
+	int ret, pw_req;
+
+	if (!ops->pi_get_pw_req) {
+		/* No power allocation management */
+		ret = ops->pi_enable(pcdev, id);
+		if (ret)
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PI %d: enable error %d",
+					   id, ret);
+		return ret;
+	}
+
+	ret = ops->pi_get_pw_req(pcdev, id);
+	if (ret < 0)
+		return ret;
+
+	pw_req = ret;
+
+	/* Compare requested power with port power limit and use the lowest
+	 * one.
+	 */
+	if (ops->pi_get_pw_limit) {
+		ret = ops->pi_get_pw_limit(pcdev, id);
+		if (ret < 0)
+			return ret;
+
+		if (ret < pw_req)
+			pw_req = ret;
+	}
+
+	ret = pse_pi_allocate_pw_budget(pcdev, id, pw_req, extack);
+	if (ret)
+		return ret;
+
+	ret = ops->pi_enable(pcdev, id);
+	if (ret) {
+		pse_pi_deallocate_pw_budget(pi);
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PI %d: enable error %d",
+				   id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int pse_pi_enable(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
-	int id, ret;
+	int id, ret = 0;
 
 	ops = pcdev->ops;
 	if (!ops->pi_enable)
@@ -331,6 +681,23 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
+		/* Manage enabled status by software.
+		 * Real enable process will happen if a port is connected.
+		 */
+		if (pcdev->pi[id].isr_pd_detected) {
+			struct netlink_ext_ack extack;
+
+			ret = _pse_pi_delivery_power_sw_pw_ctrl(pcdev, id, &extack);
+		}
+		if (!ret || ret == -ERANGE) {
+			pcdev->pi[id].admin_state_enabled = 1;
+			ret = 0;
+		}
+		mutex_unlock(&pcdev->lock);
+		return ret;
+	}
+
 	ret = ops->pi_enable(pcdev, id);
 	if (!ret)
 		pcdev->pi[id].admin_state_enabled = 1;
@@ -342,21 +709,18 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 static int pse_pi_disable(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
-	const struct pse_controller_ops *ops;
+	struct pse_pi *pi;
 	int id, ret;
 
-	ops = pcdev->ops;
-	if (!ops->pi_disable)
-		return -EOPNOTSUPP;
-
 	id = rdev_get_id(rdev);
+	pi = &pcdev->pi[id];
 	mutex_lock(&pcdev->lock);
-	ret = ops->pi_disable(pcdev, id);
+	ret = _pse_pi_disable(pcdev, id);
 	if (!ret)
-		pcdev->pi[id].admin_state_enabled = 0;
-	mutex_unlock(&pcdev->lock);
+		pi->admin_state_enabled = 0;
 
-	return ret;
+	mutex_unlock(&pcdev->lock);
+	return 0;
 }
 
 static int _pse_pi_get_voltage(struct regulator_dev *rdev)
@@ -631,6 +995,11 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		}
 
 		pw_d->supply = supply;
+		if (pcdev->supp_budget_eval_strategies)
+			pw_d->budget_eval_strategy = pcdev->supp_budget_eval_strategies;
+		else
+			pw_d->budget_eval_strategy = PSE_BUDGET_EVAL_STRAT_DISABLED;
+		kref_init(&pw_d->refcnt);
 		pcdev->pi[i].pw_d = pw_d;
 	}
 
@@ -639,6 +1008,31 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+/**
+ * pse_send_ntf_worker - Worker to send PSE notifications
+ * @work: work object
+ *
+ * Manage and send PSE netlink notifications using a workqueue to avoid
+ * deadlock between pcdev_lock and pse_list_mutex.
+ */
+static void pse_send_ntf_worker(struct work_struct *work)
+{
+	struct pse_controller_dev *pcdev;
+	struct pse_ntf ntf;
+
+	pcdev = container_of(work, struct pse_controller_dev, ntf_work);
+
+	while (kfifo_out(&pcdev->ntf_fifo, &ntf, 1)) {
+		struct net_device *netdev;
+		netdevice_tracker tracker;
+
+		netdev = pse_control_find_net_by_id(pcdev, ntf.id, &tracker);
+		if (netdev)
+			ethnl_pse_send_ntf(netdev, ntf.notifs, &ntf.extack);
+		netdev_put(netdev, &tracker);
+	}
+}
+
 /**
  * pse_controller_register - register a PSE controller device
  * @pcdev: a pointer to the initialized PSE controller device
@@ -652,6 +1046,13 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
+	spin_lock_init(&pcdev->ntf_fifo_lock);
+	ret = kfifo_alloc(&pcdev->ntf_fifo, pcdev->nr_lines, GFP_KERNEL);
+	if (ret) {
+		dev_err(pcdev->dev, "failed to allocate kfifo notifications\n");
+		return ret;
+	}
+	INIT_WORK(&pcdev->ntf_work, pse_send_ntf_worker);
 
 	if (!pcdev->nr_lines)
 		pcdev->nr_lines = 1;
@@ -718,6 +1119,10 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
+	if (pcdev->irq)
+		disable_irq(pcdev->irq);
+	cancel_work_sync(&pcdev->ntf_work);
+	kfifo_free(&pcdev->ntf_fifo);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
@@ -789,6 +1194,52 @@ static unsigned long pse_to_regulator_notifs(unsigned long notifs)
 	return rnotifs;
 }
 
+/**
+ * pse_set_config_isr - Set PSE control config according to the PSE
+ *			notifications
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ * @notifs: PSE event notifications
+ * @extack: extack for error reporting
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
+			      unsigned long notifs,
+			      struct netlink_ext_ack *extack)
+{
+	int ret = 0;
+
+	if (notifs & PSE_BUDGET_EVAL_STRAT_DYNAMIC)
+		return 0;
+
+	if ((notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) &&
+	    ((notifs & ETHTOOL_C33_PSE_EVENT_DETECTION) ||
+	     (notifs & ETHTOOL_C33_PSE_EVENT_CLASSIFICATION))) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PI %d: error, connection and disconnection reported simultaneously",
+				   id);
+		return -EINVAL;
+	}
+
+	if (notifs & ETHTOOL_C33_PSE_EVENT_CLASSIFICATION) {
+		pcdev->pi[id].isr_pd_detected = true;
+		if (pcdev->pi[id].admin_state_enabled) {
+			ret = _pse_pi_delivery_power_sw_pw_ctrl(pcdev, id,
+								extack);
+			if (ret == -ERANGE)
+				ret = 0;
+		}
+	} else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) {
+		if (pcdev->pi[id].admin_state_enabled &&
+		    pcdev->pi[id].isr_pd_detected)
+			ret = _pse_pi_disable(pcdev, id);
+		pcdev->pi[id].isr_pd_detected = false;
+	}
+
+	return ret;
+}
+
 /**
  * pse_isr - IRQ handler for PSE
  * @irq: irq number
@@ -798,7 +1249,6 @@ static unsigned long pse_to_regulator_notifs(unsigned long notifs)
  */
 static irqreturn_t pse_isr(int irq, void *data)
 {
-	struct netlink_ext_ack extack = {};
 	struct pse_controller_dev *pcdev;
 	unsigned long notifs_mask = 0;
 	struct pse_irq_desc *desc;
@@ -812,32 +1262,41 @@ static irqreturn_t pse_isr(int irq, void *data)
 	memset(h->notifs, 0, pcdev->nr_lines * sizeof(*h->notifs));
 	mutex_lock(&pcdev->lock);
 	ret = desc->map_event(irq, pcdev, h->notifs, &notifs_mask);
-	mutex_unlock(&pcdev->lock);
-	if (ret || !notifs_mask)
+	if (ret || !notifs_mask) {
+		mutex_unlock(&pcdev->lock);
 		return IRQ_NONE;
+	}
 
 	for_each_set_bit(i, &notifs_mask, pcdev->nr_lines) {
 		unsigned long notifs, rnotifs;
-		struct net_device *netdev;
-		netdevice_tracker tracker;
+		struct pse_ntf ntf = {};
 
 		/* Do nothing PI not described */
 		if (!pcdev->pi[i].rdev)
 			continue;
 
 		notifs = h->notifs[i];
+		if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[i].pw_d)) {
+			ret = pse_set_config_isr(pcdev, i, notifs, &ntf.extack);
+			if (ret)
+				notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
+		}
+
 		dev_dbg(h->pcdev->dev,
 			"Sending PSE notification EVT 0x%lx\n", notifs);
 
-		netdev = pse_control_find_net_by_id(pcdev, i, &tracker);
-		if (netdev)
-			ethnl_pse_send_ntf(netdev, notifs, &extack);
-		netdev_put(netdev, &tracker);
+		ntf.notifs = notifs;
+		ntf.id = i;
+		kfifo_in_spinlocked(&pcdev->ntf_fifo, &ntf, 1,
+				    &pcdev->ntf_fifo_lock);
+		schedule_work(&pcdev->ntf_work);
 		rnotifs = pse_to_regulator_notifs(notifs);
 		regulator_notifier_call_chain(pcdev->pi[i].rdev, rnotifs,
 					      NULL);
 	}
 
+	mutex_unlock(&pcdev->lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -960,6 +1419,20 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 		goto free_psec;
 	}
 
+	if (!pcdev->ops->pi_get_admin_state) {
+		ret = -EOPNOTSUPP;
+		goto free_psec;
+	}
+
+	/* Initialize admin_state_enabled before the regulator_get. This
+	 * aims to have the right value reported in the first is_enabled
+	 * call in case of control managed by software.
+	 */
+	ret = pse_pi_is_hw_enabled(pcdev, index);
+	if (ret < 0)
+		goto free_psec;
+
+	pcdev->pi[index].admin_state_enabled = ret;
 	psec->ps = devm_regulator_get_exclusive(pcdev->dev,
 						rdev_get_name(pcdev->pi[index].rdev));
 	if (IS_ERR(psec->ps)) {
@@ -967,12 +1440,6 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 		goto put_module;
 	}
 
-	ret = regulator_is_enabled(psec->ps);
-	if (ret < 0)
-		goto regulator_put;
-
-	pcdev->pi[index].admin_state_enabled = ret;
-
 	psec->pcdev = pcdev;
 	list_add(&psec->list, &pcdev->pse_control_head);
 	psec->id = index;
@@ -981,8 +1448,6 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 
 	return psec;
 
-regulator_put:
-	devm_regulator_put(psec->ps);
 put_module:
 	module_put(pcdev->owner);
 free_psec:
@@ -1093,6 +1558,35 @@ struct pse_control *of_pse_control_get(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(of_pse_control_get);
 
+/**
+ * pse_get_sw_admin_state - Convert the software admin state to c33 or podl
+ *			    admin state value used in the standard
+ * @psec: PSE control pointer
+ * @admin_state: a pointer to the admin_state structure
+ */
+static void pse_get_sw_admin_state(struct pse_control *psec,
+				   struct pse_admin_state *admin_state)
+{
+	struct pse_pi *pi = &psec->pcdev->pi[psec->id];
+
+	if (pse_has_podl(psec)) {
+		if (pi->admin_state_enabled)
+			admin_state->podl_admin_state =
+				ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED;
+		else
+			admin_state->podl_admin_state =
+				ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED;
+	}
+	if (pse_has_c33(psec)) {
+		if (pi->admin_state_enabled)
+			admin_state->c33_admin_state =
+				ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+		else
+			admin_state->c33_admin_state =
+				ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+	}
+}
+
 /**
  * pse_ethtool_get_status - get status of PSE control
  * @psec: PSE control pointer
@@ -1109,19 +1603,46 @@ int pse_ethtool_get_status(struct pse_control *psec,
 	struct pse_pw_status pw_status = {0};
 	const struct pse_controller_ops *ops;
 	struct pse_controller_dev *pcdev;
+	struct pse_pi *pi;
 	int ret;
 
 	pcdev = psec->pcdev;
 	ops = pcdev->ops;
+
+	pi = &pcdev->pi[psec->id];
 	mutex_lock(&pcdev->lock);
-	if (pcdev->pi[psec->id].pw_d)
-		status->pw_d_id = pcdev->pi[psec->id].pw_d->id;
+	if (pi->pw_d) {
+		status->pw_d_id = pi->pw_d->id;
+		if (pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d)) {
+			pse_get_sw_admin_state(psec, &admin_state);
+		} else {
+			ret = ops->pi_get_admin_state(pcdev, psec->id,
+						      &admin_state);
+			if (ret)
+				goto out;
+		}
+		status->podl_admin_state = admin_state.podl_admin_state;
+		status->c33_admin_state = admin_state.c33_admin_state;
 
-	ret = ops->pi_get_admin_state(pcdev, psec->id, &admin_state);
-	if (ret)
-		goto out;
-	status->podl_admin_state = admin_state.podl_admin_state;
-	status->c33_admin_state = admin_state.c33_admin_state;
+		switch (pi->pw_d->budget_eval_strategy) {
+		case PSE_BUDGET_EVAL_STRAT_STATIC:
+			status->prio_max = pcdev->nr_lines - 1;
+			status->prio = pi->prio;
+			break;
+		case PSE_BUDGET_EVAL_STRAT_DYNAMIC:
+			status->prio_max = pcdev->pis_prio_max;
+			if (ops->pi_get_prio) {
+				ret = ops->pi_get_prio(pcdev, psec->id);
+				if (ret < 0)
+					goto out;
+
+				status->prio = ret;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	ret = ops->pi_get_pw_status(pcdev, psec->id, &pw_status);
 	if (ret)
@@ -1270,6 +1791,52 @@ int pse_ethtool_set_config(struct pse_control *psec,
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
 
+/**
+ * pse_pi_update_pw_budget - Update PSE power budget allocated with new
+ *			     power in mW
+ * @pcdev: a pointer to the PSE controller device
+ * @id: index of the PSE PI
+ * @pw_req: power requested
+ * @extack: extack for reporting useful error messages
+ *
+ * Return: Previous power allocated on success and failure value on error
+ */
+static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
+				   const unsigned int pw_req,
+				   struct netlink_ext_ack *extack)
+{
+	struct pse_pi *pi = &pcdev->pi[id];
+	int previous_pw_allocated;
+	int pw_diff, ret = 0;
+
+	/* We don't want pw_allocated_mW value change in the middle of an
+	 * power budget update
+	 */
+	mutex_lock(&pcdev->lock);
+	previous_pw_allocated = pi->pw_allocated_mW;
+	pw_diff = pw_req - previous_pw_allocated;
+	if (!pw_diff) {
+		goto out;
+	} else if (pw_diff > 0) {
+		ret = regulator_request_power_budget(pi->pw_d->supply, pw_diff);
+		if (ret) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PI %d: not enough power budget available",
+					   id);
+			goto out;
+		}
+
+	} else {
+		regulator_free_power_budget(pi->pw_d->supply, -pw_diff);
+	}
+	pi->pw_allocated_mW = pw_req;
+	ret = previous_pw_allocated;
+
+out:
+	mutex_unlock(&pcdev->lock);
+	return ret;
+}
+
 /**
  * pse_ethtool_set_pw_limit - set PSE control power limit
  * @psec: PSE control pointer
@@ -1282,7 +1849,7 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     struct netlink_ext_ack *extack,
 			     const unsigned int pw_limit)
 {
-	int uV, uA, ret;
+	int uV, uA, ret, previous_pw_allocated = 0;
 	s64 tmp_64;
 
 	if (pw_limit > MAX_PI_PW)
@@ -1306,10 +1873,100 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	/* uA = mW * 1000000000 / uV */
 	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
 
-	return regulator_set_current_limit(psec->ps, 0, uA);
+	/* Update power budget only in software power control case and
+	 * if a Power Device is powered.
+	 */
+	if (pse_pw_d_is_sw_pw_control(psec->pcdev,
+				      psec->pcdev->pi[psec->id].pw_d) &&
+	    psec->pcdev->pi[psec->id].admin_state_enabled &&
+	    psec->pcdev->pi[psec->id].isr_pd_detected) {
+		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
+					      pw_limit, extack);
+		if (ret < 0)
+			return ret;
+		previous_pw_allocated = ret;
+	}
+
+	ret = regulator_set_current_limit(psec->ps, 0, uA);
+	if (ret < 0 && previous_pw_allocated) {
+		pse_pi_update_pw_budget(psec->pcdev, psec->id,
+					previous_pw_allocated, extack);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_pw_limit);
 
+/**
+ * pse_ethtool_set_prio - Set PSE PI priority according to the budget
+ *			  evaluation strategy
+ * @psec: PSE control pointer
+ * @extack: extack for reporting useful error messages
+ * @prio: priovity value
+ *
+ * Return: 0 on success and failure value on error
+ */
+int pse_ethtool_set_prio(struct pse_control *psec,
+			 struct netlink_ext_ack *extack,
+			 unsigned int prio)
+{
+	struct pse_controller_dev *pcdev = psec->pcdev;
+	const struct pse_controller_ops *ops;
+	int ret = 0;
+
+	if (!pcdev->pi[psec->id].pw_d) {
+		NL_SET_ERR_MSG(extack, "no power domain attached");
+		return -EOPNOTSUPP;
+	}
+
+	/* We don't want priority change in the middle of an
+	 * enable/disable call or a priority mode change
+	 */
+	mutex_lock(&pcdev->lock);
+	switch (pcdev->pi[psec->id].pw_d->budget_eval_strategy) {
+	case PSE_BUDGET_EVAL_STRAT_STATIC:
+		if (prio >= pcdev->nr_lines) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "priority %d exceed priority max %d",
+					   prio, pcdev->nr_lines);
+			ret = -ERANGE;
+			goto out;
+		}
+
+		pcdev->pi[psec->id].prio = prio;
+		pse_pw_d_retry_power_delivery(pcdev, pcdev->pi[psec->id].pw_d);
+		break;
+
+	case PSE_BUDGET_EVAL_STRAT_DYNAMIC:
+		ops = psec->pcdev->ops;
+		if (!ops->pi_set_prio) {
+			NL_SET_ERR_MSG(extack,
+				       "pse driver does not support setting port priority");
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		if (prio > pcdev->pis_prio_max) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "priority %d exceed priority max %d",
+					   prio, pcdev->pis_prio_max);
+			ret = -ERANGE;
+			goto out;
+		}
+
+		ret = ops->pi_set_prio(pcdev, psec->id, prio);
+		break;
+
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+out:
+	mutex_unlock(&pcdev->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_prio);
+
 bool pse_has_podl(struct pse_control *psec)
 {
 	return psec->pcdev->types & ETHTOOL_PSE_PODL;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 2f8ecfd87d43..b678f4d77505 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -6,6 +6,8 @@
 #define _LINUX_PSE_CONTROLLER_H
 
 #include <linux/list.h>
+#include <linux/netlink.h>
+#include <linux/kfifo.h>
 #include <uapi/linux/ethtool.h>
 #include <uapi/linux/ethtool_netlink_generated.h>
 #include <linux/regulator/driver.h>
@@ -134,6 +136,9 @@ struct pse_pw_limit_ranges {
  *	is in charge of the memory allocation
  * @c33_pw_limit_nb_ranges: number of supported power limit configuration
  *	ranges
+ * @prio_max: max priority allowed for the c33_prio variable value.
+ * @prio: priority of the PSE. Managed by PSE core in case of static budget
+ *	evaluation strategy.
  */
 struct ethtool_pse_control_status {
 	u32 pw_d_id;
@@ -147,6 +152,8 @@ struct ethtool_pse_control_status {
 	u32 c33_avail_pw_limit;
 	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
 	u32 c33_pw_limit_nb_ranges;
+	u32 prio_max;
+	u32 prio;
 };
 
 /**
@@ -170,6 +177,11 @@ struct ethtool_pse_control_status {
  *			    range. The driver is in charge of the memory
  *			    allocation and should return the number of
  *			    ranges.
+ * @pi_get_prio: Get the PSE PI priority.
+ * @pi_set_prio: Configure the PSE PI priority.
+ * @pi_get_pw_req: Get the power requested by a PD before enabling the PSE PI.
+ *		   This is only relevant when an interrupt is registered using
+ *		   devm_pse_irq_helper helper.
  */
 struct pse_controller_ops {
 	int (*setup_pi_matrix)(struct pse_controller_dev *pcdev);
@@ -190,6 +202,10 @@ struct pse_controller_ops {
 			       int id, int max_mW);
 	int (*pi_get_pw_limit_ranges)(struct pse_controller_dev *pcdev, int id,
 				      struct pse_pw_limit_ranges *pw_limit_ranges);
+	int (*pi_get_prio)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_set_prio)(struct pse_controller_dev *pcdev, int id,
+			   unsigned int prio);
+	int (*pi_get_pw_req)(struct pse_controller_dev *pcdev, int id);
 };
 
 struct module;
@@ -225,6 +241,13 @@ struct pse_pi_pairset {
  * @rdev: regulator represented by the PSE PI
  * @admin_state_enabled: PI enabled state
  * @pw_d: Power domain of the PSE PI
+ * @prio: Priority of the PSE PI. Used in static budget evaluation strategy
+ * @isr_pd_detected: PSE PI detection status managed by the interruption
+ *		     handler. This variable is relevant when the power enabled
+ *		     management is managed in software like the static
+ *		     budget evaluation strategy.
+ * @pw_allocated_mW: Power allocated to a PSE PI to manage power budget in
+ *		     static budget evaluation strategy.
  */
 struct pse_pi {
 	struct pse_pi_pairset pairset[2];
@@ -232,6 +255,22 @@ struct pse_pi {
 	struct regulator_dev *rdev;
 	bool admin_state_enabled;
 	struct pse_power_domain *pw_d;
+	int prio;
+	bool isr_pd_detected;
+	int pw_allocated_mW;
+};
+
+/**
+ * struct pse_ntf - PSE notification element
+ *
+ * @id: ID of the PSE control
+ * @notifs: PSE notifications to be reported
+ * @extack: extack for reporting error messages
+ */
+struct pse_ntf {
+	int id;
+	unsigned long notifs;
+	struct netlink_ext_ack extack;
 };
 
 /**
@@ -249,6 +288,12 @@ struct pse_pi {
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
  * @irq: PSE interrupt
+ * @pis_prio_max: Maximum value allowed for the PSE PIs priority
+ * @supp_budget_eval_strategies: budget evaluation strategies supported
+ *				 by the PSE
+ * @ntf_work: workqueue for PSE notification management
+ * @ntf_fifo: PSE notifications FIFO
+ * @ntf_fifo_lock: protect @ntf_fifo writer
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -263,6 +308,29 @@ struct pse_controller_dev {
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
 	int irq;
+	unsigned int pis_prio_max;
+	u32 supp_budget_eval_strategies;
+	struct work_struct ntf_work;
+	DECLARE_KFIFO_PTR(ntf_fifo, struct pse_ntf);
+	spinlock_t ntf_fifo_lock; /* Protect @ntf_fifo writer */
+};
+
+/**
+ * enum pse_budget_eval_strategies - PSE budget evaluation strategies.
+ * @PSE_BUDGET_EVAL_STRAT_DISABLED: Budget evaluation strategy disabled.
+ * @PSE_BUDGET_EVAL_STRAT_STATIC: PSE static budget evaluation strategy.
+ *	Budget evaluation strategy based on the power requested during PD
+ *	classification. This strategy is managed by the PSE core.
+ * @PSE_BUDGET_EVAL_STRAT_DYNAMIC: PSE dynamic budget evaluation
+ *	strategy. Budget evaluation strategy based on the current consumption
+ *	per ports compared to the total	power budget. This mode is managed by
+ *	the PSE controller.
+ */
+
+enum pse_budget_eval_strategies {
+	PSE_BUDGET_EVAL_STRAT_DISABLED	= 1 << 0,
+	PSE_BUDGET_EVAL_STRAT_STATIC	= 1 << 1,
+	PSE_BUDGET_EVAL_STRAT_DYNAMIC	= 1 << 2,
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -287,6 +355,9 @@ int pse_ethtool_set_config(struct pse_control *psec,
 int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     struct netlink_ext_ack *extack,
 			     const unsigned int pw_limit);
+int pse_ethtool_set_prio(struct pse_control *psec,
+			 struct netlink_ext_ack *extack,
+			 unsigned int prio);
 
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
@@ -324,6 +395,13 @@ static inline int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	return -EOPNOTSUPP;
 }
 
+static inline int pse_ethtool_set_prio(struct pse_control *psec,
+				       struct netlink_ext_ack *extack,
+				       unsigned int prio)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool pse_has_podl(struct pse_control *psec)
 {
 	return false;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index ed344c8533eb..c6a95224be25 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -53,10 +53,28 @@ enum hwtstamp_source {
  * enum ethtool_pse_event - PSE event list for the PSE controller
  * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high
  * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state
+ * @ETHTOOL_C33_PSE_EVENT_DETECTION: detection process occur on the PSE. IEEE
+ *   802.3-2022 33.2.5 and 145.2.6 PSE detection of PDs. IEEE 802.3-202
+ *   30.9.1.1.5 aPSEPowerDetectionStatus
+ * @ETHTOOL_C33_PSE_EVENT_CLASSIFICATION: classification process occur on the
+ *   PSE. IEEE 802.3-2022 33.2.6 and 145.2.8 classification of PDs mutual
+ *   identification. IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification.
+ * @ETHTOOL_C33_PSE_EVENT_DISCONNECTION: PD has been disconnected on the PSE.
+ *   IEEE 802.3-2022 33.3.8 and 145.3.9 PD Maintain Power Signature. IEEE
+ *   802.3-2022 33.5.1.2.9 MPS Absent. IEEE 802.3-2022 30.9.1.1.20
+ *   aPSEMPSAbsentCounter.
+ * @ETHTOOL_PSE_EVENT_OVER_BUDGET: PSE turned off due to over budget situation
+ * @ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR: PSE faced an error managing the
+ *   power control from software
  */
 enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_OVER_CURRENT = 1,
 	ETHTOOL_PSE_EVENT_OVER_TEMP = 2,
+	ETHTOOL_C33_PSE_EVENT_DETECTION = 4,
+	ETHTOOL_C33_PSE_EVENT_CLASSIFICATION = 8,
+	ETHTOOL_C33_PSE_EVENT_DISCONNECTION = 16,
+	ETHTOOL_PSE_EVENT_OVER_BUDGET = 32,
+	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
 enum {

-- 
2.43.0


