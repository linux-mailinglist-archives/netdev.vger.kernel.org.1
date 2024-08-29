Return-Path: <netdev+bounces-123116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14EE963B55
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109981C22B5E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59982171E4F;
	Thu, 29 Aug 2024 06:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768016C437
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912613; cv=none; b=dUZA0ZoB60TVjJcFGAxlIRVAu1aR5+zkeR3pNXJZwtnUh/ZUOAp+jrryItRHhgVP3J8fVN/J/Fm6jb/gT4MNmjmyHihVbdyaxLNCxY1nyVBFp8bHFC8hKwwlC4aEEDffGaEqBkL+7gGdAE+r8yNSe5S9RxOg8qUkrF9EYS+42G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912613; c=relaxed/simple;
	bh=d9j+PE3W0MkMIw3CPTif/GX7kZpz2hHZhSfjcy+uecg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1twjod0oydFAYQop/kEz7evNSR3pipS5VzMJh/x7RbEcy+nfFXWnmV5zYLnHhjiOm78d0hWhUY7ZEnXOQ/9LQywx50kCDWl3iNkNLpPQ1+UaVs0tbD/JMLlQts9IwzrwGRWmhRGI3KVfUhQiX+urg5VeuN2cL+e93ZDraif48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WvWLk1qpJzQqxb;
	Thu, 29 Aug 2024 14:18:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E69FD180AE6;
	Thu, 29 Aug 2024 14:23:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <mcoquelin.stm32@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3 12/13] net: bcmasp: Simplify with scoped for each OF child loop
Date: Thu, 29 Aug 2024 14:31:17 +0800
Message-ID: <20240829063118.67453-13-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829063118.67453-1-ruanjinjie@huawei.com>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_available_child_of_node_scoped() when
iterating over device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
- Sort the variables, longest first, shortest last.
- Add Reviewed-by.
v2:
- Split into 2 patches.
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 20c6529ec135..297c2682a9cf 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1300,9 +1300,9 @@ static void bcmasp_remove_intfs(struct bcmasp_priv *priv)
 
 static int bcmasp_probe(struct platform_device *pdev)
 {
-	struct device_node *ports_node, *intf_node;
 	const struct bcmasp_plat_data *pdata;
 	struct device *dev = &pdev->dev;
+	struct device_node *ports_node;
 	struct bcmasp_priv *priv;
 	struct bcmasp_intf *intf;
 	int ret = 0, count = 0;
@@ -1374,12 +1374,11 @@ static int bcmasp_probe(struct platform_device *pdev)
 	}
 
 	i = 0;
-	for_each_available_child_of_node(ports_node, intf_node) {
+	for_each_available_child_of_node_scoped(ports_node, intf_node) {
 		intf = bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
 			dev_err(dev, "Cannot create eth interface %d\n", i);
 			bcmasp_remove_intfs(priv);
-			of_node_put(intf_node);
 			ret = -ENOMEM;
 			goto of_put_exit;
 		}
-- 
2.34.1


