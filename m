Return-Path: <netdev+bounces-104333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE690C30C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695F71C22098
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED51C2A8;
	Tue, 18 Jun 2024 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMoheu/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D5288BD
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687890; cv=none; b=ce9/bGr4GrOOCisNIc5eig/yMJcf7gI+zopbfbcB7F0JKuo2Q2IoIL3eAGXRl5LoF84uzpBlN6UJSZZrwD6OeAoBeXx5d37QQa/twLbxq30vFjI3F598EppksnX/t8kF9vvlg9Mdo06bU7Lf4NGgu317TBQr2XLPKffvf567zak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687890; c=relaxed/simple;
	bh=YM/dhV6faxN3O/elpgBnBs7AZ0UqYg6DXQ45DitTOSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZSoa+y2uOYniJcPGRaI03fAUJcNJaQdBwX3VKyZ+fHYLdZDgXJqrkj4st9bl7oU0hiEo6q4cnZMktqQnitDvWiJQ5trsApcoWmtYTGcG/fb9MM47OV/Ef40x4auuvbwxVZUGItNd6cDAjgHvbgtW6wu2NTGCz/BnPIvADkQHJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMoheu/m; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2c1473f73so734611a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 22:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718687886; x=1719292686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+OGkQFtXlMNlA+M6Np4YYg0jmHD5jfgeUaflwiuV7M=;
        b=cMoheu/mZVunMwbodIczAegxDWp500u2nmlXBPtw5W1yqpaXVipyk8PmagyXPzM2OT
         TofZXVf1Fk487m0jXSI16gDAe4OinngWsDpgRN5M9lskOq4KQWAUwtO0lswxGTmefuuW
         fZWSe7Ju+qqJ48E8oUuZfz5mNCv+YMDAJAuCZBlPRJewIyczkJXEap2nHPpyENvE5D5c
         WRt5FvomSFQU6lBcZG076oD3+hLZjPN34Z0ho7qixhR+ylIjAw7IVrv5KKaZA19M4gL8
         uytp0U99pGrsNcAWLKXOeRNSL/rXNfToYXnrl4z+Q0LojGJDXpCgSq/EMHH31viNLnlh
         /ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718687886; x=1719292686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+OGkQFtXlMNlA+M6Np4YYg0jmHD5jfgeUaflwiuV7M=;
        b=NwB113WCAQpErrUmk/6fdX5N/0AJsYl3CkbgLkjHJsTKSz9IkTK+l7bN+H3/d08aY7
         tUgt2xf7Rg5eXa6lmYVX4PPJ/wpEOcRw6fEJf/9/9gBYUZJGnwDrgLK8QW1zZ6a71qUF
         RplWp++P/lDI3jp3vYs/bUu8YifuloiX7ROAYWk11G1a1nTAIArMgsvamUuYwCjp+nVs
         2F7SDz9fmXsp6MwiOHhVKTWkzj1IFHceamoHxVYNhzYFWyAmsfl3z0iGtegpnP/Myomu
         eFuqfMEJ5+sdnK8Af4fG83+DDSnC94E54hI7y+Mj34AK7ECkHRq+v/t3q9XxLdDj5HSU
         XNgQ==
X-Gm-Message-State: AOJu0YzgzhD575F1Zd+zVSGcwul5zALZBv7lE9Va3YIEx0m6nz0EdLsQ
	CtxnA3/7rPW6FyGp4xayYCmvyxTeUNubyDOvHfLnYqHx6rQfUrAOb6jfRSUj
X-Google-Smtp-Source: AGHT+IGDIuNEsyXzeTm12pICLikfpt4TlC+1jUFw2Ulko2Y43aA+Wjcu1QpipfPBv9b8UmEVGTqm3g==
X-Received: by 2002:a17:902:d48a:b0:1f7:2576:7f88 with SMTP id d9443c01a7336-1f862b260d3mr142100325ad.6.1718687885793;
        Mon, 17 Jun 2024 22:18:05 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6debasm88165575ad.65.2024.06.17.22.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:18:05 -0700 (PDT)
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
Subject: [PATCH net-next v11 4/7] net: tn40xx: add basic Tx handling
Date: Tue, 18 Jun 2024 14:16:05 +0900
Message-Id: <20240618051608.95208-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618051608.95208-1-fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c  | 1258 +++++++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h  |  157 ++++
 3 files changed, 1416 insertions(+)

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
index 248b17366680..025aea5a1733 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1,12 +1,1181 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright (c) Tehuti Networks Ltd. */
 
+#include <linux/bitfield.h>
+#include <linux/ethtool.h>
+#include <linux/firmware.h>
+#include <linux/if_vlan.h>
+#include <linux/iopoll.h>
+#include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/vmalloc.h>
 
 #include "tn40.h"
 
+#define TN40_SHORT_PACKET_SIZE 60
+#define TN40_FIRMWARE_NAME "tehuti/bdx.bin"
+
+static void tn40_enable_interrupts(struct tn40_priv *priv)
+{
+	tn40_write_reg(priv, TN40_REG_IMR, priv->isr_mask);
+}
+
+static void tn40_disable_interrupts(struct tn40_priv *priv)
+{
+	tn40_write_reg(priv, TN40_REG_IMR, 0);
+}
+
+static int tn40_fifo_alloc(struct tn40_priv *priv, struct tn40_fifo *f,
+			   int fsz_type,
+			   u16 reg_cfg0, u16 reg_cfg1,
+			   u16 reg_rptr, u16 reg_wptr)
+{
+	u16 memsz = TN40_FIFO_SIZE * (1 << fsz_type);
+	u64 cfg_base;
+
+	memset(f, 0, sizeof(struct tn40_fifo));
+	/* 1K extra space is allocated at the end of the fifo to simplify
+	 * processing of descriptors that wraps around fifo's end.
+	 */
+	f->va = dma_alloc_coherent(&priv->pdev->dev,
+				   memsz + TN40_FIFO_EXTRA_SPACE, &f->da,
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
+	cfg_base = lower_32_bits((f->da & TN40_TX_RX_CFG0_BASE) | fsz_type);
+	tn40_write_reg(priv, reg_cfg0, cfg_base);
+	tn40_write_reg(priv, reg_cfg1, upper_32_bits(f->da));
+	return 0;
+}
+
+static void tn40_fifo_free(struct tn40_priv *priv, struct tn40_fifo *f)
+{
+	dma_free_coherent(&priv->pdev->dev,
+			  f->memsz + TN40_FIFO_EXTRA_SPACE, f->va, f->da);
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
+static void tn40_do_tx_db_ptr_next(struct tn40_txdb *db,
+				   struct tn40_tx_map **pptr)
+{
+	++*pptr;
+	if (unlikely(*pptr == db->end))
+		*pptr = db->start;
+}
+
+static void tn40_tx_db_inc_rptr(struct tn40_txdb *db)
+{
+	tn40_do_tx_db_ptr_next(db, &db->rptr);
+}
+
+static void tn40_tx_db_inc_wptr(struct tn40_txdb *db)
+{
+	tn40_do_tx_db_ptr_next(db, &db->wptr);
+}
+
+static int tn40_tx_db_init(struct tn40_txdb *d, int sz_type)
+{
+	int memsz = TN40_FIFO_SIZE * (1 << (sz_type + 1));
+
+	d->start = vzalloc(memsz);
+	if (!d->start)
+		return -ENOMEM;
+	/* In order to differentiate between an empty db state and a full db
+	 * state at least one element should always be empty in order to
+	 * avoid rptr == wptr, which means that the db is empty.
+	 */
+	d->size = memsz / sizeof(struct tn40_tx_map) - 1;
+	d->end = d->start + d->size + 1;	/* just after last element */
+
+	/* All dbs are created empty */
+	d->rptr = d->start;
+	d->wptr = d->start;
+	return 0;
+}
+
+static void tn40_tx_db_close(struct tn40_txdb *d)
+{
+	if (d->start) {
+		vfree(d->start);
+		d->start = NULL;
+	}
+}
+
+/* Sizes of tx desc (including padding if needed) as function of the SKB's
+ * frag number
+ * 7 - is number of lwords in txd with one phys buffer
+ * 3 - is number of lwords used for every additional phys buffer
+ * for (i = 0; i < TN40_MAX_PBL; i++) {
+ *	lwords = 7 + (i * 3);
+ *	if (lwords & 1)
+ *		lwords++;	pad it with 1 lword
+ *	tn40_txd_sizes[i].bytes = lwords << 2;
+ *	tn40_txd_sizes[i].qwords = lwords >> 1;
+ * }
+ */
+static struct {
+	u16 bytes;
+	u16 qwords;	/* qword = 64 bit */
+} tn40_txd_sizes[] = {
+	{0x20, 0x04},
+	{0x28, 0x05},
+	{0x38, 0x07},
+	{0x40, 0x08},
+	{0x50, 0x0a},
+	{0x58, 0x0b},
+	{0x68, 0x0d},
+	{0x70, 0x0e},
+	{0x80, 0x10},
+	{0x88, 0x11},
+	{0x98, 0x13},
+	{0xa0, 0x14},
+	{0xb0, 0x16},
+	{0xb8, 0x17},
+	{0xc8, 0x19},
+	{0xd0, 0x1a},
+	{0xe0, 0x1c},
+	{0xe8, 0x1d},
+	{0xf8, 0x1f},
+};
+
+static void tn40_pbl_set(struct tn40_pbl *pbl, dma_addr_t dma, int len)
+{
+	pbl->len = cpu_to_le32(len);
+	pbl->pa_lo = cpu_to_le32(lower_32_bits(dma));
+	pbl->pa_hi = cpu_to_le32(upper_32_bits(dma));
+}
+
+static void tn40_txdb_set(struct tn40_txdb *db, dma_addr_t dma, int len)
+{
+	db->wptr->len = len;
+	db->wptr->addr.dma = dma;
+}
+
+struct tn40_mapping_info {
+	dma_addr_t dma;
+	size_t size;
+};
+
+/**
+ * tn40_tx_map_skb - create and store DMA mappings for skb's data blocks
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
+static int tn40_tx_map_skb(struct tn40_priv *priv, struct sk_buff *skb,
+			   struct tn40_txd_desc *txdd, unsigned int *pkt_len)
+{
+	struct tn40_mapping_info info[TN40_MAX_PBL];
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	struct tn40_pbl *pbl = &txdd->pbl[0];
+	struct tn40_txdb *db = &priv->txdb;
+	unsigned int size;
+	int i, len, ret;
+	dma_addr_t dma;
+
+	netdev_dbg(priv->ndev, "TX skb %p skbLen %d dataLen %d frags %d\n", skb,
+		   skb->len, skb->data_len, nr_frags);
+	if (nr_frags > TN40_MAX_PBL - 1) {
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
+	tn40_txdb_set(db, dma, len);
+	tn40_pbl_set(pbl++, db->wptr->addr.dma, db->wptr->len);
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
+		tn40_tx_db_inc_wptr(db);
+		tn40_txdb_set(db, info[i].dma, info[i].size);
+		tn40_pbl_set(pbl++, db->wptr->addr.dma, db->wptr->len);
+		*pkt_len += db->wptr->len;
+	}
+
+	/* SHORT_PKT_FIX */
+	if (skb->len < TN40_SHORT_PACKET_SIZE)
+		++nr_frags;
+
+	/* Add skb clean up info. */
+	tn40_tx_db_inc_wptr(db);
+	db->wptr->len = -tn40_txd_sizes[nr_frags].bytes;
+	db->wptr->addr.skb = skb;
+	tn40_tx_db_inc_wptr(db);
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
+static int tn40_create_tx_ring(struct tn40_priv *priv)
+{
+	int ret;
+
+	ret = tn40_fifo_alloc(priv, &priv->txd_fifo0.m, priv->txd_size,
+			      TN40_REG_TXD_CFG0_0, TN40_REG_TXD_CFG1_0,
+			      TN40_REG_TXD_RPTR_0, TN40_REG_TXD_WPTR_0);
+	if (ret)
+		return ret;
+
+	ret = tn40_fifo_alloc(priv, &priv->txf_fifo0.m, priv->txf_size,
+			      TN40_REG_TXF_CFG0_0, TN40_REG_TXF_CFG1_0,
+			      TN40_REG_TXF_RPTR_0, TN40_REG_TXF_WPTR_0);
+	if (ret)
+		goto err_free_txd;
+
+	/* The TX db has to keep mappings for all packets sent (on
+	 * TxD) and not yet reclaimed (on TxF).
+	 */
+	ret = tn40_tx_db_init(&priv->txdb, max(priv->txd_size, priv->txf_size));
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
+	tn40_tx_db_close(&priv->txdb);
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
+static int tn40_tx_space(struct tn40_priv *priv)
+{
+	struct tn40_txd_fifo *f = &priv->txd_fifo0;
+	int fsize;
+
+	f->m.rptr = tn40_read_reg(priv, f->m.reg_rptr) & TN40_TXF_WPTR_WR_PTR;
+	fsize = f->m.rptr - f->m.wptr;
+	if (fsize <= 0)
+		fsize = f->m.memsz + fsize;
+	return fsize;
+}
+
+#define TN40_TXD_FULL_CHECKSUM 7
+
+static int tn40_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+	struct tn40_txd_fifo *f = &priv->txd_fifo0;
+	int txd_checksum = TN40_TXD_FULL_CHECKSUM;
+	struct tn40_txd_desc *txdd;
+	int nr_frags, len, err;
+	unsigned int pkt_len;
+	int txd_vlan_id = 0;
+	int txd_lgsnd = 0;
+	int txd_vtag = 0;
+	int txd_mss = 0;
+
+	/* Build tx descriptor */
+	txdd = (struct tn40_txd_desc *)(f->m.va + f->m.wptr);
+	err = tn40_tx_map_skb(priv, skb, txdd, &pkt_len);
+	if (err) {
+		u64_stats_update_begin(&priv->syncp);
+		priv->stats.tx_dropped++;
+		u64_stats_update_end(&priv->syncp);
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
+		cpu_to_le32(TN40_TXD_W1_VAL
+			    (tn40_txd_sizes[nr_frags].qwords, txd_checksum,
+			     txd_vtag, txd_lgsnd, txd_vlan_id));
+	netdev_dbg(priv->ndev, "=== w1 qwords[%d] %d =====\n", nr_frags,
+		   tn40_txd_sizes[nr_frags].qwords);
+	netdev_dbg(priv->ndev, "=== TxD desc =====================\n");
+	netdev_dbg(priv->ndev, "=== w1: 0x%x ================\n",
+		   txdd->txd_val1);
+	netdev_dbg(priv->ndev, "=== w2: mss 0x%x len 0x%x\n", txdd->mss,
+		   txdd->length);
+	/* SHORT_PKT_FIX */
+	if (pkt_len < TN40_SHORT_PACKET_SIZE) {
+		struct tn40_pbl *pbl = &txdd->pbl[++nr_frags];
+
+		txdd->length = cpu_to_le16(TN40_SHORT_PACKET_SIZE);
+		txdd->txd_val1 =
+			cpu_to_le32(TN40_TXD_W1_VAL
+				    (tn40_txd_sizes[nr_frags].qwords,
+				     txd_checksum, txd_vtag, txd_lgsnd,
+				     txd_vlan_id));
+		pbl->len = cpu_to_le32(TN40_SHORT_PACKET_SIZE - pkt_len);
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
+	f->m.wptr += tn40_txd_sizes[nr_frags].bytes;
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
+	priv->tx_level -= tn40_txd_sizes[nr_frags].bytes;
+	if (priv->tx_level > priv->tx_update_mark) {
+		tn40_write_reg(priv, f->m.reg_wptr,
+			       f->m.wptr & TN40_TXF_WPTR_WR_PTR);
+	} else {
+		if (priv->tx_noupd++ > TN40_NO_UPD_PACKETS) {
+			priv->tx_noupd = 0;
+			tn40_write_reg(priv, f->m.reg_wptr,
+				       f->m.wptr & TN40_TXF_WPTR_WR_PTR);
+		}
+	}
+
+	netif_trans_update(ndev);
+	u64_stats_update_begin(&priv->syncp);
+	priv->stats.tx_packets++;
+	priv->stats.tx_bytes += pkt_len;
+	u64_stats_update_end(&priv->syncp);
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
+	struct tn40_txdb *db = &priv->txdb;
+
+	while (db->rptr != db->wptr) {
+		if (likely(db->rptr->len))
+			dma_unmap_page(&priv->pdev->dev, db->rptr->addr.dma,
+				       db->rptr->len, DMA_TO_DEVICE);
+		else
+			dev_kfree_skb(db->rptr->addr.skb);
+		tn40_tx_db_inc_rptr(db);
+	}
+}
+
+static void tn40_destroy_tx_ring(struct tn40_priv *priv)
+{
+	tn40_tx_free_skbs(priv);
+	tn40_fifo_free(priv, &priv->txd_fifo0.m);
+	tn40_fifo_free(priv, &priv->txf_fifo0.m);
+	tn40_tx_db_close(&priv->txdb);
+	/* SHORT_PKT_FIX */
+	if (priv->b0_len) {
+		dma_free_coherent(&priv->pdev->dev, priv->b0_len, priv->b0_va,
+				  priv->b0_dma);
+		priv->b0_len = 0;
+	}
+}
+
+/**
+ * tn40_tx_push_desc - Push a descriptor to TxD fifo.
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
+static void tn40_tx_push_desc(struct tn40_priv *priv, void *data, int size)
+{
+	struct tn40_txd_fifo *f = &priv->txd_fifo0;
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
+	tn40_write_reg(priv, f->m.reg_wptr, f->m.wptr & TN40_TXF_WPTR_WR_PTR);
+}
+
+/**
+ * tn40_tx_push_desc_safe - push descriptor to TxD fifo in a safe way.
+ *
+ * @priv: NIC private structure
+ * @data: descriptor data
+ * @size: descriptor size
+ *
+ * This function does check for available space and, if necessary,
+ * waits for the NIC to read existing data before writing new data.
+ */
+static void tn40_tx_push_desc_safe(struct tn40_priv *priv, void *data, int size)
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
+		tn40_tx_push_desc(priv, data, avail);
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
+		tn40_write_reg(priv, 0x1010, 0x217);	/*ETHSD.REFCLK_CONF  */
+		tn40_write_reg(priv, 0x104c, 0x4c);	/*ETHSD.L0_RX_PCNT  */
+		tn40_write_reg(priv, 0x1050, 0x4c);	/*ETHSD.L1_RX_PCNT  */
+		tn40_write_reg(priv, 0x1054, 0x4c);	/*ETHSD.L2_RX_PCNT  */
+		tn40_write_reg(priv, 0x1058, 0x4c);	/*ETHSD.L3_RX_PCNT  */
+		tn40_write_reg(priv, 0x102c, 0x434);	/*ETHSD.L0_TX_PCNT  */
+		tn40_write_reg(priv, 0x1030, 0x434);	/*ETHSD.L1_TX_PCNT  */
+		tn40_write_reg(priv, 0x1034, 0x434);	/*ETHSD.L2_TX_PCNT  */
+		tn40_write_reg(priv, 0x1038, 0x434);	/*ETHSD.L3_TX_PCNT  */
+		tn40_write_reg(priv, 0x6300, 0x0400);	/*MAC.PCS_CTRL */
+
+		tn40_write_reg(priv, 0x1018, 0x00);	/*Mike2 */
+		udelay(5);
+		tn40_write_reg(priv, 0x1018, 0x04);	/*Mike2 */
+		udelay(5);
+		tn40_write_reg(priv, 0x1018, 0x06);	/*Mike2 */
+		udelay(5);
+		/*MikeFix1 */
+		/*L0: 0x103c , L1: 0x1040 , L2: 0x1044 , L3: 0x1048 =0x81644 */
+		tn40_write_reg(priv, 0x103c, 0x81644);	/*ETHSD.L0_TX_DCNT  */
+		tn40_write_reg(priv, 0x1040, 0x81644);	/*ETHSD.L1_TX_DCNT  */
+		tn40_write_reg(priv, 0x1044, 0x81644);	/*ETHSD.L2_TX_DCNT  */
+		tn40_write_reg(priv, 0x1048, 0x81644);	/*ETHSD.L3_TX_DCNT  */
+		tn40_write_reg(priv, 0x1014, 0x043);	/*ETHSD.INIT_STAT */
+		for (i = 1000; i; i--) {
+			udelay(50);
+			/*ETHSD.INIT_STAT */
+			val = tn40_read_reg(priv, 0x1014);
+			if (val & (1 << 9)) {
+				/*ETHSD.INIT_STAT */
+				tn40_write_reg(priv, 0x1014, 0x3);
+				/*ETHSD.INIT_STAT */
+				val = tn40_read_reg(priv, 0x1014);
+
+				break;
+			}
+		}
+		if (!i)
+			netdev_err(priv->ndev, "MAC init timeout!\n");
+
+		tn40_write_reg(priv, 0x6350, 0x0);	/*MAC.PCS_IF_MODE */
+		tn40_write_reg(priv, TN40_REG_CTRLST, 0xC13);	/*0x93//0x13 */
+		tn40_write_reg(priv, 0x111c, 0x7ff);	/*MAC.MAC_RST_CNT */
+		for (i = 40; i--;)
+			udelay(50);
+
+		tn40_write_reg(priv, 0x111c, 0x0);	/*MAC.MAC_RST_CNT */
+		break;
+
+	case SPEED_1000:
+	case SPEED_100:
+		tn40_write_reg(priv, 0x1010, 0x613);	/*ETHSD.REFCLK_CONF */
+		tn40_write_reg(priv, 0x104c, 0x4d);	/*ETHSD.L0_RX_PCNT  */
+		tn40_write_reg(priv, 0x1050, 0x0);	/*ETHSD.L1_RX_PCNT  */
+		tn40_write_reg(priv, 0x1054, 0x0);	/*ETHSD.L2_RX_PCNT  */
+		tn40_write_reg(priv, 0x1058, 0x0);	/*ETHSD.L3_RX_PCNT  */
+		tn40_write_reg(priv, 0x102c, 0x35);	/*ETHSD.L0_TX_PCNT  */
+		tn40_write_reg(priv, 0x1030, 0x0);	/*ETHSD.L1_TX_PCNT  */
+		tn40_write_reg(priv, 0x1034, 0x0);	/*ETHSD.L2_TX_PCNT  */
+		tn40_write_reg(priv, 0x1038, 0x0);	/*ETHSD.L3_TX_PCNT  */
+		tn40_write_reg(priv, 0x6300, 0x01140);	/*MAC.PCS_CTRL */
+
+		tn40_write_reg(priv, 0x1014, 0x043);	/*ETHSD.INIT_STAT */
+		for (i = 1000; i; i--) {
+			udelay(50);
+			val = tn40_read_reg(priv, 0x1014); /*ETHSD.INIT_STAT */
+			if (val & (1 << 9)) {
+				/*ETHSD.INIT_STAT */
+				tn40_write_reg(priv, 0x1014, 0x3);
+				/*ETHSD.INIT_STAT */
+				val = tn40_read_reg(priv, 0x1014);
+
+				break;
+			}
+		}
+		if (!i)
+			netdev_err(priv->ndev, "MAC init timeout!\n");
+
+		tn40_write_reg(priv, 0x6350, 0x2b);	/*MAC.PCS_IF_MODE 1g */
+		tn40_write_reg(priv, 0x6310, 0x9801);	/*MAC.PCS_DEV_AB */
+
+		tn40_write_reg(priv, 0x6314, 0x1);	/*MAC.PCS_PART_AB */
+		tn40_write_reg(priv, 0x6348, 0xc8);	/*MAC.PCS_LINK_LO */
+		tn40_write_reg(priv, 0x634c, 0xc8);	/*MAC.PCS_LINK_HI */
+		udelay(50);
+		tn40_write_reg(priv, TN40_REG_CTRLST, 0xC13);	/*0x93//0x13 */
+		tn40_write_reg(priv, 0x111c, 0x7ff);	/*MAC.MAC_RST_CNT */
+		for (i = 40; i--;)
+			udelay(50);
+
+		tn40_write_reg(priv, 0x111c, 0x0);	/*MAC.MAC_RST_CNT */
+		tn40_write_reg(priv, 0x6300, 0x1140);	/*MAC.PCS_CTRL */
+		break;
+
+	case 0:		/* Link down */
+		tn40_write_reg(priv, 0x104c, 0x0);	/*ETHSD.L0_RX_PCNT  */
+		tn40_write_reg(priv, 0x1050, 0x0);	/*ETHSD.L1_RX_PCNT  */
+		tn40_write_reg(priv, 0x1054, 0x0);	/*ETHSD.L2_RX_PCNT  */
+		tn40_write_reg(priv, 0x1058, 0x0);	/*ETHSD.L3_RX_PCNT  */
+		tn40_write_reg(priv, 0x102c, 0x0);	/*ETHSD.L0_TX_PCNT  */
+		tn40_write_reg(priv, 0x1030, 0x0);	/*ETHSD.L1_TX_PCNT  */
+		tn40_write_reg(priv, 0x1034, 0x0);	/*ETHSD.L2_TX_PCNT  */
+		tn40_write_reg(priv, 0x1038, 0x0);	/*ETHSD.L3_TX_PCNT  */
+
+		tn40_write_reg(priv, TN40_REG_CTRLST, 0x800);
+		tn40_write_reg(priv, 0x111c, 0x7ff);	/*MAC.MAC_RST_CNT */
+		for (i = 40; i--;)
+			udelay(50);
+		tn40_write_reg(priv, 0x111c, 0x0);	/*MAC.MAC_RST_CNT */
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
+static void tn40_link_changed(struct tn40_priv *priv)
+{
+	u32 link = tn40_read_reg(priv,
+				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
+
+	netdev_dbg(priv->ndev, "link changed %u\n", link);
+}
+
+static void tn40_isr_extra(struct tn40_priv *priv, u32 isr)
+{
+	if (isr & (TN40_IR_LNKCHG0 | TN40_IR_LNKCHG1 | TN40_IR_TMR0)) {
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
+	isr = tn40_read_reg(priv, TN40_REG_ISR_MSK0);
+
+	if (unlikely(!isr)) {
+		tn40_enable_interrupts(priv);
+		return IRQ_NONE;	/* Not our interrupt */
+	}
+
+	if (isr & TN40_IR_EXTRA)
+		tn40_isr_extra(priv, isr);
+
+	if (isr & (TN40_IR_RX_DESC_0 | TN40_IR_TX_FREE_0 | TN40_IR_TMR1)) {
+		/* We get here if an interrupt has slept into the
+		 * small time window between these lines in
+		 * tn40_poll: tn40_enable_interrupts(priv); return 0;
+		 *
+		 * Currently interrupts are disabled (since we read
+		 * the ISR register) and we have failed to register
+		 * the next poll. So we read the regs to trigger the
+		 * chip and allow further interrupts.
+		 */
+		tn40_read_reg(priv, TN40_REG_TXF_WPTR_0);
+		tn40_read_reg(priv, TN40_REG_RXD_WPTR_0);
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
+	ret = request_firmware(&fw, TN40_FIRMWARE_NAME, &priv->pdev->dev);
+	if (ret)
+		return ret;
+
+	master = tn40_read_reg(priv, TN40_REG_INIT_SEMAPHORE);
+	if (!tn40_read_reg(priv, TN40_REG_INIT_STATUS) && master) {
+		netdev_dbg(priv->ndev, "Loading FW...\n");
+		tn40_tx_push_desc_safe(priv, (void *)fw->data, fw->size);
+		mdelay(100);
+	}
+	for (i = 0; i < 200; i++) {
+		if (tn40_read_reg(priv, TN40_REG_INIT_STATUS))
+			break;
+		mdelay(2);
+	}
+	if (master)
+		tn40_write_reg(priv, TN40_REG_INIT_SEMAPHORE, 1);
+
+	if (i == 200) {
+		netdev_err(priv->ndev, "firmware loading failed\n");
+		netdev_dbg(priv->ndev, "VPC: 0x%x VIC: 0x%x STATUS: 0x%xd\n",
+			   tn40_read_reg(priv, TN40_REG_VPC),
+			   tn40_read_reg(priv, TN40_REG_VIC),
+			   tn40_read_reg(priv, TN40_REG_INIT_STATUS));
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
+		   tn40_read_reg(priv, TN40_REG_UNC_MAC0_A),
+		   tn40_read_reg(priv, TN40_REG_UNC_MAC1_A),
+		   tn40_read_reg(priv, TN40_REG_UNC_MAC2_A));
+
+	val = (ndev->dev_addr[0] << 8) | (ndev->dev_addr[1]);
+	tn40_write_reg(priv, TN40_REG_UNC_MAC2_A, val);
+	val = (ndev->dev_addr[2] << 8) | (ndev->dev_addr[3]);
+	tn40_write_reg(priv, TN40_REG_UNC_MAC1_A, val);
+	val = (ndev->dev_addr[4] << 8) | (ndev->dev_addr[5]);
+	tn40_write_reg(priv, TN40_REG_UNC_MAC0_A, val);
+
+	/* More then IP MAC address */
+	tn40_write_reg(priv, TN40_REG_MAC_ADDR_0,
+		       (ndev->dev_addr[3] << 24) | (ndev->dev_addr[2] << 16) |
+		       (ndev->dev_addr[1] << 8) | (ndev->dev_addr[0]));
+	tn40_write_reg(priv, TN40_REG_MAC_ADDR_1,
+		       (ndev->dev_addr[5] << 8) | (ndev->dev_addr[4]));
+
+	netdev_dbg(priv->ndev, "mac0 =%x mac1 =%x mac2 =%x\n",
+		   tn40_read_reg(priv, TN40_REG_UNC_MAC0_A),
+		   tn40_read_reg(priv, TN40_REG_UNC_MAC1_A),
+		   tn40_read_reg(priv, TN40_REG_UNC_MAC2_A));
+}
+
+static void tn40_hw_start(struct tn40_priv *priv)
+{
+	tn40_write_reg(priv, TN40_REG_FRM_LENGTH, 0X3FE0);
+	tn40_write_reg(priv, TN40_REG_GMAC_RXF_A, 0X10fd);
+	/*MikeFix1 */
+	/*L0: 0x103c , L1: 0x1040 , L2: 0x1044 , L3: 0x1048 =0x81644 */
+	tn40_write_reg(priv, 0x103c, 0x81644);	/*ETHSD.L0_TX_DCNT  */
+	tn40_write_reg(priv, 0x1040, 0x81644);	/*ETHSD.L1_TX_DCNT  */
+	tn40_write_reg(priv, 0x1044, 0x81644);	/*ETHSD.L2_TX_DCNT  */
+	tn40_write_reg(priv, 0x1048, 0x81644);	/*ETHSD.L3_TX_DCNT  */
+	tn40_write_reg(priv, TN40_REG_RX_FIFO_SECTION, 0x10);
+	tn40_write_reg(priv, TN40_REG_TX_FIFO_SECTION, 0xE00010);
+	tn40_write_reg(priv, TN40_REG_RX_FULLNESS, 0);
+	tn40_write_reg(priv, TN40_REG_TX_FULLNESS, 0);
+
+	tn40_write_reg(priv, TN40_REG_VGLB, 0);
+	tn40_write_reg(priv, TN40_REG_RDINTCM0, priv->rdintcm);
+	tn40_write_reg(priv, TN40_REG_RDINTCM2, 0);
+
+	/* old val = 0x300064 */
+	tn40_write_reg(priv, TN40_REG_TDINTCM0, priv->tdintcm);
+
+	/* Enable timer interrupt once in 2 secs. */
+	tn40_restore_mac(priv->ndev, priv);
+
+	/* Pause frame */
+	tn40_write_reg(priv, 0x12E0, 0x28);
+	tn40_write_reg(priv, TN40_REG_PAUSE_QUANT, 0xFFFF);
+	tn40_write_reg(priv, 0x6064, 0xF);
+
+	tn40_write_reg(priv, TN40_REG_GMAC_RXF_A,
+		       TN40_GMAC_RX_FILTER_OSEN | TN40_GMAC_RX_FILTER_TXFC |
+		       TN40_GMAC_RX_FILTER_AM | TN40_GMAC_RX_FILTER_AB);
+
+	tn40_enable_interrupts(priv);
+}
+
+static int tn40_hw_reset(struct tn40_priv *priv)
+{
+	u32 val, i;
+
+	/* Reset sequences: read, write 1, read, write 0 */
+	val = tn40_read_reg(priv, TN40_REG_CLKPLL);
+	tn40_write_reg(priv, TN40_REG_CLKPLL, (val | TN40_CLKPLL_SFTRST) + 0x8);
+	udelay(50);
+	val = tn40_read_reg(priv, TN40_REG_CLKPLL);
+	tn40_write_reg(priv, TN40_REG_CLKPLL, val & ~TN40_CLKPLL_SFTRST);
+
+	/* Check that the PLLs are locked and reset ended */
+	for (i = 0; i < 70; i++, mdelay(10)) {
+		if ((tn40_read_reg(priv, TN40_REG_CLKPLL) & TN40_CLKPLL_LKD) ==
+		    TN40_CLKPLL_LKD) {
+			udelay(50);
+			/* Do any PCI-E read transaction */
+			tn40_read_reg(priv, TN40_REG_RXD_CFG0_0);
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void tn40_sw_reset(struct tn40_priv *priv)
+{
+	int i, ret;
+	u32 val;
+
+	/* 1. load MAC (obsolete) */
+	/* 2. disable Rx (and Tx) */
+	tn40_write_reg(priv, TN40_REG_GMAC_RXF_A, 0);
+	msleep(100);
+	/* 3. Disable port */
+	tn40_write_reg(priv, TN40_REG_DIS_PORT, 1);
+	/* 4. Disable queue */
+	tn40_write_reg(priv, TN40_REG_DIS_QU, 1);
+	/* 5. Wait until hw is disabled */
+	ret = read_poll_timeout(tn40_read_reg, val, val & 1, 10000, 500000,
+				false, priv, TN40_REG_RST_PORT);
+	if (ret)
+		netdev_err(priv->ndev, "SW reset timeout. continuing anyway\n");
+
+	/* 6. Disable interrupts */
+	tn40_write_reg(priv, TN40_REG_RDINTCM0, 0);
+	tn40_write_reg(priv, TN40_REG_TDINTCM0, 0);
+	tn40_write_reg(priv, TN40_REG_IMR, 0);
+	tn40_read_reg(priv, TN40_REG_ISR);
+
+	/* 7. Reset queue */
+	tn40_write_reg(priv, TN40_REG_RST_QU, 1);
+	/* 8. Reset port */
+	tn40_write_reg(priv, TN40_REG_RST_PORT, 1);
+	/* 9. Zero all read and write pointers */
+	for (i = TN40_REG_TXD_WPTR_0; i <= TN40_REG_TXF_RPTR_3; i += 0x10)
+		tn40_write_reg(priv, i, 0);
+	/* 10. Unset port disable */
+	tn40_write_reg(priv, TN40_REG_DIS_PORT, 0);
+	/* 11. Unset queue disable */
+	tn40_write_reg(priv, TN40_REG_DIS_QU, 0);
+	/* 12. Unset queue reset */
+	tn40_write_reg(priv, TN40_REG_RST_QU, 0);
+	/* 13. Unset port reset */
+	tn40_write_reg(priv, TN40_REG_RST_PORT, 0);
+	/* 14. Enable Rx */
+	/* Skipped. will be done later */
+}
+
+static int tn40_start(struct tn40_priv *priv)
+{
+	int ret;
+
+	ret = tn40_create_tx_ring(priv);
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
+	tn40_destroy_tx_ring(priv);
+	return ret;
+}
+
+static void tn40_stop(struct tn40_priv *priv)
+{
+	tn40_disable_interrupts(priv);
+	free_irq(priv->pdev->irq, priv->ndev);
+	tn40_sw_reset(priv);
+	tn40_destroy_tx_ring(priv);
+}
+
+static int tn40_close(struct net_device *ndev)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+
+	tn40_stop(priv);
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
+	reg = TN40_REG_VLAN_0 + (vid / 32) * 4;
+	bit = 1 << vid % 32;
+	val = tn40_read_reg(priv, reg);
+	netdev_dbg(priv->ndev, "reg =%x, val =%x, bit =%d\n", reg, val, bit);
+	if (enable)
+		val |= bit;
+	else
+		val &= ~bit;
+	netdev_dbg(priv->ndev, "new val %x\n", val);
+	tn40_write_reg(priv, reg, val);
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
+	u32 rxf_val = TN40_GMAC_RX_FILTER_AM | TN40_GMAC_RX_FILTER_AB |
+		TN40_GMAC_RX_FILTER_OSEN | TN40_GMAC_RX_FILTER_TXFC;
+	struct tn40_priv *priv = netdev_priv(ndev);
+	int i;
+
+	/* IMF - imperfect (hash) rx multicast filter */
+	/* PMF - perfect rx multicast filter */
+
+	/* FIXME: RXE(OFF) */
+	if (ndev->flags & IFF_PROMISC) {
+		rxf_val |= TN40_GMAC_RX_FILTER_PRM;
+	} else if (ndev->flags & IFF_ALLMULTI) {
+		/* set IMF to accept all multicast frames */
+		for (i = 0; i < TN40_MAC_MCST_HASH_NUM; i++)
+			tn40_write_reg(priv,
+				       TN40_REG_RX_MCST_HASH0 + i * 4, ~0);
+	} else if (netdev_mc_count(ndev)) {
+		struct netdev_hw_addr *mclist;
+		u32 reg, val;
+		u8 hash;
+
+		/* Set IMF to deny all multicast frames */
+		for (i = 0; i < TN40_MAC_MCST_HASH_NUM; i++)
+			tn40_write_reg(priv,
+				       TN40_REG_RX_MCST_HASH0 + i * 4, 0);
+
+		/* Set PMF to deny all multicast frames */
+		for (i = 0; i < TN40_MAC_MCST_NUM; i++) {
+			tn40_write_reg(priv,
+				       TN40_REG_RX_MAC_MCST0 + i * 8, 0);
+			tn40_write_reg(priv,
+				       TN40_REG_RX_MAC_MCST1 + i * 8, 0);
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
+			reg = TN40_REG_RX_MCST_HASH0 + ((hash >> 5) << 2);
+			val = tn40_read_reg(priv, reg);
+			val |= (1 << (hash % 32));
+			tn40_write_reg(priv, reg, val);
+		}
+	} else {
+		rxf_val |= TN40_GMAC_RX_FILTER_AB;
+	}
+	tn40_write_reg(priv, TN40_REG_GMAC_RXF_A, rxf_val);
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
+	val = (u64)tn40_read_reg(priv, TN40_REG_UNC_MAC0_A);
+	val |= (u64)tn40_read_reg(priv, TN40_REG_UNC_MAC1_A) << 16;
+	val |= (u64)tn40_read_reg(priv, TN40_REG_UNC_MAC2_A) << 32;
+
+	u64_to_ether_addr(val, addr);
+	eth_hw_addr_set(priv->ndev, addr);
+}
+
+static void tn40_get_stats(struct net_device *ndev,
+			   struct rtnl_link_stats64 *stats)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&priv->syncp);
+		stats->tx_packets = priv->stats.tx_packets;
+		stats->tx_bytes = priv->stats.tx_bytes;
+		stats->tx_dropped = priv->stats.tx_dropped;
+	} while (u64_stats_fetch_retry(&priv->syncp, start));
+}
+
+static const struct net_device_ops tn40_netdev_ops = {
+	.ndo_open = tn40_open,
+	.ndo_stop = tn40_close,
+	.ndo_start_xmit = tn40_start_xmit,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_set_rx_mode = tn40_setmulti,
+	.ndo_get_stats64 = tn40_get_stats,
+	.ndo_set_mac_address = tn40_set_mac,
+	.ndo_vlan_rx_add_vid = tn40_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = tn40_vlan_rx_kill_vid,
+};
+
+static int tn40_priv_init(struct tn40_priv *priv)
+{
+	int ret;
+
+	tn40_set_link_speed(priv, 0);
+
+	/* Set GPIO[9:0] to output 0 */
+	tn40_write_reg(priv, 0x51E0, 0x30010006);	/* GPIO_OE_ WR CMD */
+	tn40_write_reg(priv, 0x51F0, 0x0);	/* GPIO_OE_ DATA */
+	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, 0x3ec8);
+
+	/* we use tx descriptors to load a firmware. */
+	ret = tn40_create_tx_ring(priv);
+	if (ret)
+		return ret;
+	ret = tn40_fw_load(priv);
+	tn40_destroy_tx_ring(priv);
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
 
 	ret = pci_enable_device(pdev);
@@ -17,7 +1186,86 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(&pdev->dev, "failed to set DMA mask.\n");
 		goto err_disable_device;
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
+	priv->rdintcm = TN40_INT_REG_VAL(0x20, 1, 4, 12);
+	priv->tdintcm = TN40_INT_REG_VAL(0x20, 1, 0, 12);
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
+	priv->stats_flag =
+		((tn40_read_reg(priv, TN40_FPGA_VER) & 0xFFF) != 308);
+	u64_stats_init(&priv->syncp);
+
+	priv->isr_mask = TN40_IR_RX_FREE_0 | TN40_IR_LNKCHG0 | TN40_IR_PSE |
+		TN40_IR_TMR0 | TN40_IR_RX_DESC_0 | TN40_IR_TX_FREE_0 |
+		TN40_IR_TMR1;
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
@@ -25,6 +1273,15 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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
 
@@ -51,4 +1308,5 @@ module_pci_driver(tn40_driver);
 
 MODULE_DEVICE_TABLE(pci, tn40_id_table);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(TN40_FIRMWARE_NAME);
 MODULE_DESCRIPTION("Tehuti Network TN40xx Driver");
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index aec23208e9b1..381257416d76 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -8,4 +8,161 @@
 
 #define TN40_DRV_NAME "tn40xx"
 
+#define TN40_MDIO_SPEED_1MHZ (1)
+#define TN40_MDIO_SPEED_6MHZ (6)
+
+/* netdev tx queue len for Luxor. The default value is 1000.
+ * ifconfig eth1 txqueuelen 3000 - to change it at runtime.
+ */
+#define TN40_NDEV_TXQ_LEN 1000
+
+#define TN40_FIFO_SIZE 4096
+#define TN40_FIFO_EXTRA_SPACE 1024
+
+#define TN40_TXF_DESC_SZ 16
+#define TN40_MAX_TX_LEVEL (priv->txd_fifo0.m.memsz - 16)
+#define TN40_MIN_TX_LEVEL 256
+#define TN40_NO_UPD_PACKETS 40
+#define TN40_MAX_MTU BIT(14)
+
+#define TN40_PCK_TH_MULT 128
+#define TN40_INT_COAL_MULT 2
+
+#define TN40_INT_REG_VAL(coal, coal_rc, rxf_th, pck_th) (	\
+	FIELD_PREP(GENMASK(14, 0), (coal)) |		\
+	FIELD_PREP(BIT(15), (coal_rc)) |		\
+	FIELD_PREP(GENMASK(19, 16), (rxf_th)) |		\
+	FIELD_PREP(GENMASK(31, 20), (pck_th))		\
+	)
+
+struct tn40_fifo {
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
+struct tn40_txf_fifo {
+	struct tn40_fifo m; /* The minimal set of variables used by all fifos */
+};
+
+struct tn40_txd_fifo {
+	struct tn40_fifo m; /* The minimal set of variables used by all fifos */
+};
+
+union tn40_tx_dma_addr {
+	dma_addr_t dma;
+	struct sk_buff *skb;
+};
+
+/* Entry in the db.
+ * if len == 0 addr is dma
+ * if len != 0 addr is skb
+ */
+struct tn40_tx_map {
+	union tn40_tx_dma_addr addr;
+	int len;
+};
+
+/* tx database - implemented as circular fifo buffer */
+struct tn40_txdb {
+	struct tn40_tx_map *start; /* Points to the first element */
+	struct tn40_tx_map *end; /* Points just AFTER the last element */
+	struct tn40_tx_map *rptr; /* Points to the next element to read */
+	struct tn40_tx_map *wptr; /* Points to the next element to write */
+	int size; /* Number of elements in the db */
+};
+
+struct tn40_priv {
+	struct net_device *ndev;
+	struct pci_dev *pdev;
+
+	/* Tx FIFOs: 1 for data desc, 1 for empty (acks) desc */
+	struct tn40_txd_fifo txd_fifo0;
+	struct tn40_txf_fifo txf_fifo0;
+	struct tn40_txdb txdb;
+	int tx_level;
+	int tx_update_mark;
+	int tx_noupd;
+
+	int stats_flag;
+	struct rtnl_link_stats64 stats;
+	struct u64_stats_sync syncp;
+
+	u8 txd_size;
+	u8 txf_size;
+	u8 rxd_size;
+	u8 rxf_size;
+	u32 rdintcm;
+	u32 tdintcm;
+
+	u32 isr_mask;
+
+	void __iomem *regs;
+
+	/* SHORT_PKT_FIX */
+	u32 b0_len;
+	dma_addr_t b0_dma; /* Physical address of buffer */
+	char *b0_va; /* Virtual address of buffer */
+};
+
+#define TN40_MAX_PBL (19)
+/* PBL describes each virtual buffer to be transmitted from the host. */
+struct tn40_pbl {
+	__le32 pa_lo;
+	__le32 pa_hi;
+	__le32 len;
+};
+
+/* First word for TXD descriptor. It means: type = 3 for regular Tx packet,
+ * hw_csum = 7 for IP+UDP+TCP HW checksums.
+ */
+#define TN40_TXD_W1_VAL(bc, checksum, vtag, lgsnd, vlan_id) (		\
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
+struct tn40_txd_desc {
+	__le32 txd_val1;
+	__le16 mss;
+	__le16 length;
+	__le32 va_lo;
+	__le32 va_hi;
+	struct tn40_pbl pbl[]; /* Fragments */
+};
+
+struct tn40_txf_desc {
+	u32 status;
+	u32 va_lo; /* VAdr[31:0] */
+	u32 va_hi; /* VAdr[63:32] */
+	u32 pad;
+};
+
+static inline u32 tn40_read_reg(struct tn40_priv *priv, u32 reg)
+{
+	return readl(priv->regs + reg);
+}
+
+static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
+{
+	writel(val, priv->regs + reg);
+}
+
 #endif /* _TN40XX_H */
-- 
2.34.1


