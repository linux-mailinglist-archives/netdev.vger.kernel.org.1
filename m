Return-Path: <netdev+bounces-290605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHRAN4hrD2qOLAYAu9opvQ
	(envelope-from <netdev+bounces-290605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466F5ABC7C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A28AF303DAE1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB43E172B;
	Thu, 21 May 2026 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="c0H/shPn"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFD3FC5D4;
	Thu, 21 May 2026 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395385; cv=fail; b=dfGmwCSObJE2bpGhY2qmIx/IHI061fQYP/aRRbn6+sb+FUPJ2aK1L1qUmYD6jTHQPldoI/stA4dNtMMkTXwF4q1R39jmCJLtSHJhro8VpFSzhw6xjpwgYR4Q86wGiWDa22wqRY3Olq7Wkohh84kpAjr9zOl6T1GFuKsu8wlgy1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395385; c=relaxed/simple;
	bh=Hq/sOUFo6NfRXo1CJAUy1PPGFamAJHIpVq0bhhcvMPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwWyxRp6M99/+/2C9jyo3vr2lM0asHitZVm7+Kf08M8pyOtE1EReo3ctAJCXOsbfbcYDYAGDoPhBblKJCrIwh4XiqDuDTYeZ5yQdSq20hEPEJ/kpiVrVzxG2Q/p4o2Wg18Fp1P54YQByqM0JkyGGUEAfw9AjwHp3JB7FTVeLE5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=c0H/shPn; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CutLM39WZQ1UJash2O3EoFqF6aqFh9G79vhTzrxU3ThglCvgo4ExWl3wA1H0F/RFfT+00cYySq5iI77IydTTmIfGtQceZSjgfgf9rugNb3xCA8HOaeLKoRz9Ki32H0CekXWgtS7AiIFl//8fKgZlqa0Id324lHfVEK6Sr0XXgf0R3c0hRaXrRrwZ7hIH6kGyU+GtTs4mxudLvBxgrLjfXtFFHby6NzzvCGXQACp9oGiA4vG7u58N1RRc4y9YMboB45tHbcwH6XlscYSgA2GZfA+Tl81erhd+N8aHV3imBisKyu3IucNRnnc+4Ip1reMwpzcjsUqxfYg9O99qmTWZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXIZlVo4hiOJRVR5Lrn7RVvgrMnrBi6KHIQnuvF/Ro8=;
 b=VlPHzUpICUjyUJAZVRm/zhLKK3F7v1xza06nSI3hXMzIPOYVulZZ2JrHKzp8+iS+NlO/lLuwxhG/d66eQ1wsdAk3vM5AKe+d9jrv7kIpQ7Z3uoH+gynXoRkHDmGRLhHRyOb6+mAvhbjgVzUKSd/KzsOaoPDC+rozUFnXXF1M6lEOP9bE3Mlw2T3K1KXNPLscwNNNAGEY08eFiGpLsVl12babg/ub0WcH50o41pMR/igaJKBwc5sejLmNUwdqvC+zET70ZUjF4rwpizgluUww8RnUyf6LLqLN298Sd5oMr0D90Bi64K1pUBSMb+uJWOI3tKw/sQy0Lj0MsDGUY2fBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXIZlVo4hiOJRVR5Lrn7RVvgrMnrBi6KHIQnuvF/Ro8=;
 b=c0H/shPnpLcGuhp9i+l7DInmKVYDhNzxsl8O4n5XdtI+qWaMQ4AbYTDUynnMMDIQH0CO2kQqQoSC/9/flGNg8ag7zgHmjkXNmEWPooRd8/QgSB5v0SmUywTT221CFKjKDwUUy1/RBq1vjppDEsjobfcpWAIVdvmqCSlBBbXlmIRXhBDofF+beQFZkq8WGxPWvTFNkhh0pPT7FBGUiuUk0Hf1sLi7FnDRTGfyHExjprK4Z+aUSFAKtrhqktfTUV7LIKIjel0sfcbkq7yQt++gFGYguZkhlUscjgMLfNdB2QhMVIwQYoPQHz9mNeGymtv2BBavHsoAagSlb7ywPlEuHw==
Received: from DU2PR04CA0052.eurprd04.prod.outlook.com (2603:10a6:10:234::27)
 by DBAPR07MB6872.eurprd07.prod.outlook.com (2603:10a6:10:17c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 20:29:40 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::8d) by DU2PR04CA0052.outlook.office365.com
 (2603:10a6:10:234::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 20:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 20:29:39 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 21 May 2026 22:29:38 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 2B3399569E;
	Thu, 21 May 2026 22:29:38 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 17CCA1005D6A; Thu, 21 May 2026 22:29:38 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next v2 1/4] mv88e6xxx: Add mv88e6352_reset for 6352 family
Date: Thu, 21 May 2026 22:29:21 +0200
Message-ID: <20260521202924.727929-2-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260521202924.727929-1-fidan.aliyeva.ext@ericsson.com>
References: <20260521202924.727929-1-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|DBAPR07MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: e62944a9-0ed7-4c91-f4aa-08deb777aece
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zirp6YabSXZ0aK1ubQVegMtbM7iSH1U8pocYwEX2u5SrFPifZG2rKZD5e6u5hdpE6aY9FxuXhuHXDl6H6eXpEgcdnidvPdJFDWYhm0KshWgBQYYDUIVwRMqb1oF5jrdH/3Y+W/cjxYwKLot1l6QUiKUd53KqEMJHhutOtrTwn+Qatz2lCDqC2ehmwYBwLoAc5Uq9d9Qjhy/SKYHfQQZI4cFu7yTqXqek4AWMasVpqW7f0soOQfHeq8DXWWj+/e35HZyRHMyqHDCo4xDDYdCguSgH/ygUh9Qzd7k9rkd4IKibG4tjYh0ChA1rofbJN3fOASwBbAzQdA2EulFWwvsj3/i19R1g3wOxK7xYhhOzkDXl9CPZWWan9nZqF5OBLJhThahtetwNxnWqv2bEMF7Yjd1azUP5EPwOlSA71C6GiT8lUbvFmpc1phPBfwMplSdwTWHWzR1EwoHN579a1o0ggoovAn29IIkI8loEaf4e6EOTYkE1tiyzJHzf6Px1Me/qYkbV5La6xAX9lyZBycTTZ1OF7IUXbUEmt9Vrm2+cT/qs4TpWMpTGEZnqYkM9ERq49sTlGXFHcPemxKNcRhTppOw0L++EhsWA8UIwhnZRrgqK9hPwpSMhWMnAhk2j8iYKjkHiVnAnXrj2tL4yWDaPc7x6YFygtsYHis1XI+EmIqz6SLFOXnmwFVwXCrFJanvoTojL3H+Jzs+gLMzAkFcKolm2IgQjTb5TNjwin7w9Jkk=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ahuq7rPom+TjACtjqvTj6sbOpOTa29gGRTI9OqYS81L4yUO0JEsob4RSqRZYarMg47hwiDq3YJG3rluNNAmtGOYU4/gM1tKdMfwqyL83J50YGoQYcXqsjn07NU7dlQrz6phznEDqQOawNwcEgMBnazP/9oiJTIZZ7ZdkHJiAkW9LiTDHAgMCex3bW++8sTlrRgKbyWu5zo75xQrecugF/xa8KI9V0sfhLzahidd1UHyhzKvPBPuxhtr7es+iY1JgQEU+sgubyptrGsKaGvdW0wnMXapboDF0mBCrzt5PdhMfLouAM/v0GFsiqC6JF6/7EaUesuig+jhyZo97pgnH1yxZCuxgLV5GCIjtYxmk9HOfTYx7HOtmwmRfZRnd5ep9n25x2mLfUwpsZoUXweylh7aeSkdSq2ry6VLTEZE6MSvIP/WUETKCidDa0jJcMBE7
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:29:39.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62944a9-0ed7-4c91-f4aa-08deb777aece
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6872
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290605-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ericsson.com:email,ericsson.com:mid,ericsson.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4466F5ABC7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1. Add mv88e6352_reset which calls the previous ops->reset function
 - mv88e6352_g1_reset.
2. Make all 6352 family use this new function as ops->reset

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8ca5fd40df92..6102b7fd8d44 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3736,6 +3736,15 @@ static int mv88e6390_setup_errata(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_software_reset(chip);
 }

+static int mv88e6352_reset(struct mv88e6xxx_chip *chip)
+{
+	int err;
+
+	err = mv88e6352_g1_reset(chip);
+
+	return err;
+}
+
 /* prod_id for switch families which do not have a PHY model number */
 static const u16 family_prod_id_table[] = {
 	[MV88E6XXX_FAMILY_6341] = MV88E6XXX_PORT_SWITCH_ID_PROD_6341,
@@ -4654,7 +4663,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
-	.reset = mv88e6352_g1_reset,
+	.reset = mv88e6352_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
@@ -4757,7 +4766,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
-	.reset = mv88e6352_g1_reset,
+	.reset = mv88e6352_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
@@ -5032,7 +5041,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
-	.reset = mv88e6352_g1_reset,
+	.reset = mv88e6352_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
@@ -5463,7 +5472,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
-	.reset = mv88e6352_g1_reset,
+	.reset = mv88e6352_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
--
2.36.0


