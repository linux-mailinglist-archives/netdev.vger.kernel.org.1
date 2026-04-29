Return-Path: <netdev+bounces-282488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K9AAw1y8mmJrQEAu9opvQ
	(envelope-from <netdev+bounces-282488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:03:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43249A53E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89D29302D13A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47D36EAB9;
	Wed, 29 Apr 2026 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UB/m+g8M"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374C3264FD
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496467; cv=fail; b=NtKlfNVZbezyWeerv4COKhR+3HEZvIrYYGpznbPTXVWS69tp6NlfnmjKE4JlBS9mQrgn8clAFtsdcRzG05k2xdIPN/OXdwrM79zx35SfxefRhNULUTn19m7DzeDct5UfGhhNFDXSj/g4CXgG8Cr1TXYYtdJHw6s31gEu9w3M+2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496467; c=relaxed/simple;
	bh=rvQWAJFeDoaTeGKu6XCecyAuULj7ngLVcy1UG25mq3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cl1VQE9ArBRWs0Cbs7Myo8f5iXMsoFPuXzQF3xgf2mGJS5636gcKikqjx26q2SqWM3ZOE8uvkVsfIMkgpqr0O6Duscxl4JJeInz0XMWgwLNJWsWKsBVSz3fVpAccn1/j4pAWl0mi+J6wvwxmWtZctOFWcAqSZVSGxVRmPQbyMEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UB/m+g8M; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0iYElA7H8VxHEioGAqoejkvD63LkbzM02ekMMAH5e3HLJAiApnDaV6GTkBBbnj9zSk4ulcL0tiIuqUUt86p751U+BpDRn01fpLJBxXccVCfRMyoi3ZTWGWBuKsKKyDNw9Z6oNcyBs4TmbjqbvUR4bIhpCbuHcQPDNMSbJAzLBPG61Sa9cl0CWGOIOfN/ZN4F5tdgcHpZhhvWpuDK+8WD/yV2LT9B4rgF2tKXMrx2UuyMfyTGpu/FYSo9gyHsj3QREIvFUk1umBWj0vK+Q5++RdNcH5pGVI1Nk00ZXi5n3GMF2IfJUgXw9vklbritm3n2rbrTrFNyPpcocWCz2bUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAEWLmI7DSJcQsBmwfxR6NkvwAZTUp+EoTkzLBWD2HQ=;
 b=SZ973q0ZpwnXkgnQWJ3gk71yP/96J9Oo0wnpZnYVo3u8X3aXqsCQs9ZkgIMxkRTa5nvzW+f8Lu+RlVuXBSgFA+yaq4d4nEoG41Qs4Apv0WLOmG7xs6TCpIKQgZbHrnrDFAuBm+GShUW7bvJuWOyarP4Y7u/iHQxKBlnsnUnB7wuKa3cGeAOo7rv+kfyb/ic2l5mB/03A1ER3nK4lh6vDt2QlSL6m5q1VXlR9IKlEaxtea9zBDSplrhtUDyeRf9+jrmZUCBhN+HsP/iOSyP8h/EUbho9hEBZUeZowju9wsgmTL4PuoQa31tTluJBo4EcM1GUST0BN4hyUtyv4LLMdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAEWLmI7DSJcQsBmwfxR6NkvwAZTUp+EoTkzLBWD2HQ=;
 b=UB/m+g8Mnn1QjS0xBpdanY89hDZB4ki/Irm8suh/evLptsUwgy3o3ETSGSKDpYdFhpSmCzkv14e90PIk37YWd7iX3hx9uK+LcacJfdk0eKBj3BkGQF5OIiusADbD2F+BOh0scNV7jdekCJ1T7B6aXhJ82+MX0Uy91zZRdAuVHTI=
Received: from SJ0PR13CA0226.namprd13.prod.outlook.com (2603:10b6:a03:2c1::21)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 21:01:02 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::fc) by SJ0PR13CA0226.outlook.office365.com
 (2603:10b6:a03:2c1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.5 via Frontend Transport; Wed,
 29 Apr 2026 21:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:01:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:00:54 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 2/7] ionic: Handle failures from ionic_reset() when relevant
Date: Wed, 29 Apr 2026 14:00:02 -0700
Message-ID: <20260429210007.40015-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260429210007.40015-1-eric.joyner@amd.com>
References: <20260429210007.40015-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 826a317d-5fb0-4b5c-a685-08dea6326ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Kf7Cf3D6DAq0oCsh4vMsVQJE734wPheI72e7vF5a0M4Cgrrd34An/oC95ty2Sz+8J7+TKvJuXigPjNXJ85skLJQyKlnzrULRPGsTGOSxucdgqOQg9LvYNVQUnID80N3lawTEFyWrGiNWdUGVqFMYlgR9eMHI8OUKyjOY95AC2/+WRHiDwDsZgsfb7+vsIiUMaS3zjB7UW/4Ncb7nTceEYe/xF0LZvccjTC7j+nTiq/G1KEI/Mo69d27rTVLFueSha1+GupsQnve69HR+0BEwylbSVEZRIHyWXy3jRiNAH6U7HcNLURhu5vAp5WHIZKheT6W4Q+whtm+tlidMZQHlarqG3qnLJmrYmr+jZOZ9n2eNRr8+QPp2W1gCnPv6kK9z1kHKoa8BIW2D0F47V2JtPccDHJpjKvblg0/Fxd+etav6u+auefSHAdoseGTR3K2h5HqwDT2ivRz2mbBSlumF8cTA5JvosD+cfelHue/VBZ7eLUoq3iW65I1cVSyfCc+Z2jsukaBO/bQVu0Wznnkd4qedWIbFf45bXzUL9dbIitqdR2XAvxovjIWEV7AXRWnX0BXgSUQ9MwBnp+c4/WBESSO0rrk8z6/wBYsxrBrnc38bwzXWCdCv9Gv6OPEkBKhgqQhBQsJJ/SHmfE4xVR1iDzpFIw0b2d4k9vXXxMt1UzHXEiZh5BaQliFRxhhCiwufKmrbnnidR8Ml2DiZUfk1tJ/WY3BIponMiy67MRtA2zrxpv3l2xC9GjR/eGotb6Mv3W1L64zx249I675gYmOkrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4NA+gwDSxRmDmrzC7DF4U6lV77ldMdgNzMn15p28LhRss1TdlAjUCnmPW+KhSRqW/AnlDbydBcRHxSBMA9Nk+8s6Oi48aJC96a1ovkDV1ymLqSvTnqDsJm2lKTwwMt8VVYH1zRXi4vgIIFcFi7qMJraE0ivK4E2RTvAqSTIFPmIgRF78OHLRnYDU7nTzBXrdJ40xvJaeXYy+xt/IdTN9k+wXdlskIN8EcNF8eb1atagGlD2hW6PAIu99j9K5JALfO7yxd3GFEOKYgXzcI5O1Vf3G0DtmOWTIaoibEs/4fBrpE/dTu4j/TkOQ3SRSieySfNbP5vxcZcbiTfJk+6b4hM3jIFar7uaEMZxbxZ4uFqDHHL8EAhyoSMujbTfBrpOph1pRyIllcJLxIoMKo53fuWLjRiI1JbiTGZNQ5ENArlpNRyaBdevC8yzFgjTIRmk9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:01:00.0959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826a317d-5fb0-4b5c-a685-08dea6326ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
X-Rspamd-Queue-Id: 2A43249A53E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,amd.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282488-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


