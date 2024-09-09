Return-Path: <netdev+bounces-126440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C56971284
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F141F2340B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812931779AE;
	Mon,  9 Sep 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CltAdiyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE5176237
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871660; cv=none; b=HxG8uuTsi+vho469/hR+RilPlmJGJqHB30MWNoiY5MK9YvB48lc6tdVfe7OOghB9OuuneC6q4v+njGamGNe3Z+epLUis9+s2OB1vkDPzdcf81aPyebnQvQhm0Jzfp9rO7RkxLbogEblJb0LH2vc/0Q7ElAQ0XlKa8bij40xxAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871660; c=relaxed/simple;
	bh=kt0lPmkHrt98h79AEXbXI3LieZDZjeHn7Tj6V/v2Pfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qT3/bk4o84Ym0gYjbbcNqMESBf2IYzmGUGm4kpqdqUYTWxTj9Hlym6oMXkJ6c8U09iFmAVkq9ukW70cHgcw5iAKys5/RKf3bbEoR/A4MB5Xfds5Kl3u5pPYSfS3p2wGdeR/oSTGLbqfLrOFOVb+udJ8Or0XSLgYEcfw7yMgBVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CltAdiyd; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725871659; x=1757407659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CUMSoRMWPW+r7npP2a+yjfigSyRK8+x6+JEJ3C5j7E=;
  b=CltAdiydTaVpNJpjr8Em/RZ997yMBk0r1/s9UhlJC8Gj7s5Bj2BMXFTM
   eVu8hCQVOYM6pj3f9/fWPl711SG3hoHBTyX1IZCBxREcVydTm7A7f9DJ3
   bloICQG22+w9xUf+7t/XMAufVJP3982EpIPuxdXtdR6SnfErU6RIaoYcO
   w=;
X-IronPort-AV: E=Sophos;i="6.10,213,1719878400"; 
   d="scan'208";a="451974468"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:47:20 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.29.78:8353]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.4.141:2525] with esmtp (Farcaster)
 id c4217a95-e83d-4f4b-8fee-8d27962f0786; Mon, 9 Sep 2024 08:47:19 +0000 (UTC)
X-Farcaster-Flow-ID: c4217a95-e83d-4f4b-8fee-8d27962f0786
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 08:47:19 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 08:47:18 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.174) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Mon, 9 Sep 2024 08:47:14 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Beider, Ron"
	<rbeider@amazon.com>, "Chauskin, Igor" <igorch@amazon.com>
Subject: [PATCH v2 net-next 1/2] net: ena: Add ENA Express metrics support
Date: Mon, 9 Sep 2024 11:47:03 +0300
Message-ID: <20240909084704.13856-2-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909084704.13856-1-darinzon@amazon.com>
References: <20240909084704.13856-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

ENA Express metrics, called `ena_srd` are exposed to
customers via `ethtool`.
The metrics allow customers to check the configuration
(mode), tx/rx counters as well as resource utilization.

The documentation is also updated to provide a general
explanation about ENA Express as well as links for further
information about metrics and configurations.

Signed-off-by: Igor Chauskin <igorch@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    |  5 ++
 .../net/ethernet/amazon/ena/ena_admin_defs.h  | 42 ++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.c     | 21 +++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  9 ++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 84 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 13 ---
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  2 +-
 7 files changed, 142 insertions(+), 34 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index a4c7d0c65fd7..4561e8ab9e08 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -230,6 +230,11 @@ per-queue stats) from the device.
 
 In addition the driver logs the stats to syslog upon device reset.
 
+On supported instance types, the statistics will also include the
+ENA Express data (fields prefixed with `ena_srd`). For a complete
+documentation of ENA Express data refer to
+https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ena-express.html#ena-express-monitor
+
 MTU
 ===
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 6de0d590be34..74772b0068ea 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -51,6 +51,8 @@ enum ena_admin_aq_feature_id {
 /* device capabilities */
 enum ena_admin_aq_caps_id {
 	ENA_ADMIN_ENI_STATS                         = 0,
+	/* ENA SRD customer metrics */
+	ENA_ADMIN_ENA_SRD_INFO                      = 1,
 };
 
 enum ena_admin_placement_policy_type {
@@ -99,6 +101,8 @@ enum ena_admin_get_stats_type {
 	ENA_ADMIN_GET_STATS_TYPE_EXTENDED           = 1,
 	/* extra HW stats for specific network interface */
 	ENA_ADMIN_GET_STATS_TYPE_ENI                = 2,
+	/* extra HW stats for ENA SRD */
+	ENA_ADMIN_GET_STATS_TYPE_ENA_SRD            = 3,
 };
 
 enum ena_admin_get_stats_scope {
@@ -106,6 +110,16 @@ enum ena_admin_get_stats_scope {
 	ENA_ADMIN_ETH_TRAFFIC                       = 1,
 };
 
+/* ENA SRD configuration for ENI */
+enum ena_admin_ena_srd_flags {
+	/* Feature enabled */
+	ENA_ADMIN_ENA_SRD_ENABLED                   = BIT(0),
+	/* UDP support enabled */
+	ENA_ADMIN_ENA_SRD_UDP_ENABLED               = BIT(1),
+	/* Bypass Rx UDP ordering */
+	ENA_ADMIN_ENA_SRD_UDP_ORDERING_BYPASS_ENABLED = BIT(2),
+};
+
 struct ena_admin_aq_common_desc {
 	/* 11:0 : command_id
 	 * 15:12 : reserved12
@@ -419,6 +433,32 @@ struct ena_admin_eni_stats {
 	u64 linklocal_allowance_exceeded;
 };
 
+struct ena_admin_ena_srd_stats {
+	/* Number of packets transmitted over ENA SRD */
+	u64 ena_srd_tx_pkts;
+
+	/* Number of packets transmitted or could have been
+	 * transmitted over ENA SRD
+	 */
+	u64 ena_srd_eligible_tx_pkts;
+
+	/* Number of packets received over ENA SRD */
+	u64 ena_srd_rx_pkts;
+
+	/* Percentage of the ENA SRD resources that is in use */
+	u64 ena_srd_resource_utilization;
+};
+
+/* ENA SRD Statistics Command */
+struct ena_admin_ena_srd_info {
+	/* ENA SRD configuration bitmap. See ena_admin_ena_srd_flags for
+	 * details
+	 */
+	u64 flags;
+
+	struct ena_admin_ena_srd_stats ena_srd_stats;
+};
+
 struct ena_admin_acq_get_stats_resp {
 	struct ena_admin_acq_common_desc acq_common_desc;
 
@@ -428,6 +468,8 @@ struct ena_admin_acq_get_stats_resp {
 		struct ena_admin_basic_stats basic_stats;
 
 		struct ena_admin_eni_stats eni_stats;
+
+		struct ena_admin_ena_srd_info ena_srd_info;
 	} u;
 };
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 713a595370bf..3cc3830de482 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -2152,6 +2152,27 @@ int ena_com_get_eni_stats(struct ena_com_dev *ena_dev,
 	return ret;
 }
 
+int ena_com_get_ena_srd_info(struct ena_com_dev *ena_dev,
+			     struct ena_admin_ena_srd_info *info)
+{
+	struct ena_com_stats_ctx ctx;
+	int ret;
+
+	if (!ena_com_get_cap(ena_dev, ENA_ADMIN_ENA_SRD_INFO)) {
+		netdev_err(ena_dev->net_device, "Capability %d isn't supported\n",
+			   ENA_ADMIN_ENA_SRD_INFO);
+		return -EOPNOTSUPP;
+	}
+
+	memset(&ctx, 0x0, sizeof(ctx));
+	ret = ena_get_dev_stats(ena_dev, &ctx, ENA_ADMIN_GET_STATS_TYPE_ENA_SRD);
+	if (likely(ret == 0))
+		memcpy(info, &ctx.get_resp.u.ena_srd_info,
+		       sizeof(ctx.get_resp.u.ena_srd_info));
+
+	return ret;
+}
+
 int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
 				struct ena_admin_basic_stats *stats)
 {
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 924f03f5a6c7..372066e039bf 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -595,6 +595,15 @@ int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
 int ena_com_get_eni_stats(struct ena_com_dev *ena_dev,
 			  struct ena_admin_eni_stats *stats);
 
+/* ena_com_get_ena_srd_info - Get ENA SRD network interface statistics
+ * @ena_dev: ENA communication layer struct
+ * @info: ena srd stats and flags
+ *
+ * @return: 0 on Success and negative value otherwise.
+ */
+int ena_com_get_ena_srd_info(struct ena_com_dev *ena_dev,
+			     struct ena_admin_ena_srd_info *info);
+
 /* ena_com_set_dev_mtu - Configure the device mtu.
  * @ena_dev: ENA communication layer struct
  * @mtu: mtu value
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index b24cc3f05248..5efd3e43ffa6 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -41,6 +41,14 @@ struct ena_stats {
 #define ENA_STAT_ENI_ENTRY(stat) \
 	ENA_STAT_HW_ENTRY(stat, eni_stats)
 
+#define ENA_STAT_ENA_SRD_ENTRY(stat) \
+	ENA_STAT_HW_ENTRY(stat, ena_srd_stats)
+
+#define ENA_STAT_ENA_SRD_MODE_ENTRY(stat) { \
+	.name = #stat, \
+	.stat_offset = offsetof(struct ena_admin_ena_srd_info, flags) / sizeof(u64) \
+}
+
 static const struct ena_stats ena_stats_global_strings[] = {
 	ENA_STAT_GLOBAL_ENTRY(tx_timeout),
 	ENA_STAT_GLOBAL_ENTRY(suspend),
@@ -60,6 +68,14 @@ static const struct ena_stats ena_stats_eni_strings[] = {
 	ENA_STAT_ENI_ENTRY(linklocal_allowance_exceeded),
 };
 
+static const struct ena_stats ena_srd_info_strings[] = {
+	ENA_STAT_ENA_SRD_MODE_ENTRY(ena_srd_mode),
+	ENA_STAT_ENA_SRD_ENTRY(ena_srd_tx_pkts),
+	ENA_STAT_ENA_SRD_ENTRY(ena_srd_eligible_tx_pkts),
+	ENA_STAT_ENA_SRD_ENTRY(ena_srd_rx_pkts),
+	ENA_STAT_ENA_SRD_ENTRY(ena_srd_resource_utilization)
+};
+
 static const struct ena_stats ena_stats_tx_strings[] = {
 	ENA_STAT_TX_ENTRY(cnt),
 	ENA_STAT_TX_ENTRY(bytes),
@@ -112,7 +128,8 @@ static const struct ena_stats ena_stats_ena_com_strings[] = {
 #define ENA_STATS_ARRAY_TX		ARRAY_SIZE(ena_stats_tx_strings)
 #define ENA_STATS_ARRAY_RX		ARRAY_SIZE(ena_stats_rx_strings)
 #define ENA_STATS_ARRAY_ENA_COM		ARRAY_SIZE(ena_stats_ena_com_strings)
-#define ENA_STATS_ARRAY_ENI(adapter)	ARRAY_SIZE(ena_stats_eni_strings)
+#define ENA_STATS_ARRAY_ENI		ARRAY_SIZE(ena_stats_eni_strings)
+#define ENA_STATS_ARRAY_ENA_SRD		ARRAY_SIZE(ena_srd_info_strings)
 
 static void ena_safe_update_stat(u64 *src, u64 *dst,
 				 struct u64_stats_sync *syncp)
@@ -179,7 +196,7 @@ static void ena_dev_admin_queue_stats(struct ena_adapter *adapter, u64 **data)
 
 static void ena_get_stats(struct ena_adapter *adapter,
 			  u64 *data,
-			  bool eni_stats_needed)
+			  bool hw_stats_needed)
 {
 	const struct ena_stats *ena_stats;
 	u64 *ptr;
@@ -193,15 +210,37 @@ static void ena_get_stats(struct ena_adapter *adapter,
 		ena_safe_update_stat(ptr, data++, &adapter->syncp);
 	}
 
-	if (eni_stats_needed) {
-		ena_update_hw_stats(adapter);
-		for (i = 0; i < ENA_STATS_ARRAY_ENI(adapter); i++) {
-			ena_stats = &ena_stats_eni_strings[i];
+	if (hw_stats_needed) {
+		if (ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENI_STATS)) {
+			ena_com_get_eni_stats(adapter->ena_dev, &adapter->eni_stats);
+			/* Updating regardless of rc - once we told ethtool how many stats we have
+			 * it will print that much stats. We can't leave holes in the stats
+			 */
+			for (i = 0; i < ENA_STATS_ARRAY_ENI; i++) {
+				ena_stats = &ena_stats_eni_strings[i];
 
-			ptr = (u64 *)&adapter->eni_stats +
-				ena_stats->stat_offset;
+				ptr = (u64 *)&adapter->eni_stats +
+					ena_stats->stat_offset;
 
+				ena_safe_update_stat(ptr, data++, &adapter->syncp);
+			}
+		}
+
+		if (ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENA_SRD_INFO)) {
+			ena_com_get_ena_srd_info(adapter->ena_dev, &adapter->ena_srd_info);
+			/* Get ENA SRD mode */
+			ptr = (u64 *)&adapter->ena_srd_info;
 			ena_safe_update_stat(ptr, data++, &adapter->syncp);
+			for (i = 1; i < ENA_STATS_ARRAY_ENA_SRD; i++) {
+				ena_stats = &ena_srd_info_strings[i];
+				/* Wrapped within an outer struct - need to accommodate an
+				 * additional offset of the ENA SRD mode that was already processed
+				 */
+				ptr = (u64 *)&adapter->ena_srd_info +
+					ena_stats->stat_offset + 1;
+
+				ena_safe_update_stat(ptr, data++, &adapter->syncp);
+			}
 		}
 	}
 
@@ -214,9 +253,8 @@ static void ena_get_ethtool_stats(struct net_device *netdev,
 				  u64 *data)
 {
 	struct ena_adapter *adapter = netdev_priv(netdev);
-	struct ena_com_dev *dev = adapter->ena_dev;
 
-	ena_get_stats(adapter, data, ena_com_get_cap(dev, ENA_ADMIN_ENI_STATS));
+	ena_get_stats(adapter, data, true);
 }
 
 static int ena_get_sw_stats_count(struct ena_adapter *adapter)
@@ -228,9 +266,8 @@ static int ena_get_sw_stats_count(struct ena_adapter *adapter)
 
 static int ena_get_hw_stats_count(struct ena_adapter *adapter)
 {
-	bool supported = ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENI_STATS);
-
-	return ENA_STATS_ARRAY_ENI(adapter) * supported;
+	return ENA_STATS_ARRAY_ENI * ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENI_STATS) +
+	       ENA_STATS_ARRAY_ENA_SRD * ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENA_SRD_INFO);
 }
 
 int ena_get_sset_count(struct net_device *netdev, int sset)
@@ -291,7 +328,7 @@ static void ena_com_dev_strings(u8 **data)
 
 static void ena_get_strings(struct ena_adapter *adapter,
 			    u8 *data,
-			    bool eni_stats_needed)
+			    bool hw_stats_needed)
 {
 	const struct ena_stats *ena_stats;
 	int i;
@@ -301,10 +338,18 @@ static void ena_get_strings(struct ena_adapter *adapter,
 		ethtool_puts(&data, ena_stats->name);
 	}
 
-	if (eni_stats_needed) {
-		for (i = 0; i < ENA_STATS_ARRAY_ENI(adapter); i++) {
-			ena_stats = &ena_stats_eni_strings[i];
-			ethtool_puts(&data, ena_stats->name);
+	if (hw_stats_needed) {
+		if (ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENI_STATS)) {
+			for (i = 0; i < ENA_STATS_ARRAY_ENI; i++) {
+				ena_stats = &ena_stats_eni_strings[i];
+				ethtool_puts(&data, ena_stats->name);
+			}
+		}
+		if (ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENA_SRD_INFO)) {
+			for (i = 0; i < ENA_STATS_ARRAY_ENA_SRD; i++) {
+				ena_stats = &ena_srd_info_strings[i];
+				ethtool_puts(&data, ena_stats->name);
+			}
 		}
 	}
 
@@ -317,11 +362,10 @@ static void ena_get_ethtool_strings(struct net_device *netdev,
 				    u8 *data)
 {
 	struct ena_adapter *adapter = netdev_priv(netdev);
-	struct ena_com_dev *dev = adapter->ena_dev;
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		ena_get_strings(adapter, data, ena_com_get_cap(dev, ENA_ADMIN_ENI_STATS));
+		ena_get_strings(adapter, data, true);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 184b6e6cbed4..0883c9a230f2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2798,19 +2798,6 @@ static void ena_config_debug_area(struct ena_adapter *adapter)
 	ena_com_delete_debug_area(adapter->ena_dev);
 }
 
-int ena_update_hw_stats(struct ena_adapter *adapter)
-{
-	int rc;
-
-	rc = ena_com_get_eni_stats(adapter->ena_dev, &adapter->eni_stats);
-	if (rc) {
-		netdev_err(adapter->netdev, "Failed to get ENI stats\n");
-		return rc;
-	}
-
-	return 0;
-}
-
 static void ena_get_stats64(struct net_device *netdev,
 			    struct rtnl_link_stats64 *stats)
 {
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index d59509747d1a..6e12ae3b12e5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -373,6 +373,7 @@ struct ena_adapter {
 	struct u64_stats_sync syncp;
 	struct ena_stats_dev dev_stats;
 	struct ena_admin_eni_stats eni_stats;
+	struct ena_admin_ena_srd_info ena_srd_info;
 
 	/* last queue index that was checked for uncompleted tx packets */
 	u32 last_monitored_tx_qid;
@@ -390,7 +391,6 @@ void ena_dump_stats_to_dmesg(struct ena_adapter *adapter);
 
 void ena_dump_stats_to_buf(struct ena_adapter *adapter, u8 *buf);
 
-int ena_update_hw_stats(struct ena_adapter *adapter);
 
 int ena_update_queue_params(struct ena_adapter *adapter,
 			    u32 new_tx_size,
-- 
2.40.1


