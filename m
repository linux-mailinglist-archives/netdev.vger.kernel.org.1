Return-Path: <netdev+bounces-273227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGWKHGWRymma+AUAu9opvQ
	(envelope-from <netdev+bounces-273227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:06:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958E835D720
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9738308D3FD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6530AABE;
	Mon, 30 Mar 2026 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eiYSlDfL"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088CB19CCF5;
	Mon, 30 Mar 2026 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881537; cv=fail; b=TXu1uqBtLQp+ykijUkdajriF0HbULjLL0ArXNoNqyw9T0QYvCVhEIiiYU+HLW+PnM5sZwmaxQ16vSolSxEcN8PCGMA0/wU/uRFgvC32//XZ7NqXsOTDezOM02B0dnrwzOfe23r0c5AuBHv/Nordl4gsnqS+1YmtczA8JWpg6jqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881537; c=relaxed/simple;
	bh=iedrUsfGGI2OYoUvej10hWretNEtFojJVMCzMXlgAcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ax1hp+0krOIMIq0hZ7HC7suodloktSKP+bGSMcTatAx7Jl2OImt3Zg5009YvwiEJHHbBz037J/aJqVHP3GAcPL8lvl6136tOefZQsp6CFABU/ZPdtaKviBwJMgdyyuX0OVApk63aQwavhojDi46Zhwkl2nOkSh5EzJzJP6+1gP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eiYSlDfL; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCZDX9qhpvf37JTz7w3tIv45WH8s/w9nMJgk+qLT4ipvArcnJv6YH0av86RgHssO18iM1Yi+cy6IXUSXWqLnDhWsLOHUirYS2ptdbVoYtb7ZtZRYCF8z+8WjFvzi5vEdqI3gcUPSs9CTuBEHrGGTQ3E871JdyBcZLw33GmIDfp0Malfiuyf30oFuOzKzN80S9QQbPNWof5qPrJhNF8nxaNZhHWAEAPbYdLuoh7LES4mKzuRWvSTTKJu3auyA/p37aHB6LzFTB+h73g1Sy6R/gjk7SMnmHqCxnecZsQvWc1FRc26JRZjEkdWs1gsPXFklEWQOZxml/ER5/63KY7Kl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzHshjvxsfdgpeT3QJX5aI+B7HUIpnFnaCeP1GBtplQ=;
 b=M/2m+Hv/RBhw6cTHkYRgYRfFDoUg/wvFmPrt1gTponXDz9XavQnvH7csfaI2cJcc36tiBxB1T45cD2H9iNvUp5+V8fe8b2HHtIysoGT8OoRgy2LT7ErioYovbl9rWHz26ZNceJbO/MA4YxKhd+pHI/um84TTeK4dML96ajN2V8wn1isrfvLM8F1huVwvOYRamHohASDe7eu9Buy4oms8M2UUBXQsqth9grBfYCq2qzgAvbPt6lvponiX4PTOWhSXXgB4TjaX7D8VvNICRjmsD5JdZbTSSUvt7w+HJNc/xGAWBOzaQSRehJO1rlGMRQaOgV0jQ+6Ji6k+Eh8LM9MlnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzHshjvxsfdgpeT3QJX5aI+B7HUIpnFnaCeP1GBtplQ=;
 b=eiYSlDfLprSe+Bu7kEMEOX9+C/SS21J+nliBgXKQTQTbtpKyOnd+ut3KGGLD4KHCgwnAE2oZigDl+/zd/Abw+RDDmW+DwHWWnS7mo24bkO4ykqEWsrwxueWtuy96rKH2a6noTdp1Gx3A4vOsbLlQSdCziSWwmq984j6NXNiKuNc=
Received: from CH2PR18CA0033.namprd18.prod.outlook.com (2603:10b6:610:55::13)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:38:51 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::d6) by CH2PR18CA0033.outlook.office365.com
 (2603:10b6:610:55::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:38:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:50 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 30 Mar 2026 09:38:49 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: [PATCH v25 10/11] cxl: Avoid dax creation for accelerators
Date: Mon, 30 Mar 2026 15:38:26 +0100
Message-ID: <20260330143827.1278677-11-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 71df897c-43a2-407d-89cc-08de8e6a0f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KDopWS/DMj0qizvXPQB7XB7GSYrZBugZTYg9RSZePpajbzhKHLaA1QpyBZLT1nkAiBeSEo4khyxz8RsuyMeFESYWtRIxHBV57xT4appWEsu5RXPPOKWhU7o55PmE1Ik5P3uYCvMHJw9g8vYuFt+R8pkDTIjkpju5lG3mIMqo23UJrwmBvXt6NLrnTGgvyHqT42NfOJtiYaingL7jqizc+BcYr+680pO44b5mVdET594doFhtaHhjV6yt23CMVrSSj3c0FrCTf/UuynVIKcDH4u+ORJJfUDKISsmZvYtSIA6kjS/PNRFaKq/Aw4lq2Nhw+zcsJbJ8mdYyznaRQZ1JQWeCOUDgKQi7997cmtgNQ67IyRicDVbuLEbIdrrCrXsmS65QhPrvddgY6FqpbDGXa7dWTrqP8Hwu/3RSC60LwOCfchZKyCcvLAOgdAp6NyAP0jh0HNQujKLdWmW5IslK6pD3I/ru42pT871rkihPksvq+e/9nbInB+m8ky3FF5bQDWbAODhzN/Xdn5yX9Pt/KFLYEWW9l6Uz1Oauv5CE7vneK2A5u0rXs+rkaq0f5K5baa16AeHBYqtlU/fztFxZ9cZ6Zn/stHO/hKGiI4yZgIyJwcWG0m6FjKb6e/CzuAYT4RwtOmmK4dk909U0mYMwEUkIVz6xulE9sJWBEJ5EFcMMzSOBMfQui8TzpqmJ76BwebjdjoIsDGAPp9QSpfJQMve7k5+lQkp4G/mraz7PF6EVbVvRYPtZ3/oJ9uyzPuR9VNQZ8bb1caUQlahu6ZVqow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9JdQfpncuLxMWZzJ6BrKVLZNwRjX+lox19YNpAbRPHpd3i8rk7uCLgSrvTq+N1WCyLkBG2HrWhthy6YoH4wy2cmXcq4hLncpHD1YcyS0iqwrY8Ed+aFKpHLk1X+tXK4LTLH39VG77wFeLRvILfmIHiA92vCG0DYHdKfVZH+Y8/G9ou+zDyE2XnH081J9n3Pgl4dpN5ARB5Y2Rl2JitNlS1FdWcRYRO2wJNtNsZOuCtRYV+0epf7kK1PFNFn11V0PMG22Kc/bKF9XGL0FkaNTDX2fmnH9KUzW2pqyqqeTZCkAdNJnUHp4WdZdFstmLmiscAhQa9IgmGyByLnCG/XSoFU7spbGAfJmck1IlWAEBZwthb5Iqg7AwN8WxI4Sb0plgZaYOL9Iw3hFU0y3KYjI+RQBcrn1t360ULB48IhSHtKT+dAcHM0BbT/AxPw4RwIF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:38:51.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71df897c-43a2-407d-89cc-08de8e6a0f9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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
	TAGGED_FROM(0.00)[bounces-273227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid,intel.com:email,stgolabs.net:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 958E835D720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses like DAX.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b3a6d08be461..6a89a1817199 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4264,6 +4264,13 @@ static int cxl_region_probe(struct device *dev)
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


