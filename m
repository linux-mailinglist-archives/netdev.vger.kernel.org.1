Return-Path: <netdev+bounces-247133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D8CF4D1E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52D830F4D4C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7490D3161BA;
	Mon,  5 Jan 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S3o2ejMq"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E8277C96
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631213; cv=fail; b=PoCB7u317sgWGFOw7f0I/romQruwMTvOeqSlgrlitWFusTVaVXpO+57fKT6g6wYTECim3xhQM1RX2azxh0/Wv7yBfvy1aUpSJ29oIalWr1gLyx3eAAceBYsbxJ/9n19/zT3lqLIJI/e4EeGbNP2V2VvGHp05+5h8SL7clhWbK40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631213; c=relaxed/simple;
	bh=97Hf6pC4gkvJIgN/OlkNO199HWhXAf3G6A2xo12Hlvk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNr8a8u6ZhLepbLMQ0esoyU9iZs7jGNDFJ5AQ4EZxgCKrqkUR6Lrq8k7D9mp4me0JTD78AqKFnqiYE+BpK+BJDdo79hZV+6cIe5HqEHL9dUMrP9R8+OS8nkNJuO/FhFqDtkxiQKr/9OfqqmS5Hzmzdsj3fi8iUcLaJrEXelGSJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S3o2ejMq; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Orr0H21uQr6BNYw7T7lPZGVrUw4exEpFJJ4AgzEy182N6/V+cIiaJbvtiFUMD3sdIHIX5kZbo1Mcbz0rg5sfzVwnsIShKubonJGnr18c8MbZmBJOck9nZbi+rxlND3YnFvF8dY7hDsCvnfZffhfWNcNuJtCDv191Mr6QKiUBS/or0A7iFJGRYTb/7v1M28t3boT/yWClyS0nG0v1k7zVXRb+Lp7r3JHU02wfH5uVYPiqJQm/c7XJQxe6FtMExhoX2yaXancDtmSb4yb78ZeX4X63lhyLUyno8NNR7/CrtB8cqxPAQl8Qovf8hJrC0yXJpVfbaDczUkXkkgkFdN4tMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gwz1ARr11NKAfmp1P8yQ3QPpKPaj3YXLFdSNN+bfz0=;
 b=i+bnDgYl2JgB0rbs1m38afOauqaFSWAht4WVCY9ZtaW7FCUgr0jFyEq9A/cvI06uIy2BVhi3xOAcNeknKV7xBHSwTpJoJ+LpffpyV+fobP4Sx73SCXytrd5ZWb8pMqDN9j1YJ5ShIt5ze32NUsM9mbNyyc9YESwWS4gOeZstk7LYXTuUnelFZm64//GZvZDf4gdNy9/E5Cr8S2hhraKfyW8QV1fHVvFaFfR/caOTfNDR7xyG35fJMljm2uO7x25qUyGt2JiEUmqpEkd69X/r9Zk++CnXKNj/cTujc9tY9ViuYTAZxp6ufunFjixz5ydktb0LHUDOBrwz2FpF/yQS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gwz1ARr11NKAfmp1P8yQ3QPpKPaj3YXLFdSNN+bfz0=;
 b=S3o2ejMqhxj73pxbRoxb0jgj7JRnhl5DjSPTdYltr7+ZXcZJCLk91jlT+9zQWtNOh/mAS/LKL48UQ8WgATQ8oQUV+ig3o7XhkZWPgFGz95C5FF7OE865VyJJv7LvqsHaHpDtNCWRZcJvpOe1QHeiVxd4BLpd+JFqZi5yCfDTjSBxfagv+gbxtf8myJC/UAJDoL0dh7kAwCNUG+RGEIJyEOIAxKV5olFOiiWb1TDTTC8FLPa7i+lVeGNJ8tlxQb3OWon4iJKM3c4C/iEXhxOvDfK5YijxFQ6CcRbKvnJa2c20Q1YklrvFFGh7WWEeoq1hd8M6SqHWbNzi71Av2jHQdA==
Received: from CY8P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::14)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 16:40:02 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:46:cafe::ab) by CY8P220CA0007.outlook.office365.com
 (2603:10b6:930:46::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 16:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 16:40:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 08:39:41 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 08:39:41 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 5 Jan
 2026 08:39:38 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next] ethtool: Clarify len/n_stats fields in/out semantics
Date: Mon, 5 Jan 2026 18:39:23 +0200
Message-ID: <20260105163923.49104-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b56d409-b082-496c-1172-08de4c7912d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wXyPk5sy6CEhpPA239Qf2IWj2ISFhy7n8i1GajBEccJl2dx7pHZtQD0TvQRR?=
 =?us-ascii?Q?SGkQsmlzr+MUt+g48KEAgAGoX8M4HRs92Po+9d2Rx2arLT5y1Y39B1pjdDzE?=
 =?us-ascii?Q?4gEwlJpszIztNlijShGVWXIlY+s8jj5YM3coqN/Y9f8LLKtSDKOZ1hMz4tFX?=
 =?us-ascii?Q?L6cc0sPJqjweVEddJ532n0MbZg/fiM/24TJ2ksyp3OSnouR/x+/rrqKr6Tbg?=
 =?us-ascii?Q?RUvowE2Yd+3QkdC2ChjiUWw8hh2HZ9z+ErfTUysVxf+8sjqJeBTgZ7+Up2DW?=
 =?us-ascii?Q?nPTsy73mzzhVp1zTfg5FIZR/zALmHHosTI3zdGAFSaB8qKxWJlw/8VefkzTf?=
 =?us-ascii?Q?wGWpiW2NBiG132KixSoIVdqc7AsmqDO72krWnL5hUfQhVXDNEyx5Z22iCvM1?=
 =?us-ascii?Q?ox8QPti3hPCljgoqlsKJkGWCPcbCngk9mO1gTdAHxSS6kMZbmX/yotxY5yCA?=
 =?us-ascii?Q?N30tqEDfxLDDSkPxtqvzNKLQWizaeNo9p9DMixozAAsOyG+zApHiAO+oLy3R?=
 =?us-ascii?Q?SFYeBEZZNbsuRFo5dP57JvJSW1FrgiO7IhYL+Ivttpac/19yyEWatsoFK6cv?=
 =?us-ascii?Q?vjt8OSbL8j3cqAfMPuHbbFzklYtVhc+HPWYe4rY0CIHfc2lZi4WJQajwV3wI?=
 =?us-ascii?Q?2fmRHhir3ca668eDhJzKXUetFlnMp0sLP+O0gWq3lWPAQmjkIsiwdA5lsuI6?=
 =?us-ascii?Q?rc+Z+GlxkC0nME2XAt/AHhKlhJR1L6X164lqg7p3WV132IzZo9QYEde4iP+v?=
 =?us-ascii?Q?7Fh0XdIkIsK0Mg8neCrqHecwjHJAk/s4qHx6pWOh2SbPIOaGxmSZnSuyo9y8?=
 =?us-ascii?Q?cY9vqCHxAIX+IkVWJa7ow3WffzSErAwmytIlvQ/c6G6gS48wZL7B0VPmiNxw?=
 =?us-ascii?Q?ne/PuI72p96oy+p3dh4TdO0NfPEEbayPuB0bKM3g2+USPS2SZC5edlLNfdsy?=
 =?us-ascii?Q?FjOYGRudoLwRuSgjIKYtiRaN++tHeiGDSa7eqqPUhdaEDcMkcKG6nl1gxS/G?=
 =?us-ascii?Q?t5WLLOexSteJPdTkOuPsfzoLrGvjmWY06z8tcG4w7T3kBQXMDwM1X+RAMTGo?=
 =?us-ascii?Q?noMYPHqNOnco49MGH4S8sounFUDmiA4j8Q6jcQ5URIJrZjOqlUzFW1stBuaf?=
 =?us-ascii?Q?lSXrQ8swws4LB3w9hqV7xFvKPO55dy/DkRNyla+n37dM3cIM5EM1n4goUv81?=
 =?us-ascii?Q?jJ5+Cf/C23wmFSatYaSZHpNCG2NeMspQpShPyJuLTfqFmBf1NTv/xgA7tgWP?=
 =?us-ascii?Q?v/mSP21wsKC2l+TrfvEK6g8M7mfOpcnDh+bZgz9wo5iGJ5f8l9+Cgi7EFQSI?=
 =?us-ascii?Q?OczaBW+F4qr/1sGjO5Dq2PtWh2W6R21GsfkG8rMJndpPdjdnfkb1TmfssHLk?=
 =?us-ascii?Q?LMUHKM+Cyhn5lOuveRWPYOEYUKKNh3hToKAVND2bL2TKAE5awXLq0RAFXEHt?=
 =?us-ascii?Q?vTKX3J0+MOulYDwXkTBnIFUkv2+1ePsrjdf5t/94uqlidb+hfwtEIzFE4nCU?=
 =?us-ascii?Q?L+K5hJOasDK5ttxVap8C/Fcts6GevX91jy6S+cvNrwYn7sGk42ZH/QAejYp5?=
 =?us-ascii?Q?1KZGB0FiFAedBuYeVNI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 16:40:02.2785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b56d409-b082-496c-1172-08de4c7912d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Document that the 'len' field in ethtool_gstrings and 'n_stats' field in
ethtool_stats serve dual purposes: on entry they specify the number of
items requested, and on return they indicate the number actually
returned (which is not necessarily the same).

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/uapi/linux/ethtool.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index eb7ff2602fbb..f66adf15a3c8 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1094,7 +1094,8 @@ enum ethtool_module_fw_flash_status {
  * struct ethtool_gstrings - string set for data tagging
  * @cmd: Command number = %ETHTOOL_GSTRINGS
  * @string_set: String set ID; one of &enum ethtool_stringset
- * @len: On return, the number of strings in the string set
+ * @len: On entry, the number of strings requested.
+ *	On return, the number of strings returned.
  * @data: Buffer for strings.  Each string is null-padded to a size of
  *	%ETH_GSTRING_LEN.
  *
@@ -1177,7 +1178,8 @@ struct ethtool_test {
 /**
  * struct ethtool_stats - device-specific statistics
  * @cmd: Command number = %ETHTOOL_GSTATS
- * @n_stats: On return, the number of statistics
+ * @n_stats: On entry, the number of stats requested.
+	On return, the number of stats returned.
  * @data: Array of statistics
  *
  * Users must use %ETHTOOL_GSSET_INFO or %ETHTOOL_GDRVINFO to find the
-- 
2.40.1


