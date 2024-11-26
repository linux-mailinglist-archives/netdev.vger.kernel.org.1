Return-Path: <netdev+bounces-147523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7119D9EE6
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA31128156F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237C61DF25D;
	Tue, 26 Nov 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WrO6OLNC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C532500D5
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656850; cv=fail; b=aQEK88QY+aAmF+zqab7BNx7Fk1hxv7PycRzdxf14u7cZdRM2xaxe5gUNNZY/fKYXIKdu9MNWxxpBn2fsaOjb/Kfec7w7Cuyh2k5pAMTrJK7doIE2JfBV4a0MeV98853v+KBzcf7YwQAKNpAArNhQX6noGQcEULyo3ox2XfI1udk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656850; c=relaxed/simple;
	bh=rMkb8A92YwIcjx74OGBXnONIg6eOMUMdxgj7a7dV8FA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WnBgZKiCByBynq42QsyMs3NB0V47IWfmfCoIplLH4vLGMPNdYJ8iezP0F78jx9fEmfPD5XlyZJ53mONVUHeUAiSMTrxieFyItk5A10Zd/pVaYGW0mJ5/uXke+PRVsv1iGj7TRzeHc5FgbjzIZFQMDFv/18fq7AG8clXq7wBaBjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WrO6OLNC; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZreJS8MJ3O6jLX299CGPTcL1WY1iE54YFET0IwubMl1WRMKHerNHxzfHSBdK1b7dZ2RiKRoEzQDt3tZp4F6j5WUWTlots7vsUefr0fAmJOMve2td9VJ82MzFLgkofAUoWovqVjMX5PQA7qOiOEUYlZsWq9ic/xpvDOzgcGbgHLg/v+mTT+akAts3laBWPxUsgNoLsRCcnOG+WYfvXyIFfS28YC7nD5MrcqNyFVP6eqDkRm6A0OD2n+jN2IWuImjbzAvky/qk31vw/VU6eFbbFDmjwx55LqucHP5I0aNxE1NAyMqwtwiXP3MHYsW8clZOGHFtYqHV3vSCPgkhUjxe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86zlaxWsjJ3Hyj9RxwZIck7GO30S0cbt1N2ZnLRKPSw=;
 b=Rhq3R9yv56Ai0gh5y7kzNM1te5PtdcGv3MnSbuQmNEDrAUWFTxmOnVmxV0hd7KroQmagi8THcS+NzqaPQ9CChfNvM3Ry9mzA4GW/+u5z/CwRcerfjDmvr42wJw6emMH5NZBw1o1Hlw96B8bEWslhbjS9kyI4LsiAnTFAcGELA7GJOsRqp8UZ7VbqAwRcZA2SiC8tPJlGPX8OnPoUFtd90z9k5JpfcTB6GXgVSF9bq6ZsM7Jn7SbPly+zP8WmtbR5W78bhuGM0KdfCO0xlVtYG1jBie1vRQvh1Chnj2nCUnovAxvpVK6mQhzOh6OrFfl5LfuO0W3BRAFslkpbDvmJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86zlaxWsjJ3Hyj9RxwZIck7GO30S0cbt1N2ZnLRKPSw=;
 b=WrO6OLNCqzUFIMsPZOnlpAPHTVewU6Zf53DMUNkPXqIdEZm9xZGQf7FrxPxSlpDafeatcz5QqHSuBktI4GhhijRLzItoFQ8TaTQQEH2o3wKCEzhguALMu7uMl86NwZ2HlXBhllEpq6AFTrVqBkAddNBvx7QZ8UmHPbDxMsT55b3lXMRbpCL/7yxsN1s8LurKPleNduX6yrIBnavnnRFfJFoEndiz3PGP0Sp9cOD/sDOSyiLrOtIYLnGhoztuy2s9vW3KOglt7xJnE1KctQXn3JdmM9LcCwfqsNHF50WPUpDhJWDwf8lPrrzwDuX5KB5XqP6PBUucCQkW2PSksIuwFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 21:34:04 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 21:34:03 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	ndhar@nvidia.com
Subject: [RFC net-next 0/2] bridge: multicast: per vlan query improvement when port or vlan state changes
Date: Tue, 26 Nov 2024 13:33:59 -0800
Message-Id: <20241126213401.3211801-1-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 33191158-1129-42f2-0c83-08dd0e620c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NAJyVW9IP095IhCMUQ5BgaxN9FUYXNJr1qsknbBc9QWb8Bu8SUOWGrrKgE+T?=
 =?us-ascii?Q?NsW102XTl4W6QGCZCSZDIqesTIpISQpVEXwF3usdfCYS0P1GVwmrojs0yZUV?=
 =?us-ascii?Q?+TJWII0HrbmP3Bb65ZrPV+CMYcQ3667mrWFHT2bqrCZsCKCmr/cg69RMU/nc?=
 =?us-ascii?Q?qvoG6uqqHg6xtvnXnOrIGSlSmCg7CMlgTS+HnLz2BcfkJFPGE87sHnUNCS0n?=
 =?us-ascii?Q?sjl1aUSGoWEhJR5+G1y1EatqB9+Qe6CvC6lqfUXf5bSXmntZaM9DVhSIsz3r?=
 =?us-ascii?Q?zwL3am55F33LpuUO5HVCLTuXAlq6gKpSVlsk8+z9QJ+lfERwZNTV4gDCwGuK?=
 =?us-ascii?Q?iOV/oKdcDdc1eurS62J4MtohybpqPgRhh8E30kOkz4EesId2myt4yLraspY6?=
 =?us-ascii?Q?TAf5sdK79DYQJzw9aJ8iw6wwbqVADVGmpB36tNNODLaGnS/YYa5gE/E+SURm?=
 =?us-ascii?Q?mnAlZ++hGQS0VCAD6GACC0MMV8muON6XdzsVrJcQcRo1J25nsGzlf/jVgEV0?=
 =?us-ascii?Q?Cu3XIeWtfMwJG1zZg9BOgYs2wfO+4nM6svVM6D+vxC7bdX2wEXbaq9HRjhOV?=
 =?us-ascii?Q?sr0e1uYgJwC7Df4TqGa01NrWH+LsmioQia0vqK6uOmWf8zQgJa+sQA3YR2M5?=
 =?us-ascii?Q?mAxHZkmzgQWwl8L5SMPHF/r45hPR/qpGczK644RMNyAYM0uYT2fxwoWU/VtB?=
 =?us-ascii?Q?ezIzv0+Mw3nf0mQnmWggv8Eo8Ey0xuRIjjMk9uE26lUgeEIfGmxqD73lLWQh?=
 =?us-ascii?Q?TBBfNh4rcQHx9qXVjzFC1QoPyjrMr0nQ9MFiAzw0QhuOz2dlBfzdsAKL8YzM?=
 =?us-ascii?Q?Zp5CktLk7Oh3+XytNsOfHWs40ojTAv6WQjFUsNFF8AwO1wQHwQZIE84Oq2WV?=
 =?us-ascii?Q?PDHCZd16hMXwgzei6ZxwfjIvfbLGB9FbrXY9JaKTH1QEydlP/PoBD8narLS4?=
 =?us-ascii?Q?dPyTXqog4iq0oFmuC+3wxoyOvF/9AUjrr3LmbEVm0WCqbsZSVUgApA5Kl8S3?=
 =?us-ascii?Q?TmBnjifXZ+ZdeykJgR5FD6ERle5uz/2Z/CTvRn1Pk9W6L5hRbvqnU8X/U9fD?=
 =?us-ascii?Q?RrUrmxKPx53ONEZEh8pOIB77VY7YhYSqgt9ugah3VmZY1FmNCrJ541hPAGor?=
 =?us-ascii?Q?hnXmGHMXm6pG/HJOpBdGluaK0uGkQz4JJs/8tssT8IFPsMRTTzDWfq1XXDLU?=
 =?us-ascii?Q?HF2XceLpreKCw/2sjXeTlKofLNBLVvyuo0qkrz2SpqBOfu3gCTDwm1TW5BpV?=
 =?us-ascii?Q?TzrM34t4nvzBTMU4O9RSjkwb9VfTjHUqMcdm4VTL8mw3LHhP/C8GfqG1R6Tt?=
 =?us-ascii?Q?8ZKFRCTkLEiIbqTsfKD57Zw91JaXDGu3VX7mW0WQJ6RYMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYg4DUj6Fw1QZWUE5fDZuFiGgneXe/38L6IGjMwGDhA+ekOcsVEYOQqGiLn0?=
 =?us-ascii?Q?E006NTejzrKpJH1l6vDPulan/aN5Fg6jf+bY7JpugDH/u0RZC/IDXRI5/9mu?=
 =?us-ascii?Q?hxMNj++Nibcz3WNQcqHrOFubT+YySXLbBQehv5vBhInQ70numFY5mNoZe3jw?=
 =?us-ascii?Q?o3PSrVnd0XWiq3zRUPmkZaggAPleMbdDc7Cq2GULCuVa4c9ZYLIlSMju2rJG?=
 =?us-ascii?Q?OjkMAMwucjDjuaJb1jDGHpS9iAIvIbVDqhTMNVj6r0xdI1I8I1R2kn9jOLx+?=
 =?us-ascii?Q?rV2bYUwlDy+ExjMwQr338ASG6F0hIDSnrX0180nBk7BB056lWe/XCCj+A1lQ?=
 =?us-ascii?Q?TlUw43CjOIpQ7BO+t51VG70CuiEPEWycalcJ13w3s/OwWAcR4ZgSchLFeiW+?=
 =?us-ascii?Q?MxlM+x3zJ0WIU0lYPrrSZqIbpkP5PhIbYC7748uAMebcnr0RKeBK0DEQ/KBa?=
 =?us-ascii?Q?ynjh68N0Yw57QFnXLbNp1Pne/B2z53TnMnf0ntWr6yJ/zDaj3LEw6tIu0kNQ?=
 =?us-ascii?Q?bcivczw/DrmJASiRUevIAFBhqEv56dbl+7l1+2rG1fHonFoeBBjnobfYtw/G?=
 =?us-ascii?Q?q7qj+8dqd5uYODE2QcwLukfcO/DbP3ICT64mFL0PG1KkKnSss0h38EAOOpS1?=
 =?us-ascii?Q?LaibeoKlFMH29D25dSw0OAnYRzbYfr8dCCEtRexsHej4Xux2dHPHwo0R2fls?=
 =?us-ascii?Q?xbX5ItZL0GZQZ1IyHPMy6K2p4YxYtVVi7tPPw1fQ489GZtInOX5PiXQbgYBy?=
 =?us-ascii?Q?HYz+ZZCma4Xdt5UhmeQMSwccr2ArT33BNfKI4F39SBNn6phkKKiaCmZl/nLK?=
 =?us-ascii?Q?s3ibfm7nkoAprwxrMxE/JwmukZXGCF/BIM9buPPEu8gXcVOLD5dZG7zOhtms?=
 =?us-ascii?Q?WdcVd3tYB1Bm3ptws+hn3TVZnnMmt657oFywFyYtmOLr/RL/BnHkEvujLY8u?=
 =?us-ascii?Q?ZzJy/DbDzRRXzcaF1RQwCIdVWUPtBIqM02HAUN+6iFvv2mTOhj/k84Sr6Oao?=
 =?us-ascii?Q?09J76vUsBgglZ7/vKUM2C+8XmNXttO7pwqOas0c9fENLPqU8fE3C29LAUolF?=
 =?us-ascii?Q?zEzBOJKji+89J86ukP3b4wkjaFxo6VtWsJksxEP1OZ4kE91ZYziRrBL7PveT?=
 =?us-ascii?Q?PYFkqTKZuVMkKCTMIw4MfpoFGFdH0ICfungxD5gfbhM6nYBjTMJ5XSb12Mcf?=
 =?us-ascii?Q?9CAINRRML7BX4VP0z7+yAr2fiJR0bQ2aWlUlAtO8thXy+zczTAuLl0AGl5Iz?=
 =?us-ascii?Q?FwK0L4UgT0SHPCSQLxzFLFb4aNDMUG5zh313UaFfRo/9ywYsesXeP+b13hiF?=
 =?us-ascii?Q?a7oc4iDOZDSPXbuXIGlHrFYYnW0g2Jd8TGEfacunt3/TY8l1anrgMpIbxz1v?=
 =?us-ascii?Q?2A1uJFQpLnKnYZVEqmK7oEEOJbZT0AEJd+ud7v/nvz9vbHXSZH6pdVJHSMbn?=
 =?us-ascii?Q?dZGDQq50yrJK6vQ7OqivnEs6/EyKGi+Utqm3yZAiY4eKxuZKj6OAlNY7GwnS?=
 =?us-ascii?Q?lhlDGqKwfZakE6vRE8zCuKlB+MreBy24UfXojRDA63bNk3WeY6fdU2UgNEBv?=
 =?us-ascii?Q?JDOzUNzSfbeR7jyH1yjsGKmA/mz3uMvd2jJdnY9N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33191158-1129-42f2-0c83-08dd0e620c5d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 21:34:03.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Yb+Vr3qWM/LHKvDYd5JlOHw9QSJFqIWbDtYQM9tnovf0Utel0ZkmZ9It1d1YlD+FE/dwLzu+a/lNZYDY5PVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447

The current implementation of br_multicast_enable_port() only operates on
port's multicast context, which doesn't take into account in case of vlan
snooping, one downside is the port's igmp query timer will NOT resume when
port state gets changed from BR_STATE_BLOCKING to BR_STATE_FORWARDING etc.

Such code flow will briefly look like:
1.vlan snooping 
  --> br_multicast_port_query_expired with per vlan port_mcast_ctx
  --> port in BR_STATE_BLOCKING state --> then one-shot timer discontinued

The port state could be changed by STP daemon or kernel STP, taking mstpd
as example:

2.mstpd --> netlink_sendmsg --> br_setlink --> br_set_port_state with non 
  blocking states, i.e. BR_STATE_LEARNING or BR_STATE_FORWARDING
  --> br_port_state_selection --> br_multicast_enable_port
  --> enable multicast with port's multicast_ctx

Here for per vlan query, the port_mcast_ctx of each vlan should be used
instead of port's multicast_ctx. The first patch corrects such behavior.

Similarly, vlan state could also impacts multicast behavior, the 2nd patch
adds function to update the corresponding multicast context when vlan state
changes.


Yong Wang (2):
  net: bridge: multicast: re-implement port multicast enable/disable
    functions
  net: bridge: multicast: update multicast contex when vlan state gets
    changed

 net/bridge/br_mst.c          |  5 +-
 net/bridge/br_multicast.c    | 93 ++++++++++++++++++++++++++++++++----
 net/bridge/br_private.h      | 11 +++++
 net/bridge/br_vlan_options.c |  2 +
 4 files changed, 101 insertions(+), 10 deletions(-)


base-commit: d7ef9eeef0723cc47601923c508ecbebd864f0c0
-- 
2.39.5


