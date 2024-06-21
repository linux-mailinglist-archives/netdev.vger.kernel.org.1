Return-Path: <netdev+bounces-105643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63082912207
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14ACE1F28B22
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA37172BB2;
	Fri, 21 Jun 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v4Wm+r+P"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB33171E5D;
	Fri, 21 Jun 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964848; cv=none; b=IvUVJgpXy9km91dh89moH2cYO+yXW9q3Gdu1xvmfHaFUR7OZ96mYup+RA3zfqWm5erRkrwMQC0sZNws8dzkPaBmAbI+NMATQQqimMXf1F7NzW3MWfB6jhit+4NBzzWNOKKatfEjSzSbV7jRoEGXY/tW/5ussNFA87zGzRz7zg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964848; c=relaxed/simple;
	bh=tmlri8t1CxgfIkfVOnGXuPMD3e1M651EGjnqQtUcNRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qs13kSWaubFBjLtQ/lU49y83YOZ2t9qoa+Of8NE7w/KsAjFPGSWU6k/TVZF+06xNpmWSViGwtA329HCwQtXzUcO2l8NbZEzOn/5TGJ04+hvpo2BX5y1qkijCocp6FMnbJgSkw6AaZY/ZbdgyxOv0fOsCqA06nNtfH5AimHm/EpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v4Wm+r+P; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718964838; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=N5h3iZ4k+3MeEdd0aie0bnGKKRDFAZ2ZrjPuYSrtQc0=;
	b=v4Wm+r+PJmCzVU59TfRgh148JiUFPUqH54SgsRuCmaAHoF+1TJCt7m0OFDNQU3yo435CiEBuSMNZ9vp5pF1q74hVvnXPPjfDBLFfob6nUxQSjz6Rkm5GnYXi9ua+ArHD01eO/UDUO/OT7hNprQ3sXeBZ2wZf4sZXWEMU15GIE4I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0W8w3037_1718964836;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8w3037_1718964836)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 18:13:56 +0800
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
	awel Dembicki <paweldembicki@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v15 2/5] dim: make DIMLIB dependent on NET
Date: Fri, 21 Jun 2024 18:13:50 +0800
Message-Id: <20240621101353.107425-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240621101353.107425-1-hengqi@linux.alibaba.com>
References: <20240621101353.107425-1-hengqi@linux.alibaba.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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
index b0a76dff5c18..b38849af6f13 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -623,6 +623,7 @@ config SIGNATURE
 
 config DIMLIB
 	tristate
+	depends on NET
 	help
 	  Dynamic Interrupt Moderation library.
 	  Implements an algorithm for dynamically changing CQ moderation values
-- 
2.32.0.3.g01195cf9f


