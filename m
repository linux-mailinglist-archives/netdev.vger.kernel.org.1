Return-Path: <netdev+bounces-221201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B43FB4FB5E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710391C6014F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4522322DB4;
	Tue,  9 Sep 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WKPM0COK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1F3191B4
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421417; cv=fail; b=uAvkmAcbJxz8k/PDCC21pWsddBhd3rGfrqM2KJj/+yMEPjd2UAmMRE8m5riWUeF2oShoGXmJVlkBTQfnlwl+S0J4MZ4Lw0m4lqzYeMXsrq86+BdYk3SnsxDv0O7NMqOzrp42qslHqEiXpNRSDdk9fjXPaCsXr58JdFnCYgXlj5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421417; c=relaxed/simple;
	bh=sicbH1Qb+wBzrd9NnkiuF9Rx+tydaVjIzAI727XV89g=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GDel3gUK/Rj2w1rvZrGDI4WktbKW11ZU7A0BipjG1XOD3nMT+8Jobxoe5wvc/HJ0nV6D257j3k/1SKHKwPN8v8wssjT+GF0nbG+bNB55TrpZNgsKyG5+/zx9t9D+A89jzAx/QWxU8GUMPaDHyy+XNzjWDWHUpZ1R3x/Dz13AQCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WKPM0COK; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycGJyfx5kmncQn3t+xorRkTGwdnjPNRmaGaH9U28Hb6SXtFbPLT1jyZ0Gy4WkiDyceQHxVSAjjmCTdSpra+zSoliS9uHtZM++oM4ubuOFIWqJI8qR4aMJWgkc79LP/2nwhD5sMRj4EkQs8TdFfKnopl47QhxnVbq4sAffS3+PlcztVzmdzTsqJYBEfenkKtPFNsFoBgEkktGlP8pWGKqlc5F0QMk4Xe/vTaKhIVug8OBlLVZxE9DO8w2exQXRbvRSpoRgGqMWZdyr0uqLSjAug8dHyUgKZpv4up1phBFMxRE97VYHxOxv/1VDE6EGf5ghYTyX53IWOx7dvVEYSIBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sicbH1Qb+wBzrd9NnkiuF9Rx+tydaVjIzAI727XV89g=;
 b=je48mweXbU+cBw7JpcMmLmc0USyZOuNtVIi/MZB6eU0vouDQyHHgRaXUZoPQNa7dsuFWRw0BASupG4sZ33mqe+RHrKIbnsyYk9hUvJOo6Mze0hN8edH73tswGZjh9+Af0fV2YfmjHF8GA8eHvuSlrV0+phFQnSkEyA+1QAajL9Q6Jdl/UoaIt3CmlH2u4ZvHTDaCVIzUuzS65tFZx+7I67sdkY7/LjfB7r24XaHCFMDcztJvYOVXTnFoLZ2n21IZ9zH/l7hlojMltYJ2qehJQ30HcD+WnhN4hdEmh3JzhEFhdhxC2LbcUfNYRkgU5CGJZ4GdZKQqyKf9yqE16MB/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sicbH1Qb+wBzrd9NnkiuF9Rx+tydaVjIzAI727XV89g=;
 b=WKPM0COK04uRtcZCRIDGhdXiA5Lj4ypOV+T1p7+z9MiyCtjxq68AWcQbVH01+yNhj5jx1yL26RChcuDZID/IC/rjQoj3zIujPxw78ekGnPPboPJNPWtOOcdVmQbbQNuhwGBZ6XEscSUc7vPBSBkz2fnp56gkKY0oYzjGys8cqPA8cEhvAv3z+lSFis1Vhpu4M9jZjBqLpOEJR/j4bU1SF0HE5pk2F2IgWwrAj7nfNLv1ghSl+bDAoybB4g0JeUlCHSxd/Nr/ypPICTfhy1wZsNG+oJzQvUtrswx6SsmZ/BGoNnD/gfyOHK4rTr/V/gysjdW9USWr1AEdsMdNofWGPw==
Received: from BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::6)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 12:36:52 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::d1) by BY1P220CA0002.outlook.office365.com
 (2603:10b6:a03:59d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 12:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 12:36:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 05:36:30 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 05:36:21 -0700
References: <cover.1757004393.git.petrm@nvidia.com>
 <20250908192753.7bdb8d21@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, <mlxsw@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Jiri Pirko
	<jiri@resnulli.us>
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
Date: Tue, 9 Sep 2025 14:12:51 +0200
In-Reply-To: <20250908192753.7bdb8d21@kernel.org>
Message-ID: <87ikhrregs.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: ae255df3-4955-42e2-4f41-08ddef9d8d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJLjKmg9fBHwh5YSpN0hgKR9WFlcKfrvoR58VBgiTfOvguXcmVsD7aAYt2JY?=
 =?us-ascii?Q?US3Nxfh7Z8Pn2BnEsFTSdbK+EXo3Yvg0Yy0ylsPpCO0mf4qzWdtorlhr1Zwx?=
 =?us-ascii?Q?4EHekiZTL9no+JtZ8O56hpF/kM/+SPV+o8jgtqjqGk/XgeceTHYVrpOSsVe+?=
 =?us-ascii?Q?fhCqM388OprQqsPtQDZ4jqyPp/Wq01w6ZzGFrGHfQWyh/UKydBRRxB8ea5yV?=
 =?us-ascii?Q?S3yB1TTWDYamfTdz8g58cvSAuvE4toYaDswqWOfOrlwZBVupMH87fKfE40Qa?=
 =?us-ascii?Q?iw4EanVrkwZZlXD5w6z55OWW/lJ23YfZ6ntyxFN7cmIg/bu60CNPEIAGq43G?=
 =?us-ascii?Q?hw0A03u30l8CMj5t+Vc1iYXmAubUEwrL4yzXL+l2iVDJFnc1U1xf9c+pJqJ4?=
 =?us-ascii?Q?LMWTo5yfJN8VsPRGiN2X1fK0zLm3gVSCwFLBVFHem6/moTfum5xoO9tHJ9hZ?=
 =?us-ascii?Q?GU1ysD/DA4sT4uY8uw6NVGeSm2F6SfmawuiRvhbXgSbeyMstGcuTX5deNQ8H?=
 =?us-ascii?Q?HZTKoadGWWRTESj7HQtLwthAasPToWOYvmQo+BU8nEeYdcTg3qB7Zri0Y2ai?=
 =?us-ascii?Q?RBmK1UIM+bmiJ6JHbBSbI/ocl+qyqr7y3tkGKb3Soy53eEdzpiFmErJIjUJ8?=
 =?us-ascii?Q?V0vjNVEQ7e5FcSNQHWKJWO9sIvViGoXMP3Ogb/CsI0eoXL3sjozYlwzSNkno?=
 =?us-ascii?Q?Z76qH43H+rK9843ZGKbIrNdFeRP+c5X7iLUU8zdLZLH9gq1qDGJRs3fIT8Ty?=
 =?us-ascii?Q?CJ3XlX3AREhI1a2iE/oO+ft8UEqvGR03cBv6v9N4cpBwABzwcWMsXQ31P2+o?=
 =?us-ascii?Q?TXFoc4Idfg+SiCA1jld6bCMBgzrMztTViYGwRpsWbylBsOs7fvQH/BLUByni?=
 =?us-ascii?Q?3LkzvmG80ahwl4iUCvhunC8lz1tX1S4zNz3Lr4a+tMoyPUoAadcEuqlySlez?=
 =?us-ascii?Q?1ERLbTnCuqDd40amAG4oYuqyMjC93qtz6ZvNgdmnJO0OXT2BsMhcLbxL3scU?=
 =?us-ascii?Q?smEHZLuh62TJD6sVk14nCCyU5Nzk4jgxRV58S6VagDJp404k6F8FzjtaCxM+?=
 =?us-ascii?Q?l9k4Q4P93YJ7b+RRg7fBbfu4j2THQ8OUarZyF3/TbMsvRUoTTgX4vBWVQVeY?=
 =?us-ascii?Q?JIV90j0ClbMXd23t5t71q9DO1rt0NaB3RjFRDCJbhczfbWDrhwEKsam8pxAQ?=
 =?us-ascii?Q?KEbZCZ+ABYJiUd1pxTMkzX199yMQkkyZW7UkcRlgN4SppP96yOIC6Xu0iWkM?=
 =?us-ascii?Q?j30EMxhA0v66h8Q9UOYGqiRpZxA4kZk6mnXr8p4/fMXmp28SBv1eeVGfQd26?=
 =?us-ascii?Q?rRjRLacVvG4k8b5gFt45+rmtecv616TNVQpMfrCmQxrfzLMG2w7A04ccv4pE?=
 =?us-ascii?Q?uc2ntk4hDabd+dFjzR7tRbxNstIRZH9WGfrXVSnttWszBvaKw8/L2xVJwd2U?=
 =?us-ascii?Q?KfpGSgHpIOYkW6PwGAG4qgQYR3K6xVuSHY8xw219qnYiG4yssN1rdkASuJZh?=
 =?us-ascii?Q?bzNyFLIDbFBrtiJYQmSVvoQzi0vXGE8Vob03?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 12:36:51.9393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae255df3-4955-42e2-4f41-08ddef9d8d99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 4 Sep 2025 19:07:17 +0200 Petr Machata wrote:
>> Yet another option might be to use in-kernel FDB filtering, and to filter
>> the local entries when dumping. Unfortunately, this does not help all that
>> much either, because the linked-list walk still needs to happen. Also, with
>> the obvious filtering interface built around ndm_flags / ndm_state
>> filtering, one can't just exclude pure local entries in one query. One
>> needs to dump all non-local entries first, and then to get permanent
>> entries in another run filter local & added_by_user. I.e. one needs to pay
>> the iteration overhead twice, and then integrate the result in userspace.
>> To get significant savings, one would need a very specific knob like "dump,
>> but skip/only include local entries". But if we are adding a local-specific
>> knobs, maybe let's have an option to just not duplicate them in the first
>> place.
>
> Local-specific knob for dump seems like the most direct way to address
> your concern, if I'm reading the cover letter right. Also, is it normal
> to special case vlan 0 the way this series does? Wouldn't it be cleaner
> to store local entries in a separate hash table? Perhaps if they lived
> in a separate hash table it'd be odd to dump them for VLAN 0 (so the
> series also conflates the kernel internals and control path/dump output)

I'm not sure why it would be helpful to keep them separate. You would
still need to dump them presumably? Or maybe there's a way to request
skipping specifically local entries, but then you don't need to keep
them separate? I find it better to not create them in the first place,
because then you have faster iteration in all for-each-fdb contexts,
faster marshalling, less memory taken.

> Given that Nik has authored the previous version a third opinion would
> be great... adding a handful of people to CC.


