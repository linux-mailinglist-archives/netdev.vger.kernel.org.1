Return-Path: <netdev+bounces-282294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNzRFQbC8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A922049135E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B84C830841ED
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E053B3881;
	Wed, 29 Apr 2026 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dwDvAntr"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECC3B19AB;
	Wed, 29 Apr 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451318; cv=fail; b=M+qP4QMgjXjwBgExHwzjdiYiniN86rqRWnaWXxUTmV5/WP+Ni/zyS6ppM88gnlMNj43ECbxjV5aD7n6qQ9odRGI/6k5mz5giYZBWOMcF/PNPipZiSTWAhtQDLI/qC/ygkSZVkapzdyTv0eR9YaguJobmeuGRYUae4xVBlH34RV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451318; c=relaxed/simple;
	bh=Pxfj0aMFAjgOC68mesnrDf0itOVSZrZsmsJxJGjmVZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xy4nXjeM2irL6C6i7u6xfT6IOz830IqEc0ifo75U4/g4EaSvuHrKCMBJcZymBXeQKi9swqSUJqZFGWOllu/2FuG6tjC10FYeioisxBvwbY0+HdGKWILvtMZKfnoQtDphfZSKUvpuXo2sYj+V9IVt/fkMeLPntZwGCQMU1T+PiSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dwDvAntr; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXFFN8d25WGi5SxH+Ot08EnOcav4CoTYy+SGm9E5h6tt8ng9ENMGA8AcFg87H4nUK56Ua/b2k8JEd/aI/ScReNw8W/4bIF8QcJj07SHpfDa/ccr/uQD2sWAMS73QBXmkdfH+J0vgCCJ/LGo4Jndl/CouMmmsYjDaEPx0K71MT8wbyg5O6wQ4wWbeOFSN0/s5jKtfkhqqlqOm5iSsJYnHg7fZuZYu5uOaDxvw6SbDjiMSIlTWA1tLgIVAgaEXPYwgWtaM5l7HLsTcAY14sKUkI3f53wQBnZJtvlWuQ3kMJ6ts7W4cljB4HwU1rxY2UHeT8EXNMzkLyQ6cIF91P+zmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdtAtnpBAO3qpDcIHt2f/jzL8Y7+0rmyYfn49+UY9yc=;
 b=Lkc15T/fbay+tQraT/zVEuXdVXl4/IFXhgHRBfEQgxBshrPtWJOuRgcLxHG/rpEYH+r4qm0uJu6U6fOtVc8zJAZm4YplHqmR4Egdz/Hxqhf6ati6P5jnjICe+vWUBxKVzC0QDHOgePa7p5Dv8GfUs7/QWes62G/byE2Hb3+na1oVvMJwsOBJ3sQl2EkPuIV+lFBA4WM6teFlAWzwPGR5n019D4xu5kyMVMCBLf68k3svcn5l76q2148zzOmvAe7ejpdIURiIkGPhMUnm3kR4JqSAAhH8P2rHQcPpMMBuRaJC/KOJI5vgGzAflYEJzOlVl4V593HVRqo+AAZxzvO/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdtAtnpBAO3qpDcIHt2f/jzL8Y7+0rmyYfn49+UY9yc=;
 b=dwDvAntrKxopE3WX46V8ISB3UNvK62j2X4KeW69JbZYQSB+iH3xDhi5XgikkPlj2oMn7ozM9jQPScxJDREgfDA/tyWSvhq1HBD510du4nomZtLnXDWt+KIeYHxaz5Jt4HYtQWHIzG44nFqCHx6dCAfa7HsQmfWOOpU22y+SKrUc=
Received: from MN0P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::10)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 08:28:29 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::cd) by MN0P221CA0007.outlook.office365.com
 (2603:10b6:208:52a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 08:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 08:28:29 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 03:28:28 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 08:28:18 +0000
Subject: [PATCH net-next 2/6] pds_core: add support for identity version 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-2-394fafba526f@amd.com>
References: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4447e479-26ff-4edd-94fd-08dea5c94ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XRAZsd6Bjy0/wxd/B7WoIiRkLmG5qzty8aNBJ4m1cgLSPiYZg0ujCvJ/gtLo5xOQdvcqegBE2Hq/FxzCUst9yB/UyBJTyRfc9MFZwwcAH8b+MdbxPs36vLHp09iw/brkl6hmBCQ/PcuV36yeJ9tw5cooNBxE10qhUekFd3Lk7N3bIvDylVzmbfXMH0C2+XR/3T4kszkiWyzCXgsdxJmFRvWN1nQM3ZJg9LVXQtzntHMg23fwaCAxHCZQcNHQMhk94EvjPlLtVhFUeXNwlOKI/aVK0Sqgm0Vrl0JQ8u4ediAlFilp9Q/Gmhz7rwgogaaCCnxGqsRiWGGEwkW1i+q7ff8ErdwGBjrRz2kavJdxAfNBw6DcljTIWYXVCLRVDdBMFDnxJP+rTODlN6ONIOZXL28/Yy7FAD0Fgdpx1kdPVds61Ub7iWLFN0mXvGCIUraHYWkiSmnmcKKsrE0kKBKKJpWCJGELOPU8YF3DNXRf8ZkJYIX75bKGpeRGKUQJbpEAsq9CXTVob/f7nnkb0lKYnnSNl9LTirRjixx52nX3t7g7k/oSXPq/00d3CaofwPFN5HQfI92cJYbRr5eO11N+/gnh1x2XvW5vZqgy24hMc5xn87QVjRb4a1/qTdIf3TaI/KiYjXj1QRwhZw9CFJ+3aHlKIPlhcSe5/iyS03IUdWROEvL9ysFGq++/Oburz6em4DapSA7IpwlYvyFrvRVFGPb2jAKNyzF5SoXvaRD9YXp4tPb9WK+SvqpXnbMOL/uMoD5x5sbDVOk058L+tR84FQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YCtaoIWjjgzoqdEAM4v4RBhkvv4UZwy34ekPr2F/Hr78gblhtQGZ8UhFCAQ5oHeGzorP2dORJQ53wbnvs1VMcELWLezV/byeNZe7XIYHF3owSWsdf4FmJu3cqWo2RCJ+FrLNqKHlgNw+mb0mI/HAIb/fMPHuw05sx36WKQSeZF1idOBcvwL8b5O0mCI21B4PYS7dJYrX5+tgaOkTAfXsL/6kVq0s/JcUo+1BKnGUZ6OKyIxkyue2jEKKAgfuKR94Sg/ex6vVvXfQrc7iWO35nDC2ROzX/KofTi9655ZUlFHvaA9bIv2gVbNWHCZydvtKcp6ZBa3gpNCYCaDWxc52fhwg9TOEzfq+gLouE2TeyJZqRHEFxxlweZhxEuyXmGFAdBNTVU79EY8iXhdPY2US6ZSoqTl2jMamg6qD6vW21W775tXYnSLNeYbRiFXJPZQM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:28:29.3424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4447e479-26ff-4edd-94fd-08dea5c94ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798
X-Rspamd-Queue-Id: A922049135E
X-Rspamd-Action: no action
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-282294-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

Add a new capabilities field in struct pds_core_drv_identity,
which requires bumping the identity version to 2, i.e.
PDS_CORE_IDENTITY_VERSION_2. If version 2 negotiation fails,
then quietly fall back to version 1. If version 1 negotiation
fails, then driver load will fail.

Another patch in the series will make use of the capabilities
field.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 28 +++++++++++++++++++++++-----
 include/linux/pds/pds_core_if.h         |  4 ++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 5b86d6cd0ac3..f77bd5e48b92 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -243,15 +243,17 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
 	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
 
-static int pdsc_devcmd_identify_locked(struct pdsc *pdsc)
+static int pdsc_devcmd_identify_locked(struct pdsc *pdsc, u8 drv_ident_ver,
+				       bool do_msg)
 {
 	union pds_core_dev_comp comp = {};
 	union pds_core_dev_cmd cmd = {
 		.identify.opcode = PDS_CORE_CMD_IDENTIFY,
-		.identify.ver = PDS_CORE_IDENTITY_VERSION_1,
+		.identify.ver = drv_ident_ver,
 	};
 
-	return pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	return __pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout,
+				    do_msg);
 }
 
 static void pdsc_init_devinfo(struct pdsc *pdsc)
@@ -274,8 +276,9 @@ static void pdsc_init_devinfo(struct pdsc *pdsc)
 	dev_dbg(pdsc->dev, "fw_version %s\n", pdsc->dev_info.fw_version);
 }
 
-static int pdsc_identify(struct pdsc *pdsc)
+static int pdsc_identify_ver(struct pdsc *pdsc, u8 drv_ident_ver)
 {
+	bool do_msg = drv_ident_ver == PDS_CORE_IDENTITY_VERSION_1;
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
@@ -298,7 +301,7 @@ static int pdsc_identify(struct pdsc *pdsc)
 	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
 
-	err = pdsc_devcmd_identify_locked(pdsc);
+	err = pdsc_devcmd_identify_locked(pdsc, drv_ident_ver, do_msg);
 	if (!err) {
 		sz = min_t(size_t, sizeof(pdsc->dev_ident),
 			   sizeof(pdsc->cmd_regs->data));
@@ -327,6 +330,21 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+static int pdsc_identify(struct pdsc *pdsc)
+{
+	int err;
+
+	/* Older firmware rejects anything but PDS_CORE_IDENTIFY_VERSION_1
+	 * instead of returning the max supported identify version, so retry if
+	 * firmware doesn't support PDS_CORE_IDENTIFY_VERSION_2
+	 */
+	err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_2);
+	if (err)
+		err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_1);
+
+	return err;
+}
+
 void pdsc_dev_uninit(struct pdsc *pdsc)
 {
 	if (pdsc->intr_info) {
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 17a87c1a55d7..619186f26b5b 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -119,6 +119,8 @@ struct pds_core_drv_identity {
  *		      value in usecs to device units using:
  *		      device units = usecs * mult / div
  * @vif_types:        How many of each VIF device type is supported
+ * @capabilities:     Device capabilities
+ *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
  */
 struct pds_core_dev_identity {
 	u8     version;
@@ -131,9 +133,11 @@ struct pds_core_dev_identity {
 	__le32 intr_coal_mult;
 	__le32 intr_coal_div;
 	__le16 vif_types[PDS_DEV_TYPE_MAX];
+	__le64 capabilities;
 };
 
 #define PDS_CORE_IDENTITY_VERSION_1	1
+#define PDS_CORE_IDENTITY_VERSION_2	2
 
 /**
  * struct pds_core_dev_identify_cmd - Driver/device identify command

-- 
2.43.0


