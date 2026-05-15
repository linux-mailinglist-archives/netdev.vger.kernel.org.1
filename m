Return-Path: <netdev+bounces-288467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJtlKk6QB2rQ8wIAu9opvQ
	(envelope-from <netdev+bounces-288467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220895581F6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DA03301CC69
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C28405C57;
	Fri, 15 May 2026 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="egY/bUyc"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB49405C54
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880567; cv=fail; b=Ns+wJg7fj+ihltu3uRHAlwjua/ql+mMZuBEwCLvyAJuRDg8StVfbO/oRIX+sAoyNs+El2DJkiBKrWJeo9lTCAFx605OKIGU32hjLPDsmZKcOFjfR9lmdBSuPmGJeC589XzIE2SNZLwk21Al3c9DtRPuQ3iIDBOH01omCk+4akJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880567; c=relaxed/simple;
	bh=udW24RNxyENlmL9rYR+pCSw1jyL2CKmGGaQFWCAOUKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SF6ilErIYTfVg+UIHAoXmbfzkLquXtalH4Lm8Tc1eIA/7IuimHBFgScs8fiHEzHbNBTR86mRafOp28Ec/rkgR6hA38qMXa46BZUVwPYi8jyhR67aRHRX4sFWs/ahpaj78Vfij5UjCaKC7LP23TyZhigpG/RZq5MaTpSMjSgezw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=egY/bUyc; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY2ezuOHsNGApsBiKsllWqZs0hv/FzFr1XhUksIlc/e18LBHPpzL9QdexhrAbpE6c2/crbQXvs7eLS3hLH7TMmcg+DPmeATvhrgSre1bpDahJsFs6P1SRir8/iO7av5+85/tISnYbHLCC4o+0A33K7cup+nGJmx60cTzNba/fUr1nJqgiQlrlD0kIY/knbP8+pammLDHHcXBShhCNRvKOv457uoYxBw4VbD669CktFRNwDVJeEOlBOlqi9LooBpcE1DpllF2Z1rawqIvio5ETBk5dWdnLzvokju/fDGDQt4WBU50SM1UH9He+McPQbIhvFXsFcl89t4oCXmTJ1nnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLgo/Sk3m/ndBNV2rv2yWGkgg69vVqEPegRN4pl18KQ=;
 b=obChxif9d6QoJjOkvUmGkF5+7dIfa4lwqx0+Zdc9C438b5g/q9yobLLFXgAzZwkbEqazhFW1eqJj4iCW8Yl5TmyRm4bGXMZO+sY8mN2NqBfcgXW8x+8XUmLW79+dBxMxz1zBCkdJdrdPHNqghap+3+sjrz+GR7N+ns/GIDWjxZ5B8fU4aFXOzYvokOiHhQYyPy1f2G4poX9AfWygHY+5ezltj7/vTxwxGro7UVl2ItRnd9rUPiLOzOb4nts8VebUUsiby6P9TjpzmDzEBAO9jGfyZ+auoNv2AwyEo4/3yZuzvLQnAZ3FMXj7jplv/xxU+DFInLyT/Z+gcYblr6FZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLgo/Sk3m/ndBNV2rv2yWGkgg69vVqEPegRN4pl18KQ=;
 b=egY/bUycVpU4A/3milQHJ29StLPn7Pxzo/NqIKm/sfH9ok6RnyvdVNRz6p3voNlkUD8WqwOLtRwC8s0lNJDy928mO+OacDDS9+k/XOSAmSvZOl1pgCrasa4Z20KRrKYcuIx+zJbHi4tGTyf9gufFvqt7jc8+Sgx84kBDIsHCJtw=
Received: from SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) by BL1PR12MB5897.namprd12.prod.outlook.com
 (2603:10b6:208:395::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 21:29:20 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::a8) by SN6PR2101CA0021.outlook.office365.com
 (2603:10b6:805:106::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.8 via Frontend Transport; Fri, 15
 May 2026 21:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 21:29:20 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 16:29:18 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, <eric.joyner@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH net] pds_core: fix potential stack info leak in firmware version reporting
Date: Fri, 15 May 2026 21:29:06 +0000
Message-ID: <20260515212907.998028-2-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8d91d2-2fe1-4c30-f25f-08deb2c906a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	TmIfajVIPI2q0a6v/KMt60ZHa5fj20MZezLq+PaEujqV90g34YHZkqmh+pEFIsqZNjE+etAQe0aqYONo4tdGAC3++PzwhxaXsLWVYn4FizAAEmFbBnuinT7Khk1hkate20nI57CihBKdMXGSbZEaTPvgrWgojlKb9RcpWiorMOl5yxdzIQ30ywwXR46tV2EZjWnqE2RGh3DswhbVaHHEFijGxrWB4M46nmXynlY6Kw56s3teVDlQmrt+yUMFIv+XasI6giXwhEoplRlIvZSwaBiMdDEumqk7fldrBEDFDW/66MwpOu8hfZnPyoWgGVZajf6smC4HLPn/gTmTSL7u+0gHe/JiEr0KfYxBd2nRCN696X/ddx1Cr2iup2Oa95pRX3TJfdj4GgJQHKf40CpFva4Onogjwc89WVrpmiAImXyL31cpX5eaddfXei/tD9EIncjWqRDDpbfc8E8cmsoYBuTlWOzWqYK74ZUdqWnTPmLXgmN9hln792+gigRHyfcG8oDSuTtmqLOCea4t5TSIV52K6oplPmhdsFs1CQRRSaPz+5EWFc/kNE0xx2GTwyshGqaXXZlBF4KIHNRIiYnVUjZbvvWod4o6Go5e8ZINQjsKtwyGYYrVYKSnNFuRPOCpVEHNKnop84SO+L33wbXFiLLmjtXoEdKrYzwic1MPcpLbBtVzomcvOB+jtI4yXmOsHAnz6KpG29VqQPwzaLGU3K9NkuusjsV+qpfqpeMtMHM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	erSBGwoA2932b7bEiME6MOhkQqzKp+BYSH1fr+8+BEj2WvNEU9686Jul3j+uywzS9N/wrcue9mFGAoVgbYFcX8sEZXXxbJvoHU2frw7h1HbpfSSMuglIowQPSf+n3PWIpeYSVsK2sfoe9JZAftr3ZLst1qfwTxo95T5l1XrIEBTloWClxlXQ/9MCxy6txmuqjXw+0ZwPUEV4t0+4voECDpbsIBAJxLbXtYiQ0VpcwHBysJEI+GDvy3NegKHzJNjYJTKS87508YzHTE2PcOgAQenjuko67FZcnUbvW/DY+PkAfSQ+GOcCveFUfNp0fCtFOC9x8RHdWxkHkEqXOI2YAiX7v3sDNcUipAcGKxMOQ69X3CKY/+9/mSWaH6chSvmLV++3DgiVaFjE+8SDJKfr1mW1UqZDlYF6XSK8ddhzpbkdmUHxTc54YhC/MnNV9qTi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 21:29:20.1901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8d91d2-2fe1-4c30-f25f-08deb2c906a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
X-Rspamd-Queue-Id: 220895581F6
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
	TAGGED_FROM(0.00)[bounces-288467-lists,netdev=lfdr.de];
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

The fw_version field in pds_core_fw_name_info is a fixed 32-byte array
that may not be null-terminated if firmware writes exactly 32
characters. When passed to devlink_info_version_stored_put(), this
could cause a read beyond the array boundary, potentially leaking
stack contents to userspace or causing a crash if the read crosses
into an unmapped page.

Null-terminate the firmware version string in place before passing it
to the devlink API.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
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


