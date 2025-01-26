Return-Path: <netdev+bounces-160967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D78A1C795
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87F81885FFB
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB51547C5;
	Sun, 26 Jan 2025 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZglcDXP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CC13AA3E
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892634; cv=fail; b=kMr19XhfUvEIvWszwoVWWvrbqOwRzH8HPRGh3o2VG/MbHVMaGfu7ckbBn0dBAl/weGgXh/EiNXN4L8yCz4C+jEz7EI4MbxHXgS7mruZQFEY84eABdGZLt+FCcuIIkk46L4vYkAdIcNVxKBA1/GwcRY8ep3IExV0K4g/Ue1hnRrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892634; c=relaxed/simple;
	bh=QHmENA3v1z9r1OlXlOPbRFoLyiFBK93HzPbcKz6dmpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojXxJ2sKoMAcq9QHhPVWDWF2kQM3nrS/b0qIXVP9b7df1WlgaOPuTYSrCzw5o3ZrXNLXVgQoqgOW9pw+Em+PJInSYe3TlRKOYdloDkUrepRDmHqYOoDziONotF78PoTFh5ZUTDarejxY3tSGktkuIrhm1Bqg3odj/nhpK2ReOl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZglcDXP; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axh6CEyRc1NQB9JEQsR33UN7Uepe37vYzODdQc8C01vCZHnhhuPpWu1E5+LDFh3qPd1xiizNCBZWI+j5B3TwCVaFkZyd+8Q4w93sVssonXxMW28GNzdny0flth6btovyptMWe3GBhmnNKOUvVoQko3DUQOXY83bi4pFhAwTqoD22iG0gp7wlHzYd5T1QTwqywzc19d5fTyWsfky75C4VxZrjK6cg7nvPSQwMAFejFfI5ftgM6hvXdrnCwYeRiRc6+QoAHrgTub4pkNPcGnB9i4Z7F+6V0lytV5HDtLtx6q8yWtCsxrV8GmveG1IJscgldxrXcIAJCgO9UDxV306kiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Smdmj4VmD1nNuQJ0+g0y9NtQqD1W326RhPvJsDcYOa0=;
 b=E60rsHNFQRa6bgnng4g68kou0ZmSvRFRMVqH7JDJODrQWAR++bOMPqwYrJieqZCSbi3KJdvnZ9LvdDgEM9vSF4U78IXOlX9XS+taafkqWEfwMnZjMfaj/j4jNGjuq3yT+XZtPrULPJ1aRfnu6lTbi4mRD3KgZSQ/nJQx+929qevwdct9796Yp6Zxc+3luBlFCL7Y3+xjiccxiQrUwFlc46UJp8mmu0OTA5wjmsonSZeKNirykNz8CnxYkrJvd+NQxhIZPURqBOiBO/QBn3BUpfzceMcN0HA1omivPhgSagJdxbXiA/no7fgV04Z/0Wdh9IZQkIk+qe6p71CX3FJmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smdmj4VmD1nNuQJ0+g0y9NtQqD1W326RhPvJsDcYOa0=;
 b=RZglcDXPxxvTfsZfCi1touFu/PMWYkDqCOtj5GDeYU3V83GXowZclpLw812KyyXYa0e+fOaXJG1WrD3mVuAMye68d3iV86srEB6/GJGrXS21fmqmpYFSSVBo/muYMWoZeg2l8la29oJVreR40xFfGzRnsLJ+xx9vM2BPyX51mUid85mCsw04z7Lb4hF3gbwJsIK8ZtoP8TLUEIs65L7Y1xL519TSQ/lAM8DH/0h+dbHQhDw50y8csTXI3CAAG/LtPd334oDVRr3/ba31KGOb2JD4C3S2eg2PEmapre4HsMn+K6gkR0XW00LPWTJU3N1JIBLYkILRdoZLyinkFshwgw==
Received: from PH8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:510:2cd::9)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sun, 26 Jan
 2025 11:57:02 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::26) by PH8PR07CA0002.outlook.office365.com
 (2603:10b6:510:2cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Sun,
 26 Jan 2025 11:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:56:53 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:56:50 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 01/14] module_common: Add a new file to all the common code for all module types
Date: Sun, 26 Jan 2025 13:56:22 +0200
Message-ID: <20250126115635.801935-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126115635.801935-1-danieller@nvidia.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c42a632-b567-4336-728b-08dd3e008bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afMkIBtw9qh1u0bjBptCqF0DjnLzvnR8v/iQ3bRUCWDEo8nrUaHR0MXnezne?=
 =?us-ascii?Q?5o5gDpAFJL2NPmDQli98pLbY/8yyRsU30nBqqAmaDX4Zpyp4yCTxk2Nwf/Ea?=
 =?us-ascii?Q?g3qTU1fqKvmJ99yZISoUXzGhlPECQ+9CUViT3FKXwKMxEDOFk8Ar5u2XSycf?=
 =?us-ascii?Q?BWfpjGmjOXfgDDkqMsADv5Ei7Vfa1yru6hoOzVNMF7X64GiGq7xJpnikzWOL?=
 =?us-ascii?Q?b8vjDgokwXIjr0MEMPFVuMsE8oDU6Bc8plVDRFe9hyW1F5hogPlzqN3+SxGH?=
 =?us-ascii?Q?8JOSYkwP1K7ApYpJjgGmJ8BvLIAv3ehv6C1N4q8aAv+mQYxOgpIjeh1IdVzs?=
 =?us-ascii?Q?+XXn161D5tFLJRVpPFiPNChBaV3eBSwfp9bN+siDwx/pogTGzBJIy/kn3LAU?=
 =?us-ascii?Q?r8sMhHapev41cwocNi+eFpUxPL2+x7qyeaciCNJf/G3p+AbUj5dwb3GAJc8d?=
 =?us-ascii?Q?BAFzkD3IZYrI1JofEO5HKsW0Bi0fW3/pM+TCqUOIYOF73wY5AkZW7SxmvF2K?=
 =?us-ascii?Q?g9xnnvzAuhXwj+iVHDI/hv4B6y9z+RBbdOeZOMPzyIrI9RcCdCT7R4YgFOKt?=
 =?us-ascii?Q?5PYCk1q6O8FsjqLNoRA2APdcf/KOSfnaO95Kt8uOr3lzujVSPW4hLrbUm/Lc?=
 =?us-ascii?Q?D4eLG5xiUuJFUIGn5Vj+Jv/L8ht0dPMyogfMAEaFX+DQXuaNcR6cAI754Wcc?=
 =?us-ascii?Q?BE04rkEYQvF5yCp8ZAlpBZd42FK2l44XC+IQ+pauqKTAwJyzgHd0OH9ZaDBd?=
 =?us-ascii?Q?GiGktJi8SvNeBggX8sWROnC8tohSpzmY+Rv7oGIiotS3QYDM9EvN/SxMc9TS?=
 =?us-ascii?Q?tzzkm8E5YgEaP9bMQTfw8t/UIaQ3uwgPmP0Xv2XSHFUM6hy+bQ5wnG28VVOJ?=
 =?us-ascii?Q?L4iTCtVYs5vjhCswVs+seT2rE4zPweLAc6nvwBQV+ANvgPPo29xOUX/jfZLk?=
 =?us-ascii?Q?W9NSaSf0UTv/ZHpyar8AfYl5WXd7oQsRFilD2DePEIjBGSolVQENha7Hclel?=
 =?us-ascii?Q?CbNU5tIlazyoPtCivXmzM0PmCRAxJE1ocm94TZoYw/EGknApiEa7UB1o6fpr?=
 =?us-ascii?Q?lM6ql8v4ffn7hiiYuScOd/M38NTW/PAWLB7oXh+w3DmLjI5SkrlBlCxahi24?=
 =?us-ascii?Q?ScjcNlP45Axd4scl8ZphAdZSonEFaqg6rnrSTR02ieEgm3Ec8CQOxp3scxWa?=
 =?us-ascii?Q?XkHMl3lXwmtapVpEgh1ScT7CGRExhXThZA8cnXhjmhGff4apmueidHyOJv0k?=
 =?us-ascii?Q?tkqthPIwGwicYf7A2mnll1cVDwmAONFuO/CtbNY0hVGOtmk9ZDbH5npu1z7v?=
 =?us-ascii?Q?MB7B2wWvAiskHbKSmkhRdMgbcvu/Tf+a93r/3R4lOtFbMcGIR5PtsZHuDfoX?=
 =?us-ascii?Q?P7pNYYe/8+sRckiqRUi6mwiYMcNsBVN6QeEKkXNTaenW/1r6ssURkrZ6iAfK?=
 =?us-ascii?Q?OVcagkRP25nLSAoQboU2qtWnVT5P5bjuQXFORWiq69K36hGe+MyKEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:02.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c42a632-b567-4336-728b-08dd3e008bd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

Currently, a significant amount of repetitive code exists across different
module type files.

Consolidate shared functions and definitions into a single, dedicated file
to improve organization and maintainability.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 Makefile.am             |   7 +-
 cmis.c                  | 212 ++++-------------
 cmis.h                  |  65 ------
 module-common.c         | 506 ++++++++++++++++++++++++++++++++++++++++
 module-common.h         | 281 ++++++++++++++++++++++
 netlink/module-eeprom.c |  26 +--
 qsfp.c                  | 301 +++++-------------------
 qsfp.h                  | 108 ---------
 sff-common.c            | 227 ------------------
 sff-common.h            |  77 ------
 sfpdiag.c               |   5 +-
 sfpid.c                 |  62 ++---
 12 files changed, 924 insertions(+), 953 deletions(-)
 create mode 100644 module-common.c
 create mode 100644 module-common.h

diff --git a/Makefile.am b/Makefile.am
index 5a61a9a..41290b4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -21,9 +21,10 @@ ethtool_SOURCES += \
 		  fec.c fec_8xx.c fsl_enetc.c ibm_emac.c ixgb.c ixgbe.c \
 		  natsemi.c pcnet32.c realtek.c tg3.c marvell.c vioc.c \
 		  smsc911x.c at76c50x-usb.c sfc.c stmmac.c	\
-		  sff-common.c sff-common.h sfpid.c sfpdiag.c	\
-		  ixgbevf.c tse.c vmxnet3.c qsfp.c qsfp.h fjes.c lan78xx.c \
-		  igc.c cmis.c cmis.h bnxt.c cpsw.c lan743x.c hns3.c
+		  sff-common.c sff-common.h module-common.c module-common.h \
+		  sfpid.c sfpdiag.c ixgbevf.c tse.c vmxnet3.c qsfp.c qsfp.h \
+		  fjes.c lan78xx.c igc.c cmis.c cmis.h bnxt.c cpsw.c lan743x.c \
+		  hns3.c
 endif
 
 if ENABLE_BASH_COMPLETION
diff --git a/cmis.c b/cmis.c
index 6fe5dfb..71f0745 100644
--- a/cmis.c
+++ b/cmis.c
@@ -11,7 +11,7 @@
 #include <math.h>
 #include <errno.h>
 #include "internal.h"
-#include "sff-common.h"
+#include "module-common.h"
 #include "cmis.h"
 #include "netlink/extapi.h"
 
@@ -36,93 +36,19 @@ struct cmis_memory_map {
 #define CMIS_PAGE_SIZE		0x80
 #define CMIS_I2C_ADDRESS	0x50
 
-static struct {
-	const char *str;
-	int offset;
-	__u8 value;	/* Alarm is on if (offset & value) != 0. */
-} cmis_aw_mod_flags[] = {
-	{ "Module temperature high alarm",
-	  CMIS_TEMP_AW_OFFSET, CMIS_TEMP_HALARM_STATUS },
-	{ "Module temperature low alarm",
-	  CMIS_TEMP_AW_OFFSET, CMIS_TEMP_LALARM_STATUS },
-	{ "Module temperature high warning",
-	  CMIS_TEMP_AW_OFFSET, CMIS_TEMP_HWARN_STATUS },
-	{ "Module temperature low warning",
-	  CMIS_TEMP_AW_OFFSET, CMIS_TEMP_LWARN_STATUS },
-
-	{ "Module voltage high alarm",
-	  CMIS_VCC_AW_OFFSET, CMIS_VCC_HALARM_STATUS },
-	{ "Module voltage low alarm",
-	  CMIS_VCC_AW_OFFSET, CMIS_VCC_LALARM_STATUS },
-	{ "Module voltage high warning",
-	  CMIS_VCC_AW_OFFSET, CMIS_VCC_HWARN_STATUS },
-	{ "Module voltage low warning",
-	  CMIS_VCC_AW_OFFSET, CMIS_VCC_LWARN_STATUS },
-
-	{ NULL, 0, 0 },
-};
-
-static struct {
-	const char *fmt_str;
-	int offset;
-	int adver_offset;	/* In Page 01h. */
-	__u8 adver_value;	/* Supported if (offset & value) != 0. */
-} cmis_aw_chan_flags[] = {
-	{ "Laser bias current high alarm   (Chan %d)",
-	  CMIS_TX_BIAS_AW_HALARM_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_TX_BIAS_MON_MASK },
-	{ "Laser bias current low alarm    (Chan %d)",
-	  CMIS_TX_BIAS_AW_LALARM_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_TX_BIAS_MON_MASK },
-	{ "Laser bias current high warning (Chan %d)",
-	  CMIS_TX_BIAS_AW_HWARN_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_TX_BIAS_MON_MASK },
-	{ "Laser bias current low warning  (Chan %d)",
-	  CMIS_TX_BIAS_AW_LWARN_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_TX_BIAS_MON_MASK },
-
-	{ "Laser tx power high alarm   (Channel %d)",
-	  CMIS_TX_PWR_AW_HALARM_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_TX_PWR_MON_MASK },
-	{ "Laser tx power low alarm    (Channel %d)",
-	  CMIS_TX_PWR_AW_LALARM_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_TX_PWR_MON_MASK },
-	{ "Laser tx power high warning (Channel %d)",
-	  CMIS_TX_PWR_AW_HWARN_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_TX_PWR_MON_MASK },
-	{ "Laser tx power low warning  (Channel %d)",
-	  CMIS_TX_PWR_AW_LWARN_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_TX_PWR_MON_MASK },
-
-	{ "Laser rx power high alarm   (Channel %d)",
-	  CMIS_RX_PWR_AW_HALARM_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_RX_PWR_MON_MASK },
-	{ "Laser rx power low alarm    (Channel %d)",
-	  CMIS_RX_PWR_AW_LALARM_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_RX_PWR_MON_MASK },
-	{ "Laser rx power high warning (Channel %d)",
-	  CMIS_RX_PWR_AW_HWARN_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_RX_PWR_MON_MASK },
-	{ "Laser rx power low warning  (Channel %d)",
-	  CMIS_RX_PWR_AW_LWARN_OFFSET,
-	  CMIS_DIAG_CHAN_ADVER_OFFSET, CMIS_RX_PWR_MON_MASK },
-
-	{ NULL, 0, 0, 0 },
-};
-
 static void cmis_show_identifier(const struct cmis_memory_map *map)
 {
-	sff8024_show_identifier(map->lower_memory, CMIS_ID_OFFSET);
+	module_show_identifier(map->lower_memory, CMIS_ID_OFFSET);
 }
 
 static void cmis_show_connector(const struct cmis_memory_map *map)
 {
-	sff8024_show_connector(map->page_00h, CMIS_CTOR_OFFSET);
+	module_show_connector(map->page_00h, CMIS_CTOR_OFFSET);
 }
 
 static void cmis_show_oui(const struct cmis_memory_map *map)
 {
-	sff8024_show_oui(map->page_00h, CMIS_VENDOR_OUI_OFFSET);
+	module_show_oui(map->page_00h, CMIS_VENDOR_OUI_OFFSET);
 }
 
 /**
@@ -154,7 +80,7 @@ cmis_show_signals_one(const struct cmis_memory_map *map, const char *name,
 		v |= map->upper_memory[i][0x11][off] << (i * 8);
 
 	if (map->page_01h[ioff] & imask)
-		sff_show_lane_status(name, i * 8, "Yes", "No", v);
+		module_show_lane_status(name, i * 8, "Yes", "No", v);
 }
 
 static void cmis_show_signals(const struct cmis_memory_map *map)
@@ -316,63 +242,11 @@ static void cmis_show_sig_integrity(const struct cmis_memory_map *map)
  */
 static void cmis_show_mit_compliance(const struct cmis_memory_map *map)
 {
-	static const char *cc = " (Copper cable,";
+	u16 value = map->page_00h[CMIS_MEDIA_INTF_TECH_OFFSET];
 
-	printf("\t%-41s : 0x%02x", "Transmitter technology",
-	       map->page_00h[CMIS_MEDIA_INTF_TECH_OFFSET]);
-
-	switch (map->page_00h[CMIS_MEDIA_INTF_TECH_OFFSET]) {
-	case CMIS_850_VCSEL:
-		printf(" (850 nm VCSEL)\n");
-		break;
-	case CMIS_1310_VCSEL:
-		printf(" (1310 nm VCSEL)\n");
-		break;
-	case CMIS_1550_VCSEL:
-		printf(" (1550 nm VCSEL)\n");
-		break;
-	case CMIS_1310_FP:
-		printf(" (1310 nm FP)\n");
-		break;
-	case CMIS_1310_DFB:
-		printf(" (1310 nm DFB)\n");
-		break;
-	case CMIS_1550_DFB:
-		printf(" (1550 nm DFB)\n");
-		break;
-	case CMIS_1310_EML:
-		printf(" (1310 nm EML)\n");
-		break;
-	case CMIS_1550_EML:
-		printf(" (1550 nm EML)\n");
-		break;
-	case CMIS_OTHERS:
-		printf(" (Others/Undefined)\n");
-		break;
-	case CMIS_1490_DFB:
-		printf(" (1490 nm DFB)\n");
-		break;
-	case CMIS_COPPER_UNEQUAL:
-		printf("%s unequalized)\n", cc);
-		break;
-	case CMIS_COPPER_PASS_EQUAL:
-		printf("%s passive equalized)\n", cc);
-		break;
-	case CMIS_COPPER_NF_EQUAL:
-		printf("%s near and far end limiting active equalizers)\n", cc);
-		break;
-	case CMIS_COPPER_F_EQUAL:
-		printf("%s far end limiting active equalizers)\n", cc);
-		break;
-	case CMIS_COPPER_N_EQUAL:
-		printf("%s near end limiting active equalizers)\n", cc);
-		break;
-	case CMIS_COPPER_LINEAR_EQUAL:
-		printf("%s linear active equalizers)\n", cc);
-		break;
-	}
+	module_show_mit_compliance(value);
 
-	if (map->page_00h[CMIS_MEDIA_INTF_TECH_OFFSET] >= CMIS_COPPER_UNEQUAL) {
+	if (value >= CMIS_COPPER_UNEQUAL) {
 		printf("\t%-41s : %udb\n", "Attenuation at 5GHz",
 		       map->page_00h[CMIS_COPPER_ATT_5GHZ]);
 		printf("\t%-41s : %udb\n", "Attenuation at 7GHz",
@@ -403,14 +277,14 @@ static void cmis_show_link_len(const struct cmis_memory_map *map)
 	cmis_print_smf_cbl_len(map);
 	if (!map->page_01h)
 		return;
-	sff_show_value_with_unit(map->page_01h, CMIS_OM5_LEN_OFFSET,
-				 "Length (OM5)", 2, "m");
-	sff_show_value_with_unit(map->page_01h, CMIS_OM4_LEN_OFFSET,
-				 "Length (OM4)", 2, "m");
-	sff_show_value_with_unit(map->page_01h, CMIS_OM3_LEN_OFFSET,
-				 "Length (OM3 50/125um)", 2, "m");
-	sff_show_value_with_unit(map->page_01h, CMIS_OM2_LEN_OFFSET,
-				 "Length (OM2 50/125um)", 1, "m");
+	module_show_value_with_unit(map->page_01h, CMIS_OM5_LEN_OFFSET,
+				    "Length (OM5)", 2, "m");
+	module_show_value_with_unit(map->page_01h, CMIS_OM4_LEN_OFFSET,
+				    "Length (OM4)", 2, "m");
+	module_show_value_with_unit(map->page_01h, CMIS_OM3_LEN_OFFSET,
+				    "Length (OM3 50/125um)", 2, "m");
+	module_show_value_with_unit(map->page_01h, CMIS_OM2_LEN_OFFSET,
+				    "Length (OM2 50/125um)", 1, "m");
 }
 
 /**
@@ -422,22 +296,22 @@ static void cmis_show_vendor_info(const struct cmis_memory_map *map)
 {
 	const char *clei;
 
-	sff_show_ascii(map->page_00h, CMIS_VENDOR_NAME_START_OFFSET,
-		       CMIS_VENDOR_NAME_END_OFFSET, "Vendor name");
+	module_show_ascii(map->page_00h, CMIS_VENDOR_NAME_START_OFFSET,
+			  CMIS_VENDOR_NAME_END_OFFSET, "Vendor name");
 	cmis_show_oui(map);
-	sff_show_ascii(map->page_00h, CMIS_VENDOR_PN_START_OFFSET,
-		       CMIS_VENDOR_PN_END_OFFSET, "Vendor PN");
-	sff_show_ascii(map->page_00h, CMIS_VENDOR_REV_START_OFFSET,
-		       CMIS_VENDOR_REV_END_OFFSET, "Vendor rev");
-	sff_show_ascii(map->page_00h, CMIS_VENDOR_SN_START_OFFSET,
-		       CMIS_VENDOR_SN_END_OFFSET, "Vendor SN");
-	sff_show_ascii(map->page_00h, CMIS_DATE_YEAR_OFFSET,
-		       CMIS_DATE_VENDOR_LOT_OFFSET + 1, "Date code");
+	module_show_ascii(map->page_00h, CMIS_VENDOR_PN_START_OFFSET,
+			  CMIS_VENDOR_PN_END_OFFSET, "Vendor PN");
+	module_show_ascii(map->page_00h, CMIS_VENDOR_REV_START_OFFSET,
+			  CMIS_VENDOR_REV_END_OFFSET, "Vendor rev");
+	module_show_ascii(map->page_00h, CMIS_VENDOR_SN_START_OFFSET,
+			  CMIS_VENDOR_SN_END_OFFSET, "Vendor SN");
+	module_show_ascii(map->page_00h, CMIS_DATE_YEAR_OFFSET,
+			  CMIS_DATE_VENDOR_LOT_OFFSET + 1, "Date code");
 
 	clei = (const char *)(map->page_00h + CMIS_CLEI_START_OFFSET);
 	if (*clei && strncmp(clei, CMIS_CLEI_BLANK, CMIS_CLEI_LEN))
-		sff_show_ascii(map->page_00h, CMIS_CLEI_START_OFFSET,
-			       CMIS_CLEI_END_OFFSET, "CLEI code");
+		module_show_ascii(map->page_00h, CMIS_CLEI_START_OFFSET,
+				  CMIS_CLEI_END_OFFSET, "CLEI code");
 }
 
 /* Print the current Module State. Relevant documents:
@@ -670,15 +544,6 @@ static void cmis_parse_dom(const struct cmis_memory_map *map,
 	cmis_parse_dom_chan_lvl_thresh(map, sd);
 }
 
-/* Print module-level monitoring values. Relevant documents:
- * [1] CMIS Rev. 5, page 110, section 8.2.5, Table 8-9
- */
-static void cmis_show_dom_mod_lvl_monitors(const struct sff_diags *sd)
-{
-	PRINT_TEMP("Module temperature", sd->sfp_temp[MCURR]);
-	PRINT_VCC("Module voltage", sd->sfp_voltage[MCURR]);
-}
-
 /* Print channel Tx laser bias current. Relevant documents:
  * [1] CMIS Rev. 5, page 165, section 8.9.4, Table 8-79
  */
@@ -806,10 +671,11 @@ static void cmis_show_dom_mod_lvl_flags(const struct cmis_memory_map *map)
 {
 	int i;
 
-	for (i = 0; cmis_aw_mod_flags[i].str; i++) {
-		printf("\t%-41s : %s\n", cmis_aw_mod_flags[i].str,
-		       map->lower_memory[cmis_aw_mod_flags[i].offset] &
-		       cmis_aw_mod_flags[i].value ? "On" : "Off");
+	for (i = 0; module_aw_mod_flags[i].str; i++) {
+		if (module_aw_mod_flags[i].type == MODULE_TYPE_CMIS)
+			printf("\t%-41s : %s\n", module_aw_mod_flags[i].str,
+			       map->lower_memory[module_aw_mod_flags[i].offset] &
+			       module_aw_mod_flags[i].value ? "On" : "Off");
 	}
 }
 
@@ -823,16 +689,16 @@ static void cmis_show_dom_chan_lvl_flags_chan(const struct cmis_memory_map *map,
 	const __u8 *page_11h = map->upper_memory[bank][0x11];
 	int i;
 
-	for (i = 0; cmis_aw_chan_flags[i].fmt_str; i++) {
+	for (i = 0; module_aw_chan_flags[i].fmt_str; i++) {
 		char str[80];
 
-		if (!(map->page_01h[cmis_aw_chan_flags[i].adver_offset] &
-		      cmis_aw_chan_flags[i].adver_value))
+		if (!(map->page_01h[module_aw_chan_flags[i].adver_offset] &
+		      module_aw_chan_flags[i].adver_value))
 			continue;
 
-		snprintf(str, 80, cmis_aw_chan_flags[i].fmt_str, chan + 1);
+		snprintf(str, 80, module_aw_chan_flags[i].fmt_str, chan + 1);
 		printf("\t%-41s : %s\n", str,
-		       page_11h[cmis_aw_chan_flags[i].offset] & chan ?
+		       page_11h[module_aw_chan_flags[i].offset] & chan ?
 		       "On" : "Off");
 	}
 }
@@ -876,7 +742,7 @@ static void cmis_show_dom(const struct cmis_memory_map *map)
 
 	cmis_parse_dom(map, &sd);
 
-	cmis_show_dom_mod_lvl_monitors(&sd);
+	module_show_dom_mod_lvl_monitors(&sd);
 	cmis_show_dom_chan_lvl_monitors(map, &sd);
 	cmis_show_dom_mod_lvl_flags(map);
 	cmis_show_dom_chan_lvl_flags(map);
diff --git a/cmis.h b/cmis.h
index cee2a38..007632a 100644
--- a/cmis.h
+++ b/cmis.h
@@ -16,18 +16,6 @@
 #define CMIS_MODULE_STATE_MODULE_PWR_DN		0x04
 #define CMIS_MODULE_STATE_MODULE_FAULT		0x05
 
-/* Module Flags (Page 0) */
-#define CMIS_VCC_AW_OFFSET			0x09
-#define CMIS_VCC_LWARN_STATUS			0x80
-#define CMIS_VCC_HWARN_STATUS			0x40
-#define CMIS_VCC_LALARM_STATUS			0x20
-#define CMIS_VCC_HALARM_STATUS			0x10
-#define CMIS_TEMP_AW_OFFSET			0x09
-#define CMIS_TEMP_LWARN_STATUS			0x08
-#define CMIS_TEMP_HWARN_STATUS			0x04
-#define CMIS_TEMP_LALARM_STATUS			0x02
-#define CMIS_TEMP_HALARM_STATUS			0x01
-
 #define CMIS_MODULE_TYPE_OFFSET			0x55
 #define CMIS_MT_MMF				0x01
 #define CMIS_MT_SMF				0x02
@@ -115,22 +103,6 @@
 
 /* Media interface technology */
 #define CMIS_MEDIA_INTF_TECH_OFFSET		0xD4
-#define CMIS_850_VCSEL				0x00
-#define CMIS_1310_VCSEL				0x01
-#define CMIS_1550_VCSEL				0x02
-#define CMIS_1310_FP				0x03
-#define CMIS_1310_DFB				0x04
-#define CMIS_1550_DFB				0x05
-#define CMIS_1310_EML				0x06
-#define CMIS_1550_EML				0x07
-#define CMIS_OTHERS				0x08
-#define CMIS_1490_DFB				0x09
-#define CMIS_COPPER_UNEQUAL			0x0A
-#define CMIS_COPPER_PASS_EQUAL			0x0B
-#define CMIS_COPPER_NF_EQUAL			0x0C
-#define CMIS_COPPER_F_EQUAL			0x0D
-#define CMIS_COPPER_N_EQUAL			0x0E
-#define CMIS_COPPER_LINEAR_EQUAL		0x0F
 
 /*-----------------------------------------------------------------------
  * Upper Memory Page 0x01: contains advertising fields that define properties
@@ -178,10 +150,6 @@
 #define CMIS_DIAG_FL_RX_LOS			(1 << 1)
 
 /* Supported Monitors Advertisement (Page 1) */
-#define CMIS_DIAG_CHAN_ADVER_OFFSET		0xA0
-#define CMIS_TX_BIAS_MON_MASK			0x01
-#define CMIS_TX_PWR_MON_MASK			0x02
-#define CMIS_RX_PWR_MON_MASK			0x04
 #define CMIS_TX_BIAS_MUL_MASK			0x18
 #define CMIS_TX_BIAS_MUL_1			0x00
 #define CMIS_TX_BIAS_MUL_2			0x08
@@ -231,39 +199,6 @@
 #define CMIS_RX_PWR_HWARN_OFFSET		0xC4
 #define CMIS_RX_PWR_LWARN_OFFSET		0xC6
 
-/*-----------------------------------------------------------------------
- * Upper Memory Page 0x11: Optional Page that contains lane dynamic status
- * bytes.
- */
-
-/* Media Lane-Specific Flags (Page 0x11) */
-#define CMIS_TX_FAIL_OFFSET			0x87
-#define CMIS_TX_LOS_OFFSET			0x88
-#define CMIS_TX_LOL_OFFSET			0x89
-#define CMIS_TX_EQ_FAIL_OFFSET			0x8a
-#define CMIS_TX_PWR_AW_HALARM_OFFSET		0x8B
-#define CMIS_TX_PWR_AW_LALARM_OFFSET		0x8C
-#define CMIS_TX_PWR_AW_HWARN_OFFSET		0x8D
-#define CMIS_TX_PWR_AW_LWARN_OFFSET		0x8E
-#define CMIS_TX_BIAS_AW_HALARM_OFFSET		0x8F
-#define CMIS_TX_BIAS_AW_LALARM_OFFSET		0x90
-#define CMIS_TX_BIAS_AW_HWARN_OFFSET		0x91
-#define CMIS_TX_BIAS_AW_LWARN_OFFSET		0x92
-#define CMIS_RX_LOS_OFFSET			0x93
-#define CMIS_RX_LOL_OFFSET			0x94
-#define CMIS_RX_PWR_AW_HALARM_OFFSET		0x95
-#define CMIS_RX_PWR_AW_LALARM_OFFSET		0x96
-#define CMIS_RX_PWR_AW_HWARN_OFFSET		0x97
-#define CMIS_RX_PWR_AW_LWARN_OFFSET		0x98
-
-/* Media Lane-Specific Monitors (Page 0x11) */
-#define CMIS_TX_PWR_OFFSET			0x9A
-#define CMIS_TX_BIAS_OFFSET			0xAA
-#define CMIS_RX_PWR_OFFSET			0xBA
-
-#define YESNO(x) (((x) != 0) ? "Yes" : "No")
-#define ONOFF(x) (((x) != 0) ? "On" : "Off")
-
 void cmis_show_all_ioctl(const __u8 *id);
 
 int cmis_show_all_nl(struct cmd_context *ctx);
diff --git a/module-common.c b/module-common.c
new file mode 100644
index 0000000..ec61b1e
--- /dev/null
+++ b/module-common.c
@@ -0,0 +1,506 @@
+/*
+ * module-common.c: Implements common utilities across CMIS, SFF-8436/8636
+ * and SFF-8472/8079.
+ */
+
+#include <stdio.h>
+#include <math.h>
+#include "module-common.h"
+
+const struct module_aw_mod module_aw_mod_flags[] = {
+	{ MODULE_TYPE_CMIS, "Module temperature high alarm",
+	  CMIS_TEMP_AW_OFFSET, CMIS_TEMP_HALARM_STATUS },
+	{ MODULE_TYPE_CMIS, "Module temperature low alarm",
+	  CMIS_TEMP_AW_OFFSET, CMIS_TEMP_LALARM_STATUS },
+	{ MODULE_TYPE_CMIS, "Module temperature high warning",
+	  CMIS_TEMP_AW_OFFSET, CMIS_TEMP_HWARN_STATUS },
+	{ MODULE_TYPE_CMIS, "Module temperature low warning",
+	  CMIS_TEMP_AW_OFFSET, CMIS_TEMP_LWARN_STATUS },
+
+	{ MODULE_TYPE_CMIS, "Module voltage high alarm",
+	  CMIS_VCC_AW_OFFSET, CMIS_VCC_HALARM_STATUS },
+	{ MODULE_TYPE_CMIS, "Module voltage low alarm",
+	  CMIS_VCC_AW_OFFSET, CMIS_VCC_LALARM_STATUS },
+	{ MODULE_TYPE_CMIS, "Module voltage high warning",
+	  CMIS_VCC_AW_OFFSET, CMIS_VCC_HWARN_STATUS },
+	{ MODULE_TYPE_CMIS, "Module voltage low warning",
+	  CMIS_VCC_AW_OFFSET, CMIS_VCC_LWARN_STATUS },
+
+	{ MODULE_TYPE_SFF8636, "Module temperature high alarm",
+	  SFF8636_TEMP_AW_OFFSET, (SFF8636_TEMP_HALARM_STATUS) },
+	{ MODULE_TYPE_SFF8636, "Module temperature low alarm",
+	  SFF8636_TEMP_AW_OFFSET, (SFF8636_TEMP_LALARM_STATUS) },
+	{ MODULE_TYPE_SFF8636, "Module temperature high warning",
+	  SFF8636_TEMP_AW_OFFSET, (SFF8636_TEMP_HWARN_STATUS) },
+	{ MODULE_TYPE_SFF8636, "Module temperature low warning",
+	  SFF8636_TEMP_AW_OFFSET, (SFF8636_TEMP_LWARN_STATUS) },
+
+	{ MODULE_TYPE_SFF8636, "Module voltage high alarm",
+	  SFF8636_VCC_AW_OFFSET, (SFF8636_VCC_HALARM_STATUS) },
+	{ MODULE_TYPE_SFF8636, "Module voltage low alarm",
+	  SFF8636_VCC_AW_OFFSET, (SFF8636_VCC_LALARM_STATUS) },
+	{ MODULE_TYPE_SFF8636, "Module voltage high warning",
+	  SFF8636_VCC_AW_OFFSET, (SFF8636_VCC_HWARN_STATUS) },
+	{ MODULE_TYPE_SFF8636, "Module voltage low warning",
+	  SFF8636_VCC_AW_OFFSET, (SFF8636_VCC_LWARN_STATUS) },
+
+	{ 0, NULL, 0, 0 },
+};
+
+const struct module_aw_chan module_aw_chan_flags[] = {
+	{ MODULE_TYPE_CMIS, "Laser bias current high alarm",
+	  CMIS_TX_BIAS_AW_HALARM_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_TX_BIAS_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser bias current low alarm",
+	  CMIS_TX_BIAS_AW_LALARM_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_TX_BIAS_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser bias current high warning",
+	  CMIS_TX_BIAS_AW_HWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_TX_BIAS_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser bias current low warning",
+	  CMIS_TX_BIAS_AW_LWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_TX_BIAS_MON_MASK },
+
+	{ MODULE_TYPE_CMIS, "Laser tx power high alarm",
+	  CMIS_TX_PWR_AW_HALARM_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_TX_PWR_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser tx power low alarm",
+	  CMIS_TX_PWR_AW_LALARM_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_TX_PWR_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser tx power high warning",
+	  CMIS_TX_PWR_AW_HWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_TX_PWR_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser tx power low warning",
+	  CMIS_TX_PWR_AW_LWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_TX_PWR_MON_MASK },
+
+	{ MODULE_TYPE_CMIS, "Laser rx power high alarm",
+	  CMIS_RX_PWR_AW_HALARM_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_RX_PWR_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser rx power low alarm",
+	  CMIS_RX_PWR_AW_LALARM_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_RX_PWR_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser rx power high warning",
+	  CMIS_RX_PWR_AW_HWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_RX_PWR_MON_MASK },
+	{ MODULE_TYPE_CMIS, "Laser rx power low warning",
+	  CMIS_RX_PWR_AW_LWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
+	  CMIS_RX_PWR_MON_MASK },
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 1)",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 1)",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 1)",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 1)",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 2)",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 2)",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 2)",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 2)",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 3)",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 3)",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 3)",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 3)",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 4)",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 4)",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 4)",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 4)",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 1)",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 1)",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 1)",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 1)",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 2)",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 2)",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 2)",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 2)",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 3)",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 3)",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 3)",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 3)",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 4)",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 4)",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 4)",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 4)",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 1)",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 1)",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 1)",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 1)",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 2)",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 2)",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 2)",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 2)",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 3)",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 3)",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 3)",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 3)",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 4)",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 4)",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 4)",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 4)",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LWARN) },
+
+	{ 0, NULL, 0, 0, 0 },
+};
+
+void module_show_value_with_unit(const __u8 *id, unsigned int reg,
+				 const char *name, unsigned int mult,
+				 const char *unit)
+{
+	unsigned int val = id[reg];
+
+	printf("\t%-41s : %u%s\n", name, val * mult, unit);
+}
+
+void module_show_ascii(const __u8 *id, unsigned int first_reg,
+		       unsigned int last_reg, const char *name)
+{
+	unsigned int reg, val;
+
+	printf("\t%-41s : ", name);
+	while (first_reg <= last_reg && id[last_reg] == ' ')
+		last_reg--;
+	for (reg = first_reg; reg <= last_reg; reg++) {
+		val = id[reg];
+		putchar(((val >= 32) && (val <= 126)) ? val : '_');
+	}
+	printf("\n");
+}
+
+void module_show_lane_status(const char *name, unsigned int lane_cnt,
+			     const char *yes, const char *no,
+			     unsigned int value)
+{
+	printf("\t%-41s : ", name);
+	if (!value) {
+		printf("None\n");
+		return;
+	}
+
+	printf("[");
+	while (lane_cnt--) {
+		printf(" %s%c", value & 1 ? yes : no, lane_cnt ? ',': ' ');
+		value >>= 1;
+	}
+	printf("]\n");
+}
+
+void module_show_oui(const __u8 *id, int id_offset)
+{
+	printf("\t%-41s : %02x:%02x:%02x\n", "Vendor OUI",
+		      id[id_offset], id[(id_offset) + 1],
+		      id[(id_offset) + 2]);
+}
+
+void module_show_identifier(const __u8 *id, int id_offset)
+{
+	printf("\t%-41s : 0x%02x", "Identifier", id[id_offset]);
+	switch (id[id_offset]) {
+	case MODULE_ID_UNKNOWN:
+		printf(" (no module present, unknown, or unspecified)\n");
+		break;
+	case MODULE_ID_GBIC:
+		printf(" (GBIC)\n");
+		break;
+	case MODULE_ID_SOLDERED_MODULE:
+		printf(" (module soldered to motherboard)\n");
+		break;
+	case MODULE_ID_SFP:
+		printf(" (SFP)\n");
+		break;
+	case MODULE_ID_300_PIN_XBI:
+		printf(" (300 pin XBI)\n");
+		break;
+	case MODULE_ID_XENPAK:
+		printf(" (XENPAK)\n");
+		break;
+	case MODULE_ID_XFP:
+		printf(" (XFP)\n");
+		break;
+	case MODULE_ID_XFF:
+		printf(" (XFF)\n");
+		break;
+	case MODULE_ID_XFP_E:
+		printf(" (XFP-E)\n");
+		break;
+	case MODULE_ID_XPAK:
+		printf(" (XPAK)\n");
+		break;
+	case MODULE_ID_X2:
+		printf(" (X2)\n");
+		break;
+	case MODULE_ID_DWDM_SFP:
+		printf(" (DWDM-SFP)\n");
+		break;
+	case MODULE_ID_QSFP:
+		printf(" (QSFP)\n");
+		break;
+	case MODULE_ID_QSFP_PLUS:
+		printf(" (QSFP+)\n");
+		break;
+	case MODULE_ID_CXP:
+		printf(" (CXP)\n");
+		break;
+	case MODULE_ID_HD4X:
+		printf(" (Shielded Mini Multilane HD 4X)\n");
+		break;
+	case MODULE_ID_HD8X:
+		printf(" (Shielded Mini Multilane HD 8X)\n");
+		break;
+	case MODULE_ID_QSFP28:
+		printf(" (QSFP28)\n");
+		break;
+	case MODULE_ID_CXP2:
+		printf(" (CXP2/CXP28)\n");
+		break;
+	case MODULE_ID_CDFP:
+		printf(" (CDFP Style 1/Style 2)\n");
+		break;
+	case MODULE_ID_HD4X_FANOUT:
+		printf(" (Shielded Mini Multilane HD 4X Fanout Cable)\n");
+		break;
+	case MODULE_ID_HD8X_FANOUT:
+		printf(" (Shielded Mini Multilane HD 8X Fanout Cable)\n");
+		break;
+	case MODULE_ID_CDFP_S3:
+		printf(" (CDFP Style 3)\n");
+		break;
+	case MODULE_ID_MICRO_QSFP:
+		printf(" (microQSFP)\n");
+		break;
+	case MODULE_ID_QSFP_DD:
+		printf(" (QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628))\n");
+		break;
+	case MODULE_ID_OSFP:
+		printf(" (OSFP 8X Pluggable Transceiver)\n");
+		break;
+	case MODULE_ID_DSFP:
+		printf(" (DSFP Dual Small Form Factor Pluggable Transceiver)\n");
+		break;
+	case MODULE_ID_QSFP_PLUS_CMIS:
+		printf(" (QSFP+ or later with Common Management Interface Specification (CMIS))\n");
+		break;
+	case MODULE_ID_SFP_DD_CMIS:
+		printf(" (SFP-DD Double Density 2X Pluggable Transceiver with Common Management Interface Specification (CMIS))\n");
+		break;
+	case MODULE_ID_SFP_PLUS_CMIS:
+		printf(" (SFP+ and later with Common Management Interface Specification (CMIS))\n");
+		break;
+	default:
+		printf(" (reserved or unknown)\n");
+		break;
+	}
+}
+
+void module_show_connector(const __u8 *id, int ctor_offset)
+{
+	printf("\t%-41s : 0x%02x", "Connector", id[ctor_offset]);
+	switch (id[ctor_offset]) {
+	case  MODULE_CTOR_UNKNOWN:
+		printf(" (unknown or unspecified)\n");
+		break;
+	case MODULE_CTOR_SC:
+		printf(" (SC)\n");
+		break;
+	case MODULE_CTOR_FC_STYLE_1:
+		printf(" (Fibre Channel Style 1 copper)\n");
+		break;
+	case MODULE_CTOR_FC_STYLE_2:
+		printf(" (Fibre Channel Style 2 copper)\n");
+		break;
+	case MODULE_CTOR_BNC_TNC:
+		printf(" (BNC/TNC)\n");
+		break;
+	case MODULE_CTOR_FC_COAX:
+		printf(" (Fibre Channel coaxial headers)\n");
+		break;
+	case MODULE_CTOR_FIBER_JACK:
+		printf(" (FibreJack)\n");
+		break;
+	case MODULE_CTOR_LC:
+		printf(" (LC)\n");
+		break;
+	case MODULE_CTOR_MT_RJ:
+		printf(" (MT-RJ)\n");
+		break;
+	case MODULE_CTOR_MU:
+		printf(" (MU)\n");
+		break;
+	case MODULE_CTOR_SG:
+		printf(" (SG)\n");
+		break;
+	case MODULE_CTOR_OPT_PT:
+		printf(" (Optical pigtail)\n");
+		break;
+	case MODULE_CTOR_MPO:
+		printf(" (MPO Parallel Optic)\n");
+		break;
+	case MODULE_CTOR_MPO_2:
+		printf(" (MPO Parallel Optic - 2x16)\n");
+		break;
+	case MODULE_CTOR_HSDC_II:
+		printf(" (HSSDC II)\n");
+		break;
+	case MODULE_CTOR_COPPER_PT:
+		printf(" (Copper pigtail)\n");
+		break;
+	case MODULE_CTOR_RJ45:
+		printf(" (RJ45)\n");
+		break;
+	case MODULE_CTOR_NO_SEPARABLE:
+		printf(" (No separable connector)\n");
+		break;
+	case MODULE_CTOR_MXC_2x16:
+		printf(" (MXC 2x16)\n");
+		break;
+	case MODULE_CTOR_CS_OPTICAL:
+		printf(" (CS optical connector)\n");
+		break;
+	case MODULE_CTOR_CS_OPTICAL_MINI:
+		printf(" (Mini CS optical connector)\n");
+		break;
+	case MODULE_CTOR_MPO_2X12:
+		printf(" (MPO 2x12)\n");
+		break;
+	case MODULE_CTOR_MPO_1X16:
+		printf(" (MPO 1x16)\n");
+		break;
+	default:
+		printf(" (reserved or unknown)\n");
+		break;
+	}
+}
+
+void module_show_mit_compliance(u16 value)
+{
+	static const char *cc = " (Copper cable,";
+
+	printf("\t%-41s : 0x%02x", "Transmitter technology", value);
+
+	switch (value) {
+	case MODULE_850_VCSEL:
+		printf(" (850 nm VCSEL)\n");
+		break;
+	case CMIS_1310_VCSEL:
+	case SFF8636_TRANS_1310_VCSEL:
+		printf(" (1310 nm VCSEL)\n");
+		break;
+	case CMIS_1550_VCSEL:
+	case SFF8636_TRANS_1550_VCSEL:
+		printf(" (1550 nm VCSEL)\n");
+		break;
+	case CMIS_1310_FP:
+	case SFF8636_TRANS_1310_FP:
+		printf(" (1310 nm FP)\n");
+		break;
+	case CMIS_1310_DFB:
+	case SFF8636_TRANS_1310_DFB:
+		printf(" (1310 nm DFB)\n");
+		break;
+	case CMIS_1550_DFB:
+	case SFF8636_TRANS_1550_DFB:
+		printf(" (1550 nm DFB)\n");
+		break;
+	case CMIS_1310_EML:
+	case SFF8636_TRANS_1310_EML:
+		printf(" (1310 nm EML)\n");
+		break;
+	case CMIS_1550_EML:
+	case SFF8636_TRANS_1550_EML:
+		printf(" (1550 nm EML)\n");
+		break;
+	case CMIS_OTHERS:
+	case SFF8636_TRANS_OTHERS:
+		printf(" (Others/Undefined)\n");
+		break;
+	case CMIS_1490_DFB:
+	case SFF8636_TRANS_1490_DFB:
+		printf(" (1490 nm DFB)\n");
+		break;
+	case CMIS_COPPER_UNEQUAL:
+	case SFF8636_TRANS_COPPER_PAS_UNEQUAL:
+		printf("%s unequalized)\n", cc);
+		break;
+	case CMIS_COPPER_PASS_EQUAL:
+	case SFF8636_TRANS_COPPER_PAS_EQUAL:
+		printf("%s passive equalized)\n", cc);
+		break;
+	case CMIS_COPPER_NF_EQUAL:
+	case SFF8636_TRANS_COPPER_LNR_FAR_EQUAL:
+		printf("%s near and far end limiting active equalizers)\n", cc);
+		break;
+	case CMIS_COPPER_F_EQUAL:
+	case SFF8636_TRANS_COPPER_FAR_EQUAL:
+		printf("%s far end limiting active equalizers)\n", cc);
+		break;
+	case CMIS_COPPER_N_EQUAL:
+	case SFF8636_TRANS_COPPER_NEAR_EQUAL:
+		printf("%s near end limiting active equalizers)\n", cc);
+		break;
+	case CMIS_COPPER_LINEAR_EQUAL:
+	case SFF8636_TRANS_COPPER_LNR_EQUAL:
+		printf("%s linear active equalizers)\n", cc);
+		break;
+	}
+}
+
+void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd)
+{
+	PRINT_TEMP("Module temperature", sd->sfp_temp[MCURR]);
+	PRINT_VCC("Module voltage", sd->sfp_voltage[MCURR]);
+}
diff --git a/module-common.h b/module-common.h
new file mode 100644
index 0000000..8c34779
--- /dev/null
+++ b/module-common.h
@@ -0,0 +1,281 @@
+/*
+ * module-common.h: Declares common utilities across CMIS, SFF-8436/8636
+ * and SFF-8472/8079.
+ */
+
+#ifndef MODULE_COMMON_H__
+#define MODULE_COMMON_H__
+
+#include <stdio.h>
+#include "internal.h"
+#include "sff-common.h"
+
+enum module_type {
+	MODULE_TYPE_SFF8636,
+	MODULE_TYPE_CMIS,
+};
+
+#define  MODULE_ID_OFFSET				0x00
+#define  MODULE_ID_UNKNOWN				0x00
+#define  MODULE_ID_GBIC				0x01
+#define  MODULE_ID_SOLDERED_MODULE		0x02
+#define  MODULE_ID_SFP					0x03
+#define  MODULE_ID_300_PIN_XBI			0x04
+#define  MODULE_ID_XENPAK				0x05
+#define  MODULE_ID_XFP					0x06
+#define  MODULE_ID_XFF					0x07
+#define  MODULE_ID_XFP_E				0x08
+#define  MODULE_ID_XPAK				0x09
+#define  MODULE_ID_X2					0x0A
+#define  MODULE_ID_DWDM_SFP			0x0B
+#define  MODULE_ID_QSFP				0x0C
+#define  MODULE_ID_QSFP_PLUS			0x0D
+#define  MODULE_ID_CXP					0x0E
+#define  MODULE_ID_HD4X				0x0F
+#define  MODULE_ID_HD8X				0x10
+#define  MODULE_ID_QSFP28				0x11
+#define  MODULE_ID_CXP2				0x12
+#define  MODULE_ID_CDFP				0x13
+#define  MODULE_ID_HD4X_FANOUT			0x14
+#define  MODULE_ID_HD8X_FANOUT			0x15
+#define  MODULE_ID_CDFP_S3				0x16
+#define  MODULE_ID_MICRO_QSFP			0x17
+#define  MODULE_ID_QSFP_DD				0x18
+#define  MODULE_ID_OSFP				0x19
+#define  MODULE_ID_DSFP				0x1B
+#define  MODULE_ID_QSFP_PLUS_CMIS			0x1E
+#define  MODULE_ID_SFP_DD_CMIS				0x1F
+#define  MODULE_ID_SFP_PLUS_CMIS			0x20
+#define  MODULE_ID_LAST				MODULE_ID_SFP_PLUS_CMIS
+#define  MODULE_ID_UNALLOCATED_LAST	0x7F
+#define  MODULE_ID_VENDOR_START		0x80
+#define  MODULE_ID_VENDOR_LAST			0xFF
+
+#define  MODULE_CTOR_UNKNOWN			0x00
+#define  MODULE_CTOR_SC				0x01
+#define  MODULE_CTOR_FC_STYLE_1		0x02
+#define  MODULE_CTOR_FC_STYLE_2		0x03
+#define  MODULE_CTOR_BNC_TNC			0x04
+#define  MODULE_CTOR_FC_COAX			0x05
+#define  MODULE_CTOR_FIBER_JACK		0x06
+#define  MODULE_CTOR_LC				0x07
+#define  MODULE_CTOR_MT_RJ				0x08
+#define  MODULE_CTOR_MU				0x09
+#define  MODULE_CTOR_SG				0x0A
+#define  MODULE_CTOR_OPT_PT			0x0B
+#define  MODULE_CTOR_MPO				0x0C
+#define  MODULE_CTOR_MPO_2				0x0D
+/* 0E-1Fh --- Reserved */
+#define  MODULE_CTOR_HSDC_II			0x20
+#define  MODULE_CTOR_COPPER_PT			0x21
+#define  MODULE_CTOR_RJ45				0x22
+#define  MODULE_CTOR_NO_SEPARABLE		0x23
+#define  MODULE_CTOR_MXC_2x16			0x24
+#define  MODULE_CTOR_CS_OPTICAL		0x25
+#define  MODULE_CTOR_CS_OPTICAL_MINI		0x26
+#define  MODULE_CTOR_MPO_2X12			0x27
+#define  MODULE_CTOR_MPO_1X16			0x28
+#define  MODULE_CTOR_LAST			MODULE_CTOR_MPO_1X16
+
+#define  MODULE_CTOR_NO_SEP_QSFP_DD		0x6F
+#define  MODULE_CTOR_UNALLOCATED_LAST		0x7F
+#define  MODULE_CTOR_VENDOR_START		0x80
+#define  MODULE_CTOR_VENDOR_LAST		0xFF
+
+/* Transmitter Technology */
+#define MODULE_850_VCSEL			0x00
+
+/* SFF8636 */
+#define	 SFF8636_TRANS_TECH_MASK		0xF0
+#define	 SFF8636_TRANS_COPPER_LNR_EQUAL		(15 << 4)
+#define	 SFF8636_TRANS_COPPER_NEAR_EQUAL	(14 << 4)
+#define	 SFF8636_TRANS_COPPER_FAR_EQUAL		(13 << 4)
+#define	 SFF8636_TRANS_COPPER_LNR_FAR_EQUAL	(12 << 4)
+#define	 SFF8636_TRANS_COPPER_PAS_EQUAL		(11 << 4)
+#define	 SFF8636_TRANS_COPPER_PAS_UNEQUAL	(10 << 4)
+#define	 SFF8636_TRANS_1490_DFB			(9 << 4)
+#define	 SFF8636_TRANS_OTHERS			(8 << 4)
+#define	 SFF8636_TRANS_1550_EML			(7 << 4)
+#define	 SFF8636_TRANS_1310_EML			(6 << 4)
+#define  SFF8636_TRANS_1550_DFB			(5 << 4)
+#define	 SFF8636_TRANS_1310_DFB			(4 << 4)
+#define	 SFF8636_TRANS_1310_FP			(3 << 4)
+#define	 SFF8636_TRANS_1550_VCSEL		(2 << 4)
+#define	 SFF8636_TRANS_1310_VCSEL		(1 << 4)
+
+/* CMIS */
+#define CMIS_1310_VCSEL				0x01
+#define CMIS_1550_VCSEL				0x02
+#define CMIS_1310_FP				0x03
+#define CMIS_1310_DFB				0x04
+#define CMIS_1550_DFB				0x05
+#define CMIS_1310_EML				0x06
+#define CMIS_1550_EML				0x07
+#define CMIS_OTHERS				0x08
+#define CMIS_1490_DFB				0x09
+#define CMIS_COPPER_UNEQUAL			0x0A
+#define CMIS_COPPER_PASS_EQUAL			0x0B
+#define CMIS_COPPER_NF_EQUAL			0x0C
+#define CMIS_COPPER_F_EQUAL			0x0D
+#define CMIS_COPPER_N_EQUAL			0x0E
+#define CMIS_COPPER_LINEAR_EQUAL		0x0F
+
+/* Module Flags (Page 0) */
+#define CMIS_VCC_AW_OFFSET			0x09
+#define CMIS_VCC_LWARN_STATUS			0x80
+#define CMIS_VCC_HWARN_STATUS			0x40
+#define CMIS_VCC_LALARM_STATUS			0x20
+#define CMIS_VCC_HALARM_STATUS			0x10
+#define CMIS_TEMP_AW_OFFSET			0x09
+#define CMIS_TEMP_LWARN_STATUS			0x08
+#define CMIS_TEMP_HWARN_STATUS			0x04
+#define CMIS_TEMP_LALARM_STATUS			0x02
+#define CMIS_TEMP_HALARM_STATUS			0x01
+
+/* Supported Monitors Advertisement (Page 1) */
+#define CMIS_DIAG_CHAN_ADVER_OFFSET		0xA0
+
+/* Module Monitor Interrupt Flags - 6-8 */
+#define	SFF8636_TEMP_AW_OFFSET	0x06
+#define	 SFF8636_TEMP_HALARM_STATUS		(1 << 7)
+#define	 SFF8636_TEMP_LALARM_STATUS		(1 << 6)
+#define	 SFF8636_TEMP_HWARN_STATUS		(1 << 5)
+#define	 SFF8636_TEMP_LWARN_STATUS		(1 << 4)
+
+#define	SFF8636_VCC_AW_OFFSET	0x07
+#define	 SFF8636_VCC_HALARM_STATUS		(1 << 7)
+#define	 SFF8636_VCC_LALARM_STATUS		(1 << 6)
+#define	 SFF8636_VCC_HWARN_STATUS		(1 << 5)
+#define	 SFF8636_VCC_LWARN_STATUS		(1 << 4)
+
+/* Channel Monitor Interrupt Flags - 9-21 */
+#define	SFF8636_RX_PWR_12_AW_OFFSET	0x09
+#define	 SFF8636_RX_PWR_1_HALARM		(1 << 7)
+#define	 SFF8636_RX_PWR_1_LALARM		(1 << 6)
+#define	 SFF8636_RX_PWR_1_HWARN			(1 << 5)
+#define	 SFF8636_RX_PWR_1_LWARN			(1 << 4)
+#define	 SFF8636_RX_PWR_2_HALARM		(1 << 3)
+#define	 SFF8636_RX_PWR_2_LALARM		(1 << 2)
+#define	 SFF8636_RX_PWR_2_HWARN			(1 << 1)
+#define	 SFF8636_RX_PWR_2_LWARN			(1 << 0)
+
+#define	SFF8636_RX_PWR_34_AW_OFFSET	0x0A
+#define	 SFF8636_RX_PWR_3_HALARM		(1 << 7)
+#define	 SFF8636_RX_PWR_3_LALARM		(1 << 6)
+#define	 SFF8636_RX_PWR_3_HWARN			(1 << 5)
+#define	 SFF8636_RX_PWR_3_LWARN			(1 << 4)
+#define	 SFF8636_RX_PWR_4_HALARM		(1 << 3)
+#define	 SFF8636_RX_PWR_4_LALARM		(1 << 2)
+#define	 SFF8636_RX_PWR_4_HWARN			(1 << 1)
+#define	 SFF8636_RX_PWR_4_LWARN			(1 << 0)
+
+#define	SFF8636_TX_BIAS_12_AW_OFFSET	0x0B
+#define	 SFF8636_TX_BIAS_1_HALARM		(1 << 7)
+#define	 SFF8636_TX_BIAS_1_LALARM		(1 << 6)
+#define	 SFF8636_TX_BIAS_1_HWARN		(1 << 5)
+#define	 SFF8636_TX_BIAS_1_LWARN		(1 << 4)
+#define	 SFF8636_TX_BIAS_2_HALARM		(1 << 3)
+#define	 SFF8636_TX_BIAS_2_LALARM		(1 << 2)
+#define	 SFF8636_TX_BIAS_2_HWARN		(1 << 1)
+#define	 SFF8636_TX_BIAS_2_LWARN		(1 << 0)
+
+#define	SFF8636_TX_BIAS_34_AW_OFFSET	0xC
+#define	 SFF8636_TX_BIAS_3_HALARM		(1 << 7)
+#define	 SFF8636_TX_BIAS_3_LALARM		(1 << 6)
+#define	 SFF8636_TX_BIAS_3_HWARN		(1 << 5)
+#define	 SFF8636_TX_BIAS_3_LWARN		(1 << 4)
+#define	 SFF8636_TX_BIAS_4_HALARM		(1 << 3)
+#define	 SFF8636_TX_BIAS_4_LALARM		(1 << 2)
+#define	 SFF8636_TX_BIAS_4_HWARN		(1 << 1)
+#define	 SFF8636_TX_BIAS_4_LWARN		(1 << 0)
+
+#define	SFF8636_TX_PWR_12_AW_OFFSET	0x0D
+#define	 SFF8636_TX_PWR_1_HALARM		(1 << 7)
+#define	 SFF8636_TX_PWR_1_LALARM		(1 << 6)
+#define	 SFF8636_TX_PWR_1_HWARN			(1 << 5)
+#define	 SFF8636_TX_PWR_1_LWARN			(1 << 4)
+#define	 SFF8636_TX_PWR_2_HALARM		(1 << 3)
+#define	 SFF8636_TX_PWR_2_LALARM		(1 << 2)
+#define	 SFF8636_TX_PWR_2_HWARN			(1 << 1)
+#define	 SFF8636_TX_PWR_2_LWARN			(1 << 0)
+
+#define	SFF8636_TX_PWR_34_AW_OFFSET	0x0E
+#define	 SFF8636_TX_PWR_3_HALARM		(1 << 7)
+#define	 SFF8636_TX_PWR_3_LALARM		(1 << 6)
+#define	 SFF8636_TX_PWR_3_HWARN			(1 << 5)
+#define	 SFF8636_TX_PWR_3_LWARN			(1 << 4)
+#define	 SFF8636_TX_PWR_4_HALARM		(1 << 3)
+#define	 SFF8636_TX_PWR_4_LALARM		(1 << 2)
+#define	 SFF8636_TX_PWR_4_HWARN			(1 << 1)
+#define	 SFF8636_TX_PWR_4_LWARN			(1 << 0)
+
+/*-----------------------------------------------------------------------
+ * Upper Memory Page 0x11: Optional Page that contains lane dynamic status
+ * bytes.
+ */
+
+/* Media Lane-Specific Flags (Page 0x11) */
+#define CMIS_TX_FAIL_OFFSET			0x87
+#define CMIS_TX_LOS_OFFSET			0x88
+#define CMIS_TX_LOL_OFFSET			0x89
+#define CMIS_TX_EQ_FAIL_OFFSET			0x8a
+#define CMIS_TX_PWR_AW_HALARM_OFFSET		0x8B
+#define CMIS_TX_PWR_AW_LALARM_OFFSET		0x8C
+#define CMIS_TX_PWR_AW_HWARN_OFFSET		0x8D
+#define CMIS_TX_PWR_AW_LWARN_OFFSET		0x8E
+#define CMIS_TX_BIAS_AW_HALARM_OFFSET		0x8F
+#define CMIS_TX_BIAS_AW_LALARM_OFFSET		0x90
+#define CMIS_TX_BIAS_AW_HWARN_OFFSET		0x91
+#define CMIS_TX_BIAS_AW_LWARN_OFFSET		0x92
+#define CMIS_RX_LOS_OFFSET			0x93
+#define CMIS_RX_LOL_OFFSET			0x94
+#define CMIS_RX_PWR_AW_HALARM_OFFSET		0x95
+#define CMIS_RX_PWR_AW_LALARM_OFFSET		0x96
+#define CMIS_RX_PWR_AW_HWARN_OFFSET		0x97
+#define CMIS_RX_PWR_AW_LWARN_OFFSET		0x98
+
+/* Media Lane-Specific Monitors (Page 0x11) */
+#define CMIS_TX_PWR_OFFSET			0x9A
+#define CMIS_TX_BIAS_OFFSET			0xAA
+#define CMIS_RX_PWR_OFFSET			0xBA
+
+#define CMIS_TX_BIAS_MON_MASK			0x01
+#define CMIS_TX_PWR_MON_MASK			0x02
+#define CMIS_RX_PWR_MON_MASK			0x04
+
+#define YESNO(x) (((x) != 0) ? "Yes" : "No")
+#define ONOFF(x) (((x) != 0) ? "On" : "Off")
+
+struct module_aw_mod {
+	enum module_type type;
+	const char *str;	/* Human-readable string, null at the end */
+	int offset;
+	__u8 value;		/* Alarm is on if (offset & value) != 0. */
+};
+
+struct module_aw_chan {
+	enum module_type type;
+	const char *fmt_str;
+	int offset;
+	int adver_offset;	/* In Page 01h. */
+	__u8 adver_value;	/* Supported if (offset & value) != 0. */
+};
+
+extern const struct module_aw_mod module_aw_mod_flags[];
+extern const struct module_aw_chan module_aw_chan_flags[];
+
+void module_show_value_with_unit(const __u8 *id, unsigned int reg,
+				 const char *name, unsigned int mult,
+				 const char *unit);
+void module_show_ascii(const __u8 *id, unsigned int first_reg,
+		       unsigned int last_reg, const char *name);
+void module_show_lane_status(const char *name, unsigned int lane_cnt,
+			     const char *yes, const char *no,
+			     unsigned int value);
+void module_show_oui(const __u8 *id, int id_offset);
+void module_show_identifier(const __u8 *id, int id_offset);
+void module_show_connector(const __u8 *id, int ctor_offset);
+void module_show_mit_compliance(u16 value);
+void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd);
+
+#endif /* MODULE_COMMON_H__ */
diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index 2b30d04..ce6a7d9 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -9,7 +9,7 @@
 #include <stdio.h>
 #include <stddef.h>
 
-#include "../sff-common.h"
+#include "../module-common.h"
 #include "../qsfp.h"
 #include "../cmis.h"
 #include "../internal.h"
@@ -225,20 +225,20 @@ static int eeprom_parse(struct cmd_context *ctx)
 
 	switch (request.data[0]) {
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
-	case SFF8024_ID_GBIC:
-	case SFF8024_ID_SOLDERED_MODULE:
-	case SFF8024_ID_SFP:
+	case MODULE_ID_GBIC:
+	case MODULE_ID_SOLDERED_MODULE:
+	case MODULE_ID_SFP:
 		return sff8079_show_all_nl(ctx);
-	case SFF8024_ID_QSFP:
-	case SFF8024_ID_QSFP28:
-	case SFF8024_ID_QSFP_PLUS:
+	case MODULE_ID_QSFP:
+	case MODULE_ID_QSFP28:
+	case MODULE_ID_QSFP_PLUS:
 		return sff8636_show_all_nl(ctx);
-	case SFF8024_ID_QSFP_DD:
-	case SFF8024_ID_OSFP:
-	case SFF8024_ID_DSFP:
-	case SFF8024_ID_QSFP_PLUS_CMIS:
-	case SFF8024_ID_SFP_DD_CMIS:
-	case SFF8024_ID_SFP_PLUS_CMIS:
+	case MODULE_ID_QSFP_DD:
+	case MODULE_ID_OSFP:
+	case MODULE_ID_DSFP:
+	case MODULE_ID_QSFP_PLUS_CMIS:
+	case MODULE_ID_SFP_DD_CMIS:
+	case MODULE_ID_SFP_PLUS_CMIS:
 		return cmis_show_all_nl(ctx);
 #endif
 	default:
diff --git a/qsfp.c b/qsfp.c
index a3a919d..6d774f8 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -57,7 +57,7 @@
 #include <math.h>
 #include <errno.h>
 #include "internal.h"
-#include "sff-common.h"
+#include "module-common.h"
 #include "qsfp.h"
 #include "cmis.h"
 #include "netlink/extapi.h"
@@ -75,143 +75,9 @@ struct sff8636_memory_map {
 
 #define MAX_DESC_SIZE	42
 
-static struct sff8636_aw_flags {
-	const char *str;        /* Human-readable string, null at the end */
-	int offset;
-	__u8 value;             /* Alarm is on if (offset & value) != 0. */
-} sff8636_aw_flags[] = {
-	{ "Laser bias current high alarm   (Chan 1)",
-		SFF8636_TX_BIAS_12_AW_OFFSET, (SFF8636_TX_BIAS_1_HALARM) },
-	{ "Laser bias current low alarm    (Chan 1)",
-		SFF8636_TX_BIAS_12_AW_OFFSET, (SFF8636_TX_BIAS_1_LALARM) },
-	{ "Laser bias current high warning (Chan 1)",
-		SFF8636_TX_BIAS_12_AW_OFFSET, (SFF8636_TX_BIAS_1_HWARN) },
-	{ "Laser bias current low warning  (Chan 1)",
-		SFF8636_TX_BIAS_12_AW_OFFSET, (SFF8636_TX_BIAS_1_LWARN) },
-
-	{ "Laser bias current high alarm   (Chan 2)",
-		SFF8636_TX_BIAS_12_AW_OFFSET, (SFF8636_TX_BIAS_2_HALARM) },
-	{ "Laser bias current low alarm    (Chan 2)",
-		SFF8636_TX_BIAS_12_AW_OFFSET, (SFF8636_TX_BIAS_2_LALARM) },
-	{ "Laser bias current high warning (Chan 2)",
-		SFF8636_TX_BIAS_12_AW_OFFSET, (SFF8636_TX_BIAS_2_HWARN) },
-	{ "Laser bias current low warning  (Chan 2)",
-		SFF8636_TX_BIAS_12_AW_OFFSET, (SFF8636_TX_BIAS_2_LWARN) },
-
-	{ "Laser bias current high alarm   (Chan 3)",
-		SFF8636_TX_BIAS_34_AW_OFFSET, (SFF8636_TX_BIAS_3_HALARM) },
-	{ "Laser bias current low alarm    (Chan 3)",
-		SFF8636_TX_BIAS_34_AW_OFFSET, (SFF8636_TX_BIAS_3_LALARM) },
-	{ "Laser bias current high warning (Chan 3)",
-		SFF8636_TX_BIAS_34_AW_OFFSET, (SFF8636_TX_BIAS_3_HWARN) },
-	{ "Laser bias current low warning  (Chan 3)",
-		SFF8636_TX_BIAS_34_AW_OFFSET, (SFF8636_TX_BIAS_3_LWARN) },
-
-	{ "Laser bias current high alarm   (Chan 4)",
-		SFF8636_TX_BIAS_34_AW_OFFSET, (SFF8636_TX_BIAS_4_HALARM) },
-	{ "Laser bias current low alarm    (Chan 4)",
-		SFF8636_TX_BIAS_34_AW_OFFSET, (SFF8636_TX_BIAS_4_LALARM) },
-	{ "Laser bias current high warning (Chan 4)",
-		SFF8636_TX_BIAS_34_AW_OFFSET, (SFF8636_TX_BIAS_4_HWARN) },
-	{ "Laser bias current low warning  (Chan 4)",
-		SFF8636_TX_BIAS_34_AW_OFFSET, (SFF8636_TX_BIAS_4_LWARN) },
-
-	{ "Module temperature high alarm",
-		SFF8636_TEMP_AW_OFFSET, (SFF8636_TEMP_HALARM_STATUS) },
-	{ "Module temperature low alarm",
-		SFF8636_TEMP_AW_OFFSET, (SFF8636_TEMP_LALARM_STATUS) },
-	{ "Module temperature high warning",
-		SFF8636_TEMP_AW_OFFSET, (SFF8636_TEMP_HWARN_STATUS) },
-	{ "Module temperature low warning",
-		SFF8636_TEMP_AW_OFFSET, (SFF8636_TEMP_LWARN_STATUS) },
-
-	{ "Module voltage high alarm",
-		SFF8636_VCC_AW_OFFSET, (SFF8636_VCC_HALARM_STATUS) },
-	{ "Module voltage low alarm",
-		SFF8636_VCC_AW_OFFSET, (SFF8636_VCC_LALARM_STATUS) },
-	{ "Module voltage high warning",
-		SFF8636_VCC_AW_OFFSET, (SFF8636_VCC_HWARN_STATUS) },
-	{ "Module voltage low warning",
-		SFF8636_VCC_AW_OFFSET, (SFF8636_VCC_LWARN_STATUS) },
-
-	{ "Laser tx power high alarm   (Channel 1)",
-		SFF8636_TX_PWR_12_AW_OFFSET, (SFF8636_TX_PWR_1_HALARM) },
-	{ "Laser tx power low alarm    (Channel 1)",
-		SFF8636_TX_PWR_12_AW_OFFSET, (SFF8636_TX_PWR_1_LALARM) },
-	{ "Laser tx power high warning (Channel 1)",
-		SFF8636_TX_PWR_12_AW_OFFSET, (SFF8636_TX_PWR_1_HWARN) },
-	{ "Laser tx power low warning  (Channel 1)",
-		SFF8636_TX_PWR_12_AW_OFFSET, (SFF8636_TX_PWR_1_LWARN) },
-
-	{ "Laser tx power high alarm   (Channel 2)",
-		SFF8636_TX_PWR_12_AW_OFFSET, (SFF8636_TX_PWR_2_HALARM) },
-	{ "Laser tx power low alarm    (Channel 2)",
-		SFF8636_TX_PWR_12_AW_OFFSET, (SFF8636_TX_PWR_2_LALARM) },
-	{ "Laser tx power high warning (Channel 2)",
-		SFF8636_TX_PWR_12_AW_OFFSET, (SFF8636_TX_PWR_2_HWARN) },
-	{ "Laser tx power low warning  (Channel 2)",
-		SFF8636_TX_PWR_12_AW_OFFSET, (SFF8636_TX_PWR_2_LWARN) },
-
-	{ "Laser tx power high alarm   (Channel 3)",
-		SFF8636_TX_PWR_34_AW_OFFSET, (SFF8636_TX_PWR_3_HALARM) },
-	{ "Laser tx power low alarm    (Channel 3)",
-		SFF8636_TX_PWR_34_AW_OFFSET, (SFF8636_TX_PWR_3_LALARM) },
-	{ "Laser tx power high warning (Channel 3)",
-		SFF8636_TX_PWR_34_AW_OFFSET, (SFF8636_TX_PWR_3_HWARN) },
-	{ "Laser tx power low warning  (Channel 3)",
-		SFF8636_TX_PWR_34_AW_OFFSET, (SFF8636_TX_PWR_3_LWARN) },
-
-	{ "Laser tx power high alarm   (Channel 4)",
-		SFF8636_TX_PWR_34_AW_OFFSET, (SFF8636_TX_PWR_4_HALARM) },
-	{ "Laser tx power low alarm    (Channel 4)",
-		SFF8636_TX_PWR_34_AW_OFFSET, (SFF8636_TX_PWR_4_LALARM) },
-	{ "Laser tx power high warning (Channel 4)",
-		SFF8636_TX_PWR_34_AW_OFFSET, (SFF8636_TX_PWR_4_HWARN) },
-	{ "Laser tx power low warning  (Channel 4)",
-		SFF8636_TX_PWR_34_AW_OFFSET, (SFF8636_TX_PWR_4_LWARN) },
-
-	{ "Laser rx power high alarm   (Channel 1)",
-		SFF8636_RX_PWR_12_AW_OFFSET, (SFF8636_RX_PWR_1_HALARM) },
-	{ "Laser rx power low alarm    (Channel 1)",
-		SFF8636_RX_PWR_12_AW_OFFSET, (SFF8636_RX_PWR_1_LALARM) },
-	{ "Laser rx power high warning (Channel 1)",
-		SFF8636_RX_PWR_12_AW_OFFSET, (SFF8636_RX_PWR_1_HWARN) },
-	{ "Laser rx power low warning  (Channel 1)",
-		SFF8636_RX_PWR_12_AW_OFFSET, (SFF8636_RX_PWR_1_LWARN) },
-
-	{ "Laser rx power high alarm   (Channel 2)",
-		SFF8636_RX_PWR_12_AW_OFFSET, (SFF8636_RX_PWR_2_HALARM) },
-	{ "Laser rx power low alarm    (Channel 2)",
-		SFF8636_RX_PWR_12_AW_OFFSET, (SFF8636_RX_PWR_2_LALARM) },
-	{ "Laser rx power high warning (Channel 2)",
-		SFF8636_RX_PWR_12_AW_OFFSET, (SFF8636_RX_PWR_2_HWARN) },
-	{ "Laser rx power low warning  (Channel 2)",
-		SFF8636_RX_PWR_12_AW_OFFSET, (SFF8636_RX_PWR_2_LWARN) },
-
-	{ "Laser rx power high alarm   (Channel 3)",
-		SFF8636_RX_PWR_34_AW_OFFSET, (SFF8636_RX_PWR_3_HALARM) },
-	{ "Laser rx power low alarm    (Channel 3)",
-		SFF8636_RX_PWR_34_AW_OFFSET, (SFF8636_RX_PWR_3_LALARM) },
-	{ "Laser rx power high warning (Channel 3)",
-		SFF8636_RX_PWR_34_AW_OFFSET, (SFF8636_RX_PWR_3_HWARN) },
-	{ "Laser rx power low warning  (Channel 3)",
-		SFF8636_RX_PWR_34_AW_OFFSET, (SFF8636_RX_PWR_3_LWARN) },
-
-	{ "Laser rx power high alarm   (Channel 4)",
-		SFF8636_RX_PWR_34_AW_OFFSET, (SFF8636_RX_PWR_4_HALARM) },
-	{ "Laser rx power low alarm    (Channel 4)",
-		SFF8636_RX_PWR_34_AW_OFFSET, (SFF8636_RX_PWR_4_LALARM) },
-	{ "Laser rx power high warning (Channel 4)",
-		SFF8636_RX_PWR_34_AW_OFFSET, (SFF8636_RX_PWR_4_HWARN) },
-	{ "Laser rx power low warning  (Channel 4)",
-		SFF8636_RX_PWR_34_AW_OFFSET, (SFF8636_RX_PWR_4_LWARN) },
-
-	{ NULL, 0, 0 },
-};
-
 static void sff8636_show_identifier(const struct sff8636_memory_map *map)
 {
-	sff8024_show_identifier(map->lower_memory, SFF8636_ID_OFFSET);
+	module_show_identifier(map->lower_memory, SFF8636_ID_OFFSET);
 }
 
 static void sff8636_show_ext_identifier(const struct sff8636_memory_map *map)
@@ -278,7 +144,7 @@ static void sff8636_show_ext_identifier(const struct sff8636_memory_map *map)
 
 static void sff8636_show_connector(const struct sff8636_memory_map *map)
 {
-	sff8024_show_connector(map->page_00h, SFF8636_CTOR_OFFSET);
+	module_show_connector(map->page_00h, SFF8636_CTOR_OFFSET);
 }
 
 static void sff8636_show_transceiver(const struct sff8636_memory_map *map)
@@ -624,64 +490,12 @@ static void sff8636_show_rate_identifier(const struct sff8636_memory_map *map)
 static void
 sff8636_show_wavelength_or_copper_compliance(const struct sff8636_memory_map *map)
 {
-	printf("\t%-41s : 0x%02x", "Transmitter technology",
-	       map->page_00h[SFF8636_DEVICE_TECH_OFFSET] &
-	       SFF8636_TRANS_TECH_MASK);
-
-	switch (map->page_00h[SFF8636_DEVICE_TECH_OFFSET] &
-		SFF8636_TRANS_TECH_MASK) {
-	case SFF8636_TRANS_850_VCSEL:
-		printf(" (850 nm VCSEL)\n");
-		break;
-	case SFF8636_TRANS_1310_VCSEL:
-		printf(" (1310 nm VCSEL)\n");
-		break;
-	case SFF8636_TRANS_1550_VCSEL:
-		printf(" (1550 nm VCSEL)\n");
-		break;
-	case SFF8636_TRANS_1310_FP:
-		printf(" (1310 nm FP)\n");
-		break;
-	case SFF8636_TRANS_1310_DFB:
-		printf(" (1310 nm DFB)\n");
-		break;
-	case SFF8636_TRANS_1550_DFB:
-		printf(" (1550 nm DFB)\n");
-		break;
-	case SFF8636_TRANS_1310_EML:
-		printf(" (1310 nm EML)\n");
-		break;
-	case SFF8636_TRANS_1550_EML:
-		printf(" (1550 nm EML)\n");
-		break;
-	case SFF8636_TRANS_OTHERS:
-		printf(" (Others/Undefined)\n");
-		break;
-	case SFF8636_TRANS_1490_DFB:
-		printf(" (1490 nm DFB)\n");
-		break;
-	case SFF8636_TRANS_COPPER_PAS_UNEQUAL:
-		printf(" (Copper cable unequalized)\n");
-		break;
-	case SFF8636_TRANS_COPPER_PAS_EQUAL:
-		printf(" (Copper cable passive equalized)\n");
-		break;
-	case SFF8636_TRANS_COPPER_LNR_FAR_EQUAL:
-		printf(" (Copper cable, near and far end limiting active equalizers)\n");
-		break;
-	case SFF8636_TRANS_COPPER_FAR_EQUAL:
-		printf(" (Copper cable, far end limiting active equalizers)\n");
-		break;
-	case SFF8636_TRANS_COPPER_NEAR_EQUAL:
-		printf(" (Copper cable, near end limiting active equalizers)\n");
-		break;
-	case SFF8636_TRANS_COPPER_LNR_EQUAL:
-		printf(" (Copper cable, linear active equalizers)\n");
-		break;
-	}
+	u16 value = map->page_00h[SFF8636_DEVICE_TECH_OFFSET] &
+			SFF8636_TRANS_TECH_MASK;
 
-	if ((map->page_00h[SFF8636_DEVICE_TECH_OFFSET] &
-	     SFF8636_TRANS_TECH_MASK) >= SFF8636_TRANS_COPPER_PAS_UNEQUAL) {
+	module_show_mit_compliance(value);
+
+	if (value >= SFF8636_TRANS_COPPER_PAS_UNEQUAL) {
 		printf("\t%-41s : %udb\n", "Attenuation at 2.5GHz",
 			map->page_00h[SFF8636_WAVELEN_HIGH_BYTE_OFFSET]);
 		printf("\t%-41s : %udb\n", "Attenuation at 5.0GHz",
@@ -823,8 +637,7 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 
 	sff8636_dom_parse(map, &sd);
 
-	PRINT_TEMP("Module temperature", sd.sfp_temp[MCURR]);
-	PRINT_VCC("Module voltage", sd.sfp_voltage[MCURR]);
+	module_show_dom_mod_lvl_monitors(&sd);
 
 	/*
 	 * SFF-8636/8436 spec is not clear whether RX power/ TX bias
@@ -862,10 +675,21 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 	}
 
 	if (sd.supports_alarms) {
-		for (i = 0; sff8636_aw_flags[i].str; ++i) {
-			printf("\t%-41s : %s\n", sff8636_aw_flags[i].str,
-			       map->lower_memory[sff8636_aw_flags[i].offset]
-			       & sff8636_aw_flags[i].value ? "On" : "Off");
+		for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
+			if (module_aw_chan_flags[i].type == MODULE_TYPE_SFF8636)
+				printf("\t%-41s : %s\n",
+				       module_aw_chan_flags[i].fmt_str,
+				       (map->lower_memory[module_aw_chan_flags[i].offset]
+				        & module_aw_chan_flags[i].adver_value) ?
+				       "On" : "Off");
+		}
+		for (i = 0; module_aw_mod_flags[i].str; ++i) {
+			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
+				printf("\t%-41s : %s\n",
+				       module_aw_mod_flags[i].str,
+				       (map->lower_memory[module_aw_mod_flags[i].offset]
+				       & module_aw_mod_flags[i].value) ?
+				       "On" : "Off");
 		}
 
 		sff_show_thresholds(sd);
@@ -879,26 +703,27 @@ static void sff8636_show_signals(const struct sff8636_memory_map *map)
 	/* There appears to be no Rx LOS support bit, use Tx for both */
 	if (map->page_00h[SFF8636_OPTION_4_OFFSET] & SFF8636_O4_TX_LOS) {
 		v = map->lower_memory[SFF8636_LOS_AW_OFFSET] & 0xf;
-		sff_show_lane_status("Rx loss of signal", 4, "Yes", "No", v);
+		module_show_lane_status("Rx loss of signal", 4, "Yes", "No", v);
 		v = map->lower_memory[SFF8636_LOS_AW_OFFSET] >> 4;
-		sff_show_lane_status("Tx loss of signal", 4, "Yes", "No", v);
+		module_show_lane_status("Tx loss of signal", 4, "Yes", "No", v);
 	}
 
 	v = map->lower_memory[SFF8636_LOL_AW_OFFSET] & 0xf;
 	if (map->page_00h[SFF8636_OPTION_3_OFFSET] & SFF8636_O3_RX_LOL)
-		sff_show_lane_status("Rx loss of lock", 4, "Yes", "No", v);
+		module_show_lane_status("Rx loss of lock", 4, "Yes", "No", v);
 
 	v = map->lower_memory[SFF8636_LOL_AW_OFFSET] >> 4;
 	if (map->page_00h[SFF8636_OPTION_3_OFFSET] & SFF8636_O3_TX_LOL)
-		sff_show_lane_status("Tx loss of lock", 4, "Yes", "No", v);
+		module_show_lane_status("Tx loss of lock", 4, "Yes", "No", v);
 
 	v = map->lower_memory[SFF8636_FAULT_AW_OFFSET] & 0xf;
 	if (map->page_00h[SFF8636_OPTION_4_OFFSET] & SFF8636_O4_TX_FAULT)
-		sff_show_lane_status("Tx fault", 4, "Yes", "No", v);
+		module_show_lane_status("Tx fault", 4, "Yes", "No", v);
 
 	v = map->lower_memory[SFF8636_FAULT_AW_OFFSET] >> 4;
 	if (map->page_00h[SFF8636_OPTION_2_OFFSET] & SFF8636_O2_TX_EQ_AUTO)
-		sff_show_lane_status("Tx adaptive eq fault", 4, "Yes", "No", v);
+		module_show_lane_status("Tx adaptive eq fault", 4, "Yes", "No",
+					v);
 }
 
 static void sff8636_show_page_zero(const struct sff8636_memory_map *map)
@@ -907,31 +732,31 @@ static void sff8636_show_page_zero(const struct sff8636_memory_map *map)
 	sff8636_show_connector(map);
 	sff8636_show_transceiver(map);
 	sff8636_show_encoding(map);
-	sff_show_value_with_unit(map->page_00h, SFF8636_BR_NOMINAL_OFFSET,
-				 "BR, Nominal", 100, "Mbps");
+	module_show_value_with_unit(map->page_00h, SFF8636_BR_NOMINAL_OFFSET,
+				    "BR, Nominal", 100, "Mbps");
 	sff8636_show_rate_identifier(map);
-	sff_show_value_with_unit(map->page_00h, SFF8636_SM_LEN_OFFSET,
-				 "Length (SMF,km)", 1, "km");
-	sff_show_value_with_unit(map->page_00h, SFF8636_OM3_LEN_OFFSET,
-				 "Length (OM3 50um)", 2, "m");
-	sff_show_value_with_unit(map->page_00h, SFF8636_OM2_LEN_OFFSET,
-				 "Length (OM2 50um)", 1, "m");
-	sff_show_value_with_unit(map->page_00h, SFF8636_OM1_LEN_OFFSET,
-				 "Length (OM1 62.5um)", 1, "m");
-	sff_show_value_with_unit(map->page_00h, SFF8636_CBL_LEN_OFFSET,
-				 "Length (Copper or Active cable)", 1, "m");
+	module_show_value_with_unit(map->page_00h, SFF8636_SM_LEN_OFFSET,
+				    "Length (SMF,km)", 1, "km");
+	module_show_value_with_unit(map->page_00h, SFF8636_OM3_LEN_OFFSET,
+				    "Length (OM3 50um)", 2, "m");
+	module_show_value_with_unit(map->page_00h, SFF8636_OM2_LEN_OFFSET,
+				    "Length (OM2 50um)", 1, "m");
+	module_show_value_with_unit(map->page_00h, SFF8636_OM1_LEN_OFFSET,
+				    "Length (OM1 62.5um)", 1, "m");
+	module_show_value_with_unit(map->page_00h, SFF8636_CBL_LEN_OFFSET,
+				    "Length (Copper or Active cable)", 1, "m");
 	sff8636_show_wavelength_or_copper_compliance(map);
-	sff_show_ascii(map->page_00h, SFF8636_VENDOR_NAME_START_OFFSET,
-		       SFF8636_VENDOR_NAME_END_OFFSET, "Vendor name");
-	sff8024_show_oui(map->page_00h, SFF8636_VENDOR_OUI_OFFSET);
-	sff_show_ascii(map->page_00h, SFF8636_VENDOR_PN_START_OFFSET,
-		       SFF8636_VENDOR_PN_END_OFFSET, "Vendor PN");
-	sff_show_ascii(map->page_00h, SFF8636_VENDOR_REV_START_OFFSET,
-		       SFF8636_VENDOR_REV_END_OFFSET, "Vendor rev");
-	sff_show_ascii(map->page_00h, SFF8636_VENDOR_SN_START_OFFSET,
-		       SFF8636_VENDOR_SN_END_OFFSET, "Vendor SN");
-	sff_show_ascii(map->page_00h, SFF8636_DATE_YEAR_OFFSET,
-		       SFF8636_DATE_VENDOR_LOT_OFFSET + 1, "Date code");
+	module_show_ascii(map->page_00h, SFF8636_VENDOR_NAME_START_OFFSET,
+			  SFF8636_VENDOR_NAME_END_OFFSET, "Vendor name");
+	module_show_oui(map->page_00h, SFF8636_VENDOR_OUI_OFFSET);
+	module_show_ascii(map->page_00h, SFF8636_VENDOR_PN_START_OFFSET,
+			  SFF8636_VENDOR_PN_END_OFFSET, "Vendor PN");
+	module_show_ascii(map->page_00h, SFF8636_VENDOR_REV_START_OFFSET,
+			  SFF8636_VENDOR_REV_END_OFFSET, "Vendor rev");
+	module_show_ascii(map->page_00h, SFF8636_VENDOR_SN_START_OFFSET,
+			  SFF8636_VENDOR_SN_END_OFFSET, "Vendor SN");
+	module_show_ascii(map->page_00h, SFF8636_DATE_YEAR_OFFSET,
+			  SFF8636_DATE_VENDOR_LOT_OFFSET + 1, "Date code");
 	sff_show_revision_compliance(map->lower_memory,
 				     SFF8636_REV_COMPLIANCE_OFFSET);
 	sff8636_show_signals(map);
@@ -941,9 +766,9 @@ static void sff8636_show_all_common(const struct sff8636_memory_map *map)
 {
 	sff8636_show_identifier(map);
 	switch (map->lower_memory[SFF8636_ID_OFFSET]) {
-	case SFF8024_ID_QSFP:
-	case SFF8024_ID_QSFP_PLUS:
-	case SFF8024_ID_QSFP28:
+	case MODULE_ID_QSFP:
+	case MODULE_ID_QSFP_PLUS:
+	case MODULE_ID_QSFP28:
 		sff8636_show_page_zero(map);
 		sff8636_show_dom(map);
 		break;
@@ -978,12 +803,12 @@ void sff8636_show_all_ioctl(const __u8 *id, __u32 eeprom_len)
 	struct sff8636_memory_map map = {};
 
 	switch (id[SFF8636_ID_OFFSET]) {
-	case SFF8024_ID_QSFP_DD:
-	case SFF8024_ID_OSFP:
-	case SFF8024_ID_DSFP:
-	case SFF8024_ID_QSFP_PLUS_CMIS:
-	case SFF8024_ID_SFP_DD_CMIS:
-	case SFF8024_ID_SFP_PLUS_CMIS:
+	case MODULE_ID_QSFP_DD:
+	case MODULE_ID_OSFP:
+	case MODULE_ID_DSFP:
+	case MODULE_ID_QSFP_PLUS_CMIS:
+	case MODULE_ID_SFP_DD_CMIS:
+	case MODULE_ID_SFP_PLUS_CMIS:
 		cmis_show_all_ioctl(id);
 		break;
 	default:
diff --git a/qsfp.h b/qsfp.h
index 9f0cb0f..b899d4a 100644
--- a/qsfp.h
+++ b/qsfp.h
@@ -57,80 +57,6 @@
 
 #define	SFF8636_LOL_AW_OFFSET	0x05
 
-/* Module Monitor Interrupt Flags - 6-8 */
-#define	SFF8636_TEMP_AW_OFFSET	0x06
-#define	 SFF8636_TEMP_HALARM_STATUS		(1 << 7)
-#define	 SFF8636_TEMP_LALARM_STATUS		(1 << 6)
-#define	 SFF8636_TEMP_HWARN_STATUS		(1 << 5)
-#define	 SFF8636_TEMP_LWARN_STATUS		(1 << 4)
-
-#define	SFF8636_VCC_AW_OFFSET	0x07
-#define	 SFF8636_VCC_HALARM_STATUS		(1 << 7)
-#define	 SFF8636_VCC_LALARM_STATUS		(1 << 6)
-#define	 SFF8636_VCC_HWARN_STATUS		(1 << 5)
-#define	 SFF8636_VCC_LWARN_STATUS		(1 << 4)
-
-/* Channel Monitor Interrupt Flags - 9-21 */
-#define	SFF8636_RX_PWR_12_AW_OFFSET	0x09
-#define	 SFF8636_RX_PWR_1_HALARM		(1 << 7)
-#define	 SFF8636_RX_PWR_1_LALARM		(1 << 6)
-#define	 SFF8636_RX_PWR_1_HWARN			(1 << 5)
-#define	 SFF8636_RX_PWR_1_LWARN			(1 << 4)
-#define	 SFF8636_RX_PWR_2_HALARM		(1 << 3)
-#define	 SFF8636_RX_PWR_2_LALARM		(1 << 2)
-#define	 SFF8636_RX_PWR_2_HWARN			(1 << 1)
-#define	 SFF8636_RX_PWR_2_LWARN			(1 << 0)
-
-#define	SFF8636_RX_PWR_34_AW_OFFSET	0x0A
-#define	 SFF8636_RX_PWR_3_HALARM		(1 << 7)
-#define	 SFF8636_RX_PWR_3_LALARM		(1 << 6)
-#define	 SFF8636_RX_PWR_3_HWARN			(1 << 5)
-#define	 SFF8636_RX_PWR_3_LWARN			(1 << 4)
-#define	 SFF8636_RX_PWR_4_HALARM		(1 << 3)
-#define	 SFF8636_RX_PWR_4_LALARM		(1 << 2)
-#define	 SFF8636_RX_PWR_4_HWARN			(1 << 1)
-#define	 SFF8636_RX_PWR_4_LWARN			(1 << 0)
-
-#define	SFF8636_TX_BIAS_12_AW_OFFSET	0x0B
-#define	 SFF8636_TX_BIAS_1_HALARM		(1 << 7)
-#define	 SFF8636_TX_BIAS_1_LALARM		(1 << 6)
-#define	 SFF8636_TX_BIAS_1_HWARN		(1 << 5)
-#define	 SFF8636_TX_BIAS_1_LWARN		(1 << 4)
-#define	 SFF8636_TX_BIAS_2_HALARM		(1 << 3)
-#define	 SFF8636_TX_BIAS_2_LALARM		(1 << 2)
-#define	 SFF8636_TX_BIAS_2_HWARN		(1 << 1)
-#define	 SFF8636_TX_BIAS_2_LWARN		(1 << 0)
-
-#define	SFF8636_TX_BIAS_34_AW_OFFSET	0xC
-#define	 SFF8636_TX_BIAS_3_HALARM		(1 << 7)
-#define	 SFF8636_TX_BIAS_3_LALARM		(1 << 6)
-#define	 SFF8636_TX_BIAS_3_HWARN		(1 << 5)
-#define	 SFF8636_TX_BIAS_3_LWARN		(1 << 4)
-#define	 SFF8636_TX_BIAS_4_HALARM		(1 << 3)
-#define	 SFF8636_TX_BIAS_4_LALARM		(1 << 2)
-#define	 SFF8636_TX_BIAS_4_HWARN		(1 << 1)
-#define	 SFF8636_TX_BIAS_4_LWARN		(1 << 0)
-
-#define	SFF8636_TX_PWR_12_AW_OFFSET	0x0D
-#define	 SFF8636_TX_PWR_1_HALARM		(1 << 7)
-#define	 SFF8636_TX_PWR_1_LALARM		(1 << 6)
-#define	 SFF8636_TX_PWR_1_HWARN			(1 << 5)
-#define	 SFF8636_TX_PWR_1_LWARN			(1 << 4)
-#define	 SFF8636_TX_PWR_2_HALARM		(1 << 3)
-#define	 SFF8636_TX_PWR_2_LALARM		(1 << 2)
-#define	 SFF8636_TX_PWR_2_HWARN			(1 << 1)
-#define	 SFF8636_TX_PWR_2_LWARN			(1 << 0)
-
-#define	SFF8636_TX_PWR_34_AW_OFFSET	0x0E
-#define	 SFF8636_TX_PWR_3_HALARM		(1 << 7)
-#define	 SFF8636_TX_PWR_3_LALARM		(1 << 6)
-#define	 SFF8636_TX_PWR_3_HWARN			(1 << 5)
-#define	 SFF8636_TX_PWR_3_LWARN			(1 << 4)
-#define	 SFF8636_TX_PWR_4_HALARM		(1 << 3)
-#define	 SFF8636_TX_PWR_4_LALARM		(1 << 2)
-#define	 SFF8636_TX_PWR_4_HWARN			(1 << 1)
-#define	 SFF8636_TX_PWR_4_LWARN			(1 << 0)
-
 /* Module Monitoring Values - 22-33 */
 #define	SFF8636_TEMP_CURR		0x16
 #define	SFF8636_TEMP_MSB_OFFSET		0x16
@@ -381,40 +307,6 @@
 
 /* Device Technology - 147 */
 #define	SFF8636_DEVICE_TECH_OFFSET	0x93
-/* Transmitter Technology */
-#define	 SFF8636_TRANS_TECH_MASK		0xF0
-/* Copper cable, linear active equalizers */
-#define	 SFF8636_TRANS_COPPER_LNR_EQUAL		(15 << 4)
-/* Copper cable, near end limiting active equalizers */
-#define	 SFF8636_TRANS_COPPER_NEAR_EQUAL	(14 << 4)
-/* Copper cable, far end limiting active equalizers */
-#define	 SFF8636_TRANS_COPPER_FAR_EQUAL		(13 << 4)
-/* Copper cable, near & far end limiting active equalizers */
-#define	 SFF8636_TRANS_COPPER_LNR_FAR_EQUAL	(12 << 4)
-/* Copper cable, passive equalized */
-#define	 SFF8636_TRANS_COPPER_PAS_EQUAL		(11 << 4)
-/* Copper cable, unequalized */
-#define	 SFF8636_TRANS_COPPER_PAS_UNEQUAL	(10 << 4)
-/* 1490 nm DFB */
-#define	 SFF8636_TRANS_1490_DFB			(9 << 4)
-/* Others */
-#define	 SFF8636_TRANS_OTHERS			(8 << 4)
-/* 1550 nm EML */
-#define	 SFF8636_TRANS_1550_EML			(7 << 4)
-/* 1310 nm EML */
-#define	 SFF8636_TRANS_1310_EML			(6 << 4)
-/* 1550 nm DFB */
-#define	 SFF8636_TRANS_1550_DFB			(5 << 4)
-/* 1310 nm DFB */
-#define	 SFF8636_TRANS_1310_DFB			(4 << 4)
-/* 1310 nm FP */
-#define	 SFF8636_TRANS_1310_FP			(3 << 4)
-/* 1550 nm VCSEL */
-#define	 SFF8636_TRANS_1550_VCSEL		(2 << 4)
-/* 1310 nm VCSEL */
-#define	 SFF8636_TRANS_1310_VCSEL		(1 << 4)
-/* 850 nm VCSEL */
-#define	 SFF8636_TRANS_850_VCSEL		(0 << 4)
 
  /* Active/No wavelength control */
 #define	 SFF8636_DEV_TECH_ACTIVE_WAVE_LEN	(1 << 3)
diff --git a/sff-common.c b/sff-common.c
index a412a6e..6712b3e 100644
--- a/sff-common.c
+++ b/sff-common.c
@@ -29,233 +29,6 @@ double convert_mw_to_dbm(double mw)
 	return (10. * log10(mw / 1000.)) + 30.;
 }
 
-void sff_show_value_with_unit(const __u8 *id, unsigned int reg,
-			      const char *name, unsigned int mult,
-			      const char *unit)
-{
-	unsigned int val = id[reg];
-
-	printf("\t%-41s : %u%s\n", name, val * mult, unit);
-}
-
-void sff_show_ascii(const __u8 *id, unsigned int first_reg,
-		    unsigned int last_reg, const char *name)
-{
-	unsigned int reg, val;
-
-	printf("\t%-41s : ", name);
-	while (first_reg <= last_reg && id[last_reg] == ' ')
-		last_reg--;
-	for (reg = first_reg; reg <= last_reg; reg++) {
-		val = id[reg];
-		putchar(((val >= 32) && (val <= 126)) ? val : '_');
-	}
-	printf("\n");
-}
-
-void sff_show_lane_status(const char *name, unsigned int lane_cnt,
-			  const char *yes, const char *no, unsigned int value)
-{
-	printf("\t%-41s : ", name);
-	if (!value) {
-		printf("None\n");
-		return;
-	}
-
-	printf("[");
-	while (lane_cnt--) {
-		printf(" %s%c", value & 1 ? yes : no, lane_cnt ? ',': ' ');
-		value >>= 1;
-	}
-	printf("]\n");
-}
-
-void sff8024_show_oui(const __u8 *id, int id_offset)
-{
-	printf("\t%-41s : %02x:%02x:%02x\n", "Vendor OUI",
-		      id[id_offset], id[(id_offset) + 1],
-		      id[(id_offset) + 2]);
-}
-
-void sff8024_show_identifier(const __u8 *id, int id_offset)
-{
-	printf("\t%-41s : 0x%02x", "Identifier", id[id_offset]);
-	switch (id[id_offset]) {
-	case SFF8024_ID_UNKNOWN:
-		printf(" (no module present, unknown, or unspecified)\n");
-		break;
-	case SFF8024_ID_GBIC:
-		printf(" (GBIC)\n");
-		break;
-	case SFF8024_ID_SOLDERED_MODULE:
-		printf(" (module soldered to motherboard)\n");
-		break;
-	case SFF8024_ID_SFP:
-		printf(" (SFP)\n");
-		break;
-	case SFF8024_ID_300_PIN_XBI:
-		printf(" (300 pin XBI)\n");
-		break;
-	case SFF8024_ID_XENPAK:
-		printf(" (XENPAK)\n");
-		break;
-	case SFF8024_ID_XFP:
-		printf(" (XFP)\n");
-		break;
-	case SFF8024_ID_XFF:
-		printf(" (XFF)\n");
-		break;
-	case SFF8024_ID_XFP_E:
-		printf(" (XFP-E)\n");
-		break;
-	case SFF8024_ID_XPAK:
-		printf(" (XPAK)\n");
-		break;
-	case SFF8024_ID_X2:
-		printf(" (X2)\n");
-		break;
-	case SFF8024_ID_DWDM_SFP:
-		printf(" (DWDM-SFP)\n");
-		break;
-	case SFF8024_ID_QSFP:
-		printf(" (QSFP)\n");
-		break;
-	case SFF8024_ID_QSFP_PLUS:
-		printf(" (QSFP+)\n");
-		break;
-	case SFF8024_ID_CXP:
-		printf(" (CXP)\n");
-		break;
-	case SFF8024_ID_HD4X:
-		printf(" (Shielded Mini Multilane HD 4X)\n");
-		break;
-	case SFF8024_ID_HD8X:
-		printf(" (Shielded Mini Multilane HD 8X)\n");
-		break;
-	case SFF8024_ID_QSFP28:
-		printf(" (QSFP28)\n");
-		break;
-	case SFF8024_ID_CXP2:
-		printf(" (CXP2/CXP28)\n");
-		break;
-	case SFF8024_ID_CDFP:
-		printf(" (CDFP Style 1/Style 2)\n");
-		break;
-	case SFF8024_ID_HD4X_FANOUT:
-		printf(" (Shielded Mini Multilane HD 4X Fanout Cable)\n");
-		break;
-	case SFF8024_ID_HD8X_FANOUT:
-		printf(" (Shielded Mini Multilane HD 8X Fanout Cable)\n");
-		break;
-	case SFF8024_ID_CDFP_S3:
-		printf(" (CDFP Style 3)\n");
-		break;
-	case SFF8024_ID_MICRO_QSFP:
-		printf(" (microQSFP)\n");
-		break;
-	case SFF8024_ID_QSFP_DD:
-		printf(" (QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628))\n");
-		break;
-	case SFF8024_ID_OSFP:
-		printf(" (OSFP 8X Pluggable Transceiver)\n");
-		break;
-	case SFF8024_ID_DSFP:
-		printf(" (DSFP Dual Small Form Factor Pluggable Transceiver)\n");
-		break;
-	case SFF8024_ID_QSFP_PLUS_CMIS:
-		printf(" (QSFP+ or later with Common Management Interface Specification (CMIS))\n");
-		break;
-	case SFF8024_ID_SFP_DD_CMIS:
-		printf(" (SFP-DD Double Density 2X Pluggable Transceiver with Common Management Interface Specification (CMIS))\n");
-		break;
-	case SFF8024_ID_SFP_PLUS_CMIS:
-		printf(" (SFP+ and later with Common Management Interface Specification (CMIS))\n");
-		break;
-	default:
-		printf(" (reserved or unknown)\n");
-		break;
-	}
-}
-
-void sff8024_show_connector(const __u8 *id, int ctor_offset)
-{
-	printf("\t%-41s : 0x%02x", "Connector", id[ctor_offset]);
-	switch (id[ctor_offset]) {
-	case  SFF8024_CTOR_UNKNOWN:
-		printf(" (unknown or unspecified)\n");
-		break;
-	case SFF8024_CTOR_SC:
-		printf(" (SC)\n");
-		break;
-	case SFF8024_CTOR_FC_STYLE_1:
-		printf(" (Fibre Channel Style 1 copper)\n");
-		break;
-	case SFF8024_CTOR_FC_STYLE_2:
-		printf(" (Fibre Channel Style 2 copper)\n");
-		break;
-	case SFF8024_CTOR_BNC_TNC:
-		printf(" (BNC/TNC)\n");
-		break;
-	case SFF8024_CTOR_FC_COAX:
-		printf(" (Fibre Channel coaxial headers)\n");
-		break;
-	case SFF8024_CTOR_FIBER_JACK:
-		printf(" (FibreJack)\n");
-		break;
-	case SFF8024_CTOR_LC:
-		printf(" (LC)\n");
-		break;
-	case SFF8024_CTOR_MT_RJ:
-		printf(" (MT-RJ)\n");
-		break;
-	case SFF8024_CTOR_MU:
-		printf(" (MU)\n");
-		break;
-	case SFF8024_CTOR_SG:
-		printf(" (SG)\n");
-		break;
-	case SFF8024_CTOR_OPT_PT:
-		printf(" (Optical pigtail)\n");
-		break;
-	case SFF8024_CTOR_MPO:
-		printf(" (MPO Parallel Optic)\n");
-		break;
-	case SFF8024_CTOR_MPO_2:
-		printf(" (MPO Parallel Optic - 2x16)\n");
-		break;
-	case SFF8024_CTOR_HSDC_II:
-		printf(" (HSSDC II)\n");
-		break;
-	case SFF8024_CTOR_COPPER_PT:
-		printf(" (Copper pigtail)\n");
-		break;
-	case SFF8024_CTOR_RJ45:
-		printf(" (RJ45)\n");
-		break;
-	case SFF8024_CTOR_NO_SEPARABLE:
-		printf(" (No separable connector)\n");
-		break;
-	case SFF8024_CTOR_MXC_2x16:
-		printf(" (MXC 2x16)\n");
-		break;
-	case SFF8024_CTOR_CS_OPTICAL:
-		printf(" (CS optical connector)\n");
-		break;
-	case SFF8024_CTOR_CS_OPTICAL_MINI:
-		printf(" (Mini CS optical connector)\n");
-		break;
-	case SFF8024_CTOR_MPO_2X12:
-		printf(" (MPO 2x12)\n");
-		break;
-	case SFF8024_CTOR_MPO_1X16:
-		printf(" (MPO 1x16)\n");
-		break;
-	default:
-		printf(" (reserved or unknown)\n");
-		break;
-	}
-}
-
 void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type)
 {
 	printf("\t%-41s : 0x%02x", "Encoding", id[encoding_offset]);
diff --git a/sff-common.h b/sff-common.h
index 899dc5b..34f1275 100644
--- a/sff-common.h
+++ b/sff-common.h
@@ -36,73 +36,6 @@
 #define  SFF8636_REV_8636_20			0x06
 #define  SFF8636_REV_8636_27			0x07
 
-#define  SFF8024_ID_OFFSET				0x00
-#define  SFF8024_ID_UNKNOWN				0x00
-#define  SFF8024_ID_GBIC				0x01
-#define  SFF8024_ID_SOLDERED_MODULE		0x02
-#define  SFF8024_ID_SFP					0x03
-#define  SFF8024_ID_300_PIN_XBI			0x04
-#define  SFF8024_ID_XENPAK				0x05
-#define  SFF8024_ID_XFP					0x06
-#define  SFF8024_ID_XFF					0x07
-#define  SFF8024_ID_XFP_E				0x08
-#define  SFF8024_ID_XPAK				0x09
-#define  SFF8024_ID_X2					0x0A
-#define  SFF8024_ID_DWDM_SFP			0x0B
-#define  SFF8024_ID_QSFP				0x0C
-#define  SFF8024_ID_QSFP_PLUS			0x0D
-#define  SFF8024_ID_CXP					0x0E
-#define  SFF8024_ID_HD4X				0x0F
-#define  SFF8024_ID_HD8X				0x10
-#define  SFF8024_ID_QSFP28				0x11
-#define  SFF8024_ID_CXP2				0x12
-#define  SFF8024_ID_CDFP				0x13
-#define  SFF8024_ID_HD4X_FANOUT			0x14
-#define  SFF8024_ID_HD8X_FANOUT			0x15
-#define  SFF8024_ID_CDFP_S3				0x16
-#define  SFF8024_ID_MICRO_QSFP			0x17
-#define  SFF8024_ID_QSFP_DD				0x18
-#define  SFF8024_ID_OSFP				0x19
-#define  SFF8024_ID_DSFP				0x1B
-#define  SFF8024_ID_QSFP_PLUS_CMIS			0x1E
-#define  SFF8024_ID_SFP_DD_CMIS				0x1F
-#define  SFF8024_ID_SFP_PLUS_CMIS			0x20
-#define  SFF8024_ID_LAST				SFF8024_ID_SFP_PLUS_CMIS
-#define  SFF8024_ID_UNALLOCATED_LAST	0x7F
-#define  SFF8024_ID_VENDOR_START		0x80
-#define  SFF8024_ID_VENDOR_LAST			0xFF
-
-#define  SFF8024_CTOR_UNKNOWN			0x00
-#define  SFF8024_CTOR_SC				0x01
-#define  SFF8024_CTOR_FC_STYLE_1		0x02
-#define  SFF8024_CTOR_FC_STYLE_2		0x03
-#define  SFF8024_CTOR_BNC_TNC			0x04
-#define  SFF8024_CTOR_FC_COAX			0x05
-#define  SFF8024_CTOR_FIBER_JACK		0x06
-#define  SFF8024_CTOR_LC				0x07
-#define  SFF8024_CTOR_MT_RJ				0x08
-#define  SFF8024_CTOR_MU				0x09
-#define  SFF8024_CTOR_SG				0x0A
-#define  SFF8024_CTOR_OPT_PT			0x0B
-#define  SFF8024_CTOR_MPO				0x0C
-#define  SFF8024_CTOR_MPO_2				0x0D
-/* 0E-1Fh --- Reserved */
-#define  SFF8024_CTOR_HSDC_II			0x20
-#define  SFF8024_CTOR_COPPER_PT			0x21
-#define  SFF8024_CTOR_RJ45				0x22
-#define  SFF8024_CTOR_NO_SEPARABLE		0x23
-#define  SFF8024_CTOR_MXC_2x16			0x24
-#define  SFF8024_CTOR_CS_OPTICAL		0x25
-#define  SFF8024_CTOR_CS_OPTICAL_MINI		0x26
-#define  SFF8024_CTOR_MPO_2X12			0x27
-#define  SFF8024_CTOR_MPO_1X16			0x28
-#define  SFF8024_CTOR_LAST			SFF8024_CTOR_MPO_1X16
-
-#define  SFF8024_CTOR_NO_SEP_QSFP_DD		0x6F
-#define  SFF8024_CTOR_UNALLOCATED_LAST		0x7F
-#define  SFF8024_CTOR_VENDOR_START		0x80
-#define  SFF8024_CTOR_VENDOR_LAST		0xFF
-
 /* ENCODING Values */
 #define  SFF8024_ENCODING_UNSPEC		0x00
 #define  SFF8024_ENCODING_8B10B			0x01
@@ -196,18 +129,8 @@ struct sff_diags {
 };
 
 double convert_mw_to_dbm(double mw);
-void sff_show_value_with_unit(const __u8 *id, unsigned int reg,
-			      const char *name, unsigned int mult,
-			      const char *unit);
-void sff_show_ascii(const __u8 *id, unsigned int first_reg,
-		    unsigned int last_reg, const char *name);
-void sff_show_lane_status(const char *name, unsigned int lane_cnt,
-			  const char *yes, const char *no, unsigned int value);
 void sff_show_thresholds(struct sff_diags sd);
 
-void sff8024_show_oui(const __u8 *id, int id_offset);
-void sff8024_show_identifier(const __u8 *id, int id_offset);
-void sff8024_show_connector(const __u8 *id, int ctor_offset);
 void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type);
 void sff_show_revision_compliance(const __u8 *id, int rev_offset);
 
diff --git a/sfpdiag.c b/sfpdiag.c
index 1fa8b7b..bbca91e 100644
--- a/sfpdiag.c
+++ b/sfpdiag.c
@@ -12,7 +12,7 @@
 #include <math.h>
 #include <arpa/inet.h>
 #include "internal.h"
-#include "sff-common.h"
+#include "module-common.h"
 
 /* Offsets in decimal, for direct comparison with the SFF specs */
 
@@ -263,8 +263,7 @@ void sff8472_show_all(const __u8 *id)
 
 	PRINT_xX_PWR(rx_power_string, sd.rx_power[MCURR]);
 
-	PRINT_TEMP("Module temperature", sd.sfp_temp[MCURR]);
-	PRINT_VCC("Module voltage", sd.sfp_voltage[MCURR]);
+	module_show_dom_mod_lvl_monitors(&sd);
 
 	printf("\t%-41s : %s\n", "Alarm/warning flags implemented",
 	       (sd.supports_alarms ? "Yes" : "No"));
diff --git a/sfpid.c b/sfpid.c
index 1bc45c1..3c126b4 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -10,7 +10,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include "internal.h"
-#include "sff-common.h"
+#include "module-common.h"
 #include "netlink/extapi.h"
 
 #define SFF8079_PAGE_SIZE		0x80
@@ -19,7 +19,7 @@
 
 static void sff8079_show_identifier(const __u8 *id)
 {
-	sff8024_show_identifier(id, 0);
+	module_show_identifier(id, 0);
 }
 
 static void sff8079_show_ext_identifier(const __u8 *id)
@@ -37,7 +37,7 @@ static void sff8079_show_ext_identifier(const __u8 *id)
 
 static void sff8079_show_connector(const __u8 *id)
 {
-	sff8024_show_connector(id, 2);
+	module_show_connector(id, 2);
 }
 
 static void sff8079_show_transceiver(const __u8 *id)
@@ -299,12 +299,6 @@ static void sff8079_show_rate_identifier(const __u8 *id)
 	}
 }
 
-static void sff8079_show_oui(const __u8 *id)
-{
-	printf("\t%-41s : %02x:%02x:%02x\n", "Vendor OUI",
-	       id[37], id[38], id[39]);
-}
-
 static void sff8079_show_wavelength_or_copper_compliance(const __u8 *id)
 {
 	if (id[8] & (1 << 2)) {
@@ -344,30 +338,6 @@ static void sff8079_show_wavelength_or_copper_compliance(const __u8 *id)
 	}
 }
 
-static void sff8079_show_value_with_unit(const __u8 *id, unsigned int reg,
-					 const char *name, unsigned int mult,
-					 const char *unit)
-{
-	unsigned int val = id[reg];
-
-	printf("\t%-41s : %u%s\n", name, val * mult, unit);
-}
-
-static void sff8079_show_ascii(const __u8 *id, unsigned int first_reg,
-			       unsigned int last_reg, const char *name)
-{
-	unsigned int reg, val;
-
-	printf("\t%-41s : ", name);
-	while (first_reg <= last_reg && id[last_reg] == ' ')
-		last_reg--;
-	for (reg = first_reg; reg <= last_reg; reg++) {
-		val = id[reg];
-		putchar(((val >= 32) && (val <= 126)) ? val : '_');
-	}
-	printf("\n");
-}
-
 static void sff8079_show_options(const __u8 *id)
 {
 	static const char *pfx =
@@ -425,24 +395,24 @@ static void sff8079_show_all_common(const __u8 *id)
 		sff8079_show_encoding(id);
 		printf("\t%-41s : %u%s\n", "BR, Nominal", br_nom, "MBd");
 		sff8079_show_rate_identifier(id);
-		sff8079_show_value_with_unit(id, 14,
-					     "Length (SMF,km)", 1, "km");
-		sff8079_show_value_with_unit(id, 15, "Length (SMF)", 100, "m");
-		sff8079_show_value_with_unit(id, 16, "Length (50um)", 10, "m");
-		sff8079_show_value_with_unit(id, 17,
+		module_show_value_with_unit(id, 14,
+					    "Length (SMF,km)", 1, "km");
+		module_show_value_with_unit(id, 15, "Length (SMF)", 100, "m");
+		module_show_value_with_unit(id, 16, "Length (50um)", 10, "m");
+		module_show_value_with_unit(id, 17,
 					     "Length (62.5um)", 10, "m");
-		sff8079_show_value_with_unit(id, 18, "Length (Copper)", 1, "m");
-		sff8079_show_value_with_unit(id, 19, "Length (OM3)", 10, "m");
+		module_show_value_with_unit(id, 18, "Length (Copper)", 1, "m");
+		module_show_value_with_unit(id, 19, "Length (OM3)", 10, "m");
 		sff8079_show_wavelength_or_copper_compliance(id);
-		sff8079_show_ascii(id, 20, 35, "Vendor name");
-		sff8079_show_oui(id);
-		sff8079_show_ascii(id, 40, 55, "Vendor PN");
-		sff8079_show_ascii(id, 56, 59, "Vendor rev");
+		module_show_ascii(id, 20, 35, "Vendor name");
+		module_show_oui(id, 37);
+		module_show_ascii(id, 40, 55, "Vendor PN");
+		module_show_ascii(id, 56, 59, "Vendor rev");
 		sff8079_show_options(id);
 		printf("\t%-41s : %u%s\n", "BR margin, max", br_max, "%");
 		printf("\t%-41s : %u%s\n", "BR margin, min", br_min, "%");
-		sff8079_show_ascii(id, 68, 83, "Vendor SN");
-		sff8079_show_ascii(id, 84, 91, "Date code");
+		module_show_ascii(id, 68, 83, "Vendor SN");
+		module_show_ascii(id, 84, 91, "Date code");
 	}
 }
 
-- 
2.47.0


