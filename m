Return-Path: <netdev+bounces-274812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPPaGyUQz2lysgYAu9opvQ
	(envelope-from <netdev+bounces-274812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F438FBE7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4F2430AB60C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA926A0A7;
	Fri,  3 Apr 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+jXmbwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3F25A2A4
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177524; cv=none; b=uQIqjg201zJj+sL5MWxUXPEBQm1CTgWZb/QlDFSM0JZavx6eG7kL8+e1B06jf1a4H4fQC8Ryd69NnfcDMGyoOGtTAA33HYHUrQv29myA1+7s5AxiEuj7YmEZa2zLdqvxSHpiJc3mwGRdRk6oPO+x1RLdOQtdLEgyrM75NpkgUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177524; c=relaxed/simple;
	bh=tRMVu6GM7+H2C7gIhSHYmeG83ofUKG+ZKGYfkloYcYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXlL9VHKbKSXOWO5hPxh3CJtGrwIJJtCGcuxDD2pvz73HrnYVL9vhkob+73J03Kc9nTP8jWuUNYj9ais6NjH9RgPqEIvdfvMnu25M+WtELMHQgs+wL+SF79YqY6oPdf1zZPnmlwFKDUtxJEQziDMLbkFjf60q0TD8tWjQcQWhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+jXmbwg; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1817539eec.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177522; x=1775782322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0XcTKJSZv00lNgVXjUFXubjiKj+C90x3kNuWZLzTwo=;
        b=W+jXmbwgjuoPkOv7IL+E1thwTwrIBBT8gasmaqbyDeSWvHtnqi86ApSGhttgbKQw15
         h42uv5FbWBFCWL6uhbzVshUtOo6Ej39wCrsXXKAJOkHNriYr5YFM3+YPDgRPRCjqMQn0
         4NFyaJM4vp3rd3szTNyHfTVMfY2Zl+o2o45GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177522; x=1775782322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c0XcTKJSZv00lNgVXjUFXubjiKj+C90x3kNuWZLzTwo=;
        b=aiWTrDmqoAMwkV7Z5v/948QQdUiiULWroTYw5MjrcNdhV1fjxng05EfOwowKyt03ti
         BRTs9MKRrxnrKOpbjWHMgWAKTxC8TmNvUbCwqFZ46yG5gSMOOT25yXKxvhqvJHZxAvpt
         YhYF3pMYH01BWLOitCaXHhBqVjhjelmrZZMw/7eB5VJYasxFk9jlBVpycAVj2uSyvVv9
         aEWC2ZFg2L+kd/tmU4a3L6rCldEIz5sER5/WEzZHQYA8nuqhH8hH034OLXJzyqA06K9W
         AuX23UJ3LZaVqXEUV4WmAyJ6tVxud5U8oN9Fnn9UnOd3L3axhorfNtPI4F9AVeg73bce
         nkpg==
X-Forwarded-Encrypted: i=1; AJvYcCW1GfmvQQYWCr8LkHOu3OrhvXEhEjD5UaSGzKzx4o1EKfn5Iu2VZE594i8B3flMgUARI5K+8Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtMSx+0p61Z1z9lGjfgJPVAlr8VYtPXGoD1uiBmeYI0MqBk66
	H1+jtnC+4HP1xXk8dnYoxYYw/IvqA9KHFwKRVmwnt64L9Pjih09+IPyuscMm/zNaMw==
X-Gm-Gg: AeBDiethZ0Be46gLK6oRpX/Ao0X2tb+HIyf7nqLZBjDb+IRwBpoLdyQXH+Xrdl1urTT
	huzKxZ1ORjaOCyjRHRRge60OKD2EJhx90ZT13PpqsI8t8yw4UrP6IjWBkIb7Yi7+6lqFJRRZzsG
	6iCuoJxQfIe14uWT7D75g7TEXHQWNzdnTUpCLI8dFATy1aKWZEyOEj1y4a0Skzwyw86IebwhUOt
	lR9lZDi0WYCFt0f/Xe+jPcFtGeKMja/KSQF4m7KRzIKwYa/plW+Z+Vo0mvq2O8FoASJ3Dbf++Mu
	W9htRrWXH4QAvsT1R8LlKmif0QInXKpPqPCnAjWz6+l9LBxmZCVb66f08HWbHFjAIB7Kvoe3Gei
	T9r78yfXUmGZI++0j3E+B7Lbh7pc6jq7GjkHrNuL5kgkf8m2PvDo5gwzMUCu4b5f40LaB9mnXlA
	bdz+vxwByphUZRFkSDvF/5oKU6vqTNyX1xYE8lYGG2gCt8H6NpRQWwoyLrztpDCwTwwrIqaUCAq
	fNqvENBUZ4=
X-Received: by 2002:a05:7300:2315:b0:2c8:b5e1:6b03 with SMTP id 5a478bee46e88-2cbfbf77d16mr618666eec.23.1775177521837;
        Thu, 02 Apr 2026 17:52:01 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:59 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	alexander.stein@ew.tq-group.com,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	astewart@tektelic.com,
	bhelgaas@google.com,
	brgl@kernel.org,
	broonie@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	driver-core@lists.linux.dev,
	hkallweit1@gmail.com,
	jirislaby@kernel.org,
	joel@jms.id.au,
	kees@kernel.org,
	kuba@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	mani@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org
Subject: [PATCH v3 8/9] driver core: Replace dev->of_node_reused with DEV_FLAG_OF_NODE_REUSED
Date: Thu,  2 Apr 2026 17:49:54 -0700
Message-ID: <20260402174925.v3.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260403005005.30424-1-dianders@chromium.org>
References: <20260403005005.30424-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,mips.com,intel.com,google.com,hp.com,lst.de,ozlabs.ru,chromium.org,ew.tq-group.com,codeconstruct.com.au,lunn.ch,linux.intel.com,tektelic.com,davemloft.net,vger.kernel.org,lists.linux.dev,gmail.com,jms.id.au,lists.infradead.org,lists.ozlabs.org,armlinux.org.uk,redhat.com];
	TAGGED_FROM(0.00)[bounces-274812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: EB7F438FBE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "of_node_reused" over to the "flags"
field so modifications are safe.

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

Changes in v3:
- New

 drivers/base/core.c                      | 2 +-
 drivers/base/pinctrl.c                   | 2 +-
 drivers/base/platform.c                  | 2 +-
 drivers/net/pcs/pcs-xpcs-plat.c          | 2 +-
 drivers/of/device.c                      | 6 +++---
 drivers/pci/of.c                         | 2 +-
 drivers/pci/pwrctrl/core.c               | 2 +-
 drivers/regulator/bq257xx-regulator.c    | 2 +-
 drivers/regulator/rk808-regulator.c      | 2 +-
 drivers/tty/serial/serial_base_bus.c     | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 +-
 include/linux/device.h                   | 6 +++---
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 00005777c21f..a87bd40499b6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5282,7 +5282,7 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 {
 	of_node_put(dev->of_node);
 	dev->of_node = of_node_get(dev2->of_node);
-	dev->of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags);
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
 
diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
index 6e250272c843..62c228c75d50 100644
--- a/drivers/base/pinctrl.c
+++ b/drivers/base/pinctrl.c
@@ -24,7 +24,7 @@ int pinctrl_bind_pins(struct device *dev)
 {
 	int ret;
 
-	if (dev->of_node_reused)
+	if (test_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags))
 		return 0;
 
 	dev->pins = devm_kzalloc(dev, sizeof(*(dev->pins)), GFP_KERNEL);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d44591d52e36..5128ff7e5e78 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -856,7 +856,7 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.parent = pdevinfo->parent;
 	pdev->dev.fwnode = pdevinfo->fwnode;
 	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
-	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
+	assign_bit(DEV_FLAG_OF_NODE_REUSED, &pdev->dev.flags, pdevinfo->of_node_reused);
 
 	if (pdevinfo->dma_mask) {
 		pdev->platform_dma_mask = pdevinfo->dma_mask;
diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index b8c48f9effbf..c2722d8bd98a 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -349,7 +349,7 @@ static int xpcs_plat_init_dev(struct dw_xpcs_plat *pxpcs)
 	 * up later. Make sure DD-core is aware of the OF-node being re-used.
 	 */
 	device_set_node(&mdiodev->dev, fwnode_handle_get(dev_fwnode(dev)));
-	mdiodev->dev.of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &mdiodev->dev.flags);
 
 	/* Pass the data further so the DW XPCS driver core could use it */
 	mdiodev->dev.platform_data = (void *)device_get_match_data(dev);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index f7e75e527667..fd77295a8c0f 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -26,7 +26,7 @@
 const struct of_device_id *of_match_device(const struct of_device_id *matches,
 					   const struct device *dev)
 {
-	if (!matches || !dev->of_node || dev->of_node_reused)
+	if (!matches || !dev->of_node || test_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags))
 		return NULL;
 	return of_match_node(matches, dev->of_node);
 }
@@ -192,7 +192,7 @@ ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 {
 	ssize_t sl;
 
-	if (!dev || !dev->of_node || dev->of_node_reused)
+	if (!dev || !dev->of_node || test_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags))
 		return -ENODEV;
 
 	sl = of_modalias(dev->of_node, str, len - 2);
@@ -254,7 +254,7 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 {
 	int sl;
 
-	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
+	if ((!dev) || (!dev->of_node) || test_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags))
 		return -ENODEV;
 
 	/* Devicetree modalias is tricky, we add it in 2 steps */
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9f8eb5df279e..197b60c5a660 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -38,7 +38,7 @@ int pci_set_of_node(struct pci_dev *dev)
 	struct device *pdev __free(put_device) =
 		bus_find_device_by_of_node(&platform_bus_type, node);
 	if (pdev)
-		dev->bus->dev.of_node_reused = true;
+		set_bit(DEV_FLAG_OF_NODE_REUSED, &dev->bus->dev.flags);
 
 	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
 	return 0;
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 7754baed67f2..cfbe9b615b88 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -39,7 +39,7 @@ static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 		 * If we got here then the PCI device is the second after the
 		 * power control platform device. Mark its OF node as reused.
 		 */
-		dev->of_node_reused = true;
+		set_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags);
 		break;
 	}
 
diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index dab8f1ab4450..01d3139e1d87 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -143,7 +143,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct regulator_config cfg = {};
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &pdev->dev.flags);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
 	if (!pdata)
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e66408f23bb6..375ea7861134 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -2115,7 +2115,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	int ret, i, nregulators;
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &pdev->dev.flags);
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index a12935f6b992..86c6003bbebb 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -74,7 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
-	dev->of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags);
 
 	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 2ecd049dacc2..57048e3aa6bb 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -593,7 +593,7 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 		d->gadget.max_speed = USB_SPEED_HIGH;
 	d->gadget.speed = USB_SPEED_UNKNOWN;
 	d->gadget.dev.of_node = vhub->pdev->dev.of_node;
-	d->gadget.dev.of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &d->gadget.dev.flags);
 
 	rc = usb_add_gadget_udc(d->port_dev, &d->gadget);
 	if (rc != 0)
diff --git a/include/linux/device.h b/include/linux/device.h
index c2a6dba7a036..f6ca067bacca 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -482,6 +482,8 @@ struct device_physical_location {
  *		driver/bus sync_state() callback.
  * @DEV_FLAG_DMA_COHERENT: This particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @DEV_FLAG_OF_NODE_REUSED: Set if the device-tree node is shared with an
+ *		ancestor device.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE,
@@ -491,6 +493,7 @@ enum struct_device_flags {
 	DEV_FLAG_DMA_OPS_BYPASS,
 	DEV_FLAG_STATE_SYNCED,
 	DEV_FLAG_DMA_COHERENT,
+	DEV_FLAG_OF_NODE_REUSED,
 };
 
 /**
@@ -570,8 +573,6 @@ enum struct_device_flags {
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
- * @of_node_reused: Set if the device-tree node is shared with an ancestor
- *              device.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -678,7 +679,6 @@ struct device {
 
 	bool			offline_disabled:1;
 	bool			offline:1;
-	bool			of_node_reused:1;
 
 	unsigned long		flags;
 };
-- 
2.53.0.1213.gd9a14994de-goog


