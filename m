Return-Path: <netdev+bounces-255633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN0GBR54f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:58:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC25C65EE
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA5C303715A
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15D24BBFD;
	Sun,  1 Feb 2026 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFWq/sT2"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69009242D70;
	Sun,  1 Feb 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961313; cv=fail; b=B/bdALk9ECelMl1iqtfgZYvBAnfdjkllUOMiIFj0hwRv9MyK1XhNnwrks6LeDws/QJrlSRGuheOnVv5Om2F6uOaIlOgwIDTRyW1d1NuAIHdYu3CIPT840LpDzEiA3B0OKWm4+o/uzkZt2f4IDV9aT75ef8JEGmSD07yJwxAcrrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961313; c=relaxed/simple;
	bh=oguIJEvU0F7XkNCtsfzBni5a65hgaQApoNSpyViMQJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQuUWj0DjlEyAPPUlZb36zNB7+1JbF0M8Apj+QTAeVQSMi1VBwCSt5W+3gDZCwpXU/FPhf7JTr8rtdnNLQdk9IM2GbFrPR0q9B4vzs6PfVqzbiljPVyGI3femWQiE/ADUUL3Hqwz+uwiR3NppUAHC3ey2ha3cScqXQICBA74QCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFWq/sT2; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsMFEcEcrwo6Xcuj6FoQdFDPizk19+W8hdxf7tY6rhF3TDyvxWDEVWCt6/UUnU9TOL1dsVi6YMKOL5d6MweL1SQgCdJOkhMp1gX/SdjosDm38NJZzJG6AwJQrgK2xIlV90cXwVflllk2QVHypkifP+W1XtgkTBZs8HzFPtjwGg5Uh1Djymlt9GA6bMDxkPziN9k40Pspr/xBTS3s19fCFDIx/MRWmCJzL0s77ONT++8sSYp2vnuuidD2rdtNTneuPQJRKUCw1b+PW3cNbqcCClz42nHrOtgpVIOXxQTkFjHjbkN4y28oSmpnCQLBWpCdA2ufbv5G3NrpQrInsarWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE0qBgO3Y1dECHogpGRjzUFdd62l/6L92BHZa4CsTeo=;
 b=SMzqEECJvYc4GDw8LRoZpdry8IHiSClvYhV/unpYRKiZiRhDoMo7MlULO5tAd+oM4Wrkl++jMz806kp8j/XhgntFlnNPmQpUzLyMcBsInfX1CKAsiK7YyB119K13iccLSIhZAI7GVwR5O9pipMMec1ZYxLmsa4WPH6jWzwhFBH4ziLceuGjogtWyb5clt2SygJ2dQNfM+k4ZCGGAnnXOIz91qebMsRUIfBacSfSSXV9688w7y+ukfizEVawJoeD3jKL2F352ee+eiwmkXEgetaKaMOBVWpE04XbdpZ5nYbE+HD8bfBOVoGrW86C8LVnTHOn7okjI9dVZWp324xqIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE0qBgO3Y1dECHogpGRjzUFdd62l/6L92BHZa4CsTeo=;
 b=vFWq/sT2RXskZK3RQvDa38wNymI0qMR26aLarFKtNOAXDyeLs1gyEho2PRGCcIq7JoOSRYHecJ+LtwyBSKIWlrUk0OA13vH54e8ulcymW3R6+PM4Tcq8k6vdQoHSO/lHWcksVPgqFjHC9yUpZw4K1RQvRd6LfPRDFOKLA1QgPNE=
Received: from DM6PR13CA0020.namprd13.prod.outlook.com (2603:10b6:5:bc::33) by
 CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Sun, 1 Feb 2026 15:55:08 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::fe) by DM6PR13CA0020.outlook.office365.com
 (2603:10b6:5:bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.9 via Frontend Transport; Sun, 1
 Feb 2026 15:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 07:55:05 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:04 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v23 12/22] cxl: Define a driver interface for HPA free space enumeration
Date: Sun, 1 Feb 2026 15:54:28 +0000
Message-ID: <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b120ef5-0250-47ef-4326-08de61aa45c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eM1sdWsOQu7WYoL4UFYm6BewVs9j76V6tO4ncAEum1TgOCbo5BFC9+8fcZbt?=
 =?us-ascii?Q?T7tGnAumymLjPM5Ijbcb42SF51h9R0JAy4XVKSv1+rSh716JZb7BMkADD6nB?=
 =?us-ascii?Q?E6kJC0FFCE4ytBK9DnY3yeq6/p2eiBxQPSpYNCoeGykuyaTDYaNgQ305mL8E?=
 =?us-ascii?Q?O3fd8wdw8WpCBKFbtsPFeJrx2fYB1e0kH21/24zV0TdyOKcUSns0pkeZIwTm?=
 =?us-ascii?Q?q4JssAyZWsi354keD7Kl2GdLsXt37gV7Yz3jJ8Ac94ekVDM+K8FU0TRko6gN?=
 =?us-ascii?Q?K2GVyujQbIa3novRf8VJ6oJQnDNxuMdvhFKmbbxISkI+3d/7z4C1eiCY53hS?=
 =?us-ascii?Q?gAeBCPOrUU1sm9G6FV0l9LzPJsp86y16YCcs5iyyiWmq0wKemt2+U9wqI0DJ?=
 =?us-ascii?Q?4qDbmObNHG7N5NEgYC6GWffVUQ1vOvmNDGkWuG2EwB48f0/sKWyLvh02rjC2?=
 =?us-ascii?Q?GvS/+Q92DpF8ws+wrT5SfjvTFH9dZg5yPrZsptjnuXw3z4wBqrcCQqrf7neM?=
 =?us-ascii?Q?SDDkiuIUcNmZ0++j8yOMKkkSrf+OVdTn5jzNvcS0Z5EWk1UWDZjDIhf6DtUi?=
 =?us-ascii?Q?JHkpA07wd+hhqJ6iDRgpeO5zWMGThR6vhk0ydMF5396yFeDcQaGWrL0MQ6WF?=
 =?us-ascii?Q?Io8PfxF8i2Qb1xLbazm0c1svREmSQP95ngwNkMhywGKX5NaGXTlPrEQwoNoF?=
 =?us-ascii?Q?18d3P/e19M+t1fUaSZ5DJjjxDsMwUtutLOGSsTNk17xTW8IfgJo+2ud4oQ6i?=
 =?us-ascii?Q?kSJDM2QiOoAL+M5H7Er+6lPq3NynBKkCi/YXQOrVeqwMtTKaBSPufZUozf3v?=
 =?us-ascii?Q?0T//TFvJlpaTKA4cuACjLRrsWBRjCQ5H+8MhOCDbJboPQkE3pNiLBRo2wyGI?=
 =?us-ascii?Q?a97Mg/5JiR4e7NtFYS8POdvB7aBZLuvcQjN84JjblPp+PMJbiJwuwtzzsb8Y?=
 =?us-ascii?Q?BcAOAUtCErmP3KReWEYFfQm79xe+DkDfMIHNdI403CLWtcR5Ng/qyeNaeGRA?=
 =?us-ascii?Q?KJlmK6j5WxFz1AdVcJjzsJHTJb8eLU7HnEAZea1V1yzmMvewrXS34szdNdZJ?=
 =?us-ascii?Q?CHcJCp3fbtvXe7u2vv+wkuW1y0ogtcUdLgmW9TLuh8MoTNcwHCX5aoqyksm1?=
 =?us-ascii?Q?RTU/LfZ7TXK845ietp4HdpPbbwxicmKTWlxytslaz60RESXC1hrZ7UORbUtI?=
 =?us-ascii?Q?2L1FiLROvzjdK6W5YYPudhbLIeTAA/x7wsj3qlSvhh7ENdbHf/1FBKwdCyfX?=
 =?us-ascii?Q?tZ+gPyIU2REerShCAXH3rMeQdxLwUmTdVfzNkTSOJ2ZrqBBbCqlFS+Nijbui?=
 =?us-ascii?Q?FXgQfXukIIL1DPaIeuSywiaeWHADqkubMUlxKg8CX85RK3QFhcf1+OzXY3ZC?=
 =?us-ascii?Q?bca7uAIN5q8LTd15IDkimuCYovRgeHu3n8q6Ainrb/pYh4FHb6GNfYH0qHxx?=
 =?us-ascii?Q?XDwcuoqn+y73C3Zmd3Yh9+Z5GCh8Iwzygh3bOB7F5rXYhV+8UaKvvwajFVN+?=
 =?us-ascii?Q?cMk1W0x92X255cg5E4rNl2iDWHeo/3WVtnEDmCpBOdRDWYeArqJ/7jYacq7e?=
 =?us-ascii?Q?5ztEfYzpsgluwC+/JG4piN+83wMEDJD3rv8TCwObo760oCH5xXANbYCcKqZ0?=
 =?us-ascii?Q?sDFTpTWn+19LPwQpdtMxvKimKbpRuUg5QXWFOwE179+IepEyPp2LhABznA1J?=
 =?us-ascii?Q?81jGcj5Y1Vvug+OqeHDZgjEkgZc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SYCkLpImoBlwRhYuXiBOPawf4jEWIWOHIdmedIXlmsZDdGwchapgwGoPRMuKy+9R2tG8LjZ4Mwvpg5ZN78G9/mJr+pYMQfrFjMVcZ6hwznvKFXQYWVXpPaTBgor8Exxp04j2NljlDw+d1Rh63n7huAMixrFeldDT5SoOf/7CkWoCKiXjq5/DVKqes6N3qOoAHC67eaS11eUnYFkn4qQlKTwHzmrydU56vjVYRGjT5PUZhqP6lBhu+ykyJOJ7QQ33OqaPiLbJ49kRqgjzM/ndVu1XqiTv728qJ71z7z+MkGWd/1u9S5139RmBqbb8qg3xkHgwaIcl3dAGkh3cb2hhkKrAOjjc6drCTl5OskF8QdXaEqOMXhdUXCVadXcxBgArH2ihTATMyeu2uiXQhJGwOgJVo7SH6k7qG9N46sL6ACFaAwhdo27/c5fAtw1xB0kw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:07.5460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b120ef5-0250-47ef-4326-08de61aa45c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-255633-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6AC25C65EE
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

CXL region creation involves allocating capacity from Device Physical
Address (DPA) and assigning it to decode a given Host Physical Address
(HPA). Before determining how much DPA to allocate the amount of available
HPA must be determined. Also, not all HPA is created equal, some HPA
targets RAM, some targets PMEM, some is prepared for device-memory flows
like HDM-D and HDM-DB, and some is HDM-H (host-only).

In order to support Type2 CXL devices, wrap all of those concerns into
an API that retrieves a root decoder (platform CXL window) that fits the
specified constraints and the capacity available for a new region.

Add a complementary function for releasing the reference to such root
decoder.

Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   6 ++
 3 files changed, 173 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 954b8fcdbac6..bdefd088f5f1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -705,6 +705,170 @@ static int free_hpa(struct cxl_region *cxlr)
 	return 0;
 }
 
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
+	resource_size_t free = 0;
+	resource_size_t max;
+	int found = 0;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxlsd = &cxlrd->cxlsd;
+	cxld = &cxlsd->cxld;
+
+	if ((cxld->flags & ctx->flags) != ctx->flags) {
+		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
+			cxld->flags, ctx->flags);
+		return 0;
+	}
+
+	for (int i = 0; i < ctx->interleave_ways; i++) {
+		for (int j = 0; j < ctx->interleave_ways; j++) {
+			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
+				found++;
+				break;
+			}
+		}
+	}
+
+	if (found != ctx->interleave_ways) {
+		dev_dbg(dev,
+			"Not enough host bridges. Found %d for %d interleave ways requested\n",
+			found, ctx->interleave_ways);
+		return 0;
+	}
+
+	/*
+	 * Walk the root decoder resource range relying on cxl_rwsem.region to
+	 * preclude sibling arrival/departure and find the largest free space
+	 * gap.
+	 */
+	lockdep_assert_held_read(&cxl_rwsem.region);
+	res = cxlrd->res->child;
+
+	/* With no resource child the whole parent resource is available */
+	if (!res)
+		max = resource_size(cxlrd->res);
+	else
+		max = 0;
+
+	for (prev = NULL; res; prev = res, res = res->sibling) {
+		if (!prev && res->start == cxlrd->res->start &&
+		    res->end == cxlrd->res->end) {
+			max = resource_size(cxlrd->res);
+			break;
+		}
+		/*
+		 * Sanity check for preventing arithmetic problems below as a
+		 * resource with size 0 could imply using the end field below
+		 * when set to unsigned zero - 1 or all f in hex.
+		 */
+		if (prev && !resource_size(prev))
+			continue;
+
+		if (!prev && res->start > cxlrd->res->start) {
+			free = res->start - cxlrd->res->start;
+			max = max(free, max);
+		}
+		if (prev && res->start > prev->end + 1) {
+			free = res->start - prev->end + 1;
+			max = max(free, max);
+		}
+	}
+
+	if (prev && prev->end + 1 < cxlrd->res->end + 1) {
+		free = cxlrd->res->end + 1 - prev->end + 1;
+		max = max(free, max);
+	}
+
+	dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
+	if (max > ctx->max_hpa) {
+		if (ctx->cxlrd)
+			put_device(cxlrd_dev(ctx->cxlrd));
+		get_device(cxlrd_dev(cxlrd));
+		ctx->cxlrd = cxlrd;
+		ctx->max_hpa = max;
+	}
+	return 0;
+}
+
+/**
+ * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
+ * @cxlmd: the mem device requiring the HPA
+ * @interleave_ways: number of entries in @host_bridges
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
+ * @max_avail_contig: output parameter of max contiguous bytes available in the
+ *		      returned decoder
+ *
+ * Returns a pointer to a struct cxl_root_decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
+ * in (@max_avail_contig))' is a point in time snapshot. If by the time the
+ * caller goes to use this decoder and its capacity is reduced then caller needs
+ * to loop and retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with cxl_put_root_decoder(cxlrd).
+ */
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max_avail_contig)
+{
+	struct cxlrd_max_context ctx = {
+		.flags = flags,
+		.interleave_ways = interleave_ways,
+	};
+	struct cxl_port *root_port;
+	struct cxl_port *endpoint;
+
+	endpoint = cxlmd->endpoint;
+	if (!endpoint) {
+		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	ctx.host_bridges = &endpoint->host_bridge;
+
+	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
+	if (!root) {
+		dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	root_port = &root->port;
+	scoped_guard(rwsem_read, &cxl_rwsem.region)
+		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
+
+	if (!ctx.cxlrd)
+		return ERR_PTR(-ENOMEM);
+
+	*max_avail_contig = ctx.max_hpa;
+	return ctx.cxlrd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
+
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
+{
+	put_device(cxlrd_dev(cxlrd));
+}
+EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 944c5d1ccceb..c7d9b2c2908f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -706,6 +706,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
+
+#define cxlrd_dev(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
+
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 92880c26b2d5..834dc7e78934 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -255,4 +255,10 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
 struct range;
 int cxl_get_region_range(struct cxl_region *region, struct range *range);
 void cxl_unregister_region(struct cxl_region *cxlr);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


