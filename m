Return-Path: <netdev+bounces-155212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6BA0173D
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C1E188485F
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05051D5CE3;
	Sat,  4 Jan 2025 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z8cSv2wM"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417151D95B3;
	Sat,  4 Jan 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029741; cv=none; b=tY5IrjqmE2v+6eXwdX1pQyeWgvO8So1qu9ntES0FgRCtjzAeebIoRI+fC2W6sRo2DjydNR+BS59syD8KA/+mMrYtZt+CE8hihsarzxdui6g/xBpAnU2q38MF9PJKk7EVWbBAgV4/w35Ov9kLaBbNS3O3EOiC1mxTMV4gyxAhvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029741; c=relaxed/simple;
	bh=9/9TxWrBLurwJDnmLnQWaPvSuP+h1zjH2o2k8xJUDqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TXjsDooCq8YKqQxHxtgAwW4DLrMFr0UI+wwa1tKofK6PVZYkwSfW4pzPReuff7NfiGadpcGfsg3x3W4OCeRWLH1TawQFHAVveqip9o5/iTymhjQzJol0t88x1gikyjAuXEBYAWmLgRpOWjA8UjWCpC4oiukBsgT8rGBQ0lyTISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z8cSv2wM; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8D7C40002;
	Sat,  4 Jan 2025 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736029737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5wJYXjrCWVs718YfxRm4fTgq42UkWxWVFw7JLZPMyU=;
	b=Z8cSv2wM9RWhh4LVcPy7rlwekYe84Ud8WUL7gXDAsESV0MfXmbX1jFI8EV4hAmTfPGjpOh
	5lQye6Otklq0WX47HnwOW+F10v5wCmrlXoH6yYAcbggIoji86h3dsbX7TW4qbMzuRa1w+X
	KVwxVL829K8s+x0lPLe5gdHA5UfoxgOJdMWyDcE0ZLswnbbBeN4w2phWXeFyr2nLEz0eaJ
	OyuK2YDMywWVkjRY0U+Z6+v1EgruSs4yPru8abAQiUx7eFuf+bTEOz37IHKmJ2FuULn1q3
	f4PJF0qN0bsfuxZBeGHK9/q7lsJJienPwaUQPuX1ixLCmFFIiOUFy/Fn3GVsWw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 04 Jan 2025 23:27:36 +0100
Subject: [PATCH net-next 11/14] net: pse-pd: Add support for PSE device
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-b4-feature_poe_arrange-v1-11-92f804bd74ed@bootlin.com>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
In-Reply-To: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
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

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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


