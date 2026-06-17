Return-Path: <netdev+bounces-300144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id psFvEY+HMmpK1gUAu9opvQ
	(envelope-from <netdev+bounces-300144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:39:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B180D69931C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:39:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=S0UpbCav;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300144-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300144-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1699C32BB0EB
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519773D0927;
	Wed, 17 Jun 2026 11:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AB2E03EA;
	Wed, 17 Jun 2026 11:28:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695703; cv=none; b=G4K1JF+QsKS1c7GCW/kBlLIisVtgDmQaMf9P+JnPJGkt7ptINamy3jXBNJ5ZidcvfCs64X/GTAmfTKYe8uXX2bKzbyMpG14wJElpRGp8mPvpKemR2uwjBvjNJUDh/LQTEg6YFOuDjp8yQMfoiOjpacy1y6esjyw7L6oh+L8k3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695703; c=relaxed/simple;
	bh=7Lk7xlXLk52vjOJlW8INysOgXmh1CJObhNDxY3kwTPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcBvWKUoLZPT5XrFKWDFTE+A+OHSN6j2rLnc+vTNZVRimOH/Z5703YtFlDOeImVLy70s3C0PbQTPnpEIxaO/+ELR2N1ilS+IO2Mv9OYRH0evvzKyUhoHXEFaggHB7GXxYoXfBMkeiThHpM25Uzzdlf95g0ujyw13ZCOw7IEavHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S0UpbCav; arc=none smtp.client-ip=113.46.200.224
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UoFton//N2Ofzt6VaY4Ci/2GL4/RauwEz4aXLaQWWnA=;
	b=S0UpbCavpsRMgGgNxpsVj8IgwN7zKchU+5uRGP/AOVRaRrzXaqZ+xB2vkAWiu1gj1l1kAbD7O
	IpPuuNXINIR75p5hiJ3zaqVWTHV0udlWKV8W/nFpk5MKJtJ/n99NPBG9uXbP8Aixp0EJkAA9GrO
	4+LQUB3poZ1uln2R9K0a2XY=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4ggLxb4S5qz1cyss;
	Wed, 17 Jun 2026 19:20:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 02EF040563;
	Wed, 17 Jun 2026 19:28:17 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 19:28:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 2/5] net: hns3: refactor MAC autoneg and speed configuration
Date: Wed, 17 Jun 2026 19:27:18 +0800
Message-ID: <20260617112721.75186-3-shaojijie@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-300144-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B180D69931C

From: Shuaisong Yang <yangshuaisong@h-partners.com>

Extract the MAC autoneg and speed/duplex/lane configuration logic out
of hclge_mac_init() and encapsulate it into a new dedicated helper
function hclge_set_autoneg_speed_dup().

Currently, hclge_mac_init() handles various heterogeneous operations
including MTU settings, buffer allocation, and loopback initialization.
Stripping the complex link state machine configuration improves code
readability and reduces cyclomatic complexity. This helper function
will also be invoked during the hardware reset recovery path to
re-apply link settings without repeating unnecessary buffer or MTU
initializations.

Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 49 +++++++++++++------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5a00797d9252..2c74675b149f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2957,20 +2957,6 @@ static int hclge_mac_init(struct hclge_dev *hdev)
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
@@ -11740,6 +11726,27 @@ static int hclge_set_wol(struct hnae3_handle *handle,
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
+						 hdev->hw.mac.lane_num);
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
@@ -11901,6 +11908,13 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
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
@@ -12231,6 +12245,13 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
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
-- 
2.33.0


