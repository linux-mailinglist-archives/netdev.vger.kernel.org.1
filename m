Return-Path: <netdev+bounces-146661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099DF9D4EEE
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F3CB26C7C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743CC1DEFE8;
	Thu, 21 Nov 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FGpYhcEC"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F46F1DED6E;
	Thu, 21 Nov 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200234; cv=none; b=YNCG5SluG8T4S02Baw7nW+ziuNrLi0Mmn0znl1/gkZMXvQcmJO9MK6Hl0Y8O+21s+j8jAcmUtwNEGOk18JjcJy9dQphoqxBTj8afVNcsGQuDcN/NfmYeLvdF8oLpFelA2fhT6vRjbwHdOVZm8WDeFXIsILp3dluszC1cNMK7mbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200234; c=relaxed/simple;
	bh=r2LVXcXz9BO9jX+SECBfo4p/PJGFk8PifuoZoGDFf6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osJXkIDGvef5fgvZFQXf88teqYFJUUOODW1KvCIjkEX10Lj7jrP71umS0fBZFxygXp5y9odcJwbq+HOc7Y2DOtyFJuwaeNOLImMfKH0AGQuO0lDOS1IKTDb3dsMZFWpNcXmZoPqMnRlVILmsHPWlnY3EDsHiNRP/5D8kiNHE2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FGpYhcEC; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D79BB40008;
	Thu, 21 Nov 2024 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mToZpR+IImksBdjIBc4se6t1/bKD5M6yV62a708rgs=;
	b=FGpYhcECvMZcC5GkEI5iC3x5GHTyj3FiwOloBeqXspbDY/09uUwiJ75WFQKxrAdDroi3XT
	eCEw+dqWVz9EJPqamyDx2iZeOSzPUr7i+8i8NY1Rup85HUlvjA29iHoOjUfSZuqDqb9jGO
	7ezjU6Y0BTHj/QIELdUMhJizTfUWEvJ7BPM9uJq5FSZfw13cruErcX0MZZvDRAj1q4fVys
	YZJP9PHMyxLUYJh965hb54Rme+gYYkklpqwgm/ACA0FcD4mhxypgDxKwT/0HW7GCJb4kuL
	gzJTQWgBrsC6XmnHaL+H10YCQI2SuEUqDuMQvZz8EkpcoBSEdWLXRNaQZEdIEw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:35 +0100
Subject: [PATCH RFC net-next v3 09/27] net: pse-pd: Add support for PSE
 device index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-9-83299fa6967c@bootlin.com>
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

Add support for a PSE device index to report the PSE controller index to
the user through ethtool. This will be useful for future support of power
domains and port priority management.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Use u32 for all variables.

Changes in v2:
- new patch.
---
 drivers/net/pse-pd/pse_core.c | 23 ++++++++++++++++++-----
 include/linux/pse-pd/pse.h    |  4 ++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 432b6c2c04f8..411868bccbcc 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -13,6 +13,7 @@
 
 static DEFINE_MUTEX(pse_list_mutex);
 static LIST_HEAD(pse_controller_list);
+static DEFINE_IDA(pse_ida);
 
 /**
  * struct pse_control - a PSE control
@@ -441,18 +442,22 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 
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
@@ -469,15 +474,17 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
@@ -485,6 +492,10 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	mutex_unlock(&pse_list_mutex);
 
 	return 0;
+
+free_pse_ida:
+	ida_free(&pse_ida, pcdev->id);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
 
@@ -495,6 +506,7 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
 	pse_release_pis(pcdev);
+	ida_free(&pse_ida, pcdev->id);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
@@ -751,6 +763,7 @@ static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
 		return -EOPNOTSUPP;
 	}
 
+	status->pse_id = pcdev->id;
 	return ops->ethtool_get_status(pcdev, id, extack, status);
 }
 
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index bc5addccbf32..f2294a1d9b58 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -33,6 +33,7 @@ struct pse_control_config {
 /**
  * struct pse_control_status - PSE control/channel status.
  *
+ * @pse_id: index number of the PSE. Set by PSE core.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -54,6 +55,7 @@ struct pse_control_config {
  *	ranges
  */
 struct pse_control_status {
+	u32 pse_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
@@ -152,6 +154,7 @@ struct pse_pi {
  * @types: types of the PSE controller
  * @pi: table of PSE PIs described in this controller device
  * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
+ * @id: Index of the PSE
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -165,6 +168,7 @@ struct pse_controller_dev {
 	enum ethtool_pse_types types;
 	struct pse_pi *pi;
 	bool no_of_pse_pi;
+	u32 id;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)

-- 
2.34.1


