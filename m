Return-Path: <netdev+bounces-52999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9668010D0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24243281C32
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67FA4E606;
	Fri,  1 Dec 2023 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="batvedLs"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C0512A;
	Fri,  1 Dec 2023 09:11:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D09224000E;
	Fri,  1 Dec 2023 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701450699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ur2t+3CZiMiWT1hOhnWzj0bjmB7HlBaMOY5SSeNEDOo=;
	b=batvedLsMF+5fFUDJk5QtEjk/H8hKHD/llMaQBCVFZhull78N3CCJprss0L8pDO1cqAKi1
	4DutMhREiyzj6QIZSNiM6+3JGp702YL9mccLtkS/4ElKXpilRgyovFSC/2RG5JC1OUmjHs
	EU3RglutAdeqN4VR7Ydon7bo3j2g8lnz/N0GaJ4Us06A/dW63Wh4RMol3R3H5ieG1tsN2V
	n6qPRNi/zKGynERo0aoC+UlLdmQlHQXJMZaV4BE64coFUdwqBcckbhpyVaJnv/QdyoM/0w
	9zjw30JplhtyaDLbpiD0zcSoL6rrpZybuvj/NQmWlNTScOeCDZwE2yPPbsBvyA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 01 Dec 2023 18:10:25 +0100
Subject: [PATCH net-next v2 3/8] net: pse-pd: Introduce PSE types
 enumeration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-feature_poe-v2-3-56d8cac607fa@bootlin.com>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
In-Reply-To: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Introduce an enumeration to define PSE types (C33 or PoDL),
utilizing a bitfield for potential future support of both types.
Include 'pse_get_types' helper for external access to PSE type info.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Rename PSE_POE to PSE_C33 to have naming consistency.
- Use "static inline" instead of simple static in the header
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
index be4e5754eb24..4a0ae3097bb2 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -44,6 +44,19 @@ struct pse_control_status {
 	enum ethtool_c33_pse_pw_d_status c33_pw_status;
 };
 
+/**
+ * enum - Types of PSE controller.
+ *
+ * @PSE_UNKNOWN: Type of PSE controller is unknown
+ * @PSE_PODL: PSE controller which support PoDL
+ * @PSE_C33: PSE controller which support Clause 33 (PoE)
+ */
+enum {
+	PSE_UNKNOWN = BIT(0),
+	PSE_PODL = BIT(1),
+	PSE_C33 = BIT(2),
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
 
+static inline u32 pse_get_types(struct pse_control *psec)
+{
+	return PSE_UNKNOWN;
+}
+
 #endif
 
 #endif

-- 
2.25.1


