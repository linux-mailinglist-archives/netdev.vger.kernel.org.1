Return-Path: <netdev+bounces-217906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76881B3A645
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729FA7B80FD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2AD322A3E;
	Thu, 28 Aug 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwTuymrI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CDE322A3D
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398600; cv=none; b=quUA1CoYGw71BYUPza17r2dKJ6NAlqMoHVGb4A7pR1chVd+h+7P6nj1VnudGn2IF2kEX8lSJHi6dK3kExkKXAlT2DS1dVXHKOIdCEOaBHy52VJD5Z5gkgyVMmggrzqntvpqLtBgPbe7kkQFo8bGv54ivPliWky2WC5Zeu7p6H0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398600; c=relaxed/simple;
	bh=/zNu5MvUIB5E4km3h0nlQnHOK2Gwhz+HzMr0Slyeof0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auzCrl3bAE1wsdxTGYq+T2Jl8KjI14YEIr4AIoAhoMDno8qON6ELf8ZFvAV+ld7+a6vYlR/16Kjg7fhNo0Z6W5ulW+tW7/JyNsKdI1wLmwtyHNr3umssv5ZU8PRE10ZGaeWXE8/ENC2vVqDw5/HYH/SaFvZ/oMPx4/xqlXqSAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwTuymrI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e970acf352fso564138276.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398597; x=1757003397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqz1xYZVRIniT4Az8ANEOTb4KR6gVfg3aaDQy8uhN2Q=;
        b=lwTuymrIaNQF/rWPXTfJZBsiAZ0CyT46BMtltCAn45tbhFwie61ZLxvi9+JOwSa+ji
         MgOMwMZoqkxiTymLoiL66RtF6ayLHO7YE/Zho1sJBCptaDuMUt9mD8Yh/cI9HBjUTQH7
         Faz5Xsh+7rLOTVq6WCsDqvoJECjfmS16Bj/Tx5afWGWxow/xSGNGaE7AQTs9kwLgu8HX
         rrwZIdsBzbL+rIBZNPNGEr02kmFz83TsAtHu+mICb85mo/5SKPIKvTwXAYMQQZ5SZdHu
         UYp55Avwkh8LyRDp0Nz+1UVGrBChkBloCAxZBK+PHkrAz4ZnRm/5p1yfeiQYEjn7JsWv
         xrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398597; x=1757003397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqz1xYZVRIniT4Az8ANEOTb4KR6gVfg3aaDQy8uhN2Q=;
        b=in+a8xuur30glvtOfcFCBbT/hSiAfjjNFalJVrjTku6yXOlXlF/P8fAgBhH1Zj0GMW
         2+pfclXRsZHVSEKgkYEtQrDHq3ic97GuiRGpnGrkTCyBCdMO7MJGD3ctp+vJFRciPiuA
         v6sXpSaQO9uZN8Bslpt/LEWB+TwLDpjBn5rJRSy2vYkRdI3Oi7csgI+S65+jx3h+V+dY
         l0aViCgUF9AEAzm0/AS8w5Jyj4ckmFWPYNJdmx3MCjR+He2Qr4M1HhesEOlbRxO/a/2w
         0SrKDNiSSUXoEM8B1RObOiJaOGBaz/0Yyha46lMVSEuARN5EnuF9I932ddUn3k7qaEal
         TDhA==
X-Forwarded-Encrypted: i=1; AJvYcCURJELF+dcDf74f3VcF0sC5afujdxGSYcFnmk6/oilKcIm/Ufw7ZTgDtoa7bfGQOjGZCDQbVkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXhZyEENoD6CCkPPMDD0W5WpvypBlSk7TtX77NQyQQ8kPn717
	w1HplJw/nAAu2i5R4JBNbphGPpEzqDDzGmYFw+5JMoM53ZejsSFtvMyH
X-Gm-Gg: ASbGnctScKnqW7erseae4J8YZ3ddjeDizWdrMNKgNWqWu+y+DQHYquvjzUa00W5K0n4
	3ftKdZmj/lBuOenoHTqbQMrPuz0zzyQeA4QqW7E/ncyw+GUCQoK/MDFCIggn6Efx2eG0R1whwSs
	ZDw5tzwV/h3y5gvxgKNugLhOmFQvxBlPxPVKzd1AOLK2IBWuCdx6Du+SHJ+0I56LIFTKrS8QMiO
	yxGHHrdZ59lfehH43/rhceCxdkv4osjV2J3Cm0HGQQ0e6D/b2zBv+MFu0d/xRbqLdxiAuieKXQO
	PnCIeNIy3bkHtsfqFlW+p096j651TZukxVboKcmCdWIgx+aufcCzzGgl/WcG0mlGmVJAn+eCngi
	GjunD/ysXTOQTvOyPlhUx
X-Google-Smtp-Source: AGHT+IGZIhORP1rHOKu/G5EQXwKRrSpXvOMYoPqFl7i8PGLYhca3XJNJSB6j4pxbe11AvXus6wR0Gw==
X-Received: by 2002:a05:690c:7286:b0:71c:bf3:afb0 with SMTP id 00721157ae682-71fdc412548mr246652377b3.40.1756398596976;
        Thu, 28 Aug 2025 09:29:56 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721c6372ec9sm476947b3.29.2025.08.28.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:29:56 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v10 02/19] psp: base PSP device support
Date: Thu, 28 Aug 2025 09:29:28 -0700
Message-ID: <20250828162953.2707727-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add a netlink family for PSP and allow drivers to register support.

The "PSP device" is its own object. This allows us to perform more
flexible reference counting / lifetime control than if PSP information
was part of net_device. In the future we should also be able
to "delegate" PSP access to software devices, such as *vlan, veth
or netkit more easily.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v7:
    - add comment explaining use of xa_store()/xa_erase() in
      psp_dev_unregister()/psp_dev_destroy().
    v4:
    - remove unused PSP_KEY_V0/PSP_KEY_V1 defines
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-3-kuba@kernel.org/

 Documentation/netlink/specs/psp.yaml |  96 ++++++++++++
 include/linux/netdevice.h            |   4 +
 include/net/psp.h                    |  12 ++
 include/net/psp/functions.h          |  14 ++
 include/net/psp/types.h              | 100 ++++++++++++
 include/uapi/linux/psp.h             |  42 +++++
 net/Kconfig                          |   1 +
 net/Makefile                         |   1 +
 net/psp/Kconfig                      |  13 ++
 net/psp/Makefile                     |   5 +
 net/psp/psp-nl-gen.c                 |  65 ++++++++
 net/psp/psp-nl-gen.h                 |  30 ++++
 net/psp/psp.h                        |  31 ++++
 net/psp/psp_main.c                   | 139 +++++++++++++++++
 net/psp/psp_nl.c                     | 223 +++++++++++++++++++++++++++
 tools/net/ynl/Makefile.deps          |   1 +
 16 files changed, 777 insertions(+)
 create mode 100644 Documentation/netlink/specs/psp.yaml
 create mode 100644 include/net/psp.h
 create mode 100644 include/net/psp/functions.h
 create mode 100644 include/net/psp/types.h
 create mode 100644 include/uapi/linux/psp.h
 create mode 100644 net/psp/Kconfig
 create mode 100644 net/psp/Makefile
 create mode 100644 net/psp/psp-nl-gen.c
 create mode 100644 net/psp/psp-nl-gen.h
 create mode 100644 net/psp/psp.h
 create mode 100644 net/psp/psp_main.c
 create mode 100644 net/psp/psp_nl.c

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
new file mode 100644
index 000000000000..706f4baf8764
--- /dev/null
+++ b/Documentation/netlink/specs/psp.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: psp
+
+doc:
+  PSP Security Protocol Generic Netlink family.
+
+definitions:
+  -
+    type: enum
+    name: version
+    entries: [hdr0-aes-gcm-128, hdr0-aes-gcm-256,
+              hdr0-aes-gmac-128, hdr0-aes-gmac-256]
+
+attribute-sets:
+  -
+    name: dev
+    attributes:
+      -
+        name: id
+        doc: PSP device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: ifindex
+        doc: ifindex of the main netdevice linked to the PSP device.
+        type: u32
+      -
+        name: psp-versions-cap
+        doc: Bitmask of PSP versions supported by the device.
+        type: u32
+        enum: version
+        enum-as-flags: true
+      -
+        name: psp-versions-ena
+        doc: Bitmask of currently enabled (accepted on Rx) PSP versions.
+        type: u32
+        enum: version
+        enum-as-flags: true
+
+operations:
+  list:
+    -
+      name: dev-get
+      doc: Get / dump information about PSP capable devices on the system.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+        reply: &dev-all
+          attributes:
+            - id
+            - ifindex
+            - psp-versions-cap
+            - psp-versions-ena
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+      dump:
+        reply: *dev-all
+    -
+      name: dev-add-ntf
+      doc: Notification about device appearing.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: dev-del-ntf
+      doc: Notification about device disappearing.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: dev-set
+      doc: Set the configuration of a PSP device.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+            - psp-versions-ena
+        reply:
+          attributes: []
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+    -
+      name: dev-change-ntf
+      doc: Notification about device configuration being changed.
+      notify: dev-get
+      mcgrp: mgmt
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
+
+...
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb..4eb22268143c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1906,6 +1906,7 @@ enum netdev_reg_state {
  *			 device struct
  *	@mpls_ptr:	mpls_dev struct pointer
  *	@mctp_ptr:	MCTP specific data
+ *	@psp_dev:	PSP crypto device registered for this netdev
  *
  *	@dev_addr:	Hw address (before bcast,
  *			because most packets are unicast)
@@ -2310,6 +2311,9 @@ struct net_device {
 #if IS_ENABLED(CONFIG_MCTP)
 	struct mctp_dev __rcu	*mctp_ptr;
 #endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_dev __rcu	*psp_dev;
+#endif
 
 /*
  * Cache lines mostly used on receive path (including eth_type_trans())
diff --git a/include/net/psp.h b/include/net/psp.h
new file mode 100644
index 000000000000..33bb4d1dc46e
--- /dev/null
+++ b/include/net/psp.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __NET_PSP_ALL_H
+#define __NET_PSP_ALL_H
+
+#include <uapi/linux/psp.h>
+#include <net/psp/functions.h>
+#include <net/psp/types.h>
+
+/* Do not add any code here. Put it in the sub-headers instead. */
+
+#endif /* __NET_PSP_ALL_H */
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
new file mode 100644
index 000000000000..074f9df9afc3
--- /dev/null
+++ b/include/net/psp/functions.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __NET_PSP_HELPERS_H
+#define __NET_PSP_HELPERS_H
+
+#include <net/psp/types.h>
+
+/* Driver-facing API */
+struct psp_dev *
+psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
+	       struct psp_dev_caps *psd_caps, void *priv_ptr);
+void psp_dev_unregister(struct psp_dev *psd);
+
+#endif /* __NET_PSP_HELPERS_H */
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
new file mode 100644
index 000000000000..d242b1ecee7d
--- /dev/null
+++ b/include/net/psp/types.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __NET_PSP_H
+#define __NET_PSP_H
+
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+
+struct netlink_ext_ack;
+
+#define PSP_DEFAULT_UDP_PORT	1000
+
+struct psphdr {
+	u8	nexthdr;
+	u8	hdrlen;
+	u8	crypt_offset;
+	u8	verfl;
+	__be32	spi;
+	__be64	iv;
+	__be64	vc[]; /* optional */
+};
+
+#define PSP_SPI_KEY_ID		GENMASK(30, 0)
+#define PSP_SPI_KEY_PHASE	BIT(31)
+
+#define PSPHDR_CRYPT_OFFSET	GENMASK(5, 0)
+
+#define PSPHDR_VERFL_SAMPLE	BIT(7)
+#define PSPHDR_VERFL_DROP	BIT(6)
+#define PSPHDR_VERFL_VERSION	GENMASK(5, 2)
+#define PSPHDR_VERFL_VIRT	BIT(1)
+#define PSPHDR_VERFL_ONE	BIT(0)
+
+#define PSP_HDRLEN_NOOPT	((sizeof(struct psphdr) - 8) / 8)
+
+/**
+ * struct psp_dev_config - PSP device configuration
+ * @versions: PSP versions enabled on the device
+ */
+struct psp_dev_config {
+	u32 versions;
+};
+
+/**
+ * struct psp_dev - PSP device struct
+ * @main_netdev: original netdevice of this PSP device
+ * @ops:	driver callbacks
+ * @caps:	device capabilities
+ * @drv_priv:	driver priv pointer
+ * @lock:	instance lock, protects all fields
+ * @refcnt:	reference count for the instance
+ * @id:		instance id
+ * @config:	current device configuration
+ *
+ * @rcu:	RCU head for freeing the structure
+ */
+struct psp_dev {
+	struct net_device *main_netdev;
+
+	struct psp_dev_ops *ops;
+	struct psp_dev_caps *caps;
+	void *drv_priv;
+
+	struct mutex lock;
+	refcount_t refcnt;
+
+	u32 id;
+
+	struct psp_dev_config config;
+
+	struct rcu_head rcu;
+};
+
+/**
+ * struct psp_dev_caps - PSP device capabilities
+ */
+struct psp_dev_caps {
+	/**
+	 * @versions: mask of supported PSP versions
+	 * Set this field to 0 to indicate PSP is not supported at all.
+	 */
+	u32 versions;
+};
+
+#define PSP_MAX_KEY	32
+
+/**
+ * struct psp_dev_ops - netdev driver facing PSP callbacks
+ */
+struct psp_dev_ops {
+	/**
+	 * @set_config: set configuration of a PSP device
+	 * Driver can inspect @psd->config for the previous configuration.
+	 * Core will update @psd->config with @config on success.
+	 */
+	int (*set_config)(struct psp_dev *psd, struct psp_dev_config *conf,
+			  struct netlink_ext_ack *extack);
+};
+
+#endif /* __NET_PSP_H */
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
new file mode 100644
index 000000000000..4a404f085190
--- /dev/null
+++ b/include/uapi/linux/psp.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/psp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_PSP_H
+#define _UAPI_LINUX_PSP_H
+
+#define PSP_FAMILY_NAME		"psp"
+#define PSP_FAMILY_VERSION	1
+
+enum psp_version {
+	PSP_VERSION_HDR0_AES_GCM_128,
+	PSP_VERSION_HDR0_AES_GCM_256,
+	PSP_VERSION_HDR0_AES_GMAC_128,
+	PSP_VERSION_HDR0_AES_GMAC_256,
+};
+
+enum {
+	PSP_A_DEV_ID = 1,
+	PSP_A_DEV_IFINDEX,
+	PSP_A_DEV_PSP_VERSIONS_CAP,
+	PSP_A_DEV_PSP_VERSIONS_ENA,
+
+	__PSP_A_DEV_MAX,
+	PSP_A_DEV_MAX = (__PSP_A_DEV_MAX - 1)
+};
+
+enum {
+	PSP_CMD_DEV_GET = 1,
+	PSP_CMD_DEV_ADD_NTF,
+	PSP_CMD_DEV_DEL_NTF,
+	PSP_CMD_DEV_SET,
+	PSP_CMD_DEV_CHANGE_NTF,
+
+	__PSP_CMD_MAX,
+	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
+};
+
+#define PSP_MCGRP_MGMT	"mgmt"
+
+#endif /* _UAPI_LINUX_PSP_H */
diff --git a/net/Kconfig b/net/Kconfig
index d5865cf19799..4b563aea4c23 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -82,6 +82,7 @@ config NET_CRC32C
 menu "Networking options"
 
 source "net/packet/Kconfig"
+source "net/psp/Kconfig"
 source "net/unix/Kconfig"
 source "net/tls/Kconfig"
 source "net/xfrm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index aac960c41db6..90e3d72bf58b 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_INET)		+= ipv4/
 obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
 obj-$(CONFIG_UNIX)		+= unix/
+obj-$(CONFIG_INET_PSP)		+= psp/
 obj-y				+= ipv6/
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
diff --git a/net/psp/Kconfig b/net/psp/Kconfig
new file mode 100644
index 000000000000..55f9dd87446b
--- /dev/null
+++ b/net/psp/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# PSP configuration
+#
+config INET_PSP
+	bool "PSP Security Protocol support"
+	depends on INET
+	help
+	Enable kernel support for the PSP protocol.
+	For more information see:
+	  https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
+
+	If unsure, say N.
diff --git a/net/psp/Makefile b/net/psp/Makefile
new file mode 100644
index 000000000000..41b51d06e560
--- /dev/null
+++ b/net/psp/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_INET_PSP) += psp.o
+
+psp-y := psp_main.o psp_nl.o psp-nl-gen.o
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
new file mode 100644
index 000000000000..859712e7c2c1
--- /dev/null
+++ b/net/psp/psp-nl-gen.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/psp.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "psp-nl-gen.h"
+
+#include <uapi/linux/psp.h>
+
+/* PSP_CMD_DEV_GET - do */
+static const struct nla_policy psp_dev_get_nl_policy[PSP_A_DEV_ID + 1] = {
+	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
+/* PSP_CMD_DEV_SET - do */
+static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_PSP_VERSIONS_ENA + 1] = {
+	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+	[PSP_A_DEV_PSP_VERSIONS_ENA] = NLA_POLICY_MASK(NLA_U32, 0xf),
+};
+
+/* Ops table for psp */
+static const struct genl_split_ops psp_nl_ops[] = {
+	{
+		.cmd		= PSP_CMD_DEV_GET,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_dev_get_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_dev_get_nl_policy,
+		.maxattr	= PSP_A_DEV_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= PSP_CMD_DEV_GET,
+		.dumpit	= psp_nl_dev_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= PSP_CMD_DEV_SET,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_dev_set_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_dev_set_nl_policy,
+		.maxattr	= PSP_A_DEV_PSP_VERSIONS_ENA,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group psp_nl_mcgrps[] = {
+	[PSP_NLGRP_MGMT] = { "mgmt", },
+};
+
+struct genl_family psp_nl_family __ro_after_init = {
+	.name		= PSP_FAMILY_NAME,
+	.version	= PSP_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= psp_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(psp_nl_ops),
+	.mcgrps		= psp_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(psp_nl_mcgrps),
+};
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
new file mode 100644
index 000000000000..a099686cab5d
--- /dev/null
+++ b/net/psp/psp-nl-gen.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/psp.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_PSP_GEN_H
+#define _LINUX_PSP_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/psp.h>
+
+int psp_device_get_locked(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info);
+void
+psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
+		  struct genl_info *info);
+
+int psp_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	PSP_NLGRP_MGMT,
+};
+
+extern struct genl_family psp_nl_family;
+
+#endif /* _LINUX_PSP_GEN_H */
diff --git a/net/psp/psp.h b/net/psp/psp.h
new file mode 100644
index 000000000000..94d0cc31a61f
--- /dev/null
+++ b/net/psp/psp.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __PSP_PSP_H
+#define __PSP_PSP_H
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <net/netns/generic.h>
+#include <net/psp.h>
+#include <net/sock.h>
+
+extern struct xarray psp_devs;
+extern struct mutex psp_devs_lock;
+
+void psp_dev_destroy(struct psp_dev *psd);
+int psp_dev_check_access(struct psp_dev *psd, struct net *net);
+
+void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
+
+static inline void psp_dev_get(struct psp_dev *psd)
+{
+	refcount_inc(&psd->refcnt);
+}
+
+static inline void psp_dev_put(struct psp_dev *psd)
+{
+	if (refcount_dec_and_test(&psd->refcnt))
+		psp_dev_destroy(psd);
+}
+
+#endif /* __PSP_PSP_H */
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
new file mode 100644
index 000000000000..e09499b7b14a
--- /dev/null
+++ b/net/psp/psp_main.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/list.h>
+#include <linux/netdevice.h>
+#include <linux/xarray.h>
+#include <net/net_namespace.h>
+#include <net/psp.h>
+
+#include "psp.h"
+#include "psp-nl-gen.h"
+
+DEFINE_XARRAY_ALLOC1(psp_devs);
+struct mutex psp_devs_lock;
+
+/**
+ * DOC: PSP locking
+ *
+ * psp_devs_lock protects the psp_devs xarray.
+ * Ordering is take the psp_devs_lock and then the instance lock.
+ * Each instance is protected by RCU, and has a refcount.
+ * When driver unregisters the instance gets flushed, but struct sticks around.
+ */
+
+/**
+ * psp_dev_check_access() - check if user in a given net ns can access PSP dev
+ * @psd:	PSP device structure user is trying to access
+ * @net:	net namespace user is in
+ *
+ * Return: 0 if PSP device should be visible in @net, errno otherwise.
+ */
+int psp_dev_check_access(struct psp_dev *psd, struct net *net)
+{
+	if (dev_net(psd->main_netdev) == net)
+		return 0;
+	return -ENOENT;
+}
+
+/**
+ * psp_dev_create() - create and register PSP device
+ * @netdev:	main netdevice
+ * @psd_ops:	driver callbacks
+ * @psd_caps:	device capabilities
+ * @priv_ptr:	back-pointer to driver private data
+ *
+ * Return: pointer to allocated PSP device, or ERR_PTR.
+ */
+struct psp_dev *
+psp_dev_create(struct net_device *netdev,
+	       struct psp_dev_ops *psd_ops, struct psp_dev_caps *psd_caps,
+	       void *priv_ptr)
+{
+	struct psp_dev *psd;
+	static u32 last_id;
+	int err;
+
+	if (WARN_ON(!psd_caps->versions ||
+		    !psd_ops->set_config))
+		return ERR_PTR(-EINVAL);
+
+	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
+	if (!psd)
+		return ERR_PTR(-ENOMEM);
+
+	psd->main_netdev = netdev;
+	psd->ops = psd_ops;
+	psd->caps = psd_caps;
+	psd->drv_priv = priv_ptr;
+
+	mutex_init(&psd->lock);
+	refcount_set(&psd->refcnt, 1);
+
+	mutex_lock(&psp_devs_lock);
+	err = xa_alloc_cyclic(&psp_devs, &psd->id, psd, xa_limit_16b,
+			      &last_id, GFP_KERNEL);
+	if (err) {
+		mutex_unlock(&psp_devs_lock);
+		kfree(psd);
+		return ERR_PTR(err);
+	}
+	mutex_lock(&psd->lock);
+	mutex_unlock(&psp_devs_lock);
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_ADD_NTF);
+
+	rcu_assign_pointer(netdev->psp_dev, psd);
+
+	mutex_unlock(&psd->lock);
+
+	return psd;
+}
+EXPORT_SYMBOL(psp_dev_create);
+
+void psp_dev_destroy(struct psp_dev *psd)
+{
+	mutex_lock(&psp_devs_lock);
+	xa_erase(&psp_devs, psd->id);
+	mutex_unlock(&psp_devs_lock);
+
+	mutex_destroy(&psd->lock);
+	kfree_rcu(psd, rcu);
+}
+
+/**
+ * psp_dev_unregister() - unregister PSP device
+ * @psd:	PSP device structure
+ */
+void psp_dev_unregister(struct psp_dev *psd)
+{
+	mutex_lock(&psp_devs_lock);
+	mutex_lock(&psd->lock);
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_DEL_NTF);
+
+	/* Wait until psp_dev_destroy() to call xa_erase() to prevent a
+	 * different psd from being added to the xarray with this id, while
+	 * there are still references to this psd being held.
+	 */
+	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);
+	mutex_unlock(&psp_devs_lock);
+
+	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
+
+	psd->ops = NULL;
+	psd->drv_priv = NULL;
+
+	mutex_unlock(&psd->lock);
+
+	psp_dev_put(psd);
+}
+EXPORT_SYMBOL(psp_dev_unregister);
+
+static int __init psp_init(void)
+{
+	mutex_init(&psp_devs_lock);
+
+	return genl_register_family(&psp_nl_family);
+}
+
+subsys_initcall(psp_init);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
new file mode 100644
index 000000000000..fda5ce800f82
--- /dev/null
+++ b/net/psp/psp_nl.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/skbuff.h>
+#include <linux/xarray.h>
+#include <net/genetlink.h>
+#include <net/psp.h>
+#include <net/sock.h>
+
+#include "psp-nl-gen.h"
+#include "psp.h"
+
+/* Netlink helpers */
+
+static struct sk_buff *psp_nl_reply_new(struct genl_info *info)
+{
+	struct sk_buff *rsp;
+	void *hdr;
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return NULL;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		nlmsg_free(rsp);
+		return NULL;
+	}
+
+	return rsp;
+}
+
+static int psp_nl_reply_send(struct sk_buff *rsp, struct genl_info *info)
+{
+	/* Note that this *only* works with a single message per skb! */
+	nlmsg_end(rsp, (struct nlmsghdr *)rsp->data);
+
+	return genlmsg_reply(rsp, info);
+}
+
+/* Device stuff */
+
+static struct psp_dev *
+psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
+{
+	struct psp_dev *psd;
+	int err;
+
+	mutex_lock(&psp_devs_lock);
+	psd = xa_load(&psp_devs, nla_get_u32(dev_id));
+	if (!psd) {
+		mutex_unlock(&psp_devs_lock);
+		return ERR_PTR(-ENODEV);
+	}
+
+	mutex_lock(&psd->lock);
+	mutex_unlock(&psp_devs_lock);
+
+	err = psp_dev_check_access(psd, net);
+	if (err) {
+		mutex_unlock(&psd->lock);
+		return ERR_PTR(err);
+	}
+
+	return psd;
+}
+
+int psp_device_get_locked(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info)
+{
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_ID))
+		return -EINVAL;
+
+	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
+						    info->attrs[PSP_A_DEV_ID]);
+	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
+}
+
+void
+psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
+		  struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+
+	mutex_unlock(&psd->lock);
+}
+
+static int
+psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
+		const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(rsp, PSP_A_DEV_ID, psd->id) ||
+	    nla_put_u32(rsp, PSP_A_DEV_IFINDEX, psd->main_netdev->ifindex) ||
+	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_CAP, psd->caps->versions) ||
+	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions))
+		goto err_cancel_msg;
+
+	genlmsg_end(rsp, hdr);
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
+void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd)
+{
+	struct genl_info info;
+	struct sk_buff *ntf;
+
+	if (!genl_has_listeners(&psp_nl_family, dev_net(psd->main_netdev),
+				PSP_NLGRP_MGMT))
+		return;
+
+	ntf = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	genl_info_init_ntf(&info, &psp_nl_family, cmd);
+	if (psp_nl_dev_fill(psd, ntf, &info)) {
+		nlmsg_free(ntf);
+		return;
+	}
+
+	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
+				0, PSP_NLGRP_MGMT, GFP_KERNEL);
+}
+
+int psp_nl_dev_get_doit(struct sk_buff *req, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int err;
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	err = psp_nl_dev_fill(psd, rsp, info);
+	if (err)
+		goto err_free_msg;
+
+	return genlmsg_reply(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+	return err;
+}
+
+static int
+psp_nl_dev_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
+			  struct psp_dev *psd)
+{
+	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+		return 0;
+
+	return psp_nl_dev_fill(psd, rsp, genl_info_dump(cb));
+}
+
+int psp_nl_dev_get_dumpit(struct sk_buff *rsp, struct netlink_callback *cb)
+{
+	struct psp_dev *psd;
+	int err = 0;
+
+	mutex_lock(&psp_devs_lock);
+	xa_for_each_start(&psp_devs, cb->args[0], psd, cb->args[0]) {
+		mutex_lock(&psd->lock);
+		err = psp_nl_dev_get_dumpit_one(rsp, cb, psd);
+		mutex_unlock(&psd->lock);
+		if (err)
+			break;
+	}
+	mutex_unlock(&psp_devs_lock);
+
+	return err;
+}
+
+int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct psp_dev_config new_config;
+	struct sk_buff *rsp;
+	int err;
+
+	memcpy(&new_config, &psd->config, sizeof(new_config));
+
+	if (info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]) {
+		new_config.versions =
+			nla_get_u32(info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]);
+		if (new_config.versions & ~psd->caps->versions) {
+			NL_SET_ERR_MSG(info->extack, "Requested PSP versions not supported by the device");
+			return -EINVAL;
+		}
+	} else {
+		NL_SET_ERR_MSG(info->extack, "No settings present");
+		return -EINVAL;
+	}
+
+	rsp = psp_nl_reply_new(info);
+	if (!rsp)
+		return -ENOMEM;
+
+	if (memcmp(&new_config, &psd->config, sizeof(new_config))) {
+		err = psd->ops->set_config(psd, &new_config, info->extack);
+		if (err)
+			goto err_free_rsp;
+
+		memcpy(&psd->config, &new_config, sizeof(new_config));
+	}
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
+
+	return psp_nl_reply_send(rsp, info);
+
+err_free_rsp:
+	nlmsg_free(rsp);
+	return err;
+}
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 90686e241157..865fd2e8519e 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -31,6 +31,7 @@ CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN_H,ovpn.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_psp:=$(call get_hdr_inc,_LINUX_PSP_H,psp.h)
 CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
 CFLAGS_rt-link:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
-- 
2.47.3


