Return-Path: <netdev+bounces-131690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C598F444
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A81E1C211AF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72081A706C;
	Thu,  3 Oct 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpXdsKwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E501A705F
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973068; cv=none; b=kyyQliwy40V2T1tCEqcFLCA43qSiu8cHNr7w0STwRO49KtpJxtAjUAKCRTqQwCgJ5x1d/wWzjha83RaVZgxAhd2hNap67/i4wFxCxptHeUJXbO7wlomcDsetsskaOJ3Ofkq3X8Nl+bkrOC2Dnb8HwM64hugy3gG1EeFCZ+zDBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973068; c=relaxed/simple;
	bh=xHeOp7bJ4gr60GQrPnI9UmAsXfM8KVUrzxiyqf+4rcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jpOjclCwalUh1HpZk21u5SVUiYxKuoSRgIwWakXuCmh20AcwiJ7AkrAjnsLkX8aAcrWodSKEREYPn2HUnHca06rmxLVCIVTMp5U+SWKoVhEiiUW8P5240hLPELaW07POig54hhZT/FtMNRFo8NJH7UKCuFiuCNTKduyv1WUIRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpXdsKwX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso1704880276.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727973066; x=1728577866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEQyf+jH8wm+48YdDb46WNYRYtTLvwiORYfoH+G8G58=;
        b=cpXdsKwXivYY+wwvihQ+Y5ap3FrvfjhAyX/GxTq4OpOFUeyVTGojHUqRY26EBqH60k
         nygVY4xRS3dBnoHiAJPcZKeyC6jnb1x5YVmoDmDe+28VH0ABP75YwEFjHQXv7lw4VNb8
         vBwu8Qd6aGYseJo4QqSB6qAYStLcAy6JGWioyoOjunTSx87xcauQafo8sn3TrR+b841j
         PZUBBYe7BfqebN7y+eUPoRkM3Skwy+iYmbWph/vx/UlYqvgpn7wCL6rmxY44V3hpCBXh
         EE3qXTwc7A3YkuUaM/hIbxU2d9hw8fjiMtCqfrquw7HmXVFw+3xC4gYF2YSjnJk5zTYX
         vxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973066; x=1728577866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEQyf+jH8wm+48YdDb46WNYRYtTLvwiORYfoH+G8G58=;
        b=RJsxJNV7WLe/qyUG05lRQamT4SLgC/A3E93ac+6/kM0qCOXvD65ovDOnUBOhdKVhpQ
         A8R51TD9v0IbWRI+Ds9D976KNL0rR4KHiQOnKHGHdeZw5MYtCDvS/b450xdqgYwpabha
         iaAo0oOXKuKqz9xC+dv1/cOKHf1YJ+jtjct+t2ypld7VEWngl4QAuGgF/Bkex9pTNra5
         qTQrYG7hGLJesAJW3P9uK2enEAuj4lK7Okx+QUOLdgy8iwHuevoCmDUcYnxorm4t4Xix
         aO8ouCwDXrBmYSqwbSyY0gyg1nDe5H1u6m5DMS4AerkMNDMnt/6XFIFRKy7M1v/guQch
         wTHg==
X-Gm-Message-State: AOJu0YzUVcj7faTfrflIAb7mnu5oLD0KjcpqyTZTKC8f+QbP/lQDjsOF
	uRAaXfQbFAoZdr0QCdUcC6bQ3l8im7m/Z5/rQT7cgIVJzY0bcGj4fDiGJUhz90/jhwHW5jTraep
	N3DRTo9Pqj/NjjrxKo32tCTb6gxK+os7qJJhXYbWdEiSLyG04o8SwNJBNoOYZyY6NSNxxARgSLq
	CvzmIEUu7ehNzGsgFekZkFxYEvvkZKLXuLae4Sbjzo4HaBuj7FVa1Mns39XhBkq0qG
X-Google-Smtp-Source: AGHT+IE4BgtaWX4/Sw/4ImaKki5C1WCPXdYKjxFIw4M2EbrfJ3UY31lXwAcbcoV3bRchhoAX68uxn4DhM7Z2pir9bZw=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:db19:ea7:7d31:e0ea])
 (user=pkaligineedi job=sendgmr) by 2002:a25:2d04:0:b0:e1a:6bf9:aa83 with SMTP
 id 3f1490d57ef6-e26383e33dbmr17986276.3.1727973065439; Thu, 03 Oct 2024
 09:31:05 -0700 (PDT)
Date: Thu,  3 Oct 2024 09:30:41 -0700
In-Reply-To: <20241003163042.194168-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003163042.194168-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241003163042.194168-2-pkaligineedi@google.com>
Subject: [PATCH net-next v2 1/2] gve: move DQO rx buffer management related
 code to a new file
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Harshitha Ramamurthy <hramamurthy@google.com>

In preparation for the upcoming page pool adoption for DQO
raw addressing mode, move RX buffer management code to a new
file. In the follow on patches, page pool code will be added
to this file.

No functional change, just movement of code.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v2:
-Don't exceed 80 char limit (Jakub Kicinski)

---
 drivers/net/ethernet/google/gve/Makefile      |   3 +-
 drivers/net/ethernet/google/gve/gve.h         |  18 ++
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 230 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 225 -----------------
 4 files changed, 250 insertions(+), 226 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c

diff --git a/drivers/net/ethernet/google/gve/Makefile b/drivers/net/ethernet/google/gve/Makefile
index 9ed07080b38a..4520f1c07a63 100644
--- a/drivers/net/ethernet/google/gve/Makefile
+++ b/drivers/net/ethernet/google/gve/Makefile
@@ -1,4 +1,5 @@
 # Makefile for the Google virtual Ethernet (gve) driver
 
 obj-$(CONFIG_GVE) += gve.o
-gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o
+gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o \
+	    gve_buffer_mgmt_dqo.o
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 301fa1ea4f51..bd684c7d996a 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1162,6 +1162,24 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
 u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hplit);
 bool gve_header_split_supported(const struct gve_priv *priv);
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split);
+/* rx buffer handling */
+int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs);
+void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
+		       bool free_page);
+struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx);
+bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
+				struct gve_rx_buf_state_dqo *buf_state);
+void gve_free_buf_state(struct gve_rx_ring *rx,
+			struct gve_rx_buf_state_dqo *buf_state);
+struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
+						   struct gve_index_list *list);
+void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
+			   struct gve_rx_buf_state_dqo *buf_state);
+struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx);
+int gve_alloc_page_dqo(struct gve_rx_ring *rx,
+		       struct gve_rx_buf_state_dqo *buf_state);
+void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
+			 struct gve_rx_buf_state_dqo *buf_state);
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
 int gve_reset(struct gve_priv *priv, bool attempt_teardown);
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
new file mode 100644
index 000000000000..8e50f0e4bb2e
--- /dev/null
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Google virtual Ethernet (gve) driver
+ *
+ * Copyright (C) 2015-2024 Google, Inc.
+ */
+
+#include "gve.h"
+#include "gve_utils.h"
+
+int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
+{
+	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
+}
+
+void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
+		       bool free_page)
+{
+	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
+	if (free_page)
+		gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
+			      DMA_FROM_DEVICE);
+	bs->page_info.page = NULL;
+}
+
+struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
+{
+	struct gve_rx_buf_state_dqo *buf_state;
+	s16 buffer_id;
+
+	buffer_id = rx->dqo.free_buf_states;
+	if (unlikely(buffer_id == -1))
+		return NULL;
+
+	buf_state = &rx->dqo.buf_states[buffer_id];
+
+	/* Remove buf_state from free list */
+	rx->dqo.free_buf_states = buf_state->next;
+
+	/* Point buf_state to itself to mark it as allocated */
+	buf_state->next = buffer_id;
+
+	return buf_state;
+}
+
+bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
+				struct gve_rx_buf_state_dqo *buf_state)
+{
+	s16 buffer_id = buf_state - rx->dqo.buf_states;
+
+	return buf_state->next == buffer_id;
+}
+
+void gve_free_buf_state(struct gve_rx_ring *rx,
+			struct gve_rx_buf_state_dqo *buf_state)
+{
+	s16 buffer_id = buf_state - rx->dqo.buf_states;
+
+	buf_state->next = rx->dqo.free_buf_states;
+	rx->dqo.free_buf_states = buffer_id;
+}
+
+struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
+						   struct gve_index_list *list)
+{
+	struct gve_rx_buf_state_dqo *buf_state;
+	s16 buffer_id;
+
+	buffer_id = list->head;
+	if (unlikely(buffer_id == -1))
+		return NULL;
+
+	buf_state = &rx->dqo.buf_states[buffer_id];
+
+	/* Remove buf_state from list */
+	list->head = buf_state->next;
+	if (buf_state->next == -1)
+		list->tail = -1;
+
+	/* Point buf_state to itself to mark it as allocated */
+	buf_state->next = buffer_id;
+
+	return buf_state;
+}
+
+void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
+			   struct gve_rx_buf_state_dqo *buf_state)
+{
+	s16 buffer_id = buf_state - rx->dqo.buf_states;
+
+	buf_state->next = -1;
+
+	if (list->head == -1) {
+		list->head = buffer_id;
+		list->tail = buffer_id;
+	} else {
+		int tail = list->tail;
+
+		rx->dqo.buf_states[tail].next = buffer_id;
+		list->tail = buffer_id;
+	}
+}
+
+struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx)
+{
+	struct gve_rx_buf_state_dqo *buf_state;
+	int i;
+
+	/* Recycled buf states are immediately usable. */
+	buf_state = gve_dequeue_buf_state(rx, &rx->dqo.recycled_buf_states);
+	if (likely(buf_state))
+		return buf_state;
+
+	if (unlikely(rx->dqo.used_buf_states.head == -1))
+		return NULL;
+
+	/* Used buf states are only usable when ref count reaches 0, which means
+	 * no SKBs refer to them.
+	 *
+	 * Search a limited number before giving up.
+	 */
+	for (i = 0; i < 5; i++) {
+		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
+		if (gve_buf_ref_cnt(buf_state) == 0) {
+			rx->dqo.used_buf_states_cnt--;
+			return buf_state;
+		}
+
+		gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
+	}
+
+	/* For QPL, we cannot allocate any new buffers and must
+	 * wait for the existing ones to be available.
+	 */
+	if (rx->dqo.qpl)
+		return NULL;
+
+	/* If there are no free buf states discard an entry from
+	 * `used_buf_states` so it can be used.
+	 */
+	if (unlikely(rx->dqo.free_buf_states == -1)) {
+		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
+		if (gve_buf_ref_cnt(buf_state) == 0)
+			return buf_state;
+
+		gve_free_page_dqo(rx->gve, buf_state, true);
+		gve_free_buf_state(rx, buf_state);
+	}
+
+	return NULL;
+}
+
+int gve_alloc_page_dqo(struct gve_rx_ring *rx,
+		       struct gve_rx_buf_state_dqo *buf_state)
+{
+	struct gve_priv *priv = rx->gve;
+	u32 idx;
+
+	if (!rx->dqo.qpl) {
+		int err;
+
+		err = gve_alloc_page(priv, &priv->pdev->dev,
+				     &buf_state->page_info.page,
+				     &buf_state->addr,
+				     DMA_FROM_DEVICE, GFP_ATOMIC);
+		if (err)
+			return err;
+	} else {
+		idx = rx->dqo.next_qpl_page_idx;
+		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
+			net_err_ratelimited("%s: Out of QPL pages\n",
+					    priv->dev->name);
+			return -ENOMEM;
+		}
+		buf_state->page_info.page = rx->dqo.qpl->pages[idx];
+		buf_state->addr = rx->dqo.qpl->page_buses[idx];
+		rx->dqo.next_qpl_page_idx++;
+	}
+	buf_state->page_info.page_offset = 0;
+	buf_state->page_info.page_address =
+		page_address(buf_state->page_info.page);
+	buf_state->last_single_ref_offset = 0;
+
+	/* The page already has 1 ref. */
+	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
+	buf_state->page_info.pagecnt_bias = INT_MAX;
+
+	return 0;
+}
+
+void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
+			 struct gve_rx_buf_state_dqo *buf_state)
+{
+	const u16 data_buffer_size = priv->data_buffer_size_dqo;
+	int pagecount;
+
+	/* Can't reuse if we only fit one buffer per page */
+	if (data_buffer_size * 2 > PAGE_SIZE)
+		goto mark_used;
+
+	pagecount = gve_buf_ref_cnt(buf_state);
+
+	/* Record the offset when we have a single remaining reference.
+	 *
+	 * When this happens, we know all of the other offsets of the page are
+	 * usable.
+	 */
+	if (pagecount == 1) {
+		buf_state->last_single_ref_offset =
+			buf_state->page_info.page_offset;
+	}
+
+	/* Use the next buffer sized chunk in the page. */
+	buf_state->page_info.page_offset += data_buffer_size;
+	buf_state->page_info.page_offset &= (PAGE_SIZE - 1);
+
+	/* If we wrap around to the same offset without ever dropping to 1
+	 * reference, then we don't know if this offset was ever freed.
+	 */
+	if (buf_state->page_info.page_offset ==
+	    buf_state->last_single_ref_offset) {
+		goto mark_used;
+	}
+
+	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+	return;
+
+mark_used:
+	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
+	rx->dqo.used_buf_states_cnt++;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 1154c1d8f66f..b343be2fb118 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -16,189 +16,6 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 
-static int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
-{
-	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
-}
-
-static void gve_free_page_dqo(struct gve_priv *priv,
-			      struct gve_rx_buf_state_dqo *bs,
-			      bool free_page)
-{
-	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
-	if (free_page)
-		gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
-			      DMA_FROM_DEVICE);
-	bs->page_info.page = NULL;
-}
-
-static struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
-{
-	struct gve_rx_buf_state_dqo *buf_state;
-	s16 buffer_id;
-
-	buffer_id = rx->dqo.free_buf_states;
-	if (unlikely(buffer_id == -1))
-		return NULL;
-
-	buf_state = &rx->dqo.buf_states[buffer_id];
-
-	/* Remove buf_state from free list */
-	rx->dqo.free_buf_states = buf_state->next;
-
-	/* Point buf_state to itself to mark it as allocated */
-	buf_state->next = buffer_id;
-
-	return buf_state;
-}
-
-static bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
-				       struct gve_rx_buf_state_dqo *buf_state)
-{
-	s16 buffer_id = buf_state - rx->dqo.buf_states;
-
-	return buf_state->next == buffer_id;
-}
-
-static void gve_free_buf_state(struct gve_rx_ring *rx,
-			       struct gve_rx_buf_state_dqo *buf_state)
-{
-	s16 buffer_id = buf_state - rx->dqo.buf_states;
-
-	buf_state->next = rx->dqo.free_buf_states;
-	rx->dqo.free_buf_states = buffer_id;
-}
-
-static struct gve_rx_buf_state_dqo *
-gve_dequeue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list)
-{
-	struct gve_rx_buf_state_dqo *buf_state;
-	s16 buffer_id;
-
-	buffer_id = list->head;
-	if (unlikely(buffer_id == -1))
-		return NULL;
-
-	buf_state = &rx->dqo.buf_states[buffer_id];
-
-	/* Remove buf_state from list */
-	list->head = buf_state->next;
-	if (buf_state->next == -1)
-		list->tail = -1;
-
-	/* Point buf_state to itself to mark it as allocated */
-	buf_state->next = buffer_id;
-
-	return buf_state;
-}
-
-static void gve_enqueue_buf_state(struct gve_rx_ring *rx,
-				  struct gve_index_list *list,
-				  struct gve_rx_buf_state_dqo *buf_state)
-{
-	s16 buffer_id = buf_state - rx->dqo.buf_states;
-
-	buf_state->next = -1;
-
-	if (list->head == -1) {
-		list->head = buffer_id;
-		list->tail = buffer_id;
-	} else {
-		int tail = list->tail;
-
-		rx->dqo.buf_states[tail].next = buffer_id;
-		list->tail = buffer_id;
-	}
-}
-
-static struct gve_rx_buf_state_dqo *
-gve_get_recycled_buf_state(struct gve_rx_ring *rx)
-{
-	struct gve_rx_buf_state_dqo *buf_state;
-	int i;
-
-	/* Recycled buf states are immediately usable. */
-	buf_state = gve_dequeue_buf_state(rx, &rx->dqo.recycled_buf_states);
-	if (likely(buf_state))
-		return buf_state;
-
-	if (unlikely(rx->dqo.used_buf_states.head == -1))
-		return NULL;
-
-	/* Used buf states are only usable when ref count reaches 0, which means
-	 * no SKBs refer to them.
-	 *
-	 * Search a limited number before giving up.
-	 */
-	for (i = 0; i < 5; i++) {
-		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
-		if (gve_buf_ref_cnt(buf_state) == 0) {
-			rx->dqo.used_buf_states_cnt--;
-			return buf_state;
-		}
-
-		gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
-	}
-
-	/* For QPL, we cannot allocate any new buffers and must
-	 * wait for the existing ones to be available.
-	 */
-	if (rx->dqo.qpl)
-		return NULL;
-
-	/* If there are no free buf states discard an entry from
-	 * `used_buf_states` so it can be used.
-	 */
-	if (unlikely(rx->dqo.free_buf_states == -1)) {
-		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
-		if (gve_buf_ref_cnt(buf_state) == 0)
-			return buf_state;
-
-		gve_free_page_dqo(rx->gve, buf_state, true);
-		gve_free_buf_state(rx, buf_state);
-	}
-
-	return NULL;
-}
-
-static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
-			      struct gve_rx_buf_state_dqo *buf_state)
-{
-	struct gve_priv *priv = rx->gve;
-	u32 idx;
-
-	if (!rx->dqo.qpl) {
-		int err;
-
-		err = gve_alloc_page(priv, &priv->pdev->dev,
-				     &buf_state->page_info.page,
-				     &buf_state->addr,
-				     DMA_FROM_DEVICE, GFP_ATOMIC);
-		if (err)
-			return err;
-	} else {
-		idx = rx->dqo.next_qpl_page_idx;
-		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
-			net_err_ratelimited("%s: Out of QPL pages\n",
-					    priv->dev->name);
-			return -ENOMEM;
-		}
-		buf_state->page_info.page = rx->dqo.qpl->pages[idx];
-		buf_state->addr = rx->dqo.qpl->page_buses[idx];
-		rx->dqo.next_qpl_page_idx++;
-	}
-	buf_state->page_info.page_offset = 0;
-	buf_state->page_info.page_address =
-		page_address(buf_state->page_info.page);
-	buf_state->last_single_ref_offset = 0;
-
-	/* The page already has 1 ref. */
-	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
-	buf_state->page_info.pagecnt_bias = INT_MAX;
-
-	return 0;
-}
-
 static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
 {
 	struct device *hdev = &priv->pdev->dev;
@@ -557,48 +374,6 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	rx->fill_cnt += num_posted;
 }
 
-static void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
-				struct gve_rx_buf_state_dqo *buf_state)
-{
-	const u16 data_buffer_size = priv->data_buffer_size_dqo;
-	int pagecount;
-
-	/* Can't reuse if we only fit one buffer per page */
-	if (data_buffer_size * 2 > PAGE_SIZE)
-		goto mark_used;
-
-	pagecount = gve_buf_ref_cnt(buf_state);
-
-	/* Record the offset when we have a single remaining reference.
-	 *
-	 * When this happens, we know all of the other offsets of the page are
-	 * usable.
-	 */
-	if (pagecount == 1) {
-		buf_state->last_single_ref_offset =
-			buf_state->page_info.page_offset;
-	}
-
-	/* Use the next buffer sized chunk in the page. */
-	buf_state->page_info.page_offset += data_buffer_size;
-	buf_state->page_info.page_offset &= (PAGE_SIZE - 1);
-
-	/* If we wrap around to the same offset without ever dropping to 1
-	 * reference, then we don't know if this offset was ever freed.
-	 */
-	if (buf_state->page_info.page_offset ==
-	    buf_state->last_single_ref_offset) {
-		goto mark_used;
-	}
-
-	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
-	return;
-
-mark_used:
-	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
-	rx->dqo.used_buf_states_cnt++;
-}
-
 static void gve_rx_skb_csum(struct sk_buff *skb,
 			    const struct gve_rx_compl_desc_dqo *desc,
 			    struct gve_ptype ptype)
-- 
2.46.1.824.gd892dcdcdd-goog


