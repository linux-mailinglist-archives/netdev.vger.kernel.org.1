Return-Path: <netdev+bounces-101255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A898FDDCB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5368D1F240A2
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D7A1DA4C;
	Thu,  6 Jun 2024 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SefYi4xQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DDC13C
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717648721; cv=fail; b=M1i/fRw8DrEQX6cMjnn+8vMUm4ansEtLKhSnlRXVqqV2/Rs6pkJszCidGSvsWYfC75JsPvo6fvwAF8yeGPqT1BPhfujlRs9rI/5djqKAcYqRtY9nBuw0BI/DXxGAP+PTokwz2b6jmSxNk6urKLO/1joF47sSO6weT5DcdByqqhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717648721; c=relaxed/simple;
	bh=+tbKpv9hSphhMGrMcc+IR/+j+yGPEWagHr8Cuk/SAyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUCovCMFJ86Uu7F1m0zJWBuHYCDyE4eMHJxEGqjoR+QGVj3WGytn3Gq4AM8odZwZco289hFN6wg+kwaUUGXoTdzLaQB5/iS/5jjOk3Gd+Km4rC+KtRNHOyegTY3H+yAjOIVN9W9LeVDbPJk6Z5szquTyhg/pf1l8ouBt333dk0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SefYi4xQ; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRRgbvE7zxfM8nVW9WJsDCePk460i2dW4BGj2N4kknsCOzi+5BR1xFDFBYZysnMJ7XwOqJ5a837L7CmLC+hHhUltPYND4EtEEHPtqcbAlbrQuK6k0ApHyrHECdJ9hkQtdB8iwKMPBNaA2oYC28EqNl9zH71j+YYBPzYPFJC12Sl6TnN6rogqtQ2X9rr49hl92/xRKvOZvJ/zsuzaYaopvnGI8VSRLjiwKJNv0j9PHZIgo8w+UkIixHq0hl7A3A9woeACXbBjCsUPSpcX7wIJrD8AzBHcxa/Psv/CVBVdtzy4aqlkmbfdLnT4Hg5W5U9MGBUFgptiTH29YbsilDhG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYlTW1VBzsaoLkD2eqCrX7eKhBokF9uKvcWQsoaMgXc=;
 b=FmiCnRKIPQe9DxLNLBH4wFeV1y6U8a+yM96hQGz8STB4r0xCaqrLGdASr5sK/YeZqBtYU5bRGzlwcr09DnWrD+dtj5OLhrzvcXx4y4oaNL/wRUSh7ad8zJuVCEAeQfnBgj9msn0oHZSGZm6uGtR4+sE+duZnTH+9bh65mneHBbnpvF8KyChUWp98ibhmOrlanqBYP4wxaoMv7gJcDNm4NMoABloZsDZrkf88q+gnJYIDlQrkrY+SVKQWHNQE/sSL2xb1GkSkj8/uC1OFww/Zecty1/k+28TvBcGU90A5e7EGXEBs/FI88VSUD2KYFkPx72WdhdcmZOpd8saDA/RCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYlTW1VBzsaoLkD2eqCrX7eKhBokF9uKvcWQsoaMgXc=;
 b=SefYi4xQHSLoSeJZgBby9e1iZkyTrEk4Ae2b1Nx87LgJqC25KLiAdJq/G2gw1ANSFdZsFt3K57ECIQHljD179YHlOGe3icuLqrrfaS4uMs/MGEBElNeqq+4s0uNqTu1JM4gVIgI/qM4uj8Y6Z8j43aH40lYLzIsdIb52aEY1icZUvERal6nsOLeFuav2aetKJNm+DEYQlbLqzVCzEKI35fztSa0FNQFsOCFggVPC95OpbPhXvqS9RC9iGUElHUQRHEb8xvWRWOZj3VBbrW4qmyVQyhq8HbH5ONR7K2UOBTXrJT0zOwtjCcZNF2XcZHRFX30WTApl9ExN32WWSHaweA==
Received: from MW3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:303:2b::6)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 04:38:37 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::a9) by MW3PR05CA0001.outlook.office365.com
 (2603:10b6:303:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7 via Frontend
 Transport; Thu, 6 Jun 2024 04:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.0 via Frontend Transport; Thu, 6 Jun 2024 04:38:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Jun 2024
 21:38:22 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 5 Jun 2024 21:38:21 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <dsahern@kernel.org>,
	<stephen@networkplumber.org>
CC: <jiri@nvidia.com>, <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH net] devlink: Fix setting max_io_eqs as the sole attribute
Date: Thu, 6 Jun 2024 07:38:08 +0300
Message-ID: <20240606043808.1330909-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e76bbf5-6cfa-4277-d59a-08dc85e2880e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UzEtFN/sNFCNBfZ/m9dqLE9xksC8x5f5x+jR6k98fO8wdnsNDqxm51GH94vu?=
 =?us-ascii?Q?HQ3tMp3eqIzI0c/PIR1VjZY21EYMMbm8THJGFRnuyfa4wOkkzw9KnEV6ZGw5?=
 =?us-ascii?Q?8xzTSc7fwR6HAXLJL7vgW/Ynqrja24ibOJeZSZc156mSrTDNdfgDNVDEOujJ?=
 =?us-ascii?Q?8D5Nhxyf6EIpAbFRf1l7MFywayandl7wgFBpE37MaTaLDK0WHGr0CI+X2fDZ?=
 =?us-ascii?Q?UjSwUrywUnotO+7fJubxhtxf6J7KcbJVptY00dwxvXNTnGurb0l+j4BF1zZE?=
 =?us-ascii?Q?OdYBvhNXfM7TzIapz02gCW4KP4SdgJ1a2gp+LwzXktHsB0N/asQtx1KZZ2iT?=
 =?us-ascii?Q?LgeQbSXlo8/PKKWqzYXIu93kFfe37cWglroq/9NmQdKswWScx+fvN/Res4Bf?=
 =?us-ascii?Q?WtFvII68tuOeL9znhYA6IZL6QBrGKPAv9JTutIi5kGAlj1wVBeUUPPRcTDlY?=
 =?us-ascii?Q?uaGn1tzHJhTBEmOM4VCzK4ySPzBDCU3/iYet3DHSvepKzIUq4vatLAkXEGZ8?=
 =?us-ascii?Q?Ziu8GKZ+2VLdn8cADj5ry9BM4ZHxfhyLjefDDJ1FkKyuAx44EgWJUX0Ne9e8?=
 =?us-ascii?Q?oVRCkt2xJyg+oOVTnEjobJHUwqBBlIR8Ft2R2aCBWAOZZlWru5aAgseUAx+o?=
 =?us-ascii?Q?ohBSr0FZTFYLrmw3XxE/oU9s7gokZ/+FMkgXWyCtnT2XOJSoinvN+W+a8P21?=
 =?us-ascii?Q?uqSbz/iMxy34K2N18f4LfBnkKlccLoQ4Lh2MeLALbOS7ACD2UHhfICGflGyP?=
 =?us-ascii?Q?SzDL/0Nri9YyEEoRSLgskmn+NFGW8G6MgnLN8g5JxwoQj6JwGQPTHfJR+sA4?=
 =?us-ascii?Q?ouHArIfV1kkoggKgDNCyuYChNohfu3d+tSODftij0jLpNzFFOIrWAAUTQNLJ?=
 =?us-ascii?Q?/FqpMyoLK8nAttYdtArvPXuTewlU4+RWeXXsmzch20hznT4K9Bk6WfKnqFEB?=
 =?us-ascii?Q?Z18BlTjFHWWjqbhbmh794K2SqwA30LJRhVTkOnXq2YMfyNJ/gd/SMSsyHzQ+?=
 =?us-ascii?Q?TKtKVoZc6QkaN2nH4hG3E7ORG6noasDiXoOM5M8rpGACRMVaubLGC7dLsN6P?=
 =?us-ascii?Q?8Dm0SFF/psONq21qzvlqECI8seHSFgsyXdoJylhU+QU/O83PtTAT4mdBL8M7?=
 =?us-ascii?Q?V/UVsLh8Zj0Z9kPY3IrBnuxOEDC8kt2zgn6LedppWGq3aCXGK6OCxAul+HXC?=
 =?us-ascii?Q?izkxZSRm/Dn4RYSA7Jy9R0/9BebrH9ZdSe5uATERYLiSiKIldoqUFt8ehyGt?=
 =?us-ascii?Q?ayP0WaHmJeJ2hx6XN2ZzExhMvOq7PA70e+kTgrL1qXRDpQUk4aURkBmA8NnI?=
 =?us-ascii?Q?RZ23CETn6uL3zUty07wQDSIct3SWDFCkvo8YeF6/YcV8jmohkEjYJxjnH1as?=
 =?us-ascii?Q?kgPLeVixBVHzbYQuubXFJY3p3ofzGQQaChsYND5EhjGi2/89qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 04:38:37.1231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e76bbf5-6cfa-4277-d59a-08dc85e2880e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694

dl_opts_put() function missed to consider IO eqs option flag.
Due to this, when max_io_eqs setting is applied only when it
is combined with other attributes such as roce/hw_addr.
When max_io_eqs is the only attribute set, it missed to
apply the attribute.

Fix it by adding the missing flag.

Fixes: e8add23c59b7 ("devlink: Support setting max_io_eqs")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 03d27202..3ab5a85d 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2637,7 +2637,7 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_TRAP_POLICER_BURST,
 				 opts->trap_policer_burst);
 	if (opts->present & (DL_OPT_PORT_FUNCTION_HW_ADDR | DL_OPT_PORT_FUNCTION_STATE |
-			     DL_OPT_PORT_FN_CAPS))
+			     DL_OPT_PORT_FN_CAPS | DL_OPT_PORT_FN_MAX_IO_EQS))
 		dl_function_attr_put(nlh, opts);
 	if (opts->present & DL_OPT_PORT_FLAVOUR)
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PORT_FLAVOUR, opts->port_flavour);
-- 
2.26.2


