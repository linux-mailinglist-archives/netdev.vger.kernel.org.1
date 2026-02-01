Return-Path: <netdev+bounces-255628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMFmN2l3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:55:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A1BC6586
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B50A43003712
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEA024BBFD;
	Sun,  1 Feb 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c1Up8Cl3"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BA23E350;
	Sun,  1 Feb 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961303; cv=fail; b=a3M2ITOZ0IUGU0RKJLZcEBHjYZPu0beH70uonuTkJQJUXnrNbhKAfkGYmNgYQqKEd5sYN+ZFJHO50f0lZGv/9qcB5NFWQsBpc8fqkogDaIvW67xd4nq+J+5E6qTUANoF98Ahof9qsHrBZQpJ3JNFdGPzreMkSxjYDA9QiPccz5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961303; c=relaxed/simple;
	bh=6vFlLRga6tm0f+ALa63ejTLfypIR4ueypNzqfVmHJAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUEOW6cvOA55vSXOjy3kAaABO8X3BB/abrabrzflUSf3paeQvNIbbGiKeVk6DYvO3dxiT/jzl2zBhK0Fd8m11GX0XRFX+boiUbl39anXHHg/EnfZqTFm2cmZD+v1XRpf9u2qaIZWQK3Psm0HWCyimECIFX1brV7DAAB3945etIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c1Up8Cl3; arc=fail smtp.client-ip=52.101.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbv2WOWNeGJZy/ivP/HY1uwuaTPVnfki23iI4GHrzfDzLFDKsmFVTSDTKhxGFYbUxP7IiuKjYAb7bR7LbSVS32BL4dXdXrGHyP+z+S4Q5ouzhGE+A3OSbCosDcyjFUdYkn6Tc7lylqd2JFNkn10GYloFcy+0qKUrt/IBtI5mb4768PkmxChiYrcFDHk0Vf7PlKMk8QCm6ZjKDRMIl38MsuWCc7134y7lvY/H44C8Fn5IBlB+qGv8KVllbXWZGnNGYrofq2Hj2fC3/uTwEFLlpwoMHQj3EIh5VhudjrgCDJiUpsatyclf0WTkjhwW7FUfNH7N+VuxPdNuX/pjVvC25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QOSfJf6idiMWFNlFEERq60qE4I1hh0tFcYTCnZzDLk=;
 b=FQpHD2ISx0awGa7mPC1aW+/ROHfYumwYSqX9pJd1C4quk1ObKcMHPlGvOeHeCbGFPJAGStEcjOqG9rReFJfW5xej5flt5eObvNvQufE9UIRsG6VJMWyvSK0AT9cKw/IxWf5aN2bLmVyX7J0fPv1GU0AxPrEtb9EUxo3sNTy037yj05UKFkGqPN21rctNMhKy2utWl7y3+iulRys11J6ckXgD0e40MfHUK/z9GnkMzRwcjetoqnVQE7fjLiL9yPRb0e3RsGfMMwlMZE1LOQ9XeXJcTEKefxsdiYSfQK6Bohe1aaOMXT8/YO7NMFQnG5HqPms01Ao1BYpvvWAcpLw55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QOSfJf6idiMWFNlFEERq60qE4I1hh0tFcYTCnZzDLk=;
 b=c1Up8Cl3P1V51mJC4npG6263DqQ+9dwcRcopZ3HjxDE8R4vaTf7C+B5m1fFQTDhaTZ1BagMLkTheryelNjGrTJlIk2VYSxh/rHMRoJPYEjg6JenEq8YylqmhLQdte8ypRUTocmr13Edr+jEqMk1TTY0DYECJ4p2+EkEZTcbr/A4=
Received: from SJ0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:a03:333::9)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:54:57 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::2f) by SJ0PR03CA0094.outlook.office365.com
 (2603:10b6:a03:333::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 15:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:54:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Feb
 2026 09:54:56 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:54:55 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v23 06/22] cxl: Prepare memdev creation for type2
Date: Sun, 1 Feb 2026 15:54:22 +0000
Message-ID: <20260201155438.2664640-7-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bd8a64-92ae-4862-dd0f-08de61aa3faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m7sl8CS7kl21XOhQg+5sozNSeFFTcXkeF+cAGn8tmloZ1dDQc9LZnpV0gDVD?=
 =?us-ascii?Q?bty7PiRBBNUChnW7UJ0pwaqY7j/nW8TG6831hUbPUE7dRLiqJUF89EXbBnUV?=
 =?us-ascii?Q?D44EQPhz47K6dGSHdLFH1JCq2i5vpc2IP4Q3Bu9MT+Fn0UmlTqkpyXe0szGl?=
 =?us-ascii?Q?4q2OomP0FdRefkK6GxjUj04g4rEIUUp+J+rDhqyAZMhUXwkrIrR5zkMFdAQf?=
 =?us-ascii?Q?dAiwq7vKiuUXoS7HvYbIa6YRXyn+xjRMt6xtGGDXWWOVWaImfcvua0zGAOHP?=
 =?us-ascii?Q?16yOV/bO5C9+QPvpH+dV/DwbILHtU2+oNMcDOvPkoFcOjxuP5xmMk6dYY4Wl?=
 =?us-ascii?Q?YyZl64xARecN19YK7h/bpJWiGoF2WKO1C0COHmWiy2niQQhfzDHcJmv8VReE?=
 =?us-ascii?Q?2SInrWoxJrFIdzyozM5gpxiMCoa/JFmqQ1PNyiR6PTiPAiyt8k7uq8qqlT2x?=
 =?us-ascii?Q?KR2cSwb1D7Ov+VSisllVOIqHWpm/IFfw/fEZoDOY5oMN0RaCU634q5kjFaaN?=
 =?us-ascii?Q?UjA/7TFf+8BYIj8ZS3Mq+8NjE6n8l3qiiiAzFNrOf7taSOmv12Tqm2phkwcu?=
 =?us-ascii?Q?gSr/cOFUdyiAAqLCAjTJo9ccLYR0YyA/KYTRvsE7urx3ar96exLP9yeQU50F?=
 =?us-ascii?Q?iwhhbNe7yveOdB/yDvOaPKG2woFduXmuNi/gTkcuyeHRbjJ4XpQ2Szqh0j/q?=
 =?us-ascii?Q?wLeB8OtROWgvJHEcf9Go+YEFMQgHSfvv/OC4Emkb1gg98w1F3NxNEOJF6Tib?=
 =?us-ascii?Q?1tR4NlEkOyp2cw+qd0mg98uWAG+vejzdPknbjOWNzkfjrsW3Z+Sjsx0qv0vL?=
 =?us-ascii?Q?T7K2l5vDvoEybO8LgvAUDvHjuLoivlKU2H25G12sFR3ZfdJLWceRS3AGlFHj?=
 =?us-ascii?Q?POl0a+5bhhGARz8DIPvJXUQM4yjOn6cwQwy189eWfOZlVUyGHJblAg/mcHgW?=
 =?us-ascii?Q?eF1IILaH3VnBoi80M6tSNV3YYIxYEPh+6PeMY3ZiuV7k56+ZECx1gfNPSNbF?=
 =?us-ascii?Q?plkThBOQrElSFhhwQue4MCOyP9RIVJGeH268LU2CuNemxaC+U9Zxw7jq2yg1?=
 =?us-ascii?Q?Ch4Ri/97VP9wRhYk5Wh/Nw36iqtYcM/gSOUplkqL4z1nsakjb8dEZvidmehT?=
 =?us-ascii?Q?yKx6CeW4es86dr5vOmymv6Ao7G3oDNZR4LNreZvW3FXSSthpIogRIuL8wXzV?=
 =?us-ascii?Q?Dfeqzqc577+RJT4pz1ReQc96Gx7WerxlEI8b0egl0WWiHpO7V83NkDQOrjjN?=
 =?us-ascii?Q?xEGPHJJlua6McODK3zyWANBTrnlrW1XvB9bByNb2a7hLYJ4XBMvP/z6+2lHv?=
 =?us-ascii?Q?ojA1kR4SYrzm/FbMTXMU7Yz5SXEt4K/+vyBwT7iWA0G6Spg/S6SQ/bxgLxbZ?=
 =?us-ascii?Q?n0Zk7fyc+iOSuqXxPnNMODlNCFM79Q2UUykGl9srn23PdbCO1PxFliZ4HllV?=
 =?us-ascii?Q?QwmpQue7pY1Q1j51UWaxBllbfwFEswogi/WRprDBhj4qMtznk9R7geVm+gSu?=
 =?us-ascii?Q?SlBJP9wiWFFNKhluTSwSr9xJl2Z4kKFFzuAFzIdg6u8gKAPYzS3Pxt469K2B?=
 =?us-ascii?Q?jESoiqca0SE7vUt2TvHp9Yz30Gf3bam39kSJIkguf5Acwjmr/aJKq3eD7IxW?=
 =?us-ascii?Q?3WEjeB7bW8ap352ZWnzoC+NMJj2KV/sYmRUjtaQfgTcw1KhT36NcsmJURHuM?=
 =?us-ascii?Q?JWiWkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vmjKFj++AsXarNKQ56jRsT6BGnSzJn7mAwrJgT87+A34q5oZvzVle9AGb2hrP/akCMwtOJSvsiFxg7nDBNo3C+tNoHAfRbFeiNfMIMPXeV4EUD2anTq2TGRAZIovgM/hJ8CB89ZMw8qz7ulcZDoFO7RB8KpLl3GBpCZnZskvCaFjlMqiVkWAfWQIfV4ajQNerysbMcc24jAKxF/K1eDppr0/3gakNFdxwd7MzTLAkYDuyr82OtXBK6RiJwT0wFThWXd0JcNnrDgkOIaPB2AHEDlNImPATL3W/DvANqG6NTeCpEB9jDBf+9omHAKcMslU/pe6e4jNfOUrKYTt7UsZL1sLnuvFJM9Z19nlFJ+D01S7rZ1QJAgYwl7eLhAIJES9MWUx9hzIxzS1DiKgg1aGazrVQNcohwP5QZsFfrvZbr4O58aUoaweX9W49ffUFsFY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:54:57.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd8a64-92ae-4862-dd0f-08de61aa3faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-255628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E8A1BC6586
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accessible from an accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++--
 drivers/cxl/cxlmem.h      |  6 ------
 drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
 include/cxl/cxl.h         |  6 ++++++
 4 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 2c5dd72f43ca..1b43763b8e20 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include "trace.h"
 #include "core.h"
@@ -576,9 +577,16 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_accel_memdev_type = {
+	.name = "cxl_accel_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_memdev_type ||
+		dev->type == &cxl_accel_memdev_type);
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
@@ -781,7 +789,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->parent = cxlds->dev;
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
+	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
+		dev->type = &cxl_accel_memdev_type;
+	else
+		dev->type = &cxl_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 281546de426e..c98db6f18aa2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,10 +34,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_memdev_attach {
-	int (*probe)(struct cxl_memdev *cxlmd);
-};
-
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -103,8 +99,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 
 struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 					 const struct cxl_memdev_attach *attach);
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_attach *attach);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0958bea915ac..39687baedd1a 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,6 +65,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
+				     struct cxl_memdev *cxlmd,
+				     struct dentry *dentry)
+{
+	/*
+	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return;
+
+	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_inject_fops);
+
+	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_clear_fops);
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -92,12 +112,7 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	cxl_memdev_poison_enable(mds, cxlmd, dentry);
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -208,16 +223,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
-static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+static bool cxl_poison_attr_visible(struct kobject *kobj, struct attribute *a)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (a == &dev_attr_trigger_poison_list.attr)
-		if (!test_bit(CXL_POISON_ENABLED_LIST,
-			      mds->poison.enabled_cmds))
-			return 0;
+	if (!mds ||
+	    !test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
+		return false;
+
+	return true;
+}
+
+static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	if (a == &dev_attr_trigger_poison_list.attr &&
+	    !cxl_poison_attr_visible(kobj, a))
+		return 0;
 
 	return a->mode;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index fb2f8f2395d5..6f8d365067af 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,10 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+struct cxl_memdev_attach {
+	int (*probe)(struct cxl_memdev *cxlmd);
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -243,4 +247,6 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_attach *attach);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


