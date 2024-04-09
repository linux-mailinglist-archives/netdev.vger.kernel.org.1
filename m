Return-Path: <netdev+bounces-86102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC789D8CC
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71412823C7
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1026D12DD8A;
	Tue,  9 Apr 2024 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DskDHacK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5EC12C81F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664218; cv=none; b=QKCmbU+9Hj8hiJegjzEIA5E5f/RAg+kngrxyxsQm8EkqTrSmEA9+PxmPZDLrXv6wq1poNv7WuL6MwA912pJk/V6upc20/7HDv7O/RqOW0EI8qlY2cB0Dz4s9SI4LxLneaQ3Aij950G3vw1LbMdmXbcOW5DAaBlVLK+8PyKhye8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664218; c=relaxed/simple;
	bh=mkU+i1vxhHLKvTuglCWvU5wQvNfwNj/HOa+1NF5gL+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sLEOV7dvujsJvTzyvAY1tdjm6gxYiNKFC5Y8N5xlsPAz5eLEh/FgYMtS5Szt67QK+Sdb0lKs7vBfuu7c/tyDZy6+MqiRh1pPO3bAjbHhZojWXOs8d1nnH3Eeq25IiHuyoQfJIN6hH4SJyzo9YBiUAeDssFvvNsRFUXNDqrQ/zN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DskDHacK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712664208; h=From:To:Subject:Date:Message-Id;
	bh=/kf47pqgvi9B6CHjDCr/aTvdkv5T1GGqbxOpd24KJ14=;
	b=DskDHacK3x/qPnTH8tCc/EYe49Ki2v938QWN5B0t4juBbkmPIGWL4k5R6FugijpKJ4gdMBSlfcUwqteG6VgMNy+4CAwpLMosPdu8qCDP6XL6Jf9YsTaGT4zLNI8xVUtVqqgkHZF4gpi0x9eQQTQZnkK0V+Y+VnAM4k5849bb/KE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4EReAF_1712664206;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4EReAF_1712664206)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 20:03:27 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v5 2/4] linux/dim: move profiles from .c to .h file
Date: Tue,  9 Apr 2024 20:03:22 +0800
Message-Id: <1712664204-83147-3-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
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


