Return-Path: <netdev+bounces-104314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFED590C1F7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 04:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6604928470C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 02:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B473519B5A4;
	Tue, 18 Jun 2024 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NNP1IBO8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C319B3C3;
	Tue, 18 Jun 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679413; cv=none; b=IDtWVue2zlZQp0MI6QGgzfcGKk2Tv1q8wD3nkkWanWLv+Kw3ysNlKI96AvQ+WKVm17G1k7l6u8FJRdbVeFxOMCuz8aBohWw4eBJMdRuFMtn+S8e8pk8IO69WPWKnAD2oglDm+3tNZ+OW7J5HY41ceA+kr4MNvhQfB0h8B3Mi3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679413; c=relaxed/simple;
	bh=V2q9wNhoGtcyAXiR+9ihkLI1oCVtTX6AlUqTypmDM7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSgCfcsRtbrRHZT10IfaXEmRXSy5Fkn4ZKw38uCwU28szOJGRWlD/JtF1mk+FDExlZp26p3bZqxYltPgf0cK/eLASAgfQGk8Ksca7sZwliYrZr8u8xX8AwUj8OUS/XvkjHQjlJLSBm0z96id7rw43MyPqF4TB+d+Kx+VakiCJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NNP1IBO8; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718679409; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MPfdTFk0JzUdgoO7Gp95wxkRiKUup9y05x3o9Fsda+E=;
	b=NNP1IBO8xy2SlgMEPWq9wdtDof6mzY+g8c9owcxwo3IyxEc5LeDcCuIrsuGexkk3Nxkv4RieKPi2XzYLSLewfh1ovFqqBCIF8od/JnH3g5KylzjWK/0FnpB7S7BxeFcBbPyHdX6CBQLUON/hVP+l7gdwAtH2TESIFNP/mja1SbI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W8iGnO7_1718679407;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8iGnO7_1718679407)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 10:56:47 +0800
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
Subject: [PATCH RESEND net-next v14 2/5] dim: make DIMLIB dependent on NET
Date: Tue, 18 Jun 2024 10:56:41 +0800
Message-Id: <20240618025644.25754-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240618025644.25754-1-hengqi@linux.alibaba.com>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
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


