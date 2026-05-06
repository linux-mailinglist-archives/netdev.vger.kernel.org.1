Return-Path: <netdev+bounces-284684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMU6Bkm8+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:58:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 929544D6069
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CEAD30374BD
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F409463;
	Wed,  6 May 2026 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zjtNL1fX"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C082798F3
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039852; cv=fail; b=PNB4S37TFWTcW1qhBCjkQbC5sPUUZ4ZYyM3ApDWQyd4RaCaoZOfWFj+uE6vys7MbGxBshFEbTq3vb+cxLlfz9LuW1BORDpIGJytxT6feuPzcCh7kErT8cNupYkAGwy9l3elzwPm+/J8S+STkZW75ZioxparmVkTnG9MeJ/Set5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039852; c=relaxed/simple;
	bh=rvQWAJFeDoaTeGKu6XCecyAuULj7ngLVcy1UG25mq3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPYHH2Wu7zI5Y4Y+OTDQXEQEtlkVfJOPk0x5gFUm6e2+RnjxSmMXqGAtuXkJniu8n5hUo3l54R3raHMAtqB0ckKj/FlJkqnWs80cKZsY7cYqmkRT959n+v+csM1CYgVe8WaHleSjyjAFxFqUAIeZCME1WkRzlFHR+Rh5E670RqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zjtNL1fX; arc=fail smtp.client-ip=40.93.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sy3vlGqb9u2OuZ0zAjeOtRhus0jdH5kMjw1cGoLXEvpQkmzznY2wjpHKBpkcUdx13z4NWcbEO89raXTwGeL9bzBjd8FANsr3Vii3GOa642f/akMCbx01HF0SEQd8/y9SbpfXMWG3BOTNbjhCbUXxcJ4IL6dqc9ppDXIzea7pSNHS7fVsHyIbJMvL9ljIQJ32wXMXIgtHBhKmlAiYGCVyU8Iqbfvttwe26LbG9iZeeR+v1Ho1zCfPCbMeN/BGpXNHSWuNAPnOVuIEQo8gvKo29Os/ofL6nPVxjdQDIgMdnVkYuU/ha0cVE5g4AsEjZgKVvxF4VjvnHXPupevJkGvemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAEWLmI7DSJcQsBmwfxR6NkvwAZTUp+EoTkzLBWD2HQ=;
 b=ETMZXoMrhVB/rvS/SWF1FDUJJVjOvoFdS3T3tuKPoJdM/oNFHctUs0ja6L/Ok3wGc4C1lbgZu2cffu8YrEBRI8+YEuJnHeZ+cTT9FHL14kmWKyTbc1dnO7EfVgxHkulqxdGiy7TGYacGO5OJE/LKbtEKjUp7TewJoJWkPo/k3OH+O4aKKrZjfWCmk9XjlPr1O7kQKageCPKp7Gt/TZ8b3C7pOHXTDIqTEN/Jj+oyXFLVBH2/71Tudyw22ivt0dymEW0Wn3HFlj651pfmy4u+tTGMkLDiM73UDm0NGFbR+FXfH8XN3PTqs9xlepTd8xswuMp+5ujNdO6XockgcqVWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAEWLmI7DSJcQsBmwfxR6NkvwAZTUp+EoTkzLBWD2HQ=;
 b=zjtNL1fXznli+h383Uo+7D117ha/6Nh+tqb3uQm67EqR0LRyeAxcGHD0f3qIyvnjx4B93CfiNWYomEvFgSbn8El0RRgQ3r20ahRY1QyfGLdptC1Dr7p01682gaZkvK/Pbn5Ydg+ksxTxyZBq+Hj7SqsGgBfPabwQyDOihEuQxds=
Received: from DS7P220CA0064.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::19) by
 SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 03:57:26 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::c0) by DS7P220CA0064.outlook.office365.com
 (2603:10b6:8:224::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 03:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 03:57:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 22:57:24 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net v2 2/5] ionic: Handle failures from ionic_reset() when relevant
Date: Tue, 5 May 2026 20:57:03 -0700
Message-ID: <20260506035706.12373-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506035706.12373-1-eric.joyner@amd.com>
References: <20260506035706.12373-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1006cc07-0e36-41af-0666-08deab2395e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YGo/DJmbBXgKaVPSUrpOOsTs8r4DFXdVA8hn68Gox8y6IjbT6OYffeAv28Fd3E+RbwvFUQioWQ4997Yhz5Dh3G+4WnCWX8/xE77NUO46DUtOdo2DppF0i3sZL+LYnmydwJFyIozwTCnPLS9eO/d9hXza8wEuI/4fjbR2K1JfY5q8z5OMmwIcG1IR1GB1gAHPLSpNDPzmSu8/1XgXnfcSznb1uFZurcg0WVhiU4uQgQkw+6bbjqvsvSecc8BXIQ8nmUueo7U/M6RWINAbn+Ow9RIib/HHQILmdXkawFOu5/YTxTxR92gynessJ2ke8u8H6DAneDgjKyMVkyHG0AeijqNfHjZTSsTue9ErFzuPdFrlKzcoP9eHeIPESZNrdxsj+ro+Mu8q1UXTfqbCXFaLfjKUeRiMb2Li2X3i+6WVT8Fniug7Px0CUeODBg3Mz5IQ4x8y7Alxs1yoOEp+cEXJEMgkaHB0SQ2xkypcc+8t3AVl2YMBslAsP0RXekSbZeU0HdB1bfFfuUgNubZV6lnGYE8XQFzmXBoXGRzAqrH3o6QhJ0Bu0MsNKvJpABAaWvX14L/2aCJoxMVNseyncjkco6wBqdpcRs/b3TIzLno/yughD2gM3ZjtrQOZlQVAvZXpvtaVuLOjGlhAQySPhqnkfnaouBtKSW0ylb7iRL1YrLCA4PbFHE0R11q5VDbGVlTZzS1Xs7bNmaGK4hHRCEqAZdqP9xUNe45b13lBELbFK8U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M6qCM5DC3twHpdLLiyGzi7T0N2QvAIco9L9XOpJNzqyTq+akB/JGMAe8/tTDndPbumKR3WKxU9EuksbxZn+Z97Twjh32XPXhQ0EtEDsrv7LnS196KOvr7l1/smuDuCgjprvMnSewbdw/BSC8UPlMOzB9q13wwxwuDEtfOTh6iCGQTmV6NaPS3q6154ZWd0zhShpMR8YMXk8mBbToXS8HP6z70E5uuk1t3DRo9ggYfx7yjskQ31d/XNAYiTSLR2tyWoKw1ZQaRNFJF7rjly2et1loLkhTdLgM5k99oDuYDne3Mb7U0P8W5kpk9xf3K7BbKbATHMReY/6/jaU9k4ldGrQLcmJLdQ72SdTEreS6Nu/GJvN3bhBNm5yWN0aXgVJmgPhtjiDpLt6nyNczHNNI0TqeXoEeiBGwfhRKdv5pCEQJIRZKnE/js9T/HtE2Mwqe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:57:25.9403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1006cc07-0e36-41af-0666-08deab2395e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840
X-Rspamd-Queue-Id: 929544D6069
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284684-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

If ionic_reset() fails, then the device either wasn't ready to be
communicated with, the firmware is down, and/or the devcmd path is
already torn down. For teardown/remove cases we can ignore the
result of ionic_reset(). However, for any setup cases, we should
take the result seriously.

Note, older firmware always returns success for IONIC_CMD_RESET, so this
change will not break those. However, newer firmware may return failure
if the IONIC_CMD_RESET dev cmd fails.

Fixes: 8097a2f3d21a ("ionic: Reset LIF device while restarting LIF")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 637e635bbf03..db4bbeda0b29 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3473,7 +3473,9 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 	 * just need to reanimate it.
 	 */
 	ionic_init_devinfo(ionic);
-	ionic_reset(ionic);
+	err = ionic_reset(ionic);
+	if (err)
+		goto err_out;
 	err = ionic_identify(ionic);
 	if (err)
 		goto err_out;
-- 
2.17.1


