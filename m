Return-Path: <netdev+bounces-189588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEDBAB2AC1
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42441668CC
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F9626560C;
	Sun, 11 May 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNcWUruY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F026461E;
	Sun, 11 May 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994412; cv=none; b=QaFdMNZj1m9t0aB2hY36mfBife2VqErK4+RHbJWMHyk/xNncisBZ4+wFtj4yel18/u0mZcq57oUhajvroTxH1q4amS8CB0uIOTre6cDwIaMWN1wsfgQrF0H03vuk3CzJlxIZk6vNKtNHIoJmKDSqDh4i7PQo7JuaKmt6JfQ0yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994412; c=relaxed/simple;
	bh=eRWMgbPX/9dDQ5A2Y1/wb3icFGnLvph7pLmjvErc7d8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv57HvSXbuaP5jEWZdV+SfBf+wez9ds9pcICT57fAgRvjDxZ/e7zNFcyHGtSMiTBl0oKov9nxqySNYdGDAS0MdRTSS2FKQ8GijbSAtk75bOlOFZVv0ArfQzToC6B+JHF0uSzja6t6dMgl4E50KdSs521RnlcAnFWj2mFM5vHv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNcWUruY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so17069715e9.1;
        Sun, 11 May 2025 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746994409; x=1747599209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zt4Vte/Fn8P/UH8DOrwKj0Cm/lExYGWxO4AhO6PdHyg=;
        b=cNcWUruYVl3Sqk6AjW5RzabN/Hzm03y6/hi5Vl4pQBHC/Gu0AjmjeWV62Vw01iuSi4
         C9WKVEZ0bLqa8zgje7Do8JY+dy7O6FQH8Px9hyVZYEMxeXcJm00qcI5z15HQuy57TjUN
         aIUea2kBSmBk0URELkfPDrqAoFRBJL2rgavGlLzsINRbzposZPPCKWIF9XozuTc+L70y
         4j606LALbySPAKwAbCt6N5nUTo964ixzFPhFaRrN6Q296mexQpRaPYlUxwYB6Y+uB8QX
         usdBC+u8VrkRnDTYV+yk0Gqj2sUq/wNugDAEKJf/tkfaTgWwwGEHouCx4+rWn26wnDX7
         UyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746994409; x=1747599209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt4Vte/Fn8P/UH8DOrwKj0Cm/lExYGWxO4AhO6PdHyg=;
        b=majRxpMD9H6QBB8SvGYGlXOICZi5Y5c7VN4XRP+h0TDxq4U0ZWrr6gNWJTaYlUkizO
         r6ec0vjE1owmES331Ica0SdRdQsjEiMDUgvwqIcp8liGBwQGP4rZaP+FOFfuQbmn0fCS
         eSgcUqb7BA4iUx2/q9TOlocsynMzlmiPE4QlLy+IBoPmQgaGiX5TdxTn6AevlLOFhj1L
         yH0PHN+SdypO7elpl4NSJgBgT/JQ7fhmJuKoZ/lZb5dhwY9Gu61IDDtn4tYcZhJlvGSp
         /YfWY3TIEFkA8ZtnE+ouqOLTsGg5EfsjfRiRQMCx8dyN3kAaBNfgfsf1U9FuNeDg4o6+
         Zzdg==
X-Forwarded-Encrypted: i=1; AJvYcCUchGK0i3D+0T/nnocx10JhgcYK9giPNJa3FKeraemferrhr/rEpxOu3GxTCNjkXBpAYDVAsh4kuFrX@vger.kernel.org, AJvYcCX3EvqrtM3pb6klk6NmUHqXPsI4lYQKbormjxoZddjLc26SPWDG9fa+gb2FLYye6k1xllRYsVku+h2tXU8q@vger.kernel.org, AJvYcCXD9v+09IgMy8Qzime1XjRWJndL2iCub4tOUF9r5f/05GyD8khHShefWQm2q80Gv4r65GSpuJWe@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYMb4kWDOzd5Qfh1pb7KC93Qtgoau/77GnA0xRZ2UXbXLUiMy
	L/uWu9fkvSUX/EXMVhUCwneo9binpMROE+24LsLhc6x6cmYno6sc
X-Gm-Gg: ASbGnctyRrVOqxLPyug80QnpPAGSfrKXLcOiJv1MKSe4M2X8SHSYkWAfEFzIafhMfat
	4mOgP2NZEF/YaneQ7X/lzSrxoNxGWCJSTqHxAWX1wKUh49xbukCXDh9YGmRrgr06G2ADUl59rnr
	gnBUnlul4LZomInVn+vUKFYDZEgChgv/FYmvoFG/7faXNbBM2+hJoRlz+omWXEBw226R81qHYSf
	D1nJiv/tO/mQV/YQsKLmWIPB8lGgoYeHY/9KEe4cxcfgvxF3owdAIA1dHqRcHDDtRGhAmjR32fW
	CTT7y+dXGpTxHWTKZ5scYaggjcjtd6VyuFb9Z8JP4QtNPbTpoKvP4u7sv9pTj0ePke5UgFoFj5f
	hH/KqEUNqSYtAeHHn76UF
X-Google-Smtp-Source: AGHT+IFVBvBkG/jh2Rp7uVAkD5gcecmAVteBF0APe6UMpjV6H7GDTaGroyBGSDV4aKB2Dawtk+lY6g==
X-Received: by 2002:a05:600c:4694:b0:440:94a2:95b8 with SMTP id 5b1f17b1804b1-442d6d6b65fmr94946245e9.16.1746994408557;
        Sun, 11 May 2025 13:13:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm100615165e9.19.2025.05.11.13.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:13:28 -0700 (PDT)
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next PATCH v4 05/11] net: pcs: implement Firmware node support for PCS driver
Date: Sun, 11 May 2025 22:12:31 +0200
Message-ID: <20250511201250.3789083-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511201250.3789083-1-ansuelsmth@gmail.com>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
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

The consumer will then use fwnode_pcs_get() to get the actual PCS by
passing the firmware node pointer and the index for #pcs-cells.

For a simple implementation where #pcs-cells is 0 and the PCS driver
expose a single PCS, the xlate function fwnode_pcs_simple_get() is
provided.

For an advanced implementation a custom xlate function is required.

One removal the PCS driver should first delete itself from the provider
list using fwnode_pcs_del_provider() and then call phylink_release_pcs()
on every PCS the driver provides.

A generic function fwnode_phylink_pcs_parse() is provided for MAC driver
that will declare PCS in DT (or ACPI).
This function will parse "pcs-handle" property and fill the passed array
with the parsed PCS in availabel_pcs up to the passed num_pcs value.
It's also possible to pass NULL as array to only parse the PCS and
update the num_pcs value with the count of scanned PCS.

Co-developed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/pcs/Kconfig          |   6 +
 drivers/net/pcs/Makefile         |   1 +
 drivers/net/pcs/pcs.c            | 201 +++++++++++++++++++++++++++++++
 include/linux/pcs/pcs-provider.h |  41 +++++++
 include/linux/pcs/pcs.h          |  56 +++++++++
 5 files changed, 305 insertions(+)
 create mode 100644 drivers/net/pcs/pcs.c
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index f6aa437473de..0d54bea1f663 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -5,6 +5,12 @@
 
 menu "PCS device drivers"
 
+config FWNODE_PCS
+	tristate
+	depends on (ACPI || OF)
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
index 000000000000..26d07a2edfce
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
+	int ret;
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
index 000000000000..ae51c108147e
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
+ * Returns: the PCS pointed by data.
+ */
+struct phylink_pcs *fwnode_pcs_simple_get(struct fwnode_reference_args *pcsspec,
+					  void *data);
+
+/**
+ * fwnode_pcs_add_provider - Registers a new PCS provider
+ * @fwnode: Firmware node
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
+ * Returns: 0 on success or -ENOMEM on allocation failure.
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
index 000000000000..33244e3a442b
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
+ * Returns: a pointer to the phylink_pcs or a negative
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
+ * Returns: 0 or a negative error.
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


