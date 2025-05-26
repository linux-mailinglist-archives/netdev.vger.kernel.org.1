Return-Path: <netdev+bounces-193357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F780AC39B4
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEFD3A9614
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0011957FC;
	Mon, 26 May 2025 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YfkW5mqx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6A7E110
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239924; cv=none; b=nZPk5U9ZZEWsBpZo8XH7FZ/OyXoa2OW8/fK8hPs8kwOs4sXH3kOli57Ev/Pq8Xxmt9X4sTn6pvmyB2dbeHDX7bK66a5cR/umgorsMImIK6eIAdhaosdQDJuYSJ+dlt/DTnb+Sk8l2t/Cw9CbLHzBezrioG0t1PRE34svO7/pPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239924; c=relaxed/simple;
	bh=IRR/axaqJSB8U6ZdY+vkjVvS2JUVYtosnoHTOV3F8Nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuRya7YFWdmDJfBZ6zAqCq8m2glxUo6THr8Y6p3YTWVzpvyiTSqevj8fnolVlJyhOhbZlTosf19TfBydPReHjC0kyNO8ls7G8z3CNdmlI9uy+TuLjo9FTUI86DqW9dJ379TKbmvOZfxKgYgnEgvrb3dkGhVhQCrSHIymzlqcnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YfkW5mqx; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748239922; x=1779775922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjD3xdTrNY9z67bTqV6P/R/0uiJK8x+0ndOsd7RRhXc=;
  b=YfkW5mqxBFplHFndiZN4xmuIAhYD8kSFPJQ0X+inCzEa7iQjs9ez/NOd
   a2RxU37q0F5J/3iM+Wx22PA3Da/OcqJLMsnYHWzZZvP8W3BKxZ2njH3uZ
   T+s/I+1mteL/IzpwCusYm8ou9wqbGSghH/2nh5bRmoTue4hTTuZlwkpVv
   wRBZXxMEfa//CUqvZmS/2xLNmmZzqDAeFNraBvTVpxnfs0XV0TFEjQeU/
   nTSiwMrzAgzXl+IUhzCDHrMcszUJ0swwiOQRzUSkwhRbANtP/6u4OzJpq
   Sc4+DWrtGSKDtE8rv04M+vH+ENG0XBHPRlaGaVvniBPtLtVIgKmL0CR8x
   A==;
X-IronPort-AV: E=Sophos;i="6.15,315,1739836800"; 
   d="scan'208";a="200805151"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 06:12:00 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:14344]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.135:2525] with esmtp (Farcaster)
 id cf59ac50-c240-4655-ad81-2b2625078669; Mon, 26 May 2025 06:11:59 +0000 (UTC)
X-Farcaster-Flow-ID: cf59ac50-c240-4655-ad81-2b2625078669
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:11:57 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.177) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:11:46 +0000
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
Subject: [PATCH v11 net-next 7/8] net: ena: View PHC stats using debugfs
Date: Mon, 26 May 2025 09:09:17 +0300
Message-ID: <20250526060919.214-8-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526060919.214-1-darinzon@amazon.com>
References: <20250526060919.214-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
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


