Return-Path: <netdev+bounces-59002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACFC818E98
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD011F22B8C
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07437D1A;
	Tue, 19 Dec 2023 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="EZICCefA"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6653B296
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023121917462922603cf257b41aed0a
        for <netdev@vger.kernel.org>;
        Tue, 19 Dec 2023 18:46:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8sQbeCmWiLFomVY+kxivPzriHLrsmhcfUL/M14qU9XY=;
 b=EZICCefAuH6CxyplmW1RRn8rSciVnFdivmefU/yU8lhzq0GfppcXncqCy+hLNH6WhtDmcP
 e1qbgRvlBKzyM2isInFlE5MHN5Gn6f9zF5W70B19qHlqwL5eMVhmju8Icj/1HxUf87GjJk8v
 Ka8RQzS6vj8fY13maNxLQ336AAxf8=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	grygorii.strashko@ti.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC PATCH net-next 3/8] net: ti: icssg-prueth: add SR1.0-specific configuration bits
Date: Tue, 19 Dec 2023 17:45:41 +0000
Message-ID: <20231219174548.3481-4-diogo.ivo@siemens.com>
In-Reply-To: <20231219174548.3481-1-diogo.ivo@siemens.com>
References: <20231219174548.3481-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Add fields to differentiate between SR1.0 and SR2.0 in the driver
as well as the structures necessary to program SR1.0.

Based on the work of Roger Quadros in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 8b6d6b497010..1bdd3d301fde 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -127,6 +127,7 @@ struct prueth_rx_chn {
 
 /* data for each emac port */
 struct prueth_emac {
+	bool is_sr1;
 	bool fw_running;
 	struct prueth *prueth;
 	struct net_device *ndev;
@@ -155,6 +156,10 @@ struct prueth_emac {
 	int rx_flow_id_base;
 	int tx_ch_num;
 
+	/* SR1.0 Management channel */
+	struct prueth_rx_chn rx_mgm_chn;
+	int rx_mgm_flow_id_base;
+
 	spinlock_t lock;	/* serialize access */
 
 	/* TX HW Timestamping */
@@ -182,10 +187,12 @@ struct prueth_emac {
  * struct prueth_pdata - PRUeth platform data
  * @fdqring_mode: Free desc queue mode
  * @quirk_10m_link_issue: 10M link detect errata
+ * @is_sr1: device is SR1.0
  */
 struct prueth_pdata {
 	enum k3_ring_mode fdqring_mode;
 	u32	quirk_10m_link_issue:1;
+	u32	is_sr1:1;
 };
 
 /**
@@ -224,6 +231,7 @@ struct prueth {
 	struct device_node *eth_node[PRUETH_NUM_MACS];
 	struct prueth_emac *emac[PRUETH_NUM_MACS];
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
+	struct icssg_config_sr1 config[PRUSS_NUM_PRUS];
 	struct regmap *miig_rt;
 	struct regmap *mii_rt;
 
@@ -236,6 +244,13 @@ struct prueth {
 	struct icss_iep *iep1;
 };
 
+struct emac_tx_ts_response_sr1 {
+	u32 lo_ts;
+	u32 hi_ts;
+	u32 reserved;
+	u32 cookie;
+};
+
 struct emac_tx_ts_response {
 	u32 reserved[2];
 	u32 cookie;
-- 
2.43.0


