Return-Path: <netdev+bounces-77474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A00871E47
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394081C23733
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820A58123;
	Tue,  5 Mar 2024 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="ASGFVDXs"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97F54910
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639505; cv=none; b=b15Sr799y13gur8BaqBzGpG6SbtXXzBZApyAgj8t0hW9C/goDfzZMGQJuDN6AvNRNoCJUXRl3waNe9JD+LX9iSsEukZMS3rB+1vBBayk8MyWg9nGNQvys/l8mukqQRSmQPywlvRKQUpbHcnmszaZDrexp2dwVgx0ruypJnmgji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639505; c=relaxed/simple;
	bh=XcLiwpdNx/fbGRVm1XjcL0W650UrDWp/leNS4NRj4ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SylTQiAJYswB82tj3CdYYEOb0uLs1zzrLfMDdhoeP/qHkJHGGnwbfaSMapD6s1edMpJG0CWwMZOS3vxUlN6tYi2MqXoC+CtVET91Ns31GMekrSqAJGXQGOiBc7wyiZcItID2Izl5UW7pWjd0PxCzM5RgvW9klkNx8C86BaxTGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=ASGFVDXs; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240305114104b7729d5045b2c884e7
        for <netdev@vger.kernel.org>;
        Tue, 05 Mar 2024 12:41:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uCLz4ZWwfJ4YaIamLmzsKd0wJQqxlc2ZzOpM7ueZrwg=;
 b=ASGFVDXsSyESPlbyCmxd6vh3BDYXEL8kBNtuhlxYNClqb4qvVJ28IDEqL83HBGnWQp962f
 pbBX9XHlVAiQWjr9W/i4Uo6wZcFyCkVUYFFjMMoQLUSU/2OXUuSWZ5m4ELcHcjmefJxYmypp
 SlD0v129RKjw1vOBjXL6/R/NcHHKY=;
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
Subject: [PATCH net-next v4 04/10] net: ti: icssg-prueth: Add SR1.0-specific configuration bits
Date: Tue,  5 Mar 2024 11:40:24 +0000
Message-ID: <20240305114045.388893-5-diogo.ivo@siemens.com>
In-Reply-To: <20240305114045.388893-1-diogo.ivo@siemens.com>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
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


