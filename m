Return-Path: <netdev+bounces-270488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGmeFEglwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:34:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F33C2F1479
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33EF33010808
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D85939098A;
	Mon, 23 Mar 2026 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dUHDmDfL"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301639479B;
	Mon, 23 Mar 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265536; cv=fail; b=ZieY02kf6xdN+YQBBk0Mqk+M+VhcFQrxErJfL4aTcfsKRX5FEMqYPzFpvYBU3AV+lnLE+y/zDtEe1HGQ29nlEX5UhpCWeSXvHkabN7E9z54TQ5gVEZZ5woThJctEwPUkCu2r8UVCpmnvHy/bFGkEUa4HAoWN/z7xsQRQPXp6GBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265536; c=relaxed/simple;
	bh=7qe96e5FCWLs1dD3e/D2QXaWAvDBRVFK2fiGx8FLpRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv3i1cpGX2nl4kkQ1KXplFb7LhWBDmvqWx5KNmLwlazgJGuS0FC+v1i5+JsVunNqPGeLsrldiW1Q3ZhZuhXdNsfSFNRl4uThRXeDqtgH39OESwRyhfxFQ0/GLtJwDTYe71e//kAE70bH6jQhzwONuWBI/ra4eomBIzqyODNwPGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dUHDmDfL; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlZD9QeloQyTPQ52PB4LhUNCQjq1vxVkGypG+XnoVy/dOaFkJLfchvjFZ6EeFynFbY5m1e4p6uPFrVnSGVREVlERm9HXi0CP/nceMlXMvtHelkRMtU5yE1DKaruYVTty0Owc7B2AEvqitYe0cGhwBHZGulrmtZng9a5JJjnlBvBSH+hLinfdLlJyQgmxALYRRCTcIRundkkex0HgOkYvSlGrKPRhSQynbkUA8qUVa9Mnrd2vY+HQKeZlrNwk9QWbAyV5IKH9gQb/qp86dekpMZI3vf04B7POQjB8s1HkQC8fZ6WTbn2xguJ5V766LK2FLYRjj04/qzXxtyekBHswMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8/PnXqdhK/e1Go8HPhs8IfnZMeJv7DtrdHQg+oUlfk=;
 b=qZz61dWM7sGk0qdNLmTzQE1lcCGpLe9e8yupEZRB6sjuMubuw6CH00f1JJBgeqHwHX4Adg25Lxjmh7wBCORSwSsUI8YQKU7XJAHsa5+/Ap6OM8rs0HueUTqFcer/U8UnjvGsa+BUNAV8qAgxWrBZTVJUgv2XMyceQtVVIBgkIEdei84RyPOs8eygyFhXtnj5cp9VvtQr/h2qiMoNLCTAzY1wxXjHVoapIMblEJaiNPLidEaMPVIj0LFodX+eJUEQt3SoP9YPCVV8l7UmM4/eaKvtavKIJJ/C3pgEGnPSKY3Am7AxRvAKqzmSdudo03O7z06F5ccsWrQLFjz4VT4mxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8/PnXqdhK/e1Go8HPhs8IfnZMeJv7DtrdHQg+oUlfk=;
 b=dUHDmDfLzTIFHZncR3kmgtUIvRx9aZ7nMZ04k1q2Ye6dYg0VokB4xG22ViOq+toR2NbzkOq8FZLeQn/S+7TJSxvzHgzRw1D7acyoerhLouB148TpOyzMVxR4WYMawo/TyThUIa3K/qZnLDbsYsELiYhDdTdVwGk8fxzsQozPvBA=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:12 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::c3) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
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
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:31:39 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:38 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v24 09/11] sfc: obtain decoder and region if committed by firmware
Date: Mon, 23 Mar 2026 11:31:15 +0000
Message-ID: <20260323113117.2352709-10-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d08163-a9b4-48b0-4afb-08de88cfd31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Zk59pO6w13gevVfZqgl/zS0jz4bkDk42JkVpMK+ZUhyA7FvJJjrjbW6I7jxHBaCqoj9pu5Qfruop/0oLIBqr+5ri/gbp1FbNWQd1IOoIt2CQQcASRu2JMyIsbC9djhttijtEzeWM1RfzugX9nsIgEld2u93fTC8qwBkWqNN3RWB7JUAGPOLeTfwFhChUCaIh9OgJKcDYUMm0DAXN803eJOUvpBFwHtsQEym0s1wyXyYb6D7y3f4hNNES9IXo/YwPklWl89NOnzn/H0vE9hCeSspr2G/XSc+6w7BnoOmGNTL/2rqq81yIm5hq0i45qk5ThO+yL2VRt8pURRrY2FEt5oLTYLEZP5HXxIVU6+VjpjvHOV14iP6mH/53IfdGFQkFI/bP+9Uz6Nt4X4hVgI4B6DP6QaHqbTN/BFaJR372Pq26dilxv5OhjieaTPzB7CMI7mlLhQ4qceTWbViC9X9qMo+aTms4v3Bp8ENRnEXd3wy1XncIRtbbDOhamLHK+qZAt6E7BhQYQZh4cpzrOT8OCX2cIi1skW9oBWcKjZm1in2mECFq3ACXTj3AJS7+8qWTvGhr5uXZr/Fvyoog2Cm6IgdkUWEhXGIcz6RXe7IlnG8A9NQVTPyLw2Enra7wDJPfwNXgqpQyfojub99P5njUfG/I0r1dzqzUc3QiuDX6LtGN6cJqFd4At5oKauBJpzD9fc55X2xTqtDuVyfyQAVoriRPlBMZi5mo1uKAxoLzeozJz/cB6ls4pR0O4bz7Y/8kU7CYDPh0p+Er8lixqWaUEw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r4ryO0QMx9i0td/Zra+PhCpzRlUiWJTu7C//shC9ay3uNaiYujddz8IiTS03P0eyMlhiKhr1l0xA2fMadGfSYC75apskIqRVHl85Dml/YUnmBbh6QBGQ6aT+27gDHfd6BxJ89cqJWEpprkv8uknv//kgpZFS5X+BYY/mjZJk96yotNx0BvfNj/tVZeFwdFKGwx40swXlzVYzi2zJ9VV8s5R7WKE22dqXMnii6DawdvJk/EOU3h3gtZ+gnm8SqY041AgD3Wceo0usxJELvMkJFufXIshQ64wBpJPi49vJBft0JCbi+gK2Uy3VMHKbNXThZ95l63HoB1md0nW/sL1Fkl4mzrHG4D+JbAtC4oYz+n/oNimbN092GeuDYYMZ3o9N5wb4tW/oix+bilzuy8OUrpx0Tt4PYTksu3dcPuzH3Kc79d4goAIkKKdRYurjrwe+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:11.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d08163-a9b4-48b0-4afb-08de88cfd31b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3F33C2F1479
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
 drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 22a7d1d95425..78f926300943 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -82,6 +83,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
+	if (!cxl->cxled || !cxl->efx_region)
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
@@ -89,6 +108,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (!probe_data->cxl)
+		return;
+
+	iounmap(probe_data->cxl->ctpio_cxl);
+	cxl_unregister_region(probe_data->cxl->efx_region);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


