Return-Path: <netdev+bounces-294224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lXobEcneHmrLWwAAu9opvQ
	(envelope-from <netdev+bounces-294224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:46:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C762EA00
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:46:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="Av5E/HaC";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294224-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294224-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC2693093BBE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214AC3E866C;
	Tue,  2 Jun 2026 13:34:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DA3E5A3F;
	Tue,  2 Jun 2026 13:33:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407240; cv=none; b=b0jkFaIq+REDM/q0tLxIr6xAkxMhjHIln2Nhu5+q0WM7PS7VLsBpKjLjKSZhJhYNBHV6Zrk8zzGvlRK9L4w+YQTGgoxo0GZ7g9HmEx5Zyu2+iv8cD7WQpUFYLXTcLcAlwvlGZ/j97BPq2+1YQx6Ix69TLylHMTq0ovLRGnKqa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407240; c=relaxed/simple;
	bh=ZkirKX9c1Up2j/3cDhbI5OWWz76/jJxgPB/OHDKtb9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcFJ7JbCBrGEWMzmDGSj+s96ox34PLibBKDDbOh5bO6l7PjcJmVEzT2khLdZfkGb/3E91cx0Wa16GLUFUlV7njmzfkbZUTlkjravEc17LCCQ+D96ca6Y2NwzuM7fkw3lIMzk9Uvwdz0ITLRglQ53r3ogytw2xPT3rsquGwMujfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Av5E/HaC; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Eal6M5WU8UoX3tezsyAq+WPMKkeX6EywnfONwBSRb+0=;
	b=Av5E/HaCqDGtIYh6H7zhLW6d0ijH/ZcmvggneDXw9tFpnftslapVnnuLZPzSlnea3ok/wva1/
	Sc7FKOBL3uKa+2QiDGriSUvak5mzBplfYCeAh5Qb7annciQ6xfzp5YuDU4U+JoNMBk20+hE6zmV
	fi9PGxTsfwPiieBCgz3/8i8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gVBR80jrvz1T4Fw;
	Tue,  2 Jun 2026 21:25:40 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 06E614048F;
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
Subject: [PATCH V3 net-next 3/6] net: hns3: support two more actions for tc flow
Date: Tue, 2 Jun 2026 21:33:34 +0800
Message-ID: <20260602133337.2216918-4-shaojijie@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294224-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:mid,huawei.com:dkim,huawei.com:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D1C762EA00

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
index 5e1f76513622..aa85abda2909 100644
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
+				act->rx_queue, handle->kinfo.num_tqps);
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


