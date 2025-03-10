Return-Path: <netdev+bounces-173457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E3CA59040
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31DD16BD35
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80107225793;
	Mon, 10 Mar 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OtsUJOjQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001F225777
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600231; cv=fail; b=OUpvMlu1k7XIThZL5FrR/nX2NKomUGiyh0cMmbtgLa2WJYNiZfVp7In5Nrcd60LuzC/KhbM+cWIupg3uGvp2gYBrgmcLMDm3zws/vdtcHTVBwowNm5n7N6yhd1pJE2inANgi2LB25dPlRdTDpTT2ICBUETQjX3Sc5AEd6wfV6uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600231; c=relaxed/simple;
	bh=OVwDITVdXnLZg8gQ8kcgnWbpk4nZAB645/dOMLkc+6k=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ajay+oqXOYUIrb+uVQKVsu8wwArVFq1oabmBmBPKAgm5LEVYrEsqKXIxu7s/VrTUbl2FHZ9ChRimuovRdacEwWCv9N3CjhPsB99h9+UF8Sm1xNRa+locKLPxDh1f39Le6Zw/14xF2jODlwk813uKx3gTKsroVomr2YraXjjmH4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OtsUJOjQ; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxkDzOO0gq7pVKiq97KL6waiVyDX8ZUYLv1NsbGypq2f08U16AkEn+f7NKXn/t9ICA8cadYeHb1HmS+bQCVmW++aEQTBBuQlrU/xqn078XrfDV5iUUIQugMXeIIjflgLRRLbJAYbSgFGMsJKbJALlBaCHzJ0XkCnRZWXJBtGLXgOiqO3JV07L8OeEUXQdvnNCWEycBOA9CXFl1NuP8glx0odMnMZ/vpYYnitFz9fjbKHvoIMet/YLOKb4BcHDRiOlUYSt6cLtzwjWtw0+Y8Xv0ssJwmDr9ojLIWTVSat+OaG78p4j5lZFCnEZo7nG9Mis3NDgY+V2QNecllxyjBtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVwDITVdXnLZg8gQ8kcgnWbpk4nZAB645/dOMLkc+6k=;
 b=DSE8emRjEFp+RMgnM3r/N4zaisDOf9ODmVztyYMFGAjoaZHztR5HU8yidDlTHtIfsMh/tb7sOSX9vQEe08uXgRr2o+SagvYoar7EVc1gwhhygccaEK+gIo/KPNb75EZ32b55w+ND7iKvE4QiDWBrt6GGNxBsYew5WXxD7WirGx0Wdv5snXcU0JLlKAJhqvPjPUCXFVORKbNmj8LJ8VWGSXrTlQdEXsT2Ef6OS6Pl0MM14eiJ74nM6/Z3MJy6598ypWZyudQXRGuwnrhOvsiugirEb9ISqnLpOL86WX9fMPYj5Gsm+fHfSYmgXEF24m9r3JS2K/cQthvhTQ1S3cLPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=idosch.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVwDITVdXnLZg8gQ8kcgnWbpk4nZAB645/dOMLkc+6k=;
 b=OtsUJOjQ5Ht15DWuW7ED6bR1Vh8oFupKVCg5NFQ/QnVnAd929YIc0LerZh/D//4bu5l9brAQr2z/g2uv6rN7M5RCfP+WTWELIpHib9oCuL7sQH0QcHOgP7FVK0WXqMxJwaWIqsZ0t5/fnHsBPz9Zvw2zxmyc62H0UJygFoV7pfu0TtAZvzmdwOUaSG8HtIz9JQrtdIlbJrm5fRtlIgnd25k+aIVAKTKL1OPg6Q+lY+e2YjGT4TchhCWhhuuskk4u6Pg91yOlV8qGAboslxw3onT57zDcUfQjO27bftrSlirMILDdppXKNxhKNXzB+4t4lMJ1YyWYxnxJBVO7qpYWkA==
Received: from SA9PR03CA0019.namprd03.prod.outlook.com (2603:10b6:806:20::24)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:50:25 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::b9) by SA9PR03CA0019.outlook.office365.com
 (2603:10b6:806:20::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 09:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 09:50:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 02:50:08 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Mar
 2025 02:50:03 -0700
References: <cover.1741375285.git.gnault@redhat.com>
 <2d6772af8e1da9016b2180ec3f8d9ee99f470c77.1741375285.git.gnault@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>, Antonio Quartulli <antonio@mandelbit.com>, "Ido
 Schimmel" <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Date: Mon, 10 Mar 2025 10:44:48 +0100
In-Reply-To: <2d6772af8e1da9016b2180ec3f8d9ee99f470c77.1741375285.git.gnault@redhat.com>
Message-ID: <87jz8xz03d.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9add6d00-dc7b-4115-d5e1-08dd5fb8fb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J4o7ZBoObMw2hNC1LbFvInx46hzStbZ80jPFvDwfIsSi3JwozkEn4mcL9YhJ?=
 =?us-ascii?Q?SC36LgU/XMaGBnqLZruIo6I0+NRunWpBFSs/IdLITawNm9cL/x6VpVpT629V?=
 =?us-ascii?Q?N5VRuKsi3wsd4BvhGvsqGQu9XG6rOqqAvZwVGOFq2Bs1vN2j2GARpIbJE8yr?=
 =?us-ascii?Q?Y+XIG+OHwqyULT+CL7poRplbuIJ+cNo061t/WxomXwkPlW//+XqymV1e+/lR?=
 =?us-ascii?Q?IRGsYFIH7jd6CJTnowcOGwljqV3XSAkB4TNsH874OsZbus4brDIgUx/tTHvd?=
 =?us-ascii?Q?PuEmR/M5e796zlyjSishjBUgLp+nThi10xI5a/lq+tR9Wa82aczom0XnT0sp?=
 =?us-ascii?Q?vbmk1zut6hP1ZruPfCgAhlbCwkUPpS1HfuSx8aon47XMjtujoXhRWYS5obUN?=
 =?us-ascii?Q?YaAPRkkC9vmqM4kqUb4tqtMicM7i57cr9JRpI3SfAG6JrGx8S8MlAMRSDujv?=
 =?us-ascii?Q?REYSvbt3JWB2ff3OrCG7qwueOA2gdUd2ur5ODCmZITSKT93nbzJ3QeoMVKry?=
 =?us-ascii?Q?uDO06TLyC9G9+PCTxOCc5PgfBuI0iAo+kLjC/EpyldTRpJr4lMnUwcs4dgFr?=
 =?us-ascii?Q?/QBVYd5IMLgo2wxAyQni1E/gP/I9bPLelpKKaDpNru/2PG1nabihfTQ+9d6k?=
 =?us-ascii?Q?RSn97C2DP14xoi4EQcOG3uuZUiKvPH2I7tQciivHCtHRCQU4IfTlgdCIjP40?=
 =?us-ascii?Q?M5V0IzOpCgBKtqmbzZYMWvpN4z7xXhaMnbSZX4a00IBIlXtqrgK6PqcuajoR?=
 =?us-ascii?Q?UIHnf45NihhoFXEMCnCfdyImN1IkGzqUDFkKuUigYSO3sK+fGDoeGAtKsj2R?=
 =?us-ascii?Q?J0w3LDdJgDEDqgFqqSXPphvlwZVcZtrvXlg6aRz/OiNUM8cAySc5A8xifbLL?=
 =?us-ascii?Q?nUr8/zYh59j+vu0kkAeMSLhj4GvG5fSnrfuBMKJPdlGQD4UIcolGqadU/WnG?=
 =?us-ascii?Q?GGX63OB34Zu/RAmJmxrEWEQHJYChNY2ugU4H1LIZHAJ41SMn0rnygv6akqoL?=
 =?us-ascii?Q?D7qYNtlGHM1oK+jsq66sDFzJh7ouYzw1CyEYZ6bvkIrQpnZLk0N1GSGWW/xp?=
 =?us-ascii?Q?oW6magPpOfMUo83RmH4g5bNqR6oJwbYoUQU+vtAOkibpnS9nSrNrlOWgDtKJ?=
 =?us-ascii?Q?WEuSY8WEKWdVvCeRZ8iZZDHFDR2YxwgkhcFeDnTEMTZRgS/ufim5G257J2oe?=
 =?us-ascii?Q?908B5dT6yAXABNk5CrAVE2Z3DY/tRLwBqVasfQDT7A3TD1ThnQ0tTg7DYRp8?=
 =?us-ascii?Q?M6UY73+y5ZLnJS+ijhE3sC9BFjUfQJD3mDP2DWKcMkFHmO7GjbU9VBGfd/3n?=
 =?us-ascii?Q?6pFg7jtOHm+tePxLSTsOfZLOjrsi3TCbtvC8MyO6AZ7yOu9t2hSHVBL49kH7?=
 =?us-ascii?Q?2PjoCo+tj+Ut8UMQnqnkotDMwBFaqE2eE/6XEZ9IcP5/qvmm5Q1ym7SasYmS?=
 =?us-ascii?Q?cBfI41wyrjrLbFSbIC19uvpOpfU31payRGBHtC6Go166I7UfNHSr50kOCcz+?=
 =?us-ascii?Q?uMguWuy/Eiv2+DI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 09:50:25.5143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9add6d00-dc7b-4115-d5e1-08dd5fb8fb9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796


Guillaume Nault <gnault@redhat.com> writes:

> GRE devices have their special code for IPv6 link-local address
> generation that has been the source of several regressions in the past.
>
> Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
> IPv6 link-link local address in accordance with the
> net.ipv6.conf.<dev>.addr_gen_mode sysctl.
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

