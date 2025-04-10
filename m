Return-Path: <netdev+bounces-181086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295EA83A70
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75868C3311
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9422046BF;
	Thu, 10 Apr 2025 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huFZfTt7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8DD204C3C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268978; cv=none; b=u/vxuatB7k0r4GiOY6en8K6Li8Rzq5d1V9QQD95fFUt4i0jY90sfswi21mYkqvH114+M3bmllBqersuCVgTnmxvntHEBPOThhurjs8ZZkK7Rzl2W9NaGTIWRitW0J3kWWzS3fVk5HtXoJc82DVwKwl7aKImTwc0JveeW/xeWv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268978; c=relaxed/simple;
	bh=9GMUF7pImvxqFvl08svPq8C6bS8tO6DYtxfWRztQdVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tt7aC+saN85H8SR/JC+9kg1GBo4sHFM5rVUDrWkNcT/RlzBgWhazNDeQC2rAakUfD85F4nZicq05kfgUwHEAwmhqyqU2pESznHdyWDXH2vX9gkHVo+DYf+OtsoLtxSKIKKUo7NXBt7aju02xIAoGSCL4dIVkWHMZ8scNHkDIgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huFZfTt7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso3164675e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268974; x=1744873774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G9ba1OytrE2JGvhMaAIXzjR+cA1mRYn7afZCz4Plgs=;
        b=huFZfTt7CYAVtKVFNJHW+EHl9wYsVLS2IfjOBPIZFWcNqlarsRIwheez2IDixA3Mr5
         ELOxDF545kMU85hNsFUlcrMVGz53JGyW8yybod1dC/KFioO0e05HQLxd1New3k/vX7uN
         T1eTkPrw6yJ2CFnJfRVxiP3bNgHm8R0eQJ9b5ktYx/QnvyF9S3Lh2yQmZggRW6lww85f
         LLxq5uejb1M572G6+HgKqZdwr0S1z0+HyYmnFBzYlqlhH3khRseEE0WipGa6HO4zMYJ7
         1w+NTAnNE9l5tUY43FhQbeu/vZqHTBRETK8eF5gmCbp9bJo/MisY7mneti8BiM33UlAp
         cHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268974; x=1744873774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G9ba1OytrE2JGvhMaAIXzjR+cA1mRYn7afZCz4Plgs=;
        b=IajfNvZyYjfWVjNzJxBNHpPf/xEibpmGuD8CcOyPjRvHN4iMR6fpJwHpOzsSkr6haa
         C7OcPK3ZBO38pV6bXOuwgW8lFHqtDxcoqEDECE/TYTj2LC6wf1N0pETc9kHLpy4QoWko
         i60ZlOWWQ/iJmrMudPBbPmAhod8UWlFKHMGo2qXGJRTSLIWxv9oMJcbGP6rmV+Wgoa3E
         BjDKdCKP8A61Wn+1GTWZCWxVWjfQAh7O4BkcTPOqB1t++wEdJmPk74yUpj/M/+PI8FDD
         rZPshSqQOkNSuN2ej97+R7PkgAXs/Nypxefv4Pk4CY1/kSL4daoO2AUkZNowk2VlVjk1
         TSqQ==
X-Gm-Message-State: AOJu0YxKjjAt+OFH1KuMJLHpFdIpAjRm8Io6/4tcdPTDBW4MDOE8T3BE
	zA8zPsyYzDh1kkulz5Q27vfdRHlz0GItsDXP+9Ca9IqHbKSsCtX9I7wx2orI
X-Gm-Gg: ASbGncu7WcYMfarEqiI2ebtUiGi2zu7l51w4zvJC5qb7+/ekweSlynMYLkp3w0lA8mj
	45aGg9mc49cRErwxJ4aNxVPGedLSQoHHVTJigRoyGfF69JMxsKAKI9U43hJ82AHa6K0e8nuFnUU
	XIQWxWeyMNU7OwprWg2xpiL3+n6as5oS/DnK41c6KeZUI7J9KE5gwhJirWS+IVeAzd7bTlAoN/q
	2m68wjP0Oc31A7NZtlR4hsnnsJ0yz2QzSTpZ/REKD7/2BDtzPruiP6CV4rzn0xhvYzTotFlHCwr
	a/J5rsJJnQyIkzYPrEdiSvnt15/v1pMcAFJlFTYgCtTvfwluEw==
X-Google-Smtp-Source: AGHT+IHAAZ8J8TkPeuwn7TsS4z1Hl0AOohE+/o/1sJAQ0bjNbg1NK0ojHhJ8ijyVCCWAdy8Y9zRR0Q==
X-Received: by 2002:a05:600c:1546:b0:43c:e2dd:98ea with SMTP id 5b1f17b1804b1-43f2d95990dmr14095085e9.22.1744268973935;
        Thu, 10 Apr 2025 00:09:33 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c7a68sm40611115e9.19.2025.04.10.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:09:33 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jdamato@fastly.com,
	kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	sanman.p211993@gmail.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next 2/5 V2] eth: fbnic: add coverage for hw queue stats
Date: Thu, 10 Apr 2025 00:08:56 -0700
Message-ID: <20250410070859.4160768-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
References: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides support for hardware queue stats and covers
packet errors for RX-DMA engine, RCQ drops and BDQ drops.

The packet errors are also aggregated with the `rx_errors` stats in the
`rtnl_link_stats` as well as with the `hw_drops` in the queue API.

The RCQ and BDQ drops are aggregated with `rx_over_errors` in the
`rtnl_link_stats` as well as with the `hw_drop_overruns` in the queue API.

ethtool -S eth0 | grep -E 'rde'
     rde_0_pkt_err: 0
     rde_0_pkt_cq_drop: 0
     rde_0_pkt_bdq_drop: 0
     ---
     ---
     rde_127_pkt_err: 0
     rde_127_pkt_cq_drop: 0
     rde_127_pkt_bdq_drop: 0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
V2: Add lock protection while reading the `fbd->hw_stats` to ensure
snapshot consistency.
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  9 +++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 12 ++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 55 ++++++++++++++++---
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 50 +++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  9 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 29 +++++++++-
 6 files changed, 156 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 04e0595bb0a7..bc7f2fef2875 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -44,6 +44,15 @@ RPC (Rx parser)
  - ``rpc_out_of_hdr_err``: frames where header was larger than parsable region
  - ``ovr_size_err``: oversized frames
 
+Hardware Queues
+~~~~~~~~~~~~~~~
+
+1. RX DMA Engine:
+
+ - ``rde_[i]_pkt_err``: packets with MAC EOP, RPC parser, RXB truncation, or RDE frame truncation errors. These error are flagged in the packet metadata because of cut-through support but the actual drop happens once PCIE/RDE is reached.
+ - ``rde_[i]_pkt_cq_drop``: packets dropped because RCQ is full
+ - ``rde_[i]_pkt_bdq_drop``: packets dropped because HPQ or PPQ ran out of host buffer
+
 PCIe
 ~~~~
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 3b12a0ab5906..ff5f68c7e73d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -864,6 +864,12 @@ enum {
 #define FBNIC_QUEUE_TWQ1_BAL		0x022		/* 0x088 */
 #define FBNIC_QUEUE_TWQ1_BAH		0x023		/* 0x08c */
 
+/* Tx Work Queue Statistics Registers */
+#define FBNIC_QUEUE_TWQ0_PKT_CNT	0x062		/* 0x188 */
+#define FBNIC_QUEUE_TWQ0_ERR_CNT	0x063		/* 0x18c */
+#define FBNIC_QUEUE_TWQ1_PKT_CNT	0x072		/* 0x1c8 */
+#define FBNIC_QUEUE_TWQ1_ERR_CNT	0x073		/* 0x1cc */
+
 /* Tx Completion Queue Registers */
 #define FBNIC_QUEUE_TCQ_CTL		0x080		/* 0x200 */
 #define FBNIC_QUEUE_TCQ_CTL_RESET		CSR_BIT(0)
@@ -953,6 +959,12 @@ enum {
 	FBNIC_QUEUE_RDE_CTL1_PAYLD_PACK_RSS	= 2,
 };
 
+/* Rx Per CQ Statistics Counters */
+#define FBNIC_QUEUE_RDE_PKT_CNT		0x2a2		/* 0xa88 */
+#define FBNIC_QUEUE_RDE_PKT_ERR_CNT	0x2a3		/* 0xa8c */
+#define FBNIC_QUEUE_RDE_CQ_DROP_CNT	0x2a4		/* 0xa90 */
+#define FBNIC_QUEUE_RDE_BDQ_DROP_CNT	0x2a5		/* 0xa94 */
+
 /* Rx Interrupt Manager Registers */
 #define FBNIC_QUEUE_RIM_CTL		0x2c0		/* 0xb00 */
 #define FBNIC_QUEUE_RIM_CTL_MSIX_MASK		CSR_GENMASK(7, 0)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 0a751a2aaf73..038e969f5ba3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -39,7 +39,20 @@ static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
 };
 
 #define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
-#define FBNIC_HW_STATS_LEN	FBNIC_HW_FIXED_STATS_LEN
+
+#define FBNIC_HW_Q_STAT(name, stat) \
+	FBNIC_STAT_FIELDS(fbnic_hw_q_stats, name, stat.value)
+
+static const struct fbnic_stat fbnic_gstrings_hw_q_stats[] = {
+	FBNIC_HW_Q_STAT("rde_%u_pkt_err", rde_pkt_err),
+	FBNIC_HW_Q_STAT("rde_%u_pkt_cq_drop", rde_pkt_cq_drop),
+	FBNIC_HW_Q_STAT("rde_%u_pkt_bdq_drop", rde_pkt_bdq_drop),
+};
+
+#define FBNIC_HW_Q_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_q_stats)
+#define FBNIC_HW_STATS_LEN \
+	(FBNIC_HW_FIXED_STATS_LEN + \
+	 FBNIC_HW_Q_STATS_LEN * FBNIC_MAX_QUEUES)
 
 static void
 fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
@@ -300,29 +313,57 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 
 static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 {
-	int i;
+	const struct fbnic_stat *stat;
+	int i, idx;
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
+		for (i = 0; i < FBNIC_HW_FIXED_STATS_LEN; i++)
 			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
+
+		for (idx = 0; idx < FBNIC_MAX_QUEUES; idx++) {
+			stat = fbnic_gstrings_hw_q_stats;
+
+			for (i = 0; i < FBNIC_HW_Q_STATS_LEN; i++, stat++)
+				ethtool_sprintf(&data, stat->string, idx);
+		}
 		break;
 	}
 }
 
+static void fbnic_report_hw_stats(const struct fbnic_stat *stat,
+				  const void *base, int len, u64 **data)
+{
+	while (len--) {
+		u8 *curr = (u8 *)base + stat->offset;
+
+		**data = *(u64 *)curr;
+
+		stat++;
+		(*data)++;
+	}
+}
+
 static void fbnic_get_ethtool_stats(struct net_device *dev,
 				    struct ethtool_stats *stats, u64 *data)
 {
 	struct fbnic_net *fbn = netdev_priv(dev);
-	const struct fbnic_stat *stat;
+	struct fbnic_dev *fbd = fbn->fbd;
 	int i;
 
 	fbnic_get_hw_stats(fbn->fbd);
 
-	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
-		stat = &fbnic_gstrings_hw_stats[i];
-		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
+	spin_lock(&fbd->hw_stats_lock);
+	fbnic_report_hw_stats(fbnic_gstrings_hw_stats, &fbd->hw_stats,
+			      FBNIC_HW_FIXED_STATS_LEN, &data);
+
+	for (i  = 0; i < FBNIC_MAX_QUEUES; i++) {
+		const struct fbnic_hw_q_stats *hw_q = &fbd->hw_stats.hw_q[i];
+
+		fbnic_report_hw_stats(fbnic_gstrings_hw_q_stats, hw_q,
+				      FBNIC_HW_Q_STATS_LEN, &data);
 	}
+	spin_unlock(&fbd->hw_stats_lock);
 }
 
 static int fbnic_get_sset_count(struct net_device *dev, int sset)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 957138cb841e..c8faedc2ec44 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -117,6 +117,54 @@ static void fbnic_get_rpc_stats32(struct fbnic_dev *fbd,
 			   &rpc->ovr_size_err);
 }
 
+static void fbnic_reset_hw_rxq_stats(struct fbnic_dev *fbd,
+				     struct fbnic_hw_q_stats *hw_q)
+{
+	int i;
+
+	for (i = 0; i < fbd->max_num_queues; i++, hw_q++) {
+		u32 base = FBNIC_QUEUE(i);
+
+		fbnic_hw_stat_rst32(fbd,
+				    base + FBNIC_QUEUE_RDE_PKT_ERR_CNT,
+				    &hw_q->rde_pkt_err);
+		fbnic_hw_stat_rst32(fbd,
+				    base + FBNIC_QUEUE_RDE_CQ_DROP_CNT,
+				    &hw_q->rde_pkt_cq_drop);
+		fbnic_hw_stat_rst32(fbd,
+				    base + FBNIC_QUEUE_RDE_BDQ_DROP_CNT,
+				    &hw_q->rde_pkt_bdq_drop);
+	}
+}
+
+static void fbnic_get_hw_rxq_stats32(struct fbnic_dev *fbd,
+				     struct fbnic_hw_q_stats *hw_q)
+{
+	int i;
+
+	for (i = 0; i < fbd->max_num_queues; i++, hw_q++) {
+		u32 base = FBNIC_QUEUE(i);
+
+		fbnic_hw_stat_rd32(fbd,
+				   base + FBNIC_QUEUE_RDE_PKT_ERR_CNT,
+				   &hw_q->rde_pkt_err);
+		fbnic_hw_stat_rd32(fbd,
+				   base + FBNIC_QUEUE_RDE_CQ_DROP_CNT,
+				   &hw_q->rde_pkt_cq_drop);
+		fbnic_hw_stat_rd32(fbd,
+				   base + FBNIC_QUEUE_RDE_BDQ_DROP_CNT,
+				   &hw_q->rde_pkt_bdq_drop);
+	}
+}
+
+void fbnic_get_hw_q_stats(struct fbnic_dev *fbd,
+			  struct fbnic_hw_q_stats *hw_q)
+{
+	spin_lock(&fbd->hw_stats_lock);
+	fbnic_get_hw_rxq_stats32(fbd, hw_q);
+	spin_unlock(&fbd->hw_stats_lock);
+}
+
 static void fbnic_reset_pcie_stats_asic(struct fbnic_dev *fbd,
 					struct fbnic_pcie_stats *pcie)
 {
@@ -205,6 +253,7 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
 	spin_lock(&fbd->hw_stats_lock);
 	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
+	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
 	spin_unlock(&fbd->hw_stats_lock);
 }
@@ -212,6 +261,7 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
 	fbnic_get_rpc_stats32(fbd, &fbd->hw_stats.rpc);
+	fbnic_get_hw_rxq_stats32(fbd, fbd->hw_stats.hw_q);
 }
 
 void fbnic_get_hw_stats32(struct fbnic_dev *fbd)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index 78df56b87745..81efa8dc8381 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -43,6 +43,12 @@ struct fbnic_rpc_stats {
 	struct fbnic_stat_counter tcp_opt_err, out_of_hdr_err, ovr_size_err;
 };
 
+struct fbnic_hw_q_stats {
+	struct fbnic_stat_counter rde_pkt_err;
+	struct fbnic_stat_counter rde_pkt_cq_drop;
+	struct fbnic_stat_counter rde_pkt_bdq_drop;
+};
+
 struct fbnic_pcie_stats {
 	struct fbnic_stat_counter ob_rd_tlp, ob_rd_dword;
 	struct fbnic_stat_counter ob_wr_tlp, ob_wr_dword;
@@ -56,12 +62,15 @@ struct fbnic_pcie_stats {
 struct fbnic_hw_stats {
 	struct fbnic_mac_stats mac;
 	struct fbnic_rpc_stats rpc;
+	struct fbnic_hw_q_stats hw_q[FBNIC_MAX_QUEUES];
 	struct fbnic_pcie_stats pcie;
 };
 
 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);
 
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd);
+void fbnic_get_hw_q_stats(struct fbnic_dev *fbd,
+			  struct fbnic_hw_q_stats *hw_q);
 void fbnic_get_hw_stats32(struct fbnic_dev *fbd);
 void fbnic_get_hw_stats(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 79a01fdd1dd1..e19284d4b91d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -403,11 +403,15 @@ static int fbnic_hwtstamp_set(struct net_device *netdev,
 static void fbnic_get_stats64(struct net_device *dev,
 			      struct rtnl_link_stats64 *stats64)
 {
+	u64 rx_bytes, rx_packets, rx_dropped = 0, rx_errors = 0;
 	u64 tx_bytes, tx_packets, tx_dropped = 0;
-	u64 rx_bytes, rx_packets, rx_dropped = 0;
 	struct fbnic_net *fbn = netdev_priv(dev);
+	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_queue_stats *stats;
 	unsigned int start, i;
+	u64 rx_over = 0;
+
+	fbnic_get_hw_stats(fbd);
 
 	stats = &fbn->tx_stats;
 
@@ -444,9 +448,22 @@ static void fbnic_get_stats64(struct net_device *dev,
 	rx_packets = stats->packets;
 	rx_dropped = stats->dropped;
 
+	spin_lock(&fbd->hw_stats_lock);
+	for (i = 0; i < fbd->max_num_queues; i++) {
+		/* Report packets dropped due to CQ/BDQ being full/empty */
+		rx_over += fbd->hw_stats.hw_q[i].rde_pkt_cq_drop.value;
+		rx_over += fbd->hw_stats.hw_q[i].rde_pkt_bdq_drop.value;
+
+		/* Report packets with errors */
+		rx_errors += fbd->hw_stats.hw_q[i].rde_pkt_err.value;
+	}
+	spin_unlock(&fbd->hw_stats_lock);
+
 	stats64->rx_bytes = rx_bytes;
 	stats64->rx_packets = rx_packets;
 	stats64->rx_dropped = rx_dropped;
+	stats64->rx_over_errors = rx_over;
+	stats64->rx_errors = rx_errors;
 
 	for (i = 0; i < fbn->num_rx_queues; i++) {
 		struct fbnic_ring *rxr = fbn->rx[i];
@@ -486,6 +503,7 @@ static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
 {
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_ring *rxr = fbn->rx[idx];
+	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_queue_stats *stats;
 	u64 bytes, packets, alloc_fail;
 	u64 csum_complete, csum_none;
@@ -509,6 +527,15 @@ static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
 	rx->alloc_fail = alloc_fail;
 	rx->csum_complete = csum_complete;
 	rx->csum_none = csum_none;
+
+	fbnic_get_hw_q_stats(fbd, fbd->hw_stats.hw_q);
+
+	spin_lock(&fbd->hw_stats_lock);
+	rx->hw_drop_overruns = fbd->hw_stats.hw_q[idx].rde_pkt_cq_drop.value +
+			       fbd->hw_stats.hw_q[idx].rde_pkt_bdq_drop.value;
+	rx->hw_drops = fbd->hw_stats.hw_q[idx].rde_pkt_err.value +
+		       rx->hw_drop_overruns;
+	spin_unlock(&fbd->hw_stats_lock);
 }
 
 static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
-- 
2.47.1


