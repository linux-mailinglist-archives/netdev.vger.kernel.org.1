Return-Path: <netdev+bounces-92565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C98B7EA4
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23111282F4D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C47180A93;
	Tue, 30 Apr 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NBZpWQhz"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A8181BB6;
	Tue, 30 Apr 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498313; cv=none; b=lSl3Y6yasU3kaEzcG3ePdhj0KwdxikemFk7FJKEGf6So7xl0FM817n6JcrXhqPuoIHQCBdp7M0IbEwZuJVbsV76cUseJG1wKv/Q/AB0tYAeUKPOA8kvDAX//WmJC2bSlN18qSacQJ9dIWwFIioOOeEe2aQGZWTce6NMmX5SmZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498313; c=relaxed/simple;
	bh=5nFbI7Upd2hpda5RW2EE/j0+rNTNKwpdyiOklTx6Nug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFRsX2qFrBH1tSL1JCczugqtgRtOBbLBUZXKTkmSoEqqwR33gGQDoYT356/fA0q2XnY/vDEUsQJFu0ryPnVaMu9tuENNOdK5q1PF+J9X/d/og84aYoyCqlCukXbcnP76q6MmV+bGyVP9N6QsjpEPwgry0tZFchZC7rvrZZxy0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NBZpWQhz; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714498303; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8pxCpWS62jn7IeclhGIjU+cXuR/s1kYqZ8blq+PFmUc=;
	b=NBZpWQhzHTp1Gvnp+JtRZxOg67nulAjhBYaiXk7izTbsHMGq+sde9Dg3RqxBLG79B8tTvxcyK7lUK7VVhOCIIzXXVngOn555a5QvfS5BgDtSdRYq98L3qgDuNfCOodv9ODThL060AKWFJqohdY8RPabDWFOueqSoANwUfT91mgw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5ckN.u_1714498297;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5ckN.u_1714498297)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 01:31:39 +0800
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
	justinstitt@google.com
Subject: [PATCH net-next v11 1/4] linux/dim: move useful macros to .h file
Date: Wed,  1 May 2024 01:31:33 +0800
Message-Id: <20240430173136.15807-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240430173136.15807-1-hengqi@linux.alibaba.com>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
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


