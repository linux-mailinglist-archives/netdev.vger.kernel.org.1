Return-Path: <netdev+bounces-113186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F259C93D246
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809531F226BE
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468F17A92C;
	Fri, 26 Jul 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAuhOMP2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207517A588
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993364; cv=fail; b=U1WW430jQwLFa00Q1b/qJD2JyhyLliVr6CB6VQ58tVfaH4xmMOZFgH9JPOcBRBc0ZOL4FcKzHx/UPSW1mSTMU0nm+9Xc1+IUH/wGunGFzytDxxGB4p6SFTGI9LxWKMr4OHpC0gkZOZmya0Wyg4wZeuyKR5VW/4qglpOIcbmfxfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993364; c=relaxed/simple;
	bh=FoLEUWU7JtRrbBu3wq7+uKCniy03Cy4vl7NcLCYuzwU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=p4sO+MzsKRi90ZA5IOIaDGqcgEYQjnFRJguseyvu/2Ghko0hMLcT01sBpe+kIM0eKZRq51aHlSpFdk1iHNnHj1BGBTL3HIz1wBcVbwmS9bwYnynKjJlB2TU1nSqSCfjy0ZGI5RF4lG2UPMwe8rQVDyEV8peqZ7COpOFRyQ9o4A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HAuhOMP2; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XADQ+yrJ4Ab6Aj5dRtDUdOAhnSKeTN0L9BzY6kJzgpluakFWI77YgzT85YE4feBpiov5FHXleloPZ3v3yjhgmQNxz7rrvn1Ax/C45QV+/jKbwR1u0UHRx4chxcHFBvFvKnMSVbkS3ZIQtRHMxkyRvtjgt2JTXcM2J1nmeh/3vct7eCIkshRTqrc4b0CwhJ8V6Mp8kEQd1/21A7Gb3uE6rdocK/UwYOJUUcyDjNG36XFf0RQ0nW1vyOsbV5w3Gkkbk9N0QFoKQ7LGlyTKvMdFw+yLfSBVfzy0TqHbTDaN/br04V6/Z7hr/Wv1hRUO/H12Unyz3RITI/xo/nSHKqgizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2I1hi+uU9cgD12fTjG33iWNNbLpkzjN87NL4kQ3pCRM=;
 b=kCn0aIROP83IYE8FiSGjV3//QDFGxkiTaZeRHC6oP7+17BPhcoOaYpBdX8eTr6XV6etaEmRVEzJf5cnmz2Vg/hO7X4sdhT+JpNEGU8vv7+GAn4HrHXyrpuugPSRUzhx4ZoLRYsZae0KMgkQKl7U/ExFeejeN1SUgRtvpPmyiEQIedy1Wm4qWodWtLViFQOMWsAJKBYihMEGJdcuMMoSbq+/cPvDRReYEm0u/VN7r2Mym9zfR7t5YYgr8o7vrt7CcJDc6Bb0++48WJy29UJmMFxSt/H0RnWYF+cv1ZWJloVCHR5XEaYQv05sESbC5Xpvd3eRvgZZRhGbfCvL+ANzKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I1hi+uU9cgD12fTjG33iWNNbLpkzjN87NL4kQ3pCRM=;
 b=HAuhOMP28uYV3LFqNpLYqOj4/+ZzjatoOUqVRu1aV6GJOBwtbL/4P6j+TZHBGzWsmpO2/pClJ/r9wy5m7Qt/pukdG4Wfo6H8CqsOxT+k1UrlRHPOLot2M3zvFvI4nkZ/aPLL39CH/M9Mm7Wm1Fdj0KwlYaRH/w02YQNpFQhsIlOMPZgvboWWlml6929iY2oaSgCYXCfmCneLZmY2XrJu7DmX7a4Z9JHKz4g1/Wyy738CMVBLKgj0hQXVn22JqXcnPApicasJ7R/BC+4OYCG/yj5HRneGMu+8zBZGhTkFFCdYlEP2E3jYHMyItpgBlWBx4u68MbZcbtXq0Yfp3qwalA==
Received: from DM6PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:40::22) by
 CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.31; Fri, 26 Jul 2024 11:29:19 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::45) by DM6PR03CA0009.outlook.office365.com
 (2603:10b6:5:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Fri, 26 Jul 2024 11:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 11:29:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Jul
 2024 04:29:08 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Jul
 2024 04:29:02 -0700
References: <20240725222353.2993687-1-kuba@kernel.org>
 <20240725222353.2993687-6-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <michael.chan@broadcom.com>, <shuah@kernel.org>,
	<ecree.xilinx@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<ahmed.zaki@intel.com>, <andrew@lunn.ch>, <willemb@google.com>,
	<pavan.chebbi@broadcom.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net 5/5] selftests: drv-net: rss_ctx: check for all-zero
 keys
Date: Fri, 26 Jul 2024 13:25:06 +0200
In-Reply-To: <20240725222353.2993687-6-kuba@kernel.org>
Message-ID: <87ttgc75ol.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe12d18-a795-457d-b4d0-08dcad663049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hlAAaEC7uqlJHeaIRKF93qec71S122SBeULQpxJoNcA8jxk5S3BJS+q//VQ2?=
 =?us-ascii?Q?tH0o6ydsiGgYtcrnhI4FWeMfcgsg840iPmsxacnUFZK1MGJafc6cnwc09VSZ?=
 =?us-ascii?Q?IjhTubDRUq7wFGTaie6xMH+8chEP28AQ/NN+RjKCvcQkIsdNAsEsVv2PbD1f?=
 =?us-ascii?Q?cr6Q+O7SoECe1IkkS49B8oIkR6v00tBNy84WHB+qOPdytE256hBtCWeCvDYB?=
 =?us-ascii?Q?++I4/vwPVRQ0W1fPs7oDdpGehDrRj+4nzyTa7eNGlxyZVSDDFzndSlNRlVZm?=
 =?us-ascii?Q?W0Kx9wGC/Iaa9h7xty8MTjlLaAES+mV9yLTPnnd0mqtMHEoiWJ4nmVmb8ZHt?=
 =?us-ascii?Q?o76IodOJ6YYIw0IBmApCGYslRTN4blm0VwIJw3BfAAhQCP4ymFUgg8LoIHSx?=
 =?us-ascii?Q?obGmoqjdq74l1CRdrwbFCzIMrbhsIAziy0uYwb8fVdXfhdKFYr2wIcH63sFD?=
 =?us-ascii?Q?G/TIETr/+O5O4XKW+98i5xfjbIl6z0bA4WhYEQYDDvHpT02DROnKgZxaLSsd?=
 =?us-ascii?Q?FoFVE87HSkFpla8pi30q9e+wTlHWyQZAF3eo8iR8SG8zKZ8Keb5+3FNvBsMc?=
 =?us-ascii?Q?IeP7CwUnyxfx9IV7OKz5SaTp/ckkKaOgYOS97+mydiSeYt7qvP4E27lR+mdd?=
 =?us-ascii?Q?q0pSBNDEZorx8lUdCu4CJjNacM7fJfvImZnFzRhKLmuSY73rV69ZiwLeKu8L?=
 =?us-ascii?Q?9kQA59ekgPpSJNC9hx6gR/ZU81EixTet75pUAB0IFD5q1+C1ZJXvdplDiVpT?=
 =?us-ascii?Q?99PcLNVJib/4A41cfppfExaPmEEGfxCLz+GW3L1cCqkCBIQOiAqVrfiWyQhC?=
 =?us-ascii?Q?0n63Hk62Fwc9ZIeFnXGf1bf8fBohI58LCViEQukv4euk62SODWuMc1SKdEj2?=
 =?us-ascii?Q?NI/C/f+DEiD+ixO+aaMDGcQMoMe6BOspVgyP1avQnXAc0ib9Fj32KGOCR4QX?=
 =?us-ascii?Q?sDskQp38BhLeFqR00iOcmA+c0QYXOF3vhgARx4tAsGzmUBDEHW7oXW1emgBc?=
 =?us-ascii?Q?mcIc5+2jlx4L+uwilImbsxYQxVI5BxjCwxuhufcXduMiw2qkatXOET6s9MaZ?=
 =?us-ascii?Q?dZylaGoxr78IMHcL+qb5+ITE2BLsiIQc0Z2iTIjb681I636nDS0BYLcOaPjf?=
 =?us-ascii?Q?nOtp1yY+uTmZVeyzB7504+3xX8pyqfRWEjqwEYWvq7SG+DqlMAtVUr5KTroQ?=
 =?us-ascii?Q?JbPveQOuC/j8Ikyy/B96MlxNR/NncmoqCaAIe+Cb3PlOkqhJqvcpjw93okd4?=
 =?us-ascii?Q?bylxpcEPcwz5GIi5n8Jun6vSr5itRIaoFB7L2qz3u59diiHp9Cm76oCZFDaS?=
 =?us-ascii?Q?bgnRg4RTHFEmiPqvUV3Bs5bkKLgWNoKJayislEgjBJqb2UvoFdqxa55dLWC8?=
 =?us-ascii?Q?YeZIEN2QaV55tuc5y/ZuZqI9uEpRs+k0dQBqPVC1aYFJTOIOmEv9NwaX0BA9?=
 =?us-ascii?Q?P6BgjPAu3CiVPaaa3fZGLtsI851F7yUg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 11:29:18.6767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe12d18-a795-457d-b4d0-08dcad663049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491


Jakub Kicinski <kuba@kernel.org> writes:

> We had a handful of bugs relating to key being either all 0
> or just reported incorrectly as all 0. Check for this in
> the tests.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> +def _rss_key_check(cfg, data=None, context=0):
> +    if data is None:
> +        data = get_rss(cfg, context=context)
> +    if 'rss-hash-key' not in data:
> +        return
> +    non_zero = [x for x in data['rss-hash-key'] if x != 0]
> +    ksft_eq(bool(non_zero), True, comment=f"RSS key is all zero {data['rss-hash-key']}")

If there's a v2, consider changing this to len(non_zero) > 0, or
non_zero != [].

