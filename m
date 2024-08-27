Return-Path: <netdev+bounces-122172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E017A96038C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C009283E84
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C219CD08;
	Tue, 27 Aug 2024 07:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E9194AEF;
	Tue, 27 Aug 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744679; cv=none; b=dzABNQmaEC6qElGL0yydkIP+num7/sdRgf+MxliQeVBdxClZbe3FVJj67Ls5+mAAMZJCgETKDvYsllAP/PbwP4BK2KUWxHlWR/xbdjYYvg4X0c9lWoeT3XcVWjJIdlbxxI5ymcEloZruujzs+wvIY/lEm9bybNIE5ExKg8RlX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744679; c=relaxed/simple;
	bh=8c4Tr1gcsgc3ABStWkW8rdW8bVsFRjz1eLq2j5zUSeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMPRKhwM2CP5jdpQm31AYUpNNeU7e2+vDaGbrozNdyDYe/Y89kRf+xGJqx3+8hTbNNUr/1OjxGH7dSP10p8GAK6RHvbeaWUFAi1j8EqGe3rnF8Qh9Ot7pmluonfQFfDZ6/N250DjtopigXSgkhV8OzYsXul3b0iFj0JchsLLpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtKJt6h77zpTpP;
	Tue, 27 Aug 2024 15:42:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AD83140202;
	Tue, 27 Aug 2024 15:44:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 15:44:34 +0800
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
Subject: [PATCH -next 6/7] net: dsa: microchip: Use scoped function and __free() to simplfy code
Date: Tue, 27 Aug 2024 15:52:18 +0800
Message-ID: <20240827075219.3793198-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827075219.3793198-1-ruanjinjie@huawei.com>
References: <20240827075219.3793198-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoids the need for manual cleanup of_node_put() in early exits
from the loop by using for_each_available_child_of_node_scoped()
and __free().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index cd3991792b69..8058a0b7c161 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4595,7 +4595,6 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
 int ksz_switch_register(struct ksz_device *dev)
 {
 	const struct ksz_chip_data *info;
-	struct device_node *port, *ports;
 	phy_interface_t interface;
 	unsigned int port_num;
 	int ret;
@@ -4677,25 +4676,22 @@ int ksz_switch_register(struct ksz_device *dev)
 		ret = of_get_phy_mode(dev->dev->of_node, &interface);
 		if (ret == 0)
 			dev->compat_interface = interface;
-		ports = of_get_child_by_name(dev->dev->of_node, "ethernet-ports");
+		struct device_node *ports __free(device_node) =
+			of_get_child_by_name(dev->dev->of_node, "ethernet-ports");
 		if (!ports)
 			ports = of_get_child_by_name(dev->dev->of_node, "ports");
 		if (ports) {
-			for_each_available_child_of_node(ports, port) {
+			for_each_available_child_of_node_scoped(ports, port) {
 				if (of_property_read_u32(port, "reg",
 							 &port_num))
 					continue;
-				if (!(dev->port_mask & BIT(port_num))) {
-					of_node_put(port);
-					of_node_put(ports);
+				if (!(dev->port_mask & BIT(port_num)))
 					return -EINVAL;
-				}
 				of_get_phy_mode(port,
 						&dev->ports[port_num].interface);
 
 				ksz_parse_rgmii_delay(dev, port_num, port);
 			}
-			of_node_put(ports);
 		}
 		dev->synclko_125 = of_property_read_bool(dev->dev->of_node,
 							 "microchip,synclko-125");
-- 
2.34.1


