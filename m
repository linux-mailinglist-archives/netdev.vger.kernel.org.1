Return-Path: <netdev+bounces-87859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D98A4CCE
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E4A1F22F86
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF215FB82;
	Mon, 15 Apr 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb+gAk7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45BB5D732
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177855; cv=none; b=a61hcVXGZn3yfNAjb8sQqAui1BYICv5UG1b5gLXK40IYqkMcf6jgI80lIeAluvcIlnzMs+fSR09+oNkg4RnPViq0X5raJFRUAkTjwjwivWWoOJnJR1wlm0IApOP9GXRymqmCTjnb+fceVkmHibEx8o/ZnatyvcOv2e6HHPutong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177855; c=relaxed/simple;
	bh=LeZRAPRUho0OGyCkBYRQhBmTHplfZGZ7Vak8rR29cmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwlPkHeuIO8M1a6xKSNiPLONaTUVSdMinog4gQIEHC1jjUyd+jo9xK0MenuDgmluVZYGvs0m573lYb2bCprrBA9AFoF+MC4I4XsZNWJXmK+B/wwMLiaBxalXvkA38HYusOzY7qJ2herdWB9jVc6dnjxlz1FriQGhlUZrJzUgKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb+gAk7q; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a2cced7482so498784a91.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177853; x=1713782653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5fHUNnvxn+Wz3sw3yjwkZBjwptVCSfLY/l0tfVytYI=;
        b=cb+gAk7qhxtFjOtf9J+vcSMlNSPI6xwKPWR/Sdu22W7tP4qdfBOtYBltpX1WNOW3FF
         4ZkapC7ChJR+74cLMoBdH/jw3NMWc7JE01TL3+Oi28xNJUjXceWkJVH9oKiYeFQf9Ct9
         ryQFA+cY3aNu9tXY5DnYnhqzztHSCm2d1I8mR9mVk/Ztu/KMt0mFSo29zAvLPnsqOChD
         Tbkox0sUAxtSZblgA4M3rKurFQ/AI8bhsyQ+xWgE7sCdnOhihMqFSpQDQBOQs6L8Y58c
         zz5GgE1O14Ra8Xdo0di33UehwIknmcqLGIjKoM6shna4KXzRAfr3sqB9jzeY9LJzRQAP
         2+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177853; x=1713782653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5fHUNnvxn+Wz3sw3yjwkZBjwptVCSfLY/l0tfVytYI=;
        b=Dd4voLn+za2HG8n3pe7jAns35lspM5rOLHixegDORJkntXX+uvh4crdcZ94YmW564G
         6rJ9VpkTAQzqSRAckcuLzkwHbdUud7lHjmvoO7YZL/QfyeVCcugSNm0QdiIUshViEL9O
         sOr7IHDm2xYK7bILa9YUuZVtGwqWry8SI+bEEJ/Tw/OdDLQLLOJSL6/R9yvwJPmhyKnO
         1h2gjCPC8ODzwpEloDR1MfSK6AAfIiYplsSNyovbj2VGM5++bJAK7YRHcL0PdkGAXbGQ
         uEizs8tTDMNS3pVw19w2sqd8DNM6bYXv65WJh3bPIwyq+785mLTF3Mpyqj1MWw5H+Ehw
         sfDw==
X-Gm-Message-State: AOJu0YxEb3HmJ59zzPVBCWb6Z4zp/d5iL/FlM48bpmt/FmuIR9H/E445
	8VC3g34uuI3e+AvU8XxzxzSKPBaeqWmdVzg6P0NaINaYMd/zdvd++aDUIA==
X-Google-Smtp-Source: AGHT+IEDcvEzLmfK+FY+s6xOCk3ChEREuT1n1xg4JfOKj+Y58maKn/w0+N5tAM/hdlxzuFS9hftJfA==
X-Received: by 2002:a17:902:da90:b0:1e5:1138:e299 with SMTP id j16-20020a170902da9000b001e51138e299mr11784531plx.1.1713177852600;
        Mon, 15 Apr 2024 03:44:12 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090274c400b001e256cb48f7sm7581991plt.197.2024.04.15.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:44:12 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch
Subject: [PATCH net-next v1 4/5] net: tn40xx: add basic Rx handling
Date: Mon, 15 Apr 2024 19:43:51 +0900
Message-Id: <20240415104352.4685-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415104352.4685-1-fujita.tomonori@gmail.com>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c | 643 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/tehuti/tn40.h |  77 ++++
 2 files changed, 719 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 0798df468fc3..c8ed9b743753 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -48,6 +48,559 @@ static void bdx_fifo_free(struct bdx_priv *priv, struct fifo *f)
 			  f->memsz + FIFO_EXTRA_SPACE, f->va, f->da);
 }
 
+static struct rxdb *bdx_rxdb_alloc(int nelem)
+{
+	struct rxdb *db;
+	int i;
+	size_t size = sizeof(struct rxdb) + (nelem * sizeof(int)) +
+	    (nelem * sizeof(struct rx_map));
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
+static void bdx_rxdb_free(struct rxdb *db)
+{
+	vfree(db);
+}
+
+static inline int bdx_rxdb_alloc_elem(struct rxdb *db)
+{
+	return db->stack[--(db->top)];
+}
+
+static inline void *bdx_rxdb_addr_elem(struct rxdb *db, unsigned int n)
+{
+	return db->elems + n;
+}
+
+static inline int bdx_rxdb_available(struct rxdb *db)
+{
+	return db->top;
+}
+
+static inline void bdx_rxdb_free_elem(struct rxdb *db, unsigned int n)
+{
+	db->stack[(db->top)++] = n;
+}
+
+static void bdx_rx_vlan(struct bdx_priv *priv, struct sk_buff *skb,
+			u32 rxd_val1, u16 rxd_vlan)
+{
+	if (GET_RXD_VTAG(rxd_val1))	/* Vlan case */
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+				       le16_to_cpu(GET_RXD_VLAN_TCI(rxd_vlan)));
+}
+
+static inline struct bdx_page *bdx_rx_page(struct rx_map *dm)
+{
+	return &dm->bdx_page;
+}
+
+static struct bdx_page *bdx_rx_get_page(struct bdx_priv *priv)
+{
+	gfp_t gfp_mask;
+	int page_size = priv->rx_page_table.page_size;
+	struct bdx_page *bdx_page = &priv->rx_page_table.bdx_pages;
+	struct page *page;
+	dma_addr_t dma;
+
+	gfp_mask = GFP_ATOMIC | __GFP_NOWARN;
+	if (page_size > PAGE_SIZE)
+		gfp_mask |= __GFP_COMP;
+
+	page = alloc_pages(gfp_mask, get_order(page_size));
+	if (likely(page)) {
+		netdev_dbg(priv->ndev, "map page %p size %d\n", page, page_size);
+		dma = dma_map_page(&priv->pdev->dev, page, 0, page_size,
+				   DMA_FROM_DEVICE);
+		if (unlikely(dma_mapping_error(&priv->pdev->dev, dma))) {
+			netdev_err(priv->ndev, "failed to map page %d\n", page_size);
+			__free_pages(page, get_order(page_size));
+			return NULL;
+		}
+	} else {
+		return NULL;
+	}
+
+	bdx_page->page = page;
+	bdx_page->dma = dma;
+	return bdx_page;
+}
+
+static int bdx_rx_get_page_size(struct bdx_priv *priv)
+{
+	struct rxdb *db = priv->rxdb0;
+	int dno = bdx_rxdb_available(db) - 1;
+
+	priv->rx_page_table.page_size =
+	    min(LUXOR__MAX_PAGE_SIZE, dno * priv->rx_page_table.buf_size);
+
+	return priv->rx_page_table.page_size;
+}
+
+static void bdx_rx_reuse_page(struct bdx_priv *priv, struct rx_map *dm)
+{
+	netdev_dbg(priv->ndev, "dm size %d off %d dma %p\n", dm->size, dm->off,
+		   (void *)dm->dma);
+	if (dm->off == 0) {
+		netdev_dbg(priv->ndev, "unmap page %p size %d\n", (void *)dm->dma, dm->size);
+		dma_unmap_page(&priv->pdev->dev, dm->dma, dm->size,
+			       DMA_FROM_DEVICE);
+	}
+}
+
+static void bdx_rx_ref_page(struct bdx_page *bdx_page)
+{
+	get_page(bdx_page->page);
+}
+
+static void bdx_rx_put_page(struct bdx_priv *priv, struct rx_map *dm)
+{
+	if (dm->off == 0)
+		dma_unmap_page(&priv->pdev->dev, dm->dma, dm->size,
+			       DMA_FROM_DEVICE);
+	put_page(dm->bdx_page.page);
+}
+
+static void bdx_rx_set_dm_page(register struct rx_map *dm,
+			       struct bdx_page *bdx_page)
+{
+	dm->bdx_page.page = bdx_page->page;
+}
+
+/**
+ * create_rx_ring - Initialize RX all related HW and SW resources
+ * @priv: NIC private structure
+ *
+ * bdx_rx_init creates rxf and rxd fifos, updates the relevant HW registers,
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
+static int create_rx_ring(struct bdx_priv *priv)
+{
+	int ret, pkt_size;
+
+	ret = bdx_fifo_alloc(priv, &priv->rxd_fifo0.m, priv->rxd_size,
+			     REG_RXD_CFG0_0, REG_RXD_CFG1_0,
+			     REG_RXD_RPTR_0, REG_RXD_WPTR_0);
+	if (ret)
+		return ret;
+
+	ret = bdx_fifo_alloc(priv, &priv->rxf_fifo0.m, priv->rxf_size,
+			     REG_RXF_CFG0_0, REG_RXF_CFG1_0,
+			     REG_RXF_RPTR_0, REG_RXF_WPTR_0);
+	if (ret)
+		goto err_free_rxd;
+
+	pkt_size = priv->ndev->mtu + VLAN_ETH_HLEN;
+	priv->rxf_fifo0.m.pktsz = pkt_size;
+	priv->rxdb0 =
+		bdx_rxdb_alloc(priv->rxf_fifo0.m.memsz / sizeof(struct rxf_desc));
+	if (!priv->rxdb0)
+		goto err_free_rxf;
+
+	priv->rx_page_table.buf_size = round_up(pkt_size, SMP_CACHE_BYTES);
+	return 0;
+err_free_rxf:
+	bdx_fifo_free(priv, &priv->rxf_fifo0.m);
+err_free_rxd:
+	bdx_fifo_free(priv, &priv->rxd_fifo0.m);
+	return ret;
+}
+
+static void bdx_rx_free_buffers(struct bdx_priv *priv, struct rxdb *db,
+				struct rxf_fifo *f)
+{
+	struct rx_map *dm;
+	u16 i;
+
+	netdev_dbg(priv->ndev, "total =%d free =%d busy =%d\n", db->nelem,
+		   bdx_rxdb_available(db), db->nelem - bdx_rxdb_available(db));
+	while (bdx_rxdb_available(db) > 0) {
+		i = bdx_rxdb_alloc_elem(db);
+		dm = bdx_rxdb_addr_elem(db, i);
+		dm->dma = 0;
+	}
+	for (i = 0; i < db->nelem; i++) {
+		dm = bdx_rxdb_addr_elem(db, i);
+		if (dm->dma && dm->bdx_page.page)
+			bdx_rx_put_page(priv, dm);
+	}
+}
+
+static void destroy_rx_ring(struct bdx_priv *priv)
+{
+	if (priv->rxdb0) {
+		bdx_rx_free_buffers(priv, priv->rxdb0, &priv->rxf_fifo0);
+		bdx_rxdb_free(priv->rxdb0);
+		priv->rxdb0 = NULL;
+	}
+	bdx_fifo_free(priv, &priv->rxf_fifo0.m);
+	bdx_fifo_free(priv, &priv->rxd_fifo0.m);
+}
+
+/**
+ * bdx_rx_alloc_buffers - Fill rxf fifo with new skbs.
+ *
+ * @priv: NIC's private structure
+ *
+ * bdx_rx_alloc_buffers allocates skbs, builds rxf descs and pushes them (rxf
+ * descr) into the rxf fifo.  Skb's virtual and physical addresses are stored
+ * in skb db.
+ * To calculate the free space, we uses the cached values of RPTR and WPTR
+ * when needed. This function also updates RPTR and WPTR.
+ */
+static void bdx_rx_alloc_buffers(struct bdx_priv *priv)
+{
+	int dno, delta, idx;
+	struct rxf_desc *rxfd;
+	struct rx_map *dm;
+	int page_size;
+	struct rxdb *db = priv->rxdb0;
+	struct rxf_fifo *f = &priv->rxf_fifo0;
+	int n_pages = 0;
+	struct bdx_page *bdx_page = NULL;
+	int buf_size = priv->rx_page_table.buf_size;
+	int page_off = -1;
+	u64 dma = 0ULL;
+
+	dno = bdx_rxdb_available(db) - 1;
+	page_size = bdx_rx_get_page_size(priv);
+	netdev_dbg(priv->ndev, "dno %d page_size %d buf_size %d\n", dno, page_size,
+		   priv->rx_page_table.buf_size);
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
+			bdx_page = bdx_rx_get_page(priv);
+			if (!bdx_page) {
+				u32 timeout = 1000000;	/* 1/5 sec */
+
+				write_reg(priv, 0x5154, timeout);
+				netdev_dbg(priv->ndev, "system memory is temporary low\n");
+				break;
+			}
+			page_off = ((page_size / buf_size) - 1) * buf_size;
+			dma = bdx_page->dma;
+			n_pages += 1;
+		} else {
+			bdx_rx_ref_page(bdx_page);
+			/* Page is already allocated and mapped, just
+			 * increment the page usage count.
+			 */
+		}
+		rxfd = (struct rxf_desc *)(f->m.va + f->m.wptr);
+		idx = bdx_rxdb_alloc_elem(db);
+		dm = bdx_rxdb_addr_elem(db, idx);
+		dm->size = page_size;
+		bdx_rx_set_dm_page(dm, bdx_page);
+		dm->off = page_off;
+		dm->dma = dma + page_off;
+		netdev_dbg(priv->ndev, "dm size %d off %d dma %p\n", dm->size, dm->off,
+			   (void *)dm->dma);
+		page_off -= buf_size;
+
+		rxfd->info = cpu_to_le32(0x10003);	/* INFO =1 BC =3 */
+		rxfd->va_lo = idx;
+		rxfd->pa_lo = cpu_to_le32(L32_64(dm->dma));
+		rxfd->pa_hi = cpu_to_le32(H32_64(dm->dma));
+		rxfd->len = cpu_to_le32(f->m.pktsz);
+		f->m.wptr += sizeof(struct rxf_desc);
+		delta = f->m.wptr - f->m.memsz;
+		if (unlikely(delta >= 0)) {
+			f->m.wptr = delta;
+			if (delta > 0) {
+				memcpy(f->m.va, f->m.va + f->m.memsz, delta);
+				netdev_dbg(priv->ndev, "wrapped rxd descriptor\n");
+			}
+		}
+		dno--;
+	}
+	netdev_dbg(priv->ndev, "n_pages %d\n", n_pages);
+	/* TBD: Do not update WPTR if no desc were written */
+	write_reg(priv, f->m.reg_wptr, f->m.wptr & TXF_WPTR_WR_PTR);
+	netdev_dbg(priv->ndev, "write_reg 0x%04x f->m.reg_wptr 0x%x\n", f->m.reg_wptr,
+		   f->m.wptr & TXF_WPTR_WR_PTR);
+	netdev_dbg(priv->ndev, "read_reg  0x%04x f->m.reg_rptr=0x%x\n", f->m.reg_rptr,
+		   read_reg(priv, f->m.reg_rptr));
+	netdev_dbg(priv->ndev, "write_reg 0x%04x f->m.reg_wptr=0x%x\n", f->m.reg_wptr,
+		   read_reg(priv, f->m.reg_wptr));
+}
+
+static void bdx_recycle_skb(struct bdx_priv *priv, struct rxd_desc *rxdd)
+{
+	struct rxdb *db = priv->rxdb0;
+	struct rx_map *dm = bdx_rxdb_addr_elem(db, rxdd->va_lo);
+	struct rxf_fifo *f = &priv->rxf_fifo0;
+	struct rxf_desc *rxfd = (struct rxf_desc *)(f->m.va + f->m.wptr);
+	int delta;
+
+	rxfd->info = cpu_to_le32(0x10003);	/* INFO=1 BC=3 */
+	rxfd->va_lo = rxdd->va_lo;
+	rxfd->pa_lo = cpu_to_le32(L32_64(dm->dma));
+	rxfd->pa_hi = cpu_to_le32(H32_64(dm->dma));
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
+static inline u16 checksum(u16 *buf, u16 len, u16 *saddr, u16 *daddr, u16 proto)
+{
+	u32 sum;
+	u16 j = len;
+
+	sum = 0;
+	while (j > 1) {
+		sum += *buf++;
+		if (sum & 0x80000000)
+			sum = (sum & 0xFFFF) + (sum >> 16);
+
+		j -= 2;
+	}
+	if (j & 1)
+		sum += *((u8 *)buf);
+
+	/* Add the tcp pseudo-header */
+	sum += *(saddr++);
+	sum += *saddr;
+	sum += *(daddr++);
+	sum += *daddr;
+	sum += htons(proto);
+	sum += htons(len);
+	/* Fold 32-bit sum to 16 bits */
+	while (sum >> 16)
+		sum = (sum & 0xFFFF) + (sum >> 16);
+
+	/* One's complement of sum */
+	return ((u16)(sum));
+}
+
+static void bdx_skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page,
+				int off, int len)
+{
+	skb_add_rx_frag(skb, 0, page, off, len, SKB_TRUESIZE(len));
+}
+
+#define PKT_ERR_LEN		(70)
+
+static int bdx_rx_error(struct bdx_priv *priv, char *pkt, u32 rxd_err, u16 len)
+{
+	struct ethhdr *eth = (struct ethhdr *)pkt;
+	struct iphdr *iph =
+	    (struct iphdr *)(pkt + sizeof(struct ethhdr) +
+			     ((eth->h_proto ==
+			       htons(ETH_P_8021Q)) ? VLAN_HLEN : 0));
+	int ret = 1;
+
+	if (rxd_err == 0x8) {	/* UDP checksum error */
+		struct udphdr *udp =
+		    (struct udphdr *)((u8 *)iph + sizeof(struct iphdr));
+		if (udp->check == 0) {
+			netdev_dbg(priv->ndev, "false rxd_err = 0x%x\n", rxd_err);
+			ret = 0;	/* Work around H/W false error indication */
+		} else if (len < PKT_ERR_LEN) {
+			u16 sum = checksum((u16 *)udp,
+					   htons(iph->tot_len) -
+					   (iph->ihl * sizeof(u32)),
+					   (u16 *)&iph->saddr,
+					   (u16 *)&iph->daddr, IPPROTO_UDP);
+			if (sum == 0xFFFF) {
+				netdev_dbg(priv->ndev, "false rxd_err = 0x%x\n", rxd_err);
+				ret = 0;	/* Work around H/W false error indication */
+			}
+		}
+	} else if ((rxd_err == 0x10) && (len < PKT_ERR_LEN)) {	/* TCP checksum error */
+		u16 sum;
+		struct tcphdr *tcp =
+		    (struct tcphdr *)((u8 *)iph + sizeof(struct iphdr));
+		sum = checksum((u16 *)tcp,
+			       htons(iph->tot_len) - (iph->ihl * sizeof(u32)),
+			       (u16 *)&iph->saddr, (u16 *)&iph->daddr,
+			       IPPROTO_TCP);
+		if (sum == 0xFFFF) {
+			netdev_dbg(priv->ndev, "false rxd_err = 0x%x\n", rxd_err);
+			ret = 0;	/* Work around H/W false error indication */
+		}
+	}
+	return ret;
+}
+
+static int bdx_rx_receive(struct bdx_priv *priv, struct rxd_fifo *f, int budget)
+{
+	struct sk_buff *skb;
+	struct rxd_desc *rxdd;
+	struct rx_map *dm;
+	struct bdx_page *bdx_page;
+	struct rxf_fifo *rxf_fifo;
+	u32 rxd_val1, rxd_err;
+	u16 len;
+	u16 rxd_vlan;
+	u32 pkt_id;
+	int tmp_len, size;
+	char *pkt;
+	int done = 0;
+	struct rxdb *db = NULL;
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
+		rxd_val1 = cpu_to_le32(rxdd->rxd_val1);
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
+				/* COPY PARTIAL DESCRIPTOR TO THE END OF THE QUEUE */
+				netdev_dbg(priv->ndev, "wrapped desc rptr=%d tmp_len=%d\n",
+					   f->m.rptr, tmp_len);
+				memcpy(f->m.va + f->m.memsz, f->m.va, tmp_len);
+			}
+		}
+		dm = bdx_rxdb_addr_elem(db, rxdd->va_lo);
+		prefetch(dm);
+		bdx_page = bdx_rx_page(dm);
+
+		len = cpu_to_le16(rxdd->len);
+		rxd_vlan = cpu_to_le16(rxdd->rxd_vlan);
+		/* CHECK FOR ERRORS */
+		rxd_err = GET_RXD_ERR(rxd_val1);
+		if (unlikely(rxd_err)) {
+			int ret = 1;
+
+			/* NOT CRC error */
+			if (!(rxd_err & 0x4) &&
+			    /* UDP checksum error */
+			    ((rxd_err == 0x8 && pkt_id == 2) ||
+			     /* TCP checksum error */
+			     (rxd_err == 0x10 && len < PKT_ERR_LEN && pkt_id == 1))) {
+				pkt = ((char *)page_address(bdx_page->page) +
+				       dm->off);
+				ret = bdx_rx_error(priv, pkt, rxd_err, len);
+			}
+			if (ret) {
+				netdev_err(priv->ndev, "rxd_err = 0x%x\n", rxd_err);
+				priv->net_stats.rx_errors++;
+				bdx_recycle_skb(priv, rxdd);
+				continue;
+			}
+		}
+		rxf_fifo = &priv->rxf_fifo0;
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
+		bdx_skb_add_rx_frag(skb, 0, bdx_page->page, dm->off, len);
+		bdx_rxdb_free_elem(db, rxdd->va_lo);
+
+		/* PROCESS PACKET */
+		bdx_rx_vlan(priv, skb, rxd_val1, rxd_vlan);
+		napi_gro_frags(&priv->napi);
+
+		bdx_rx_reuse_page(priv, dm);
+		priv->net_stats.rx_bytes += len;
+
+		if (unlikely(++done >= budget))
+			break;
+	}
+
+	priv->net_stats.rx_packets += done;
+	/* FIXME: Do something to minimize pci accesses */
+	write_reg(priv, f->m.reg_rptr, f->m.rptr & TXF_WPTR_WR_PTR);
+	bdx_rx_alloc_buffers(priv);
+	return done;
+}
+
 /* TX HW/SW interaction overview
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * There are 2 types of TX communication channels between driver and NIC.
@@ -436,6 +989,58 @@ static int bdx_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+static void bdx_tx_cleanup(struct bdx_priv *priv)
+{
+	struct txf_fifo *f = &priv->txf_fifo0;
+	struct txdb *db = &priv->txdb;
+	int tx_level = 0;
+
+	f->m.wptr = read_reg(priv, f->m.reg_wptr) & TXF_WPTR_MASK;
+
+	netif_tx_lock(priv->ndev);
+	while (f->m.wptr != f->m.rptr) {
+		f->m.rptr += BDX_TXF_DESC_SZ;
+		f->m.rptr &= f->m.size_mask;
+		/* Unmap all fragments */
+		/* First has to come tx_maps containing DMA */
+		do {
+			netdev_dbg(priv->ndev, "pci_unmap_page 0x%llx len %d\n",
+				   db->rptr->addr.dma, db->rptr->len);
+			dma_unmap_page(&priv->pdev->dev, db->rptr->addr.dma,
+				       db->rptr->len, DMA_TO_DEVICE);
+			bdx_tx_db_inc_rptr(db);
+		} while (db->rptr->len > 0);
+		tx_level -= db->rptr->len;	/* '-' Because the len is negative */
+
+		/* Now should come skb pointer - free it */
+		dev_kfree_skb_any(db->rptr->addr.skb);
+		netdev_dbg(priv->ndev, "dev_kfree_skb_any %p %d\n", db->rptr->addr.skb,
+			   -db->rptr->len);
+		bdx_tx_db_inc_rptr(db);
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
+		     (priv->tx_level >= BDX_MAX_TX_LEVEL / 2))) {
+		netdev_dbg(priv->ndev, "TX Q WAKE level %d\n", priv->tx_level);
+		netif_wake_queue(priv->ndev);
+	}
+	netif_tx_unlock(priv->ndev);
+}
+
 static void bdx_tx_free_skbs(struct bdx_priv *priv)
 {
 	struct txdb *db = &priv->txdb;
@@ -713,6 +1318,11 @@ static irqreturn_t bdx_isr_napi(int irq, void *dev)
 		bdx_isr_extra(priv, isr);
 
 	if (isr & (IR_RX_DESC_0 | IR_TX_FREE_0 | IR_TMR1)) {
+		if (likely(napi_schedule_prep(&priv->napi))) {
+			__napi_schedule(&priv->napi);
+			return IRQ_HANDLED;
+		}
+
 		/* We get here if an interrupt has slept into the
 		 * small time window between these lines in
 		 * bdx_poll: bdx_enable_interrupts(priv); return 0;
@@ -730,6 +1340,21 @@ static irqreturn_t bdx_isr_napi(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static int bdx_poll(struct napi_struct *napi, int budget)
+{
+	struct bdx_priv *priv = container_of(napi, struct bdx_priv, napi);
+	int work_done;
+
+	bdx_tx_cleanup(priv);
+
+	work_done = bdx_rx_receive(priv, &priv->rxd_fifo0, budget);
+	if (work_done < budget) {
+		napi_complete(napi);
+		bdx_enable_interrupts(priv);
+	}
+	return work_done;
+}
+
 static int bdx_fw_load(struct bdx_priv *priv)
 {
 	int master, i, ret;
@@ -810,6 +1435,8 @@ static int bdx_hw_start(struct bdx_priv *priv)
 	write_reg(priv, REG_TX_FULLNESS, 0);
 
 	write_reg(priv, REG_VGLB, 0);
+	write_reg(priv, REG_MAX_FRAME_A,
+		  priv->rxf_fifo0.m.pktsz & MAX_FRAME_AB_VAL);
 	write_reg(priv, REG_RDINTCM0, priv->rdintcm);
 	write_reg(priv, REG_RDINTCM2, 0);
 
@@ -913,11 +1540,19 @@ static int bdx_start(struct bdx_priv *priv)
 		return ret;
 	}
 
+	ret = create_rx_ring(priv);
+	if (ret) {
+		netdev_err(priv->ndev, "failed to rx init %d\n", ret);
+		goto err_tx_ring;
+	}
+
+	bdx_rx_alloc_buffers(priv);
+
 	ret = request_irq(priv->pdev->irq, &bdx_isr_napi, IRQF_SHARED,
 			  priv->ndev->name, priv->ndev);
 	if (ret) {
 		netdev_err(priv->ndev, "failed to request irq %d\n", ret);
-		goto err_tx_ring;
+		goto err_rx_ring;
 	}
 
 	ret = bdx_hw_start(priv);
@@ -928,6 +1563,8 @@ static int bdx_start(struct bdx_priv *priv)
 	return 0;
 err_free_irq:
 	free_irq(priv->pdev->irq, priv->ndev);
+err_rx_ring:
+	destroy_rx_ring(priv);
 err_tx_ring:
 	destroy_tx_ring(priv);
 	return ret;
@@ -938,10 +1575,13 @@ static int bdx_close(struct net_device *ndev)
 	struct bdx_priv *priv = netdev_priv(ndev);
 
 	netif_carrier_off(ndev);
+	netif_napi_del(&priv->napi);
+	napi_disable(&priv->napi);
 
 	bdx_disable_interrupts(priv);
 	free_irq(priv->pdev->irq, priv->ndev);
 	bdx_sw_reset(priv);
+	destroy_rx_ring(priv);
 	destroy_tx_ring(priv);
 	return 0;
 }
@@ -1204,6 +1844,7 @@ static int bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	priv = netdev_priv(ndev);
 	pci_set_drvdata(pdev, priv);
+	netif_napi_add(ndev, &priv->napi, bdx_poll);
 
 	priv->regs = regs;
 	priv->pdev = pdev;
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index e8044e9d06eb..fb43ebb5911f 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -7,6 +7,7 @@
 #include <linux/crc32.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/firmware.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
@@ -19,6 +20,7 @@
 #include <linux/phy.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
+#include <linux/vmalloc.h>
 #include <linux/version.h>
 
 #include "tn40_regs.h"
@@ -98,6 +100,33 @@ struct txd_fifo {
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
+struct bdx_page {
+	struct page *page;
+	u64 dma;
+};
+
+struct rx_map {
+	struct bdx_page bdx_page;
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
 union bdx_dma_addr {
 	dma_addr_t dma;
 	struct sk_buff *skb;
@@ -121,10 +150,23 @@ struct txdb {
 	int size; /* Number of elements in the db */
 };
 
+struct bdx_rx_page_table {
+	int page_size;
+	int buf_size;
+	struct bdx_page bdx_pages;
+};
+
 struct bdx_priv {
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 
+	struct napi_struct napi;
+	/* RX FIFOs: 1 for data (full) descs, and 2 for free descs */
+	struct rxd_fifo rxd_fifo0;
+	struct rxf_fifo rxf_fifo0;
+	struct rxdb *rxdb0; /* Rx dbs to store skb pointers */
+	int napi_stop;
+	struct vlan_group *vlgrp;
 	/* Tx FIFOs: 1 for data desc, 1 for empty (acks) desc */
 	struct txd_fifo txd_fifo0;
 	struct txf_fifo txf_fifo0;
@@ -153,6 +195,41 @@ struct bdx_priv {
 	u32 b0_len;
 	dma_addr_t b0_dma; /* Physical address of buffer */
 	char *b0_va; /* Virtual address of buffer */
+
+	struct bdx_rx_page_table rx_page_table;
+};
+
+/* RX FREE descriptor - 64bit */
+struct rxf_desc {
+	u32 info; /* Buffer Count + Info - described below */
+	u32 va_lo; /* VAdr[31:0] */
+	u32 va_hi; /* VAdr[63:32] */
+	u32 pa_lo; /* PAdr[31:0] */
+	u32 pa_hi; /* PAdr[63:32] */
+	u32 len; /* Buffer Length */
+};
+
+#define GET_RXD_BC(x) GET_BITS_SHIFT((x), 5, 0)
+#define GET_RXD_RXFQ(x) GET_BITS_SHIFT((x), 2, 8)
+#define GET_RXD_TO(x) GET_BITS_SHIFT((x), 1, 15)
+#define GET_RXD_TYPE(x) GET_BITS_SHIFT((x), 4, 16)
+#define GET_RXD_ERR(x) GET_BITS_SHIFT((x), 6, 21)
+#define GET_RXD_RXP(x) GET_BITS_SHIFT((x), 1, 27)
+#define GET_RXD_PKT_ID(x) GET_BITS_SHIFT((x), 3, 28)
+#define GET_RXD_VTAG(x) GET_BITS_SHIFT((x), 1, 31)
+#define GET_RXD_VLAN_ID(x) GET_BITS_SHIFT((x), 12, 0)
+#define GET_RXD_VLAN_TCI(x) GET_BITS_SHIFT((x), 16, 0)
+#define GET_RXD_CFI(x) GET_BITS_SHIFT((x), 1, 12)
+#define GET_RXD_PRIO(x) GET_BITS_SHIFT((x), 3, 13)
+
+struct rxd_desc {
+	u32 rxd_val1;
+	u16 len;
+	u16 rxd_vlan;
+	u32 va_lo;
+	u32 va_hi;
+	u32 rss_lo;
+	u32 rss_hash;
 };
 
 #define MAX_PBL (19)
-- 
2.34.1


