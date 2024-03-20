Return-Path: <netdev+bounces-80839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B888139C
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF9D1C217A9
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625F51C2A;
	Wed, 20 Mar 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="hgd6101V"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAF4E1D5
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945782; cv=none; b=aJIhplVUuZ333l0cVm0OBT/v9Jt1+iFzwFKq9APBQp7piw/dg3VSwDa/tjieg3eJQ5WRRg3hdEbK14AKtzwaC3M1G+wX5X4EIdoG9btB5i3zZdfNF/pKx7Bhrax2aPfwYzElEhqbpidtVVJLoDvBwZp/F1vzqsDy4Ce4QCkE6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945782; c=relaxed/simple;
	bh=RxP8le+pbP8lqWKDf79K25kYpetBEIO+bOuVZb2V/i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0ucTxK0GOKqL+NSv9+PB8vF9HEep5Jg+Shpw1IbaJo5aFwNI6U4g1d7tdkesiCM6Ryz3E9cJzF1uiSDeCIbVeEmKuCfq0kHOGl3CWRlDHFcE+LNMRq6w4scsGqTtcy5MbMBleZPHTOudkyi2KfchV2/xnzPktaZx5qu5N4GnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=hgd6101V; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202403201442522cd1ae5251cf8f7a2b
        for <netdev@vger.kernel.org>;
        Wed, 20 Mar 2024 15:42:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vvMVRtx4DlUw71e1iwCqU1RnBP/hADkPx94gUz5rWfE=;
 b=hgd6101VcOJPfTIWvKgUW2abV0Aytdh2MG8hKBcBgCuPPpJhJ8k7QcjFuYbE30uI9dGjl8
 T11P1/34qmJbDaNCi7f7Pu3rRSGJTIOHN5VMsm0eaJnsTFjTsYY1vIjzPzahxmNLafwSHYXG
 8I33scksqKUDJeFJvaL/uC71HeOfw=;
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
Subject: [PATCH net-next v5 04/10] net: ti: icssg-prueth: Add SR1.0-specific configuration bits
Date: Wed, 20 Mar 2024 14:42:26 +0000
Message-ID: <20240320144234.313672-5-diogo.ivo@siemens.com>
In-Reply-To: <20240320144234.313672-1-diogo.ivo@siemens.com>
References: <20240320144234.313672-1-diogo.ivo@siemens.com>
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
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes in v5: 
 - Added Reviewed-by tags from Roger and Danish 

Changes in v4:
 - Added _SR1 suffix to all SR1 defines
 - Grouped SR1.0 specific data together

Changes in v2:
 - Removed explicit references to SR2.0

 drivers/net/ethernet/ti/icssg/icssg_config.h | 56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 43eb0922172a..cf2ea4bd22a2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -109,6 +109,62 @@ enum icssg_port_state_cmd {
 
 #define ICSSG_FLAG_MASK		0xff00ffff
 
+/* SR1.0-specific bits */
+#define PRUETH_MAX_RX_FLOWS_SR1			4	/* excluding default flow */
+#define PRUETH_RX_FLOW_DATA_SR1			3       /* highest priority flow */
+#define PRUETH_MAX_RX_MGM_DESC_SR1		8
+#define PRUETH_MAX_RX_MGM_FLOWS_SR1		2	/* excluding default flow */
+#define PRUETH_RX_MGM_FLOW_RESPONSE_SR1		0
+#define PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1	1
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
+#define ICSSG_SHUTDOWN_CMD_SR1		0x81010000
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
+#define ICSSG_PSTATE_SPEED_DUPLEX_CMD_SR1	0x81020000
+
 struct icssg_setclock_desc {
 	u8 request;
 	u8 restore;
-- 
2.44.0


