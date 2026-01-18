Return-Path: <netdev+bounces-250836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C4D394C6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B9E73006471
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E532AAB7;
	Sun, 18 Jan 2026 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8TQsg4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78132AAD3
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768738195; cv=none; b=XoykbgFPo+fJlletqQdYn7n/uCsAFaG3AFF2/JbMwpP0qn3uDZv3h/5f0LFBMD0ejysXVvRUy3CmZT7YzqvmmK8ARBacb3iOWcBDubxxz9hJohqcpA7OI2JmdIR1B72Jm+teCHhSHvHfx6y1litKM4imKzYFRpz0DPt8M+GkDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768738195; c=relaxed/simple;
	bh=jK+yNcICvqRbyZARz0kLdDh52epc3bF2uuFBDeCxs4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQc1YKnxUjJfcMZLFIhH3mawRiowBrtYMzwRDrCg6MSVIKcLSAeBbP5nRZ6hBe/d1n4IHxkimiQC+SB1sPE/M51L11iCtCg2RznJMDEnsslgIljF57C5QE+hV6ZZl41PKVRukewf5M31oAvvFBKTOdbMVf50Gmk8EB2uHXSffM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8TQsg4Q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so18504665e9.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768738190; x=1769342990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0XcKTBhlolXc9R2eXbUHncEF8lj7/Mk75nDsnHNmv0=;
        b=X8TQsg4Q5vFIIJUDRGhIajcQopx0WEBTIg+w/YU78W/UVtDLmolttwvY6ObeLuCYCG
         gLYyrPYml+2BwLqZT40FQdJQJBcL4UE6ji8Idu2mVe0PSlDQ+T7CF+1Ba6YsstyS2koA
         KX5pEukMsOiybQopMqNZUojb5DDe7uha2N+x7zXbhkspdCmXl9nOen4oh9De5eTcyaeO
         Z+tWAsBvzQhXaeUXBqtWgz+ACD6/+zpMB/LSe19ykKHjIUmqyXc1a8jmVoj4cejsEiVG
         2f0ErgBEWjQsqv5drXkQAAOF7JVm32nyHYcQ7349hiQ9RojP8rFg9H/b/fX7GgCGePJj
         MoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768738190; x=1769342990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0XcKTBhlolXc9R2eXbUHncEF8lj7/Mk75nDsnHNmv0=;
        b=aFDEtAxngKIjdcHEfQspfAAjDe8rxvAkhXgom5dNQfePLjfD/rGWS0tO2oV2XXtso8
         OM4b7K/AGGgVyCyOXZjrfQUxVWN7qiMi9s4HFEot1SD0GhCft3BbNbJdU44rrClS6iD4
         MxVOOHgPswbwNRKQUFQxGdD0932JbGsxMN8nOgXugu3wXhNMedujiqlI7bEJurJ+hQt/
         MOebI1VRokai66tSAAnoa2klgjPS8ADpxiaGAc4ky6sZb4aLTBtxQn+WIeBiOH/CuBo5
         swSdHO4w7CuTFQ1sx/RNGTHG5YH3WdO/6cvT4wzuTxqE1vz+pfsPUIizlrgsGpB5m2vm
         3n7w==
X-Gm-Message-State: AOJu0YzEcII/1Gpafd8Qz8CwJXjJ3u/3MQcUxoDsJNgcSR0QFHUtller
	EB+Sm3zNq2Xa3G+r70Eludt2v9DwVYaXZ3XP2ihf8Ik/jdrO2a05CzlTETdk+8I+wNM=
X-Gm-Gg: AY/fxX7SmyQmxGUShe2erPO54m8iNiYJoy4sG3d7DVNTD6B3SO6ypcDHMiBhj1h3+bz
	ICZS7xRzn+v6UMZ1qBWEcsw3IlRDM9yIT1pkyaVfXRxz5wLFSm0txSNDqGv5BoVp6Cs0xOKgQkw
	JB+gKPYjD/2AW0UtEPxqwVjhKMSP9E0qQmNkjmqJrqg1ZGVyAJ6UNdlQi8NLdT7g8hZzTRyYJFv
	8omNjoTF9N3YC52FRfkmpmY2qMAMhXWALucnpTT/0ULY0mEyyIsxEYYe0BfBJv3mg3TEy3cz7nd
	ak9hxZ7BMWBsgZDR+2LmDCFbDuWbsTxP0PiYEwd3N+YRKU049pyWR7YD3hIn+zopUtKSJAxYYNg
	jdFhyegZ709+M/7Y6kk40D1ttngJtFQkozb/qf8auoiPsXF0cig5gdipuf0CONKPHAikm+/I3sr
	D+TqQ67/UQndWc7M9h/Yngw3Y0
X-Received: by 2002:a05:600c:4586:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-4801e2a50e4mr100543305e9.0.1768738189976;
        Sun, 18 Jan 2026 04:09:49 -0800 (PST)
Received: from Arch-Spectre.dur.ac.uk ([129.234.0.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e886829sm138661265e9.8.2026.01.18.04.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:09:49 -0800 (PST)
From: Yicong Hui <yiconghui@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH net-next v2 1/3] net/benet: Fix typos in driver code comments
Date: Sun, 18 Jan 2026 12:09:59 +0000
Message-ID: <20260118121001.136806-2-yiconghui@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118121001.136806-1-yiconghui@gmail.com>
References: <20260118121001.136806-1-yiconghui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various typos and misspellings in code comments in the
drivers/net/ethernet/emulex directory

Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/net/ethernet/emulex/benet/be.h         |  8 ++++----
 drivers/net/ethernet/emulex/benet/be_cmds.c    |  6 +++---
 drivers/net/ethernet/emulex/benet/be_cmds.h    |  6 +++---
 drivers/net/ethernet/emulex/benet/be_ethtool.c |  6 +++---
 drivers/net/ethernet/emulex/benet/be_hw.h      |  6 +++---
 drivers/net/ethernet/emulex/benet/be_main.c    | 16 ++++++++--------
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index 270ff9aab335..d2623e35de43 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -672,7 +672,7 @@ struct be_adapter {
 	struct be_error_recovery error_recovery;
 };
 
-/* Used for defered FW config cmds. Add fields to this struct as reqd */
+/* Used for deferred FW config cmds. Add fields to this struct as reqd */
 struct be_cmd_work {
 	struct work_struct work;
 	struct be_adapter *adapter;
@@ -700,19 +700,19 @@ struct be_cmd_work {
 #define be_max_rxqs(adapter)		(adapter->res.max_rx_qs)
 /* Max number of EQs available for the function (NIC + RoCE (if enabled)) */
 #define be_max_func_eqs(adapter)	(adapter->res.max_evt_qs)
-/* Max number of EQs available avaialble only for NIC */
+/* Max number of EQs available only for NIC */
 #define be_max_nic_eqs(adapter)		(adapter->res.max_nic_evt_qs)
 #define be_if_cap_flags(adapter)	(adapter->res.if_cap_flags)
 #define be_max_pf_pool_rss_tables(adapter)	\
 				(adapter->pool_res.max_rss_tables)
-/* Max irqs avaialble for NIC */
+/* Max irqs available for NIC */
 #define be_max_irqs(adapter)		\
 			(min_t(u16, be_max_nic_eqs(adapter), num_online_cpus()))
 
 /* Max irqs *needed* for RX queues */
 static inline u16 be_max_rx_irqs(struct be_adapter *adapter)
 {
-	/* If no RSS, need atleast one irq for def-RXQ */
+	/* If no RSS, need at least one irq for def-RXQ */
 	u16 num = max_t(u16, be_max_rss(adapter), 1);
 
 	return min_t(u16, num, be_max_irqs(adapter));
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index bb5d2fa15736..3a032d4ac598 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -1941,7 +1941,7 @@ int be_cmd_modify_eqd(struct be_adapter *adapter, struct be_set_eqd *set_eqd,
 	return 0;
 }
 
-/* Uses sycnhronous mcc */
+/* Uses synchronous mcc */
 int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 		       u32 num, u32 domain)
 {
@@ -2035,7 +2035,7 @@ int be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 	return __be_cmd_rx_filter(adapter, flags, value);
 }
 
-/* Uses synchrounous mcc */
+/* Uses synchronous mcc */
 int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 {
 	struct be_mcc_wrb *wrb;
@@ -2074,7 +2074,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 	return status;
 }
 
-/* Uses sycn mcc */
+/* Uses sync mcc */
 int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 {
 	struct be_mcc_wrb *wrb;
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.h b/drivers/net/ethernet/emulex/benet/be_cmds.h
index 5e2d3ddb5d43..fcc298ce2c77 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.h
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.h
@@ -1134,14 +1134,14 @@ struct be_cmd_resp_get_fw_version {
 	u8 fw_on_flash_version_string[FW_VER_LEN];
 } __packed;
 
-/******************** Set Flow Contrl *******************/
+/******************** Set Flow Control *******************/
 struct be_cmd_req_set_flow_control {
 	struct be_cmd_req_hdr hdr;
 	u16 tx_flow_control;
 	u16 rx_flow_control;
 } __packed;
 
-/******************** Get Flow Contrl *******************/
+/******************** Get Flow Control *******************/
 struct be_cmd_req_get_flow_control {
 	struct be_cmd_req_hdr hdr;
 	u32 rsvd;
@@ -2069,7 +2069,7 @@ struct be_cmd_resp_get_stats_v2 {
 	struct be_hw_stats_v2 hw_stats;
 };
 
-/************** get fat capabilites *******************/
+/************** get fat capabilities *******************/
 #define MAX_MODULES 27
 #define MAX_MODES 4
 #define MODE_UART 0
diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index f9216326bdfe..f55f1fd5d90f 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -142,7 +142,7 @@ static const struct be_ethtool_stat et_rx_stats[] = {
 	 * to HW.
 	 */
 	{DRVSTAT_RX_INFO(rx_post_fail)},
-	/* Recevied packets dropped due to skb allocation failure */
+	/* Received packets dropped due to skb allocation failure */
 	{DRVSTAT_RX_INFO(rx_drops_no_skbs)},
 	/* Received packets dropped due to lack of available fetched buffers
 	 * posted by the driver.
@@ -189,7 +189,7 @@ static const struct be_ethtool_stat et_tx_stats[] = {
 	{DRVSTAT_TX_INFO(tx_bytes)},
 	{DRVSTAT_TX_INFO(tx_pkts)},
 	{DRVSTAT_TX_INFO(tx_vxlan_offload_pkts)},
-	/* Number of skbs queued for trasmission by the driver */
+	/* Number of skbs queued for transmission by the driver */
 	{DRVSTAT_TX_INFO(tx_reqs)},
 	/* Number of times the TX queue was stopped due to lack
 	 * of spaces in the TXQ.
@@ -1222,7 +1222,7 @@ static void be_get_channels(struct net_device *netdev,
 	ch->tx_count = adapter->num_tx_qs - ch->combined_count;
 
 	ch->max_combined = be_max_qp_irqs(adapter);
-	/* The user must create atleast one combined channel */
+	/* The user must create at least one combined channel */
 	ch->max_rx = be_max_rx_irqs(adapter) - 1;
 	ch->max_tx = be_max_tx_irqs(adapter) - 1;
 }
diff --git a/drivers/net/ethernet/emulex/benet/be_hw.h b/drivers/net/ethernet/emulex/benet/be_hw.h
index 3476194f0855..42e83ff9c52f 100644
--- a/drivers/net/ethernet/emulex/benet/be_hw.h
+++ b/drivers/net/ethernet/emulex/benet/be_hw.h
@@ -16,7 +16,7 @@
  * The software must write this register twice to post any command. First,
  * it writes the register with hi=1 and the upper bits of the physical address
  * for the MAILBOX structure. Software must poll the ready bit until this
- * is acknowledged. Then, sotware writes the register with hi=0 with the lower
+ * is acknowledged. Then, software writes the register with hi=0 with the lower
  * bits in the address. It must poll the ready bit until the command is
  * complete. Upon completion, the MAILBOX will contain a valid completion
  * queue entry.
@@ -27,7 +27,7 @@
 
 #define MPU_EP_CONTROL 		0
 
-/********** MPU semphore: used for SH & BE  *************/
+/********** MPU semaphore: used for SH & BE  *************/
 #define SLIPORT_SOFTRESET_OFFSET		0x5c	/* CSR BAR offset */
 #define SLIPORT_SEMAPHORE_OFFSET_BEx		0xac  /* CSR BAR offset */
 #define SLIPORT_SEMAPHORE_OFFSET_SH		0x94  /* PCI-CFG offset */
@@ -39,7 +39,7 @@
 /* Soft Reset register masks */
 #define SLIPORT_SOFTRESET_SR_MASK		0x00000080	/* SR bit */
 
-/* MPU semphore POST stage values */
+/* MPU semaphore POST stage values */
 #define POST_STAGE_AWAITING_HOST_RDY 	0x1 /* FW awaiting goahead from host */
 #define POST_STAGE_HOST_RDY 		0x2 /* Host has given go-ahed to FW */
 #define POST_STAGE_BE_RESET		0x3 /* Host wants to reset chip */
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 5bb31c8fab39..b633c6e2bab7 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -61,7 +61,7 @@ static const struct pci_device_id be_dev_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, be_dev_ids);
 
-/* Workqueue used by all functions for defering cmd calls to the adapter */
+/* Workqueue used by all functions for deferring cmd calls to the adapter */
 static struct workqueue_struct *be_wq;
 
 /* UE Status Low CSR */
@@ -1129,7 +1129,7 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	struct iphdr *ip;
 
 	/* For padded packets, BE HW modifies tot_len field in IP header
-	 * incorrecly when VLAN tag is inserted by HW.
+	 * incorrectly when VLAN tag is inserted by HW.
 	 * For padded packets, Lancer computes incorrect checksum.
 	 */
 	eth_hdr_len = ntohs(skb->protocol) == ETH_P_8021Q ?
@@ -2568,7 +2568,7 @@ static struct be_rx_compl_info *be_rx_compl_get(struct be_rx_obj *rxo)
 			rxcp->vlanf = 0;
 	}
 
-	/* As the compl has been parsed, reset it; we wont touch it again */
+	/* As the compl has been parsed, reset it; we won't touch it again */
 	compl->dw[offsetof(struct amap_eth_rx_compl_v1, valid) / 32] = 0;
 
 	queue_tail_inc(&rxo->cq);
@@ -2727,7 +2727,7 @@ static struct be_tx_compl_info *be_tx_compl_get(struct be_adapter *adapter,
 	if (txcp->status) {
 		if (lancer_chip(adapter)) {
 			lancer_update_tx_err(txo, txcp->status);
-			/* Reset the adapter incase of TSO,
+			/* Reset the adapter in case of TSO,
 			 * SGE or Parity error
 			 */
 			if (txcp->status == LANCER_TX_COMP_LSO_ERR ||
@@ -3125,7 +3125,7 @@ static int be_rx_cqs_create(struct be_adapter *adapter)
 	adapter->num_rss_qs =
 			min(adapter->num_evt_qs, adapter->cfg_num_rx_irqs);
 
-	/* We'll use RSS only if atleast 2 RSS rings are supported. */
+	/* We'll use RSS only if at least 2 RSS rings are supported. */
 	if (adapter->num_rss_qs < 2)
 		adapter->num_rss_qs = 0;
 
@@ -3167,7 +3167,7 @@ static irqreturn_t be_intx(int irq, void *dev)
 	/* IRQ is not expected when NAPI is scheduled as the EQ
 	 * will not be armed.
 	 * But, this can happen on Lancer INTx where it takes
-	 * a while to de-assert INTx or in BE2 where occasionaly
+	 * a while to de-assert INTx or in BE2 where occasionally
 	 * an interrupt may be raised even when EQ is unarmed.
 	 * If NAPI is already scheduled, then counting & notifying
 	 * events will orphan them.
@@ -4415,7 +4415,7 @@ static void be_setup_init(struct be_adapter *adapter)
 /* HW supports only MAX_PORT_RSS_TABLES RSS Policy Tables per port.
  * However, this HW limitation is not exposed to the host via any SLI cmd.
  * As a result, in the case of SRIOV and in particular multi-partition configs
- * the driver needs to calcuate a proportional share of RSS Tables per PF-pool
+ * the driver needs to calculate a proportional share of RSS Tables per PF-pool
  * for distribution between the VFs. This self-imposed limit will determine the
  * no: of VFs for which RSS can be enabled.
  */
@@ -4519,7 +4519,7 @@ static int be_get_resources(struct be_adapter *adapter)
 		if (status)
 			return status;
 
-		/* If a deafault RXQ must be created, we'll use up one RSSQ*/
+		/* If a default RXQ must be created, we'll use up one RSSQ*/
 		if (res.max_rss_qs && res.max_rss_qs == res.max_rx_qs &&
 		    !(res.if_cap_flags & BE_IF_FLAGS_DEFQ_RSS))
 			res.max_rss_qs -= 1;
-- 
2.52.0


