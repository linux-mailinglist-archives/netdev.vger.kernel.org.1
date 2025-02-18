Return-Path: <netdev+bounces-167472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A384BA3A5E7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B661888456
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83611EB5C8;
	Tue, 18 Feb 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hbTCLahV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05DC26FDA0
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904039; cv=none; b=X6iN302HavLmo/oZhOltH2C4aSwFUwgVCGbrQSjgebcZJwWd5QMwRr4BlPQ6S4dLA4H4t5D+p1y0rFolGnnQl+mnb6J1gXOpDVxiXl7t9aMTPify73nU5lUig+1aEyD/l7I8/VaWT4/cPRv5ULlUB/WcW1oHuegu9FGMdAEuxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904039; c=relaxed/simple;
	bh=TnFfCJKTb5HnpSXdNnNEfk0ytnyaYOkZEgIKBtkZphs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRIyWxWx0MqMQ0Ak9HKBUaf7lCdMEbIPei7+NArd7VgHGwpS4TFH0ALjphrMppy581xk2ffUIuYnwizyl4YsANd+uPE/SONMZlvEovwdVoJhZYxrS29cdBdKABsOVqhwrywV/RAFiDh8GRP4DBG4hDElVT1HqB23eoRsCEbn8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hbTCLahV; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739904036; x=1771440036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7QlZUtrjU+4HGCsvna6+v81ESwqOBOAoM3b2HCetxIQ=;
  b=hbTCLahV56nsjDPBIw3YXfGWiuVFR965XnJGlMvNFeRX+vVjRJYb/99I
   fiIVOXVwDvA6lxZpz13/51ewdhrWioxcf3eU/wGXGmVxtqQ5w+8lMLOU8
   LjqH4lY0gsuFznusyQvgtYP+jMaE9eFOIVU2og+VQYa/AuK/5DPL3x22A
   c=;
X-IronPort-AV: E=Sophos;i="6.13,296,1732579200"; 
   d="scan'208";a="719855749"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 18:40:35 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:54400]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.51.50:2525] with esmtp (Farcaster)
 id 23b0e92f-3da4-4aa2-af9e-b6d7ee0f8f50; Tue, 18 Feb 2025 18:40:34 +0000 (UTC)
X-Farcaster-Flow-ID: 23b0e92f-3da4-4aa2-af9e-b6d7ee0f8f50
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 18 Feb 2025 18:40:33 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEC001.ant.amazon.com (10.252.135.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Feb 2025 18:40:33 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 18 Feb 2025 18:40:33 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.176])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id 6DE2EA0108;
	Tue, 18 Feb 2025 18:40:26 +0000 (UTC)
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
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH v7 net-next 4/5] net: ena: PHC stats through sysfs
Date: Tue, 18 Feb 2025 20:39:47 +0200
Message-ID: <20250218183948.757-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218183948.757-1-darinzon@amazon.com>
References: <20250218183948.757-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The patch allows retrieving PHC statistics
through sysfs.
In case the feature is not enabled (through `phc_enable`
sysfs entry), no output will be written.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  5 --
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  6 +++
 drivers/net/ethernet/amazon/ena/ena_sysfs.c   | 50 +++++++++++++++++++
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index b442d247..28cc0163 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -11,11 +11,6 @@
 #include "ena_xdp.h"
 #include "ena_phc.h"
 
-struct ena_stats {
-	char name[ETH_GSTRING_LEN];
-	int stat_offset;
-};
-
 struct ena_hw_metrics {
 	char name[ETH_GSTRING_LEN];
 };
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index e3c7ed9c..c10d1305 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/ethtool.h>
 #include <net/xdp.h>
 #include <uapi/linux/bpf.h>
 
@@ -389,6 +390,11 @@ struct ena_adapter {
 	u32 xdp_num_queues;
 };
 
+struct ena_stats {
+	char name[ETH_GSTRING_LEN];
+	int stat_offset;
+};
+
 void ena_set_ethtool_ops(struct net_device *netdev);
 
 void ena_dump_stats_to_dmesg(struct ena_adapter *adapter);
diff --git a/drivers/net/ethernet/amazon/ena/ena_sysfs.c b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
index d0ded92d..10993594 100644
--- a/drivers/net/ethernet/amazon/ena/ena_sysfs.c
+++ b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
@@ -65,6 +65,52 @@ static ssize_t ena_phc_enable_get(struct device *dev,
 static DEVICE_ATTR(phc_enable, S_IRUGO | S_IWUSR, ena_phc_enable_get,
 		   ena_phc_enable_set);
 
+#define ENA_STAT_ENA_COM_PHC_ENTRY(stat) { \
+	.name = #stat, \
+	.stat_offset = offsetof(struct ena_com_stats_phc, stat) / sizeof(u64) \
+}
+
+const struct ena_stats ena_stats_ena_com_phc_strings[] = {
+	ENA_STAT_ENA_COM_PHC_ENTRY(phc_cnt),
+	ENA_STAT_ENA_COM_PHC_ENTRY(phc_exp),
+	ENA_STAT_ENA_COM_PHC_ENTRY(phc_skp),
+	ENA_STAT_ENA_COM_PHC_ENTRY(phc_err),
+};
+
+u16 ena_stats_array_ena_com_phc_size = ARRAY_SIZE(ena_stats_ena_com_phc_strings);
+
+static ssize_t ena_phc_stats_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct ena_adapter *adapter = dev_get_drvdata(dev);
+	int i, rc, chars_written = 0;
+
+	if (!ena_phc_is_active(adapter))
+		return 0;
+
+	for (i = 0; i < ena_stats_array_ena_com_phc_size; i++) {
+		const struct ena_stats *ena_stats;
+		u64 *ptr;
+
+		ena_stats = &ena_stats_ena_com_phc_strings[i];
+		ptr = (u64 *)&adapter->ena_dev->phc.stats +
+		      ena_stats->stat_offset;
+		rc = snprintf(buf,
+			      ETH_GSTRING_LEN + sizeof(u64),
+			      "%s: %llu\n",
+			      ena_stats->name,
+			      *ptr);
+
+		buf += rc;
+		chars_written += rc;
+	}
+
+	return chars_written;
+}
+
+static DEVICE_ATTR(phc_stats, S_IRUGO, ena_phc_stats_show, NULL);
+
 /******************************************************************************
  *****************************************************************************/
 int ena_sysfs_init(struct device *dev)
@@ -72,6 +118,9 @@ int ena_sysfs_init(struct device *dev)
 	if (device_create_file(dev, &dev_attr_phc_enable))
 		dev_err(dev, "Failed to create phc_enable sysfs entry");
 
+	if (device_create_file(dev, &dev_attr_phc_stats))
+		dev_err(dev, "Failed to create phc_stats sysfs entry");
+
 	return 0;
 }
 
@@ -80,4 +129,5 @@ int ena_sysfs_init(struct device *dev)
 void ena_sysfs_terminate(struct device *dev)
 {
 	device_remove_file(dev, &dev_attr_phc_enable);
+	device_remove_file(dev, &dev_attr_phc_stats);
 }
-- 
2.47.1


