Return-Path: <netdev+bounces-100065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153C8D7BE8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D41B1F2252D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A33381AF;
	Mon,  3 Jun 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtB3r/v6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5E2C859
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397581; cv=none; b=cHgCJzgUoqhR4SJ4u+3i7z5+H9cpfB9CO85HR54+Uu5KeDkGV+2dqMnUEjsZ1moPwA2jTdROWQr/FLrB4hObOBV1r/TMJr3zSMssxD47WCcKx/lA5MV8JgT23sZgrGnrrimRelYgi3XZThc1unCC9jxm5u/yGtIcE2Ktfub+qU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397581; c=relaxed/simple;
	bh=ae9fbnpBm66wD1su5yCqi+3SRaJPJwgxyLH3IX5jpcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJhoqMJt6XG/gSeTFPQ7kpIcERZaSGbWq4Mw3mm+/GoUwCBeTKltzIwXgLFOM09aoSSBuZZlj91CsI0pyswUVaXCaarKBPk/62tXd6NDU2p8flPEEqx8VDb9LN3VCH1yE0IJWrGf0y4A/AGsXZrWQBknzn09gvMwKzAixohnPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtB3r/v6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c1e9965478so354515a91.0
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 23:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717397578; x=1718002378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vkp4hzxyh7FJ19bFm+L+PyUHZ0pVRCW3cgKSCW9SIcE=;
        b=jtB3r/v6GinhnwC/99TwNNxxccKqBq4PSFH6RuPM3v7nldRJsVm3YKX5B/wGD78atI
         h0yYwxGdkF/LNDgRn8Ax1HRa2tordN4+X5TswhgvfeAWCDa0SgIiGObpbEGN+Tt7PmlN
         RFjeiEzgUp5EanNPcT/IvSnTAcbD+OFuayUBnn2ZTqyE4oqIK5QpcDrEg5eX9blOQlh7
         zpqdhYrxe1HqCjFBS2Cygvbb3QZqw832sHvFYc7JOOT5mm51ye+wGQhrUpqt2zzWHAlI
         Z0yccZLkjXSH1X6LDrSnLBl6+GoI8VE1kQ25Jq3FlKdPkphRMowxOXrQKpE0kU0ee+c5
         cGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717397578; x=1718002378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vkp4hzxyh7FJ19bFm+L+PyUHZ0pVRCW3cgKSCW9SIcE=;
        b=c1fAenPBfObrzm0ozXhMK+klKlLcpccS0/i/XM54Lu6qHLgu8KjWuUIPBzbiq8Hnsp
         vfzbUW+MkrPwBZMJiPyIlMoCBzFSJ4zc5paUbIG4s7j3O3XMwTkTbLkkQd8wbK9UK6hu
         0P7eJQHGJScllRkm51m9uiNuhXbz0pT74/QkeHVbIW3QEIUn47EstO9RcWiDDJUzoHMG
         tnHwV7kBES/ifuItPBZq7OzPL8NCe9LlMIHgY0iPw31hmu3PoOopyRDUmrVmUz8qE2rx
         8cmybJodtwGoi3S11K5GMMXQZVXzNvh5FmmPSynDGDbqZKtZpidMhqwqHNahm5MKtKny
         dTeA==
X-Gm-Message-State: AOJu0YxyLajoYg0k2OjUsfl3/zJLAuwkWyotmGq/Vxg966N3Raak6VXs
	Ts7ZeQKy+apqm5oXmtMGsDo7ySaZvUZ9e7qeGkg8z0dbpt7Alccqcb6VnwDl
X-Google-Smtp-Source: AGHT+IHsl2Ou77zkWGH5OyaecQCMAr5OtFSHodf8CczpGuJiMFy6Li2HXTj6GNG6r2Eeo0+N54vODg==
X-Received: by 2002:a05:6a20:5652:b0:1b1:f7ca:9942 with SMTP id adf61e73a8af0-1b26f3a34bcmr7055066637.6.1717397578167;
        Sun, 02 Jun 2024 23:52:58 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e293csm5448263a91.28.2024.06.02.23.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 23:52:57 -0700 (PDT)
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
Subject: [PATCH net-next v8 4/6] net: tn40xx: add basic Rx handling
Date: Mon,  3 Jun 2024 15:49:53 +0900
Message-Id: <20240603064955.58327-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603064955.58327-1-fujita.tomonori@gmail.com>
References: <20240603064955.58327-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c  | 443 +++++++++++++++++++++++++++-
 drivers/net/ethernet/tehuti/tn40.h  |  52 ++++
 3 files changed, 495 insertions(+), 1 deletion(-)

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
index 56decf3abfc9..52e2adfed4b3 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -8,6 +8,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
+#include <net/page_pool/helpers.h>
 
 #include "tn40.h"
 
@@ -62,6 +63,350 @@ static void tn40_fifo_free(struct tn40_priv *priv, struct tn40_fifo *f)
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
+	dno = i = tn40_rxdb_available(db) - 1;
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
@@ -450,6 +795,56 @@ static int tn40_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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
@@ -713,6 +1108,10 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
 		tn40_isr_extra(priv, isr);
 
 	if (isr & (TN40_IR_RX_DESC_0 | TN40_IR_TX_FREE_0 | TN40_IR_TMR1)) {
+		if (likely(napi_schedule_prep(&priv->napi))) {
+			__napi_schedule(&priv->napi);
+			return IRQ_HANDLED;
+		}
 		/* We get here if an interrupt has slept into the
 		 * small time window between these lines in
 		 * tn40_poll: tn40_enable_interrupts(priv); return 0;
@@ -730,6 +1129,25 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
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
@@ -812,6 +1230,8 @@ static void tn40_hw_start(struct tn40_priv *priv)
 	tn40_write_reg(priv, TN40_REG_TX_FULLNESS, 0);
 
 	tn40_write_reg(priv, TN40_REG_VGLB, 0);
+	tn40_write_reg(priv, TN40_REG_MAX_FRAME_A,
+		       priv->rxf_fifo0.m.pktsz & TN40_MAX_FRAME_AB_VAL);
 	tn40_write_reg(priv, TN40_REG_RDINTCM0, priv->rdintcm);
 	tn40_write_reg(priv, TN40_REG_RDINTCM2, 0);
 
@@ -913,15 +1333,30 @@ static int tn40_start(struct tn40_priv *priv)
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
@@ -933,11 +1368,14 @@ static void tn40_stop(struct tn40_priv *priv)
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
@@ -953,6 +1391,8 @@ static int tn40_open(struct net_device *dev)
 		netdev_err(dev, "failed to start %d\n", ret);
 		return ret;
 	}
+	napi_enable(&priv->napi);
+	netif_start_queue(priv->ndev);
 	return 0;
 }
 
@@ -1202,6 +1642,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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


