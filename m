Return-Path: <netdev+bounces-131307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563F98E0B2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792701C23CFD
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41211D1E6B;
	Wed,  2 Oct 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fl2CXcTH"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391831D12EA;
	Wed,  2 Oct 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886553; cv=none; b=mPJS4/lHwIU6gDlBw1f+nJ8UKTR9jv/ZZ2CHAjtaKWr59+L/COa8/5fB7PpCQy1MVJMnGiVIXaUDvHnDANtdbO7MU7ySEBAZ/V69AotRtnhi7xTHoA/ii/OiwDI1Tp0rFMM/dkNMkRn5hyq/H0hjxuNDDaFeRloSkeYofFotTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886553; c=relaxed/simple;
	bh=IAn/aP5J4OooV+vXF/TyTGRcput+ez4+P0gxjzAXSdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pb7O68TEA+pcFQde+fnbl9J2W7Tl8+TdnlafCE22cwkkLEKbA2UAM6Lby+29pMN0kIHjN/yjWJCTO36exB/dHJQtZe9Y1faDx/G07o966RDbPc6vxag8gjleBtEWiF1tk4Z53r5OUIN7QASWXMUQn/bWOaf1/P1BagNMHMjLQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fl2CXcTH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE0A51BF203;
	Wed,  2 Oct 2024 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEgsL4qeKQAHgpYyJ07KFlg6HXoQP/UEP7QR/h3wag0=;
	b=Fl2CXcTHjs8H70SAMoeABIT75NYboULvJwO9UBrKxg9c1QPlYHk1NsmHAtNUwYCe/A8aUI
	PUieBvY6jebOkxPWxihm17IlrAoUNpjuhAK2Ie/toGJjUpSm81DTNG1+R3UtUjrPqHuqOi
	rSdU+vmKVfc8G9A4IlsoUXt3xhCKeAfRqqO5BBqa4qDplbs8mleLPwcqN7Y01qVk4xEniW
	EU/xISAsfCJ4U59SHvzcNogDPzjN4i0R3aBY7ZgecLAaftpUNVRAz+NULCPOOsvjvHMEyl
	ti3pVEHgWjTn+qJpEHJW4H1oJx5ZNH7mKJ/bO3chXAb1jdYivGwgr305Y9JDzQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:28:01 +0200
Subject: [PATCH net-next 05/12] net: pse-pd: Add support for getting and
 setting port priority
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-5-787054f74ed5@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h    | 19 +++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index f8e6854781e6..6b3893a3381c 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -750,6 +750,7 @@ static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
 		return -EOPNOTSUPP;
 	}
 
+	status->c33_prio_max = pcdev->pis_prio_max;
 	return ops->ethtool_get_status(pcdev, id, extack, status);
 }
 
@@ -898,6 +899,35 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_pw_limit);
 
+int pse_ethtool_set_prio(struct pse_control *psec,
+			 struct netlink_ext_ack *extack,
+			 unsigned int prio)
+{
+	const struct pse_controller_ops *ops;
+	int ret;
+
+	ops = psec->pcdev->ops;
+	if (!ops->pi_set_prio) {
+		NL_SET_ERR_MSG(extack,
+			       "pse driver does not support port priority");
+		return -EOPNOTSUPP;
+	}
+
+	if (prio > psec->pcdev->pis_prio_max) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "priority %d exceed priority max %d",
+				   prio, psec->pcdev->pis_prio_max);
+		return -ERANGE;
+	}
+
+	mutex_lock(&psec->pcdev->lock);
+	ret = ops->pi_set_prio(psec->pcdev, psec->id, prio);
+	mutex_unlock(&psec->pcdev->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_prio);
+
 bool pse_has_podl(struct pse_control *psec)
 {
 	return psec->pcdev->types & ETHTOOL_PSE_PODL;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 85a08c349256..b60fc56923bd 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -50,6 +50,8 @@ struct pse_control_config {
  *	is in charge of the memory allocation.
  * @c33_pw_limit_nb_ranges: number of supported power limit configuration
  *	ranges
+ * @c33_prio_max: max priority allowed for the c33_prio variable value
+ * @c33_prio: priority of the PSE
  */
 struct pse_control_status {
 	enum ethtool_podl_pse_admin_state podl_admin_state;
@@ -62,6 +64,8 @@ struct pse_control_status {
 	u32 c33_avail_pw_limit;
 	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
 	u32 c33_pw_limit_nb_ranges;
+	u32 c33_prio_max;
+	u32 c33_prio;
 };
 
 /**
@@ -81,6 +85,7 @@ struct pse_control_status {
  *			  set_current_limit regulator callback.
  *			  Should not return an error in case of MAX_PI_CURRENT
  *			  current value set.
+ * @pi_set_prio: Configure the PSE PI priority
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -95,6 +100,8 @@ struct pse_controller_ops {
 				    int id);
 	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
 				    int id, int max_uA);
+	int (*pi_set_prio)(struct pse_controller_dev *pcdev, int id,
+			   unsigned int prio);
 };
 
 struct module;
@@ -150,6 +157,7 @@ struct pse_pi {
  * @types: types of the PSE controller
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
+ * @pis_prio_max: Maximum value allowed for the PSE PIs priority
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -163,6 +171,7 @@ struct pse_controller_dev {
 	enum ethtool_pse_types types;
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
+	unsigned int pis_prio_max;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -184,6 +193,9 @@ int pse_ethtool_set_config(struct pse_control *psec,
 int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     struct netlink_ext_ack *extack,
 			     const unsigned int pw_limit);
+int pse_ethtool_set_prio(struct pse_control *psec,
+			 struct netlink_ext_ack *extack,
+			 unsigned int prio);
 
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
@@ -220,6 +232,13 @@ static inline int pse_ethtool_set_pw_limit(struct pse_control *psec,
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

-- 
2.34.1


