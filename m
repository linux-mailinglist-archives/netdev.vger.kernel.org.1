Return-Path: <netdev+bounces-94531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897AA8BFC81
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910041C233FC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12ED84038;
	Wed,  8 May 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPhbzlsR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA46582862
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168617; cv=none; b=btMZh4UHzjZDzQX2f6oqDD3/aEKZVIizkInFrTZzxrj3NlEH4SRlP1vTleYOucsojQDIq1Wshydxswe3xpKkPlPlHJzA2se38a9hUmQkpnSeO4MSIL1Eik6zRhSPBy8df+2OvitKjie7r+Ss9EV/N0wAoaSN83trBxjvjnx8J9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168617; c=relaxed/simple;
	bh=e4eqQFZeRUFqU5H+mJwyWNATpxGRKalr2Af9NJzrf+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzEpRKnIg/rY8ZdCbntOp0z9mpFU5S/n9jI1LXtg+xJ28zH0cvdREyjMShDhGl7uzF8LiJh6jSX4vtlVK1x8ukuunIX+d3FqIuY1lp38UFqU32x48b/lXQC49cgE0pP6V0x5sg+UTfuiwkVwxu61wGMNdnoJXPYM3CiwF4TA16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPhbzlsR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5fccb1133e7so124872a12.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168615; x=1715773415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZUm7zcqCTPmWofLdUObjasaWEyPuGkK8dqI6hcGZRw=;
        b=nPhbzlsRnYWZllfQ/x/DtDkQl+nfULvXEX8MysxTQyvRgCVzjpQ6V2wFyeZ6ywSGiO
         RI0S9Sp2/EsZu+tgBz615Ca5/3jUKfQ6bIIXfSlNN8GOOrLf9lhqpf8WqxXZFzzlBCbQ
         LhxaDpAshOvNu+L9jCkynXvhc1P5iv2dlg1BYzpOzq7Xq54ijVrWA+RwoxiaDV0rfCMF
         b75cD7KphvUlmyB2nVonmivTU600bGSD5a0WeOZMikYjMLRmZ00QcM8avLvufbOgU+Hc
         h6y7pBKL88yiERPom0g+EhZf970BQH+FREhBPU8vGT3SHqPa5rPMCEqJ22IlePeT8jRW
         UTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168615; x=1715773415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZUm7zcqCTPmWofLdUObjasaWEyPuGkK8dqI6hcGZRw=;
        b=YDTMWiQyN6g0AjPMpEdqJYGRe7kn+FaPyIBNz9NoSxUUVAkp/bm5b+pv5xYIRlwfLt
         W3CEenfRVIH4HVmWFqen20Mohsz2hO9rsTMIlIh/rLwAx4l64iVfI0mPXA+Evum/+Fan
         f0EMwVw1sUdKTGaANzdogflPIuHPUAw0dwHfcOIoZ3hWsXn8Hz+X5T80Ot0ek8B8l/N7
         MMiTZ593x43TVtmLnfk+ouuE7YfTgNv8YHyRguS2OSJGruli5jLvaWVA1hrUg1p1wHCr
         kVeEAzF9p2ocH8Bn3Hedgh6qLXiV6bpevR2ORtPulvoDTY0dHXYnph1iPW+aYxU81iWw
         MzVA==
X-Gm-Message-State: AOJu0YwE23ygPdCm2uXEzX0T81JbeCWughhVO3gWMgCwE6tjWsOdhqox
	jWVqCcGfN3bEn4ppCFHeA0BqpYS8G/z71qGB3YG2LydCsAdRxATzCbhCMXYJ
X-Google-Smtp-Source: AGHT+IEJnvnd0kkpAn4ooC+Ms8Spv82lxq89ERnka3qlVa/iSRR8CH8GNZLsyOsFWec6BkTvUX5xog==
X-Received: by 2002:a17:902:daca:b0:1eb:2e59:d6a with SMTP id d9443c01a7336-1eeb0697d24mr25553795ad.3.1715168614636;
        Wed, 08 May 2024 04:43:34 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e83a70d774sm11620938plg.187.2024.05.08.04.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:43:34 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com
Subject: [PATCH net-next v5 4/6] net: tn40xx: add basic Rx handling
Date: Wed,  8 May 2024 20:39:45 +0900
Message-Id: <20240508113947.68530-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508113947.68530-1-fujita.tomonori@gmail.com>
References: <20240508113947.68530-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c | 543 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/tehuti/tn40.h |  78 ++++-
 2 files changed, 612 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 6c6163bad2c2..b923ea58f2d4 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -61,6 +61,456 @@ static void tn40_fifo_free(struct tn40_priv *priv, struct tn40_fifo *f)
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
+static struct tn40_rx_page *tn40_rx_page_alloc(struct tn40_priv *priv)
+{
+	struct tn40_rx_page *rx_page = &priv->rx_page_table.rx_pages;
+	int page_size = priv->rx_page_table.page_size;
+	struct page *page;
+	gfp_t gfp_mask;
+	dma_addr_t dma;
+
+	gfp_mask = GFP_ATOMIC | __GFP_NOWARN;
+	if (page_size > PAGE_SIZE)
+		gfp_mask |= __GFP_COMP;
+
+	page = alloc_pages(gfp_mask, get_order(page_size));
+	if (likely(page)) {
+		netdev_dbg(priv->ndev, "map page %p size %d\n",
+			   page, page_size);
+		dma = dma_map_page(&priv->pdev->dev, page, 0, page_size,
+				   DMA_FROM_DEVICE);
+		if (unlikely(dma_mapping_error(&priv->pdev->dev, dma))) {
+			netdev_err(priv->ndev, "failed to map page %d\n",
+				   page_size);
+			__free_pages(page, get_order(page_size));
+			return NULL;
+		}
+	} else {
+		return NULL;
+	}
+
+	rx_page->page = page;
+	rx_page->dma = dma;
+	return rx_page;
+}
+
+static int tn40_rx_page_size(struct tn40_priv *priv)
+{
+	int dno = tn40_rxdb_available(priv->rxdb0) - 1;
+
+	priv->rx_page_table.page_size =
+		min(TN40_MAX_PAGE_SIZE, dno * priv->rx_page_table.buf_size);
+
+	return priv->rx_page_table.page_size;
+}
+
+static void tn40_rx_page_reuse(struct tn40_priv *priv, struct tn40_rx_map *dm)
+{
+	if (dm->off == 0)
+		dma_unmap_page(&priv->pdev->dev, dm->dma, dm->size,
+			       DMA_FROM_DEVICE);
+}
+
+static void tn40_rx_page_ref(struct tn40_rx_page *rx_page)
+{
+	get_page(rx_page->page);
+}
+
+static void tn40_rx_page_put(struct tn40_priv *priv, struct tn40_rx_map *dm)
+{
+	if (dm->off == 0)
+		dma_unmap_page(&priv->pdev->dev, dm->dma, dm->size,
+			       DMA_FROM_DEVICE);
+	put_page(dm->rx_page.page);
+}
+
+static void tn40_dm_rx_page_set(register struct tn40_rx_map *dm,
+				struct tn40_rx_page *rx_page)
+{
+	dm->rx_page.page = rx_page->page;
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
+	int ret, pkt_size, nr;
+
+	ret = tn40_fifo_alloc(priv, &priv->rxd_fifo0.m, priv->rxd_size,
+			      TN40_REG_RXD_CFG0_0, TN40_REG_RXD_CFG1_0,
+			      TN40_REG_RXD_RPTR_0, TN40_REG_RXD_WPTR_0);
+	if (ret)
+		return ret;
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
+
+	priv->rx_page_table.buf_size = round_up(pkt_size, SMP_CACHE_BYTES);
+	return 0;
+err_free_rxf:
+	tn40_fifo_free(priv, &priv->rxf_fifo0.m);
+err_free_rxd:
+	tn40_fifo_free(priv, &priv->rxd_fifo0.m);
+	return ret;
+}
+
+static void tn40_rx_free_buffers(struct tn40_priv *priv, struct tn40_rxdb *db,
+				 struct tn40_rxf_fifo *f)
+{
+	struct tn40_rx_map *dm;
+	u16 i;
+
+	netdev_dbg(priv->ndev, "total =%d free =%d busy =%d\n", db->nelem,
+		   tn40_rxdb_available(db),
+		   db->nelem - tn40_rxdb_available(db));
+	while (tn40_rxdb_available(db) > 0) {
+		i = tn40_rxdb_alloc_elem(db);
+		dm = tn40_rxdb_addr_elem(db, i);
+		dm->dma = 0;
+	}
+	for (i = 0; i < db->nelem; i++) {
+		dm = tn40_rxdb_addr_elem(db, i);
+		if (dm->dma && dm->rx_page.page)
+			tn40_rx_page_put(priv, dm);
+	}
+}
+
+static void tn40_destroy_rx_ring(struct tn40_priv *priv)
+{
+	if (priv->rxdb0) {
+		tn40_rx_free_buffers(priv, priv->rxdb0, &priv->rxf_fifo0);
+		tn40_rxdb_free(priv->rxdb0);
+		priv->rxdb0 = NULL;
+	}
+	tn40_fifo_free(priv, &priv->rxf_fifo0.m);
+	tn40_fifo_free(priv, &priv->rxd_fifo0.m);
+}
+
+/**
+ * tn40_rx_alloc_buffers - Fill rxf fifo with new skbs.
+ *
+ * @priv: NIC's private structure
+ *
+ * rx_alloc_buffers allocates skbs, builds rxf descs and pushes them (rxf
+ * descr) into the rxf fifo.  Skb's virtual and physical addresses are stored
+ * in skb db.
+ * To calculate the free space, we uses the cached values of RPTR and WPTR
+ * when needed. This function also updates RPTR and WPTR.
+ */
+static void tn40_rx_alloc_buffers(struct tn40_priv *priv)
+{
+	int buf_size = priv->rx_page_table.buf_size;
+	struct tn40_rxf_fifo *f = &priv->rxf_fifo0;
+	struct tn40_rx_page *rx_page = NULL;
+	struct tn40_rxdb *db = priv->rxdb0;
+	struct tn40_rxf_desc *rxfd;
+	struct tn40_rx_map *dm;
+	int dno, delta, idx;
+	int page_off = -1;
+	int n_pages = 0;
+	u64 dma = 0ULL;
+	int page_size;
+
+	dno = tn40_rxdb_available(db) - 1;
+	page_size = tn40_rx_page_size(priv);
+	netdev_dbg(priv->ndev, "dno %d page_size %d buf_size %d\n", dno,
+		   page_size, priv->rx_page_table.buf_size);
+	while (dno > 0) {
+		/* We allocate large pages (i.e. 64KB) and store
+		 * multiple packet buffers in each page. The packet
+		 * buffers are stored backwards in each page (starting
+		 * from the highest address). We utilize the fact that
+		 * the last buffer in each page has a 0 offset to
+		 * detect that all the buffers were processed in order
+		 * to unmap the page.
+		 */
+		if (unlikely(page_off < 0)) {
+			rx_page = tn40_rx_page_alloc(priv);
+			if (!rx_page) {
+				u32 timeout = 1000000;	/* 1/5 sec */
+
+				tn40_write_reg(priv, 0x5154, timeout);
+				netdev_dbg(priv->ndev,
+					   "system memory is temporary low\n");
+				break;
+			}
+			page_off = ((page_size / buf_size) - 1) * buf_size;
+			dma = rx_page->dma;
+			n_pages += 1;
+		} else {
+			tn40_rx_page_ref(rx_page);
+			/* Page is already allocated and mapped, just
+			 * increment the page usage count.
+			 */
+		}
+		rxfd = (struct tn40_rxf_desc *)(f->m.va + f->m.wptr);
+		idx = tn40_rxdb_alloc_elem(db);
+		dm = tn40_rxdb_addr_elem(db, idx);
+		dm->size = page_size;
+		tn40_dm_rx_page_set(dm, rx_page);
+		dm->off = page_off;
+		dm->dma = dma + page_off;
+		netdev_dbg(priv->ndev, "dm size %d off %d dma %llx\n", dm->size,
+			   dm->off, dm->dma);
+		page_off -= buf_size;
+
+		rxfd->info = cpu_to_le32(0x10003);	/* INFO =1 BC =3 */
+		rxfd->va_lo = cpu_to_le32(idx);
+		rxfd->pa_lo = cpu_to_le32(lower_32_bits(dm->dma));
+		rxfd->pa_hi = cpu_to_le32(upper_32_bits(dm->dma));
+		rxfd->len = cpu_to_le32(f->m.pktsz);
+		f->m.wptr += sizeof(struct tn40_rxf_desc);
+		delta = f->m.wptr - f->m.memsz;
+		if (unlikely(delta >= 0)) {
+			f->m.wptr = delta;
+			if (delta > 0) {
+				memcpy(f->m.va, f->m.va + f->m.memsz, delta);
+				netdev_dbg(priv->ndev,
+					   "wrapped rxd descriptor\n");
+			}
+		}
+		dno--;
+	}
+	netdev_dbg(priv->ndev, "n_pages %d\n", n_pages);
+	/* TBD: Do not update WPTR if no desc were written */
+	tn40_write_reg(priv, f->m.reg_wptr, f->m.wptr & TN40_TXF_WPTR_WR_PTR);
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
+	struct tn40_rx_map *dm = tn40_rxdb_addr_elem(priv->rxdb0,
+						     le32_to_cpu(rxdd->va_lo));
+	struct tn40_rxf_fifo *f = &priv->rxf_fifo0;
+	struct tn40_rxf_desc *rxfd;
+	int delta;
+
+	rxfd = (struct tn40_rxf_desc *)(f->m.va + f->m.wptr);
+	rxfd->info = cpu_to_le32(0x10003);	/* INFO=1 BC=3 */
+	rxfd->va_lo = rxdd->va_lo;
+	rxfd->pa_lo = cpu_to_le32(lower_32_bits(dm->dma));
+	rxfd->pa_hi = cpu_to_le32(upper_32_bits(dm->dma));
+	rxfd->len = cpu_to_le32(f->m.pktsz);
+	f->m.wptr += sizeof(struct tn40_rxf_desc);
+	delta = f->m.wptr - f->m.memsz;
+	if (unlikely(delta >= 0)) {
+		f->m.wptr = delta;
+		if (delta > 0) {
+			memcpy(f->m.va, f->m.va + f->m.memsz, delta);
+			netdev_dbg(priv->ndev, "wrapped rxf descriptor\n");
+		}
+	}
+}
+
+static int tn40_rx_receive(struct tn40_priv *priv, struct tn40_rxd_fifo *f,
+			   int budget)
+{
+	u32 rxd_val1, rxd_err, pkt_id;
+	struct tn40_rx_page *rx_page;
+	int tmp_len, size, done = 0;
+	struct tn40_rxdb *db = NULL;
+	struct tn40_rxd_desc *rxdd;
+	struct tn40_rx_map *dm;
+	struct sk_buff *skb;
+	u16 len, rxd_vlan;
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
+		dm = tn40_rxdb_addr_elem(db, le32_to_cpu(rxdd->va_lo));
+		prefetch(dm);
+		rx_page = &dm->rx_page;
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
+		/* In this case we obtain a pre-allocated skb from
+		 * napi. We add a frag with the page/off/len tuple of
+		 * the buffer that we have just read and then call
+		 * vlan_gro_frags()/napi_gro_frags() to process the
+		 * packet. The same skb is used again and again to
+		 * handle all packets, which eliminates the need to
+		 * allocate an skb for each packet.
+		 */
+		skb = napi_get_frags(&priv->napi);
+		if (!skb) {
+			netdev_err(priv->ndev, "napi_get_frags failed\n");
+			break;
+		}
+		skb->ip_summed =
+		    (pkt_id == 0) ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
+		skb_add_rx_frag(skb, 0, rx_page->page, dm->off, len,
+				SKB_TRUESIZE(len));
+		tn40_rxdb_free_elem(db, le32_to_cpu(rxdd->va_lo));
+
+		/* PROCESS PACKET */
+		if (TN40_GET_RXD_VTAG(rxd_val1))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       TN40_GET_RXD_VLAN_TCI(rxd_vlan));
+		napi_gro_frags(&priv->napi);
+
+		tn40_rx_page_reuse(priv, dm);
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
@@ -449,6 +899,56 @@ static int tn40_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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
@@ -729,6 +1229,10 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
 		tn40_isr_extra(priv, isr);
 
 	if (isr & (TN40_IR_RX_DESC_0 | TN40_IR_TX_FREE_0 | TN40_IR_TMR1)) {
+		if (likely(napi_schedule_prep(&priv->napi))) {
+			__napi_schedule(&priv->napi);
+			return IRQ_HANDLED;
+		}
 		/* We get here if an interrupt has slept into the
 		 * small time window between these lines in
 		 * tn40_poll: tn40_enable_interrupts(priv); return 0;
@@ -746,6 +1250,25 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
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
+	work_done = tn40_rx_receive(priv, &priv->rxd_fifo0, budget);
+	if (work_done == budget)
+		return budget;
+
+	napi_complete_done(napi, work_done);
+	tn40_enable_interrupts(priv);
+	return work_done;
+}
+
 static int tn40_fw_load(struct tn40_priv *priv)
 {
 	const struct firmware *fw = NULL;
@@ -828,6 +1351,8 @@ static void tn40_hw_start(struct tn40_priv *priv)
 	tn40_write_reg(priv, TN40_REG_TX_FULLNESS, 0);
 
 	tn40_write_reg(priv, TN40_REG_VGLB, 0);
+	tn40_write_reg(priv, TN40_REG_MAX_FRAME_A,
+		       priv->rxf_fifo0.m.pktsz & TN40_MAX_FRAME_AB_VAL);
 	tn40_write_reg(priv, TN40_REG_RDINTCM0, priv->rdintcm);
 	tn40_write_reg(priv, TN40_REG_RDINTCM2, 0);
 
@@ -930,15 +1455,25 @@ static int tn40_start(struct tn40_priv *priv)
 		return ret;
 	}
 
+	ret = tn40_create_rx_ring(priv);
+	if (ret) {
+		netdev_err(priv->ndev, "failed to rx init %d\n", ret);
+		goto err_tx_ring;
+	}
+
+	tn40_rx_alloc_buffers(priv);
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
@@ -948,9 +1483,12 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	napi_disable(&priv->napi);
+	netif_napi_del(&priv->napi);
 	tn40_disable_interrupts(priv);
 	free_irq(priv->pdev->irq, priv->ndev);
 	tn40_sw_reset(priv);
+	tn40_destroy_rx_ring(priv);
 	tn40_destroy_tx_ring(priv);
 	return 0;
 }
@@ -966,6 +1504,8 @@ static int tn40_open(struct net_device *dev)
 		netdev_err(dev, "failed to start %d\n", ret);
 		return ret;
 	}
+	napi_enable(&priv->napi);
+	netif_start_queue(priv->ndev);
 	return 0;
 }
 
@@ -1214,6 +1754,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	priv = netdev_priv(ndev);
 	pci_set_drvdata(pdev, priv);
+	netif_napi_add(ndev, &priv->napi, tn40_poll);
 
 	priv->regs = regs;
 	priv->pdev = pdev;
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index c1bd3952ca62..19bf1652b579 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -62,6 +62,33 @@ struct tn40_txd_fifo {
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
+struct tn40_rx_page {
+	struct page *page;
+	u64 dma;
+};
+
+struct tn40_rx_map {
+	struct tn40_rx_page rx_page;
+	u64 dma;
+	u32 off;
+	u32 size; /* Mapped area (i.e. page) size */
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
@@ -85,10 +112,24 @@ struct tn40_txdb {
 	int size; /* Number of elements in the db */
 };
 
+struct tn40_rx_page_table {
+	int page_size;
+	int buf_size;
+	struct tn40_rx_page rx_pages;
+};
+
 struct tn40_priv {
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 
+	struct napi_struct napi;
+	/* RX FIFOs: 1 for data (full) descs, and 2 for free descs */
+	struct tn40_rxd_fifo rxd_fifo0;
+	struct tn40_rxf_fifo rxf_fifo0;
+	struct tn40_rxdb *rxdb0; /* Rx dbs to store skb pointers */
+	int napi_stop;
+	struct vlan_group *vlgrp;
+
 	/* Tx FIFOs: 1 for data desc, 1 for empty (acks) desc */
 	struct tn40_txd_fifo txd_fifo0;
 	struct tn40_txf_fifo txf_fifo0;
@@ -117,6 +158,34 @@ struct tn40_priv {
 	u32 b0_len;
 	dma_addr_t b0_dma; /* Physical address of buffer */
 	char *b0_va; /* Virtual address of buffer */
+
+	struct tn40_rx_page_table rx_page_table;
+};
+
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
 };
 
 #define TN40_MAX_PBL (19)
@@ -158,14 +227,7 @@ struct tn40_txf_desc {
 	u32 pad;
 };
 
-/* 32 bit kernels use 16 bits for page_offset. Do not increase
- * LUXOR__MAX_PAGE_SIZE beyond 64K!
- */
-#if BITS_PER_LONG > 32
-#define TN40_MAX_PAGE_SIZE 0x40000
-#else
-#define TN40_MAX_PAGE_SIZE 0x10000
-#endif
+#define TN40_MAX_PAGE_SIZE ((int)PAGE_SIZE * 2)
 
 static inline u32 tn40_read_reg(struct tn40_priv *priv, u32 reg)
 {
-- 
2.34.1


