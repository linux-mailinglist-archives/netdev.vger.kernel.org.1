Return-Path: <netdev+bounces-299144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XpA8Bdw1LmoaqwQAu9opvQ
	(envelope-from <netdev+bounces-299144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:02:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BA6805FB
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:02:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=uN5Z6BZu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299144-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299144-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446D03030E83
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5F307AC6;
	Sun, 14 Jun 2026 05:01:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EC30BBB6
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:01:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781413287; cv=fail; b=D70qGZW6xeMxeIhMm2ETNVaGFtDnBub70tL7X0wT+AGFhredkqNo/EX9rX8891kiY6NXsI2BcuXzQCKXx/4hNgaNp0+Ihiea0/M+u1weEQpaP2PK2D2bJkJoJ0I+31ze43cncDCyfrJPPoNmnrgyesyW65jfUWu/v2JF+YtPFYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781413287; c=relaxed/simple;
	bh=FAzljHnNLKfrNSJpjCqajj6mK8WAlU+c7h0j/yheMdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+NbJU2ufTnUn1qA/BET4OmOWYEvV9SuGye5aTauklRel5gwLUBkpkq+WtM/K2rgj58x0m72lxeJ5bPaqRf1otFeFsS24nlNmb4VXcuzvu5paUC7mqY5vpBi8pqr7/8qwTT7MEQojG3lJPq93A/vyVwwS1FZQbqcqoD8EEBBUyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uN5Z6BZu; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rG+Rwa1dHNPI26OTJRgVV6fF+L5XSL7yzErwI+w3nVa2i0Nb2rFsxuuzJeW+r/BtQCyH4J0aKlZN7vlShOrHovBohYKWfOYvV6sizBMLWlILLHtZ0sAlbv/GPJvG14TnLkQ0YPySzj7F7+RvbftTV6Y3A2mNW2ZY5VGdITSrGwreEQ7CeNMWd1ei64iUv4FwzcVqKljYlZlepE9hjADpflnNrvFA3Wx3+s2AE1Bj/cnZSeQJWoa5KtrCqM/zEQsEQPHN+JT/qsPIxj0msTKqngHHHBs37wEsiMLY+O61CguF+yz5tDhcNNAKeSX1VFc2qvZy0bF34KpkgAD7+eV/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8FJJOjg8ATRTWcfcMUqbJ2bU9Dy7eiWi9AMCFDRESo=;
 b=CjZhpj1SaYR0iUvLccNRfdMrkoeMXlwjO9w1yo0bBM7u+7HHfNp9M6HIJ+y0bIk050dnm+9ZEsPDps9PXm0SV8VQD9SPdFHXSM7/GsZm3902aKdH0sLBUzj27uFrkXIEnvlbZ0YdGSUIr49J/4IM3Fox5C13SN9AbFmOKf1xE3ObZ2oUIaAc4M7lqb9j5fhqcrm7fTBTIQ9TTEbR+OVK3BfWdLNx+qdK5J+d29U7A3VA/hLb1l80WdursS0Nk+d2JUWe1XbsGwVr5eVjbtXdRfMvDLLDeLS0cTOYXbtSWjVk3en3nm803fF9/0sb5ripQXBC45u4pcB2vJL86pZ5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8FJJOjg8ATRTWcfcMUqbJ2bU9Dy7eiWi9AMCFDRESo=;
 b=uN5Z6BZuH5MFLg5Rt/GGUTLNGBS+JfcNgjcdNvPXY8ECx3pLk69aZPIUfAuYPLa2ghiurBWJBtCKY/E36GXkOk9CxenPly97A6wewqFhZQt6a+EB8R+WFjDpxFCtmnZqfz2D7vaiAcW4vJ2CenJrHabo8JTOeEKvURhWQ4xHpRk=
Received: from PH8PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:2d0::17)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 05:01:21 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::46) by PH8PR02CA0008.outlook.office365.com
 (2603:10b6:510:2d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.16 via Frontend Transport; Sun,
 14 Jun 2026 05:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 05:01:21 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 00:01:20 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, Vamsi Atluri
	<Vamsi.Atluri@amd.com>
Subject: [PATCH v4 6/6] pds_core: add debugfs support for host backed memory
Date: Sun, 14 Jun 2026 05:00:52 +0000
Message-ID: <20260614050052.1048328-7-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614050052.1048328-1-nikhil.rao@amd.com>
References: <20260614050052.1048328-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0bd9ef-df44-4915-5aad-08dec9d1f9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tZyrydHFmVhbJ1gvxCwAIowbBbhPLkQdLpde8qyJ25NPOHD+h9FhfstXZv/ZHJ1q0+0lmEf5YAf59i7D/8u1X42Am97XPqdtVUG+GS9TKAGKaM4BWzZ3aZ7k0zQ00OIZ9+QZPpMq80oHrRek+v8Zw4dyBoZS8tDzQqe1jgAreYc6D+qGfaZFF04LO71FWd8T2lR7QUiCt0+0V6xk96nF3hlB6VWLksxj9SESHKyE4Jn8V2BN9DVZ8d0DVEKQp+jw9ncrUgP5ydQZdhxmqFvkhmUwiRrj5+wjyTX6KKd5xcJH2YmkEqLfLtBHpxjtmJE3TzLOy8dNv586AuDa7vgznqaVGo/b1AO/gQk24d2n9UWi9zHVn3BOHHslKoUebv4aA1B8vEYdqlG4i5chi8QfuR0w99ZaONgpd7C91rw8MxcvLCFV8/lqPLK1PmFhAnAjxfZHfEBMq2WEC58gj+JOWe4CClZ29aqeOD3jC3/sLhbwCnDIb/dd3DZMFQA61iqCWX3UGcykTpLlcWT2+XLiWHEl4/iin35q10KrgFQVDK/bzJL00eRfThPCysYRBFQVyV5SXhv8LtacmStXCyfxiypaGt9q3jQonySUiRnAMXddK2IDdterBpiJLX2RmdEW1ZLp3TEoE2vQblniWC+i3o/14HtA0hKUupbKL7v4l33As8QCLft1fRKUEuTKfOF28Nm8dV5J+/710XavH7xzk+xFBjP9W0O8OxMrVvjxRbo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8/StAaxVOzzG6FkwO1j0i56rVkYkoSCAp7Lsj/z1HrC9m5O16QFiDzn3waHyyqa6JxTn7yjEFWVzYAGokRxbdBxjZA9VSl60Zj8M9T5TZf+WvxCAQ5b84ieV1oapz8SYKA/UV3MWf3SeOE21MvouBTPiDtgCmSIuumnw4jzgBSyGRRtTOHLVuKtZaBxnkx8Vf4ce5+BAs3Qg88FQ1jUjAWZuPp7vuzsK18yX13fv3HKJxNo38FwL1e7+idLigWHR5YpdiKQ/qvnDLZ+TKNv6wv+Xv0UCt4FZleVj6SId1/tuckcdEvGqSOWqUobitt/JtzFvDd0fa0gb0bWwHjU/9pf72rr2Xc3wUf9XtvppfsYh7vPb7/MOQsagCQnfkL11pgGtENRjQ46jNaD8eLSapBIVHdaZspZ5MH1wAIVKA9abG4G2xau126n01uuX5pmq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 05:01:21.1726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0bd9ef-df44-4915-5aad-08dec9d1f9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299144-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:Vamsi.Atluri@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 620BA6805FB

From: Vamsi Atluri <Vamsi.Atluri@amd.com>

Add debugfs file to display host memory allocations including tag,
size, order, and physical address for each memory request.

Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c    |  2 +
 drivers/net/ethernet/amd/pds_core/core.h    |  1 +
 drivers/net/ethernet/amd/pds_core/debugfs.c | 45 +++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index d1695ca95440..c0a8966dfff9 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -487,6 +487,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_debugfs_del_host_mem(pdsc);
 	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
@@ -498,6 +499,7 @@ int pdsc_start(struct pdsc *pdsc)
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
 	pdsc_host_mem_add(pdsc);
+	pdsc_debugfs_add_host_mem(pdsc);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 53e5a6f0af9c..b453493c093f 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -304,6 +304,7 @@ void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
 void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
 void pdsc_debugfs_add_host_mem(struct pdsc *pdsc);
+void pdsc_debugfs_del_host_mem(struct pdsc *pdsc);
 
 int pdsc_err_to_errno(enum pds_core_status_code code);
 bool pdsc_is_fw_running(struct pdsc *pdsc);
diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 810a0cd9bcac..ef0a1b7d159b 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -178,3 +178,48 @@ void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq)
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
+	seq_printf(seq, "Host memory requests: %u\n\n",
+		   pdsc->num_host_mem_reqs);
+	seq_puts(seq, "Tag    Size         Order  PA\n");
+	seq_puts(seq, "---    ----         -----  --\n");
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
+		hm = &pdsc->host_mem_reqs[i];
+
+		if (!hm->pg)
+			continue;
+
+		seq_printf(seq, "%-6u %-12u %-6u %pad\n",
+			   hm->tag, hm->size, hm->order, &hm->pa);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(host_mem);
+
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc)
+{
+	if (!(pdsc->dev_ident.capabilities &
+	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
+		return;
+
+	debugfs_create_file("host_mem", 0400, pdsc->dentry,
+			    pdsc, &host_mem_fops);
+}
+
+void pdsc_debugfs_del_host_mem(struct pdsc *pdsc)
+{
+	debugfs_lookup_and_remove("host_mem", pdsc->dentry);
+}
-- 
2.43.0


