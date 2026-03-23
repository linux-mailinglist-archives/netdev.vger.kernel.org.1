Return-Path: <netdev+bounces-270490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LyNKnsnwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:43:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA02F1604
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 513273078385
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD5399016;
	Mon, 23 Mar 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2IbX/MvF"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83539446F;
	Mon, 23 Mar 2026 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265538; cv=fail; b=T0qxiO27jx98+Bm9+t36mz8ZsIzuZgQbnyOIaPDTIyKOyXFK0wgHElRNHoruOEDVrfs9Pgolgx4E+0RZEFLI4WWimmwGa2zKMdOMtyNPKLdbaK2EiwJjHgFIDieJjKEDPb30Cvc7zpK70lvN3VWPDVTBQ7a/5XF4GnTxe2jxyJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265538; c=relaxed/simple;
	bh=5prFvKVsZ8e3ATrP3dD1c3lU2nPswq57OaNMIdzHw/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNvWfuJ43ZLTtJsHtcUHBdrF1tU0qU/woY5a8xEWGHNKQbpp57619HGx6ti/PXj9AyacxzFtgyQG0Mcr0Utm3nxTZAWPABkMuW0FYI60S2+YOpCRgOMe3NjSMQy00vkjfaJyrVHbdAMWKng+ZyhoCZf9EL58AUqJfiOFYjtSVTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2IbX/MvF; arc=fail smtp.client-ip=52.101.193.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXeaqpjbw3dcKCK57Vsbl3b4M/1odEWxNhpN2Cdt5aN7UaB1LXmdnXuNe2JWeA2CI0vHmoaoCzS3XWbZAYrh/zjTNo0MfxEW8a4rLqp5YFmUG9ohr85xfmHESxv3FbBeR+tmrlZoMdaNtQlY0g71dWeYP4mMNCOZOacsPlPv7UTTsuiZGalg0SRaPwVow3Ek4Jx1qLkyQznptEgzCspU7jdpEUCxwOr/i/mzdi4sZirDCIu7/gWH9P4cbmvsdraqbHHqygMRjI5NPssGZJ1kJUBHW8+SF0x3ulAlHaYgrZw/JiC/aoEiuTxa70t4CIQoj5XNwmCjNSQkJu7sn1lzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qay7wtCH0jZXivK4ixhEP4UeGe2P7TAwnb6KN3dxHEg=;
 b=RhmsZYRdP91WDtSOQPsw2sFOfkdXXWVztVE5/5SlefsQaW4imM0YaB4AMXU+/uXwL/Pmsuo5BNvy56a3c5JzwSNKdoVDW3qy9qNUMw19ilEHoxnw0aacs1oIZNoQrvU0Ro4g+ZIVEDR2elX21AEUPtsPR2ETpjdXaXpDxWlpEKaAufp475iIxUORnBjxnZJG89/RCF9TwYHTv/8TZE3mV+Uwbo8PXd3gg6SloC+JU5dghMwi/Lvg7tDY3rWMOjIoMkyuzeprxqGrhs0Nj6x1352UwOHmNlJgU/u3ca8qyPCtsT7vSOHCoVJCrwN1wh6x1P75+CWknwGzbqlQE1yKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qay7wtCH0jZXivK4ixhEP4UeGe2P7TAwnb6KN3dxHEg=;
 b=2IbX/MvFkPwD3Ky/aVd+ZoOLIxNRklTyeh1G1kWIMn30nREel4EMCcrSN3xQyYgfKtJqzo5i2mwgsknRAAr3OUOWlHfEa/zkrxk8WhnZpDmRFJKahm/ZDgOw6YFJN/4Sa5SiKtHvReu7p58jGY0og1OENQkckmDF7dz9EoA2Tj8=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 11:32:12 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::f1) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 11:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:41 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:39 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: [PATCH v24 10/11] cxl: Avoid dax creation for accelerators
Date: Mon, 23 Mar 2026 11:31:16 +0000
Message-ID: <20260323113117.2352709-11-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 329f4483-fd78-411e-0a56-08de88cfd3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2eNwr1kUJuUdI6p15tCZoGuTxs6aWuOY96mHM+JputvDDTfd6Fttn6w5c0/A5CAFl8PSCclowXlektggToEQRztbUDEwi7WTHYPykfRXO+Hfj7bA8lrW7Yr0fb5dU4ESxYaxNF64cIDQYdSmmqWREj7wKHXsq0EBM2I+WON3aM7GJs49EwVZUK1nTv69aLZzAObxlqMw3i7uZcGewVA7LE4Ffz5R5o4+iz2UapwX+rM7RTgCIoDpy2DSpwp5K/+7AxdwWPvVzguxalLdekcu0MgBOkUc0dk6kpeadtyk0/BpKfblYIjrQJ9WeQujZklFAbenHxRPNSXEBZGqoyoKWVmm9vHpYUiiNtFcmboQEjjo+bIVHgJylbVgeeLLCHIzM9bOGmOKxFk13A7R6feDYM5venvm9oyqOoQ/t/ZlJroBiNrWksuvp4C7ExcIbyXxk7YVOUnXDpfDMsWF3ChrdUAWK4puGxb4DbyC0FxoUVM61/za44f88UnvGe1C1hb0FB12do0SItAMsujndOYRjQrec5S2+CdgBaY+cUIcHnyINs2Y9Qm94Rwg7Lq9QgDql8xscov2WP8J9pwDOb+Mc1UzAfCMM3F1GhRdp7wmaIfvW6y7jj088SfH1hlh2fOb2x0yRrsd67sSx0LCX6u/GD1/x8LeE8z+AnfTfii4VFyJD8/HFH8vL11vkIJnD3R9oSTdsrII9wsNW+/4JheyqSPjMby4XZVgG9DSg+HSXhtvakYF4m5KHfyUb9L0nWec0BwL1rPeOt3rccLs874RXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ki1xkTRHXSSkvRg+BA7NSwkPhTDP8ZDT/x3PmJMYS1DgGWfpOMjJwo7a8FgOuZIeG/jvYpvHybpz5Zq7vwUnmIpjmlHcKO/dxeDkuhr0C0yfdZMTonft10uoRgk8d/RaLEHzfgCfgVwUIJmU/2gjgPVcaIZz+//hMsRFB/HodmUYJpUIUvUsngGrpp3y3UawUWRSjRLqPIdIv3SoCbkPD4PLmkNvkIOx5JlM2nXvoTRE/vMndWkpkrMmK7DmUslBDlTxxGH0TTCmhQ28vP06PS/4x4eX9gSUd0eITB1GrFKp3oalp3t55QK4VvdOU/tKyBOaSnmvSAtmQyj7o2VZCjkfE7gLbPVuNyU8Xk1kwTurQ7nmMjFfnH2h2rmcEeWLO8QN1sw7/dzUsK/U/kl5GlTRPDUz5PIzsAPBkyX1Ow+QkGuMlr3O3lE8wTDaujZh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:12.4675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329f4483-fd78-411e-0a56-08de88cfd3ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-270490-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid,intel.com:email,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 10BA02F1604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8bb53a095290..2f9bdb4f1f4f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4263,6 +4263,13 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	/*
+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
+	 * Skip device-dax registration.
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM)
+		return 0;
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
-- 
2.34.1


