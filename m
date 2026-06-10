Return-Path: <netdev+bounces-297454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bCwcILj/KGqTOgMAu9opvQ
	(envelope-from <netdev+bounces-297454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:10:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2A66617E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="d6qx6F//";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297454-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297454-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 327C6314CBA5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34B371CF4;
	Wed, 10 Jun 2026 06:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEEC368D4D;
	Wed, 10 Jun 2026 06:06:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071605; cv=none; b=cb5L6lp4xW9nfrU0unOx7cvTgELr/FOEJyIwv4dw/pwnYIYSlGv+cygueVVG5xfnD6nv2mfPtZbJOfoAMx6fL8NFIkdFqCDoUuo7XGv2uX9o4oXQpfujlLVPsH4AI6J3FIPlMXYpmpXdHwdjs4LL9xUj4q8dDd1up72y2Y9VHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071605; c=relaxed/simple;
	bh=OFwUD5u1SoDZUrt5BR+USGXeaypfWd/TJRpgiwRlTco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rxl6jTMnBXs1Z2G1oH6TuzkLB1ckKLfLU6UqN6JQWlwqjRVhgOVPeOAMe8LckNxdKqa1uTx90Whb/DEVBfwvxVmf5w3NyCRmzwgy9uhrOgA72Hgy1c+r+BRB/8jyjxJCspHp4+f/q+QK0E1fA9wjuPwTVsErT1e4KtV8sMJNa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=d6qx6F//; arc=none smtp.client-ip=113.46.200.218
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0nVw7NtXG7zJSwe8+BGxCBrF5QqZhskdhRg8AYGXQvM=;
	b=d6qx6F//EisVJ6ro3AQ+rk0jAPJUAFlRu/lHvJF6DuGCmvYfjPgHU8oikeyH6p2BwB2y5sFnA
	GmX/y/OU02BBMV6KcgWRx4OmREI/F75Gz+G0DDW8XNer5VCVsaUBIt8E42MSFAGCZLtJd//OaAQ
	rDRoqJWRflEJoJJgbb1r2Pg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gZw7n1tmXzpTJt;
	Wed, 10 Jun 2026 13:58:45 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BCCF440569;
	Wed, 10 Jun 2026 14:06:35 +0800 (CST)
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
Subject: [PATCH V4 net-next 3/6] net: hns3: support two more actions for tc flow
Date: Wed, 10 Jun 2026 14:06:15 +0800
Message-ID: <20260610060618.834987-4-shaojijie@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-297454-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: D6F2A66617E

Currently, the driver supports only one action:HCLGE_FD_ACTION_SELECT_TC.

This patch adds support for HCLGE_FD_ACTION_SELECT_QUEUE and
HCLGE_FD_ACTION_DROP_PACKET.

A rule can have only one action. Therefore, the driver intercepts rules
that have multiple actions or no action.

Note: The driver considers cls_flower->classid as an action:
HCLGE_FD_ACTION_SELECT_TC.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 63 ++++++++++++++++---
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 176ea5aac8aa..ed7cd0a0d267 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7344,19 +7344,49 @@ static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
 				      struct flow_cls_offload *cls_flower,
 				      struct hclge_fd_rule *rule)
 {
+	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	struct hnae3_handle *handle = &hdev->vport[0].nic;
+	struct flow_action *action = &flow->action;
+	struct flow_action_entry *act;
 	int tc;
 
-	tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
-	if (tc < 0 || tc > hdev->tc_max) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "invalid traffic class: %d", tc);
-		return -EINVAL;
+	if (!flow_action_has_entries(&flow->action)) {
+		tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
+		if (tc < 0 || tc > hdev->tc_max) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "invalid traffic class: %d",
+					       tc);
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
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "queue id (%u) should be less than %u",
+					       act->rx_queue,
+					       handle->kinfo.num_tqps);
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
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "unsupported action(%d)", act->id);
+		return -EOPNOTSUPP;
+	}
 }
 
 static int hclge_parse_cls_flower(struct hclge_dev *hdev,
@@ -7420,6 +7450,25 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 		return -EOPNOTSUPP;
 	}
 
+	/* driver will parses classid into an action */
+	if (cls_flower->classid && flow_action_has_entries(&flow->action)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "cannot specify both classid and action");
+		return -EOPNOTSUPP;
+	}
+
+	if (!flow_action_has_entries(&flow->action) && !cls_flower->classid) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "must specify either classid or action");
+		return -EINVAL;
+	}
+
+	if (flow_action_has_entries(&flow->action) &&
+	    !flow_offload_has_one_action(&flow->action)) {
+		NL_SET_ERR_MSG_MOD(extack, "unsupported multiple actions");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
-- 
2.33.0


