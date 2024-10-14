Return-Path: <netdev+bounces-135308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C74F99D818
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06B7282A07
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D11D0E11;
	Mon, 14 Oct 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCsiNnsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D41D0BA4
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937282; cv=none; b=HjrPHlG6mS4q4KjguP4AyYC42B15rT2yhfxEP1czwZ0Tm4EgZXAOr52+A3r5ed22gXO426vptT685jOTY7fo0Rqi3E3TAc5GtLf1IFc/TcTi/dbXySkGJr05/anw+B+Xlxce18KI1lj4uckC94+TkL82MrDL7YdSuPDxO9ejrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937282; c=relaxed/simple;
	bh=qwSoiVHiwKiVFYr4UbvRdD1g0sOuJOkns8N7cqLJ/VA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u9h7tYYYVp/KStFe4eHEFLlWf69gT+4Omj26/3WPSv0EBus3D6kjTQqtw0SguPtETdtDKvNwOa8IUxl8+qLd6EV7qjWTYL3eMMPPuoRDImymdSlB73QRJxW8ayfLQE0G16SJgVLpj7UpisyG1BcH0sLHtVFEntz53NPxHHt4Qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCsiNnsd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370139342so26572147b3.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728937279; x=1729542079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwvXWkdJH5WPr9qMuhG+EePGqzvI5IUkbLUjwgUy5Ig=;
        b=pCsiNnsdEbvFwTICIrmyvKHLUm/EXYL8onN5SItU//PmNJPCjyo+be6tVchxCpObC8
         /2iQTkHPmemCRmpwV8b4A87W93FTr+qLA8EhwljgfKxIVEm0e3JIwom/lVyCHIunZVKi
         NC+nyYIJDseF5PAO7BlhAejiCHY98fbhK9qHesQs+msJe5MF64AKQwXdYWD5KfBMpf3B
         DpvPqxCqaoXrmYilrXJuwbNhziY+xdaIw9gdaNibQHMP7a4KM/EkgWV+6ZB3gSJTB4ej
         Id1IaNOFcKhkjw441eH1BO5qsC6ngWu6kuK2Hym1Uf3+b+QFmoPy8uk4xeIWeIYcNrvF
         HFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937279; x=1729542079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwvXWkdJH5WPr9qMuhG+EePGqzvI5IUkbLUjwgUy5Ig=;
        b=ptKs1pRfd0xjuCl+5+lI3KNYq5TkjHM6I7bUWcQ1dbCfASNJ06pg2G2fhujiSv6Umh
         D/VwFH31jOAOSpyHBZNANvVfYNyAv7pXIx1iTWfBXrtuVGjRyKue6hYTHMQUz7+t8z1+
         1b63TEGu7NLBM4wxQuZv2B7mHrTy3U4AVsUT2IEQcCgUy29wm4wbX9tI/8np6vQmP3/V
         RR8Mzaw2b1J+RCf1GtWv6Pfp5XDgsBNu7QzMu9Yy3MReiY90vt4fAGPtMuQxwivh/X4s
         mGiq/PUtDMHj707kYYbT4sBm3/85r2PRpB694paMPJXrX72Wpm5hXOTqyfDgf/9cbFWU
         mBiA==
X-Gm-Message-State: AOJu0YwrwdM0AZboeL8q1EtdS9rxro2/vIt0IrYJFCs0RtSBAWTid/yk
	NOAUGn0j3wrSQXvrppK5TLp09yGPF/fN0fg5Aj2Wf//+BTSKWr0AivmWRgkMZO6WlkwcPN7mPTG
	3NOht+PEuvSBJIAeqWxGY0OtF6yIOtTI6YMbwTGiJ0j/HSdP0RsNbFXP63/yxoJsYtuB4VYu64o
	GTLP+CgNDwGbjjiF0w2OCaV6GcCFkuU9/exYO3e9W+O3fZrzkmBLcHmqb2y/GWfpQU
X-Google-Smtp-Source: AGHT+IEoSpC3R+zXe4nrYzKPADYWd2V+Fa4aHMwssciYaPiy4OCQYV/1vAm41fKIAhlWgf26QbjKtyamv2apuL7pzXo=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:1ab8:7f2d:7123:f4fc])
 (user=pkaligineedi job=sendgmr) by 2002:a25:74cb:0:b0:e11:5da7:337 with SMTP
 id 3f1490d57ef6-e2919d9e4e2mr47599276.3.1728937278640; Mon, 14 Oct 2024
 13:21:18 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:21:06 -0700
In-Reply-To: <20241014202108.1051963-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014202108.1051963-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014202108.1051963-2-pkaligineedi@google.com>
Subject: [PATCH net-next v3 1/3] gve: move DQO rx buffer management related
 code to a new file
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com, jacob.e.keller@intel.com, 
	Praveen Kaligineedi <pkaligineedi@google.com>
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
2.47.0.rc1.288.g06298d1525-goog


