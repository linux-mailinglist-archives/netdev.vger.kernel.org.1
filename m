Return-Path: <netdev+bounces-192273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCFCABF337
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9343017B54B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DFB264606;
	Wed, 21 May 2025 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TOKpuQ5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB925A2AF
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827931; cv=none; b=DXeC755eG6997pDRZ6XqxAJUsuWYivg+YLqV38IVJYQSHj5mTH0PLVW2N+JCPQVC/FfW8IhUZlFqRZ2cERBQy7zqUxbzRtQILFNFw43/lneFNDoVcn8i8yXNblyYneA+D2cyWDVW+OKez/s/mcDGDFsS39CkTS6wjFrhCXC/9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827931; c=relaxed/simple;
	bh=G6o67bGA5yaohL9M8lKS072DecaQ7XIw4Em8N1NJ9fg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nx0v06U+nRCaxtRLo2ucUKEgXlWV5PTnwK1SkJInwoQTSqMsZJfNOJ8AZtcODd6bR/TtIzz8XckKl242p9oWDPHwh1+1xSu+gFBs1gln8J6KHjTA5QNh4XIL/LNFqeOqpXrVNM8ehM2v6h13fPXHOjYuSr6geNidCUKAwhMLJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TOKpuQ5L; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747827931; x=1779363931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hI6LFDY9fjnPMnB02Vu2Lx6p+rty2OMnLiLLDlvgmyw=;
  b=TOKpuQ5LJIWQnY2ca6YeTEkuXfPncCGqwgzt6b+ijj+qpJenwPqL9xe2
   SMMsuaemKGxtnVnFEEkmcCr2r/c0nHMWdHZ+auTewoClM8/wnSBNqswdf
   vrYqQ2gW7p7Ok6Soe0oqXjUSvTY2aAXPj1gdz9LaJ6gHlp4N/FLXkQB5/
   optAF44PIJpVupbGxz3iyCiLTgyiEexfEi2EEBoCwWNZqvvrFMWBujoXw
   6ljADR4s+EosFaxM4YoBUhKAK1Qaaa21zRDG54kjwdoyaWLaaNYpCBpF4
   VagTcm0UVmkA2j1K6ZJ2aSQBNHik0QEUZ8aqyzxX47jzf1xQ9PwBPrJG3
   g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="826997169"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:45:05 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:32393]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.44:2525] with esmtp (Farcaster)
 id 088c0592-5e00-4a62-a1fa-0521c7570850; Wed, 21 May 2025 11:45:03 +0000 (UTC)
X-Farcaster-Flow-ID: 088c0592-5e00-4a62-a1fa-0521c7570850
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:45:03 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:44:52 +0000
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
Subject: [PATCH v9 net-next 6/8] net: ena: View PHC stats using debugfs
Date: Wed, 21 May 2025 14:42:52 +0300
Message-ID: <20250521114254.369-7-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521114254.369-1-darinzon@amazon.com>
References: <20250521114254.369-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
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
 drivers/net/ethernet/amazon/ena/ena_debugfs.c | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_debugfs.c b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
index fea7bb7f..c7de13f1 100644
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
@@ -15,8 +44,16 @@ void ena_debugfs_init(struct net_device *dev)
 
 	adapter->debugfs_base =
 		debugfs_create_dir(dev_name(&adapter->pdev->dev), NULL);
-	if (IS_ERR(adapter->debugfs_base))
+	if (IS_ERR(adapter->debugfs_base)) {
 		netdev_err(dev, "Failed to create debugfs dir\n");
+		return;
+	}
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


