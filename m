Return-Path: <netdev+bounces-291086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGiDHJ+HEWqdnAYAu9opvQ
	(envelope-from <netdev+bounces-291086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:55:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F245BE944
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15A183003703
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1182E3876BF;
	Sat, 23 May 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="k91HxXJb"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C8346A10;
	Sat, 23 May 2026 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533721; cv=none; b=gC/a/wNaS+7ktHOWQGcXgjQ796YWpXSnrTTjlMVFNMWM5LfNTDOpnktV/11b/e72eBajb7c7lT5P9KwmcKIGNAF4wDfkLbEo1FjhuX+z3AZXRMzzC0Tb9oS5TAw43S00K211pFQAXB7Mg/b1nQDGaXbtlH5b8LJZq1xPDAwdJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533721; c=relaxed/simple;
	bh=Rb8F1vVwH/kqjO6EcZvw7goIKZHEldO/pKOCUqLSNt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzIYSHGuxVjG9SKPXmw8Qq/GimVZOF/JRpY+/BxP/xYvsvDWzEjlRWfcRr3hhpjiCbtoGFVcLiMs95woAmglpVwR8C/3QokKWc7782TecAB5xUn7WgS1odNiCsRHtnsc5Bu8kklztF8hq/2OLSjuNvYuJp9vmx/PyR/I0UVwtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=k91HxXJb; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UAdT9DzZISjzzrLRw+Xv2Q6P3doPws7i47j3i2ULYmg=;
	b=k91HxXJbwJnGBFmHhGvASxJw8WfJK6xCcBigVTpJH0ml6M3SBzlKvnkdsyBETX6cBMInHTPsd
	wyU7lcy40xDc2wPeKC8yoaQvRDyuvFvEKxUXJCgt4IMSFQKydMzaruG1UW9RUYGCK5dj3pb3d9n
	kfwtgNZcp0NqdmcizRrJfSE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gMzPf0r8mzpSvR;
	Sat, 23 May 2026 18:47:50 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 495BE4048F;
	Sat, 23 May 2026 18:55:09 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 23 May 2026 18:55:08 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net-next 2/6] net: hns3: improve the unused_tuple parameter setting
Date: Sat, 23 May 2026 18:54:45 +0800
Message-ID: <20260523105449.661848-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260523105449.661848-1-shaojijie@huawei.com>
References: <20260523105449.661848-1-shaojijie@huawei.com>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291086-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: A1F245BE944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, when the tc tool is used to set flow table rules, the IP address
and MAC address can be configured separately, for example, src_xx or dst_xx
can be configured separately.

Therefore, the driver needs to check whether the address is all zero in
keys, such as FLOW_DISSECTOR_KEY_IPV4_ADDRS, FLOW_DISSECTOR_KEY_IPV6_ADDRS,
and FLOW_DISSECTOR_KEY_ETH_ADDRS.
If the address is all zero, the tuple is not configured.
In this case, the driver adds the tuple to unused_tuple.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 89fff510befd..6eb4c6e4df4e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7242,6 +7242,10 @@ static void hclge_get_cls_key_mac(const struct flow_rule *flow,
 		ether_addr_copy(rule->tuples_mask.dst_mac, match.mask->dst);
 		ether_addr_copy(rule->tuples.src_mac, match.key->src);
 		ether_addr_copy(rule->tuples_mask.src_mac, match.mask->src);
+		if (is_zero_ether_addr(match.key->dst))
+			rule->unused_tuple |= BIT(INNER_DST_MAC);
+		if (is_zero_ether_addr(match.key->src))
+			rule->unused_tuple |= BIT(INNER_SRC_MAC);
 	} else {
 		rule->unused_tuple |= BIT(INNER_DST_MAC);
 		rule->unused_tuple |= BIT(INNER_SRC_MAC);
@@ -7290,6 +7294,10 @@ static int hclge_get_cls_key_ip(const struct flow_rule *flow,
 		rule->tuples.dst_ip[IPV4_INDEX] = be32_to_cpu(match.key->dst);
 		rule->tuples_mask.dst_ip[IPV4_INDEX] =
 						be32_to_cpu(match.mask->dst);
+		if (!match.key->src)
+			rule->unused_tuple |= BIT(INNER_SRC_IP);
+		if (!match.key->dst)
+			rule->unused_tuple |= BIT(INNER_DST_IP);
 	} else if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
 		struct flow_match_ipv6_addrs match;
 
@@ -7302,6 +7310,10 @@ static int hclge_get_cls_key_ip(const struct flow_rule *flow,
 				      match.key->dst.s6_addr32);
 		ipv6_addr_be32_to_cpu(rule->tuples_mask.dst_ip,
 				      match.mask->dst.s6_addr32);
+		if (ipv6_addr_any((struct in6_addr *)match.key->src.s6_addr32))
+			rule->unused_tuple |= BIT(INNER_SRC_IP);
+		if (ipv6_addr_any((struct in6_addr *)match.key->dst.s6_addr32))
+			rule->unused_tuple |= BIT(INNER_DST_IP);
 	} else {
 		rule->unused_tuple |= BIT(INNER_SRC_IP);
 		rule->unused_tuple |= BIT(INNER_DST_IP);
-- 
2.33.0


