Return-Path: <netdev+bounces-248996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBDFD126BB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E10DC30263C6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967403570D4;
	Mon, 12 Jan 2026 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dAO05LcM"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF23570C6
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219054; cv=fail; b=MdRAeF51wGyFLCW+xWLInMVudyoc/GdiFzTfS2NUmNqzBIJAswXZ7nErCtzkDh5m1E3HeU7+g9ib47VvcwqhnhkoCU8nXEJm4fIrmJ2ErlGAgaiScN6EnGXFyZ5UqjE3IcSKpZppAsCMpSWSievrlykn/aJha7UeO/E9El4l+cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219054; c=relaxed/simple;
	bh=xlh53/MXHr9QKNHMckCN5guNiskjExJB7sTPDPON8gg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ca9r84UejStgM+53ccPf6dNdvRyb4OzOygtOoXFLLQYAR2Ju23i9xG2uIIdLNm/qxqlHBM78cLC5RI8ScgKlk+prXwzqTdGI9yD2bGJ3mFxZ07aWAroluyIQGuOWY6x3uCS3td6zpfAtIdSoHsoBGYYWKieLsEiu1HURSG9dFVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dAO05LcM; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEc6setKgKCVslsl3ka/7d4ABBkbAFaaHN8M6tN8eT52Ni+TEp5k2huJTCadpDjg6H68DrooOHkpCKoccYA96T0v5oU/IK1ceL1r0P9qsoEIKmBaF368/r8igrKnBD0BTTifG8ucNPAHfcf+oz3Bqui9PL/B4VQ/IzC/uAEUFvQuB2Sx/rvqN92BjVgsuk6xdhvOT/xNvz4Y1bcv1pZOcC3lI0aCEoTu2KAZctNfEC8RpOcekp2Df3JAw9zpNiIDOgVeCpRcgnb/J6LemblYdftN44akqNL+4MDHzJrLdPg6bAp/KHA7OeNsHcltFWOVkiR6EB4MH+scT0XOURnJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx09g0xDXHb+21cjo1iZSCImbGWzHIVlexy8dJsYasE=;
 b=eI32jI/FYrpaf7Ex+kOFlSVyloFl1j2nIHiKFVL9CXzzjM82fVmO+OuShG6JyXMIEZWcPRrw9Lt1etS8hSgmcclpWmA8iGEO4vMjvZk/qmm9AJHOzEGfGws2oQpS3wHZVREyQWVB2euYk9voI/tTlq4Ul8XpRZkGKgBW7yuhZvUGYxFG+Oo9Zv+bYqS97uLRMLZP+gYgK9q7q5YxSDRuvLR/msAIbntXEAh138R4ZXFNFWIWUyduE/16Yj++oCSWQnEwbqnOk3l4ZMb4uNX14giMFVeli7q9VciZiu/2GPLkI4nOYvJ6fMy91X/tsTwR1iZWxe7L32oxUEBvVqcwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx09g0xDXHb+21cjo1iZSCImbGWzHIVlexy8dJsYasE=;
 b=dAO05LcMpSa+XTaN1/5OujyIhVVJq7HBIk51bsiEJnmevGqVnVWyJgoSezPC/W93VIKTvxz9tqkKtcyreE8yYB2H6TEF16TCz6RUbe3LKmh69cQLzfPlRwOZdtijGuWiC9OObqpXkdu5+c2N4PgYz3KY5i/9UNWOeGfhI3Y7+WDjI0YwZVAN/ABU95TFEwtzZkqKPopN/vowugP9Iztw5Zm60YYbjRXFy66/tS1GR4C+0o4iJbdAysZ55McsvC+34Q/32EZDuWcEZ/MpQyRzuaTn3Y1LeZQ4zwenZIpxnjQI+7Wt2oPTZ0/HY6Q8sYDPj/CTKuq175tDRjI+Kyvwsg==
Received: from BYAPR11CA0081.namprd11.prod.outlook.com (2603:10b6:a03:f4::22)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:57:26 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::49) by BYAPR11CA0081.outlook.office365.com
 (2603:10b6:a03:f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 11:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 11:57:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:57:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:57:12 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 03:57:10 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v2] ethtool: Clarify len/n_stats fields in/out semantics
Date: Mon, 12 Jan 2026 13:57:08 +0200
Message-ID: <20260112115708.244752-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: dc437934-d172-44f7-7e0d-08de51d1c15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xATPtO1DQqG0vFKeLcyQs6Y4ZzM5gmGsy8r52V8qeosTGRXrCQxgauouEAQ4?=
 =?us-ascii?Q?J6lHlGWe/Uf5vKdh7WAh8vTX2v93/fY/nxJR0tvVqXXS/fbnB1stCwWT6cLR?=
 =?us-ascii?Q?T3oWzt4ltY0EFLKT6c182wwcOnyFrIZFctMfQroQlSCj2DXDX4/8VE0iRCGG?=
 =?us-ascii?Q?jUMygRVNS/Ry25BBuU8QNQlOqgBfSNMlGSSO2hOCzMvb/mFnaVomT9gbMdRS?=
 =?us-ascii?Q?ncSdhQ+SHh266TGha9ZoyPmbkoB3C10EeeRE3jMmQUzxjTTHY5iOXpmZu+dR?=
 =?us-ascii?Q?hYNLeVdY6MDJ1s+wEUBCg/sxPW34YKBtQzHxi/7ixKYZ+W/1jQzPZdoLKiJ1?=
 =?us-ascii?Q?HFs4x2S0fgeONYz21dacOekOVGrfVCOqSmrAkscmfCejrRrq89hLMnz+/sIJ?=
 =?us-ascii?Q?daLw94306hBkBvGKUl3kihRbXpcBsj33tBLTUccbKLnDeQ8oPSAOJmyI3Xwh?=
 =?us-ascii?Q?m7rngHRQNZ+m9D7IxiwUacYubi5r+y66ddstKdRLSST1I+DWzkyPTQ6Qd6Jb?=
 =?us-ascii?Q?7C8+Q2suOZpMBW3GQ3LkIGnu9FRBdw7GwNn6QChW7hcZf/DH91gI1WPIpB/u?=
 =?us-ascii?Q?6bcoBKNpHMms9L/xd3ChmvA21dZawzKGxHxzUCUJbR4KweYX7FNQJnmbTQfy?=
 =?us-ascii?Q?CKwjqYSO9ZHrgm/W/DyZvOWE3kRomTcRiLphpzuoTdZHBoTqlem2UG/B/Rif?=
 =?us-ascii?Q?H59PbZIhhx/x1pA/5v0lVZ1831gd3OYVZBHhgrPN8u2tWta6puowrremax+Q?=
 =?us-ascii?Q?kJgGw9nE6jybSlmM3Q+ySpkLmXiKZbDNdIoaf2JT1AWL2WQx1am07LtuYWMP?=
 =?us-ascii?Q?RgSiiIrCQL6aFO7BqXSXoaabwU8kMXOYaN+VeBjbELjGRCyrRLRbYOo5Lg2m?=
 =?us-ascii?Q?5lv7c3hZxHyc3TTgjdbHS9Bg3ajTb5Hbyy6VlRB/PVJqctnaTKMAQX2844W/?=
 =?us-ascii?Q?Ux1GHVb3CLxOg5avMgkak95Xl2x2csImJmjZjt3Wi0UoHBy0tpqkmXk82g45?=
 =?us-ascii?Q?VTlEl34SYHwGfL2c0tfadY/qh/CxaDMT4sdDNp12092Xcg2p/3SxJm1a7pZ3?=
 =?us-ascii?Q?7a71Rw/qIqmM67D1Bcgo6ZFuO4H+4mrZXBQpup3/gKY+WQXTHwHhJeeXE+ah?=
 =?us-ascii?Q?1pXomIZA8AstvvdVFheSW/220CKJYoRVVcQkqmC1JwWMKVDw5Hacw7U9Iz+Y?=
 =?us-ascii?Q?4eY9nJxgb5RE7mDO+T0Uv6alsmcRGhVZA9ZqdnDlkgjRMz+RmZ0K81iihdS6?=
 =?us-ascii?Q?TFA96NEuqAKVID7VKnL0oZKXw0zF8d46CMNgLKR6VELPUP0F0vJc0xoTCL/r?=
 =?us-ascii?Q?VvbObzsXPu6yXROL2pAS4SmgtZ7m7QyUsYLcuo1vYxoH0UJf2M29wP7wSunq?=
 =?us-ascii?Q?gHHFevijNOdT1agAD30FMSZcHUsHQUUvLvUtjrLoH+LxomWEFWQvqVj98/6Y?=
 =?us-ascii?Q?ei2maG5B/8IQ26CByx6OXnE32QlnLp3R0MWMTCVW5GwHiFnDwGuveZ0qZuPr?=
 =?us-ascii?Q?LgKucsCQ5Cgq9G5Y/0rb61lj5l9ESltI6N/UfstheEzgNrHKZgp2as7012Ss?=
 =?us-ascii?Q?0Jla/JBi1pAeT/nwMbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:57:26.6243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc437934-d172-44f7-7e0d-08de51d1c15e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611

Document that the 'len' field in ethtool_gstrings and 'n_stats' field in
ethtool_stats optionally serve dual purposes: on entry they specify the
number of items requested, and on return they indicate the number
actually returned (which is not necessarily the same).

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
v1->v2: https://lore.kernel.org/all/20260105163923.49104-1-gal@nvidia.com/
* Reword comments (Jakub).
---
 include/uapi/linux/ethtool.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index eb7ff2602fbb..de810f1c3bfb 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1101,6 +1101,13 @@ enum ethtool_module_fw_flash_status {
  * Users must use %ETHTOOL_GSSET_INFO to find the number of strings in
  * the string set.  They must allocate a buffer of the appropriate
  * size immediately following this structure.
+ *
+ * Setting @len on input is optional (though preferred), but must be zeroed
+ * otherwise.
+ * When set, @len will return the requested count if it matches the actual
+ * count; otherwise, it will be zero.
+ * This prevents issues when the number of strings is different than the
+ * userspace allocation.
  */
 struct ethtool_gstrings {
 	__u32	cmd;
@@ -1184,6 +1191,13 @@ struct ethtool_test {
  * number of statistics that will be returned.  They must allocate a
  * buffer of the appropriate size (8 * number of statistics)
  * immediately following this structure.
+ *
+ * Setting @n_stats on input is optional (though preferred), but must be zeroed
+ * otherwise.
+ * When set, @n_stats will return the requested count if it matches the actual
+ * count; otherwise, it will be zero.
+ * This prevents issues when the number of stats is different than the
+ * userspace allocation.
  */
 struct ethtool_stats {
 	__u32	cmd;
-- 
2.40.1


