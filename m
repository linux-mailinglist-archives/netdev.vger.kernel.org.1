Return-Path: <netdev+bounces-159100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABDA1466F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D76E3A48B9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75122442DE;
	Thu, 16 Jan 2025 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H7YoDbru"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66A24386A
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070207; cv=none; b=oqZBZoLSdlUGqz7rOlTCQskHNKGqpOdCAPEkdXZktFnEs4mzCBvtRXz8EyMeawe1zHOCYb0gSngy2tBPFANRv1bo/VQySHHVZFQdiK9uoqklle5AVan6W5lhWyyLpfP9vXryr0RzXEpfDu7cRXQcvQ7ciJjJpLGivI3o7G0BrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070207; c=relaxed/simple;
	bh=0ovZud7HtG3Tj2gpzpN2GUrZgs+D7dNcA2ORWtWOiEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxhHy1/HgB/5283WjlR7vnupTock1KD9MZCYOmP2xYYjwMLEUBupDQDTNs59bWqXSv1Oa0sR8sOZ8o7tgljIXswH+MH9e0wRpyiHmP9/Ra23FPzEzWRURTzLJ5pOBGYkGVG8WMwfFLMA3uYEKFVxM28e+Za/k7DWzWai1CWpzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H7YoDbru; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737070202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stXRbr6NMAFCNaNplm0LLeRfGGK/AKy1U5jOfxsu6KA=;
	b=H7YoDbruHBzE9kO2GwMtyuP73nJ2aJ30OIgU3CIz2ARf5x3Mrcxl4H3JsC7KEHV4E3BmR8
	JSjVKzVp+z9eEWPbTVE089Cis5GQgoixsY6ryTyLbYpH6RQd8FdOZtEjeHYUXNr1DU/q41
	FWHkDaq14EzAtbUxLwK7LFn4VdaiD40=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 1/6] net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
Date: Thu, 16 Jan 2025 18:29:49 -0500
Message-Id: <20250116232954.2696930-2-sean.anderson@linux.dev>
In-Reply-To: <20250116232954.2696930-1-sean.anderson@linux.dev>
References: <20250116232954.2696930-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Instead of using literals, add some symbolic constants for the IRQ delay
timer calculation.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed by: Shannon Nelson <shannon.nelson@amd.com>
---

(no changes since v2)

Changes in v2:
- New

 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 3 +++
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 ++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index d64b8abcf018..a3f4f3e42587 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -120,6 +120,9 @@
 #define XAXIDMA_IRQ_ERROR_MASK		0x00004000 /* Error interrupt */
 #define XAXIDMA_IRQ_ALL_MASK		0x00007000 /* All interrupts */
 
+/* Constant to convert delay counts to microseconds */
+#define XAXIDMA_DELAY_SCALE		(125ULL * USEC_PER_SEC)
+
 /* Default TX/RX Threshold and delay timer values for SGDMA mode */
 #define XAXIDMA_DFT_TX_THRESHOLD	24
 #define XAXIDMA_DFT_TX_USEC		50
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 07850ad331dd..0532dc94ee93 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -238,11 +238,8 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
 
 	/* 1 Timeout Interval = 125 * (clock period of SG clock) */
 	result = DIV64_U64_ROUND_CLOSEST((u64)coalesce_usec * clk_rate,
-					 (u64)125000000);
-	if (result > 255)
-		result = 255;
-
-	return result;
+					 XAXIDMA_DELAY_SCALE);
+	return min(result, FIELD_MAX(XAXIDMA_DELAY_MASK));
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


