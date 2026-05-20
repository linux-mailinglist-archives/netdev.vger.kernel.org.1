Return-Path: <netdev+bounces-290105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ6oC+AuDmoK7wUAu9opvQ
	(envelope-from <netdev+bounces-290105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E859B918
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 280BE3056F2B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45A5376496;
	Wed, 20 May 2026 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qm67LFlo"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9A3750D5
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310748; cv=fail; b=LKNxnj1T7faMoeNBgQYNahASUPJ7I86VO1NgE1qJZwq2U6ZLzyQDDv4mibVUsZ/4xe90bWghQIZ/14G7o8wwhri6emrZtZxyX5ZDUkyiYjgu9xqN7WR8wFrimBtGRnnDAcVURY/jNJymJR7nYRQG6TBwoHdRS+ghejP5ihGxvWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310748; c=relaxed/simple;
	bh=wxBa5aYWXXzRvjnJ+2Cg+iom9hE5Doj/FruLOK0gsD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+01wwylKv2nE3I4G3GDonnoLhkTUxgi+8P3mVg/GQDTwlH22kuy4pS2HigFm6JtqX05nPG7wPaK6ZGsFp16LcCmlSGeuXyBNXxWyGY9wtkZXb8gZZiAS5ysqr7Eh6Z1gQNGVdfySKF5I/4yu5qqUSZE1f3aeD0LapxsKFmm/Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qm67LFlo; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWvar/YJVaWXL9T0cnzeZzzpw0mDziVQpD/TOY27375jBSjNDJNAoOiheoehRqrym2WSpH5KLYAysJS1aiumO0vD/IsaX3VNrtZnIl9pbZwBLPz47AomCt6L+yKATl71pB7v70Ix4jZKYOkSH5mU4SCRtBHKK/cIswIt+u7LuOqnLZDLZKtIvZdxfP/0j7DD1qHNA3zm8zxgY4OCdrVV/IWYwQhtJrKvcJoOQHWR8EPkNg25/t3aYvJqlyXtoit+rhJYDcXjih2sSZnDjZb6MtLysk3Z9Ecrwy/DWEVlOw6pnsoh4AEjw5PDHt6aTLEmzuxCVjz0yADXF3+JL5tbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy09x96204WMoNcyEXG8l0LXZ+oXY2z2Ff23zfxOiQ4=;
 b=GaVxqdnKN6N6tcai5wuIfCGxOrqXPtzHG7l5t37R5qOYK9hT8VOpDdQWh+nsbFEVj+0vLIBgscy6NrCwuGIYmAlYS29Jxk9GKBUaa46YZPXCBSrBbPsA4mCPEXW2irbYqvh8C6Yeg/HF/fvH3vJPpAlQi4Mx7Skp2sGlXfil2n6K5dPpQKfTcrec2qpMGsspNh2RkEStez7mP8RI5i0xla0d+s01/0Jng7i8ad9x8CkXB9XJlIKr5XyEts03oiMWfiNQw7CWC0jTVHnJd4GO4O6l1i7DdJhVst814YDFkcKSQDCcBNH1t3ia2mXp0IVasnsRVR1eoIU4qIfLNhbBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy09x96204WMoNcyEXG8l0LXZ+oXY2z2Ff23zfxOiQ4=;
 b=Qm67LFlokuhTWrhaz9ownXO6hF1HDx+eIrruFb7+dTjcCL2ddZfhAbuCgqvtG/nWrkM9xCAOZFz6J4ZDRJNsoyJIiZEnml0uEmruKdxW6cUe8NBJLMfIa5VGke9G87eHdOIa9rVhD3muUY0idUEQmBwDfIbGpYWYeDg1UCO0Gww=
Received: from SJ0PR13CA0122.namprd13.prod.outlook.com (2603:10b6:a03:2c6::7)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 20:59:03 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::7f) by SJ0PR13CA0122.outlook.office365.com
 (2603:10b6:a03:2c6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 20:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 20:59:02 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 15:59:01 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v2] pds_core: ensure null-termination for firmware version strings
Date: Wed, 20 May 2026 20:58:42 +0000
Message-ID: <20260520205842.1486718-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 087bff11-3db9-4088-ae34-08deb6b29f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kjqx94ooN8EVjr981zOeLidKruuFBPyo7KY5LCQWXH0PVTk2St8FFuJdO7VlsuMGDC0zTkj/mDkXsIXdi5L2B5kxEUe8t9VV9Ec6lM0Gk01geEzwpi9kZ+85hhj5WnbYspi+WaXKJtOFGKOpK0xNfwwuWVljwsuWqiLYXTHkqFSzkbYTSNI+b2711hXRTutD9eIMk4CUCIcM5wS7jdEkTuDEWSwhva8V1nHqksa6sH0XOg/UBM3eC+7rPYsjRVuMC0agdFFn5MUVXS43dqkMu2VTAW0ndsLj9j/4Wh8zSs8toDW45ms2b8fBWwXbT79W6TZdvl+o9lmQLjk9zecM95FcJoUhBWhF1htIHYRDHJa6SXM29HiR63Lp4GTNOpcsQB4R8m4/+G+/CLedYQFMHBjtDWneND8ABtgYcrDfzab0q/VyJUfxczqQc3Fizi7NXGlFfKNW4PPRcXRbr0DwJAGyCUhzv2QirPgUbgKJqRuePlb6uglT/qVme2Km5ejODnNLy15ceN36XkSvXClQKiDO8Qa8KVr0KR5bcGLhcp+JwxVhdAj9jR1G2vrdxISQCMB1vJ/zzUSbc8VIFvKZlJrReXLYhKeVqdhmZ6RH95rdb4u+6M/ojwMXMpCIKM0x7j+8XY/Wqcfxw6UlvK6NGGcZPeuZtE/iCXR/O+Z01LCBB/ztq9xNb05EOm7f1CYqow6Nj2m1koiHePvRAJGT47YSkaAeHvG+5jEH7i7mabg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7o0ZBEnOeVCS5TpaiKDpHd/Qj/Ipg+JMWATnRZll+j2xA/3ALy6HlPZLa4bZoqCLRy8HvGUGBvycmFY9TGG1tqFNrJq279wZOASTZM2M5yaLZ3ORjgpi7EBKVH7GdUhLmMRr3cbSvx3OMdgIHzwxrFmhm+4ElsR9dMTKXxCsvs+Kut6m/3RQHbUxfB0CfeYc9ZdtW7eXAhOLkG/ir8IYyMgwaMIeD4OBFTQ7ZXGUv0eq41IyNqnvdlHlmECTmxdWsWdHv+NNBLCuoXME8WByP1oay7DYmbl2b6Ns4h4pMG03tJqsPPgd8mwAG74GhzD1FacdUlg0HfNXhykMSCUdSt8Dp8yHFGMovEDOw/JGd+l7ZBPr5UXjKCEWsQ48kVOgJdC5VuSs3iX33zmVTdSYeBOoHAsD1cwL+x3sbCK/NfyGb4S99qTHjnWbCxtDzm5z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:59:02.3316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087bff11-3db9-4088-ae34-08deb6b29f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-290105-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 4B8E859B918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver passes fw_version directly to devlink_info_version_stored_put()
without ensuring null-termination. While current firmware null-terminates
these strings, the driver should not rely on this behavior. Add explicit
null-termination to prevent potential issues if firmware behavior changes.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
v2:
- Clarify this is a defensive fix; current firmware already
  null-terminates these strings

 drivers/net/ethernet/amd/pds_core/devlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index b576be626a29..3f0e56b951bf 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -122,12 +122,14 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 
 	listlen = min(fw_list.num_fw_slots, ARRAY_SIZE(fw_list.fw_names));
 	for (i = 0; i < listlen; i++) {
+		char *fw_ver = fw_list.fw_names[i].fw_version;
+
 		if (i < ARRAY_SIZE(fw_slotnames))
 			strscpy(buf, fw_slotnames[i], sizeof(buf));
 		else
 			snprintf(buf, sizeof(buf), "fw.slot_%d", i);
-		err = devlink_info_version_stored_put(req, buf,
-						      fw_list.fw_names[i].fw_version);
+		fw_ver[sizeof(fw_list.fw_names[i].fw_version) - 1] = '\0';
+		err = devlink_info_version_stored_put(req, buf, fw_ver);
 		if (err)
 			return err;
 	}
-- 
2.43.0


