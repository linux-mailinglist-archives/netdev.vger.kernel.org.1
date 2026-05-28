Return-Path: <netdev+bounces-292848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF8wDS6uGGpolwgAu9opvQ
	(envelope-from <netdev+bounces-292848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:05:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3365FA353
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DFFF307247E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1106318B9D;
	Thu, 28 May 2026 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="YPGtZQu+"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D63546C4;
	Thu, 28 May 2026 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002232; cv=fail; b=QiNgewDcUfN4KqTIBdGk7m2nOhORMZjq0maPPLHU/rWyYfnChgl8NQIbxX4LdjHkeYjVJCCZRDPPIKVrI/Jx2IrJ/dKZo+pyoIeyybWZ4ncYqY98KMzJyuAnMbz5bJlEfamG0IVH2cZtIPzUcPajSLm53GwGsvlAZnCOHtdMhcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002232; c=relaxed/simple;
	bh=GEIoPmukQZn49SeLa9eWlbI4U9FmZJ/u1V2PSUJYGHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StXqgPCtcVsoCVNau3ps5cukCk1UO7s3eqwhW/ZCOxyAugGVi388C3iaqj4l6cN7rwACrKgKCySh8VLxQK0ipHVLiLypdTXVjgX38Mm2Rwf4NZX/Q6BbbBgUWEhlx10S83Ulm5nkg4yIfEcGExQmc23KpyJTUSm4DecvCakSqYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=YPGtZQu+; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxKnQ6ucYoLmJJreGxnAyraY44gJWINvp9L6b3Yk+DtIcw+Ke2O3ODMeL0l82kbyFbeHJHLO4FuErdIt0AUp0G1lE9byLAM0FcS7xLCDozSY3jg3EsjQ4wETCDOMZNJtAEgO5GrgzqbsJG3CwDJjjIwupEOf3UZ2GJzAh3egLM7SGzqSt1CcJywIne9ZqdqRCWP/M6fi/wVB8k0aTWSprcEX1KtwYkrcSikDv7n6UepnAQFgwK+YtTyablKaMkTYsRSSoniAWOo+2BFyHLdleheGVvElYnAT7qEliEIaM7SOAW847m+8ExVUep/kcCP7KN6bWDTGuIK87BP8zki4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT/4iiaoCSIZKJLQ5zVn+FpzwUqWSbbtV5eqOxfGTis=;
 b=uZqSHG3/CZ16+UWQs4lQ3nxDdCl433lDdPfwkJC9OH3wEOVWhObd3N6KFAh0TSQSoe/jlr9VGtP78sT9Hv58B+4A1xxqrhtmXXhIGEZmH5XnMSjtVqGIUzKhiNdV85u+Xxl1wnsDdYkhXokTs9uSl0oqXyVTRyJwz/Mm1boemdBK6MCP931iJYcBBtdckch1hc3dQLyX1B2z+wjg3gCa3AvLfZvQ8wdBcPfdrynsV5AmZOOcUZwm8oIbflJ3PBcC7teQF6gxlibv1v6Qpmkl/dXFoEEjbyUFJVKmAsag10/CtQ7EibXF68AaqWdeV+VikOFsy+QxZnzQYvOULykMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT/4iiaoCSIZKJLQ5zVn+FpzwUqWSbbtV5eqOxfGTis=;
 b=YPGtZQu+RJrVB4gi8hmfpb8K+/Jh6oX445jzu1apxQR8SuwelPrXjvof1lbthydEZXoht5iW/1QMDXQmfKbf4yRpHnxLARlS70tbP95CJDcQwnX1Ui7QEPU7o/GCAawERXBNM616lhhQCq25nDibimlo0t7kTanRiCCbHB/1f/slBHLa62Rz6IvMzd9NUuUQK8aG+8PN0iuvAvMUxuw/Dof4iJi7k9dkZcn9jYkz6DnxTo7SIp9/hQKC8EeVUDa8RwS/d3Zc1LwHEQfUwI5lnii6ue878UKelcM2m9aBD9MW0VhUCa5NwD7y71z5O4L3Q++bjFXncuHS5BRQLU2gWQ==
Received: from DB8P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::20)
 by PA4PR07MB7504.eurprd07.prod.outlook.com (2603:10a6:102:c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 21:03:45 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::57) by DB8P191CA0010.outlook.office365.com
 (2603:10a6:10:130::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 21:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 21:03:43 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 28 May 2026 23:03:43 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id D8A6B4020B4A;
	Thu, 28 May 2026 23:03:42 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id C8CFB1005D6A; Thu, 28 May 2026 23:03:42 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next v3 1/3] mv88e6xxx: Add mv88e6352_serdes_get_lane
Date: Thu, 28 May 2026 23:03:08 +0200
Message-ID: <20260528210310.1365858-2-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|PA4PR07MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 20524871-5869-4215-ebe8-08debcfc9a4d
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EZNjg+ILHUFMKqduv8a2I2h+kHqgZQpnKVFdujYHf0YfyctwTPV1sxhXnkIjLfvHMLUgH8brx7K0B3LseavRgJTnwCp6UB7p62gx7OUvwsplXqiwBSyJHNTKSjj2xKVTwaBkphEM9PlbijmMoRzXo+h4rsyjYB9zB7JKfLklDTYumcOcvIwfi+RFD8kuAh5H32C846LvelpPuIqSLBrZrrfkz3GE3+ofgsBNxx4Zrm40J33sL8VDSnMcdnvs4YywgplK9WYtVnzYhgBEBYCbSexPpf4IJ33EDq6x5e7Fw36UQ+lCJWGi8W4S0yas7VUHFp7eGNKCyEsBnkOFHdoRjqLQlXW5kS+Nd9MmjwOLAG1uz3dX8kIdGLKBr4/rtfbqeepPH8QBSoBUwYTlTeIeCnMRpFc8dQrDofODJcDiXd27w+0oZ9IUyrTeEkggjmTD2fgwIxnCMKzRTkjlHEaIJHj3/J+DVklkXhDlPtyTlIygbqui+62xKhcRt+9tZslu5fingoFbcqCEERi9sN5Oe1MSdGSQ3fabn/wmjnZo45KwHitCU0bdDK3wnhUsxVjsH3azNB/Lr69w2jx74QQIfiUqbg8bovXXogrKeBsuvZC+VDnLVzJN1cHmPc2QHaMTGmoZZoVbkQ0ZbVvKS6Tswg8aCYxHLRIys0MGvq8wjwnCrNV46lPOYhLAcvN7XctfdK5v6baSbKvvxYjfXZXHoRPCPD2KIyew7N5hLoOdMGs=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wUryXAhoGneo/eXa7/Blvrv3ZiWi0Nvq6AQyvxsUEsU+MkFWcK3IJi+uSEmF3oemq4B01eNEpN1HGYt1m6cMJsGpQwEwXW/o6O1heWqZLKV/YmZB1OTEiNFwcQlWkfJWvQAOr+UC8qn1HqWJox6icy+IeevC5ufOJ1Ko7vjVVmuFaUy+ZZidVPTEOFGoYNtBXLOUNX8lXm4DITjasCYST2zh6iiT3chchqPAlKNlkqTYUd7kppjUSV5UY3RDys9CLW8UYnQU30BOgovlzVJx2RGVPHaUZ9e6CBSh7AmCKooZUtNsVY57V74Q9lkfNdG/+Y6pqmtWvebqmIRMbPf48Wfr1NdFT01cqRDtA3FOjb1lPsQRUe4K02ESwHzwKEQzMir7ou0uMRko41F5H06vlNKfq7MTrplaqgpQ2uW70vsO7LvijBA8j61oJjcbQ4kn
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 21:03:43.9006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20524871-5869-4215-ebe8-08debcfc9a4d
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7504
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292848-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ericsson.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ericsson.com:email,ericsson.com:mid,ericsson.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CE3365FA353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Changes:
1. Add mv88e6352_serdes_get_lane function which checks if the port
supports SERDES by calling mv88e6352_g2_scratch_port_has_serdes. Then
returns the address of the SERDES lane.
2. Add this function as .serdes_get_lane member to all the chip
versions which use mv88e6352_pcs_init.

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   |  4 ++++
 drivers/net/dsa/mv88e6xxx/serdes.c | 11 +++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 63cdcce3d8c7..30c8f6e1b367 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4673,6 +4673,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_get_lane = mv88e6352_serdes_get_lane,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4776,6 +4777,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_get_lane = mv88e6352_serdes_get_lane,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5051,6 +5053,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_get_lane = mv88e6352_serdes_get_lane,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5486,6 +5489,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
+	.serdes_get_lane = mv88e6352_serdes_get_lane,
 	.serdes_get_sset_count = mv88e6352_serdes_get_sset_count,
 	.serdes_get_strings = mv88e6352_serdes_get_strings,
 	.serdes_get_stats = mv88e6352_serdes_get_stats,
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index d3d3c121a32d..a23eb3d50b6e 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -102,6 +102,17 @@ int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 	return 0;
 }

+int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
+{
+	int has_serdes;
+
+	has_serdes = mv88e6352_g2_scratch_port_has_serdes(chip, port);
+	if (has_serdes == 0)
+		return -ENODEV;
+
+	return MV88E6352_ADDR_SERDES;
+}
+
 struct mv88e6352_serdes_hw_stat {
 	char string[ETH_GSTRING_LEN];
 	int sizeof_stat;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 17a3e85fabaa..21e050b328cc 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -115,6 +115,7 @@ int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 			       u16 status, struct phylink_link_state *state);

 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
+int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390x_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6393x_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
--
2.36.0


