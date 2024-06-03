Return-Path: <netdev+bounces-100285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69EA8D8664
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EF61F23608
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE0135A7F;
	Mon,  3 Jun 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FuSEPbZe"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511F130A4D;
	Mon,  3 Jun 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429661; cv=none; b=AoUikqLrEJuKSISZ2e/jkCqV1HSXHCkkvWlAdBUI8VIigkGOLh5MOB8AMw6KBRxiG6wZt90takMJlvAYfVlFZL3H9u3sKQzxiGcmkY90VCgZ3Z43AvKliAXTylEgfwjq+P/zPxe7qp1TIxP5+9XcMshy29FltCM6vlsr0R0T2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429661; c=relaxed/simple;
	bh=5nFbI7Upd2hpda5RW2EE/j0+rNTNKwpdyiOklTx6Nug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alFYpItEmx8HMPhWJ7MH8CstCg5IsPmn4GCLfCOh+tZcQivf/8tLmFWlTHmUXEC+ARNmJUbNNnTrVQOEk0LFYFlTjzLC8nW8O0NR5rj9lv4d22ZzLneVVYRdOiJ/0sAUAOPWwYpE+6Et/EbTqiu1ETbUzPcDpYt+2ab1P0/dsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FuSEPbZe; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717429651; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8pxCpWS62jn7IeclhGIjU+cXuR/s1kYqZ8blq+PFmUc=;
	b=FuSEPbZeqLvLCp35G9SG588NemGc7g4B7009GuiPDENTPmdrMA/aQal8iRDoR/N6Phqr4mriTGVYQpvsZQ1dBH3/F0UCzKoTAeERlmgzi89c12me+3m73w+xWUgX9MakVrefHtylNK45BTKrbwLGOFkTav5L2b4Zk+Xx1QipQdk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W7oJyxL_1717429648;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7oJyxL_1717429648)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 23:47:29 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
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
	justinstitt@google.com,
	donald.hunter@gmail.com,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	awel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net-next v14 1/5] linux/dim: move useful macros to .h file
Date: Mon,  3 Jun 2024 23:47:23 +0800
Message-Id: <20240603154727.31998-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240603154727.31998-1-hengqi@linux.alibaba.com>
References: <20240603154727.31998-1-hengqi@linux.alibaba.com>
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
 lib/dim/net_dim.c   | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

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
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 4e32f7aaac86..67d5beb34dc3 100644
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
-- 
2.32.0.3.g01195cf9f


