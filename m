Return-Path: <netdev+bounces-100186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7FB8D8162
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5711F21A23
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ADC84A46;
	Mon,  3 Jun 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ojw+d85+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C107F7D1;
	Mon,  3 Jun 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414678; cv=fail; b=SD0e+15qB5QjP8Tl8D8IUgFt+rVc/IWvCqpBpfKKieB6DAmzcpnKZHv9RGi5JuBgWRa+MeLodT4t5m7ry4sd87eanN4FnVoam8IYJxKhmpyD0IP+V5QiTN5NmWeEb7OjSsDcgIneublztoo7evoyS2orV+lpKL7segb26mOVVyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414678; c=relaxed/simple;
	bh=zPTmy5eNWDt9cGvV9kPsP0F/4zNkjB+3ndc6+cuw9Ts=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iTuF+APKkAJ31LCd96I0fK7N9WifQgrATvKMYB0Hyl0mCwD/o16NIszjXKOrJH1BYjUxyORgB8Y+fYhEm1CbfQ0zAyB2HDOtFEE6aIpKJ586oec96DZ2MRYqr1bN6+hME1x3RSzV6lA4GQX8OUOu8rf4i4lDuCTICC7/u043XqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ojw+d85+; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSc9camWBg5HXIqOiecxQ8JdE2rSkVD2ToOaCFCVI+wREd6wfVjDeFqRnQZsQuZHzO7NIUzcHyuDC1crrdRU8yTkwZzm1FnyP5W1pCcCKziqwH7qZMrQPe6dLvpdaOKeE+l6KwVBWv+fy0RJLyyKP3pffbVQUjRVPKGy1tZG8KOkoaM/Bj2quKwGSVnfyMEzQKPfNyCnlWmjWcezQqXHtAytmNpEGR1FoquglRbHSv/UUglbCmngYd0Hdu0V+HedHoDvkn/Tb2RyMm1/aw5jWCMxILkP1CBFTVoU3acx+dqnLgdqJ75Ah1BcK+gV5kDT0n23RXbx0tsk8nE6FZvOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ssLR454/KX970sI/LEhp0SJshV/y2QsnPjcbspmQ4U=;
 b=idcJ/PRZECq29PjPLsxG24OaoyyeBNt5GKq3U3QKq4aNwpTYRpVMRcSCtsKjyFiyB1Tmga/s3zoKgq3inS2jFMVGpksJwpv+zBRUSAhOc9Qx4dgfdLEzynL7G9c4CrNc1D2DUsnhkKo5RB0NXVx+ZREcMBqjT1lK1/AHP77uhbDJ+ZM11ecTsymdQt+pBW3lcQ0SG3WmStFO0gowET+em+gubdbfhooYrRQf/2Ix6QaoFsJM49YOKYIGEYKf1CGabNcRtfNLtRlkXdpGxc+UqFgbLDi/ViO+i9KNARi22WKl7f1l0KVn0n4TiwJ0/VDwmGf83xeftjJUXqoz8DRHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ssLR454/KX970sI/LEhp0SJshV/y2QsnPjcbspmQ4U=;
 b=ojw+d85+QhDAF2of40bBBuFtshlBlFQ7OpfjXX5MrDtU5INdpBZdrrMuAHwFH0lHir4bedBE8JJtIyYwHdsyrktHi2/fCE/eBZ+L5i3z0URk+ZDKOXAF6cxGWwFyt/aW7rbcHs7/ZIEGwgPlIq4wd3Co1M4uMZU9kSMJzw4M+lFZ9BJ60xOhwIamDjBHKWlRPnryxAVdwBzukjlm7XskrB//edlST6KRK85BpTM8eIMz1bWIPGxjR/r3SKLMU1iwvKsQ5yy+K1Ms+HxiiBODhCcPEukdU3ISi4TEiCgskhsa1nTmhk1hOuVg0teIQvdJnN5X2Yz26ynug+C74zEC5g==
Received: from CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::23)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 11:37:52 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::6b) by CH5P221CA0022.outlook.office365.com
 (2603:10b6:610:1f2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 11:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 11:37:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 04:37:38 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 04:37:33 -0700
References: <20240529111844.13330-1-petrm@nvidia.com>
 <20240529111844.13330-3-petrm@nvidia.com>
 <20240530180034.307318fd@kernel.org> <87sexu8iaa.fsf@nvidia.com>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
Date: Mon, 3 Jun 2024 13:37:02 +0200
In-Reply-To: <87sexu8iaa.fsf@nvidia.com>
Message-ID: <87o78i8dfr.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: b3855423-89b7-4618-ac4b-08dc83c19a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFw17RJprWfmlPepDdQaUGdzSFkScxoXgSfINcEk23H+/+YNSyuNlA7YNAYf?=
 =?us-ascii?Q?za+qNqYPX6aMpumMvnsjTyVPCdb9BUzAJ0h11ieXKl6l1IYE6FCT/n+lQaUM?=
 =?us-ascii?Q?ggqihd+lA886Fy9CJARe28aJl8pi+QSgOInyteyThClG0/L+WqahV3Ap40x6?=
 =?us-ascii?Q?uPu0rf03ylAOv0W7c98szem6fWUZT6xFxitEK4d3g5q0ig3t0JsTVWJkMGZg?=
 =?us-ascii?Q?lBaQ3NgHtxC3ADn460KtbQuoVWigt813E/maMkeFwtxMzSyIFd8+hdix0RHe?=
 =?us-ascii?Q?fLNpASZC0ltlQCAkj52gCb47pGwUCU0ZD7fDCCnn1aooVblayxfUazWMHw4N?=
 =?us-ascii?Q?a75CCIQh5chYXUm2zYJgJ+t838Pw6FnbTdQYk9p1LIRu7DAoheIphZbd4W2z?=
 =?us-ascii?Q?1y0SErl1iLGxiqyFkHiewAa9OU472jlmvL9SzCMjcLTVC9FAdVImKBrhe+PM?=
 =?us-ascii?Q?O0sDFQkxDgPl3x4bEiT6gQ5NVGexgfcAatSciz1tuQMNyBY+pIpTEtoexo3Z?=
 =?us-ascii?Q?GaaNyWzvXWSGrpmnBIFxgD5OFF9McXTaQuvIS7HZRgMTfw03EFE8/x+zBHd5?=
 =?us-ascii?Q?aWWXe3ZDDBVj4cogxfDNr9caJ3oI/9BhVopWTIza1pab2Da5MPHyMA9XBfnp?=
 =?us-ascii?Q?MH6rKb5bNrJKVrS9tl25/yplHvR45v6M80gmKTCF1Vyp9JniOWL5jnW7dqgc?=
 =?us-ascii?Q?QNfX5jSVX0c9bSdoli1DtZYoU98udenL9/+KR7+CiyD9TOT5V6V0WTv3KbE/?=
 =?us-ascii?Q?pyPeYRmTRUG3dIrMqAFSClEHDxYk1LIul0aDVggWsISE4tw4n347fpYiE+6+?=
 =?us-ascii?Q?VJmey1hfzqcL1/0aB8UgDBbJIS67Hiw+fVZu7W52GwaCX8ZsyWcgQqQ0gpwy?=
 =?us-ascii?Q?ubaWWJjAVQlztimsdE9eieI9JmceHepNoXE44/9zHa1id5CJqG7DrT+3ef6B?=
 =?us-ascii?Q?FX2QU3rs1V6Fy/YHaUVuLZBw7QYTi3o/xWMWnqk20YfOJapFBbhclxr/yTWD?=
 =?us-ascii?Q?FbYLRgmZsf8heZdmxtS6S21zJgSHVEV3IikvyBp6el9DY6Zm1nNMGPH4Q+ap?=
 =?us-ascii?Q?fwEiMUeL7lAWVXFCOSGq3KzOsKXy3Wvm2ybKOajLkn30WOeLXfwp87InE4nQ?=
 =?us-ascii?Q?81+y4u+lpRwOoWp1yqX+QKbQuTdLIQXa473eFZ05TYJoPUybDYMi4DVgp6i+?=
 =?us-ascii?Q?Nzd13OU2kZ515vtgfUeG8VfpWsKcqaU+L5mecFt1MSckdgymMO5F5UJUrN6z?=
 =?us-ascii?Q?uaWBDBQOq4jlw3XmDAEFdYKB2wa2Rs15T+bcd+WIxMnDTRZ8HvG31v63oKAr?=
 =?us-ascii?Q?e5+SZE7waSAhPYqk+5kvN09zEhjs86a0NCIAuVcT2YBY30p7e118MZ/to027?=
 =?us-ascii?Q?6wyD/eA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:37:52.1273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3855423-89b7-4618-ac4b-08dc83c19a71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736


Petr Machata <petrm@nvidia.com> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Wed, 29 May 2024 13:18:42 +0200 Petr Machata wrote:
>>> +fib_multipath_hash_seed - UNSIGNED INTEGER
>>> +	The seed value used when calculating hash for multipath routes. Applies
>>
>> nits..
>>
>> For RSS we call it key rather than seed, is calling it seed well
>> established for ECMP?
>>
>> Can we also call out that hashing implementation is not well defined?
>
> As others note, this seems to be industry nomenclature, so I'll keep it.

I meant the "seed" name, I'll mention the algorithm is undefined and
doesn't constitute an ABI.

