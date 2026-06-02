Return-Path: <netdev+bounces-294221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oeorDkDeHmo2WwAAu9opvQ
	(envelope-from <netdev+bounces-294221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:44:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2D62E9B3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:44:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="J5/lGs1Z";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294221-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294221-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36A05303D561
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9D235AC1B;
	Tue,  2 Jun 2026 13:33:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9430146C;
	Tue,  2 Jun 2026 13:33:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407235; cv=none; b=tqTqg7+TqxYaeLlQHnulYQzB/1kKdbs2APwIXYOytN1Xcn1B6REsiSuJpnyj4fCdoOKkPCxnzalwtC9ovp/IQz+7aderDvnNmDcslUV3ATiksMeAWkVYoD2e62dBbtd2l1X6mdE3MHojdlj0pUgU1g2fLXecL9WHfi0q9VbDlEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407235; c=relaxed/simple;
	bh=SAJQPWEq4YnhiFREbKxqsWlYRDxj6UjCdTg39vXdaCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4GePFf510Z7mVWBWHAQL/YgZ31/gKBbGxImxLUn46uja11aTDG+HIIkSm6wwM6+0epSarJmd+8aonAOHOzcay9CdG/IT6ADDeCSQpRfmz66A/SE8RKQd2HBprnMw+6nnsuUAVGSEcZMYG0GMAD70XwAgxSA4++guMz3b0wZ0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=J5/lGs1Z; arc=none smtp.client-ip=113.46.200.226
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rStD3Jzb8d7iTJw6uGcY35i1IemrjCBF4FYP2b2FV+k=;
	b=J5/lGs1ZdF7AzcYVcN8WtMJuSWzrC2mN/7C8YukGQdG82Uuin4jfuu9u3zDC9cp/MQ8D7JKHo
	b8TT45MZJ9WD1gjuQDE5vD8/Fwel0VwRL5zZ0LUVe9qwlpFI1e0L2SfWamW5ed/PSslvn46V8JD
	dIwRW0R0zxdfMbALA4i9ow0=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gVBRV4qJXzKm4Z;
	Tue,  2 Jun 2026 21:25:58 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F02B4056C;
	Tue,  2 Jun 2026 21:33:50 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Jun 2026 21:33:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V3 net-next 4/6] net: hns3: support IP and tunnel VNI dissectors for tc flow
Date: Tue, 2 Jun 2026 21:33:35 +0800
Message-ID: <20260602133337.2216918-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260602133337.2216918-1-shaojijie@huawei.com>
References: <20260602133337.2216918-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294221-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:from_mime,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98B2D62E9B3

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
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 97 ++++++++++++++++---
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  4 +
 2 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index aa85abda2909..3559b471b3fe 100644
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
@@ -5760,6 +5763,17 @@ static bool hclge_fd_convert_tuple(u32 tuple_bit, u8 *key_x, u8 *key_y,
 		*(__le32 *)key_x = cpu_to_le32(tmp_x_l);
 		*(__le32 *)key_y = cpu_to_le32(tmp_y_l);
 
+		return true;
+	case KEY_OPT_VNI:
+		calc_x(tmp_x_l, *(u32 *)(&p[offset]), *(u32 *)(&p[moffset]));
+		calc_y(tmp_y_l, *(u32 *)(&p[offset]), *(u32 *)(&p[moffset]));
+		for (i = 0; i < HCLGE_VNI_LENGTH; i++) {
+			key_x[i] = ((__force u32)cpu_to_le32(tmp_x_l) >>
+				    (i * BITS_PER_BYTE)) & 0xFF;
+			key_y[i] = ((__force u32)cpu_to_le32(tmp_y_l) >>
+				    (i * BITS_PER_BYTE)) & 0xFF;
+		}
+
 		return true;
 	default:
 		return false;
@@ -7340,6 +7354,53 @@ static void hclge_get_cls_key_port(const struct flow_rule *flow,
 	}
 }
 
+static int hclge_get_cls_enc_keyid(struct hclge_dev *hdev,
+				   const struct flow_rule *flow,
+				   struct hclge_fd_rule *rule)
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
+			dev_err(&hdev->pdev->dev, "invalid enc_keyid\n");
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
+static void hclge_get_cls_key_ip_tos(const struct flow_rule *flow,
+				     struct hclge_fd_rule *rule)
+{
+	if (flow_rule_match_key(flow, FLOW_DISSECTOR_KEY_IP)) {
+		struct flow_match_ip match;
+
+		flow_rule_match_ip(flow, &match);
+
+		rule->tuples.ip_tos = match.key->tos;
+		rule->tuples_mask.ip_tos = match.mask->tos;
+		if (!rule->tuples_mask.ip_tos)
+			rule->unused_tuple |= BIT(INNER_IP_TOS);
+	} else {
+		rule->unused_tuple |= BIT(INNER_IP_TOS);
+	}
+}
+
 static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
 				      struct flow_cls_offload *cls_flower,
 				      struct hclge_fd_rule *rule)
@@ -7393,6 +7454,9 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	int ret;
 
+	/* not support any user def tuples */
+	rule->unused_tuple |= HCLGE_FD_TUPLE_USER_DEF_TUPLES;
+
 	hclge_get_cls_key_basic(flow, rule);
 	hclge_get_cls_key_mac(flow, rule);
 	hclge_get_cls_key_vlan(flow, rule);
@@ -7402,8 +7466,9 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 		return ret;
 
 	hclge_get_cls_key_port(flow, rule);
+	hclge_get_cls_key_ip_tos(flow, rule);
 
-	return 0;
+	return hclge_get_cls_enc_keyid(hdev, flow, rule);
 }
 
 static int hclge_check_cls_flower(struct hclge_dev *hdev,
@@ -7412,6 +7477,7 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
 	struct flow_dissector *dissector = flow->match.dissector;
 	u32 prio = cls_flower->common.prio;
+	u64 support_keys;
 
 	if (prio == 0 ||
 	    prio > hdev->fd_cfg.rule_num[HCLGE_FD_STAGE_1]) {
@@ -7426,14 +7492,19 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 		return -EINVAL;
 	}
 
-	if (dissector->used_keys &
-	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
+	support_keys = BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_IP);
+
+	if (hdev->fd_cfg.fd_mode == HCLGE_FD_MODE_DEPTH_2K_WIDTH_400B_STAGE_1)
+		support_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+				BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID);
+
+	if (dissector->used_keys & ~support_keys) {
 		dev_err(&hdev->pdev->dev, "unsupported key set: %#llx\n",
 			dissector->used_keys);
 		return -EOPNOTSUPP;
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


