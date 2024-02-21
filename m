Return-Path: <netdev+bounces-73738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3485E0F9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815C61F21B5B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E480639;
	Wed, 21 Feb 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="nR5C/f+V"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745180C1C
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529080; cv=none; b=qFyxZvkm0UIo8jgoTrvnh8z2gtexL8ByPZy8LqE+Zty0QLnJz5kWBbuknpuop/5MOewtAZtWD47iKuUu5IkMrE8KWEWqOJbj8LMDsQ0Vj4FYFhC8rQk3Th6iGd8pYX9EaJUqlVF4rWvPWUiY+SGIZa8wZo5el41bi2SExizYqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529080; c=relaxed/simple;
	bh=teVhrJ/9O3KmR04AGLTQm702JtymcCzQgh0NKeAupEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRNghLyKC8TsPgFn6Cx/2GS9+hglzM8UORsdFJrKN5zHq5QkFaufFSpMdsyqU1om43tGBt3HbHPNyEu5FNj72hX97FLiOL4hzcGF4ChqhjGW3ae7hWy/SqtrjivBGTrwNcBgE6IqZajwNMhSLK01FwManHu6xJ3OdbRaniwSUCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=nR5C/f+V; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024022115243070b675f2d45f15a5b3
        for <netdev@vger.kernel.org>;
        Wed, 21 Feb 2024 16:24:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AZGTLJwLrUkfkXIIlmR2mejSx+suHq4AzNo6yzzzTMA=;
 b=nR5C/f+Vw/LOJGQ4JR6C62vEO/HFuZ5wAdORv9NG2VcZ+stV2wur+oFdoE66Y1HFldSSLx
 i6attMUul7EFW1tJfdukyeDY41IZ9QlEoDUTyDVuRW5uWy0bxHa30Wp1mGDzSTp4uTxUeVz/
 Lf9bSq3/KTS+tFGqh9iC/RNTpBahM=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v3 04/10] net: ti: icssg-prueth: Add SR1.0-specific configuration bits
Date: Wed, 21 Feb 2024 15:24:10 +0000
Message-ID: <20240221152421.112324-5-diogo.ivo@siemens.com>
In-Reply-To: <20240221152421.112324-1-diogo.ivo@siemens.com>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Define the firmware configuration structure and commands needed to
communicate with SR1.0 firmware, as well as SR1.0 buffer information
where it differs from SR2.0.

Based on the work of Roger Quadros, Murali Karicheri and
Grygorii Strashko in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v2:
 - Removed explicit references to SR2.0

 drivers/net/ethernet/ti/icssg/icssg_config.h | 56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 43eb0922172a..cb465b3f5355 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -35,6 +35,23 @@ struct icssg_flow_cfg {
 	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
 	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
 
+/* SR1.0 defines */
+#define PRUETH_MAX_RX_FLOWS_SR1		4	/* excluding default flow */
+#define PRUETH_RX_FLOW_DATA_SR1		3       /* highest priority flow */
+#define PRUETH_MAX_RX_MGM_DESC		8
+#define PRUETH_MAX_RX_MGM_FLOWS		2	/* excluding default flow */
+#define PRUETH_RX_MGM_FLOW_RESPONSE	0
+#define PRUETH_RX_MGM_FLOW_TIMESTAMP	1
+
+#define PRUETH_NUM_BUF_POOLS_SR1		16
+#define PRUETH_EMAC_BUF_POOL_START_SR1		8
+#define PRUETH_EMAC_BUF_POOL_MIN_SIZE_SR1	128
+#define PRUETH_EMAC_BUF_SIZE_SR1		1536
+#define PRUETH_EMAC_NUM_BUF_SR1			4
+#define PRUETH_EMAC_BUF_POOL_SIZE_SR1	(PRUETH_EMAC_NUM_BUF_SR1 * \
+					 PRUETH_EMAC_BUF_SIZE_SR1)
+#define MSMC_RAM_SIZE_SR1	(SZ_64K + SZ_32K + SZ_2K) /* 0x1880 x 8 x 2 */
+
 struct icssg_rxq_ctx {
 	__le32 start[3];
 	__le32 end;
@@ -104,6 +121,45 @@ enum icssg_port_state_cmd {
 #define ICSSG_NUM_NORMAL_PDS	64
 #define ICSSG_NUM_SPECIAL_PDS	16
 
+struct icssg_sr1_config {
+	__le32 status;		/* Firmware status */
+	__le32 addr_lo;		/* MSMC Buffer pool base address low. */
+	__le32 addr_hi;		/* MSMC Buffer pool base address high. Must be 0 */
+	__le32 tx_buf_sz[16];	/* Array of buffer pool sizes */
+	__le32 num_tx_threads;	/* Number of active egress threads, 1 to 4 */
+	__le32 tx_rate_lim_en;	/* Bitmask: Egress rate limit en per thread */
+	__le32 rx_flow_id;	/* RX flow id for first rx ring */
+	__le32 rx_mgr_flow_id;	/* RX flow id for the first management ring */
+	__le32 flags;		/* TBD */
+	__le32 n_burst;		/* for debug */
+	__le32 rtu_status;	/* RTU status */
+	__le32 info;		/* reserved */
+	__le32 reserve;
+	__le32 rand_seed;	/* Used for the random number generation at fw */
+} __packed;
+
+/* SR1.0 shutdown command to stop processing at firmware.
+ * Command format: 0x8101ss00, where
+ *	- ss: sequence number. Currently not used by driver.
+ */
+#define ICSSG_SHUTDOWN_CMD		0x81010000
+
+/* SR1.0 pstate speed/duplex command to set speed and duplex settings
+ * in firmware.
+ * Command format: 0x8102ssPN, where
+ *	- ss: sequence number. Currently not used by driver.
+ *	- P: port number (for switch mode).
+ *	- N: Speed/Duplex state:
+ *		0x0 - 10Mbps/Half duplex;
+ *		0x8 - 10Mbps/Full duplex;
+ *		0x2 - 100Mbps/Half duplex;
+ *		0xa - 100Mbps/Full duplex;
+ *		0xc - 1Gbps/Full duplex;
+ *		NOTE: The above are the same value as bits [3..1](slice 0)
+ *		      or bits [7..5](slice 1) of RGMII CFG register.
+ */
+#define ICSSG_PSTATE_SPEED_DUPLEX_CMD	0x81020000
+
 #define ICSSG_NORMAL_PD_SIZE	8
 #define ICSSG_SPECIAL_PD_SIZE	20
 
-- 
2.43.2


