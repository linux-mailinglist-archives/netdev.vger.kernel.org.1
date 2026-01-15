Return-Path: <netdev+bounces-250011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00CD227C8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 07:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C6173024E40
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 06:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C22285074;
	Thu, 15 Jan 2026 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QeFVZCpa"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4882866
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457167; cv=fail; b=VOA6ogHAI81di0M8lr/SF2bVwr0sUPKcX4Fpsz4qIER5yNmIEgpUdG2NlfxT5jRTrL6MSiHiUOHzCz0qvsAOkNoySSDJu3BGWjX8e87wm3F6mZpNqiBzzUU4o+yl+mYc8oBKKFovwqU4yNzXCKB1PThGh/f3lFqYuoCRTt6ntZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457167; c=relaxed/simple;
	bh=6OZef4A6m/SyAmXBYC0pepAXnoY+nftGyz+rVdKxXOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ob+e2NH5VIk6TpnDZnTtNDTtQt5D4JrxBfYR1Np4DISrMcTnBDUQNNx5119UlV6m8K/FVfhdVRqj2BZuQMNoTscB5DMYEbNXtEbmx8s6U6fni5qrSBnjOCyXGJGFiP5kF0zT9Wtt8BcP1zW9E27/Zo+/EjWdjTSpbDtyMEohlZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QeFVZCpa; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEzvcQ7sGfEXDsfjOBcSWrnkJPre8xvCol21Tj23ElgkAUwxpUsF5tKjtE/PdU3tDwLGp3d1BxF1eLF4cB//x1dSPz3EL7hokOxnWUmWbuCtcwaJO/2TIQhfy7c/brOCtcpeP283yG+Qpjhg73rbciQxREBl1OYply0NzLlGe6J7ieK0riMMgTuHbGR/IOokMT/vrWXWnOezrjg92Tk4xwaY0WJme/SdUwWzQYdWFUr5BkWQ7X20O9aljKBgXu3zSIB0aLeFrBwsnw8c8463gy/cUIC1MUpSzM3hyFGAacJqBFxAD2Wh/Y5wJsXNonCGu4txkfeNhd0Dfj8b47So/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhJ9hZtdyasyxgchEoRzuxIyQArhvGl//n1tMBG1VHs=;
 b=DtejvUqPhSeLLaYvLmzvsMqxagcWyvFK7j4xhJos9Aus843eJj4t2Y82usUfwqJ+w0uyorm6OkwTmKGo/lTFi5BJuRvaWslSMcTxIwKOS19DNe0en5655xZdN5n6r8YbRGRiawnXfMok4/StCrFnV5fJDbcAY8vm5k8uVuo83wOD1K7lIV/lTLTynqfc04Sb9ko76OhFk75UWD+bJmoh2BVq0nC3TBvk/OQRv6NpjfOZ68xvTPO+YJ0FmovVfmyh+TWZiaQknBLerY6qcg9E6GHIGkbHPFwGsSPJeNOWmAfhIvFeophW8pW7g1x+UFjpDXFasRRk8Yytn5gLzBDNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhJ9hZtdyasyxgchEoRzuxIyQArhvGl//n1tMBG1VHs=;
 b=QeFVZCpaid3AudLXtVvJAOTE3BWyfWurIIj4AUCQi0yUxrn7EYyte2JPRnMuyihNxDbtS3oj0CrFAEF4NGBhwmN3wQrO9ZXRvlSkAKHPREmec1Y4Hz3ZpSMqLrxO9YjlRyXHRBkCjmYoN64KxRPzkn8PDL4fxIERXS23lcf9XUb/F5oHj4+0RsbKzBAv5TD8XOgG94UHLolqJqKCTZwT3XbWVfrZVT3XfVk5+xRYYms9bXDUOHqb2HQPlreQ+Da7K2JDnAFpGvWeiWd5oAlbiKTCOfNYq2ucwyh/4+I2N/6ui3UtRHZOeZsuP7Q4oTGP5qy0MEaCgTm8ImGER3iLGw==
Received: from CH2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:20::35)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 06:06:02 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::28) by CH2PR07CA0022.outlook.office365.com
 (2603:10b6:610:20::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 06:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:06:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 22:05:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 22:05:45 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 14
 Jan 2026 22:05:42 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v3] ethtool: Clarify len/n_stats fields in/out semantics
Date: Thu, 15 Jan 2026 08:05:44 +0200
Message-ID: <20260115060544.481550-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2daaa2-4039-4726-2ebe-08de53fc2888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBaqItqAiU0WCtCnM9Qs+u8WsebmjUBlKGfSorpzDzxvze5eU82EC5m9YUFz?=
 =?us-ascii?Q?Xs0k6Ta59T6Y2RSwf9iYfqIk1l0mAham/LfT9tCPvd5mHmrLlA8LLcqRsymj?=
 =?us-ascii?Q?eRN5CXjKxt2YXon+1YeD9HVf+JThsvDasjv5JF8Oc0iTbPa5xSGfaJBvdqnl?=
 =?us-ascii?Q?Jy4q/NpRmXIjWoHBmcWNZE1hS4V8WKO2xVow3Gi6XdrrQIrixu4QyQl2VrCp?=
 =?us-ascii?Q?H/pXpmCd86I5wfr0S55iikyctUpKRgWIpuOHrlOocp15P74bVbQ9P/7SO18r?=
 =?us-ascii?Q?u7Jd/8t1mnMO3b7lzczgJ/0DkE+J+rwCyaVK8bGFKjti2DocwqJc5bAI6NJZ?=
 =?us-ascii?Q?NVCXevyfR9jGjJgJoewDBhgUlksgjNAvQbgAm40jNgXPYN9Pbj1GFGKOBT18?=
 =?us-ascii?Q?LJ1pkz9ZqBLMYRskYKzqMo4Xeknn2vzr4CUiVDUpXIIofIq8nJZbrYr/TbOQ?=
 =?us-ascii?Q?AL1KQFKJNZYgbOOawYAu6ZlrA4s1FVE/LIwG4sXl2miXZLkw/BC3QB0D6Via?=
 =?us-ascii?Q?gpUJJEHiXY8zQgGjy+aNuzZhKmS3Nr30mWFIsesXYoRDzx+apto3pz2mh2Si?=
 =?us-ascii?Q?cs1d/ecQmZT2r4gcgzHrKDmJagYmlXDLNYMUFi7A00tmy3ofS/+ZbKCZlULR?=
 =?us-ascii?Q?YXP+4w4VcQ+9FV1yqkWFXnR/18e+7GZM/ZPMsDH9HQ6i6y6fV0AYXQnhDvOv?=
 =?us-ascii?Q?oKyA3WRrfnUkI/foxDKKx3PEDRyz28BzNhGR1kh1QtgRasF439ejefmpLNcD?=
 =?us-ascii?Q?ATZs/4rMHi6bkHpcidtKM3fqZvHrrmTTWF4yvRKBdAt/o6eAlADDU0GHbKFB?=
 =?us-ascii?Q?/l5oMEbekAlXNoNGgk8mrRb3cYgGonzqiD5jKCIDDyGyR7TdsTYrcUFjb75G?=
 =?us-ascii?Q?sVgGICm++TqZnEX6ME4NhQFVH0AKPAUSxBlRvYXws6URu72WpLQWUp5XXG41?=
 =?us-ascii?Q?eHzFg1mvxVVEyYV8HBdF2dRqqOU4zTucVjeQAoEu6RISow0e49Cl8Wc44q/i?=
 =?us-ascii?Q?jiE0zEwMeU6QXEAk4nfzp/Fe42jHyUsDwEziJnMJJ+R3bzOk9wRi4IiieZAm?=
 =?us-ascii?Q?Q4F8743OJ19laDq0J/gWu13Eof+9fsKbaW8QcPNZCAtLbJp9174OcCutdZcl?=
 =?us-ascii?Q?GP5PKAlVRlo0tjrD1fNHbAXt6ohwlqBXU+1UXXy0dMBbQHyo6/LAugdtwwc9?=
 =?us-ascii?Q?l4XPngOWZhKT6gtmbiuYuadPNyguk1MrpM5NSC2iCleb+mQx8gq9tIUTNwK4?=
 =?us-ascii?Q?GcJPQEivgREwfkmfR6MLH/L3rAfXKvY+To7Djhtv/Q/FjSkRdV3SiAmH0ERh?=
 =?us-ascii?Q?vtVtykzTog0S5vtNaFB9ng7MgYZHeOtgSu8CG6KdY0jOIxpJaIYjrik5e4iC?=
 =?us-ascii?Q?VqLH5Eg0WhFJuJmielCdbg+20RQSafxWGOn5Aw9hk85tOkUdBMLd6tmvc3KH?=
 =?us-ascii?Q?qtNlAms1EP6kNTY5zr3UtcW55289zNdn0O3bA820rBNewmpZzfTrs07yo93t?=
 =?us-ascii?Q?Q2APeq6RjCXMPyfAGUU5fkZ7zYkUBxzOhsf/5L9MBLLNmcQcI9mjNq2ObEvn?=
 =?us-ascii?Q?4nH1EyJaaZE2SZumx/RnLxAW+fsgUwUfoKHeuWgptWeOV4bguOLxfFQ5LcK1?=
 =?us-ascii?Q?BIRB1Ng0LrR4qaE+YpXfNuvCt986j68B3HKSSXF+4JB3Jyd7YQB9QMdTUqpd?=
 =?us-ascii?Q?KkNhOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:06:00.8532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2daaa2-4039-4726-2ebe-08de53fc2888
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

Document that the 'len' field in ethtool_gstrings and 'n_stats' field in
ethtool_stats optionally serve dual purposes: on entry they specify the
number of items requested, and on return they indicate the number
actually returned (which is not necessarily the same).

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
v2->v3: https://lore.kernel.org/all/20260112115708.244752-1-gal@nvidia.com/
* Remove the 'on return' description (Jakub).

v1->v2: https://lore.kernel.org/all/20260105163923.49104-1-gal@nvidia.com/
* Reword comments (Jakub).
---
 include/uapi/linux/ethtool.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index eb7ff2602fbb..7887697e6886 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1094,13 +1094,20 @@ enum ethtool_module_fw_flash_status {
  * struct ethtool_gstrings - string set for data tagging
  * @cmd: Command number = %ETHTOOL_GSTRINGS
  * @string_set: String set ID; one of &enum ethtool_stringset
- * @len: On return, the number of strings in the string set
+ * @len: Number of strings in the string set
  * @data: Buffer for strings.  Each string is null-padded to a size of
  *	%ETH_GSTRING_LEN.
  *
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
@@ -1177,13 +1184,20 @@ struct ethtool_test {
 /**
  * struct ethtool_stats - device-specific statistics
  * @cmd: Command number = %ETHTOOL_GSTATS
- * @n_stats: On return, the number of statistics
+ * @n_stats: Number of statistics
  * @data: Array of statistics
  *
  * Users must use %ETHTOOL_GSSET_INFO or %ETHTOOL_GDRVINFO to find the
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


