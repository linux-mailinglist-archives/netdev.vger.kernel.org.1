Return-Path: <netdev+bounces-120039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3539095800E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84DC281DCC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416F188CD6;
	Tue, 20 Aug 2024 07:40:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE91188CBB;
	Tue, 20 Aug 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139654; cv=none; b=NGRnqEwQY76MWHEUaBWZ6bHu1SdgD0zK/ZoknMpkfh7Err1Z4F/+nBSuK3WS9TPwE214vqrXZrvlAO59vX3lvvl8fEUUPnZVKfHvTPqjFi4QY4B5D6TmOhQKslBXyOkgISeBf/etJO14h3DJdMemPxn60JfYx32m57k8DfVupZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139654; c=relaxed/simple;
	bh=JdIQBI8pfCPEIloS9LRgdMusjlgJmiV9AUDWnZhVXSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwtQ5RFJG3BGByqc02hFjybj2yB/z2TRIfuiqXlFn3VXBbQ4KNHL2Pm1rleD4TbGUoMqOAAKm7PuXAsJ48G91Pm0S0xqQmeE2/myHrQKACMLTsCyisZvrVgE80d97/v9z3nL31MCTp+vArN36qafPWf4cawGs4CFpvKJQNzeb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wp1VG4F6nz20m3L;
	Tue, 20 Aug 2024 15:36:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 000BB18001B;
	Tue, 20 Aug 2024 15:40:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 15:40:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <vladimir.oltean@nxp.com>, <claudiu.manoil@nxp.com>,
	<alexandre.belloni@bootlin.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] net: dsa: ocelot: Simplify with scoped for each OF child loop
Date: Tue, 20 Aug 2024 15:48:05 +0800
Message-ID: <20240820074805.680674-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/dsa/ocelot/felix.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index e554699f06d4..800711c2b6cb 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1265,9 +1265,8 @@ static int felix_parse_ports_node(struct felix *felix,
 				  phy_interface_t *port_phy_modes)
 {
 	struct device *dev = felix->ocelot.dev;
-	struct device_node *child;
 
-	for_each_available_child_of_node(ports_node, child) {
+	for_each_available_child_of_node_scoped(ports_node, child) {
 		phy_interface_t phy_mode;
 		u32 port;
 		int err;
@@ -1276,7 +1275,6 @@ static int felix_parse_ports_node(struct felix *felix,
 		if (of_property_read_u32(child, "reg", &port) < 0) {
 			dev_err(dev, "Port number not defined in device tree "
 				"(property \"reg\")\n");
-			of_node_put(child);
 			return -ENODEV;
 		}
 
@@ -1286,7 +1284,6 @@ static int felix_parse_ports_node(struct felix *felix,
 			dev_err(dev, "Failed to read phy-mode or "
 				"phy-interface-type property for port %d\n",
 				port);
-			of_node_put(child);
 			return -ENODEV;
 		}
 
-- 
2.34.1


