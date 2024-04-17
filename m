Return-Path: <netdev+bounces-88773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C08A883D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15089B21C55
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDCD1482E3;
	Wed, 17 Apr 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AUix8wrg"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299013C668;
	Wed, 17 Apr 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369361; cv=none; b=prvlt15MP+ZX99+OBD230SFRkCKLnv5CstpZTc5HRFM4ZtNoqYYy/gzjout//ZvxXby3ILRiyTsLH4Rtj45VZBBtz1+kEZKs7i1/Id2ACB5sb1v1qoESjmiZtDDCnTc+Jz8gJYB30TY2xwKEfbBjUz1Qio/9OW1pK7X3UbaLERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369361; c=relaxed/simple;
	bh=531CFp+fCuM34mS5cJtscp3kcLouJp5+cILiR2HSNw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDZD4tyyaxlujWnpQF2z5DClEdsSX4WxT4xGpZjectkE5ZsVotu2JEXtBdWQ92TPPRqYkZ3MFysyzVEj0rLCFOhEhdGcmoIGHwOkyfoF/aiDut4Tw+cjPv8rvmkdJT0QQHaWUzTNORyeEbVm2pF/x+1NhYvtMbxW180WhLPfYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AUix8wrg; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713369350; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zOwP8RNrk5vXOcpT61mlwQiTxZ0s8AllhAHin84XddM=;
	b=AUix8wrgNegBc5c+H2yINEvNCgu1AyDErDweLBWVyiRg1rJZcNwiUqUawJQplrhJS9C3UfY83jzNLTYBWMLI99mYc7l8th+0MpW6EAnAlvR8Om6hiWKSmLuLOFVZPbIWKTY7Nyjq5QqI9wrUIPyzEc4BdqKOAIvg/7N3jZWNeA8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W4lx7.8_1713369347;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4lx7.8_1713369347)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 23:55:48 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"justinstitt@google.com" <justinstitt@google.com>
Subject: [PATCH net-next v9 1/4] linux/dim: move useful macros to .h file
Date: Wed, 17 Apr 2024 23:55:43 +0800
Message-Id: <20240417155546.25691-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240417155546.25691-1-hengqi@linux.alibaba.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These will be used in subsequent patches, including
newly declared profile arrays.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 include/linux/dim.h | 13 +++++++++++++
 lib/dim/net_dim.c   | 18 ++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9aa2ec..bc992118770d 100644
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
+dim_rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES];
+
+extern const struct dim_cq_moder
+dim_tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES];
+
 /**
  * enum dim_state - DIM algorithm states
  *
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 4e32f7aaac86..686da4b91808 100644
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
@@ -49,14 +43,14 @@
 	{.usec = 64, .pkts = 32,}   \
 }
 
-static const struct dim_cq_moder
-rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
+const struct dim_cq_moder
+dim_rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_RX_EQE_PROFILES,
 	NET_DIM_RX_CQE_PROFILES,
 };
 
-static const struct dim_cq_moder
-tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
+const struct dim_cq_moder
+dim_tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_TX_EQE_PROFILES,
 	NET_DIM_TX_CQE_PROFILES,
 };
@@ -64,7 +58,7 @@ tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 struct dim_cq_moder
 net_dim_get_rx_moderation(u8 cq_period_mode, int ix)
 {
-	struct dim_cq_moder cq_moder = rx_profile[cq_period_mode][ix];
+	struct dim_cq_moder cq_moder = dim_rx_profile[cq_period_mode][ix];
 
 	cq_moder.cq_period_mode = cq_period_mode;
 	return cq_moder;
@@ -84,7 +78,7 @@ EXPORT_SYMBOL(net_dim_get_def_rx_moderation);
 struct dim_cq_moder
 net_dim_get_tx_moderation(u8 cq_period_mode, int ix)
 {
-	struct dim_cq_moder cq_moder = tx_profile[cq_period_mode][ix];
+	struct dim_cq_moder cq_moder = dim_tx_profile[cq_period_mode][ix];
 
 	cq_moder.cq_period_mode = cq_period_mode;
 	return cq_moder;
-- 
2.32.0.3.g01195cf9f


