Return-Path: <netdev+bounces-273229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP22OqONymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:50:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 610B535D28F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D48330D442C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054E30E838;
	Mon, 30 Mar 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vMjO7vXQ"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0B30B53E;
	Mon, 30 Mar 2026 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881539; cv=fail; b=R9q1n0Hn+z0tQyQ7gDlV8TaXbliEM4gq1G97sBnHXUjECYQkQrboE7lYU32bCNjLvsV+KjO+wmsT4KhPUlFUS9l20K/JKFfYcr7Cst9+yFUH+vtm8iNvGu5MKW56nTAXRo9WEhVc7xltHbjnGWkoIiPjCq4Sub4EWmuOp6+annE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881539; c=relaxed/simple;
	bh=bt/ytLb9WTtbn9VusYI3mpIdqCO+bYRWYg1WpjWKODw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4qYgAA46zOV642mbvLZNEZByq+VJefMEFxyWHsp2YA27WhI5njPq1FxSOG6fxdC8puWtqCAfcZPuv0Kk4KxFny4mlkz4scdeNQtAuqlqFFRrwX00YxRFQY2SkSO4A2wrK6uA98hTDJRZKLyvQPYy4YSZuWBzlBL9i7Ya6n9Eo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vMjO7vXQ; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhYI4ZraiAZCJpgTd5YaiA5eqfz4AYU5CcYclmmg1YslRhFevurDyyMHtH3zCc6Dk1b6MSju3HqPWX2R81u6gLjac5PNEnLhoxSEnaWtoquXFC0fabDJndgP+eJ3W5bQjyScGLg9Iv239mVQPLj0igjw1SL2x6cHoelmQxhrwB2xoNN6EeO0wajeqov4tDHgrXU/8027Vg02s28UgEtUTAxeG32vMgHr9cCd7grvJFQOtPORQMzuJTLfScVe/hA9ARo3v9/lgpJO/FDxnxEDonokBgy+3hTWN2jYVrKRhKf1z14EpuoLJkFPabnEyVvi3aqK1ZcOoidfrQxDrWLw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WPZAxwqWgcSoD9+IFvYyBQz/RG5Gh11ah9pt9JT9Zo=;
 b=CfKoEga0V0ei4pLhZXQAox8o62TKYU7Gzp9J6HXEDbLp9aaOXbUwisiTYt6YlqvpPC5j0YOVcVWbq3hMRFG3RnPOfmRlel59/6BVBCRG/R3ndD+VlGGJypxnSquAblgo7yzTYRqazSvq182gnr6MaMG1pPIouV716+1k8qWFWLqacWgCyYgfov8RREuu8l6oZuANWgs7SZvSJjiqOOAyHNdOCz2txnOoBJ1ZE7W5VvBAD7cKX8fwqVeUQZSX56UUfWiTaep8yVGNh0aCXqvw5u8KFb2V6TUHLTwcxtQVRkw4xBFfxk2Hd6yNWHUfYTVfCjM3b8+ClVM44Rqc1w8eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WPZAxwqWgcSoD9+IFvYyBQz/RG5Gh11ah9pt9JT9Zo=;
 b=vMjO7vXQQOr3dXYbdo8PTvaONo6XYmMCnkVI60+MeK4umCj8pv2i6C+h8MTRNDWEf8EmfaM+E5bL6wlYQVh4bUbMEeQOqxs/0v2K3kl9FFe0t7EyIIDlHztokIaQwH84vNh/5P1ynZhJxCEmcgSX6hLmEm1Z7md7S7BT9KSTxZI=
Received: from BY5PR17CA0013.namprd17.prod.outlook.com (2603:10b6:a03:1b8::26)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:38:53 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::6d) by BY5PR17CA0013.outlook.office365.com
 (2603:10b6:a03:1b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:38:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 07:38:49 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 30 Mar 2026 09:38:48 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v25 09/11] sfc: obtain decoder and region if committed by firmware
Date: Mon, 30 Mar 2026 15:38:25 +0100
Message-ID: <20260330143827.1278677-10-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cc748c-2f2b-48bc-a491-08de8e6a10c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KOfQm4vBsN3o76BAX+jew8+fdbQ5PWlmxzlK2rU5mBKh2s5z6DcE3Ll0SjzxCDnxDvbJnGt/iPpHOjjgPs6RhD1hVQuWgHrqMIuGBEoPxYE7tCYWpwYi0r1bSUU2xzWspTykpfvcaJhXV5X7vLW97L16BZCVjPXWg9YtY8swonmU8zmX8TipP8P+y/oZe+18xnsT802s6vYaN6VNJpmM3w2Lmw7l6dpFmdL3hmSx4V8qzrENZmUdPLqyV+mMxEv9UDBADCEfiO5SiapdFwg9DL6HhcpRDj7kVT9ObtQhi4tFY8hfo6FubDaiPiFt/MlQStXRjjHWWzlHHJ3zy6MMEJ3UIeNgCAaj2m31jTWakzztQgthGlzsRVmC5J3fq5Z13+gSJPTC0GhApMpALAR0N3MvYl0H4XtM6tw6B2/Lz6MjpyDfSpyLd26/GNuncCPzb2WCW4c9UMQVv8C/qDgpU5nwzF37Y5NmBfqWObVgemwOvTbkfLXmA5gQvHJsM14ANEbGMI3paUc2A6xfqTxSU9yMeFERNu6mWov8Qpi+XaO2Z7L6xFeyL4v0CZYORGJFZPnVpESIbefUM4CkhSboC/vw5pAoVIZgfP/lR+D2yXjpvAR8k1xAzFv958/is8A6rE7KVlv5HOhYsdrf33PKPE2khxGPQGogwED4EPbWC93k2coo3+nUKx5FLWGxPi+Jbemr98IMkOzIPgfLIQt4sDhueoS47/YZpc574s205evk20VLu9xoAakKvFFbnYcyTSDHUMwMhN3e2gXZ9P+B3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r7Rfl0gtHehI757u6SyVfFTFoZYl8A4TL8wGPio4fnypJUIZmBljI0eV+hZ0pXQdhpQm2b9ME6jNBB6nJTr1bdHS10SzUzoQx0a7psLi8Tne05X1rL05UD0xpjLRY7UmKRB9p1pxcbmk10ZAYyE3b6RoDIXA6CzSouFBdlZldw+c9MLO5GRC58dadPTu/VgurwcV2pyl8vAXjo3+Q00I7vllHLgxdP453QjSm9ExWMLCDhd3YA7SILTlw5CqkI5IXggmwLEyyE2/8kWHeoXECCr65dUUWowsGSRr7wfFbeHc+4yMYFBwopQuqftA8IpI5QqNhLgSd6kX76BdfOe1/8T7wBkghr0Dc3BkukITmX7Mp4DuLip0uNyIHRugmhWC0lhe968qLGiWlplATtniJ2kaa+djp7Se+qazQgcDLf+gCHxbYOJIaUo2JdjMQNHp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:38:53.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cc748c-2f2b-48bc-a491-08de8e6a10c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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
	FREEMAIL_CC(0.00)[amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 610B535D28F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Check if device HDM is already committed during firmware/BIOS
initialization.

A CXL region should exist if so after memdev allocation/initialization.
Get HPA from region and map it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 63e6f277ae9f..f3bcae22d1dd 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -81,6 +82,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	cxl->efx_region = cxl_get_region_from_committed_decoder(cxl->cxlmd);
+	if (!cxl->efx_region)
+		return -ENODEV;
+
+	rc = cxl_get_region_range(cxl->efx_region, &range);
+	if (rc) {
+		pci_err(pci_dev,
+			"CXL getting regions params from a committed decoder failed");
+		return rc;
+	}
+
+	cxl->ctpio_cxl = ioremap(range.start, range_len(&range));
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
+		return -ENOMEM;
+	}
+
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -88,6 +107,17 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (!probe_data->cxl)
+		return;
+
+	iounmap(probe_data->cxl->ctpio_cxl);
+
+	/* If the sfc cxl initialization was successful, it implies the
+	 * endpoint decoder had an auto discover region which is the one
+	 * we used and we need to remove now. Otherwise the region will
+	 * be around until the root port is removed.
+	 */
+	cxl_unregister_region(probe_data->cxl->efx_region);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


