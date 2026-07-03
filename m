Return-Path: <netdev+bounces-304648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NR8RLGj8R2o8igAAu9opvQ
	(envelope-from <netdev+bounces-304648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:16:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E126704D1E
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:16:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=JpIMrUhf;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304648-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304648-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0825D30388B0
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE18313543;
	Fri,  3 Jul 2026 18:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B9A30E829;
	Fri,  3 Jul 2026 18:10:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102208; cv=none; b=sPwI0kQCSK91w7z/+PZCFYHj9GJt8c96+EEHir7JeEFy9Sqq82FJ32uKW7n83+FNznNZ7TLImReOynz97P+jrO0dlUVhogJozPFtokVJWmCXiVokygBlID94HnLY+yjpBZ/C13ZyClc7GwUKi3B/PzGhB3Y222fTWzRJTgkmoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102208; c=relaxed/simple;
	bh=CNyyNpBKXvdWxQ+JKqXEuJWhIy34HxDBjCH+Kpt0yts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8s5t8kFlA30bC4Am1oN3ZDtIihEEGHBDvkK8CmzkDo7rCZANvwlcBEIRgkJSWLrDGGxTSHBlBca3TYnQzyN7BaswQjXxINhwgWZfeAaVVGuYJ8Pm5c2uzYBUCUvzbDL+Ap/Uz0PTtOMuUNACXIXToD3rPjiLfbsMZBptYoAulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=JpIMrUhf; arc=none smtp.client-ip=173.37.86.78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11545; q=dns/txt;
  s=iport01; t=1783102207; x=1784311807;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Sorf0jTZuFVvTbMwN7h92xT9arsCuGLeYoqT+B2G15s=;
  b=JpIMrUhfb40a3kdhJdm+hufMEACtI2/5zw+K5RrNMZBLVNmOVlEQeJP0
   NK9UPLJcxI66oWdc5Gu0d22E+jdZJiPONcPKa+yJZ7vyWBgdVJVO5bgjQ
   c3sT4BMmBtTNOaHPW8AUt/R9TgVtybaNOVAG42vgvkBQt+FiXzcts6/SI
   a1vF970+e+kPJO0Wt6eCa/XYdkTH7Md/9KEkm66UPIwtvRenUmHPd3mdE
   F6sFn+2SiuEGxIemcWVhZx2g03W7+4Wv9ScZd9mOJt0IkVJQxV2A+7m41
   f9f1kh19qAjmVI1hpjZDmahdJ1BB4dTtd9t8j/RoArxB5W73LgiuMAR3T
   Q==;
X-CSE-ConnectionGUID: D6Y+mnLESza6inMAT69qYQ==
X-CSE-MsgGUID: QE4U5nq+SEuamwn9Mg53mQ==
X-IPAS-Result: =?us-ascii?q?A0AmAABV+Udq/5P/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBUkNJhFeIHIc3giGeHhSBag8BAQEPUQQBAYUGAo1LAiY0CQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESg?=
 =?us-ascii?q?wKCdAO8BXp/M4EBhH3ZRoFmAQsUAYEKLgGFcIJqAYFwhAY7hEEnG4FJRIEUA?=
 =?us-ascii?q?YNphAUBBBULg3SCagSDHBKBeI8nCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSE?=
 =?us-ascii?q?hgVAhQvDwQWMh1wDCcSLBc0WBsHBYEdgRUxBCGBBIR5Ix8DOX+BMHVKeTOBA?=
 =?us-ascii?q?gESHgqBUoEmAwsYDUgRLDcGDhsEPQFuB40AFw+BNRdxWTUBTW+BIRwskmAIg?=
 =?us-ascii?q?3aNX2uBNZ9ahCeBZqAPATKXZ5MFmQgjo0luhGiBaDyBWTMaCBsVgyJTGQ+OK?=
 =?us-ascii?q?gMW0jonMj0CBwIHDgMLkWgRF4FVAQE?=
IronPort-Data: A9a23:mIoDe6Ll0aiAzLmXFE+REZQlxSXFcZb7ZxGr2PjKsXjdYENS32NUy
 TcZUTyGafyOa2PyctAgao6yphxV6sDQndZqGQod+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnQ0
 T/Oi5eHYgH9hGYvajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1CUnB1OIs8191lCD9P8
 9kxFG5cdyG60rfeLLKTEoGAh+w5J8XteYdasXZ6wHSAVbAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEuojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeC2YIaOI4HaLSlTtn+1+
 l+b+X26OTwHPdmAz2ug/S/3g9aayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasvQMWUvJTHvc85QXLzbDbiy6QAGQeQyECbtE6uMIobTg30
 FnPlNOBLSRmurCTSFqH+7uUpC/0Mi8QRUcGZCkZXU4G7sPlrYUbkB3CVJBgHbSzg9mzHiv/q
 xiMoTQyiqs7k8EGzeO48ErBjjbqoYLGJjPZ/S3NVW6jqwc8b4m/asnxsR7Q7O1LK8CSSVzpU
 GU4pvVyJdsmVfml/BFhis1UdF11z55p6AHhvGM=
IronPort-HdrOrdr: A9a23:PwaOeamE3ZBf7Wqkdai331W+9ePpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: 9a23:bPKFfWOGmbuSgu5DdHdWt0sSPu0eYHSDzXH1CnPmWH9YcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AZgOHkA1DPpOlaBrYdRUCeN3nejUj2onyNR0LiNY?=
 =?us-ascii?q?9ltSNMDN2ahKS0W+ye9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="503843158"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:08:57 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 29C1018000A6D;
	Fri,  3 Jul 2026 18:08:57 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:08:52 -0700
Subject: [PATCH net-next v11 03/12] enic: add admin channel open and close
 for SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-3-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=11940;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=CNyyNpBKXvdWxQ+JKqXEuJWhIy34HxDBjCH+Kpt0yts=;
 b=tRam1Q/PQvNkLWyFDq4gCUBisZG6PG34gcM2+UJqmRt2WP0Vtb8qGKKseSZvqJq1GfkbDxWEV
 iuKWEK4rBrgB0GHi8ta+I8I6JhyT72dY40bhrq7z0F/C3+Ywap1SlsU
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304648-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E126704D1E

The V2 SR-IOV design uses a dedicated admin channel (WQ/RQ/CQ/INTR
on separate BAR resources) for PF-VF mailbox communication rather
than firmware-proxied devcmds.

Introduce enic_admin_channel_open() and enic_admin_channel_close().
Open allocates and initialises the admin WQ, RQ, and two CQs (one per
direction), then issues CMD_QP_TYPE_SET to tell firmware the queues are
admin-type. Close reverses the sequence.

enic_admin_wq_buf_clean() unmaps and frees any WQ buffers still held
at close time, fixing a DMA mapping leak when a send times out.

Add CMD_QP_TYPE_SET (97), QP_TYPE_ADMIN/DATA, and QP_ENABLE/QP_DISABLE
defines to vnic_devcmd.h. Add VNIC_CQ_* named constants to vnic_cq.h
so CQ initialisation parameters are self-documenting from their first
introduction.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |   5 +
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 227 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_cq.h     |   9 +
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  11 ++
 6 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/Makefile b/drivers/net/ethernet/cisco/enic/Makefile
index a96b8332e6e2..7ae72fefc99a 100644
--- a/drivers/net/ethernet/cisco/enic/Makefile
+++ b/drivers/net/ethernet/cisco/enic/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_ENIC) := enic.o
 
 enic-y := enic_main.o vnic_cq.o vnic_intr.o vnic_wq.o \
 	enic_res.o enic_dev.o enic_pp.o vnic_dev.o vnic_rq.o vnic_vic.o \
-	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o
+	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o \
+	enic_admin.o
 
diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 08472420f3a1..398227448b37 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -292,6 +292,11 @@ struct enic {
 
 	/* Admin channel resources for SR-IOV MBOX */
 	bool has_admin_channel;
+	/* true only while the admin WQ/RQ/CQ are allocated and enabled; gates
+	 * enic_admin_channel_close() so it is a no-op after a failed (re)open
+	 * left the resources freed.
+	 */
+	bool admin_chan_up;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
new file mode 100644
index 000000000000..50b46b92c88f
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+#include "vnic_rq.h"
+#include "vnic_cq.h"
+#include "vnic_intr.h"
+#include "vnic_resource.h"
+#include "vnic_devcmd.h"
+#include "enic.h"
+#include "enic_admin.h"
+#include "cq_desc.h"
+#include "wq_enet_desc.h"
+#include "rq_enet_desc.h"
+
+/* Clean up any admin WQ buffers still held by hardware at close time.
+ * Normally buffers are freed inline after send completion, but a timed-out
+ * send intentionally leaves the buffer live until the queue is stopped.
+ */
+static void enic_admin_wq_buf_clean(struct vnic_wq *wq,
+				    struct vnic_wq_buf *buf)
+{
+	struct enic *enic = vnic_dev_priv(wq->vdev);
+
+	if (buf->os_buf) {
+		dma_unmap_single(&enic->pdev->dev, buf->dma_addr,
+				 buf->len, DMA_TO_DEVICE);
+		kfree(buf->os_buf);
+		buf->os_buf = NULL;
+	}
+}
+
+/* No-op: admin RQ buffer teardown is handled in enic_admin_channel_close */
+static void enic_admin_rq_buf_clean(struct vnic_rq *rq,
+				    struct vnic_rq_buf *buf)
+{
+}
+
+static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
+{
+	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
+	int wait = 1000;
+	int err;
+
+	spin_lock_bh(&enic->devcmd_lock);
+	err = vnic_dev_cmd(enic->vdev, CMD_QP_TYPE_SET, &a0, &a1, wait);
+	spin_unlock_bh(&enic->devcmd_lock);
+
+	return err;
+}
+
+static int enic_admin_alloc_resources(struct enic *enic)
+{
+	int err;
+
+	err = vnic_wq_alloc_with_type(enic->vdev, &enic->admin_wq, 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct wq_enet_desc),
+				      RES_TYPE_ADMIN_WQ);
+	if (err)
+		return err;
+
+	err = vnic_rq_alloc_with_type(enic->vdev, &enic->admin_rq, 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct rq_enet_desc),
+				      RES_TYPE_ADMIN_RQ);
+	if (err)
+		goto free_wq;
+
+	/* admin_cq[0] is the WQ completion queue.  WQ CQEs are always
+	 * 16 bytes wide; firmware always writes 16-byte CQEs for WQ
+	 * completions on every WQ, including the admin channel WQ.
+	 * Use sizeof(struct cq_desc) accordingly.
+	 */
+	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[0], 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct cq_desc),
+				      RES_TYPE_ADMIN_CQ);
+	if (err)
+		goto free_rq;
+
+	/* admin_cq[1] is the RQ completion queue.  Its descriptor size
+	 * must match what firmware writes.  enic_ext_cq() called earlier
+	 * in probe issues CMD_CQ_ENTRY_SIZE_SET for VNIC_RQ_ALL,
+	 * programming firmware to write CQ entries of (16 << enic->ext_cq)
+	 * bytes for every RQ CQ on the vNIC, including the admin RQ CQ.
+	 * Allocating with the same size keeps the host poller and
+	 * firmware in lockstep:
+	 *
+	 *   - The color/valid bit lives at byte (desc_size - 1) of every
+	 *     cq_enet_rq_desc[_32|_64] variant, so enic_admin_cq_color()
+	 *     reads it from the correct offset.
+	 *   - Only the first 15 bytes of the descriptor (vlan,
+	 *     bytes_written_flags, ...) are accessed by the admin path;
+	 *     these fields are identical across all three variants (see
+	 *     comment in enic_rq.c above cq_enet_rq_desc_dec()).
+	 */
+	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[1], 1,
+				      ENIC_ADMIN_DESC_COUNT,
+				      16 << enic->ext_cq,
+				      RES_TYPE_ADMIN_CQ);
+	if (err)
+		goto free_cq0;
+
+	return 0;
+
+free_cq0:
+	vnic_cq_free(&enic->admin_cq[0]);
+free_rq:
+	vnic_rq_free(&enic->admin_rq);
+free_wq:
+	vnic_wq_free(&enic->admin_wq);
+	return err;
+}
+
+static void enic_admin_free_resources(struct enic *enic)
+{
+	vnic_cq_free(&enic->admin_cq[1]);
+	vnic_cq_free(&enic->admin_cq[0]);
+	vnic_rq_free(&enic->admin_rq);
+	vnic_wq_free(&enic->admin_wq);
+}
+
+static void enic_admin_init_resources(struct enic *enic)
+{
+	vnic_wq_init(&enic->admin_wq,
+		     0, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
+	vnic_rq_init(&enic->admin_rq,
+		     1, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
+	vnic_cq_init(&enic->admin_cq[0],
+		     VNIC_CQ_FC_DISABLE,
+		     VNIC_CQ_COLOR_ENABLE,
+		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
+		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_ENTRY_ENABLE,
+		     VNIC_CQ_MSG_DISABLE,
+		     0, /* interrupt_offset */
+		     0 /* cq_message_addr */);
+	vnic_cq_init(&enic->admin_cq[1],
+		     VNIC_CQ_FC_DISABLE,
+		     VNIC_CQ_COLOR_ENABLE,
+		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
+		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_ENTRY_ENABLE,
+		     VNIC_CQ_MSG_DISABLE,
+		     0, /* interrupt_offset */
+		     0 /* cq_message_addr */);
+}
+
+int enic_admin_channel_open(struct enic *enic)
+{
+	int err;
+
+	if (!enic->has_admin_channel)
+		return -ENODEV;
+
+	err = enic_admin_alloc_resources(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to alloc admin channel resources: %d\n",
+			   err);
+		return err;
+	}
+
+	enic_admin_init_resources(enic);
+
+	vnic_wq_enable(&enic->admin_wq);
+	vnic_rq_enable(&enic->admin_rq);
+
+	err = enic_admin_qp_type_set(enic, QP_ENABLE);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to set admin QP type: %d\n", err);
+		goto disable_queues;
+	}
+
+	enic->admin_chan_up = true;
+
+	return 0;
+
+disable_queues:
+	enic_admin_qp_type_set(enic, QP_DISABLE);
+	if (vnic_wq_disable(&enic->admin_wq))
+		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
+	if (vnic_rq_disable(&enic->admin_rq))
+		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
+	enic_admin_free_resources(enic);
+	return err;
+}
+
+void enic_admin_channel_close(struct enic *enic)
+{
+	int err;
+
+	if (!enic->has_admin_channel)
+		return;
+
+	/* Nothing to tear down if the channel was never (re)opened, e.g. a
+	 * failed enic_admin_channel_open() in probe or in the reset path;
+	 * otherwise the disable/clean calls below dereference freed resources.
+	 */
+	if (!enic->admin_chan_up)
+		return;
+
+	enic_admin_qp_type_set(enic, QP_DISABLE);
+
+	err = vnic_wq_disable(&enic->admin_wq);
+	if (err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin WQ: %d\n", err);
+	err = vnic_rq_disable(&enic->admin_rq);
+	if (err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin RQ: %d\n", err);
+
+	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
+	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	vnic_cq_clean(&enic->admin_cq[0]);
+	vnic_cq_clean(&enic->admin_cq[1]);
+	enic_admin_free_resources(enic);
+
+	enic->admin_chan_up = false;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.h b/drivers/net/ethernet/cisco/enic/enic_admin.h
new file mode 100644
index 000000000000..569aadeb9312
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2025 Cisco Systems, Inc.  All rights reserved. */
+
+#ifndef _ENIC_ADMIN_H_
+#define _ENIC_ADMIN_H_
+
+#define ENIC_ADMIN_DESC_COUNT	64
+#define ENIC_ADMIN_BUF_SIZE	2048
+
+struct enic;
+
+int enic_admin_channel_open(struct enic *enic);
+void enic_admin_channel_close(struct enic *enic);
+
+#endif /* _ENIC_ADMIN_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/vnic_cq.h b/drivers/net/ethernet/cisco/enic/vnic_cq.h
index d46d4d2ef6bb..35ffa3230713 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_cq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_cq.h
@@ -76,6 +76,15 @@ int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 int vnic_cq_alloc_with_type(struct vnic_dev *vdev, struct vnic_cq *cq,
 			    unsigned int index, unsigned int desc_count,
 			    unsigned int desc_size, unsigned int res_type);
+#define VNIC_CQ_FC_ENABLE	1
+#define VNIC_CQ_FC_DISABLE	0
+#define VNIC_CQ_COLOR_ENABLE	1
+#define VNIC_CQ_INTR_ENABLE	1
+#define VNIC_CQ_INTR_DISABLE	0
+#define VNIC_CQ_ENTRY_ENABLE	1
+#define VNIC_CQ_MSG_ENABLE	1
+#define VNIC_CQ_MSG_DISABLE	0
+
 void vnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
 	unsigned int color_enable, unsigned int cq_head, unsigned int cq_tail,
 	unsigned int cq_tail_color, unsigned int interrupt_enable,
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 3b6efa743dba..90ca06691ebd 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -455,8 +455,19 @@ enum vnic_devcmd_cmd {
 	 */
 	CMD_CQ_ENTRY_SIZE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 90),
 
+	/*
+	 * Set queue pair type (admin or data)
+	 * in: (u32) a0 = queue pair type (0 = admin, 1 = data)
+	 * in: (u32) a1 = enable (1) / disable (0)
+	 */
+	CMD_QP_TYPE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 97),
 };
 
+#define QP_TYPE_ADMIN	0
+#define QP_TYPE_DATA	1
+#define QP_ENABLE	1
+#define QP_DISABLE	0
+
 /* CMD_ENABLE2 flags */
 #define CMD_ENABLE2_STANDBY 0x0
 #define CMD_ENABLE2_ACTIVE  0x1

-- 
2.43.0


