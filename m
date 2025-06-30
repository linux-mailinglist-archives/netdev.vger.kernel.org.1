Return-Path: <netdev+bounces-202459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCA3AEE02E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AFF3AE8CF
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8FF28B50E;
	Mon, 30 Jun 2025 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G1y+x6Gm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FAC23AB9C;
	Mon, 30 Jun 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292517; cv=fail; b=aFOQD+0trfzoCNodcNrQI1p3oREdKumE6SvzEMNbeJGvJUZswmEbPzdYaqdtv4Upl2lz+yE0oXyFnSAqT2Uo3quaHoAoIs+A6JcDNqIvYgEefXOysLvkEUeirmdzxe+0eXXTWPLUVqL0Jmze25BrS8n7i6NjYRYKyZuCZ5erfGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292517; c=relaxed/simple;
	bh=VtfoxHCtXyOfvw4ubyb/YAQ4gMUPx/X8vwJT/T+o69o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMaPNJv3mMzveh3VN/S1jvu4tdubv7wfuo6oQUdVeb1ruLaQMp7R85AjOQvTlv24NCtrYPsF1L1KezK3U+WoaJLqily/pU5zsiCYXst30YxRjusTrQkcNisLWM3YOgs4pCe5vjp3/YB9aHlJEKDmvE6u+lcQ6pC37x2SYbpjBsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G1y+x6Gm; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GARj8FYdC+sZ1G1y+nz+TZB8Nc1hjTITZh248OKLUKEamGAbz7L+Jc+jP9OXp6BsfRN8MdrKnl+0VESli/wBNo+e8GlsARFFyQkYE9dB6D2WG9DOl/5Kvvk2YRuFWM04Y3WApz82/bNGmgg/HHv3R7lC8uhpw0T2o9u0SC+wDzEk4wsrWh4VCLmndUurY5mGVHhY3XgalbJ/rKqAf0qsBXftZHVF8G9b2b4c/znmeyMywn4ezt8j8ry6NU3GWj6fwGu1qgE+BPOenTIw710KoTQZBgtF5KwwjZ9YMQZLOsdrxI7UkNL2Hr3ViGCrixU7lD+s03U955PxM4ZRTeSPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iESXFwQqVSypFpeVOeXE+hjYnWXEyEWDzkrEiRsf2Ek=;
 b=xNWam/v95hdHq5/20WTwvanYag3XScQL0GJZTfx2feg00QcAS1GhUvJA+E/D07QD7EKTKiTNdqbcUYUhoY02HDnlxKDxkGH7OaLsC4Y1xVs5DQWnBW6NqmvY15sDjNXTmVSvdJaLDTzsHMzVsHTIU9/EeJ0FXwZ35Xip7T7raqtUcDff6mI733K8icb712qPcrocIM1m4XtmdKQn1xS0+QmmHKX/WFH7sjd8dIYSRA/Bb5NHMMNMxzkCgwyHOrv7KqgG2jthK+7sofwVMd02hfTCQYF056csBQwupMJAqh/nibiv9Tz0H+mP4UF5L8CUfQnE8nsd7j8C0v6Xw5lhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iESXFwQqVSypFpeVOeXE+hjYnWXEyEWDzkrEiRsf2Ek=;
 b=G1y+x6GmybC+SzDoq397hOR1QISkje09jHD8Q/RJ4AdMlo6XyFEWaz+/fRCr4+x8x7HOaoyDfFgXdO1RaYmLluegeEH/n9TC87S41eMvRebQt15pfRCsnC2mb2qQPZQ8F1BgBWgiXryacIh5AoKfkHzIH+EhT2z/mxJm0FO06QtedbykHVQXoSFc+25rkuCvo57HiSa+gx6MpNoL9MeaWJwE7We9uagmW85T16HA2w4+LlyVFb1JA5xmUBbgvYR7QjVW1379il/Lbqw/TeFsCHCFCf/6AUx5oyHm3PLLadnzcCrCgyZBcXLrR2CC8Msb+JVOeE49PKdt8/SQQgTl3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:31 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:31 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	linux-doc@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	corbet@lwn.net
Subject: [PATCH v29 09/20] Documentation: add ULP DDP offload documentation
Date: Mon, 30 Jun 2025 14:07:26 +0000
Message-Id: <20250630140737.28662-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 63751571-5812-4f8f-71ae-08ddb7df981d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UIbF+dDVQFOMGeBT8HR6U080b1UtXVlpbdjd57D/TtKioYmpXu/FzPd3RVQo?=
 =?us-ascii?Q?eNr4eZUygD2l2SUr1OSzilGIkGnRIZn9W22c+2v+lUBaBn7UhHPop+JZlIgS?=
 =?us-ascii?Q?Jv06TuNJwh1X3Y6ierTermUiSYVG0Y1LpWN+nOFO1TBXPAM8gj32/dAee7pW?=
 =?us-ascii?Q?P2xBBRYNQi1aM4sp4HKhr2ZEWajLglk6wIZ1OQhx+YxWThZLEJD3cQ9h83sk?=
 =?us-ascii?Q?yChhS1w+GnJooNgrbx/kuWrBQH9VvCCQNLGfkRSLdRP5R7sTj9egSrHEkYI0?=
 =?us-ascii?Q?cooAKLWrPMM0t2i7JLzL742YzJVO+GEI/Z12l9h8i44b3DcJmFdI1imXB4f7?=
 =?us-ascii?Q?TbbINLfuYMj+fYMQof+oGT47DwpQlN+hpSSkfrPVo38j+/bRpjUn/aFxjXYb?=
 =?us-ascii?Q?QJUCM1ClyzKG1W0Nluc5E2MYspoJvJ6d/ONnx1v6JvyAiQid884QX7xPQUCS?=
 =?us-ascii?Q?TtpIb5MGAWXeneY3adkYNoNUhhnxxBeucAb9dmYITCg3uzJNDVo38Df1sHD5?=
 =?us-ascii?Q?zhXmk3VI+wR7OlJvbEI4r5WS5RWohK9MWvApGom/0nE2bDwKX8m6gNZc5fXW?=
 =?us-ascii?Q?nASLG1aw6rQs404AaDN3lN85j4w/4xYH4zCzffOYxJwJORj70DuhKwPCAjAc?=
 =?us-ascii?Q?FbUXr9wjIxteCFrtahWmZiO2ex6YU3X1ELPx6B/mYfwqmhRBgh4lE3asFBfV?=
 =?us-ascii?Q?VaWxs8V09r4rFmGua1fcsIiM1LwCHYpEIlokAuk/XDMWnt6W2sNGnPPLFNYZ?=
 =?us-ascii?Q?CV+TwMxIxmG9p78FEc7gul8yIl9V/Xux3jh9QNQcg3Z4AbuH8wAIyxvH2rUQ?=
 =?us-ascii?Q?Jp/O8IUkeNiQDnxpStA0W8bvJ7uKpfNHZS2N3I1H5C3GOyCl4OBeN8fR1E1+?=
 =?us-ascii?Q?f/HL3IfxN5f+XJoNTMknZkPfsoEycuRMNRi4p8bQZ2txG6xvo1ppGsRxWfYB?=
 =?us-ascii?Q?hA3LjTbaoaMeiPFFvdWXs/ctjcq6KcCQf0JaTHT05qROk3f5uJPJzhuEG8vY?=
 =?us-ascii?Q?7mPcgqe9TOPuhb3suslIXod+Nz5A0nY6ZvbbR6/SsShRQwXJA0KsJ1E+3pz6?=
 =?us-ascii?Q?gxVnIdY7Etg7iBskitIDRqgZ8aSmhBDHgJIKJs/rqUuhwayUGkNNwebOJwfe?=
 =?us-ascii?Q?Mm2O9YI3E5WLrubRuwCDgyfd8/n9+EC5UiWqXz7x17V4ZA+fn2spDuwcA2gJ?=
 =?us-ascii?Q?rHJljPRzfJGJ/GjeP7wobUhS+XLlj5VifPnH96E8Q7kH9TkogzRz48fOwyXN?=
 =?us-ascii?Q?fukeWqGq5y6IrIhcxjb379MBubdVWDJ8iZ0AGX1rk+7BJlNVx+HA6Sibq+lp?=
 =?us-ascii?Q?5IyETgY+vksQ3prCd1WaOeFcWg6IbKS5l4/jJB9VLPdERJx6lYWZ4GYCVQhy?=
 =?us-ascii?Q?JohHAlzcuB0kt3v8zenbMe0JaK14576bDqwBPCSzT/4XMAGIhGIMCsXFUhBd?=
 =?us-ascii?Q?6n/6rr9NB6I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q/XYROjCibZYcCfP8K7EDzKwrH8yAICyn66GlQietazSFTroe1ttzDXrvlA6?=
 =?us-ascii?Q?6kvoAnqGpOHsvJ59J+uj+NwXuAqwwnYUjOPaaf1+AXc+SxBwe3lilU3Yy8l6?=
 =?us-ascii?Q?FV9mMjY2HLMu/09a2Aa9whYJ31cTmFxFX5epLjQ0vzMXm4eUa/+0jPjh+oMF?=
 =?us-ascii?Q?hiu6vJ5rBrmQm7LiGrob/l2plCD75ib2FTYuXUc56iqFIVJ+1XsXmFVUuy9Y?=
 =?us-ascii?Q?qFQr0Om/4VOiJ0/62upcWh7d6nW6W1w7yKXboGT8TsQx846HOJVaQoRZblli?=
 =?us-ascii?Q?EmRrU4qNmIHCE4LWuzDb8hXZV7S4Es9tdoHFA9ai4rJOBddkBRns9EIef2eU?=
 =?us-ascii?Q?vn0U/EjJy2d2xARM0R33DI0ISwLgepXxgjf0qeCPfRO2U+7fCdmrCp5qT5K4?=
 =?us-ascii?Q?r657c5FE2cSO9moEK+Rw5Utn8NUfm2+sOcsUosDMrfP+Z8OoYPLr+mdlX+Cm?=
 =?us-ascii?Q?+V4K4P817j+mPF/raXebkPp5J21NMFAR6WErjjT0zY6NLLufe+jQskxfItmj?=
 =?us-ascii?Q?cR85HVf1GYUPmnf5u5Gw9YkhhlukH8L7kceeQTO7rF/xNXseyA6xFxf6cXiX?=
 =?us-ascii?Q?LzPl1vd45nAO/AFCdlkVjtvjn3SX577nojUoKT7aUbwqCztlYhh8fl7rEXLU?=
 =?us-ascii?Q?zamOcYsKVP4xJeaw3/4CzqrklLsO6DfdFlS9rwO0C9CG0JvHl2aNAimzl2ua?=
 =?us-ascii?Q?Cdwz09bOFSRJhde5oP5fSceakBFgGNmxpZH7A51XU4rJYNB41lJ66g+6xBxO?=
 =?us-ascii?Q?tYHP8N2GfcCeey54AnblzRLAaMML5gBUL/zB7kO+8xpE3tzaU+gOx8UUlCQE?=
 =?us-ascii?Q?Tc5EuLwE44Ih62yFqCePKBtJIDrMIj0oarBEy2jGlME7dNCyMvs+fAgMCFa6?=
 =?us-ascii?Q?GrbGhxi+gSYbRKoEWGWzutFchVBsGcmQtcBHK8rAoNPnuZWCuNXpmKoegST5?=
 =?us-ascii?Q?fsUebIrwMLlyaI9VDDG/5NVqHvmfGmQRU9S+tpNGdn2kF/i/Mnp5Ifs1oSHi?=
 =?us-ascii?Q?LE5j/MtFaIovyomfivF5JSKl6T7AssXUqfjFYaN61Zw728PEjD3KomcXBPwj?=
 =?us-ascii?Q?7ijaVGDCDZtIy9L9wQ2/Nv7VbBv7rDUZvx+eP37NspgcC9X6wAHPA56jMjbh?=
 =?us-ascii?Q?YKTSSKd2VJWSXC1UI6MnLnxxIKM1+M+VJyJgwXu1rBW0L5al0vuXg9Ncgyvq?=
 =?us-ascii?Q?Swa/RiIZNaC4sSAaf10u6Jf/cy22iKeuUNrPTXGONnpsEu22Dh8WPZuPXHkn?=
 =?us-ascii?Q?tXY1/V8pNpScXf8j3/FLKOjxV4GP7h5fE710sIyXklwOTVu9pIwnZpw00Goe?=
 =?us-ascii?Q?gz9SFOU2scqvgSElIyRtQT6Qm1cF/Ihiz+DoCKEclHe3wl2qTmzsap8aIOQB?=
 =?us-ascii?Q?h0kAO/V314eSlnVugy5UIsDKAmDY27TT4L7+Gtim34+eldTmyKxDP7bEGBf3?=
 =?us-ascii?Q?/a4eVpSEUd2IbIF6QJaoQ1XCYeizGru8Uo2vY0TqU/mjkwiBg62x8T0RI9mV?=
 =?us-ascii?Q?FkkW+WM1hPv+S7t4m1wJ9t3+PO7bezLxDkgLYrnsymZCljrf8ZGMyso//ybs?=
 =?us-ascii?Q?add3N9pCmA06gqJubetN9qiw530JX5Bq7+QFEgVj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63751571-5812-4f8f-71ae-08ddb7df981d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:31.6082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07S2W42JBZUas//Aszs478mhNWZm9/SEynyFqIx7jlaSGy3d3/MstOVV6/QNlbZwcBQnXP85LY/Tf5KOOtKWUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Yoray Zack <yorayz@nvidia.com>

Document the new ULP DDP API and add it under "networking".
Use NVMe-TCP implementation as an example.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 372 +++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index ac90b82f3ce9..41ab7d1f9c0e 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -120,6 +120,7 @@ Contents:
    tc-queue-filters
    tcp_ao
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..4133e5094ff5
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,372 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+ULP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel ULP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
+Thereafter, clients correlate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+The driver builds SKB page fragments that point to destination buffers.
+Consequently, SKBs represent the original data on the wire, which enables
+*transparent* inter-operation with the network stack. To avoid copies between
+SKBs and destination buffers, the layer-5 protocol (L5P) will check
+``if (src == dst)`` for SKB page fragments, success indicates that data is
+already placed there by NIC hardware and copy should be skipped.
+
+In addition, L5P might have DDGST which ensures data integrity over
+the network.  If not offloaded, ULP DDP might not be efficient as L5P
+will need to go over the data and calculate it by itself, cancelling
+out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
+DDGST offload. On the received side the NIC will verify DDGST for
+received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the SKBs
+making up a L5P PDU have crc on, L5P will skip on calculating and
+verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
+will be responsible for calculating and filling the DDGST fields in
+the sent PDUs.
+
+Offloading does require NIC hardware to track L5P protocol framing, similarly
+to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC hardware
+will parse PDU headers, extract fields such as operation type, length, tag
+identifier, etc. and only offload segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the driver sets the ULP DDP operations
+for the :c:type:`struct net_device <net_device>` via
+`netdev->netdev_ops->ulp_ddp_ops`.
+
+The :c:member:`get_caps` operation returns the ULP DDP capabilities
+enabled and/or supported by the device to the caller. The current list
+of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST,
+  };
+
+The enablement of capabilities can be controlled via the
+:c:member:`set_caps` operation. This operation is exposed to userspace
+via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
+details.
+
+Later, after the L5P completes its handshake, the L5P queries the
+driver for its runtime limitations via the :c:member:`limits` operation:
+
+.. code-block:: c
+
+ int (*limits)(struct net_device *netdev,
+	       struct ulp_ddp_limits *lim);
+
+
+All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits <ulp_ddp_limits>`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+  * protocol limits.
+  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+  *
+  * @type:		type of this limits struct
+  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+  * @io_threshold:	minimum payload size required to offload
+  * @tls:		support for ULP over TLS
+  * @nvmeotcp:		NVMe-TCP specific limits
+  */
+ struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		/* ... protocol-specific limits ... */
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+ };
+
+But each L5P can also add protocol-specific limits e.g.:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+  *
+  * @full_ccid_range:	true if the driver supports the full CID range
+  */
+ struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+ };
+
+Once the L5P has made sure the device is supported the offload
+operations are installed on the socket.
+
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted.
+
+To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
+
+.. code-block:: c
+
+ int (*sk_add)(struct net_device *netdev,
+	       struct sock *sk,
+	       struct ulp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operations.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignment (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if L5P data digest is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+ };
+
+When offload is not needed anymore, e.g. when the socket is being released, the L5P
+calls :c:member:`sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*sk_del)(struct net_device *netdev,
+	        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correlation between PDUs and TCP packets.
+If TCP packets arrive in-order, offload will place PDU payloads
+directly inside corresponding registered buffers. NIC offload should
+not delay packets. If offload is not possible, than the packet is
+passed as-is to software. To perform offload on incoming packets
+without buffering packets in the NIC, the NIC stores some inter-packet
+state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet
+TCP sequence number. If there is a match, offload is performed: the PDU payload
+is DMA written to the corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seamless integration with the network stack, which can
+inspect and modify packet fields transparently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping between tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
+<ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ int (*setup)(struct net_device *netdev,
+	      struct sock *sk,
+	      struct ulp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`teardown` of :c:type:`struct
+ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ void (*teardown)(struct net_device *netdev,
+		  struct sock *sk,
+		  struct ulp_ddp_io *io,
+		  void *ddp_ctx);
+
+`teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+RX
+--
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. Resync is very similar
+to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
+The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
+a request is pending or not.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`resync` function of
+the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*resync)(struct net_device *netdev,
+		struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the NIC driver must report statistics for the above
+netdevice operations and packets processed by offload.
+These statistics are per-device and can be retrieved from userspace
+via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
+
+For example, NVMe-TCP offload reports:
+
+ * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
+ * ``rx_nvme_tcp_packets`` - number of packets that used offload.
+ * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.34.1


