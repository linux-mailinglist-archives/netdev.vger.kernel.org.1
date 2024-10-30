Return-Path: <netdev+bounces-140491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805F9B69FE
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED541B22FB9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D96922A4B7;
	Wed, 30 Oct 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m7YNFqxL"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F510229132;
	Wed, 30 Oct 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307257; cv=none; b=sfAEEK+ApgvLJS0i00dMsm+kDpAUW/4eREZH9x4T451kgnX9vDbpf8x+z3byNIKW+8VXCD0kvweGGaEDw6ibj6ouDFuFhpV9Qh60TJWOlr7TfB/PlGHbEvv8wgdN7N9/xXlk2h/JcZ35TS09EGLtkKQfySaKLXwAWCJN2icvqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307257; c=relaxed/simple;
	bh=Aw35rarNrgyd9iIqV12PBn4CMkLCsURbgF2H3eKwo6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKIgsYMx4UjYSLCjnrkPB908FmBkfsEHVMfTvuhabTClFn+LjtJJXx40IS2hrbFtYLyu/t68gcDMSvpvQ8ZX3hsRsBEIdltq+CYigvB6KAuNPwyoXDEVLbQGroHyEo2d7w5iN5HqAoBQ5eyyqV9xh3Z0HRwGvr42q79L8Nv6NPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m7YNFqxL; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2CCEC0016;
	Wed, 30 Oct 2024 16:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IEJNg3a6UlsNz51NUXx0CUXxOrj3s8D1zu3Xp8SybM=;
	b=m7YNFqxL5VR9RUdHp09Ptg08rCCd5ql/CSHlHXsO77lUyh9FxQ+iTR9bzh8lVahaKoxkY2
	SZzsasZMxL0oyZOujedjE0zcdyhnJCtZpol0Su7/ZVIfpsyImZEIglU1RfSJlN4aIc4GqL
	TvH44TeJFw87AgOGRzgnDerh9+M1xwWZuONsNuS2Zy+XMKa+TKSG2aKcq9d2EV9A3n7JQn
	NjrjVJ9QZACzV/QfbRWyV+F6nH/GAMulqnh3Xt1QAzEognmGhJEx1KdBb2pkukCditIN8v
	7VwFOAo2DDLlTttt8iR4KR1FIw0cnR/XmWLTfv2AQmH8+5R+deWjBK7MukMaaQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:17 +0100
Subject: [PATCH RFC net-next v2 15/18] net: pse-pd: Add support for getting
 and setting port priority
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
In-Reply-To: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
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

Change in v2:
- Rethink the port priority support.
---
 drivers/net/pse-pd/pse_core.c | 305 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/pse-pd/pse.h    |  51 +++++++
 include/uapi/linux/ethtool.h  |  28 +++-
 3 files changed, 375 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 29374b1ce378..25911083ff3b 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -229,6 +229,9 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 		return -EOPNOTSUPP;
 
 	id = rdev_get_id(rdev);
+	if (pcdev->port_prio_mode == ETHTOOL_PSE_PORT_PRIO_STATIC)
+		return pcdev->pi[id].pw_enabled;
+
 	mutex_lock(&pcdev->lock);
 	ret = ops->pi_is_enabled(pcdev, id);
 	mutex_unlock(&pcdev->lock);
@@ -248,6 +251,16 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	if (pcdev->port_prio_mode == ETHTOOL_PSE_PORT_PRIO_STATIC) {
+		/* Manage enabled status by software.
+		 * Real enable process will happen after a port connected
+		 * event.
+		 */
+		pcdev->pi[id].admin_state_enabled = 1;
+		mutex_unlock(&pcdev->lock);
+		return 0;
+	}
+
 	ret = ops->pi_enable(pcdev, id);
 	if (!ret)
 		pcdev->pi[id].admin_state_enabled = 1;
@@ -268,9 +281,12 @@ static int pse_pi_disable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+
 	ret = ops->pi_disable(pcdev, id);
-	if (!ret)
+	if (!ret) {
 		pcdev->pi[id].admin_state_enabled = 0;
+		pcdev->pi[id].pw_enabled = 0;
+	}
 	mutex_unlock(&pcdev->lock);
 
 	return ret;
@@ -564,6 +580,7 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	if (ret < 0)
 		return ret;
 	pcdev->id = ret;
+	pcdev->port_prio_supp_modes |= BIT(ETHTOOL_PSE_PORT_PRIO_DISABLED);
 
 	if (!pcdev->nr_lines)
 		pcdev->nr_lines = 1;
@@ -704,10 +721,166 @@ pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
 			return psec->attached_phydev;
 	}
 	mutex_unlock(&pse_list_mutex);
-
 	return NULL;
 }
 
+static void pse_deallocate_pw_budget(struct pse_controller_dev *pcdev, int id)
+{
+	struct pse_power_domain *pw_d = pcdev->pi[id].pw_d;
+
+	if (!pw_d)
+		return;
+
+	pw_d->pw_budget += pcdev->pi[id].pw_allocated;
+}
+
+static int pse_pi_disable_isr(struct pse_controller_dev *pcdev, int id,
+			      struct netlink_ext_ack *extack)
+{
+	const struct pse_controller_ops *ops = pcdev->ops;
+	int ret;
+
+	if (!ops->pi_disable) {
+		NL_SET_ERR_MSG(extack, "PSE does not support disable control");
+		return -EOPNOTSUPP;
+	}
+
+	if (!pcdev->pi[id].admin_state_enabled ||
+	    !pcdev->pi[id].pw_enabled)
+		return 0;
+
+	ret = ops->pi_disable(pcdev, id);
+	if (ret) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PI %d: disable error %d",
+				   id, ret);
+		return ret;
+	}
+
+	pse_deallocate_pw_budget(pcdev, id);
+	pcdev->pi[id].pw_enabled = 0;
+	return 0;
+}
+
+static int pse_disable_pis_prio(struct pse_controller_dev *pcdev, int prio)
+{
+	int i, ret;
+
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		struct netlink_ext_ack extack = {};
+		struct phy_device *phydev;
+
+		if (pcdev->pi[i].prio != prio)
+			continue;
+
+		dev_dbg(pcdev->dev,
+			"Disabling PI %d to free power budget\n",
+			i);
+
+		NL_SET_ERR_MSG_FMT(&extack,
+				   "Disabling PI %d to free power budget",
+				   i);
+
+		ret = pse_pi_disable_isr(pcdev, i, &extack);
+		phydev = pse_control_find_phy_by_id(pcdev, i);
+		if (phydev)
+			ethnl_pse_send_ntf(phydev,
+					   ETHTOOL_C33_PSE_EVENT_DISCONNECTED,
+					   &extack);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int pse_allocate_pw_budget(struct pse_controller_dev *pcdev, int id,
+				  int pw_req, struct netlink_ext_ack *extack)
+{
+	struct pse_power_domain *pw_d = pcdev->pi[id].pw_d;
+	int ret, _prio;
+
+	if (!pw_d)
+		return 0;
+
+	_prio = pcdev->nr_lines;
+	while (pw_req > pw_d->pw_budget && _prio > pcdev->pi[id].prio) {
+		ret = pse_disable_pis_prio(pcdev, _prio--);
+		if (ret)
+			return ret;
+	}
+
+	if (pw_req > pw_d->pw_budget) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PI %d: not enough power budget available",
+				   id);
+		return -ERANGE;
+	}
+
+	pw_d->pw_budget -= pw_req;
+	pcdev->pi[id].pw_allocated = pw_req;
+	return 0;
+}
+
+static int pse_pi_enable_isr(struct pse_controller_dev *pcdev, int id,
+			     struct netlink_ext_ack *extack)
+{
+	const struct pse_controller_ops *ops = pcdev->ops;
+	int ret, pw_req;
+
+	if (!ops->pi_enable || !ops->pi_get_pw_req) {
+		NL_SET_ERR_MSG(extack, "PSE does not support enable control");
+		return -EOPNOTSUPP;
+	}
+
+	if (!pcdev->pi[id].admin_state_enabled ||
+	    pcdev->pi[id].pw_enabled)
+		return 0;
+
+	ret = ops->pi_get_pw_req(pcdev, id);
+	if (ret < 0)
+		return ret;
+
+	pw_req = ret;
+	ret = pse_allocate_pw_budget(pcdev, id, pw_req, extack);
+	if (ret)
+		return ret;
+
+	ret = ops->pi_enable(pcdev, id);
+	if (ret) {
+		pse_deallocate_pw_budget(pcdev, id);
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PI %d: enable error %d",
+				   id, ret);
+		return ret;
+	}
+
+	pcdev->pi[id].pw_enabled = 1;
+	return 0;
+}
+
+static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
+			      unsigned long notifs,
+			      struct netlink_ext_ack *extack)
+{
+	int ret = 0;
+
+	if (notifs & ETHTOOL_C33_PSE_EVENT_CONNECTED &&
+	    notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTED) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PI %d: error, connection and disconnection reported simultaneously",
+				   id);
+		return -EINVAL;
+	}
+
+	if (notifs & ETHTOOL_C33_PSE_EVENT_CONNECTED)
+		ret = pse_pi_enable_isr(pcdev, id, extack);
+	else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTED)
+		ret = pse_pi_disable_isr(pcdev, id, extack);
+
+	return ret;
+}
+
 static irqreturn_t pse_notifier_isr(int irq, void *data)
 {
 	struct netlink_ext_ack extack = {};
@@ -724,7 +897,6 @@ static irqreturn_t pse_notifier_isr(int irq, void *data)
 	memset(h->notifs, 0, pcdev->nr_lines * sizeof(*h->notifs));
 	mutex_lock(&pcdev->lock);
 	ret = desc->map_event(irq, pcdev, h->notifs, &notifs_mask);
-	mutex_unlock(&pcdev->lock);
 	if (ret || !notifs_mask)
 		return IRQ_NONE;
 
@@ -737,6 +909,12 @@ static irqreturn_t pse_notifier_isr(int irq, void *data)
 			continue;
 
 		notifs = h->notifs[i];
+		if (pcdev->port_prio_mode == ETHTOOL_PSE_PORT_PRIO_STATIC) {
+			ret = pse_set_config_isr(pcdev, i, notifs, &extack);
+			if (ret)
+				notifs |= ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR;
+		}
+
 		dev_dbg(h->pcdev->dev,
 			"Sending PSE notification EVT 0x%lx\n", notifs);
 
@@ -748,6 +926,8 @@ static irqreturn_t pse_notifier_isr(int irq, void *data)
 					      NULL);
 	}
 
+	mutex_unlock(&pcdev->lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -1001,6 +1181,20 @@ static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
 
 	status->pse_id = pcdev->id;
 	status->pw_d_id = pcdev->pi[id].pw_d->id;
+	status->c33_prio_supp_modes = pcdev->port_prio_supp_modes;
+	status->c33_prio_mode = pcdev->port_prio_mode;
+	switch (pcdev->port_prio_mode) {
+	case ETHTOOL_PSE_PORT_PRIO_STATIC:
+		status->c33_prio_max = pcdev->nr_lines;
+		status->c33_prio = pcdev->pi[id].prio;
+		break;
+	case ETHTOOL_PSE_PORT_PRIO_DYNAMIC:
+		status->c33_prio_max = pcdev->pis_prio_max;
+		break;
+	default:
+		break;
+	}
+
 	return ops->ethtool_get_status(pcdev, id, extack, status);
 }
 
@@ -1038,11 +1232,12 @@ static int pse_ethtool_c33_set_config(struct pse_control *psec,
 	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
 		/* We could have mismatch between admin_state_enabled and
 		 * state reported by regulator_is_enabled. This can occur when
-		 * the PI is forcibly turn off by the controller. Call
-		 * regulator_disable on that case to fix the counters state.
+		 * the PI is forcibly turn off by the controller or by the
+		 * interrupt context. Call regulator_disable on that case
+		 * to fix the counters state.
 		 */
-		if (psec->pcdev->pi[psec->id].admin_state_enabled &&
-		    !regulator_is_enabled(psec->ps)) {
+		if (!regulator_is_enabled(psec->ps) &&
+		    psec->pcdev->pi[psec->id].admin_state_enabled) {
 			err = regulator_disable(psec->ps);
 			if (err)
 				break;
@@ -1149,6 +1344,102 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
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
+	switch (pcdev->port_prio_mode) {
+	case ETHTOOL_PSE_PORT_PRIO_STATIC:
+		if (prio > pcdev->nr_lines) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "priority %d exceed priority max %d",
+					   prio, pcdev->nr_lines);
+			return -ERANGE;
+		}
+
+		/* We don't want priority change in the middle of an
+		 * enable/disable call
+		 */
+		mutex_lock(&pcdev->lock);
+		pcdev->pi[psec->id].prio = prio;
+		mutex_unlock(&pcdev->lock);
+		break;
+
+	case ETHTOOL_PSE_PORT_PRIO_DYNAMIC:
+		ops = psec->pcdev->ops;
+		if (!ops->pi_set_prio) {
+			NL_SET_ERR_MSG(extack,
+				       "pse driver does not support setting port priority");
+			return -EOPNOTSUPP;
+		}
+
+		if (prio > pcdev->pis_prio_max) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "priority %d exceed priority max %d",
+					   prio, pcdev->pis_prio_max);
+			return -ERANGE;
+		}
+
+		mutex_lock(&pcdev->lock);
+		ret = ops->pi_set_prio(pcdev, psec->id, prio);
+		mutex_unlock(&pcdev->lock);
+		break;
+
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_prio);
+
+int pse_ethtool_set_prio_mode(struct pse_control *psec,
+			      struct netlink_ext_ack *extack,
+			      enum pse_port_prio_modes prio_mode)
+{
+	struct pse_controller_dev *pcdev = psec->pcdev;
+	const struct pse_controller_ops *ops;
+	int ret = 0, i;
+
+	if (!(BIT(prio_mode) & pcdev->port_prio_supp_modes)) {
+		NL_SET_ERR_MSG(extack, "priority mode not supported");
+		return -EOPNOTSUPP;
+	}
+
+	ops = psec->pcdev->ops;
+
+	/* We don't want priority mode change in the middle of an
+	 * enable/disable call
+	 */
+	mutex_lock(&pcdev->lock);
+	pcdev->port_prio_mode = prio_mode;
+
+	/* Reset all priorities */
+	for (i = 0; i < psec->pcdev->nr_lines; i++) {
+		/* PI not described */
+		if (!pcdev->pi[i].rdev)
+			continue;
+
+		pcdev->pi[i].prio = 0;
+
+		if (!ops->pi_set_prio)
+			continue;
+
+		if (pcdev->port_prio_supp_modes &
+		    BIT(ETHTOOL_PSE_PORT_PRIO_DYNAMIC))
+			ret = ops->pi_set_prio(pcdev, psec->id, 0);
+	}
+
+	mutex_unlock(&psec->pcdev->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_prio_mode);
+
 bool pse_has_podl(struct pse_control *psec)
 {
 	return psec->pcdev->types & ETHTOOL_PSE_PODL;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index e275ef7e1eb0..653f9e3634bb 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -9,9 +9,12 @@
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
 #include <linux/regulator/driver.h>
+#include <linux/workqueue.h>
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
+/* Maximum power in mW according to IEEE 802.3-2022 Table 145-16 */
+#define MAX_PI_PW 99900
 
 struct phy_device;
 struct pse_controller_dev;
@@ -60,6 +63,12 @@ struct pse_control_config {
  *	is in charge of the memory allocation.
  * @c33_pw_limit_nb_ranges: number of supported power limit configuration
  *	ranges
+ * @c33_prio_supp_modes: PSE port priority modes supported. Set by PSE core.
+ * @c33_prio_mode: PSE port priority mode selected. Set by PSE core.
+ * @c33_prio_max: max priority allowed for the c33_prio variable value. Set
+ *	by PSE core.
+ * @c33_prio: priority of the PSE. Set by PSE core in case of static port
+ *	priority mode.
  */
 struct pse_control_status {
 	u32 pse_id;
@@ -74,6 +83,10 @@ struct pse_control_status {
 	u32 c33_avail_pw_limit;
 	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
 	u32 c33_pw_limit_nb_ranges;
+	u32 c33_prio_supp_modes;
+	enum pse_port_prio_modes c33_prio_mode;
+	u32 c33_prio_max;
+	u32 c33_prio;
 };
 
 /**
@@ -93,6 +106,8 @@ struct pse_control_status {
  *			  set_current_limit regulator callback.
  *			  Should not return an error in case of MAX_PI_CURRENT
  *			  current value set.
+ * @pi_set_prio: Configure the PSE PI priority.
+ * @pi_get_pw_req: Get the power requested by a PD before enabling the PSE PI
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -107,6 +122,9 @@ struct pse_controller_ops {
 				    int id);
 	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
 				    int id, int max_uA);
+	int (*pi_set_prio)(struct pse_controller_dev *pcdev, int id,
+			   unsigned int prio);
+	int (*pi_get_pw_req)(struct pse_controller_dev *pcdev, int id);
 };
 
 struct module;
@@ -141,6 +159,10 @@ struct pse_pi_pairset {
  * @rdev: regulator represented by the PSE PI
  * @admin_state_enabled: PI enabled state
  * @pw_d: Power domain of the PSE PI
+ * @prio: Priority of the PSE PI. Used in static port priority mode
+ * @pw_enabled: PSE PI power status in static port priority mode
+ * @pw_allocated: Power allocated to a PSE PI to manage power budget in
+ *	static port priority mode
  */
 struct pse_pi {
 	struct pse_pi_pairset pairset[2];
@@ -148,6 +170,9 @@ struct pse_pi {
 	struct regulator_dev *rdev;
 	bool admin_state_enabled;
 	struct pse_power_domain *pw_d;
+	int prio;
+	bool pw_enabled;
+	int pw_allocated;
 };
 
 /**
@@ -165,6 +190,9 @@ struct pse_pi {
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
  * @id: Index of the PSE
+ * @pis_prio_max: Maximum value allowed for the PSE PIs priority
+ * @port_prio_supp_modes: Bitfield of port priority mode supported by the PSE
+ * @port_prio_mode: Current port priority mode of the PSE
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -179,6 +207,9 @@ struct pse_controller_dev {
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
 	int id;
+	unsigned int pis_prio_max;
+	u32 port_prio_supp_modes;
+	enum pse_port_prio_modes port_prio_mode;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -203,6 +234,12 @@ int pse_ethtool_set_config(struct pse_control *psec,
 int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     struct netlink_ext_ack *extack,
 			     const unsigned int pw_limit);
+int pse_ethtool_set_prio(struct pse_control *psec,
+			 struct netlink_ext_ack *extack,
+			 unsigned int prio);
+int pse_ethtool_set_prio_mode(struct pse_control *psec,
+			      struct netlink_ext_ack *extack,
+			      enum pse_port_prio_modes prio_mode);
 
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
@@ -240,6 +277,20 @@ static inline int pse_ethtool_set_pw_limit(struct pse_control *psec,
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
+					    enum pse_port_prio_modes prio_mode)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool pse_has_podl(struct pse_control *psec)
 {
 	return false;
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index a1ad257b1ec1..22664b1ea4a2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1002,11 +1002,35 @@ enum ethtool_c33_pse_pw_d_status {
  * enum ethtool_c33_pse_events - event list of the C33 PSE controller.
  * @ETHTOOL_C33_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
  * @ETHTOOL_C33_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
+ * @ETHTOOL_C33_PSE_EVENT_CONNECTED: PD detected on the PSE.
+ * @ETHTOOL_C33_PSE_EVENT_DISCONNECTED: PD has been disconnected on the PSE.
+ * @ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR: PSE faced an error in static
+ *	port priority management mode.
  */
 
 enum ethtool_c33_pse_events {
-	ETHTOOL_C33_PSE_EVENT_OVER_CURRENT =	1 << 0,
-	ETHTOOL_C33_PSE_EVENT_OVER_TEMP =	1 << 1,
+	ETHTOOL_C33_PSE_EVENT_OVER_CURRENT =		1 << 0,
+	ETHTOOL_C33_PSE_EVENT_OVER_TEMP =		1 << 1,
+	ETHTOOL_C33_PSE_EVENT_CONNECTED =		1 << 2,
+	ETHTOOL_C33_PSE_EVENT_DISCONNECTED =		1 << 3,
+	ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR =	1 << 4,
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
+	ETHTOOL_PSE_PORT_PRIO_DISABLED,
+	ETHTOOL_PSE_PORT_PRIO_STATIC,
+	ETHTOOL_PSE_PORT_PRIO_DYNAMIC,
 };
 
 /**

-- 
2.34.1


