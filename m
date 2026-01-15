Return-Path: <netdev+bounces-249977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E26D21DCC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D1DD300B346
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A87E110;
	Thu, 15 Jan 2026 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVyaSZAY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95D14A4F0
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437249; cv=none; b=exNYt0bosUgc6z8lzHIEDiU4wuQPrRph5UubLyCCgFTn/lrmdq+dMWu/dyFoDXQ3RVrESpIx18l9++hhVK+OoN6UX5Fo4vTSjR86b4e8RBSqdIXFvHbZnW2aXFXPVbL328878sHBKtuotZT00iQvI/B+VXEmMaEI3NA+sTaBMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437249; c=relaxed/simple;
	bh=UP8nm2xgv87yUAnntGij5Regpwz2bf2+nV5gHpwSA3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsdWvFXPVnqUX0GEoNkJviRSttm3mEVQlEtjiXeXEwSk7B8IFjlGsi8X0atCYvekahlc1GBFWxm/T7GB6eRmESHjqdma2QgBrs2zGXKOdE1vKFy4fDXu+ZWd7cilAFfrCG4KCSgWauRNEwOU94GXKe5jvfEs3B/CxT6H0GkEzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVyaSZAY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so2144595e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768437245; x=1769042045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsN2b7gj8b48lxiHoLwTrmOsJk8s4kq5nfeUryJsvRE=;
        b=lVyaSZAY1pibiFF7SB/IXVjNjBp69V7L97jrmWk5qtgLDSv16ykJblO2bkIrk1MSfj
         OL3zBN2l/EjGJAmwRVeFWZYLpi06PphnXx9zDB0MhmhURIaaC1eModKXxM4GRtnj+MPl
         6nrKJyFWNCnel8TyX1hvlgYTYDX88EHw41EB5WjxBHwDWDDNUzNfHGGEVJrg4grF5sCS
         IZNG6UtDsA4aECc2mf0iwaXd61okdFdzFbbtAHML/RTXvKl4FviIgojhhuPtBkAjKMjJ
         z4+56Otbn1PDbLZEzLIRYt7X0TRh8jFlbKvO28WJi0jjEHQfHRSmy2tvQuGpN+IoWe/4
         8ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437245; x=1769042045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VsN2b7gj8b48lxiHoLwTrmOsJk8s4kq5nfeUryJsvRE=;
        b=pu8oftqDlIcI+slq4Jwfc3KRhhd7jPAO+FY1tyddLq7a7MXFLRzFiAY6uO1GVvGeGd
         PdkOG2DqLYd6sAMspCg/moqQUjaZ/HtxmyzELCE+EoDAkA7jjhNoFEkbSuhnjXoQf6V9
         z4+AJifLMyRB2yw7EVlGi7uexYwFgaYx31xky8bOzOVP4rOMJYURRHlPKJ3s1fg9HjYv
         w4WTbWNU5qWq+KVvhAxVihJr1FEtEE6F3kEGkmhROhh2kzJhHzP6Hr59aRdno7QEcJuL
         1FgayxGXH3LyT3QBBbLUgis1AeCvRyKJ3vxQJKvywUCjlQiXopPk6vafMw/raKozDSl0
         cPQA==
X-Gm-Message-State: AOJu0YwADqThM5ftQLL5A4X9f/YyXESWRrRTyTDLJn+4MFoaJfBBFYsM
	hIlSv7ys/LC6VPwWeEKyqXI8EA5dlf5QljAX1B6Bcdwr+4M0+O6aLX0bHRFfA6va
X-Gm-Gg: AY/fxX4Wweqfy/7UvqSkisozExcZt/OuhbsFZBr5bRcXy72DJkQKdsQJHS4c8V73HMl
	QB5ffLc66YG5JF+wwkHuO7rfM5ZP8Xc0JcFz+LNzXL2ooNEuzJxvhDC+l8gzd3B9A6XSX1TfNXp
	OjRduFub3d6pmtqKk4oX2x4YeP6t4sQ4YAIojOJJPqnsgnhy9gj8BA4rc1C+qnwl3mFt4G7MGhm
	wJ/9Ki1g2jFG7snZPlhED0TEaTnRC59KwCkSHeSQ2LVqxYVZZw9YO5KRaREGLTNe+yDOIgU0HCQ
	wwh3GLQphCGkgr/da9klehrEmcbBBUrfJ+OYmG7doHq4iUtzikAqMvnQzRtDO6ghSY5UWLETZ4K
	lW8kPhRJwcwzBNtnPlmlKGY2UfK9VIT5HXumgWAuOFKaz23K1g/PVEGg5tD8xSSS6FFit7MEBSC
	AW/B10K9Nl
X-Received: by 2002:a05:600c:3b9e:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-47ee32fcd4amr53901165e9.9.1768437245461;
        Wed, 14 Jan 2026 16:34:05 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee2725b54sm33925955e9.1.2026.01.14.16.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:34:05 -0800 (PST)
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
Subject: [PATCH net-next V2 3/5] eth: fbnic: Reuse RX mailbox pages
Date: Wed, 14 Jan 2026 16:33:51 -0800
Message-ID: <20260115003353.4150771-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
References: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
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


