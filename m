Return-Path: <netdev+bounces-263909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GUsFONbqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:20:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD502041A3
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49A1B335C5E2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BA35E95B;
	Wed,  4 Mar 2026 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ftkhT3Oe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52435E941
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640051; cv=none; b=pO4hdGBLszQM9xO5eR9NlTHBsR6oB6yH+yFUvRXobue9YGq9swFcHf51cvQoZWdkTpkq4zhJeZUxHdQ1DMBGlhJCEuIOUEQF+ACUi+aBz+kT/d4I33X7UQVu5co2/YKpiv2dmM8/qpVD4hrTe8O6WeqX/SsHa2aSvtfv++CMKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640051; c=relaxed/simple;
	bh=iIEcsOfgyoQwnVxTEoJrOmuXhZRHf4VmCFe2BWfUG0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5a5oF5dpKOFv0kVHC45BwVKuSxnqc63BNCTkdy+7KjhOC0MoJvxfbhNknzZCMVvk5rG5eYw5X884RK/seoq/UpXv4iPBORWHM2z3vKEeBmue57bUFvAP1fIO0MMKy8gigUHnfRlLXiHsBGzyOOkQk9VWSPsDH4vkCKbDwE+ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ftkhT3Oe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48379a42f76so58898365e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640048; x=1773244848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNmgU9ASHSR7+2H948CyENoisRrq7nchFqcl7cGshyU=;
        b=ftkhT3OeFhHAf33owxf/YhwRgMLICzVeqazvpP0QrPLaQ3gtmOhem7gNfNfgDo0H56
         19VKp4IAF6XLvhNEmudreQw790iu2yWFhko3uc6sUicgjhxLcxKNC3RLyK4+X2ymlof/
         +vm4OdFV6KHo3lCUvMgu/DoqT3DfV4+FBIhcKdMYVVap/zy4/zdUtKMJWVJiBqQXyqdz
         CuvriifmyubbbbRbqih895MJZiHYoN6EmSWAnEk379SFYq6/tTaUmxrgmwlsWvR3jUnl
         34dDqWa48zo+qJq0Yw1I5QyXOOqPiAubD+9GVLpfJlixGpAmhptUvre3yXa09tgwZqf6
         /oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640048; x=1773244848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNmgU9ASHSR7+2H948CyENoisRrq7nchFqcl7cGshyU=;
        b=Mb4vm2JMMT1unIAENUrfksiT7CnvZdsFLHxuuQfF9vE//tuVQ+SeJcLSRggV65hhRP
         1cKo03KE0CK70qkpQvOVWO/r/KA+X8PQFIvNiE/JUO4RlWsmH9ndqxm4P/kQUpe57TG4
         xKdHiMp3Pbc769tLKxyIS/7RoQzd5bG+97j5ROvLijGGa0dd/j1nhf29ExUJJWMeKeUP
         +jGrkmAUMfLGM4k+w2uvsKq2wW88KSPfXQ8oKE0ykS/TQsqWHjsRn/ZjBWIe6Ra+nA/t
         +B98XNnWAohOaDdZiO5MJF0Ei3HNeL2EJIfdNBZ5QqJz9HdAIvLcy6PqYiy9hM8rOrvy
         q6lg==
X-Gm-Message-State: AOJu0YwqVclCq98ky7pEBxGvB2S/e0EipATn4wcYTD+GlcNa3Qhh4q0z
	scitdQ65SMuj6/S5rnVxSLfvjbZJfFJzaztXs+ttqa5lVDtU2JZyqS4bZdGTij3Fq0eS/VxH2wd
	dfetam4E=
X-Gm-Gg: ATEYQzxbqJm8DsFV0NMh7VRwOCfuPy1DEWhAWeLO4ZFeHtYdimjQ5WKi31r4CsWCWfA
	UQT4j9EYiFLmn2pOTMMY67+ncQMw+3sFEOY4c9oSI1b/9ar3dmU2BsfmlHdgI91GM7th3EP+bs9
	9S+wRKokXL3V5e5Hw4YhvfeqiiXEbfdleMbyeFDk5G8liYamkOTtr2k+m7GmYMATpnQZaEDyuyW
	/HIh8UYt3PZOWsIrqXjSS7EySrKVGk78HrKI9QgzvZ/2btiHn8z6ztlzIISld0IdfDbZYRc811p
	dVSOQvHlWZN7tazh0HbrFj2zKiT6TorsBK7yAH/qnisPYp8QzvHcTKf9pYTOIMo8SdKuRA73kIm
	nNZqOgGZqpvCEGYnqnaDlxU+iLRR30+XWxEJ1oKmMemWBFFkaW+JQsozcPWi8Ruku+UF9JvqH88
	kBjABV/ZFXnOt1jXhjB9yoejbtRl0AP+G2J/M4cbQY61XCDQ==
X-Received: by 2002:a05:600c:620f:b0:47d:885d:d2ff with SMTP id 5b1f17b1804b1-4851989f6bemr42106725e9.29.1772640047786;
        Wed, 04 Mar 2026 08:00:47 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187b7851sm104855645e9.3.2026.03.04.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:47 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v3 11/13] devlink: introduce shared devlink instance for PFs on same chip
Date: Wed,  4 Mar 2026 17:00:20 +0100
Message-ID: <20260304160022.6114-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260304160022.6114-1-jiri@resnulli.us>
References: <20260304160022.6114-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACD502041A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263909-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is no good object to pin the configuration
knobs on.

Introduce a shared devlink instance, instantiated upon probe of
the first PF and removed during remove of the last PF. The shared
devlink instance is not backed by any device device, as there is
no PCI device related to it.

The implementation uses reference counting to manage the lifecycle:
each PF that probes calls devlink_shd_get() to get or create
the shared instance, and calls devlink_shd_put() when it removes.
The shared instance is automatically destroyed when the last PF removes.

Example:

pci/0000:08:00.0: index 0
  nested_devlink:
    auxiliary/mlx5_core.eth.0
devlink_index/1: index 1
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0: index 2
pci/0000:08:00.1: index 3
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1: index 4

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- added __counter_by() for priv
- added *driver arg to devlink_shd_get()
- added ops, priv_size and driver pointer consistency check
v1->v2:
- s/err_kstrdup_id/err_devlink_free/
- fixed kernel-doc comment of devlink_shd_get()
- removed NULL arg check in devlink_shd_get/put()
---
 include/net/devlink.h |   7 ++
 net/devlink/Makefile  |   2 +-
 net/devlink/sh_dev.c  | 161 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 net/devlink/sh_dev.c

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 45dec7067a8e..3038af6ec017 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1647,6 +1647,13 @@ void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size,
+				const struct device_driver *driver);
+void devlink_shd_put(struct devlink *devlink);
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 /**
  * struct devlink_port_ops - Port operations
  * @port_split: Callback used to split the port into multiple ones.
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 000da622116a..8f2adb5e5836 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o rate.o linecard.o
+	 resource.o param.o region.o health.o trap.o rate.o linecard.o sh_dev.o
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
new file mode 100644
index 000000000000..85acce97e788
--- /dev/null
+++ b/net/devlink/sh_dev.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <net/devlink.h>
+
+#include "devl_internal.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created per identifier (e.g., serial number).
+ */
+struct devlink_shd {
+	struct list_head list; /* Node in shd list */
+	const char *id; /* Identifier string (e.g., serial number) */
+	refcount_t refcount; /* Reference count */
+	size_t priv_size; /* Size of driver private data */
+	char priv[] __aligned(NETDEV_ALIGN) __counted_by(priv_size);
+};
+
+static struct devlink_shd *devlink_shd_lookup(const char *id)
+{
+	struct devlink_shd *shd;
+
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->id, id))
+			return shd;
+	}
+
+	return NULL;
+}
+
+static struct devlink_shd *devlink_shd_create(const char *id,
+					      const struct devlink_ops *ops,
+					      size_t priv_size,
+					      const struct device_driver *driver)
+{
+	struct devlink_shd *shd;
+	struct devlink *devlink;
+
+	devlink = __devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
+				  &init_net, NULL, driver);
+	if (!devlink)
+		return NULL;
+	shd = devlink_priv(devlink);
+
+	shd->id = kstrdup(id, GFP_KERNEL);
+	if (!shd->id)
+		goto err_devlink_free;
+	shd->priv_size = priv_size;
+	refcount_set(&shd->refcount, 1);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+
+	list_add_tail(&shd->list, &shd_list);
+
+	return shd;
+
+err_devlink_free:
+	devlink_free(devlink);
+	return NULL;
+}
+
+static void devlink_shd_destroy(struct devlink_shd *shd)
+{
+	struct devlink *devlink = priv_to_devlink(shd);
+
+	list_del(&shd->list);
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	kfree(shd->id);
+	devlink_free(devlink);
+}
+
+/**
+ * devlink_shd_get - Get or create a shared devlink instance
+ * @id: Identifier string (e.g., serial number) for the shared instance
+ * @ops: Devlink operations structure
+ * @priv_size: Size of private data structure
+ * @driver: Driver associated with the shared devlink instance
+ *
+ * Get an existing shared devlink instance identified by @id, or create
+ * a new one if it doesn't exist. Return the devlink instance with a
+ * reference held. The caller must call devlink_shd_put() when done.
+ *
+ * All callers sharing the same @id must pass identical @ops, @priv_size
+ * and @driver. A mismatch triggers a warning and returns NULL.
+ *
+ * Return: Pointer to the shared devlink instance on success,
+ *         NULL on failure
+ */
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size,
+				const struct device_driver *driver)
+{
+	struct devlink *devlink;
+	struct devlink_shd *shd;
+
+	mutex_lock(&shd_mutex);
+
+	shd = devlink_shd_lookup(id);
+	if (!shd) {
+		shd = devlink_shd_create(id, ops, priv_size, driver);
+		goto unlock;
+	}
+
+	devlink = priv_to_devlink(shd);
+	if (WARN_ON_ONCE(devlink->ops != ops ||
+			 shd->priv_size != priv_size ||
+			 devlink->dev_driver != driver)) {
+		shd = NULL;
+		goto unlock;
+	}
+	refcount_inc(&shd->refcount);
+
+unlock:
+	mutex_unlock(&shd_mutex);
+	return shd ? priv_to_devlink(shd) : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get);
+
+/**
+ * devlink_shd_put - Release a reference on a shared devlink instance
+ * @devlink: Shared devlink instance
+ *
+ * Release a reference on a shared devlink instance obtained via
+ * devlink_shd_get().
+ */
+void devlink_shd_put(struct devlink *devlink)
+{
+	struct devlink_shd *shd;
+
+	mutex_lock(&shd_mutex);
+	shd = devlink_priv(devlink);
+	if (refcount_dec_and_test(&shd->refcount))
+		devlink_shd_destroy(shd);
+	mutex_unlock(&shd_mutex);
+}
+EXPORT_SYMBOL_GPL(devlink_shd_put);
+
+/**
+ * devlink_shd_get_priv - Get private data from shared devlink instance
+ * @devlink: Devlink instance
+ *
+ * Returns a pointer to the driver's private data structure within
+ * the shared devlink instance.
+ *
+ * Return: Pointer to private data
+ */
+void *devlink_shd_get_priv(struct devlink *devlink)
+{
+	struct devlink_shd *shd = devlink_priv(devlink);
+
+	return shd->priv;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.51.1


