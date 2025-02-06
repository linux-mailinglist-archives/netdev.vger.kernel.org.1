Return-Path: <netdev+bounces-163715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482B6A2B6DA
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C7C7A3799
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2A723AE97;
	Thu,  6 Feb 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1C/JFVb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A923AE8F
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886022; cv=none; b=msr9NneMKG61r1sCmPS1IjaT3Yk94xbYfeFbiHY6pirsWWDyhGSl+63gBDffkJaKjDuSMKY8I45lCYOERQ9EBSfsYmSHyac1JzKT577upau99W5/o8f+TeMH/2Ct3sqMtQvqK5IrxMqyy+H7uwbSQbAq3UGdwYBtGEGsbFS6tTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886022; c=relaxed/simple;
	bh=GH6g+jn8IKmo3zJYgkCnj9NQsg74hRPTBHnWVwXxQ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7sftNCasiYV18wjnuC8fjLTo92lYLSaOaPGHOx7M1Drd5tuYGCB33kZvevn8H0glvEMj56MeASvL8siVCQjDWNATEj0fkAL4jOtSSSg7z92kQqUQ0OIKj0x92uqpYd5iZaRP16HPfx6P5yqPQoJfG35Xb6PK3VUZq+Ddi3bkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1C/JFVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640B9C4CEDD;
	Thu,  6 Feb 2025 23:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738886021;
	bh=GH6g+jn8IKmo3zJYgkCnj9NQsg74hRPTBHnWVwXxQ1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1C/JFVbzcs9xcJlYcUG1jh2Dbc+Qh0BVIx+6KNOYymdT9UqkejFqI4q00L+v3EKv
	 pJXTKZULeKuPFzUMLBLdnlWd6ndbenU8pCjLjBrxRTBYdQ/ZBMOAp3eeqcV4zPg3l5
	 voBIOuX5DGwnwWZXByNkF7ZOgpofDRdnMUobS0p2AJCovCc+apwnbhAJOEmdVALq+G
	 mkn4lmvmpYO7eOwaJRryrqwd9EU5s7YfBrYERU84CJcXQMxG4j5LrFP5rl4Cpw6vok
	 rMvjDYgSDxeYGaqXB1AETBo6qGv0lFZgor4002AxuIg6+3iCPnawI0/DmAotN/A4Kf
	 20lWBYELaaX9w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/7] eth: fbnic: support n-tuple filters
Date: Thu,  6 Feb 2025 15:53:32 -0800
Message-ID: <20250206235334.1425329-6-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206235334.1425329-1-kuba@kernel.org>
References: <20250206235334.1425329-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@fb.com>

Add ethtool -n / -N support. Support only "un-ordered" rule sets
(RX_CLS_LOC_ANY), just for simplicity of the code. It's unclear
anyone actually cares about the rule ordering.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |   9 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 646 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +-
 5 files changed, 660 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index d5e9b11ed2f8..6f24c5f2e175 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -605,8 +605,11 @@ enum {
 	FBNIC_RPC_ACT_TBL0_DEST_EI	= 4,
 };
 
+#define FBNIC_RPC_ACT_TBL0_Q_SEL		CSR_BIT(4)
+#define FBNIC_RPC_ACT_TBL0_Q_ID			CSR_GENMASK(15, 8)
 #define FBNIC_RPC_ACT_TBL0_DMA_HINT		CSR_GENMASK(24, 16)
 #define FBNIC_RPC_ACT_TBL0_TS_ENA		CSR_BIT(28)
+#define FBNIC_RPC_ACT_TBL0_ACT_TBL_IDX		CSR_BIT(29)
 #define FBNIC_RPC_ACT_TBL0_RSS_CTXT_ID		CSR_BIT(30)
 
 #define FBNIC_RPC_ACT_TBL1_DEFAULT	0x0840b		/* 0x2102c */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
index b3515f2f5f92..6892414195c3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
@@ -96,6 +96,11 @@ enum {
 #define FBNIC_RPC_ACT_TBL_BMC_OFFSET		0
 #define FBNIC_RPC_ACT_TBL_BMC_ALL_MULTI_OFFSET	1
 
+/* This should leave us with 48 total entries in the TCAM that can be used
+ * for NFC after also deducting the 14 needed for RSS table programming.
+ */
+#define FBNIC_RPC_ACT_TBL_NFC_OFFSET		2
+
 /* We reserve the last 14 entries for RSS rules on the host. The BMC
  * unicast rule will need to be populated above these and is expected to
  * use MACDA TCAM entry 23 to store the BMC MAC address.
@@ -103,6 +108,9 @@ enum {
 #define FBNIC_RPC_ACT_TBL_RSS_OFFSET \
 	(FBNIC_RPC_ACT_TBL_NUM_ENTRIES - FBNIC_RSS_EN_NUM_ENTRIES)
 
+#define FBNIC_RPC_ACT_TBL_NFC_ENTRIES \
+	(FBNIC_RPC_ACT_TBL_RSS_OFFSET - FBNIC_RPC_ACT_TBL_NFC_OFFSET)
+
 /* Flags used to identify the owner for this MAC filter. Note that any
  * flags set for Broadcast thru Promisc indicate that the rule belongs
  * to the RSS filters for the host.
@@ -183,6 +191,7 @@ void fbnic_rss_init_en_mask(struct fbnic_net *fbn);
 void fbnic_rss_disable_hw(struct fbnic_dev *fbd);
 void fbnic_rss_reinit_hw(struct fbnic_dev *fbd, struct fbnic_net *fbn);
 void fbnic_rss_reinit(struct fbnic_dev *fbd, struct fbnic_net *fbn);
+u16 fbnic_flow_hash_2_rss_en_mask(struct fbnic_net *fbn, int flow_type);
 
 int __fbnic_xc_unsync(struct fbnic_mac_addr *mac_addr, unsigned int tcam_idx);
 struct fbnic_mac_addr *__fbnic_uc_sync(struct fbnic_dev *fbd,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 4d73b405c8b9..9503c36620c6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -4,6 +4,7 @@
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <net/ipv6.h>
 
 #include "fbnic.h"
 #include "fbnic_netdev.h"
@@ -218,11 +219,234 @@ fbnic_get_rss_hash_opts(struct fbnic_net *fbn, struct ethtool_rxnfc *cmd)
 	return 0;
 }
 
+static int fbnic_get_cls_rule_all(struct fbnic_net *fbn,
+				  struct ethtool_rxnfc *cmd,
+				  u32 *rule_locs)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	int i, cnt = 0;
+
+	/* Report maximum rule count */
+	cmd->data = FBNIC_RPC_ACT_TBL_NFC_ENTRIES;
+
+	for (i = 0; i < FBNIC_RPC_ACT_TBL_NFC_ENTRIES; i++) {
+		int idx = i + FBNIC_RPC_ACT_TBL_NFC_OFFSET;
+		struct fbnic_act_tcam *act_tcam;
+
+		act_tcam = &fbd->act_tcam[idx];
+		if (act_tcam->state != FBNIC_TCAM_S_VALID)
+			continue;
+
+		if (rule_locs) {
+			if (cnt == cmd->rule_cnt)
+				return -EMSGSIZE;
+
+			rule_locs[cnt] = i;
+		}
+
+		cnt++;
+	}
+
+	return cnt;
+}
+
+static int fbnic_get_cls_rule(struct fbnic_net *fbn, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp;
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct fbnic_act_tcam *act_tcam;
+	int idx;
+
+	fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+
+	if (fsp->location >= FBNIC_RPC_ACT_TBL_NFC_ENTRIES)
+		return -EINVAL;
+
+	idx = fsp->location + FBNIC_RPC_ACT_TBL_NFC_OFFSET;
+	act_tcam = &fbd->act_tcam[idx];
+
+	if (act_tcam->state != FBNIC_TCAM_S_VALID)
+		return -EINVAL;
+
+	/* Report maximum rule count */
+	cmd->data = FBNIC_RPC_ACT_TBL_NFC_ENTRIES;
+
+	/* Set flow type field */
+	if (!(act_tcam->value.tcam[1] & FBNIC_RPC_TCAM_ACT1_IP_VALID)) {
+		fsp->flow_type = ETHER_FLOW;
+		if (!FIELD_GET(FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX,
+			       act_tcam->mask.tcam[1])) {
+			struct fbnic_mac_addr *mac_addr;
+
+			idx = FIELD_GET(FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX,
+					act_tcam->value.tcam[1]);
+			mac_addr = &fbd->mac_addr[idx];
+
+			ether_addr_copy(fsp->h_u.ether_spec.h_dest,
+					mac_addr->value.addr8);
+			eth_broadcast_addr(fsp->m_u.ether_spec.h_dest);
+		}
+	} else if (act_tcam->value.tcam[1] &
+		   FBNIC_RPC_TCAM_ACT1_OUTER_IP_VALID) {
+		fsp->flow_type = IPV6_USER_FLOW;
+		fsp->h_u.usr_ip6_spec.l4_proto = IPPROTO_IPV6;
+		fsp->m_u.usr_ip6_spec.l4_proto = 0xff;
+
+		if (!FIELD_GET(FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_IDX,
+			       act_tcam->mask.tcam[0])) {
+			struct fbnic_ip_addr *ip_addr;
+			int i;
+
+			idx = FIELD_GET(FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_IDX,
+					act_tcam->value.tcam[0]);
+			ip_addr = &fbd->ipo_src[idx];
+
+			for (i = 0; i < 4; i++) {
+				fsp->h_u.usr_ip6_spec.ip6src[i] =
+					ip_addr->value.s6_addr32[i];
+				fsp->m_u.usr_ip6_spec.ip6src[i] =
+					~ip_addr->mask.s6_addr32[i];
+			}
+		}
+
+		if (!FIELD_GET(FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_IDX,
+			       act_tcam->mask.tcam[0])) {
+			struct fbnic_ip_addr *ip_addr;
+			int i;
+
+			idx = FIELD_GET(FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_IDX,
+					act_tcam->value.tcam[0]);
+			ip_addr = &fbd->ipo_dst[idx];
+
+			for (i = 0; i < 4; i++) {
+				fsp->h_u.usr_ip6_spec.ip6dst[i] =
+					ip_addr->value.s6_addr32[i];
+				fsp->m_u.usr_ip6_spec.ip6dst[i] =
+					~ip_addr->mask.s6_addr32[i];
+			}
+		}
+	} else if ((act_tcam->value.tcam[1] & FBNIC_RPC_TCAM_ACT1_IP_IS_V6)) {
+		if (act_tcam->value.tcam[1] & FBNIC_RPC_TCAM_ACT1_L4_VALID) {
+			if (act_tcam->value.tcam[1] &
+			    FBNIC_RPC_TCAM_ACT1_L4_IS_UDP)
+				fsp->flow_type = UDP_V6_FLOW;
+			else
+				fsp->flow_type = TCP_V6_FLOW;
+			fsp->h_u.tcp_ip6_spec.psrc =
+				cpu_to_be16(act_tcam->value.tcam[3]);
+			fsp->m_u.tcp_ip6_spec.psrc =
+				cpu_to_be16(~act_tcam->mask.tcam[3]);
+			fsp->h_u.tcp_ip6_spec.pdst =
+				cpu_to_be16(act_tcam->value.tcam[4]);
+			fsp->m_u.tcp_ip6_spec.pdst =
+				cpu_to_be16(~act_tcam->mask.tcam[4]);
+		} else {
+			fsp->flow_type = IPV6_USER_FLOW;
+		}
+
+		if (!FIELD_GET(FBNIC_RPC_TCAM_ACT0_IPSRC_IDX,
+			       act_tcam->mask.tcam[0])) {
+			struct fbnic_ip_addr *ip_addr;
+			int i;
+
+			idx = FIELD_GET(FBNIC_RPC_TCAM_ACT0_IPSRC_IDX,
+					act_tcam->value.tcam[0]);
+			ip_addr = &fbd->ip_src[idx];
+
+			for (i = 0; i < 4; i++) {
+				fsp->h_u.usr_ip6_spec.ip6src[i] =
+					ip_addr->value.s6_addr32[i];
+				fsp->m_u.usr_ip6_spec.ip6src[i] =
+					~ip_addr->mask.s6_addr32[i];
+			}
+		}
+
+		if (!FIELD_GET(FBNIC_RPC_TCAM_ACT0_IPDST_IDX,
+			       act_tcam->mask.tcam[0])) {
+			struct fbnic_ip_addr *ip_addr;
+			int i;
+
+			idx = FIELD_GET(FBNIC_RPC_TCAM_ACT0_IPDST_IDX,
+					act_tcam->value.tcam[0]);
+			ip_addr = &fbd->ip_dst[idx];
+
+			for (i = 0; i < 4; i++) {
+				fsp->h_u.usr_ip6_spec.ip6dst[i] =
+					ip_addr->value.s6_addr32[i];
+				fsp->m_u.usr_ip6_spec.ip6dst[i] =
+					~ip_addr->mask.s6_addr32[i];
+			}
+		}
+	} else {
+		if (act_tcam->value.tcam[1] & FBNIC_RPC_TCAM_ACT1_L4_VALID) {
+			if (act_tcam->value.tcam[1] &
+			    FBNIC_RPC_TCAM_ACT1_L4_IS_UDP)
+				fsp->flow_type = UDP_V4_FLOW;
+			else
+				fsp->flow_type = TCP_V4_FLOW;
+			fsp->h_u.tcp_ip4_spec.psrc =
+				cpu_to_be16(act_tcam->value.tcam[3]);
+			fsp->m_u.tcp_ip4_spec.psrc =
+				cpu_to_be16(~act_tcam->mask.tcam[3]);
+			fsp->h_u.tcp_ip4_spec.pdst =
+				cpu_to_be16(act_tcam->value.tcam[4]);
+			fsp->m_u.tcp_ip4_spec.pdst =
+				cpu_to_be16(~act_tcam->mask.tcam[4]);
+		} else {
+			fsp->flow_type = IPV4_USER_FLOW;
+			fsp->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
+		}
+
+		if (!FIELD_GET(FBNIC_RPC_TCAM_ACT0_IPSRC_IDX,
+			       act_tcam->mask.tcam[0])) {
+			struct fbnic_ip_addr *ip_addr;
+
+			idx = FIELD_GET(FBNIC_RPC_TCAM_ACT0_IPSRC_IDX,
+					act_tcam->value.tcam[0]);
+			ip_addr = &fbd->ip_src[idx];
+
+			fsp->h_u.usr_ip4_spec.ip4src =
+				ip_addr->value.s6_addr32[3];
+			fsp->m_u.usr_ip4_spec.ip4src =
+				~ip_addr->mask.s6_addr32[3];
+		}
+
+		if (!FIELD_GET(FBNIC_RPC_TCAM_ACT0_IPDST_IDX,
+			       act_tcam->mask.tcam[0])) {
+			struct fbnic_ip_addr *ip_addr;
+
+			idx = FIELD_GET(FBNIC_RPC_TCAM_ACT0_IPDST_IDX,
+					act_tcam->value.tcam[0]);
+			ip_addr = &fbd->ip_dst[idx];
+
+			fsp->h_u.usr_ip4_spec.ip4dst =
+				ip_addr->value.s6_addr32[3];
+			fsp->m_u.usr_ip4_spec.ip4dst =
+				~ip_addr->mask.s6_addr32[3];
+		}
+	}
+
+	/* Record action */
+	if (act_tcam->dest & FBNIC_RPC_ACT_TBL0_DROP)
+		fsp->ring_cookie = RX_CLS_FLOW_DISC;
+	else if (act_tcam->dest & FBNIC_RPC_ACT_TBL0_Q_SEL)
+		fsp->ring_cookie = FIELD_GET(FBNIC_RPC_ACT_TBL0_Q_ID,
+					     act_tcam->dest);
+	else
+		fsp->flow_type |= FLOW_RSS;
+
+	cmd->rss_context = FIELD_GET(FBNIC_RPC_ACT_TBL0_RSS_CTXT_ID,
+				     act_tcam->dest);
+
+	return 0;
+}
+
 static int fbnic_get_rxnfc(struct net_device *netdev,
 			   struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	int ret = -EOPNOTSUPP;
+	u32 special = 0;
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
@@ -232,6 +456,22 @@ static int fbnic_get_rxnfc(struct net_device *netdev,
 	case ETHTOOL_GRXFH:
 		ret = fbnic_get_rss_hash_opts(fbn, cmd);
 		break;
+	case ETHTOOL_GRXCLSRULE:
+		ret = fbnic_get_cls_rule(fbn, cmd);
+		break;
+	case ETHTOOL_GRXCLSRLCNT:
+		rule_locs = NULL;
+		special = RX_CLS_LOC_SPECIAL;
+		fallthrough;
+	case ETHTOOL_GRXCLSRLALL:
+		ret = fbnic_get_cls_rule_all(fbn, cmd, rule_locs);
+		if (ret < 0)
+			break;
+
+		cmd->data |= special;
+		cmd->rule_cnt = ret;
+		ret = 0;
+		break;
 	}
 
 	return ret;
@@ -272,6 +512,406 @@ fbnic_set_rss_hash_opts(struct fbnic_net *fbn, const struct ethtool_rxnfc *cmd)
 	return 0;
 }
 
+static int fbnic_cls_rule_any_loc(struct fbnic_dev *fbd)
+{
+	int i;
+
+	for (i = FBNIC_RPC_ACT_TBL_NFC_ENTRIES; i--;) {
+		int idx = i + FBNIC_RPC_ACT_TBL_NFC_OFFSET;
+
+		if (fbd->act_tcam[idx].state != FBNIC_TCAM_S_VALID)
+			return i;
+	}
+
+	return -ENOSPC;
+}
+
+static int fbnic_set_cls_rule_ins(struct fbnic_net *fbn,
+				  const struct ethtool_rxnfc *cmd)
+{
+	u16 flow_value = 0, flow_mask = 0xffff, ip_value = 0, ip_mask = 0xffff;
+	u16 sport = 0, sport_mask = ~0, dport = 0, dport_mask = ~0;
+	u16 misc = 0, misc_mask = ~0;
+	u32 dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
+			      FBNIC_RPC_ACT_TBL0_DEST_HOST);
+	struct fbnic_ip_addr *ip_src = NULL, *ip_dst = NULL;
+	struct fbnic_mac_addr *mac_addr = NULL;
+	struct ethtool_rx_flow_spec *fsp;
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct fbnic_act_tcam *act_tcam;
+	struct in6_addr *addr6, *mask6;
+	struct in_addr *addr4, *mask4;
+	int hash_idx, location;
+	u32 flow_type;
+	int idx, j;
+
+	fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+
+	if (fsp->location != RX_CLS_LOC_ANY)
+		return -EINVAL;
+	location = fbnic_cls_rule_any_loc(fbd);
+	if (location < 0)
+		return location;
+
+	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
+		dest = FBNIC_RPC_ACT_TBL0_DROP;
+	} else if (fsp->flow_type & FLOW_RSS) {
+		if (cmd->rss_context == 1)
+			dest |= FBNIC_RPC_ACT_TBL0_RSS_CTXT_ID;
+	} else {
+		u32 ring_idx = ethtool_get_flow_spec_ring(fsp->ring_cookie);
+
+		if (ring_idx >= fbn->num_rx_queues)
+			return -EINVAL;
+
+		dest |= FBNIC_RPC_ACT_TBL0_Q_SEL |
+			FIELD_PREP(FBNIC_RPC_ACT_TBL0_Q_ID, ring_idx);
+	}
+
+	idx = location + FBNIC_RPC_ACT_TBL_NFC_OFFSET;
+	act_tcam = &fbd->act_tcam[idx];
+
+	/* Do not allow overwriting for now.
+	 * To support overwriting rules we will need to add logic to free
+	 * any IP or MACDA TCAMs that may be associated with the old rule.
+	 */
+	if (act_tcam->state != FBNIC_TCAM_S_DISABLED)
+		return -EBUSY;
+
+	flow_type = fsp->flow_type & ~(FLOW_EXT | FLOW_RSS);
+	hash_idx = fbnic_get_rss_hash_idx(flow_type);
+
+	switch (flow_type) {
+	case UDP_V4_FLOW:
+udp4_flow:
+		flow_value |= FBNIC_RPC_TCAM_ACT1_L4_IS_UDP;
+		fallthrough;
+	case TCP_V4_FLOW:
+tcp4_flow:
+		flow_value |= FBNIC_RPC_TCAM_ACT1_L4_VALID;
+		flow_mask &= ~(FBNIC_RPC_TCAM_ACT1_L4_IS_UDP |
+			       FBNIC_RPC_TCAM_ACT1_L4_VALID);
+
+		sport = be16_to_cpu(fsp->h_u.tcp_ip4_spec.psrc);
+		sport_mask = ~be16_to_cpu(fsp->m_u.tcp_ip4_spec.psrc);
+		dport = be16_to_cpu(fsp->h_u.tcp_ip4_spec.pdst);
+		dport_mask = ~be16_to_cpu(fsp->m_u.tcp_ip4_spec.pdst);
+		goto ip4_flow;
+	case IP_USER_FLOW:
+		if (!fsp->m_u.usr_ip4_spec.proto)
+			goto ip4_flow;
+		if (fsp->m_u.usr_ip4_spec.proto != 0xff)
+			return -EINVAL;
+		if (fsp->h_u.usr_ip4_spec.proto == IPPROTO_UDP)
+			goto udp4_flow;
+		if (fsp->h_u.usr_ip4_spec.proto == IPPROTO_TCP)
+			goto tcp4_flow;
+		return -EINVAL;
+ip4_flow:
+		addr4 = (struct in_addr *)&fsp->h_u.usr_ip4_spec.ip4src;
+		mask4 = (struct in_addr *)&fsp->m_u.usr_ip4_spec.ip4src;
+		if (mask4->s_addr) {
+			ip_src = __fbnic_ip4_sync(fbd, fbd->ip_src,
+						  addr4, mask4);
+			if (!ip_src)
+				return -ENOSPC;
+
+			set_bit(idx, ip_src->act_tcam);
+			ip_value |= FBNIC_RPC_TCAM_ACT0_IPSRC_VALID |
+				    FIELD_PREP(FBNIC_RPC_TCAM_ACT0_IPSRC_IDX,
+					       ip_src - fbd->ip_src);
+			ip_mask &= ~(FBNIC_RPC_TCAM_ACT0_IPSRC_VALID |
+				     FBNIC_RPC_TCAM_ACT0_IPSRC_IDX);
+		}
+
+		addr4 = (struct in_addr *)&fsp->h_u.usr_ip4_spec.ip4dst;
+		mask4 = (struct in_addr *)&fsp->m_u.usr_ip4_spec.ip4dst;
+		if (mask4->s_addr) {
+			ip_dst = __fbnic_ip4_sync(fbd, fbd->ip_dst,
+						  addr4, mask4);
+			if (!ip_dst) {
+				if (ip_src && ip_src->state == FBNIC_TCAM_S_ADD)
+					memset(ip_src, 0, sizeof(*ip_src));
+				return -ENOSPC;
+			}
+
+			set_bit(idx, ip_dst->act_tcam);
+			ip_value |= FBNIC_RPC_TCAM_ACT0_IPDST_VALID |
+				    FIELD_PREP(FBNIC_RPC_TCAM_ACT0_IPDST_IDX,
+					       ip_dst - fbd->ip_dst);
+			ip_mask &= ~(FBNIC_RPC_TCAM_ACT0_IPDST_VALID |
+				     FBNIC_RPC_TCAM_ACT0_IPDST_IDX);
+		}
+		flow_value |= FBNIC_RPC_TCAM_ACT1_IP_VALID |
+			      FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+		flow_mask &= ~(FBNIC_RPC_TCAM_ACT1_IP_IS_V6 |
+			       FBNIC_RPC_TCAM_ACT1_IP_VALID |
+			       FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID);
+		break;
+	case UDP_V6_FLOW:
+udp6_flow:
+		flow_value |= FBNIC_RPC_TCAM_ACT1_L4_IS_UDP;
+		fallthrough;
+	case TCP_V6_FLOW:
+tcp6_flow:
+		flow_value |= FBNIC_RPC_TCAM_ACT1_L4_VALID;
+		flow_mask &= ~(FBNIC_RPC_TCAM_ACT1_L4_IS_UDP |
+			  FBNIC_RPC_TCAM_ACT1_L4_VALID);
+
+		sport = be16_to_cpu(fsp->h_u.tcp_ip6_spec.psrc);
+		sport_mask = ~be16_to_cpu(fsp->m_u.tcp_ip6_spec.psrc);
+		dport = be16_to_cpu(fsp->h_u.tcp_ip6_spec.pdst);
+		dport_mask = ~be16_to_cpu(fsp->m_u.tcp_ip6_spec.pdst);
+		goto ipv6_flow;
+	case IPV6_USER_FLOW:
+		if (!fsp->m_u.usr_ip6_spec.l4_proto)
+			goto ipv6_flow;
+
+		if (fsp->m_u.usr_ip6_spec.l4_proto != 0xff)
+			return -EINVAL;
+		if (fsp->h_u.usr_ip6_spec.l4_proto == IPPROTO_UDP)
+			goto udp6_flow;
+		if (fsp->h_u.usr_ip6_spec.l4_proto == IPPROTO_TCP)
+			goto tcp6_flow;
+		if (fsp->h_u.usr_ip6_spec.l4_proto != IPPROTO_IPV6)
+			return -EINVAL;
+
+		addr6 = (struct in6_addr *)fsp->h_u.usr_ip6_spec.ip6src;
+		mask6 = (struct in6_addr *)fsp->m_u.usr_ip6_spec.ip6src;
+		if (!ipv6_addr_any(mask6)) {
+			ip_src = __fbnic_ip6_sync(fbd, fbd->ipo_src,
+						  addr6, mask6);
+			if (!ip_src)
+				return -ENOSPC;
+
+			set_bit(idx, ip_src->act_tcam);
+			ip_value |=
+				FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_VALID |
+				FIELD_PREP(FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_IDX,
+					   ip_src - fbd->ipo_src);
+			ip_mask &=
+				~(FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_VALID |
+				  FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_IDX);
+		}
+
+		addr6 = (struct in6_addr *)fsp->h_u.usr_ip6_spec.ip6dst;
+		mask6 = (struct in6_addr *)fsp->m_u.usr_ip6_spec.ip6dst;
+		if (!ipv6_addr_any(mask6)) {
+			ip_dst = __fbnic_ip6_sync(fbd, fbd->ipo_dst,
+						  addr6, mask6);
+			if (!ip_dst) {
+				if (ip_src && ip_src->state == FBNIC_TCAM_S_ADD)
+					memset(ip_src, 0, sizeof(*ip_src));
+				return -ENOSPC;
+			}
+
+			set_bit(idx, ip_dst->act_tcam);
+			ip_value |=
+				FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_VALID |
+				FIELD_PREP(FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_IDX,
+					   ip_dst - fbd->ipo_dst);
+			ip_mask &= ~(FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_VALID |
+				     FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_IDX);
+		}
+
+		flow_value |= FBNIC_RPC_TCAM_ACT1_OUTER_IP_VALID;
+		flow_mask &= FBNIC_RPC_TCAM_ACT1_OUTER_IP_VALID;
+ipv6_flow:
+		addr6 = (struct in6_addr *)fsp->h_u.usr_ip6_spec.ip6src;
+		mask6 = (struct in6_addr *)fsp->m_u.usr_ip6_spec.ip6src;
+		if (!ip_src && !ipv6_addr_any(mask6)) {
+			ip_src = __fbnic_ip6_sync(fbd, fbd->ip_src,
+						  addr6, mask6);
+			if (!ip_src)
+				return -ENOSPC;
+
+			set_bit(idx, ip_src->act_tcam);
+			ip_value |= FBNIC_RPC_TCAM_ACT0_IPSRC_VALID |
+				    FIELD_PREP(FBNIC_RPC_TCAM_ACT0_IPSRC_IDX,
+					       ip_src - fbd->ip_src);
+			ip_mask &= ~(FBNIC_RPC_TCAM_ACT0_IPSRC_VALID |
+				       FBNIC_RPC_TCAM_ACT0_IPSRC_IDX);
+		}
+
+		addr6 = (struct in6_addr *)fsp->h_u.usr_ip6_spec.ip6dst;
+		mask6 = (struct in6_addr *)fsp->m_u.usr_ip6_spec.ip6dst;
+		if (!ip_dst && !ipv6_addr_any(mask6)) {
+			ip_dst = __fbnic_ip6_sync(fbd, fbd->ip_dst,
+						  addr6, mask6);
+			if (!ip_dst) {
+				if (ip_src && ip_src->state == FBNIC_TCAM_S_ADD)
+					memset(ip_src, 0, sizeof(*ip_src));
+				return -ENOSPC;
+			}
+
+			set_bit(idx, ip_dst->act_tcam);
+			ip_value |= FBNIC_RPC_TCAM_ACT0_IPDST_VALID |
+				    FIELD_PREP(FBNIC_RPC_TCAM_ACT0_IPDST_IDX,
+					       ip_dst - fbd->ip_dst);
+			ip_mask &= ~(FBNIC_RPC_TCAM_ACT0_IPDST_VALID |
+				       FBNIC_RPC_TCAM_ACT0_IPDST_IDX);
+		}
+
+		flow_value |= FBNIC_RPC_TCAM_ACT1_IP_IS_V6 |
+			      FBNIC_RPC_TCAM_ACT1_IP_VALID |
+			      FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+		flow_mask &= ~(FBNIC_RPC_TCAM_ACT1_IP_IS_V6 |
+			       FBNIC_RPC_TCAM_ACT1_IP_VALID |
+			       FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID);
+		break;
+	case ETHER_FLOW:
+		if (!is_zero_ether_addr(fsp->m_u.ether_spec.h_dest)) {
+			u8 *addr = fsp->h_u.ether_spec.h_dest;
+			u8 *mask = fsp->m_u.ether_spec.h_dest;
+
+			/* Do not allow MAC addr of 0 */
+			if (is_zero_ether_addr(addr))
+				return -EINVAL;
+
+			/* Only support full MAC address to avoid
+			 * conflicts with other MAC addresses.
+			 */
+			if (!is_broadcast_ether_addr(mask))
+				return -EINVAL;
+
+			if (is_multicast_ether_addr(addr))
+				mac_addr = __fbnic_mc_sync(fbd, addr);
+			else
+				mac_addr = __fbnic_uc_sync(fbd, addr);
+
+			if (!mac_addr)
+				return -ENOSPC;
+
+			set_bit(idx, mac_addr->act_tcam);
+			flow_value |=
+				FIELD_PREP(FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX,
+					   mac_addr - fbd->mac_addr);
+			flow_mask &= ~FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX;
+		}
+
+		flow_value |= FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+		flow_mask &= ~FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Write action table values */
+	act_tcam->dest = dest;
+	act_tcam->rss_en_mask = fbnic_flow_hash_2_rss_en_mask(fbn, hash_idx);
+
+	/* Write IP Match value/mask to action_tcam[0] */
+	act_tcam->value.tcam[0] = ip_value;
+	act_tcam->mask.tcam[0] = ip_mask;
+
+	/* Write flow type value/mask to action_tcam[1] */
+	act_tcam->value.tcam[1] = flow_value;
+	act_tcam->mask.tcam[1] = flow_mask;
+
+	/* Write error, DSCP, extra L4 matches to action_tcam[2] */
+	act_tcam->value.tcam[2] = misc;
+	act_tcam->mask.tcam[2] = misc_mask;
+
+	/* Write source/destination port values */
+	act_tcam->value.tcam[3] = sport;
+	act_tcam->mask.tcam[3] = sport_mask;
+	act_tcam->value.tcam[4] = dport;
+	act_tcam->mask.tcam[4] = dport_mask;
+
+	for (j = 5; j < FBNIC_RPC_TCAM_ACT_WORD_LEN; j++)
+		act_tcam->mask.tcam[j] = 0xffff;
+
+	act_tcam->state = FBNIC_TCAM_S_UPDATE;
+	fsp->location = location;
+
+	if (netif_running(fbn->netdev)) {
+		fbnic_write_rules(fbd);
+		if (ip_src || ip_dst)
+			fbnic_write_ip_addr(fbd);
+		if (mac_addr)
+			fbnic_write_macda(fbd);
+	}
+
+	return 0;
+}
+
+static void fbnic_clear_nfc_macda(struct fbnic_net *fbn,
+				  unsigned int tcam_idx)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;)
+		__fbnic_xc_unsync(&fbd->mac_addr[idx], tcam_idx);
+
+	/* Write updates to hardware */
+	if (netif_running(fbn->netdev))
+		fbnic_write_macda(fbd);
+}
+
+static void fbnic_clear_nfc_ip_addr(struct fbnic_net *fbn,
+				    unsigned int tcam_idx)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->ip_src); idx--;)
+		__fbnic_ip_unsync(&fbd->ip_src[idx], tcam_idx);
+	for (idx = ARRAY_SIZE(fbd->ip_dst); idx--;)
+		__fbnic_ip_unsync(&fbd->ip_dst[idx], tcam_idx);
+	for (idx = ARRAY_SIZE(fbd->ipo_src); idx--;)
+		__fbnic_ip_unsync(&fbd->ipo_src[idx], tcam_idx);
+	for (idx = ARRAY_SIZE(fbd->ipo_dst); idx--;)
+		__fbnic_ip_unsync(&fbd->ipo_dst[idx], tcam_idx);
+
+	/* Write updates to hardware */
+	if (netif_running(fbn->netdev))
+		fbnic_write_ip_addr(fbd);
+}
+
+static int fbnic_set_cls_rule_del(struct fbnic_net *fbn,
+				  const struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp;
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct fbnic_act_tcam *act_tcam;
+	int idx;
+
+	fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+
+	if (fsp->location >= FBNIC_RPC_ACT_TBL_NFC_ENTRIES)
+		return -EINVAL;
+
+	idx = fsp->location + FBNIC_RPC_ACT_TBL_NFC_OFFSET;
+	act_tcam = &fbd->act_tcam[idx];
+
+	if (act_tcam->state != FBNIC_TCAM_S_VALID)
+		return -EINVAL;
+
+	act_tcam->state = FBNIC_TCAM_S_DELETE;
+
+	if ((act_tcam->value.tcam[1] & FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID) &&
+	    (~act_tcam->mask.tcam[1] & FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX))
+		fbnic_clear_nfc_macda(fbn, idx);
+
+	if ((act_tcam->value.tcam[0] &
+	     (FBNIC_RPC_TCAM_ACT0_IPSRC_VALID |
+	      FBNIC_RPC_TCAM_ACT0_IPDST_VALID |
+	      FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_VALID |
+	      FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_VALID)) &&
+	    (~act_tcam->mask.tcam[0] &
+	     (FBNIC_RPC_TCAM_ACT0_IPSRC_IDX |
+	      FBNIC_RPC_TCAM_ACT0_IPDST_IDX |
+	      FBNIC_RPC_TCAM_ACT0_OUTER_IPSRC_IDX |
+	      FBNIC_RPC_TCAM_ACT0_OUTER_IPDST_IDX)))
+		fbnic_clear_nfc_ip_addr(fbn, idx);
+
+	if (netif_running(fbn->netdev))
+		fbnic_write_rules(fbd);
+
+	return 0;
+}
+
 static int fbnic_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
@@ -281,6 +921,12 @@ static int fbnic_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	case ETHTOOL_SRXFH:
 		ret = fbnic_set_rss_hash_opts(fbn, cmd);
 		break;
+	case ETHTOOL_SRXCLSRLINS:
+		ret = fbnic_set_cls_rule_ins(fbn, cmd);
+		break;
+	case ETHTOOL_SRXCLSRLDEL:
+		ret = fbnic_set_cls_rule_del(fbn, cmd);
+		break;
 	}
 
 	return ret;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 1db57c42333e..14e7a8384bce 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -639,6 +639,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
 	netdev->hw_enc_features |= netdev->features;
+	netdev->features |= NETIF_F_NTUPLE;
 
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index be06f43e51e4..8ff07b5562e3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -61,7 +61,7 @@ void fbnic_rss_disable_hw(struct fbnic_dev *fbd)
 #define FBNIC_FH_2_RSSEM_BIT(_fh, _rssem, _val)		\
 	FIELD_PREP(FBNIC_RPC_ACT_TBL1_RSS_ENA_##_rssem,	\
 		   FIELD_GET(RXH_##_fh, _val))
-static u16 fbnic_flow_hash_2_rss_en_mask(struct fbnic_net *fbn, int flow_type)
+u16 fbnic_flow_hash_2_rss_en_mask(struct fbnic_net *fbn, int flow_type)
 {
 	u32 flow_hash = fbn->rss_flow_hash[flow_type];
 	u32 rss_en_mask = 0;
-- 
2.48.1


