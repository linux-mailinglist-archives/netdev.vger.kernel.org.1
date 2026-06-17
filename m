Return-Path: <netdev+bounces-300146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WnsKHs6HMmpb1gUAu9opvQ
	(envelope-from <netdev+bounces-300146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C892569934F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=dDlPjLhU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300146-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300146-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D0B3298228
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B54E3E1CEB;
	Wed, 17 Jun 2026 11:28:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DEA3E92B3;
	Wed, 17 Jun 2026 11:28:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695708; cv=none; b=GyYlqMqeLHcptLKfHewI1t1jCXZXxpGaOJGsgKcSXdtmnMd+98omP54GzW4xwtoIzxG9jEgjUhJT/O5TC1ukjTPJdG+ytRsXFgiQL1K/voYxbyRA7MrpIqcNgD96rQsrSklpYKdsXz2/nEccHX3BuqVHF8FK2fRP31TuHUF6TFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695708; c=relaxed/simple;
	bh=WMPFxioi7li4MbHPo+9Eweyyve5Hah7xPbm1/pKXyYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYCYoNDTjyaon03j72tPGAmvENXTvykJYx2YJhbZyHe8e2Kzzj1Uz0BCoXC85nfNEbzhP4OpJw7qpXixOEVZVxLBfl8URKlRd5vrWEtt2f1qUCVVN1Ph+wr5RwoA77L+ed1k/8w4/ILDmtMYm0b4d3P3uMJh/O+PQqlxxlfL7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dDlPjLhU; arc=none smtp.client-ip=113.46.200.223
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZDxqeEWE822+RJOGmlyj0wK+pYlkrEmFcG4ijQsq4Zo=;
	b=dDlPjLhUIPri1Be3hOp/SQ1qFuROS5pgJAfLhssYTxR/t+PnhjqoPC58d/34x67KFS2BAQ+F6
	IBLkOMiThwarUERNlPYGImdjCdPC4aSB6Yeu5g40DNGGXQxa7RmEuFRLfSsOZecVPzPzejnzcm2
	vzWz7d+45P1hFYZ4RL5UxgY=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ggLxh5t40zmV6K;
	Wed, 17 Jun 2026 19:20:24 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BC0D40563;
	Wed, 17 Jun 2026 19:28:24 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 19:28:23 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 5/5] net: hns3: fix init failure caused by lane_num contamination
Date: Wed, 17 Jun 2026 19:27:21 +0800
Message-ID: <20260617112721.75186-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260617112721.75186-1-shaojijie@huawei.com>
References: <20260617112721.75186-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
	TAGGED_FROM(0.00)[bounces-300146-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,h-partners.com:email,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C892569934F

From: Shuaisong Yang <yangshuaisong@h-partners.com>

Fix an initialization (probe) failure introduced when the driver
attempts to pre-query port settings from the firmware before link
setup.

To accurately implement the media-type differentiated autoneg
initialization (introduced in the previous patch), the driver queries
the firmware for preset autoneg configurations via
hclge_update_port_info() before invoking link setup. However, this
query also inadvertently pulls the stale 'lane_num' value from the last
active lifecycle (e.g., lane_num = 4 from a previous 100G link up state)
and overwrites the driver's runtime storage.

When the driver later tries to initialize the MAC with its default
speed (e.g., 25G, which requires 1 lane) but passes the stale
lane_num=4, the firmware rejects this invalid hardware parameter
combination (25G with 4 lanes) with -EINVAL, causing the entire driver
probe/initialization sequence to fail.

Fix this by introducing a new user-intent tracking variable
`req_lane_num`. Initialize `req_lane_num = 0` during probe, and pass it
into hclge_cfg_mac_speed_dup_hw(). According to the firmware
specification, passing a lane_num of 0 triggers the firmware's
automatic fallback mechanism to select the correct number of lanes
matching the speed, effectively neutralizing any cross-lifecycle
parameter contamination.

Fixes: 05eb60e9648c ("net: hns3: using user configure after hardware reset")
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 8 +++++++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 853e97b0b6ff..50837d2c7998 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1577,6 +1577,11 @@ static int hclge_configure(struct hclge_dev *hdev)
 	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
 	hdev->hw.mac.req_duplex = DUPLEX_FULL;
 
+	/* When lane_num is 0, the firmware will automatically
+	 * select the appropriate lane_num based on the speed.
+	 */
+	hdev->hw.mac.req_lane_num = 0;
+
 	hclge_parse_link_mode(hdev, cfg.speed_ability);
 
 	hdev->hw.mac.max_speed = hclge_get_max_speed(cfg.speed_ability);
@@ -2652,6 +2657,7 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 	if (ret)
 		return ret;
 
+	hdev->hw.mac.req_lane_num = lane_num;
 	if (speed != SPEED_UNKNOWN)
 		hdev->hw.mac.req_speed = (u32)speed;
 	if (duplex != DUPLEX_UNKNOWN)
@@ -11747,7 +11753,7 @@ static int hclge_set_autoneg_speed_dup(struct hclge_dev *hdev)
 	if (!hdev->hw.mac.req_autoneg) {
 		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
 						 hdev->hw.mac.req_duplex,
-						 hdev->hw.mac.lane_num);
+						 hdev->hw.mac.req_lane_num);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 032b472d2368..4ca6458625a9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -287,6 +287,7 @@ struct hclge_mac {
 	u8 support_autoneg;
 	u8 speed_type;	/* 0: sfp speed, 1: active speed */
 	u8 lane_num;
+	u8 req_lane_num;
 	u32 speed;
 	u32 req_speed;
 	u32 max_speed;
-- 
2.33.0


