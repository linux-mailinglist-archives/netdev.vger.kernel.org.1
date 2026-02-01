Return-Path: <netdev+bounces-255644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CVnKqd3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E213BC65C0
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAF5D3004C91
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C842417FB;
	Sun,  1 Feb 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xYXkMwPo"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F123D2B1;
	Sun,  1 Feb 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961332; cv=fail; b=mjmdSIT3LaRgo++xQzN62ELLmMx7YUFpEi/85gYrtLp6dhSK7wT98KTcdvHstasVT5Tlmaaj8XC5Nm3khBJFH6JckZfrL6fFwrBf8aaaskxngdMiDVycp2zKKb0NErFMaM5LKL/LS1jNpnJk4eQegc0FBCkYr/NIOUo7vBA8G3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961332; c=relaxed/simple;
	bh=bcnUjL9V4ZNF82wObApzBv8KPe8mfh94sVIAiF26pX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKaigb8a0avJ1ydiPgQoyXnrmZEgsaOUH/4Pu2CSHPEQ9KOQl2wnIIPjoSqvk/I6A6RIssVWaX6zfsqaSHHr0AR1HP1tdzUCmT7AuliBHaiSCTqdj48OtlYj4OtdDX0IQOm8pR3GgkpjcOCqzSVwQP5G+BWiEiAHooIfY2A1ktY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xYXkMwPo; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EavbyQ/CD5eF1CS13A1Iv85K6E/RJmKUYYs47tUO1AHjkbzTc45/G61U8YQerA3Vn+aOW9pn1c6tgZvbV3Dc39ZiKmYiwOT4iW/gOjm3dYKTMw4xZvdKYLxoEYaluCCtG7lhyIqd1kk8eWoT5mX33CtgBP0iwJiGICiz+N+ktjVj93H9TdfWISG7VwMNq0WoRJnIMrCkc2is3GXZJ4FhXItDJnIr+Y9/DYQRlS+YhuGgPBh6DdEm8sja83A01g6iYpjCLRVf01pojuHac6BKKKu6f7z4SZ1mUKdv67DnYJyKYLYwXoHEesvnFO+gi1l5DFOY7aA4ntykKnxZZYZPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0A83wUSwMcdJTlWmwYY70ShM2XS1iyO/Bvp6lIgJF8=;
 b=WLgr/2rcawhXHrA0AvZagNz92PiTJPNrF0askOrOekMLIw8eP+J6LUsR4BkFFGQ6saVZMFSQ9p8z/2atK8RlRhCUvgXCAWxSUFl2r5YtHDyK6laUjIU4DA8DyWFs5khA4qA4+yAqHvZZdi0pUOfmWX9m03x0WjEJFFYxCU4cav3Vp3TO7V/XPnsehxc7algksQZz4McvG3E5kA0ZCjVn4jMO0bFoG/0kVsF6UQTXqabP8fF8unXuFjicf9Iu66OcxUXZrCqFGjHyglAZe8Hwznf1CQ/4EL0Lkc0gssluHsbK8Nd+PtEWCV4Lbho/D6KRHzBuUJCInTOF2Phydn7MHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0A83wUSwMcdJTlWmwYY70ShM2XS1iyO/Bvp6lIgJF8=;
 b=xYXkMwPoM3qxXwelBUCTpelGkVKkxPgy9ILWJRSl6dA6mHOoN2uguV94jRc34bMG9GLuGTnBlfj0uKEEs03IBGUOZbSewEbCrRpWlT+LaD1JxjnZIfqQtZfeDQPNMvqIow3iweaUOvxrf7lbhsCcUH70Revn/3jtXyVR/FF2/z0=
Received: from BYAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:74::19)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:55:24 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::f9) by BYAPR05CA0042.outlook.office365.com
 (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Sun, 1
 Feb 2026 15:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:17 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:15 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v23 19/22] cxl: Allow region creation by type2 drivers
Date: Sun, 1 Feb 2026 15:54:35 +0000
Message-ID: <20260201155438.2664640-20-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6d182a-e038-4a08-e164-08de61aa4fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmcjffRDlUhZI9x55fpFEFODSH+YdoXj1XKpVVDX4JTL7PivYXTW6OYRZjy6?=
 =?us-ascii?Q?98K5Rr1D/E/YtRF/5ZkdnW2pOVXmxyJ/k3knAWIrIiDOx7PmoFQbH5DFW4GA?=
 =?us-ascii?Q?8m1yp4jz0vf7r132fLeo5+q2lTvD5Fzg9lctv5jA89FWkxBJGw6JXvSkEz0R?=
 =?us-ascii?Q?+GjvEwtaOWLZ8ET4OTbS6DtyYqcBSWu8D1XXCDysVGByG2uQol5QFmYoio+4?=
 =?us-ascii?Q?+kEi+9ZOmnVjwm85iEj7wAGBYvdrRH/Aio1D5jSmOO2Oa4h2UCzY4OZoauW8?=
 =?us-ascii?Q?7fXzxzmneaA61W117o2KyXDtGGP1aEpKCKK32hhkZBVi2eRivgzGi3uxxV8I?=
 =?us-ascii?Q?0eUiECP2wN7pb/pqlO46LJ8ju7Jf6hE+aTkEogc2/owOqq2NTomUM2W9Mt+U?=
 =?us-ascii?Q?zp1mE+2P3Y/962wCTv5ZD/4mDWtEwXor4XR2n5+KzpwiBV8GU61yTDh00/r4?=
 =?us-ascii?Q?erj/Q8dzKKwrQAYV2LFQCyf6ocdrIFFOmAix1DD4OGMpiUr67CqbwY3gx42G?=
 =?us-ascii?Q?W0RY+FRQPz2KyvuPNbSmmszo7FMKafwKa37z/FFYgl3jBhupG43+UQpzcvHO?=
 =?us-ascii?Q?f7uSs8CwbKZT69IiKjjJX8rGiEelb65oaW243kkEwNwfrTZRQSbk9Tql4aG+?=
 =?us-ascii?Q?yVnShhirRWYA1oKnsPFeZV/5HOQ/WyeD4EkgruHsv1m5QsEEIc5uJfW2c/gI?=
 =?us-ascii?Q?TqPDfJpND7LavurAtwZITrqRZs6/uHxUi1ee4wTG0qsKrE3D5u7wYp+2UDnt?=
 =?us-ascii?Q?G24xdV6dRrmhk1hLjqUto/WufgetGx1cWAh7w6c1XKfhnJaNI5psR+pYXiY1?=
 =?us-ascii?Q?9WZCJ7Z5dM8ecqf4PUqW12NurN2ia+OzFRQ67pzzQQTwPMwrV0j+M1tY4unn?=
 =?us-ascii?Q?R0QHdRQG077l87m/bltqSoEBaIiGB03cUx+aD5iM7r47AsyDNJ0EfXRIN1IT?=
 =?us-ascii?Q?NfNOf4e1JiYzNTQaGiopNZDUeKk3BQZK7m7l6i0x2t2H9L1HHJLPTxxgwT/7?=
 =?us-ascii?Q?leI5+DUb+7KgK+gqwGFmnvIyMvme9LwimFhJdvWNa1Jfrfz2QhHLSQDPJV/N?=
 =?us-ascii?Q?Bvk/MdhFhc/bZzcqcnHBXESP0NM89oPM7t+9fErFGetA8WTAQKq62fUUB3Sa?=
 =?us-ascii?Q?kg3s9CCzx0qikRjKfpxTYq0Co8Q9H+YDbB6yO4/uJGQydMLOVuTbdJ9CqnfQ?=
 =?us-ascii?Q?raK4h4BhzsCn6r7wFYNQ3Nbz/+x7raaw9TwKjcLvTgvFG+dFCP9MwoLFVnoc?=
 =?us-ascii?Q?Y9E6CxVppQ++oS1l1iEbARRdULD1ktOPfMYlhDVDAACTgP5A0KoWCQnMK1LJ?=
 =?us-ascii?Q?ZP8dpPN0i7xdGXwHz3Dzzel75LAMZQH05wNVGpW0dY8O4fEb4eMEqo8r36PR?=
 =?us-ascii?Q?utUBsZZRYAyKn+7JFJiGF09vISWgSWEYYAMwry3hzn8g+Cd08u3OJy4LrBtk?=
 =?us-ascii?Q?9hsYUTaGKp6dLNt4ewjHemR0qE4LR+T0XGHaznWFqUFrF+q9E8Gh6ZvNoicm?=
 =?us-ascii?Q?qr8QQPSleB6yXWBRCyvJm+os9CHUPhsZ2nPOMAZlIAJlb53vYjUHP7awwan6?=
 =?us-ascii?Q?8AL5Ik7DiPImb0Qmv8v7gbuFBii/Pm5i6CKQ3y0obfAXsN1NoJQ/OqkeV3l9?=
 =?us-ascii?Q?09Svmrr9bk/rrPcVevniTipq3OgZ8zZATEW5xHO84MXDhOFLdTaR5bcom5Lc?=
 =?us-ascii?Q?Sb6Q6C516E0RwWRu4iDZGbcotLY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bYQrPEFzE4VOswtvr3PTArT2+8/vl7BSeDihaHlUBzwGJ0jn/8hJY0o8M+x6vB+jsfDMZ3a8nh4NqEN5J44QiEvgsV3Pg3w8fhl2czrWS3iK13sJHNSU0xFPpT6DC+klaQ3A4EP/mfwtVbWFuUrrfY3KCDaABvQvKMaIRTtIktL9xlJdkittbpqTJM0AMFrcg2yllOkitR0QGE5I09xWmZHeJk77r7w+AXZkyTLQn9bkjm+y+uRsgg28/fFFTvGisz1iP5OFbXZwh7plCdAxMZ5EWnYAKTfyod58PBvnOVAJiQWNEnduah3DqWto6GxVTsSIY2uDUEcteK7NpMnI7Vr0JWe0zQG47jjBi4BmjRZty1l7VQZZMuJaVGiW2jjRtVOgb3Mr+WVgxx812Zff2iFAiRKhCWUIbR0grtIO+9djGSxT2Ew9sLk3oiTMvWEt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:24.3130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6d182a-e038-4a08-e164-08de61aa4fca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255644-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,intel.com:email];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E213BC65C0
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 131 ++++++++++++++++++++++++++++++++++++--
 include/cxl/cxl.h         |   3 +
 2 files changed, 127 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 63c2aeb2ee1f..293e63dfef22 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2944,6 +2944,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, __unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -4047,14 +4055,12 @@ static int __construct_region(struct cxl_region *cxlr,
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
 	do {
@@ -4063,13 +4069,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
+
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
 		return cxlr;
-	}
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -4080,6 +4099,104 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
+
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder **cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	int rc, i;
+
+	struct cxl_region *cxlr __free(cxl_region_drop) =
+		construct_region_begin(cxlrd, cxled[0]);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
+			__func__);
+		return ERR_PTR(-EBUSY);
+	}
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		return ERR_PTR(rc);
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		for (i = 0; i < ways; i++) {
+			if (!cxled[i]->dpa_res)
+				return ERR_PTR(-EINVAL);
+			size += resource_size(cxled[i]->dpa_res);
+		}
+
+		rc = alloc_hpa(cxlr, size);
+		if (rc)
+			return ERR_PTR(rc);
+
+		for (i = 0; i < ways; i++) {
+			rc = cxl_region_attach(cxlr, cxled[i], 0);
+			if (rc)
+				return ERR_PTR(rc);
+		}
+	}
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		return ERR_PTR(rc);
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return no_free_ptr(cxlr);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoders with reserved DPA capacity
+ * @ways: interleave ways required
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 static struct cxl_region *
 cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 {
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 4802371db00e..50acbd13bcf8 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -281,4 +281,7 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


