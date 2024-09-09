Return-Path: <netdev+bounces-126439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE649971283
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2101F233D3
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB541B29CC;
	Mon,  9 Sep 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J+jRUh0u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1341B2522
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871651; cv=none; b=GQ6D4kEGeyH18kuHlk1dMwSDl6dTPElawhN8HUaTpsYdN4lUM2zSsOx94cCtJDJ7rDYNqqOFQGGAVsFpyp8TsysqIs7w/bVrLWNNwhzgoItNV1SI/UKCvdifnpcdqa7GI5Dic/dAoKshl1m66aSuaNQCVTOxYJuJqyqyqZ5srTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871651; c=relaxed/simple;
	bh=5t0oyk/ONjUKOc+/vi/FtxAGa9zQJ1gnrgjnjJrKF5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYgakueu9KUYOPW6G+00zL941kHZjA64/1T3kVe9oVvfBwQNGDr0ye1VW1tmbO18BNvDb3ayq4VBmksoqcad/cgpisi24uox62ckTR7qKWTWkRe8vkvnHR4R5g7Uep/rFiWOb2/2DvqQjxfPBY9BfIIGPz6FrkqZI6L3AcD2HzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=J+jRUh0u; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725871650; x=1757407650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiFKq029PsEjRXECTChoqna9bTKRXuY6yMx/cj1sMO4=;
  b=J+jRUh0uCsTz0BlNTr/qNXT/OnbsvKbfIiO4eYV49iQTx8gxqh+b8ERE
   praPATE9gPaPnLUa+oiET2eNvitlmS94UsaOMRFjfbv+2rOnAMLaaTJck
   MSk66pAzI6EBaReSRp/I/QpeEL4zvwyozKCmON2LJxuKmMNsE5Q0Wuz0o
   M=;
X-IronPort-AV: E=Sophos;i="6.10,213,1719878400"; 
   d="scan'208";a="432103700"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:47:26 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.44.209:35100]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.0.78:2525] with esmtp (Farcaster)
 id 83cca504-63d1-4ae7-ba8b-eab9397a7c61; Mon, 9 Sep 2024 08:47:25 +0000 (UTC)
X-Farcaster-Flow-ID: 83cca504-63d1-4ae7-ba8b-eab9397a7c61
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 08:47:24 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 08:47:24 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.174) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Mon, 9 Sep 2024 08:47:20 +0000
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
Subject: [PATCH v2 net-next 2/2] net: ena: Extend customer metrics reporting support
Date: Mon, 9 Sep 2024 11:47:04 +0300
Message-ID: <20240909084704.13856-3-darinzon@amazon.com>
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

ENA currently supports the following customer metrics:
- `bw_in_allowance_exceeded`
- `bw_out_allowance_exceeded`
- `conntrack_allowance_exceeded`
- `linklocal_allowance_exceeded`
- `pps_allowance_exceeded`

This patch adds a new metric named:
`conntrack_allowance_available`.

Information about these metrics is available in [1].

In addition, the interface between the driver and the
device has been upgraded to allow more flexibility and
expendability to additional metrics in the future.

[1]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-network-performance-ena.html#network-performance-metrics

Signed-off-by: Ron Beider <rbeider@amazon.com>
Signed-off-by: Shahar Itzko <itzko@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  30 ++++
 drivers/net/ethernet/amazon/ena/ena_com.c     | 154 +++++++++++++---
 drivers/net/ethernet/amazon/ena/ena_com.h     |  59 +++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 165 ++++++++++++------
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  14 +-
 5 files changed, 344 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 74772b0068ea..9d9fa6559354 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -7,6 +7,21 @@
 
 #define ENA_ADMIN_RSS_KEY_PARTS              10
 
+#define ENA_ADMIN_CUSTOMER_METRICS_SUPPORT_MASK 0x3F
+#define ENA_ADMIN_CUSTOMER_METRICS_MIN_SUPPORT_MASK 0x1F
+
+ /* customer metrics - in correlation with
+  * ENA_ADMIN_CUSTOMER_METRICS_SUPPORT_MASK
+  */
+enum ena_admin_customer_metrics_id {
+	ENA_ADMIN_BW_IN_ALLOWANCE_EXCEEDED         = 0,
+	ENA_ADMIN_BW_OUT_ALLOWANCE_EXCEEDED        = 1,
+	ENA_ADMIN_PPS_ALLOWANCE_EXCEEDED           = 2,
+	ENA_ADMIN_CONNTRACK_ALLOWANCE_EXCEEDED     = 3,
+	ENA_ADMIN_LINKLOCAL_ALLOWANCE_EXCEEDED     = 4,
+	ENA_ADMIN_CONNTRACK_ALLOWANCE_AVAILABLE    = 5,
+};
+
 enum ena_admin_aq_opcode {
 	ENA_ADMIN_CREATE_SQ                         = 1,
 	ENA_ADMIN_DESTROY_SQ                        = 2,
@@ -53,6 +68,7 @@ enum ena_admin_aq_caps_id {
 	ENA_ADMIN_ENI_STATS                         = 0,
 	/* ENA SRD customer metrics */
 	ENA_ADMIN_ENA_SRD_INFO                      = 1,
+	ENA_ADMIN_CUSTOMER_METRICS                  = 2,
 };
 
 enum ena_admin_placement_policy_type {
@@ -103,6 +119,7 @@ enum ena_admin_get_stats_type {
 	ENA_ADMIN_GET_STATS_TYPE_ENI                = 2,
 	/* extra HW stats for ENA SRD */
 	ENA_ADMIN_GET_STATS_TYPE_ENA_SRD            = 3,
+	ENA_ADMIN_GET_STATS_TYPE_CUSTOMER_METRICS   = 4,
 };
 
 enum ena_admin_get_stats_scope {
@@ -377,6 +394,9 @@ struct ena_admin_aq_get_stats_cmd {
 	 * stats of other device
 	 */
 	u16 device_id;
+
+	/* a bitmap representing the requested metric values */
+	u64 requested_metrics;
 };
 
 /* Basic Statistics Command. */
@@ -459,6 +479,14 @@ struct ena_admin_ena_srd_info {
 	struct ena_admin_ena_srd_stats ena_srd_stats;
 };
 
+/* Customer Metrics Command. */
+struct ena_admin_customer_metrics {
+	/* A bitmap representing the reported customer metrics according to
+	 * the order they are reported
+	 */
+	u64 reported_metrics;
+};
+
 struct ena_admin_acq_get_stats_resp {
 	struct ena_admin_acq_common_desc acq_common_desc;
 
@@ -470,6 +498,8 @@ struct ena_admin_acq_get_stats_resp {
 		struct ena_admin_eni_stats eni_stats;
 
 		struct ena_admin_ena_srd_info ena_srd_info;
+
+		struct ena_admin_customer_metrics customer_metrics;
 	} u;
 };
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 3cc3830de482..d958cda9e58b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1881,6 +1881,56 @@ int ena_com_get_link_params(struct ena_com_dev *ena_dev,
 	return ena_com_get_feature(ena_dev, resp, ENA_ADMIN_LINK_CONFIG, 0);
 }
 
+static int ena_get_dev_stats(struct ena_com_dev *ena_dev,
+			     struct ena_com_stats_ctx *ctx,
+			     enum ena_admin_get_stats_type type)
+{
+	struct ena_admin_acq_get_stats_resp *get_resp = &ctx->get_resp;
+	struct ena_admin_aq_get_stats_cmd *get_cmd = &ctx->get_cmd;
+	struct ena_com_admin_queue *admin_queue;
+	int ret;
+
+	admin_queue = &ena_dev->admin_queue;
+
+	get_cmd->aq_common_descriptor.opcode = ENA_ADMIN_GET_STATS;
+	get_cmd->aq_common_descriptor.flags = 0;
+	get_cmd->type = type;
+
+	ret = ena_com_execute_admin_command(admin_queue,
+					    (struct ena_admin_aq_entry *)get_cmd,
+					    sizeof(*get_cmd),
+					    (struct ena_admin_acq_entry *)get_resp,
+					    sizeof(*get_resp));
+
+	if (unlikely(ret))
+		netdev_err(ena_dev->net_device, "Failed to get stats. error: %d\n", ret);
+
+	return ret;
+}
+
+static void ena_com_set_supported_customer_metrics(struct ena_com_dev *ena_dev)
+{
+	struct ena_customer_metrics *customer_metrics;
+	struct ena_com_stats_ctx ctx;
+	int ret;
+
+	customer_metrics = &ena_dev->customer_metrics;
+	if (!ena_com_get_cap(ena_dev, ENA_ADMIN_CUSTOMER_METRICS)) {
+		customer_metrics->supported_metrics = ENA_ADMIN_CUSTOMER_METRICS_MIN_SUPPORT_MASK;
+		return;
+	}
+
+	memset(&ctx, 0x0, sizeof(ctx));
+	ctx.get_cmd.requested_metrics = ENA_ADMIN_CUSTOMER_METRICS_SUPPORT_MASK;
+	ret = ena_get_dev_stats(ena_dev, &ctx, ENA_ADMIN_GET_STATS_TYPE_CUSTOMER_METRICS);
+	if (likely(ret == 0))
+		customer_metrics->supported_metrics =
+			ctx.get_resp.u.customer_metrics.reported_metrics;
+	else
+		netdev_err(ena_dev->net_device,
+			   "Failed to query customer metrics support. error: %d\n", ret);
+}
+
 int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 			      struct ena_com_dev_get_features_ctx *get_feat_ctx)
 {
@@ -1960,6 +2010,8 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 	else
 		return rc;
 
+	ena_com_set_supported_customer_metrics(ena_dev);
+
 	return 0;
 }
 
@@ -2104,33 +2156,6 @@ int ena_com_dev_reset(struct ena_com_dev *ena_dev,
 	return 0;
 }
 
-static int ena_get_dev_stats(struct ena_com_dev *ena_dev,
-			     struct ena_com_stats_ctx *ctx,
-			     enum ena_admin_get_stats_type type)
-{
-	struct ena_admin_aq_get_stats_cmd *get_cmd = &ctx->get_cmd;
-	struct ena_admin_acq_get_stats_resp *get_resp = &ctx->get_resp;
-	struct ena_com_admin_queue *admin_queue;
-	int ret;
-
-	admin_queue = &ena_dev->admin_queue;
-
-	get_cmd->aq_common_descriptor.opcode = ENA_ADMIN_GET_STATS;
-	get_cmd->aq_common_descriptor.flags = 0;
-	get_cmd->type = type;
-
-	ret =  ena_com_execute_admin_command(admin_queue,
-					     (struct ena_admin_aq_entry *)get_cmd,
-					     sizeof(*get_cmd),
-					     (struct ena_admin_acq_entry *)get_resp,
-					     sizeof(*get_resp));
-
-	if (unlikely(ret))
-		netdev_err(ena_dev->net_device, "Failed to get stats. error: %d\n", ret);
-
-	return ret;
-}
-
 int ena_com_get_eni_stats(struct ena_com_dev *ena_dev,
 			  struct ena_admin_eni_stats *stats)
 {
@@ -2188,6 +2213,50 @@ int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
 	return ret;
 }
 
+int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32 len)
+{
+	struct ena_admin_aq_get_stats_cmd *get_cmd;
+	struct ena_com_stats_ctx ctx;
+	int ret;
+
+	if (unlikely(len > ena_dev->customer_metrics.buffer_len)) {
+		netdev_err(ena_dev->net_device,
+			   "Invalid buffer size %u. The given buffer is too big.\n", len);
+		return -EINVAL;
+	}
+
+	if (!ena_com_get_cap(ena_dev, ENA_ADMIN_CUSTOMER_METRICS)) {
+		netdev_err(ena_dev->net_device, "Capability %d not supported.\n",
+			   ENA_ADMIN_CUSTOMER_METRICS);
+		return -EOPNOTSUPP;
+	}
+
+	if (!ena_dev->customer_metrics.supported_metrics) {
+		netdev_err(ena_dev->net_device, "No supported customer metrics.\n");
+		return -EOPNOTSUPP;
+	}
+
+	get_cmd = &ctx.get_cmd;
+	memset(&ctx, 0x0, sizeof(ctx));
+	ret = ena_com_mem_addr_set(ena_dev,
+				   &get_cmd->u.control_buffer.address,
+				   ena_dev->customer_metrics.buffer_dma_addr);
+	if (unlikely(ret)) {
+		netdev_err(ena_dev->net_device, "Memory address set failed.\n");
+		return ret;
+	}
+
+	get_cmd->u.control_buffer.length = ena_dev->customer_metrics.buffer_len;
+	get_cmd->requested_metrics = ena_dev->customer_metrics.supported_metrics;
+	ret = ena_get_dev_stats(ena_dev, &ctx, ENA_ADMIN_GET_STATS_TYPE_CUSTOMER_METRICS);
+	if (likely(ret == 0))
+		memcpy(buffer, ena_dev->customer_metrics.buffer_virt_addr, len);
+	else
+		netdev_err(ena_dev->net_device, "Failed to get customer metrics. error: %d\n", ret);
+
+	return ret;
+}
+
 int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 {
 	struct ena_com_admin_queue *admin_queue;
@@ -2727,6 +2796,24 @@ int ena_com_allocate_debug_area(struct ena_com_dev *ena_dev,
 	return 0;
 }
 
+int ena_com_allocate_customer_metrics_buffer(struct ena_com_dev *ena_dev)
+{
+	struct ena_customer_metrics *customer_metrics = &ena_dev->customer_metrics;
+
+	customer_metrics->buffer_len = ENA_CUSTOMER_METRICS_BUFFER_SIZE;
+	customer_metrics->buffer_virt_addr = NULL;
+
+	customer_metrics->buffer_virt_addr =
+		dma_alloc_coherent(ena_dev->dmadev, customer_metrics->buffer_len,
+				   &customer_metrics->buffer_dma_addr, GFP_KERNEL);
+	if (!customer_metrics->buffer_virt_addr) {
+		customer_metrics->buffer_len = 0;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 void ena_com_delete_host_info(struct ena_com_dev *ena_dev)
 {
 	struct ena_host_attribute *host_attr = &ena_dev->host_attr;
@@ -2749,6 +2836,19 @@ void ena_com_delete_debug_area(struct ena_com_dev *ena_dev)
 	}
 }
 
+void ena_com_delete_customer_metrics_buffer(struct ena_com_dev *ena_dev)
+{
+	struct ena_customer_metrics *customer_metrics = &ena_dev->customer_metrics;
+
+	if (customer_metrics->buffer_virt_addr) {
+		dma_free_coherent(ena_dev->dmadev, customer_metrics->buffer_len,
+				  customer_metrics->buffer_virt_addr,
+				  customer_metrics->buffer_dma_addr);
+		customer_metrics->buffer_virt_addr = NULL;
+		customer_metrics->buffer_len = 0;
+	}
+}
+
 int ena_com_set_host_attributes(struct ena_com_dev *ena_dev)
 {
 	struct ena_host_attribute *host_attr = &ena_dev->host_attr;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 372066e039bf..a372c5e768a7 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -42,6 +42,8 @@
 #define ADMIN_CQ_SIZE(depth)	((depth) * sizeof(struct ena_admin_acq_entry))
 #define ADMIN_AENQ_SIZE(depth)	((depth) * sizeof(struct ena_admin_aenq_entry))
 
+#define ENA_CUSTOMER_METRICS_BUFFER_SIZE 512
+
 /*****************************************************************************/
 /*****************************************************************************/
 /* ENA adaptive interrupt moderation settings */
@@ -278,6 +280,16 @@ struct ena_rss {
 
 };
 
+struct ena_customer_metrics {
+	/* in correlation with ENA_ADMIN_CUSTOMER_METRICS_SUPPORT_MASK
+	 * and ena_admin_customer_metrics_id
+	 */
+	u64 supported_metrics;
+	dma_addr_t buffer_dma_addr;
+	void *buffer_virt_addr;
+	u32 buffer_len;
+};
+
 struct ena_host_attribute {
 	/* Debug area */
 	u8 *debug_area_virt_addr;
@@ -327,6 +339,8 @@ struct ena_com_dev {
 	struct ena_intr_moder_entry *intr_moder_tbl;
 
 	struct ena_com_llq_info llq_info;
+
+	struct ena_customer_metrics customer_metrics;
 };
 
 struct ena_com_dev_get_features_ctx {
@@ -604,6 +618,15 @@ int ena_com_get_eni_stats(struct ena_com_dev *ena_dev,
 int ena_com_get_ena_srd_info(struct ena_com_dev *ena_dev,
 			     struct ena_admin_ena_srd_info *info);
 
+/* ena_com_get_customer_metrics - Get customer metrics for network interface
+ * @ena_dev: ENA communication layer struct
+ * @buffer: buffer for returned customer metrics
+ * @len: size of the buffer
+ *
+ * @return: 0 on Success and negative value otherwise.
+ */
+int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32 len);
+
 /* ena_com_set_dev_mtu - Configure the device mtu.
  * @ena_dev: ENA communication layer struct
  * @mtu: mtu value
@@ -814,6 +837,13 @@ int ena_com_allocate_host_info(struct ena_com_dev *ena_dev);
 int ena_com_allocate_debug_area(struct ena_com_dev *ena_dev,
 				u32 debug_area_size);
 
+/* ena_com_allocate_customer_metrics_buffer - Allocate customer metrics resources.
+ * @ena_dev: ENA communication layer struct
+ *
+ * @return: 0 on Success and negative value otherwise.
+ */
+int ena_com_allocate_customer_metrics_buffer(struct ena_com_dev *ena_dev);
+
 /* ena_com_delete_debug_area - Free the debug area resources.
  * @ena_dev: ENA communication layer struct
  *
@@ -828,6 +858,13 @@ void ena_com_delete_debug_area(struct ena_com_dev *ena_dev);
  */
 void ena_com_delete_host_info(struct ena_com_dev *ena_dev);
 
+/* ena_com_delete_customer_metrics_buffer - Free the customer metrics resources.
+ * @ena_dev: ENA communication layer struct
+ *
+ * Free the allocated customer metrics area.
+ */
+void ena_com_delete_customer_metrics_buffer(struct ena_com_dev *ena_dev);
+
 /* ena_com_set_host_attributes - Update the device with the host
  * attributes (debug area and host info) base address.
  * @ena_dev: ENA communication layer struct
@@ -984,6 +1021,28 @@ static inline bool ena_com_get_cap(struct ena_com_dev *ena_dev,
 	return !!(ena_dev->capabilities & BIT(cap_id));
 }
 
+/* ena_com_get_customer_metric_support - query whether device supports a given customer metric.
+ * @ena_dev: ENA communication layer struct
+ * @metric_id: enum value representing the customer metric
+ *
+ * @return - true if customer metric is supported or false otherwise
+ */
+static inline bool ena_com_get_customer_metric_support(struct ena_com_dev *ena_dev,
+						       enum ena_admin_customer_metrics_id metric_id)
+{
+	return !!(ena_dev->customer_metrics.supported_metrics & BIT(metric_id));
+}
+
+/* ena_com_get_customer_metric_count - return the number of supported customer metrics.
+ * @ena_dev: ENA communication layer struct
+ *
+ * @return - the number of supported customer metrics
+ */
+static inline int ena_com_get_customer_metric_count(struct ena_com_dev *ena_dev)
+{
+	return hweight64(ena_dev->customer_metrics.supported_metrics);
+}
+
 /* ena_com_update_intr_reg - Prepare interrupt register
  * @intr_reg: interrupt register to update.
  * @rx_delay_interval: Rx interval in usecs
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 5efd3e43ffa6..60fb35ec4b15 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -14,6 +14,10 @@ struct ena_stats {
 	int stat_offset;
 };
 
+struct ena_hw_metrics {
+	char name[ETH_GSTRING_LEN];
+};
+
 #define ENA_STAT_ENA_COM_ENTRY(stat) { \
 	.name = #stat, \
 	.stat_offset = offsetof(struct ena_com_stats_admin, stat) / sizeof(u64) \
@@ -49,6 +53,10 @@ struct ena_stats {
 	.stat_offset = offsetof(struct ena_admin_ena_srd_info, flags) / sizeof(u64) \
 }
 
+#define ENA_METRIC_ENI_ENTRY(stat) { \
+	.name = #stat \
+}
+
 static const struct ena_stats ena_stats_global_strings[] = {
 	ENA_STAT_GLOBAL_ENTRY(tx_timeout),
 	ENA_STAT_GLOBAL_ENTRY(suspend),
@@ -60,6 +68,9 @@ static const struct ena_stats ena_stats_global_strings[] = {
 	ENA_STAT_GLOBAL_ENTRY(reset_fail),
 };
 
+/* A partial list of hw stats. Used when admin command
+ * with type ENA_ADMIN_GET_STATS_TYPE_CUSTOMER_METRICS is not supported
+ */
 static const struct ena_stats ena_stats_eni_strings[] = {
 	ENA_STAT_ENI_ENTRY(bw_in_allowance_exceeded),
 	ENA_STAT_ENI_ENTRY(bw_out_allowance_exceeded),
@@ -68,6 +79,15 @@ static const struct ena_stats ena_stats_eni_strings[] = {
 	ENA_STAT_ENI_ENTRY(linklocal_allowance_exceeded),
 };
 
+static const struct ena_hw_metrics ena_hw_stats_strings[] = {
+	ENA_METRIC_ENI_ENTRY(bw_in_allowance_exceeded),
+	ENA_METRIC_ENI_ENTRY(bw_out_allowance_exceeded),
+	ENA_METRIC_ENI_ENTRY(pps_allowance_exceeded),
+	ENA_METRIC_ENI_ENTRY(conntrack_allowance_exceeded),
+	ENA_METRIC_ENI_ENTRY(linklocal_allowance_exceeded),
+	ENA_METRIC_ENI_ENTRY(conntrack_allowance_available),
+};
+
 static const struct ena_stats ena_srd_info_strings[] = {
 	ENA_STAT_ENA_SRD_MODE_ENTRY(ena_srd_mode),
 	ENA_STAT_ENA_SRD_ENTRY(ena_srd_tx_pkts),
@@ -130,6 +150,7 @@ static const struct ena_stats ena_stats_ena_com_strings[] = {
 #define ENA_STATS_ARRAY_ENA_COM		ARRAY_SIZE(ena_stats_ena_com_strings)
 #define ENA_STATS_ARRAY_ENI		ARRAY_SIZE(ena_stats_eni_strings)
 #define ENA_STATS_ARRAY_ENA_SRD		ARRAY_SIZE(ena_srd_info_strings)
+#define ENA_METRICS_ARRAY_ENI		ARRAY_SIZE(ena_hw_stats_strings)
 
 static void ena_safe_update_stat(u64 *src, u64 *dst,
 				 struct u64_stats_sync *syncp)
@@ -142,6 +163,57 @@ static void ena_safe_update_stat(u64 *src, u64 *dst,
 	} while (u64_stats_fetch_retry(syncp, start));
 }
 
+static void ena_metrics_stats(struct ena_adapter *adapter, u64 **data)
+{
+	struct ena_com_dev *dev = adapter->ena_dev;
+	const struct ena_stats *ena_stats;
+	u64 *ptr;
+	int i;
+
+	if (ena_com_get_cap(dev, ENA_ADMIN_CUSTOMER_METRICS)) {
+		u32 supported_metrics_count;
+		int len;
+
+		supported_metrics_count = ena_com_get_customer_metric_count(dev);
+		len = supported_metrics_count * sizeof(u64);
+
+		/* Fill the data buffer, and advance its pointer */
+		ena_com_get_customer_metrics(dev, (char *)(*data), len);
+		(*data) += supported_metrics_count;
+
+	} else if (ena_com_get_cap(dev, ENA_ADMIN_ENI_STATS)) {
+		ena_com_get_eni_stats(dev, &adapter->eni_stats);
+		/* Updating regardless of rc - once we told ethtool how many stats we have
+		 * it will print that much stats. We can't leave holes in the stats
+		 */
+		for (i = 0; i < ENA_STATS_ARRAY_ENI; i++) {
+			ena_stats = &ena_stats_eni_strings[i];
+
+			ptr = (u64 *)&adapter->eni_stats +
+				ena_stats->stat_offset;
+
+			ena_safe_update_stat(ptr, (*data)++, &adapter->syncp);
+		}
+	}
+
+	if (ena_com_get_cap(dev, ENA_ADMIN_ENA_SRD_INFO)) {
+		ena_com_get_ena_srd_info(dev, &adapter->ena_srd_info);
+		/* Get ENA SRD mode */
+		ptr = (u64 *)&adapter->ena_srd_info;
+		ena_safe_update_stat(ptr, (*data)++, &adapter->syncp);
+		for (i = 1; i < ENA_STATS_ARRAY_ENA_SRD; i++) {
+			ena_stats = &ena_srd_info_strings[i];
+			/* Wrapped within an outer struct - need to accommodate an
+			 * additional offset of the ENA SRD mode that was already processed
+			 */
+			ptr = (u64 *)&adapter->ena_srd_info +
+				ena_stats->stat_offset + 1;
+
+			ena_safe_update_stat(ptr, (*data)++, &adapter->syncp);
+		}
+	}
+}
+
 static void ena_queue_stats(struct ena_adapter *adapter, u64 **data)
 {
 	const struct ena_stats *ena_stats;
@@ -210,39 +282,8 @@ static void ena_get_stats(struct ena_adapter *adapter,
 		ena_safe_update_stat(ptr, data++, &adapter->syncp);
 	}
 
-	if (hw_stats_needed) {
-		if (ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENI_STATS)) {
-			ena_com_get_eni_stats(adapter->ena_dev, &adapter->eni_stats);
-			/* Updating regardless of rc - once we told ethtool how many stats we have
-			 * it will print that much stats. We can't leave holes in the stats
-			 */
-			for (i = 0; i < ENA_STATS_ARRAY_ENI; i++) {
-				ena_stats = &ena_stats_eni_strings[i];
-
-				ptr = (u64 *)&adapter->eni_stats +
-					ena_stats->stat_offset;
-
-				ena_safe_update_stat(ptr, data++, &adapter->syncp);
-			}
-		}
-
-		if (ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENA_SRD_INFO)) {
-			ena_com_get_ena_srd_info(adapter->ena_dev, &adapter->ena_srd_info);
-			/* Get ENA SRD mode */
-			ptr = (u64 *)&adapter->ena_srd_info;
-			ena_safe_update_stat(ptr, data++, &adapter->syncp);
-			for (i = 1; i < ENA_STATS_ARRAY_ENA_SRD; i++) {
-				ena_stats = &ena_srd_info_strings[i];
-				/* Wrapped within an outer struct - need to accommodate an
-				 * additional offset of the ENA SRD mode that was already processed
-				 */
-				ptr = (u64 *)&adapter->ena_srd_info +
-					ena_stats->stat_offset + 1;
-
-				ena_safe_update_stat(ptr, data++, &adapter->syncp);
-			}
-		}
-	}
+	if (hw_stats_needed)
+		ena_metrics_stats(adapter, &data);
 
 	ena_queue_stats(adapter, &data);
 	ena_dev_admin_queue_stats(adapter, &data);
@@ -266,8 +307,17 @@ static int ena_get_sw_stats_count(struct ena_adapter *adapter)
 
 static int ena_get_hw_stats_count(struct ena_adapter *adapter)
 {
-	return ENA_STATS_ARRAY_ENI * ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENI_STATS) +
-	       ENA_STATS_ARRAY_ENA_SRD * ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENA_SRD_INFO);
+	struct ena_com_dev *dev = adapter->ena_dev;
+	int count;
+
+	count = ENA_STATS_ARRAY_ENA_SRD * ena_com_get_cap(dev, ENA_ADMIN_ENA_SRD_INFO);
+
+	if (ena_com_get_cap(dev, ENA_ADMIN_CUSTOMER_METRICS))
+		count += ena_com_get_customer_metric_count(dev);
+	else if (ena_com_get_cap(dev, ENA_ADMIN_ENI_STATS))
+		count += ENA_STATS_ARRAY_ENI;
+
+	return count;
 }
 
 int ena_get_sset_count(struct net_device *netdev, int sset)
@@ -283,6 +333,35 @@ int ena_get_sset_count(struct net_device *netdev, int sset)
 	return -EOPNOTSUPP;
 }
 
+static void ena_metrics_stats_strings(struct ena_adapter *adapter, u8 **data)
+{
+	struct ena_com_dev *dev = adapter->ena_dev;
+	const struct ena_hw_metrics *ena_metrics;
+	const struct ena_stats *ena_stats;
+	int i;
+
+	if (ena_com_get_cap(dev, ENA_ADMIN_CUSTOMER_METRICS)) {
+		for (i = 0; i < ENA_METRICS_ARRAY_ENI; i++) {
+			if (ena_com_get_customer_metric_support(dev, i)) {
+				ena_metrics = &ena_hw_stats_strings[i];
+				ethtool_puts(data, ena_metrics->name);
+			}
+		}
+	} else if (ena_com_get_cap(dev, ENA_ADMIN_ENI_STATS)) {
+		for (i = 0; i < ENA_STATS_ARRAY_ENI; i++) {
+			ena_stats = &ena_stats_eni_strings[i];
+			ethtool_puts(data, ena_stats->name);
+		}
+	}
+
+	if (ena_com_get_cap(dev, ENA_ADMIN_ENA_SRD_INFO)) {
+		for (i = 0; i < ENA_STATS_ARRAY_ENA_SRD; i++) {
+			ena_stats = &ena_srd_info_strings[i];
+			ethtool_puts(data, ena_stats->name);
+		}
+	}
+}
+
 static void ena_queue_strings(struct ena_adapter *adapter, u8 **data)
 {
 	const struct ena_stats *ena_stats;
@@ -338,20 +417,8 @@ static void ena_get_strings(struct ena_adapter *adapter,
 		ethtool_puts(&data, ena_stats->name);
 	}
 
-	if (hw_stats_needed) {
-		if (ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENI_STATS)) {
-			for (i = 0; i < ENA_STATS_ARRAY_ENI; i++) {
-				ena_stats = &ena_stats_eni_strings[i];
-				ethtool_puts(&data, ena_stats->name);
-			}
-		}
-		if (ena_com_get_cap(adapter->ena_dev, ENA_ADMIN_ENA_SRD_INFO)) {
-			for (i = 0; i < ENA_STATS_ARRAY_ENA_SRD; i++) {
-				ena_stats = &ena_srd_info_strings[i];
-				ethtool_puts(&data, ena_stats->name);
-			}
-		}
-	}
+	if (hw_stats_needed)
+		ena_metrics_stats_strings(adapter, &data);
 
 	ena_queue_strings(adapter, &data);
 	ena_com_dev_strings(&data);
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 0883c9a230f2..c5b50cfa935a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3931,10 +3931,16 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, adapter);
 
+	rc = ena_com_allocate_customer_metrics_buffer(ena_dev);
+	if (rc) {
+		netdev_err(netdev, "ena_com_allocate_customer_metrics_buffer failed\n");
+		goto err_netdev_destroy;
+	}
+
 	rc = ena_map_llq_mem_bar(pdev, ena_dev, bars);
 	if (rc) {
 		dev_err(&pdev->dev, "ENA LLQ bar mapping failed\n");
-		goto err_netdev_destroy;
+		goto err_metrics_destroy;
 	}
 
 	rc = ena_device_init(adapter, pdev, &get_feat_ctx, &wd_state);
@@ -3942,7 +3948,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(&pdev->dev, "ENA device init failed\n");
 		if (rc == -ETIME)
 			rc = -EPROBE_DEFER;
-		goto err_netdev_destroy;
+		goto err_metrics_destroy;
 	}
 
 	/* Initial TX and RX interrupt delay. Assumes 1 usec granularity.
@@ -4063,6 +4069,8 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+err_metrics_destroy:
+	ena_com_delete_customer_metrics_buffer(ena_dev);
 err_netdev_destroy:
 	free_netdev(netdev);
 err_free_region:
@@ -4126,6 +4134,8 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 
 	ena_com_delete_host_info(ena_dev);
 
+	ena_com_delete_customer_metrics_buffer(ena_dev);
+
 	ena_release_bars(ena_dev, pdev);
 
 	pci_disable_device(pdev);
-- 
2.40.1


