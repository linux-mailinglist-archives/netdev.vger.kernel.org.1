Return-Path: <netdev+bounces-297453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kmseNYz/KGqGOgMAu9opvQ
	(envelope-from <netdev+bounces-297453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:09:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E066616D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:09:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="Ge/OgChH";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297453-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297453-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5633A31300B9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED125371D15;
	Wed, 10 Jun 2026 06:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A5282F2A;
	Wed, 10 Jun 2026 06:06:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071603; cv=none; b=glCC13jkzxOwUtDDN6RPhmvbBRRNsE0IDj7zpmtqnfQNlimePEQcvQPPhvAtjBZ316DRylm8WFtwFP9djLS1VzO8X5jkBMLe5E9ImQf5zylhL7t3Bnue9VE+CBgAtx1TV6bOQvBMrDuoo4TUFD+VigmbvCiEindv30Tx8oboJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071603; c=relaxed/simple;
	bh=qUraGaKDVyw3heR703LGav4EN88vkDUqa5PTFzYHybU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtCVRDrCFG1R5l1QtAdEx06cyid4BUN26EEyqFBssNV6I4XRUj5IqNTHQbNg9WsTe5WoQrDvS3mI15y7tpirnkfkXVBPMU7dZxInX7OV9gO4+sy2CJGyS/LsFuwwK+2Z34MWiP8R35SM4IselyrzvhIOJe6wD7+Iy6MVwJTSJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ge/OgChH; arc=none smtp.client-ip=113.46.200.226
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SnSRLf03Jzzsy2DIn0FAY/xl4V+1/cHYD9HQEnA5J+o=;
	b=Ge/OgChHz3Vo4lF+idoy7dm1/ptDLdvuPXik6D3MFEsr4buZmEu+bOwPAmLVjQVzQk0zVSDt5
	ERIDW9KYdxw+4Al5cqL9Pn+98RbM/IkmUZA4ezR3X+04wbZqHV7R1M220wJ+tL+zCemhigZWA4q
	yIhihrSwuz12pDmpnXbLUzw=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gZw7g4xfDzKm4Y;
	Wed, 10 Jun 2026 13:58:39 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BA0440572;
	Wed, 10 Jun 2026 14:06:36 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 10 Jun 2026 14:06:35 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V4 net-next 4/6] net: hns3: support IP and tunnel VNI dissectors for tc flow
Date: Wed, 10 Jun 2026 14:06:16 +0800
Message-ID: <20260610060618.834987-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260610060618.834987-1-shaojijie@huawei.com>
References: <20260610060618.834987-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7E066616D

Currently, the driver does not support FLOW_DISSECTOR_KEY_IP and
FLOW_DISSECTOR_KEY_ENC_KEYID. But the hardware supports
ip_tos (FLOW_DISSECTOR_KEY_IP) and
outer_tun_vni (FLOW_DISSECTOR_KEY_ENC_KEYID).

This patch adds support for FLOW_DISSECTOR_KEY_IP and
FLOW_DISSECTOR_KEY_ENC_KEYID.

Additionally, since tc flow cannot effectively support
l2_user_def, l3_user_def, and l4_user_def,
this patch explicitly sets them to not be used.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 91 +++++++++++++++++--
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  4 +
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ed7cd0a0d267..b8d4858fe39a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -16,7 +16,7 @@
 #include <linux/crash_dump.h>
 
 #include <net/rtnetlink.h>
-
+#include <net/vxlan.h>
 #include "hclge_cmd.h"
 #include "hclge_dcb.h"
 #include "hclge_main.h"
@@ -337,7 +337,9 @@ static const struct key_info tuple_key_info[] = {
 	{ OUTER_SRC_PORT, 16, KEY_OPT_LE16, -1, -1 },
 	{ OUTER_DST_PORT, 16, KEY_OPT_LE16, -1, -1 },
 	{ OUTER_L4_RSV, 32, KEY_OPT_LE32, -1, -1 },
-	{ OUTER_TUN_VNI, 24, KEY_OPT_VNI, -1, -1 },
+	{ OUTER_TUN_VNI, 24, KEY_OPT_VNI,
+	  offsetof(struct hclge_fd_rule, tuples.outer_tun_vni),
+	  offsetof(struct hclge_fd_rule, tuples_mask.outer_tun_vni) },
 	{ OUTER_TUN_FLOW_ID, 8, KEY_OPT_U8, -1, -1 },
 	{ INNER_DST_MAC, 48, KEY_OPT_MAC,
 	  offsetof(struct hclge_fd_rule, tuples.dst_mac),
@@ -5590,8 +5592,9 @@ static int hclge_init_fd_config(struct hclge_dev *hdev)
 
 	/* If use max 400bit key, we can support tuples for ether type */
 	if (hdev->fd_cfg.fd_mode == HCLGE_FD_MODE_DEPTH_2K_WIDTH_400B_STAGE_1) {
-		key_cfg->tuple_active |=
-				BIT(INNER_DST_MAC) | BIT(INNER_SRC_MAC);
+		key_cfg->tuple_active |= BIT(INNER_DST_MAC) |
+					 BIT(INNER_SRC_MAC) |
+					 BIT(OUTER_TUN_VNI);
 		if (hdev->ae_dev->dev_version >= HNAE3_DEVICE_VERSION_V3)
 			key_cfg->tuple_active |= HCLGE_FD_TUPLE_USER_DEF_TUPLES;
 	}
@@ -5713,6 +5716,7 @@ static bool hclge_fd_convert_tuple(u32 tuple_bit, u8 *key_x, u8 *key_y,
 	u16 tmp_x_s, tmp_y_s;
 	u32 tmp_x_l, tmp_y_l;
 	u8 *p = (u8 *)rule;
+	__le32 le_x, le_y;
 	int i;
 
 	if (rule->unused_tuple & BIT(tuple_bit))
@@ -5760,6 +5764,15 @@ static bool hclge_fd_convert_tuple(u32 tuple_bit, u8 *key_x, u8 *key_y,
 		*(__le32 *)key_x = cpu_to_le32(tmp_x_l);
 		*(__le32 *)key_y = cpu_to_le32(tmp_y_l);
 
+		return true;
+	case KEY_OPT_VNI:
+		calc_x(tmp_x_l, *(u32 *)(&p[offset]), *(u32 *)(&p[moffset]));
+		calc_y(tmp_y_l, *(u32 *)(&p[offset]), *(u32 *)(&p[moffset]));
+		le_x = cpu_to_le32(tmp_x_l);
+		le_y = cpu_to_le32(tmp_y_l);
+		memcpy(key_x, &le_x, HCLGE_VNI_LENGTH);
+		memcpy(key_y, &le_y, HCLGE_VNI_LENGTH);
+
 		return true;
 	default:
 		return false;
@@ -7340,6 +7353,62 @@ static void hclge_get_cls_key_port(const struct flow_rule *flow,
 	}
 }
 
+static int hclge_get_cls_enc_keyid(struct hclge_dev *hdev,
+				   const struct flow_rule *flow,
+				   struct hclge_fd_rule *rule,
+				   struct netlink_ext_ack *extack)
+{
+	if (flow_rule_match_key(flow, FLOW_DISSECTOR_KEY_ENC_KEYID)) {
+		struct flow_match_enc_keyid match;
+
+		flow_rule_match_enc_keyid(flow, &match);
+
+		/* vni is only 24 bits and must be greater than 0,
+		 * and it can not be masked.
+		 */
+		if (be32_to_cpu(match.mask->keyid) !=
+		    HCLGE_FD_VXLAN_VNI_UNMASK ||
+		    be32_to_cpu(match.key->keyid) >= VXLAN_N_VID ||
+		    !match.key->keyid) {
+			NL_SET_ERR_MSG_MOD(extack, "invalid enc_keyid");
+			return -EINVAL;
+		}
+
+		rule->tuples.outer_tun_vni = be32_to_cpu(match.key->keyid);
+		rule->tuples_mask.outer_tun_vni =
+						be32_to_cpu(match.mask->keyid);
+	} else {
+		rule->unused_tuple |= BIT(OUTER_TUN_VNI);
+	}
+
+	return 0;
+}
+
+static int hclge_get_cls_key_ip_tos(const struct flow_rule *flow,
+				    struct hclge_fd_rule *rule,
+				    struct netlink_ext_ack *extack)
+{
+	if (flow_rule_match_key(flow, FLOW_DISSECTOR_KEY_IP)) {
+		struct flow_match_ip match;
+
+		flow_rule_match_ip(flow, &match);
+
+		if (match.mask->ttl) {
+			NL_SET_ERR_MSG_MOD(extack, "unsupported TTL");
+			return -EOPNOTSUPP;
+		}
+
+		rule->tuples.ip_tos = match.key->tos;
+		rule->tuples_mask.ip_tos = match.mask->tos;
+		if (!rule->tuples_mask.ip_tos)
+			rule->unused_tuple |= BIT(INNER_IP_TOS);
+	} else {
+		rule->unused_tuple |= BIT(INNER_IP_TOS);
+	}
+
+	return 0;
+}
+
 static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
 				      struct flow_cls_offload *cls_flower,
 				      struct hclge_fd_rule *rule)
@@ -7397,6 +7466,9 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	int ret;
 
+	/* not support any user def tuples */
+	rule->unused_tuple |= HCLGE_FD_TUPLE_USER_DEF_TUPLES;
+
 	hclge_get_cls_key_basic(flow, rule);
 	hclge_get_cls_key_mac(flow, rule);
 	hclge_get_cls_key_vlan(flow, rule);
@@ -7406,8 +7478,11 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 		return ret;
 
 	hclge_get_cls_key_port(flow, rule);
+	ret = hclge_get_cls_key_ip_tos(flow, rule, extack);
+	if (ret)
+		return ret;
 
-	return 0;
+	return hclge_get_cls_enc_keyid(hdev, flow, rule, extack);
 }
 
 static int hclge_check_cls_flower(struct hclge_dev *hdev,
@@ -7439,10 +7514,12 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 		       BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
 		       BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
 		       BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-		       BIT_ULL(FLOW_DISSECTOR_KEY_PORTS);
+		       BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_IP);
 
 	if (hdev->fd_cfg.fd_mode == HCLGE_FD_MODE_DEPTH_2K_WIDTH_400B_STAGE_1)
-		support_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS);
+		support_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+				BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID);
 
 	if (dissector->used_keys & ~support_keys) {
 		NL_SET_ERR_MSG_FMT_MOD(extack, "unsupported key set: %#llx",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 032b472d2368..ccb19d960690 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -645,6 +645,9 @@ struct key_info {
 #define HCLGE_FD_USER_DEF_DATA		GENMASK(15, 0)
 #define HCLGE_FD_USER_DEF_OFFSET	GENMASK(15, 0)
 #define HCLGE_FD_USER_DEF_OFFSET_UNMASK	GENMASK(15, 0)
+#define HCLGE_FD_VXLAN_VNI_UNMASK	GENMASK(31, 0)
+
+#define HCLGE_VNI_LENGTH		3
 
 /* assigned by firmware, the real filter number for each pf may be less */
 #define MAX_FD_FILTER_NUM	4096
@@ -738,6 +741,7 @@ struct hclge_fd_rule_tuples {
 	u32 l4_user_def;
 	u8 ip_tos;
 	u8 ip_proto;
+	u32 outer_tun_vni;
 };
 
 struct hclge_fd_rule {
-- 
2.33.0


