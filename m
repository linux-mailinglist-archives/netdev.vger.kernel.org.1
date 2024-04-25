Return-Path: <netdev+bounces-91142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C088B184E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7911C225D5
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D37411C92;
	Thu, 25 Apr 2024 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh9ku5fP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B78111AA
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007134; cv=none; b=Y3SvU+3vVyPknjPQfgFb62p+qSAqkXslFtqEQdv/y2GheadBuZJaqFcfhodUPXqd3dAvmaspiVJb695xtlcRdL2zR/wmwLYw3EB5TJoUhemO0JV27oXEE05uFUmoV4HvfsIr84R+U0MwE3SGm8twft3yGMgyfFvypaFAdvFdhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007134; c=relaxed/simple;
	bh=nTCshv0G98IB5WxsCDvDRVz4/XmsYrprGKgZeMCb+w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QoysTdW7IYeD6TZTU0kKcHir34G1fGu8xsHQYjfbcY3u4erjbLHeF8oqYnvSKRr+tt4vW2TngHlTWY9G8oWMkwb4j1AGvvvhbMriHk7bk6GEUiiNyoc6k+kA92QGVxQZ32c68B8eJ+XPX2Id2l4Go1UXnfavWFZmatCvLgmaC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh9ku5fP; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aca32d3f78so74056eaf.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714007130; x=1714611930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9hKI1A+uPkUMaKEXu9wdZpJGI27vOu6Kj0breS0yjY=;
        b=Nh9ku5fPKeI0Dtj9LE2mZ+JNFdxSTotBWnCsiaWHdp1bhhsiq1Tpsg9GkBP23TLdX2
         sVWIr9zCngzMjyZ1VY87XSdiPWOmqMqfWO69uNV50a3jqW6Gj1PenosOskw8VfrNOWsx
         c+U1LLxvaDXGNFt9tAdai8hxPRRC6M8QQDXTkMxYICuGyMiALWb0STiodwMvBuSCTgw+
         JrSPAmuRtoBFBHXU1TFGfwkIyCIWbJU13I32d9AliWjAZsQF/JrCRLCxhceaV7oQeSVG
         gZhcN8zdukw2qViBp2KnTZ9HlqGryFbgi6ZYJWAL5ZTdtmpPtd4j26sh1xu6teU+slL1
         ejQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007130; x=1714611930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9hKI1A+uPkUMaKEXu9wdZpJGI27vOu6Kj0breS0yjY=;
        b=WLTrCvhcZYDrm7V+3/06e8hNquGjEwiuozaMS3mzM0sqE6YS00Ag20HOeKRtWEbGhP
         BPD9rM68NLq+p0PJIgmjoaW9RpKcu3NBxXP3mCiPIszKTwvJmE4NQLzzeHAaMHpyTPc4
         dwO2Uig0dI7DcV7m2cOlr9Zbnf3ZnS+Fccy3oMGtQ2J+PAyaXpD4AeLVnarBP74jM9Ky
         c/h+LW/hqekijKTjDldez7BKNmdRgUfLjelegG9Tuku60Q2CiyzCYtXwR+4rDqKzB/gz
         bGKrOk1q7Lob/0qvnKAPPyR5OmqLPQZ+9rjYPqOHe4HAlPZ8b4Oa8AfECZS+CMB6v7ls
         tssg==
X-Gm-Message-State: AOJu0YySwfSywQxWzZeIfrJ1mo9FFjCpffoM6j8Bi3lUrMN7vNS9WT0J
	ys78lX+2AIc8YXhNpkQeT47C0JvlRoBPDrHUvZVX3kAmxeXlWUoRuax4mg==
X-Google-Smtp-Source: AGHT+IFmQl5OPZy8Fcje9GNCrHYbSwhu3Jc8KlXeb3cC83xiVQgjgfGoHP2NTyca7+SCllRpavz1PA==
X-Received: by 2002:a05:6830:1503:b0:6eb:c386:3c3a with SMTP id k3-20020a056830150300b006ebc3863c3amr4861822otp.0.1714007129490;
        Wed, 24 Apr 2024 18:05:29 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm5644940pgl.30.2024.04.24.18.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:05:29 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v2 4/6] net: tn40xx: add basic Rx handling
Date: Thu, 25 Apr 2024 10:03:52 +0900
Message-Id: <20240425010354.32605-5-fujita.tomonori@gmail.com>
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

This patch adds basic Rx handling. The Rx logic uses three major data
structures; two ring buffers with NIC and one database. One ring
buffer is used to send information to NIC about memory to be stored
packets to be received. The other is used to get information from NIC
about received packets. The database is used to keep the information
about DMA mapping. After a packet arrived, the db is used to pass the
packet to the network stack.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/tn40.c | 537 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/tehuti/tn40.h |  69 ++++
 2 files changed, 605 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 014ef9b3fcbd..f676fc6e1d3a 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -53,6 +53,453 @@ static void tn40_fifo_free(struct tn40_priv *priv, struct fifo *f)
 			  f->memsz + FIFO_EXTRA_SPACE, f->va, f->da);
 }
 
+static struct rxdb *rxdb_alloc(int nelem)
+{
+	size_t size = sizeof(struct rxdb) + (nelem * sizeof(int)) +
+	    (nelem * sizeof(struct rx_map));
+	struct rxdb *db;
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
+static void rxdb_free(struct rxdb *db)
+{
+	vfree(db);
+}
+
+static inline int rxdb_alloc_elem(struct rxdb *db)
+{
+	return db->stack[--(db->top)];
+}
+
+static inline void *rxdb_addr_elem(struct rxdb *db, unsigned int n)
+{
+	return db->elems + n;
+}
+
+static inline int rxdb_available(struct rxdb *db)
+{
+	return db->top;
+}
+
+static inline void rxdb_free_elem(struct rxdb *db, unsigned int n)
+{
+	db->stack[(db->top)++] = n;
+}
+
+static struct rx_page *rx_page_alloc(struct tn40_priv *priv)
+{
+	struct rx_page *rx_page = &priv->rx_page_table.rx_pages;
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
+static int rx_page_size(struct tn40_priv *priv)
+{
+	int dno = rxdb_available(priv->rxdb0) - 1;
+
+	priv->rx_page_table.page_size =
+	    min(LUXOR__MAX_PAGE_SIZE, dno * priv->rx_page_table.buf_size);
+
+	return priv->rx_page_table.page_size;
+}
+
+static void rx_page_reuse(struct tn40_priv *priv, struct rx_map *dm)
+{
+	if (dm->off == 0)
+		dma_unmap_page(&priv->pdev->dev, dm->dma, dm->size,
+			       DMA_FROM_DEVICE);
+}
+
+static void rx_page_ref(struct rx_page *rx_page)
+{
+	get_page(rx_page->page);
+}
+
+static void rx_page_put(struct tn40_priv *priv, struct rx_map *dm)
+{
+	if (dm->off == 0)
+		dma_unmap_page(&priv->pdev->dev, dm->dma, dm->size,
+			       DMA_FROM_DEVICE);
+	put_page(dm->rx_page.page);
+}
+
+static void dm_rx_page_set(register struct rx_map *dm, struct rx_page *rx_page)
+{
+	dm->rx_page.page = rx_page->page;
+}
+
+/**
+ * create_rx_ring - Initialize RX all related HW and SW resources
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
+static int create_rx_ring(struct tn40_priv *priv)
+{
+	int ret, pkt_size, nr;
+
+	ret = tn40_fifo_alloc(priv, &priv->rxd_fifo0.m, priv->rxd_size,
+			      REG_RXD_CFG0_0, REG_RXD_CFG1_0,
+			      REG_RXD_RPTR_0, REG_RXD_WPTR_0);
+	if (ret)
+		return ret;
+
+	ret = tn40_fifo_alloc(priv, &priv->rxf_fifo0.m, priv->rxf_size,
+			      REG_RXF_CFG0_0, REG_RXF_CFG1_0,
+			      REG_RXF_RPTR_0, REG_RXF_WPTR_0);
+	if (ret)
+		goto err_free_rxd;
+
+	pkt_size = priv->ndev->mtu + VLAN_ETH_HLEN;
+	priv->rxf_fifo0.m.pktsz = pkt_size;
+	nr = priv->rxf_fifo0.m.memsz / sizeof(struct rxf_desc);
+	priv->rxdb0 = rxdb_alloc(nr);
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
+static void rx_free_buffers(struct tn40_priv *priv, struct rxdb *db,
+			    struct rxf_fifo *f)
+{
+	struct rx_map *dm;
+	u16 i;
+
+	netdev_dbg(priv->ndev, "total =%d free =%d busy =%d\n", db->nelem,
+		   rxdb_available(db), db->nelem - rxdb_available(db));
+	while (rxdb_available(db) > 0) {
+		i = rxdb_alloc_elem(db);
+		dm = rxdb_addr_elem(db, i);
+		dm->dma = 0;
+	}
+	for (i = 0; i < db->nelem; i++) {
+		dm = rxdb_addr_elem(db, i);
+		if (dm->dma && dm->rx_page.page)
+			rx_page_put(priv, dm);
+	}
+}
+
+static void destroy_rx_ring(struct tn40_priv *priv)
+{
+	if (priv->rxdb0) {
+		rx_free_buffers(priv, priv->rxdb0, &priv->rxf_fifo0);
+		rxdb_free(priv->rxdb0);
+		priv->rxdb0 = NULL;
+	}
+	tn40_fifo_free(priv, &priv->rxf_fifo0.m);
+	tn40_fifo_free(priv, &priv->rxd_fifo0.m);
+}
+
+/**
+ * rx_alloc_buffers - Fill rxf fifo with new skbs.
+ *
+ * @priv: NIC's private structure
+ *
+ * rx_alloc_buffers allocates skbs, builds rxf descs and pushes them (rxf
+ * descr) into the rxf fifo.  Skb's virtual and physical addresses are stored
+ * in skb db.
+ * To calculate the free space, we uses the cached values of RPTR and WPTR
+ * when needed. This function also updates RPTR and WPTR.
+ */
+static void rx_alloc_buffers(struct tn40_priv *priv)
+{
+	int buf_size = priv->rx_page_table.buf_size;
+	struct rxf_fifo *f = &priv->rxf_fifo0;
+	struct rx_page *rx_page = NULL;
+	struct rxdb *db = priv->rxdb0;
+	struct rxf_desc *rxfd;
+	int dno, delta, idx;
+	struct rx_map *dm;
+	int page_off = -1;
+	int n_pages = 0;
+	u64 dma = 0ULL;
+	int page_size;
+
+	dno = rxdb_available(db) - 1;
+	page_size = rx_page_size(priv);
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
+			rx_page = rx_page_alloc(priv);
+			if (!rx_page) {
+				u32 timeout = 1000000;	/* 1/5 sec */
+
+				write_reg(priv, 0x5154, timeout);
+				netdev_dbg(priv->ndev,
+					   "system memory is temporary low\n");
+				break;
+			}
+			page_off = ((page_size / buf_size) - 1) * buf_size;
+			dma = rx_page->dma;
+			n_pages += 1;
+		} else {
+			rx_page_ref(rx_page);
+			/* Page is already allocated and mapped, just
+			 * increment the page usage count.
+			 */
+		}
+		rxfd = (struct rxf_desc *)(f->m.va + f->m.wptr);
+		idx = rxdb_alloc_elem(db);
+		dm = rxdb_addr_elem(db, idx);
+		dm->size = page_size;
+		dm_rx_page_set(dm, rx_page);
+		dm->off = page_off;
+		dm->dma = dma + page_off;
+		netdev_dbg(priv->ndev, "dm size %d off %d dma %p\n", dm->size,
+			   dm->off, (void *)dm->dma);
+		page_off -= buf_size;
+
+		rxfd->info = cpu_to_le32(0x10003);	/* INFO =1 BC =3 */
+		rxfd->va_lo = cpu_to_le32(idx);
+		rxfd->pa_lo = cpu_to_le32(lower_32_bits(dm->dma));
+		rxfd->pa_hi = cpu_to_le32(upper_32_bits(dm->dma));
+		rxfd->len = cpu_to_le32(f->m.pktsz);
+		f->m.wptr += sizeof(struct rxf_desc);
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
+	write_reg(priv, f->m.reg_wptr, f->m.wptr & TXF_WPTR_WR_PTR);
+	netdev_dbg(priv->ndev, "write_reg 0x%04x f->m.reg_wptr 0x%x\n",
+		   f->m.reg_wptr, f->m.wptr & TXF_WPTR_WR_PTR);
+	netdev_dbg(priv->ndev, "read_reg  0x%04x f->m.reg_rptr=0x%x\n",
+		   f->m.reg_rptr, read_reg(priv, f->m.reg_rptr));
+	netdev_dbg(priv->ndev, "write_reg 0x%04x f->m.reg_wptr=0x%x\n",
+		   f->m.reg_wptr, read_reg(priv, f->m.reg_wptr));
+}
+
+static void tn40_recycle_skb(struct tn40_priv *priv, struct rxd_desc *rxdd)
+{
+	struct rx_map *dm = rxdb_addr_elem(priv->rxdb0,
+					   le32_to_cpu(rxdd->va_lo));
+	struct rxf_fifo *f = &priv->rxf_fifo0;
+	struct rxf_desc *rxfd;
+	int delta;
+
+	rxfd = (struct rxf_desc *)(f->m.va + f->m.wptr);
+	rxfd->info = cpu_to_le32(0x10003);	/* INFO=1 BC=3 */
+	rxfd->va_lo = rxdd->va_lo;
+	rxfd->pa_lo = cpu_to_le32(lower_32_bits(dm->dma));
+	rxfd->pa_hi = cpu_to_le32(upper_32_bits(dm->dma));
+	rxfd->len = cpu_to_le32(f->m.pktsz);
+	f->m.wptr += sizeof(struct rxf_desc);
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
+static int tn40_rx_receive(struct tn40_priv *priv, struct rxd_fifo *f,
+			   int budget)
+{
+	u32 rxd_val1, rxd_err, pkt_id;
+	int tmp_len, size, done = 0;
+	struct rx_page *rx_page;
+	struct rxdb *db = NULL;
+	struct rxd_desc *rxdd;
+	struct sk_buff *skb;
+	struct rx_map *dm;
+	u16 len, rxd_vlan;
+
+	f->m.wptr = read_reg(priv, f->m.reg_wptr) & TXF_WPTR_WR_PTR;
+	size = f->m.wptr - f->m.rptr;
+	if (size < 0)
+		size += f->m.memsz;	/* Size is negative :-) */
+
+	while (size > 0) {
+		rxdd = (struct rxd_desc *)(f->m.va + f->m.rptr);
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
+		tmp_len = GET_RXD_BC(rxd_val1) << 3;
+		pkt_id = GET_RXD_PKT_ID(rxd_val1);
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
+		dm = rxdb_addr_elem(db, le32_to_cpu(rxdd->va_lo));
+		prefetch(dm);
+		rx_page = &dm->rx_page;
+
+		len = le16_to_cpu(rxdd->len);
+		rxd_vlan = le16_to_cpu(rxdd->rxd_vlan);
+		/* CHECK FOR ERRORS */
+		rxd_err = GET_RXD_ERR(rxd_val1);
+		if (unlikely(rxd_err)) {
+			netdev_err(priv->ndev, "rxd_err = 0x%x\n", rxd_err);
+			priv->net_stats.rx_errors++;
+			tn40_recycle_skb(priv, rxdd);
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
+		rxdb_free_elem(db, le32_to_cpu(rxdd->va_lo));
+
+		/* PROCESS PACKET */
+		if (GET_RXD_VTAG(rxd_val1))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       GET_RXD_VLAN_TCI(rxd_vlan));
+		napi_gro_frags(&priv->napi);
+
+		rx_page_reuse(priv, dm);
+		priv->net_stats.rx_bytes += len;
+
+		if (unlikely(++done >= budget))
+			break;
+	}
+
+	priv->net_stats.rx_packets += done;
+	/* FIXME: Do something to minimize pci accesses */
+	write_reg(priv, f->m.reg_rptr, f->m.rptr & TXF_WPTR_WR_PTR);
+	rx_alloc_buffers(priv);
+	return done;
+}
+
 /* TX HW/SW interaction overview
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * There are 2 types of TX communication channels between driver and NIC.
@@ -439,6 +886,56 @@ static int tn40_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+static void tn40_tx_cleanup(struct tn40_priv *priv)
+{
+	struct txf_fifo *f = &priv->txf_fifo0;
+	struct txdb *db = &priv->txdb;
+	int tx_level = 0;
+
+	f->m.wptr = read_reg(priv, f->m.reg_wptr) & TXF_WPTR_MASK;
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
+			tx_db_inc_rptr(db);
+		} while (db->rptr->len > 0);
+		tx_level -= db->rptr->len; /* '-' Because the len is negative */
+
+		/* Now should come skb pointer - free it */
+		dev_kfree_skb_any(db->rptr->addr.skb);
+		netdev_dbg(priv->ndev, "dev_kfree_skb_any %p %d\n",
+			   db->rptr->addr.skb, -db->rptr->len);
+		tx_db_inc_rptr(db);
+	}
+
+	/* Let the HW know which TXF descriptors were cleaned */
+	write_reg(priv, f->m.reg_rptr, f->m.rptr & TXF_WPTR_WR_PTR);
+
+	/* We reclaimed resources, so in case the Q is stopped by xmit
+	 * callback, we resume the transmission and use tx_lock to
+	 * synchronize with xmit.
+	 */
+	priv->tx_level += tx_level;
+	if (priv->tx_noupd) {
+		priv->tx_noupd = 0;
+		write_reg(priv, priv->txd_fifo0.m.reg_wptr,
+			  priv->txd_fifo0.m.wptr & TXF_WPTR_WR_PTR);
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
 	struct txdb *db = &priv->txdb;
@@ -718,6 +1215,11 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
 		tn40_isr_extra(priv, isr);
 
 	if (isr & (IR_RX_DESC_0 | IR_TX_FREE_0 | IR_TMR1)) {
+		if (likely(napi_schedule_prep(&priv->napi))) {
+			__napi_schedule(&priv->napi);
+			return IRQ_HANDLED;
+		}
+
 		/* We get here if an interrupt has slept into the
 		 * small time window between these lines in
 		 * tn40_poll: tn40_enable_interrupts(priv); return 0;
@@ -735,6 +1237,21 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static int tn40_poll(struct napi_struct *napi, int budget)
+{
+	struct tn40_priv *priv = container_of(napi, struct tn40_priv, napi);
+	int work_done;
+
+	tn40_tx_cleanup(priv);
+
+	work_done = tn40_rx_receive(priv, &priv->rxd_fifo0, budget);
+	if (work_done < budget) {
+		napi_complete(napi);
+		tn40_enable_interrupts(priv);
+	}
+	return work_done;
+}
+
 static int tn40_fw_load(struct tn40_priv *priv)
 {
 	const struct firmware *fw = NULL;
@@ -817,6 +1334,8 @@ static void tn40_hw_start(struct tn40_priv *priv)
 	write_reg(priv, REG_TX_FULLNESS, 0);
 
 	write_reg(priv, REG_VGLB, 0);
+	write_reg(priv, REG_MAX_FRAME_A,
+		  priv->rxf_fifo0.m.pktsz & MAX_FRAME_AB_VAL);
 	write_reg(priv, REG_RDINTCM0, priv->rdintcm);
 	write_reg(priv, REG_RDINTCM2, 0);
 
@@ -917,15 +1436,25 @@ static int tn40_start(struct tn40_priv *priv)
 		return ret;
 	}
 
+	ret = create_rx_ring(priv);
+	if (ret) {
+		netdev_err(priv->ndev, "failed to rx init %d\n", ret);
+		goto err_tx_ring;
+	}
+
+	rx_alloc_buffers(priv);
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
+	destroy_rx_ring(priv);
 err_tx_ring:
 	destroy_tx_ring(priv);
 	return ret;
@@ -935,9 +1464,12 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	netif_napi_del(&priv->napi);
+	napi_disable(&priv->napi);
 	tn40_disable_interrupts(priv);
 	free_irq(priv->pdev->irq, priv->ndev);
 	tn40_sw_reset(priv);
+	destroy_rx_ring(priv);
 	destroy_tx_ring(priv);
 	return 0;
 }
@@ -953,6 +1485,8 @@ static int tn40_open(struct net_device *dev)
 		netdev_err(dev, "failed to start %d\n", ret);
 		return ret;
 	}
+	napi_enable(&priv->napi);
+	netif_start_queue(priv->ndev);
 	return 0;
 }
 
@@ -1200,6 +1734,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	priv = netdev_priv(ndev);
 	pci_set_drvdata(pdev, priv);
+	netif_napi_add(ndev, &priv->napi, tn40_poll);
 
 	priv->regs = regs;
 	priv->pdev = pdev;
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 0cf2eca0ae1a..2c24f75cab03 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -78,6 +78,33 @@ struct txd_fifo {
 	struct fifo m; /* The minimal set of variables used by all fifos */
 };
 
+struct rxf_fifo {
+	struct fifo m; /* The minimal set of variables used by all fifos */
+};
+
+struct rxd_fifo {
+	struct fifo m; /* The minimal set of variables used by all fifos */
+};
+
+struct rx_page {
+	struct page *page;
+	u64 dma;
+};
+
+struct rx_map {
+	struct rx_page rx_page;
+	u64 dma;
+	u32 off;
+	u32 size; /* Mapped area (i.e. page) size */
+};
+
+struct rxdb {
+	int *stack;
+	struct rx_map *elems;
+	int nelem;
+	int top;
+};
+
 union tx_dma_addr {
 	dma_addr_t dma;
 	struct sk_buff *skb;
@@ -101,10 +128,24 @@ struct txdb {
 	int size; /* Number of elements in the db */
 };
 
+struct rx_page_table {
+	int page_size;
+	int buf_size;
+	struct rx_page rx_pages;
+};
+
 struct tn40_priv {
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 
+	struct napi_struct napi;
+	/* RX FIFOs: 1 for data (full) descs, and 2 for free descs */
+	struct rxd_fifo rxd_fifo0;
+	struct rxf_fifo rxf_fifo0;
+	struct rxdb *rxdb0; /* Rx dbs to store skb pointers */
+	int napi_stop;
+	struct vlan_group *vlgrp;
+
 	/* Tx FIFOs: 1 for data desc, 1 for empty (acks) desc */
 	struct txd_fifo txd_fifo0;
 	struct txf_fifo txf_fifo0;
@@ -133,6 +174,34 @@ struct tn40_priv {
 	u32 b0_len;
 	dma_addr_t b0_dma; /* Physical address of buffer */
 	char *b0_va; /* Virtual address of buffer */
+
+	struct rx_page_table rx_page_table;
+};
+
+/* RX FREE descriptor - 64bit */
+struct rxf_desc {
+	__le32 info; /* Buffer Count + Info - described below */
+	__le32 va_lo; /* VAdr[31:0] */
+	__le32 va_hi; /* VAdr[63:32] */
+	__le32 pa_lo; /* PAdr[31:0] */
+	__le32 pa_hi; /* PAdr[63:32] */
+	__le32 len; /* Buffer Length */
+};
+
+#define GET_RXD_BC(x) FIELD_GET(GENMASK(4, 0), (x))
+#define GET_RXD_ERR(x) FIELD_GET(GENMASK(26, 21), (x))
+#define GET_RXD_PKT_ID(x) FIELD_GET(GENMASK(30, 28), (x))
+#define GET_RXD_VTAG(x) FIELD_GET(BIT(31), (x))
+#define GET_RXD_VLAN_TCI(x) FIELD_GET(GENMASK(15, 0), (x))
+
+struct rxd_desc {
+	__le32 rxd_val1;
+	__le16 len;
+	__le16 rxd_vlan;
+	__le32 va_lo;
+	__le32 va_hi;
+	__le32 rss_lo;
+	__le32 rss_hash;
 };
 
 #define MAX_PBL (19)
-- 
2.34.1


