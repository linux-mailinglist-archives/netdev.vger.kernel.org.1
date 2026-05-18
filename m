Return-Path: <netdev+bounces-288966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNBtIbbdCmpV8wQAu9opvQ
	(envelope-from <netdev+bounces-288966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:36:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDA569D5C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FB4B300E031
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D712E3E833C;
	Mon, 18 May 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LoP0bnHI"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F473E717D;
	Mon, 18 May 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096961; cv=none; b=CSa9vg4b8GTn+ZtVnNUZ+MA2B7CjDCTYBtDCFbSTtJtC52FQz2sctunUl4Wd0wlkCG5LkxsNUvzhfeG37vI9bi9TMkxEJCYQBN4PpVTqWkAPhdnwTKGNBJ2TLRqybclV0p73BhIMzqDG2I5iD/g8KFOZxDlAXhMOvUQSaeCwiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096961; c=relaxed/simple;
	bh=4IRMK1SH8vkPGzTRoAu/9PzlKVGstmE0gkZLpRNV7SM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qx9inaRKM56br9+ioJvfRGbzx58aVhKMDyFdepSHga3vQVbJxf38W11ZC7d2NDhySpXvRKp0xRFSrDDW1Y8dAnZ46R2Frv5AxrEy/dpCcdtF5hqNm9x/r9FVC4ApbWTcqkuqHRBVkp6dTSyAltnQeJeD6fMUmZww6MyaoPVBro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LoP0bnHI; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9knPvIDKpNZX0ND2NsTb0A/XO0/cA9NffW2E5WLknz0=;
	b=LoP0bnHI79AILw9+hY4mHJUgmBSbS/FFQ9TybgkDFwNRYbXlwk2UcNNFqvdqwJhtLpZ4pU95t
	jYpu2WHM7K/79/c3j4AIeoVJuAZDW+7HT4wsnu7uOUZWG1kd44qyHx/OrMmerXi6JaTmquE4xAp
	pvTg1TaTHcNloFdTyBOitpM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gJssz5X2QzmV6S;
	Mon, 18 May 2026 17:28:07 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 22CF14056E;
	Mon, 18 May 2026 17:35:49 +0800 (CST)
Received: from
 deployment-s00611957-4ii0-20260331111539-78d5c5cfbb-9s2bv.default.svc.cluster.local
 (7.197.8.232) by kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 18 May 2026 17:35:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 3/6] net: hns3: support two more actions for tc flow
Date: Mon, 18 May 2026 17:35:23 +0800
Message-ID: <20260518093526.1109595-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518093526.1109595-1-shaojijie@huawei.com>
References: <20260518093526.1109595-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Queue-Id: 2BDDA569D5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288966-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action

Currently, the driver supports only one action:HCLGE_FD_ACTION_SELECT_TC.

This patch adds support for HCLGE_FD_ACTION_SELECT_QUEUE and
HCLGE_FD_ACTION_DROP_PACKET.

A rule can have only one action. Therefore, the driver intercepts rules
that have multiple actions or no action.

Note: The driver considers cls_flower->classid as an action:
HCLGE_FD_ACTION_SELECT_TC.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 59 ++++++++++++++++---
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6eb4c6e4df4e..bbbc017a0fb7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7344,18 +7344,45 @@ static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
 				      struct flow_cls_offload *cls_flower,
 				      struct hclge_fd_rule *rule)
 {
+	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
 	struct hnae3_handle *handle = &hdev->vport[0].nic;
+	struct flow_action *action = &flow->action;
+	struct flow_action_entry *act;
 	int tc;
 
-	tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
-	if (tc < 0 || tc > hdev->tc_max) {
-		dev_err(&hdev->pdev->dev, "invalid traffic class: %d\n", tc);
-		return -EINVAL;
+	if (!flow_action_has_entries(&flow->action)) {
+		tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
+		if (tc < 0 || tc > hdev->tc_max) {
+			dev_err(&hdev->pdev->dev,
+				"invalid traffic class: %d\n", tc);
+			return -EINVAL;
+		}
+
+		rule->action = HCLGE_FD_ACTION_SELECT_TC;
+		rule->cls_flower.tc = tc;
+		return 0;
 	}
 
-	rule->action = HCLGE_FD_ACTION_SELECT_TC;
-	rule->cls_flower.tc = tc;
-	return 0;
+	act = &action->entries[0];
+	switch (act->id) {
+	case FLOW_ACTION_RX_QUEUE_MAPPING:
+		if (act->rx_queue >= handle->kinfo.num_tqps) {
+			dev_err(&hdev->pdev->dev,
+				"queue id (%u) should be less than %u\n",
+				act->rx_queue, handle->kinfo.num_tqps - 1);
+			return -EINVAL;
+		}
+
+		rule->queue_id = act->rx_queue;
+		rule->action = HCLGE_FD_ACTION_SELECT_QUEUE;
+		return 0;
+	case FLOW_ACTION_DROP:
+		rule->action = HCLGE_FD_ACTION_DROP_PACKET;
+		return 0;
+	default:
+		dev_err(&hdev->pdev->dev, "unsupported action(%d)\n", act->id);
+		return -EOPNOTSUPP;
+	}
 }
 
 static int hclge_parse_cls_flower(struct hclge_dev *hdev,
@@ -7412,6 +7439,24 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 		return -EOPNOTSUPP;
 	}
 
+	/* driver will parses classid into an action */
+	if (cls_flower->classid && flow_action_has_entries(&flow->action)) {
+		dev_err(&hdev->pdev->dev,
+			"please not set classid and action together\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!flow_action_has_entries(&flow->action) && !cls_flower->classid) {
+		dev_err(&hdev->pdev->dev, "please set action or classid\n");
+		return -EINVAL;
+	}
+
+	if (flow_action_has_entries(&flow->action) &&
+	    !flow_offload_has_one_action(&flow->action)) {
+		dev_err(&hdev->pdev->dev, "unsupported multiple actions\n");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
-- 
2.33.0


