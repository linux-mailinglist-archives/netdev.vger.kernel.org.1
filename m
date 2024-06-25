Return-Path: <netdev+bounces-106530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B95916A9B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7271F280B5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D99216D4FB;
	Tue, 25 Jun 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLr8sZSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9816EBF3
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326175; cv=none; b=WrHS66cl46KBn9V1t9Ki2C27XsNH69TSlVEmWrMseQOyS5FJyMIP3pjS55skopNnXGrQOv7S/NotsYy6XyhD04xnlOIOn6BWcc+6OMbfx/6MI4uRsRXk+MSE81VcQq2t7vETtUXZeCiAeENODVNdGsRhLz0v1W+JBkoCBnaM5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326175; c=relaxed/simple;
	bh=nA4kZG4E9X1UlldY7Wfg5JNCxUNnPAS99Ic3IgBvXf8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hatehsD7XCNBrUcet3PQWYSKJjzwGyLvu+TQn2AG1r/sN3d9EuPmJYr2cx39y5AXhA5LqA0Dx3aSZMk0b+0lSPdVOf3hqIZv6eUkwvl3S1nJ9xmismmqNxihJh8QyrNBI9HMTY0xzTXS+X3uKZ3GYC7YEm3w+sbwPDcmGPfodmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLr8sZSP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-70df213542bso3985233a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326173; x=1719930973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g1XAnUOhNWzhCKNBU+i5we5bgoLZdtKG1aISxD/DWUE=;
        b=mLr8sZSPjXov8K7XcTlyArI5OAZNGhSJL2XAvFwpEjdVEUY7+8eZK4JI/j0rolM8Au
         DhVrGXrHvdWM+N9+C3d1nDg8ohPm9dcD5Gkrc+rBrB/dYax0fgHyvIGNlwyIs+MM5hp4
         lfdltuQRSEYl1HOxZkDm60RP44bVR6i27ubiDCMskW7eodmTvXMDWD2dd3odxRfIo/3O
         qYZCXn9kbobuOhgAp/OgloP7FP9ou+lW3cIlAxAUwRlUlaSBx/nTTUSom4D7dEeTlgJX
         1Y3USFbzplxi8vzS9HnekGvaF//UcjMNadyd3yHmNwidnC8fQW+PxY/03TEwgZ/UU3Bn
         RnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326173; x=1719930973;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1XAnUOhNWzhCKNBU+i5we5bgoLZdtKG1aISxD/DWUE=;
        b=UgkZyyJMG815fAnP5Y6ZDU40v3uvVkkvjBAM1eCSAPVKDt4c1VQP2Q2SBXEzWl9O1P
         yJc1ZAvGmp6177oN4NjQmizCAUMsHK5+zDuVnWlvmTeu5GWuTst2YMVWF4n/2OIe7krf
         M1LaZh4Qdkflq50YYVbEW8xQEgNKmuUY4LO0/ugUuAzaZvgLXw8IPA0fLjIx44EDUzgk
         +4MIbyfgVi6zo2n6ZFJ8747PxHnbM25SqBerw7Pnl0FXZcRuoMG1zsiB/bB8qVTaE7Nw
         qS28w6MNFgnaWvt2CsPgGSB3UbqaGZTm5HGZtdjMxaYqlezasdElWajD4EIyLi+owbXJ
         S29w==
X-Gm-Message-State: AOJu0Yzw3Bes/lkDetpBl564V/21JEvuP1UH+duXzzmraR92PU3u5Awk
	XOaz68doMi3IQ8bamkZWF/Ew/G842CJy2pISU+1l+GcyZy3EtAlp
X-Google-Smtp-Source: AGHT+IEKur3aRb46EfHoBFTEwYWtL+KjyXmmgRxcRnVbXNMlzQSVJi0uA8ws6gTgSeSvY3hOqB6bZQ==
X-Received: by 2002:a17:90b:124b:b0:2c8:c191:27e6 with SMTP id 98e67ed59e1d1-2c8c19128b9mr1088824a91.16.1719326172368;
        Tue, 25 Jun 2024 07:36:12 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55dccbfsm10783589a91.32.2024.06.25.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:36:11 -0700 (PDT)
Subject: [net-next PATCH v2 09/15] eth: fbnic: Implement Rx queue
 alloc/start/stop/free
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:36:10 -0700
Message-ID: 
 <171932617073.3072535.8918778399126638637.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |  103 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |  480 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |   33 ++
 6 files changed, 615 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index db423b3424ab..853fb01f8f70 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -16,6 +16,37 @@
 
 #define FBNIC_CLOCK_FREQ	(600 * (1000 * 1000))
 
+/* Rx Buffer Descriptor Format
+ *
+ * The layout of this can vary depending on the page size of the system.
+ *
+ * If the page size is 4K then the layout will simply consist of ID for
+ * the 16 most signficant bits, and the lower 46 are essentially the page
+ * address with the lowest 12 bits being reserved 0 due to the fact that
+ * a page will be aligned.
+ *
+ * If the page size is larger than 4K then the lower n bits of the ID and
+ * page address will be reserved for the fragment ID. This fragment will
+ * be 4K in size and will be used to index both the DMA address and the ID
+ * by the same amount.
+ */
+#define FBNIC_BD_DESC_ADDR_MASK			DESC_GENMASK(45, 12)
+#define FBNIC_BD_DESC_ID_MASK			DESC_GENMASK(63, 48)
+#define FBNIC_BD_FRAG_SIZE \
+	(FBNIC_BD_DESC_ADDR_MASK & ~(FBNIC_BD_DESC_ADDR_MASK - 1))
+#define FBNIC_BD_FRAG_COUNT \
+	(PAGE_SIZE / FBNIC_BD_FRAG_SIZE)
+#define FBNIC_BD_FRAG_ADDR_MASK \
+	(FBNIC_BD_DESC_ADDR_MASK & \
+	 ~(FBNIC_BD_DESC_ADDR_MASK * FBNIC_BD_FRAG_COUNT))
+#define FBNIC_BD_FRAG_ID_MASK \
+	(FBNIC_BD_DESC_ID_MASK & \
+	 ~(FBNIC_BD_DESC_ID_MASK * FBNIC_BD_FRAG_COUNT))
+#define FBNIC_BD_PAGE_ADDR_MASK \
+	(FBNIC_BD_DESC_ADDR_MASK & ~FBNIC_BD_FRAG_ADDR_MASK)
+#define FBNIC_BD_PAGE_ID_MASK \
+	(FBNIC_BD_DESC_ID_MASK & ~FBNIC_BD_FRAG_ID_MASK)
+
 /* Register Definitions
  *
  * The registers are laid as indexes into an le32 array. As such the actual
@@ -124,14 +155,14 @@ enum {
 
 /* Global QM Rx registers */
 #define FBNIC_CSR_START_QM_RX		0x00c00	/* CSR section delimiter */
-#define FBNIC_QM_RCQ_IDLE(n)		(0x00c00 + (n)) /* 0x03000 + 0x4*n */
+#define FBNIC_QM_RCQ_IDLE(n)		(0x00c00 + (n)) /* 0x03000 + 4*n */
 #define FBNIC_QM_RCQ_IDLE_CNT			4
 #define FBNIC_QM_RCQ_CTL0		0x00c0c		/* 0x03030 */
 #define FBNIC_QM_RCQ_CTL0_COAL_WAIT		CSR_GENMASK(15, 0)
 #define FBNIC_QM_RCQ_CTL0_TICK_CYCLES		CSR_GENMASK(26, 16)
-#define FBNIC_QM_HPQ_IDLE(n)		(0x00c0f + (n)) /* 0x0303c + 0x4*n */
+#define FBNIC_QM_HPQ_IDLE(n)		(0x00c0f + (n)) /* 0x0303c + 4*n */
 #define FBNIC_QM_HPQ_IDLE_CNT			4
-#define FBNIC_QM_PPQ_IDLE(n)		(0x00c13 + (n)) /* 0x0304c + 0x4*n */
+#define FBNIC_QM_PPQ_IDLE(n)		(0x00c13 + (n)) /* 0x0304c + 4*n */
 #define FBNIC_QM_PPQ_IDLE_CNT			4
 #define FBNIC_QM_RNI_RBP_CTL		0x00c2d		/* 0x030b4 */
 #define FBNIC_QM_RNI_RBP_CTL_MRRS		CSR_GENMASK(1, 0)
@@ -451,12 +482,78 @@ enum {
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
index 95ab8ac1cae7..987c5a88e674 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -129,6 +129,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
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
index 73c96fe2a746..db83ad38d2ee 100644
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
index 52314aac29b9..fa5bf331c005 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -3,6 +3,8 @@
 
 #include <linux/iopoll.h>
 #include <linux/pci.h>
+#include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 
 #include "fbnic.h"
 #include "fbnic_netdev.h"
@@ -31,12 +33,134 @@ static void fbnic_ring_wr32(struct fbnic_ring *ring, unsigned int csr, u32 val)
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
+static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, struct page *page)
+{
+	__le64 *bdq_desc = &bdq->desc[id * FBNIC_BD_FRAG_COUNT];
+	dma_addr_t dma = page_pool_get_dma_addr(page);
+	u64 bd, i = FBNIC_BD_FRAG_COUNT;
+
+	bd = (FBNIC_BD_PAGE_ADDR_MASK & dma) |
+	     FIELD_PREP(FBNIC_BD_PAGE_ID_MASK, id);
+
+	/* In the case that a page size is larger than 4K we will map a
+	 * single page to multiple fragments. The fragments will be
+	 * FBNIC_BD_FRAG_COUNT in size and the lower n bits will be use
+	 * to indicate the individual fragment IDs.
+	 */
+	do {
+		*bdq_desc = cpu_to_le64(bd);
+		bd += FIELD_PREP(FBNIC_BD_DESC_ADDR_MASK, 1) |
+		      FIELD_PREP(FBNIC_BD_DESC_ID_MASK, 1);
+	} while (--i);
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
+
+		page = page_pool_dev_alloc_pages(nv->page_pool);
+		if (!page)
+			break;
+
+		fbnic_page_pool_init(bdq, i, page);
+		fbnic_bd_prep(bdq, i, page);
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
+}
+
 static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
 {
 	struct fbnic_dev *fbd = nv->fbd;
@@ -100,6 +224,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 	}
 
 	fbnic_free_irq(fbd, v_idx, nv);
+	page_pool_destroy(nv->page_pool);
 	netif_napi_del(&nv->napi);
 	list_del(&nv->napis);
 	kfree(nv);
@@ -125,6 +250,45 @@ static void fbnic_name_napi_vector(struct fbnic_napi_vector *nv)
 			 nv->v_idx - FBNIC_NON_NAPI_VECTORS);
 }
 
+#define FBNIC_PAGE_POOL_FLAGS \
+	(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
+
+static int fbnic_alloc_nv_page_pool(struct fbnic_net *fbn,
+				    struct fbnic_napi_vector *nv)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = FBNIC_PAGE_POOL_FLAGS,
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
@@ -173,6 +337,13 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	/* Tie nv back to PCIe dev */
 	nv->dev = fbd->dev;
 
+	/* Allocate page pool */
+	if (rxq_count) {
+		err = fbnic_alloc_nv_page_pool(fbn, nv);
+		if (err)
+			goto napi_del;
+	}
+
 	/* Initialize vector name */
 	fbnic_name_napi_vector(nv);
 
@@ -180,7 +351,7 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	err = fbnic_request_irq(fbd, v_idx, &fbnic_msix_clean_rings,
 				IRQF_SHARED, nv->name, nv);
 	if (err)
-		goto napi_del;
+		goto pp_destroy;
 
 	/* Initialize queue triads */
 	qt = nv->qt;
@@ -237,6 +408,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 
 	return 0;
 
+pp_destroy:
+	page_pool_destroy(nv->page_pool);
 napi_del:
 	netif_napi_del(&nv->napi);
 	list_del(&nv->napis);
@@ -370,6 +543,80 @@ static int fbnic_alloc_tx_ring_resources(struct fbnic_net *fbn,
 	return err;
 }
 
+static int fbnic_alloc_rx_ring_desc(struct fbnic_net *fbn,
+				    struct fbnic_ring *rxr)
+{
+	struct device *dev = fbn->netdev->dev.parent;
+	size_t desc_size = sizeof(*rxr->desc);
+	u32 rxq_size;
+	size_t size;
+
+	switch (rxr->doorbell - fbnic_ring_csr_base(rxr)) {
+	case FBNIC_QUEUE_BDQ_HPQ_TAIL:
+		rxq_size = fbn->hpq_size / FBNIC_BD_FRAG_COUNT;
+		desc_size *= FBNIC_BD_FRAG_COUNT;
+		break;
+	case FBNIC_QUEUE_BDQ_PPQ_TAIL:
+		rxq_size = fbn->ppq_size / FBNIC_BD_FRAG_COUNT;
+		desc_size *= FBNIC_BD_FRAG_COUNT;
+		break;
+	case FBNIC_QUEUE_RCQ_HEAD:
+		rxq_size = fbn->rcq_size;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Round size up to nearest 4K */
+	size = ALIGN(array_size(desc_size, rxq_size), 4096);
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
@@ -391,11 +638,38 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 		return err;
 
 	err = fbnic_alloc_tx_ring_resources(fbn, &qt->cmpl);
+	if (err)
+		goto free_sub1;
+
+	return 0;
+
+free_sub1:
+	fbnic_free_ring_resources(dev, &qt->sub0);
+	return err;
+}
+
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
 	if (err)
 		goto free_sub0;
 
+	err = fbnic_alloc_rx_ring_resources(fbn, &qt->cmpl);
+	if (err)
+		goto free_sub1;
+
 	return 0;
 
+free_sub1:
+	fbnic_free_ring_resources(dev, &qt->sub1);
 free_sub0:
 	fbnic_free_ring_resources(dev, &qt->sub0);
 	return err;
@@ -404,17 +678,20 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
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
@@ -423,6 +700,13 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
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
@@ -474,6 +758,21 @@ static void fbnic_disable_tcq(struct fbnic_ring *txr)
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
@@ -489,7 +788,7 @@ void fbnic_disable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_napi_vector *nv;
-	int i;
+	int i, j;
 
 	list_for_each_entry(nv, &fbn->napis, napis) {
 		/* Disable Tx queue triads */
@@ -499,6 +798,14 @@ void fbnic_disable(struct fbnic_net *fbn)
 			fbnic_disable_twq0(&qt->sub0);
 			fbnic_disable_tcq(&qt->cmpl);
 		}
+
+		/* Disable Rx queue triads */
+		for (j = 0; j < nv->rxt_count; j++, i++) {
+			struct fbnic_q_triad *qt = &nv->qt[i];
+
+			fbnic_disable_bdq(&qt->sub0, &qt->sub1);
+			fbnic_disable_rcq(&qt->cmpl);
+		}
 	}
 
 	fbnic_wrfl(fbd);
@@ -558,6 +865,10 @@ int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
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
@@ -577,6 +888,10 @@ int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
 			return err;
 	}
 
+	err = read_poll_timeout_atomic(fbnic_all_idle, idle, idle, 2, 500000,
+				       false, fbd, rx, ARRAY_SIZE(rx));
+	if (err)
+		fbnic_idle_dump(fbd, rx, ARRAY_SIZE(rx), "Rx", err);
 	return err;
 }
 
@@ -585,7 +900,7 @@ void fbnic_flush(struct fbnic_net *fbn)
 	struct fbnic_napi_vector *nv;
 
 	list_for_each_entry(nv, &fbn->napis, napis) {
-		int i;
+		int i, j;
 
 		/* Flush any processed Tx Queue Triads and drop the rest */
 		for (i = 0; i < nv->txt_count; i++) {
@@ -600,6 +915,39 @@ void fbnic_flush(struct fbnic_net *fbn)
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
+			qt->cmpl.pkt->buff.data_hard_start = NULL;
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
+			/* Populate the header and payload BDQs */
+			fbnic_fill_bdq(nv, &qt->sub0);
+			fbnic_fill_bdq(nv, &qt->sub1);
+		}
 	}
 }
 
@@ -654,11 +1002,102 @@ static void fbnic_enable_tcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TCQ_CTL, FBNIC_QUEUE_TCQ_CTL_ENABLE);
 }
 
+static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
+{
+	u32 bdq_ctl = FBNIC_QUEUE_BDQ_CTL_ENABLE;
+	u32 log_size;
+
+	/* Reset head/tail */
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
+	/* Write lower 4 bits of log size as 64K ring size is 0 */
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
+	/* Reset head/tail */
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_CTL, FBNIC_QUEUE_RCQ_CTL_RESET);
+	rcq->head = 0;
+	rcq->tail = 0;
+
+	/* Store descriptor ring address and size */
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_BAL, lower_32_bits(rcq->dma));
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_BAH, upper_32_bits(rcq->dma));
+
+	/* Write lower 4 bits of log size as 64K ring size is 0 */
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
@@ -668,6 +1107,15 @@ void fbnic_enable(struct fbnic_net *fbn)
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
 
 	fbnic_wrfl(fbd);
@@ -685,11 +1133,31 @@ static void fbnic_nv_irq_enable(struct fbnic_napi_vector *nv)
 
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
+	}
+
+	/* Force the first interrupt on the device to guarantee
+	 * that any packets that may have been enqueued during the
+	 * bringup are processed.
+	 */
+	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
+		if (!irqs[i])
+			continue;
+		fbnic_wr32(fbd, FBNIC_INTR_SET(i), irqs[i]);
 	}
+
+	fbnic_wrfl(fbd);
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 77abc15bb0dc..0e681dcc85c1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -6,6 +6,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/types.h>
+#include <net/xdp.h>
 
 struct fbnic_net;
 
@@ -13,14 +14,44 @@ struct fbnic_net;
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
 #define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
 
+struct fbnic_pkt_buff {
+	struct xdp_buff buff;
+	u32 data_truesize;
+	u16 data_len;
+	u16 nr_frags;
+};
+
+/* Pagecnt bias is long max to reserve the last bit to catch overflow
+ * cases where if we overcharge the bias it will flip over to be negative.
+ */
+#define PAGECNT_BIAS_MAX	LONG_MAX
+struct fbnic_rx_buf {
+	struct page *page;
+	long pagecnt_bias;
+};
+
 struct fbnic_ring {
 	/* Pointer to buffer specific info */
 	union {
+		struct fbnic_pkt_buff *pkt;	/* RCQ */
+		struct fbnic_rx_buf *rx_buf;	/* BDQ */
 		void **tx_buf;			/* TWQ */
 		void *buffer;			/* Generic pointer */
 	};
@@ -45,6 +76,7 @@ struct fbnic_q_triad {
 struct fbnic_napi_vector {
 	struct napi_struct napi;
 	struct device *dev;		/* Device for DMA unmapping */
+	struct page_pool *page_pool;
 	struct fbnic_dev *fbd;
 	char name[IFNAMSIZ + 9];
 
@@ -71,6 +103,7 @@ void fbnic_napi_disable(struct fbnic_net *fbn);
 void fbnic_enable(struct fbnic_net *fbn);
 void fbnic_disable(struct fbnic_net *fbn);
 void fbnic_flush(struct fbnic_net *fbn);
+void fbnic_fill(struct fbnic_net *fbn);
 
 int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail);
 



