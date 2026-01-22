Return-Path: <netdev+bounces-252117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MQZGMF0cWm3HAAAu9opvQ
	(envelope-from <netdev+bounces-252117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 288F660170
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 388FA3C4C4F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE331062D;
	Thu, 22 Jan 2026 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kaf+/pTM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74230F95C
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043092; cv=none; b=mxTlqyuQUOeYJn7tMuIkeCK699FrMBl1T+A/BOYiFJFsABRKGWsXNgomJQnI37Rlu7yS1M7WJA5HfWApIJLRATwk162pu9SSXfjjNApprk0m7GsAl2Jj8qZb9eX+KQGZHB1zXAgluAi5lcvPZSmlNkR6HpKuqDznPfzRIdsjKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043092; c=relaxed/simple;
	bh=FNDgyEhm+AU9JDVxt+AiV1JIWAuwLh7ctfHIDZGsBp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc4BwaVTKv/oG4TumXeIQ0p3Wchtsi94BuaKDUkXutIqWCrvr/dvEErc5Cxm6If/ECdMorRjlJ+hpnq0dmnq2N3uB0v5Ubxw4VpHXMDD3nUxsnzSyYsUR6/MIGuH4Ee51dszv+TLqSwPtonqLfFB+AF50AAPwo/1lEW+U8CSL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kaf+/pTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CA9C19425;
	Thu, 22 Jan 2026 00:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043092;
	bh=FNDgyEhm+AU9JDVxt+AiV1JIWAuwLh7ctfHIDZGsBp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kaf+/pTM4tBmu1B/kylh/mJ1nZ+m64qm6jj65DYbPIhksFy00/SWmSuVJZ7ksywuF
	 kvjWkjKPr0UPOxXHBQZyt9dU+y9f86cu+upLtekVvBnhHjwlR67iUOy6SXE9bbtyqa
	 /QdTj/YwdrOviKZdNY3CZBJS8Z4WZKxeQlaQblwKHUAazOwW9LWZkIwaxHpUIYzjDw
	 sOH7Qw72fnhCOF63brUr3jJGp08eAYvcjFUvnLOYc0Udm3BWX63vMudrKWbz6yxoa4
	 AamZ13N4LK6KDHwCLz1Vg1PG1dnbT6E8n75KtDJ3UvC9Z1ue71v/Cw+D+YXvc0lITH
	 r5cJm0NWp4Zeg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/6] net: introduce a trivial netdev_queue_config()
Date: Wed, 21 Jan 2026 16:51:09 -0800
Message-ID: <20260122005113.2476634-3-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122005113.2476634-1-kuba@kernel.org>
References: <20260122005113.2476634-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,nvidia.com,gmail.com,davidwei.uk,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252117-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 288F660170
X-Rspamd-Action: no action

We may choose to extend or reimplement the logic which renders
the per-queue config. The drivers should not poke directly into
the queue state. Add a helper for drivers to use when they want
to query the config for a specific queue.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/Makefile                         |  1 +
 include/net/netdev_queues.h               |  3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  6 ++---
 net/core/netdev_config.c                  | 32 +++++++++++++++++++++++
 4 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 net/core/netdev_config.c

diff --git a/net/core/Makefile b/net/core/Makefile
index 9ef2099c5426..d643a5a7fd18 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
 obj-y += hotdata.o
+obj-y += netdev_config.o
 obj-y += netdev_rx_queue.o
 obj-y += netdev_queues.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 2ab3eae8e8c3..725bf69ef86c 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -170,6 +170,9 @@ struct netdev_queue_mgmt_ops {
 	unsigned int supported_params;
 };
 
+void netdev_queue_config(struct net_device *dev, int rxq,
+			 struct netdev_queue_config *qcfg);
+
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
 
 /**
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0b95100a7c36..d57e833ce690 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4326,12 +4326,12 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
+		struct netdev_queue_config qcfg;
 		struct bnxt_ring_mem_info *rmem;
 		struct bnxt_cp_ring_info *cpr;
 		struct bnxt_rx_ring_info *rxr;
 		struct bnxt_tx_ring_info *txr;
 		struct bnxt_ring_struct *ring;
-		struct netdev_rx_queue *rxq;
 
 		if (!bnapi)
 			continue;
@@ -4349,8 +4349,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
-		rxq = __netif_get_rx_queue(bp->dev, i);
-		rxr->rx_page_size = rxq->qcfg.rx_page_size;
+		netdev_queue_config(bp->dev, i, &qcfg);
+		rxr->rx_page_size = qcfg.rx_page_size;
 
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
new file mode 100644
index 000000000000..562087bd30c8
--- /dev/null
+++ b/net/core/netdev_config.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/netdevice.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+
+/**
+ * netdev_queue_config() - get configuration for a given queue
+ * @dev:      net_device instance
+ * @rxq_idx:  index of the queue of interest
+ * @qcfg: queue configuration struct (output)
+ *
+ * Render the configuration for a given queue. This helper should be used
+ * by drivers which support queue configuration to retrieve config for
+ * a particular queue.
+ *
+ * @qcfg is an output parameter and is always fully initialized by this
+ * function. Some values may not be set by the user, drivers may either
+ * deal with the "unset" values in @qcfg, or provide the callback
+ * to populate defaults in queue_management_ops.
+ */
+void netdev_queue_config(struct net_device *dev, int rxq_idx,
+			 struct netdev_queue_config *qcfg)
+{
+	struct netdev_queue_config *stored;
+
+	memset(qcfg, 0, sizeof(*qcfg));
+
+	stored = &__netif_get_rx_queue(dev, rxq_idx)->qcfg;
+	qcfg->rx_page_size = stored->rx_page_size;
+}
+EXPORT_SYMBOL(netdev_queue_config);
-- 
2.52.0


