Return-Path: <netdev+bounces-301669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0uZZGkPmO2pGfAgAu9opvQ
	(envelope-from <netdev+bounces-301669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:14:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C97926BF00D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=Jygd5fOp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301669-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301669-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEB553030746
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B283BE17D;
	Wed, 24 Jun 2026 14:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513B3BBFC1;
	Wed, 24 Jun 2026 14:13:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310426; cv=none; b=Yi4MOOAfEK0UBjGP36wNhmZxQaBpWpgqfhiiiTD+fG8S74JaPlgxCd0xKRH1iTbYJwpk+BVdP1Zjeh+ow28Nx7DE/Q9jYsWT1h41voWTOg5P1FXpXnGHMnVL8rZplcwGs2EP3WxOJhbhkgDBtpFOhdXKZ72zTb1I+CqvYXi0U9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310426; c=relaxed/simple;
	bh=+ykReh263zVhkT5BpVlbc1o72y7Pqyx63/3ScRJ57oY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgrmW+tiaNj/KbOd/K/GbSEbBYODCZWgxTRsbfmNcy0D4tu2qX+xd+t8pM4Pbfgtr/UdWaPhgbgIHeDQnm0dhTvJ8QT8GMHP4s8nrZBTsAyi2LpoLzqnVkJ60fQ0+BTkXa8z9CdX5L8BoGVCUgmgd5gNuAhpN37TQkh3YcE1ZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Jygd5fOp; arc=none smtp.client-ip=113.46.200.224
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VmF1BOg0iSl0WxDVNJcuHj613vnybNB35fVJ+XHjddY=;
	b=Jygd5fOp9wGHMurMCcea1aU70CouHdZRVq9jNGlvbO8+KPOBQ3YUIs7iPtGLZ1IvgPgWX/fbr
	odGb9c2QtoN8SQ0gQFbibMiFBS8La22KubXz8xuNuIt7atmeExbe1mPn0oxucTTu8pqQJyqABhb
	j1QelmwuNnXYaIZwkdjatXg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4glkFv2sQCz1cyPh;
	Wed, 24 Jun 2026 22:04:35 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 6800540539;
	Wed, 24 Jun 2026 22:13:39 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 22:13:38 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 1/4] net: hns3: unify copper port ksettings configuration path
Date: Wed, 24 Jun 2026 22:13:16 +0800
Message-ID: <20260624141319.271439-2-shaojijie@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-301669-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,h-partners.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C97926BF00D

From: Shuaisong Yang <yangshuaisong@h-partners.com>

Refactor hns3_set_link_ksettings() and hclge_set_phy_link_ksettings()
to unify the configuration path for copper ports.

Previously, netdevs with a native kernel phy attached bypassed the main
MAC parameter caching logic and returned early via
phy_ethtool_ksettings_set(). This prevented the driver from updating
hdev->hw.mac.req_xxx variables for kernel PHY setups, leaving them
out-of-sync during reset recovery.

Clean this up by routing all copper port configurations through
ops->set_phy_link_ksettings(), and perform driver-level or kernel-level
PHY arbitration inside hclge_set_phy_link_ksettings() via
hnae3_dev_phy_imp_supported(). This ensures that the user's intended link
profiles (req_speed, req_duplex, req_autoneg) are uniformly recorded
across all copper and fiber deployment topologies, laying the groundwork
for stable reset recovery.

For copper ports where neither IMP firmware nor a kernel PHY is available
(e.g. PHY_INEXISTENT), hclge_set_phy_link_ksettings() returns -ENODEV.
In hns3_set_link_ksettings(), this is caught so the configuration falls
through to the existing MAC-level path (check_ksettings_param ->
cfg_mac_speed_dup_h), preserving compatibility with PHY-less copper
deployments.

Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in V2:
- Add NULL phydev guard in hclge_set_phy_link_ksettings() to prevent
  kernel panic when firmware reports PHY_INEXISTENT on a copper port.
- For PHY_INEXISTENT copper ports, return -ENODEV from
  hclge_set_phy_link_ksettings() and catch it in
  hns3_set_link_ksettings() to fall through to the existing MAC-level
  path, preserving compatibility with PHY-less copper deployments.
- Preserve the 1000BASE-T forced-mode (SPEED_1000 + AUTONEG_DISABLE)
  rejection in the kernel PHY path, closing a validation gap.
---
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 31 +++++++++----------
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 28 +++++++++++++++--
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 9cb7ce9fd311..64bee0e78db3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -811,12 +811,11 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 }
 
 static int hns3_check_ksettings_param(const struct net_device *netdev,
-				      const struct ethtool_link_ksettings *cmd)
+				      const struct ethtool_link_ksettings *cmd,
+				      u8 media_type)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
-	u8 module_type = HNAE3_MODULE_TYPE_UNKNOWN;
-	u8 media_type = HNAE3_MEDIA_TYPE_UNKNOWN;
 	u32 lane_num;
 	u8 autoneg;
 	u32 speed;
@@ -836,9 +835,6 @@ static int hns3_check_ksettings_param(const struct net_device *netdev,
 			return 0;
 	}
 
-	if (ops->get_media_type)
-		ops->get_media_type(handle, &media_type, &module_type);
-
 	if (cmd->base.duplex == DUPLEX_HALF &&
 	    media_type != HNAE3_MEDIA_TYPE_COPPER) {
 		netdev_err(netdev,
@@ -863,6 +859,8 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
+	u8 module_type = HNAE3_MODULE_TYPE_UNKNOWN;
+	u8 media_type = HNAE3_MEDIA_TYPE_UNKNOWN;
 	int ret;
 
 	/* Chip don't support this mode. */
@@ -878,22 +876,23 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
 		  cmd->base.autoneg, cmd->base.speed, cmd->base.duplex,
 		  cmd->lanes);
 
-	/* Only support ksettings_set for netdev with phy attached for now */
-	if (netdev->phydev) {
-		if (cmd->base.speed == SPEED_1000 &&
-		    cmd->base.autoneg == AUTONEG_DISABLE)
-			return -EINVAL;
+	if (!ops->get_media_type)
+		return -EOPNOTSUPP;
+	ops->get_media_type(handle, &media_type, &module_type);
 
-		return phy_ethtool_ksettings_set(netdev->phydev, cmd);
-	} else if (test_bit(HNAE3_DEV_SUPPORT_PHY_IMP_B, ae_dev->caps) &&
-		   ops->set_phy_link_ksettings) {
-		return ops->set_phy_link_ksettings(handle, cmd);
+	if (media_type == HNAE3_MEDIA_TYPE_COPPER) {
+		if (!ops->set_phy_link_ksettings)
+			return -EOPNOTSUPP;
+		ret = ops->set_phy_link_ksettings(handle, cmd);
+		if (ret != -ENODEV)
+			return ret;
+		/* PHY_INEXISTENT, use MAC-level configuration */
 	}
 
 	if (ae_dev->dev_version < HNAE3_DEVICE_VERSION_V2)
 		return -EOPNOTSUPP;
 
-	ret = hns3_check_ksettings_param(netdev, cmd);
+	ret = hns3_check_ksettings_param(netdev, cmd, media_type);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2f1984930da2..9fe6bc02d71e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3285,8 +3285,8 @@ static int hclge_get_phy_link_ksettings(struct hnae3_handle *handle,
 }
 
 static int
-hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
-			     const struct ethtool_link_ksettings *cmd)
+hclge_ethtool_ksettings_set(struct hnae3_handle *handle,
+			    const struct ethtool_link_ksettings *cmd)
 {
 	struct hclge_desc desc[HCLGE_PHY_LINK_SETTING_BD_NUM];
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -3327,10 +3327,32 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 		return ret;
 	}
 
+	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
+	return 0;
+}
+
+static int
+hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
+			     const struct ethtool_link_ksettings *cmd)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+	int ret = -ENODEV;
+
+	if (hnae3_dev_phy_imp_supported(hdev)) {
+		ret = hclge_ethtool_ksettings_set(handle, cmd);
+	} else if (handle->netdev->phydev) {
+		if (cmd->base.speed == SPEED_1000 &&
+		    cmd->base.autoneg == AUTONEG_DISABLE)
+			return -EINVAL;
+		ret = phy_ethtool_ksettings_set(handle->netdev->phydev, cmd);
+	}
+	if (ret)
+		return ret;
+
 	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
 	hdev->hw.mac.req_speed = cmd->base.speed;
 	hdev->hw.mac.req_duplex = cmd->base.duplex;
-	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
 
 	return 0;
 }
-- 
2.33.0


