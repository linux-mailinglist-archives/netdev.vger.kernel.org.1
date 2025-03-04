Return-Path: <netdev+bounces-171566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C1BA4DA28
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AB43A8B72
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6CB200BBD;
	Tue,  4 Mar 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QMKuVl8x"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E71FF7D3;
	Tue,  4 Mar 2025 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083653; cv=none; b=mUgmOukPedWIE+bOjBZOUG4PlZtgEnb9xuUNHkZdN/1gkgJzfrhQny/2VtozeV5aURLZLe4y7fuMlClSwOkXKre+3uwg+tnYE33B/DNTvGJUkW3lRxdewkI1E/UylfPkW5TbZcSwBjP1Eeo6AmUwjqkZIg0JjPIpA1boM7or77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083653; c=relaxed/simple;
	bh=6XoWcdASbAacNW+cXPX7CmeKXfeI+/qMuG/K0aEfTEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0NeBlOvN+aqcAbvo6U74av1kJLhtvjLK3++HsuixunPVb10LB4aiYsT9oLiaLIOOO2pN+rat1SF5ATbkj2x4/GpgaFf8euW5QmUKLcCH/KuwPGmM6Mitr0quYII3oQl+ETElUPFPFEJ1LFukEtDEIKsO70+UI7oQVUta7K5LBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QMKuVl8x; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1B93432BD;
	Tue,  4 Mar 2025 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741083648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUryjVZsjq1p4A+L2KLfgdWU9g5yd+MpU8973978tRs=;
	b=QMKuVl8xJW7EJkxOLdUgbIkqMZPF/gCuAWkdGoqCIagCJSw4wL6/PzS1M+XYR1OUibzVFE
	DMq5ES/sws8RiLZxHlrVvz5C6vOpX53H7c7eAubb6QGVknQOuj72ZtT+uFd4zuCiFKGu5e
	Oz6RtRgU48ukneF4Kd1gDT9cDYU2/ee0GaIo9WgQoDD9+z+IRpVLwkqYrcU2/Xl947cqoP
	6PHQH6ZQx81VzgkAuT3hmIu09zf+J7zrocNmsodrgwQJ0N9ZWx/2DDxOLb/9QLzymPyxTo
	PPJYwB+JivGcJ0WHKOFPeF30sbnJnjedn+Gxeouu3bVvNgIIqI+76LTSaLz3QQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Mar 2025 11:18:55 +0100
Subject: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
In-Reply-To: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddujeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeikefgjedvkedugfeiheffgeeflefgteduleeuvdeitdfgtddvleetieekffffkeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigf
 hhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthh
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
---
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
 drivers/net/pse-pd/pse_core.c | 624 ++++++++++++++++++++++++++++++++++++++----
 include/linux/pse-pd/pse.h    |  44 +++
 include/uapi/linux/ethtool.h  |  39 ++-
 3 files changed, 660 insertions(+), 47 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index cb3477e4bd67b..e5b40e684fff5 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -40,10 +40,13 @@ struct pse_control {
  * struct pse_power_domain - a PSE power domain
  * @id: ID of the power domain
  * @supply: Power supply the Power Domain
+ * @budget_eval_strategy: Current power budget evaluation strategy of the
+ *			  power domain
  */
 struct pse_power_domain {
 	int id;
 	struct regulator *supply;
+	u32 budget_eval_strategy;
 };
 
 static int of_load_single_pse_pi_pairset(struct device_node *node,
@@ -222,6 +225,29 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+/**
+ * pse_pw_d_is_sw_pw_control - Is power control software managed
+ * @pcdev: a pointer to the PSE controller device
+ * @pw_d: a pointer to the PSE power domain
+ *
+ * Return: true if the power control of the power domain is managed from
+ * the software in the interrupt handler
+ */
+static bool pse_pw_d_is_sw_pw_control(struct pse_controller_dev *pcdev,
+				      struct pse_power_domain *pw_d)
+{
+	if (!pw_d)
+		return false;
+
+	if (pw_d->budget_eval_strategy == ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC)
+		return true;
+	if (pw_d->budget_eval_strategy == ETHTOOL_PSE_BUDGET_EVAL_STRAT_DISABLED &&
+	    pcdev->ops->pi_enable && pcdev->irq)
+		return true;
+
+	return false;
+}
+
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
@@ -235,6 +261,11 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
+		ret = pcdev->pi[id].admin_state_enabled;
+		goto out;
+	}
+
 	ret = ops->pi_get_admin_state(pcdev, id, &admin_state);
 	if (ret)
 		goto out;
@@ -249,11 +280,260 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
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
+	return 0;
+}
+
+/**
+ * pse_control_find_phy_by_id - Find PHY attached to the pse control id
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
+	return NULL;
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
+	struct netlink_ext_ack extack = {};
+	struct phy_device *phydev;
+	int ret;
+
+	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
+
+	NL_SET_ERR_MSG_FMT(&extack,
+			   "Disabling PI %d to free power budget", id);
+
+	ret = _pse_pi_disable(pcdev, id);
+	if (ret) {
+		notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
+	} else {
+		pcdev->pi[id].admin_state_enabled = 0;
+		pcdev->pi[id]._isr_counter_mismatch = 1;
+	}
+
+	phydev = pse_control_find_phy_by_id(pcdev, id);
+	if (phydev)
+		ethnl_pse_send_ntf(phydev, notifs, &extack);
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
+		    !pcdev->pi[i].admin_state_enabled)
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
+	/* ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC */
+	if (pi->pw_d->budget_eval_strategy == ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC)
+		return pse_pi_allocate_pw_budget_static_prio(pcdev, id, pw_req,
+							     extack);
+
+	return 0;
+}
+
+/**
+ * _pse_pi_enable_sw_pw_ctrl - Enable PSE PI in case of software power control.
+ *			       Assumes the PSE lock has been acquired
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ * @extack: extack for error reporting
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int _pse_pi_enable_sw_pw_ctrl(struct pse_controller_dev *pcdev, int id,
+				     struct netlink_ext_ack *extack)
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
@@ -261,6 +541,23 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
+		/* Manage enabled status by software.
+		 * Real enable process will happen if a port is connected.
+		 */
+		if (pcdev->pi[id].isr_pd_detected) {
+			struct netlink_ext_ack extack;
+
+			ret = _pse_pi_enable_sw_pw_ctrl(pcdev, id, &extack);
+			if (!ret)
+				pcdev->pi[id].admin_state_enabled = 1;
+		} else {
+			pcdev->pi[id].admin_state_enabled = 1;
+		}
+		mutex_unlock(&pcdev->lock);
+		return ret;
+	}
+
 	ret = ops->pi_enable(pcdev, id);
 	if (!ret)
 		pcdev->pi[id].admin_state_enabled = 1;
@@ -272,21 +569,20 @@ static int pse_pi_enable(struct regulator_dev *rdev)
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
-	if (!ret)
-		pcdev->pi[id].admin_state_enabled = 0;
-	mutex_unlock(&pcdev->lock);
+	ret = _pse_pi_disable(pcdev, id);
+	if (!ret) {
+		pi->admin_state_enabled = 0;
+		pcdev->pi[id]._isr_counter_mismatch = 0;
+	}
 
-	return ret;
+	mutex_unlock(&pcdev->lock);
+	return 0;
 }
 
 static int _pse_pi_get_voltage(struct regulator_dev *rdev)
@@ -542,6 +838,10 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		}
 
 		pw_d->supply = supply;
+		if (pcdev->supp_budget_eval_strategies)
+			pw_d->budget_eval_strategy = pcdev->supp_budget_eval_strategies;
+		else
+			pw_d->budget_eval_strategy = ETHTOOL_PSE_BUDGET_EVAL_STRAT_DISABLED;
 		pcdev->pi[i].pw_d = pw_d;
 	}
 
@@ -699,27 +999,45 @@ static unsigned long pse_to_regulator_notifs(unsigned long notifs)
 }
 
 /**
- * pse_control_find_phy_by_id - Find PHY attached to the pse control id
+ * pse_set_config_isr - Set PSE control config according to the PSE
+ *			notifications
  * @pcdev: a pointer to the PSE
  * @id: index of the PSE control
+ * @notifs: PSE event notifications
+ * @extack: extack for error reporting
  *
- * Return: PHY device pointer or NULL
+ * Return: 0 on success and failure value on error
  */
-static struct phy_device *
-pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
+static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
+			      unsigned long notifs,
+			      struct netlink_ext_ack *extack)
 {
-	struct pse_control *psec;
+	int ret = 0;
 
-	mutex_lock(&pse_list_mutex);
-	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
-		if (psec->id == id) {
-			mutex_unlock(&pse_list_mutex);
-			return psec->attached_phydev;
-		}
+	if (notifs & ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC)
+		return 0;
+
+	if ((notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) &&
+	    ((notifs & ETHTOOL_C33_PSE_EVENT_DETECTION) ||
+	     (notifs & ETHTOOL_C33_PSE_EVENT_CLASSIFICATION))) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PI %d: error, connection and disconnection reported simultaneously",
+				   id);
+		return -EINVAL;
 	}
-	mutex_unlock(&pse_list_mutex);
 
-	return NULL;
+	if (notifs & ETHTOOL_C33_PSE_EVENT_CLASSIFICATION) {
+		pcdev->pi[id].isr_pd_detected = true;
+		if (pcdev->pi[id].admin_state_enabled)
+			ret = _pse_pi_enable_sw_pw_ctrl(pcdev, id, extack);
+	} else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) {
+		if (pcdev->pi[id].admin_state_enabled &&
+		    pcdev->pi[id].isr_pd_detected)
+			ret = _pse_pi_disable(pcdev, id);
+		pcdev->pi[id].isr_pd_detected = false;
+	}
+
+	return ret;
 }
 
 /**
@@ -745,9 +1063,10 @@ static irqreturn_t pse_isr(int irq, void *data)
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
 		struct phy_device *phydev;
@@ -758,6 +1077,12 @@ static irqreturn_t pse_isr(int irq, void *data)
 			continue;
 
 		notifs = h->notifs[i];
+		if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[i].pw_d)) {
+			ret = pse_set_config_isr(pcdev, i, notifs, &extack);
+			if (ret)
+				notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
+		}
+
 		dev_dbg(h->pcdev->dev,
 			"Sending PSE notification EVT 0x%lx\n", notifs);
 
@@ -769,6 +1094,8 @@ static irqreturn_t pse_isr(int irq, void *data)
 					      NULL);
 	}
 
+	mutex_unlock(&pcdev->lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -863,6 +1190,7 @@ static struct pse_control *
 pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 			 struct phy_device *phydev)
 {
+	struct pse_admin_state admin_state = {0};
 	struct pse_control *psec;
 	int ret;
 
@@ -884,6 +1212,23 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
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
+	ret = pcdev->ops->pi_get_admin_state(pcdev, index, &admin_state);
+	if (ret)
+		goto free_psec;
+
+	if (admin_state.podl_admin_state == ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED ||
+	    admin_state.c33_admin_state == ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED)
+		pcdev->pi[index].admin_state_enabled = 1;
+
 	psec->ps = devm_regulator_get_exclusive(pcdev->dev,
 						rdev_get_name(pcdev->pi[index].rdev));
 	if (IS_ERR(psec->ps)) {
@@ -891,12 +1236,6 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
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
@@ -905,8 +1244,6 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 
 	return psec;
 
-regulator_put:
-	devm_regulator_put(psec->ps);
 put_module:
 	module_put(pcdev->owner);
 free_psec:
@@ -1017,6 +1354,35 @@ struct pse_control *of_pse_control_get(struct device_node *node,
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
@@ -1033,19 +1399,46 @@ int pse_ethtool_get_status(struct pse_control *psec,
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
+		case ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC:
+			status->prio_max = pcdev->nr_lines;
+			status->prio = pi->prio;
+			break;
+		case ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC:
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
@@ -1120,11 +1513,15 @@ static int pse_ethtool_c33_set_config(struct pse_control *psec,
 	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
 		/* We could have mismatch between admin_state_enabled and
 		 * state reported by regulator_is_enabled. This can occur when
-		 * the PI is forcibly turn off by the controller. Call
+		 * the PI is forcibly turn off by the controller or in power
+		 * off case in the interrupt context. Call
 		 * regulator_disable on that case to fix the counters state.
+		 * disable action might be called two times consecutively
+		 * but that is not a real issue.
 		 */
-		if (psec->pcdev->pi[psec->id].admin_state_enabled &&
-		    !regulator_is_enabled(psec->ps)) {
+		if ((psec->pcdev->pi[psec->id].admin_state_enabled &&
+		     !regulator_is_enabled(psec->ps)) ||
+		    psec->pcdev->pi[psec->id]._isr_counter_mismatch) {
 			err = regulator_disable(psec->ps);
 			if (err)
 				break;
@@ -1194,6 +1591,52 @@ int pse_ethtool_set_config(struct pse_control *psec,
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
@@ -1206,7 +1649,7 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     struct netlink_ext_ack *extack,
 			     const unsigned int pw_limit)
 {
-	int uV, uA, ret;
+	int uV, uA, ret, previous_pw_allocated = 0;
 	s64 tmp_64;
 
 	if (pw_limit > MAX_PI_PW)
@@ -1230,10 +1673,99 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
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
+	case ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC:
+		if (prio > pcdev->nr_lines) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "priority %d exceed priority max %d",
+					   prio, pcdev->nr_lines);
+			ret = -ERANGE;
+			goto out;
+		}
+
+		pcdev->pi[psec->id].prio = prio;
+		break;
+
+	case ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC:
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
index ffa6cf9a0072f..b47d2d2c807e9 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -132,6 +132,9 @@ struct pse_pw_limit_ranges {
  *	is in charge of the memory allocation
  * @c33_pw_limit_nb_ranges: number of supported power limit configuration
  *	ranges
+ * @prio_max: max priority allowed for the c33_prio variable value.
+ * @prio: priority of the PSE. Managed by PSE core in case of static budget
+ *	evaluation strategy.
  */
 struct ethtool_pse_control_status {
 	u32 pw_d_id;
@@ -145,6 +148,8 @@ struct ethtool_pse_control_status {
 	u32 c33_avail_pw_limit;
 	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
 	u32 c33_pw_limit_nb_ranges;
+	u32 prio_max;
+	u32 prio;
 };
 
 /**
@@ -168,6 +173,11 @@ struct ethtool_pse_control_status {
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
@@ -188,6 +198,10 @@ struct pse_controller_ops {
 			       int id, int max_mW);
 	int (*pi_get_pw_limit_ranges)(struct pse_controller_dev *pcdev, int id,
 				      struct pse_pw_limit_ranges *pw_limit_ranges);
+	int (*pi_get_prio)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_set_prio)(struct pse_controller_dev *pcdev, int id,
+			   unsigned int prio);
+	int (*pi_get_pw_req)(struct pse_controller_dev *pcdev, int id);
 };
 
 struct module;
@@ -223,6 +237,17 @@ struct pse_pi_pairset {
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
+ * @_isr_counter_mismatch: Internal flag used in PSE core in case of a
+ *			   counter mismatch between regulator and PSE API.
+ *			   This is caused by a disable call in the interrupt
+ *			   context handler.
  */
 struct pse_pi {
 	struct pse_pi_pairset pairset[2];
@@ -230,6 +255,10 @@ struct pse_pi {
 	struct regulator_dev *rdev;
 	bool admin_state_enabled;
 	struct pse_power_domain *pw_d;
+	int prio;
+	bool isr_pd_detected;
+	int pw_allocated_mW;
+	bool _isr_counter_mismatch;
 };
 
 /**
@@ -247,6 +276,9 @@ struct pse_pi {
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
  * @irq: PSE interrupt
+ * @pis_prio_max: Maximum value allowed for the PSE PIs priority
+ * @supp_budget_eval_strategies: budget evaluation strategies supported
+ *				 by the PSE
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -261,6 +293,8 @@ struct pse_controller_dev {
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
 	int irq;
+	unsigned int pis_prio_max;
+	u32 supp_budget_eval_strategies;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -285,6 +319,9 @@ int pse_ethtool_set_config(struct pse_control *psec,
 int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     struct netlink_ext_ack *extack,
 			     const unsigned int pw_limit);
+int pse_ethtool_set_prio(struct pse_control *psec,
+			 struct netlink_ext_ack *extack,
+			 unsigned int prio);
 
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
@@ -322,6 +359,13 @@ static inline int pse_ethtool_set_pw_limit(struct pse_control *psec,
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
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 5e99daf42d440..0c6aef700a8ff 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1006,6 +1006,20 @@ enum ethtool_c33_pse_pw_d_status {
  * enum ethtool_pse_events - event list of the PSE controller.
  * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
  * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
+ * @ETHTOOL_C33_PSE_EVENT_DETECTION: detection process occur on the PSE.
+ *	IEEE 802.3-2022 33.2.5 and 145.2.6 PSE detection of PDs.
+ *	IEEE 802.3-202 30.9.1.1.5 aPSEPowerDetectionStatus.
+ * @ETHTOOL_C33_PSE_EVENT_CLASSIFICATION: classification process occur on
+ *	the PSE. IEEE 802.3-2022 33.2.6 and 145.2.8 classification of PDs and
+ *	mutual identification.
+ *	IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification.
+ * @ETHTOOL_C33_PSE_EVENT_DISCONNECTION: PD has been disconnected on the PSE.
+ *	IEEE 802.3-2022 33.3.8 and 145.3.9 PD Maintain Power Signature.
+ *	IEEE 802.3-2022 33.5.1.2.9 MPS Absent.
+ *	IEEE 802.3-2022 30.9.1.1.20 aPSEMPSAbsentCounter.
+ * @ETHTOOL_PSE_EVENT_OVER_BUDGET: PSE turned off due to over budget situation.
+ * @ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR: PSE faced an error managing the
+ *	power control from software.
  *
  * @ETHTOOL_PSE_EVENT_LAST: Last PSE event of the enum.
  */
@@ -1013,8 +1027,31 @@ enum ethtool_c33_pse_pw_d_status {
 enum ethtool_pse_events {
 	ETHTOOL_PSE_EVENT_OVER_CURRENT =	1 << 0,
 	ETHTOOL_PSE_EVENT_OVER_TEMP =		1 << 1,
+	ETHTOOL_C33_PSE_EVENT_DETECTION =	1 << 2,
+	ETHTOOL_C33_PSE_EVENT_CLASSIFICATION =	1 << 3,
+	ETHTOOL_C33_PSE_EVENT_DISCONNECTION =	1 << 4,
+	ETHTOOL_PSE_EVENT_OVER_BUDGET =		1 << 5,
+	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR =	1 << 6,
 
-	ETHTOOL_PSE_EVENT_LAST = ETHTOOL_PSE_EVENT_OVER_TEMP,
+	ETHTOOL_PSE_EVENT_LAST = ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR,
+};
+
+/**
+ * enum ethtool_pse_budget_eval_strategies - PSE budget evaluation strategies.
+ * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_DISABLED: Budget evaluation strategy disabled.
+ * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC: PSE static budget evaluation strategy.
+ *	Budget evaluation strategy based on the power requested during PD
+ *	classification. This strategy is managed by the PSE core.
+ * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC: PSE dynamic budget evaluation
+ *	strategy. Budget evaluation strategy based on the current consumption
+ *	per ports compared to the total	power budget. This mode is managed by
+ *	the PSE controller.
+ */
+
+enum ethtool_pse_budget_eval_strategies {
+	ETHTOOL_PSE_BUDGET_EVAL_STRAT_DISABLED	= 1 << 0,
+	ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC	= 1 << 1,
+	ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC	= 1 << 2,
 };
 
 /**

-- 
2.34.1


