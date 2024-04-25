Return-Path: <netdev+bounces-91391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C837C8B2700
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06434B23F0A
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535D14D713;
	Thu, 25 Apr 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WwLl43Mr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40214D6E5;
	Thu, 25 Apr 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064399; cv=none; b=CUjj3+Q6bnHKbIqebf8MEWbutoCXdI8PisK4IcrNja3QhL0zagRXBC9BiJ+1EWtv1yRA6aZC79cuOZTN/x5vBcB6mCBfHFAs+/72NzfbJp/89RpN1+I6ef5e1dw/yS/VntcYXS9aDFMcPjlP0oaxpltfGPMuVvKr+wA6AS/81mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064399; c=relaxed/simple;
	bh=6rJQgGazq0MxChNaQ4nbOaHIPuqZ8ZyTflKccpLlbRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2eviKBK4Cg2b9ivw8CgEFMf5Zoiu3WZHXclap8ncZ4Yq1UXL6TPe8I107m5cQEoAsmhRBfrFWg+3o12eb9IhLakgE5joJ8V+QwGuWXAq8cnCxf/tAUguOby9cwNL4HmoAThoTRd7IyUBtIWlB5enuTMm7OGbqMocgi7PteEuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WwLl43Mr; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714064394; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YMOky6wjROeChW2gGiwYbzSNM5F/ZEDz2+PT8bliH4A=;
	b=WwLl43Mr0eyxtTIdwbyoHE9hb8ZaYP0e/eGakzpjv7IOo7GBGUJA21eackmbFcLZK3Bf3rwrBq6UyTFm/OyLHLvGZNFUMPSrls9nEplqEh2vVe5Lbgok0/MvLgad09esbttORv9xtq+Hi6FrGJRDZ+Mg7HOIjV8JXE7uvv3FHoU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5G09o0_1714064390;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5G09o0_1714064390)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 00:59:51 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
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
	"justinstitt @ google . com" <justinstitt@google.com>
Subject: [PATCH net-next v10 1/4] linux/dim: move useful macros to .h file
Date: Fri, 26 Apr 2024 00:59:45 +0800
Message-Id: <20240425165948.111269-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240425165948.111269-1-hengqi@linux.alibaba.com>
References: <20240425165948.111269-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Useful macros will be used effectively elsewhere.
These will be utilized in subsequent patches.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 include/linux/dim.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9aa2ec..43398f5eade2 100644
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
-- 
2.32.0.3.g01195cf9f


