Return-Path: <netdev+bounces-98270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71218D0813
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 18:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741312A905C
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C1716086C;
	Mon, 27 May 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UbbkYHxY"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4C15F30A;
	Mon, 27 May 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826505; cv=none; b=cgpw1J/EYqFzZk0J3mzLu0g+aV/pgtuiIMPE/eTvWJtm1gIXJdDAgKzlvzntofusJqyXty3kUoEX5ddjPmQZzuXVVr5iR7bYS7W8XkqPVubjSVJjtAloeSs71enpDPsmpvvHT2642HPyRfBTkgPFF8IFXKGXMae2fqs/C/PDTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826505; c=relaxed/simple;
	bh=0M1Hns7CDOYJ2aLM9KSawz/vJcM90IBbHl4CqMegdlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dsa9AiA6NrSyZLTYAyhddrLRg8uJigHZ6cBBrX8P+nC9ZAZNbFKRPsJNtGyiImDxuxojGaReH4V2N8yl+U/0ABOENGgbXV7oc6pcKsp+EY51eFjL/tPqzkykR6I3dV8AZWoZlNsng4O0VV7zna5ufnvRbJpRWtZHC7qLs87t/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UbbkYHxY; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6E42AFF811;
	Mon, 27 May 2024 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9+p1hma003opriOOEox9fT6iYMjtITIcW1ZIQ2QLNo=;
	b=UbbkYHxYIA3ApPt5oZI7rO4HRwWoAo+RNwHf495UokGST04QM/XPmwZtNfGcvXqNkTLLfv
	zPUvOe+3SPZsP9KT2IJxAesVe4FI9LV4C2BZTsojIVpNNUeFoesg2zWL8OJEA8+nRMAOHN
	K+llDN/wjyKrld3B3chDtl9+p+esUWB+dB8aE9FtPOBBFiQg0um64VbuBdlxOWQtqvk3OM
	W0JAOMp5UrAlcivoZaqFJ2Ggh8DZV8bwlkDnUzSnTShUs503r9tGo7Of+ahmFZI3fGyWJG
	U5aa5lsr0s8+nuyELHEYKPojqVP9Am8/bPDFC0Q/FPlAZ32lf/kjwEoYKm4y8A==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v2 01/19] mfd: syscon: Add reference counting and device managed support
Date: Mon, 27 May 2024 18:14:28 +0200
Message-ID: <20240527161450.326615-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

From: Clément Léger <clement.leger@bootlin.com>

Syscon releasing is not supported.
Without release function, unbinding a driver that uses syscon whether
explicitly or due to a module removal left the used syscon in a in-use
state.

For instance a syscon_node_to_regmap() call from a consumer retrieve a
syscon regmap instance. Internally, syscon_node_to_regmap() can create
syscon instance and add it to the existing syscon list. No API is
available to release this syscon instance, remove it from the list and
free it when it is not used anymore.

Introduce reference counting in syscon in order to keep track of syscon
usage using syscon_{get,put}() and add a device managed version of
syscon_regmap_lookup_by_phandle(), to automatically release the syscon
instance on the consumer removal.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/mfd/syscon.c       | 145 ++++++++++++++++++++++++++++++++++---
 include/linux/mfd/syscon.h |  18 +++++
 2 files changed, 154 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 7d0e91164cba..86898831b842 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -34,6 +34,7 @@ struct syscon {
 	struct regmap *regmap;
 	struct reset_control *reset;
 	struct list_head list;
+	struct kref refcount;
 };
 
 static const struct regmap_config syscon_regmap_config = {
@@ -147,6 +148,8 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 
 	syscon->regmap = regmap;
 	syscon->np = np;
+	of_node_get(syscon->np);
+	kref_init(&syscon->refcount);
 
 	spin_lock(&syscon_list_slock);
 	list_add_tail(&syscon->list, &syscon_list);
@@ -168,7 +171,30 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	return ERR_PTR(ret);
 }
 
-static struct regmap *device_node_get_regmap(struct device_node *np,
+static void syscon_free(struct kref *kref)
+{
+	struct syscon *syscon = container_of(kref, struct syscon, refcount);
+
+	spin_lock(&syscon_list_slock);
+	list_del(&syscon->list);
+	spin_unlock(&syscon_list_slock);
+
+	regmap_exit(syscon->regmap);
+	of_node_put(syscon->np);
+	kfree(syscon);
+}
+
+static void syscon_get(struct syscon *syscon)
+{
+	kref_get(&syscon->refcount);
+}
+
+static void syscon_put(struct syscon *syscon)
+{
+	kref_put(&syscon->refcount, syscon_free);
+}
+
+static struct syscon *device_node_get_syscon(struct device_node *np,
 					     bool check_res)
 {
 	struct syscon *entry, *syscon = NULL;
@@ -183,9 +209,23 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 
 	spin_unlock(&syscon_list_slock);
 
-	if (!syscon)
+	if (!syscon) {
 		syscon = of_syscon_register(np, check_res);
+		if (IS_ERR(syscon))
+			return ERR_CAST(syscon);
+	} else {
+		syscon_get(syscon);
+	}
+
+	return syscon;
+}
 
+static struct regmap *device_node_get_regmap(struct device_node *np,
+					     bool check_res)
+{
+	struct syscon *syscon;
+
+	syscon = device_node_get_syscon(np, check_res);
 	if (IS_ERR(syscon))
 		return ERR_CAST(syscon);
 
@@ -198,12 +238,23 @@ struct regmap *device_node_to_regmap(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(device_node_to_regmap);
 
-struct regmap *syscon_node_to_regmap(struct device_node *np)
+static struct syscon *syscon_node_to_syscon(struct device_node *np)
 {
 	if (!of_device_is_compatible(np, "syscon"))
 		return ERR_PTR(-EINVAL);
 
-	return device_node_get_regmap(np, true);
+	return device_node_get_syscon(np, true);
+}
+
+struct regmap *syscon_node_to_regmap(struct device_node *np)
+{
+	struct syscon *syscon;
+
+	syscon = syscon_node_to_syscon(np);
+	if (IS_ERR(syscon))
+		return ERR_CAST(syscon);
+
+	return syscon->regmap;
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
@@ -223,11 +274,11 @@ struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
 
-struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
-					const char *property)
+static struct syscon *syscon_lookup_by_phandle(struct device_node *np,
+					       const char *property)
 {
 	struct device_node *syscon_np;
-	struct regmap *regmap;
+	struct syscon *syscon;
 
 	if (property)
 		syscon_np = of_parse_phandle(np, property, 0);
@@ -237,12 +288,24 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 	if (!syscon_np)
 		return ERR_PTR(-ENODEV);
 
-	regmap = syscon_node_to_regmap(syscon_np);
+	syscon = syscon_node_to_syscon(syscon_np);
 
 	if (property)
 		of_node_put(syscon_np);
 
-	return regmap;
+	return syscon;
+}
+
+struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
+					       const char *property)
+{
+	struct syscon *syscon;
+
+	syscon = syscon_lookup_by_phandle(np, property);
+	if (IS_ERR(syscon))
+		return ERR_CAST(syscon);
+
+	return syscon->regmap;
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
 
@@ -293,6 +356,70 @@ struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_optional);
 
+static struct syscon *syscon_from_regmap(struct regmap *regmap)
+{
+	struct syscon *entry, *syscon = NULL;
+
+	spin_lock(&syscon_list_slock);
+
+	list_for_each_entry(entry, &syscon_list, list)
+		if (entry->regmap == regmap) {
+			syscon = entry;
+			break;
+		}
+
+	spin_unlock(&syscon_list_slock);
+
+	return syscon;
+}
+
+void syscon_put_regmap(struct regmap *regmap)
+{
+	struct syscon *syscon;
+
+	syscon = syscon_from_regmap(regmap);
+	if (!syscon)
+		return;
+
+	syscon_put(syscon);
+}
+EXPORT_SYMBOL_GPL(syscon_put_regmap);
+
+static void devm_syscon_release(struct device *dev, void *res)
+{
+	syscon_put(*(struct syscon **)res);
+}
+
+static struct regmap *__devm_syscon_get(struct device *dev,
+					struct syscon *syscon)
+{
+	struct syscon **ptr;
+
+	if (IS_ERR(syscon))
+		return ERR_CAST(syscon);
+
+	ptr = devres_alloc(devm_syscon_release, sizeof(struct syscon *), GFP_KERNEL);
+	if (!ptr) {
+		syscon_put(syscon);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*ptr = syscon;
+	devres_add(dev, ptr);
+
+	return syscon->regmap;
+}
+
+struct regmap *devm_syscon_regmap_lookup_by_phandle(struct device *dev,
+						    struct device_node *np,
+						    const char *property)
+{
+	struct syscon *syscon = syscon_lookup_by_phandle(np, property);
+
+	return __devm_syscon_get(dev, syscon);
+}
+EXPORT_SYMBOL_GPL(devm_syscon_regmap_lookup_by_phandle);
+
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index c315903f6dab..f742d865a37a 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 
 struct device_node;
+struct device;
 
 #ifdef CONFIG_MFD_SYSCON
 struct regmap *device_node_to_regmap(struct device_node *np);
@@ -28,6 +29,11 @@ struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
 						    unsigned int *out_args);
 struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 							const char *property);
+void syscon_put_regmap(struct regmap *regmap);
+
+struct regmap *devm_syscon_regmap_lookup_by_phandle(struct device *dev,
+						    struct device_node *np,
+						    const char *property);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -67,6 +73,18 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_optional(
 	return NULL;
 }
 
+static inline void syscon_put_regmap(struct regmap *regmap)
+{
+}
+
+static inline
+struct regmap *devm_syscon_regmap_lookup_by_phandle(struct device *dev,
+						    struct device_node *np,
+						    const char *property)
+{
+	return NULL;
+}
+
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.45.0


