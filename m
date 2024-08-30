Return-Path: <netdev+bounces-123599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD679657CE
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E161F24102
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D914F13D;
	Fri, 30 Aug 2024 06:49:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8552374D1;
	Fri, 30 Aug 2024 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000598; cv=none; b=ezLMq7q/2MRrWQzhsjMMdYbydbwu0WFYKT6FgVBhsNSFwA4HkzBclYebxZ6EiE49QgrV2umyVz+3xv/sF7HtQv4lFMFRApdbt9rm1MzeYbuAQVE6MyVALp6aKAmW1Zpv9ha5vFSDRfqcAnRWke1zpEvFuOSfqi508/UtYPwVbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000598; c=relaxed/simple;
	bh=HVcshivvRfucW7wgpqvNmGNGqzxULsJLHVEFI2Fw+1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VAEn4aK7we6/LC7+K0E+SYKV9FmY8AYX37Qx9/GyH8rIMedHr9Cpz9pvnixfVLNAzCesZoX7RkKkNMsm+l/f1vmPaUl9avK0rOkkB4pxhS8ycx5PwU9aJMrHFtbmS8lAtOfYlfdYiLwGyoTi+LKNZmaY2lybnQiz2LciZnlPfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ww7wQ6xRyz1HHmv;
	Fri, 30 Aug 2024 14:46:30 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BAFAA180041;
	Fri, 30 Aug 2024 14:49:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 14:49:52 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] net: dsa: Simplify with scoped for each OF child loop
Date: Fri, 30 Aug 2024 14:58:01 +0800
Message-ID: <20240830065801.3529739-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Remove the goto.
---
 net/dsa/dsa.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..24f566838621 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1264,9 +1264,8 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 				     struct device_node *dn)
 {
-	struct device_node *ports, *port;
+	struct device_node *ports;
 	struct dsa_port *dp;
-	int err = 0;
 	u32 reg;
 
 	ports = of_get_child_by_name(dn, "ports");
@@ -1279,33 +1278,30 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 		}
 	}
 
-	for_each_available_child_of_node(ports, port) {
-		err = of_property_read_u32(port, "reg", &reg);
+	for_each_available_child_of_node_scoped(ports, port) {
+		int err = of_property_read_u32(port, "reg", &reg);
 		if (err) {
-			of_node_put(port);
-			goto out_put_node;
+			of_node_put(ports);
+			return err;
 		}
 
 		if (reg >= ds->num_ports) {
 			dev_err(ds->dev, "port %pOF index %u exceeds num_ports (%u)\n",
 				port, reg, ds->num_ports);
-			of_node_put(port);
-			err = -EINVAL;
-			goto out_put_node;
+			of_node_put(ports);
+			return -EINVAL;
 		}
 
 		dp = dsa_to_port(ds, reg);
 
 		err = dsa_port_parse_of(dp, port);
 		if (err) {
-			of_node_put(port);
-			goto out_put_node;
+			of_node_put(ports);
+			return err;
 		}
 	}
 
-out_put_node:
-	of_node_put(ports);
-	return err;
+	return 0;
 }
 
 static int dsa_switch_parse_member_of(struct dsa_switch *ds,
-- 
2.34.1


