Return-Path: <netdev+bounces-123600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C44819657D6
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE6AB21972
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467921531CB;
	Fri, 30 Aug 2024 06:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BF1D12F7;
	Fri, 30 Aug 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000757; cv=none; b=I1/tAWv+v3ERF+A7pQ1+9UXvMsiFrcJ890RG5YXzLHQV9RqbOR3biNNIiQdBbPg4WlffPuyEl8SNmua3BKxQG1vHkeDNbjaj1qYxBXtsF6RJYRtToy+byJajA7TXGnGKHLin65JC804VrE1cOo11c6SUvnXiJWWffJYcu8Q4oNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000757; c=relaxed/simple;
	bh=0hn3Betc7tfW+6SbzlbneRilASAMWCLpLy4y2NRCHp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WlevOzs6OjfwhjUqvVlm89dAyvP8Ehr+DY8oRQjA1h67dU2ZQt1EbvyeNqxt8QJ6E7JVxp/CegFBxaIsy2qC70eNdN+t2jEMBkhajpSq31oOyOpQIDqvtEuqfVwV/5xfvvrP4H0IJVxhuViN3AuQh2cVRdb4bwpF4YWTiHykv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ww82m0MvfzyR8Q;
	Fri, 30 Aug 2024 14:52:00 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6526D18005F;
	Fri, 30 Aug 2024 14:52:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 14:52:31 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2 RESEND] net: dsa: Simplify with scoped for each OF child loop
Date: Fri, 30 Aug 2024 15:00:37 +0800
Message-ID: <20240830070037.3529832-1-ruanjinjie@huawei.com>
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
v1 -> v2 RESNED:
- Remove the goto.
- next -> net-next
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


