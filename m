Return-Path: <netdev+bounces-296759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O4R8JxVGJ2rkuAIAu9opvQ
	(envelope-from <netdev+bounces-296759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:45:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752D65B0E2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:45:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=STJcBZVf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296759-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296759-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43E6C30B8A0D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554993B3BF3;
	Mon,  8 Jun 2026 22:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9D3B19C6;
	Mon,  8 Jun 2026 22:40:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958460; cv=fail; b=byQCQcZcJ4iEVTVwz+T8Mq/dd2/RUzdNzBLqGDxbXreclIO3VqFlrLbmxxJAfUJCqNXyF4kDCdf3RsReszUX2cbI2Ngm82WHYs2FEw+txj0AemeYfQ5iTVWMZvqGCooBmH3aPqS3ZQDXMaIVM+oGijNqggHXON2foiUL7Fx5+VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958460; c=relaxed/simple;
	bh=rE9eIRTUG67nqC/GynzmklkZC7u99UZ/hVLkdQsEVF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SriDkSi2QzMm+XIewRx5whjWpJfdM2bLHh6aC/0pYikC0nyVhYJVlZ3ArQtkrARxJlK9fTh+gsAYDwy1s4X2C8i1hRoZsU7PSrl+tsPGEv7cQjgGluOW2Tu05++mOuHXse/lQLJd9hjUS5MePkgrosuunABmYnIJPSdMWZoUUFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=STJcBZVf; arc=fail smtp.client-ip=40.107.201.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyIdsZey2kyrhZsQ+Z697p+i0Bn3rxykAyEtoQO9+Mkd4QGD0nmLd1y0zBguwyyIB8IQXdRjXt+VWrZ8/Z9ElXJpKYmEr84ACqRUrK0i70BcSD+7OwKE4xSbaCnEUwbJm7RUkA1lP6cIJN4hYNqJ/hIgZltqUCxvxlV5Z064NgcKrdscUEDF9MZwlZZj11bhMPM1o+lyO9EdH2DANG4T2RPUEKgv3NT3lzBT3xzsT6VHH7NcK0j/SoQ4gpzxvlJMqBsMnv+aolksXaA72tIDMlIkp/ye+efNshHL0t1jjqJkFej0HwzvsKO9W6gC67JqaIXujnwQLjLjVf34iyLDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+lFpAnmgS9dWGkZwFo+RaYwxsNoIRYrPG8zt9Geeto=;
 b=m7aXp5kuhTCB22NQe0bca5FVSRnb+VOzjLcXUKP4dpfsJSHgFzCR6CzS9Pc0vD+HlziPdZvNyrHG+RgtEcPXKrEmiQb37EK1q1a3KnjbxNrvWYpFwvdpQNTUlcs0i8waY4k54jh0Sw7UYOh1iHzGYaL3AWf683v4Bgtv57MSJQrCObf+83VPU/yZyz75aWgbFuxq5q7l6LtM0QtZfbL6jisU1BRSY1ejyyrT6WTSyx/s4ZOAW0vSsVBPCFNlhAdfqWt0mEvegphIBdPGJhCRwhK9n6D7vU9MEFDAvwn7ZT2JLTcZZjOpSS+u2mZdGobV6lNT+pC2wTmZS1NubhBrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+lFpAnmgS9dWGkZwFo+RaYwxsNoIRYrPG8zt9Geeto=;
 b=STJcBZVfcZVXoaqtB7bgnSOs08LD43RNhCxYtdZqbOUYhIAmXnQBqwLynrKkBrdZ1+uR3O5f5bFj4Ppo4fPqy0kpnrDm8SOaQGE25HAJTi0AAsTkolBahB9exLEOtIsZL2IBVPujhRGLeJ0eMkAUPbHkBv0Pt2mZWkSNq4GRBYI=
Received: from SA1P222CA0069.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::29)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 22:40:55 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::32) by SA1P222CA0069.outlook.office365.com
 (2603:10b6:806:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 22:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 22:40:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 17:40:54 -0500
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:33:16 -0700
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>, Vamsi Atluri <Vamsi.Atluri@amd.com>
Subject: [PATCH v3 6/6] pds_core: add debugfs support for host backed memory
Date: Mon, 8 Jun 2026 22:32:56 +0000
Message-ID: <20260608223256.12357-7-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608223256.12357-1-nikhil.rao@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b71e228-5a75-4c75-59ad-08dec5af009a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LX+Uw+iTHgGhs/1dw8CQCyfxrRKjLYjg+nMpNxkuXKEyjeAULhAOh+vJ74U42hYn+2YuSn2kBfkkQKPGWqp1LXAzl1IAcLyUgF86R8fyq01B60y1WYcnXJsVY6gazZVAJANz1O3cjgNK+CppPJkd3ANfA8M8eayTA/+pK++f7TvApuQNJMXOl30lunLH8GHXblFs+LEeNuJhA1SxfO20ZvFhoUB6F/kCxb0yjS5+If6868VUM3kWFUy8iIN9gWSRQOWOXzk67tGJRNAhO4s9wX+fGsJ+eXf2ZWVm8PwMDMOS58Ad4gd1wuUdxr3BUfRuadi3awPbMERxTdyDAsgqOQBTJ8Y4VtM6tfVXSiVnGQOEjL0fcifltkgz3++SUWqobuOPK1MoWD69XSZ7Al+Jz9icVKFFYNIw6z+fvdcDc0nN2ymFPFK4AhZFZol5f6mQ/P1lh40/vPFxjG2fq3nUjvywZl8i9o29U6sepqzSNyKkggJs8O1BK/REojcaML4nW6rRwPB6S6FHLeYHJBAuR4birEdC1EBMZO5Ey0aysLbVa5fmhiZCnPH7wOrgCQrOmq1e/ZmG7K4IbzkaEag6fjXiNLGj1zu45KvsIgH3WKero8ZoB8e6+888u07yADnbaYX8fshZQ4Fqeo3Siqz5dlo+cIAekv1e4BHuG3D/kPK855vSJ+hGUF4JPRJIDkeG6Jr1R9Cr7HkoyqnXgZ8KZDXF1An9HFaBLGyX+LJ9Cfw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JZtQXhZ/XG2ZRlYSd63olWFPt1rFUFuXAFUi+Br4J7AEiPa4nTIoxC1BekIkFSwKIvxRGkPYug8ISP5Iz5idaLL2haAROTPQ9t2596PuHEB5xujQaUnjJQkGWfw5vtgE7hCpeX/7hkqmpkWssLH/DW30zx85EsE0BJAukQnp1uVJ8SFNelbIHpRO3K2QvHNjPx7ByWfLMqkFCi9YHBD945reGgi0CznihV+kcgFLZLrDiPjI73jq4ZRr/NcfucfHQgF7q398LwghCImeya8kj+iLfDThQIXdCd2H3Miq+FHiHu3B3YJYPhUlCzDfcS6A7Dx7oDFzV5dCUDMBJN0M5482fy/QS5sAS/FxOr8iKayqX/XebFXIKMvvws1DY/gnPRFWzkQNsrh0fomjKhTuaGEmQuAXh75j4G+v7iItK6GWnzU6dFWSE8ho8fH7vpGD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:40:55.2588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b71e228-5a75-4c75-59ad-08dec5af009a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296759-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:eric.joyner@amd.com,m:Vamsi.Atluri@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5752D65B0E2

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
index 249afcd5f5d7..fa73c008d683 100644
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


