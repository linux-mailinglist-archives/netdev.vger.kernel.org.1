Return-Path: <netdev+bounces-179488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BEDA7D0FA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA716F2DD
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599122257C;
	Sun,  6 Apr 2025 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT/SIHV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B9221F3B;
	Sun,  6 Apr 2025 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977711; cv=none; b=t++aMmdRVjkpRmPpDWYbmNPaYPrTLO/TaY1JIRny+X2GJyVUDCpQx5F2ZCIQ8Zo1VKlD+rv3/2rFZ6F2YVDnB9UR9KtwTVQId2vtTuuyOICylYdgmdFy0h1GzVTmotpiFQQKBrN8oAG8N33G+C9ymF8LTv+CfRh3M9PA2GO2Mb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977711; c=relaxed/simple;
	bh=OWyjiB9xZw2J+tUYX6oGxSJ4ZdCAM7qFUvd8zV6xLco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayLz+2eL3uFCWD4HgRrWMX7I6i8RmuBqpzmMP9milA+mfRTwjniszsgIRl4jUeDVnv2Gj6+oLyefCDyuAp62sLigREaS20ozZyg7pYcLTAimhJINiAGSm7KoalSdBCdpmZg0JLldnLU/zcuUgjgd2tonwBsLT7EcSby+4dnXqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT/SIHV6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso22666885e9.0;
        Sun, 06 Apr 2025 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977707; x=1744582507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9xqHcI6eEdBoYc8sq0yd0T9xMnWM8DZJfsMIYVhLZU=;
        b=fT/SIHV6YfwVwLIxjS2Q38QcR3dHgx4kmfvw8qGiOlxHJmuKKp0lKkfCB2UOr1yCBv
         nadlKe7CcMH041xpuAAbzfVDzVShwMcZZRRenC+ladJw5ZVph2+3fGMBWsTzPHyghKCW
         E1rq6JwL25rFgwGwAdTN9Yc5me3GVmIDMG1aEeQtbUCXWhWrfR9eMFwhmQyFiiBtyy4q
         IV8K7Srrf6xsJvY1Ejyzxet7ibXhj6lyZ1jckNOE8FkvW65YCAGd+APyy5CCGGpzyZls
         DTyey99Vz4gyJpN2DwN4F+qVzGBxcIo5WpIW/3zwONPISvt755gmmjji8pyhRdRXdGAe
         6owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977707; x=1744582507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9xqHcI6eEdBoYc8sq0yd0T9xMnWM8DZJfsMIYVhLZU=;
        b=VbYatIHB2ZLxKUjkElPF8vAAUiFs1uiYrsdrRjA7MNGBwGWumQCNeGL9P0m1S326Bn
         Q7mkRMDX0/pYuxdDmKB/Vxgv1BU6c4V1upxdw5i4GWTz3r18mnHm26s7mCaA+sxcNuGH
         QQeOhJ0an17bzNe//4jwePFza906WSfwbCaMUO9Eun3Om8RTBGbWTNXOErPwXw7LHL1m
         ZLYpwZMd0B6lm8hrQLBSoEDgBgnV3RwDm+cUoua+7pegnRnaHL5QbenQRwsIpFVaMkfP
         gkiEEytoB4jUm2WSMvufhvKNBQ56fQsuK2g3886qWjQ/v5M9l7zsQMCdNTwRK3ouso9i
         n2eg==
X-Forwarded-Encrypted: i=1; AJvYcCVZOh2katD08nVHTILDu0MXlw6UvqA0NjtY0F6pM4z7b7DbjTlk+kdH7exB2A9vKCOA1zCKyR61Pb+X@vger.kernel.org, AJvYcCXg0iowHJsZZCu5x+R8RtEFKHPepalnzzZ5uTIlI/tVtdJmBDH/jb0XNiCQ3JlpPGWmEBBb/3lzdUsfnorp@vger.kernel.org, AJvYcCXq3AqFrUdHdxLhpYT0caza9m3P2SAlFSvB4e8bXqdmr0+BfxABzxd6RkaL8OI2JRfNqiCmegf1@vger.kernel.org
X-Gm-Message-State: AOJu0YyP18oW2CaFUqCpowE+JT75LwYuZ76ykEKEIFrHnywAQ2av+mxE
	X6/ueY/vw+KV7C6WXiizysQX+mMSjaVEDprcwFASW8r2Ka/Eo+/W
X-Gm-Gg: ASbGncs2o0mYXRjAV4S2Qe92EzjFucfV50nc6TDuNnPauRZsvVqOy4FmIQE0YjLV7KY
	amwf0rPDlJE+3nJpDa75YMjMwGH4QdoCwTPXQLAPtGZ/jXinFHR92u5Up3S0Aoh6t8TqfeA2xiQ
	NtfH8htVhrmG/YdghzX7fuCqJ6x84RrP7rSTNVGIhga0wZVl6H5uyoph+c23dbwuBKX7NuJ6HJP
	uSPywo73+Whr5EPdc817Q4xjpG2Tp2WGFz5luiDzkHMUkCvwlURHwroH1wLOimt7GNdYMKARPtX
	x77QVrIDJnA8eZuB1iBYm5U2Am1+mU6u4+iNF3gETz0nOng7soHtx7FGruICuzXtIMoHkMznzeB
	iENQR4wUs5Hj3EQ==
X-Google-Smtp-Source: AGHT+IHHGzqQcd0yxNmInYcS6+JqZl5EtjnstzVnRpxCfifNdrZhAMxa8fvFxvPHu5vzKgxQcN6MHA==
X-Received: by 2002:a05:600c:3504:b0:43d:54a:221c with SMTP id 5b1f17b1804b1-43eeb5c0212mr45020395e9.18.1743977707112;
        Sun, 06 Apr 2025 15:15:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 06/11] net: pcs: implement Firmware node support for PCS driver
Date: Mon,  7 Apr 2025 00:13:59 +0200
Message-ID: <20250406221423.9723-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the foundation of Firmware node support for PCS driver.

To support this, implement a simple Provider API where a PCS driver can
expose multiple PCS with an xlate .get function.

PCS driver will have to call fwnode_pcs_add_provider() and pass the
firmware node pointer and a xlate function to return the correct PCS for
the passed #pcs-cells.

This will register the PCS in a global list of providers so that
consumer can access it.

Consumer will then use fwnode_pcs_get() to get the actual PCS by passing
the firmware node pointer and the index for #pcs-cells.

For simple implementation where #pcs-cells is 0 and the PCS driver
expose a single PCS, the xlate function fwnode_pcs_simple_get() is
provided.

For advanced implementation a custom xlate function is required.

PCS driver on removal should first delete as a provider with
the usage of fwnode_pcs_del_provider() and then call
phylink_release_pcs() on every PCS the driver provides and

A generic function fwnode_phylink_pcs_parse() is provided for any MAC
driver that will declare PCS in DT (or ACPI).
This function will parse "pcs-handle" property and fill the passed array
with the parsed PCS in availabel_pcs up to the passed num_pcs value.
It's also possible to pass NULL as array to only parse the PCS and
update the num_pcs value with the count of scanned PCS.

Co-developed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/pcs/Kconfig          |   7 ++
 drivers/net/pcs/Makefile         |   1 +
 drivers/net/pcs/pcs.c            | 201 +++++++++++++++++++++++++++++++
 include/linux/pcs/pcs-provider.h |  41 +++++++
 include/linux/pcs/pcs.h          |  56 +++++++++
 5 files changed, 306 insertions(+)
 create mode 100644 drivers/net/pcs/pcs.c
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index f6aa437473de..2951aa2f4cda 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -5,6 +5,13 @@
 
 menu "PCS device drivers"
 
+config FWNODE_PCS
+	tristate
+	depends on (ACPI || OF)
+	depends on PHYLINK
+	help
+		Firmware node PCS accessors
+
 config PCS_XPCS
 	tristate "Synopsys DesignWare Ethernet XPCS"
 	select PHYLINK
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index 4f7920618b90..3005cdd89ab7 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux PCS drivers
 
+obj-$(CONFIG_FWNODE_PCS)	+= pcs.o
 pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
 				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
 
diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
new file mode 100644
index 000000000000..14a5cd3eeda1
--- /dev/null
+++ b/drivers/net/pcs/pcs.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/phylink.h>
+#include <linux/pcs/pcs.h>
+#include <linux/pcs/pcs-provider.h>
+
+MODULE_DESCRIPTION("PCS library");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
+
+struct fwnode_pcs_provider {
+	struct list_head link;
+
+	struct fwnode_handle *fwnode;
+	struct phylink_pcs *(*get)(struct fwnode_reference_args *pcsspec,
+				   void *data);
+
+	void *data;
+};
+
+static LIST_HEAD(fwnode_pcs_providers);
+static DEFINE_MUTEX(fwnode_pcs_mutex);
+
+struct phylink_pcs *fwnode_pcs_simple_get(struct fwnode_reference_args *pcsspec,
+					  void *data)
+{
+	return data;
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_simple_get);
+
+int fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
+			    struct phylink_pcs *(*get)(struct fwnode_reference_args *pcsspec,
+						       void *data),
+			    void *data)
+{
+	struct fwnode_pcs_provider *pp;
+
+	if (!fwnode)
+		return 0;
+
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
+	pp->fwnode = fwnode_handle_get(fwnode);
+	pp->data = data;
+	pp->get = get;
+
+	mutex_lock(&fwnode_pcs_mutex);
+	list_add(&pp->link, &fwnode_pcs_providers);
+	mutex_unlock(&fwnode_pcs_mutex);
+	pr_debug("Added pcs provider from %pfwf\n", fwnode);
+
+	fwnode_dev_initialized(fwnode, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_add_provider);
+
+void fwnode_pcs_del_provider(struct fwnode_handle *fwnode)
+{
+	struct fwnode_pcs_provider *pp;
+
+	if (!fwnode)
+		return;
+
+	mutex_lock(&fwnode_pcs_mutex);
+	list_for_each_entry(pp, &fwnode_pcs_providers, link) {
+		if (pp->fwnode == fwnode) {
+			list_del(&pp->link);
+			fwnode_dev_initialized(pp->fwnode, false);
+			fwnode_handle_put(pp->fwnode);
+			kfree(pp);
+			break;
+		}
+	}
+	mutex_unlock(&fwnode_pcs_mutex);
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_del_provider);
+
+static int fwnode_parse_pcsspec(const struct fwnode_handle *fwnode, int index,
+				const char *name,
+				struct fwnode_reference_args *out_args)
+{
+	int ret = -ENOENT;
+
+	if (!fwnode)
+		return -ENOENT;
+
+	if (name)
+		index = fwnode_property_match_string(fwnode, "pcs-names",
+						     name);
+
+	ret = fwnode_property_get_reference_args(fwnode, "pcs-handle",
+						 "#pcs-cells",
+						 -1, index, out_args);
+	if (ret || (name && index < 0))
+		return ret;
+
+	return 0;
+}
+
+static struct phylink_pcs *
+fwnode_pcs_get_from_pcsspec(struct fwnode_reference_args *pcsspec)
+{
+	struct fwnode_pcs_provider *provider;
+	struct phylink_pcs *pcs = ERR_PTR(-EPROBE_DEFER);
+
+	if (!pcsspec)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&fwnode_pcs_mutex);
+	list_for_each_entry(provider, &fwnode_pcs_providers, link) {
+		if (provider->fwnode == pcsspec->fwnode) {
+			pcs = provider->get(pcsspec, provider->data);
+			if (!IS_ERR(pcs))
+				break;
+		}
+	}
+	mutex_unlock(&fwnode_pcs_mutex);
+
+	return pcs;
+}
+
+static struct phylink_pcs *__fwnode_pcs_get(struct fwnode_handle *fwnode,
+					    int index, const char *con_id)
+{
+	struct fwnode_reference_args pcsspec;
+	struct phylink_pcs *pcs;
+	int ret;
+
+	ret = fwnode_parse_pcsspec(fwnode, index, con_id, &pcsspec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pcs = fwnode_pcs_get_from_pcsspec(&pcsspec);
+	fwnode_handle_put(pcsspec.fwnode);
+
+	return pcs;
+}
+
+struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode, int index)
+{
+	return __fwnode_pcs_get(fwnode, index, NULL);
+}
+EXPORT_SYMBOL_GPL(fwnode_pcs_get);
+
+static int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode,
+				    unsigned int *num_pcs)
+{
+	struct fwnode_reference_args out_args;
+	int index = 0;
+	int ret;
+
+	while (true) {
+		ret = fwnode_property_get_reference_args(fwnode, "pcs-handle",
+							 "#pcs-cells",
+							 -1, index, &out_args);
+		/* We expect to reach an -ENOENT error while counting */
+		if (ret)
+			break;
+
+		fwnode_handle_put(out_args.fwnode);
+		index++;
+	}
+
+	/* Update num_pcs with parsed PCS */
+	*num_pcs = index;
+
+	/* Return error if we didn't found any PCS */
+	return index > 0 ? 0 : -ENOENT;
+}
+
+int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
+			     struct phylink_pcs **available_pcs,
+			     unsigned int *num_pcs)
+{
+	int i;
+
+	if (!fwnode_property_present(fwnode, "pcs-handle"))
+		return -ENODEV;
+
+	/* With available_pcs NULL, only count the PCS */
+	if (!available_pcs)
+		return fwnode_phylink_pcs_count(fwnode, num_pcs);
+
+	for (i = 0; i < *num_pcs; i++) {
+		struct phylink_pcs *pcs;
+
+		pcs = fwnode_pcs_get(fwnode, i);
+		if (IS_ERR(pcs))
+			return PTR_ERR(pcs);
+
+		available_pcs[i] = pcs;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fwnode_phylink_pcs_parse);
diff --git a/include/linux/pcs/pcs-provider.h b/include/linux/pcs/pcs-provider.h
new file mode 100644
index 000000000000..2fcc1d696c97
--- /dev/null
+++ b/include/linux/pcs/pcs-provider.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_PCS_PROVIDER_H
+#define __LINUX_PCS_PROVIDER_H
+
+/**
+ * fwnode_pcs_simple_get - Simple xlate function to retrieve PCS
+ * @pcsspec: reference arguments
+ * @data: Context data (assumed assigned to the single PCS)
+ *
+ * Returns the PCS. (pointed by data)
+ */
+struct phylink_pcs *fwnode_pcs_simple_get(struct fwnode_reference_args *pcsspec,
+					  void *data);
+
+/**
+ * fwnode_pcs_add_provider - Registers a new PCS provider
+ * @np: Firmware node
+ * @get: xlate function to retrieve the PCS
+ * @data: Context data
+ *
+ * Register and add a new PCS to the global providers list
+ * for the firmware node. A function to get the PCS from
+ * firmware node with the use fwnode reference arguments.
+ * To the get function is also passed the interface type
+ * requested for the PHY. PCS driver will use the passed
+ * interface to understand if the PCS can support it or not.
+ *
+ * Returns 0 on success or -ENOMEM on allocation failure.
+ */
+int fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
+			    struct phylink_pcs *(*get)(struct fwnode_reference_args *pcsspec,
+						       void *data),
+			    void *data);
+
+/**
+ * fwnode_pcs_del_provider - Removes a PCS provider
+ * @fwnode: Firmware node
+ */
+void fwnode_pcs_del_provider(struct fwnode_handle *fwnode);
+
+#endif /* __LINUX_PCS_PROVIDER_H */
diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
new file mode 100644
index 000000000000..c7a4d63bcd6d
--- /dev/null
+++ b/include/linux/pcs/pcs.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_PCS_H
+#define __LINUX_PCS_H
+
+#include <linux/phylink.h>
+
+#if IS_ENABLED(CONFIG_FWNODE_PCS)
+/**
+ * fwnode_pcs_get - Retrieves a PCS from a firmware node
+ * @fwnode: firmware node
+ * @index: index fwnode PCS handle in firmware node
+ *
+ * Get a PCS from the firmware node at index.
+ *
+ * Returns a pointer to the phylink_pcs or a negative
+ * error pointer. Can return -EPROBE_DEFER if the PCS is not
+ * present in global providers list (either due to driver
+ * still needs to be probed or it failed to probe/removed)
+ */
+struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode,
+				   int index);
+
+/**
+ * fwnode_phylink_pcs_parse - generic PCS parse for fwnode PCS provider
+ * @fwnode: firmware node
+ * @available_pcs: pointer to preallocated array of PCS
+ * @num_pcs: where to store count of parsed PCS
+ *
+ * Generic helper function to fill available_pcs array with PCS parsed
+ * from a "pcs-handle" fwnode property defined in firmware node up to
+ * passed num_pcs.
+ *
+ * If available_pcs is NULL, num_pcs is updated with the count of the
+ * parsed PCS.
+ *
+ * Returns 0 or a negative error.
+ */
+int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
+			     struct phylink_pcs **available_pcs,
+			     unsigned int *num_pcs);
+#else
+static inline struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode,
+						 int index)
+{
+	return ERR_PTR(-ENOENT);
+}
+
+static inline int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
+					   struct phylink_pcs **available_pcs,
+					   unsigned int *num_pcs)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif /* __LINUX_PCS_H */
-- 
2.48.1


