Return-Path: <netdev+bounces-244955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65712CC4355
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDF8B307B2AA
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7924E4C6;
	Tue, 16 Dec 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FQiBv0oU"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAE23D7D4;
	Tue, 16 Dec 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897710; cv=none; b=cvn/R7tcFbH/+z6IQb4ESdnBjoX+JIHpYEvQhD5lsxivirCszRE0UKScMpfjZngRk27sZOahiQtbO47vpuiEBQxLuJz8PES0w9QPEXcjjWH/iRi2a/nEvQTe+0crBXz1DYinIU8j5nokHr4Iupc3yCsM8N8Q6rzaG9DeSWWFg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897710; c=relaxed/simple;
	bh=T4GfTzdDT+WLwDcLZ+kcam3IJyG5h9kwtrEYOpzlSlI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZFMOIVkIFjDQNlPk4sIe6jEtVu3phCQAMG4/Kf2xbhhFfLjCmNuXaCYZCFK5BvVqq+vVrIVV8RqREM5R8WjtACwpJW+e6w6U9ER/WQCFcQ92stGTeVXnAJTlAqI5vmcEpJM1M7+NZwgAN4gAF14Pl245BHgGKx7wf9A2yyWX3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FQiBv0oU; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=LFrFoKsKHi5MKf5
	l5656b7lBtyZwulDZhSgVO40faJg=; b=FQiBv0oU4iOMxeVwCtJMGf2KyQSORP2
	gHvglybFUQQoljHVroWHfpdTXJ3JvlhKMzwFvobSwi4xzFRiMrZ3AsRTLbyCpeu4
	zvdj9OV98YqVPqrjZNZwizTrK8KJU73ihYkavw2Stxadnzc88H2fxyiwiht0fs+5
	aJ49EBKvt00k=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3X_ukdUFptVRoHQ--.1199S2;
	Tue, 16 Dec 2025 23:07:31 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: heiko@sntech.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH 2/2] [PATCH net-next v2 2/2] net: stmmac: dwmac-rk:return actual error from phy_power_on
Date: Tue, 16 Dec 2025 07:07:15 -0800
Message-Id: <20251216150715.3672-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:PCgvCgD3X_ukdUFptVRoHQ--.1199S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF47Ww4UKr43Zw1UCw48WFg_yoWfCFX_W3
	WjvFnaqa1UtFW0yrn8Aa13ZryS9Fs8WrZ3ArsFga93Cay7uw1DA34DurZxAr4DWw40vF9r
	Gr13tF4Iyw1xJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMOzVUUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbC3RQ14GlBdbRwhAAA3B
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The function phy_power_on currently always returns 0, even when
regulator operations fail. This patch modifies it to return the
actual error code from regulator_enable/disable operations

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 2f5a65c235aa..fa989cb96714 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1514,7 +1514,7 @@ static int rk_phy_power_set(struct rk_priv_data *bsp_priv, bool enable)
 			dev_err(dev, "fail to disable phy-supply\n");
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
-- 
2.17.1


