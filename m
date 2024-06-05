Return-Path: <netdev+bounces-101182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5008FDA77
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E5A1F25AD4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9FC168C2D;
	Wed,  5 Jun 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3rSbmrr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29021667FC
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630058; cv=none; b=KJQcp6N4Atrh25RCDid6AbOLqNdUTAJUBlddHpRKbrNHhqnP03IUzodINc8TTk7G0A6+GWr/t8wfmYnzvpACRfv53WX4G4KqXaLSdaVyo/R4RlSrJ8fzNqaDiGWkkZCK6+OJ18L3WzQt6qxWE04qTN/3sq50dPxGL6LQwKeFxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630058; c=relaxed/simple;
	bh=cT56LV4Faahnmvwn8zhRmOPjdjsBUGYzz4Rq39etR7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRMAedh5llzt6MCwUuj6yK8W9b5CTX8lTEzfoj8nAC3vdARIImUh4UayGRNg13h1RdnVFe8Uypyc1QxZzP9ADLvm1mz2j4vXgdZ48WouMNWv/zt7QT98D5pvVIBQPDMfLsDHqzAg8/NnCXsZYIjNWYLZNdxzHiy7J/8ScKf8xW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3rSbmrr; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3745eeedc76so293295ab.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717630055; x=1718234855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3jRRSst0v663y0ZMDG04exRrCmwT5isWwJkgIm3hCI=;
        b=M3rSbmrrYI5pIURebvj4mrDKe9AeFgmxBwy+KvCdTDi9RefHV73PcRiI+O4nrl3Var
         OOPbvFei/RwpHOIH3P90moFuD7lN7VRFDh1aDXPLpyzw6CHXN46/hGxX3BH8oH0opIvF
         FGnL5EtQG3hUWooWDefw9IRakjjv3nmlAbrr0v0ORuXgxeAdfTmB+WSrZq8V7NpmnSae
         SjwvKgiLuSvCD6ljmv/vSOS8uHtgZDj5WfmfLUZSZNwA9QZ3rmN75eaD5mTJ4r+TVc1R
         IkBBpj8mu4165gT+ndzswRnaeiAlU7Ic/7MOINyCmJxRbWMg69Fnw2dB1G7BCzsf/36G
         FCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630055; x=1718234855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3jRRSst0v663y0ZMDG04exRrCmwT5isWwJkgIm3hCI=;
        b=UBpjT/1E2m2L0dIZBPy9W8VElN0hXGo6t8h5rXSgLuaeHM34WT3x7j1Al1OU/vLjtY
         kvDD8gWEy/ABiwrVCqZYesWF3qGewK3cuPncnAL2KoqZUAd/6meCN/tOS0Wp0yf1ZlLZ
         lBdQU+5HdGyi9+QXsWHJ5TunPRzwoZCROcb8qBP8wUa3njpT3707iUVvkthCsZN7zKJ8
         yKh253uFHPIGfM2XS5t9Tsd2kFIgQF+D5ZMnahRFtwabIGRgCm6G5pz9xrKcYIpea9Cw
         DSsld6s0uqPjMsnf5fU+RolzsklHMkmVf1mjfOcJH6GEPPaftc8jZlCvV26WJtBsQWOx
         0mGQ==
X-Gm-Message-State: AOJu0YxCYRa+PpHMo3sGc5K+ko2FY3SxbrNqe2xIaQREB+K1u/8VVMbw
	YeldMoq6xI6hfBvqs5ZpBmTUDrEG9aiX8zQ315XwC7DpPTvVP2oHRPelC3WX
X-Google-Smtp-Source: AGHT+IGLlXw6ker/A+AVRL9bkFlO02ic4qjpxXsARXoV0gSolycGdM6r+My9eKc7IORqA2Cj7LqrIA==
X-Received: by 2002:a05:6e02:1384:b0:374:99fc:c83a with SMTP id e9e14a558f8ab-374b1f58ee7mr38730855ab.3.1717630054767;
        Wed, 05 Jun 2024 16:27:34 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28f37482sm67725a12.94.2024.06.05.16.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 16:27:34 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com
Subject: [PATCH net-next v9 4/6] net: tn40xx: add basic Rx handling
Date: Thu,  6 Jun 2024 08:26:06 +0900
Message-Id: <20240605232608.65471-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605232608.65471-1-fujita.tomonori@gmail.com>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds basic Rx handling. The Rx logic uses three major data
structures; two ring buffers with NIC and one database. One ring
buffer is used to send information to NIC about memory to be stored
packets to be received. The other is used to get information from NIC
about received packets. The database is used to keep the information
about DMA mapping. After a packet arrived, the db is used to pass the
packet to the network stack.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/Kconfig |   1 +
 drivers/net/ethernet/tehuti/tn40.c  | 444 +++++++++++++++++++++++++++-
 drivers/net/ethernet/tehuti/tn40.h  |  52 ++++
 3 files changed, 496 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
index 4198fd59e42e..2b3b5a8c7fbf 100644
--- a/drivers/net/ethernet/tehuti/Kconfig
+++ b/drivers/net/ethernet/tehuti/Kconfig
@@ -26,6 +26,7 @@ config TEHUTI
 config TEHUTI_TN40
 	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
 	depends on PCI
+	select PAGE_POOL
 	select FW_LOADER
 	help
 	  This driver supports 10G Ethernet adapters using Tehuti Networks
diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 6ee72ec8d7e4..4354ac52e098 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -8,6 +8,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
+#include <net/page_pool/helpers.h>
 
 #include "tn40.h"
 
@@ -62,6 +63,351 @@ static void tn40_fifo_free(struct tn40_priv *priv, struct tn40_fifo *f)
 			  f->memsz + TN40_FIFO_EXTRA_SPACE, f->va, f->da);
 }
 
+static struct tn40_rxdb *tn40_rxdb_alloc(int nelem)
+{
+	size_t size = sizeof(struct tn40_rxdb) + (nelem * sizeof(int)) +
+	    (nelem * sizeof(struct tn40_rx_map));
+	struct tn40_rxdb *db;
+	int i;
+
+	db = vzalloc(size);
+	if (db) {
+		db->stack = (int *)(db + 1);
+		db->elems = (void *)(db->stack + nelem);
+		db->nelem = nelem;
+		db->top = nelem;
+		/* make the first alloc close to db struct */
+		for (i = 0; i < nelem; i++)
+			db->stack[i] = nelem - i - 1;
+	}
+	return db;
+}
+
+static void tn40_rxdb_free(struct tn40_rxdb *db)
+{
+	vfree(db);
+}
+
+static int tn40_rxdb_alloc_elem(struct tn40_rxdb *db)
+{
+	return db->stack[--(db->top)];
+}
+
+static void *tn40_rxdb_addr_elem(struct tn40_rxdb *db, unsigned int n)
+{
+	return db->elems + n;
+}
+
+static int tn40_rxdb_available(struct tn40_rxdb *db)
+{
+	return db->top;
+}
+
+static void tn40_rxdb_free_elem(struct tn40_rxdb *db, unsigned int n)
+{
+	db->stack[(db->top)++] = n;
+}
+
+/**
+ * tn40_create_rx_ring - Initialize RX all related HW and SW resources
+ * @priv: NIC private structure
+ *
+ * create_rx_ring creates rxf and rxd fifos, updates the relevant HW registers,
+ * preallocates skbs for rx. It assumes that Rx is disabled in HW funcs are
+ * grouped for better cache usage
+ *
+ * RxD fifo is smaller then RxF fifo by design. Upon high load, RxD will be
+ * filled and packets will be dropped by the NIC without getting into the host
+ * or generating interrupts. In this situation the host has no chance of
+ * processing all the packets. Dropping packets by the NIC is cheaper, since it
+ * takes 0 CPU cycles.
+ *
+ * Return: 0 on success and negative value on error.
+ */
+static int tn40_create_rx_ring(struct tn40_priv *priv)
+{
+	struct page_pool_params pp = {
+		.dev = &priv->pdev->dev,
+		.napi = &priv->napi,
+		.dma_dir = DMA_FROM_DEVICE,
+		.netdev = priv->ndev,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.max_len = PAGE_SIZE,
+	};
+	int ret, pkt_size, nr;
+
+	priv->page_pool = page_pool_create(&pp);
+	if (IS_ERR(priv->page_pool))
+		return PTR_ERR(priv->page_pool);
+
+	ret = tn40_fifo_alloc(priv, &priv->rxd_fifo0.m, priv->rxd_size,
+			      TN40_REG_RXD_CFG0_0, TN40_REG_RXD_CFG1_0,
+			      TN40_REG_RXD_RPTR_0, TN40_REG_RXD_WPTR_0);
+	if (ret)
+		goto err_destroy_page_pool;
+
+	ret = tn40_fifo_alloc(priv, &priv->rxf_fifo0.m, priv->rxf_size,
+			      TN40_REG_RXF_CFG0_0, TN40_REG_RXF_CFG1_0,
+			      TN40_REG_RXF_RPTR_0, TN40_REG_RXF_WPTR_0);
+	if (ret)
+		goto err_free_rxd;
+
+	pkt_size = priv->ndev->mtu + VLAN_ETH_HLEN;
+	priv->rxf_fifo0.m.pktsz = pkt_size;
+	nr = priv->rxf_fifo0.m.memsz / sizeof(struct tn40_rxf_desc);
+	priv->rxdb0 = tn40_rxdb_alloc(nr);
+	if (!priv->rxdb0) {
+		ret = -ENOMEM;
+		goto err_free_rxf;
+	}
+	return 0;
+err_free_rxf:
+	tn40_fifo_free(priv, &priv->rxf_fifo0.m);
+err_free_rxd:
+	tn40_fifo_free(priv, &priv->rxd_fifo0.m);
+err_destroy_page_pool:
+	page_pool_destroy(priv->page_pool);
+	return ret;
+}
+
+static void tn40_rx_free_buffers(struct tn40_priv *priv)
+{
+	struct tn40_rxdb *db = priv->rxdb0;
+	struct tn40_rx_map *dm;
+	u16 i;
+
+	netdev_dbg(priv->ndev, "total =%d free =%d busy =%d\n", db->nelem,
+		   tn40_rxdb_available(db),
+		   db->nelem - tn40_rxdb_available(db));
+
+	for (i = 0; i < db->nelem; i++) {
+		dm = tn40_rxdb_addr_elem(db, i);
+		if (dm->page)
+			page_pool_put_full_page(priv->page_pool, dm->page,
+						false);
+	}
+}
+
+static void tn40_destroy_rx_ring(struct tn40_priv *priv)
+{
+	if (priv->rxdb0) {
+		tn40_rx_free_buffers(priv);
+		tn40_rxdb_free(priv->rxdb0);
+		priv->rxdb0 = NULL;
+	}
+	tn40_fifo_free(priv, &priv->rxf_fifo0.m);
+	tn40_fifo_free(priv, &priv->rxd_fifo0.m);
+	page_pool_destroy(priv->page_pool);
+}
+
+static void tn40_set_rx_desc(struct tn40_priv *priv, int idx, u64 dma)
+{
+	struct tn40_rxf_fifo *f = &priv->rxf_fifo0;
+	struct tn40_rxf_desc *rxfd;
+	int delta;
+
+	rxfd = (struct tn40_rxf_desc *)(f->m.va + f->m.wptr);
+	rxfd->info = cpu_to_le32(0x10003);	/* INFO =1 BC =3 */
+	rxfd->va_lo = cpu_to_le32(idx);
+	rxfd->pa_lo = cpu_to_le32(lower_32_bits(dma));
+	rxfd->pa_hi = cpu_to_le32(upper_32_bits(dma));
+	rxfd->len = cpu_to_le32(f->m.pktsz);
+	f->m.wptr += sizeof(struct tn40_rxf_desc);
+	delta = f->m.wptr - f->m.memsz;
+	if (unlikely(delta >= 0)) {
+		f->m.wptr = delta;
+		if (delta > 0) {
+			memcpy(f->m.va, f->m.va + f->m.memsz, delta);
+			netdev_dbg(priv->ndev,
+				   "wrapped rxd descriptor\n");
+		}
+	}
+}
+
+/**
+ * tn40_rx_alloc_buffers - Fill rxf fifo with buffers.
+ *
+ * @priv: NIC's private structure
+ *
+ * rx_alloc_buffers allocates buffers via the page pool API, builds rxf descs
+ * and pushes them (rxf descr) into the rxf fifo. The pages are stored in rxdb.
+ * To calculate the free space, we uses the cached values of RPTR and WPTR
+ * when needed. This function also updates RPTR and WPTR.
+ */
+static void tn40_rx_alloc_buffers(struct tn40_priv *priv)
+{
+	struct tn40_rxf_fifo *f = &priv->rxf_fifo0;
+	struct tn40_rxdb *db = priv->rxdb0;
+	struct tn40_rx_map *dm;
+	struct page *page;
+	int dno, i, idx;
+
+	dno = tn40_rxdb_available(db) - 1;
+	i = dno;
+	while (i > 0) {
+		page = page_pool_dev_alloc_pages(priv->page_pool);
+		if (!page)
+			break;
+
+		idx = tn40_rxdb_alloc_elem(db);
+		tn40_set_rx_desc(priv, idx, page_pool_get_dma_addr(page));
+		dm = tn40_rxdb_addr_elem(db, idx);
+		dm->page = page;
+
+		i--;
+	}
+	if (i != dno)
+		tn40_write_reg(priv, f->m.reg_wptr,
+			       f->m.wptr & TN40_TXF_WPTR_WR_PTR);
+	netdev_dbg(priv->ndev, "write_reg 0x%04x f->m.reg_wptr 0x%x\n",
+		   f->m.reg_wptr, f->m.wptr & TN40_TXF_WPTR_WR_PTR);
+	netdev_dbg(priv->ndev, "read_reg  0x%04x f->m.reg_rptr=0x%x\n",
+		   f->m.reg_rptr, tn40_read_reg(priv, f->m.reg_rptr));
+	netdev_dbg(priv->ndev, "write_reg 0x%04x f->m.reg_wptr=0x%x\n",
+		   f->m.reg_wptr, tn40_read_reg(priv, f->m.reg_wptr));
+}
+
+static void tn40_recycle_rx_buffer(struct tn40_priv *priv,
+				   struct tn40_rxd_desc *rxdd)
+{
+	struct tn40_rxf_fifo *f = &priv->rxf_fifo0;
+	struct tn40_rx_map *dm;
+	int idx;
+
+	idx = le32_to_cpu(rxdd->va_lo);
+	dm = tn40_rxdb_addr_elem(priv->rxdb0, idx);
+	tn40_set_rx_desc(priv, idx, page_pool_get_dma_addr(dm->page));
+
+	tn40_write_reg(priv, f->m.reg_wptr, f->m.wptr & TN40_TXF_WPTR_WR_PTR);
+}
+
+static int tn40_rx_receive(struct tn40_priv *priv, int budget)
+{
+	struct tn40_rxd_fifo *f = &priv->rxd_fifo0;
+	u32 rxd_val1, rxd_err, pkt_id;
+	int tmp_len, size, done = 0;
+	struct tn40_rxdb *db = NULL;
+	struct tn40_rxd_desc *rxdd;
+	struct tn40_rx_map *dm;
+	struct sk_buff *skb;
+	u16 len, rxd_vlan;
+	int idx;
+
+	f->m.wptr = tn40_read_reg(priv, f->m.reg_wptr) & TN40_TXF_WPTR_WR_PTR;
+	size = f->m.wptr - f->m.rptr;
+	if (size < 0)
+		size += f->m.memsz;	/* Size is negative :-) */
+
+	while (size > 0) {
+		rxdd = (struct tn40_rxd_desc *)(f->m.va + f->m.rptr);
+		db = priv->rxdb0;
+
+		/* We have a chicken and egg problem here. If the
+		 * descriptor is wrapped we first need to copy the tail
+		 * of the descriptor to the end of the buffer before
+		 * extracting values from the descriptor. However in
+		 * order to know if the descriptor is wrapped we need to
+		 * obtain the length of the descriptor from (the
+		 * wrapped) descriptor. Luckily the length is the first
+		 * word of the descriptor. Descriptor lengths are
+		 * multiples of 8 bytes so in case of a wrapped
+		 * descriptor the first 8 bytes guaranteed to appear
+		 * before the end of the buffer. We first obtain the
+		 * length, we then copy the rest of the descriptor if
+		 * needed and then extract the rest of the values from
+		 * the descriptor.
+		 *
+		 * Do not change the order of operations as it will
+		 * break the code!!!
+		 */
+		rxd_val1 = le32_to_cpu(rxdd->rxd_val1);
+		tmp_len = TN40_GET_RXD_BC(rxd_val1) << 3;
+		pkt_id = TN40_GET_RXD_PKT_ID(rxd_val1);
+		size -= tmp_len;
+		/* CHECK FOR A PARTIALLY ARRIVED DESCRIPTOR */
+		if (size < 0) {
+			netdev_dbg(priv->ndev,
+				   "%s partially arrived desc tmp_len %d\n",
+				   __func__, tmp_len);
+			break;
+		}
+		/* make sure that the descriptor fully is arrived
+		 * before reading the rest of the descriptor.
+		 */
+		rmb();
+
+		/* A special treatment is given to non-contiguous
+		 * descriptors that start near the end, wraps around
+		 * and continue at the beginning. The second part is
+		 * copied right after the first, and then descriptor
+		 * is interpreted as normal. The fifo has an extra
+		 * space to allow such operations.
+		 */
+
+		/* HAVE WE REACHED THE END OF THE QUEUE? */
+		f->m.rptr += tmp_len;
+		tmp_len = f->m.rptr - f->m.memsz;
+		if (unlikely(tmp_len >= 0)) {
+			f->m.rptr = tmp_len;
+			if (tmp_len > 0) {
+				/* COPY PARTIAL DESCRIPTOR
+				 * TO THE END OF THE QUEUE
+				 */
+				netdev_dbg(priv->ndev,
+					   "wrapped desc rptr=%d tmp_len=%d\n",
+					   f->m.rptr, tmp_len);
+				memcpy(f->m.va + f->m.memsz, f->m.va, tmp_len);
+			}
+		}
+		idx = le32_to_cpu(rxdd->va_lo);
+		dm = tn40_rxdb_addr_elem(db, idx);
+		prefetch(dm);
+
+		len = le16_to_cpu(rxdd->len);
+		rxd_vlan = le16_to_cpu(rxdd->rxd_vlan);
+		/* CHECK FOR ERRORS */
+		rxd_err = TN40_GET_RXD_ERR(rxd_val1);
+		if (unlikely(rxd_err)) {
+			netdev_err(priv->ndev, "rxd_err = 0x%x\n", rxd_err);
+			priv->net_stats.rx_errors++;
+			tn40_recycle_rx_buffer(priv, rxdd);
+			continue;
+		}
+
+		skb = napi_build_skb(page_address(dm->page), PAGE_SIZE);
+		if (!skb) {
+			netdev_err(priv->ndev, "napi_build_skb() failed\n");
+			priv->net_stats.rx_dropped++;
+			tn40_recycle_rx_buffer(priv, rxdd);
+			break;
+		}
+		skb_mark_for_recycle(skb);
+		skb_put(skb, len);
+		skb->protocol = eth_type_trans(skb, priv->ndev);
+		skb->ip_summed =
+		    (pkt_id == 0) ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
+		if (TN40_GET_RXD_VTAG(rxd_val1))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       TN40_GET_RXD_VLAN_TCI(rxd_vlan));
+
+		dm->page = NULL;
+		tn40_rxdb_free_elem(db, idx);
+
+		napi_gro_receive(&priv->napi, skb);
+
+		priv->net_stats.rx_bytes += len;
+
+		if (unlikely(++done >= budget))
+			break;
+	}
+
+	priv->net_stats.rx_packets += done;
+	/* FIXME: Do something to minimize pci accesses */
+	tn40_write_reg(priv, f->m.reg_rptr, f->m.rptr & TN40_TXF_WPTR_WR_PTR);
+	tn40_rx_alloc_buffers(priv);
+	return done;
+}
+
 /* TX HW/SW interaction overview
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * There are 2 types of TX communication channels between driver and NIC.
@@ -450,6 +796,56 @@ static int tn40_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+static void tn40_tx_cleanup(struct tn40_priv *priv)
+{
+	struct tn40_txf_fifo *f = &priv->txf_fifo0;
+	struct tn40_txdb *db = &priv->txdb;
+	int tx_level = 0;
+
+	f->m.wptr = tn40_read_reg(priv, f->m.reg_wptr) & TN40_TXF_WPTR_MASK;
+
+	netif_tx_lock(priv->ndev);
+	while (f->m.wptr != f->m.rptr) {
+		f->m.rptr += TN40_TXF_DESC_SZ;
+		f->m.rptr &= f->m.size_mask;
+		/* Unmap all fragments */
+		/* First has to come tx_maps containing DMA */
+		do {
+			dma_unmap_page(&priv->pdev->dev, db->rptr->addr.dma,
+				       db->rptr->len, DMA_TO_DEVICE);
+			tn40_tx_db_inc_rptr(db);
+		} while (db->rptr->len > 0);
+		tx_level -= db->rptr->len; /* '-' Because the len is negative */
+
+		/* Now should come skb pointer - free it */
+		dev_kfree_skb_any(db->rptr->addr.skb);
+		netdev_dbg(priv->ndev, "dev_kfree_skb_any %p %d\n",
+			   db->rptr->addr.skb, -db->rptr->len);
+		tn40_tx_db_inc_rptr(db);
+	}
+
+	/* Let the HW know which TXF descriptors were cleaned */
+	tn40_write_reg(priv, f->m.reg_rptr, f->m.rptr & TN40_TXF_WPTR_WR_PTR);
+
+	/* We reclaimed resources, so in case the Q is stopped by xmit
+	 * callback, we resume the transmission and use tx_lock to
+	 * synchronize with xmit.
+	 */
+	priv->tx_level += tx_level;
+	if (priv->tx_noupd) {
+		priv->tx_noupd = 0;
+		tn40_write_reg(priv, priv->txd_fifo0.m.reg_wptr,
+			       priv->txd_fifo0.m.wptr & TN40_TXF_WPTR_WR_PTR);
+	}
+	if (unlikely(netif_queue_stopped(priv->ndev) &&
+		     netif_carrier_ok(priv->ndev) &&
+		     (priv->tx_level >= TN40_MAX_TX_LEVEL / 2))) {
+		netdev_dbg(priv->ndev, "TX Q WAKE level %d\n", priv->tx_level);
+		netif_wake_queue(priv->ndev);
+	}
+	netif_tx_unlock(priv->ndev);
+}
+
 static void tn40_tx_free_skbs(struct tn40_priv *priv)
 {
 	struct tn40_txdb *db = &priv->txdb;
@@ -713,6 +1109,10 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
 		tn40_isr_extra(priv, isr);
 
 	if (isr & (TN40_IR_RX_DESC_0 | TN40_IR_TX_FREE_0 | TN40_IR_TMR1)) {
+		if (likely(napi_schedule_prep(&priv->napi))) {
+			__napi_schedule(&priv->napi);
+			return IRQ_HANDLED;
+		}
 		/* We get here if an interrupt has slept into the
 		 * small time window between these lines in
 		 * tn40_poll: tn40_enable_interrupts(priv); return 0;
@@ -730,6 +1130,25 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static int tn40_poll(struct napi_struct *napi, int budget)
+{
+	struct tn40_priv *priv = container_of(napi, struct tn40_priv, napi);
+	int work_done;
+
+	tn40_tx_cleanup(priv);
+
+	if (!budget)
+		return 0;
+
+	work_done = tn40_rx_receive(priv, budget);
+	if (work_done == budget)
+		return budget;
+
+	if (napi_complete_done(napi, work_done))
+		tn40_enable_interrupts(priv);
+	return work_done;
+}
+
 static int tn40_fw_load(struct tn40_priv *priv)
 {
 	const struct firmware *fw = NULL;
@@ -812,6 +1231,8 @@ static void tn40_hw_start(struct tn40_priv *priv)
 	tn40_write_reg(priv, TN40_REG_TX_FULLNESS, 0);
 
 	tn40_write_reg(priv, TN40_REG_VGLB, 0);
+	tn40_write_reg(priv, TN40_REG_MAX_FRAME_A,
+		       priv->rxf_fifo0.m.pktsz & TN40_MAX_FRAME_AB_VAL);
 	tn40_write_reg(priv, TN40_REG_RDINTCM0, priv->rdintcm);
 	tn40_write_reg(priv, TN40_REG_RDINTCM2, 0);
 
@@ -913,15 +1334,30 @@ static int tn40_start(struct tn40_priv *priv)
 		return ret;
 	}
 
+	ret = tn40_create_rx_ring(priv);
+	if (ret) {
+		netdev_err(priv->ndev, "failed to rx init %d\n", ret);
+		goto err_tx_ring;
+	}
+
+	tn40_rx_alloc_buffers(priv);
+	if (tn40_rxdb_available(priv->rxdb0) != 1) {
+		ret = -ENOMEM;
+		netdev_err(priv->ndev, "failed to allocate rx buffers\n");
+		goto err_rx_ring;
+	}
+
 	ret = request_irq(priv->pdev->irq, &tn40_isr_napi, IRQF_SHARED,
 			  priv->ndev->name, priv->ndev);
 	if (ret) {
 		netdev_err(priv->ndev, "failed to request irq %d\n", ret);
-		goto err_tx_ring;
+		goto err_rx_ring;
 	}
 
 	tn40_hw_start(priv);
 	return 0;
+err_rx_ring:
+	tn40_destroy_rx_ring(priv);
 err_tx_ring:
 	tn40_destroy_tx_ring(priv);
 	return ret;
@@ -933,12 +1369,15 @@ static void tn40_stop(struct tn40_priv *priv)
 	free_irq(priv->pdev->irq, priv->ndev);
 	tn40_sw_reset(priv);
 	tn40_destroy_tx_ring(priv);
+	tn40_destroy_rx_ring(priv);
 }
 
 static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	napi_disable(&priv->napi);
+	netif_napi_del(&priv->napi);
 	tn40_stop(priv);
 	return 0;
 }
@@ -954,6 +1393,8 @@ static int tn40_open(struct net_device *dev)
 		netdev_err(dev, "failed to start %d\n", ret);
 		return ret;
 	}
+	napi_enable(&priv->napi);
+	netif_start_queue(priv->ndev);
 	return 0;
 }
 
@@ -1203,6 +1644,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	priv = netdev_priv(ndev);
 	pci_set_drvdata(pdev, priv);
+	netif_napi_add(ndev, &priv->napi, tn40_poll);
 
 	priv->regs = regs;
 	priv->pdev = pdev;
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 859cbeb1ec0b..afe85ce44d41 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -62,6 +62,25 @@ struct tn40_txd_fifo {
 	struct tn40_fifo m; /* The minimal set of variables used by all fifos */
 };
 
+struct tn40_rxf_fifo {
+	struct tn40_fifo m; /* The minimal set of variables used by all fifos */
+};
+
+struct tn40_rxd_fifo {
+	struct tn40_fifo m; /* The minimal set of variables used by all fifos */
+};
+
+struct tn40_rx_map {
+	struct page *page;
+};
+
+struct tn40_rxdb {
+	int *stack;
+	struct tn40_rx_map *elems;
+	int nelem;
+	int top;
+};
+
 union tn40_tx_dma_addr {
 	dma_addr_t dma;
 	struct sk_buff *skb;
@@ -89,6 +108,13 @@ struct tn40_priv {
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 
+	struct napi_struct napi;
+	/* RX FIFOs: 1 for data (full) descs, and 2 for free descs */
+	struct tn40_rxd_fifo rxd_fifo0;
+	struct tn40_rxf_fifo rxf_fifo0;
+	struct tn40_rxdb *rxdb0; /* Rx dbs to store skb pointers */
+	struct page_pool *page_pool;
+
 	/* Tx FIFOs: 1 for data desc, 1 for empty (acks) desc */
 	struct tn40_txd_fifo txd_fifo0;
 	struct tn40_txf_fifo txf_fifo0;
@@ -117,6 +143,32 @@ struct tn40_priv {
 	char *b0_va; /* Virtual address of buffer */
 };
 
+/* RX FREE descriptor - 64bit */
+struct tn40_rxf_desc {
+	__le32 info; /* Buffer Count + Info - described below */
+	__le32 va_lo; /* VAdr[31:0] */
+	__le32 va_hi; /* VAdr[63:32] */
+	__le32 pa_lo; /* PAdr[31:0] */
+	__le32 pa_hi; /* PAdr[63:32] */
+	__le32 len; /* Buffer Length */
+};
+
+#define TN40_GET_RXD_BC(x) FIELD_GET(GENMASK(4, 0), (x))
+#define TN40_GET_RXD_ERR(x) FIELD_GET(GENMASK(26, 21), (x))
+#define TN40_GET_RXD_PKT_ID(x) FIELD_GET(GENMASK(30, 28), (x))
+#define TN40_GET_RXD_VTAG(x) FIELD_GET(BIT(31), (x))
+#define TN40_GET_RXD_VLAN_TCI(x) FIELD_GET(GENMASK(15, 0), (x))
+
+struct tn40_rxd_desc {
+	__le32 rxd_val1;
+	__le16 len;
+	__le16 rxd_vlan;
+	__le32 va_lo;
+	__le32 va_hi;
+	__le32 rss_lo;
+	__le32 rss_hash;
+};
+
 #define TN40_MAX_PBL (19)
 /* PBL describes each virtual buffer to be transmitted from the host. */
 struct tn40_pbl {
-- 
2.34.1


