Return-Path: <netdev+bounces-284552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGwQNk03+mnHKwMAu9opvQ
	(envelope-from <netdev+bounces-284552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1A4D2AE2
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3309A3036C08
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0F4BC01D;
	Tue,  5 May 2026 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRCftYSR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2D4ADD8B
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005657; cv=none; b=M/OZG6CfWtThZZZycf4Ev6ax464Fg9A14fcGRBKM/RkOmRVCNYMO4lU4I1pXT7nwah0OWWMvDZHZG46mQ3OoWrOisS8fG9wIHFGvM3ZNO2MzRrnmsg/M7/oHytU2s92U8FJN6vY70wzi+zsRDikXDJqE3P+7hrOfd1T0aB4KS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005657; c=relaxed/simple;
	bh=owcC2WxU1UqQ6RQMKX3UIbzmNCGMf11dFJT3ooomHFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeVQfNdfG2L7OLpUm/eQGEv4GFsdSPUXZCyDBHnO2t0l53kdmwn70Sb3T90t6D2nGF6zc/wkMuRUeLnzOWqnsOsR7csRFkISU7GqHgZDoWIWKrP6OAt1P3ISkS2+caKB7n5I/v7Qy4t0Gx2YWgmOEv4XoTOr73BKB7VmK1pXKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRCftYSR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so53522135e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005653; x=1778610453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAD1tSXVXvetA0OgqYwIYs8Rwpx95WrbUTX9PyXaD48=;
        b=DRCftYSRcG+aSwMvW84BR7sBjELLkqSvGcsW5Vm7vWJBMPiHpg+YUdLa+ogdtRswqN
         Qkpz8GSev0mB7jfAKn7oiawF+X0UiEYUz/we7fYUuol90ThCtsg2VDiR1bwxoSFNOE6f
         86a9D9fg6yW3ID+0C0wgvjwYwCzXJDkCksGl4dmyltYOLJwm50P7IzOL/kCmW+jVoGl/
         VEsdTKjQifFzi9ZRZn0qZByNyxrtcMsWBL66/CCCh5dCVIbuMz2BvCYmB1winpN4OXg5
         Gp9DnzKYmbt+lXUTyg5h1SjkxCZ9HpdcVsrVpq2Q670BufNp/ZzeEHvGsb+sshRYwx96
         ZcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005653; x=1778610453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XAD1tSXVXvetA0OgqYwIYs8Rwpx95WrbUTX9PyXaD48=;
        b=Wza++gxYUr4qj7zQ8/XMqMX4kT2O9DcV+/BQFe4g5EWX+lbxfJIByCQbtE5S1rmFOB
         E2cdTgx1wDCyauVDS5D0T/TwedUC2MyHxUd0LwPpx50Vc00eh0Q7aNqyq8KsVJIgXB7b
         YGir3Pupm3j7Se7e9Mwsa1B0LoRF04Jrkx3eVgtGuT7ebzGZ6GHGqReg3Cb+fvTrZMBB
         ZZxw2+0IUuaJmvVIOWpgIcXoLWYE1fcpwfuCOfqSMOVbn4xW8UgLhwJeNwNI49E2M7iX
         iBc/4iuUl75ZDngkfOS5jqvnyc3rsJWurf+KF34ErBHMdcUUtJNne1bg/H2wL5papEsZ
         KszQ==
X-Forwarded-Encrypted: i=1; AFNElJ94Ea3F7dye+bWhhwLk/j9FLjcx3G7LfKTQU+Wmp4aVBld7CKXjLhIYbwCwzqvUBZNbUqzQ4FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjauPOy7hTY2nQOgdUvN4eBihqjq0bROlZY59w3Bx0UCIJEit
	VBTg+ZFLj5beBlTP0AaFxvaQBsCFyUNG1ZdKOcaIYEZuzP9W+24UOb/l
X-Gm-Gg: AeBDies4Tj/5XZUl9ixRZkbJDZPPMwDR/uy2bb51DT+f3QXz8CCvxXOwgLy1+53AJlZ
	EdfhoaNO1uWnUS9dYTB4/gDoT0vSJlQmhyeRY68oPTYtyGET0hjSdMhYySb4I+zl1x/D7sCVGJw
	7OMMZ7b2NLthAhP7i+fj9RGrbnehGirCGJ7xGYnS6QDOzw4fk2csI8FjseD3qGZbaM1HNVwgELB
	mjJjdsQze2UUfvCMRc3kC6eSfYxJZGS/tMg/GspLvICqQZfGQ0Fep76f5NXWybZ18rhJuQYyW65
	8jGeH7KfyhK69FdnIlqSdQxAqu4iyfWazK8qAOOuMW57LojsmJo/vWw0ckRPc8s3azIbYMGJEgl
	/OSdAiIlv6dqPHlMvAwH0BVhpDWQEZVZYVKbkfVBxsr8fNzi3rufHZLzWbc9MGtzSVZHeumLKZP
	OiyogO6R8euh0cikjJHLonajEeCSLpbezyxObR+JqZrhnnbZWuVAZabgyJJA2qCCJJyQzKvW7ce
	J8t3m8=
X-Received: by 2002:a05:600c:6290:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48e51f3fd58mr6560235e9.20.1778005652833;
        Tue, 05 May 2026 11:27:32 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-59-227-65.retail.telecomitalia.it. [82.59.227.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm408208245e9.5.2026.05.05.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:32 -0700 (PDT)
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
Subject: [net-next RFC PATCH v5 04/10] net: pcs: implement Firmware node support for PCS driver
Date: Tue,  5 May 2026 20:27:05 +0200
Message-ID: <20260505182713.27644-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505182713.27644-1-ansuelsmth@gmail.com>
References: <20260505182713.27644-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AA1A4D2AE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284552-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,makrotopia.org:email]

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
with the parsed PCS in available_pcs up to the passed num_pcs value.
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
index e417fd66f660..874de743b22c 100644
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
index 000000000000..72f56f55d198
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
+	pp = kzalloc_obj(*pp);
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
+	struct phylink_pcs *pcs = ERR_PTR(-ENODEV);
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
2.53.0


