Return-Path: <netdev+bounces-301670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dWnDJUjmO2pHfAgAu9opvQ
	(envelope-from <netdev+bounces-301670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:14:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBFE6BF012
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:14:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=WQbHfiwl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301670-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301670-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A364304B6B0
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77A3BE627;
	Wed, 24 Jun 2026 14:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257B3BE168;
	Wed, 24 Jun 2026 14:13:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310426; cv=none; b=pvtoKAYiGJPoAlXjLan7JyGmzKrAmWf2MxnNxvsw2SroTBv5+596CzBdF5/ZQBE8Zm3T9ORpCoB/WBw4/vu8uyIwcm3hIvRqbMCezI9LKHNVZXewqYaSg/nm0rzLTgb/aZIh1GDaAylwMX8W4LteOmsYIp7etvtT4UvI0i5dHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310426; c=relaxed/simple;
	bh=7cC15674Y9GiSjtEN1kqOwwY3kVDh8rcTItgSFd/Rg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCHAtOzwb38pHlytBlis7r+fedvy1JX51MO2qJ4bylN4ZB8+nJ1z9KB3jK5xcu6HjUaJMB7RqSDuiV2t02Si9zF30LmR/NT/quRhWc0YkKs7af5tM/S+fLHv8dpjWDaXkwevRSgYq692/rWXRsHeoikMN+j7EvpxpyrV8QeQ4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WQbHfiwl; arc=none smtp.client-ip=113.46.200.218
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+olL4ps1TX322aeWVUXgKr+KyWMsiHBmrdhQM3xI+N0=;
	b=WQbHfiwlHM106mX/Mu+3FjlbLBzz01KDrAd8tJn2ZTPfiNCPaaWJCuJFSBahs8TQQwFLEDzKv
	0cm8zFAOINQiMt21ftiOlCcydiJnOhU9ptpcchNswrvS2vXhv6Ej0nCmVo70zl2zOVxE502mr7h
	xCn6CN6spnaPldY0FRCmeQs=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4glkGr0dDGzpT0J;
	Wed, 24 Jun 2026 22:05:24 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id DECC940538;
	Wed, 24 Jun 2026 22:13:39 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 22:13:39 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 2/4] net: hns3: refactor MAC autoneg and speed configuration
Date: Wed, 24 Jun 2026 22:13:17 +0800
Message-ID: <20260624141319.271439-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260624141319.271439-1-shaojijie@huawei.com>
References: <20260624141319.271439-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301670-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,h-partners.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FBFE6BF012

From: Shuaisong Yang <yangshuaisong@h-partners.com>

Extract the MAC autoneg and speed/duplex/lane configuration logic out
of hclge_mac_init() and encapsulate it into a new dedicated helper
function hclge_set_autoneg_speed_dup().

In the init path (hclge_init_ae_dev), this helper is now called after
hclge_update_port_info() so that firmware-reported autoneg values are
already populated before applying the link configuration.

Introduce a separate req_lane_num field in struct hclge_mac to isolate
the user-requested lane count from mac.lane_num, which firmware may
overwrite via hclge_get_sfp_info() with stale values from a prior link
lifecycle (e.g., lane_num=4 from 100G). During probe, req_lane_num is
initialized to 0, which instructs firmware to auto-select the correct
lane count for the current speed, rather than reusing the firmware-
reported mac.lane_num that may be inconsistent with the target speed.
This prevents probe failures from mismatched (speed, lane_num) pairs.

In the reset path (hclge_reset_ae_dev), it runs immediately after
hclge_mac_init(), using the previously cached req_* values to restore
the link without re-querying firmware.

Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in V2:
- Squashed the former patch 5 ("fix init failure caused by lane_num
  contamination") into this patch. The req_lane_num separation is
  introduced here to avoid a bisect-time regression where an
  intermediate commit could fail probe with an inconsistent
  (speed, lane_num) pair.
- Rewrote the commit message to accurately describe the init/reset
  path asymmetry and the req_lane_num rationale.
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 55 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9fe6bc02d71e..fb12ba77228c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1504,6 +1504,11 @@ static int hclge_configure(struct hclge_dev *hdev)
 	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
 	hdev->hw.mac.req_duplex = DUPLEX_FULL;
 
+	/* When lane_num is 0, the firmware will automatically
+	 * select the appropriate lane_num based on the speed.
+	 */
+	hdev->hw.mac.req_lane_num = 0;
+
 	hclge_parse_link_mode(hdev, cfg.speed_ability);
 
 	hdev->hw.mac.max_speed = hclge_get_max_speed(cfg.speed_ability);
@@ -2579,6 +2584,7 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 	if (ret)
 		return ret;
 
+	hdev->hw.mac.req_lane_num = lane_num;
 	hdev->hw.mac.req_speed = (u32)speed;
 	hdev->hw.mac.req_duplex = duplex;
 
@@ -2884,20 +2890,6 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
 		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
 
-	if (hdev->hw.mac.support_autoneg) {
-		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
-		if (ret)
-			return ret;
-	}
-
-	if (!hdev->hw.mac.autoneg) {
-		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
-						 hdev->hw.mac.req_duplex,
-						 hdev->hw.mac.lane_num);
-		if (ret)
-			return ret;
-	}
-
 	mac->link = 0;
 
 	if (mac->user_fec_mode & BIT(HNAE3_FEC_USER_DEF)) {
@@ -9316,6 +9308,27 @@ static int hclge_set_wol(struct hnae3_handle *handle,
 	return ret;
 }
 
+static int hclge_set_autoneg_speed_dup(struct hclge_dev *hdev)
+{
+	int ret;
+
+	if (hdev->hw.mac.support_autoneg) {
+		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
+		if (ret)
+			return ret;
+	}
+
+	if (!hdev->hw.mac.autoneg) {
+		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
+						 hdev->hw.mac.req_duplex,
+						 hdev->hw.mac.req_lane_num);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 {
 	struct pci_dev *pdev = ae_dev->pdev;
@@ -9477,6 +9490,13 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto err_ptp_uninit;
 
+	ret = hclge_set_autoneg_speed_dup(hdev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to set autoneg speed duplex, ret = %d\n", ret);
+		goto err_ptp_uninit;
+	}
+
 	INIT_KFIFO(hdev->mac_tnl_log);
 
 	hclge_dcb_ops_set(hdev);
@@ -9807,6 +9827,13 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
+	ret = hclge_set_autoneg_speed_dup(hdev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to set autoneg speed duplex, ret = %d\n", ret);
+		return ret;
+	}
+
 	ret = hclge_tp_port_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init tp port, ret = %d\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 87adeb64e6ea..7419481422c3 100644
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


