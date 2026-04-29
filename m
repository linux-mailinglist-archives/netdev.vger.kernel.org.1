Return-Path: <netdev+bounces-282277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB1yC1O78Wl1kAEAu9opvQ
	(envelope-from <netdev+bounces-282277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:03:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EAB490EB6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9709030C4114
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3B3A542E;
	Wed, 29 Apr 2026 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hi4W+sRg"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476B3A6F16;
	Wed, 29 Apr 2026 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449513; cv=fail; b=JZDeMt2naIe/1z6BldjvOg6HBPEltrA1amj4YPfR5JnSKZyDAKyHVQnP5h4qhBPXR6yizJIcXReQxp9+/nZ/2BQ4v0wHGF6f8enywXSNd6ZpMF6iXj3Vz03qTkiJlg+SjhWMF7H5GmAVKF5tgDgAliHXE5hBk1JcmEGn+eg3Q+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449513; c=relaxed/simple;
	bh=lvjSDfcb2Y1ztc9VPo6EKI1IXVIKeLA2H29VctK8gMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aXqctyA2a615xy5tmEOUtB+y4qvuQ8uXHq/WalgvaR26revp+58l/yaGrA6AtOdQIaTIEvNKbeehc46pFyq9/U0kIKRh4armmyd7MhsWyt5E6Sw75k5jg1fmhbDoYhEDoestoiT6WUFC47ozVRAoIVlLN0mXwUhVfh4MBK6owew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hi4W+sRg; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QawM33msju8AzHs0/UjIaJDynmtJKHV+PqocSzqc9IQ2HK4egNxkdXWjLxJ5n0kq4aWMTIMzUncjwzzEsqrtRPMFXvoqBeyOCaop3WvY1XVPkqWqd0KvPb1ZDXq9ZSeXjulX8m97LAzS5QY+6e/KSEnkarHAzbLGsBodHSpiZCKR239qiyKfrRoeXM2LnMUJwGYpRnxEhAYNi4tksqLEs1H4hfeJJdsHiwZ0M56sqpWYZN0w38ZbIW4zDhWZaklTfE8yfXjjabxQdlIShk+4W+xSkbRG8z91ROCJQWRoHrmqy0Bof8eIvzxFp2CNGrQkxOGVhy67YT1bMDsQyUNDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA50v06f2ifm3RKkLEsxz198BeVK6Y+WcbsqFDaU3FA=;
 b=ink84BJSWL+FvRktinzKKN/gwI2IrBau2VEqcjGbJmLGpC17QtRWA05s1VNySjqV10UgFGWF8tZNn6maUek6E1clqKibUScgb+VIW4NSdaDGOpIln29rc+TXpLtssFoSsa2h9KD8R1Gcal3n+fP/Dbb3MJdplpbR+3peutvY3nHRsHeE8mnQM4bR3o7b6oGjXKEtEn2BQJ3vS8GUHRoZtwzmE/RE+ZLYvhKLgj4X0T+xKa6RKXmw+s2LvaYuWh8gOt/uKdztqAUmTBPCFLXqYiG2O2eZWp1h+yj4LGFg15htZir2hxrrllVTjpV8f+gSQSubMaI4libMOH2ZhNKPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA50v06f2ifm3RKkLEsxz198BeVK6Y+WcbsqFDaU3FA=;
 b=Hi4W+sRgCZUWMR5bif2wTb0RQzEMBNW/9A+amQSIsBTQpU/LkCCd9jpxe7N1BlJkBK+ywmr9RikPjt5rweO+mXKy1McUIQjvS5ZU149BydnODlo72TdSs7sEQQq9IbZaHCCQVpM+W69Sdwr9PAc7jwYqOxiBy8p/a+UOzvB8NoI=
Received: from BN9PR03CA0288.namprd03.prod.outlook.com (2603:10b6:408:f5::23)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 07:58:18 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::ec) by BN9PR03CA0288.outlook.office365.com
 (2603:10b6:408:f5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 07:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:58:17 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 02:58:16 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 07:58:05 +0000
Subject: [PATCH 1/6] pds_core: add support for quiet devcmd failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-1-e43b6c92e46c@amd.com>
References: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d24fd77-ddeb-4312-a2e8-08dea5c51307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	53WOfz/QqaJYBNAhMzCgOZgIoFAkhmhu7tIn/720wXcLat5+vogh908AcsrKQ9AlfqjSOgh8qYfuz9UpoP0s65f0RNrKBc9gToOxraUVbXMKWMtYQaq9e7K3IL0UJuTv9BDVPEJ/apzfW0XTgKbqGr3RbtOY/o+ALOD5LTBw87sklcoGmbOveLHchiCLbwp2koulgnp5G66ivT26zicW3WBkX9R45Q80EeR4iqtyf0LMuz5cCQEtJjEbRP6emuctrnfuLm37KgeYCzCeWKs8lnDZfkNLUd47HbUH+IjrO+u8UVvoP1NzdrEFH+R17I89kYcLsZcYXFBBluZMc7J100WJULW1/mnhMyeBPHnT04I2PeFTitmC4fc8tsvQujLw54PO7SBms1ymk4d5ATiAfe9ylb7FoG3sipFkY1wKCdoOomOKL8O/qH2WrtYe7onPChuAqhhzXPV3HFvfjGmFLGvDFZC6eppTCUv0xToQ739baBqZ1DcaCutD084MTX5O7aVh3Itu1SMs4Q44/+gzNVnd5IDZNS9Zy+slK2HZLsSXdfEbtAkCBfuKBG9bR1TBUBk/3/EJgYsSDWFlH7Q3BsReDDKaQVGDnmpUPbBiKwllw4WedU8BneSGn7/UlzlN8/ipBSKxB3Wpx+BtWm6s27vjQQgJOpRzEqf2w1RFlcAYzdzdAf6njx2e7wmIDuXWE2SuJzWV8JPFHjRAmukiKp5QYCnY/+Gy9OAl0BjXiOkcDrfzw+xon3xVjh/90XlfsRraOUDpkSITihHl6Tt5bA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XGyUTdEnmzzZCvqZSXRS0cTRqvwI0gvUoCJSO5eDtYQd8g804Ipng5wsn0ygXrZi2IuLFw+LGlLgP/kjb7cSPdMiVuuK6devcmDyUaBbvZC1G7c9Zs4C9dPOtEuLkEd3KuIMnnj87GMu4E3Aza/TMZUikxet3eiOU3ImlfHc6UGypG2Oy/nABw/ZlVvuJjsVKHgUNEaaMWl2btrLXGtUUXHzE4cX3EqsHJocPo3CQXZIEH50NahLk+99kb7dEFWq+cX5mg4bNk82/e9y5DhlMHPPosQnkTz8Fio2Vxq/Rnb1jG5oEqbGh24clgpZLNIXSp1jrSsGo6CtSmIM/NHmGh3JWHF8RjgJiHLc+MxWALrEBc+bK7FywmGpiJEZNIBqoZHULsoA6AkRqJ30fXVeKKipeQY6m16Wm9ujcAgl3K0zzPakpS+TBKGlaeK1zDsy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:58:17.9166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d24fd77-ddeb-4312-a2e8-08dea5c51307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
X-Rspamd-Queue-Id: A0EAB490EB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-282277-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

Currently there aren't any use-cases that require special handling
on whether or not to print devcmd failures. Specifically
non-generic failures, i.e. not supported failures. Add support to
allow these messages to be suppressed. This will be used when
adding support to negotiate PDS_CORE_IDENTITY_VERSION_2.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 2e1d0d01d03a..5b86d6cd0ac3 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -126,7 +126,8 @@ static const char *pdsc_devcmd_str(int opcode)
 	}
 }
 
-static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
+static int __pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds,
+			      const bool do_msg)
 {
 	struct device *dev = pdsc->dev;
 	unsigned long start_time;
@@ -172,7 +173,7 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 
 	status = pdsc_devcmd_status(pdsc);
 	err = pdsc_err_to_errno(status);
-	if (err && err != -EAGAIN)
+	if (do_msg && err && err != -EAGAIN)
 		dev_err(dev, "DEVCMD %d %s failed, status=%d err %d %pe\n",
 			opcode, pdsc_devcmd_str(opcode), status, err,
 			ERR_PTR(err));
@@ -180,8 +181,9 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 	return err;
 }
 
-int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
-		       union pds_core_dev_comp *comp, int max_seconds)
+static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				union pds_core_dev_comp *comp, int max_seconds,
+				const bool do_msg)
 {
 	int err;
 
@@ -190,7 +192,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 
 	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
 	pdsc_devcmd_dbell(pdsc);
-	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
+	err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
 
 	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
@@ -200,6 +202,12 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	return err;
 }
 
+int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+		       union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, true);
+}
+
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds)
 {

-- 
2.43.0


