Return-Path: <netdev+bounces-288726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HoXPM5mwCWqElQQAu9opvQ
	(envelope-from <netdev+bounces-288726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:12:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B9560E3C
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13B84300252F
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEBE346E73;
	Sun, 17 May 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jh688skH"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB1345CA1
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779019921; cv=fail; b=M8/FV4I06TSZbBSqWViqama+pBRi3uMAIgaMeRDCi+1epeJx8VjVUB1e+8eKNdhAUCw4besbNKLQbymySRoqkHE2JxD7cS0svLHJ8qNfnSUCpn71M/RXdVWmrLgH6dhzKsxGGs/S1HZNoG7Y2EyjCAP6qWzyA6bmxFor8YhkIQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779019921; c=relaxed/simple;
	bh=amogyWvzC53F0OtU/0t8SKLAouqMbEuuppuQ4i36xnw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=espIlZcsehA8BrY20tQTM8guU6mMNZ9WF0EWRnbvdEsl0sVLSFrw7jj1iP4konqmqc0UL5TwrM+0FX5l9TdJ5jbcayYTTBSGyxz6xsCbY7esszrv0ji8gqoC9bMDuVrAAu/rEcaUfoSPqbmrYRuugEMHLT5dCRdUeyGWe/0iO5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jh688skH; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwwcRBCo0HsbBXwomJ2l6jdr9gjOcyfMOrWPlrGps2bKHDUUxDefRNVFrSbKYaZuyAo4WizHJZKPOj+F7Zr8Ora5TlNtS5SFJOAQkJRm5+W0UudOinnFt18w4JDmwvgJo1ClWZ/MLq/jgsUXMXtzCyXfnIz2WiIYNNsuYFUhvCQ1P4KSfktW0kkhN555fTaWFWLYVVUXFjoE8+TEEq0Yh4p87xoLXogcV5EyL3/l8OvWmTVmVF1UMGAvxQJKXdAM3I80PFNhJNURH/FQM5RzTZ0osXaI5nxPuWcY6+r6/vh7lzh12JdhLDSRQAbyEJDSnMBs+m7qGXjCtYqpqjw+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys80+ldTdgxs53W3JmYaeVvo11NB86oxMNOSNbGYcV8=;
 b=LiOCqgjF5rYA0lefpdHymHLb37uPNAcEicKL70Y/1Db4pXzdUDaE4Cat5UFBJHPb6TyvnuvAActTEPPDkI9HfzXL4SMC78t14aSFP42xfTWVGc1sV6INZXhZoMZruQNgJB968w/U6JSx/ORt/j/ITaL6KRySpQWYq6P8g0nRqM+tMF+KDBgR+njPQ3UeVuC0FRSsRraU2E5yMAqxw87f1s5qjeTkb5pFG8H6kr1a7oOTiBfFLVQPst7aAYUAu+uS6pAlzuKChg46s6Lf5+5/Ui3b9yBQCLZ03kUoMpVw0zjJzaWKRuw2HYdtt7xp+6UT1RIp3V4wL+xfZ6GxONPoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys80+ldTdgxs53W3JmYaeVvo11NB86oxMNOSNbGYcV8=;
 b=jh688skHtaOE9l+iMNN081Is7vLgeKdIFWwQ9YfvN64Sz/sy6TTMgY34NWJbUkG49PiRqIr47/xH2j8pP66MTrLgYeyBzhkW2NBlRRRD3Wk/LlfXNfj5NE44OVG15XxhNeJ4gnNHNyghW66429xv9kOI+yNSW4F+Pqt+PdfFO3OXo7pjcbpXYdblN+c+o0gRsvJjV8yKA/IKJuT2PWYW9HFBCPkPXxNco0h2gxtEg5Vf1LXytIGRDJgce/NAAfXCWAfH6+bE98GqlKj7RypmglubgQ8PwbaKNGBb5LLG6bLkd+dtfnjdEdW1Gu6wNQ31jTNXi+9gWrHITUG6OU/5rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 12:11:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 12:11:53 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	dsahern@kernel.org,
	yongwang@nvidia.com,
	aroulin@nvidia.com,
	petrm@nvidia.com,
	tglx@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] bridge: mcast: Fix a possible use-after-free when removing a bridge port
Date: Sun, 17 May 2026 15:11:20 +0300
Message-ID: <20260517121122.188333-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: dc25bf5b-6549-4570-83cf-08deb40d7bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	VCJ063WjeQGimPhlWrrrR0pavSh+OW6A2oAOMRqNTKuUBDP9b11Fvk32LISKNhf64Zw3S/6XMKWHRHyieVqQi9mMoMZ9GAyxnZAkKkxg5Hni+Q1lWclJ2OtcmaQp20xC1yuuE/fpQ9R/Au9C4Umc8g23+47xZ9gZTJ7kAdH3lFW5a713cRbnUgczrfzzyJogozrGE/cE62TOcL09jqBM5nN6Mr8n2n64IWk2AeYvGLhP/5ZNKwz5iFfWHNyCfo5yBEFT8uF3yEAlzI4KDtf7kKQYdK7VDngLtStc13QBbR2a74oQzTvxeR0vMEVObnFUcTzGiLVfmIayqOBDxlSP+dQ7P3aM4ClylZScn5QWSJzYxPK0np3JsNHqV8NJh3Xcc370PLFvnQvF/Zpw1zKHEUwtj/khUDer95CHKJM1AVohYahDfGrPy4PBmTEpSaGf8aqMcLDhPcqzIxKkQJMko73U8LoVgrgGQuBS+huh7JZM67DOqs3XRcQs6UQMjgRcsxk0f/PPYjGY3jkFu6MlLoOikZJ1nwXVp8eshpM822Ea3KqXyCc/uDYmFLtT8KUXPw+ZlUEFT7xg1pdO9sNkUNH4d4MaxXVnBrzSGuASyZQA4/kaJajkQvirYqjGob1Ul25bl9EXCS1OkdxHgkvf8c45iJg3PK84MWaOLweCMDqfLoGSPUBqM2OCHpHmGhMU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdN4aIVK+91rTG6dIpwg8d/YIxZidUE6id2/9XM0M7kRNyd0MIAqwNXAEhyV?=
 =?us-ascii?Q?F6x19kSdpWL0E0+xfm3MgCBAMo4IC8lXG2wEGpkyBHr7C9CMA418wzQycfKh?=
 =?us-ascii?Q?ZyrlDaWCudZyBR/fpKhv69pn6qe99mggSVkHQj5GPljG4U+H4XNBNkloxD3y?=
 =?us-ascii?Q?cRexB/jMbzY1gR4RxJTcx67NwvqH/v6FPaFuTZePwFj8Fgzb1DJgtDxYs0wb?=
 =?us-ascii?Q?z0pzraPTE/n15GswJJP2rpxm8iYDpX+4FDdNpCgqDcN+/LH00LXcydcAcL92?=
 =?us-ascii?Q?Z50JA0xOv5qudjk+45WB88msjnKDQ7IVtMDBCAlr06wfNfkX+h1TDnVByU7n?=
 =?us-ascii?Q?BosdB2jd1bV7YSC5pgmmLrdwb+Ff4ecAypWcIp+GmICIAzwwaEryn9ITbD8y?=
 =?us-ascii?Q?0iiKx4XmrtcFVNLH6xVOAzLaGMSKNoxIJnfhrzOLKgRszAwh+tZE33gRquTi?=
 =?us-ascii?Q?voUZ8RxuMhs/xOSf92HvSfc93DPneLOjUSnoBini9gIGX5Chs4qlm/OYEJYn?=
 =?us-ascii?Q?1TpJiVlv2TuQbAD9H4iFpkMEY96LRlWJEwdTqODMRIROBiBkvvSExr3ZI5D4?=
 =?us-ascii?Q?WtEJOGtXVoIh+Lw1RxAAWon+sEYIyRXeiy4JxADQAiM/8sO7kJdYt2A+5f+b?=
 =?us-ascii?Q?myRpn3KiM6zoeILQI8CNdbBwzzb6P/ua8SPQdbUYkDs2aSmaKypjGfZIgInv?=
 =?us-ascii?Q?e8UCnJwavGrGU+7/UjX+k/5+T5jGBoNIO7pCjtnaTI4kzxkvEUToCtX12/Vd?=
 =?us-ascii?Q?3wMFuLK/tJQGwjH1JLC93iqfBm88oinhlmss2S2kfx7VpCfX7aLLVphw2AX1?=
 =?us-ascii?Q?59DoZpnBWDyzdyMPJCxdi+ojWf/izYK2b3zEMhNzgt/o/qsSfdLRtT0jyK+k?=
 =?us-ascii?Q?g71AFnDlb4s8mN7k9un1S+L8ZAvl4KhnrGMH/hs73nBIq7HQp5z48fsD3Egi?=
 =?us-ascii?Q?f2PeRMT0HstJvndXOPw47fa1rPwgPVOCbtVpTJbp3d3pGeP8zHLs8gVHxyXL?=
 =?us-ascii?Q?t4PQi9kgHaxo8KFnIkypV6bjVOHgsHfiBcgqJU/Qh69MEGsfUO9brTuZOBQ8?=
 =?us-ascii?Q?e2w3Ge0EcA17KF18uAQHhyb5nazVNfe4r/FPCKfo+w0CokdMON9TU/FKWx5r?=
 =?us-ascii?Q?yHhSLQ57Zn/wQSfMcK98uUeOOCKZR4AJj4QSFoyU6edjiXXaRuxvOcgvGMxL?=
 =?us-ascii?Q?6reXpV73KrZGQM0jLkZF0RBdaTkmXBJsL2/KS4VrjWNGoDjTgE/TI4tBAcp5?=
 =?us-ascii?Q?UiJ8G63FMBvAk5r7LiZUVOD5jxRn98gMXMZSAcn/FjnxKYT9ZFVeaDDp2dUx?=
 =?us-ascii?Q?kEZ/k2dgOI8CGEgnF/+paonbyXVN4EDpxwIJBNQzY2kqjnPRFOzO9WoLhMs/?=
 =?us-ascii?Q?fM6qBCCNCuaLnOfmPOtTpsrOdo7pkPVBGG2hJafRh6xxV6EuiVynIDKxVrHs?=
 =?us-ascii?Q?wbATR4jWSZD55MsDK3h2Yg+x8P/SchKIu+3k/byo2VgdIiIZmPXOpzQtoQ9k?=
 =?us-ascii?Q?np3LD1BjO+t+YlL75JvEz04IlsRz1+7mM14B6frCSBh0BJInqYb55P58WJAr?=
 =?us-ascii?Q?f9Z9HwU85zNGFX8uYylUfM+BIb9mrgK3CzbqP7eYPMt6hRiaR9tm+yuNCUu5?=
 =?us-ascii?Q?SBwWFrMz5MD97UtwU/fN71lkaWuNwyjre7R/R9KVI16LCUkP5YuDjwZhD16w?=
 =?us-ascii?Q?cTzXEnQ6AapW5R9OjRp9jJFFpNL2Q3Vue6/9OrE0xzt3PjSB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc25bf5b-6549-4570-83cf-08deb40d7bbc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 12:11:53.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50eLcIPJgI1Vb1gL17/UxV/2eASWNg/Vapti7/FHaP48PbHkhIoYEaQgSjetsAHoOWrx0H0K0Wbvq0hApguwuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
X-Rspamd-Queue-Id: AF5B9560E3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Patch #1 fixes a possible use-after-free when removing a bridge port.

Patch #2 adds a test case that triggers the problem.

In net-next we can:

1. Add DEBUG_NET_WARN_ON_ONCE() when a port multicast context is
de-initialized while enabled.

2. When de-initializing a port multicast context, synchronously shutdown
all the timers that were initialized when the context was initialized.

Ido Schimmel (2):
  bridge: mcast: Fix a possible use-after-free when removing a bridge
    port
  selftests: bridge_vlan_mcast: Test toggling of multicast snooping

 net/bridge/br_multicast.c                     | 22 ++++++++++----
 .../net/forwarding/bridge_vlan_mcast.sh       | 30 ++++++++++++++++++-
 2 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.54.0


