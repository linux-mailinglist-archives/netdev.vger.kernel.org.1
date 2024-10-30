Return-Path: <netdev+bounces-140473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3D79B69C1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C431F21F7D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBF2219C9A;
	Wed, 30 Oct 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DuX0bbHu"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9E21730F;
	Wed, 30 Oct 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307243; cv=none; b=YAdlrQiNRasqIoFz7aT9B7E+RBmmvMEta8Q7azQiR2g0AiQ7TcomFoiHwJcKvPkNvIpT19r+sZikn+NP1dArzJtUSoedONRW1HKXo3iXxMAuWxoCdqdk4ngc2dRB53oe9Z/z6BiDSH9fQyDT+V31MnnKJqbQeY5JaDRc5kYpgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307243; c=relaxed/simple;
	bh=q5izcH4GpPOOp7VwkYN2iMySiL7aaVw28MVRNSSIr7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6qk+cB0RzGOOwC12wh+pU7Borgp4yEbWC96LG+CMwd6pX7o3S699E1uAV+sMAannJA+zbiksiNh1ZTPHSVXbtEpJsio+QwZ/H2eqjv8hcZvmQul8ZKEPAwVJs+0w1sUgw8vHY5bQ5vqlGoX0LeFx7fb3GZaFpsTUrlP+WNZKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DuX0bbHu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9226C0003;
	Wed, 30 Oct 2024 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0scBcKP4vZWA4og7cEvQ3Oi93wItzNm6GwrVtx1oDQ=;
	b=DuX0bbHuNeSDAbB8rjAN/+OVVjHfVlg21ViNhLGTlwnG1T/7lEfc8RDvdjcZ83LonIcNMt
	QXGMWBboNvKBSYTXUdQ+s2PbubTEfxhyvq1jUEahrPM/gf11uXLG6/7Rga0Hdg3w5FNHBl
	p9ZWOB2C0F3uDtAjjCD/5WMnLAvb8xx/HtGleQ6hZADQUVn8ymjgCX5qhzG+PBsWFFswqj
	Bu6c41L45qaJhGh1laOnmeRt4LCy0FDFCKZ7D7BpOo4tI7fQuM67q8n862quJW2d6tK31R
	+Ha5r6dzXcrtqPuc/NaSuYPWue0tS3qBKR05uTJzTaNd+h9pifVIMKj3vunmJw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:07 +0100
Subject: [PATCH RFC net-next v2 05/18] net: pse-pd: Add support for PSE
 device index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_poe_port_prio-v2-5-9559622ee47a@bootlin.com>
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

Add support for a PSE device index to report the PSE controller index to
the user through ethtool. This will be useful for future support of power
domains and port priority management.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

changes in v2:
- new patch.
---
 drivers/net/pse-pd/pse_core.c | 23 ++++++++++++++++++-----
 include/linux/pse-pd/pse.h    |  4 ++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 2906ce173f66..68297428f6b5 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -13,6 +13,7 @@
 
 static DEFINE_MUTEX(pse_list_mutex);
 static LIST_HEAD(pse_controller_list);
+static DEFINE_IDA(pse_ida);
 
 /**
  * struct pse_control - a PSE control
@@ -440,18 +441,22 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
+	ret = ida_alloc_max(&pse_ida, INT_MAX, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	pcdev->id = ret;
 
 	if (!pcdev->nr_lines)
 		pcdev->nr_lines = 1;
 
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
@@ -468,15 +473,17 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
@@ -484,6 +491,10 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	mutex_unlock(&pse_list_mutex);
 
 	return 0;
+
+free_pse_ida:
+	ida_free(&pse_ida, pcdev->id);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
 
@@ -494,6 +505,7 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
 	pse_release_pis(pcdev);
+	ida_free(&pse_ida, pcdev->id);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
@@ -750,6 +762,7 @@ static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
 		return -EOPNOTSUPP;
 	}
 
+	status->pse_id = pcdev->id;
 	return ops->ethtool_get_status(pcdev, id, extack, status);
 }
 
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 85a08c349256..5312488cb3cf 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -31,6 +31,7 @@ struct pse_control_config {
 /**
  * struct pse_control_status - PSE control/channel status.
  *
+ * @pse_id: index number of the PSE. Set by PSE core.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -52,6 +53,7 @@ struct pse_control_config {
  *	ranges
  */
 struct pse_control_status {
+	u32 pse_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
@@ -150,6 +152,7 @@ struct pse_pi {
  * @types: types of the PSE controller
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
+ * @id: Index of the PSE
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -163,6 +166,7 @@ struct pse_controller_dev {
 	enum ethtool_pse_types types;
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
+	int id;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)

-- 
2.34.1


