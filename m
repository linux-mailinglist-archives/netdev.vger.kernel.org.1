Return-Path: <netdev+bounces-88324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06838A6B0D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D30A2841BB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F141C76;
	Tue, 16 Apr 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q7nu417c"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0421D530
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270915; cv=none; b=AZEQT+QpL02GERh0LUkK+5prCvcYbx8W3x/NNM+TUC7xfmEcxjFKVX/kMXdyS2AO8NP3BhC00d0Zq1uVWw8MTLK764GR/onWSxN8tJJEojH1ytHCntFc6he2ToV4KrnNIDChDU8B8ewSdA502iQGXEHsOJCPzAXxkzhBx0y1IK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270915; c=relaxed/simple;
	bh=3gXGNebqefPXgWmEmxws2q/k17H8yCR4bsq8QfYr9qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQolK1GwEGBZIvKreNOe1rKcnLsBdgbW+XDKhrLnGguQCjZbhLSH8tL16QGGjsmXlTbBsSAI1xxGIz+WaMTi+9Y26t67MdNGBEgm8xMe+vYi/XQMMuqqTe9Y4V27jGC+be2leOr4c9P36C+S6EeOypRGNM86flQ+V7pDXONddi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q7nu417c; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713270909; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IJn5JoNDxwJSLayGMmgWWRisRt/GqGsocEhi4oOUZas=;
	b=Q7nu417cFSatWBf/SHFdpVNO/pbHAJMMFSi+ScCiyAuNWI+TgS2pA0fxRs7jvTNikS19x6wEJMlGyh/CgPpyVBG+uDLdBZoHxXdalBrbOXuyv4UfxvktPVpaQtWzsrs3Le3ecfScY3ILxVrDNiRa+12o0V3RJh6XlkEnoGDpNlw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4i.ECy_1713270592;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4i.ECy_1713270592)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 20:29:52 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v8 1/4] linux/dim: move useful macros to .h file
Date: Tue, 16 Apr 2024 20:29:47 +0800
Message-Id: <20240416122950.39046-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240416122950.39046-1-hengqi@linux.alibaba.com>
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
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
 lib/dim/net_dim.c   | 10 ++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9aa2ec..8149d2d6589c 100644
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
index 4e32f7aaac86..a649d9069c06 100644
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
2.32.0.3.g01195cf9f


