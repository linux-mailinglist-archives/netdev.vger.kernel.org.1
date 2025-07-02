Return-Path: <netdev+bounces-203498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF796AF629D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694394868D3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4E2BE65B;
	Wed,  2 Jul 2025 19:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047382BE654;
	Wed,  2 Jul 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484475; cv=none; b=ok9hFyMcC6Ncks7EiscFdjGvhEnrm4b12989yD7qrrnCgnRnVeCQvo8SsvTJOHOiEyTpKKWWjYGc9BMBqlov7dhQb0V2DtqaT/syffOEnMPy22BrUVO4NV6lmpg+Z4a7bacvdUssndhy7RSMPoQNaWKRL5eHSniK/H4gJdDNkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484475; c=relaxed/simple;
	bh=UDEOnODcQ0m+DPqLV7SWa5FiyuiV2KQLIAWVwGyX7kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajzK4RkiSkqkRCSk4jZNk0PVfd7a3swwVC3DEvB/VRk9oeaUlU7rOAO/0j+FxMzC1sxa2RJxt9oFmJtCxDdPMiugG9yE91p3RIgxCQPSmAUHJZ5QJeGSGQZIbtCqQw8PN3iHP+1qfETUF1t6ln4gIEp4bi8N4oZqWv9dumIvPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uX37S-00081M-2y; Wed, 02 Jul 2025 19:27:46 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 3/6] eth: fbnic: Create ring buffer for firmware logs
Date: Wed,  2 Jul 2025 12:12:09 -0700
Message-ID: <20250702192207.697368-4-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702192207.697368-1-lee@trager.us>
References: <20250702192207.697368-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabled, firmware may send logs messages which are specific to the
device and not the host. Create a ring buffer to store these messages
which are read by a user through DebugFS. Buffer access is protected by
a spinlock.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +
 .../net/ethernet/meta/fbnic/fbnic_fw_log.c    | 95 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_fw_log.h    | 43 +++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 0dbc634adb4b..15e8ff649615 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -12,6 +12,7 @@ fbnic-y := fbnic_csr.o \
 	   fbnic_devlink.o \
 	   fbnic_ethtool.o \
 	   fbnic_fw.o \
+	   fbnic_fw_log.o \
 	   fbnic_hw_stats.o \
 	   fbnic_hwmon.o \
 	   fbnic_irq.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 65815d4f379e..c376e06880c9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -12,6 +12,7 @@

 #include "fbnic_csr.h"
 #include "fbnic_fw.h"
+#include "fbnic_fw_log.h"
 #include "fbnic_hw_stats.h"
 #include "fbnic_mac.h"
 #include "fbnic_rpc.h"
@@ -85,6 +86,8 @@ struct fbnic_dev {

 	/* Lock protecting access to hw_stats */
 	spinlock_t hw_stats_lock;
+
+	struct fbnic_fw_log fw_log;
 };

 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
new file mode 100644
index 000000000000..caedbe7844f7
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/spinlock.h>
+#include <linux/vmalloc.h>
+
+#include "fbnic.h"
+#include "fbnic_fw.h"
+#include "fbnic_fw_log.h"
+
+int fbnic_fw_log_init(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_log *log = &fbd->fw_log;
+	void *data;
+
+	if (WARN_ON_ONCE(fbnic_fw_log_ready(fbd)))
+		return -EEXIST;
+
+	data = vmalloc(FBNIC_FW_LOG_SIZE);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&fbd->fw_log.lock);
+	INIT_LIST_HEAD(&log->entries);
+	log->size = FBNIC_FW_LOG_SIZE;
+	log->data_start = data;
+	log->data_end = data + FBNIC_FW_LOG_SIZE;
+
+	return 0;
+}
+
+void fbnic_fw_log_free(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_log *log = &fbd->fw_log;
+
+	if (!fbnic_fw_log_ready(fbd))
+		return;
+
+	INIT_LIST_HEAD(&log->entries);
+	log->size = 0;
+	vfree(log->data_start);
+	log->data_start = NULL;
+	log->data_end = NULL;
+}
+
+int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
+		       char *msg)
+{
+	struct fbnic_fw_log_entry *entry, *head, *tail, *next;
+	struct fbnic_fw_log *log = &fbd->fw_log;
+	size_t msg_len = strlen(msg) + 1;
+	unsigned long flags;
+	void *entry_end;
+
+	if (!fbnic_fw_log_ready(fbd)) {
+		dev_err(fbd->dev, "Firmware sent log entry without being requested!\n");
+		return -ENOSPC;
+	}
+
+	spin_lock_irqsave(&log->lock, flags);
+
+	if (list_empty(&log->entries)) {
+		entry = log->data_start;
+	} else {
+		head = list_first_entry(&log->entries, typeof(*head), list);
+		entry = (struct fbnic_fw_log_entry *)&head->msg[head->len + 1];
+		entry = PTR_ALIGN(entry, 8);
+	}
+
+	entry_end = &entry->msg[msg_len + 1];
+
+	/* We've reached the end of the buffer, wrap around */
+	if (entry_end > log->data_end) {
+		entry = log->data_start;
+		entry_end = &entry->msg[msg_len + 1];
+	}
+
+	/* Make room for entry by removing from tail. */
+	list_for_each_entry_safe_reverse(tail, next, &log->entries, list) {
+		if (entry <= tail && entry_end > (void *)tail)
+			list_del(&tail->list);
+		else
+			break;
+	}
+
+	entry->index = index;
+	entry->timestamp = timestamp;
+	entry->len = msg_len;
+	strscpy(entry->msg, msg, entry->len);
+	list_add(&entry->list, &log->entries);
+
+	spin_unlock_irqrestore(&log->lock, flags);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
new file mode 100644
index 000000000000..881ee298ede7
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_FW_LOG_H_
+#define _FBNIC_FW_LOG_H_
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/* A 512K log buffer was chosen fairly arbitrarily */
+#define FBNIC_FW_LOG_SIZE	(512 * 1024) /* bytes */
+
+/* Firmware log output is prepended with log index followed by a timestamp.
+ * The timestamp is similar to Zephyr's format DD:HH:MM:SS.MMM
+ */
+#define FBNIC_FW_LOG_FMT	"[%5lld] [%02ld:%02ld:%02ld:%02ld.%03ld] %s\n"
+
+struct fbnic_dev;
+
+struct fbnic_fw_log_entry {
+	struct list_head	list;
+	u64			index;
+	u32			timestamp;
+	u16			len;
+	char			msg[] __counted_by(len);
+};
+
+struct fbnic_fw_log {
+	void			*data_start;
+	void			*data_end;
+	size_t			size;
+	struct list_head	entries;
+	/* Spin lock for accessing or modifying entries */
+	spinlock_t		lock;
+};
+
+#define fbnic_fw_log_ready(_fbd)	(!!(_fbd)->fw_log.data_start)
+
+int fbnic_fw_log_init(struct fbnic_dev *fbd);
+void fbnic_fw_log_free(struct fbnic_dev *fbd);
+int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
+		       char *msg);
+#endif /* _FBNIC_FW_LOG_H_ */
--
2.47.1

