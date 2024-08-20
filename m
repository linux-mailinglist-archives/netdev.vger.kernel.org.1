Return-Path: <netdev+bounces-120016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56FE957EA2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB571F24E60
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B28D149C5B;
	Tue, 20 Aug 2024 06:50:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07F18E341;
	Tue, 20 Aug 2024 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136645; cv=none; b=f0eJh9erVssmzMUqO+gkmkAnlzDgqxq4AJJVpokFYo8+EfTieNrJACPd+nlNZN7K+rJn3ITp+jjkWZ/MNTs80EMRqCUXHopdGkK2I6U3xXxu8RAIsrTVCwACd7g2c7X4ztbVUnCSNTlQV2mA8hKUDWHufjO8CWURBdggcDLfl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136645; c=relaxed/simple;
	bh=kpl6F432p2ten8zAndHZAU8GDiUZGBLHxck8SL6ZLQI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QXSuVhdiXGS9RIY7ogzOhZCTtI6fUDKUpDbz/TiiMBxIDMXoU6+EM1nHTe0qm8wKJFjPEAvmce3L8GPNJ1/y4PpzNxjaIwQOQHDfKsU6X2+dIoqueZdBPOR9RgjkQ6vV5I3n8gEWzc7cB4mzWbrhktq+PsDv2IeCaCA7rDhhDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wp0TR2GpBzyQyK;
	Tue, 20 Aug 2024 14:50:19 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A6F6614037B;
	Tue, 20 Aug 2024 14:50:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 14:50:40 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] net: dsa:  Simplify with scoped for each OF child loop
Date: Tue, 20 Aug 2024 14:58:04 +0800
Message-ID: <20240820065804.560603-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 net/dsa/dsa.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..77d91cbb0686 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1264,7 +1264,7 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 				     struct device_node *dn)
 {
-	struct device_node *ports, *port;
+	struct device_node *ports;
 	struct dsa_port *dp;
 	int err = 0;
 	u32 reg;
@@ -1279,17 +1279,14 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 		}
 	}
 
-	for_each_available_child_of_node(ports, port) {
+	for_each_available_child_of_node_scoped(ports, port) {
 		err = of_property_read_u32(port, "reg", &reg);
-		if (err) {
-			of_node_put(port);
+		if (err)
 			goto out_put_node;
-		}
 
 		if (reg >= ds->num_ports) {
 			dev_err(ds->dev, "port %pOF index %u exceeds num_ports (%u)\n",
 				port, reg, ds->num_ports);
-			of_node_put(port);
 			err = -EINVAL;
 			goto out_put_node;
 		}
@@ -1297,10 +1294,8 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 		dp = dsa_to_port(ds, reg);
 
 		err = dsa_port_parse_of(dp, port);
-		if (err) {
-			of_node_put(port);
+		if (err)
 			goto out_put_node;
-		}
 	}
 
 out_put_node:
-- 
2.34.1


