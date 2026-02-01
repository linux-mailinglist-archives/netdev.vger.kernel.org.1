Return-Path: <netdev+bounces-255629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBjsNNl3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:57:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E55C65C8
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4FF43025D37
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ECC24C676;
	Sun,  1 Feb 2026 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ajEQRBA0"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14114243969;
	Sun,  1 Feb 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961304; cv=fail; b=c7zhHSnRPIfpN/LEq0PYLGh3kGwKlib+70dV6KrNUZU+2Oo1ujoj9DRq/hyig7dhAaRrljrk2/dGfelysvrja5ZiDQiQC02SknOPBcsHpbBu3EMVhv8xqWurjOL/M+KGoQxvVm+2qrFb7178szmPTxya+RKgz8SpE5zKjMU4BGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961304; c=relaxed/simple;
	bh=HYRNj0cskEQJPqtC6NW5e6sdLa94fnr8+eSdRwa7GPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyUFIoAndZewJ98+w0ujUChLOktVoV1M/wzMxnixkof8Y6Ty12GRUPKiG18dkKoWJyOOlKeaSKcTUwmxHcQBoGDLB4tPTffRjLEo/ZB6tMkj8xR+g0BhcbW/v3uUE04Ra3l5tOyMUwmCMgFD4g38iTnBuZdTuruSjhp+aO4Vqi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ajEQRBA0; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eon+e9V6GoRm7Pfu4uS8D8dhimym7rDURQglP4daSH2oJlb7+AyNaDUN3GV2dFPAHEG5kUMOM8uCwqBbR0WbzX7HaieB/RKx7pWa0PY4fwm0c5luC0xi0XzRhPlMcBxRrAGPVCT3ZDSbQK+D7MCpDFACLU6hqaqMYCuFUOXmDZuERnsefh4pGjvu+KKZ4Dmb01wn2xXIizMVgcObWgGIYy61wvXu37w+LvqmT5nwHTM2ynfNl9PXFFQag5mQ+vZUCVvsFl23H1D19r1Sjo994h8LQE5yWL1kZuLc8uhQ48fTndDU0ZoI4EVi/1OI/sW47LIuQbT9iWhXQThCTOJVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5itm/F6gh1nQgsavWcK31cshd6uEw/WwAtQiK3EzTI=;
 b=Du8TEfAZOP8ENzYNdlARKmtLqdjfLwX9sdT/JC272krj/Iqy47PPv21dEteqyCgXuj//k81UtWnZhQViyD7/lp+aLB4kxJPShcnpBIb5L5a0RDs9SXT3mhV/Eaf99cNcDa3l8zKjgtmk+S1817xdRKQ7vDvCNJWwZTMoKrPExspPptO/foYZJszDEO0RVxdkN+1RUTKQJfk9oIZ5y3BHohofu8FnTFW+8SK6PrLHM4SsAVIyk16AscUdETH3T1VWP2ndZhTOfrI8Fk2KsTEiJiqrB11aAoI0fFnIPVuEj3cAtxpJYeCAynXnrORxkojAexSHzUE2wpMdZX9wle4fXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5itm/F6gh1nQgsavWcK31cshd6uEw/WwAtQiK3EzTI=;
 b=ajEQRBA0NhpoQQB0iPYFq06jef4pKU2GiKQj4oa/CxG2Cpa7VOnuDb4yJO/t4kIumlaOV9fXPcufDUIJ24YRl+MB3jWTmoa8/lIdNNjAs/RJ6O3tXVXGcdzfTcPCJvEAuGMS11ToMqORyQWF9RwFaslq8OPTbxSqR5WbkwEzhcI=
Received: from SJ0PR13CA0220.namprd13.prod.outlook.com (2603:10b6:a03:2c1::15)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:54:59 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::29) by SJ0PR13CA0220.outlook.office365.com
 (2603:10b6:a03:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Sun, 1
 Feb 2026 15:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:54:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:58 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:54:57 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v23 07/22] sfc: create type2 cxl memdev
Date: Sun, 1 Feb 2026 15:54:23 +0000
Message-ID: <20260201155438.2664640-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 6caa0e71-d452-428c-b964-08de61aa408d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nssqZ1RU3ny2ONzQi/Qk4YjX8Di5rxM/DYAd97mTpcA9ZPXr5DI2R46l4UGF?=
 =?us-ascii?Q?jU0v/7F4vycdrnWhP70Yh9nZQDFC9GHKJAGTVOqOF/IreYnkusIYj/KsEZSi?=
 =?us-ascii?Q?E1Xxj4ZaLgf9oTNCvIIySI2PQ6VPwZOYxF5kDGnlHpN45g1Q6vH9hHznJovZ?=
 =?us-ascii?Q?bxTJl93gPutX2SG7svqkXV5A09WuqSzxTYeVX9EikD0LgG5K0/ffyhV8Gw1s?=
 =?us-ascii?Q?TcwRvXvEnf6YBNAJM/8UQESniFMf8nStNuHGfUuB8fjX+EuqMWcbT18/w3a9?=
 =?us-ascii?Q?+zm2ePkTpcPX6fYQ6Bc9kWx9aj69MG1cdJqsZ4fQEaonD8lkiM9nt8GFTXgQ?=
 =?us-ascii?Q?MksumHWMCoo8Ri2w071Kjmg8Vs8+N2dOhCXy2RbcSwoGyL4Hx27xZx2JnDP8?=
 =?us-ascii?Q?6tLl8JSBp+88bmgYPPz1YLQvXMepH+9Hh3qF5+FX2E2dsSlr4yHHccLkf8n1?=
 =?us-ascii?Q?6SDV6Qnmdg/oOrAjUZGVyxsFtwkpDrIDFfNZO2i1skVqM4ujtPPTSfRwj1uV?=
 =?us-ascii?Q?9kcnaG3dvrtvUkbrNhzQczuRzjJFEhtRX1uYx5GsGJkeZ9JGV4pGZi5959Ey?=
 =?us-ascii?Q?YvbvyDxnDV4ZzVoIAY9orOnmp1FFycbei9VhNUktUoWF4MGKwsgkJLyAhV33?=
 =?us-ascii?Q?vK4EArrllw4ZrKPLMaIyctMWEWZAMQ0JVkOPXbcicogeGzmXcEZOXh7T9LQv?=
 =?us-ascii?Q?zd434QzABuoyz1lxNHy38432Q8vJgRBnR/tkVGcxofTQ8t/wQ1CPXp1AaTFk?=
 =?us-ascii?Q?ikD3HlEXdVCVJwDd8cTCjoRsY9B8ucbk7bMmwdlQDBpWirD5b3CovHVUt4cI?=
 =?us-ascii?Q?38lVWXcjDJyyloBOSdCP/xo78xXTUSHB00bsT6I3XyeS7FQCKwIBkI9acgng?=
 =?us-ascii?Q?qJbk6fw/Onph913Oz+ksi++Wo+GkMHOC4JEjkKV8Jquo8JEIeblUv7BBYA7d?=
 =?us-ascii?Q?azksFQ5AiVHpi9o5BZEY/ZyDopLdmsaO2DbfBmZYPJZjcVdHRlEl54Qn0Iam?=
 =?us-ascii?Q?SvDPJsEoytwA/azl7IkijJ3or7y/FmEzVNhAlgl9OvZJBLeSXuFo4dKhK1yF?=
 =?us-ascii?Q?OCyaVxmFaAVyo/Pwc6vOms5TChBk4Ht+SzzUvqzqY9EPqB1vV8n75g24fuaf?=
 =?us-ascii?Q?Oo+Xsfsb3hevRs4YoDGOkt+4aBZ820uOyDLQLOGkq9MT4I6lQpL1XgpLEck9?=
 =?us-ascii?Q?i866L8ndTFaXEeL2RStC/CSSCHJQy0lrqQEtB/dT299v2tRQFvRvB8g8Eao1?=
 =?us-ascii?Q?abLZQ/B7QCMDMAOdL7kuzAYqPCweAKnQByJnxqV/AzOOHb9pKRatEJqVx52d?=
 =?us-ascii?Q?VtJ/V4bbDzpm6pyO0wybW2Q0l+VppigvOYBrofLsRrhNtCkz2RHd8/xToaYW?=
 =?us-ascii?Q?VfDSdZ52NCiBZfaYQ+qv7gcU1J3Rtm+pZtLAQXTNr5qLa/vRmSRXybNn2r/x?=
 =?us-ascii?Q?CEt5MLSgs0mNM+wJf2S5klYS+PH+vduBWFgodjE1HyTjqvXF0QMIENnBFA9c?=
 =?us-ascii?Q?jVtQeqr/Bse9ZTtgYwb2DE+hLCTcqjyUqkYRoRs6jOkawqz84jvIR8xCHVnT?=
 =?us-ascii?Q?zxoVQ2Cj+xPJQI3w+35dvoJlUj0jhdIF6YPaLIwa1zKvO/rsQ2cfiGGdF7Zi?=
 =?us-ascii?Q?sgRix2aw9MNBhBFXXOm11leIyTe0rOQ9l0MuOSP3Fe9aQenmGVgy821r8kph?=
 =?us-ascii?Q?k0zWcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TNc1Y+6j6bDqfPEiiF9MF9raggFMyNqova0qBPVzrH4Z2+kagP0BCRYK5AKJJDpYAf0THv4ycFoGXcpOrmE5oKu/k6QbTa79vb9o/ZwGcG+UVFrG+0SFoG60+3EvehiHth+9Z7RJs24WPdHcpUMgXgefVRzl43oZ1w1nx/6wujomcYTv1Vj/lgfBTjdDkFG/sfZ+BYOLBOSfcpEKtaANIZEVLHa0XjHgNTxIoWKs3ZMztgXpfsgrAAgbwn1Nomq1FAW/Ql/ZNhwcn+ovhyHEj/KCpdLMl3uXjiys8CNWMPeQqFtB7we98EffrdG0WZugeEzHxPW7FZZycy2cJQxizO/Cfp6BLqPixSLEbxLwJzCVhe+OGtaqFXa6EzXvmn+W8WTz+Kz/97IGLnJRNa9tNbOvgldea9ub75pX7wFEum1y6wpxtqwfjVZqmzcdvhP3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:54:58.7752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caa0e71-d452-428c-b964-08de61aa408d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,samsung.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255629-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,intel.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 39E55C65C8
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 0b10a2e6aceb..a77ef4783fcb 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


