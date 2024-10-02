Return-Path: <netdev+bounces-131313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335C98E0C6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439131C2313B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA61D27BC;
	Wed,  2 Oct 2024 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DiJbMRff"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6CA1D1F76;
	Wed,  2 Oct 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886557; cv=none; b=AUYvZMbb97rPRCHIogokn4Vl+AP0UNaG0XfZXFbQgvgHt35nO7v12CyAGc9eozfm0rMjKJ0W8dMU9QAg0tDLQHiI5EHxJW6WlIm0rQ4ZEo3R6VGnquqEmdv6Ie4kFecMSljBa/KCX76lNncI054IxBx1Y0lN+1Ch37sYEJQ3TdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886557; c=relaxed/simple;
	bh=TmppxM30hDT5N6ZYZ9A5WGjGkeUb4dF0hUftJdet5Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xl4ll/38Tyt9FB4PrPnUJm8ScfqWZgIjmJyb1tI7E2elsXHj4kTk6p2cIuj5JYIyxGqYsR/BOeLQyzxx2/tNSwDGvdqy/EkINAHJuYM9pJ4c+z7N7QToLv2uspQVVh5qseLoC3n2f3rMmBrgGStU5MIrE7DbLWQGsVSfqQEEWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DiJbMRff; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 579F11BF208;
	Wed,  2 Oct 2024 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwYTIxMfa1jPmwx2OgcBIE/2wO/u4fQR0T5aEiPB4PM=;
	b=DiJbMRffZA+MwVWjVcqW2/FkadssdjolTvl//v+zd5bYFQ1PKBeDaWv9b5tWFBfCSi8wWh
	/b5zJcrVGKMSxF1FhDwnqU9+565wvbPyheURD/aejo0Ta+oFjNbBmW+5I9ICBzgArF0XC+
	6RkmmMxkrIn2bqJCTVcoiSIKs5ko+b7uwMuPq8Tpz/4CDDG+RBLY1ZdYvFod2VH/i2yNrd
	1zBIxOCsEh8GnibKg7A6m3Ch83LFMwHWXD89eo28qWd2XI14nWvo2docBLWbmDq1LlcmrY
	GYvJtyNaNLyt3SsWxpGl/9RDF29ft8FsyBtgXol4IioLpZ9zHVR+Zoooz/UYtw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:28:07 +0200
Subject: [PATCH net-next 11/12] net: pse-pd: Add support for event
 reporting using devm_regulator_irq_helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>
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


