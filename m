Return-Path: <netdev+bounces-198531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972FEADC917
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A1F189A606
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D18E2D9EC2;
	Tue, 17 Jun 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="aVQhSr6Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1E290BA2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158526; cv=none; b=eaD3l0A9z6ahucvCUG8YFRgqwBvKgYF1wIRDkD3NkpgH7S3FvSFW8p8Nq7PsgjnlfZCZXuaDMLYxmNdLM7YzQELCpO5LwoH+8Pw4miNmHbF3VxBpxSfXZqnUfCDXT4Actm3FhrfYjLxPxbhU3NnScl4D2kKCrsQgkGT9E/zWj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158526; c=relaxed/simple;
	bh=IRR/axaqJSB8U6ZdY+vkjVvS2JUVYtosnoHTOV3F8Nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMLfrlx3m2Bmp2/hPw8bQ4OygCVOKsZ6PqBxzWu2FoAhCWv+vYaQXEPX8wjloQBQhF1DQo7bdjcc/JDjmz3npcFJtgtKaQQntxH9W4Dd7dZFA9NsVy+npaTyLUCRK8PMhP9Ck+GRTg32856R+JFUowH01ChcnGPyrRVKAggUz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=aVQhSr6Q; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750158525; x=1781694525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjD3xdTrNY9z67bTqV6P/R/0uiJK8x+0ndOsd7RRhXc=;
  b=aVQhSr6QAjYGFFVOfytHZ3aSUR5+mdhln12pbmx6pJ/rn7/sOwgoCbIg
   pGdqd7GFM18B/nxyc1K2wSPPwVSsQg7YtGIr9qJpYqCl2QWVIJABetfpw
   thBR4YxOx9yUTLSZM2ez5+cuoMQUApmijhNnvEhvTF5G/PjgXRkW5Cgzr
   rejezH63BQUfNpH6scqs0Uj61Ghq6M/SAhRZpNJh+yVJ4AxCXi0gnKuRy
   quehkQd8ZNBCJm3yFDvyXK2WDmWxVStxwGA/0C9vCXi2qno5Ol2MVx/lh
   g1ynqFyoNh4mlU+Vawvv5ihKfixeMsvZ4N1ROnrdoxDNpyg+C0BOPkOM+
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,243,1744070400"; 
   d="scan'208";a="310082908"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:08:41 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:25025]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.39:2525] with esmtp (Farcaster)
 id 51019dc6-85e9-4a2a-b1a7-2583fede3946; Tue, 17 Jun 2025 11:08:40 +0000 (UTC)
X-Farcaster-Flow-ID: 51019dc6-85e9-4a2a-b1a7-2583fede3946
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:08:40 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:08:28 +0000
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
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v13 net-next 8/9] net: ena: View PHC stats using debugfs
Date: Tue, 17 Jun 2025 14:05:44 +0300
Message-ID: <20250617110545.5659-9-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617110545.5659-1-darinzon@amazon.com>
References: <20250617110545.5659-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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


