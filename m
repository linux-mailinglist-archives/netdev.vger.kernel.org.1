Return-Path: <netdev+bounces-295426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iZt2BAHwIWrcQgEAu9opvQ
	(envelope-from <netdev+bounces-295426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:37:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF3A643A37
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:37:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="KGjk/Q/+";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295426-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295426-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C504530166AB
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2476A4D98EB;
	Thu,  4 Jun 2026 21:36:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F14D90BD
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:36:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609019; cv=fail; b=lTpYIYetAi7jkj8iUbjAVfDDeoDPvEYUZ5r31SAHU8mFWoW/GBQrUGN0T8LwK+xk/1S1Laf7YphU6ZbEluSNT7zSppcNHOVtVvtIcczisE7gHcI1qSgPohmHZhCi2U4GUHsut02novUTDMQH16HIIr8NTdOTJW1QvXHNbQba5n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609019; c=relaxed/simple;
	bh=qYymAYf0bVNspYykAHNhQAfsH0maFfMuV2dONYz6sSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RTZe23AFUZbVNF9lbOu2JSKNboPjdmiZp8WFpO6ysyeT5ItJH8nL4BOZ1wF+IsqWglCiXKSb1KPKmrMDaxUBTeDKBpRDij+LXwaY9kLDuo5ulsB516eMdUgjcEjl/wsYZNPE263Ke57SL2AltN/L7hm0U7PS8sMEshmkE1VnFeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KGjk/Q/+; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huon4o9uBO+YFiWFgip6251tr9WtzCwGCv1aNj18G/tiU2rk0Z7DXp6n6/U1vg7KJyop2LwZm9wqFFDqOzGQjH/p+0vv1EKZasfv/tyW6PGHNLamwol7NMLEGT8Xz26WHiBuxspr2BMlTm3VUg/OwzGkcu1gJ9u7qa/VT0lt8DguV0fHckWACI0zjdPRVbiqd1ubBo6TypwubVlIffaocwM/kU7B3EIxsARV9OnPchzzTvCHhk8E0PWJfJbuzxPYlh58LRC/MMIY5acpUSn9oOMx36OibARw8E5ToSqzP5l6YBkn12pywY/iIZ6lh7vRulEwpADw4EeZ4tHfu5k67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fln/hkbQUZB70hkvG9hTUyamdBaT9ae3Ep3exNcwFa8=;
 b=SnvTHAyIzYmW91cbYVcjJoa1h8CJYThwrAakW1HeNHggJzuhfeLu4rAWW3zun3uPbH7DFsLJ3l1OorFLSTbEcnOaNjsTFNAUxV7nj8cprImNE7BNLbjM77L+74PrCEfUkXHbpLO8vuU+bq0DhFe0BksCyDhufEl8n2d5ED16RKBjjw8EJP7sBcUWGhmtJSJGqwU0XLiL4cBP/b8PydnLkouyC8rv6hSeCKMapO2KtIjhgTLyr6rfmkoa9LtClXlwdAIi3XccF1ZyslHvJpWy7/xgBISOJK9qnWiKU2NEY9VKcP0CZRj9aLfbl+I+ydC2rVrEh+u8uuonkEQJ7VG5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fln/hkbQUZB70hkvG9hTUyamdBaT9ae3Ep3exNcwFa8=;
 b=KGjk/Q/+ujcSCBe43Zrg5Wvq6pNQJhg3aCdGT4NqDvB0dgpBuMMpaPxoJLs/Np8gaxNsYFPnhYi6hVFU2bCQGfxUpAQS6S8kiX1ZeIqn24tI8xl/d2jZC/oX+zUkC6DBoVnAqYftBVKtt02KFMIiVZI5U7QZf2kMGdmV1NUaBNE=
Received: from CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 21:36:53 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::7f) by CH2PR14CA0048.outlook.office365.com
 (2603:10b6:610:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 21:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 21:36:52 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 16:36:52 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <aleksander.lobakin@intel.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH net v2] pds_core: quiesce DMA before freeing resources
Date: Thu, 4 Jun 2026 21:36:37 +0000
Message-ID: <20260604213637.3844317-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4b742b-18fc-4d0a-e316-08dec28164b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|3023799007|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	tYtsIqWKfoFMy4vTfuOnRQdbKXHvoPNSbM4QQGDgiWTMo6NcdaBlww41PZ4mYQq9+Hy+wxtsEqjby3SONgAfCvxpvhdcbfNcuaEXv93+bHCJCedS5pY5KGZiEzm76YRO8IwXmzM8EuFkZa/b0pXJ+34OpGfmxPJaB3UFJtApvdZKyMCJ/fa5prBu9Kp8k0lQdajbOWyUHAsrYCHfaBVz/w793gSUThf5N9K58EK9XLtdodLYhuZW3NeJljDeAJZssAS//1IBAgefzV1/uZTMfWBjzAsZUrr5d2pqaN3CMZPL5L34rHSSz5rONUkRSVIo1EI3r58S3TowidWtXeZosp7ceJPDyUilAwoR4pqu4JDIqp9/fUFuuMGrkZQi+nsZ+z7aYe9DCVAEvzJsMxtXd1n/8dFv8QPsTzocpF+EaJcMHukE2YE8p4ezOQcyazw8DMCAwCHlEYVRD2qLoLJsYRd/uHZyFxuttrMd0XSA2xpepW4QP4OEd6RJ8qkf0JJxNiOT0y5oItoHIEkIsmjRvZ5lx7RCHmOxLpyw3kpGdUmI24QkBUj0IuRd/amra2RZB6UgmQW7PBf051S63fSmWY231uD/7TtSERMOzXeuFNy2dXfqNZyTdm1MUdsT9BlalPqohPLVGgoj7IF4Re6u7EtOTOsmTZt7M9bH3jkVFgI8Ute++W6uE56hrkRRQrPK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(3023799007)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EYSc4tW8j088b5Uu36wh8qRZbyCLhojETxuhFRpzBVmGEuYvB4aZsQG4OLMhy3/BnaiTLtIW0HgEC0gkA/iR27ADQ29xGrSgsyE0OVYdweCZlc9oTcAOkZY8tpK+tONsDCw1gzY2r1SzkxoBouWcxSm8kjAO68D77de62Txhi80S0GCq61Z+AknQBpiY/5207Y6K/3+Zx06uxwgKY0ErwBZ7CwIhYIW6oP1qGGET8bsDRquWJQcPZ/EXjoFstjqC/kQ+6l8BzdKqmqHUc4VPiHxHdVyxv0+n1kyfxGXDQ1oYam0CyJTreF0E/Jq6X2Uz/N00tRtb9VjoeYCxatBwouiKtIYADoZpto1zMddW3YjUScEBj5yX8QtaSVnUoeqNdxGTw5pwGJDmBulNI9FtoS0hjb4bIduQqjN0DQ+rL69kzu7VNB/F6DazBFt/Lf2O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 21:36:52.8815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4b742b-18fc-4d0a-e316-08dec28164b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295426-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAF3A643A37

pdsc_teardown() frees DMA buffers but does not disable bus mastering,
leaving the device able to perform DMA after the buffers are freed.
This can lead to use-after-free if the device writes to freed memory.

Add pci_clear_master() to pdsc_teardown() to disable bus mastering
before freeing resources, ensuring all DMA is quiesced.

Add pci_set_master() to pdsc_setup() to re-enable bus mastering,
which is needed for the firmware recovery path since pdsc_teardown()
now disables it.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
v2:
- Move pci_clear_master() from pdsc_stop() to pdsc_teardown() to cover
  error paths (Sashiko)
- Add pci_set_master() to pdsc_setup() instead of pdsc_start() for
  recovery path (Sashiko)
- Drop Reviewed-by since patch changed substantially
v1: https://lore.kernel.org/netdev/20260603035245.32972-1-nikhil.rao@amd.com/
Sashiko review: https://sashiko.dev/#/patchset/20260603035245.32972-1-nikhil.rao%40amd.com

 drivers/net/ethernet/amd/pds_core/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 705cab7b0727..38a2446571af 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -446,6 +446,8 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 {
 	int err;
 
+	pci_set_master(pdsc->pdev);
+
 	err = pdsc_dev_init(pdsc);
 	if (err)
 		return err;
@@ -480,6 +482,8 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 	if (pdsc->adminqcq.work.func)
 		cancel_work_sync(&pdsc->adminqcq.work);
 
+	pci_clear_master(pdsc->pdev);
+
 	pdsc_core_uninit(pdsc);
 
 	if (removing) {
-- 
2.43.0


