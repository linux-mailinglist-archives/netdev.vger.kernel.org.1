Return-Path: <netdev+bounces-288466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEQWJMuQB2oW9AIAu9opvQ
	(envelope-from <netdev+bounces-288466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:31:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A753558294
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D76C3024A01
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC6405C4C;
	Fri, 15 May 2026 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3GGYyunm"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B0405C45
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880565; cv=fail; b=m1oXaesd23ooWjH2Mw/q/N3ZXgSDs5t25fgkAZ27F3A5sh8uFkje3Dr00iPfS9OGQniEcYZy3rYl95xC2OTuTZAsOq9ljfrdcxwGY2FmqruLki8kCQXG0V9ZS3whrOKUFQIO1JzGyaZTHrftT9+FF9xFAixqz+YklAcOV9MYUWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880565; c=relaxed/simple;
	bh=upc7/kS4tCkvhq48krK4zhxWhR07Duryl80tVfwsEbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/vVbYHzdB39y1Xz9xMBBN7SxKkb841mscLBQFpms9aDk7ybKlxC+Eg+GQ2WMzOSx/X7XkO9mq6DSpShI5yuUiEHFI0Cq+Y64HV4ISY/MNOkiY0wNwx2EkzWaP3oTD41Ob7Hn6IUCjBU/gffDgM2ZELtjArsw3ALC0B/nyyhTPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3GGYyunm; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn6Oe9iw2ght93aiDIHQk00ai/63DiCuVXwJcSgxq0Y1DuM3cqvbaOXWdNZ1+g+C+HxqbR+wP38g5D/x9UfujJCnpSdcO75ukT3JeZE3OKfbusp7LB8d4YNXCnDfrlqDf6UeXCOUhYIMdjq039H4W+FpwF4JOMCHIuk47KfjkXy9/2hnby1NM/03wNZ0m3x9/QB4zVGwvSwMyzJybdpCH0aXPuDtWVynEINhlZcVD/+SmSCARMTQVh2jL5kJ4l7B2Xp3PHNRjb2mt/oSWUH5o31h9+DgSZaGGU+aIJ11M6XStStS3azzyZg8pMssnOPhXLhEZk2Kig8vXNEF8FDdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbAsZrv/Zjo9HDcgZxkjHi8uCvISqRhVmV/OXwAKky4=;
 b=viDCMZFnCHRANSfGNP3EcZJPoUVHVg2gHyg9utm2RR7OAJnLbQjUpqCQbda3wANPZZcSXUXMfVRF9B8tU8ISTgZxwGhV4F8CWyHx51NKbb/kW6M+WwLcuTF3JQyk86hUtpoFAlkL4Y9iZnd0aVOlAC2ciAvHsbZig2qk9PoKwlTIC551cZLQwPCmzSA9K6sB7UflzJDXHkmnJ60u4X7/D26w5qa4lq8SJAajqDXewrnosubXPmYOv+/bTEHjTJkd7fr1sMFRa5J6KoVoujMK5JoXcZVKJIQnAgoqtp945kjAvr90AhX+q5sQXjaZdQB+yxi+rRFaYWPlWGiW4+jV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbAsZrv/Zjo9HDcgZxkjHi8uCvISqRhVmV/OXwAKky4=;
 b=3GGYyunmGDm8tQJA2eY17slx+1QZ+TmOd0RPGOeI937xrDGeDpyAOWKRqW6U1a73iJi/C8Sl3OsdrIyNUv9pTQEFOxO9oylplASCn6tbFnnUezn04LpY4ZIvZpuGRkaXKa79JiVtm1I6jwZKUCJe6o0EWmngCznK1tV5ON0Lrz4=
Received: from SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) by CH0PR12MB8505.namprd12.prod.outlook.com
 (2603:10b6:610:193::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 21:29:19 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::2a) by SN6PR2101CA0010.outlook.office365.com
 (2603:10b6:805:106::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.8 via Frontend Transport; Fri, 15
 May 2026 21:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 21:29:19 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 16:29:18 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, <eric.joyner@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH net] pds_core: fix error handling in pdsc_devcmd_wait
Date: Fri, 15 May 2026 21:29:05 +0000
Message-ID: <20260515212907.998028-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c3873f-c7ac-4ed7-f730-08deb2c9060a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	xKDjbwFRPfsAwJ9UdSSG8BSTAY+iniqm+zedZ+dJEkBkoXum2xoOuKZnxxwrzIHPETu5y8SIuBGrCwRCPGxo/4MfHrrII0BDNz792xmsIMzuR6qm7hlV/668RyqNULaThInuiTL6UPuO/2DbWE/H+H/8r/emST6m+jwBw6g4KwMQYzBiwEcLsQx5gKInEB2N9RQpdfP/Fmolm4bQb4edhLKvidlbd9CD1n52IxRmygALnTJkr3rTSTc+um0VUVc+hvqO6sIvRYUlnr0shDInQd+ttns300duOolo/smhOPkHgZzBDSxxiTOud0iaQfLRNk54l04TZ/zHqWged2Dk2v3X7RQr5PHCmeE703xf4jMG46EQP+XpAsCzX0JyYj59rh/v2U0I8soyhce2qxkb7JAM0r4EQgKj+tU8f05TROGTYWKoukHGHFAykoWF5iXU8Ffvgn+PNPf5djWWAnXcYvz7Ky+Apajwx9YN4kq7T+tX+V8CJV1nwtF750oMtFonpLUCEyovUV99/MrrBYx7bnV9fwlczv27JrL3skwud4hGwLz7BDdLFG4di8Da4m5yaAUYC0YhKegX7g7ONIurreQIf25Ynl6NP4v9m1GK7/AAG5vYGbme1sjaWpVIxagJWYk9/HqYX0+UZpamahI5j8MHEzmzMHgSMk9H/H75u7vTdYPV4qsEy5w8AgqCBqu+HBCULavJbw4RD9l5j0+tg5o/aPrYmG155ZB9K72FOOc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M92djzuTtii18ELkKOmJwoR5qJ+hf1URqf7AV1nfl+7D9Nz0u6syPMxL3UrVo6mZRl0FcTH08aa84xFOf6rebYI5HL0f7LTOLlJaUT77cdndeOBQ5JJDLhHDf76OKX2joaCXlyF93FvEL039BZcBe0rVKp0fN/K/8dQXbWUd/hAGTGIq35A2ToFkW1JrUW/bwca0wAGfE6LLMAxxv4RU6oQNhipGn3Cb1TPxrff9+51BvvGHKqyE2NR8cWhKw0tFIEGhAR9Xc3vGcIA76I8BC+UsSplkbpSu1HMMxU9a8eg/EcDEBOVQYD1v00T7DxjF7uXPMHT5nmu+x0rvzCszqiTgUSITvQVL86Mr9QCO0H/+PqMhM9SLg4fr4geNfX+BaTnZZMXbs0BUntV5F1RIgSsMeLu3I7I3a93zXpwQ/vZLgl98kgNxPShI2WDYp7L+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 21:29:19.2075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c3873f-c7ac-4ed7-f730-08deb2c9060a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505
X-Rspamd-Queue-Id: 4A753558294
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288466-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Fix two cases where pdsc_devcmd_wait() returns stale success from
the completion register instead of an error:

1. FW crash: If firmware stops running, the wait loop breaks early with
   running=false. The condition "if ((!done || timeout) && running)" is
   false, so error handling is bypassed and stale status is returned.
   Check !running first and return -ENXIO.

2. Timeout: If a command times out, err is set to -ETIMEDOUT but then
   overwritten by pdsc_err_to_errno(status) which reads stale status.
   Return -ETIMEDOUT immediately after cleaning up.

Both errors now propagate to pdsc_devcmd_locked() which queues
health_work for recovery.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 2e1d0d01d03a..bded6b33289c 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -162,12 +162,19 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 		dev_dbg(dev, "DEVCMD %d %s after %ld secs\n",
 			opcode, pdsc_devcmd_str(opcode), duration / HZ);
 
-	if ((!done || timeout) && running) {
+	if (!running) {
+		dev_err(dev, "DEVCMD %d %s fw not running\n",
+			opcode, pdsc_devcmd_str(opcode));
+		pdsc_devcmd_clean(pdsc);
+		return -ENXIO;
+	}
+
+	if (!done || timeout) {
 		dev_err(dev, "DEVCMD %d %s timeout, done %d timeout %d max_seconds=%d\n",
 			opcode, pdsc_devcmd_str(opcode), done, timeout,
 			max_seconds);
-		err = -ETIMEDOUT;
 		pdsc_devcmd_clean(pdsc);
+		return -ETIMEDOUT;
 	}
 
 	status = pdsc_devcmd_status(pdsc);
-- 
2.43.0


