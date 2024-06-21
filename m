Return-Path: <netdev+bounces-105647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD28912245
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDED288C48
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53945171E6A;
	Fri, 21 Jun 2024 10:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46F17109B;
	Fri, 21 Jun 2024 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965267; cv=none; b=vGgOSbD7Uo1ghNUfwiOCsIikNS7QptlguoopxCULHLdnWtQxsDH18LbhVQtVRnMJVCD6HCM/bvNehYQQ1mLoUNK+WI4cDUZDP86FD0nPLQ9TXMJi3/xmI1393vKez5TWtrhk8Mt90p9o1fnetk5Sy8x9juZaWU6mi+z9IkYdCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965267; c=relaxed/simple;
	bh=dPYZeWKKwd9/P7SeuLwt0oFxoyqbARsIw+dEdexsffk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7GMXNYH1GqFg+lJhAEGY+7bF4/z5kz4tPlRzTQ/n8k4sfZw81MEtR8aZOHNEBjAWlLTv6pxbmGO66JJokIg7nQUZc5B5GoVCUEY4nLsZOo+DSAlwE0/rOhb5KQD7iz+V2KZw1g99R03NSnejvUV0iPtc/ORfUmrHf9uRRnp//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz15t1718965135tf36p6
X-QQ-Originating-IP: P0/GW/bcSHhST6SeWoBh2w5Z3xI7MzBTCUiyhlDOLOk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Jun 2024 18:18:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13424936374893162487
From: WangYuli <wangyuli@uniontech.com>
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Li Wencheng <liwencheng@phytium.com.cn>,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>
Subject: [PATCH] net: stmmac: Add a barrier to make sure all access coherent
Date: Fri, 21 Jun 2024 18:18:36 +0800
Message-ID: <F19E93E071D95714+20240621101836.167600-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Add a memory barrier to sync TX descriptor to avoid data error.
Besides, increase the ring buffer size to avoid buffer overflow.

Signed-off-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
Signed-off-by: Li Wencheng <liwencheng@phytium.com.cn>
Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h    | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 9cd62b2110a1..7cc2fecbaf18 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -50,10 +50,10 @@
  */
 #define DMA_MIN_TX_SIZE		64
 #define DMA_MAX_TX_SIZE		1024
-#define DMA_DEFAULT_TX_SIZE	512
+#define DMA_DEFAULT_TX_SIZE	1024
 #define DMA_MIN_RX_SIZE		64
 #define DMA_MAX_RX_SIZE		1024
-#define DMA_DEFAULT_RX_SIZE	512
+#define DMA_DEFAULT_RX_SIZE	1024
 #define STMMAC_GET_ENTRY(x, size)	((x + 1) & (size - 1))
 
 #undef FRAME_FILTER_DEBUG
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index 68a7cfcb1d8f..40088a390f7b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -200,6 +200,10 @@ static void ndesc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 	else
 		norm_set_tx_desc_len_on_ring(p, len);
 
+	/* The own bit must be the latest setting done when prepare the
+	 * descriptor and then barrier is needed to make sure that all is coherent.
+	 */
+	wmb();
 	if (tx_own)
 		p->des0 |= cpu_to_le32(TDES0_OWN);
 }
-- 
2.43.4


