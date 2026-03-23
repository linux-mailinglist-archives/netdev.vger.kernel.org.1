Return-Path: <netdev+bounces-270489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JJnJv8kwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:33:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 247E62F1438
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D3BC300C321
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27395398906;
	Mon, 23 Mar 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pr7732gp"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F7387373;
	Mon, 23 Mar 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265537; cv=fail; b=Q7nyvNmGi/zaOqHZNpJ26BYLBdbHU6w3MBLpojCfR5x1XemWQdegltmLWbIN+W00BmhgdpNrEkTxTPEQ6qEaWickLiDEGwK0JpQ+0SrQxtoanPEcAhWVCz8RlCVvyUGbQaWZoocnrdtUIVi/qnlUdEetNxnkm5spxIp/6QytN88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265537; c=relaxed/simple;
	bh=sI3iyUvgg2qmNY5vKaqExzhyOO0+tyWZ36etV7HtFSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DC/NF2LalcJVIlpsP+j1kgzDkXU4iWE6kBjTtYipCW+j1m5uCuVdviSxSVvhPTbLDQ0L7LHqhnkO4QZinBcPBsPqDlhbtJNkaZM+jWWupb7A+Rbn4WcJ3bqFSLGayg+2xLLbLokNP+J/4T+YgckDdHCsDM9C61/7Y/ZxEet0oMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pr7732gp; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqcWHa5QuTG6WUarNw2AX1L6ucikY7MKB22e6UucUy1ck3XBbxsp+SOoK6oP+fuzYODsMS/03piJQ0BIdvXAPh3Kd8mSrmLtbcFv0xLeVSLbfNKo7AXqlAcIdxurMJ/fG1vfErH/FtURxx21xbHvA6NUt2awu5+R45trOsRMOwCHBaZ193JgEyELcBvFk6I5eEz0k999i0dyXyRsOYefbwaHA4CepSq4S7hj6pWxHtwSnVEaECmOLGK/OZCyS+/mrQhUbsKlqeKwn1ekCoiz/skASZYeBVJnbdXGSKsYRpnE23+AvAJlNRoqOEQ2fYFOP2BmKT6U4PNmsQ1m+ovi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV+SA1Xp5AypdL225YjhknJOBbrUROgwyl/V033Cv3o=;
 b=fGUs9Pz91NbMCj84SKpC/A2mte+EQwV0ZwDuAoKiLedEvEE7t9icLHl76pBYSj4v7G/honfofy63P/5cYER/UsD4z37BDtAy/8eKoCq3aX4cjAS586z1+Uig1d9QptvkKKHddn7cooE+3YYLDqt7VuukWWWh7HEEkUSZAZRtOpDMa3LH6GONqqisrDHwklH1ELaeeRalyfyfMwVH2xy66BoBYZe0/fREj6Ca7hkrSJmVH1FESFqz+1kkluk4fSrBBXd01hvcxuL4nAetK60V0L/c+YRW00Y5E1gEOvMnR/DzjeXBwzKQ4C9DW9/fbHpuXrNMaJ21RRjjvxEmSWrO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV+SA1Xp5AypdL225YjhknJOBbrUROgwyl/V033Cv3o=;
 b=Pr7732gpPFalRCzpIpEOP5rUKot3W7XEP4tXjC7XlDr8gzZyRaOiXEOmx1WsjUsF7QBOz4Od7uq2sX3VMnr496MAEwuitOCy5+HHinVf/H5m5HueI/GVIZ4w7qMpm16iLpu3AQG79+r3Nb7vh3Q2JPQyBKVkGQqzeV48/ZKHzg0=
Received: from BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37) by
 BN7PPFABD533732.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:32:10 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::3f) by BYAPR01CA0060.outlook.office365.com
 (2603:10b6:a03:94::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:38 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v24 08/11] cxl: Export function for unwinding cxl by accelerators
Date: Mon, 23 Mar 2026 11:31:14 +0000
Message-ID: <20260323113117.2352709-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: ed79eea3-b765-46c5-ba62-08de88cfd26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	86BX+q6Ihw7u3mxTaYWNhOsldRegbeUWFX3V5gM/bfDzMf1tt2SPccQQFIFoIvytae0Ibyu4rbiNo6SO//dyKfFbPsutylM4m4k1F5/JBmPA8LV856wCR0wP4Lo4tyxwhph7M8kX41k7RfIb+meh2mXCRM1YkYojpLzIfElP6lX/uZ18DawrdrVF0SO8+b/DRdfXgoYF+sal6CDiex5U0c8wFTTRoB56fex3uD9JiuaJxCefQ/ejdTzp2Op64CT7QDb3BNUKPJ0a7PDgFP+yQX2CaH/bcPsvrgAImZEfsB+W0D3uLPXnKqFtMXbhz612tqT/JLmhJo6TpBP20mW8xeJH4dazNmhDmCqPIHQi0lqUXb+POWR3pst/RQhYQG1rrO8b0ZchqqjuLOTEMe+VILvL8c1lSHhI4JhRgJ0UrWZHGG+oPdFRQYFpc0dsBNWcqGc0RZNaAntTmlIHcf4Wh9XWexEI1kINi5632JyZX+jFsVw7S7HjDOVKWD6CUGGaYJxx/09Wlci+bZ7OeZf/T6zAEhQk7eI5k2vQ3vmFPRge0voY/P27CtrrjSzB2Ge/tZBYYvvQCUiiPzRrZfuYSD4zioEUNDFmHspDzQfubOPco9ZJ2KCrFJE5IbxyCHKSDWKTviXxWUaoFK8g8A5agTK8wicJeEgi/Tr/oIjd0y8KI/rPQwIN1r4qOCjU4h5QzQGuHcuwtQR1ONKuHa1/eoNYOJfQugIA/mQbvQXkJuNtebfyFiUQj2biyYgwhgbQ0jDv7d1feI3TdFlx750wjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DZ9Wnn61p8/PRQPBinOWthPUmV1VxTGWllWMKEw8HJ6VhwmXzUFPoXaLQcoKjB2pNjPz+RCdFxtWsHyQDLK3bq8LlRUYtfhm9tQt9CsY9UiHVI7Jr43MYlKkRRjRujok/swmuVizqjXN4I15epUtWAOrmFonI3BlUknFjVHR45t6JVTFen1PQgfijMC9+T1taucxlbfgnK87g8s6JWFjjvDAnpbvCzl1ah7pDtjESCG2oWXtOXNBLSoLJFZbiSV/kFp/PBMOGpF0HBra0Tb5vMbYQ03nWh25/kmhYSB7/FKCwemqLTePv+k94xkB2j03G702Pkh+qK01VG5chIDTqE7vC0B5cdelwl82tWdcGGD9/dQoLnR+D3buzjo+zWYBKGs6tUAuM2LNKh1fsIFDzxjPA2xas1BeidIkIbbwu6J+V8OEhDx27XkXpJwWgYkE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:10.2175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed79eea3-b765-46c5-ba62-08de88cfd26e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270489-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 247E62F1438
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Add cxl_unregister_region() to the accelerator driver API
for a clean exit.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 17 ++++++++++++-----
 include/cxl/cxl.h         |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9c3ba911d865..8bb53a095290 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2468,9 +2468,8 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }
 
-static void unregister_region(void *_cxlr)
+void cxl_unregister_region(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = _cxlr;
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
@@ -2489,6 +2488,14 @@ static void unregister_region(void *_cxlr)
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");
+
+static void __unregister_region(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+
+	return cxl_unregister_region(cxlr);
+}
 
 static struct lock_class_key cxl_region_key;
 
@@ -2642,7 +2649,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
+	rc = devm_add_action_or_reset(port->uport_dev, __unregister_region, cxlr);
 	if (rc)
 		return ERR_PTR(rc);
 
@@ -2797,7 +2804,7 @@ static ssize_t delete_region_store(struct device *dev,
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	devm_release_action(port->uport_dev, __unregister_region, cxlr);
 	put_device(&cxlr->dev);
 
 	return len;
@@ -3963,7 +3970,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = __construct_region(cxlr, ctx);
 	if (rc) {
-		devm_release_action(port->uport_dev, unregister_region, cxlr);
+		devm_release_action(port->uport_dev, __unregister_region, cxlr);
 		return ERR_PTR(rc);
 	}
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 122b3331469d..b8cdc604480a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -236,4 +236,5 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
 						       struct cxl_region **cxlr);
 struct range;
 int cxl_get_region_range(struct cxl_region *region, struct range *range);
+void cxl_unregister_region(struct cxl_region *cxlr);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


