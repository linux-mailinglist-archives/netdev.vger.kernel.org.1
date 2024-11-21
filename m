Return-Path: <netdev+bounces-146673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C39D4F19
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752B2280DCF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31D1E0DF7;
	Thu, 21 Nov 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iOdPRo8Y"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745921E1028;
	Thu, 21 Nov 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200263; cv=none; b=EM9qhv1afh80fUSs3P/4E2av8zBhbpP9mOATXR5E2NLwVTxI++Lrfs9aegDio3sbnyYqhkpxuZYWdDPDs2ehh32LZvqHu+C0GouEhw2agUs7ZkWKvwYHNPVfx4WBOlcemmyX/5QOts9BEqcjC1BGWUB8xVR1YSD1GE2ccXpcPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200263; c=relaxed/simple;
	bh=jZ+p6SWY/sur9QXkhHK7CuEAnJCoxKWsnZyEYwFMLjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPmni3izBmyf48YM+q5WOYFz4M7MFjwmoiZa43wCf6bAl4SClenxIQRPKB14QMoCulaLCpWvBUUc/8qqIk+sxjIJ3BYe7gw1wBw2AI7OkoqsBG/eIokWA4aqEenFq8BhP5E/si98LZ6U8xknNFunEiEPFCpPrVAipgKCB7yhSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iOdPRo8Y; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D844840009;
	Thu, 21 Nov 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkyFhoREI2ODCCiYHamIwNZ5qVV9BPNhyEjx2uNNK/s=;
	b=iOdPRo8Y13nZ7Dql8Ncf+8UzE1MrrY+tgWkAs/aounqBgQJtz/m2tnKouMK+1cpm4ThTx1
	4XUDGFib8erp2rFaIZRWIFCCC/xlOubuDLpyRPr6Qb2B+WdTKarSGHQI6tF5m2tUiSTUju
	zTpbLHR0D/+VgSSQZIPyJ6uqRYyLQDrf/LM3G0zopcdFp8BEd2RWM1lcA9MH5Kuqe9LLeR
	WiGk0lxfVQdytCJh92Cl9Y7hoNFlPM8JuYLVxwcaXuktHDlcb1mNYJTkNM9KYTdLwvyoR6
	6I+j3m//pJW2j3ApyS93851q1wc+OTpIe+FR/AJP4iybuZSCoGtd4UW+gEymzg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:47 +0100
Subject: [PATCH RFC net-next v3 21/27] net: pse-pd: Add support for getting
 and setting port priority
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
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

This patch introduces the ability to configure the PSE PI port priority.
Port priority is utilized by PSE controllers to determine which ports to
turn off first in scenarios such as power budget exceedance.

The pis_prio_max value is used to define the maximum priority level
supported by the controller. Both the current priority and the maximum
priority are exposed to the user through the pse_ethtool_get_status call.

This patch add support for two mode of port priority modes.
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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- Add disconnection policy.
- Add management of disabled port priority in the interrupt handler.
- Move port prio mode in the power domain instead of the PSE.

Change in v2:
- Rethink the port priority support.
---
 drivers/net/pse-pd/pse_core.c | 550 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/pse-pd/pse.h    |  63 +++++
 include/uapi/linux/ethtool.h  |  73 ++++++
 3 files changed, 676 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index ff0ffbccf139..f15a693692ae 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -40,10 +40,17 @@ struct pse_control {
  * struct pse_power_domain - a PSE power domain
  * @id: ID of the power domain
  * @supply: Power supply the Power Domain
+ * @port_prio_mode: Current port priority mode of the power domain
+ * @discon_pol: Current disonnection policy of the power domain
+ * @pi_lrc_id: ID of the last recently connected PI. -1 if none. Relevant
+ *	       for static port priority mode.
  */
 struct pse_power_domain {
 	int id;
 	struct regulator *supply;
+	u32 port_prio_mode;
+	u32 discon_pol;
+	int pi_lrc_id;
 };
 
 static int of_load_single_pse_pi_pairset(struct device_node *node,
@@ -222,6 +229,33 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
+{
+	if (!pi->pw_d)
+		return;
+
+	regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated);
+}
+
+/* Helper returning true if the power control is managed from the software
+ * in the interrupt handler
+ */
+static bool pse_pw_d_is_sw_pw_control(struct pse_controller_dev *pcdev,
+				      struct pse_power_domain *pw_d)
+{
+	if (!pw_d)
+		return false;
+
+	if (pw_d->port_prio_mode & ETHTOOL_PSE_PORT_PRIO_STATIC)
+		return true;
+	if (pw_d->port_prio_mode == ETHTOOL_PSE_PORT_PRIO_DISABLED &&
+	    pcdev->ops->pi_enable && pcdev->ops->pi_get_pw_req &&
+	    pcdev->irq)
+		return true;
+
+	return false;
+}
+
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
@@ -234,6 +268,13 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
+		ret = pcdev->pi[id].isr_enabled &&
+		      pcdev->pi[id].admin_state_enabled;
+		mutex_unlock(&pcdev->lock);
+		return ret;
+	}
+
 	ret = ops->pi_is_enabled(pcdev, id);
 	mutex_unlock(&pcdev->lock);
 
@@ -244,7 +285,7 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
-	int id, ret;
+	int id, ret = 0;
 
 	ops = pcdev->ops;
 	if (!ops->pi_enable)
@@ -252,6 +293,21 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
+		/* Manage enabled status by software.
+		 * Real enable process will happen if a port is connected.
+		 */
+		if (pcdev->pi[id].isr_enabled) {
+			ret = ops->pi_enable(pcdev, id);
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
@@ -264,6 +320,7 @@ static int pse_pi_disable(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
+	struct pse_pi *pi;
 	int id, ret;
 
 	ops = pcdev->ops;
@@ -272,9 +329,16 @@ static int pse_pi_disable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+
+	pi = &pcdev->pi[id];
 	ret = ops->pi_disable(pcdev, id);
-	if (!ret)
-		pcdev->pi[id].admin_state_enabled = 0;
+	if (!ret) {
+		pse_pi_deallocate_pw_budget(pi);
+		pi->admin_state_enabled = 0;
+		pi->isr_enabled = 0;
+		if (pi->pw_d && pi->pw_d->pi_lrc_id == id)
+			pi->pw_d->pi_lrc_id = -1;
+	}
 	mutex_unlock(&pcdev->lock);
 
 	return ret;
@@ -516,6 +580,8 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		}
 
 		pw_d->supply = supply;
+		pw_d->port_prio_mode = ETHTOOL_PSE_PORT_PRIO_DISABLED;
+		pw_d->discon_pol = ETHTOOL_PSE_DISCON_ROUND_ROBIN_IDX_LOWEST_FIRST;
 		pcdev->pi[i].pw_d = pw_d;
 	}
 
@@ -539,6 +605,7 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	if (ret < 0)
 		return ret;
 	pcdev->id = ret;
+	pcdev->port_prio_supp_modes |= ETHTOOL_PSE_PORT_PRIO_DISABLED;
 
 	if (!pcdev->nr_lines)
 		pcdev->nr_lines = 1;
@@ -683,10 +750,279 @@ pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
 		}
 	}
 	mutex_unlock(&pse_list_mutex);
-
 	return NULL;
 }
 
+static int pse_pi_disable_isr(struct pse_controller_dev *pcdev, int id,
+			      struct netlink_ext_ack *extack)
+{
+	const struct pse_controller_ops *ops = pcdev->ops;
+	struct pse_pi *pi = &pcdev->pi[id];
+	int ret;
+
+	if (!ops->pi_disable) {
+		NL_SET_ERR_MSG(extack, "PSE does not support disable control");
+		return -EOPNOTSUPP;
+	}
+
+	if (!pi->isr_enabled)
+		return 0;
+
+	if (pi->admin_state_enabled) {
+		ret = ops->pi_disable(pcdev, id);
+		if (ret) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PI %d: disable error %d",
+					   id, ret);
+			return ret;
+		}
+	}
+
+	pse_pi_deallocate_pw_budget(pi);
+	pi->isr_enabled = 0;
+	if (pi->pw_d && pi->pw_d->pi_lrc_id == id)
+		pi->pw_d->pi_lrc_id = -1;
+
+	return 0;
+}
+
+static int _pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
+{
+	unsigned long notifs = ETHTOOL_C33_PSE_EVENT_DISCONNECTION;
+	struct netlink_ext_ack extack = {};
+	struct phy_device *phydev;
+	int ret;
+
+	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
+
+	NL_SET_ERR_MSG_FMT(&extack,
+			   "Disabling PI %d to free power budget", id);
+
+	ret = pse_pi_disable_isr(pcdev, id, &extack);
+	if (ret)
+		notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
+	phydev = pse_control_find_phy_by_id(pcdev, id);
+	if (phydev)
+		ethnl_pse_send_ntf(phydev, notifs, &extack);
+
+	return ret;
+}
+
+static int pse_disable_pi_prio_lrc(struct pse_controller_dev *pcdev,
+				   struct pse_power_domain *pw_d,
+				   int prio)
+{
+	int lrc_id = pw_d->pi_lrc_id;
+	int ret;
+
+	if (lrc_id < 0)
+		return 0;
+
+	if (pcdev->pi[lrc_id].prio != prio)
+		return 0;
+
+	ret = _pse_disable_pi_pol(pcdev, lrc_id);
+	if (ret)
+		return ret;
+
+	/* PI disabled */
+	return 1;
+}
+
+static int pse_disable_pi_prio_round_rob_low(struct pse_controller_dev *pcdev,
+					     struct pse_power_domain *pw_d,
+					     int prio)
+{
+	int i;
+
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		int ret;
+
+		if (pcdev->pi[i].prio != prio ||
+		    pcdev->pi[i].pw_d != pw_d ||
+		    !pcdev->pi[i].isr_enabled)
+			continue;
+
+		ret = _pse_disable_pi_pol(pcdev, i);
+		if (ret)
+			return ret;
+
+		/* PI disabled */
+		return 1;
+	}
+
+	/* No PI disabled */
+	return 0;
+}
+
+static int pse_disable_pi_prio_pol(struct pse_controller_dev *pcdev,
+				   struct pse_power_domain *pw_d,
+				   int prio)
+{
+	int ret;
+
+	if (pw_d->discon_pol & ETHTOOL_PSE_DISCON_LRC) {
+		ret = pse_disable_pi_prio_lrc(pcdev, pw_d, prio);
+		if (ret)
+			return ret;
+	}
+
+	if (pw_d->discon_pol &
+	    ETHTOOL_PSE_DISCON_ROUND_ROBIN_IDX_LOWEST_FIRST) {
+		ret = pse_disable_pi_prio_round_rob_low(pcdev, pw_d, prio);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int
+pse_pi_allocate_pw_budget_static_prio(struct pse_controller_dev *pcdev, int id,
+				      int pw_req, struct netlink_ext_ack *extack)
+{
+	struct pse_pi *pi = &pcdev->pi[id];
+	int ret, _prio;
+
+	_prio = pcdev->nr_lines;
+	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
+		ret = pse_disable_pi_prio_pol(pcdev, pi->pw_d, _prio);
+		if (ret < 0)
+			return ret;
+		/* No pi disabled, decrease priority value */
+		if (!ret)
+			_prio--;
+
+		if (_prio <= pi->prio) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PI %d: not enough power budget available",
+					   id);
+			return -ERANGE;
+		}
+	}
+
+	pi->pw_allocated = pw_req;
+	return 0;
+}
+
+static int pse_pi_allocate_pw_budget(struct pse_controller_dev *pcdev, int id,
+				     int pw_req, struct netlink_ext_ack *extack)
+{
+	struct pse_pi *pi = &pcdev->pi[id];
+	int ret;
+
+	if (!pi->pw_d)
+		return 0;
+
+	/* ETHTOOL_PSE_PORT_PRIO_STATIC */
+	if (pi->pw_d->port_prio_mode & ETHTOOL_PSE_PORT_PRIO_STATIC)
+		return pse_pi_allocate_pw_budget_static_prio(pcdev, id, pw_req,
+							     extack);
+
+	/* ETHTOOL_PSE_PORT_PRIO_DISABLED */
+	ret = regulator_request_power_budget(pi->pw_d->supply, pw_req);
+	if (ret)
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PI %d: not enough power budget available",
+				   id);
+	else
+		pi->pw_allocated = pw_req;
+
+	return ret;
+}
+
+static int pse_pi_enable_isr(struct pse_controller_dev *pcdev, int id,
+			     struct netlink_ext_ack *extack)
+{
+	const struct pse_controller_ops *ops = pcdev->ops;
+	struct pse_pi *pi = &pcdev->pi[id];
+	int ret, pw_req;
+
+	if (!ops->pi_enable || !ops->pi_get_pw_req) {
+		NL_SET_ERR_MSG(extack, "PSE does not support enable control");
+		return -EOPNOTSUPP;
+	}
+
+	if (pi->isr_enabled)
+		return 0;
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
+	if (ops->pi_get_current_limit && ops->pi_get_voltage) {
+		int uV, mW;
+		s64 tmp_64;
+
+		ret = ops->pi_get_voltage(pcdev, id);
+		if (ret < 0)
+			return ret;
+		uV = ret;
+
+		ret = ops->pi_get_current_limit(pcdev, id);
+		if (ret < 0)
+			return ret;
+
+		tmp_64 = ret;
+		tmp_64 *= uV;
+		/* mW = uV * uA / 1000000000 */
+		mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+		if (mW < pw_req)
+			pw_req = mW;
+	}
+
+	ret = pse_pi_allocate_pw_budget(pcdev, id, pw_req, extack);
+	if (ret)
+		return ret;
+
+	if (pi->admin_state_enabled) {
+		ret = ops->pi_enable(pcdev, id);
+		if (ret) {
+			pse_pi_deallocate_pw_budget(pi);
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PI %d: enable error %d",
+					   id, ret);
+			return ret;
+		}
+	}
+
+	pi->isr_enabled = 1;
+	if (pi->pw_d)
+		pi->pw_d->pi_lrc_id = id;
+	return 0;
+}
+
+static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
+			      unsigned long notifs,
+			      struct netlink_ext_ack *extack)
+{
+	int ret = 0;
+
+	if (notifs & ETHTOOL_PSE_PORT_PRIO_DYNAMIC)
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
+	if (notifs & ETHTOOL_C33_PSE_EVENT_CLASSIFICATION)
+		ret = pse_pi_enable_isr(pcdev, id, extack);
+	else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION)
+		ret = pse_pi_disable_isr(pcdev, id, extack);
+
+	return ret;
+}
+
 static irqreturn_t pse_isr(int irq, void *data)
 {
 	struct netlink_ext_ack extack = {};
@@ -703,9 +1039,10 @@ static irqreturn_t pse_isr(int irq, void *data)
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
@@ -716,6 +1053,12 @@ static irqreturn_t pse_isr(int irq, void *data)
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
 
@@ -727,6 +1070,8 @@ static irqreturn_t pse_isr(int irq, void *data)
 					      NULL);
 	}
 
+	mutex_unlock(&pcdev->lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -971,6 +1316,7 @@ static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
 				   struct pse_control_status *status)
 {
 	const struct pse_controller_ops *ops;
+	struct pse_pi *pi = &pcdev->pi[id];
 
 	ops = pcdev->ops;
 	if (!ops->ethtool_get_status) {
@@ -980,8 +1326,23 @@ static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
 	}
 
 	status->pse_id = pcdev->id;
-	if (pcdev->pi[id].pw_d)
-		status->pw_d_id = pcdev->pi[id].pw_d->id;
+	if (pi->pw_d) {
+		status->pw_d_id = pi->pw_d->id;
+		status->c33_prio_mode = pi->pw_d->port_prio_mode;
+		status->c33_discon_pol = pi->pw_d->discon_pol;
+		switch (pi->pw_d->port_prio_mode) {
+		case ETHTOOL_PSE_PORT_PRIO_STATIC:
+			status->c33_prio_max = pcdev->nr_lines;
+			status->c33_prio = pi->prio;
+			break;
+		case ETHTOOL_PSE_PORT_PRIO_DYNAMIC:
+			status->c33_prio_max = pcdev->pis_prio_max;
+			break;
+		default:
+			break;
+		}
+		status->c33_prio_supp_modes = pcdev->port_prio_supp_modes;
+	}
 
 	return ops->ethtool_get_status(pcdev, id, extack, status);
 }
@@ -1020,8 +1381,9 @@ static int pse_ethtool_c33_set_config(struct pse_control *psec,
 	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
 		/* We could have mismatch between admin_state_enabled and
 		 * state reported by regulator_is_enabled. This can occur when
-		 * the PI is forcibly turn off by the controller. Call
-		 * regulator_disable on that case to fix the counters state.
+		 * the PI is forcibly turn off by the controller or by the
+		 * interrupt context. Call regulator_disable on that case
+		 * to fix the counters state.
 		 */
 		if (psec->pcdev->pi[psec->id].admin_state_enabled &&
 		    !regulator_is_enabled(psec->ps)) {
@@ -1094,6 +1456,32 @@ int pse_ethtool_set_config(struct pse_control *psec,
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
 
+static int pse_pi_update_pw_budget(struct pse_pi *pi, int id,
+				   const unsigned int pw_limit,
+				   struct netlink_ext_ack *extack)
+{
+	int pw_diff, ret;
+
+	pw_diff = pw_limit - pi->pw_allocated;
+	if (!pw_diff) {
+		return 0;
+	} else if (pw_diff > 0) {
+		ret = regulator_request_power_budget(pi->pw_d->supply, pw_diff);
+		if (ret) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PI %d: not enough power budget available",
+					   id);
+			return ret;
+		}
+
+	} else {
+		regulator_free_power_budget(pi->pw_d->supply, -pw_diff);
+	}
+	pi->pw_allocated = pw_limit;
+
+	return 0;
+}
+
 /**
  * pse_ethtool_set_pw_limit - set PSE control power limit
  * @psec: PSE control pointer
@@ -1130,10 +1518,152 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	/* uA = mW * 1000000000 / uV */
 	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
 
+	if (psec->pcdev->pi[psec->id].pw_d) {
+		ret = pse_pi_update_pw_budget(&psec->pcdev->pi[psec->id],
+					      psec->id, pw_limit, extack);
+		if (ret)
+			return ret;
+	}
+
 	return regulator_set_current_limit(psec->ps, 0, uA);
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_pw_limit);
 
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
+	switch (pcdev->pi[psec->id].pw_d->port_prio_mode) {
+	case ETHTOOL_PSE_PORT_PRIO_STATIC:
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
+	case ETHTOOL_PSE_PORT_PRIO_DYNAMIC:
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
+int pse_ethtool_set_prio_mode(struct pse_control *psec,
+			      struct netlink_ext_ack *extack,
+			      u32 prio_mode)
+{
+	struct pse_controller_dev *pcdev = psec->pcdev;
+	const struct pse_controller_ops *ops;
+	int ret = 0, i;
+
+	if (!(prio_mode & pcdev->port_prio_supp_modes)) {
+		NL_SET_ERR_MSG(extack, "priority mode not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (!pcdev->pi[psec->id].pw_d) {
+		NL_SET_ERR_MSG(extack, "no power domain attached");
+		return -EOPNOTSUPP;
+	}
+
+	/* ETHTOOL_PSE_PORT_PRIO_DISABLED can't be ORed with another mode */
+	if (prio_mode & ETHTOOL_PSE_PORT_PRIO_DISABLED &&
+	    prio_mode & ~ETHTOOL_PSE_PORT_PRIO_DISABLED) {
+		NL_SET_ERR_MSG(extack,
+			       "port priority can't be enabled and disabled simultaneously");
+		return -EINVAL;
+	}
+
+	ops = psec->pcdev->ops;
+
+	/* We don't want priority mode change in the middle of an
+	 * enable/disable call
+	 */
+	mutex_lock(&pcdev->lock);
+	pcdev->pi[psec->id].pw_d->port_prio_mode = prio_mode;
+
+	/* Reset all priorities of the Power Domain */
+	for (i = 0; i < psec->pcdev->nr_lines; i++) {
+		if (!pcdev->pi[i].rdev ||
+		    pcdev->pi[i].pw_d != pcdev->pi[psec->id].pw_d)
+			continue;
+
+		pcdev->pi[i].prio = 0;
+
+		if (!ops->pi_set_prio)
+			continue;
+
+		if (pcdev->port_prio_supp_modes &
+		    ETHTOOL_PSE_PORT_PRIO_DYNAMIC)
+			ret = ops->pi_set_prio(pcdev, psec->id, 0);
+	}
+
+	mutex_unlock(&psec->pcdev->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_prio_mode);
+
+int pse_ethtool_set_discon_pol(struct pse_control *psec,
+			       struct netlink_ext_ack *extack,
+			       u32 pol)
+{
+	struct pse_controller_dev *pcdev = psec->pcdev;
+
+	if (!pcdev->pi[psec->id].pw_d) {
+		NL_SET_ERR_MSG(extack, "no power domain attached");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&pcdev->lock);
+	pcdev->pi[psec->id].pw_d->discon_pol = pol;
+	mutex_unlock(&psec->pcdev->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_discon_pol);
+
 bool pse_has_podl(struct pse_control *psec)
 {
 	return psec->pcdev->types & ETHTOOL_PSE_PODL;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index bdf3e8c468fc..e84eba710dc8 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
 #include <linux/regulator/driver.h>
+#include <linux/workqueue.h>
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
@@ -62,6 +63,13 @@ struct pse_control_config {
  *	is in charge of the memory allocation.
  * @c33_pw_limit_nb_ranges: number of supported power limit configuration
  *	ranges
+ * @c33_prio_supp_modes: PSE port priority modes supported. Set by PSE core.
+ * @c33_prio_mode: PSE port priority mode selected. Set by PSE core.
+ * @c33_prio_max: max priority allowed for the c33_prio variable value. Set
+ *	by PSE core.
+ * @c33_prio: priority of the PSE. Set by PSE core in case of static port
+ *	priority mode.
+ * @c33_discon_pol: PSE disconnection policy selected. Set by PSE core.
  */
 struct pse_control_status {
 	u32 pse_id;
@@ -76,6 +84,11 @@ struct pse_control_status {
 	u32 c33_avail_pw_limit;
 	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
 	u32 c33_pw_limit_nb_ranges;
+	u32 c33_prio_supp_modes;
+	enum pse_port_prio_modes c33_prio_mode;
+	u32 c33_prio_max;
+	u32 c33_prio;
+	u32 c33_discon_pol;
 };
 
 /**
@@ -95,6 +108,10 @@ struct pse_control_status {
  *			  set_current_limit regulator callback.
  *			  Should not return an error in case of MAX_PI_CURRENT
  *			  current value set.
+ * @pi_set_prio: Configure the PSE PI priority.
+ * @pi_get_pw_req: Get the power requested by a PD before enabling the PSE PI.
+ *		   This is only relevant when an interrupt is registered using
+ *		   devm_pse_irq_helper helper.
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -109,6 +126,9 @@ struct pse_controller_ops {
 				    int id);
 	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
 				    int id, int max_uA);
+	int (*pi_set_prio)(struct pse_controller_dev *pcdev, int id,
+			   unsigned int prio);
+	int (*pi_get_pw_req)(struct pse_controller_dev *pcdev, int id);
 };
 
 struct module;
@@ -143,6 +163,12 @@ struct pse_pi_pairset {
  * @rdev: regulator represented by the PSE PI
  * @admin_state_enabled: PI enabled state
  * @pw_d: Power domain of the PSE PI
+ * @prio: Priority of the PSE PI. Used in static port priority mode
+ * @isr_enabled: PSE PI power status managed by the interruption handler.
+ *		 This variable is relevant when the power enabled management
+ *		 is a managed in software like the static port priority mode.
+ * @pw_allocated: Power allocated to a PSE PI to manage power budget in
+ *	static port priority mode
  */
 struct pse_pi {
 	struct pse_pi_pairset pairset[2];
@@ -150,6 +176,9 @@ struct pse_pi {
 	struct regulator_dev *rdev;
 	bool admin_state_enabled;
 	struct pse_power_domain *pw_d;
+	int prio;
+	bool isr_enabled;
+	int pw_allocated;
 };
 
 /**
@@ -168,6 +197,8 @@ struct pse_pi {
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
  * @id: Index of the PSE
  * @irq: PSE interrupt
+ * @pis_prio_max: Maximum value allowed for the PSE PIs priority
+ * @port_prio_supp_modes: Bitfield of port priority mode supported by the PSE
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -183,6 +214,8 @@ struct pse_controller_dev {
 	bool no_of_pse_pi;
 	u32 id;
 	int irq;
+	unsigned int pis_prio_max;
+	u32 port_prio_supp_modes;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -207,6 +240,15 @@ int pse_ethtool_set_config(struct pse_control *psec,
 int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     struct netlink_ext_ack *extack,
 			     const unsigned int pw_limit);
+int pse_ethtool_set_prio(struct pse_control *psec,
+			 struct netlink_ext_ack *extack,
+			 unsigned int prio);
+int pse_ethtool_set_prio_mode(struct pse_control *psec,
+			      struct netlink_ext_ack *extack,
+			      u32 prio_mode);
+int pse_ethtool_set_discon_pol(struct pse_control *psec,
+			       struct netlink_ext_ack *extack,
+			       u32 pol);
 
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
@@ -244,6 +286,27 @@ static inline int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	return -EOPNOTSUPP;
 }
 
+static inline int pse_ethtool_set_prio(struct pse_control *psec,
+				       struct netlink_ext_ack *extack,
+				       unsigned int prio)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pse_ethtool_set_prio_mode(struct pse_control *psec,
+					    struct netlink_ext_ack *extack,
+					    u32 prio_mode)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pse_ethtool_set_discon_pol(struct pse_control *psec,
+					     struct netlink_ext_ack *extack,
+					     u32 pol)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool pse_has_podl(struct pse_control *psec)
 {
 	return false;
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index a4c93d6de218..b6727049840c 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1002,11 +1002,84 @@ enum ethtool_c33_pse_pw_d_status {
  * enum ethtool_pse_events - event list of the PSE controller.
  * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
  * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
+ * @ETHTOOL_C33_PSE_EVENT_DETECTION: detection process occur on the PSE.
+ *	IEEE 802.3-2022 145.2.6 PSE detection of PDs
+ * @ETHTOOL_C33_PSE_EVENT_CLASSIFICATION: classification process occur on
+ *	the PSE. IEEE 802.3-2022 145.2.8 PSE classification of PDs and
+ *	mutual identification
+ * @ETHTOOL_C33_PSE_EVENT_DISCONNECTION: PD has been disconnected on the PSE.
+ * @ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR: PSE faced an error managing the
+ *	power control from software.
  */
 
 enum ethtool_pse_events {
 	ETHTOOL_PSE_EVENT_OVER_CURRENT =	1 << 0,
 	ETHTOOL_PSE_EVENT_OVER_TEMP =		1 << 1,
+	ETHTOOL_C33_PSE_EVENT_DETECTION =	1 << 2,
+	ETHTOOL_C33_PSE_EVENT_CLASSIFICATION =	1 << 3,
+	ETHTOOL_C33_PSE_EVENT_DISCONNECTION =	1 << 4,
+	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR =	1 << 5,
+};
+
+/**
+ * enum pse_port_prio_modes - PSE port priority modes.
+ * @ETHTOOL_PSE_PORT_PRIO_DISABLED: Port priority disabled.
+ * @ETHTOOL_PSE_PORT_PRIO_STATIC: PSE static port priority. Port priority
+ *	based on the power requested during PD classification. This mode
+ *	is managed by the PSE core.
+ * @ETHTOOL_PSE_PORT_PRIO_DYNAMIC: PSE dynamic port priority. Port priority
+ *	based on the current consumption per ports compared to the total
+ *	power budget. This mode is managed by the PSE controller.
+ */
+
+enum pse_port_prio_modes {
+	ETHTOOL_PSE_PORT_PRIO_DISABLED	= 1 << 0,
+	ETHTOOL_PSE_PORT_PRIO_STATIC	= 1 << 1,
+	ETHTOOL_PSE_PORT_PRIO_DYNAMIC	= 1 << 2,
+};
+
+/**
+ * enum ethtool_pse_disconnection_policy - Disconnection strategies for
+ *	same-priority devices when power budget is exceeded, tailored to
+ *	specific priority modes.
+ *
+ * @ETHTOOL_PSE_DISCON_LRC: Disconnect least recently connected device.
+ *	Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
+ *	Behavior: When multiple devices share the same priority level, the
+ *	system disconnects the device that was most recently connected.
+ *	Rationale: This strategy favors stability for longer-standing
+ *	connections, assuming that established devices may be more critical.
+ *	Use Case: Suitable for systems prioritizing stable power allocation for
+ *	existing static-priority connections, making newer devices suitable
+ *	candidates for disconnection if limits are exceeded.
+ * @ETHTOOL_PSE_DISCON_ROUND_ROBIN_IDX_LOWEST_FIRST: Disconnect based on port
+ *	index in a round-robin manner, starting with the lowest index.
+ *	Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
+ *	Behavior: Disconnects devices sequentially based on port index, starting
+ *	with the lowest. If multiple disconnections are required, the process
+ *	continues in ascending order.
+ *	Rationale: Provides a predictable, systematic approach for
+ *	static-priority devices, making it clear which device will be
+ *	disconnected next if power limits are reached.
+ *	Use Case: Appropriate for systems where static-priority devices are
+ *	equal in role, and fairness in disconnections is prioritized.
+ *
+ * Each device can have multiple disconnection policies set as an array of
+ * priorities. When the power budget is exceeded, the policies are executed
+ * in the order defined by the user. This allows for a more nuanced and
+ * flexible approach to handling power constraints across a range of devices
+ * with similar priorities or attributes.
+ *
+ * Example Usage:
+ *   Users can specify an ordered list of policies, such as starting with
+ *   `PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST` to prioritize based on class,
+ *   followed by `PSE_DISCON_LRC` to break ties based on connection time.
+ *   This ordered execution ensures that power disconnections align closely
+ *   with the system’s operational requirements and priorities.
+ */
+enum ethtool_pse_disconnection_policy {
+	ETHTOOL_PSE_DISCON_LRC = 1 << 0,
+	ETHTOOL_PSE_DISCON_ROUND_ROBIN_IDX_LOWEST_FIRST = 1 << 1,
 };
 
 /**

-- 
2.34.1


