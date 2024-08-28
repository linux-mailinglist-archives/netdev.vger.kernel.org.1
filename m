Return-Path: <netdev+bounces-122584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E74961CDE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF64028549F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5514A4D6;
	Wed, 28 Aug 2024 03:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D414831D;
	Wed, 28 Aug 2024 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814961; cv=none; b=m1TOSNqOtUCalLuGrjcRI2HDOj/RrzW4fCk4DGvPlrLG9/XJMeZo5TUt5mmm+NhOWsir+LrLvR0foETEqxfca1vcZ/hAqTn96E+UjF5LF+j0/Kvi7fCi3m2cWMUm9Kcp7tdKiFj7QkNeRaC5vv1wCSNXlYwgYRRhSatuAgjeAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814961; c=relaxed/simple;
	bh=Hcitsk+sQ0vwRdxz06apI9Y3L8CDjtyTC4GBbhELy7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obZIlP1XfIaU+UJQU3r3Se4VllDnXAIgLaeMp6rIb5ZCoQUKKwOKJppkEHVv/U+SAkiFB7XyJeTcGrLTKjp4m14wj7m+Rb7eGN1EpGhDrO5qVFVaSz4m3XgfBzmBBPQ1H4OIEFPJag4VhauZBP8euvoxS4rW8GGoPS5fqDDXN1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WtqDp5s06zQqxb;
	Wed, 28 Aug 2024 11:11:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 408A6180AE8;
	Wed, 28 Aug 2024 11:15:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 11:15:55 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2 04/13] net: dsa: realtek: Use __free() to simplify code
Date: Wed, 28 Aug 2024 11:23:34 +0800
Message-ID: <20240828032343.1218749-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828032343.1218749-1-ruanjinjie@huawei.com>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoid need to manually handle of_node_put() by using __free(), which
can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2
- Split into 2 patches.
---
 drivers/net/dsa/realtek/rtl8366rb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 7001b8b1c028..0acdcdd93ea2 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1009,7 +1009,6 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 
 static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 {
-	struct device_node *leds_np;
 	struct dsa_switch *ds = &priv->ds;
 	struct dsa_port *dp;
 	int ret = 0;
@@ -1018,7 +1017,8 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 		if (!dp->dn)
 			continue;
 
-		leds_np = of_get_child_by_name(dp->dn, "leds");
+		struct device_node *leds_np __free(device_node) =
+			of_get_child_by_name(dp->dn, "leds");
 		if (!leds_np) {
 			dev_dbg(priv->dev, "No leds defined for port %d",
 				dp->index);
@@ -1032,7 +1032,6 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 				break;
 		}
 
-		of_node_put(leds_np);
 		if (ret)
 			return ret;
 	}
-- 
2.34.1


