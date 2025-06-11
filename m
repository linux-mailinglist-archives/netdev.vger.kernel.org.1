Return-Path: <netdev+bounces-196488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA9AD4FB2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8976F18948C5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55C25F7A4;
	Wed, 11 Jun 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YsjuwJ7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF125C83E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633967; cv=none; b=KsprX07wK22lVNhgOwnIou+LfOhIO82Nu9oU69EZ0fpE4NoNCLzIKW0oeejwp+yTrTZFLNaUxeM1+KxwAHtxmYLd37eh8yNf8i1uvFDpu43zWmi5/huJcncVJGKZabNqf2JgVUwUTEQeEzZctoq/gxyBJogOqpCqtqqFfjokwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633967; c=relaxed/simple;
	bh=IRR/axaqJSB8U6ZdY+vkjVvS2JUVYtosnoHTOV3F8Nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u32/oxn7fb8epq50heFouIofbpkwSmfLT4y1vKz3kOM1Ysb8A64lsIeqtKpqhJgqJQoMaf1aVZ3b2Fs5GQlJe5QcwpVwoMPr+MzrLKNZTsGaEfPx5QnvTLBZLoJZfuL2IeFPOFpva5jyjuKIUbJ/25ggAPjSjxIykRiGhlYIAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YsjuwJ7M; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749633966; x=1781169966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjD3xdTrNY9z67bTqV6P/R/0uiJK8x+0ndOsd7RRhXc=;
  b=YsjuwJ7M9VtjemqPHif9RY5x071G1f5/WExMiRsbFbNsQt6sT9U8TRXj
   IdswAlih9sSAMI7PXWlUtCIbcpnPAFopcPQS6w3QRUmeSgNMKSFs2e5tA
   rv1qzYdcVcfbrOhxIOAkJ2gOaP3LB+8V2FguYExPNBCpEkrqBr3C8SpAt
   fwrh0+oHVSfeIzH0SoxSusXEDbC2puH/NZcTCJ9MQN7uKJCoe8aca+Lns
   2rid7roXlvxQ8edNyk9mcgl0Agyhu0QCb2LcgqUwNU/8fCcB/L0e0FkMe
   BCpb8ZMHx0SxV9GVKMouWc1TV3lXmd19cRddbXcwekpbY255KJLnhNgXj
   g==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="530051151"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 09:26:05 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:58971]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.229:2525] with esmtp (Farcaster)
 id 1000dbaa-c4a3-4e05-8f93-f985fddd7431; Wed, 11 Jun 2025 09:26:04 +0000 (UTC)
X-Farcaster-Flow-ID: 1000dbaa-c4a3-4e05-8f93-f985fddd7431
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:26:03 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.176) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:25:52 +0000
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
Subject: [PATCH v12 net-next 8/9] net: ena: View PHC stats using debugfs
Date: Wed, 11 Jun 2025 12:22:37 +0300
Message-ID: <20250611092238.2651-9-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611092238.2651-1-darinzon@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
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


