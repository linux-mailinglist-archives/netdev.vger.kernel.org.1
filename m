Return-Path: <netdev+bounces-232743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0472C0883E
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 03:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3383BD159
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BF23507C;
	Sat, 25 Oct 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ECwFJ8/z"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA00224AF7;
	Sat, 25 Oct 2025 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761356853; cv=none; b=cwUEJjrexGE9tWIbVoptErkg0WixZaW5oftSzJOBQ+3pMar9zd2n+USyb/I+80I4ru7AQSVFwqZ6vtRr1I4zOFLNAgOePqC0P4kKIeuSZWOD257NuflsBYuLORGqQzdzwAZP5HEXjxEDnHQh5NrGh6bcmemUx4R9vLsHHqPX7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761356853; c=relaxed/simple;
	bh=gMIsksCQwqW2WOBKE1WoapjqbMI/EM72ZloxIN93b7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvBLbnjRybJQSAQsZFekJJrc2oqhxlwVKewopyywP46y8i8Ih+JqwbMwZwq87xFdhzZvAPNOb/RM02ExCJN2mCIBo1EAKzcmpZwJcy1eaDrBarJWJGWV2GNszdQoh3+kLNfHlESzT2tSv8z1A9dp+YAzjEzJX5/UWR8Lsy0K120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ECwFJ8/z; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aaFhJKGeApZV5kHQ1f9y5s5XqI9oMdC5Ee/Le7sF7BY=;
	b=ECwFJ8/zyMcNEApe4Dd6/mHOX4vTrIAMlxcshIoxD5e5O/v8lHq7/H2bON+ZMExJD3gq4axpH
	LyEzYB79L8jV+e/i9yE7eahQ2lv+iNvxl3HX5fZYIyax8CQgwyil3xHDn6ei9gSyxvT2xXMZPnf
	gRblb0uXpRLsA+m12NdytkU=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ctjLR4CxqzmVBH;
	Sat, 25 Oct 2025 09:46:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BCC071A016C;
	Sat, 25 Oct 2025 09:47:21 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 09:47:21 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jacob.e.keller@intel.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 2/3] net: hibmcge: remove unnecessary check for np_link_fail in scenarios without phy.
Date: Sat, 25 Oct 2025 09:46:41 +0800
Message-ID: <20251025014642.265259-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251025014642.265259-1-shaojijie@huawei.com>
References: <20251025014642.265259-1-shaojijie@huawei.com>
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

hibmcge driver uses fixed_phy to configure scenarios without PHY,
where the driver is always in a linked state. However,
there might be no link in hardware, so the np_link error
is detected in hbg_hw_adjust_link(), which can cause abnormal logs.

Therefore, in scenarios without a PHY, the driver no longer
checks the np_link status.

Fixes: 1d7cd7a9c69c ("net: hibmcge: support scenario without PHY")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h | 1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c     | 3 +++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c   | 1 -
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index ea09a09c451b..2097e4c2b3d7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -17,6 +17,7 @@
 #define HBG_PCU_CACHE_LINE_SIZE		32
 #define HBG_TX_TIMEOUT_BUF_LEN		1024
 #define HBG_RX_DESCR			0x01
+#define HBG_NO_PHY			0xFF
 
 #define HBG_PACKET_HEAD_SIZE	((HBG_RX_SKIP1 + HBG_RX_SKIP2 + \
 				  HBG_RX_DESCR) * HBG_PCU_CACHE_LINE_SIZE)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index d0aa0661ecd4..d6e8ce8e351a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -244,6 +244,9 @@ void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 
 	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
 
+	if (priv->mac.phy_addr == HBG_NO_PHY)
+		return;
+
 	/* wait MAC link up */
 	ret = readl_poll_timeout(priv->io_base + HBG_REG_AN_NEG_STATE_ADDR,
 				 link_status,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index 37791de47f6f..b6f0a2780ea8 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -20,7 +20,6 @@
 #define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
 
 #define HBG_NP_LINK_FAIL_RETRY_TIMES	5
-#define HBG_NO_PHY			0xFF
 
 static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
 {
-- 
2.33.0


