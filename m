Return-Path: <netdev+bounces-48350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C767EE221
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC121C20C0C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996693172A;
	Thu, 16 Nov 2023 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uk7yCNlr"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9A130;
	Thu, 16 Nov 2023 06:01:59 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3758020005;
	Thu, 16 Nov 2023 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700143318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB+GGbS/hOUMve+DoI9/NdA/F1GZ6dfXdqXYjtsj/c4=;
	b=Uk7yCNlrUalzKwDM9t7v3RP/8lTgkdaiiNkcfy10Aa1dkWWPM+tQ7wFl9Ond9F8c4TF7pw
	dkmVzujlkYhDI3XZs7istgviz4SeEAtZt9XsUnUt9wKK/MqDW7oZbjSWVhHmNKRS7vHot+
	s3cMz6bcUlkGZj9Q6EEuYo1bZzXjwTBLZ2ROHJ1gxPTKCU4opVvvOa/N8HI7qMBFHJJbgF
	5iJaRzs2ONvcBL0nZ/UBEH4JPZYwqSkUhzJR+SWnZzmt2M7crEsyy4PDtXZ7LCNHyygvG+
	DvNW3vtBsLLzK7omWHGLrSCpJWRd7wHu91vzXgQrG/JCM9lNjQxIh7OIJkI/XA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 16 Nov 2023 15:01:35 +0100
Subject: [PATCH net-next 3/9] net: pse-pd: Introduce PSE types enumeration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-feature_poe-v1-3-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Introduce an enumeration to define PSE types (PoE or PoDL),
utilizing a bitfield for potential future support of both types.
Include 'pse_get_types' helper for external access to PSE type info

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c      |  9 +++++++++
 drivers/net/pse-pd/pse_regulator.c |  1 +
 include/linux/pse-pd/pse.h         | 22 ++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 146b81f08a89..2959c94f7798 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -312,3 +312,12 @@ int pse_ethtool_set_config(struct pse_control *psec,
 	return err;
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
+
+u32 pse_get_types(struct pse_control *psec)
+{
+	if (!psec->pcdev)
+		return PSE_UNKNOWN;
+	else
+		return psec->pcdev->types;
+}
+EXPORT_SYMBOL_GPL(pse_get_types);
diff --git a/drivers/net/pse-pd/pse_regulator.c b/drivers/net/pse-pd/pse_regulator.c
index 1dedf4de296e..e34ab8526067 100644
--- a/drivers/net/pse-pd/pse_regulator.c
+++ b/drivers/net/pse-pd/pse_regulator.c
@@ -116,6 +116,7 @@ pse_reg_probe(struct platform_device *pdev)
 	priv->pcdev.owner = THIS_MODULE;
 	priv->pcdev.ops = &pse_reg_ops;
 	priv->pcdev.dev = dev;
+	priv->pcdev.types = PSE_PODL;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret) {
 		dev_err(dev, "failed to register PSE controller (%pe)\n",
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 25490d0c682d..67a0ff5e480c 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -44,6 +44,19 @@ struct pse_control_status {
 	enum ethtool_pse_pw_d_status pw_status;
 };
 
+/**
+ * enum - Types of PSE controller.
+ *
+ * @PSE_UNKNOWN: Type of PSE controller is unknown
+ * @PSE_PODL: PSE controller which support PoDL
+ * @PSE_POE: PSE controller which support PoE
+ */
+enum {
+	PSE_UNKNOWN = BIT(0),
+	PSE_PODL = BIT(1),
+	PSE_POE = BIT(2),
+};
+
 /**
  * struct pse_controller_ops - PSE controller driver callbacks
  *
@@ -77,6 +90,7 @@ struct pse_control;
  *            device tree to id as given to the PSE control ops
  * @nr_lines: number of PSE controls in this controller device
  * @lock: Mutex for serialization access to the PSE controller
+ * @types: types of the PSE controller
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -89,6 +103,7 @@ struct pse_controller_dev {
 			const struct of_phandle_args *pse_spec);
 	unsigned int nr_lines;
 	struct mutex lock;
+	u32 types;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -108,6 +123,8 @@ int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   const struct pse_control_config *config);
 
+u32 pse_get_types(struct pse_control *psec);
+
 #else
 
 static inline struct pse_control *of_pse_control_get(struct device_node *node)
@@ -133,6 +150,11 @@ static inline int pse_ethtool_set_config(struct pse_control *psec,
 	return -ENOTSUPP;
 }
 
+static u32 pse_get_types(struct pse_control *psec)
+{
+	return PSE_UNKNOWN;
+}
+
 #endif
 
 #endif

-- 
2.25.1


