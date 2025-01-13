Return-Path: <netdev+bounces-157706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A88A0B49C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F549164ED2
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220011FDA9F;
	Mon, 13 Jan 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6XQkMz/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85921ADB3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764167; cv=fail; b=o/U5nDqRhyUZ2QxjCrIP0AsdTCZMwahZD6sGU0DYy9UBLwscr8I0DqWdka0472sHzHsO2T7T6Nt0dX1bQ387ytU2IZQR0D5LWxMm2vbvKrVjNei7PuvXxraWUbwMvP9MIH7R6LARXcWCDj4sp8r4k9cq+rEICQ5Py8xTYezuZPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764167; c=relaxed/simple;
	bh=zYmUmTxmrDVASYqG0+709IEFN62sA78H4LJqt+Zz78U=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qpOyI/IuObI7p/SWJxAP05rSthr6g0tjZsOXOoxjk2KseVqI7w88wsGhSrcyo3+W0rXExGZCE6WarAcZ3MN3VtkiACHee2XkQuuobC9sbLnZny+edC1/YnJK7jxJmy0Tnty7sbRGjrnzmdkSxZc7CC/iqmZa7h4sfJ8fOeSbxZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6XQkMz/; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev3lyutFMbnH5H0e+Ck+pTgrpR7RJGI4QUpW5K2ldPPxquoXqowltlo4ox5R5uYhotOxtyOuzHkNPuQYHSE+h9hkSWd0Q+QZub4aahyizqy/EJoCSsI/sqpWJ7tXF3qQfnx7tNxO8cmxg7Fc8lKX0wV+0jpmgEaQcbxKkVkyXklSK0CYKahtth5ALXpUO9sL5JjwzHC1LxCE6y/L6JHAd+Ip+JTwFTxAvvsr39/NckByhoPzT7zVq1QLoky2QfPswD/OHzCLjJFmBMA3a3CaVYHHPc9fQNaVtiKFvNiGNlgo85wXzgFmmjYgemEEeGFeYo3u4nU6w6ksksWNMQZhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7J56VD7qmeBBGVBEIQ42IzceGu9HyRsu9NncdX7e0Q=;
 b=U1L238WF8QJNk8TzXi74IcaSXVRZxwTinVdOwztVvrDkH5yd9u7coc0kQC5sP5tVeen2Od6XzjrxKtHzam4OfCaaUd/pELBU9qJ/UnO5ofuaNhtQ+W0TeWbpc1ex9DpAEMHnhLVZw17mJsxZhMKOUepiePf7+bey56uBjSaHnJaOi4WWUj/pJVD8c3CUhfNVsBy1Z7iBmaOU/KVbU+4tGdAjNLRfdtM8lIHetC+g2tzKuD600Sy2mezD0dg4ERuZ9MLsAnhJRY+wfCDVGdtK3mFu/Tt5Pn8oZCwwnPwvCgHP9uR/77x1E1VJ8lG+14pd1kSlvLUQVxwfz7vXCa1Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7J56VD7qmeBBGVBEIQ42IzceGu9HyRsu9NncdX7e0Q=;
 b=X6XQkMz/1z1YwfQ47r6pG5MRA1UHYVAbjA32FerfNPPfJNUg4tYDHFCNzBBlcNMgDX5w2PmQEwCD+y4VoUgJDhke1pX5dT2ab2mRFAypIyHuAEU2KYvwyxUyoc7ur2wdmxdAFBPxqMwxdV+BcWxXdEQk/FHAUVxP1gx/adtdomatX8D7H2VIJpPGczkD1XTIYjc+6Wibw5cbMmco7b+G7unBcQ3pcEHrz2cTtdyQfqB5JVmxVWaMfSEsxXVE5dPBqWGTroc3I8xRCn/JneR3KG12yCblmBIsOlNQ3PaD7yT+hEPHF1E5Y47wSLG5CyNXWZsTj8BjaJBWpVGrnlbWew==
Received: from MN2PR15CA0034.namprd15.prod.outlook.com (2603:10b6:208:1b4::47)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 10:29:22 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::a2) by MN2PR15CA0034.outlook.office365.com
 (2603:10b6:208:1b4::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 10:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 10:29:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 02:29:04 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 02:29:00 -0800
References: <20250111145740.74755-1-jhs@mojatatu.com>
 <Z4RWFNIvS31kVhvA@pop-os.localdomain>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
CC: Jamal Hadi Salim <jhs@mojatatu.com>, <netdev@vger.kernel.org>,
	<jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <petrm@mellanox.com>, <security@kernel.org>,
	<g1042620637@gmail.com>
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
Date: Mon, 13 Jan 2025 11:21:29 +0100
In-Reply-To: <Z4RWFNIvS31kVhvA@pop-os.localdomain>
Message-ID: <87zfjvqa6w.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b719c5-67eb-46fe-10c7-08dd33bd24cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wPLd45epkEwNr4nqoK2jU5DBGxgygOy5uCcuAa44NlrcpDQ5SZYvoWwwSmOT?=
 =?us-ascii?Q?IFgjTjgRikUFCDvuqIatgRvy5Bwrx8oRbrtyNxceaFTVZyKXoh5NdqDpOIKc?=
 =?us-ascii?Q?60fCf8F9C7A8xg+HgE6GB2ZNI1Kh+znqvcvicq/OqybyZeiA2pFiS43gFxgb?=
 =?us-ascii?Q?yCjUApz5iWMtDa2FeBi7dnaLlr0g5bMu5mezOJsY5P5DqCCvXeSH40UFUGxB?=
 =?us-ascii?Q?ZdWz9gBQwCXgnrD6OngGsumfcJmZnYpWkS80446aBqX8cvgHn3QLc1Z/xeh/?=
 =?us-ascii?Q?0K7bNxb+RCK7+mEUOWH1tWTSt9ZLWFcmXctJZWSBp/SKxzoQQJ6mlcYza3p1?=
 =?us-ascii?Q?u3kWu6dJJbyfUinNLe5/B4hpabQMEN0QAEYqTc7W7lJWrQraMMzS2h28DXTk?=
 =?us-ascii?Q?Wsi3ASPVqKpUDq1d9u1aoZCAyCaVGBZzWWmWgqvUQfm4XTRrltWwkeaCmGI4?=
 =?us-ascii?Q?vNByv8K9h9gJBvHUFKm/UwrJbv+PEY1SAE5j7VCBBfi7s1/CBkcrdSWuMvpm?=
 =?us-ascii?Q?aS/iKcmQ19v64Y6h70IVkJ7kQay4BDTrFm/9CM4loVy7x6EXmQSNix1Lgcqe?=
 =?us-ascii?Q?hZYbuDzFXCXAWBlDc+CLAa/EL6SOWatlwgA4hj0UK1c7W+HY1cSw3ei5Zq1f?=
 =?us-ascii?Q?5UaVvzX+5TXSQFEla0D8qmDUoVkXnP7AJxb2Z0VVwQyssC8Kfz+iTk/XqZdf?=
 =?us-ascii?Q?lAIcTcSTS7kiYYG/fbOBYSbh3FiapxzAgOGy8dc1WurUJdl2Qv1zkqB0Ytcc?=
 =?us-ascii?Q?EACSPb376RbvUsozemOJTYhS3Vknmk14t6dD2xVK+9yHj9renE9P2/RSBE5M?=
 =?us-ascii?Q?h9VVV9N1WKzN429nFHCP7ngUEDJpTIuNr54ePo6vI/Vo5U+hWvVVgMn5vr/P?=
 =?us-ascii?Q?7QZ3UC5GAoDm5n5t+dxGrI3a8CZRswOwb2hiyM+d/ZwJXawuTQrUWCYUwaA2?=
 =?us-ascii?Q?o/rt2Sn+bCFBZ+fpgEn1qkCVBE4LewEiuNjGhylLIH4r52iyxM/PHMjj6GrQ?=
 =?us-ascii?Q?AvMQ7d9EG9UcNe7JpOoxLip07poUtFMF4e19A2N47UtKB3e5xajd6K8BMivm?=
 =?us-ascii?Q?ShIZXSAnw0f7AFeMREMWqu4j2WlJF/av8w0ZPTyovXwurB4ZhTxJVniUfFQN?=
 =?us-ascii?Q?V40FrowmUKPURrKWW6ItZqd72ZiwS9wFRngfcHkj7misOzlsFsPN4q+5AX5t?=
 =?us-ascii?Q?XpGu6+BzhRphqMOOfx/BylDAuyPkIYM777Ir0nVq/qOvgK78/id6Yq1URj6A?=
 =?us-ascii?Q?GAhwbqPxv8xaQB6g+Z4SJYa7XtF2kX1nxfcieauperwDijmicLTMcgtO2Xu3?=
 =?us-ascii?Q?Mt57f7xkodDmpaG0Lmh72KXgEvhKtDBfd9x3oC9KHZ1LYOkYn2rs0MVSSe0r?=
 =?us-ascii?Q?g9Skhhx1JTfsrpy8b6xp3+scu4u99AuYCtrebwmrILTTJUKNsXpXzpSS/2yO?=
 =?us-ascii?Q?f7G6UwCL5EFvN609eJpN3Z0Ek6asNKXWSNkIich3zESFljjpeqWGsRGB34IP?=
 =?us-ascii?Q?E4S9Qw71wnbTCGE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 10:29:21.3545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b719c5-67eb-46fe-10c7-08dd33bd24cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115


Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Sat, Jan 11, 2025 at 09:57:39AM -0500, Jamal Hadi Salim wrote:
>> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
>> index f80bc05d4c5a..516038a44163 100644
>> --- a/net/sched/sch_ets.c
>> +++ b/net/sched/sch_ets.c
>> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
>>  {
>>  	struct ets_sched *q = qdisc_priv(sch);
>>  
>> +	if (arg == 0 || arg > q->nbands)
>> +		return NULL;
>>  	return &q->classes[arg - 1];
>>  }
>
> I must miss something here. Some callers of this function don't handle
> NULL at all, so are you sure it is safe to return NULL for all the
> callers here??
>
> For one quick example:
>
> 322 static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg,
> 323                                 struct gnet_dump *d)
> 324 {
> 325         struct ets_class *cl = ets_class_from_arg(sch, arg);
> 326         struct Qdisc *cl_q = cl->qdisc;
>
> 'cl' is not checked against NULL before dereferencing it.
>
> There are other cases too, please ensure _all_ of them handle NULL
> correctly.

Yeah, I looked through ets_class_from_arg() callers last week and I
think that besides the one call that needs patching, which already
handles NULL, in all other cases the arg passed to ets_class_from_arg()
comes from class_find, and therefore shouldn't cause the NULL return.

