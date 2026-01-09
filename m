Return-Path: <netdev+bounces-248393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14664D07E1D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 09:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CF153074468
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B2350A39;
	Fri,  9 Jan 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lOTHLrxb"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68707350A1F
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947930; cv=fail; b=LmQxQqqZIPWxafmU1ntfhBahG5ZIaOqQHeDLIpbGf40hwuFG0oJ7KwhpWQk/DYhAJV6IGKSgGelVn5AaJfztIwYUR6SkeFnqOixOEk4qDE9agsAVeEtwFpayhP/YYwcbP3KExNe7rW0DZk3uSR2JMhE9L1pa8LSvZejeJWzD3Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947930; c=relaxed/simple;
	bh=kx4pjv42QOc8t00j2XacEF+KVdC/MzJN+vx56zSfH8E=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=P+fAvanQ1CKK8+9M1ciFe/sehY69mS4/N9lHed7Nn3hJm5v/+NSPJuizEE8KN8K+ymrErsmIJXp99T81JDakuKwWeqdUkHP1Zpjp81Srxc0a99hJKiIH1lcCZEL1JuturTn2feHa1pWh9raxRazI9rWIAIUAQAVb/IMaUH6nDPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lOTHLrxb; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv5bTt9oSPNjTiOo5X/STN2ZbUNPXIQdgr014W70Mb9zSiqfi84Lmc6WC+qjq/QD1UG+y+/QzOopug7OiU5xBasuALE+od0G9g1oW9IMMElDjwUqmQL7hGkVZ9nPjYMdDkTUAqboSvGhanr/FVt5OrcP97px3UYNYJwwxgpcIzknPVDKcGGgqXY7mjYDvf6JSY1Sc6XGTSA9Tt3OEhZfhIeIviGLbsyHxnu5iLRk5l98I3hsnVlNSHadVDbltN2qr6yqpJpMzFLuVgywTk9uFCmlnrIrCBZ9Lt/xw+Os/xQKIVXdjxea202a5KVIGHITyUHm0FLhClO7LcCnLNoBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJJqlpDlY5ar2CdFy9lRNfL1SzXvHSWWY/LOwUeMLzg=;
 b=tIu9irQ51XOkFkx4yhCBGT0h48RJXzYio5TucYLhTwIuL4OQk/8Oxs8WSWfGN6wUiBfJcMScoit1ho44Ews3mSHxE83cHxdl1oSaAlbmAbA2sPZ5wApoVu+xScTDy2FgyvcD4SVXBgiL+8WZvgnb7OtAhmjGkwW6wZFmSR1MgWFZNSfLBT8UWLobFOoqLY2h38F0G0hpZOoQI6uHYD5/o7XChIZNglu3xoEGEAznZaXk8Nz4l+XTQX8WCEkO8DaTTpq09l0YQVYw3qThZlFJ9PnH/h50jJBtW++lDwSQTz0Pb56xwae58Qzm1tO7UttvyOJsvLSQuXfTMJEdExdwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=fastly.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJJqlpDlY5ar2CdFy9lRNfL1SzXvHSWWY/LOwUeMLzg=;
 b=lOTHLrxb3L4h5xpuobcqeT7uagX+Mx/37qD+ZbCgQf/WfMBODfD6Qr+PWLUCp08A2v+LW0eTzDQzvxREno+lbujvs/ImseRNo5cgi37M13b+RmxtcV3SfEPDN6Ui38c5AS+9BXu5frtsCEPvBYg2csKD9TOOo1AuFrYvu24jl3yPVZTOj64OnAsuELp7V5icJoWIjLFL8zdfEfX5+H8IUhPyxXPemQgFqjFxvvYJSWJ7Z0YrxYqgVeSzJLtRGBFvpNRMrcJTbGdvtXfIUAEuCxMF9NC7seVailtXagES/GwG6/kz2sPPPEObYuSZjJvzFm+/Kl7g0yY+P301miu4Mw==
Received: from BY5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:1d0::38)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 08:38:38 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::7f) by BY5PR04CA0028.outlook.office365.com
 (2603:10b6:a03:1d0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 08:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 08:38:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 00:38:22 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 00:38:17 -0800
References: <20260108225257.2684238-1-kuba@kernel.org>
 <20260108225257.2684238-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <leitao@debian.org>, <jdamato@fastly.com>
Subject: Re: [PATCH net-next 2/2] selftests: net: py: ensure defer() is only
 used within a test case
Date: Fri, 9 Jan 2026 09:23:54 +0100
In-Reply-To: <20260108225257.2684238-2-kuba@kernel.org>
Message-ID: <87fr8f5ggb.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b87a3bb-0b7e-46c7-256c-08de4f5a7c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RIaUDdCwx9ih3RnxChI/YiWxl/PCTarjLCWIACqU0/6WyVQoqLKtfrpoKuzS?=
 =?us-ascii?Q?RYGaV18434uu9K6RO80jgoVbPW23KtD/TxrzTOEHbAWKchupf6xM8zhbq2iV?=
 =?us-ascii?Q?05bgkROc9SEeP4Vnw3tVT3yEQrss3PXIhvbbdhIVGbYksO/x/cmymDwXNEnd?=
 =?us-ascii?Q?JvIIywMYlhhpqgtXS7GXV80MMgod/tbx2DFY/xlwNr6Y22gg53SF2txo7u5O?=
 =?us-ascii?Q?5nHobJTjoMnWg+Rc3+bFjYtEF7zzsgQ407Lz2iuduYIpdmTxIsVJ1OMFaheA?=
 =?us-ascii?Q?Oo+yelvh7Nit30JS1OXVM1BfdpPD7QcuxISFLzDz/BgpsanR/MDm22c2Utyb?=
 =?us-ascii?Q?CP0b7JTrgrB3FFPqTnzxhfkgSUG50xDLyiYVWcwL5I7HgSg+Q2CZdbEHj4C7?=
 =?us-ascii?Q?lSxYUMBDCD8wUNBo0qxpm3l62vy5H87JmmNyzTIT7C5LP9ZDX2ArIii6xPDn?=
 =?us-ascii?Q?dFYpFXj3/S1w6Rx+cS1NdX8CwTrwztUVYSoDV8WxzMVQpqLoIDt+tEpQd/Co?=
 =?us-ascii?Q?jGZCwZ2iSN6wBfZia1BIz0bc0UMFy5lZPGDCBV9o0XOlHhRNaYBu/DV8UMWA?=
 =?us-ascii?Q?dDuwRlJ8lcpAULJF89r/Bx2+S5WIt/lDvmt8A3TIaIG5faoQlxnbMICFIJh5?=
 =?us-ascii?Q?m80NQCcMEMJ3EsMYMionOnyVnhZyuQLjNDi7MkoIjCvbnlIlKp213EEVnGVq?=
 =?us-ascii?Q?lf2f6GCaLLC04iqNxG7Pklt2QHr27nANvjBgMuPTRkxK3ZEZefIG4Rc3mCFj?=
 =?us-ascii?Q?xRCT2qgnd5+jy3lS3cuvs/bbso8IDi8QCKqni5T3xj1W6kJuRrloMH5Bp5nF?=
 =?us-ascii?Q?Oj/h72jhsFxkAkagw2MlZR2h8189i9l5EpgAsYy/EGFa06DM6OHDJzhfgeIP?=
 =?us-ascii?Q?dWVIBlu8fdjj5NdxofhOrlT6PFi2f4u/wJjP8luBHtoV3bbXp5TUJiBBP7XN?=
 =?us-ascii?Q?L7m7hwVv99u9A6+Xx8Y7UHFSrOcfe5539nMciJI3MKuiOLQ6oz8N709DBOM6?=
 =?us-ascii?Q?ARCRhGRjuVWPMVd0UjTN1bkk+8skm9nLGO/hyMxEXaNsncAAA0HgP/4fToRP?=
 =?us-ascii?Q?xdi+ZaS3ICrBTUwE4kyBX6DZKiRmM6BJ8KVPmeeDyp0XiGh6ARTIKQ5icNjV?=
 =?us-ascii?Q?ojFaMfCpG/N0wYVjoMN48hFnE59Fw1vHdgny0qhJHn1VnJ3/KmZ5chMETXR3?=
 =?us-ascii?Q?uC8WVVp5w6Qm9S8xqAtmpB7ROqcctzgrXm8EMIX3qYDcyQbnH9QJbArjCVae?=
 =?us-ascii?Q?cBuSQVyytDsD8tCm4MyevW0hN3VD9R6XH61se7sYKwxdGWg8DrQ+WOPDhWAb?=
 =?us-ascii?Q?a9Arg8s0iPDwxJB/o+a23mK8LnvtLtUj/q4V+hqnK4+M9j3cIU20EpxgH8OJ?=
 =?us-ascii?Q?UO5mC94ZPZtqN4HhOCtXACA7eBRCMEex940jd/yjg5beNg28+QLjbJYBZyiT?=
 =?us-ascii?Q?Um34S7iaopno22+Qie3x/S38e01a7+AAL9N9uqfgJzWZmN57IzbgljpSZL8j?=
 =?us-ascii?Q?yeb7EsotCvy9b3kTB9IApL5gAAft7vneqo0KwMsoJ3UWvT19JtmOl/IBpim3?=
 =?us-ascii?Q?naMMfbEZ+ttAmxoFxMM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 08:38:37.9954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b87a3bb-0b7e-46c7-256c-08de4f5a7c1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560


Jakub Kicinski <kuba@kernel.org> writes:

> I wasted a couple of hours recently after accidentally adding
> a defer() from within a function which itself was called as
> part of defer(). This leads to an infinite loop of defer().
> Make sure this cannot happen and raise a helpful exception.
>
> I understand that the pair of _ksft_defer_arm() calls may
> not be the most Pythonic way to implement this, but it's
> easy enough to understand.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I think we achieve the same without the extra globals though? Just drain
the queue and walk through a copy of it?

    defer_queue = utils.GLOBAL_DEFER_QUEUE
    utils.GLOBAL_DEFER_QUEUE = []
    for i, entry in enumerate(defer_queue):
        ...
    if utils.GLOBAL_DEFER_QUEUE:
        warning / exception

> ---
>  tools/testing/selftests/net/lib/py/ksft.py  | 7 +++++++
>  tools/testing/selftests/net/lib/py/utils.py | 3 +++
>  2 files changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 248cd1a723a3..0a96f88bb60a 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -153,6 +153,11 @@ KSFT_DISRUPTIVE = True
>      print(res, flush=True)
>  
>  
> +def _ksft_defer_arm(state):
> +    """ Allow or disallow the use of defer() """
> +    utils.GLOBAL_DEFER_ARMED = state
> +
> +
>  def ksft_flush_defer():
>      global KSFT_RESULT
>  
> @@ -315,6 +320,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
>          comment = ""
>          cnt_key = ""
>  
> +        _ksft_defer_arm(True)
>          try:
>              func(*args)
>          except KsftSkipEx as e:
> @@ -332,6 +338,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
>                  ksft_pr(f"Stopping tests due to {type(e).__name__}.")
>              KSFT_RESULT = False
>              cnt_key = 'fail'
> +        _ksft_defer_arm(False)
>  
>          try:
>              ksft_flush_defer()
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 2dde34560d65..824f039d384c 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -142,6 +142,7 @@ import time
>  
>  
>  GLOBAL_DEFER_QUEUE = []
> +GLOBAL_DEFER_ARMED = False
>  
>  
>  class defer:
> @@ -153,6 +154,8 @@ GLOBAL_DEFER_QUEUE = []
>          self.args = args
>          self.kwargs = kwargs
>  
> +        if not GLOBAL_DEFER_ARMED:
> +            raise Exception("defer queue not armed, did you use defer() outside of a test case?")
>          self._queue = GLOBAL_DEFER_QUEUE
>          self._queue.append(self)


