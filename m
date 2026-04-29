Return-Path: <netdev+bounces-282278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHNHC1O68Wl1kAEAu9opvQ
	(envelope-from <netdev+bounces-282278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:59:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136BC490DB1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 300D83015324
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAF3A7855;
	Wed, 29 Apr 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yd58JXWO"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9993A3E95;
	Wed, 29 Apr 2026 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449515; cv=fail; b=hsuK5ROQq8BeKs4ZZsBG1fAJK1TR3DMHqEU+YbdY2sz/INO9RZBmxb5tWyADc3DXwUiKYI3RNie3p7X/oEcym/k/YOWsfBr45FrVXXCIVRyyeAX125tY5IwVhQ+bndoVI/UemCNgvLcizYjD9QsxW4CAGkOJ2bc5URM5BHWqzFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449515; c=relaxed/simple;
	bh=Ucjisp6nk0YvlnOIpLK8TFWIqvUWOKBzdTFnWQ4MAlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NlgRmyMiv/m/iNxWRDpb58v+tX989yBfDE6oF2uj3UwqtCk8ZTLjx2LFBz1Q1iSJha4ZgfoaZ/O84mWaRQkMvj0u0wG9Rp9M+lUoMxffu7oT3uNdfivBY2DbHY6VVRCpJWTrO0j6rX/LYQ+dpsoDnb/3nfc1JnE0p3n3sjkvZEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yd58JXWO; arc=fail smtp.client-ip=40.93.195.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8ikLdVDdwA36LAIG2HcbwG8mNYHtYhstCxZKkUPyvd2xMt8LbdAGIvWSgNvW9ElSRAwMaTTgqOpczSmfNQKq58eY0Eb2819hRdfttrsu8X9l0OZLpIMCHe1byQXU9esSXCWTi8UL33lAPV7WIfhdXWCN0i+sl4DTBpgKBiHZl5Ody7KLC8VlU1gPCnT15n20atMdpUmukOxPGGs3pcXnrH/6uHaaOg9f84V5hy+72CwgaqoM8oX+sS+aOCY4CxjnsrNPMam5X88WCqi+leixb4jbvGEN2PGTbUxx8z75BMXv8wH/8YrKns8lCqWBLE5jCetwhtjTHLiyl0bQDroeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doZ/9wYbxmhKZ7FEYapGPYYSUg7Q72G22YZpkzIk1To=;
 b=wkCTOEQzFgHP91eHBbpSIsul0A934tMq8uGSsOndN6E4F85QucYKc0Nk/zQtaG9U2FbtFSOvnf9kJH4XwaVlzfaIfqxgts6Nbr2GEh7JNwi//FP6zrLZQXkqhQv4+b7vQoUt1z/O/icjW5K4gPkIzZ84Vwdq8GZqjnyS5IyBwP1BbxEySKRyORTV6h6pXjYq7Y+QKdlLKPi4Z3xYKjGdiwk0+YOiMBrU9iG5aIiWe+Q6o0eH/dSu0sujWtFhfeXADGxO1WLrRzJkei7s1n4SjzJuuXt5234Ox4UbU14sdoGAbFJ/5z4XB1AzVnijZEXLe5CGgrQlvtY+IWDJ2GDk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doZ/9wYbxmhKZ7FEYapGPYYSUg7Q72G22YZpkzIk1To=;
 b=yd58JXWOA2kD2purHUYBFw+NlGmYEqUdL0CCL6YCEw6cn280gtdMxPda1T2Qy1ROamQ5M0jq0lymWEfLiInkieHpG8Y9ietx6U/Cmg33hzek0b4jogQG7piXcOUd/qwGNvC0Dj+XiEMcT3KeJ+r9v/SDiYv4lZOOI4g8B0epPj0=
Received: from BN9PR03CA0287.namprd03.prod.outlook.com (2603:10b6:408:f5::22)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 07:58:25 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::fe) by BN9PR03CA0287.outlook.office365.com
 (2603:10b6:408:f5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:58:25 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 02:58:21 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 07:58:10 +0000
Subject: [PATCH 6/6] pds_core: add debugfs support for host backed memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-6-e43b6c92e46c@amd.com>
References: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>, Vamsi Atluri <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c25d11-b801-40a9-0a07-08dea5c517bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wbFs9nXFbWA0DfxOCcN7oFFSdTANCc7PaOxcfGUQsEupBvU1Vev4BSs3qRLUiNMJNvGXzZlO0Vf9CXTBSctSvGDzSi04yO2enEKCApPOco4ffP1+BSpBRhbZ6JK065AlzGG9P3j3tV5aEdNo3/KE8cox9opziYK5QLuRInfnrBR+1vdm0HD4cHk2baBgycZ9S9psUS8kcrBLSVtCeh7azBFoxbON+DaN66NeUvchO4rnnWFOqqF0EfKpAsr/fxFkMzzxqA+YJMFWA23bApoJpjuzRTj7l8jldf2YcGr5eWIncXZRA2/9Itxj4I1CxYcHXoDJ/JPKJuPtSW7zCgnhiNuUymv6PtrQBodXo9IbWMolOKUmzWaa8Qkkk2Lh5fr3p+sTnQNsYNLrPs77I2SLBJ+yL4LoHFEyblWJInY2jL9ep2hQxWPWDWXsMsbPi9sdmm6QJXobcrgyfJwWxpg+WZ/Ae+QQeQhzsIqGa6GvZbxoRksEHtyAZbxw1yxvmrzQueji8rQpl93rmSPV+vA7HxxgVuNNb49RFlUgmSNQGVD6iztWNKE5e5pUv12Li4ZXqCOKddqD++eUQIYq7go9q30eECkO1VWA240NU5H003M7/EWAHuSnKkRhcjfH+pqFYqm6kMShjbyO6wbZOnz8znWgl9ThRWdeDBLhNiboNmqohhbRoabaZWSumMv/YQ8F9crSyfXrj2MeythlBdFI+x79miOasJu4tCGRXwLt7jsU6q7FavJW+CyB9GQF938tQoqB90R8UY7TJbhgO+H1yg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8kwOm0OyuYNmFtJ9z6zgYIyeqTV8+mwQbspurPotml36Y8fr0D5VMWEdsR7VRuWNFiR5heRLFhtsvKFFWkmmKDSCZH0d6MHKYJ1QFwofk2fk+dk71OmQ3d7GPgOQGbmdW/2RDDl4o6mtM7dRP1zsJsUE3PT4gkiM7LGGBdiykxn19G9oZgziII0Cm0gBjiCzBvDWbLu3fREnvp5uki4wMdRZxHpRWwLxRBmNJcKjf82BupMKFxgpsBobHckGhlY+VnYc0kYkfxvKSsqbQZHjJlh6xjPhmhurWE1pMs/sT81tZ+rewcQAhgRbHSp28ARoBftRVQrU4N1Wl8JuxA2ZEifb84tQcR3iN7BiMuHXjxgFQowfKPF7tlmPMoIkVG53yfgDGHR5RY56N2o12f4CVSHYIJMZD5d+F1bjvIwoYv+FT1FTIdLwWVz9RPRxNPpG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:58:25.8094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c25d11-b801-40a9-0a07-08dea5c517bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
X-Rspamd-Queue-Id: 136BC490DB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282278-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Vamsi Atluri <Vamsi.Atluri@amd.com>

Add debugfs file to display host memory allocations including tag,
size, order, and physical address for each memory request.

Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
---
 drivers/net/ethernet/amd/pds_core/debugfs.c | 43 +++++++++++++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/main.c    |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 04c5e3abd8d7..79312107f721 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -173,3 +173,46 @@ void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq)
 	debugfs_remove_recursive(qcq->dentry);
 	qcq->dentry = NULL;
 }
+
+static int host_mem_show(struct seq_file *seq, void *v)
+{
+	struct pdsc *pdsc = seq->private;
+	struct pdsc_host_mem *hm;
+	int i;
+
+	if (!pdsc->host_mem_reqs || pdsc->num_host_mem_reqs == 0) {
+		seq_puts(seq, "No host memory allocated\n");
+		return 0;
+	}
+
+	seq_printf(seq, "Host memory requests: %d\n\n", pdsc->num_host_mem_reqs);
+	seq_puts(seq, "Tag    Size         Order  PA\n");
+	seq_puts(seq, "---    ----         -----  --\n");
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
+		hm = &pdsc->host_mem_reqs[i];
+
+		if (!hm->pg)
+			continue;
+
+		seq_printf(seq, "%-6d %-12u %-6d 0x%llx\n",
+			   hm->tag, hm->size, hm->order,
+			   (unsigned long long)hm->pa);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(host_mem);
+
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc)
+{
+	if (!(pdsc->dev_ident.capabilities & cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
+		return;
+
+	/* This file will already exist in the reset flow */
+	if (debugfs_lookup("host_mem", pdsc->dentry))
+		return;
+
+	debugfs_create_file("host_mem", 0400, pdsc->dentry,
+			    pdsc, &host_mem_fops);
+}
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 0a0542bf7cbb..4c14198eaafe 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -264,6 +264,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 
 	mutex_unlock(&pdsc->config_lock);
 
+	pdsc_debugfs_add_host_mem(pdsc);
+
 	err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
 	if (err)
 		goto err_out_stop;

-- 
2.43.0


