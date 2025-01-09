Return-Path: <netdev+bounces-156630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FAEA072CD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041F116858A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82921859B;
	Thu,  9 Jan 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ggpPHyFF"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CBE217642;
	Thu,  9 Jan 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417941; cv=none; b=Lu/W8zDzVJtvmBu5F/GvTHYbzxZJBK8S9/KTuoxwFJu+BJ1BFgQe37YAL+O4lE8zYUsE5zFQoih66ypRtjPx35yqL5+eA0b9UOS2EvXyVerHRCWxOxZiYSc1yOjtZqNvC/YlZSQnkgPITTJU8ex0fpO0WOBT1I79SH3HiMI5Yso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417941; c=relaxed/simple;
	bh=3dWlq1ZAVAiFwlpy8bLnXVcPXqypL0R7+UQQHGXEeyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LngH7sbOHyWbAXHF7V2dgHr0h4yQvT+8BsCIWqGwfMReGH53tbLt/AC7IwfC/cE/qh1KNRbE5tmp/WMXVddjtM0rsbTJ8I62cd62itZRDPLORlBfhubam7Oc3VIiVQr/V3BGtSXrJF6jWUaGud44OrxwDpBgw9drz6QtZtb4VTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ggpPHyFF; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03B9CE0017;
	Thu,  9 Jan 2025 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4b5eVqR0SUJiXGJ61wXTk+/0+l0upccx9aKNkjupd1s=;
	b=ggpPHyFFSkNfG6rh+iQfC1fTn++a2Cu4nbjYPRSWKorgPA7+/9IbRwV/NwTFMIGC+ZFBtY
	3K9w9sWzAWDoyKDZw+mPanujvAw4Ybs3M7EEbIAstW5xSo+C/Cw9kLcmVTloo4JIwB+n/T
	IwNiuTR2sRZX6hIZ5iFiQ4XI6X92sCxRsndKWb8lkrHpxwIvwPfTAHhXD9ELZ3DjseVCLW
	U+y8N+aX9GnU1rxCusNFZldHAb8nPflmK+VKsumK0W6zlqJeOvutA5ru+R6B7rcMR6OnbF
	xLx/f7CbvVUoDtbqtJu+asi9XYw56KOkbSZbZ7CbWhLmq7JKiqc7txkLr9dFxQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:18:05 +0100
Subject: [PATCH net-next v2 11/15] net: pse-pd: Add support for PSE device
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
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
 include/linux/pse-pd/pse.h    |  4 ++++
 2 files changed, 23 insertions(+), 5 deletions(-)

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
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index b5ae3dcee550..be877dea6a11 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -78,6 +78,7 @@ struct pse_pw_limit_ranges {
 /**
  * struct ethtool_pse_control_status - PSE control/channel status.
  *
+ * @pse_id: index number of the PSE.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -99,6 +100,7 @@ struct pse_pw_limit_ranges {
  *	ranges
  */
 struct ethtool_pse_control_status {
+	u32 pse_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
@@ -208,6 +210,7 @@ struct pse_pi {
  * @types: types of the PSE controller
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
+ * @id: Index of the PSE
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -221,6 +224,7 @@ struct pse_controller_dev {
 	enum ethtool_pse_types types;
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
+	u32 id;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)

-- 
2.34.1


