Return-Path: <netdev+bounces-28037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D677E114
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1175D2819E0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FB9107B6;
	Wed, 16 Aug 2023 12:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFA107AD
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:06:27 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FF72132
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:06:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id B735B21959;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692187583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQqYYIOb8vWqxiQHbz2yDg7e1e95gSKNG15/a5Zrh7U=;
	b=n1uFttfZcOCPK0dzVqs0CQCriPSF0+kYg0gTIBJb1FziMwJx48bpy8apjzgC7umNH0VHVf
	kxQ1hNIO+5gxogeS4rdvW8pyid83iwIrXAPZmJ4ikSvEYCAtHQ6tzKrG+KT15pNvr+/PWB
	L3aotSxflqym9zxYH2UHRHv7vU0xkxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692187583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQqYYIOb8vWqxiQHbz2yDg7e1e95gSKNG15/a5Zrh7U=;
	b=cA/A+RkfwHg0k7yiFX0UJ8RRRoaJL8CgqF5as1AS9QvIaV16it5COr++2Vt0H5sF2WL0Ve
	L9mqoRsZiaV6AiBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 8E1C12C146;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 7CBFC51CB21E; Wed, 16 Aug 2023 14:06:23 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/18] nvme-keyring: register '.nvme' keyring
Date: Wed, 16 Aug 2023 14:05:51 +0200
Message-Id: <20230816120608.37135-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816120608.37135-1-hare@suse.de>
References: <20230816120608.37135-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Register a '.nvme' keyring to hold keys for TLS and DH-HMAC-CHAP and
add a new config option NVME_KEYRING.
We need a separate keyring for NVMe as the configuration is done
via individual commands (eg for configfs), and the usual per-session
or per-process keyrings can't be used.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/Kconfig   |  4 ++++
 drivers/nvme/common/Makefile  |  3 ++-
 drivers/nvme/common/keyring.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      | 10 +++++++--
 include/linux/nvme-keyring.h  | 28 ++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 4514f44362dd..641b27adb047 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -2,3 +2,7 @@
 
 config NVME_COMMON
        tristate
+
+config NVME_KEYRING
+       bool
+       select KEYS
diff --git a/drivers/nvme/common/Makefile b/drivers/nvme/common/Makefile
index 720c625b8a52..0cbd0b0b8d49 100644
--- a/drivers/nvme/common/Makefile
+++ b/drivers/nvme/common/Makefile
@@ -4,4 +4,5 @@ ccflags-y			+= -I$(src)
 
 obj-$(CONFIG_NVME_COMMON)	+= nvme-common.o
 
-nvme-common-y			+= auth.o
+nvme-common-$(CONFIG_NVME_AUTH)	+= auth.o
+nvme-common-$(CONFIG_NVME_KEYRING) += keyring.o
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
new file mode 100644
index 000000000000..5cf64b278119
--- /dev/null
+++ b/drivers/nvme/common/keyring.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Hannes Reinecke, SUSE Labs
+ */
+
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/key-type.h>
+#include <keys/user-type.h>
+#include <linux/nvme.h>
+
+static struct key *nvme_keyring;
+
+key_serial_t nvme_keyring_id(void)
+{
+	return nvme_keyring->serial;
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_id);
+
+int nvme_keyring_init(void)
+{
+	nvme_keyring = keyring_alloc(".nvme",
+				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				     current_cred(),
+				     (KEY_POS_ALL & ~KEY_POS_SETATTR) |
+				     (KEY_USR_ALL & ~KEY_USR_SETATTR),
+				     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+	if (IS_ERR(nvme_keyring))
+		return PTR_ERR(nvme_keyring);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_init);
+
+void nvme_keyring_exit(void)
+{
+	key_revoke(nvme_keyring);
+	key_put(nvme_keyring);
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_exit);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa746662..dfc574d0f18d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -25,6 +25,7 @@
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -4703,12 +4704,16 @@ static int __init nvme_core_init(void)
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-
-	result = nvme_init_auth();
+	result = nvme_keyring_init();
 	if (result)
 		goto destroy_ns_chr;
+	result = nvme_init_auth();
+	if (result)
+		goto keyring_exit;
 	return 0;
 
+keyring_exit:
+	nvme_keyring_exit();
 destroy_ns_chr:
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
@@ -4732,6 +4737,7 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
+	nvme_keyring_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
new file mode 100644
index 000000000000..32bd264a71e6
--- /dev/null
+++ b/include/linux/nvme-keyring.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Hannes Reinecke, SUSE Labs
+ */
+
+#ifndef _NVME_KEYRING_H
+#define _NVME_KEYRING_H
+
+#ifdef CONFIG_NVME_KEYRING
+
+key_serial_t nvme_keyring_id(void);
+int nvme_keyring_init(void);
+void nvme_keyring_exit(void);
+
+#else
+
+static inline key_serial_t nvme_keyring_id(void)
+{
+	return 0;
+}
+static inline int nvme_keyring_init(void)
+{
+	return 0;
+}
+static inline void nvme_keyring_exit(void) {}
+
+#endif /* !CONFIG_NVME_KEYRING */
+#endif /* _NVME_KEYRING_H */
-- 
2.35.3


