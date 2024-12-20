Return-Path: <netdev+bounces-153557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570249F8A4C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007871893221
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225B978F40;
	Fri, 20 Dec 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gufcVQTT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3AA70838
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663171; cv=none; b=jMMBbjvcDfsy5QJh6giAA3on9XJADz6qDKRwKdmBqNmKQYGS1DyMVHZHV7eEgR5F44mego4r/t7eIPPflb4/JL79tr2N5Xyx+RPgVB2EJxt68BUoLN+wqFdTLei1qjXIVs3G0DRt1Qc9IdCNCaHnkJHINHeMCJYrCOtPFcvjLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663171; c=relaxed/simple;
	bh=LoeWbBwyxTSrZecZO0b7g1QpNzyCPXlj1DYXGHjXXrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntnpDyFSDktQUDc8NRP1dOhEH0kUPRcGsXKLk8A+ZjdHgTlxnW0Gjt8IhKuTD33CmwONKyuS/SynOwPA6MgYgnYPiFQvT4CqpA+XMZShZsLzSSnD4MkXS+j68QD5jhzWfnBhEZheu2elMkQ/DxTzgPShCswQqWDDiYWTFCP7PQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gufcVQTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F76C4CEDD;
	Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663170;
	bh=LoeWbBwyxTSrZecZO0b7g1QpNzyCPXlj1DYXGHjXXrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gufcVQTT52mlTV94wOGPDdpXrxFLE2/v2xJ4mBK5G/FzVqsRtmKMDuF5FxtDOAetE
	 EtJUfncX/FoKQu9Pz7vR1e3TtmEO7f2Fz74fxtCv4Sc47pLtjVX0crcV/EfY1/9YB6
	 ccF+tGbkTHavuDVBqSZkeDGr5D+Qz9csZecPiZCBF5RzslLudsW84FD24tZ19xkcAG
	 qeqaAJYxrgIXVCPTdyQlhBuK6H1Tp/uVX49MHuNuXJWObIS3n/tZrMgd3nww1nXeHZ
	 KZtO/auD8u3OemetBtuGQ2849wRpXHfSrbevbvXwTqZ0mdi/oxw4Ii8GmRDRZpJSSZ
	 vOXUpBs1jh03A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/10] eth: fbnic: add IRQ reuse support
Date: Thu, 19 Dec 2024 18:52:38 -0800
Message-ID: <20241220025241.1522781-8-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change our method of swapping NAPIs without disturbing existing config.
This is primarily needed for "live reconfiguration" such as changing
the channel count when interface is already up.

Previously we were planning to use a trick of using shared interrupts.
We would install a second IRQ handler for the new NAPI, and make it
return IRQ_NONE until we were ready for it to take over. This works fine
functionally but breaks IRQ naming. The IRQ subsystem uses the IRQ name
to create the procfs entry, since both handlers used the same name
the second handler wouldn't get a proc directory registered.
When first one gets removed on success full ring count change
it would remove its directory and we would be left with none.

New approach uses a double pointer to the NAPI. The IRQ handler needs
to know how to locate the NAPI to schedule. We register a single IRQ handler
and give it a pointer to a pointer. We can then change what it points to
without re-registering. This may have a tiny perf impact, but really
really negligible.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       | 14 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 42 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  2 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 25 ++---------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  2 +-
 5 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 706ae6104c8e..ed527209b30c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -16,6 +16,10 @@
 #include "fbnic_mac.h"
 #include "fbnic_rpc.h"
 
+struct fbnic_napi_vector;
+
+#define FBNIC_MAX_NAPI_VECTORS		128u
+
 struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
@@ -29,6 +33,11 @@ struct fbnic_dev {
 	unsigned int pcs_msix_vector;
 	unsigned short num_irqs;
 
+	struct {
+		u8 users;
+		char name[IFNAMSIZ + 9];
+	} napi_irq[FBNIC_MAX_NAPI_VECTORS];
+
 	struct delayed_work service_task;
 
 	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
@@ -148,6 +157,11 @@ void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
 int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
 void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);
 
+void fbnic_napi_name_irqs(struct fbnic_dev *fbd);
+int fbnic_napi_request_irq(struct fbnic_dev *fbd,
+			   struct fbnic_napi_vector *nv);
+void fbnic_napi_free_irq(struct fbnic_dev *fbd,
+			 struct fbnic_napi_vector *nv);
 int fbnic_request_irq(struct fbnic_dev *dev, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data);
 void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 914362195920..a8ea7b6774a8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -169,6 +169,48 @@ void fbnic_free_irq(struct fbnic_dev *fbd, int nr, void *data)
 	free_irq(irq, data);
 }
 
+void fbnic_napi_name_irqs(struct fbnic_dev *fbd)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(fbd->napi_irq); i++)
+		snprintf(fbd->napi_irq[i].name,
+			 sizeof(fbd->napi_irq[i].name),
+			 "%s-TxRx-%u", fbd->netdev->name, i);
+}
+
+int fbnic_napi_request_irq(struct fbnic_dev *fbd,
+			   struct fbnic_napi_vector *nv)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	int i = fbnic_napi_idx(nv);
+	int err;
+
+	if (!fbd->napi_irq[i].users) {
+		err = fbnic_request_irq(fbd, nv->v_idx,
+					fbnic_msix_clean_rings,	0,
+					fbd->napi_irq[i].name,
+					&fbn->napi[i]);
+		if (err)
+			return err;
+	}
+
+	fbd->napi_irq[i].users++;
+	return 0;
+}
+
+void fbnic_napi_free_irq(struct fbnic_dev *fbd,
+			 struct fbnic_napi_vector *nv)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	int i = fbnic_napi_idx(nv);
+
+	if (--fbd->napi_irq[i].users)
+		return;
+
+	fbnic_free_irq(fbd, nv->v_idx, &fbn->napi[i]);
+}
+
 void fbnic_free_irqs(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 558644c49a4b..2f19144e4410 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -74,6 +74,8 @@ static int fbnic_open(struct net_device *netdev)
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	int err;
 
+	fbnic_napi_name_irqs(fbn->fbd);
+
 	err = __fbnic_open(fbn);
 	if (!err)
 		fbnic_up(fbn);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 87e4eb03d991..75b491b8e1ca 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1036,9 +1036,9 @@ static int fbnic_poll(struct napi_struct *napi, int budget)
 	return 0;
 }
 
-static irqreturn_t fbnic_msix_clean_rings(int __always_unused irq, void *data)
+irqreturn_t fbnic_msix_clean_rings(int __always_unused irq, void *data)
 {
-	struct fbnic_napi_vector *nv = data;
+	struct fbnic_napi_vector *nv = *(void **)data;
 
 	napi_schedule_irqoff(&nv->napi);
 
@@ -1099,7 +1099,6 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 				   struct fbnic_napi_vector *nv)
 {
 	struct fbnic_dev *fbd = nv->fbd;
-	u32 v_idx = nv->v_idx;
 	int i, j;
 
 	for (i = 0; i < nv->txt_count; i++) {
@@ -1113,7 +1112,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
 	}
 
-	fbnic_free_irq(fbd, v_idx, nv);
+	fbnic_napi_free_irq(fbd, nv);
 	page_pool_destroy(nv->page_pool);
 	netif_napi_del(&nv->napi);
 	fbn->napi[fbnic_napi_idx(nv)] = NULL;
@@ -1129,18 +1128,6 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 			fbnic_free_napi_vector(fbn, fbn->napi[i]);
 }
 
-static void fbnic_name_napi_vector(struct fbnic_napi_vector *nv)
-{
-	unsigned char *dev_name = nv->napi.dev->name;
-
-	if (!nv->rxt_count)
-		snprintf(nv->name, sizeof(nv->name), "%s-Tx-%u", dev_name,
-			 nv->v_idx - FBNIC_NON_NAPI_VECTORS);
-	else
-		snprintf(nv->name, sizeof(nv->name), "%s-TxRx-%u", dev_name,
-			 nv->v_idx - FBNIC_NON_NAPI_VECTORS);
-}
-
 #define FBNIC_PAGE_POOL_FLAGS \
 	(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
 
@@ -1240,12 +1227,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 			goto napi_del;
 	}
 
-	/* Initialize vector name */
-	fbnic_name_napi_vector(nv);
-
 	/* Request the IRQ for napi vector */
-	err = fbnic_request_irq(fbd, v_idx, &fbnic_msix_clean_rings,
-				IRQF_SHARED, nv->name, nv);
+	err = fbnic_napi_request_irq(fbd, nv);
 	if (err)
 		goto pp_destroy;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 1965d1fa38a2..c8d908860ab0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -104,7 +104,6 @@ struct fbnic_napi_vector {
 	struct device *dev;		/* Device for DMA unmapping */
 	struct page_pool *page_pool;
 	struct fbnic_dev *fbd;
-	char name[IFNAMSIZ + 9];
 
 	u16 v_idx;
 	u8 txt_count;
@@ -125,6 +124,7 @@ int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
 void fbnic_free_napi_vectors(struct fbnic_net *fbn);
 int fbnic_alloc_resources(struct fbnic_net *fbn);
 void fbnic_free_resources(struct fbnic_net *fbn);
+irqreturn_t fbnic_msix_clean_rings(int irq, void *data);
 void fbnic_napi_enable(struct fbnic_net *fbn);
 void fbnic_napi_disable(struct fbnic_net *fbn);
 void fbnic_enable(struct fbnic_net *fbn);
-- 
2.47.1


