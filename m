Return-Path: <netdev+bounces-273231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJNJODKOymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:52:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80F35D329
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDFB03178F24
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB52EA73D;
	Mon, 30 Mar 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nyQqG3BC"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2F3064B2;
	Mon, 30 Mar 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881610; cv=fail; b=ObV3ncGovjPLMQvg6Ilu8jnH+iTeopMSfL7E8unnhyHtgkeb6q+dtHzZ5FcAYwGQrpfetbmoY2wG9ANYzFAdAkJZWNahLM7oCeCXn6+r+cnJgdOU41KIpl04TSCWSaKpO6j3HpJ3xSYb2QGwD51bUJRgKPk+KyhTVQ+0cTI2UR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881610; c=relaxed/simple;
	bh=n2cmnuTQ+yz++CtpJpO8BX39V+lBhGTvJiKqvgx5yvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMoMViXmqLYZ5UfsGCjjFxaUBO2e0YUBn1+IiBOXGNYecY5kliRaS67qM7v8OV7echavGbV5Yyo4e/lWY66cErZi5ylFIj7qC3U98GQPSBcXIDeVrZV38TpAf75QV4NBAuaiVfmchw6wfQDhGTdXLKk/mejEcrqfhayXM1EoqIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nyQqG3BC; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEU5ZSN6Q+LhIRg/OdQJ5VwQSAtwuqSoZRDOsBP6L5AqMsg2yLl7SC1dNqRQFSVXxzsZ+oe0dKevV17pp3yDNfAHHO14a/QNox8sjz7O28U3X7fAZGPQElFSdScYLCMNAHzDiy1IpTJMpXLRkwyD4JfzjN2P2rh9evrVe4qk9XG2gHCVs/ePJGQFZIAm4YYilQ7N+ij37vElkubXFMTLIenz3ajDqNiKUuoHZrCJmOEzE1Sls5/VMGtrSOT+GB17AcW/sqAJf1Db8Awa0nFdEFVM8sxb88Aqk/KAHOOozcjCKWsRwP79gQOPhzWcdOYzXARNJK/91RNAQETBA/nUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9H3EhRQtJVCBMhFlVrWI9aHccOgPy8Cie+m5jIEdbg=;
 b=iG3ZGpZ25wMfAANpt8wsQmN8bgLsbIoc2hJM7n3aZSS/MrMfh5ccsaFJzcIuv4ad2trc4Bpqnf+4X+A6o4IbhXug6Iuj0JsJgNT/TBphiMmu7I2WKKeXZmkdEADc2s+HG7vFLz21emAEOvEHsWpprHRprxnH9gl6nelOBdZ9punlWQ55RXBkyif58akiYyKRwwurSj1wbnkgWPA6iQOoZ7fqNrfzEx2IoGntqVIHaeM7erqkJw0n1VWQ0auady74K8H4H/nIxLZhqO+v8MJr/qu8RyLMMmAMTpBoc3flCVOkI94yCDsRgB+1XebWwOt1dx5FQArjYgPQO37Ii/MoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9H3EhRQtJVCBMhFlVrWI9aHccOgPy8Cie+m5jIEdbg=;
 b=nyQqG3BCYJI+zlWRWGoKTgLQSOgfKcPptibUPtv1/J2Es36ae4k5heAR7c9m/Umsp6SmTT6QxyPzeozEHSX7Fo4XL4TeJeU6ooKIx3aF415/yXjDFMwcEnW57+xcDkJssfxe67AOuaB/cfr7E5PV861yxUW0DCEY6OK6GaYI4YQ=
Received: from BY5PR17CA0033.namprd17.prod.outlook.com (2603:10b6:a03:1b8::46)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:38:51 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::7d) by BY5PR17CA0033.outlook.office365.com
 (2603:10b6:a03:1b8::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:38:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 07:38:47 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 30 Mar 2026 09:38:46 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v25 08/11] cxl: Export function for unwinding cxl by accelerators
Date: Mon, 30 Mar 2026 15:38:24 +0100
Message-ID: <20260330143827.1278677-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 926858de-7ecd-4c82-757d-08de8e6a0f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tkxseo//PoWPzmijVtAcCP5XIVYIQ/GoSeA0R4RUW/vN31iUaCgfn/m7HfUlXRdVtAC+tbOsDO3XbuYSL5bvGcanV0CyjFksoScm4mcTKXMpdMCO4AKeELihuiylB+eOzi9tbMudVDd9YRgRLOgGuc62zuJZD2z+BLnNhD1d9uuCWqwELwoURzHPl9+CKbpdh7JwwMtclVEWG/FXMFAj8BWJw65p7B4JMsDU60a4HRlmpTIhryyjndMBHY5xWQrV+1M2TaQYLoUVfRZvEeBYHuTM30JWpkh0ARnWVw5O0/0b/n6s8v0YcbM8oPxh6MR5lucADxMWoqGiVyHdJ2r2c7o8V0d1D4WeVfhW+59blM9FrANGDrSHROb/0hQ40Urd++LZEzYYl9qRULEHdqFpVukZ60TzbeoFUJhEr/6cHAPism68/PZJlfI6UIfin1sgCPGp7SSNVac+riiflTLgxH+ze3H43BLW8dmgud0O6MBfa2PsVGt3cnqEPXKkG1P2EnMGQ3t+2JIH34YmQIt6T5gXDoe0SGCE/DRnIlm7OlWt0cWbhRa0fgmWz2ie34mCQtko44rdOWaGlm6tvrcqYDrjfXKn/+Fc8GLGehyLJMj3hE1zSsuFf6t2ZNjWcU+Gs0yVyByF+fZOzKvGsEkQ2a3kOgQt5zSwCgtKQcQDJVXcvI1qo855z+vxvgB/wLvyAc8/jZP6EoU7dl6b0hAvh0jFcJyFMH9T8PKf+D8+dG1u09Q6ITJPJNAsGF5Qy5d+9hD4ltfoGNoq/FDx7kY/uw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fsuadvH1xLlaDapmpG40WZelCgqraAO3vWT5eCKHe2exrRU7qUbBNh46CW6hYoy6aQn9akmKlZLdhp+Gvzya3BOL7Y0ItAWdofsquJ3b9Q7huAwmukDPogG9k+3Z+5oXpdMz1uw6xv2PaZHhueWU6l7IJIfZUgJg6UksEX1yYTYCGxZxCq+xjhG4QuEdkWXmGZKstslAS9et/MHuTGpX/0Xo/P75iPOgfjirB+ws3Sii9ahATtQTeuZr8RSc1/RlIgU54aP9aIiRRUxpKej/je2/M8qI1GD4kURz24NlkHy8FscUyzcouRggp1h5MpcOucdak2nQtz9XJtCjvGSMbJ2IjXuMEIJkBMYHV7FhVsyXjzHC8IqOJ9Qk805GXe+lsIQeu/3WtaR3jf46PVrkNrOXtTUMJluIdIpZUGmR4jNA6BU+h6SM1ojofxxclQXu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:38:50.7347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926858de-7ecd-4c82-757d-08de8e6a0f5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273231-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5F80F35D329
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Add cxl_unregister_region() to the accelerator driver API
for a clean exit.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 8 ++++++++
 include/cxl/cxl.h         | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9c3ba911d865..b3a6d08be461 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2490,6 +2490,14 @@ static void unregister_region(void *_cxlr)
 	put_device(&cxlr->dev);
 }
 
+void cxl_unregister_region(struct cxl_region *cxlr)
+{
+	struct cxl_port *port = to_cxl_port(cxlr->cxlrd->cxlsd.cxld.dev.parent);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");
+
 static struct lock_class_key cxl_region_key;
 
 static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index aa3cf8509b41..e046c59904a5 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -235,4 +235,5 @@ struct cxl_region;
 struct cxl_region *cxl_get_region_from_committed_decoder(struct cxl_memdev *cxlmd);
 struct range;
 int cxl_get_region_range(struct cxl_region *region, struct range *range);
+void cxl_unregister_region(struct cxl_region *cxlr);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


