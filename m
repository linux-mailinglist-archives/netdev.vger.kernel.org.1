Return-Path: <netdev+bounces-111573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA9A93194C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A225A1C21634
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F5774BED;
	Mon, 15 Jul 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lQkuLVOQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5171B3A;
	Mon, 15 Jul 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064545; cv=fail; b=XYL+FU5toyWZ//C+dawXbRt8eSLbO/jLOjMucf5mZSr5yZ4NFlozLlruhseVTFci7hHdIeFcZR7g1gsJbXE+kpEWUnIzitPpwTC4cAOrWd9uFtoMKB2jLsE9rqNJMXddUaLM5opgJyMCSxWXCAfdPXaeMX/161tTAk03B9py910=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064545; c=relaxed/simple;
	bh=qgWS3BfT14ZBavTF8bZ0VMsweurB3s2FqgLcm22BZr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M248xshtNQTr0CGoQT8UoekE7nRcRm6Fl7mc/wTusyrnG4E08L5YjJxuIWrgET52ujiLOVEPtWF3SfFhbfYNCqQqg3n9rgEd/3P5ImLWbBto+u8Y0oyxTcFq34BwwQBZ9IT6gFRGj0Dvhr3nYCog9XK2UOFRwv81jpcU4qKqtHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lQkuLVOQ; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXQf5tCwLd6waYAu799YkA1IbM4FAS4YTs+X71jkNyIAfi6+ZfwtIhHNpug8Csv4gQtIIc8nEq2j/3w1OtE1Xk7Sps4/BePayzTFi2INozBYPVCx8yEQWRzE79n0VAAdQSBdRthxwvUU+iRtj1qkbaFd5C+HsiuLz8Qu+w1Z3iBPynYXv84sfUFmHBLyLB7Xc3tdmNwJzu8WsO0iRTZkXG3ASyVlDY4Cc98UKOJh7bndcavQA2kqzZnMT/sAOlJIvuvyjiZXc4mPfy4XpZaCWJOvRmDrWVIIwm7Zvce4EA5/FDAl2bKvE5NAPaUYj7yZis7Fv3ClZPxwyYvgFrXvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dizz2TTkzDjjd1y2eDQGqIAEiQuyoYn0IDgCcbZi8F4=;
 b=MqOe0Lz43X7WO+Ho4u/eJBRdL3tl8Uz/q7GWs4Ef5AF3/NTI4kCSX6aEw9jkgrbAp4nQqzhYCMBqWFlHLqxmZxqpb1jtjQ4qh2nfTa2R82XegnRC7msDv7fZDR/rV4xd4QGxTZosSjx1c7hOcCIszSbN75c20mf+ysFk4i5WLePqKL4dAeepT7Us2HkGI/j7e25GnlSEbxFxPtEOIMeH6/Drjiuz/neNONJfmKii414lVyBuRDPI73MpmFTLXu3dulwqMu5hSTpdEN5BUtcpxy7H/kNNAKbv14gnh/dLhW0lDYkjwb52R4O3DzaUisCa+E1lvnzOb2gukaq9hMzjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dizz2TTkzDjjd1y2eDQGqIAEiQuyoYn0IDgCcbZi8F4=;
 b=lQkuLVOQq+RDmO2KuRFHBlqw7rVODxLROkzEO0cQS9vq2Ta+ddqtSzBBfheTs8WmO+B5sE9jUqULB5zgE12LEtRXXJl9gXh61DW7KIweftCUWWyTNpzmdrmJrZJsV7SIrzWMgzpKtwYJ1wryR124aYCkWvXDneXNAf0lBz4ahyc=
Received: from CY8PR12CA0047.namprd12.prod.outlook.com (2603:10b6:930:49::20)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 17:28:58 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::e) by CY8PR12CA0047.outlook.office365.com
 (2603:10b6:930:49::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:28:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:56 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:55 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 09/15] cxl: define a driver interface for HPA free space enumaration
Date: Mon, 15 Jul 2024 18:28:29 +0100
Message-ID: <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e34b7c1-e34f-4764-a086-08dca4f39c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWVncFB5WCtvTXpRdWR6UHRNb0dFeFhYajBLUVZTYUZuT2VGSjJKQm1xVXI4?=
 =?utf-8?B?WUVSRFFYc2ZpVys2dmFySDVtbC8xbS9xbjRuU3pTaXUxTGo0Vy9zcU5UTUlG?=
 =?utf-8?B?b2VQdmdhY1BjWUp2SkpXTTAxM3Q5cW00WWhXTllpd0d6R3BNd2QwYzdScVdJ?=
 =?utf-8?B?YUJsTDhUa0JRaVJERDB1bjJkM2VITUovK0RpdlFNcUVsbjFxQ1F4TG13OGg5?=
 =?utf-8?B?ZVl2QlV6c1ZsamV3bXgwdzV6Q1UrcnZoYmZzdVVhSTBZR1pvd1Q3aFl1VFN4?=
 =?utf-8?B?dmM3bkFld1EvSEVvbEIzUG9hRFYvdkhHS2FURWsxNE82RGVqTXlZNHdVU2g0?=
 =?utf-8?B?cjBLVHo0Z2hhcFl2Zy9mVjhZTU14a1JocUVEMWkvam0wZGVQakdjdVI4NHB4?=
 =?utf-8?B?M1ovOWU4Z3BJY0FGWVBnOFVXejFHYjVWT0xYdVVZZGRhSmt3VXdBL3BBdzc2?=
 =?utf-8?B?RlpzOEV2WS9RRi9laDAweTdNaDJPeFNaaUl4TktkNHhkZFg2eG5aWU1aK2pP?=
 =?utf-8?B?WllkVmhIeUxVekNzQXEzVk1xd1dycmZVampXWG0xNSsxdDRSYXc0Y1ZiL1lH?=
 =?utf-8?B?ZUtEZ3JubndSYlNYZHZxeDNJTTg1MWZwSER0YVpVUnJGUzBYQWVTOU1vR0U0?=
 =?utf-8?B?dTNVUWVuUE4wSGZGU3NrSEt3WlRjK1NmR0pCYWVLdXN4WEpxSFB3ZGpSalB2?=
 =?utf-8?B?aU5NUXUxSHpMTnJGTDRsZ1ZIS2FzWEpVZFNtdTNnZFQ4dkVNNEszUGdKa0hX?=
 =?utf-8?B?TXdCMGprRXNpQ3p6NnFFbEx6QUY5V08xYU5EamF0cU5mZG9ybUorOHJkTjRi?=
 =?utf-8?B?bVluZ041bkRHZDEwYlExRitPQk5WcFdzcDYvQk5DL3l6d0ZLUDUxVVRrUEEr?=
 =?utf-8?B?S0g4ZTJwa256Z2RJTWQ5bUdBNU5pREpkWjNmSW16MkE0WW9ONDlRTWR5SFc3?=
 =?utf-8?B?NFlNazFzRTVKS0I5eStUR2Q5YXRHSERXYlQwR0tMQ3JYbjZwWTZSTEYrR1Fx?=
 =?utf-8?B?VlZnQ0R1aEIrd0lzemRZbHZGT3hJZGo3eTluaTBRWFFnZm5QRTh0U05mc2NM?=
 =?utf-8?B?dUQzV3NEUXJOUTBsVVJrTWhiRGo4NmxQUjJldC8vSFY3UmRxOUVGSTl3TFV6?=
 =?utf-8?B?SUVSYnRlS1E2Z2huZlZkamdjUUZOU3k1UnZaRFF1K29zSUpTNk9DVjRzaXkw?=
 =?utf-8?B?RDVBemxySGx4L3R6WUZud1dkWEgwVEVwclZENFhvdHlRTkpsdkRSWHVLdzF3?=
 =?utf-8?B?dDJMa1BlUGZpSndRK1hZM3RCR2pGOHJtRUJGUzJKaGFUR1VCMUgrTFdwUzlr?=
 =?utf-8?B?N2VZcGFIWVhDdTZhYk9EQkx0SlpkZVdJcGdWRUNhYmczZkExRDJQRlFjaXBo?=
 =?utf-8?B?UUcxcXp6Mm5GRG9ycVNDQlRZNkhkRVc0andaM0JWS1dxSWh6N2NqWU9vYkFD?=
 =?utf-8?B?NndNbEVOOUZJS0V5U05XS05tSWNnR0pGVW9NMUdxMWNGczNzaDJzTUJ4bmdH?=
 =?utf-8?B?cU0zcm5VKzVDaGhrSldqTTRYS3Y3Z0J2QWdhS1laMC90aDNkclRKZjdhYTlH?=
 =?utf-8?B?eGhPL25NR2ZMdG5UcHpDd09iOC9BbVRnYTdWbGdIT0JDcmxTeXhUTG0zbUpw?=
 =?utf-8?B?UXUram8xRHdrQ3VrVG5jdE85cXpOUzFtSmNNd29zRFE1N0lCZmk2Yk9DdVM1?=
 =?utf-8?B?SVFRbTdCUWpzbXlDeFQ0YmM2NEVVOUxUY2RObWFxR2RsNTV0N3FNbUlhTEV4?=
 =?utf-8?B?bDU4N3N1Vk5XNTc3L2NaTkFoRkVMT3lGQjhOdTIrd1F4aGptVGtrYTVBazVq?=
 =?utf-8?B?cjJtclh4L1p2RDlIcTRCTkFsN3cyemxsWkV5TDMzSnYweG1DYkdiNG82cW5U?=
 =?utf-8?B?bEVjSTJtdEhzV0NGZTRRQW9pTlh4eVk4aHFjVkdZckVWSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:58.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e34b7c1-e34f-4764-a086-08dca4f39c13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

From: Alejandro Lucero <alucerop@amd.com>

CXL region creation involves allocating capacity from device DPA
(device-physical-address space) and assigning it to decode a given HPA
(host-physical-address space). Before determining how much DPA to
allocate the amount of available HPA must be determined. Also, not all
HPA is create equal, some specifically targets RAM, some target PMEM,
some is prepared for device-memory flows like HDM-D and HDM-DB, and some
is host-only (HDM-H).

Wrap all of those concerns into an API that retrieves a root decoder
(platform CXL window) that fits the specified constraints and the
capacity available for a new region.

Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8acdc347345b4f

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c          | 161 +++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                  |   3 +
 drivers/cxl/cxlmem.h               |   5 +
 drivers/net/ethernet/sfc/efx_cxl.c |  14 +++
 include/linux/cxl_accel_mem.h      |   9 ++
 5 files changed, 192 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 538ebd5a64fd..ca464bfef77b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -702,6 +702,167 @@ static int free_hpa(struct cxl_region *cxlr)
 	return 0;
 }
 
+
+struct cxlrd_max_context {
+	struct device * const *host_bridges;
+	int interleave_ways;
+	unsigned long flags;
+	resource_size_t max_hpa;
+	struct cxl_root_decoder *cxlrd;
+};
+
+static int find_max_hpa(struct device *dev, void *data)
+{
+	struct cxlrd_max_context *ctx = data;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
+	struct resource *res, *prev;
+	struct cxl_decoder *cxld;
+	resource_size_t max;
+	int found;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxld = &cxlrd->cxlsd.cxld;
+	if ((cxld->flags & ctx->flags) != ctx->flags) {
+		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
+			      cxld->flags, ctx->flags);
+		return 0;
+	}
+
+	/* A Host bridge could have more interleave ways than an
+	 * endpoint, couldn´t it?
+	 *
+	 * What does interleave ways mean here in terms of the requestor?
+	 * Why the FFMWS has 0 interleave ways but root port has 1?
+	 */
+	if (cxld->interleave_ways != ctx->interleave_ways) {
+		dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
+		return 0;
+	}
+
+	cxlsd = &cxlrd->cxlsd;
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	found = 0;
+	for (int i = 0; i < ctx->interleave_ways; i++)
+		for (int j = 0; j < ctx->interleave_ways; j++)
+			if (ctx->host_bridges[i] ==
+					cxlsd->target[j]->dport_dev) {
+				found++;
+				break;
+			}
+
+	if (found != ctx->interleave_ways) {
+		dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
+		return 0;
+	}
+
+	/*
+	 * Walk the root decoder resource range relying on cxl_region_rwsem to
+	 * preclude sibling arrival/departure and find the largest free space
+	 * gap.
+	 */
+	lockdep_assert_held_read(&cxl_region_rwsem);
+	max = 0;
+	res = cxlrd->res->child;
+	if (!res)
+		max = resource_size(cxlrd->res);
+	else
+		max = 0;
+
+	for (prev = NULL; res; prev = res, res = res->sibling) {
+		struct resource *next = res->sibling;
+		resource_size_t free = 0;
+
+		if (!prev && res->start > cxlrd->res->start) {
+			free = res->start - cxlrd->res->start;
+			max = max(free, max);
+		}
+		if (prev && res->start > prev->end + 1) {
+			free = res->start - prev->end + 1;
+			max = max(free, max);
+		}
+		if (next && res->end + 1 < next->start) {
+			free = next->start - res->end + 1;
+			max = max(free, max);
+		}
+		if (!next && res->end + 1 < cxlrd->res->end + 1) {
+			free = cxlrd->res->end + 1 - res->end + 1;
+			max = max(free, max);
+		}
+	}
+
+	if (max > ctx->max_hpa) {
+		if (ctx->cxlrd)
+			put_device(CXLRD_DEV(ctx->cxlrd));
+		get_device(CXLRD_DEV(cxlrd));
+		ctx->cxlrd = cxlrd;
+		ctx->max_hpa = max;
+		dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
+	}
+	return 0;
+}
+
+/**
+ * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
+ * @endpoint: an endpoint that is mapped by the returned decoder
+ * @interleave_ways: number of entries in @host_bridges
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
+ * @max: output parameter of bytes available in the returned decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
+ * is a point in time snapshot. If by the time the caller goes to use this root
+ * decoder's capacity the capacity is reduced then caller needs to loop and
+ * retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
+ * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
+ * does not race.
+ */
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max)
+{
+
+	struct cxlrd_max_context ctx = {
+		.host_bridges = &endpoint->host_bridge,
+		.interleave_ways = interleave_ways,
+		.flags = flags,
+	};
+	struct cxl_port *root_port;
+	struct cxl_root *root;
+
+	if (!is_cxl_endpoint(endpoint)) {
+		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	root = find_cxl_root(endpoint);
+	if (!root) {
+		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	root_port = &root->port;
+	down_read(&cxl_region_rwsem);
+	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
+	up_read(&cxl_region_rwsem);
+	put_device(&root_port->dev);
+
+	if (!ctx.cxlrd)
+		return ERR_PTR(-ENOMEM);
+
+	*max = ctx.max_hpa;
+	return ctx.cxlrd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
+
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9973430d975f..d3fdd2c1e066 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -770,6 +770,9 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
+
+#define CXLRD_DEV(cxlrd) &cxlrd->cxlsd.cxld.dev
+
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8f2a820bd92d..a0e0795ec064 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -877,4 +877,9 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 2cf4837ddfc1..6d49571ccff7 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -22,6 +22,7 @@ void efx_cxl_init(struct efx_nic *efx)
 {
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl = efx->cxl;
+	resource_size_t max = 0;
 	struct resource res;
 	u16 dvsec;
 
@@ -74,6 +75,19 @@ void efx_cxl_init(struct efx_nic *efx)
 	if (IS_ERR(cxl->endpoint))
 		pci_info(pci_dev, "CXL accel acquire endpoint failed");
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint, 1,
+					    CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					    &max);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_info(pci_dev, "CXL accel get HPA failed");
+		goto out;
+	}
+
+	if (max < EFX_CTPIO_BUFFER_SIZE)
+		pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
+				  max, EFX_CTPIO_BUFFER_SIZE);
+out:
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 }
 
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index 701910021df8..f3e77688ffe0 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -6,6 +6,10 @@
 #ifndef __CXL_ACCEL_MEM_H
 #define __CXL_ACCEL_MEM_H
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+
 enum accel_resource{
 	CXL_ACCEL_RES_DPA,
 	CXL_ACCEL_RES_RAM,
@@ -32,4 +36,9 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 
 struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
 void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
 #endif
-- 
2.17.1


