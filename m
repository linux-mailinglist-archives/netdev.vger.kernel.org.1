Return-Path: <netdev+bounces-123579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA4965588
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 05:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C874B1C21123
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370413DDD0;
	Fri, 30 Aug 2024 03:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51021137745
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987167; cv=none; b=swy0RAB8V5goAIed21vFa9MqCk5L9c9BBomL1PkDHerruAHFgQ3afzt+qK1dYyMSNifrwlcT7mtJd/kuYk/hO0gW2sxkop3+AoBnb/hMYH2+2jn6/i+6olysA1uwwNx7H7LTNjgRX+H4a09Lma0/zNwPKwiH/+urc2igMWZLUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987167; c=relaxed/simple;
	bh=bfX1/p08jom4ePeOqqxEi8jdXv6GieupzmHqNi6MFoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2E6LCbqDcM221OB2vWZE1IjP4xFADqfnsf2DwgvwpNGi6HPw+MBGD9eg8LyCoMkDCsiRndsnKEe7DjJrvNjamsQzwW1WHj+tjOw/S/JRUA7C5t2wJHKvfmrklMd4p4Gx6f/XvZOxac1bajDqrtxxNilLhqb3u1rKRKJfrbramU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ww2zJ6P94zLqtS;
	Fri, 30 Aug 2024 11:03:40 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 9199018007C;
	Fri, 30 Aug 2024 11:05:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 11:05:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v4 7/8] net: dsa: microchip: Use scoped function to simplfy code
Date: Fri, 30 Aug 2024 11:13:24 +0800
Message-ID: <20240830031325.2406672-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830031325.2406672-1-ruanjinjie@huawei.com>
References: <20240830031325.2406672-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoids the need for manual cleanup of_node_put() in early exits
from the loop by using for_each_available_child_of_node_scoped().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Add Reviewed-by.
v3:
- Add Reviewed-by.
v2:
- Split into 2 patches.
---
 drivers/net/dsa/microchip/ksz_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index cd3991792b69..86ed563938f6 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4595,7 +4595,7 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
 int ksz_switch_register(struct ksz_device *dev)
 {
 	const struct ksz_chip_data *info;
-	struct device_node *port, *ports;
+	struct device_node *ports;
 	phy_interface_t interface;
 	unsigned int port_num;
 	int ret;
@@ -4681,12 +4681,11 @@ int ksz_switch_register(struct ksz_device *dev)
 		if (!ports)
 			ports = of_get_child_by_name(dev->dev->of_node, "ports");
 		if (ports) {
-			for_each_available_child_of_node(ports, port) {
+			for_each_available_child_of_node_scoped(ports, port) {
 				if (of_property_read_u32(port, "reg",
 							 &port_num))
 					continue;
 				if (!(dev->port_mask & BIT(port_num))) {
-					of_node_put(port);
 					of_node_put(ports);
 					return -EINVAL;
 				}
-- 
2.34.1


