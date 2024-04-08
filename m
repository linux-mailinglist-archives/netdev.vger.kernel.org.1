Return-Path: <netdev+bounces-85568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629689B684
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 05:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2466C1F2237A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1B9187F;
	Mon,  8 Apr 2024 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r15oIG9p"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFED63CB
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547883; cv=none; b=i5zPAUc6xNXZzPwEbpLoTH9eRcsGlXTioTad289Sh8qoQDiXMK2elAFDV26krugw7H/FjHcKBi5kTG0ut3UxLsoS36eS0ogCnWz/iT6iQ52Hj9xlW+UYZD3s4Pn49x+cDDpEvxKymSi7b3mCFp8y2ovoUHOjPafD9wK8NOlfC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547883; c=relaxed/simple;
	bh=mkU+i1vxhHLKvTuglCWvU5wQvNfwNj/HOa+1NF5gL+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r0i0jzYevHm2T7fGxNJerKez8EnELWi7P1ichV8rYSXavO4f9FGrBOpzX1owF/bopakRhJ+F8NYs45HuPVmoTYR5zcK2qdlR1Xy9/xKp/dics+xw3RLivTmIm11zWR13Z7X8+f8kVy+NG/HPjVsWc4QyNY+poRK5KYNJxn/YpnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r15oIG9p; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712547874; h=From:To:Subject:Date:Message-Id;
	bh=/kf47pqgvi9B6CHjDCr/aTvdkv5T1GGqbxOpd24KJ14=;
	b=r15oIG9pKy17M0tw+RqjCwnXrdpH7G8rHa2uLZIPhPMg8VDEtI9GwvIjopilgue6SPV7w/VEmVVqDUoKfWzbaVMH1qsg9DtkyfJHA/sPz5ZkQGi2DK5IA9GuOA6VdJUTNow8E9LJlGJQCLHl77qXE8H5uhUDPN87PsJYHHB8r3Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4249Yj_1712547872;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4249Yj_1712547872)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 11:44:33 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v4 2/4] linux/dim: move profiles from .c to .h file
Date: Mon,  8 Apr 2024 11:44:28 +0800
Message-Id: <1712547870-112976-3-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Place profiles into dim.h file so that the subsequent patch can use
it to initialize driver's custom profiles.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 include/linux/dim.h | 38 ++++++++++++++++++++++++++++++++++++++
 lib/dim/net_dim.c   | 38 --------------------------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index 43398f5..cf3a9d1 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -18,6 +18,44 @@
 #define NET_DIM_DEF_PROFILE_EQE 1
 
 /*
+ * Net DIM profiles:
+ *        There are different set of profiles for each CQ period mode.
+ *        There are different set of profiles for RX/TX CQs.
+ *        Each profile size must be of NET_DIM_PARAMS_NUM_PROFILES
+ */
+#define NET_DIM_RX_EQE_PROFILES { \
+	{.usec = 1,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
+	{.usec = 8,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
+	{.usec = 64,  .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
+	{.usec = 128, .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
+	{.usec = 256, .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}  \
+}
+
+#define NET_DIM_RX_CQE_PROFILES { \
+	{.usec = 2,  .pkts = 256,},             \
+	{.usec = 8,  .pkts = 128,},             \
+	{.usec = 16, .pkts = 64,},              \
+	{.usec = 32, .pkts = 64,},              \
+	{.usec = 64, .pkts = 64,}               \
+}
+
+#define NET_DIM_TX_EQE_PROFILES { \
+	{.usec = 1,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
+	{.usec = 8,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
+	{.usec = 32,  .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
+	{.usec = 64,  .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
+	{.usec = 128, .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}   \
+}
+
+#define NET_DIM_TX_CQE_PROFILES { \
+	{.usec = 5,  .pkts = 128,},  \
+	{.usec = 8,  .pkts = 64,},  \
+	{.usec = 16, .pkts = 32,},  \
+	{.usec = 32, .pkts = 32,},  \
+	{.usec = 64, .pkts = 32,}   \
+}
+
+/*
  * Number of events between DIM iterations.
  * Causes a moderation of the algorithm run.
  */
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 67d5beb..c7cf457 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -5,44 +5,6 @@
 
 #include <linux/dim.h>
 
-/*
- * Net DIM profiles:
- *        There are different set of profiles for each CQ period mode.
- *        There are different set of profiles for RX/TX CQs.
- *        Each profile size must be of NET_DIM_PARAMS_NUM_PROFILES
- */
-#define NET_DIM_RX_EQE_PROFILES { \
-	{.usec = 1,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
-	{.usec = 8,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
-	{.usec = 64,  .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
-	{.usec = 128, .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
-	{.usec = 256, .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}  \
-}
-
-#define NET_DIM_RX_CQE_PROFILES { \
-	{.usec = 2,  .pkts = 256,},             \
-	{.usec = 8,  .pkts = 128,},             \
-	{.usec = 16, .pkts = 64,},              \
-	{.usec = 32, .pkts = 64,},              \
-	{.usec = 64, .pkts = 64,}               \
-}
-
-#define NET_DIM_TX_EQE_PROFILES { \
-	{.usec = 1,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
-	{.usec = 8,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
-	{.usec = 32,  .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
-	{.usec = 64,  .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
-	{.usec = 128, .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}   \
-}
-
-#define NET_DIM_TX_CQE_PROFILES { \
-	{.usec = 5,  .pkts = 128,},  \
-	{.usec = 8,  .pkts = 64,},  \
-	{.usec = 16, .pkts = 32,},  \
-	{.usec = 32, .pkts = 32,},  \
-	{.usec = 64, .pkts = 32,}   \
-}
-
 static const struct dim_cq_moder
 rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_RX_EQE_PROFILES,
-- 
1.8.3.1


