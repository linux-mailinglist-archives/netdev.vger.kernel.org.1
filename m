Return-Path: <netdev+bounces-288557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBV4DzbaB2oALwMAu9opvQ
	(envelope-from <netdev+bounces-288557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:45:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9819C559F02
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B9D3026C1B
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A828726E;
	Sat, 16 May 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vLcMdF/p"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F529BDB1;
	Sat, 16 May 2026 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899461; cv=fail; b=ZEWK/B0yHfeCGQTbxgxaz07DZ6IlJ6Rr88neyzkj/yi92r5kYXz1vf/l8ujWf0yI2MbHZosuK1bM0a5qvpLPJZ9awgTq0MwlhxV8xP49S3ou1VfB439p5PtS5BGULvTm6ulJwSkFEjM0IV34qPQryLol7owLdzrCNPhDoDChT84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899461; c=relaxed/simple;
	bh=lvjSDfcb2Y1ztc9VPo6EKI1IXVIKeLA2H29VctK8gMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i5QCXl8S83UTwMRAeNRcgMud4o8g6q865qnmAtgnT7S/Ob9WXL+6gcbDcZvCJynrA25r1ssmHh2rPgA7uVBagMTrihWt03BC94ILxgP3egddGz0WiO3SCka9G0jwEkU8wFQnH17W9Ynt1x6n6EIIEeB8X/jDO0LqyygZqjFRSPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vLcMdF/p; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEvAZ71AMZ3/7BUgJZ7iIFpI8ClyAT8ict745mSIz9t213FNi6ZJJX1YSuMEheBw6Aqw2d+cydKJIQ3xMws14Sco6HrM4x/O0jJLMMGR1GCfy/aZ1SloHqafcJ9dUm0Vi5h8eG4OQXVGgUzRN7cUU0sHugUKo9FI3EcSfucMTCMG9hahKKOep1xF8dShG8U+Hl+DTKD4LJZomqupq5BeRvgvoPJqINQpQca5AzfBApVAHAAo+AHu8nEZ8sHz8Mw7Rnzt9mv+i+pJcUOpo3ump/ntQiZvLBcEoBfEImSAQh14Ef7kfQYWpUoq7Sv7HtmcPXfiPoWcq7jyYyj2zDa+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA50v06f2ifm3RKkLEsxz198BeVK6Y+WcbsqFDaU3FA=;
 b=SEDpm1BL5k8PLp1+J+2qOsN6CXwuoJcGiLqBWWsMH8oPsgAwiCxYmzdFWUvEEsW2Um05xlcUmbXrCBH+Y90vUCE8b6f8wAhC5X3TaM1VD8s9NZUbKt37BYs1VC1J7mRvYQJu37r8jhUkq97X34rtQk4A4esmuPB96VG/fOwjlZrhvVAoVuIBE4pls4pqSvW6OKzuj7IYu+ZG239l9GefQJUCEgl9OpurwKVe/6vJYushsipjjLUkg9iV/qnR7F0UeO16N6y79tlMHC+iy0t1gjUSxyNhpesLZ3NoridM83ClepgjzAE5/PsKGgr0Gy8y7VhXJlQNWPNiN+ExpGF0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA50v06f2ifm3RKkLEsxz198BeVK6Y+WcbsqFDaU3FA=;
 b=vLcMdF/pe2UvuW9JQ64In8UfaaVKipxjFobUC9NusUwOrqOAljXou/0uIvSvwTYR7RuuxuwwjJ5gNBQUjipBXo159gLlZWIDwv0nEC8JQ5qOfLRRAsZkZdWXJvr+3gYmUI1uq36s79/XmCYQ+pHGg854WMBdtUX+RynFOqCdVcE=
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Sat, 16 May
 2026 02:44:14 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::85) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Sat,
 16 May 2026 02:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sat, 16 May 2026 02:44:13 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 21:44:12 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Sat, 16 May 2026 02:42:35 +0000
Subject: [PATCH net-next v2 1/6] pds_core: add support for quiet devcmd
 failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260516-upstream_v2_clean-v2-1-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com>
In-Reply-To: <20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9d6d80-7fe4-4366-5586-08deb2f503f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LLgQKC1F7h8MhoLopbmDPNZrRcscJJoM272sPj8DLBx98rvCqoBDz35dwAjlJdxQWVtFzm5XvwTs9aLbyz5u83rHLLzoGealviBvwVkf85bzai8+ANe/PxA/iMT92buiyXti6DGlNbru9Lhs/uwt84kkiXtVgyKfilF7LbKuSonkCvR8RR8juIik9SsfKOa+WEriAImQSxOrNPjVYZ9+cLY1dKNIEAdIZOrl5onN8FLh+aqb6oo96AFYA8I100w8GB8z9rBbtbtSTbx/ECCSy+gRetIbJjPextIFLXYHpsxf87dcfE6VmmVy3gYPc3lHeHXOAZ+6fdFRKWNjEinSWVsE6KtPT1N28Gdqt62K5dlcBuje7Y5z63yGgikH7wzDGurIYLQ8FaEYkv+YWkHQsQlnET4WgDO56HI4qV8V01/tnxfUa+VP6g0Qpv8VhDPh4DEfn+r5J6dSl0zZeAaZd+eqBNveDXNBZZ2k6a76woz9XzgdpPZrc2lO9OJ1SLIjgopuJKuOKrs6W0d1NNMqvb2VgxV9fgXJNAl0q7O6MtmEkV3N72Nsy0ncHsgwChy/9q9D0aGpQAoISTqgER1SGcIFIszY161+HvOIEhArIy1KCfJBrYKPZF9Ous0pDA2hM3dCJnXf24V/IBnNVKEHBdtLZFatBSAalL+tv6SSGFxl2eX8TIQ7VNfk4B5lSqm8R+st9gsvd6e+NodxE9kVcFQFZ9uw/ERo6YHvXaIBwrI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l4ySjogbmeWedLubE5SAw/NsL1aWjPIhob+45N6f2LWBRBndsbvnKM6/QsNHONmjhuvpJeHfQbIJuc747aon/mAL1xA+SA3s3ilP1iVe9OLIRIOblUqJfPK5eDn/vDn7Eh0OGUKYowaP/TnN/SeqV1YGloLNV7iHLbUXQpNJiaIkA7OyX98tKAHY019BZjAlOMNTN4OxbZHrAm3XD12rVUZtmvu7yKrafbqg+mirJw6Ul+uoBA3juvOgnaccOx+lRRtLylaUAY0lsB43vdV0bmXcI+YP3NqFWa4liqbc8S+gj5z+lhG/ux6PKUOt0C1JKANfBXihfFRkwN5yZsgaw7oIgJp8HFIjwOQPDdnE+rh7Y15DVR4jUIYmgjGcpN6tpUzDUQX++JsIZITVgyxpxUfBbAHRvLr84mRpDYCTh2ecBlxcXhiXejOIDd86yzMW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 02:44:13.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9d6d80-7fe4-4366-5586-08deb2f503f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
X-Rspamd-Queue-Id: 9819C559F02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288557-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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


