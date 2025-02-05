Return-Path: <netdev+bounces-163044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B6A29426
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7680F7A0FB0
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89A19068E;
	Wed,  5 Feb 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P+FTxmlG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7618F2DF;
	Wed,  5 Feb 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768815; cv=fail; b=ultSTF8U9Loae2n4UyAhYA0Ly4tw8Vb4P8vYXyT8UPM4RlJKvw7a/No8FkKnoCGjnivfYB4urC1fG5y2xXg+843urbLyWaBL5txvF81dMjzxcN/ZoWIS0cDACqqVf1Us8FpFD83Vsm7p19tnv0Ihtmg6puFLHYozL9WIXm3lVps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768815; c=relaxed/simple;
	bh=dByrgOsz9W+MQ82o5vwfFBqca8iHLeB1W6IJuysJ0Yo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVslnDjk9fWwINMu9oP6f9D8DY3nt/5VW/e74N8+ru165LMuYAmHrwjTxTqKZ73g0BQwXSkRbEt+KF+fS9rQdndXtg+vSUoHubgKhyKtz706SndCyXyUiSzAKGU8t1hHFcu1yzyQDhnWt5Rwa6IXvXL3Qtg+4GaLJsPNrY7dd84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P+FTxmlG; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIYPsLxyo9k4Jug5h5AhSVIYF/DmDJ9nsJshZZ1GvERatBYYqSxAptMDfOvn/8/fltU18GamwApdZ7kSTtLKSEVwU1YmIGhFDED+HiZOUZC9bOqvt+uSYRjfIoPpM3Fr1hWtyz3xKR7mWCtZJpbpH8qsglzXqSDOhVCJiSycnyYe1JXzgjgqg0Ia8xOcZq/ZYqKQrrS0tP8vOIglZFjMk0v1omt4XaOrGxhFqm303RpPHhFaKvNTzrBbPAbsw3Z3VbpsHPyMzJ2aJdKy4fAAAR+0U1com+yK+xgld1+8mLQ4vcdK3DWxhhQU+szL0kt1jyy9lXIVWACTv7yMxlFYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVYYVcmsaDQF7ftpNsFlWjB+9mlXHkUOp1aZ0wIKfIA=;
 b=hWb70Lggc1W/jT80df1n/w6tYsg6FRM+TTJ7GERvJav2BP1M2cLBICTycV5Ys1MpJ+qHKobAFmuzGaYRzIKxp1nVeQ6m57LLmV6Igp9Twm5vrPpetBBIrpL69OdbCA5kqSe36IypKaSFu96EbZMF0yAW7/Yr4j303Q+YCt06+NZ2nhbOPXq7LGdUGpTmem3iG2i2lGbWBgz9gdEiWXHSOnRSYWJDAyt/N/qiX2P1XX90VvEVZcMQxHt7KsH1dbmxNuKRvAjDaERR3qY90gUj8S53aozvPAnFPSwOYvqY9ujfOmZuCnUlixkazLIAmk2CCrZ3GoiYHERlUXKasYPSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVYYVcmsaDQF7ftpNsFlWjB+9mlXHkUOp1aZ0wIKfIA=;
 b=P+FTxmlGlv+PW+5cr3YeQgijokEOFp7YnF2QmINz/rCqJG/+r9Xp40q6XaVxFY4CnQbSlIDLabHaRixXp+Sm9KQXAxcFDbLQpjp1AqWw2pW27DF3laAuRtWE7Y/btc+rD7bsmsaUo5q2KMGZw5dj1E30xr6M7aqcAu5Jay0l3+o=
Received: from DS7P220CA0064.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::19) by
 DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.23; Wed, 5 Feb 2025 15:20:10 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::f2) by DS7P220CA0064.outlook.office365.com
 (2603:10b6:8:224::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 15:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:08 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:06 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 07/26] cxl: add support for setting media ready by an accel driver
Date: Wed, 5 Feb 2025 15:19:31 +0000
Message-ID: <20250205151950.25268-8-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: b32999c1-9303-4077-467c-08dd45f8949a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8c0FKEKbmR5VfY/M8tp4hm858rJAtj50HT+IxGjuGI6GxgzPBpxGMEG1u+wh?=
 =?us-ascii?Q?vBy9tftw5QZfzDaE49194kUVXyy+y6LusrOK07VUx9CKdak9ZoEld8qeN81i?=
 =?us-ascii?Q?luUuuzsPr1yFfDeKoLar5lOuZWADpH6rESLvNsQQ42qEctJIQEoVbgmxMzNK?=
 =?us-ascii?Q?AMD/Ej4Z/Lf9l+TPyye2fw8oSZlTx/k7M37SPQhbtUsL2NXqiOSsBwT7bbPM?=
 =?us-ascii?Q?JLgyjTwUX5/bUG/uzU+qPCfAtRMYRxI2HXsdEb1MI+5rwINb1LNbNljC+m2o?=
 =?us-ascii?Q?Qf1uuRv3zvw2MK5I4Uaa0EUg+Nu6gzAmpCxkzN1zcODU0R/C0ZS2fxGYGGrR?=
 =?us-ascii?Q?4HxQUl19BetMzoJ8Ii01iIkclYP6rUcjSt7bDvq46XLxKtRjdg6+mSv2osKe?=
 =?us-ascii?Q?0xxeH3vdzuneAahkoWGxNpGmjKWbRqE389cE10ez3dic2a7cuu3iMbb+f/6P?=
 =?us-ascii?Q?/KEh45HBfxWtdCQxdKoykJC1mLLk7/yCKok3jDXrcQhwv+3rLa8ukt5vyw+7?=
 =?us-ascii?Q?TMkyyypq6mds/TVkFiXHh/Zhwalct+HdolDbTDvquRkmsVPGWsQ/7P9X2+e0?=
 =?us-ascii?Q?+ECxOklIP6BLyxyX8LeNQk0HqZNkPj3K4cVZbrfGFNI3OlnTJHqAP3WDntbg?=
 =?us-ascii?Q?wNUjwoHcfrahCbS5caf2j+tg132VKOVOXtcXqCcX1WE1kMFrOOifcHGkrCP5?=
 =?us-ascii?Q?gDP6l0dVy68VDhLAJqsy6Fd6yeRaoHEGIvuKCDJrQpOucnsRXDeqSxkuSsee?=
 =?us-ascii?Q?o1VxU/5+7wrF3++PKLnhNVhy8+UnBCzWEgOaOlvQMcsMyVeKCsIoD4/tEB9B?=
 =?us-ascii?Q?iVuUljgOcajeHl6ZiBQuDpnoYwAkkhXBIB9gdOKL/23Wdg2rRzmUnF0l8WXi?=
 =?us-ascii?Q?tcUJ6AOhII7MP4MQ/CbzpycanNEKgDUqQ5EdgncqBWJpG2K98m6k+IzQHLXf?=
 =?us-ascii?Q?RDbaBLhwnuiikLBqF5/cm6YXhVefjRRt+c7bieo0MuoMk9XFWEPrKbwPxk5H?=
 =?us-ascii?Q?8AvMvnxO2Hg9RG+QSSUyLwA/GgA+orC4oj2O5H+ine83/RJso0UGmLI/Z0iw?=
 =?us-ascii?Q?wWCVyGBh1qekTI0040HcVBO0KroiPHvBC8lGkBYlbH22h4g+qzCpoE361wdh?=
 =?us-ascii?Q?RCmPnjlA8klunV9imkWyd8xpYlKh4NXKAH1MllTZ+ySR9EzIqmTxWeuunwNn?=
 =?us-ascii?Q?ZLtQzHwh7dJoDBpFXHBdWolvwn1ttE2gT0u+Pda3O3VPi3sMELKMAiNhMLPG?=
 =?us-ascii?Q?XbhZ67YpAwatQFKRel4NuPj6dIK4WBCeOEZIhU9mp0NAS5oxSKkiAKn/U3fG?=
 =?us-ascii?Q?gEm0JpNQBENd2M7XGMrrPVbSjbn7AbvXdlD35njX75P1IgdN6yQ4QgNRUqP4?=
 =?us-ascii?Q?nby4t9dmtSL3JZUxb98P/AI/KWt7y8d5TyeS5ehJWV0atMEmSCji6qeInp0e?=
 =?us-ascii?Q?qCChaLI+/PcNV4VaVJpcGofOZnJU2Ga2uCak+TA1XDn9JJa7ogs5aLCZks9q?=
 =?us-ascii?Q?1NhFIp8h/rynyCs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:10.3041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32999c1-9303-4077-467c-08dd45f8949a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver needs to set or initialize the device media
availability.

Modify cxl_await_media_ready for the argument being cxl_memdev_state
available from accel drivers, allowing the media device initialization
as currently supported for Type3.

A Type-2 driver may be required to set the memory availability explicitly,
for example because there is not a mailbox for doing so through a specific
command.

Add a function to the exported CXL API for accelerator drivers having this
possibility.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 11 ++++++++++-
 drivers/cxl/cxlmem.h   |  1 -
 drivers/cxl/pci.c      |  3 ++-
 include/cxl/cxl.h      |  2 ++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 08705c39721d..4461cababf6a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -177,8 +177,9 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
  * Wait up to @media_ready_timeout for the device to report memory
  * active.
  */
-int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+int cxl_await_media_ready(struct cxl_memdev_state *cxlmds)
 {
+	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	int rc, i, hdm_count;
@@ -211,6 +212,14 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
+void cxl_set_media_ready(struct cxl_memdev_state *cxlmds)
+{
+	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
+
+	cxlds->media_ready = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, "CXL");
+
 static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 62a459078ec3..ab8c23009b9d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -840,7 +840,6 @@ enum {
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
-int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index cf0991c423d1..5fe5f7ff4fb1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -12,6 +12,7 @@
 #include <linux/aer.h>
 #include <linux/io.h>
 #include <cxl/mailbox.h>
+#include <cxl/cxl.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
@@ -922,7 +923,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_await_media_ready(cxlds);
+	rc = cxl_await_media_ready(mds);
 	if (rc == 0)
 		cxlds->media_ready = true;
 	else
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 17bf86993a41..955e58103df6 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -46,4 +46,6 @@ struct pci_dev;
 struct cxl_dev_state;
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_memdev_state *cxlmds,
 			     unsigned long *caps);
+int cxl_await_media_ready(struct cxl_memdev_state *mds);
+void cxl_set_media_ready(struct cxl_memdev_state *mds);
 #endif
-- 
2.17.1


