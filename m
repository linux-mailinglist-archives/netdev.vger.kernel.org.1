Return-Path: <netdev+bounces-122589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C0961CE9
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1198285CFE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A40156227;
	Wed, 28 Aug 2024 03:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D914831F;
	Wed, 28 Aug 2024 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814966; cv=none; b=Ai7AGl2FWU8x8QmGD37f4AuufXa18CmqXD7xYCq4eXHO4BBy5z1Hs/mEbSCyBi5Cnx4dehjezcLaBB9TkSkf4QUnG6S0z7us464N0BfVDMlYe/m2NcrXANjIZTGp7Dipfdva14D85rB7psNQQaiEwQyE8teLJAD6yNxD3aTLkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814966; c=relaxed/simple;
	bh=h7r1Cl+K6nCmY+aQjQpL0XcvBEZy16Opj6vYfMq9Xxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYJ6TADzTcO2UqG7jjis+ywGUWKXheEzmOKM63x/4v0VvmUrWnrtgzSaWgEJ8xrwg6J9hsPfW1G8let2N/8vFTFWaqsIbbuYQq8Dc5ttC3ahumkx712/jnC1kix7rRyBHLhVKfd6oSUVgbgM6dkmbvlZHExWcYR1yPDscqp9Sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WtqDw6SP9zQqxg;
	Wed, 28 Aug 2024 11:11:12 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 53DA0180087;
	Wed, 28 Aug 2024 11:16:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 11:16:01 +0800
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
Subject: [PATCH net-next v2 10/13] net: dsa: microchip: Use scoped function to simplfy code
Date: Wed, 28 Aug 2024 11:23:40 +0800
Message-ID: <20240828032343.1218749-11-ruanjinjie@huawei.com>
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

Avoids the need for manual cleanup of_node_put() in early exits
from the loop by using for_each_available_child_of_node_scoped().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
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


