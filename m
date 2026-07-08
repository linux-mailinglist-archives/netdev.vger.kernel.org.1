Return-Path: <netdev+bounces-305894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mYXtGOp8TmoFNwIAu9opvQ
	(envelope-from <netdev+bounces-305894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:38:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 016E3728CBD
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:38:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=ge0H6sGt;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305894-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305894-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F4C3300AB22
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38C7401A3A;
	Wed,  8 Jul 2026 16:37:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166B37206E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:37:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528678; cv=fail; b=ejGwzDSHkr8+1KskFurnAaOsh4/xN9mvjez2u6AL75MPgumM0imXHbUtXKZW9s6B7HtBgKpkxzF3pkm0K2/2ghQxeuiY87WFM3vbl4+AahCBE6/9j/yB+L2KnAF+ec9Ln1sXFTsqyd+hmsmNFkSFCAQy3KxmXZ95sY+jHDK4xhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528678; c=relaxed/simple;
	bh=zKON425vDYh/9cGLAlzgSuAPIXtvAYCkCwfqVvl2VYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3TzHib14o1f5wUVohGxNkw2v9D2MVg2Y8/24MjxRNzfwj7sxd1lX2MyIOhKuvNGB0y1H772Vfbqmy5umJ2Z4r24r4/QAXlB14KLL6GIxmOVfDo5+SdmyBvWaTuTKUPCz8QAZPUDRiho+ru0NlDLj8pv41P3zOWUM6AFjGIOczE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ge0H6sGt; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv0ksu1nYd6VSk7EHdKHC3YZf3HAVcW3Qdq7nTLp3dyyjh2cCPayDu6sN0wY6PbXN9EiC2BOFjAOjed1UrQ7cd8Btu+IwfcxjXwP05M0Nco/ViyVlw/5ydoMKQMZikCd8MaMX591unWUU2jEexP8//BkgJ85CcXN3QIFZhc3L6eTWlKoFPXlmxfdr65R4vPUj5bVUGpCSpL9GuTnbhGIHxFE/K8wjCJ3iPG4/9cgDjtxMlg7IsGp9UInxoNpXJNPC14ai7WI7DOWsCiuWaEVvhIXfsdRAGAO3zokZH+wtm1gSV4YtDKzLLNHK0xYomO7RsDZzOz3cBmdFu3+MD8vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFKPPOAIrAhPdtAFW9q5Twaj5hLTqgv/4uybEJonud4=;
 b=IwebSOmJzjTJ3pOiCRHUdk/U+KwK1vgqw8Q1dvYjvdV5/zFXQStwikfnAjYP27cZ6g/QDB4yHP8zVQFTyFs1lCu056yjogypb2hDo1ZS0wanw0NOK8mre0kqxo8BykNaueMlaD9XVFnNEHtCgZQ1VEEjZlgsrXN2HJYgoNQAT/RlO2SaC6ZdRgyvAjAPUEGI1uhWDsMEt/xCKN5vtD14vSq4cRcR8ocq0GhYiwZKslZDu2maZeoxnDxC6A7fzglsrtgbNRkszH8eTx5LVKM1oJJegz7I8rtZt2hts1GGCkWbewPJf2+v4NpHfQpJ3KUfbWD/SfQG1+vuuEMM6y9WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFKPPOAIrAhPdtAFW9q5Twaj5hLTqgv/4uybEJonud4=;
 b=ge0H6sGtOgSACxiuFTZ+vH0Fu4eZHeI0n1Z+rOjjgmRZAZm6a5PhVzun9oAxMC/SyH9XPMESGfoxdrL7F72yghbQWa5Yoc1e0OfTqYQYZt7N584tXMtn/5G1uhZzZ7O4UTMnzZA/41WZRfgKeoZ45Z6OKEgOftRQPoPwOoD1jbE=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 16:37:49 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::12) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Wed, 8
 Jul 2026 16:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 16:37:49 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 11:37:48 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: reject component parameter in legacy firmware update
Date: Wed, 8 Jul 2026 16:36:49 +0000
Message-ID: <20260708163649.128620-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b69403-2d63-4937-3113-08dedd0f3f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1mwvw10em9qxIdVbr7Ngp+L2148SstplJx9sdvAkFkv2CoScs006AF6Zz86aH5X/LPoUIk529B1QZtd4l6YF5cyjgzo3qOwjMytq+sfMvAZdBTs42HR36mDSImtVv3ItTZEZCUFCtBzsabNkpspMVaho9whms46KJIMsvSZEogAG56lMgHEGmKegxfaxb3mExg+YOFt1FB3VWwONnGc9iRcE36TwdB10ToNYWufdWJT6xYcd6OcDkF6P8yFqTHlP87tmrUqAIzuAtX3fHzx6DYZv9FPv+0FaYkeocJfHeF9kSqCV3nY5oKYpi2bXdkfAMBHuttEplRix+p96jL7EqElCS4z7NnN190SYCe1wePQ925WB/8fxou2LLAxdIG5AmJKSg0tiClzPEYiOBz66eW7iKILORvEL3j2o5p/iy5vTPDiuLMkYxFlYYj8imJmReXFGL/FFjr/IJObpYF5fiPEMv1oV3mPzkO+pE+Na/IpQLjeWLDrPEVV98o/zI9MMISwpA/vxYMpGH1PGC3wolFfj6RhE7it4cUGbYJzdipRSfe5fXMrbli2seQkMkxq+lZhL1/YMweB98pv8+3k4AUhDrQPDGtfE7/nj/e+wFrjHUlgeqkcOGZHwftvtw5jqAhaaVXzGdyCtiBU2/fEXxtRovnywRU5/NQMCdOG+A7G1Lm/j6yISniCFinGiXLEoEA+AtLZe9yk6G/fDw+KgtA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MvwdtC2j8i6VLM2SYP0Gc7og0hrKQVWw1lj9SVAISsP98jPsW3wIFQX/EOmdfc/Saw1DhvjZOJWjfiTXagIofaN/Neze5QxI6+zZeGjy+KtvEeHvlwmsIVc1LX1Vw6GsW8N1WjtUO/b8lsEt2K8sM8oRl0h37E4XmozB8XTbS8RO5GcrG5uTp17oZmQ0e3ySe4231y5uPRxTjpprYwnDOVxOHknuXJhXHVPUxlCpZpbTk6PnVesZGbkwbyDZXlIb1z11QovPMHswe+zaMuViboZGzjwS25T19on9V4bzz0HWDknC0Aspqb5A1t3snnFL4cVKyaVcOp3OFMpf+szmqQoHGpQjGZLCQURXn8Ld1YMw2qqOIVE1UnYfy6B0NyjctFXyQ6gzcFihw5BrhBKYgjC83IEfzVAv+d17TpeozAp3sKsxL7c8vAFtaRdL/AzC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 16:37:49.2701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b69403-2d63-4937-3113-08dedd0f3f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305894-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 016E3728CBD

The legacy firmware update path does not support per-component updates.
If a user specifies a component parameter with devlink flash, reject
the request with -EOPNOTSUPP rather than silently ignoring the component
parameter and flashing the entire firmware image.

Fixes: 49ce92fbee0b ("pds_core: add FW update feature to devlink")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 2ea97e1c5939..8adae7b18898 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -90,6 +90,12 @@ int pdsc_dl_flash_update(struct devlink *dl,
 {
 	struct pdsc *pdsc = devlink_priv(dl);
 
+	if (params->component) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Component update not supported by this device");
+		return -EOPNOTSUPP;
+	}
+
 	return pdsc_firmware_update(pdsc, params->fw, extack);
 }
 
-- 
2.43.0


