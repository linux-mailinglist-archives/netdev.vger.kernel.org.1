Return-Path: <netdev+bounces-216892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E09B35CA5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB698362E5F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E13431FE;
	Tue, 26 Aug 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrXCDwJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB7326D62;
	Tue, 26 Aug 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207697; cv=none; b=HoRsGEVHqmBgGFEY5A+Q7Z/Lbb77fhWUntT3ccH7VHfwm6LbWAw53LvMQH1291Ki6BFlp3Dc9FJ3ohKUaOnsgTvriXrJKWeNN6qHtC1O4wbGr42Fl7mApzK/Hl8PDg05lc02XUdEj6De6j2F3PmDmYgTZ9ryqW//noRpTsswAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207697; c=relaxed/simple;
	bh=vQJJHBnM+iEXU5V6yK0xFFHTCOFo+SL5ltPFgOxU6M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ce+qu5t1Tv2lrEY4pDMvUpc2KRlkNQrZ7cvsZI7au2m21N6vD1fI43H14d9R4DQuYnt211AfOxZQ1bF1XtzitEHRw14/cxL0b4sy3U8phr5UxYTJD2S6fCYe1prVrYbYmxG4BmOcU8Z6CPWuuWI9GVLcmXGw3y0ocrReIoA6VSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrXCDwJ0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756207696; x=1787743696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQJJHBnM+iEXU5V6yK0xFFHTCOFo+SL5ltPFgOxU6M8=;
  b=GrXCDwJ049Rxlsnhwz8+GqbRElXaP5asjgXEduQXnrfVClX3XN6zdIcv
   5ovddaYUd5wd2hZ7LGrnNG4x4VUUUEDU5Doy6ivOpqqQVYj0rqxY0C+fx
   lUdhKxnC51WykN1JXz4wK2o77WX8jOMC7N3mf4rRfIfoLjm9w19C9sCmi
   SWNtcZZIUS4sv8JZjABhsivDYXOMyGRaOv5fnioQoKbtYqh/lQXRcg10i
   fG5OMqfCJQA7qmFCk4cOHcAG/vJ2uYY5Ha3hzibmtis02jEag40B5dcTh
   RBBjIi4IsCS7sloUqjF4PrQidqF/eHxOrfUcNcQLuXe7Q8p5005eesZK5
   A==;
X-CSE-ConnectionGUID: I31oGmEtR4ypJC06jI0SZw==
X-CSE-MsgGUID: htKj/Jd7Sm6bHe3WkdJNTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62269268"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62269268"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:28:16 -0700
X-CSE-ConnectionGUID: m25XV0MxTFu/T2ff/fMB8g==
X-CSE-MsgGUID: sEdKLqKgSaiPwQzh1Fsgdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173725795"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 04:28:13 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Piotr Warpechowski <piotr.warpechowski@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next 2/7] net: stmmac: correct Tx descriptors debugfs prints
Date: Tue, 26 Aug 2025 13:32:42 +0200
Message-Id: <20250826113247.3481273-3-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Warpechowski <piotr.warpechowski@intel.com>

It was observed that extended descriptors are not printed out fully and
enhanced descriptors are completely omitted in stmmac_rings_status_show().

Correct printing according to documentation and other existing prints in
the driver.

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b948df1bff9a..bda1a83607c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6349,14 +6349,25 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 	desc_size = extend_desc ? sizeof(*ep) : sizeof(*p);
 	for (i = 0; i < size; i++) {
 		dma_addr = dma_phy_addr + i * desc_size;
-		seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
-				i, &dma_addr,
-				le32_to_cpu(p->des0), le32_to_cpu(p->des1),
-				le32_to_cpu(p->des2), le32_to_cpu(p->des3));
-		if (extend_desc)
-			p = &(++ep)->basic;
-		else
+		if (extend_desc) {
+			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+				   i, &dma_addr,
+				   le32_to_cpu(ep->basic.des0),
+				   le32_to_cpu(ep->basic.des1),
+				   le32_to_cpu(ep->basic.des2),
+				   le32_to_cpu(ep->basic.des3),
+				   le32_to_cpu(ep->des4),
+				   le32_to_cpu(ep->des5),
+				   le32_to_cpu(ep->des6),
+				   le32_to_cpu(ep->des7));
+			ep++;
+		} else {
+			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
+				   i, &dma_addr,
+				   le32_to_cpu(p->des0), le32_to_cpu(p->des1),
+				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
 			p++;
+		}
 	}
 }
 
@@ -6396,7 +6407,11 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "Extended descriptor ring:\n");
 			sysfs_display_ring((void *)tx_q->dma_etx,
 					   priv->dma_conf.dma_tx_size, 1, seq, tx_q->dma_tx_phy);
-		} else if (!(tx_q->tbs & STMMAC_TBS_AVAIL)) {
+		} else if (tx_q->tbs & STMMAC_TBS_AVAIL) {
+			seq_printf(seq, "Enhanced descriptor ring:\n");
+			sysfs_display_ring((void *)tx_q->dma_entx,
+					   priv->dma_conf.dma_tx_size, 1, seq, tx_q->dma_tx_phy);
+		} else {
 			seq_printf(seq, "Descriptor ring:\n");
 			sysfs_display_ring((void *)tx_q->dma_tx,
 					   priv->dma_conf.dma_tx_size, 0, seq, tx_q->dma_tx_phy);
-- 
2.34.1


