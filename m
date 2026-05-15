Return-Path: <netdev+bounces-288468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IvzCVyQB2rQ8wIAu9opvQ
	(envelope-from <netdev+bounces-288468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6C558204
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 989943020E97
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A98405C54;
	Fri, 15 May 2026 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aPY9GwzE"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FC405C59
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880568; cv=fail; b=j0apVF+wCWLzTn137tlC405+SSkGthrOj4cWv/LXVcFLZJVWAByQG9z8UAyEJS6aLefyov9tkwzrMADp1TvvL5CO8HrGOvrqVf075WKAhI+WT9OFtvimBWJH66ojxgdb2zQsp1PvPsydalJEwdrWGLE8EUU5ey2mxzRH1qRXE8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880568; c=relaxed/simple;
	bh=HHCxBgmeguBfjtvpiFLExulwuDXll3l/LwgNsESYs7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DGYCP+b/anfqunY7sKXF4HxQjYXQcPAjzIzBsDFpM4aomgrYimftri59qcO0OM0Mu9pnD2Z5zwTDOxgt7B6UiB9pjyuWC7OXl4OeNO4SeHwJmCUDvKkv0AMXRCVsGayQd46qc1Ht22mnsPGlLfgOTGOf82XfxxIPPknHqJ3pHwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aPY9GwzE; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyAeiS57nYsMtSYWEW7i7N3ZrczGj0HEcJuJ06Vcc2uOD9Z3EP1uS+hXHzYuvHjNibXDY2pemHrfi92ZvLahkIqwqDrla4rAy71RI17bZcKWc2cnNP8ukmQneRCbI1kSLLZkqatkzjybiwSpJ9uCABFPoNSioMXUz7fMqtZdsLvvRiCGWidxy+Q7iHeB4p3XRbbvRRZ62jVlqcTkP/R3HtGFdqeZqTf7Z4dKELH127xbGb7V2WHukvRKmJJLH39hL5yjQMR0DoPhdIuls0jdiItboFrVBSqC06r6EA0lt6S27wJh2aSiNW0tz/e+9ilxhfpIltTlLI5D6jIxy7jf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nqjjp9FDR2jG+/rinsgPG+B5DE7kS4QSEFS3CoP/PEs=;
 b=ONaOb2t5pOs7cevBDuMXdl//vXGwwdciHJUBzCRe0XIp393Dbu/8kUu+oM5XSbPYkjGzsHwsq3TCZxWzLZ0+SVvDhHdkmQnnODGL2Yt1mIcbfwE4vMwOd99o3P/bCZ3dyGrxZCBwyXQpAyW802mrRSyWZ3aWX/QvlIC8aPUSbi0fz37bzTsHXu6YJsJ2vtBURt82S/GafmvxlSY0yyWGWK7APwti+NmjhkviRH6E8AXFCxNyU2oVvvT6sf4KKpKsP7AuA7LNM7bViwqlHMryNJmLhQa1OCqv/+w1D3HTStBqq7aO5OXwGJseUEJiiiPKv+R5Kaa2qtDuvEaFGG7Xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqjjp9FDR2jG+/rinsgPG+B5DE7kS4QSEFS3CoP/PEs=;
 b=aPY9GwzEt/tBYBW1qQWeOnii4HI/DMzv6JZhIhx6AtP0TOUaLUbdEdM1RwpNNQfnYFnnGvA4BdMyqj3AXE7J6W7MckluwJ36vdnzOK819TCyPYhbhuR90TSsSp0ru8gCxdPgxzrblk0tB5tw3BZ9qHjq9tIp17Lr5aC1Wnky/Z8=
Received: from SA0PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:d3::31)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 21:29:22 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::1) by SA0PR11CA0026.outlook.office365.com
 (2603:10b6:806:d3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Fri,
 15 May 2026 21:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 21:29:21 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 16:29:19 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, <eric.joyner@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH net] pds_core: fix debugfs_lookup dentry leak and error handling
Date: Fri, 15 May 2026 21:29:07 +0000
Message-ID: <20260515212907.998028-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 810191f5-b169-4f1d-f541-08deb2c90746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	TKoUa+YYwtARk7jGEeUItzY7nJphMb6nbp92NZNroJF0LEKwi0IiN1gsbZMsyOi0dFjZfzvIdE+OQxhAgBjhgEEn2Ggy4VlofSxRZZzpFegoif8gagGS+wNx/Xx838rf/d64ZV/WGWzRJgbEql7rZnNDCKUAb8S+nrSHYoqgutk0wRrnurc/wxdVvva5I+o8SS+UylmdjwRuL3kO+FRAcc36+voLFGIsYs2gMY/zAQyUgUxd/0bO6L5EPT5KgIwxr4Aai5oqrEVwjYxsMV6vYxKfBwFF8VJ5249T9n11VfXjlD3QLz1hcunAMuwqZGFGw//8ev17WeHmQCUyuHW4HbwIHTBh64IcaSMWbamw2d22h5czMY9GxCdvEJirXF4lO8G28O0jDSLZXKzzlHKYDsAKYOiuxRLRB5XDcUMR9r3XdIjJapnvH2qzWWJnNYI+bxLJB/24+Ur4S//Y/bkdFBQBMvyRN0ByAxvqVy2jNGOrCDwt5aIEXdITwwpkubXC1AJFoz+0MpFKEAy8BWzJVj1Ux+cCxC7bikDswqWQklfkEtTZQmi8vWP9EOOggVipjdGKXjgMJAXoVvRGge+3oWy5f9dlb6wUT492p9od8HEOxOuvMKaM2JMg0ZBb0eENB85Bjo9xBd6U6VG8SPvSq/8G54kdXH4be0n2PPW7tA086/Z3fnLbyOHcsAqvZq0LrD7T8w0kN/h7E98Z41OwrDRMq1PZbU4YEgiXEXyXrk4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IWHemzecVUSUUGSE9WEQRrBtlFdVv8ctiv4JOcpeV+j0Lotm1Z0MeXMcHL1MQS4wElgRt3vUbnUC1umERtnXJVZpXaEH/s3mTGe2df27h9wGOKTP4kXhv7NrEFMgAIlTcJpFSSY/uWKBZtdwj+lR3Hx+2xpYeJ7BLdu3hDhGTJC4tVNztelErwa9yOOvMMekj/uWC0jnMM4olbnHVeaooSaxjaFWPTw0Gvy0hYgbiGPkylXnGsei7EUwH1D+ptqIMTr3WIHBI8ujQiLbi0Oh4/r8Y2YGsnGktBmJY1tPFFw1QmuOJQq/Tct4mfqXshJ1JJd0evnGNSYhw5BO6twzweZ11ZeteXDyqy7N27CrnEh8TQObQuFdLqGgnNEO+tk3BS4MQNV13ElrnBITemLTVsAicp3zh8mE9QN6zeqO4N76B15umMD3uTA1XTdZr2J/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 21:29:21.2769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810191f5-b169-4f1d-f541-08deb2c90746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
X-Rspamd-Queue-Id: AFA6C558204
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288468-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

debugfs_lookup() returns a dentry with an elevated reference count that
must be released with dput(). The current code discards the returned
dentry without calling dput(), causing a reference leak on every
firmware reset recovery.

Additionally, when CONFIG_DEBUG_FS is disabled, debugfs_lookup()
returns ERR_PTR(-ENODEV), not NULL. The current check passes for error
pointers and would call dput() on an invalid pointer, causing a crash.

Fixes: bc90fbe0c318 ("pds_core: Rework teardown/setup flow to be more common")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/debugfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 04c5e3abd8d7..810a0cd9bcac 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -64,9 +64,14 @@ DEFINE_SHOW_ATTRIBUTE(identity);
 
 void pdsc_debugfs_add_ident(struct pdsc *pdsc)
 {
+	struct dentry *dentry;
+
 	/* This file will already exist in the reset flow */
-	if (debugfs_lookup("identity", pdsc->dentry))
+	dentry = debugfs_lookup("identity", pdsc->dentry);
+	if (!IS_ERR_OR_NULL(dentry)) {
+		dput(dentry);
 		return;
+	}
 
 	debugfs_create_file("identity", 0400, pdsc->dentry,
 			    pdsc, &identity_fops);
-- 
2.43.0


