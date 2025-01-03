Return-Path: <netdev+bounces-155079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 752B1A00F66
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A162188348D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0421FA262;
	Fri,  3 Jan 2025 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ut57PD0A"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E371CEE93;
	Fri,  3 Jan 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938846; cv=none; b=d+I2H7CKJDuUgL12JFuQBvbQ7wt3wL3llXMq7da0PJDKFICvEJfqzHdTEuNb5wieWrzWMikfhjQaf1E/QuMGeTQnGLZWnJTCEmo/Ev87FHvyYU4BqlsLS43JxMrdiUB6j2JgJz61SH22TXe+GtUeXJWU40OfTZyAwuqBVSt6M5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938846; c=relaxed/simple;
	bh=pyx3ITPlmGXw/W3sYnBM8cwDcc3Py4Wk3Of+Oi63s0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKFiVAkInMCKaQuKNUreQoHMgnzEZwsASSn1aqc30SKdyRPmz0Ddys+lTpM54mo7yMwcpyFOD56F5Lc+YDCQwsJCcrfPEt4tFOjtorOdgh5CQnEv1k/l5jwR8HFMb1v9hlXpiGhl6p9A4a7vBF4liGn68ixdq0KqAeSiQdTiMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ut57PD0A; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C385FF804;
	Fri,  3 Jan 2025 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBLTQco78xGUPuwuDi7PAAZH/+o3f0fFG8ip6t+bH+U=;
	b=Ut57PD0AqZxXUqYOs6JnBWdrma1wJFXxUmqwdvLt+8wxaLiLitxcLRuK+0VsR0kGReUNoB
	aI/qhedz4DiIWMV+sByrSfHKQ2mfrH7fj51pocxr7EUpc/z7lhAesvrrR8BeT6Te33rIS0
	cEyOIh5MyvoG5aHn9JyRIVpBDWtJBh3StvgDYX58HeTd9YgwtPgwCEO4TFlbtCStlcPdLd
	xkdBneC7V56c6NDZNcCfiXS8l4a61iAxCo2g7RdjA8gMwFTDRWmgDNwg6hQU8ohUVk8V+t
	zS2qoX/Eq9ovYsUhFex9GpWXNiVrdcN3jtUbvO90KxaomHtE3xkwDHwy+dt1/g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:13:00 +0100
Subject: [PATCH net-next v4 11/27] net: pse-pd: Add support for PSE device
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-11-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for a PSE device index to report the PSE controller index to
the user through ethtool. This will be useful for future support of power
domains and port priority management.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Use u32 for all variables.

Changes in v2:
- new patch.
---
 drivers/net/pse-pd/pse_core.c | 24 +++++++++++++++++++-----
 include/linux/ethtool.h       |  2 ++
 include/linux/pse-pd/pse.h    |  2 ++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 887a477197a6..830e8d567d4d 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -13,6 +13,7 @@
 
 static DEFINE_MUTEX(pse_list_mutex);
 static LIST_HEAD(pse_controller_list);
+static DEFINE_IDA(pse_ida);
 
 /**
  * struct pse_control - a PSE control
@@ -448,6 +449,10 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
+	ret = ida_alloc_max(&pse_ida, INT_MAX, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	pcdev->id = ret;
 
 	if (!pcdev->nr_lines)
 		pcdev->nr_lines = 1;
@@ -461,12 +466,12 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 
 	ret = of_load_pse_pis(pcdev);
 	if (ret)
-		return ret;
+		goto free_pse_ida;
 
 	if (pcdev->ops->setup_pi_matrix) {
 		ret = pcdev->ops->setup_pi_matrix(pcdev);
 		if (ret)
-			return ret;
+			goto free_pse_ida;
 	}
 
 	/* Each regulator name len is pcdev dev name + 7 char +
@@ -483,15 +488,17 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 			continue;
 
 		reg_name = devm_kzalloc(pcdev->dev, reg_name_len, GFP_KERNEL);
-		if (!reg_name)
-			return -ENOMEM;
+		if (!reg_name) {
+			ret = -ENOMEM;
+			goto free_pse_ida;
+		}
 
 		snprintf(reg_name, reg_name_len, "pse-%s_pi%d",
 			 dev_name(pcdev->dev), i);
 
 		ret = devm_pse_pi_regulator_register(pcdev, reg_name, i);
 		if (ret)
-			return ret;
+			goto free_pse_ida;
 	}
 
 	mutex_lock(&pse_list_mutex);
@@ -499,6 +506,10 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	mutex_unlock(&pse_list_mutex);
 
 	return 0;
+
+free_pse_ida:
+	ida_free(&pse_ida, pcdev->id);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
 
@@ -509,6 +520,7 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
 	pse_release_pis(pcdev);
+	ida_free(&pse_ida, pcdev->id);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
@@ -771,6 +783,8 @@ int pse_ethtool_get_status(struct pse_control *psec,
 
 	pcdev = psec->pcdev;
 	ops = pcdev->ops;
+	status->pse_id = pcdev->id;
+
 	mutex_lock(&pcdev->lock);
 	ret = ops->pi_get_admin_state(pcdev, psec->id, &admin_state);
 	if (ret)
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 2bdf7e72ee50..d5d13a3d4447 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1327,6 +1327,7 @@ struct ethtool_c33_pse_pw_limit_range {
 /**
  * struct ethtool_pse_control_status - PSE control/channel status.
  *
+ * @pse_id: index number of the PSE.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -1348,6 +1349,7 @@ struct ethtool_c33_pse_pw_limit_range {
  *	ranges
  */
 struct ethtool_pse_control_status {
+	u32 pse_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 09e62d8c3271..8780a4160d3c 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -172,6 +172,7 @@ struct pse_pi {
  * @types: types of the PSE controller
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
+ * @id: Index of the PSE
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -185,6 +186,7 @@ struct pse_controller_dev {
 	enum ethtool_pse_types types;
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
+	u32 id;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)

-- 
2.34.1


