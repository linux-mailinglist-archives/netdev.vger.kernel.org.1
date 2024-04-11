Return-Path: <netdev+bounces-87046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9240F8A16D3
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24181C22789
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2614E2D9;
	Thu, 11 Apr 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F4wa7cWf"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4114B09C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844760; cv=none; b=s+OGoQUFau+lZrQKbTQ51D/xLZZu5hlQspZkm21kPzKWsD2wFj7i+loxokFTXPIILvAfEJBFC9aROlwKLsI/iDaIdZkaWQcwIp7654CaF6ShqoHsfqWFv8ny8QizBpwFFRIulCeStG6uRX419VvopaIYVkHqePJNx3iqNtPaWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844760; c=relaxed/simple;
	bh=HOL51QMzqy4o0iVUvh//ODu00l3fy1oegkYo5pstIlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K2rTQz+gdw/Dy05JBexpBSP3kMlIGOQpNtur0r0UrS/Glq1JCOCtrTelAOhKtT5PgB+ZDFKcN1UCUiyboW913R88R4nmijyK4OO6Rqv3/tM1Is/i0mXWcF975t4FJRvOHB9tMNwelxxe+D4KhuquyCW3xNFpVjj0gSugMFq6VxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F4wa7cWf; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712844754; h=From:To:Subject:Date:Message-Id;
	bh=3VokuyaV5KZEWRa1fSfPza5p9DlDFFxj4djmwpyk59s=;
	b=F4wa7cWfhioPpkR21A/Ahf4+OSdTghC/By3BXKnqlJa2mdtTLSLxwuVxxdAvFnW85k/2dHwtBaBJO290+RmRIb3vuV3s6ArBOm5gCOHYh0QJKMVzQMqx52sY05NJE09Hsmm4ytA8yPZwDWWwhOevFyZxBT9+yTdIIFdHw9hBS1A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4LV1HI_1712844753;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4LV1HI_1712844753)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 22:12:33 +0800
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
Subject: [PATCH net-next v6 1/4] linux/dim: move useful macros to .h file
Date: Thu, 11 Apr 2024 22:12:28 +0800
Message-Id: <1712844751-53514-2-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

These will be used in subsequent patches, including
newly declared profile arrays.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 include/linux/dim.h | 13 +++++++++++++
 lib/dim/net_dim.c   | 10 ++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9..8149d2d 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -10,6 +10,13 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+/* Number of DIM profiles and period mode. */
+#define NET_DIM_PARAMS_NUM_PROFILES 5
+#define NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE 256
+#define NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE 128
+#define NET_DIM_DEF_PROFILE_CQE 1
+#define NET_DIM_DEF_PROFILE_EQE 1
+
 /*
  * Number of events between DIM iterations.
  * Causes a moderation of the algorithm run.
@@ -127,6 +134,12 @@ enum dim_cq_period_mode {
 	DIM_CQ_PERIOD_NUM_MODES
 };
 
+extern const struct dim_cq_moder
+rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES];
+
+extern const struct dim_cq_moder
+tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES];
+
 /**
  * enum dim_state - DIM algorithm states
  *
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 4e32f7a..a649d90 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -11,12 +11,6 @@
  *        There are different set of profiles for RX/TX CQs.
  *        Each profile size must be of NET_DIM_PARAMS_NUM_PROFILES
  */
-#define NET_DIM_PARAMS_NUM_PROFILES 5
-#define NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE 256
-#define NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE 128
-#define NET_DIM_DEF_PROFILE_CQE 1
-#define NET_DIM_DEF_PROFILE_EQE 1
-
 #define NET_DIM_RX_EQE_PROFILES { \
 	{.usec = 1,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
 	{.usec = 8,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
@@ -49,13 +43,13 @@
 	{.usec = 64, .pkts = 32,}   \
 }
 
-static const struct dim_cq_moder
+const struct dim_cq_moder
 rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_RX_EQE_PROFILES,
 	NET_DIM_RX_CQE_PROFILES,
 };
 
-static const struct dim_cq_moder
+const struct dim_cq_moder
 tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_TX_EQE_PROFILES,
 	NET_DIM_TX_CQE_PROFILES,
-- 
1.8.3.1


