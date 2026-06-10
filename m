Return-Path: <netdev+bounces-297455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TtkREr//KGqWOgMAu9opvQ
	(envelope-from <netdev+bounces-297455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E61666181
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:10:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=TbFXtTxP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297455-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297455-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9515331506EF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD7370D69;
	Wed, 10 Jun 2026 06:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04051371CF9;
	Wed, 10 Jun 2026 06:06:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071605; cv=none; b=dTlhkHzhaCTDH3JwJs9zhbqz2KZOgtemP936hbZqKnC+CHXYIl9SAylobl29irGos7mtfsltn50yPfFOGeVwv1eV7gvvZVt5XvjbX+R3v3IHLGeNI9dWLCgfe6TwHMbp6exJHOpqKOORIpdiSjyeghyIUPZMrFj7H3PtENEyEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071605; c=relaxed/simple;
	bh=ORL8HEf+gZmLveijujYpM4411zyoXEaocR/ndIm+bD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7dDPwwohXqEeDWIcUOSuGl8GFnSHvIiVuNCF0G8FFX7kVnLEMpfJnUz48CtZR5b0KdQMO7xxS+k2jTqOWQI1Umgnz3LS6k25j2/u7wgCP/sdCm9fbMVVDmEM4o6fp3rDcf4yNbobdSYGykaRUwnWRAOyyyB+ElXJAWB010/TBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TbFXtTxP; arc=none smtp.client-ip=113.46.200.218
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=44osuMQq6VbJ68FcJd6eZjXdOVAFOTnYwPWqDkLeeGk=;
	b=TbFXtTxP2ccWtgK4q7snOIHVn4XGXoCUur/1ZFy4u+e6SOTPS95as9kWp/WXqsAB7uDX6idJC
	txc9WpoDk/eFV2IL6HilB/Yw8/rVqrI7bZRK/kSjtcCNoNO9pjoI7xD0bAD2bIjL2vEqsxbZqHX
	zSYQ4hKgPkHnkbEJQTFfIeI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gZw7m1C35zpStT;
	Wed, 10 Jun 2026 13:58:44 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A9D5D203B1;
	Wed, 10 Jun 2026 14:06:34 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 10 Jun 2026 14:06:33 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V4 net-next 1/6] net: hns3: refactor add_cls_flower to prepare for multiple actions
Date: Wed, 10 Jun 2026 14:06:13 +0800
Message-ID: <20260610060618.834987-2-shaojijie@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297455-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92E61666181

Remove the tc parameter from the add_cls_flower() ops callback and
refactor action parsing to support future extensions for SELECT_QUEUE
and DROP_PACKET actions.

Changes:
* Remove the tc parameter from the add_cls_flower() callback signature.
* Extract TC-based action parsing into hclge_get_tc_flower_action().
* Move the dissector->used_keys check from hclge_parse_cls_flower() to
  hclge_check_cls_flower(), and restrict ETH_ADDRS to
  HCLGE_FD_MODE_DEPTH_2K_WIDTH_400B_STAGE_1 mode since hardware only
  supports MAC matching there.
* Migrate error reporting from dev_err() to netlink extended ACK (extack).

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  3 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 93 ++++++++++++-------
 3 files changed, 60 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index d7c3df1958f3..a724935b655a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -778,7 +778,7 @@ struct hnae3_ae_ops {
 				 u32 len, u8 *data);
 	bool (*get_cmdq_stat)(struct hnae3_handle *handle);
 	int (*add_cls_flower)(struct hnae3_handle *handle,
-			      struct flow_cls_offload *cls_flower, int tc);
+			      struct flow_cls_offload *cls_flower);
 	int (*del_cls_flower)(struct hnae3_handle *handle,
 			      struct flow_cls_offload *cls_flower);
 	bool (*cls_flower_active)(struct hnae3_handle *handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4c34a144d21c..6ecb32e28e79 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2678,13 +2678,12 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 static int hns3_setup_tc_cls_flower(struct hns3_nic_priv *priv,
 				    struct flow_cls_offload *flow)
 {
-	int tc = tc_classid_to_hwtc(priv->netdev, flow->classid);
 	struct hnae3_handle *h = hns3_get_handle(priv->netdev);
 
 	switch (flow->command) {
 	case FLOW_CLS_REPLACE:
 		if (h->ae_algo->ops->add_cls_flower)
-			return h->ae_algo->ops->add_cls_flower(h, flow, tc);
+			return h->ae_algo->ops->add_cls_flower(h, flow);
 		break;
 	case FLOW_CLS_DESTROY:
 		if (h->ae_algo->ops->del_cls_flower)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e17b92a411a2..77bd23e2c11e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7328,28 +7328,33 @@ static void hclge_get_cls_key_port(const struct flow_rule *flow,
 	}
 }
 
+static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
+				      struct flow_cls_offload *cls_flower,
+				      struct hclge_fd_rule *rule)
+{
+	struct netlink_ext_ack *extack = cls_flower->common.extack;
+	struct hnae3_handle *handle = &hdev->vport[0].nic;
+	int tc;
+
+	tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
+	if (tc < 0 || tc > hdev->tc_max) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "invalid traffic class: %d", tc);
+		return -EINVAL;
+	}
+
+	rule->action = HCLGE_FD_ACTION_SELECT_TC;
+	rule->cls_flower.tc = tc;
+	return 0;
+}
+
 static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 				  struct flow_cls_offload *cls_flower,
 				  struct hclge_fd_rule *rule)
 {
 	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
-	struct flow_dissector *dissector = flow->match.dissector;
 	int ret;
 
-	if (dissector->used_keys &
-	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
-		dev_err(&hdev->pdev->dev, "unsupported key set: %#llx\n",
-			dissector->used_keys);
-		return -EOPNOTSUPP;
-	}
-
 	hclge_get_cls_key_basic(flow, rule);
 	hclge_get_cls_key_mac(flow, rule);
 	hclge_get_cls_key_vlan(flow, rule);
@@ -7364,51 +7369,65 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 }
 
 static int hclge_check_cls_flower(struct hclge_dev *hdev,
-				  struct flow_cls_offload *cls_flower, int tc)
+				  struct flow_cls_offload *cls_flower)
 {
+	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
+	struct netlink_ext_ack *extack = cls_flower->common.extack;
+	struct flow_dissector *dissector = flow->match.dissector;
 	u32 prio = cls_flower->common.prio;
-
-	if (tc < 0 || tc > hdev->tc_max) {
-		dev_err(&hdev->pdev->dev, "invalid traffic class\n");
-		return -EINVAL;
-	}
+	u64 support_keys;
 
 	if (prio == 0 ||
 	    prio > hdev->fd_cfg.rule_num[HCLGE_FD_STAGE_1]) {
-		dev_err(&hdev->pdev->dev,
-			"prio %u should be in range[1, %u]\n",
-			prio, hdev->fd_cfg.rule_num[HCLGE_FD_STAGE_1]);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "prio %u should be in range[1, %u]",
+				       prio,
+				       hdev->fd_cfg.rule_num[HCLGE_FD_STAGE_1]);
 		return -EINVAL;
 	}
 
 	if (test_bit(prio - 1, hdev->fd_bmap)) {
-		dev_err(&hdev->pdev->dev, "prio %u is already used\n", prio);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "prio %u is already used", prio);
 		return -EINVAL;
 	}
+
+	support_keys = BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+		       BIT_ULL(FLOW_DISSECTOR_KEY_PORTS);
+
+	if (hdev->fd_cfg.fd_mode == HCLGE_FD_MODE_DEPTH_2K_WIDTH_400B_STAGE_1)
+		support_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS);
+
+	if (dissector->used_keys & ~support_keys) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "unsupported key set: %#llx",
+				       dissector->used_keys);
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
 static int hclge_add_cls_flower(struct hnae3_handle *handle,
-				struct flow_cls_offload *cls_flower,
-				int tc)
+				struct flow_cls_offload *cls_flower)
 {
+	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_fd_rule *rule;
 	int ret;
 
 	if (!hnae3_ae_dev_fd_supported(hdev->ae_dev)) {
-		dev_err(&hdev->pdev->dev,
-			"cls flower is not supported\n");
+		NL_SET_ERR_MSG_MOD(extack, "cls flower is not supported");
 		return -EOPNOTSUPP;
 	}
 
-	ret = hclge_check_cls_flower(hdev, cls_flower, tc);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"failed to check cls flower params, ret = %d\n", ret);
+	ret = hclge_check_cls_flower(hdev, cls_flower);
+	if (ret)
 		return ret;
-	}
 
 	rule = kzalloc_obj(*rule);
 	if (!rule)
@@ -7420,8 +7439,12 @@ static int hclge_add_cls_flower(struct hnae3_handle *handle,
 		return ret;
 	}
 
-	rule->action = HCLGE_FD_ACTION_SELECT_TC;
-	rule->cls_flower.tc = tc;
+	ret = hclge_get_tc_flower_action(hdev, cls_flower, rule);
+	if (ret) {
+		kfree(rule);
+		return ret;
+	}
+
 	rule->location = cls_flower->common.prio - 1;
 	rule->vf_id = 0;
 	rule->cls_flower.cookie = cls_flower->cookie;
-- 
2.33.0


