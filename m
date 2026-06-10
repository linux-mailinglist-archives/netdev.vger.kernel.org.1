Return-Path: <netdev+bounces-297418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HA3pBkfTKGroKQMAu9opvQ
	(envelope-from <netdev+bounces-297418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC18665866
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:00:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=HYznOtf9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297418-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297418-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD6B3036E62
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14AC33BBD7;
	Wed, 10 Jun 2026 03:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48A33E355
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:00:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060420; cv=fail; b=ZB1RKezuno4LGvVfNa1Ch31UMNEuPnR21YTfL30aVWn2RGuGIMvgLEMkaG25wRgU0MJHL8bRQb0bcyk7fcPAn7KrviIAZG03qqLVz8iGa17vZlQ/UXfaxGWqR9XszWWWHzR+kEIH+omO9gmdzwcLBDnKF2gnv91PgYCev0RHeBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060420; c=relaxed/simple;
	bh=Ubi6GKhawWWJ0NdJIdYO3sQeyiJ+JowSom2JAkcecmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xv5I0fptLlX2UDlSkgdyvtw8ZJFPjwyvmhtJxLSAsAdHJhRmiWBbw9lJzBLCAIXPAE+wY73V8ec90tYO+17uCD7zEaSwQ2t+0dfYMF8EkBiHmYTAMoO0vtrVX19zeczrs17U8ypUIWf5mMoabBqgPONPuCTeA0AbNouqHB34pRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HYznOtf9; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myzB4ZfvzLCEjtepefp4fjJdcUUe4SgrmkqIsedBo9YEdCB6iU+YexcoDqvenuZ7zNdGNApOFK+3Ns8L+dl+pIOgT75e2LYl8zoB9bKfFpu2gRYV3I/zQK8taLYQotic6BZd6g99zUAj/yp7D7cPkGNy5xUiAExP7O4TqRifFxs++outc4CwDVCT3xCdMh2aTm/wxyQNJ9DISEyBObNLcf9Bsb8BDvYjM3xIQb9QAb9LpXTnX9mv7gdHLlUOQakfl1B+mPMfwz74iqv4Zl4IaJ0H/AJElZy9yngu9olbSWj75rmJhuZRO4+eafvyF1MaMlGQK5k6UYocT7FWul7n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn+j3/muln6bDdCu1afoMNtocLDxBOse81ozUmj3jgk=;
 b=vMqBTgfSh//RCWU+cpFAIIAHoqVVVWeit3mBzrwAbcW+krPdA9LBUfAT5eFOLguJsmi/uq0uy0dSpm7QUahCQpE8wc/AqMWYhzND0wOX0THGOhrDZPhnDey8G0/emj+ulW6NlVoWzCoYk9lTYAjOL92ocSqhoBzmO2fpviRSvS46ZTcjvw4RXNKoAatakhNUPaAh5M5ztIr7BWMq4t5wZDOn8PAAQgjQ99tfw4EqcoFQXEDEh3wT3mTXi0/p4l9gNhJawph+cgqIgr3fJP4xtP14hadmV2jJsYjqGwEpHoxGkkMdRXEpY9dE41JKGyU0KzhJXGIeF8fJiVK//zDTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn+j3/muln6bDdCu1afoMNtocLDxBOse81ozUmj3jgk=;
 b=HYznOtf9CXGi7e16XjMOBT5SeWGQ9ZMj+xds+n+/gVpAsjcdU9oiVmG6anZWndLtOTAWSeIbwivjPdsj7ePkSKONA17YXTcFwZL8/aXhcEb4/WgPS4z1ggcws0krjWTbp/l0Qb73Qihy6bqnp/XeROD7UhrrC6ppojMQBlO8m+Q=
Received: from BN9PR03CA0207.namprd03.prod.outlook.com (2603:10b6:408:f9::32)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 03:00:13 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::74) by BN9PR03CA0207.outlook.office365.com
 (2603:10b6:408:f9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 03:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 03:00:12 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 22:00:09 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: fix use-after-free on workqueue during remove
Date: Wed, 10 Jun 2026 02:59:52 +0000
Message-ID: <20260610025952.196470-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbccfe1-527f-42c6-1303-08dec69c63e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|18002099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	w75p+YRAlIvIo7y0Nc7KBKhg1QKPka5X+D7MowcGpl9T6JlW1Fs3CbNRqNGRtkv+3QjxW+z/vBPsG/+wPOPERbiBiuqT+nDHWWj6z2QhIsgKah5N1KiZQEkXpzI07AlVvjy1L526XREji2bAml4FWrLeKrghV1/uPmlH4QaR4TbPOXdwp0m5kYal2WRykJUgChFChBPiuzKhdJYQzNzp8Df7OoPrGu/H9+4rxIvZ2WublH3vsFJPN8vXJev3vLeHSN87dVgRyi+isEWQ8CWkZ9XelbnL+uDnhjOG0TZhHcPdCWMGxY/UfSqte0YNqbNmOfrB3o2Jtq8/wFm18TSMGNEmjEB7ODFzeo8t2Du/dod+AQOSCzEA+B3R9dVsanAcg318glMYVSM1XNzYRC2AEJ+u0KVQFQVJ8uW5KcCz7UGtRnxOI/U3RWGnloNlMAh87IZ9BtMjiRAgP7lcsAlE1RcCMABEoEfiIIr7oQmIXrFu5mSFWndpzxjlpvjSvkdaJpTxzFYXCDzOOCNHag2qdwYNywXOIPjA9do38OQ9S094QAMI0sUxrXzD6dxjPwtWZca5I6kZE9CpK65+y5YKXgUL/uzp4Bf3ZLbnLb667loiMLz8AJKVy0snBM6JfwEBbGO+aVs52GQrhxCXzzl5zzUyGcT97wqRxUnVwUCr1q1r5QhhxJmsKuNbtza56n8PSPCHeq0Ta74HizCKdtfbJc6CiMCx+/WpIWBBtwP5akU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(3023799007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ETNLMoSF48vGMARLbuFqY7fuGZa3AwaBMee5ReNGvZkIYcSqOdMUluZenatEkNT6mO8GvCjHfdiyqnc3IPbspBGarWeHPrvoBk1XQIAl/Em3Cs58q0ZCVje3Ch569VPyTrT6ZbcoUURmcqNC8A/CFPl0lXykdvDEekU09h5B7tN/9qgRFrqoyNAltplDNnF5EX70Gfpsu2H3N0haNnByqnaun6azuLoBzhhfjskfXk681VzBAxsV+5933Y6HWnMK5PYq71KQ2GS/cSXdejsooFvT0QrPy9R5aVB9eLi4F+vAF1vOF70CQrPkMPnQCXktyYJGqYdl2JjBgugSQdPGMxf0tttKoNVqWFu9ohHdfbYfCcb6W0Yp6IVu9JQ8BtaruPrzcYnoaAgBLJg/4jHuv7F1mivVJ88DZnSmGJbZpceHFZ7b7uy3BpczZcJb930T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 03:00:12.5779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbccfe1-527f-42c6-1303-08dec69c63e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297418-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC18665866

In pdsc_remove(), the workqueue is destroyed before pdsc_teardown()
is called. If pdsc_teardown() -> pdsc_devcmd_reset() times out, the
error path in pdsc_devcmd_locked() tries to queue health_work on the
already destroyed workqueue.

Fix by setting pdsc->wq to NULL after destroying the workqueue. The
devcmd error path already checks pdsc->wq before calling queue_work().

This is safe because by this point:
- Auxiliary bus clients have been removed, so no adminq commands are
  in flight and no completion IRQ can trigger queue_work()
- timer_shutdown_sync() has run, so no new health_work can be queued
  from the watchdog timer

Fixes: c2dbb0904310 ("pds_core: health timer and workqueue")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 22db78343eb0..cb3ac26266aa 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -435,8 +435,10 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
 		timer_shutdown_sync(&pdsc->wdtimer);
-		if (pdsc->wq)
+		if (pdsc->wq) {
 			destroy_workqueue(pdsc->wq);
+			pdsc->wq = NULL;
+		}
 
 		mutex_lock(&pdsc->config_lock);
 		set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);
-- 
2.43.0


