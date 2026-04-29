Return-Path: <netdev+bounces-282295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIBqORTC8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B87491366
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E346D308D249
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153073B3C0B;
	Wed, 29 Apr 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ny1NZ4i4"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803E3B27FA;
	Wed, 29 Apr 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451319; cv=fail; b=fMtDcC80LYvzkMEPg9vDiEEVu5r0oisO4XRnFUhP9IXsRpL9CBvj0RVhRETT8NWnckZ1W2B3y9xP3KfW2aSTzetillRrR59Eb/EtUfmlYWBLfJ7oI8+sOpZe29MRtxiqvxOnoC10YCQuZ0WReu3EI2JmOh0aMlay+TKiKBnp2tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451319; c=relaxed/simple;
	bh=Ucjisp6nk0YvlnOIpLK8TFWIqvUWOKBzdTFnWQ4MAlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iexAebYwBlwEZSwl52d98CzCHMxty221pxEsANQLbqmR8oEe1Ho8U0rLZMOYnBEbvCNQiD+7lh2cVimpB9ja6hxfx9FN3ochJBZIQsxDyW516AHlwabTtY8dFmARuBvSKd7HEmGmrm1Ccp+gc//jVpA5KGTQDh/mIe3xevOD+I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ny1NZ4i4; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeyADGurhBYuAy6EqOdhlnKB3rKwicqIDpwoOIEmo2TOd0pldu/vRyonTEHke44V7nPBlct8y3wleWnanjj1xEbYTJ6Fp4C7mhHU+HPNYGcCIj3UrbgYnw1spUD/gkHpSKkFF+4iwSymWyU1h7H/NYG8nhrJehTzmvQMzaWTO488KBDkMmJmKPIC65k18wpgzDtttSZTQsbRzgTtW8yNCCpZpZkw2rHFlIX3NNcR1Y15iNasRL9O4Hb40i3hKgKZCixTSbRvukddgyvmBuvPyeLRmJAjy0lhBwlGukQSMje+dCJfWlwl7VswOv6GX8stUU3DxRK9SwsqoTHZ5Hny/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doZ/9wYbxmhKZ7FEYapGPYYSUg7Q72G22YZpkzIk1To=;
 b=WxXkAbIpDuKZtcxp4BSSMYycT0wAmxUdaWapZqc2x/g9N1BAizDkb6P6toTqne5Teo3AJSivSAeKz+q7L6296WlRAzloyCfdRl/RBpQhQtT3zes6m5KoW+BMXPfWGMt+aChTyKpM9kYpLHzKeQQZv9j4Lsz5RmeoUpUZlg7tLEYkgtLGFPKz/f7qCmZitES7ZBhq+7qFCB07VnNrbthmRKcezlb3Wdq1lpNOWjhW+8lPaAhP+I2aoti+OLLOAGYitxPCiyOivibbP1s37G8MEfhClV7AkEmasvRgYwUJrl7jKNqE8GHRkYqFyIEc5upn6cPV7twgfY022g/PyUTu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doZ/9wYbxmhKZ7FEYapGPYYSUg7Q72G22YZpkzIk1To=;
 b=ny1NZ4i4sCQc0MLvjxdSqh/pWUBx2tNS9t3iQQiJY4ZhYEbFTkfWPH3T7pD0/k2DsWlSPgRCmb9H7Kg6cNgsLX58Hv4nrfP3LVH29YT5K9mzEF4BgfNGWA1LEGMiV5YJL9q1FrIsdAdDTYVIIHh6RE4h39dFdUBwlVRRRqCtK/o=
Received: from BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::7)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 08:28:33 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::f8) by BL1P223CA0002.outlook.office365.com
 (2603:10b6:208:2c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 08:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 08:28:33 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 03:28:32 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 08:28:22 +0000
Subject: [PATCH net-next 6/6] pds_core: add debugfs support for host backed
 memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-6-394fafba526f@amd.com>
References: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>, Vamsi Atluri <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: deb38821-e257-4de2-4e5b-08dea5c94d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wTmCuZYKUaLwJJD3SD0y4wg3YiTEy5EC1s4XRe86y+4VIiN0umqBKl3MFsAXs7kJybnAM26Bt6q+8DicyZR19y/cd5xNzlGlRMIUAV9tp6bMSGGH2OGPCgmjqiuhvfaWr/KKZ/dWPKxJkQPsZQHCLOFcdZGxCkRzvUt3ZdgT+amBJuR/muhJ1fduYjmKLnAUCOvnBHmHn5fVhjzv45HCh3rS9YN5mJLrcnxfnMP/Hi+mSqCIkG9EzvpeHYRG57NhYhgb99/IIev5KBaj5WvbbWPtNfYwUS1UfF/KBNpKFBHpRBJ4Q2OGEF1sQkLPQwXKKKp0xWRrbhfosYtaDdokSKFFAmFXHzgz3Msvi9rWbLNaMKBzsDkOBsOXVbdNJg/TjBOn5uV8Ufy9kSQYF3wSwQgr7lBxsrztQ3aLI6n++IEkO+LIaZqsVmgCGXreMRGy97v4JYhNeYzvXqwTBCag79PiYn7+4+h1WcTDck0X2oOKv+SuzAvLR4w8IOos1U+hZKbfiVSEnbOoty5HTdA0aCrpg1PBybisPgrtSDjQaTjxlXZkDcOjNnQ9MDOppKjGmhO7SWLUIeyZDHKH4avGwoEE2MGjO0+VeawE35UztcI9OlefB76OlOaDj3cwIrWYN3KnhZ6+bbi0xVKpS3urhan9zw/E4vJcwAGbiHK3kdaXbJmPzA6CHZD7TN+84eonWk1onyH/iI4+YqW1OV7ZY8ICQ1Skie4aLd4xq4pnB6vY+OuXu7tYjg+3amd31zsnLv3fTz2G4CB9AYa9fsPHnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kvFInFzNRAJpKM2Re+7BuxcR9OEfw3gJ3RTjfypqv7KoNTFH/YCIyTNhyOLRYyWke+Rz27CwdKkyJDP47t1apWgkKbs2CiRulcA7EESgImvrvITF008c6UCiczje24eWAQkdatGfWWSmQXnkJc5TTAhQGEZTBbmccQ/6hsLNBd6ZBjBKy1oTV4lqBTxm5Lx1Z+6OjR75HQMbrtNSoJA2RM4tBQug0eSi6mgP90PYBIzg3e1vp+QYvog+Bt4KuLYMWXKN8IEm4KLhH2M2WX2Ty3HqPRwYf3/XSbGvDCwEr0+FEWQpChh06p4Uk8yGFm4VyWRvdaJZcQBrZGjOLW/JB+cuO2CDzB3ITJhZUnlunFGBNYSL6jVBMBUFMelqF9JGxGu/y8nkggG+69mYyesfjLAWQE0+Yxmu3Jp0mPDonOl1UR98p4aMEsGpLrW/XJJ3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:28:33.5093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb38821-e257-4de2-4e5b-08dea5c94d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
X-Rspamd-Queue-Id: 58B87491366
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282295-lists,netdev=lfdr.de];
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


