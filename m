Return-Path: <netdev+bounces-255634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBb6IjR4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:58:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D68C65F6
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7537C3007CBB
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6DF23DEB6;
	Sun,  1 Feb 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="evPrhB1k"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6223D2B1;
	Sun,  1 Feb 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961320; cv=fail; b=QU8CfGn8O7q8k71x/3+O538A7Sm7CgFMmYiihRj4J7jgzbKxeN5iuu+RRSV85XJ+54S72K5gApUWGbCyhiQNLKqutN1WY6s4AbA/g1pMACy2MH8a906EC56jwAcpJyEtQsDW50XQLLeSPwkYYPcq51cKenqOG9jyrMbI1w+6WYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961320; c=relaxed/simple;
	bh=D9ySBQFh08V1y8Ip6n6J9H9z/YvuhjWqwjvIAEt8dA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaBbDeiIM6ShD67s9rT4s+Erlpm6ZgZ4o0RgY/WNgRyOoFI0VkIdzeZ99NjlqZlgmTIiUzzdc4VK+oXTP/FQOslHOwp+3Ce4ybIeQBRbT0EmLsz3d1minNhcqbiQYPsZKw+aRCbh3tUR6+OfcbkrtK8AQoWZZmLNsSdVa11Prrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=evPrhB1k; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWE3TD3vSNaVcwFKC5vu97lJaAkCST0ZDhWYP48mD5HeX1mvF/hLBNjqGWOcG4nKi6qExSufdQozD6I4R+Ilt1LxikLqjQHojq5VAmSAuxfaWlHecAncY3J6a6+VEMMJ+hZL76MWEyD4S+KwgWsoSTwT2NQgrusb4rwlYKCoFP568qVty9suSWrtkRzMxv9CY8jiCSHEmgZ6M5TUgRPqfqP2D3sDEC3n/4tjjycgLV3/vDbPb5yeL7DAQ/WmV0ocygskcuUtqqgpd++d2x6OZNvuOOQF/kF+4clyxBXZiirvSukhycHwsA7sH/9AJkbiGDvCfk7rVBElZpKFkwd2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqlRcg7qkyfL7NhSDT7GaTYzvLwc3DY7znexmM+AOZU=;
 b=PnFpPEBHtpthjZYJqjTtkz0oEZZMIi0FHYfgX1I1IF6vf5UdHTGb7ScO6LMShov/SXTtaKmGVFXvKCo1eLyoWuraWX2u/gBSqBKkQx2WrkM+506nWn1U+U+p/Gb+ptnXcW1xJ+YbvBGTSMn/rjzAR/BlenJRxilfy2UieVgNdxLojpfx6SUMXNkTE6A36sb+haUAdeA+0Pr9U7XiaHpQfaeYfffaMBVWxXj6jiq5rKxyVKSiJaWjxSHVHewrIDNBQLHdKABXVFhNzA17NpETb0T1hgnisG0TBjEGhr+lJ+QbONfJXrdYpEkrpsVC1GGzJPqFTknzvaGr7PL2xo5G7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqlRcg7qkyfL7NhSDT7GaTYzvLwc3DY7znexmM+AOZU=;
 b=evPrhB1k9SVDdrlEDBd0/W2MPRhM4Dh/e+Ogo+2A0xRAj3TBehWTLHfS+HIYi0pqvzrJwgKkgXG0UVpdi/mse3NMziTKB3Ab4wBE/SvpSnrEqICVNxI0SjfJT55gNZYF9k/chldsqPrmFvLOPdYDNd8oq9nTfgRzLg5jGEnbVow=
Received: from CH0PR03CA0423.namprd03.prod.outlook.com (2603:10b6:610:10e::6)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.15; Sun, 1 Feb 2026 15:55:16 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::6f) by CH0PR03CA0423.outlook.office365.com
 (2603:10b6:610:10e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Sun,
 1 Feb 2026 15:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Feb
 2026 09:55:12 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:10 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>
Subject: [PATCH v23 16/22] cxl: Make region type based on endpoint type
Date: Sun, 1 Feb 2026 15:54:32 +0000
Message-ID: <20260201155438.2664640-17-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 38350f2e-c272-432a-4b9e-08de61aa4aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JxM7vWYoe3wjBblBQ3XFelMDBtu1bbnqcucguUXBOVCYv3GDIepnwJxba1g5?=
 =?us-ascii?Q?NvaexDNpz8Sepyh5W/fhg+1ffEAiU44Te/73cnu3+G/CXDgNugXZZMhIxweC?=
 =?us-ascii?Q?a6XDOuA4wX8aYSIhdvnW66AabquUgil0pYljM04pRcbhrp00cqjvsS9pjW40?=
 =?us-ascii?Q?1wjRP5rWZVWAPRDWudfkDAcmBErft7WUVvQ/wU0/YdvA7miH9vXSAXHa6gq/?=
 =?us-ascii?Q?n9cHeR5GGxaTOgwTsnR1YQFZkxZ0BCcukG0VvBfZi3ycLOABJzkOK1RKfau1?=
 =?us-ascii?Q?eCv8gZ+3Y+2miDpizMGknm6Oj+c/lwcyU00XjyZzsiWkhwsn+rQOMXfHWobq?=
 =?us-ascii?Q?7zX/PeK/5QIAZUUz2Bv5/XOnUDspJ3pKicdMG0x21cjBpHntt81kzKEbCtF8?=
 =?us-ascii?Q?JDfa4XlTvk9FDierGb/lrUaolq1SnhdbJ/1bMERKcID1qgW0RXh2pGr3rjN/?=
 =?us-ascii?Q?f64ccNP9uiiL0IA/8CS1MongxC3Cz1JToO1R6oyO81Zx+TyM94zJAi5lrRYC?=
 =?us-ascii?Q?+dDdh2/SJqyeZggXt/K+TXlSMNo5tE3jhiuHF55qYAn2EgO0Q8rGqfaVbqy/?=
 =?us-ascii?Q?N+4HYkSMFfURRpahECA2VsDI8a5C6Pm63kNGAzoodfUwpxJI7k58DbLdTz8+?=
 =?us-ascii?Q?A0KMtTwgA+zcGqkZuLfHPAGEUXDvigFsA8rzBSTBPXmVHGJrhj8jqZsz+MKv?=
 =?us-ascii?Q?y2ZhMnRDZnEp1FqdsDPXZb9nLjK2Qg4xJYUx8z0j1jHEfyYtL5tNOSgzhkcm?=
 =?us-ascii?Q?WOSqBHZhH2PFur2jxjrpMjoL/IphsjatnMEroeIoLjn/tclJTNdXQ2h/Il+/?=
 =?us-ascii?Q?asbCsD5ekoFg+GFdPS3xAzWi5Nyrbi26L+06BSUDGjNKTcb74AIY8ZO7ZF/e?=
 =?us-ascii?Q?7pF8PlmmuEM1+RtP/t/AdWznJTR4elxIxbn+/IYR1emKBDedEQjk5SVcs6ZC?=
 =?us-ascii?Q?Hz6SmE8mmKRp98oV26iYqeAh4fMVOfmUf/QhKu4b5UUDV8ZLvJfch/yiy7vj?=
 =?us-ascii?Q?MOA8IaK9PAJ35A9pfaZHFlqo5mcJASv+K6dYLHh0DqfmHBlv8b+LIaOuuHRu?=
 =?us-ascii?Q?5bCcuIkyFtkXdhj/2Ug/AGmMyM2wLAffBlNKnGrxBO3T8NxItS/o51B9oF6G?=
 =?us-ascii?Q?QC57Og+QTc+B7ug2dw3K+7A1ljWVzKDBwUaZz1jIkVFCWR3xuV7S30bbizKj?=
 =?us-ascii?Q?ntAXa044iTHxx5E2xIWSS8zfNc80ghxERNVHkGSw+l9PYExzLIlMo8jYXP5h?=
 =?us-ascii?Q?OQ7PY/DxGV7obWwRi0TuaeT8VnhAtNxSWWZi1DFhhGhSxEuOjGXRd1P1hvwI?=
 =?us-ascii?Q?ZnQd2GajuqSPdONHP8+mPqCa3/ZZMiserNloqcOzuw/IaedQW/qRmbO3pLDT?=
 =?us-ascii?Q?nliXLY4ihdxWmBouZqk5ulSoHtEc/WQYSMIWP6jLzaKXsO/aERoDLEnP87N3?=
 =?us-ascii?Q?aeFZ0/BA2R8mbSncjGps2fhwHG86vQ8KN/LWsFrolpFKlR9BbF/flANtAV9d?=
 =?us-ascii?Q?1uo0nlmPGyMt7wOYf9914Dc3+HLSaQKi0ep3jZGpqgLmfMQwtafw1PDuFhYt?=
 =?us-ascii?Q?ai5ATpuS1bSGRUDKdPy0iV1VX7m9kLZ1qu7AcikLq+bnL0lTh+ZBJYuNOcK0?=
 =?us-ascii?Q?d+y81qOX/l7F9xzEK/u9Ow/WImUOzUcGEI/FmnCRe/aAyhlU3kx/bHsHd5ca?=
 =?us-ascii?Q?1nUq4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yUh0MPdDgF8VG78hwPfqMs5SqitZ6evd7qCMWwQdTxOg+rGJ+KEo18j9TMG/GznJM64Kks+AAATctJjWpB+E9GSZn7yBf3goIuqjscyfme+qXsdMhDT9oUyia9IWmkqzVT6zpnLEHxoGFE5w3lvbku1S1y6JBNK7DGehLoUjtCq1scLf3qJcSSdo7n6yttD9esV+MIZtR1tQbgKzyxdbebSZ2gM0ig/cDoya16brBdcZNXDkmWj/fKFvgiAx7IiehH1UM/dWQUzDZnaHB6Kxiu0Hy2FcxBhPeUetCj56JyinOl7OhsoYancP4AbgezNhzbo1193IcTwpwZxNdzeZ6vH3oD7YdngTRbn8rN2kvc6smimjZDWZcTDIBsyAiJ1jw9V0Fm+uPCdYxW6RtK5PU2H+TokaZ9l1viPkA1CqMp23KjHSTGnmFAb9RpxLdeLx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:16.1948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38350f2e-c272-432a-4b9e-08de61aa4aea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-255634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stgolabs.net:email,intel.com:email,nvidia.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D9D68C65F6
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bdefd088f5f1..f53b2e9fd9e6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2833,7 +2833,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2855,7 +2856,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2869,7 +2870,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -4036,7 +4037,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


