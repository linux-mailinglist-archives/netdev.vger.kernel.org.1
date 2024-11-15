Return-Path: <netdev+bounces-145126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1A9CD52F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FA7B2290E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C481534E9;
	Fri, 15 Nov 2024 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9uo2dCG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080184D02
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635638; cv=none; b=o/XtDjSojwwwVXF6YMiTvt06dLVGAikaIvXdTQvtgv4cPwECjGBxYCLT1l1qq3iYXNP2LTfNOrvV90jjRIl7tRziJeUdWESXf3TkO5SSnTQu8SEaPW+qo0Pef4Kii/Cf/GxEDNBMOs7GQKec75G8P1EAi1KBt3YRzg1p0ZXwdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635638; c=relaxed/simple;
	bh=kAhGNmnOWQmgeG+KG/+MvxLlm1sO8qX45YyHBqmYexs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKzo5ur+mk9Cq2/64Il6jYZ+r4e5BgEpbzEPlNO+z2FWKjLUs5u6iZSkbr13z6jsqCS0u0dYf2zczAm9grdXaW26cBaqpMy812MekUPy9USNDzml+VIXMIj0izRRJfBx9DKkLsJYn1DQegkD2TzaB7cesV8NtMPVAGQXV25/Xrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9uo2dCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1A1C4CED4;
	Fri, 15 Nov 2024 01:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635637;
	bh=kAhGNmnOWQmgeG+KG/+MvxLlm1sO8qX45YyHBqmYexs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9uo2dCG9biGM6jiXTDIYAkF4ouiO7l0LK07ieIjx3cN70Jy66fioHJh72pr8E0Ss
	 ZVz4pMljteA0nEyY5qduIS4U0/EKNn88uOjF+2TzRtoi0oh53MaSudOwDLlrhJ11eU
	 4E1x6iIJdcdDGfsy4S56EIN03fzfr9qTcT9R5CU/QRf1OxHaWflsaRzAxp7/VyXkTc
	 P1Hn8HURxcKUwAMTufbrfq8KvYRL+D0Ov6bYaP55Yb5DEDm6BsMnPC4SMMnBLDDz+D
	 BwIUYM9A823YflSqD5PfRBUc9+q5jTALB1i+iIfuYdp9m121SCQlC2grr+aX+2vWmn
	 Ob0NUWoN2ypwA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] eth: fbnic: add RPC hardware statistics
Date: Thu, 14 Nov 2024 17:53:44 -0800
Message-ID: <20241115015344.757567-6-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115015344.757567-1-kuba@kernel.org>
References: <20241115015344.757567-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanman Pradhan <sanman.p211993@gmail.com>

Report Rx parser statistics via ethtool -S.

The parser stats are 32b, so we need to add refresh to the service
task to make sure we don't miss overflows.

Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../device_drivers/ethernet/meta/fbnic.rst    | 13 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 10 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 71 +++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 76 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  8 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  2 +
 6 files changed, 180 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 14f2834d86d1..04e0595bb0a7 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -31,6 +31,19 @@ separate entry.
 Statistics
 ----------
 
+RPC (Rx parser)
+~~~~~~~~~~~~~~~
+
+ - ``rpc_unkn_etype``: frames containing unknown EtherType
+ - ``rpc_unkn_ext_hdr``: frames containing unknown IPv6 extension header
+ - ``rpc_ipv4_frag``: frames containing IPv4 fragment
+ - ``rpc_ipv6_frag``: frames containing IPv6 fragment
+ - ``rpc_ipv4_esp``: frames with IPv4 ESP encapsulation
+ - ``rpc_ipv6_esp``: frames with IPv6 ESP encapsulation
+ - ``rpc_tcp_opt_err``: frames which encountered TCP option parsing error
+ - ``rpc_out_of_hdr_err``: frames where header was larger than parsable region
+ - ``ovr_size_err``: oversized frames
+
 PCIe
 ~~~~
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index dac9a4879e52..02bb81b3c506 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -638,6 +638,16 @@ enum {
 		    FBNIC_RPC_RSS_KEY_DWORD_LEN * 32 - \
 		    FBNIC_RPC_RSS_KEY_BIT_LEN)
 
+#define FBNIC_RPC_CNTR_TCP_OPT_ERR	0x0849e		/* 0x21278 */
+#define FBNIC_RPC_CNTR_UNKN_ETYPE	0x0849f		/* 0x2127c */
+#define FBNIC_RPC_CNTR_IPV4_FRAG	0x084a0		/* 0x21280 */
+#define FBNIC_RPC_CNTR_IPV6_FRAG	0x084a1		/* 0x21284 */
+#define FBNIC_RPC_CNTR_IPV4_ESP		0x084a2		/* 0x21288 */
+#define FBNIC_RPC_CNTR_IPV6_ESP		0x084a3		/* 0x2128c */
+#define FBNIC_RPC_CNTR_UNKN_EXT_HDR	0x084a4		/* 0x21290 */
+#define FBNIC_RPC_CNTR_OUT_OF_HDR_ERR	0x084a5		/* 0x21294 */
+#define FBNIC_RPC_CNTR_OVR_SIZE_ERR	0x084a6		/* 0x21298 */
+
 #define FBNIC_RPC_TCAM_MACDA_VALIDATE	0x0852d		/* 0x214b4 */
 #define FBNIC_CSR_END_RPC		0x0856b	/* CSR section delimiter */
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 589cc7c2ee52..cc8ca94529ca 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -9,6 +9,37 @@
 #include "fbnic_netdev.h"
 #include "fbnic_tlv.h"
 
+struct fbnic_stat {
+	u8 string[ETH_GSTRING_LEN];
+	unsigned int size;
+	unsigned int offset;
+};
+
+#define FBNIC_STAT_FIELDS(type, name, stat) { \
+	.string = name, \
+	.size = sizeof_field(struct type, stat), \
+	.offset = offsetof(struct type, stat), \
+}
+
+/* Hardware statistics not captured in rtnl_link_stats */
+#define FBNIC_HW_STAT(name, stat) \
+	FBNIC_STAT_FIELDS(fbnic_hw_stats, name, stat)
+
+static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
+	/* RPC */
+	FBNIC_HW_STAT("rpc_unkn_etype", rpc.unkn_etype),
+	FBNIC_HW_STAT("rpc_unkn_ext_hdr", rpc.unkn_ext_hdr),
+	FBNIC_HW_STAT("rpc_ipv4_frag", rpc.ipv4_frag),
+	FBNIC_HW_STAT("rpc_ipv6_frag", rpc.ipv6_frag),
+	FBNIC_HW_STAT("rpc_ipv4_esp", rpc.ipv4_esp),
+	FBNIC_HW_STAT("rpc_ipv6_esp", rpc.ipv6_esp),
+	FBNIC_HW_STAT("rpc_tcp_opt_err", rpc.tcp_opt_err),
+	FBNIC_HW_STAT("rpc_out_of_hdr_err", rpc.out_of_hdr_err),
+};
+
+#define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
+#define FBNIC_HW_STATS_LEN	FBNIC_HW_FIXED_STATS_LEN
+
 static int
 fbnic_get_ts_info(struct net_device *netdev,
 		  struct kernel_ethtool_ts_info *tsinfo)
@@ -54,6 +85,43 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
 		*stat = counter->value;
 }
 
+static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
+{
+	int i;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
+			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
+		break;
+	}
+}
+
+static int fbnic_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return FBNIC_HW_STATS_LEN;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void fbnic_get_ethtool_stats(struct net_device *dev,
+				    struct ethtool_stats *stats, u64 *data)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	const struct fbnic_stat *stat;
+	int i;
+
+	fbnic_get_hw_stats(fbn->fbd);
+
+	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
+		stat = &fbnic_gstrings_hw_stats[i];
+		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
+	}
+}
+
 static void
 fbnic_get_eth_mac_stats(struct net_device *netdev,
 			struct ethtool_eth_mac_stats *eth_mac_stats)
@@ -138,6 +206,9 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_regs_len		= fbnic_get_regs_len,
 	.get_regs		= fbnic_get_regs,
+	.get_strings		= fbnic_get_strings,
+	.get_ethtool_stats	= fbnic_get_ethtool_stats,
+	.get_sset_count		= fbnic_get_sset_count,
 	.get_ts_info		= fbnic_get_ts_info,
 	.get_ts_stats		= fbnic_get_ts_stats,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index c391f2155054..89ac6bc8c7fc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -3,6 +3,27 @@
 
 #include "fbnic.h"
 
+static void fbnic_hw_stat_rst32(struct fbnic_dev *fbd, u32 reg,
+				struct fbnic_stat_counter *stat)
+{
+	/* We do not touch the "value" field here.
+	 * It gets zeroed out on fbd structure allocation.
+	 * After that we want it to grow continuously
+	 * through device resets and power state changes.
+	 */
+	stat->u.old_reg_value_32 = rd32(fbd, reg);
+}
+
+static void fbnic_hw_stat_rd32(struct fbnic_dev *fbd, u32 reg,
+			       struct fbnic_stat_counter *stat)
+{
+	u32 new_reg_value;
+
+	new_reg_value = rd32(fbd, reg);
+	stat->value += new_reg_value - stat->u.old_reg_value_32;
+	stat->u.old_reg_value_32 = new_reg_value;
+}
+
 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
 {
 	u32 prev_upper, upper, lower, diff;
@@ -49,6 +70,53 @@ static void fbnic_hw_stat_rd64(struct fbnic_dev *fbd, u32 reg, s32 offset,
 	stat->u.old_reg_value_64 = new_reg_value;
 }
 
+static void fbnic_reset_rpc_stats(struct fbnic_dev *fbd,
+				  struct fbnic_rpc_stats *rpc)
+{
+	fbnic_hw_stat_rst32(fbd,
+			    FBNIC_RPC_CNTR_UNKN_ETYPE,
+			    &rpc->unkn_etype);
+	fbnic_hw_stat_rst32(fbd,
+			    FBNIC_RPC_CNTR_UNKN_EXT_HDR,
+			    &rpc->unkn_ext_hdr);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RPC_CNTR_IPV4_FRAG, &rpc->ipv4_frag);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RPC_CNTR_IPV6_FRAG, &rpc->ipv6_frag);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RPC_CNTR_IPV4_ESP, &rpc->ipv4_esp);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RPC_CNTR_IPV6_ESP, &rpc->ipv6_esp);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RPC_CNTR_TCP_OPT_ERR, &rpc->tcp_opt_err);
+	fbnic_hw_stat_rst32(fbd,
+			    FBNIC_RPC_CNTR_OUT_OF_HDR_ERR,
+			    &rpc->out_of_hdr_err);
+	fbnic_hw_stat_rst32(fbd,
+			    FBNIC_RPC_CNTR_OVR_SIZE_ERR,
+			    &rpc->ovr_size_err);
+}
+
+static void fbnic_get_rpc_stats32(struct fbnic_dev *fbd,
+				  struct fbnic_rpc_stats *rpc)
+{
+	fbnic_hw_stat_rd32(fbd,
+			   FBNIC_RPC_CNTR_UNKN_ETYPE,
+			   &rpc->unkn_etype);
+	fbnic_hw_stat_rd32(fbd,
+			   FBNIC_RPC_CNTR_UNKN_EXT_HDR,
+			   &rpc->unkn_ext_hdr);
+
+	fbnic_hw_stat_rd32(fbd, FBNIC_RPC_CNTR_IPV4_FRAG, &rpc->ipv4_frag);
+	fbnic_hw_stat_rd32(fbd, FBNIC_RPC_CNTR_IPV6_FRAG, &rpc->ipv6_frag);
+
+	fbnic_hw_stat_rd32(fbd, FBNIC_RPC_CNTR_IPV4_ESP, &rpc->ipv4_esp);
+	fbnic_hw_stat_rd32(fbd, FBNIC_RPC_CNTR_IPV6_ESP, &rpc->ipv6_esp);
+
+	fbnic_hw_stat_rd32(fbd, FBNIC_RPC_CNTR_TCP_OPT_ERR, &rpc->tcp_opt_err);
+	fbnic_hw_stat_rd32(fbd,
+			   FBNIC_RPC_CNTR_OUT_OF_HDR_ERR,
+			   &rpc->out_of_hdr_err);
+	fbnic_hw_stat_rd32(fbd,
+			   FBNIC_RPC_CNTR_OVR_SIZE_ERR,
+			   &rpc->ovr_size_err);
+}
+
 static void fbnic_reset_pcie_stats_asic(struct fbnic_dev *fbd,
 					struct fbnic_pcie_stats *pcie)
 {
@@ -135,10 +203,18 @@ static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
 
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
+	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
 }
 
+void fbnic_get_hw_stats32(struct fbnic_dev *fbd)
+{
+	fbnic_get_rpc_stats32(fbd, &fbd->hw_stats.rpc);
+}
+
 void fbnic_get_hw_stats(struct fbnic_dev *fbd)
 {
+	fbnic_get_hw_stats32(fbd);
+
 	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index b152c6b1b4ab..78df56b87745 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -37,6 +37,12 @@ struct fbnic_mac_stats {
 	struct fbnic_eth_mac_stats eth_mac;
 };
 
+struct fbnic_rpc_stats {
+	struct fbnic_stat_counter unkn_etype, unkn_ext_hdr;
+	struct fbnic_stat_counter ipv4_frag, ipv6_frag, ipv4_esp, ipv6_esp;
+	struct fbnic_stat_counter tcp_opt_err, out_of_hdr_err, ovr_size_err;
+};
+
 struct fbnic_pcie_stats {
 	struct fbnic_stat_counter ob_rd_tlp, ob_rd_dword;
 	struct fbnic_stat_counter ob_wr_tlp, ob_wr_dword;
@@ -49,12 +55,14 @@ struct fbnic_pcie_stats {
 
 struct fbnic_hw_stats {
 	struct fbnic_mac_stats mac;
+	struct fbnic_rpc_stats rpc;
 	struct fbnic_pcie_stats pcie;
 };
 
 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);
 
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd);
+void fbnic_get_hw_stats32(struct fbnic_dev *fbd);
 void fbnic_get_hw_stats(struct fbnic_dev *fbd);
 
 #endif /* _FBNIC_HW_STATS_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 0aa95160f006..32702dc4a066 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -199,6 +199,8 @@ static void fbnic_service_task(struct work_struct *work)
 
 	rtnl_lock();
 
+	fbnic_get_hw_stats32(fbd);
+
 	fbnic_fw_check_heartbeat(fbd);
 
 	fbnic_health_check(fbd);
-- 
2.47.0


