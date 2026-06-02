Return-Path: <netdev+bounces-294225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y/yYH7HdHmq6WgAAu9opvQ
	(envelope-from <netdev+bounces-294225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:42:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C0C62E96E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:42:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=SVComHWC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294225-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294225-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7C8C306B1EC
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C503E95B3;
	Tue,  2 Jun 2026 13:34:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B23E5A13;
	Tue,  2 Jun 2026 13:33:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407240; cv=none; b=ZTNcqsGsxJknEtXKiKfwGBpJh9qKyh7tyUCqybmUG29kutX+Pt+1VezZJy6PsaxV7rjAxVoiM9GK9Oq+vPVjc0/CNtVN9SfrazhWnybykqUOLVnhd8L6QqwJqvdSsbl/SjKbcWyHWBHbjMbN6TRg3ZrJXKw1nXh21Xg+tbOFwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407240; c=relaxed/simple;
	bh=Hqw5CvC2z7dU38SmJMVeKqlDtUvFByskwrV3WYHiF/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEc1KplRxP9bNH26Wm1W7rALLE2jzHP8QnfWiAqkArWqoDkU/ga/eKaMCK3dEC8i5teV+Tilw9caH+E3w6UO1j1/BBNAQqN0zuYrP43s1LCJRyr1j/m3p1FPNdzoVxThaiETGhTXjaeIcYLhm9bzSU8ZPdI1qu4j+aDWcFD9t60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SVComHWC; arc=none smtp.client-ip=113.46.200.220
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e6pgzRbGQ0lkolDRDlDt4jVSgbNxhtvDpWwZ5dGiA9Y=;
	b=SVComHWCscPmfiXrd6+2sb+NQC3c4SDCcpibpMmddFFiXn07EyKu6TwTk042DDnx8ueQQrhNY
	bxMCqGk4vN5WU778v0u0CVTbA4lZFXMyzt5DzriBLWNoU1N4Jtb9O6E/uw3MI/yyA1mNnZtt0Sj
	t6cqX4BpEvbVYNJNwTByXkY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gVBRN6n5Vz12LGB;
	Tue,  2 Jun 2026 21:25:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 250974048F;
	Tue,  2 Jun 2026 21:33:49 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Jun 2026 21:33:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V3 net-next 1/6] net: hns3: adjust add_cls_flower() for support more action
Date: Tue, 2 Jun 2026 21:33:32 +0800
Message-ID: <20260602133337.2216918-2-shaojijie@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294225-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2C0C62E96E

Currently, the driver supports only HCLGE_FD_ACTION_SELECT_TC configuration
in hclge_add_cls_flower(). Therefore, the tc parameter is included
in the function input parameters.

The driver plans to extend this function to support
HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET.
Therefore, the tc parameter needs to be deleted from the input parameters
of the function to ensure the universality of the function definition.

In addition, this patch moves the check of dissector->used_keys from
hclge_parse_cls_flower() to hclge_check_cls_flower().

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  3 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 68 ++++++++++++-------
 3 files changed, 45 insertions(+), 28 deletions(-)

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
index e17b92a411a2..89fff510befd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7328,28 +7328,32 @@ static void hclge_get_cls_key_port(const struct flow_rule *flow,
 	}
 }
 
+static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
+				      struct flow_cls_offload *cls_flower,
+				      struct hclge_fd_rule *rule)
+{
+	struct hnae3_handle *handle = &hdev->vport[0].nic;
+	int tc;
+
+	tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
+	if (tc < 0 || tc > hdev->tc_max) {
+		dev_err(&hdev->pdev->dev, "invalid traffic class: %d\n", tc);
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
@@ -7364,15 +7368,12 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 }
 
 static int hclge_check_cls_flower(struct hclge_dev *hdev,
-				  struct flow_cls_offload *cls_flower, int tc)
+				  struct flow_cls_offload *cls_flower)
 {
+	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
+	struct flow_dissector *dissector = flow->match.dissector;
 	u32 prio = cls_flower->common.prio;
 
-	if (tc < 0 || tc > hdev->tc_max) {
-		dev_err(&hdev->pdev->dev, "invalid traffic class\n");
-		return -EINVAL;
-	}
-
 	if (prio == 0 ||
 	    prio > hdev->fd_cfg.rule_num[HCLGE_FD_STAGE_1]) {
 		dev_err(&hdev->pdev->dev,
@@ -7385,12 +7386,25 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 		dev_err(&hdev->pdev->dev, "prio %u is already used\n", prio);
 		return -EINVAL;
 	}
+
+	if (dissector->used_keys &
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
+		dev_err(&hdev->pdev->dev, "unsupported key set: %#llx\n",
+			dissector->used_keys);
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
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
@@ -7403,7 +7417,7 @@ static int hclge_add_cls_flower(struct hnae3_handle *handle,
 		return -EOPNOTSUPP;
 	}
 
-	ret = hclge_check_cls_flower(hdev, cls_flower, tc);
+	ret = hclge_check_cls_flower(hdev, cls_flower);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to check cls flower params, ret = %d\n", ret);
@@ -7420,8 +7434,12 @@ static int hclge_add_cls_flower(struct hnae3_handle *handle,
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


