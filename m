Return-Path: <netdev+bounces-270491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EABDKscnwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:45:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386B2F1659
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B2230363A0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDFA33FE15;
	Mon, 23 Mar 2026 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bOrg6LAI"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17139526D;
	Mon, 23 Mar 2026 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265614; cv=fail; b=YGoi2eo8Tqyf34P8q0SzkaAOIaFIoWNfN9Eje7T/yG5WNEOJmC3UpMHp/dJPX5M3++Fs2UNLXMm51jUKoRJVENxKObaGFIvaHmdX7/2WPnNFbXzT2yBrm3Y31Iibn1xyvpwIvSPoxTYTgcltKm+DMy+ldXzPCNvoV8W3/8cbqOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265614; c=relaxed/simple;
	bh=MVJJ8hD++pFynZVdnQvyJ5T6vqOQsUo4UFyCwpnFT5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDEY+cprmSt25yPxkf6nKjVsgxI2SrcJofTwjn54+1aayc5kLFbdUXVbVpSQkLHnciJpAfdEAXNkmI11jL/UspnAfbL1DsktZY1/yb7ebzj1Qzed9XhepMy1DlliTLC5FBHw24ccN5tcQq0Mg2A9gjrS0w5Crv5Awc1fjseeN4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bOrg6LAI; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqnfLxnCHP6hDfy7//0nmsk+1aT2tQ3lw7sxbwRFjtko3DQ6u3hKkZbUSOERcN9jdip/3rsXv2x20tJfDdd9t9nzNAqY+EfGcD/i6PDfwEjeqZw02MjRdPXe5M2DH5GBeKH6zdmyZmoLuPUgXdVB8KmFFCPJcZRJThYW9/sjlwnmppumPxgTYTGhwqD+pZmlZOxC4mgzjFFwRuyhUlONxb0QgOhJs32Ez4EJW00g3VQAgm/dyElSJPWOLl9jGDsqnP6pGxc12oFEu+4gck/zp1j+7tm8LLIxqWFLK8ppm1++ZayOJwwfuUwR2QktKX8QA5pBGInsJlB2yUguKK56Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7+Ksv4D6H8UyiXyqrgfGQ62IlygufAvOYQj2dErJCE=;
 b=CC9Cs2KUlKa+GZ4gWf8NLcu45XGjkeNEJI4Rzf1hY7yudL8wdxRVG9/VL3ETitX9W4vcE5SIN79m6Wkkx4w511N/HuBTZ+wE9pVE3yo4QRRvAAZ/ZHVIg7yCEYBT1Y0uEtDq0cOTK/7/3Rwf6CbZFyjuVoKx07glAnw59xdVOe+LFpkumJzPiQThHkZwZwlUse67+DfsX5vAzXgYQE2BiWVahuDc5kqVQWKShzr9F/HGtcGz9dOtIVhucxa2kF/CuDFgp+1yXT+sma/sHQJJ+dBizpGk7TrKJG9AnlJwGmgHXf4scAQI7xxxV8MAhpYtkm0vdIvCqV8ipwJV+5kaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7+Ksv4D6H8UyiXyqrgfGQ62IlygufAvOYQj2dErJCE=;
 b=bOrg6LAIwbUdSDzXjYRG/qsmMoxi/FFxMw1nq2Z4zXXAO4mQu7O0TX/QCjhVL9Xw44YpMoUlk+layg/r8Y/TtbJ1XkFw1O8LEWkAuWqRPi7Vrmn08tpHhnuhQovmIEjyL2qVvKjv2lOe6l+D0Lk/xeK4aONHneHt5fPSm3VTGgg=
Received: from SJ0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:33a::26)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:09 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5c) by SJ0PR03CA0021.outlook.office365.com
 (2603:10b6:a03:33a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 11:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:31:35 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:34 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v24 06/11] cxl/hdm: Add support for getting region from committed decoder
Date: Mon, 23 Mar 2026 11:31:12 +0000
Message-ID: <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a84adb0-a414-497b-e6ad-08de88cfd148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ob3djKts3PS31yGoqS6Uuu3XeyIVdW0Kzgr58BJn40sBwjbh/tKmc5cfLs+538YpsLCdBAiP6aacFWBXbomYCKmoj3Jqgpq+dJF3EkZu9GVSo/3dUgVaeupJ528JN9s0AYbBbeN4owCXBc+BC6OdjSo0nx5rHBnEFWXYqV+P3FCUdyKrFsBCTdgudZTtjdOKn+QhhLNke9YiR5CAKN/WnPgSiElOItHovYT6Degcek5FXQm7JlHxXE2FHY66Xn9UVTjyCnv0k4I0uIUynkGhKBXxHqCEJW//7m5CsDXYPooF9unsRRPGQDnocJHE+ZKa2FEjgWVboyi/Wid3HSHpJNX/v2H4itqQ6PnpK/rzMU2vyQcaiJUTXM6lR6SVFzl3jmyWB/5kBr+4fOO/w6ZDxHNLlQ6owirQS9x3DBMDifmdKFdIz9Ou/EPkKG8+rNRtatLtdOCFxwvsb06OyJfzp+XoWPhN9yUr6mM47xSaDH5YQv9G2NUUKRm8wkckxuQ3OxgQdhVcIY9BfX56RnJUVhfDFXH8UAH4ggFRR5Rfrr7ImdTeTx962YvivNg8sjGf78tUcZo0PzbuMYUTXHhibedJBUMasuFqVKeuX3SFiYq8hRJ/Ppm5P1C3IIdko2S14M7WXvHheU4Q8eLqMmB2J2q128C9767OUjY/2i6PPjQoMTuhikzKK7j7a5hqJSfrOxOC5hjtk7PV+yKO6hLG6ZcB6eHPZsjal1Sp436Ji7yKdWFWocetNPSkRRpZGqSVlmYML63J5oFmKrI/RqnqHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c1gJ3qlNjbRloUSxX27320jHJjWFGMC9CdB0WxWuCE4yk0uYoppgYqcei7CPu3TrteAdZRQQhctdOdxYFkTeuFPWTyPr9l5EG5cEUObzxMMkEEWZn4DlqaBe4zpss4dfHmxzzq6vftGEOIzJajabzn9c+BGNhNaeetJ+85EayQRPrXRHYu35vWz+Ov93X/8pt4seGJEzzGlPC4hbQEyfPm1JhSTgoTG+uGlvukgUKTfZi70mwr3FxKoMhagDgGnZOsH8ZzsS41yTI+tEPqF2pGz6fvAX0dRqg7h9lD8tcWNLYCOaCXIdUPqQ+xx2q4KYUt96WNAF8IW1mrXEKkuRlzz0X9hCNEX3ZgbXLgKgieZw9iZUWq1OntONTFUmUUTukSp9VMMSPx4Xr8ACAqI1M+OL35ZCDP3V2QP3TvYmbZvW40Nrezd4m3Aaj2ueqBuS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:08.2924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a84adb0-a414-497b-e6ad-08de88cfd148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270491-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1386B2F1659
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

A Type2 device configured by the BIOS can already have its HDM
committed. Add a cxl_get_committed_decoder() function for cheking
so after memdev creation. A CXL region should have been created
during memdev initialization, therefore a Type2 driver can ask for
such a region for working with the HPA. If the HDM is not committed,
a Type2 driver will create the region after obtaining proper HPA
and DPA space.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c222e98ae736..006be88efaa5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_committed_endpoint_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	port = cxled_to_port(cxled);
+
+	return cxled->cxld.id == port->hdm_end;
+}
+
+struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
+						       struct cxl_region **cxlr)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct device *cxled_dev;
+
+	if (!endpoint)
+		return NULL;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	cxled_dev = device_find_child(&endpoint->dev, NULL,
+				      find_committed_endpoint_decoder);
+
+	if (!cxled_dev)
+		return NULL;
+
+	cxled = to_cxl_endpoint_decoder(cxled_dev);
+	*cxlr = cxled->cxld.region;
+
+	put_device(cxled_dev);
+	return cxled;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 10a9b8fa2f6b..2a61138e2a73 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -231,4 +231,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_attach *attach);
+struct cxl_region;
+struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
+						       struct cxl_region **cxlr);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


