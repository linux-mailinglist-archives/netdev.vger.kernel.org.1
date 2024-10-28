Return-Path: <netdev+bounces-139688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AD9B3CF4
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31DDB214C5
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FD1CC17A;
	Mon, 28 Oct 2024 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="C3W+LfIt"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8EB1E0E09
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151667; cv=none; b=tc1raEKX4XifAUM3LaZEH8d/OOwTH0EhS770gt3Io0E2LaWasG55HbOHJ0RiH0NibzoIbVaBb38b+C8Pze78uUGhh7g5EFGDDYi7BcLuZynwuqPxVdq3RhRIPH/ont3Awb3Nkh0W2/VnT8gMOw44OR+oKqL6CZ3tJMkrY4jflXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151667; c=relaxed/simple;
	bh=T6NKZRoZMgi9Bxf+AqKvEvR7Wu/07N8Mq9VA5Wyu4PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtsSygpUI6Mg4webADDhk0tgVVWh8hA1wFfq5SPK4L37ZaHnTO2bLyet2sxzaeK/fzzy3dT9VwZl3ogMMZrcE8nQzQz+usTPL/nrMTumqhDdAsFt+an7veKwJKMbH5yL/H3R6qz31I00qVoLkF3ELLpD/sUzQEk8x4kfxqa3NYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=C3W+LfIt; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RmNZQUrDG0I4kQwz1CQFM/Kd8WIbb0yB26xYQXOFeBk=; b=C3W+LfItVrq4msQ/SRsFq1yG3S
	HCT/4+z2pcXTQHbeDftTx+QH41z5V6zsckFvgzYK9A0TJCM/gMV3UXUAkyPGXbiEi6SQ+VpKFQdIf
	16G6RqXDl66ty4wHemb89XBgF6zPdgwq11Qsg7KqxJZs7Yb4VuqCqRIpEoWhuEXeKbrk=;
Received: from 88-117-52-189.adsl.highway.telekom.at ([88.117.52.189] helo=hornet.engleder.at)
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t5WVJ-0000000077v-1BDh;
	Mon, 28 Oct 2024 21:38:21 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next 2/4] net: phy: Support speed selection for PHY loopback
Date: Mon, 28 Oct 2024 21:38:02 +0100
Message-Id: <20241028203804.41689-3-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241028203804.41689-1-gerhard@engleder-embedded.com>
References: <20241028203804.41689-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

phy_loopback() leaves it to the PHY driver to select the speed of the
loopback mode. Thus, the speed of the loopback mode depends on the PHY
driver in use.

Add support for speed selection to phy_loopback() to enable loopback
with defined speeds.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c              | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c        | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c  | 8 ++++----
 drivers/net/phy/phy_device.c                            | 6 +++---
 include/linux/phy.h                                     | 2 +-
 net/core/selftests.c                                    | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index e4ce8575ff76..5c501e4f9e3e 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -230,7 +230,7 @@ static int tsnep_phy_loopback(struct tsnep_adapter *adapter, bool enable)
 {
 	int retval;
 
-	retval = phy_loopback(adapter->phydev, enable);
+	retval = phy_loopback(adapter->phydev, enable, 0);
 
 	/* PHY link state change is not signaled if loopback is enabled, it
 	 * would delay a working loopback anyway, let's ensure that loopback
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index a5bb306b2cf1..4ad8d8da594d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -266,9 +266,9 @@ static int hns_nic_config_phy_loopback(struct phy_device *phy_dev, u8 en)
 		if (err)
 			goto out;
 
-		err = phy_loopback(phy_dev, true);
+		err = phy_loopback(phy_dev, true, 0);
 	} else {
-		err = phy_loopback(phy_dev, false);
+		err = phy_loopback(phy_dev, false, 0);
 		if (err)
 			goto out;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index bd86efd92a5a..653cef115b49 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7859,7 +7859,7 @@ static int hclge_enable_phy_loopback(struct hclge_dev *hdev,
 	if (ret)
 		return ret;
 
-	return phy_loopback(phydev, true);
+	return phy_loopback(phydev, true, 0);
 }
 
 static int hclge_disable_phy_loopback(struct hclge_dev *hdev,
@@ -7867,7 +7867,7 @@ static int hclge_disable_phy_loopback(struct hclge_dev *hdev,
 {
 	int ret;
 
-	ret = phy_loopback(phydev, false);
+	ret = phy_loopback(phydev, false, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 80079657afeb..9a456ebf9b7c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -258,7 +258,7 @@ void hclge_mac_start_phy(struct hclge_dev *hdev)
 	if (!phydev)
 		return;
 
-	phy_loopback(phydev, false);
+	phy_loopback(phydev, false, 0);
 
 	phy_start(phydev);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 3ca1c2a816ff..a01bc394d1ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -382,14 +382,14 @@ static int stmmac_test_phy_loopback(struct stmmac_priv *priv)
 	if (!priv->dev->phydev)
 		return -EOPNOTSUPP;
 
-	ret = phy_loopback(priv->dev->phydev, true);
+	ret = phy_loopback(priv->dev->phydev, true, 0);
 	if (ret)
 		return ret;
 
 	attr.dst = priv->dev->dev_addr;
 	ret = __stmmac_test_loopback(priv, &attr);
 
-	phy_loopback(priv->dev->phydev, false);
+	phy_loopback(priv->dev->phydev, false, 0);
 	return ret;
 }
 
@@ -1985,7 +1985,7 @@ void stmmac_selftest_run(struct net_device *dev,
 		case STMMAC_LOOPBACK_PHY:
 			ret = -EOPNOTSUPP;
 			if (dev->phydev)
-				ret = phy_loopback(dev->phydev, true);
+				ret = phy_loopback(dev->phydev, true, 0);
 			if (!ret)
 				break;
 			fallthrough;
@@ -2018,7 +2018,7 @@ void stmmac_selftest_run(struct net_device *dev,
 		case STMMAC_LOOPBACK_PHY:
 			ret = -EOPNOTSUPP;
 			if (dev->phydev)
-				ret = phy_loopback(dev->phydev, false);
+				ret = phy_loopback(dev->phydev, false, 0);
 			if (!ret)
 				break;
 			fallthrough;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1c34cb947588..b3242c59afa2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2092,7 +2092,7 @@ int phy_resume(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_resume);
 
-int phy_loopback(struct phy_device *phydev, bool enable)
+int phy_loopback(struct phy_device *phydev, bool enable, int speed)
 {
 	int ret = 0;
 
@@ -2112,9 +2112,9 @@ int phy_loopback(struct phy_device *phydev, bool enable)
 	}
 
 	if (phydev->drv->set_loopback)
-		ret = phydev->drv->set_loopback(phydev, enable, 0);
+		ret = phydev->drv->set_loopback(phydev, enable, speed);
 	else
-		ret = genphy_loopback(phydev, enable, 0);
+		ret = genphy_loopback(phydev, enable, speed);
 
 	if (ret)
 		goto out;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 83b705cfbf46..8fe838a1bffb 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1790,7 +1790,7 @@ int phy_init_hw(struct phy_device *phydev);
 int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
 int __phy_resume(struct phy_device *phydev);
-int phy_loopback(struct phy_device *phydev, bool enable);
+int phy_loopback(struct phy_device *phydev, bool enable, int speed);
 int phy_sfp_connect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_attach(void *upstream, struct sfp_bus *bus);
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 8f801e6e3b91..e99ae983fca9 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -299,7 +299,7 @@ static int net_test_phy_loopback_enable(struct net_device *ndev)
 	if (!ndev->phydev)
 		return -EOPNOTSUPP;
 
-	return phy_loopback(ndev->phydev, true);
+	return phy_loopback(ndev->phydev, true, 0);
 }
 
 static int net_test_phy_loopback_disable(struct net_device *ndev)
@@ -307,7 +307,7 @@ static int net_test_phy_loopback_disable(struct net_device *ndev)
 	if (!ndev->phydev)
 		return -EOPNOTSUPP;
 
-	return phy_loopback(ndev->phydev, false);
+	return phy_loopback(ndev->phydev, false, 0);
 }
 
 static int net_test_phy_loopback_udp(struct net_device *ndev)
-- 
2.39.2


