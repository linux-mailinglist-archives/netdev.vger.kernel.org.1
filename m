Return-Path: <netdev+bounces-192691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865E4AC0D44
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036493AEF98
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892CA28C03A;
	Thu, 22 May 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HMevo6Rf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7D28C01E
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921855; cv=none; b=XMCC0RyTS1WU3TsZC1/gLBt7sF8HY8l0BeWGCEX8syQX+jEAIWAQs8KqorDahzf3m1EF31y6XpY2ZRrXgt4jyFVXf9k6QXDN6IgzKQNlggKHRKEsGEgR73bvunlVf9IizEnqSDUV0NNZT1YxKYoQYRa5FMd7RVpHhEyTql1C6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921855; c=relaxed/simple;
	bh=IRR/axaqJSB8U6ZdY+vkjVvS2JUVYtosnoHTOV3F8Nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnktgs4zm5FpIOFQH4xJFhFqJuAnCgUUEcydydAy/tpuhl/KodgnKjRHX17OE8OJ5Cz7L5iEIJeqIKs8NstDEOf+m/9kEAw+qKxNBRnwK8JXLAE9Q6uZVvUM8m3RQAC+KoBY7cmw4SIvJTAmeED+kE97kk8hYokk/tGhHstMGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HMevo6Rf; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747921854; x=1779457854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjD3xdTrNY9z67bTqV6P/R/0uiJK8x+0ndOsd7RRhXc=;
  b=HMevo6Rft3S2QsnOxGvs9htrpBeOU+IzzmpVzfeFKKTSCEOV+rf+Fxg/
   y8YiEBiug9/bbIeQDCwmtQwJJhCUcu1CjW6bRscKzQDOP2/pFTgUM5Sof
   MArZEnf1Z1dCPby83sXQY9m5+4plZOONltFtAyKnIX3dOmMPu6gi1rFIR
   RZJdc7mc812erUXP4IGO4GoF+pAglx1xTlDu9X4tULjm1NFjU22FVuuEl
   u5jeGjkQ/WnwqrMJOLd2GuQL7eIwSJVsBNGDJzEPTPfqSfTy4gJVWZwqi
   M6WyFBvBx2lc7B5srNT7SFVYihWaKYWER2R/kMi1A/yxAfIw+kLHyhDMn
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="96244337"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:50:52 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:31880]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.135:2525] with esmtp (Farcaster)
 id b6d9c778-95f3-4201-bb3b-14dabac7dbb9; Thu, 22 May 2025 13:50:50 +0000 (UTC)
X-Farcaster-Flow-ID: b6d9c778-95f3-4201-bb3b-14dabac7dbb9
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:50:50 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:50:39 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>
Subject: [PATCH v10 net-next 6/8] net: ena: View PHC stats using debugfs
Date: Thu, 22 May 2025 16:48:37 +0300
Message-ID: <20250522134839.1336-7-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522134839.1336-1-darinzon@amazon.com>
References: <20250522134839.1336-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Add an entry named `phc_stats` to view the PHC statistics.
If PHC is enabled, the stats are printed, as below:

phc_cnt: 0
phc_exp: 0
phc_skp: 0
phc_err_dv: 0
phc_err_ts: 0

If PHC is disabled, no statistics will be displayed.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_debugfs.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_debugfs.c b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
index d9327cd8..46ed8098 100644
--- a/drivers/net/ethernet/amazon/ena/ena_debugfs.c
+++ b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
@@ -8,6 +8,35 @@
 #include <linux/seq_file.h>
 #include <linux/pci.h>
 #include "ena_debugfs.h"
+#include "ena_phc.h"
+
+static int phc_stats_show(struct seq_file *file, void *priv)
+{
+	struct ena_adapter *adapter = file->private;
+
+	if (!ena_phc_is_active(adapter))
+		return 0;
+
+	seq_printf(file,
+		   "phc_cnt: %llu\n",
+		   adapter->ena_dev->phc.stats.phc_cnt);
+	seq_printf(file,
+		   "phc_exp: %llu\n",
+		   adapter->ena_dev->phc.stats.phc_exp);
+	seq_printf(file,
+		   "phc_skp: %llu\n",
+		   adapter->ena_dev->phc.stats.phc_skp);
+	seq_printf(file,
+		   "phc_err_dv: %llu\n",
+		   adapter->ena_dev->phc.stats.phc_err_dv);
+	seq_printf(file,
+		   "phc_err_ts: %llu\n",
+		   adapter->ena_dev->phc.stats.phc_err_ts);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(phc_stats);
 
 void ena_debugfs_init(struct net_device *dev)
 {
@@ -15,6 +44,12 @@ void ena_debugfs_init(struct net_device *dev)
 
 	adapter->debugfs_base =
 		debugfs_create_dir(dev_name(&adapter->pdev->dev), NULL);
+
+	debugfs_create_file("phc_stats",
+			    0400,
+			    adapter->debugfs_base,
+			    adapter,
+			    &phc_stats_fops);
 }
 
 void ena_debugfs_terminate(struct net_device *dev)
-- 
2.47.1


