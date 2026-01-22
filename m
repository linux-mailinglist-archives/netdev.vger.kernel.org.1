Return-Path: <netdev+bounces-252511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNHoE8N5cmlSlQAAu9opvQ
	(envelope-from <netdev+bounces-252511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:25:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAB6CFE1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FD93300B454
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD51938B9A6;
	Thu, 22 Jan 2026 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKi1NJia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B310388875
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109951; cv=none; b=hZYY7Td7wYrKdkgcdbJkfxej8YLLS4pMoiR8e8lFjqLwvE/sTj2E9AfgtHhXg/zYGBUuQ74FQJt+/xk7VSXL57xBzQd7DrKIwnp4fF7KqMri+M/8f+SaPEtskADFtvOHRD+hK6Hz0Vh3fFVIBc20z3xPSgthsA/Tfh9Ep1hMAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109951; c=relaxed/simple;
	bh=jdgMcKVdSB39G4/lNBHFNetOkjR/zR601eO0BRbqET0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmKaITRj/7WYMZ/4Ad2VmPKIDgE2Yy3jjuN/3twqaxS7aGRXe0Y/xOZE9hpUrZ0ERrk41ijN6gh1WoEL00Pok0CdptLtln6x2anVU5fd5TcWEr8LDm7OwNMD6gFmsJXvzFnVr+g/40rqfR0FikLrApzfA+mVdpB6QN+Vy1QlDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKi1NJia; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-823081bb15fso655181b3a.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769109936; x=1769714736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg5uIQs2aqLLWSbVn9bFSM/HstapWJsX7MAzjUFagsQ=;
        b=gKi1NJiayPamZwYGHdnskX/JpQbPgb0NyuWsiiJmoQ5UNWGNiPG/+VAvBp6xNnRgy+
         yBKTVZq4scUPCDhtG6wzZt9V+n39lfc0LOhSKwgYCHiMQlgIAQY+cXcSXwmawFA4oJRU
         Ky3TTUqgtRF5oAKhiC5qYdZ6AKtSggJlitPY6pLljrRFcnk2unHCBP5j+uupy3ORIprz
         OAk9bHMXQ//xXbbb7ca6Qzc/vOG9C+c+HLFtvAu+OcnXFJQINYHIWaq82TJLzWGQJ2JA
         XNZoAOEq7MQg7+fks8UGAz7Ri2718acDSY8RNqcM/KTTeUC9TvMvMBh8kA5V8hv2nXmk
         NtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109936; x=1769714736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg5uIQs2aqLLWSbVn9bFSM/HstapWJsX7MAzjUFagsQ=;
        b=MYmZ73hHTJDbYXZfiYkvg20V5f2eTPWPjIgcWfLfRbHd1Yvbik3V206OoGqjX29Cpq
         gpjCxKhn4+Ply8tfjlP3Hjc7evzLeohzZffwGRCcQcyUQi79ppTdTUnjfxs6o8QUAA5I
         j+mRAFs3Uv21HRR0uzVIHx9xdjs05275oujk7sIdn9Px3NMyud3o6SkaIRcGgdkXjkNv
         BEcO01wcd6R5fPFWZYxLk54BAMNj8ETzI3hQnzZVvvG3bWekhTd4CKeQMQ5uFJ7WvtRo
         IIEjCf1rVh646M+SmSwCpEbCJzroWd3Rek4+Lf0WdqAE/5iBNs87beJn+hqZNTb8fKaH
         SK8A==
X-Gm-Message-State: AOJu0YzhPCxTrNH4BhrpsNF1qL8jIO4FVSSFRX3nu9VrKrygUYS7GFMF
	uzhw5+pBTKDwlZtDevnfxR+X8cT+pTnsk5GXXCM8/VRh6B/exluVl6N0J1uOgA==
X-Gm-Gg: AZuq6aIiFDinNXqE5yuoK6Toa2klhFan0OmlAcK8NMM+T9eVFtSDW12Cs2oHsjunj1I
	xwtA9bSFklUlg64Qq9p3glSeXeBiCMnFj+T5YZBS6O6TrBM5xYT3TVvwfvbTc3opU9ttbt3bCjz
	Xk3Oc/1dZ3buaQh4xGcQ7Qis/vZnaO4DOeXITZPheqwHToKuVV8oNHe6FVvfZatDC/uEf/u6L/P
	5iQSZpLRN0yzhTExa4p3nehGT6NIoxBXB0YTZhMaxgm5nMzExbU3UimTZ3VLt8ardwun2BTyv9o
	iKXiZf04OBpBVgVYYIfZ8qDQ82Q7WZr74Y1YqOtUHQbIuPMHPWjyCpRbg7NzsCzRQyBz3sZIc1K
	fHXGk1ZW1BZPiG9uX/Wp8jqNutazD68s7M+WBmpD9dva2hvfgo+q2sWZrBGpULAXhOjb9cuRzNg
	MmSbEq2+Un0MLpJiz1FjNkujSJW0nOevH+lyPAErp6uhkD9O7U16B0nA==
X-Received: by 2002:a05:6a00:3cd6:b0:823:8a5:297f with SMTP id d2e1a72fcca58-82317da469cmr337717b3a.16.1769109936001;
        Thu, 22 Jan 2026 11:25:36 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873ec59sm136239b3a.53.2026.01.22.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:25:35 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Amit Bernstein <amitbern@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Breno Leitao <leitao@debian.org>,
	Kohei Enju <enjuk@amazon.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC net-next] net: ena: Use u64_stats_t with u64_stats_sync properly
Date: Fri, 23 Jan 2026 03:24:49 +0800
Message-ID: <20260122192513.2771569-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,amazon.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,debian.org,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-252511-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEBAB6CFE1
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
RFC Comment:

The write side of u64_stats should ensure mutual exclusion, however I couldn't
find the synchronization mechanism in use (for example, ena_up / ena_io_poll /
ena_start_xmit). Should this be considered an issue?
 .../net/ethernet/amazon/ena/ena_admin_defs.h  | 18 ++--
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 27 +++---
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 50 ++++++----
 drivers/net/ethernet/amazon/ena/ena_netdev.h  | 92 +++++++++----------
 drivers/net/ethernet/amazon/ena/ena_xdp.c     |  2 +-
 drivers/net/ethernet/amazon/ena/ena_xdp.h     |  2 +-
 6 files changed, 101 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 898ecd96b96a..d8a494e44f3b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -440,42 +440,42 @@ struct ena_admin_eni_stats {
 	/* The number of packets shaped due to inbound aggregate BW
 	 * allowance being exceeded
 	 */
-	u64 bw_in_allowance_exceeded;
+	u64_stats_t bw_in_allowance_exceeded;
 
 	/* The number of packets shaped due to outbound aggregate BW
 	 * allowance being exceeded
 	 */
-	u64 bw_out_allowance_exceeded;
+	u64_stats_t bw_out_allowance_exceeded;
 
 	/* The number of packets shaped due to PPS allowance being exceeded */
-	u64 pps_allowance_exceeded;
+	u64_stats_t pps_allowance_exceeded;
 
 	/* The number of packets shaped due to connection tracking
 	 * allowance being exceeded and leading to failure in establishment
 	 * of new connections
 	 */
-	u64 conntrack_allowance_exceeded;
+	u64_stats_t conntrack_allowance_exceeded;
 
 	/* The number of packets shaped due to linklocal packet rate
 	 * allowance being exceeded
 	 */
-	u64 linklocal_allowance_exceeded;
+	u64_stats_t linklocal_allowance_exceeded;
 };
 
 struct ena_admin_ena_srd_stats {
 	/* Number of packets transmitted over ENA SRD */
-	u64 ena_srd_tx_pkts;
+	u64_stats_t ena_srd_tx_pkts;
 
 	/* Number of packets transmitted or could have been
 	 * transmitted over ENA SRD
 	 */
-	u64 ena_srd_eligible_tx_pkts;
+	u64_stats_t ena_srd_eligible_tx_pkts;
 
 	/* Number of packets received over ENA SRD */
-	u64 ena_srd_rx_pkts;
+	u64_stats_t ena_srd_rx_pkts;
 
 	/* Percentage of the ENA SRD resources that is in use */
-	u64 ena_srd_resource_utilization;
+	u64_stats_t ena_srd_resource_utilization;
 };
 
 /* ENA SRD Statistics Command */
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 2455d6dddc26..ff26b99bfc2f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -27,12 +27,12 @@ struct ena_hw_metrics {
 
 #define ENA_STAT_ENTRY(stat, stat_type) { \
 	.name = #stat, \
-	.stat_offset = offsetof(struct ena_stats_##stat_type, stat) / sizeof(u64) \
+	.stat_offset = offsetof(struct ena_stats_##stat_type, stat) / sizeof(u64_stats_t) \
 }
 
 #define ENA_STAT_HW_ENTRY(stat, stat_type) { \
 	.name = #stat, \
-	.stat_offset = offsetof(struct ena_admin_##stat_type, stat) / sizeof(u64) \
+	.stat_offset = offsetof(struct ena_admin_##stat_type, stat) / sizeof(u64_stats_t) \
 }
 
 #define ENA_STAT_RX_ENTRY(stat) \
@@ -154,14 +154,14 @@ static const struct ena_stats ena_stats_ena_com_strings[] = {
 #define ENA_STATS_ARRAY_ENA_SRD		ARRAY_SIZE(ena_srd_info_strings)
 #define ENA_METRICS_ARRAY_ENI		ARRAY_SIZE(ena_hw_stats_strings)
 
-static void ena_safe_update_stat(u64 *src, u64 *dst,
+static void ena_safe_update_stat(u64_stats_t *src, u64 *dst,
 				 struct u64_stats_sync *syncp)
 {
 	unsigned int start;
 
 	do {
 		start = u64_stats_fetch_begin(syncp);
-		*(dst) = *src;
+		*dst = u64_stats_read(src);
 	} while (u64_stats_fetch_retry(syncp, start));
 }
 
@@ -169,7 +169,7 @@ static void ena_metrics_stats(struct ena_adapter *adapter, u64 **data)
 {
 	struct ena_com_dev *dev = adapter->ena_dev;
 	const struct ena_stats *ena_stats;
-	u64 *ptr;
+	u64_stats_t *ptr;
 	int i;
 
 	if (ena_com_get_cap(dev, ENA_ADMIN_CUSTOMER_METRICS)) {
@@ -191,7 +191,7 @@ static void ena_metrics_stats(struct ena_adapter *adapter, u64 **data)
 		for (i = 0; i < ENA_STATS_ARRAY_ENI; i++) {
 			ena_stats = &ena_stats_eni_strings[i];
 
-			ptr = (u64 *)&adapter->eni_stats +
+			ptr = (u64_stats_t *)&adapter->eni_stats +
 				ena_stats->stat_offset;
 
 			ena_safe_update_stat(ptr, (*data)++, &adapter->syncp);
@@ -201,14 +201,14 @@ static void ena_metrics_stats(struct ena_adapter *adapter, u64 **data)
 	if (ena_com_get_cap(dev, ENA_ADMIN_ENA_SRD_INFO)) {
 		ena_com_get_ena_srd_info(dev, &adapter->ena_srd_info);
 		/* Get ENA SRD mode */
-		ptr = (u64 *)&adapter->ena_srd_info;
+		ptr = (u64_stats_t *)&adapter->ena_srd_info;
 		ena_safe_update_stat(ptr, (*data)++, &adapter->syncp);
 		for (i = 1; i < ENA_STATS_ARRAY_ENA_SRD; i++) {
 			ena_stats = &ena_srd_info_strings[i];
 			/* Wrapped within an outer struct - need to accommodate an
 			 * additional offset of the ENA SRD mode that was already processed
 			 */
-			ptr = (u64 *)&adapter->ena_srd_info +
+			ptr = (u64_stats_t *)&adapter->ena_srd_info +
 				ena_stats->stat_offset + 1;
 
 			ena_safe_update_stat(ptr, (*data)++, &adapter->syncp);
@@ -221,7 +221,7 @@ static void ena_queue_stats(struct ena_adapter *adapter, u64 **data)
 	const struct ena_stats *ena_stats;
 	struct ena_ring *ring;
 
-	u64 *ptr;
+	u64_stats_t *ptr;
 	int i, j;
 
 	for (i = 0; i < adapter->num_io_queues + adapter->xdp_num_queues; i++) {
@@ -231,7 +231,8 @@ static void ena_queue_stats(struct ena_adapter *adapter, u64 **data)
 		for (j = 0; j < ENA_STATS_ARRAY_TX; j++) {
 			ena_stats = &ena_stats_tx_strings[j];
 
-			ptr = (u64 *)&ring->tx_stats + ena_stats->stat_offset;
+			ptr = (u64_stats_t *)&ring->tx_stats +
+				ena_stats->stat_offset;
 
 			ena_safe_update_stat(ptr, (*data)++, &ring->syncp);
 		}
@@ -243,7 +244,7 @@ static void ena_queue_stats(struct ena_adapter *adapter, u64 **data)
 			for (j = 0; j < ENA_STATS_ARRAY_RX; j++) {
 				ena_stats = &ena_stats_rx_strings[j];
 
-				ptr = (u64 *)&ring->rx_stats +
+				ptr = (u64_stats_t *)&ring->rx_stats +
 					ena_stats->stat_offset;
 
 				ena_safe_update_stat(ptr, (*data)++, &ring->syncp);
@@ -273,13 +274,13 @@ static void ena_get_stats(struct ena_adapter *adapter,
 			  bool hw_stats_needed)
 {
 	const struct ena_stats *ena_stats;
-	u64 *ptr;
+	u64_stats_t *ptr;
 	int i;
 
 	for (i = 0; i < ENA_STATS_ARRAY_GLOBAL; i++) {
 		ena_stats = &ena_stats_global_strings[i];
 
-		ptr = (u64 *)&adapter->dev_stats + ena_stats->stat_offset;
+		ptr = (u64_stats_t *)&adapter->dev_stats + ena_stats->stat_offset;
 
 		ena_safe_update_stat(ptr, data++, &adapter->syncp);
 	}
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 92d149d4f091..5f1ec7008c48 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -149,8 +149,8 @@ int ena_xmit_common(struct ena_adapter *adapter,
 	}
 
 	u64_stats_update_begin(&ring->syncp);
-	ring->tx_stats.cnt++;
-	ring->tx_stats.bytes += bytes;
+	u64_stats_inc(&ring->tx_stats.cnt);
+	u64_stats_add(&ring->tx_stats.bytes, bytes);
 	u64_stats_update_end(&ring->syncp);
 
 	tx_info->tx_descs = nb_hw_desc;
@@ -1294,9 +1294,9 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	work_done = budget - res_budget;
 	rx_ring->per_napi_packets += work_done;
 	u64_stats_update_begin(&rx_ring->syncp);
-	rx_ring->rx_stats.bytes += total_len;
-	rx_ring->rx_stats.cnt += work_done;
-	rx_ring->rx_stats.rx_copybreak_pkt += rx_copybreak_pkt;
+	u64_stats_add(&rx_ring->rx_stats.bytes, total_len);
+	u64_stats_add(&rx_ring->rx_stats.cnt, work_done);
+	u64_stats_add(&rx_ring->rx_stats.rx_copybreak_pkt, rx_copybreak_pkt);
 	u64_stats_update_end(&rx_ring->syncp);
 
 	rx_ring->next_to_clean = next_to_clean;
@@ -1349,15 +1349,21 @@ static void ena_adjust_adaptive_rx_intr_moderation(struct ena_napi *ena_napi)
 {
 	struct dim_sample dim_sample;
 	struct ena_ring *rx_ring = ena_napi->rx_ring;
+	u64 packets, bytes;
+	unsigned int start;
 
 	if (!rx_ring->per_napi_packets)
 		return;
 
 	rx_ring->non_empty_napi_events++;
 
-	dim_update_sample(rx_ring->non_empty_napi_events,
-			  rx_ring->rx_stats.cnt,
-			  rx_ring->rx_stats.bytes,
+	do {
+		start = u64_stats_fetch_begin(&rx_ring->syncp);
+		packets = u64_stats_read(&rx_ring->rx_stats.cnt);
+		bytes = u64_stats_read(&rx_ring->rx_stats.bytes);
+	} while (u64_stats_fetch_retry(&rx_ring->syncp, start));
+
+	dim_update_sample(rx_ring->non_empty_napi_events, packets, bytes,
 			  &dim_sample);
 
 	net_dim(&ena_napi->dim, &dim_sample);
@@ -1496,8 +1502,8 @@ static int ena_io_poll(struct napi_struct *napi, int budget)
 	}
 
 	u64_stats_update_begin(&tx_ring->syncp);
-	tx_ring->tx_stats.napi_comp += napi_comp_call;
-	tx_ring->tx_stats.tx_poll++;
+	u64_stats_add(&tx_ring->tx_stats.napi_comp, napi_comp_call);
+	u64_stats_inc(&tx_ring->tx_stats.tx_poll);
 	u64_stats_update_end(&tx_ring->syncp);
 
 	tx_ring->tx_stats.last_napi_jiffies = jiffies;
@@ -2824,8 +2830,8 @@ static void ena_get_stats64(struct net_device *netdev,
 
 		do {
 			start = u64_stats_fetch_begin(&tx_ring->syncp);
-			packets = tx_ring->tx_stats.cnt;
-			bytes = tx_ring->tx_stats.bytes;
+			packets = u64_stats_read(&tx_ring->tx_stats.cnt);
+			bytes = u64_stats_read(&tx_ring->tx_stats.bytes);
 		} while (u64_stats_fetch_retry(&tx_ring->syncp, start));
 
 		stats->tx_packets += packets;
@@ -2839,9 +2845,9 @@ static void ena_get_stats64(struct net_device *netdev,
 
 		do {
 			start = u64_stats_fetch_begin(&rx_ring->syncp);
-			packets = rx_ring->rx_stats.cnt;
-			bytes = rx_ring->rx_stats.bytes;
-			xdp_rx_drops = rx_ring->rx_stats.xdp_drop;
+			packets = u64_stats_read(&rx_ring->rx_stats.cnt);
+			bytes = u64_stats_read(&rx_ring->rx_stats.bytes);
+			xdp_rx_drops = u64_stats_read(&rx_ring->rx_stats.xdp_drop);
 		} while (u64_stats_fetch_retry(&rx_ring->syncp, start));
 
 		stats->rx_packets += packets;
@@ -2851,8 +2857,8 @@ static void ena_get_stats64(struct net_device *netdev,
 
 	do {
 		start = u64_stats_fetch_begin(&adapter->syncp);
-		rx_drops = adapter->dev_stats.rx_drops;
-		tx_drops = adapter->dev_stats.tx_drops;
+		rx_drops = u64_stats_read(&adapter->dev_stats.rx_drops);
+		tx_drops = u64_stats_read(&adapter->dev_stats.tx_drops);
 	} while (u64_stats_fetch_retry(&adapter->syncp, start));
 
 	stats->rx_dropped = rx_drops + total_xdp_rx_drops;
@@ -3380,7 +3386,11 @@ static void ena_fw_reset_device(struct work_struct *work)
 	if (likely(test_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags))) {
 		rc |= ena_destroy_device(adapter, false);
 		rc |= ena_restore_device(adapter);
-		adapter->dev_stats.reset_fail += !!rc;
+		if (rc) {
+			u64_stats_update_begin(&adapter->syncp);
+			u64_stats_inc(&adapter->dev_stats.reset_fail);
+			u64_stats_update_end(&adapter->syncp);
+		}
 
 		dev_err(&adapter->pdev->dev, "Device reset completed successfully\n");
 	}
@@ -4329,8 +4339,8 @@ static void ena_keep_alive_wd(void *adapter_data,
 	/* These stats are accumulated by the device, so the counters indicate
 	 * all drops since last reset.
 	 */
-	adapter->dev_stats.rx_drops = rx_drops;
-	adapter->dev_stats.tx_drops = tx_drops;
+	u64_stats_set(&adapter->dev_stats.rx_drops, rx_drops);
+	u64_stats_set(&adapter->dev_stats.tx_drops, tx_drops);
 	u64_stats_update_end(&adapter->syncp);
 }
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 006f9a3acea6..bf2e7c74d3eb 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -178,44 +178,44 @@ struct ena_rx_buffer {
 } ____cacheline_aligned;
 
 struct ena_stats_tx {
-	u64 cnt;
-	u64 bytes;
-	u64 queue_stop;
-	u64 prepare_ctx_err;
-	u64 queue_wakeup;
-	u64 dma_mapping_err;
-	u64 linearize;
-	u64 linearize_failed;
-	u64 napi_comp;
-	u64 tx_poll;
-	u64 doorbells;
-	u64 bad_req_id;
-	u64 llq_buffer_copy;
-	u64 missed_tx;
-	u64 unmask_interrupt;
+	u64_stats_t cnt;
+	u64_stats_t bytes;
+	u64_stats_t queue_stop;
+	u64_stats_t prepare_ctx_err;
+	u64_stats_t queue_wakeup;
+	u64_stats_t dma_mapping_err;
+	u64_stats_t linearize;
+	u64_stats_t linearize_failed;
+	u64_stats_t napi_comp;
+	u64_stats_t tx_poll;
+	u64_stats_t doorbells;
+	u64_stats_t bad_req_id;
+	u64_stats_t llq_buffer_copy;
+	u64_stats_t missed_tx;
+	u64_stats_t unmask_interrupt;
 	u64 last_napi_jiffies;
 };
 
 struct ena_stats_rx {
-	u64 cnt;
-	u64 bytes;
-	u64 rx_copybreak_pkt;
-	u64 csum_good;
-	u64 refil_partial;
-	u64 csum_bad;
-	u64 page_alloc_fail;
-	u64 skb_alloc_fail;
-	u64 dma_mapping_err;
-	u64 bad_desc_num;
-	u64 bad_req_id;
-	u64 empty_rx_ring;
-	u64 csum_unchecked;
-	u64 xdp_aborted;
-	u64 xdp_drop;
-	u64 xdp_pass;
-	u64 xdp_tx;
-	u64 xdp_invalid;
-	u64 xdp_redirect;
+	u64_stats_t cnt;
+	u64_stats_t bytes;
+	u64_stats_t rx_copybreak_pkt;
+	u64_stats_t csum_good;
+	u64_stats_t refil_partial;
+	u64_stats_t csum_bad;
+	u64_stats_t page_alloc_fail;
+	u64_stats_t skb_alloc_fail;
+	u64_stats_t dma_mapping_err;
+	u64_stats_t bad_desc_num;
+	u64_stats_t bad_req_id;
+	u64_stats_t empty_rx_ring;
+	u64_stats_t csum_unchecked;
+	u64_stats_t xdp_aborted;
+	u64_stats_t xdp_drop;
+	u64_stats_t xdp_pass;
+	u64_stats_t xdp_tx;
+	u64_stats_t xdp_invalid;
+	u64_stats_t xdp_redirect;
 };
 
 struct ena_ring {
@@ -284,16 +284,16 @@ struct ena_ring {
 } ____cacheline_aligned;
 
 struct ena_stats_dev {
-	u64 tx_timeout;
-	u64 suspend;
-	u64 resume;
-	u64 wd_expired;
-	u64 interface_up;
-	u64 interface_down;
-	u64 admin_q_pause;
-	u64 rx_drops;
-	u64 tx_drops;
-	u64 reset_fail;
+	u64_stats_t tx_timeout;
+	u64_stats_t suspend;
+	u64_stats_t resume;
+	u64_stats_t wd_expired;
+	u64_stats_t interface_up;
+	u64_stats_t interface_down;
+	u64_stats_t admin_q_pause;
+	u64_stats_t rx_drops;
+	u64_stats_t tx_drops;
+	u64_stats_t reset_fail;
 };
 
 enum ena_flags_t {
@@ -430,11 +430,11 @@ int handle_invalid_req_id(struct ena_ring *ring, u16 req_id,
 			  struct ena_tx_buffer *tx_info, bool is_xdp);
 
 /* Increase a stat by cnt while holding syncp seqlock on 32bit machines */
-static inline void ena_increase_stat(u64 *statp, u64 cnt,
+static inline void ena_increase_stat(u64_stats_t *statp, u64 cnt,
 				     struct u64_stats_sync *syncp)
 {
 	u64_stats_update_begin(syncp);
-	(*statp) += cnt;
+	u64_stats_add(statp, cnt);
 	u64_stats_update_end(syncp);
 }
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index 5b175e7e92a1..9271d1deb96f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -461,7 +461,7 @@ int ena_xdp_io_poll(struct napi_struct *napi, int budget)
 	}
 
 	u64_stats_update_begin(&tx_ring->syncp);
-	tx_ring->tx_stats.tx_poll++;
+	u64_stats_inc(&tx_ring->tx_stats.tx_poll);
 	u64_stats_update_end(&tx_ring->syncp);
 	tx_ring->tx_stats.last_napi_jiffies = jiffies;
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.h b/drivers/net/ethernet/amazon/ena/ena_xdp.h
index cfd82728486a..98756a065a39 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.h
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.h
@@ -85,7 +85,7 @@ static inline int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp
 	struct bpf_prog *xdp_prog;
 	struct ena_ring *xdp_ring;
 	struct xdp_frame *xdpf;
-	u64 *xdp_stat;
+	u64_stats_t *xdp_stat;
 
 	xdp_prog = READ_ONCE(rx_ring->xdp_bpf_prog);
 
-- 
2.51.0


