Return-Path: <netdev+bounces-131294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A195398E06A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D150288E77
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945C1D1F76;
	Wed,  2 Oct 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aUxJwbg+"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8E61D14EB;
	Wed,  2 Oct 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885695; cv=none; b=WUHCljjJrBYB7GlnjgFVkR+VVY9tk52AkOGnWnoBfAHYG2eDSPFrXalKUk+pcpYl/G3ZcxYQm4zaM+nqygit9lLk5lDfUbCYhNle3T9ABaaCmZbNJ6kSb2He0WOhcvMphGUHxe9zG7EbVbPBGasrScTMCAEUYK/RcqzTCMnPb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885695; c=relaxed/simple;
	bh=TmppxM30hDT5N6ZYZ9A5WGjGkeUb4dF0hUftJdet5Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1L+cgYt6KXTtIgD9nfv2sSuJKj50aZ1WOiJ5NMG17TGxry/PwPsjHx4Fp72gNO9NjJC59Z6chK6DKlqCCLfHbJsAMurnJ7gBc/GDlvgISy2fSvhpntXrCHLsWqyDHxCjQWh8HT1C76948kcVUF3GeUb8u11gJ+WN6+yaKIad5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aUxJwbg+; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47921FF807;
	Wed,  2 Oct 2024 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwYTIxMfa1jPmwx2OgcBIE/2wO/u4fQR0T5aEiPB4PM=;
	b=aUxJwbg+nBnnAuJ2BKBfn9HAO+DKiB+M78asXWhgS1cJhsG0BICzs1DOnTY26umO/wkqIY
	lKWa4lt/SNinKheT47Db4uveFXzNvVQKiW34+zjovNh4M3WuAPIyhwOzT9ME2Tyyxz/Ew6
	v0jKGdMyAYER35xhbV/BZOssOz8zIA3xg0HiWH9ubWhHPf0sLeSL/5YeNoiPmp8ak5gO7R
	HXaL7z1n8RT+Ez1vNfC5WaGBVXsz7FHFR8NCt4tRNGNVL5ut7Q6dRogTuEog93PCNIq+A7
	ofsjiPAkPoNEBY7DNiQkvEOMvDmHDOpzHn4gpfubH41FCnyaXdsToSnYDiL1yQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:14:22 +0200
Subject: [PATCH 11/12] net: pse-pd: Add support for event reporting using
 devm_regulator_irq_helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-11-eb067b78d6cf@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
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

Add support for devm_pse_irq_helper(), a wrapper for
devm_regulator_irq_helper(). This aims to report events such as
over-current or over-temperature conditions similarly to how the regulator
API handles them. Additionally, this patch introduces several define
wrappers to keep regulator naming conventions out of PSE drivers.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/pse-pd/pse.h    | 24 ++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index d365fb7c8a98..a9f102507f5e 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -8,7 +8,6 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/pse-pd/pse.h>
-#include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
 static DEFINE_MUTEX(pse_list_mutex);
@@ -536,6 +535,37 @@ int devm_pse_controller_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pse_controller_register);
 
+int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
+			int irq_flags, int supported_errs,
+			const struct pse_irq_desc *d)
+{
+	struct regulator_dev **rdevs;
+	void *irq_helper;
+	int i;
+
+	rdevs = devm_kcalloc(pcdev->dev, pcdev->nr_lines,
+			     sizeof(struct regulator_dev *), GFP_KERNEL);
+	if (!rdevs)
+		return -ENOMEM;
+
+	for (i = 0; i < pcdev->nr_lines; i++)
+		rdevs[i] = pcdev->pi[i].rdev;
+
+	/* Register notifiers - can fail if IRQ is not given */
+	irq_helper = devm_regulator_irq_helper(pcdev->dev, d, irq,
+					       0, supported_errs, NULL,
+					       &rdevs[0], pcdev->nr_lines);
+	if (IS_ERR(irq_helper)) {
+		if (PTR_ERR(irq_helper) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_warn(pcdev->dev, "IRQ disabled %pe\n", irq_helper);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_pse_irq_helper);
+
 /* PSE control section */
 
 static void __pse_control_release(struct kref *kref)
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index b60fc56923bd..ba3d6630d768 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -8,6 +8,7 @@
 #include <linux/ethtool.h>
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
+#include <linux/regulator/driver.h>
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
@@ -15,6 +16,26 @@
 struct phy_device;
 struct pse_controller_dev;
 
+/* structure and define wrappers from PSE to regulator */
+#define pse_irq_desc regulator_irq_desc
+#define pse_irq_data regulator_irq_data
+#define pse_err_data regulator_err_data
+#define pse_err_state regulator_err_state
+
+#define PSE_EVENT_TABLE(event)	REGULATOR_EVENT_##event
+#define PSE_ERROR_TABLE(error)	REGULATOR_ERROR_##error
+
+#define PSE_EVENT_OVER_CURRENT		PSE_EVENT_TABLE(OVER_CURRENT)
+#define PSE_EVENT_OVER_TEMP		PSE_EVENT_TABLE(OVER_TEMP)
+
+#define PSE_ERROR_OVER_CURRENT		PSE_ERROR_TABLE(OVER_CURRENT)
+#define PSE_ERROR_OVER_TEMP		PSE_ERROR_TABLE(OVER_TEMP)
+
+/* Return values for PSE IRQ helpers */
+#define PSE_ERROR_CLEARED	PSE_ERROR_TABLE(CLEARED)
+#define PSE_FAILED_RETRY	REGULATOR_FAILED_RETRY
+#define PSE_ERROR_ON		PSE_ERROR_TABLE(ON)
+
 /**
  * struct pse_control_config - PSE control/channel configuration.
  *
@@ -180,6 +201,9 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev);
 struct device;
 int devm_pse_controller_register(struct device *dev,
 				 struct pse_controller_dev *pcdev);
+int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
+			int irq_flags, int supported_errs,
+			const struct pse_irq_desc *d);
 
 struct pse_control *of_pse_control_get(struct device_node *node);
 void pse_control_put(struct pse_control *psec);

-- 
2.34.1


