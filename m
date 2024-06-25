Return-Path: <netdev+bounces-106536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB3916AA1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCAE1F282F0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F616A945;
	Tue, 25 Jun 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqCrsbGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4816F0F6
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326197; cv=none; b=griT6ahO8khMxKHyF3mB/6zOoJDVu5sw901WGYLJWJbmSjyCWfv/+q8pRnPaFME329NEWWe9pFgBuQ+54AY8x3+8pwFuDXVaH4Jg31a2ZXvnLH8o9u9CGVvKu4odvTMgvPu0LQDW5HzIG57PGncPv6/XCkSPEzd6Zr2VqWcYgLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326197; c=relaxed/simple;
	bh=g3CDsM62hehTKjiSEzmPOgPiUBIuI//AXZP1Do2WaSc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXrECs9eH0r036v1DZQ+4keFsadf0JdJpekCb2nlxYWAHBRS+eVXYmkQjH9fuT3YOCcer7VfAUSGUyWYsDC0mTeKJll5IzU0ty5Iz6ZVsdfVFS8NeexjP/6lm6CpNcHU2pL+T9hknvS19dBcJwErvz9Fk0NEojGGE5z1dYPd8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqCrsbGQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70671ecd334so2242846b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326195; x=1719930995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IdyfGwU6+9TJCIyDKwRruYEdzkJcLAwRSHnMR/XbCN4=;
        b=PqCrsbGQQfohRL1ejhrO9ShpZdvFqFtxcJDjcIMfZD+KAnEytuiXbUBIHD44tBJ6Ch
         S8Z7v/8mfGd3pSjLaeYPZA2onc9aeGVQNhn6n7b9U+Mp/GcMSTpV61hwDMS1TV1zAkzH
         Zcinf2g1scyw+lDuAElRKvaAGX/z04Pv6fwekgn6vEfeNkTQfkQcv28LlACaABwFtfUY
         sBu886UXydXY4fVxyZ7sdmWfbKGRqgkvCubgdWxxx79FsdOMjt2NNbEQtGU/3kYI3keN
         LbbKSFfeGaBM+qXG5JMadTdnoj73XYOMDUhWutxVSCtMJ0aHgjAOPrHohUYTctxm8r/P
         Ifvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326195; x=1719930995;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdyfGwU6+9TJCIyDKwRruYEdzkJcLAwRSHnMR/XbCN4=;
        b=qeqB6gfKsrEpM3ESif6YwQ4I8RTU2Oglh6tdlGQNG6JTBfnCSAhwFFBIeS4MPurKnt
         ZoBc45S6cipBm9tT0h6STh/gaXnvbewBoV/GKAMezlAIZV8KVTKSWP+AH9I0sk3N45R4
         VWLQT7SH3qLjjOi5u1/zrdXZjy70MvMbUxzCNGliasqytJIRzziv1FMlosfeDterGqXi
         2Yt6aejeKoNj3uTJgJafcGR3vKUcfU2je+NsCfchUPFEuZWREp2MpK+TvjQlHT6OkPVu
         MvTMoSMwUjM8jWiyHFE8sz6rIQg3UAXk0cYhctsKLso/W+XjR0jZ/lO//LtvbHDXHZcn
         qIrA==
X-Gm-Message-State: AOJu0YxdYssz9CTPVkgEGyIOkLMRxtO01Q1Z2DPySO7DLkp4xtQKZtbX
	XKvCPn5z4+VbKv2WF5E76cFacQDioGv4PVBJJi7z3StanZ4UwqRY
X-Google-Smtp-Source: AGHT+IFe6c7A56zGkYZUJgzE2Y1YVjoADP1n7VzZKWqb+33xGmXlElktYWIznUvrGuJ4vd6GEUuQCg==
X-Received: by 2002:a05:6a00:7d0:b0:706:67aa:3911 with SMTP id d2e1a72fcca58-70671025087mr8502087b3a.28.1719326194739;
        Tue, 25 Jun 2024 07:36:34 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-718aa6f56aesm5115382a12.55.2024.06.25.07.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:36:34 -0700 (PDT)
Subject: [net-next PATCH v2 15/15] eth: fbnic: Write the TCAM tables used for
 RSS control and Rx to host
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:36:33 -0700
Message-ID: 
 <171932619334.3072535.8038615516904128868.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

RSS is controlled by the Rx filter tables. Program rules matching
on appropriate traffic types and set hashing fields using actions.
We need a separate set of rules for broadcast and multicast
because the action there needs to include forwarding to BMC.

This patch only initializes the default settings, the control
of the configuration using ethtool will come soon.

With this the necessary rules are put in place to enable Rx of packets by
the host.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h        |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |   59 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    6 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |    7 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c    |  371 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h    |   52 +++
 7 files changed, 499 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index bfc36bb203ae..c56e98a81145 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -41,6 +41,7 @@ struct fbnic_dev {
 	u32 readrq;
 
 	/* Local copy of the devices TCAM */
+	struct fbnic_act_tcam act_tcam[FBNIC_RPC_TCAM_ACT_NUM_ENTRIES];
 	struct fbnic_mac_addr mac_addr[FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES];
 	u8 mac_addr_boundary;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index c98bd7eff4b5..b19ee19c5ea2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -537,20 +537,79 @@ enum {
 #define FBNIC_RPC_RMI_CONFIG_FCS_PRESENT	CSR_BIT(8)
 #define FBNIC_RPC_RMI_CONFIG_ENABLE		CSR_BIT(12)
 #define FBNIC_RPC_RMI_CONFIG_MTU		CSR_GENMASK(31, 16)
+
+#define FBNIC_RPC_ACT_TBL0_DEFAULT	0x0840a		/* 0x21028 */
+#define FBNIC_RPC_ACT_TBL0_DROP			CSR_BIT(0)
+#define FBNIC_RPC_ACT_TBL0_DEST_MASK		CSR_GENMASK(3, 1)
+enum {
+	FBNIC_RPC_ACT_TBL0_DEST_HOST	= 1,
+	FBNIC_RPC_ACT_TBL0_DEST_BMC	= 2,
+	FBNIC_RPC_ACT_TBL0_DEST_EI	= 4,
+};
+
+#define FBNIC_RPC_ACT_TBL0_DMA_HINT		CSR_GENMASK(24, 16)
+#define FBNIC_RPC_ACT_TBL0_RSS_CTXT_ID		CSR_BIT(30)
+
+#define FBNIC_RPC_ACT_TBL1_DEFAULT	0x0840b		/* 0x2102c */
+#define FBNIC_RPC_ACT_TBL1_RSS_ENA_MASK		CSR_GENMASK(15, 0)
+enum {
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_IP_SRC	= 1,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_IP_DST	= 2,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_L4_SRC	= 4,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_L4_DST	= 8,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_L2_DA	= 16,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_L4_RSS_BYTE	= 32,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_IV6_FL_LBL	= 64,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_OV6_FL_LBL	= 128,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_DSCP		= 256,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_L3_PROT	= 512,
+	FBNIC_RPC_ACT_TBL1_RSS_ENA_L4_PROT	= 1024,
+};
+
+#define FBNIC_RPC_RSS_KEY(n)		(0x0840c + (n))	/* 0x21030 + 4*n */
+#define FBNIC_RPC_RSS_KEY_BIT_LEN		425
+#define FBNIC_RPC_RSS_KEY_BYTE_LEN \
+	DIV_ROUND_UP(FBNIC_RPC_RSS_KEY_BIT_LEN, 8)
+#define FBNIC_RPC_RSS_KEY_DWORD_LEN \
+	DIV_ROUND_UP(FBNIC_RPC_RSS_KEY_BIT_LEN, 32)
+#define FBNIC_RPC_RSS_KEY_LAST_IDX \
+	(FBNIC_RPC_RSS_KEY_DWORD_LEN - 1)
+#define FBNIC_RPC_RSS_KEY_LAST_MASK \
+	CSR_GENMASK(31, \
+		    FBNIC_RPC_RSS_KEY_DWORD_LEN * 32 - \
+		    FBNIC_RPC_RSS_KEY_BIT_LEN)
+
 #define FBNIC_RPC_TCAM_MACDA_VALIDATE	0x0852d		/* 0x214b4 */
 #define FBNIC_CSR_END_RPC		0x0856b	/* CSR section delimiter */
 
 /* RPC RAM Registers */
 
 #define FBNIC_CSR_START_RPC_RAM		0x08800	/* CSR section delimiter */
+#define FBNIC_RPC_ACT_TBL0(n)		(0x08800 + (n))	/* 0x22000 + 4*n */
+#define FBNIC_RPC_ACT_TBL1(n)		(0x08840 + (n))	/* 0x22100 + 4*n */
 #define FBNIC_RPC_ACT_TBL_NUM_ENTRIES		64
 
 /* TCAM Tables */
 #define FBNIC_RPC_TCAM_VALIDATE			CSR_BIT(31)
+
+/* 64 Action TCAM Entries, 12 registers
+ * 3 mixed, src port, dst port, 6 L4 words, and Validate
+ */
+#define FBNIC_RPC_TCAM_ACT(m, n) \
+	(0x08880 + 0x40 * (n) + (m))		/* 0x22200 + 256*n + 4*m */
+
+#define FBNIC_RPC_TCAM_ACT_VALUE		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_ACT_MASK			CSR_GENMASK(31, 16)
+
 #define FBNIC_RPC_TCAM_MACDA(m, n) \
 	(0x08b80 + 0x20 * (n) + (m))		/* 0x022e00 + 128*n + 4*m */
 #define FBNIC_RPC_TCAM_MACDA_VALUE		CSR_GENMASK(15, 0)
 #define FBNIC_RPC_TCAM_MACDA_MASK		CSR_GENMASK(31, 16)
+
+#define FBNIC_RPC_RSS_TBL(n, m) \
+	(0x08d20 + 0x100 * (n) + (m))		/* 0x023480 + 1024*n + 4*m */
+#define FBNIC_RPC_RSS_TBL_COUNT			2
+#define FBNIC_RPC_RSS_TBL_SIZE			256
 #define FBNIC_CSR_END_RPC_RAM		0x08f1f	/* CSR section delimiter */
 
 /* Fab Registers */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index f58a0440c39e..cd76e5326a7e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -50,6 +50,7 @@ int __fbnic_open(struct fbnic_net *fbn)
 		goto release_ownership;
 	/* Pull the BMC config and initialize the RPC */
 	fbnic_bmc_rpc_init(fbd);
+	fbnic_rss_reinit(fbd, fbn);
 
 	return 0;
 release_ownership:
@@ -262,6 +263,7 @@ void __fbnic_set_rx_mode(struct net_device *netdev)
 	fbnic_sift_macda(fbd);
 
 	/* Write updates to hardware */
+	fbnic_write_rules(fbd);
 	fbnic_write_macda(fbd);
 }
 
@@ -398,6 +400,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	fbnic_reset_queues(fbn, default_queues, default_queues);
 
+	fbnic_reset_indir_tbl(fbn);
+	fbnic_rss_key_fill(fbn->rss_key);
+	fbnic_rss_init_en_mask(fbn);
+
 	netdev->features |=
 		NETIF_F_RXHASH |
 		NETIF_F_SG |
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 9466cf218b38..68e423350e5f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 #include <linux/phylink.h>
 
+#include "fbnic_csr.h"
+#include "fbnic_rpc.h"
 #include "fbnic_txrx.h"
 
 struct fbnic_net {
@@ -36,7 +38,12 @@ struct fbnic_net {
 	u16 num_tx_queues;
 	u16 num_rx_queues;
 
+	u8 indir_tbl[FBNIC_RPC_RSS_TBL_COUNT][FBNIC_RPC_RSS_TBL_SIZE];
+	u32 rss_key[FBNIC_RPC_RSS_KEY_DWORD_LEN];
+	u32 rss_flow_hash[FBNIC_NUM_HASH_OPT];
+
 	u64 link_down_events;
+
 	struct list_head napis;
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 1a88e21c8118..be5c76265e00 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -133,6 +133,8 @@ void fbnic_up(struct fbnic_net *fbn)
 
 	fbnic_fill(fbn);
 
+	fbnic_rss_reinit_hw(fbn->fbd, fbn);
+
 	__fbnic_set_rx_mode(fbn->netdev);
 
 	/* Enable Tx/Rx processing */
@@ -151,6 +153,8 @@ static void fbnic_down_noidle(struct fbnic_net *fbn)
 	netif_tx_disable(fbn->netdev);
 
 	fbnic_clear_rx_mode(fbn->netdev);
+	fbnic_clear_rules(fbn->fbd);
+	fbnic_rss_disable_hw(fbn->fbd);
 	fbnic_disable(fbn);
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index d77a22a6e1f7..ba6aa5bbd043 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -2,11 +2,102 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 
 #include "fbnic.h"
 #include "fbnic_netdev.h"
 #include "fbnic_rpc.h"
 
+void fbnic_reset_indir_tbl(struct fbnic_net *fbn)
+{
+	unsigned int num_rx = fbn->num_rx_queues;
+	unsigned int i;
+
+	for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++) {
+		fbn->indir_tbl[0][i] = ethtool_rxfh_indir_default(i, num_rx);
+		fbn->indir_tbl[1][i] = ethtool_rxfh_indir_default(i, num_rx);
+	}
+}
+
+void fbnic_rss_key_fill(u32 *buffer)
+{
+	static u32 rss_key[FBNIC_RPC_RSS_KEY_DWORD_LEN];
+
+	net_get_random_once(rss_key, sizeof(rss_key));
+	rss_key[FBNIC_RPC_RSS_KEY_LAST_IDX] &= FBNIC_RPC_RSS_KEY_LAST_MASK;
+
+	memcpy(buffer, rss_key, sizeof(rss_key));
+}
+
+#define RX_HASH_OPT_L4 \
+	(RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3)
+#define RX_HASH_OPT_L3 \
+	(RXH_IP_SRC | RXH_IP_DST)
+#define RX_HASH_OPT_L2 RXH_L2DA
+
+void fbnic_rss_init_en_mask(struct fbnic_net *fbn)
+{
+	fbn->rss_flow_hash[FBNIC_TCP4_HASH_OPT] = RX_HASH_OPT_L4;
+	fbn->rss_flow_hash[FBNIC_TCP6_HASH_OPT] = RX_HASH_OPT_L4;
+
+	fbn->rss_flow_hash[FBNIC_UDP4_HASH_OPT] = RX_HASH_OPT_L3;
+	fbn->rss_flow_hash[FBNIC_UDP6_HASH_OPT] = RX_HASH_OPT_L3;
+	fbn->rss_flow_hash[FBNIC_IPV4_HASH_OPT] = RX_HASH_OPT_L3;
+	fbn->rss_flow_hash[FBNIC_IPV6_HASH_OPT] = RX_HASH_OPT_L3;
+
+	fbn->rss_flow_hash[FBNIC_ETHER_HASH_OPT] = RX_HASH_OPT_L2;
+}
+
+void fbnic_rss_disable_hw(struct fbnic_dev *fbd)
+{
+	/* Disable RPC by clearing enable bit and configuration */
+	if (!fbnic_bmc_present(fbd))
+		wr32(fbd, FBNIC_RPC_RMI_CONFIG,
+		     FIELD_PREP(FBNIC_RPC_RMI_CONFIG_OH_BYTES, 20));
+}
+
+#define FBNIC_FH_2_RSSEM_BIT(_fh, _rssem, _val)		\
+	FIELD_PREP(FBNIC_RPC_ACT_TBL1_RSS_ENA_##_rssem,	\
+		   FIELD_GET(RXH_##_fh, _val))
+static u16 fbnic_flow_hash_2_rss_en_mask(struct fbnic_net *fbn, int flow_type)
+{
+	u32 flow_hash = fbn->rss_flow_hash[flow_type];
+	u32 rss_en_mask = 0;
+
+	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(L2DA, L2_DA, flow_hash);
+	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(IP_SRC, IP_SRC, flow_hash);
+	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(IP_DST, IP_DST, flow_hash);
+	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(L4_B_0_1, L4_SRC, flow_hash);
+	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(L4_B_2_3, L4_DST, flow_hash);
+
+	return rss_en_mask;
+}
+
+void fbnic_rss_reinit_hw(struct fbnic_dev *fbd, struct fbnic_net *fbn)
+{
+	unsigned int i;
+
+	for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++) {
+		wr32(fbd, FBNIC_RPC_RSS_TBL(0, i), fbn->indir_tbl[0][i]);
+		wr32(fbd, FBNIC_RPC_RSS_TBL(1, i), fbn->indir_tbl[1][i]);
+	}
+
+	for (i = 0; i < FBNIC_RPC_RSS_KEY_DWORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_RSS_KEY(i), fbn->rss_key[i]);
+
+	/* Default action for this to drop w/ no destination */
+	wr32(fbd, FBNIC_RPC_ACT_TBL0_DEFAULT, FBNIC_RPC_ACT_TBL0_DROP);
+	wrfl(fbd);
+
+	wr32(fbd, FBNIC_RPC_ACT_TBL1_DEFAULT, 0);
+
+	/* If it isn't already enabled set the RMI Config value to enable RPC */
+	wr32(fbd, FBNIC_RPC_RMI_CONFIG,
+	     FIELD_PREP(FBNIC_RPC_RMI_CONFIG_MTU, FBNIC_MAX_JUMBO_FRAME_SIZE) |
+	     FIELD_PREP(FBNIC_RPC_RMI_CONFIG_OH_BYTES, 20) |
+	     FBNIC_RPC_RMI_CONFIG_ENABLE);
+}
+
 static int fbnic_read_macda_entry(struct fbnic_dev *fbd, unsigned int idx,
 				  struct fbnic_mac_addr *mac_addr)
 {
@@ -30,7 +121,9 @@ static int fbnic_read_macda_entry(struct fbnic_dev *fbd, unsigned int idx,
 void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
 				    bool enable_host)
 {
+	struct fbnic_act_tcam *act_tcam;
 	struct fbnic_mac_addr *mac_addr;
+	int j;
 
 	/* We need to add the all multicast filter at the end of the
 	 * multicast address list. This way if there are any that are
@@ -61,13 +154,51 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
 		clear_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
 		mac_addr->state = FBNIC_TCAM_S_DELETE;
 	}
+
+	/* We have to add a special handler for multicast as the
+	 * BMC may have an all-multi rule already in place. As such
+	 * adding a rule ourselves won't do any good so we will have
+	 * to modify the rules for the ALL MULTI below if the BMC
+	 * already has the rule in place.
+	 */
+	act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_BMC_ALL_MULTI_OFFSET];
+
+	/* If we are not enabling the rule just delete it. We will fall
+	 * back to the RSS rules that support the multicast addresses.
+	 */
+	if (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi || enable_host) {
+		if (act_tcam->state == FBNIC_TCAM_S_VALID)
+			act_tcam->state = FBNIC_TCAM_S_DELETE;
+		return;
+	}
+
+	/* Rewrite TCAM rule 23 to handle BMC all-multi traffic */
+	act_tcam->dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
+				    FBNIC_RPC_ACT_TBL0_DEST_BMC);
+	act_tcam->mask.tcam[0] = 0xffff;
+
+	/* MACDA 0 - 3 is reserved for the BMC MAC address */
+	act_tcam->value.tcam[1] =
+			FIELD_PREP(FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX,
+				   fbd->mac_addr_boundary - 1) |
+			FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+	act_tcam->mask.tcam[1] = 0xffff &
+			 ~FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX &
+			 ~FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+
+	for (j = 2; j < FBNIC_RPC_TCAM_ACT_WORD_LEN; j++)
+		act_tcam->mask.tcam[j] = 0xffff;
+
+	act_tcam->state = FBNIC_TCAM_S_UPDATE;
 }
 
 void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 {
 	int i = FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX;
+	struct fbnic_act_tcam *act_tcam;
 	struct fbnic_mac_addr *mac_addr;
 	u32 macda_validate;
+	int j;
 
 	/* Verify that RPC is already enabled, if not abort */
 	macda_validate = rd32(fbd, FBNIC_RPC_TCAM_MACDA_VALIDATE);
@@ -140,11 +271,116 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 		mac_addr->state = FBNIC_TCAM_S_VALID;
 	}
 
+	/* Rewrite TCAM rule 0 if it isn't present to relocate BMC rules */
+	act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET];
+	act_tcam->dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
+				    FBNIC_RPC_ACT_TBL0_DEST_BMC);
+	act_tcam->mask.tcam[0] = 0xffff;
+
+	/* MACDA 0 - 3 is reserved for the BMC MAC address
+	 * to account for that we have to mask out the lower 2 bits
+	 * of the macda by performing an &= with 0x1c.
+	 */
+	act_tcam->value.tcam[1] = FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+	act_tcam->mask.tcam[1] = 0xffff &
+			~FIELD_PREP(FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX, 0x1c) &
+			~FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+
+	for (j = 2; j < FBNIC_RPC_TCAM_ACT_WORD_LEN; j++)
+		act_tcam->mask.tcam[j] = 0xffff;
+
+	act_tcam->state = FBNIC_TCAM_S_UPDATE;
+
 	fbnic_bmc_rpc_all_multi_config(fbd, false);
 
 	fbnic_bmc_set_present(fbd, true);
 }
 
+#define FBNIC_ACT1_INIT(_l4, _udp, _ip, _v6)		\
+	(((_l4) ? FBNIC_RPC_TCAM_ACT1_L4_VALID : 0) |	\
+	 ((_udp) ? FBNIC_RPC_TCAM_ACT1_L4_IS_UDP : 0) |	\
+	 ((_ip) ? FBNIC_RPC_TCAM_ACT1_IP_VALID : 0) |	\
+	 ((_v6) ? FBNIC_RPC_TCAM_ACT1_IP_IS_V6 : 0))
+
+void fbnic_rss_reinit(struct fbnic_dev *fbd, struct fbnic_net *fbn)
+{
+	static const u32 act1_value[FBNIC_NUM_HASH_OPT] = {
+		FBNIC_ACT1_INIT(1, 1, 1, 1),	/* UDP6 */
+		FBNIC_ACT1_INIT(1, 1, 1, 0),	/* UDP4 */
+		FBNIC_ACT1_INIT(1, 0, 1, 1),	/* TCP6 */
+		FBNIC_ACT1_INIT(1, 0, 1, 0),	/* TCP4 */
+		FBNIC_ACT1_INIT(0, 0, 1, 1),	/* IP6 */
+		FBNIC_ACT1_INIT(0, 0, 1, 0),	/* IP4 */
+		0				/* Ether */
+	};
+	unsigned int i;
+
+	/* To support scenarios where a BMC is present we must write the
+	 * rules twice, once for the unicast cases, and once again for
+	 * the broadcast/multicast cases as we have to support 2 destinations.
+	 */
+	BUILD_BUG_ON(FBNIC_RSS_EN_NUM_UNICAST * 2 != FBNIC_RSS_EN_NUM_ENTRIES);
+	BUILD_BUG_ON(ARRAY_SIZE(act1_value) != FBNIC_NUM_HASH_OPT);
+
+	/* Program RSS hash enable mask for host in action TCAM/table. */
+	for (i = fbnic_bmc_present(fbd) ? 0 : FBNIC_RSS_EN_NUM_UNICAST;
+	     i < FBNIC_RSS_EN_NUM_ENTRIES; i++) {
+		unsigned int idx = i + FBNIC_RPC_ACT_TBL_RSS_OFFSET;
+		struct fbnic_act_tcam *act_tcam = &fbd->act_tcam[idx];
+		u32 flow_hash, dest, rss_en_mask;
+		int flow_type, j;
+		u16 value = 0;
+
+		flow_type = i % FBNIC_RSS_EN_NUM_UNICAST;
+		flow_hash = fbn->rss_flow_hash[flow_type];
+
+		/* Set DEST_HOST based on absence of RXH_DISCARD */
+		dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
+				  !(RXH_DISCARD & flow_hash) ?
+				  FBNIC_RPC_ACT_TBL0_DEST_HOST : 0);
+
+		if (i >= FBNIC_RSS_EN_NUM_UNICAST && fbnic_bmc_present(fbd))
+			dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
+					   FBNIC_RPC_ACT_TBL0_DEST_BMC);
+
+		if (!dest)
+			dest = FBNIC_RPC_ACT_TBL0_DROP;
+
+		if (act1_value[flow_type] & FBNIC_RPC_TCAM_ACT1_L4_VALID)
+			dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DMA_HINT,
+					   FBNIC_RCD_HDR_AL_DMA_HINT_L4);
+
+		rss_en_mask = fbnic_flow_hash_2_rss_en_mask(fbn, flow_type);
+
+		act_tcam->dest = dest;
+		act_tcam->rss_en_mask = rss_en_mask;
+		act_tcam->state = FBNIC_TCAM_S_UPDATE;
+
+		act_tcam->mask.tcam[0] = 0xffff;
+
+		/* We reserve the upper 8 MACDA TCAM entries for host
+		 * unicast. So we set the value to 24, and the mask the
+		 * lower bits so that the lower entries can be used as
+		 * multicast or BMC addresses.
+		 */
+		if (i < FBNIC_RSS_EN_NUM_UNICAST)
+			value = FIELD_PREP(FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX,
+					   fbd->mac_addr_boundary);
+		value |= FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+
+		flow_type = i % FBNIC_RSS_EN_NUM_UNICAST;
+		value |= act1_value[flow_type];
+
+		act_tcam->value.tcam[1] = value;
+		act_tcam->mask.tcam[1] = ~value;
+
+		for (j = 2; j < FBNIC_RPC_TCAM_ACT_WORD_LEN; j++)
+			act_tcam->mask.tcam[j] = 0xffff;
+
+		act_tcam->state = FBNIC_TCAM_S_UPDATE;
+	}
+}
+
 struct fbnic_mac_addr *__fbnic_uc_sync(struct fbnic_dev *fbd,
 				       const unsigned char *addr)
 {
@@ -292,6 +528,38 @@ static void fbnic_clear_macda_entry(struct fbnic_dev *fbd, unsigned int idx)
 		wr32(fbd, FBNIC_RPC_TCAM_MACDA(idx, i), 0);
 }
 
+static void fbnic_clear_macda(struct fbnic_dev *fbd)
+{
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
+			continue;
+
+		if (test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam)) {
+			if (fbnic_bmc_present(fbd))
+				continue;
+			dev_warn_once(fbd->dev,
+				      "Found BMC MAC address w/ BMC not present\n");
+		}
+
+		fbnic_clear_macda_entry(fbd, idx);
+
+		/* If rule was already destined for deletion just wipe it now */
+		if (mac_addr->state == FBNIC_TCAM_S_DELETE) {
+			memset(mac_addr, 0, sizeof(*mac_addr));
+			continue;
+		}
+
+		/* Change state to update so that we will rewrite
+		 * this tcam the next time fbnic_write_macda is called.
+		 */
+		mac_addr->state = FBNIC_TCAM_S_UPDATE;
+	}
+}
+
 static void fbnic_write_macda_entry(struct fbnic_dev *fbd, unsigned int idx,
 				    struct fbnic_mac_addr *mac_addr)
 {
@@ -336,3 +604,106 @@ void fbnic_write_macda(struct fbnic_dev *fbd)
 		mac_addr->state = FBNIC_TCAM_S_VALID;
 	}
 }
+
+static void fbnic_clear_act_tcam(struct fbnic_dev *fbd, unsigned int idx)
+{
+	int i;
+
+	/* Invalidate entry and clear addr state info */
+	for (i = 0; i <= FBNIC_RPC_TCAM_ACT_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_ACT(idx, i), 0);
+}
+
+void fbnic_clear_rules(struct fbnic_dev *fbd)
+{
+	u32 dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
+			      FBNIC_RPC_ACT_TBL0_DEST_BMC);
+	int i = FBNIC_RPC_TCAM_ACT_NUM_ENTRIES - 1;
+	struct fbnic_act_tcam *act_tcam;
+
+	/* Clear MAC rules */
+	fbnic_clear_macda(fbd);
+
+	/* If BMC is present we need to preserve the last rule which
+	 * will be used to route traffic to the BMC if it is received.
+	 *
+	 * At this point it should be the only MAC address in the MACDA
+	 * so any unicast or multicast traffic received should be routed
+	 * to it. So leave the last rule in place.
+	 *
+	 * It will be rewritten to add the host again when we bring
+	 * the interface back up.
+	 */
+	if (fbnic_bmc_present(fbd)) {
+		act_tcam = &fbd->act_tcam[i];
+
+		if (act_tcam->state == FBNIC_TCAM_S_VALID &&
+		    (act_tcam->dest & dest)) {
+			wr32(fbd, FBNIC_RPC_ACT_TBL0(i), dest);
+			wr32(fbd, FBNIC_RPC_ACT_TBL1(i), 0);
+
+			act_tcam->state = FBNIC_TCAM_S_UPDATE;
+
+			i--;
+		}
+	}
+
+	/* Work from the bottom up deleting all other rules from hardware */
+	do {
+		act_tcam = &fbd->act_tcam[i];
+
+		if (act_tcam->state != FBNIC_TCAM_S_VALID)
+			continue;
+
+		fbnic_clear_act_tcam(fbd, i);
+		act_tcam->state = FBNIC_TCAM_S_UPDATE;
+	} while (i--);
+}
+
+static void fbnic_delete_act_tcam(struct fbnic_dev *fbd, unsigned int idx)
+{
+	fbnic_clear_act_tcam(fbd, idx);
+	memset(&fbd->act_tcam[idx], 0, sizeof(struct fbnic_act_tcam));
+}
+
+static void fbnic_update_act_tcam(struct fbnic_dev *fbd, unsigned int idx)
+{
+	struct fbnic_act_tcam *act_tcam = &fbd->act_tcam[idx];
+	int i;
+
+	/* Update entry by writing the destination and RSS mask */
+	wr32(fbd, FBNIC_RPC_ACT_TBL0(idx), act_tcam->dest);
+	wr32(fbd, FBNIC_RPC_ACT_TBL1(idx), act_tcam->rss_en_mask);
+
+	/* Write new TCAM rule to hardware */
+	for (i = 0; i < FBNIC_RPC_TCAM_ACT_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_ACT(idx, i),
+		     FIELD_PREP(FBNIC_RPC_TCAM_ACT_MASK,
+				act_tcam->mask.tcam[i]) |
+		     FIELD_PREP(FBNIC_RPC_TCAM_ACT_VALUE,
+				act_tcam->value.tcam[i]));
+
+	wrfl(fbd);
+
+	wr32(fbd, FBNIC_RPC_TCAM_ACT(idx, i), FBNIC_RPC_TCAM_VALIDATE);
+	act_tcam->state = FBNIC_TCAM_S_VALID;
+}
+
+void fbnic_write_rules(struct fbnic_dev *fbd)
+{
+	int i;
+
+	/* Flush any pending action table rules */
+	for (i = 0; i < FBNIC_RPC_ACT_TBL_NUM_ENTRIES; i++) {
+		struct fbnic_act_tcam *act_tcam = &fbd->act_tcam[i];
+
+		/* Check if update flag is set else exit. */
+		if (!(act_tcam->state & FBNIC_TCAM_S_UPDATE))
+			continue;
+
+		if (act_tcam->state == FBNIC_TCAM_S_DELETE)
+			fbnic_delete_act_tcam(fbd, i);
+		else
+			fbnic_update_act_tcam(fbd, i);
+	}
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
index 1b59b10ba677..d62935f722a2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
@@ -54,9 +54,21 @@ struct fbnic_act_tcam {
 };
 
 enum {
+	FBNIC_RSS_EN_HOST_UDP6,
+	FBNIC_RSS_EN_HOST_UDP4,
+	FBNIC_RSS_EN_HOST_TCP6,
+	FBNIC_RSS_EN_HOST_TCP4,
+	FBNIC_RSS_EN_HOST_IP6,
+	FBNIC_RSS_EN_HOST_IP4,
 	FBNIC_RSS_EN_HOST_ETHER,
+	FBNIC_RSS_EN_XCAST_UDP6,
+#define FBNIC_RSS_EN_NUM_UNICAST FBNIC_RSS_EN_XCAST_UDP6
+	FBNIC_RSS_EN_XCAST_UDP4,
+	FBNIC_RSS_EN_XCAST_TCP6,
+	FBNIC_RSS_EN_XCAST_TCP4,
+	FBNIC_RSS_EN_XCAST_IP6,
+	FBNIC_RSS_EN_XCAST_IP4,
 	FBNIC_RSS_EN_XCAST_ETHER,
-#define FBNIC_RSS_EN_NUM_UNICAST FBNIC_RSS_EN_XCAST_ETHER
 	FBNIC_RSS_EN_NUM_ENTRIES
 };
 
@@ -91,8 +103,22 @@ enum {
 #define FBNIC_MAC_ADDR_T_HOST_LEN \
 	(FBNIC_MAC_ADDR_T_HOST_LAST - FBNIC_MAC_ADDR_T_HOST_START)
 
+#define FBNIC_RPC_TCAM_ACT0_IPSRC_IDX		CSR_GENMASK(2, 0)
+#define FBNIC_RPC_TCAM_ACT0_IPSRC_VALID		CSR_BIT(3)
+#define FBNIC_RPC_TCAM_ACT0_IPDST_IDX		CSR_GENMASK(6, 4)
+#define FBNIC_RPC_TCAM_ACT0_IPDST_VALID		CSR_BIT(7)
+#define FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_IDX	CSR_GENMASK(10, 8)
+#define FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_VALID	CSR_BIT(11)
+#define FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_IDX	CSR_GENMASK(14, 12)
+#define FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_VALID	CSR_BIT(15)
+
 #define FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX	CSR_GENMASK(9, 5)
 #define FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID	CSR_BIT(10)
+#define FBNIC_RPC_TCAM_ACT1_IP_IS_V6		CSR_BIT(11)
+#define FBNIC_RPC_TCAM_ACT1_IP_VALID		CSR_BIT(12)
+#define FBNIC_RPC_TCAM_ACT1_OUTER_IP_VALID	CSR_BIT(13)
+#define FBNIC_RPC_TCAM_ACT1_L4_IS_UDP		CSR_BIT(14)
+#define FBNIC_RPC_TCAM_ACT1_L4_VALID		CSR_BIT(15)
 
 /* TCAM 0 - 3 reserved for BMC MAC addresses */
 #define FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX	0
@@ -114,11 +140,32 @@ enum {
 /* Reserved for use to record Multicast promisc, or Promiscuous */
 #define FBNIC_RPC_TCAM_MACDA_PROMISC_IDX	31
 
+enum {
+	FBNIC_UDP6_HASH_OPT,
+	FBNIC_UDP4_HASH_OPT,
+	FBNIC_TCP6_HASH_OPT,
+	FBNIC_TCP4_HASH_OPT,
+#define FBNIC_L4_HASH_OPT FBNIC_TCP4_HASH_OPT
+	FBNIC_IPV6_HASH_OPT,
+	FBNIC_IPV4_HASH_OPT,
+#define FBNIC_IP_HASH_OPT FBNIC_IPV4_HASH_OPT
+	FBNIC_ETHER_HASH_OPT,
+	FBNIC_NUM_HASH_OPT,
+};
+
 struct fbnic_dev;
+struct fbnic_net;
 
 void fbnic_bmc_rpc_init(struct fbnic_dev *fbd);
 void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd, bool enable_host);
 
+void fbnic_reset_indir_tbl(struct fbnic_net *fbn);
+void fbnic_rss_key_fill(u32 *buffer);
+void fbnic_rss_init_en_mask(struct fbnic_net *fbn);
+void fbnic_rss_disable_hw(struct fbnic_dev *fbd);
+void fbnic_rss_reinit_hw(struct fbnic_dev *fbd, struct fbnic_net *fbn);
+void fbnic_rss_reinit(struct fbnic_dev *fbd, struct fbnic_net *fbn);
+
 int __fbnic_xc_unsync(struct fbnic_mac_addr *mac_addr, unsigned int tcam_idx);
 struct fbnic_mac_addr *__fbnic_uc_sync(struct fbnic_dev *fbd,
 				       const unsigned char *addr);
@@ -136,4 +183,7 @@ static inline int __fbnic_mc_unsync(struct fbnic_mac_addr *mac_addr)
 {
 	return __fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_MULTICAST);
 }
+
+void fbnic_clear_rules(struct fbnic_dev *fbd);
+void fbnic_write_rules(struct fbnic_dev *fbd);
 #endif /* _FBNIC_RPC_H_ */



