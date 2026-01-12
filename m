Return-Path: <netdev+bounces-249202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF99D1568F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B8A430437BA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6232D7F9;
	Mon, 12 Jan 2026 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC/9MLA3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4732ABC2
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252786; cv=none; b=uJlyEg6FP8Y+gUE7ToLz07FdLhrQQlXuNehrwAtLNeGruqrs+gCHGGyCosWRkb8F+Q7Of33dWXxnFh/i3hXfazBj4ah9zY4haP81K9tYPVtDNR1UkQfNhM55JxzgmnpNRG+Y7ZgWLkzLmIjndkk+EgBX3HpbEt47Frw0YgaUzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252786; c=relaxed/simple;
	bh=UP8nm2xgv87yUAnntGij5Regpwz2bf2+nV5gHpwSA3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXvFAqZPoPTStl5RiQKZpA4mx2eXoo0yFgJFtZkJ5UymeMzfpI8nl0LpQ3UZV+uBSQBo87FXTFXrpjg049i+q/YgMgaC3rWcafghPK/DALidTHh0jeZcX/edrbL+l/9WZv7KXMkEKiidvvGxwAIMf0UK+zBzq6fp7sXZCLIHRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC/9MLA3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so47778895e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252782; x=1768857582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsN2b7gj8b48lxiHoLwTrmOsJk8s4kq5nfeUryJsvRE=;
        b=IC/9MLA3YKHm2YeR1s9aI8rjtZEP1tOIiXc+NZKnkXnP0vMSPx6iiQLT9DRH572NXa
         w2RD3lTcDcfwBTjotHBRm7LoO1joffaohq0W8mByLS+SUDgPx/JQLV2XTFF0fb3DjUDd
         RSihXcMnZkHQR2hLmdy9SQ+lhspAxacFMCgDGIBggkwlJdXB4nc7vrUh2r3gzx5jyH6o
         btDQN2uTERDNg1tSagrEKKoRAsh78iw0F8RJThJXDtWJfYc3o4LLx3fi1f8hoy176tla
         Ah5T1VGYAi9yOODBJEKCp1KTqKuvTRswSBWi79NRPdBroFwDks4MQGxjjAMuOAEaq3rT
         hPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252782; x=1768857582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VsN2b7gj8b48lxiHoLwTrmOsJk8s4kq5nfeUryJsvRE=;
        b=F+Od57EI64qGr/ky47rsArsV4IB7uxys9cNY8oZHGdgz7rlyMK9cc1vw/iT7PEL08m
         InWYnEV+FgrBkO8tw++qT7Nywxf1b7EhCg218zlkP7Acu07TDjwPueSpzIwuyvqnQ8lA
         0biU1/At17FBrk8QuZRPyghCLzc0OFGJTaeJrEixH75MLV1GTrKasZkNBLkQYMc+mOJj
         lj3w6U7mUiBtmpbvSui2r2ziYZo5YeEKYwOTFDU089pnjN+88cq9oB7P7KhJNu0ArBqX
         7+llEBHIfs6bOJDqNe2+B7hbJMizBPUFlFCivtd/DPOQSh2GALIpfExhzUmyzRkMoJPz
         VeGQ==
X-Gm-Message-State: AOJu0YyzLQXHQzLnb53+74S9pOl56rq4c3+7ltV94tCU4AbIL4SsYTsy
	vbKdsVGMh8ElYdqZZCbRu6N1kWWPqdeQZfLbKEDI4cY3vrJ7x5E9VM+lFOR5XLMd
X-Gm-Gg: AY/fxX4IXpNRjP5FwS/9J3XctnuVpqJ0g8C6pMpIdKb9Jctg2E0MrAR91i372uskENn
	y/cK8FKBHvusuceskhlhP/yW/B6wMkfRsY7mpC6HUg7hX7ASyBIVvbkfU3T0MLOlUhiryDpalNp
	qQFlrKkhiwrPeFfA5xFk7mADLo3znkHvgUcMyKo8YkXd84LpbVUKqt1dixGYHIR0ZR4m0QWZAtP
	l5j7oWWKLMMBxRLB89UKAwl99lUmHYE+RcX68uZQd9bW9ZFdiYsTZ31qQIdQszTsR4nX8Tatz3J
	WETIqK86qA6dCdt40Fs3FVVyhh/C7SGyfuSZ5hU3AuTo0I5JPghVzGadgaNcDFAQtOwUljs2ipw
	Spn6erEz0c0qztJVT3CiuKHfwPGKyIqXMnO5NsFWiolnf5XQcx50PTYdiZ4c9ivvukBEADEh49h
	VABHRvSukY
X-Google-Smtp-Source: AGHT+IE9q5lvBGYwPZExQJ0BFPzIaNnhFIVb+p2xOqukee4pDqibCQ+0tdq+Ztt+wPRbv5bw8cXNTQ==
X-Received: by 2002:a05:600c:a47:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-47d8e56624emr176397845e9.1.1768252782535;
        Mon, 12 Jan 2026 13:19:42 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:55::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f661a03sm387280315e9.13.2026.01.12.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:19:42 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next V0.5 3/5] eth: fbnic: Reuse RX mailbox pages
Date: Mon, 12 Jan 2026 13:19:23 -0800
Message-ID: <20260112211925.2551576-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
References: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the RX mailbox frees and reallocates a page for each received
message. Since FW Rx messages are processed synchronously, and nothing
hold these pages (unlike skbs which we hand over to the stack), reuse
the pages and put them back on the Rx ring. Now that we ensure the ring
is always fully populated we don't have to worry about filling it up
after partial population during init, either. Update
fbnic_mbx_process_rx_msgs() to recycle pages after message processing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 25 ++++++++++++++--------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 09252b3e03ca..66c9412f4057 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1592,7 +1592,7 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *rx_mbx = &fbd->mbx[FBNIC_IPC_MBX_RX_IDX];
-	u8 head = rx_mbx->head;
+	u8 head = rx_mbx->head, tail = rx_mbx->tail;
 	u64 desc, length;
 
 	while (head != rx_mbx->tail) {
@@ -1603,8 +1603,8 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
 			break;
 
-		dma_unmap_single(fbd->dev, rx_mbx->buf_info[head].addr,
-				 PAGE_SIZE, DMA_FROM_DEVICE);
+		dma_sync_single_for_cpu(fbd->dev, rx_mbx->buf_info[head].addr,
+					FBNIC_RX_PAGE_SIZE, DMA_FROM_DEVICE);
 
 		msg = rx_mbx->buf_info[head].msg;
 
@@ -1637,19 +1637,26 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 
 		dev_dbg(fbd->dev, "Parsed msg type %d\n", msg->hdr.type);
 next_page:
+		fw_wr32(fbd, FBNIC_IPC_MBX(FBNIC_IPC_MBX_RX_IDX, head), 0);
 
-		free_page((unsigned long)rx_mbx->buf_info[head].msg);
+		rx_mbx->buf_info[tail] = rx_mbx->buf_info[head];
 		rx_mbx->buf_info[head].msg = NULL;
+		rx_mbx->buf_info[head].addr = 0;
 
-		head++;
-		head %= FBNIC_IPC_MBX_DESC_LEN;
+		__fbnic_mbx_wr_desc(fbd, FBNIC_IPC_MBX_RX_IDX, tail,
+				    FIELD_PREP(FBNIC_IPC_MBX_DESC_LEN_MASK,
+					       FBNIC_RX_PAGE_SIZE) |
+				    (rx_mbx->buf_info[tail].addr &
+				     FBNIC_IPC_MBX_DESC_ADDR_MASK) |
+				    FBNIC_IPC_MBX_DESC_HOST_CMPL);
+
+		head = (head + 1) & (FBNIC_IPC_MBX_DESC_LEN - 1);
+		tail = (tail + 1) & (FBNIC_IPC_MBX_DESC_LEN - 1);
 	}
 
 	/* Record head for next interrupt */
 	rx_mbx->head = head;
-
-	/* Make sure we have at least one page for the FW to write to */
-	fbnic_mbx_alloc_rx_msgs(fbd);
+	rx_mbx->tail = tail;
 }
 
 void fbnic_mbx_poll(struct fbnic_dev *fbd)
-- 
2.47.3


