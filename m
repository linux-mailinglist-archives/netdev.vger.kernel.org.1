Return-Path: <netdev+bounces-84605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0062C89799B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246AC1C22A80
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C515575C;
	Wed,  3 Apr 2024 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeoRFek4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93279155758
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174947; cv=none; b=swvpnq1hgt3wZB//sZoLGmySCUyCtREt924xPYrulhZ23HolVdqlhXcEJgGVJvL6FbjAx3IhkxxHShMraRDd1NqEcMdd+UWlEQb5YOhJHfnDXX8Ji8O5IzJ1g0+aORVWUxI+MWQt5ZbiS8bhbiK45VmonPRtVI61F4Qi7mRniP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174947; c=relaxed/simple;
	bh=KYPadNLROppIXX2jYwputd1Q5RIgnWhSnfm+NMt/Lck=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfdJQNHG5g0H+Nrjy7V6aL78uHp3aQodETZuI3KIaJPf2tiWIUYcqGf3n7uRlPn7XXmw0aj4Lgc0sMQUs1N5cpJufrbthb+EIe2V4UeonzKL7S1vDRsTmeqB2+jCuUihcaIUdcjeVWQmhCPQJ+2V1ZwSnGqf8hjM7OVpe964yAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeoRFek4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e28efd8335so1706875ad.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174945; x=1712779745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9k1XmAzI3Hgm+OnwrkZSij5lZ6182abKvcydSr8PAQM=;
        b=TeoRFek4kZ8ffQsHK7I21wTe7MhpoXhmYNQKeZ0SXRoIXQ/LiAJddLlnyur66wXAKv
         PxsLXvB35YIKuiL5Nfsmuy8QRfX2rjZdEBBmC3vnFLvetiGWnC+A8aR9kAle3I5hU6Kf
         MLcBzy3zxWjLQW7DXBcYAK6p7Lh80p7VtrTsK8kx87tNA67uQYNEh+J1jCN3PBlG/H3w
         5GxyiU3ziSuKNz6vJt5UkPgmBjN562v6P5knWiIJ+iC+5GqgIoh5i+AclUn2PPWm7EDS
         Hi0GqE8lxSoYR6I/u5fBpOBRjAdInKgYYcB10NjeUky2cD404+Oty6pXGLgnCPqXsS3N
         IoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174945; x=1712779745;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9k1XmAzI3Hgm+OnwrkZSij5lZ6182abKvcydSr8PAQM=;
        b=LaV99OWJQ0jDW3zGPHGetHSnnAE0XCjN9CPcm/Y8FM+pEHRKnQG86MpF3l6lgBJt+3
         Vm56Ve9lp4pmMfL1kKL3ZsyFBns3WJmr6WNgkV61qnBs4lNjQgPLCjDd5aIZZz7Mi2qk
         d2JGVPP4mq2VzEBQDgOXJbo6ucYO8eQomLUqAyjl+Gg1Xji0gjlfe6ZwHuUOnKgTRV2V
         A8HMfh0rNgSA81HozA8TivHjTji0a2Ek/PFpDWnHpcSdYABvEpfgGoPv5Tl2mDS6a46k
         qibk1BYJ4x0l8Zc28fOOS4XLiVhQAxsKMOZF+jLo4VyE4ldYAgPw+zeJn5oPdPLP087v
         xm6w==
X-Gm-Message-State: AOJu0YzygNEgJDhQCQQSgsi9s5sbOqZy8up0BKg/IzBIg2jYq3nw63SY
	f0abEM8+R+UuiZcD9qy6OPdh5R2k/cNR2xCYusYmCDcNDWSXZjQ2
X-Google-Smtp-Source: AGHT+IGpX1FBeKPY5fBQ7Fa5RptdXFYhYvMLs2OBqtWv4ar4K39xgOoUW6BQYSTsosDVstGj++QbTA==
X-Received: by 2002:a17:903:2656:b0:1df:f681:3cd8 with SMTP id je22-20020a170903265600b001dff6813cd8mr369337plb.12.1712174944878;
        Wed, 03 Apr 2024 13:09:04 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902cec300b001e294f2f30dsm1885360plg.93.2024.04.03.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:09:04 -0700 (PDT)
Subject: [net-next PATCH 09/15] eth: fbnic: implement Rx queue
 alloc/start/stop/free
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Wed, 03 Apr 2024 13:09:02 -0700
Message-ID: 
 <171217494276.1598374.468010123854919775.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Implement control path parts of Rx queue handling.

The NIC consumes memory in pages. It takes a full page and places
packets into it in a configurable manner (with the ability to define
headroom / tailroom as well as head alignment requirements).
As mentioned in prior patches there are two page submissions queues
one for packet headers and second (optional) for packet payloads.
For now feed both queues from a single page pool.

Use the page pool "fragment" API, as we can't predict upfront
how the page will be sliced.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |   70 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |  466 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |   30 ++
 6 files changed, 568 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index e50c2827590b..33832a4f78ea 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -16,6 +16,10 @@
 
 #define FBNIC_CLOCK_FREQ	(600 * (1000 * 1000))
 
+/* Rx Buffer Descriptor Format */
+#define FBNIC_BD_PAGE_ADDR_MASK			DESC_GENMASK(45, 12)
+#define FBNIC_BD_PAGE_ID_MASK			DESC_GENMASK(63, 48)
+
 /* Register Definitions
  *
  * The registers are laid as indexes into an le32 array. As such the actual
@@ -451,12 +455,78 @@ enum {
 #define FBNIC_QUEUE_TIM_COUNTS_CNT0_MASK	CSR_GENMASK(14, 0)
 
 /* Rx Completion Queue Registers */
+#define FBNIC_QUEUE_RCQ_CTL		0x200		/* 0x800 */
+#define FBNIC_QUEUE_RCQ_CTL_RESET		CSR_BIT(0)
+#define FBNIC_QUEUE_RCQ_CTL_ENABLE		CSR_BIT(1)
+
 #define FBNIC_QUEUE_RCQ_HEAD		0x201		/* 0x804 */
 
+#define FBNIC_QUEUE_RCQ_SIZE		0x204		/* 0x810 */
+#define FBNIC_QUEUE_RCQ_SIZE_MASK		CSR_GENMASK(3, 0)
+
+#define FBNIC_QUEUE_RCQ_BAL		0x220		/* 0x880 */
+#define FBNIC_QUEUE_RCQ_BAH		0x221		/* 0x884 */
+
 /* Rx Buffer Descriptor Queue Registers */
+#define FBNIC_QUEUE_BDQ_CTL		0x240		/* 0x900 */
+#define FBNIC_QUEUE_BDQ_CTL_RESET		CSR_BIT(0)
+#define FBNIC_QUEUE_BDQ_CTL_ENABLE		CSR_BIT(1)
+#define FBNIC_QUEUE_BDQ_CTL_PPQ_ENABLE		CSR_BIT(30)
+
 #define FBNIC_QUEUE_BDQ_HPQ_TAIL	0x241		/* 0x904 */
 #define FBNIC_QUEUE_BDQ_PPQ_TAIL	0x242		/* 0x908 */
 
+#define FBNIC_QUEUE_BDQ_HPQ_SIZE	0x247		/* 0x91c */
+#define FBNIC_QUEUE_BDQ_PPQ_SIZE	0x248		/* 0x920 */
+#define FBNIC_QUEUE_BDQ_SIZE_MASK		CSR_GENMASK(3, 0)
+
+#define FBNIC_QUEUE_BDQ_HPQ_BAL		0x260		/* 0x980 */
+#define FBNIC_QUEUE_BDQ_HPQ_BAH		0x261		/* 0x984 */
+#define FBNIC_QUEUE_BDQ_PPQ_BAL		0x262		/* 0x988 */
+#define FBNIC_QUEUE_BDQ_PPQ_BAH		0x263		/* 0x98c */
+
+/* Rx DMA Engine Configuration */
+#define FBNIC_QUEUE_RDE_CTL0		0x2a0		/* 0xa80 */
+#define FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT	CSR_BIT(31)
+#define FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK	CSR_GENMASK(30, 29)
+enum {
+	FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE	= 0,
+	FBNIC_QUEUE_RDE_CTL0_DROP_WAIT		= 1,
+	FBNIC_QUEUE_RDE_CTL0_DROP_NEVER		= 2,
+};
+
+#define FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK	CSR_GENMASK(28, 20)
+#define FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK	CSR_GENMASK(19, 11)
+
+#define FBNIC_QUEUE_RDE_CTL1		0x2a1		/* 0xa84 */
+#define FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK	CSR_GENMASK(24, 12)
+#define FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK	CSR_GENMASK(11, 9)
+#define FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK	CSR_GENMASK(8, 6)
+#define FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK	CSR_GENMASK(5, 2)
+#define FBNIC_QUEUE_RDE_CTL1_PAYLD_PACK_MASK	CSR_GENMASK(1, 0)
+enum {
+	FBNIC_QUEUE_RDE_CTL1_PAYLD_PACK_NONE	= 0,
+	FBNIC_QUEUE_RDE_CTL1_PAYLD_PACK_ALL	= 1,
+	FBNIC_QUEUE_RDE_CTL1_PAYLD_PACK_RSS	= 2,
+};
+
+/* Rx Interrupt Manager Registers */
+#define FBNIC_QUEUE_RIM_CTL		0x2c0		/* 0xb00 */
+#define FBNIC_QUEUE_RIM_CTL_MSIX_MASK		CSR_GENMASK(7, 0)
+
+#define FBNIC_QUEUE_RIM_THRESHOLD	0x2c1		/* 0xb04 */
+#define FBNIC_QUEUE_RIM_THRESHOLD_RCD_MASK	CSR_GENMASK(14, 0)
+
+#define FBNIC_QUEUE_RIM_CLEAR		0x2c2		/* 0xb08 */
+#define FBNIC_QUEUE_RIM_CLEAR_MASK		CSR_BIT(0)
+#define FBNIC_QUEUE_RIM_SET		0x2c3		/* 0xb0c */
+#define FBNIC_QUEUE_RIM_SET_MASK		CSR_BIT(0)
+#define FBNIC_QUEUE_RIM_MASK		0x2c4		/* 0xb10 */
+#define FBNIC_QUEUE_RIM_MASK_MASK		CSR_BIT(0)
+
+#define FBNIC_QUEUE_RIM_COAL_STATUS	0x2c5		/* 0xb14 */
+#define FBNIC_QUEUE_RIM_RCD_COUNT_MASK		CSR_GENMASK(30, 16)
+#define FBNIC_QUEUE_RIM_TIMER_MASK		CSR_GENMASK(13, 0)
 #define FBNIC_MAX_QUEUES		128
 #define FBNIC_CSR_END_QUEUE	(0x40000 + 0x400 * FBNIC_MAX_QUEUES - 1)
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index dce3827d4398..171b159cc006 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -115,6 +115,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	INIT_LIST_HEAD(&fbn->napis);
 
 	fbn->txq_size = FBNIC_TXQ_SIZE_DEFAULT;
+	fbn->hpq_size = FBNIC_HPQ_SIZE_DEFAULT;
+	fbn->ppq_size = FBNIC_PPQ_SIZE_DEFAULT;
+	fbn->rcq_size = FBNIC_RCQ_SIZE_DEFAULT;
 
 	default_queues = netif_get_num_default_rss_queues();
 	if (default_queues > fbd->max_num_queues)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index b3c39c10c3f7..18f93e9431cc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -16,6 +16,9 @@ struct fbnic_net {
 	struct fbnic_dev *fbd;
 
 	u32 txq_size;
+	u32 hpq_size;
+	u32 ppq_size;
+	u32 rcq_size;
 
 	u16 num_napi;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 12d7fbf22d27..d6598c81a5f9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -131,6 +131,8 @@ void fbnic_up(struct fbnic_net *fbn)
 {
 	fbnic_enable(fbn);
 
+	fbnic_fill(fbn);
+
 	/* Enable Tx/Rx processing */
 	fbnic_napi_enable(fbn);
 	netif_tx_start_all_queues(fbn->netdev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index dd05ed96d8fc..484cab7342da 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -3,6 +3,8 @@
 
 #include <linux/iopoll.h>
 #include <linux/pci.h>
+#include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 
 #include "fbnic_netdev.h"
 #include "fbnic_txrx.h"
@@ -31,12 +33,128 @@ static void fbnic_ring_wr32(struct fbnic_ring *ring, unsigned int csr, u32 val)
 	writel(val, csr_base + csr);
 }
 
+static inline unsigned int fbnic_desc_unused(struct fbnic_ring *ring)
+{
+	return (ring->head - ring->tail - 1) & ring->size_mask;
+}
+
 netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 {
 	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
 
+static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
+				 struct page *page)
+{
+	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
+
+	page_pool_fragment_page(page, PAGECNT_BIAS_MAX);
+	rx_buf->pagecnt_bias = PAGECNT_BIAS_MAX;
+	rx_buf->page = page;
+}
+
+static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
+				  struct fbnic_napi_vector *nv, int budget)
+{
+	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
+	struct page *page = rx_buf->page;
+
+	if (!page_pool_unref_page(page, rx_buf->pagecnt_bias))
+		page_pool_put_unrefed_page(nv->page_pool, page, -1, !!budget);
+
+	rx_buf->page = NULL;
+}
+
+static void fbnic_clean_bdq(struct fbnic_napi_vector *nv, int napi_budget,
+			    struct fbnic_ring *ring, unsigned int hw_head)
+{
+	unsigned int head = ring->head;
+
+	if (head == hw_head)
+		return;
+
+	do {
+		fbnic_page_pool_drain(ring, head, nv, napi_budget);
+
+		head++;
+		head &= ring->size_mask;
+	} while (head != hw_head);
+
+	ring->head = head;
+}
+
+static __le64 fbnic_bd_prep(struct page *page, u16 id)
+{
+	dma_addr_t dma = page_pool_get_dma_addr(page);
+	u64 bd;
+
+	bd = (FBNIC_BD_PAGE_ADDR_MASK & dma) |
+	     FIELD_PREP(FBNIC_BD_PAGE_ID_MASK, id);
+
+	return cpu_to_le64(bd);
+}
+
+static void fbnic_fill_bdq(struct fbnic_napi_vector *nv, struct fbnic_ring *bdq)
+{
+	unsigned int count = fbnic_desc_unused(bdq);
+	unsigned int i = bdq->tail;
+
+	if (!count)
+		return;
+
+	do {
+		struct page *page;
+		__le64 *bd;
+
+		page = page_pool_dev_alloc_pages(nv->page_pool);
+		if (!page)
+			break;
+
+		fbnic_page_pool_init(bdq, i, page);
+
+		bd = &bdq->desc[i];
+		*bd = fbnic_bd_prep(page, i);
+
+		i++;
+		i &= bdq->size_mask;
+
+		count--;
+	} while (count);
+
+	if (bdq->tail != i) {
+		bdq->tail = i;
+
+		/* Force DMA writes to flush before writing to tail */
+		dma_wmb();
+
+		writel(i, bdq->doorbell);
+	}
+}
+
+static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
+			       struct fbnic_pkt_buff *pkt, int budget)
+{
+	struct skb_shared_info *shinfo;
+	struct page *page;
+	int nr_frags;
+
+	if (!pkt->buff.data_hard_start)
+		return;
+
+	shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+	nr_frags = pkt->nr_frags;
+
+	while (nr_frags--) {
+		page = skb_frag_page(&shinfo->frags[nr_frags]);
+		page_pool_put_full_page(nv->page_pool, page, !!budget);
+	}
+
+	page = virt_to_page(pkt->buff.data_hard_start);
+	page_pool_put_full_page(nv->page_pool, page, !!budget);
+	pkt->buff.data_hard_start = NULL;
+}
+
 static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
 {
 	struct fbnic_dev *fbd = nv->fbd;
@@ -100,6 +218,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 	}
 
 	free_irq(fbd->msix_entries[v_idx].vector, nv);
+	page_pool_destroy(nv->page_pool);
 	netif_napi_del(&nv->napi);
 	list_del(&nv->napis);
 	kfree(nv);
@@ -125,6 +244,42 @@ static void fbnic_name_napi_vector(struct fbnic_napi_vector *nv)
 			 nv->v_idx - FBNIC_NON_NAPI_VECTORS);
 }
 
+static int fbnic_alloc_nv_page_pool(struct fbnic_net *fbn,
+				    struct fbnic_napi_vector *nv)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = (fbn->hpq_size + fbn->ppq_size) * nv->rxt_count,
+		.nid = NUMA_NO_NODE,
+		.dev = nv->dev,
+		.dma_dir = DMA_BIDIRECTIONAL,
+		.offset = 0,
+		.max_len = PAGE_SIZE
+	};
+	struct page_pool *pp;
+
+	/* Page pool cannot exceed a size of 32768. This doesn't limit the
+	 * pages on the ring but the number we can have cached waiting on
+	 * the next use.
+	 *
+	 * TBD: Can this be reduced further? Would a multiple of
+	 * NAPI_POLL_WEIGHT possibly make more sense? The question is how
+	 * may pages do we need to hold in reserve to get the best return
+	 * without hogging too much system memory.
+	 */
+	if (pp_params.pool_size > 32768)
+		pp_params.pool_size = 32768;
+
+	pp = page_pool_create(&pp_params);
+	if (IS_ERR(pp))
+		return PTR_ERR(pp);
+
+	nv->page_pool = pp;
+
+	return 0;
+}
+
 static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
 			    int q_idx, u8 flags)
 {
@@ -174,6 +329,13 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	/* tie nv back to PCIe dev */
 	nv->dev = fbd->dev;
 
+	/* allocate page pool */
+	if (rxq_count) {
+		err = fbnic_alloc_nv_page_pool(fbn, nv);
+		if (err)
+			goto napi_del;
+	}
+
 	/* initialize vector name */
 	fbnic_name_napi_vector(nv);
 
@@ -182,7 +344,7 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	err = request_irq(vector, &fbnic_msix_clean_rings, IRQF_SHARED,
 			  nv->name, nv);
 	if (err)
-		goto napi_del;
+		goto pp_destroy;
 
 	/* Initialize queue triads */
 	qt = nv->qt;
@@ -239,6 +401,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 
 	return 0;
 
+pp_destroy:
+	page_pool_destroy(nv->page_pool);
 napi_del:
 	netif_napi_del(&nv->napi);
 	list_del(&nv->napis);
@@ -371,6 +535,77 @@ static int fbnic_alloc_tx_ring_resources(struct fbnic_net *fbn,
 	return err;
 }
 
+static int fbnic_alloc_rx_ring_desc(struct fbnic_net *fbn,
+				    struct fbnic_ring *rxr)
+{
+	struct device *dev = fbn->netdev->dev.parent;
+	u32 rxq_size;
+	size_t size;
+
+	switch (rxr->doorbell - fbnic_ring_csr_base(rxr)) {
+	case FBNIC_QUEUE_BDQ_HPQ_TAIL:
+		rxq_size = fbn->hpq_size;
+		break;
+	case FBNIC_QUEUE_BDQ_PPQ_TAIL:
+		rxq_size = fbn->ppq_size;
+		break;
+	case FBNIC_QUEUE_RCQ_HEAD:
+		rxq_size = fbn->rcq_size;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* round size up to nearest 4K */
+	size = ALIGN(array_size(sizeof(*rxr->desc), rxq_size), 4096);
+
+	rxr->desc = dma_alloc_coherent(dev, size, &rxr->dma,
+				       GFP_KERNEL | __GFP_NOWARN);
+	if (!rxr->desc)
+		return -ENOMEM;
+
+	/* rxq_size should be a power of 2, so mask is just that -1 */
+	rxr->size_mask = rxq_size - 1;
+	rxr->size = size;
+
+	return 0;
+}
+
+static int fbnic_alloc_rx_ring_buffer(struct fbnic_ring *rxr)
+{
+	size_t size = array_size(sizeof(*rxr->rx_buf), rxr->size_mask + 1);
+
+	if (rxr->flags & FBNIC_RING_F_CTX)
+		size = sizeof(*rxr->rx_buf) * (rxr->size_mask + 1);
+	else
+		size = sizeof(*rxr->pkt);
+
+	rxr->rx_buf = kvzalloc(size, GFP_KERNEL | __GFP_NOWARN);
+
+	return rxr->rx_buf ? 0 : -ENOMEM;
+}
+
+static int fbnic_alloc_rx_ring_resources(struct fbnic_net *fbn,
+					 struct fbnic_ring *rxr)
+{
+	struct device *dev = fbn->netdev->dev.parent;
+	int err;
+
+	err = fbnic_alloc_rx_ring_desc(fbn, rxr);
+	if (err)
+		return err;
+
+	err = fbnic_alloc_rx_ring_buffer(rxr);
+	if (err)
+		goto free_desc;
+
+	return 0;
+
+free_desc:
+	fbnic_free_ring_resources(dev, rxr);
+	return err;
+}
+
 static void fbnic_free_qt_resources(struct fbnic_net *fbn,
 				    struct fbnic_q_triad *qt)
 {
@@ -402,20 +637,50 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 	return err;
 }
 
+static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
+				       struct fbnic_q_triad *qt)
+{
+	struct device *dev = fbn->netdev->dev.parent;
+	int err;
+
+	err = fbnic_alloc_rx_ring_resources(fbn, &qt->sub0);
+	if (err)
+		return err;
+
+	err = fbnic_alloc_rx_ring_resources(fbn, &qt->sub1);
+	if (err)
+		goto free_sub0;
+
+	err = fbnic_alloc_rx_ring_resources(fbn, &qt->cmpl);
+	if (err)
+		goto free_sub1;
+
+	return 0;
+
+free_sub1:
+	fbnic_free_ring_resources(dev, &qt->sub1);
+free_sub0:
+	fbnic_free_ring_resources(dev, &qt->sub0);
+	return err;
+}
+
 static void fbnic_free_nv_resources(struct fbnic_net *fbn,
 				    struct fbnic_napi_vector *nv)
 {
-	int i;
+	int i, j;
 
 	/* Free Tx Resources  */
 	for (i = 0; i < nv->txt_count; i++)
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
+
+	for (j = 0; j < nv->rxt_count; j++, i++)
+		fbnic_free_qt_resources(fbn, &nv->qt[i]);
 }
 
 static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 				    struct fbnic_napi_vector *nv)
 {
-	int i, err;
+	int i, j, err;
 
 	/* Allocate Tx Resources */
 	for (i = 0; i < nv->txt_count; i++) {
@@ -424,6 +689,13 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 			goto free_resources;
 	}
 
+	/* Allocate Rx Resources */
+	for (j = 0; j < nv->rxt_count; j++, i++) {
+		err = fbnic_alloc_rx_qt_resources(fbn, &nv->qt[i]);
+		if (err)
+			goto free_resources;
+	}
+
 	return 0;
 
 free_resources:
@@ -475,6 +747,21 @@ static void fbnic_disable_tcq(struct fbnic_ring *txr)
 	fbnic_ring_wr32(txr, FBNIC_QUEUE_TIM_MASK, FBNIC_QUEUE_TIM_MASK_MASK);
 }
 
+static void fbnic_disable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
+{
+	u32 bdq_ctl = fbnic_ring_rd32(hpq, FBNIC_QUEUE_BDQ_CTL);
+
+	bdq_ctl &= ~FBNIC_QUEUE_BDQ_CTL_ENABLE;
+
+	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_CTL, bdq_ctl);
+}
+
+static void fbnic_disable_rcq(struct fbnic_ring *rxr)
+{
+	fbnic_ring_wr32(rxr, FBNIC_QUEUE_RCQ_CTL, 0);
+	fbnic_ring_wr32(rxr, FBNIC_QUEUE_RIM_MASK, FBNIC_QUEUE_RIM_MASK_MASK);
+}
+
 void fbnic_napi_disable(struct fbnic_net *fbn)
 {
 	struct fbnic_napi_vector *nv;
@@ -490,7 +777,7 @@ void fbnic_disable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_napi_vector *nv;
-	int i;
+	int i, j;
 
 	list_for_each_entry(nv, &fbn->napis, napis) {
 		/* disable Tx Queue Triads */
@@ -500,6 +787,14 @@ void fbnic_disable(struct fbnic_net *fbn)
 			fbnic_disable_twq0(&qt->sub0);
 			fbnic_disable_tcq(&qt->cmpl);
 		}
+
+		/* disable Rx Queue Triads */
+		for (j = 0; j < nv->rxt_count; j++, i++) {
+			struct fbnic_q_triad *qt = &nv->qt[i];
+
+			fbnic_disable_bdq(&qt->sub0, &qt->sub1);
+			fbnic_disable_rcq(&qt->cmpl);
+		}
 	}
 
 	wrfl();
@@ -559,6 +854,10 @@ int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
 		{ FBNIC_QM_TQS_IDLE(0),	FBNIC_QM_TQS_IDLE_CNT, },
 		{ FBNIC_QM_TDE_IDLE(0),	FBNIC_QM_TDE_IDLE_CNT, },
 		{ FBNIC_QM_TCQ_IDLE(0),	FBNIC_QM_TCQ_IDLE_CNT, },
+	}, rx[] = {
+		{ FBNIC_QM_HPQ_IDLE(0),	FBNIC_QM_HPQ_IDLE_CNT, },
+		{ FBNIC_QM_PPQ_IDLE(0),	FBNIC_QM_PPQ_IDLE_CNT, },
+		{ FBNIC_QM_RCQ_IDLE(0),	FBNIC_QM_RCQ_IDLE_CNT, },
 	};
 	bool idle;
 	int err;
@@ -578,6 +877,10 @@ int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
 			return err;
 	}
 
+	err = read_poll_timeout_atomic(fbnic_all_idle, idle, idle, 2, 500000,
+				       false, fbd, rx, ARRAY_SIZE(rx));
+	if (err)
+		fbnic_idle_dump(fbd, rx, ARRAY_SIZE(rx), "Rx", err);
 	return err;
 }
 
@@ -586,7 +889,7 @@ void fbnic_flush(struct fbnic_net *fbn)
 	struct fbnic_napi_vector *nv;
 
 	list_for_each_entry(nv, &fbn->napis, napis) {
-		int i;
+		int i, j;
 
 		/* Flush any processed Tx Queue Triads and drop the rest */
 		for (i = 0; i < nv->txt_count; i++) {
@@ -601,6 +904,38 @@ void fbnic_flush(struct fbnic_net *fbn)
 						       qt->sub0.q_idx);
 			netdev_tx_reset_queue(tx_queue);
 		}
+
+		/* Flush any processed Rx Queue Triads and drop the rest */
+		for (j = 0; j < nv->rxt_count; j++, i++) {
+			struct fbnic_q_triad *qt = &nv->qt[i];
+
+			/* Clean the work queues of unprocessed work */
+			fbnic_clean_bdq(nv, 0, &qt->sub0, qt->sub0.tail);
+			fbnic_clean_bdq(nv, 0, &qt->sub1, qt->sub1.tail);
+
+			/* Reset completion queue descriptor ring */
+			memset(qt->cmpl.desc, 0, qt->cmpl.size);
+
+			fbnic_put_pkt_buff(nv, qt->cmpl.pkt, 0);
+		}
+	}
+}
+
+void fbnic_fill(struct fbnic_net *fbn)
+{
+	struct fbnic_napi_vector *nv;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		int i, j;
+
+		/* Populate pages in the BDQ rings to use for Rx */
+		for (j = 0, i = nv->txt_count; j < nv->rxt_count; j++, i++) {
+			struct fbnic_q_triad *qt = &nv->qt[i];
+
+			/* populate the header and payload BDQs */
+			fbnic_fill_bdq(nv, &qt->sub0);
+			fbnic_fill_bdq(nv, &qt->sub1);
+		}
 	}
 }
 
@@ -655,11 +990,102 @@ static void fbnic_enable_tcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TCQ_CTL, FBNIC_QUEUE_TCQ_CTL_ENABLE);
 }
 
+static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
+{
+	u32 bdq_ctl = FBNIC_QUEUE_BDQ_CTL_ENABLE;
+	u32 log_size;
+
+	/* reset head/tail */
+	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_CTL, FBNIC_QUEUE_BDQ_CTL_RESET);
+	ppq->tail = 0;
+	ppq->head = 0;
+	hpq->tail = 0;
+	hpq->head = 0;
+
+	log_size = fls(hpq->size_mask);
+
+	/* Store descriptor ring address and size */
+	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_HPQ_BAL, lower_32_bits(hpq->dma));
+	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_HPQ_BAH, upper_32_bits(hpq->dma));
+
+	/* write lower 4 bits of log size as 64K ring size is 0 */
+	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_HPQ_SIZE, log_size & 0xf);
+
+	if (!ppq->size_mask)
+		goto write_ctl;
+
+	log_size = fls(ppq->size_mask);
+
+	/* Add enabling of PPQ to BDQ control */
+	bdq_ctl |= FBNIC_QUEUE_BDQ_CTL_PPQ_ENABLE;
+
+	/* Store descriptor ring address and size */
+	fbnic_ring_wr32(ppq, FBNIC_QUEUE_BDQ_PPQ_BAL, lower_32_bits(ppq->dma));
+	fbnic_ring_wr32(ppq, FBNIC_QUEUE_BDQ_PPQ_BAH, upper_32_bits(ppq->dma));
+	fbnic_ring_wr32(ppq, FBNIC_QUEUE_BDQ_PPQ_SIZE, log_size & 0xf);
+
+write_ctl:
+	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_CTL, bdq_ctl);
+}
+
+static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
+				       struct fbnic_ring *rcq)
+{
+	u32 drop_mode, rcq_ctl;
+
+	drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
+
+	/* Specify packet layout */
+	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
+	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, FBNIC_RX_HROOM) |
+	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM);
+
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
+}
+
+static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
+			     struct fbnic_ring *rcq)
+{
+	u32 log_size = fls(rcq->size_mask);
+	u32 rcq_ctl;
+
+	fbnic_config_drop_mode_rcq(nv, rcq);
+
+	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
+		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK,
+			      FBNIC_RX_MAX_HDR) |
+		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,
+			      FBNIC_RX_PAYLD_OFFSET) |
+		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK,
+			      FBNIC_RX_PAYLD_PG_CL);
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL1, rcq_ctl);
+
+	/* reset head/tail */
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_CTL, FBNIC_QUEUE_RCQ_CTL_RESET);
+	rcq->head = 0;
+	rcq->tail = 0;
+
+	/* Store descriptor ring address and size */
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_BAL, lower_32_bits(rcq->dma));
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_BAH, upper_32_bits(rcq->dma));
+
+	/* write lower 4 bits of log size as 64K ring size is 0 */
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_SIZE, log_size & 0xf);
+
+	/* Store interrupt information for the completion queue */
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_CTL, nv->v_idx);
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, rcq->size_mask / 2);
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_MASK, 0);
+
+	/* Enable queue */
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_CTL, FBNIC_QUEUE_RCQ_CTL_ENABLE);
+}
+
 void fbnic_enable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_napi_vector *nv;
-	int i;
+	int i, j;
 
 	list_for_each_entry(nv, &fbn->napis, napis) {
 		/* Setup Tx Queue Triads */
@@ -669,6 +1095,15 @@ void fbnic_enable(struct fbnic_net *fbn)
 			fbnic_enable_twq0(&qt->sub0);
 			fbnic_enable_tcq(nv, &qt->cmpl);
 		}
+
+		/* Setup Rx Queue Triads */
+		for (j = 0; j < nv->rxt_count; j++, i++) {
+			struct fbnic_q_triad *qt = &nv->qt[i];
+
+			fbnic_enable_bdq(&qt->sub0, &qt->sub1);
+			fbnic_config_drop_mode_rcq(nv, &qt->cmpl);
+			fbnic_enable_rcq(nv, &qt->cmpl);
+		}
 	}
 
 	wrfl();
@@ -683,11 +1118,30 @@ static void fbnic_nv_irq_enable(struct fbnic_napi_vector *nv)
 
 void fbnic_napi_enable(struct fbnic_net *fbn)
 {
+	u32 irqs[FBNIC_MAX_MSIX_VECS / 32] = {};
+	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_napi_vector *nv;
+	int i;
 
 	list_for_each_entry(nv, &fbn->napis, napis) {
 		napi_enable(&nv->napi);
 
 		fbnic_nv_irq_enable(nv);
+
+		/* Record bit used for NAPI IRQs so we can
+		 * set the mask appropriately
+		 */
+		irqs[nv->v_idx / 32] |= BIT(nv->v_idx % 32);
 	}
+
+	/* Force the first interrupt on the device to guarantee
+	 * that any packets that may have been enqueued during the
+	 * bringup are processed.
+	 */
+	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
+		if (!irqs[i])
+			continue;
+		wr32(FBNIC_INTR_SET(i), irqs[i]);
+	}
+	wrfl();
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 2898e0dccf7a..200f3b893d02 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -6,6 +6,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/types.h>
+#include <net/xdp.h>
 
 struct fbnic_net;
 
@@ -13,16 +14,43 @@ struct fbnic_net;
 #define FBNIC_MAX_RXQS			128u
 
 #define FBNIC_TXQ_SIZE_DEFAULT		1024
+#define FBNIC_HPQ_SIZE_DEFAULT		256
+#define FBNIC_PPQ_SIZE_DEFAULT		256
+#define FBNIC_RCQ_SIZE_DEFAULT		1024
+
+#define FBNIC_RX_TROOM \
+	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+#define FBNIC_RX_HROOM \
+	(ALIGN(FBNIC_RX_TROOM + NET_SKB_PAD, 128) - FBNIC_RX_TROOM)
+#define FBNIC_RX_PAD			0
+#define FBNIC_RX_MAX_HDR		(1536 - FBNIC_RX_PAD)
+#define FBNIC_RX_PAYLD_OFFSET		0
+#define FBNIC_RX_PAYLD_PG_CL		0
 
 #define FBNIC_RING_F_DISABLED		BIT(0)
 #define FBNIC_RING_F_CTX		BIT(1)
 #define FBNIC_RING_F_STATS		BIT(2)	/* ring's stats may be used */
 
+struct fbnic_pkt_buff {
+	struct xdp_buff buff;
+	u32 data_truesize;
+	u16 data_len;
+	u16 nr_frags;
+};
+
+#define PAGECNT_BIAS_MAX	USHRT_MAX
+struct fbnic_rx_buf {
+	struct page *page;
+	unsigned int pagecnt_bias;
+};
+
 struct fbnic_ring {
 	/* Pointer to buffer specific info */
 	union {
 		void *buffer;			/* Generic pointer */
 		void **tx_buf;			/* TWQ */
+		struct fbnic_pkt_buff *pkt;	/* RCQ */
+		struct fbnic_rx_buf *rx_buf;	/* BDQ */
 	};
 
 	u32 __iomem *doorbell;		/* pointer to CSR space for ring */
@@ -45,6 +73,7 @@ struct fbnic_q_triad {
 struct fbnic_napi_vector {
 	struct napi_struct napi;
 	struct device *dev;		/* Device for DMA unmapping */
+	struct page_pool *page_pool;
 	struct fbnic_dev *fbd;
 	char name[IFNAMSIZ + 9];
 
@@ -71,6 +100,7 @@ void fbnic_napi_disable(struct fbnic_net *fbn);
 void fbnic_enable(struct fbnic_net *fbn);
 void fbnic_disable(struct fbnic_net *fbn);
 void fbnic_flush(struct fbnic_net *fbn);
+void fbnic_fill(struct fbnic_net *fbn);
 
 int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail);
 



