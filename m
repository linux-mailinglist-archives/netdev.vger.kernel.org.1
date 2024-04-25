Return-Path: <netdev+bounces-91140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F88B184D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A141C21446
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA6EAD55;
	Thu, 25 Apr 2024 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmD7enNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CAC10A22
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007132; cv=none; b=qZ7qGWNnVc/d8lG+ZknWJ7cBRvKdQiZeuHTE5MbJmXEL2fCHu+fFQF89Y/WuR0MoLlXnRtdPBy+TJNxcYAKPrKnw4ENOkQzhDHmHt9+0SnPxkVCQ30224ks9gdGLmKULDEYAhJxt1rp7u6EwpYtWHimpkIglSldoN0D1hVgeL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007132; c=relaxed/simple;
	bh=TJIq/6EzDbJIyw86wUj3wGe/6vvwNwQ1FLYNaf3Cy/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syCNGyPA4dxZUlCwzf/h03QUWqePZ72MMvYLaaSSIFmnecJ88dkw2QXD5F2afasZe1EQQn2/0wVqPNK6x1U2xFZcJ3KRJbv1bUEnThXRX3WJCa2A0Bz+laUCpCXehNLrXM0LdFRgJwYYEusQXFA7ak3OxUMyeAfKzS1rVYri5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmD7enNB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2389e1dd2a6so969fac.3
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714007128; x=1714611928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+imsZF26fkTzdNUt2uaWAAuTVdyLbuFdot6hWruCHk=;
        b=dmD7enNBBtKTJXMXKyCfuUy9ItEbbd7T/NnW5rRzCYC4wxbtUDN8owSDJ9lvDk9BEp
         u1ApQMcoYvXu5D8RQYJ69NT75VtxoiOuQx0j5J5Ec0GZePJ/4vqhiPdIGDX4WpG6fdIm
         cH/4HX50dCzTeQlV+Vcwsx5a/9R91TYOSDzTx5OsrwLZFIy0hRzr3ERytBqYlBBM0mny
         8CAo8Tjq5HLeAFptCzmKqN6QVMNGw8acPTxNIh/uex2o5KrmbrXDllMz6RnWKo6xZtA2
         hlrQyhDsK2b9r4trZBfc6wFHhe3NxGw3M4NWGZrhpvjIAoMozTp0ZdUCmvukpzaa00RK
         uENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007128; x=1714611928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+imsZF26fkTzdNUt2uaWAAuTVdyLbuFdot6hWruCHk=;
        b=jGOHRyLFdvBE2pqYE+CGEcMkOxGeTf/I4l/rqIGgfuhptSeVxuuje7PgXhZKMP/LLm
         Epb+bAIJD8JL/+wtOWKnQxM+oH7TGKe2+iKml/mCJ7A3M3hcgblIYrC584aTzyEHrhnY
         d8uJfD3lb200Q5hMvrsVfhK+7HcZYEZbAaUgeHLbhvg57sMBmaOXhjG6wE1nZebYp0eM
         LRublN7t8eLoPffVyUW3X7ZFkQSuRlzVDhLE0XmsEg3rETrSZUDrNDcW8i9SPrbpR/Bl
         p5WewMBCUNTPusZnXJmxVtooFbCuyTLMQc3AESNCnh0a/SYSOa15HFqYYVJXZhdGLEO/
         hCnQ==
X-Gm-Message-State: AOJu0YxC1zhibL+TJ0eCNduDLwjNC779Qa2zLr7vFVWEGt8uBHHbOoKw
	OKYAn2DvMbq3TYLHx8J2/sY0lr3PdPZm19jnQfKYnQF9H9pm2s1tkLIHsg==
X-Google-Smtp-Source: AGHT+IECHfl+yTPesL3sV/8ZXBZEb+6WkglYW6HZXeok8Q0OAUJEHFH55AQVR5UXwtK4AcOR4QwKpg==
X-Received: by 2002:a05:6870:218f:b0:23b:3428:725a with SMTP id l15-20020a056870218f00b0023b3428725amr2358603oae.1.1714007127745;
        Wed, 24 Apr 2024 18:05:27 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm5644940pgl.30.2024.04.24.18.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:05:27 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v2 3/6] net: tn40xx: add basic Tx handling
Date: Thu, 25 Apr 2024 10:03:51 +0900
Message-Id: <20240425010354.32605-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425010354.32605-1-fujita.tomonori@gmail.com>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds device specific structures to initialize the hardware
with basic Tx handling. The original driver loads the embedded
firmware in the header file. This driver is implemented to use the
firmware APIs.

The Tx logic uses three major data structures; two ring buffers with
NIC and one database. One ring buffer is used to send information
about packets to be sent for NIC. The other is used to get information
from NIC about packet that are sent. The database is used to keep the
information about DMA mapping. After a packet is sent, the db is used
to free the resource used for the packet.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/Kconfig |    1 +
 drivers/net/ethernet/tehuti/tn40.c  | 1244 +++++++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h  |  179 ++++
 3 files changed, 1424 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
index 849e3b4a71c1..4198fd59e42e 100644
--- a/drivers/net/ethernet/tehuti/Kconfig
+++ b/drivers/net/ethernet/tehuti/Kconfig
@@ -26,6 +26,7 @@ config TEHUTI
 config TEHUTI_TN40
 	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
 	depends on PCI
+	select FW_LOADER
 	help
 	  This driver supports 10G Ethernet adapters using Tehuti Networks
 	  TN40xx chips. Currently, adapters with Applied Micro Circuits
diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index c26f391059e1..014ef9b3fcbd 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -3,10 +3,1167 @@
 
 #include "tn40.h"
 
+#define SHORT_PACKET_SIZE 60
+#define FIRMWARE_NAME "tn40xx-14.fw"
+
+static void tn40_enable_interrupts(struct tn40_priv *priv)
+{
+	write_reg(priv, REG_IMR, priv->isr_mask);
+}
+
+static void tn40_disable_interrupts(struct tn40_priv *priv)
+{
+	write_reg(priv, REG_IMR, 0);
+}
+
+static int tn40_fifo_alloc(struct tn40_priv *priv, struct fifo *f,
+			   int fsz_type,
+			   u16 reg_cfg0, u16 reg_cfg1,
+			   u16 reg_rptr, u16 reg_wptr)
+{
+	u16 memsz = FIFO_SIZE * (1 << fsz_type);
+
+	memset(f, 0, sizeof(struct fifo));
+	/* 1K extra space is allocated at the end of the fifo to simplify
+	 * processing of descriptors that wraps around fifo's end.
+	 */
+	f->va = dma_alloc_coherent(&priv->pdev->dev,
+				   memsz + FIFO_EXTRA_SPACE, &f->da,
+				   GFP_KERNEL);
+	if (!f->va)
+		return -ENOMEM;
+
+	f->reg_cfg0 = reg_cfg0;
+	f->reg_cfg1 = reg_cfg1;
+	f->reg_rptr = reg_rptr;
+	f->reg_wptr = reg_wptr;
+	f->rptr = 0;
+	f->wptr = 0;
+	f->memsz = memsz;
+	f->size_mask = memsz - 1;
+	write_reg(priv, reg_cfg0,
+		  lower_32_bits((f->da & TX_RX_CFG0_BASE) | fsz_type));
+	write_reg(priv, reg_cfg1, upper_32_bits(f->da));
+	return 0;
+}
+
+static void tn40_fifo_free(struct tn40_priv *priv, struct fifo *f)
+{
+	dma_free_coherent(&priv->pdev->dev,
+			  f->memsz + FIFO_EXTRA_SPACE, f->va, f->da);
+}
+
+/* TX HW/SW interaction overview
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * There are 2 types of TX communication channels between driver and NIC.
+ * 1) TX Free Fifo - TXF - Holds ack descriptors for sent packets.
+ * 2) TX Data Fifo - TXD - Holds descriptors of full buffers.
+ *
+ * Currently the NIC supports TSO, checksumming and gather DMA
+ * UFO and IP fragmentation is on the way.
+ *
+ * RX SW Data Structures
+ * ~~~~~~~~~~~~~~~~~~~~~
+ * TXDB is used to keep track of all skbs owned by SW and their DMA addresses.
+ * For TX case, ownership lasts from getting the packet via hard_xmit and
+ * until the HW acknowledges sending the packet by TXF descriptors.
+ * TXDB is implemented as a cyclic buffer.
+ *
+ * FIFO objects keep info about the fifo's size and location, relevant HW
+ * registers, usage and skb db. Each RXD and RXF fifo has their own fifo
+ * structure. Implemented as simple struct.
+ *
+ * TX SW Execution Flow
+ * ~~~~~~~~~~~~~~~~~~~~
+ * OS calls the driver's hard_xmit method with a packet to send. The driver
+ * creates DMA mappings, builds TXD descriptors and kicks the HW by updating
+ * TXD WPTR.
+ *
+ * When a packet is sent, The HW write a TXF descriptor and the SW
+ * frees the original skb. To prevent TXD fifo overflow without
+ * reading HW registers every time, the SW deploys "tx level"
+ * technique. Upon startup, the tx level is initialized to TXD fifo
+ * length. For every sent packet, the SW gets its TXD descriptor size
+ * (from a pre-calculated array) and subtracts it from tx level.  The
+ * size is also stored in txdb. When a TXF ack arrives, the SW fetched
+ * the size of the original TXD descriptor from the txdb and adds it
+ * to the tx level. When the Tx level drops below some predefined
+ * threshold, the driver stops the TX queue. When the TX level rises
+ * above that level, the tx queue is enabled again.
+ *
+ * This technique avoids excessive reading of RPTR and WPTR registers.
+ * As our benchmarks shows, it adds 1.5 Gbit/sec to NIS's throughput.
+ */
+static inline void __tx_db_ptr_next(struct txdb *db, struct tx_map **pptr)
+{
+	++*pptr;
+	if (unlikely(*pptr == db->end))
+		*pptr = db->start;
+}
+
+static inline void tx_db_inc_rptr(struct txdb *db)
+{
+	__tx_db_ptr_next(db, &db->rptr);
+}
+
+static inline void tx_db_inc_wptr(struct txdb *db)
+{
+	__tx_db_ptr_next(db, &db->wptr);
+}
+
+static int tx_db_init(struct txdb *d, int sz_type)
+{
+	int memsz = FIFO_SIZE * (1 << (sz_type + 1));
+
+	d->start = vzalloc(memsz);
+	if (!d->start)
+		return -ENOMEM;
+	/* In order to differentiate between an empty db state and a full db
+	 * state at least one element should always be empty in order to
+	 * avoid rptr == wptr, which means that the db is empty.
+	 */
+	d->size = memsz / sizeof(struct tx_map) - 1;
+	d->end = d->start + d->size + 1;	/* just after last element */
+
+	/* All dbs are created empty */
+	d->rptr = d->start;
+	d->wptr = d->start;
+	return 0;
+}
+
+static void tx_db_close(struct txdb *d)
+{
+	if (d->start) {
+		vfree(d->start);
+		d->start = NULL;
+	}
+}
+
+/* Sizes of tx desc (including padding if needed) as function of the SKB's
+ * frag number
+ */
+static struct {
+	u16 bytes;
+	u16 qwords;		/* qword = 64 bit */
+} txd_sizes[MAX_PBL];
+
+inline void pbl_set(struct pbl *pbl, dma_addr_t dma, int len)
+{
+	pbl->len = cpu_to_le32(len);
+	pbl->pa_lo = cpu_to_le32(lower_32_bits(dma));
+	pbl->pa_hi = cpu_to_le32(upper_32_bits(dma));
+}
+
+static inline void txdb_set(struct txdb *db, dma_addr_t dma, int len)
+{
+	db->wptr->len = len;
+	db->wptr->addr.dma = dma;
+}
+
+struct mapping_info {
+	dma_addr_t dma;
+	size_t size;
+};
+
+/**
+ * tx_map_skb - create and store DMA mappings for skb's data blocks
+ * @priv: NIC private structure
+ * @skb: socket buffer to map
+ * @txdd: pointer to tx descriptor to be updated
+ * @pkt_len: pointer to unsigned long value
+ *
+ * This function creates DMA mappings for skb's data blocks and writes them to
+ * PBL of a new tx descriptor. It also stores them in the tx db, so they could
+ * be unmapped after the data has been sent. It is the responsibility of the
+ * caller to make sure that there is enough space in the txdb. The last
+ * element holds a pointer to skb itself and is marked with a zero length.
+ *
+ * Return: 0 on success and negative value on error.
+ */
+static inline int tx_map_skb(struct tn40_priv *priv, struct sk_buff *skb,
+			     struct txd_desc *txdd, unsigned int *pkt_len)
+{
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	struct mapping_info info[MAX_PBL];
+	struct pbl *pbl = &txdd->pbl[0];
+	struct txdb *db = &priv->txdb;
+	unsigned int size;
+	int i, len, ret;
+	dma_addr_t dma;
+
+	netdev_dbg(priv->ndev, "TX skb %p skbLen %d dataLen %d frags %d\n", skb,
+		   skb->len, skb->data_len, nr_frags);
+	if (nr_frags > MAX_PBL - 1) {
+		ret = skb_linearize(skb);
+		if (ret)
+			return ret;
+		nr_frags = skb_shinfo(skb)->nr_frags;
+	}
+	/* initial skb */
+	len = skb->len - skb->data_len;
+	dma = dma_map_single(&priv->pdev->dev, skb->data, len,
+			     DMA_TO_DEVICE);
+	ret = dma_mapping_error(&priv->pdev->dev, dma);
+	if (ret)
+		return ret;
+
+	txdb_set(db, dma, len);
+	pbl_set(pbl++, db->wptr->addr.dma, db->wptr->len);
+	*pkt_len = db->wptr->len;
+
+	for (i = 0; i < nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		size = skb_frag_size(frag);
+		dma = skb_frag_dma_map(&priv->pdev->dev, frag, 0,
+				       size, DMA_TO_DEVICE);
+
+		ret = dma_mapping_error(&priv->pdev->dev, dma);
+		if (ret)
+			goto mapping_error;
+		info[i].dma = dma;
+		info[i].size = size;
+	}
+
+	for (i = 0; i < nr_frags; i++) {
+		tx_db_inc_wptr(db);
+		txdb_set(db, info[i].dma, info[i].size);
+		pbl_set(pbl++, db->wptr->addr.dma, db->wptr->len);
+		*pkt_len += db->wptr->len;
+	}
+
+	/* SHORT_PKT_FIX */
+	if (skb->len < SHORT_PACKET_SIZE)
+		++nr_frags;
+
+	/* Add skb clean up info. */
+	tx_db_inc_wptr(db);
+	db->wptr->len = -txd_sizes[nr_frags].bytes;
+	db->wptr->addr.skb = skb;
+	tx_db_inc_wptr(db);
+
+	return 0;
+ mapping_error:
+	dma_unmap_page(&priv->pdev->dev, db->wptr->addr.dma, db->wptr->len,
+		       DMA_TO_DEVICE);
+	for (; i > 0; i--)
+		dma_unmap_page(&priv->pdev->dev, info[i - 1].dma,
+			       info[i - 1].size, DMA_TO_DEVICE);
+	return -ENOMEM;
+}
+
+static void init_txd_sizes(void)
+{
+	int i, lwords;
+
+	if (txd_sizes[0].bytes)
+		return;
+
+	/* 7 - is number of lwords in txd with one phys buffer
+	 * 3 - is number of lwords used for every additional phys buffer
+	 */
+	for (i = 0; i < MAX_PBL; i++) {
+		lwords = 7 + (i * 3);
+		if (lwords & 1)
+			lwords++;	/* pad it with 1 lword */
+		txd_sizes[i].qwords = lwords >> 1;
+		txd_sizes[i].bytes = lwords << 2;
+	}
+}
+
+static int create_tx_ring(struct tn40_priv *priv)
+{
+	int ret;
+
+	ret = tn40_fifo_alloc(priv, &priv->txd_fifo0.m, priv->txd_size,
+			      REG_TXD_CFG0_0, REG_TXD_CFG1_0,
+			      REG_TXD_RPTR_0, REG_TXD_WPTR_0);
+	if (ret)
+		return ret;
+
+	ret = tn40_fifo_alloc(priv, &priv->txf_fifo0.m, priv->txf_size,
+			      REG_TXF_CFG0_0, REG_TXF_CFG1_0,
+			      REG_TXF_RPTR_0, REG_TXF_WPTR_0);
+	if (ret)
+		goto err_free_txd;
+
+	/* The TX db has to keep mappings for all packets sent (on
+	 * TxD) and not yet reclaimed (on TxF).
+	 */
+	ret = tx_db_init(&priv->txdb, max(priv->txd_size, priv->txf_size));
+	if (ret)
+		goto err_free_txf;
+
+	/* SHORT_PKT_FIX */
+	priv->b0_len = 64;
+	priv->b0_va = dma_alloc_coherent(&priv->pdev->dev, priv->b0_len,
+					 &priv->b0_dma, GFP_KERNEL);
+	if (!priv->b0_va)
+		goto err_free_db;
+
+	priv->tx_level = TN40_MAX_TX_LEVEL;
+	priv->tx_update_mark = priv->tx_level - 1024;
+	return 0;
+err_free_db:
+	tx_db_close(&priv->txdb);
+err_free_txf:
+	tn40_fifo_free(priv, &priv->txf_fifo0.m);
+err_free_txd:
+	tn40_fifo_free(priv, &priv->txd_fifo0.m);
+	return -ENOMEM;
+}
+
+/**
+ * tn40_tx_space - Calculate the available space in the TX fifo.
+ * @priv: NIC private structure
+ *
+ * Return: available space in TX fifo in bytes
+ */
+static inline int tn40_tx_space(struct tn40_priv *priv)
+{
+	struct txd_fifo *f = &priv->txd_fifo0;
+	int fsize;
+
+	f->m.rptr = read_reg(priv, f->m.reg_rptr) & TXF_WPTR_WR_PTR;
+	fsize = f->m.rptr - f->m.wptr;
+	if (fsize <= 0)
+		fsize = f->m.memsz + fsize;
+	return fsize;
+}
+
+#define TXD_FULL_CHECKSUM 7
+
+static int tn40_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+	struct txd_fifo *f = &priv->txd_fifo0;
+	int txd_checksum = TXD_FULL_CHECKSUM;
+	int nr_frags, len, err;
+	struct txd_desc *txdd;
+	unsigned int pkt_len;
+	int txd_vlan_id = 0;
+	int txd_lgsnd = 0;
+	int txd_vtag = 0;
+	int txd_mss = 0;
+
+	/* Build tx descriptor */
+	txdd = (struct txd_desc *)(f->m.va + f->m.wptr);
+	err = tx_map_skb(priv, skb, txdd, &pkt_len);
+	if (err) {
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
+		txd_checksum = 0;
+
+	if (skb_shinfo(skb)->gso_size) {
+		txd_mss = skb_shinfo(skb)->gso_size;
+		txd_lgsnd = 1;
+		netdev_dbg(priv->ndev, "skb %p pkt len %d gso size = %d\n", skb,
+			   pkt_len, txd_mss);
+	}
+	if (skb_vlan_tag_present(skb)) {
+		/* Don't cut VLAN ID to 12 bits */
+		txd_vlan_id = skb_vlan_tag_get(skb);
+		txd_vtag = 1;
+	}
+	txdd->va_hi = 0;
+	txdd->va_lo = 0;
+	txdd->length = cpu_to_le16(pkt_len);
+	txdd->mss = cpu_to_le16(txd_mss);
+	txdd->txd_val1 =
+		cpu_to_le32(TXD_W1_VAL
+			    (txd_sizes[nr_frags].qwords, txd_checksum,
+			     txd_vtag, txd_lgsnd, txd_vlan_id));
+	netdev_dbg(priv->ndev, "=== w1 qwords[%d] %d =====\n", nr_frags,
+		   txd_sizes[nr_frags].qwords);
+	netdev_dbg(priv->ndev, "=== TxD desc =====================\n");
+	netdev_dbg(priv->ndev, "=== w1: 0x%x ================\n",
+		   txdd->txd_val1);
+	netdev_dbg(priv->ndev, "=== w2: mss 0x%x len 0x%x\n", txdd->mss,
+		   txdd->length);
+	/* SHORT_PKT_FIX */
+	if (pkt_len < SHORT_PACKET_SIZE) {
+		struct pbl *pbl = &txdd->pbl[++nr_frags];
+
+		txdd->length = cpu_to_le16(SHORT_PACKET_SIZE);
+		txdd->txd_val1 =
+			cpu_to_le32(TXD_W1_VAL
+				    (txd_sizes[nr_frags].qwords,
+				     txd_checksum, txd_vtag, txd_lgsnd,
+				     txd_vlan_id));
+		pbl->len = cpu_to_le32(SHORT_PACKET_SIZE - pkt_len);
+		pbl->pa_lo = cpu_to_le32(lower_32_bits(priv->b0_dma));
+		pbl->pa_hi = cpu_to_le32(upper_32_bits(priv->b0_dma));
+		netdev_dbg(priv->ndev, "=== SHORT_PKT_FIX   ==============\n");
+		netdev_dbg(priv->ndev, "=== nr_frags : %d   ==============\n",
+			   nr_frags);
+	}
+
+	/* Increment TXD write pointer. In case of fifo wrapping copy
+	 * reminder of the descriptor to the beginning.
+	 */
+	f->m.wptr += txd_sizes[nr_frags].bytes;
+	len = f->m.wptr - f->m.memsz;
+	if (unlikely(len >= 0)) {
+		f->m.wptr = len;
+		if (len > 0)
+			memcpy(f->m.va, f->m.va + f->m.memsz, len);
+	}
+	/* Force memory writes to complete before letting the HW know
+	 * there are new descriptors to fetch.
+	 */
+	wmb();
+
+	priv->tx_level -= txd_sizes[nr_frags].bytes;
+	if (priv->tx_level > priv->tx_update_mark) {
+		write_reg(priv, f->m.reg_wptr,
+			  f->m.wptr & TXF_WPTR_WR_PTR);
+	} else {
+		if (priv->tx_noupd++ > TN40_NO_UPD_PACKETS) {
+			priv->tx_noupd = 0;
+			write_reg(priv, f->m.reg_wptr,
+				  f->m.wptr & TXF_WPTR_WR_PTR);
+		}
+	}
+
+	netif_trans_update(ndev);
+	priv->net_stats.tx_packets++;
+	priv->net_stats.tx_bytes += pkt_len;
+	if (priv->tx_level < TN40_MIN_TX_LEVEL) {
+		netdev_dbg(priv->ndev, "TX Q STOP level %d\n", priv->tx_level);
+		netif_stop_queue(ndev);
+	}
+
+	return NETDEV_TX_OK;
+}
+
+static void tn40_tx_free_skbs(struct tn40_priv *priv)
+{
+	struct txdb *db = &priv->txdb;
+
+	while (db->rptr != db->wptr) {
+		if (likely(db->rptr->len))
+			dma_unmap_page(&priv->pdev->dev, db->rptr->addr.dma,
+				       db->rptr->len, DMA_TO_DEVICE);
+		else
+			dev_kfree_skb(db->rptr->addr.skb);
+		tx_db_inc_rptr(db);
+	}
+}
+
+static void destroy_tx_ring(struct tn40_priv *priv)
+{
+	tn40_tx_free_skbs(priv);
+	tn40_fifo_free(priv, &priv->txd_fifo0.m);
+	tn40_fifo_free(priv, &priv->txf_fifo0.m);
+	tx_db_close(&priv->txdb);
+	/* SHORT_PKT_FIX */
+	if (priv->b0_len) {
+		dma_free_coherent(&priv->pdev->dev, priv->b0_len, priv->b0_va,
+				  priv->b0_dma);
+		priv->b0_len = 0;
+	}
+}
+
+/**
+ * tx_push_desc - Push a descriptor to TxD fifo.
+ *
+ * @priv: NIC private structure
+ * @data: desc's data
+ * @size: desc's size
+ *
+ * This function pushes desc to TxD fifo and overlaps it if needed.
+ *
+ * This function does not check for available space, nor does it check
+ * that the data size is smaller than the fifo size. Checking for
+ * space is the responsibility of the caller.
+ */
+static void tx_push_desc(struct tn40_priv *priv, void *data, int size)
+{
+	struct txd_fifo *f = &priv->txd_fifo0;
+	int i = f->m.memsz - f->m.wptr;
+
+	if (size == 0)
+		return;
+
+	if (i > size) {
+		memcpy(f->m.va + f->m.wptr, data, size);
+		f->m.wptr += size;
+	} else {
+		memcpy(f->m.va + f->m.wptr, data, i);
+		f->m.wptr = size - i;
+		memcpy(f->m.va, data + i, f->m.wptr);
+	}
+	write_reg(priv, f->m.reg_wptr, f->m.wptr & TXF_WPTR_WR_PTR);
+}
+
+/**
+ * tx_push_desc_safe - push descriptor to TxD fifo in a safe way.
+ *
+ * @priv: NIC private structure
+ * @data: descriptor data
+ * @size: descriptor size
+ *
+ * This function does check for available space and, if necessary,
+ * waits for the NIC to read existing data before writing new data.
+ */
+static void tx_push_desc_safe(struct tn40_priv *priv, void *data, int size)
+{
+	int timer = 0;
+
+	while (size > 0) {
+		/* We subtract 8 because when the fifo is full rptr ==
+		 * wptr, which also means that fifo is empty, we can
+		 * understand the difference, but could the HW do the
+		 * same ???
+		 */
+		int avail = tn40_tx_space(priv) - 8;
+
+		if (avail <= 0) {
+			if (timer++ > 300) /* Prevent endless loop */
+				break;
+
+			udelay(50); /* Give the HW a chance to clean the fifo */
+			continue;
+		}
+		avail = min(avail, size);
+		netdev_dbg(priv->ndev,
+			   "about to push  %d bytes starting %p size %d\n",
+			   avail, data, size);
+		tx_push_desc(priv, data, avail);
+		size -= avail;
+		data += avail;
+	}
+}
+
+static int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
+{
+	u32 val;
+	int i;
+
+	netdev_dbg(priv->ndev, "speed %d\n", speed);
+	switch (speed) {
+	case SPEED_10000:
+	case SPEED_5000:
+	case SPEED_2500:
+		netdev_dbg(priv->ndev, "link_speed %d\n", speed);
+
+		write_reg(priv, 0x1010, 0x217);	/*ETHSD.REFCLK_CONF  */
+		write_reg(priv, 0x104c, 0x4c);	/*ETHSD.L0_RX_PCNT  */
+		write_reg(priv, 0x1050, 0x4c);	/*ETHSD.L1_RX_PCNT  */
+		write_reg(priv, 0x1054, 0x4c);	/*ETHSD.L2_RX_PCNT  */
+		write_reg(priv, 0x1058, 0x4c);	/*ETHSD.L3_RX_PCNT  */
+		write_reg(priv, 0x102c, 0x434);	/*ETHSD.L0_TX_PCNT  */
+		write_reg(priv, 0x1030, 0x434);	/*ETHSD.L1_TX_PCNT  */
+		write_reg(priv, 0x1034, 0x434);	/*ETHSD.L2_TX_PCNT  */
+		write_reg(priv, 0x1038, 0x434);	/*ETHSD.L3_TX_PCNT  */
+		write_reg(priv, 0x6300, 0x0400);	/*MAC.PCS_CTRL */
+
+		write_reg(priv, 0x1018, 0x00);	/*Mike2 */
+		udelay(5);
+		write_reg(priv, 0x1018, 0x04);	/*Mike2 */
+		udelay(5);
+		write_reg(priv, 0x1018, 0x06);	/*Mike2 */
+		udelay(5);
+		/*MikeFix1 */
+		/*L0: 0x103c , L1: 0x1040 , L2: 0x1044 , L3: 0x1048 =0x81644 */
+		write_reg(priv, 0x103c, 0x81644);	/*ETHSD.L0_TX_DCNT  */
+		write_reg(priv, 0x1040, 0x81644);	/*ETHSD.L1_TX_DCNT  */
+		write_reg(priv, 0x1044, 0x81644);	/*ETHSD.L2_TX_DCNT  */
+		write_reg(priv, 0x1048, 0x81644);	/*ETHSD.L3_TX_DCNT  */
+		write_reg(priv, 0x1014, 0x043);	/*ETHSD.INIT_STAT */
+		for (i = 1000; i; i--) {
+			udelay(50);
+			val = read_reg(priv, 0x1014);	/*ETHSD.INIT_STAT */
+			if (val & (1 << 9)) {
+				/*ETHSD.INIT_STAT */
+				write_reg(priv, 0x1014, 0x3);
+				/*ETHSD.INIT_STAT */
+				val = read_reg(priv, 0x1014);
+
+				break;
+			}
+		}
+		if (!i)
+			netdev_err(priv->ndev, "MAC init timeout!\n");
+
+		write_reg(priv, 0x6350, 0x0);	/*MAC.PCS_IF_MODE */
+		write_reg(priv, REG_CTRLST, 0xC13);	/*0x93//0x13 */
+		write_reg(priv, 0x111c, 0x7ff);	/*MAC.MAC_RST_CNT */
+		for (i = 40; i--;)
+			udelay(50);
+
+		write_reg(priv, 0x111c, 0x0);	/*MAC.MAC_RST_CNT */
+		break;
+
+	case SPEED_1000:
+	case SPEED_100:
+		write_reg(priv, 0x1010, 0x613);	/*ETHSD.REFCLK_CONF  */
+		write_reg(priv, 0x104c, 0x4d);	/*ETHSD.L0_RX_PCNT  */
+		write_reg(priv, 0x1050, 0x0);	/*ETHSD.L1_RX_PCNT  */
+		write_reg(priv, 0x1054, 0x0);	/*ETHSD.L2_RX_PCNT  */
+		write_reg(priv, 0x1058, 0x0);	/*ETHSD.L3_RX_PCNT  */
+		write_reg(priv, 0x102c, 0x35);	/*ETHSD.L0_TX_PCNT  */
+		write_reg(priv, 0x1030, 0x0);	/*ETHSD.L1_TX_PCNT  */
+		write_reg(priv, 0x1034, 0x0);	/*ETHSD.L2_TX_PCNT  */
+		write_reg(priv, 0x1038, 0x0);	/*ETHSD.L3_TX_PCNT  */
+		write_reg(priv, 0x6300, 0x01140);	/*MAC.PCS_CTRL */
+
+		write_reg(priv, 0x1014, 0x043);	/*ETHSD.INIT_STAT */
+		for (i = 1000; i; i--) {
+			udelay(50);
+			val = read_reg(priv, 0x1014);	/*ETHSD.INIT_STAT */
+			if (val & (1 << 9)) {
+				/*ETHSD.INIT_STAT */
+				write_reg(priv, 0x1014, 0x3);
+				/*ETHSD.INIT_STAT */
+				val = read_reg(priv, 0x1014);
+
+				break;
+			}
+		}
+		if (!i)
+			netdev_err(priv->ndev, "MAC init timeout!\n");
+
+		write_reg(priv, 0x6350, 0x2b);	/*MAC.PCS_IF_MODE 1g */
+		write_reg(priv, 0x6310, 0x9801);	/*MAC.PCS_DEV_AB */
+
+		write_reg(priv, 0x6314, 0x1);	/*MAC.PCS_PART_AB */
+		write_reg(priv, 0x6348, 0xc8);	/*MAC.PCS_LINK_LO */
+		write_reg(priv, 0x634c, 0xc8);	/*MAC.PCS_LINK_HI */
+		udelay(50);
+		write_reg(priv, REG_CTRLST, 0xC13);	/*0x93//0x13 */
+		write_reg(priv, 0x111c, 0x7ff);	/*MAC.MAC_RST_CNT */
+		for (i = 40; i--;)
+			udelay(50);
+
+		write_reg(priv, 0x111c, 0x0);	/*MAC.MAC_RST_CNT */
+		write_reg(priv, 0x6300, 0x1140);	/*MAC.PCS_CTRL */
+		break;
+
+	case 0:		/* Link down */
+		write_reg(priv, 0x104c, 0x0);	/*ETHSD.L0_RX_PCNT  */
+		write_reg(priv, 0x1050, 0x0);	/*ETHSD.L1_RX_PCNT  */
+		write_reg(priv, 0x1054, 0x0);	/*ETHSD.L2_RX_PCNT  */
+		write_reg(priv, 0x1058, 0x0);	/*ETHSD.L3_RX_PCNT  */
+		write_reg(priv, 0x102c, 0x0);	/*ETHSD.L0_TX_PCNT  */
+		write_reg(priv, 0x1030, 0x0);	/*ETHSD.L1_TX_PCNT  */
+		write_reg(priv, 0x1034, 0x0);	/*ETHSD.L2_TX_PCNT  */
+		write_reg(priv, 0x1038, 0x0);	/*ETHSD.L3_TX_PCNT  */
+
+		write_reg(priv, REG_CTRLST, 0x800);
+		write_reg(priv, 0x111c, 0x7ff);	/*MAC.MAC_RST_CNT */
+		for (i = 40; i--;)
+			udelay(50);
+		write_reg(priv, 0x111c, 0x0);	/*MAC.MAC_RST_CNT */
+		break;
+
+	default:
+		netdev_err(priv->ndev,
+			   "Link speed was not identified yet (%d)\n", speed);
+		speed = 0;
+		break;
+	}
+	return speed;
+}
+
+#define LINK_LOOP_MAX 10
+
+static void tn40_link_changed(struct tn40_priv *priv)
+{
+	u32 link = read_reg(priv, REG_MAC_LNK_STAT) & MAC_LINK_STAT;
+
+	if (!link) {
+		if (netif_carrier_ok(priv->ndev) && priv->link)
+			netif_stop_queue(priv->ndev);
+
+		priv->link = 0;
+		if (priv->link_loop_cnt++ > LINK_LOOP_MAX) {
+			/* MAC reset */
+			tn40_set_link_speed(priv, 0);
+			priv->link_loop_cnt = 0;
+		}
+		write_reg(priv, 0x5150, 1000000);
+		return;
+	}
+	if (!netif_carrier_ok(priv->ndev) && !link)
+		netif_wake_queue(priv->ndev);
+
+	priv->link = link;
+}
+
+static inline void tn40_isr_extra(struct tn40_priv *priv, u32 isr)
+{
+	if (isr & (IR_LNKCHG0 | IR_LNKCHG1 | IR_TMR0)) {
+		netdev_dbg(priv->ndev, "isr = 0x%x\n", isr);
+		tn40_link_changed(priv);
+	}
+}
+
+static irqreturn_t tn40_isr_napi(int irq, void *dev)
+{
+	struct tn40_priv *priv = netdev_priv((struct net_device *)dev);
+	u32 isr;
+
+	isr = read_reg(priv, REG_ISR_MSK0);
+
+	if (unlikely(!isr)) {
+		tn40_enable_interrupts(priv);
+		return IRQ_NONE;	/* Not our interrupt */
+	}
+
+	if (isr & IR_EXTRA)
+		tn40_isr_extra(priv, isr);
+
+	if (isr & (IR_RX_DESC_0 | IR_TX_FREE_0 | IR_TMR1)) {
+		/* We get here if an interrupt has slept into the
+		 * small time window between these lines in
+		 * tn40_poll: tn40_enable_interrupts(priv); return 0;
+		 *
+		 * Currently interrupts are disabled (since we read
+		 * the ISR register) and we have failed to register
+		 * the next poll. So we read the regs to trigger the
+		 * chip and allow further interrupts.
+		 */
+		read_reg(priv, REG_TXF_WPTR_0);
+		read_reg(priv, REG_RXD_WPTR_0);
+	}
+
+	tn40_enable_interrupts(priv);
+	return IRQ_HANDLED;
+}
+
+static int tn40_fw_load(struct tn40_priv *priv)
+{
+	const struct firmware *fw = NULL;
+	int master, i, ret;
+
+	ret = request_firmware(&fw, FIRMWARE_NAME, &priv->pdev->dev);
+	if (ret)
+		return ret;
+
+	master = read_reg(priv, REG_INIT_SEMAPHORE);
+	if (!read_reg(priv, REG_INIT_STATUS) && master) {
+		netdev_dbg(priv->ndev, "Loading FW...\n");
+		tx_push_desc_safe(priv, (void *)fw->data, fw->size);
+		mdelay(100);
+	}
+	for (i = 0; i < 200; i++) {
+		if (read_reg(priv, REG_INIT_STATUS))
+			break;
+		mdelay(2);
+	}
+	if (master)
+		write_reg(priv, REG_INIT_SEMAPHORE, 1);
+
+	if (i == 200) {
+		netdev_err(priv->ndev, "firmware loading failed\n");
+		netdev_dbg(priv->ndev, "VPC: 0x%x VIC: 0x%x STATUS: 0x%xd\n",
+			   read_reg(priv, REG_VPC), read_reg(priv, REG_VIC),
+			   read_reg(priv, REG_INIT_STATUS));
+		ret = -EIO;
+	} else {
+		netdev_dbg(priv->ndev, "firmware loading success\n");
+	}
+	release_firmware(fw);
+	return ret;
+}
+
+static void tn40_restore_mac(struct net_device *ndev, struct tn40_priv *priv)
+{
+	u32 val;
+
+	netdev_dbg(priv->ndev, "mac0 =%x mac1 =%x mac2 =%x\n",
+		   read_reg(priv, REG_UNC_MAC0_A),
+		   read_reg(priv, REG_UNC_MAC1_A),
+		   read_reg(priv, REG_UNC_MAC2_A));
+
+	val = (ndev->dev_addr[0] << 8) | (ndev->dev_addr[1]);
+	write_reg(priv, REG_UNC_MAC2_A, val);
+	val = (ndev->dev_addr[2] << 8) | (ndev->dev_addr[3]);
+	write_reg(priv, REG_UNC_MAC1_A, val);
+	val = (ndev->dev_addr[4] << 8) | (ndev->dev_addr[5]);
+	write_reg(priv, REG_UNC_MAC0_A, val);
+
+	/* More then IP MAC address */
+	write_reg(priv, REG_MAC_ADDR_0,
+		  (ndev->dev_addr[3] << 24) | (ndev->dev_addr[2] << 16) |
+		  (ndev->dev_addr[1]
+		   << 8) | (ndev->dev_addr[0]));
+	write_reg(priv, REG_MAC_ADDR_1,
+		  (ndev->dev_addr[5] << 8) | (ndev->dev_addr[4]));
+
+	netdev_dbg(priv->ndev, "mac0 =%x mac1 =%x mac2 =%x\n",
+		   read_reg(priv, REG_UNC_MAC0_A),
+		   read_reg(priv, REG_UNC_MAC1_A),
+		   read_reg(priv, REG_UNC_MAC2_A));
+}
+
+static void tn40_hw_start(struct tn40_priv *priv)
+{
+	write_reg(priv, REG_FRM_LENGTH, 0X3FE0);
+	write_reg(priv, REG_GMAC_RXF_A, 0X10fd);
+	/*MikeFix1 */
+	/*L0: 0x103c , L1: 0x1040 , L2: 0x1044 , L3: 0x1048 =0x81644 */
+	write_reg(priv, 0x103c, 0x81644);	/*ETHSD.L0_TX_DCNT  */
+	write_reg(priv, 0x1040, 0x81644);	/*ETHSD.L1_TX_DCNT  */
+	write_reg(priv, 0x1044, 0x81644);	/*ETHSD.L2_TX_DCNT  */
+	write_reg(priv, 0x1048, 0x81644);	/*ETHSD.L3_TX_DCNT  */
+	write_reg(priv, REG_RX_FIFO_SECTION, 0x10);
+	write_reg(priv, REG_TX_FIFO_SECTION, 0xE00010);
+	write_reg(priv, REG_RX_FULLNESS, 0);
+	write_reg(priv, REG_TX_FULLNESS, 0);
+
+	write_reg(priv, REG_VGLB, 0);
+	write_reg(priv, REG_RDINTCM0, priv->rdintcm);
+	write_reg(priv, REG_RDINTCM2, 0);
+
+	write_reg(priv, REG_TDINTCM0, priv->tdintcm);	/* old val = 0x300064 */
+
+	/* Enable timer interrupt once in 2 secs. */
+	tn40_restore_mac(priv->ndev, priv);
+
+	/* Pause frame */
+	write_reg(priv, 0x12E0, 0x28);
+	write_reg(priv, REG_PAUSE_QUANT, 0xFFFF);
+	write_reg(priv, 0x6064, 0xF);
+
+	write_reg(priv, REG_GMAC_RXF_A,
+		  GMAC_RX_FILTER_OSEN | GMAC_RX_FILTER_TXFC | GMAC_RX_FILTER_AM
+		  | GMAC_RX_FILTER_AB);
+
+	tn40_link_changed(priv);
+	tn40_enable_interrupts(priv);
+}
+
+static int tn40_hw_reset(struct tn40_priv *priv)
+{
+	u32 val, i;
+
+	/* Reset sequences: read, write 1, read, write 0 */
+	val = read_reg(priv, REG_CLKPLL);
+	write_reg(priv, REG_CLKPLL, (val | CLKPLL_SFTRST) + 0x8);
+	udelay(50);
+	val = read_reg(priv, REG_CLKPLL);
+	write_reg(priv, REG_CLKPLL, val & ~CLKPLL_SFTRST);
+
+	/* Check that the PLLs are locked and reset ended */
+	for (i = 0; i < 70; i++, mdelay(10)) {
+		if ((read_reg(priv, REG_CLKPLL) & CLKPLL_LKD) == CLKPLL_LKD) {
+			udelay(50);
+			/* Do any PCI-E read transaction */
+			read_reg(priv, REG_RXD_CFG0_0);
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void tn40_sw_reset(struct tn40_priv *priv)
+{
+	int i;
+
+	/* 1. load MAC (obsolete) */
+	/* 2. disable Rx (and Tx) */
+	write_reg(priv, REG_GMAC_RXF_A, 0);
+	mdelay(100);
+	/* 3. Disable port */
+	write_reg(priv, REG_DIS_PORT, 1);
+	/* 4. Disable queue */
+	write_reg(priv, REG_DIS_QU, 1);
+	/* 5. Wait until hw is disabled */
+	for (i = 0; i < 50; i++) {
+		if (read_reg(priv, REG_RST_PORT) & 1)
+			break;
+		mdelay(10);
+	}
+	if (i == 50)
+		netdev_err(priv->ndev, "SW reset timeout. continuing anyway\n");
+
+	/* 6. Disable interrupts */
+	write_reg(priv, REG_RDINTCM0, 0);
+	write_reg(priv, REG_TDINTCM0, 0);
+	write_reg(priv, REG_IMR, 0);
+	read_reg(priv, REG_ISR);
+
+	/* 7. Reset queue */
+	write_reg(priv, REG_RST_QU, 1);
+	/* 8. Reset port */
+	write_reg(priv, REG_RST_PORT, 1);
+	/* 9. Zero all read and write pointers */
+	for (i = REG_TXD_WPTR_0; i <= REG_TXF_RPTR_3; i += 0x10)
+		write_reg(priv, i, 0);
+	/* 10. Unset port disable */
+	write_reg(priv, REG_DIS_PORT, 0);
+	/* 11. Unset queue disable */
+	write_reg(priv, REG_DIS_QU, 0);
+	/* 12. Unset queue reset */
+	write_reg(priv, REG_RST_QU, 0);
+	/* 13. Unset port reset */
+	write_reg(priv, REG_RST_PORT, 0);
+	/* 14. Enable Rx */
+	/* Skipped. will be done later */
+}
+
+static int tn40_start(struct tn40_priv *priv)
+{
+	int ret;
+
+	ret = create_tx_ring(priv);
+	if (ret) {
+		netdev_err(priv->ndev, "failed to tx init %d\n", ret);
+		return ret;
+	}
+
+	ret = request_irq(priv->pdev->irq, &tn40_isr_napi, IRQF_SHARED,
+			  priv->ndev->name, priv->ndev);
+	if (ret) {
+		netdev_err(priv->ndev, "failed to request irq %d\n", ret);
+		goto err_tx_ring;
+	}
+
+	tn40_hw_start(priv);
+	return 0;
+err_tx_ring:
+	destroy_tx_ring(priv);
+	return ret;
+}
+
+static int tn40_close(struct net_device *ndev)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+
+	tn40_disable_interrupts(priv);
+	free_irq(priv->pdev->irq, priv->ndev);
+	tn40_sw_reset(priv);
+	destroy_tx_ring(priv);
+	return 0;
+}
+
+static int tn40_open(struct net_device *dev)
+{
+	struct tn40_priv *priv = netdev_priv(dev);
+	int ret;
+
+	tn40_sw_reset(priv);
+	ret = tn40_start(priv);
+	if (ret) {
+		netdev_err(dev, "failed to start %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static void __tn40_vlan_rx_vid(struct net_device *ndev, uint16_t vid,
+			       int enable)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+	u32 reg, bit, val;
+
+	netdev_dbg(priv->ndev, "vid =%d value =%d\n", (int)vid, enable);
+	if (unlikely(vid >= 4096)) {
+		netdev_err(priv->ndev, "invalid VID: %u (> 4096)\n", vid);
+		return;
+	}
+	reg = REG_VLAN_0 + (vid / 32) * 4;
+	bit = 1 << vid % 32;
+	val = read_reg(priv, reg);
+	netdev_dbg(priv->ndev, "reg =%x, val =%x, bit =%d\n", reg, val, bit);
+	if (enable)
+		val |= bit;
+	else
+		val &= ~bit;
+	netdev_dbg(priv->ndev, "new val %x\n", val);
+	write_reg(priv, reg, val);
+}
+
+static int tn40_vlan_rx_add_vid(struct net_device *ndev,
+				__always_unused __be16 proto, u16 vid)
+{
+	__tn40_vlan_rx_vid(ndev, vid, 1);
+	return 0;
+}
+
+static int tn40_vlan_rx_kill_vid(struct net_device *ndev,
+				 __always_unused __be16 proto, u16 vid)
+{
+	__tn40_vlan_rx_vid(ndev, vid, 0);
+	return 0;
+}
+
+static void tn40_setmulti(struct net_device *ndev)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+
+	u32 rxf_val =
+	    GMAC_RX_FILTER_AM | GMAC_RX_FILTER_AB | GMAC_RX_FILTER_OSEN |
+	    GMAC_RX_FILTER_TXFC;
+	int i;
+
+	/* IMF - imperfect (hash) rx multicast filter */
+	/* PMF - perfect rx multicast filter */
+
+	/* FIXME: RXE(OFF) */
+	if (ndev->flags & IFF_PROMISC) {
+		rxf_val |= GMAC_RX_FILTER_PRM;
+	} else if (ndev->flags & IFF_ALLMULTI) {
+		/* set IMF to accept all multicast frames */
+		for (i = 0; i < MAC_MCST_HASH_NUM; i++)
+			write_reg(priv, REG_RX_MCST_HASH0 + i * 4, ~0);
+	} else if (netdev_mc_count(ndev)) {
+		u8 hash;
+		struct netdev_hw_addr *mclist;
+		u32 reg, val;
+
+		/* Set IMF to deny all multicast frames */
+		for (i = 0; i < MAC_MCST_HASH_NUM; i++)
+			write_reg(priv, REG_RX_MCST_HASH0 + i * 4, 0);
+
+		/* Set PMF to deny all multicast frames */
+		for (i = 0; i < MAC_MCST_NUM; i++) {
+			write_reg(priv, REG_RX_MAC_MCST0 + i * 8, 0);
+			write_reg(priv, REG_RX_MAC_MCST1 + i * 8, 0);
+		}
+		/* Use PMF to accept first MAC_MCST_NUM (15) addresses */
+
+		/* TBD: Sort the addresses and write them in ascending
+		 * order into RX_MAC_MCST regs. we skip this phase now
+		 * and accept ALL multicast frames through IMF. Accept
+		 * the rest of addresses throw IMF.
+		 */
+		netdev_for_each_mc_addr(mclist, ndev) {
+			hash = 0;
+			for (i = 0; i < ETH_ALEN; i++)
+				hash ^= mclist->addr[i];
+
+			reg = REG_RX_MCST_HASH0 + ((hash >> 5) << 2);
+			val = read_reg(priv, reg);
+			val |= (1 << (hash % 32));
+			write_reg(priv, reg, val);
+		}
+	} else {
+		rxf_val |= GMAC_RX_FILTER_AB;
+	}
+	write_reg(priv, REG_GMAC_RXF_A, rxf_val);
+	/* Enable RX */
+	/* FIXME: RXE(ON) */
+}
+
+static int tn40_set_mac(struct net_device *ndev, void *p)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+	struct sockaddr *addr = p;
+
+	eth_hw_addr_set(ndev, addr->sa_data);
+	tn40_restore_mac(ndev, priv);
+	return 0;
+}
+
+static void tn40_mac_init(struct tn40_priv *priv)
+{
+	u8 addr[ETH_ALEN];
+	u64 val;
+
+	val = (u64)read_reg(priv, REG_UNC_MAC0_A);
+	val |= (u64)read_reg(priv, REG_UNC_MAC1_A) << 16;
+	val |= (u64)read_reg(priv, REG_UNC_MAC2_A) << 32;
+
+	u64_to_ether_addr(val, addr);
+	eth_hw_addr_set(priv->ndev, addr);
+}
+
+static struct net_device_stats *tn40_get_stats(struct net_device *ndev)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+
+	return &priv->net_stats;
+}
+
+static const struct net_device_ops tn40_netdev_ops = {
+	.ndo_open = tn40_open,
+	.ndo_stop = tn40_close,
+	.ndo_start_xmit = tn40_start_xmit,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_set_rx_mode = tn40_setmulti,
+	.ndo_get_stats = tn40_get_stats,
+	.ndo_set_mac_address = tn40_set_mac,
+	.ndo_vlan_rx_add_vid = tn40_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = tn40_vlan_rx_kill_vid,
+};
+
+static int tn40_priv_init(struct tn40_priv *priv)
+{
+	int ret;
+
+	ret = tn40_hw_reset(priv);
+	if (ret)
+		return ret;
+
+	/* Set GPIO[9:0] to output 0 */
+	write_reg(priv, 0x51E0, 0x30010006);	/* GPIO_OE_ WR CMD */
+	write_reg(priv, 0x51F0, 0x0);	/* GPIO_OE_ DATA */
+	write_reg(priv, REG_MDIO_CMD_STAT, 0x3ec8);
+
+	// we use tx descriptors to load a firmware.
+	ret = create_tx_ring(priv);
+	if (ret)
+		return ret;
+	ret = tn40_fw_load(priv);
+	destroy_tx_ring(priv);
+	return ret;
+}
+
+static struct net_device *tn40_netdev_alloc(struct pci_dev *pdev)
+{
+	struct net_device *ndev;
+
+	ndev = devm_alloc_etherdev(&pdev->dev, sizeof(struct tn40_priv));
+	if (!ndev)
+		return NULL;
+	ndev->netdev_ops = &tn40_netdev_ops;
+	ndev->tx_queue_len = TN40_NDEV_TXQ_LEN;
+	ndev->mem_start = pci_resource_start(pdev, 0);
+	ndev->mem_end = pci_resource_end(pdev, 0);
+	ndev->min_mtu = ETH_ZLEN;
+	ndev->max_mtu = TN40_MAX_MTU;
+
+	ndev->features = NETIF_F_IP_CSUM |
+		NETIF_F_SG |
+		NETIF_F_FRAGLIST |
+		NETIF_F_TSO | NETIF_F_GRO |
+		NETIF_F_RXCSUM |
+		NETIF_F_RXHASH |
+		NETIF_F_HW_VLAN_CTAG_TX |
+		NETIF_F_HW_VLAN_CTAG_RX |
+		NETIF_F_HW_VLAN_CTAG_FILTER;
+	ndev->vlan_features = NETIF_F_IP_CSUM |
+			       NETIF_F_SG |
+			       NETIF_F_TSO | NETIF_F_GRO | NETIF_F_RXHASH;
+
+	if (dma_get_mask(&pdev->dev) == DMA_BIT_MASK(64)) {
+		ndev->features |= NETIF_F_HIGHDMA;
+		ndev->vlan_features |= NETIF_F_HIGHDMA;
+	}
+	ndev->hw_features |= ndev->features;
+
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+	netif_carrier_off(ndev);
+	netif_stop_queue(ndev);
+	return ndev;
+}
+
 static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	struct net_device *ndev;
+	struct tn40_priv *priv;
+	unsigned int nvec = 1;
+	void __iomem *regs;
 	int ret;
 
+	init_txd_sizes();
+
 	ret = pci_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -18,7 +1175,84 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			goto err_disable_device;
 		}
 	}
+
+	ret = pci_request_regions(pdev, TN40_DRV_NAME);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request PCI regions.\n");
+		goto err_disable_device;
+	}
+
+	pci_set_master(pdev);
+
+	regs = pci_iomap(pdev, 0, TN40_REGS_SIZE);
+	if (!regs) {
+		ret = -EIO;
+		dev_err(&pdev->dev, "failed to map PCI bar.\n");
+		goto err_free_regions;
+	}
+
+	ndev = tn40_netdev_alloc(pdev);
+	if (!ndev) {
+		ret = -ENOMEM;
+		dev_err(&pdev->dev, "failed to allocate netdev.\n");
+		goto err_iounmap;
+	}
+
+	priv = netdev_priv(ndev);
+	pci_set_drvdata(pdev, priv);
+
+	priv->regs = regs;
+	priv->pdev = pdev;
+	priv->ndev = ndev;
+	/* Initialize fifo sizes. */
+	priv->txd_size = 3;
+	priv->txf_size = 3;
+	priv->rxd_size = 3;
+	priv->rxf_size = 3;
+	/* Initialize the initial coalescing registers. */
+	priv->rdintcm = INT_REG_VAL(0x20, 1, 4, 12);
+	priv->tdintcm = INT_REG_VAL(0x20, 1, 0, 12);
+
+	ret = tn40_hw_reset(priv);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to reset HW.\n");
+		goto err_unset_drvdata;
+	}
+
+	ret = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to allocate irq.\n");
+		goto err_unset_drvdata;
+	}
+
+	priv->stats_flag = ((read_reg(priv, FPGA_VER) & 0xFFF) != 308);
+
+	priv->isr_mask =
+	    IR_RX_FREE_0 | IR_LNKCHG0 | IR_PSE | IR_TMR0 | IR_RX_DESC_0 |
+	    IR_TX_FREE_0 | IR_TMR1;
+
+	tn40_mac_init(priv);
+
+	ret = tn40_priv_init(priv);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize tn40_priv.\n");
+		goto err_free_irq;
+	}
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register netdev.\n");
+		goto err_free_irq;
+	}
 	return 0;
+err_free_irq:
+	pci_free_irq_vectors(pdev);
+err_unset_drvdata:
+	pci_set_drvdata(pdev, NULL);
+err_iounmap:
+	iounmap(regs);
+err_free_regions:
+	pci_release_regions(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
 	return ret;
@@ -26,6 +1260,15 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 static void tn40_remove(struct pci_dev *pdev)
 {
+	struct tn40_priv *priv = pci_get_drvdata(pdev);
+	struct net_device *ndev = priv->ndev;
+
+	unregister_netdev(ndev);
+
+	pci_free_irq_vectors(priv->pdev);
+	pci_set_drvdata(pdev, NULL);
+	iounmap(priv->regs);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 
@@ -54,4 +1297,5 @@ MODULE_DEVICE_TABLE(pci, tn40_id_table);
 MODULE_AUTHOR("Tehuti networks");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Tehuti Network TN40xx Driver");
+MODULE_FIRMWARE(FIRMWARE_NAME);
 MODULE_VERSION(TN40_DRV_VERSION);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index b4978f92574a..0cf2eca0ae1a 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -4,8 +4,20 @@
 #ifndef _TN40_H_
 #define _TN40_H_
 
+#include <linux/delay.h>
+#include <linux/etherdevice.h>
+#include <linux/firmware.h>
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/in.h>
+#include <linux/interrupt.h>
+#include <linux/ip.h>
 #include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phy.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
 
 #include "tn40_regs.h"
 
@@ -14,4 +26,171 @@
 
 #define PCI_VENDOR_ID_EDIMAX 0x1432
 
+#define MDIO_SPEED_1MHZ (1)
+#define MDIO_SPEED_6MHZ (6)
+
+/* netdev tx queue len for Luxor. The default value is 1000.
+ * ifconfig eth1 txqueuelen 3000 - to change it at runtime.
+ */
+#define TN40_NDEV_TXQ_LEN 3000
+
+#define FIFO_SIZE 4096
+#define FIFO_EXTRA_SPACE 1024
+
+#define TN40_TXF_DESC_SZ 16
+#define TN40_MAX_TX_LEVEL (priv->txd_fifo0.m.memsz - 16)
+#define TN40_MIN_TX_LEVEL 256
+#define TN40_NO_UPD_PACKETS 40
+#define TN40_MAX_MTU BIT(14)
+
+#define PCK_TH_MULT 128
+#define INT_COAL_MULT 2
+
+#define INT_REG_VAL(coal, coal_rc, rxf_th, pck_th) (	\
+	FIELD_PREP(GENMASK(14, 0), (coal)) |		\
+	FIELD_PREP(BIT(15), (coal_rc)) |		\
+	FIELD_PREP(GENMASK(19, 16), (rxf_th)) |		\
+	FIELD_PREP(GENMASK(31, 20), (pck_th))		\
+	)
+
+struct fifo {
+	dma_addr_t da; /* Physical address of fifo (used by HW) */
+	char *va; /* Virtual address of fifo (used by SW) */
+	u32 rptr, wptr;
+	 /* Cached values of RPTR and WPTR registers,
+	  * they're 32 bits on both 32 and 64 archs.
+	  */
+	u16 reg_cfg0;
+	u16 reg_cfg1;
+	u16 reg_rptr;
+	u16 reg_wptr;
+	u16 memsz; /* Memory size allocated for fifo */
+	u16 size_mask;
+	u16 pktsz; /* Skb packet size to allocate */
+	u16 rcvno; /* Number of buffers that come from this RXF */
+};
+
+struct txf_fifo {
+	struct fifo m; /* The minimal set of variables used by all fifos */
+};
+
+struct txd_fifo {
+	struct fifo m; /* The minimal set of variables used by all fifos */
+};
+
+union tx_dma_addr {
+	dma_addr_t dma;
+	struct sk_buff *skb;
+};
+
+/* Entry in the db.
+ * if len == 0 addr is dma
+ * if len != 0 addr is skb
+ */
+struct tx_map {
+	union tx_dma_addr addr;
+	int len;
+};
+
+/* tx database - implemented as circular fifo buffer */
+struct txdb {
+	struct tx_map *start; /* Points to the first element */
+	struct tx_map *end; /* Points just AFTER the last element */
+	struct tx_map *rptr; /* Points to the next element to read */
+	struct tx_map *wptr; /* Points to the next element to write */
+	int size; /* Number of elements in the db */
+};
+
+struct tn40_priv {
+	struct net_device *ndev;
+	struct pci_dev *pdev;
+
+	/* Tx FIFOs: 1 for data desc, 1 for empty (acks) desc */
+	struct txd_fifo txd_fifo0;
+	struct txf_fifo txf_fifo0;
+	struct txdb txdb;
+	int tx_level;
+	int tx_update_mark;
+	int tx_noupd;
+
+	int stats_flag;
+	struct net_device_stats net_stats;
+
+	u8 txd_size;
+	u8 txf_size;
+	u8 rxd_size;
+	u8 rxf_size;
+	u32 rdintcm;
+	u32 tdintcm;
+
+	u32 isr_mask;
+	int link;
+	u32 link_loop_cnt;
+
+	void __iomem *regs;
+
+	/* SHORT_PKT_FIX */
+	u32 b0_len;
+	dma_addr_t b0_dma; /* Physical address of buffer */
+	char *b0_va; /* Virtual address of buffer */
+};
+
+#define MAX_PBL (19)
+/* PBL describes each virtual buffer to be transmitted from the host. */
+struct pbl {
+	__le32 pa_lo;
+	__le32 pa_hi;
+	__le32 len;
+};
+
+/* First word for TXD descriptor. It means: type = 3 for regular Tx packet,
+ * hw_csum = 7 for IP+UDP+TCP HW checksums.
+ */
+#define TXD_W1_VAL(bc, checksum, vtag, lgsnd, vlan_id) (		\
+	GENMASK(17, 16) |						\
+	FIELD_PREP(GENMASK(4, 0), (bc)) |				\
+	FIELD_PREP(GENMASK(7, 5), (checksum)) |				\
+	FIELD_PREP(BIT(8), (vtag)) |					\
+	FIELD_PREP(GENMASK(12, 9), (lgsnd)) |				\
+	FIELD_PREP(GENMASK(15, 13),					\
+		   FIELD_GET(GENMASK(15, 13), (vlan_id))) |		\
+	FIELD_PREP(GENMASK(31, 20),					\
+		   FIELD_GET(GENMASK(11, 0), (vlan_id)))		\
+	)
+
+struct txd_desc {
+	__le32 txd_val1;
+	__le16 mss;
+	__le16 length;
+	__le32 va_lo;
+	__le32 va_hi;
+	struct pbl pbl[]; /* Fragments */
+} __packed;
+
+struct txf_desc {
+	u32 status;
+	u32 va_lo; /* VAdr[31:0] */
+	u32 va_hi; /* VAdr[63:32] */
+	u32 pad;
+} __packed;
+
+/* 32 bit kernels use 16 bits for page_offset. Do not increase
+ * LUXOR__MAX_PAGE_SIZE beyond 64K!
+ */
+#if BITS_PER_LONG > 32
+#define LUXOR__MAX_PAGE_SIZE 0x40000
+#else
+#define LUXOR__MAX_PAGE_SIZE 0x10000
+#endif
+
+static inline u32 read_reg(struct tn40_priv *priv, u32 reg)
+{
+	return readl(priv->regs + reg);
+}
+
+static inline void write_reg(struct tn40_priv *priv, u32 reg, u32 val)
+{
+	writel(val, priv->regs + reg);
+}
+
 #endif /* _TN40XX_H */
-- 
2.34.1


