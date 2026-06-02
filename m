Return-Path: <netdev+bounces-294226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KDR+BILfHmrHXAAAu9opvQ
	(envelope-from <netdev+bounces-294226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A58AB62EA99
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:49:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=F8+mqmpx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294226-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294226-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43F4630D142A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3F3E9299;
	Tue,  2 Jun 2026 13:34:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A483E7159;
	Tue,  2 Jun 2026 13:33:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407241; cv=none; b=m8xNhJYmpBdLS1cwFcMToUscGg+9vt1TFApZgQbYnLj5GsqA9UkD0fiy7gv1hNjA3pfCgs75ZgIK33VzfIu03CuRcKg72OB9qzZFvuGf8lLKNrNCZTF63oDvTcey/s+9qovkNmKNuCJB2sNcmaSPSEu7bDYLWwtQPUQ3MltYgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407241; c=relaxed/simple;
	bh=/LAh8YwTDHwbKZJa/IbKdcMNNE0krTbMPZ2QOjwzNJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1znK+7xdz3bnCozic6TrvEDrou2btbIdfakqVTDi02NbafruFveBS8Rn9m69IBK1EVoMXXruo/Cssv+AAie1pyn8ObgXltcJVaVxqBLlNWY3C9Gh+zQ8rOhNYznxN20/zl/g3M5MH2Lr38KW1rw1fEs27dgEaF1/KKxgYpICQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=F8+mqmpx; arc=none smtp.client-ip=113.46.200.222
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=58tx1J2pj5FUfympWBJdCT08aHIILSv/0ZZhim18CyI=;
	b=F8+mqmpxnezfi8NaQKxOUooXCkSk69s0+Pt96TXqPzIl6Z3Gr9Z8FQXcaUQrSpLhjur4jwtCs
	xmwzLGB/PGIL9SN+PMleRHPFIDutu8hnjHdsCw+o/SwNGPwRDqYKBiuYgI+gABFF+42SG1R9BJ0
	Y9COvidxXugh0VBsh3uXbZU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gVBRX4FV3zLlTC;
	Tue,  2 Jun 2026 21:26:00 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E230402AB;
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
Subject: [PATCH V3 net-next 2/6] net: hns3: improve the unused_tuple parameter setting
Date: Tue, 2 Jun 2026 21:33:33 +0800
Message-ID: <20260602133337.2216918-3-shaojijie@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-294226-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A58AB62EA99

Currently, when the tc tool is used to set flow table rules, the IP address
and MAC address can be configured separately, for example, src_xx or dst_xx
can be configured separately.

Therefore, the driver needs to check whether the mask is all zero in
keys, such as FLOW_DISSECTOR_KEY_IPV4_ADDRS, FLOW_DISSECTOR_KEY_IPV6_ADDRS,
and FLOW_DISSECTOR_KEY_ETH_ADDRS.
If the mask is all zero, the tuple is not configured.
In this case, the driver adds the tuple to unused_tuple.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 89fff510befd..5e1f76513622 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7242,6 +7242,10 @@ static void hclge_get_cls_key_mac(const struct flow_rule *flow,
 		ether_addr_copy(rule->tuples_mask.dst_mac, match.mask->dst);
 		ether_addr_copy(rule->tuples.src_mac, match.key->src);
 		ether_addr_copy(rule->tuples_mask.src_mac, match.mask->src);
+		if (is_zero_ether_addr(match.mask->dst))
+			rule->unused_tuple |= BIT(INNER_DST_MAC);
+		if (is_zero_ether_addr(match.mask->src))
+			rule->unused_tuple |= BIT(INNER_SRC_MAC);
 	} else {
 		rule->unused_tuple |= BIT(INNER_DST_MAC);
 		rule->unused_tuple |= BIT(INNER_SRC_MAC);
@@ -7290,6 +7294,10 @@ static int hclge_get_cls_key_ip(const struct flow_rule *flow,
 		rule->tuples.dst_ip[IPV4_INDEX] = be32_to_cpu(match.key->dst);
 		rule->tuples_mask.dst_ip[IPV4_INDEX] =
 						be32_to_cpu(match.mask->dst);
+		if (!match.mask->src)
+			rule->unused_tuple |= BIT(INNER_SRC_IP);
+		if (!match.mask->dst)
+			rule->unused_tuple |= BIT(INNER_DST_IP);
 	} else if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
 		struct flow_match_ipv6_addrs match;
 
@@ -7302,6 +7310,10 @@ static int hclge_get_cls_key_ip(const struct flow_rule *flow,
 				      match.key->dst.s6_addr32);
 		ipv6_addr_be32_to_cpu(rule->tuples_mask.dst_ip,
 				      match.mask->dst.s6_addr32);
+		if (ipv6_addr_any(&match.mask->src))
+			rule->unused_tuple |= BIT(INNER_SRC_IP);
+		if (ipv6_addr_any(&match.mask->dst))
+			rule->unused_tuple |= BIT(INNER_DST_IP);
 	} else {
 		rule->unused_tuple |= BIT(INNER_SRC_IP);
 		rule->unused_tuple |= BIT(INNER_DST_IP);
-- 
2.33.0


