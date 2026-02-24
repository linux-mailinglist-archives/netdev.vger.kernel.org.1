Return-Path: <netdev+bounces-260521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG1gKBeinWlrQwQAu9opvQ
	(envelope-from <netdev+bounces-260521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:05:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB64187605
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5C39300FB41
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6E39B48E;
	Tue, 24 Feb 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gGjj2AUw"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F132222A9;
	Tue, 24 Feb 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938307; cv=fail; b=FgkIbZFthCsSWwPBq7IO17OhmjbygqqkPZkTOobpwrZNe4aIEh1y2W5Bs+M4YOs7LxmRlM02jbZDJUFuxE0Jtfrz6su5EroL0+g1nVufxQunKHVdXb8K83s8jjil42vv43r25mapOR07SjSGuSsljbcut0D7k8gaXnbu11+msYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938307; c=relaxed/simple;
	bh=BBnMjQILzZadnsvx4OOa7iLLfgFhZxVvgX9AU9kGjs4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kfS38CwOKIXD7yrALQgV7ob4RUDTzXMhpNawMNxiKERYeZlgmXoWmRlmO31mk/MfdViwMPB8VbR25Z5oshYT33rCwWUdbT+t9yJmLbcgqUIp3aW7K+7SWfw2zNLxUjeFrcc1WOQImzoYRwg2B9a73t2roQNrHm2LvTrxPuDcCrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gGjj2AUw; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LT8cxSeuXaGe3lJ+hsoDxrdNLtWG+g36sHD+BvP49YHLW05tczT4RlIIHrpC9XlU5nxqZpakWy1ll7jZK7jIKTPB+jS9glTfOaJ/nNYh3V4C/xjnQaXI6cKuGDRc9JHBdYuSZNeCMX4/3omuSZSRsCBzuExqGBUvtNAEWtbKNgIbVm628DecZu5DYt7K5cYfhaaBjl7IpD5IPRfCfwh5XAeMI1LeSM+9pbBPvORMZIzN/tTfng3x0OgKL58ECpvsEBedauBX/rTl8OhBT8/QFMtmXx6Gs1JIvAhwTy/jp5135f4Y935ilf6S2HTQkCI3QDuIeuCZ8dBF6TysmRxE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvoHLpu4dkpaeGrg5F6V993JVko/51rnWkAGyC3+HVs=;
 b=w/jrVmwxG5Oob/3vnMfm/yNSeiIEYojGfDif9qz+gq7ibFr4eDJS34TR2/mgnCNLttlvuQFNb3ox+rRdU3xEaW8OI2QsM7GeAWPfyi57QWPnz54K5WhmftIc9khbmdGP/0KV6/lpO1dn7qRb+iXY/+QN1XLzzV0U7ujIiD7vqea6Y2ugl0r1G0ngV+7dZpND/11gV2ov3o2P4UFvvNDzg3JaLwuvx2TvgIQ2MPD7QPXu2AfC3sF/2973ilYxNPBO0rEZNS2Q+7061PLm6rV9qo5ku6jTQnJ9EGh4clsyO21teaxaG+AUWZURUTpVfHEQBR5h5rp+y/U1sAhse9/34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvoHLpu4dkpaeGrg5F6V993JVko/51rnWkAGyC3+HVs=;
 b=gGjj2AUwbFLbCjIiaA08CQkUK04eOujTCRVXEHxBvXzr+kTOuaoLSoeEHuTemG34NCxUVJ4QPRVQhHbIJUkH+J6TZu8upnnzZzWGvpFoJaXNENh00M/10CI8v4mqQSH3CC4y41J6qEgSDnuPLkQ5g1d3G2qFN3CdKqx+sRxOEF+zDL8iLaDXdbm67z95c/qW6j/W7AZ/fijLWJsUISjlBuXxDfVR5GWyPIeGDiwoe7Ncptc8i+rFrulWsaSA8eQwWbaDypQANY7UwNg/s9KJw1wXw1UY+w0ckTHu7BMCIyOEoJJM+DKfPZXx8hr3+KcGoD+rk5GLeuoAJwIKlV1BLw==
Received: from PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::6)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 13:05:01 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::b8) by PH5P222CA0006.outlook.office365.com
 (2603:10b6:510:34b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:05:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 05:04:46 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 05:04:41 -0800
References: <20260223202633.4126087-1-kuba@kernel.org>
 <20260223202633.4126087-3-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <gal@nvidia.com>,
	<leitao@debian.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] selftests: net: py: use repr(cmd) for
 failure exceptions
Date: Tue, 24 Feb 2026 14:03:13 +0100
In-Reply-To: <20260223202633.4126087-3-kuba@kernel.org>
Message-ID: <87fr6qgumy.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 3644e569-bfa3-4d97-1ec0-08de73a551df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YODC2gzisEuDOv4IgzHZlm+HC6WbfAacWCawYzDeNLv2BMtXchLIAvaCQevs?=
 =?us-ascii?Q?YIIum7yex5K26zryyEdXmjkQx3HdCjVFy/uqr8hw7CrwgacpLwjUEY14zhqF?=
 =?us-ascii?Q?9QatWkR4KygCb3LM6qamzGfppQLc9iv4/fOH48F8OuzGfHjdRuPNTH/5B6rT?=
 =?us-ascii?Q?NBxTtrGjqNOWWDZK6NoolIwWYvbmaGbLW99ivxfPuL4Jx5VGLWvpYBy3f2Oz?=
 =?us-ascii?Q?qWJC7zY3TfQMge+MIl7uthQBR7BZTIEk24NYLDPYeNTQo5q1L+3UCtI6jGxO?=
 =?us-ascii?Q?fKLlEIsyGAK26ufBaOgrAmx08nu2OZKbaKItsYKjn1Jkt+6xqwblxdgHpnhQ?=
 =?us-ascii?Q?phaeXL2LqxgoANPAlJ6Zo2cfrlgd8qHbp6MLsGCuGi40DFEsPx64SAHiptfK?=
 =?us-ascii?Q?JcIvILZ7mLKCcBQ5HCd0/MPY7vCC6pWSAbZ2I5OZT3Xfgu1Qb00ouMuubYuW?=
 =?us-ascii?Q?vQFw2Oeawxkddqanin5BtJZ/SpNiB+gHR1Iwsg+nhFitVHUoMj3xHtW6YxLi?=
 =?us-ascii?Q?r/xVbBdVpR/NInD2lQkUZkGbykElAj6LIbfWwiDO+U9ViJs8wwntPeH0j4GF?=
 =?us-ascii?Q?jFY4Lmepy1tjOFVxOqpDsiRRKAUA07Vp1q36JNcJjN74zUG+ntQV0emgIsCc?=
 =?us-ascii?Q?ZBtm3iuhWyeBb11eGBJY4StyB0dRCTKjmWN+x/Id+Fwk6zdCpNimL/y97OCm?=
 =?us-ascii?Q?eryvO8O6HtntPxoAMeNUjbOGT7BFY1yLBvvOuNOPM8SHxicoNh92S0+OU5+T?=
 =?us-ascii?Q?X7gfwZsE8IiO8/0h2YGD7KJLNZ4Eufmu0YqnLJ9Prg+hhueInbQiwzyWxB1D?=
 =?us-ascii?Q?cTSOnxL1hbjhTwNVNY055ZEY6/bNvN9g1PAXJ3ueWmHXuoYNDOco8wKSwy74?=
 =?us-ascii?Q?vNmDNTVPWZVACJsTN19ra6KaSTyJSQR4pYFK6ImKRRLWzOUOgn1+KjRUythB?=
 =?us-ascii?Q?e9FSp9eW1E8SOfULYlIP+r34Zsy15FZMuXZYi/lG32Nbc8LdLBr14GJTDfw6?=
 =?us-ascii?Q?fnC+RdsRF3cINAGssh756II3PLkY7h926TZItCycJkbWH3NCbqTh+sxxJdKX?=
 =?us-ascii?Q?NxDJudCpbejwfXrk/ND4vpLtocSrpuTd3rfoklYwsXg3YVfw2eV1Nu401ra6?=
 =?us-ascii?Q?tfE9RKKtrY/7ZZXfg6c8TCx+7A375V1/6aNnnKbKV+PZ/FYGVqW93bQg/bB6?=
 =?us-ascii?Q?leXJJCOdcoA+bpsr2UePYsnqeFd1PSbbggnjVBWLc9pmVsqYRITkwd4PcG13?=
 =?us-ascii?Q?7nYpezF2k6f7NN62pVgI81hn0HqaLIq1+FtLM6zyxdaFduQ6VxVEy3VNXbix?=
 =?us-ascii?Q?yFEotgtv90rGkR/omQQDcUOWn/PggIM/3ufioc6WCTcuu5etsocNc+ARcpfs?=
 =?us-ascii?Q?akF3/YrpeJ2gL0ycSAd6bQU6XyNXX7Bkrui6YmZi0JU9DUowp+mTAyYkVnkn?=
 =?us-ascii?Q?6ihS/lF/xd+plGlFsww0CFt4pSVF+R/5FNwiRG+leTk+usN7rDIM5OI5RTlU?=
 =?us-ascii?Q?ynje50wB9aMlpyrRLk7PkhP9EbIZYleTjKx5/F5B633H2RU+IVP76OoN8cXf?=
 =?us-ascii?Q?1RSofW5jDWikv96iJ5GsljTERSYTrqJdjppwjpc4bptRrxx53AmKkHtxrboA?=
 =?us-ascii?Q?M/7k+Thqk9n/54AaxLpz9MexgZ2tA+q42QVz9bjKadg/kmVRehMZ8dq4NRma?=
 =?us-ascii?Q?mQPYgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qxNaEjXNKAOUcEpbvMwDfkepqaLIqSyrXQo9xunO0FZ9vzMiWCQ6I85gktKpxtV86FJgvqJdqFy8sG/YLDKfp6ENP3kY6R0oijUMCWxP1ZNHniCkSlNDu1hke1uByl6JAsPV1xhCgdHlKDLOzkXSue/+pEztcke8Eok/oZsc4tU+UxY/8pLxbp70Amc5GLsR014BWB1iDoT9xHJp1Mq0jZJpvXyqGTl7NvNCpqDNqLnKIWeJw3BipUgf9UKK9I6pJZdPwB/JoHLCVsiyPz7r6HtW0jHEG6dqyYxV4sw2lRGC5nXoZHb4PuU4Q+Kp/Uta88MqM8ar//p64xIJDgL8T7ymF0GCUuZbN9u1LUEpnTVoknuqOsnOqzuP/uJ/QTYpV8B5EwpMAeKKeZ2oQRpGJFUifUHjX/NbYia7NW0whWjzQlPkIV/DbhKyfvk0F4pT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:05:01.2070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3644e569-bfa3-4d97-1ec0-08de73a551df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260521-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1FB64187605
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> Reuse repr(cmd) instead of manually formatting a similar string.
>
> Before:
>   # Exception| lib.py.utils.CmdExitFailure: Command failed: false
>   # Exception| STDOUT: b''
>   # Exception| STDERR: b''
>
> After:
>   # Exception| lib.py.utils.CmdExitFailure: Command failed
>   # Exception| CMD: false
>   # Exception|   EXIT: 1

(This seemingly omits STDOUT and STDERR, but cmd.__repr__ includes these
if they are truthy.)

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

