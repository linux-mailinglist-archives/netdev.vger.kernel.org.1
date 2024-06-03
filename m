Return-Path: <netdev+bounces-100282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C208D865C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3FC1C218E8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545412FF73;
	Mon,  3 Jun 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wiebDOyG"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F8132110;
	Mon,  3 Jun 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429658; cv=none; b=ZSofABnJZkc7LUQy3vuzY893vxgCx/Ygsv1t1EQWl4T6xKLEf3YrPhLT8zss4u3Hho11JreUSmRLBYLJlXNzW6D6xfVWgTMHe8oMzzx/kRdpyiTOBmsqyUx3DPsKY6k7p3NPDYVvjyX90GT8FRBsvMH+qbAK27CCFO5F3qYOiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429658; c=relaxed/simple;
	bh=V2q9wNhoGtcyAXiR+9ihkLI1oCVtTX6AlUqTypmDM7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLZ44tMT0gXj4q9kRS3SW+32oYsdm3gbkHv6m+x7rER2d6e4hfmk8OE2UKK+nos22h+4iZCjZPbmk6PmQafr3yU1cshCl6P9v2hPhWQd2U7tsm921tlnlsQ9MiAnKfPcvtwukm+RwKxnzjgqfjaEivHTgHnkUG1spZf4xj21GKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wiebDOyG; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717429653; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MPfdTFk0JzUdgoO7Gp95wxkRiKUup9y05x3o9Fsda+E=;
	b=wiebDOyGCkEM0AMRbqACoXLIigoYTRu+F8Ik7OqBixGLjqhQw5BikIza3Fl+6UrzMdkhpIENauJ4OBnnYigGKTCFo7qfAaOCIi058uLTA50c9jXy1QD/EJ9Zi0ipLG1MPezaEX0VxT+sh1DyIdNoCvLdb1x49HZ9WFQbpBPrneI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W7oH02s_1717429650;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7oH02s_1717429650)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 23:47:31 +0800
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
Subject: [PATCH net-next v14 2/5] dim: make DIMLIB dependent on NET
Date: Mon,  3 Jun 2024 23:47:24 +0800
Message-Id: <20240603154727.31998-3-hengqi@linux.alibaba.com>
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

DIMLIB's capabilities are supplied by the dim, net_dim, and
rdma_dim objects, and dim's interfaces solely act as a base for
net_dim and rdma_dim and are not explicitly used anywhere else.
rdma_dim is utilized by the infiniband driver, while net_dim
is for network devices, excluding the soc/fsl driver.

In this patch, net_dim relies on some NET's interfaces, thus
DIMLIB needs to explicitly depend on the NET Kconfig.

The soc/fsl driver uses the functions provided by net_dim, so
it also needs to depend on NET.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/soc/fsl/Kconfig | 2 +-
 lib/Kconfig             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index fcec6ed83d5e..a1e0bc8c1757 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -22,7 +22,7 @@ config FSL_GUTS
 
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
+        depends on FSL_MC_BUS && NET
         select SOC_BUS
         select FSL_GUTS
         select DIMLIB
diff --git a/lib/Kconfig b/lib/Kconfig
index d33a268bc256..0ffc4f69564f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -629,6 +629,7 @@ config SIGNATURE
 
 config DIMLIB
 	tristate
+	depends on NET
 	help
 	  Dynamic Interrupt Moderation library.
 	  Implements an algorithm for dynamically changing CQ moderation values
-- 
2.32.0.3.g01195cf9f


