Return-Path: <netdev+bounces-301673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RziTBpnmO2pTfAgAu9opvQ
	(envelope-from <netdev+bounces-301673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:15:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45A6BF039
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:15:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="iztr/RQI";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301673-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301673-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42CB130B4483
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EA33BF692;
	Wed, 24 Jun 2026 14:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DF3BD646;
	Wed, 24 Jun 2026 14:13:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310427; cv=none; b=Gu0XryKjRG8+CMT2DAQvyugepRtbZACq5jEW3sW+L3hnP5ZU2Uu8xNLAJj9p7l88eVhk/rAu0IGJWTo4nGxsYLs9X9EETh7JD2E1/gbavkwJKB9aL8NnMn+dKl/yeEK643EgVkFetX+DXdkp6SsCBORMl6vYMilSSRp4TsKp+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310427; c=relaxed/simple;
	bh=ecq8X27WUlcD6CGRnsnN8jdbbG08c6CgSG1Tge++SGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=if1YjV7HTsDwzwkhLpZJHO+K/BjI7QsG0szCHvD031b7zHGvPDIs1MIbUV5oL+PumJAFRj+Qbc4OCDoAGkeNEXbz0JKgQV7ORWqb+vcF6SblLUwvRbOKCDXbuVZKBTZGSC2Er/NLELEZOl4dgkDoZ1JwBCso1k2g2gX3NLWs7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iztr/RQI; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZwA/s/5XnySdVCJVedrFV2NNFQgsq8LvqPgYCIvpi5I=;
	b=iztr/RQIQLS+0x9TfRIdmmhmQHL0mSXhFKKOup3o42hRJG/6tfvqSwwMJc93T5QMYKiMA/rPr
	8nEiDMbys+CB2SkVqW2aVgpXoQefmzcJrmkoXaUQ5gXb0NNbyfKDFkFTTjeCsy3vFeiI6RBlC12
	C/gOynVbBx6F+tOjAq3PTRo=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4glkGM5B4yz1T4G8;
	Wed, 24 Jun 2026 22:04:59 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id CE9E140561;
	Wed, 24 Jun 2026 22:13:40 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 22:13:40 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 4/4] net: hns3: differentiate autoneg default values between copper and fiber
Date: Wed, 24 Jun 2026 22:13:19 +0800
Message-ID: <20260624141319.271439-5-shaojijie@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301673-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,h-partners.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA45A6BF039

From: Shuaisong Yang <yangshuaisong@h-partners.com>

Fix a link loss issue during driver initialization on optical ports
connected to forced-mode (non-autoneg) remote switches.

Previously, during driver probe or initialization, hclge_configure()
blindly hardcoded hdev->hw.mac.req_autoneg to AUTONEG_ENABLE for all
media types. While this is necessary for copper (BASE-T) ports to
establish a link, many high-speed optical (fiber) ports in data
centers are connected to switches running in forced mode (fixed speed,
autoneg disabled). Forcing autoneg on these optical ports during
initialization causes a permanent link failure since the remote end
refuses to respond to autoneg pulses.

Fix this by implementing media-type differentiated initialization in
hclge_init_ae_dev(). Copper ports continue to default to
AUTONEG_ENABLE, while optical ports strictly inherit the preset
autoneg status pre-configured by the firmware (hdev->hw.mac.autoneg),
preserving native compatibility with forced-mode network environments.

Fixes: 05eb60e9648c ("net: hns3: using user configure after hardware reset")
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in V2:
- Fix a link-loss regression on fiber ports in forced mode where the
  helper would configure hardware with the static default_speed instead
  of the firmware-probed SFP speed, by synchronizing req_speed from
  mac.speed when req_autoneg is overridden to AUTONEG_DISABLE.
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d176100d3e4c..fc8587c80813 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9498,6 +9498,13 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto err_ptp_uninit;
 
+	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER) {
+		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
+		if (hdev->hw.mac.autoneg == AUTONEG_DISABLE &&
+		    hdev->hw.mac.speed != SPEED_UNKNOWN)
+			hdev->hw.mac.req_speed = hdev->hw.mac.speed;
+	}
+
 	ret = hclge_set_autoneg_speed_dup(hdev);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.33.0


