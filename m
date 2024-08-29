Return-Path: <netdev+bounces-123113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8C5963B50
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBDE1C2197B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711A166F01;
	Thu, 29 Aug 2024 06:23:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E0715DBC6
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912608; cv=none; b=hBfiBAcjJop+1YdmQtS5jNp0KPRWAeSntGXcbLFh/kQua4yny5Gov3jF+0CvkwzgRGiObf31UFHlRSPCB1RoD3o3Kum7sA8kdroV+gBFKzwoYvxyRA6yPbgipTT6IP3UIon6++uB1Yw1WYtR//I5xzNVl1uG2E0xFtuwOVwZXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912608; c=relaxed/simple;
	bh=M3qKQE/U8c0EraIvCeSRwTBvPBGRapy1KhFj4ZNKKok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIlWGiEexVyekHIvqDHOWt2qZ4muHgX0OKSyzntsOA7vLZccmI/RzuDozLr73JT8Jd4xa469qcqY65+fIarSLifDRRDd+zMPsiYZW/2TxtuH3Z91AutVlZwWhgd5/xHYm+kG5A0uQ3cz3MTGXsEBV5W4TvJmSeOBMXX150C0IoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WvWS00lfHz1S9CT;
	Thu, 29 Aug 2024 14:23:12 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DEBF180019;
	Thu, 29 Aug 2024 14:23:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:23 +0800
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
Subject: [PATCH net-next v3 07/13] net: mdio: mux-mmioreg: Simplified with scoped function
Date: Thu, 29 Aug 2024 14:31:12 +0800
Message-ID: <20240829063118.67453-8-ruanjinjie@huawei.com>
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

Avoids the need for manual cleanup of_node_put() in early exits
from the loop by using for_each_available_child_of_node_scoped().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
- Add Reviewed-by.
v2:
- Split into 2 patches.
---
 drivers/net/mdio/mdio-mux-mmioreg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-mmioreg.c b/drivers/net/mdio/mdio-mux-mmioreg.c
index de08419d0c98..4d87e61fec7b 100644
--- a/drivers/net/mdio/mdio-mux-mmioreg.c
+++ b/drivers/net/mdio/mdio-mux-mmioreg.c
@@ -96,7 +96,7 @@ static int mdio_mux_mmioreg_switch_fn(int current_child, int desired_child,
 
 static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 {
-	struct device_node *np2, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct mdio_mux_mmioreg_state *s;
 	struct resource res;
 	const __be32 *iprop;
@@ -139,20 +139,18 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 	 * Verify that the 'reg' property of each child MDIO bus does not
 	 * set any bits outside of the 'mask'.
 	 */
-	for_each_available_child_of_node(np, np2) {
+	for_each_available_child_of_node_scoped(np, np2) {
 		u64 reg;
 
 		if (of_property_read_reg(np2, 0, &reg, NULL)) {
 			dev_err(&pdev->dev, "mdio-mux child node %pOF is "
 				"missing a 'reg' property\n", np2);
-			of_node_put(np2);
 			return -ENODEV;
 		}
 		if ((u32)reg & ~s->mask) {
 			dev_err(&pdev->dev, "mdio-mux child node %pOF has "
 				"a 'reg' value with unmasked bits\n",
 				np2);
-			of_node_put(np2);
 			return -ENODEV;
 		}
 	}
-- 
2.34.1


