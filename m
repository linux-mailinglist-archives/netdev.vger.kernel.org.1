Return-Path: <netdev+bounces-166059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA3A342AF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EE77A5F27
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F2624293C;
	Thu, 13 Feb 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMvG8M1g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A11487FA
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457564; cv=fail; b=nsPLnvMcX/8m0HicBPKMmK7Px/kPxtpssYhvZBexdH6gkFR+SWs1GdpW2daB8ZJv83TjFEOyrOlWgCrY2W3+AOK+4nHIHIftJc22jj303jbyhFL5LjsRNrQhKEWWZcgWrSbA4iS4kOtOANuCtlIaf7pHhdlAQvq6nBHDky3A3P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457564; c=relaxed/simple;
	bh=06Gfy5RyNE2IRcL0uBKbh5P3/PLUiHYLGSkDGWgC09E=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dsMBPmStBCaRLyRPOGVg+mkfCdnJ4ZjnRZ/3Sja/4ZkfGsUXBC6WPE2onFq9qE6DYJm3YTh30vnmYjP6SXmB4+VYM82pRjjQ7m4AT33p9SifVo7PwndLRBFXzdTthhwEr/15/XrMOvJx7qC5MrFR1KNY3aUCG7OSyG0ogXLxCcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMvG8M1g; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXtOHM9xrh8uUCpQaCS1vd452ozwtN36Oz5Usgf2FNHQu0TVTEDujqEGMGs96GTwJkCW/aQC+mYWbDfNzEvPL6B0siDOYU9fnkKv7TNUTmwB+G5jyLYBO5Ai1NcWduh+L7qsHmJQq4z3Tfr1a/QZRm5vQTDid9B/t+lQ1v3UORlXWoFeIdHdhRcX+elW0aiY0q64pTiOByiHL1TsQDZntYLUQGhs5isO/k/hroda2sCD6ZDGMuotXHOa0TNoj6BXkX5NCm+Uh7B8Ok2nRButIYw10fCGYmRBs/AGJTc2dOpBTFAddU06uIZOnGmiOCmiok8ZPEiYG98d+zvq/RVJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvqoXIcyoJy1og1kcsh/+8JtLPBK/06zJHh/PlkN5Vc=;
 b=KcQsRcsPM3FPwsQfVwLXHO2Ar/Z6pgGMJjocDsxwN+yMBuslQsJ33FvDpVlTUHirliBGk2KFrxHt8lS2wBMn/N2o5W/yfNd+hs/NXtAICymQXClr5PZ7l05/CWp+lzQa45v3KCT6X2k2yu2TBJe9RZPfnw6IaZg8kEssaIPKBGxfkpq8FGDD19qaDHc7b0urxupSbr0CxDDsomz5B9ZNAah2ZTrg0kfMWqpVDN6az6L3azzGzx/PrLN0YG9+2/JsPuw3pOeLjodixqmzCk2AFpWkBwH7eCUEM5Fikc9Vn/1EDNh96ZReHcC6OSW/qCnssDZ1/5cI3fqRUnucSO7olw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvqoXIcyoJy1og1kcsh/+8JtLPBK/06zJHh/PlkN5Vc=;
 b=ZMvG8M1gjoa6QEYOdZpjQ2UElGQK2hNNnlgCCUFAp8xoclwWUhkW1gdg/KtHf/vFdwiZx3YyC6HBFLra5pHMLiH3vYh+TF5aVTtQxdUuzIcXOA1+O24sHtBAe/NQMawIAhL5TVpGTT4wtFiw/1iXmSez/HUG7SGgbSdXgUHh0qfH3/Ne+y4YZMUMYEGUL8YLYiS1xm1kQwFKig6rp1tcmYJPEuXrFHscPdbKHAWfPzSylaLGxwWbHBYkXkMqnuvccV+oIVHokyWyAY4OinVDh3aRwfXEaASx/EzUUjAODSotk/r+ghstY6Oix9hxrOZ2rQ2vMRM754aqiUxA/HPcOw==
Received: from DS7PR03CA0195.namprd03.prod.outlook.com (2603:10b6:5:3b6::20)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 14:39:15 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::b2) by DS7PR03CA0195.outlook.office365.com
 (2603:10b6:5:3b6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 14:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 14:39:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 06:38:58 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 06:38:54 -0800
References: <20250213003454.1333711-1-kuba@kernel.org>
 <20250213003454.1333711-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemb@google.com>, <shuah@kernel.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: resolve remote
 interface name
Date: Thu, 13 Feb 2025 15:31:57 +0100
In-Reply-To: <20250213003454.1333711-2-kuba@kernel.org>
Message-ID: <87o6z5di4m.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 857b2831-33a4-4223-407b-08dd4c3c2f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IlcJiIErASmFCVsAqlcNAAa6iZ+bWxxPeykdJNpGlg0v9RMhLzSUKFuGpjlA?=
 =?us-ascii?Q?O119iba5gdrnQ5X+5/1kE48rgqwMlTylMw6mKPzB8tolkloZHPeYiroVpHfQ?=
 =?us-ascii?Q?Kf7Z6+raMV1fBTpbTisZhioC2jvQggE101ttbppaPHnN6vtna135dbkcqdo/?=
 =?us-ascii?Q?XocFrcOyEaWYIgvRi7CCBGEZYXHOxiKyDWnnxI3MWdzaSmX2hSjXmbUNm67H?=
 =?us-ascii?Q?qDTq8dz4PD6Vov0eOqmBoktHeu40PWRDiGId4ur/77y6HaC6IiMgwjja/u/x?=
 =?us-ascii?Q?YgOAID/aaSrO7rcAxrR6CKD3lRNLLwVOBWz/ewC+hzQtxnNHytkPE8JYhy5P?=
 =?us-ascii?Q?7uvSEuwo27/KdqPfQFnbr24OleuhPi/yDbI3T40TGERAiqPVdPvSgtDAkb66?=
 =?us-ascii?Q?YBST+Ls5/+FnL+4A1hJMl80D4UzhP6yT4L0t/pdcKGO0erESj7yRVWH2m4aQ?=
 =?us-ascii?Q?ryOskptjFkup4BK3b/nYlXS3/kuzLfuXWEJmAAVSwHPQfGwfXsa8jhAv0+lV?=
 =?us-ascii?Q?EhSCyZFA9gryqBXOTBu5IvSuQaVA37XgdO4T9MD/qL6NWPTvtnOIYcZF+3Vo?=
 =?us-ascii?Q?5pr4lrOqEd4BVUQJ+rotpvd4+x5px2h7+yMtc0k+bjPvG+Zpuugnn5RiSgIj?=
 =?us-ascii?Q?2sbRq3tWg6/NxeloYOy7w2RMhnI1ZgcfedKPMjq3WPyvNfHXG7jN6V3sTPjt?=
 =?us-ascii?Q?rWeulI/74cl58/NdfYufrqGV19RQHjXr+ABiooq+r7hXDJ3STlUeWJ8HPdUD?=
 =?us-ascii?Q?laP9T14TusiTVvEiK0iGOFTn8S8As909uGKmwrnRZJRk9pu4Langxqa8JoAv?=
 =?us-ascii?Q?ctWG9kPQ7NGubyVv/hloQwwdCEK+Nc1yx7EzAhxLM7lOXuDV/vxcNV+UaNHE?=
 =?us-ascii?Q?Sn7QMr+YnFV6XXQWmL78xFmUh9MrWoibnJ1Mk2huydSg+3mYVbeYyz6ltffj?=
 =?us-ascii?Q?7Qqb3judatlhBC6l+aGDBgiiO4aYmiTR9GYm+BKpzt1d0GbTqDArgBCU7aXj?=
 =?us-ascii?Q?8OPm5KwJ/X3R9Qgl31zT3ct6Ib/OxxP3hsA34V8fz2kgm7d/2ndONFmQVz24?=
 =?us-ascii?Q?lDkddypRr4tD1zSVQR1tLG2/nrhDbylxPXnzv8VqvgsscNB5s3VzXJ3P1/yy?=
 =?us-ascii?Q?tqvUckTubnqfR3/EMWqANDoePkgjW02qmYKXxkyJj+JGAvpKyaAiXPCA8H5E?=
 =?us-ascii?Q?CBNG+saqGIDTtPO6Ld6OnMplodxK6PZQ34ba0+NLQPhsTRW7AojdKEpB/Oq7?=
 =?us-ascii?Q?Lc0/vehpMbZrLhv1G16VkEt4TVfXqcFnPk54GlebGG9QTMs3wCvndebhoTkd?=
 =?us-ascii?Q?Nh58FQ5/GJCESVRQzmcS+IvUkIqsWJs9igYYtAH+bbdZE6Ypa0z2eHvRcXdh?=
 =?us-ascii?Q?yrgc8TVNhc7r93+pi6Qevuw3l70EDJhCFc1V7mKjatYBOgwhrJtgDxnbBRFh?=
 =?us-ascii?Q?kBCGDQYmcjMXSiqEu/Zqj7hGJKIndMjtFN0NN3aLeQrAVyZY3rf2JL/tYB7F?=
 =?us-ascii?Q?HNjbgJE69x9UOqM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:39:13.4395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857b2831-33a4-4223-407b-08dd4c3c2f85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602


Jakub Kicinski <kuba@kernel.org> writes:

> Find out and record in env the name of the interface which remote host
> will use for the IP address provided via config.
>
> Interface name is useful for mausezahn and for setting up tunnels.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/lib/py/env.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 886b4904613c..fc649797230b 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -154,6 +154,9 @@ from .remote import Remote
>          self.ifname = self.dev['ifname']
>          self.ifindex = self.dev['ifindex']
>  
> +        # resolve remote interface name
> +        self.remote_ifname = self.resolve_remote_ifc()
> +
>          self._required_cmd = {}
>  
>      def create_local(self):
> @@ -200,6 +203,16 @@ from .remote import Remote
>              raise Exception("Invalid environment, missing configuration:", missing,
>                              "Please see tools/testing/selftests/drivers/net/README.rst")
>  
> +    def resolve_remote_ifc(self):
> +        v4 = v6 = None
> +        if self.remote_v4:
> +            v4 = ip("addr show to " + self.remote_v4, json=True, host=self.remote)
> +        if self.remote_v6:
> +            v6 = ip("addr show to " + self.remote_v6, json=True, host=self.remote)
> +        if v4 and v6 and v4[0]["ifname"] != v6[0]["ifname"]:
> +            raise Exception("Can't resolve remote interface name, v4 and v6 don't match")
> +        return v6[0]["ifname"] if v6 else v4[0]["ifname"]

Is existence of more than one interface with the same IP address a
concern? I guess such configuration is broken and wouldn't come up in a
selftest, but consider throwing in an "len(v4) == len(v6) == 1" for
robustness sake. I guess it could in fact replace the "v4 and v6" bit.

> +
>      def __enter__(self):
>          return self


