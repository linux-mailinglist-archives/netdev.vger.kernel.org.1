Return-Path: <netdev+bounces-276631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP5fHA6E1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:36:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A53E3BEE8B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8E78300F164
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65DF3D3487;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqnmxbKx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0803D2FF5;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666185; cv=none; b=QfKAM0Q8SzsgThptXEdZN+vgN9p7LUEZqgw4cogc0n4082vaW9JHD2xWM2GTCNWPuuVptXkUFkgc2uXw6WBmT9oXTenaDqeY+0OhwekxBRocJEg2vJv5q6pZLPsD4l2QB1TvB+THXhQcSL/cJdaLMv+op+KhqTc0bRm4kldaROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666185; c=relaxed/simple;
	bh=qoiuiRACX+7fyGd6PmgsS4FBGmhMwOSqH3IFoLmmOYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/5ouNkeLsOcq+3BT8+zAWJznJkPGq0v2QQPts/Z7BK3OcjXs/68j76zWYfy18KON3ceBqGyyrPD2hmMK1+SY3DNT0HqkedoRXRx0+P2Qwhm7rj9B780SmV172cyw29mNvRSul/Rymt0sZy0IXIJYfng+lodVX9BTa8WXAMJ3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqnmxbKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18291C4AF09;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666185;
	bh=qoiuiRACX+7fyGd6PmgsS4FBGmhMwOSqH3IFoLmmOYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RqnmxbKxbqQdjFQb8msExMkBSPfmPBmNnQb7Ez6k4P7hAKL7hKRudixFmBkbLqKlW
	 8Aaofvq1eDsQ+bhREAcBxieArl6WDIDB29aQ6rOytd8ICCmOTQIZJpBVqFwxvUHBpA
	 fx5cuGfmcPttZq5DpXDTyXDfO5LVpyI1074JvN0WYW8d5fS6Fbap1dEKSiYEmx2Edx
	 O4s7v8pdYTupBZSbAgVwqPCCpd29rWpxJMQxrr60orYytQ+KlyT47amXrTtiBG/FNX
	 kwoBKyw5E3AgGIPSU73QR3OG4M75y157xPKs6/YKJ8TqMgbpfsDa0kGxtVJTtC6eQS
	 OuHjYvhLUTPAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0807B10F995F;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 08 Apr 2026 09:36:24 -0700
Subject: [PATCH net-next v3 03/10] enic: add admin RQ buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-enic-sriov-v2-admin-channel-v2-v3-3-1d4999a03cec@cisco.com>
References: <20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com>
In-Reply-To: <20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775666183; l=3638;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZMpfBevBZMtAG95G26rzqtWY0Kge40y6XyZgAR1yrjY=;
 b=LW1+bNDAAE4y2+I/QO9emCChFXz5nSJHEwsBGAN3YsCGUpeeTmPiRogh5nGg2B/d1rMVLZb/C
 +so4rMkB1iwCfVgeeIkiHOjhoxnyKbwRG1rRUvdj7pzCj6dbZBv804i
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276631-lists,netdev=lfdr.de,satishkh.cisco.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A53E3BEE8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

The admin receive queue needs pre-posted DMA buffers for incoming
mailbox messages from VFs. Each buffer is a kmalloc'd region mapped
for DMA (2048 bytes, sufficient for any MBOX message).

Add enic_admin_rq_fill() to post buffers at open time, and
enic_admin_rq_drain() to unmap and free them at close time.
Wire both into the admin channel open/close paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_admin.c | 66 +++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index d1abe6a50095..a8fcd5f116d1 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -23,10 +24,63 @@ static void enic_admin_wq_buf_clean(struct vnic_wq *wq,
 {
 }
 
-/* No-op: admin RQ buffer teardown is handled in enic_admin_channel_close */
 static void enic_admin_rq_buf_clean(struct vnic_rq *rq,
 				    struct vnic_rq_buf *buf)
 {
+	struct enic *enic = vnic_dev_priv(rq->vdev);
+
+	if (!buf->os_buf)
+		return;
+
+	dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
+			 DMA_FROM_DEVICE);
+	kfree(buf->os_buf);
+	buf->os_buf = NULL;
+}
+
+static int enic_admin_rq_post_one(struct enic *enic)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	struct rq_enet_desc *desc;
+	dma_addr_t dma_addr;
+	void *buf;
+
+	buf = kmalloc(ENIC_ADMIN_BUF_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	dma_addr = dma_map_single(&enic->pdev->dev, buf, ENIC_ADMIN_BUF_SIZE,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(&enic->pdev->dev, dma_addr)) {
+		kfree(buf);
+		return -ENOMEM;
+	}
+
+	desc = vnic_rq_next_desc(rq);
+	rq_enet_desc_enc(desc, (u64)dma_addr | VNIC_PADDR_TARGET,
+			 RQ_ENET_TYPE_ONLY_SOP, ENIC_ADMIN_BUF_SIZE);
+	vnic_rq_post(rq, buf, 0, dma_addr, ENIC_ADMIN_BUF_SIZE, 0);
+
+	return 0;
+}
+
+static int enic_admin_rq_fill(struct enic *enic)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	int err;
+
+	while (vnic_rq_desc_avail(rq) > 0) {
+		err = enic_admin_rq_post_one(enic);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void enic_admin_rq_drain(struct enic *enic)
+{
+	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
 }
 
 static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
@@ -138,6 +192,13 @@ int enic_admin_channel_open(struct enic *enic)
 	vnic_wq_enable(&enic->admin_wq);
 	vnic_rq_enable(&enic->admin_rq);
 
+	err = enic_admin_rq_fill(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to fill admin RQ buffers: %d\n", err);
+		goto disable_queues;
+	}
+
 	err = enic_admin_qp_type_set(enic, 1);
 	if (err) {
 		netdev_err(enic->netdev,
@@ -151,6 +212,7 @@ int enic_admin_channel_open(struct enic *enic)
 	vnic_wq_disable(&enic->admin_wq);
 	vnic_rq_disable(&enic->admin_rq);
 	enic_admin_qp_type_set(enic, 0);
+	enic_admin_rq_drain(enic);
 	enic_admin_free_resources(enic);
 	return err;
 }
@@ -166,7 +228,7 @@ void enic_admin_channel_close(struct enic *enic)
 	enic_admin_qp_type_set(enic, 0);
 
 	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
-	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	vnic_intr_clean(&enic->admin_intr);

-- 
2.43.0



