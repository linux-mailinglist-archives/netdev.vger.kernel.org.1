Return-Path: <netdev+bounces-226457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586BBA0A69
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77F85632D7
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816830749B;
	Thu, 25 Sep 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bgdiqPGu"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F2306499
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818312; cv=fail; b=ALHbpEMKxSkbzHYNm/SbOHAQIOu083E04Q9sfrgfoYQqgXPlprXVLJOxENT2Q1vK0xewyDLEEHJAuw6AevLgM4/mMDavBVBMEfBWGe2WyMgfWJStBZa66A0l8xCK8V3jyvVn5ypCBEUv4peRVaAN41eiCybT37CX6Socal29U6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818312; c=relaxed/simple;
	bh=fhL0zRDooFuzfxGdNHC6hUkMTnd3IfcqTdj651ngC0I=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VkZm+Crdj2ZjRne1dt7ct6+vfWE/Xjhf4m4D+I61o+orDWdpx42QRZNY/XVxeUiXcR5Oc2iGAks+u+DpOWfWWzYXi5d+T7E7JxGeXOfMO7Q2A+jpMvOsrBm8kXO/6UhemVUpoziHnhM0v5Xm6CEUxA1vHgFAZI/ZvQCFWCmqrRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bgdiqPGu; arc=fail smtp.client-ip=52.101.57.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSyA2QKd6lHb4Tdv9j4KN+qRIcA09SE4z6jvMnXG4XxtW0DaNiPkQxiWYbxkelFvT6ojBPlDZNBe1AoGVF3GXZXDy4SilLhd2yMeeRCVcGZU1U8OaNJgGEJqOtiY2dfLFkfHFdobIhvmg2ZuBdIx3WMluPwpGim8HspA57/tM/ASZ+LtTqxsJ6NtiBdx0HwA6Y+fewWjU4ObnVxOQN3v1t0Exg6B0nzw7Ll3d+I1PuoXsKCbX6fS9/0ExlhNPgtYlHGw+lwnq2Karaue5zKgjzoyzG6JPdwWZ12VHusLOMJ178R1eGlhDwWtaD7k1Ax6hZ/NDn5Gxz7OltS/wVvhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Shw2QqzoOlyBwip0U55/LCrB1q0LUEPf8D9cadnvKKU=;
 b=QJ43KgvoAu99bHaGZ160YGz1LDYYhNY9nss/m2LusVMOMGF37Na7Ts+BDToYlBT1LaeEC/wgqykUzC+ymwJ1owMc8bc0/YZVSrY2tXbN/Maie0eAB1aOIIqAjOEWPQ1TDeIr/5Il4u2TNLYoQeeXciB7cW3zTRo+/cYnAqdbKECVFp2qbpdgxjrnrORcvdMM4Vk/yg4qZHE152I2WI2qEA3kM8dhEvs9U8V2uTpZAGVwGbuCtEHC/PnkdpML14QHFnHlpL7wjw6O8kFCwqEUiIr4TC0J4msLTHBFhgiqGwo1ryPg79M5kjYflGO/4AKYznIfqAB+ucUWYz0FJorunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shw2QqzoOlyBwip0U55/LCrB1q0LUEPf8D9cadnvKKU=;
 b=bgdiqPGuBDK3YcnGvWcsrB5ydK26QySHNfGXpjuYhU9j4lrZZ/W2dpINGJ3BGV7MGws4R4oi54IOFBx9UOJsCnaGIWMpk7dNimFLkWPEqn3bTKDm+JRQabslucIwpbZ6XwpHI22XBvSnZ3ZbZEexwiboihBgEUzTGNLYra+Nlj6jRsIpjQ4L/GqdpcB4AiLkQD7K7t46o+jk/cJeg02ujWWHV/Ln3UB+/zp9ATpFMAMFTeK86xFYT18m57eVWkbldLKYPcYnO/62sEyN2t4wliTivbTZAfpcbJbfQ8etx6QOPtYj4ffK26AjIV8LeLOIUk+X8ZfkfznenGz5m9fvjg==
Received: from MN2PR20CA0061.namprd20.prod.outlook.com (2603:10b6:208:235::30)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 16:38:26 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::1b) by MN2PR20CA0061.outlook.office365.com
 (2603:10b6:208:235::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 16:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 16:38:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 09:38:11 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 09:38:04 -0700
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
 <20250924194959.2845473-3-daniel.zahka@gmail.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Breno Leitao
	<leitao@debian.org>, Petr Machata <petrm@nvidia.com>, Yuyang Huang
	<yuyanghuang@google.com>, Xiao Liang <shaw.leon@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/9] selftests: net: add skip all feature to
 ksft_run()
Date: Thu, 25 Sep 2025 18:09:33 +0200
In-Reply-To: <20250924194959.2845473-3-daniel.zahka@gmail.com>
Message-ID: <87jz1mwksz.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: af144bd3-0ec6-4b37-96a1-08ddfc51f34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cj0+H9wR9IGbpd+h6xd1tL/ys6UIUuI4qZ1D9p31KZAydzXuB84pFL8fUz7+?=
 =?us-ascii?Q?TLGUlPlskEQlZD9Tnieb1Tbbm1CZQmutL4MKFogVbDPKVk6hpYXs3bG7+Wsn?=
 =?us-ascii?Q?uLaCFnuWHE8s8EYhGK8FcvtYp+T9l+BzgCmWpZE4EYB/LZ39uEwI9E3m/HhK?=
 =?us-ascii?Q?perRX+9OAGHAnaHmVHy8zgWQ/KEkZL9JFeqDtxCOrebKUiZb1vo5y6EL/ChI?=
 =?us-ascii?Q?DIviLkvBJOt95wMbmTAzYwcfLosRn3ejUwGJRuzLPllYRDT6Du5rKHdL7YFh?=
 =?us-ascii?Q?tHqPKMfFpGEL737GFzyrZVU8BsDvVspgG/WxYKdg0tRXt+35G2jPgafbkCOW?=
 =?us-ascii?Q?hi5e2tRJ5y9UtZeZYAj97oHpQZ4FXCvgHW95tTLotyp1aOSgmLAVRdwT9rHg?=
 =?us-ascii?Q?FT3b2jIeOvJTaRaEZcVmfkTGjXMj+2h/21FyYqCiestcBpg6UXmrlrabpm2L?=
 =?us-ascii?Q?XxLShh1e1CTJjPP5VjW7iMcfIMtfSr08eK5KiiAZTAqbwPWYkU59mlpjVxyi?=
 =?us-ascii?Q?NGs99KuJyVP1AxcBYDS3MAwPl2gr2nKUl5hnAYlJo98tuPzSJX/cjCP4FWS/?=
 =?us-ascii?Q?YYylB+5EOL9FTB3194xyCo+nMIJ/HXZeuu2VPZVirGlV/BP4uxiao5eJ8zS/?=
 =?us-ascii?Q?6P4Jm3fKROt4C2kVGht3/iAejC8fbvNynllMElf0pI8gVYgrUmZlZtElkyYF?=
 =?us-ascii?Q?9b9EgApF+NIelwlDBdD2qIoQ32+w6EG9LksrPctbtnAlWQxymzxto6GnVBo/?=
 =?us-ascii?Q?hKf3OYFsTSPU9ysx8+BWGVOq+RgBgFJv/TI53F6zKgfYIUBbQtEmgt41bWe8?=
 =?us-ascii?Q?XxD5n32ZVAkoXszxnr3lG21S1ZyfaxuKVZ1viyZamEpnv0q/FrDOGncE/Cxv?=
 =?us-ascii?Q?VfRkYud5acXx2qeV2zMESkWF6ZR7YEbTkjLTwfft/o+KzTqH3XjjGjq+12z3?=
 =?us-ascii?Q?3z6MUOahcpDOBsVpgeJrxhUZL81bWW8XdUIhYANm76tHO28W4mFRHsA9t/CQ?=
 =?us-ascii?Q?7DnInpYwCFfqrQoWhsc8RkDHVN+dSGlIVx4yddhPWspRaiSpNwFlBscXeT6I?=
 =?us-ascii?Q?MxNUejVrzEkVB96BwOdiKCnvGcfoj3x8SvlziBZ6/uDqNAkVu2jEPNL3x+WI?=
 =?us-ascii?Q?PPbT2IFARsuaF6mlku6Bj+olvAIShbZirmrJEsguDhRi5nobTqWgTrZrVNkz?=
 =?us-ascii?Q?e2D5ADnTnka/z/l8Ghu1+kX/0stk5BqfwEAtwjSrOcbyPwyVJ6MXpYEo73ay?=
 =?us-ascii?Q?+oNOfmBvxHD4Bz+BvbNaM101U0H4RoSlJ4poW3F4HXgjqjmF7lgxWjD/OdTw?=
 =?us-ascii?Q?T9zP7X/xHHt6jx628zL169CId0Rjux3PjZrAyJoQg9mS4JMVsvKWaqtQdXP3?=
 =?us-ascii?Q?RxIfBng+5IF78S62hdjwiI4KH8nT512sxbwGxcmKuhfvEJHhIBKHKNOsgDQa?=
 =?us-ascii?Q?9u8iIiJOQNJInE72t8HLzSG/hK6nx9pmuU0vQZCDNNRi51OxVZXRurTOsS9v?=
 =?us-ascii?Q?QbhiI7ziQaESrmiDRO/r8SyI+OHYBdG0EFlX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:38:25.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af144bd3-0ec6-4b37-96a1-08ddfc51f34c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377


Daniel Zahka <daniel.zahka@gmail.com> writes:

> When there is an entire test suite where each test case depends upon
> some feature, e.g., psp, it is easier to state the least common
> denominator of dpendencies up front, rather than doing:
>
> cfg.require_psp()
>
> at the start of each test.
>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  tools/testing/selftests/net/lib/py/ksft.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 8e35ed12ed9e..375020d3edf2 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -210,7 +210,7 @@ def _ksft_intr(signum, frame):
>          ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
>  
>  
> -def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
> +def ksft_run(cases=None, globs=None, case_pfx=None, args=(), skip_all=None):
>      cases = cases or []
>  
>      if globs and case_pfx:
> @@ -241,6 +241,8 @@ def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
>          cnt_key = ""
>  
>          try:
> +            if skip_all:
> +                raise KsftSkipEx()
>              case(*args)
>          except KsftSkipEx as e:
>              comment = "SKIP " + str(e)

Personally I'm not very fond of this. Calling a run helper just to have
it skip all tests... eh, wouldn't it make more sense to just not call
the function at all then? If all tests have PSP as prereq, just have the
test say so and bail out early?

Topic-specific tests are pretty common, so it's not nonsense to have a
facility that supports that. But this API just seems wrong to me. Run
these tests, except don't run them, just show they are all skipped.

