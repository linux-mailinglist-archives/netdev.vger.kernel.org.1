Return-Path: <netdev+bounces-251865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4My1FZXOcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:03:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25057493
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 679EA645122
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6F48A2B4;
	Wed, 21 Jan 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t912IPc6"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F848167F;
	Wed, 21 Jan 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999940; cv=fail; b=LP4nNU07ZQhdczUUAwSNcjpXTBr8O5eG8VM6ErI78kmSQuI7Kxai7vf9QT+cQNXo5Pm+VEWkub/oVXwHbipbje/VoT/qJajdZ/WxmuRYPvftT+uWR1DK2pllNcMGG2FZ83Xgh5LpQ1rjJshsOFx5GozXF/nL26TZyjVzl5JW070=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999940; c=relaxed/simple;
	bh=3BjkrFO6ImOrHZ5XSADvhZgYZZAZZdn/jxDKaMJ082A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ScYxhx+5EsSEUFgdPCGjbgzwoHzo++5dW51OHZM63vbA9JM4XU9RcPu1e5n3n9IoDjyN6dHdfUAx8KOe+QWEvFspNrDnznHutEde5S17DTN3Iped71xUeH1LkheK0VgnbBEtPHAS813E9Vcj1VzRmoy/OomXz99eifpCBvOuwsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t912IPc6; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVX8EBqQpoASBeGgsq/RzOg5gxzpqJZHqbvx6blZ128KqEV7n0dNOyzqFutTUjr73n5FrZm+XgFVm5kJlGTkcCl53fel79yZCsWZsD8+pfCIPGznOhyBcMF5WjoFQ404a9M/jT6dUood+YuQKSfgtAt/Vp6cQNlj0fniULWv3VyJIvVSaPDwhY2QEzvRe/ID/4UuwE+RSYxhi5keJFKLkhd4phpgzlk5Ga4O0FsrRhLhe9BSu97lS2YwFrT23gdxHKvwkNqDSEc5F9+1nLOP/aKJHfulPZx013qQAy6kL2++GLbWseyc2m5qOa+yM5w88gI0cztQa5w35plJypSWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wHXZUe2400pAMvxjYhiCnoAMQr1LqPQdHKf31NXHHo=;
 b=jcIs1qRTVrB+5pmwSslJTqGAs36w6Vv8rDheLT2VbCccNpfAP466qQzWUjdXYYNXaXz7tVyWJJgJP65S3cIvaRVE0wtrHBe2UDAHJia9oyFu/zWB9bb3XQJN8+8V36fVvYYdDSvMxLAG2QuHh3R8egWz4lGGfhSSSehu4RYZncsjd7MDDu3HMFq8dKTxkSIAUe6L6yUqZ0TG9tQXbZIJaEZcM+Yx+RqHbhinSHRUtr+s6wyqjSZ3b/C4d1Sa0lbvulHygMxPLlkQjfvqTVFiFq8spnvlL608mLdccw3HwmW3Z2PkfmrajpeGlE+T25b1x1Z02DGJz2E2TBeEzTztzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wHXZUe2400pAMvxjYhiCnoAMQr1LqPQdHKf31NXHHo=;
 b=t912IPc6VAYhezitSIrLgsnvFUQT+6Co4Mj27IZ5EihKezVyu8JFmrydsIrdNx4OPxk3SvY9n3K3vpNld9phujZN/h65MShbrf0lrwVmumS7FMKnRopwS0V9uT0d1a8vq2TMm6K0GfMkRf3gLQO0PLXlKvHhSVlTzreuM0DVcOc=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by CH3PR10MB7931.namprd10.prod.outlook.com (2603:10b6:610:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:52:12 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::ce) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 12:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 12:52:10 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 06:52:10 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 06:52:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 06:52:09 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LCq4Tk3024117;
	Wed, 21 Jan 2026 06:52:04 -0600
Message-ID: <e36b0352-9167-41de-b63d-ed255cc5c4ba@ti.com>
Date: Wed, 21 Jan 2026 18:22:03 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add Frame Preemption
 MAC Merge support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <afd@ti.com>, <pmohan@couthit.com>,
	<basharath@couthit.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-2-m-malladi@ti.com>
 <20260112175029.hgjpxwmysjg5ypne@skbuf>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260112175029.hgjpxwmysjg5ypne@skbuf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|CH3PR10MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: f5052b5d-e7e0-49db-b1a7-08de58ebe494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjdlV2d2STVWMHFPVjRodUlERytKRnN5MEgyaW5COU1RMUlXVnhNMHB2Nk5F?=
 =?utf-8?B?RTRQbEZoSk1PU3lNMS9WaHUvbm9maWlYWDJZalJJNXZDWHFidmozT2J2dXNn?=
 =?utf-8?B?VjFFR09MZkFGNGtsdmNiUXM3WEZ2MElHWFJnbHUyczJ5OC84Zmx0SXVlUmJP?=
 =?utf-8?B?VGM2NFovT1p3ZlRwMXYyL0FVc0ZNalN1a3dObTBTQVUxRFRZUXY0T1hQUEtk?=
 =?utf-8?B?QnFrUTR2d3BLOXljZHVhNTNBRlA1aHhWb0sraVRnbExDOE1PWWNtMkE3L0Zz?=
 =?utf-8?B?WGY5QmxQQTNPQko4eTRDeG5lcHdoMEI2TXZVdEkyYVB1eENHeURQSnYxdU13?=
 =?utf-8?B?Y0g2K21YSWlCOUxGdklXRG1IMlZTTXhlM2kvUjQ4MW81YjFXKy9DVVFGVHJJ?=
 =?utf-8?B?bGdabTI3Z3NpTjJXaGxQd3JvNW0ydlNLRGpJWG8zTTNrUDFkMWxMY01peXVO?=
 =?utf-8?B?cURreVBHQ0RLNkhRTnFCZ3I2QzNGaFdoSEN0VWd6VXF3Rk90Zlg5bzdIU25z?=
 =?utf-8?B?eWhMYnFuSVlOT3NscEFaekJWaTJTS1NDdGFPd2FYYWZ1MUM0OTlwVWxFazhr?=
 =?utf-8?B?ei9md1U2dGxpV1JNVWR5T2NzTlBzb1BUNWxiaEUxWmp4aEc3K1pQNmN5ZUkw?=
 =?utf-8?B?NjF0SFVnNm9sVVI2RHJWQzh5ZDNpRDU3UVp0cTlkMFdXcStMSEROYWQ5aVBX?=
 =?utf-8?B?bEpmdTMwNGRZNVgxUVEzNWlObHBSNVRDc1FqK0lvQmJSbTFrTlZ5dlRHMEFy?=
 =?utf-8?B?ek8wY3JMdzhUekczQjIwRm9qUGFRZ3lBV0lEMnhoM0ZlczFRWVdvSW42SFNE?=
 =?utf-8?B?QmV6K1BhbU9ScnN3SFZhS2YxR1V1YnNKZ1NSS1duazF5aHlNeEFyTmNkLzc2?=
 =?utf-8?B?V2xYdTlHdWNDa3JRazlxQ3RFWkpqUk0rd1cvbjg4QjNEQkhxRWE2MHI3Mm9j?=
 =?utf-8?B?MjREVHRRd3V0M1B0MkcyQ3I4RDI0byt0bzYrRmp3N3JXcWsvMEVSMi80cTlk?=
 =?utf-8?B?bFllRE02YlUvZjZBNmJIekZXemc4WXRSQjNQb0pxcjc1WWhSeVd0VUtvY3NR?=
 =?utf-8?B?V1dqR0dMb3BTcGpZb3FBek4xVWt5dDI4bDZTeTRyUVloWW1XZnhNcWhkWk1R?=
 =?utf-8?B?eTd2Q3J2cWpBN3dpZzB5VHFJRUdCMTVEZjQvWGxXQlAwVzJDRi9RNzVXRDJv?=
 =?utf-8?B?QlNYOFkvV1JOUVJaRG9NUFF5TkZnbExBS3JXb1JuUE1ja2p1K1lpTUw1VWdG?=
 =?utf-8?B?RStRZ0RCTTVCYjdkS0ZwMENuazh0WWJEazMrVFlhL3gvYjUzTU5CcXhSbmQw?=
 =?utf-8?B?UDJub3B3ZDRlbFBKUWVrR2lhTVF2eXNTaXk5eVBxd0hocXRrY3JEOXJXMDNh?=
 =?utf-8?B?NzJJQXJsYkRxcFRxL2tMdFFZc1BNVkdnNFI4Q21nUUpYWSs0cW55RmJiZFhO?=
 =?utf-8?B?VkVEV1BlY25LbWlpcFc2QS91SEFhcWQvdDU2UkljZldtdE1FcEozU2dmWWFj?=
 =?utf-8?B?WWxzejVFWURzK2VYYlJaWGhIVmhMQVJUcTBrUXkybTNyeGs0eUtIeHk2c3hJ?=
 =?utf-8?B?Z0IrZ3dKUVo3M28yMVNCOWdnNHV0bEVFVEhWbzBMRFJLU1pyQUFaNjVPSENj?=
 =?utf-8?B?S2p0NU1aT0F2YmI1bEVESmZmSVZxanFjY0dxVmRHV0I4QmttRE90aStYUWsx?=
 =?utf-8?B?OHVSWWlpc3VwVVAzUzcvWG9RVGJmeHpVejgvTUU5MzRwaldNV3ZCR3Q4dTly?=
 =?utf-8?B?dUVodnVSTFdHN25oajN2cmFtaHkwMGltczR2ZUwrQ2FMOEdZOGphYW9kRkI4?=
 =?utf-8?B?WmxnZldLaDZPNTNVNy9HSkJCcm96QVdPd042cGhlbHlDUS9tc3pRUnlIL2Zh?=
 =?utf-8?B?ZmN0S2tJaUlLTkRDQ3dOTVBteU9PVGREZHVyRllyWDBCR0VWUzNhN3cxQTht?=
 =?utf-8?B?dC9McnVGd29DVDF4RWdJSXRNczJzR2VkWVE5Z3drTFpqR2ZuZlRHNmt4Z0lx?=
 =?utf-8?B?OXBIaVBVSUlKckRSUkt3QVpKN3pSZ0M3VUtiVnhINE10a3g2RTV2N0YrLzIz?=
 =?utf-8?B?Vll4MlByUHdZWWtqVWI5MG1YV0dKVXpkSit4NCtjdS9TM0d6NUpJdlBqNnVk?=
 =?utf-8?B?ZGV3OXhVWTJVcXV1LzlRZkJtTVZ3Ujg5YVh5NHNxVlU4Y1NkNVlFMGxlU3Zj?=
 =?utf-8?B?aEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:52:10.7124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5052b5d-e7e0-49db-b1a7-08de58ebe494
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7931
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim,ti.com:mid,ti.com:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EF25057493
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vladimir,

On 1/12/26 23:20, Vladimir Oltean wrote:
> Hi Meghana,
> 
> On Wed, Jan 07, 2026 at 06:21:10PM +0530, Meghana Malladi wrote:
>> This patch adds utility functions to configure firmware to enable
>> IET FPE. The highest priority queue is marked as Express queue and
>> lower priority queues as pre-emptable, as the default configuration
>> which will be overwritten by the mqprio tc mask passed by tc qdisc.
>> Driver optionally allow configure the Verify state machine in the
>> firmware to check remote peer capability. If remote fails to respond
>> to Verify command, then FPE is disabled by firmware and TX FPE active
> 
> "If remote fails to respond to Verify command, then FPE is disabled by
> firmware" -> please clarify that. There is also a question on the code
> about this.

Sure, I will elaborate this more.

> 
>> status is disabled.
>>
>> This also adds the necessary hooks to enable IET/FPE feature in ICSSG
>> driver. IET/FPE gets configured when Link is up and gets disabled when link
>> goes down or device is stopped.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>   drivers/net/ethernet/ti/Makefile             |   2 +-
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c |   9 +
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
>>   drivers/net/ethernet/ti/icssg/icssg_qos.c    | 319 +++++++++++++++++++
>>   drivers/net/ethernet/ti/icssg/icssg_qos.h    |  48 +++
>>   5 files changed, 379 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>>   create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
>>
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index 93c0a4d0e33a..2f588663fdf0 100644
>> --- a/drivers/net/ethernet/ti/Makefile
>> +++ b/drivers/net/ethernet/ti/Makefile
>> @@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
>>   obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
>>   
>>   obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
>> -icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
>> +icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
>>   
>>   obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
>>   icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index f65041662173..668177eba3f8 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -378,6 +378,12 @@ static void emac_adjust_link(struct net_device *ndev)
>>   		} else {
>>   			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>>   		}
>> +
>> +		if (emac->link) {
>> +			icssg_qos_link_up(ndev);
>> +		} else {
>> +			icssg_qos_link_down(ndev);
>> +		}
>>   	}
>>   
>>   	if (emac->link) {
>> @@ -967,6 +973,8 @@ static int emac_ndo_open(struct net_device *ndev)
>>   	if (ret)
>>   		goto destroy_rxq;
>>   
>> +	icssg_qos_init(ndev);
>> +
>>   	/* start PHY */
>>   	phy_start(ndev->phydev);
>>   
>> @@ -1421,6 +1429,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>   	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
>>   	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
>>   	.ndo_xsk_wakeup = prueth_xsk_wakeup,
>> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>>   };
>>   
>>   static int prueth_netdev_init(struct prueth *prueth,
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index 10eadd356650..7a586038adf8 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -44,6 +44,7 @@
>>   #include "icssg_config.h"
>>   #include "icss_iep.h"
>>   #include "icssg_switch_map.h"
>> +#include "icssg_qos.h"
>>   
>>   #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>>   #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
>> @@ -255,6 +256,7 @@ struct prueth_emac {
>>   	struct bpf_prog *xdp_prog;
>>   	struct xdp_attachment_info xdpi;
>>   	int xsk_qid;
>> +	struct prueth_qos qos;
>>   };
>>   
>>   /* The buf includes headroom compatible with both skb and xdpf */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>> new file mode 100644
>> index 000000000000..858268740dae
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>> @@ -0,0 +1,319 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Texas Instruments ICSSG PRUETH QoS submodule
>> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#include "icssg_prueth.h"
>> +#include "icssg_switch_map.h"
>> +
>> +static int icssg_prueth_iet_fpe_enable(struct prueth_emac *emac);
>> +static void icssg_prueth_iet_fpe_disable(struct prueth_qos_iet *iet);
>> +static void icssg_qos_enable_ietfpe(struct work_struct *work);
> 
> Please order functions such as to avoid forward declarations.
> 

Sure, I will fix this.

>> +
>> +void icssg_qos_init(struct net_device *ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth_qos_iet *iet = &emac->qos.iet;
>> +
>> +	if (!iet->fpe_configured)
>> +		return;
> 
> Bug:
> 
> if you open (ip link set ... up) the interface first, emac_ndo_open() ->
> icssg_qos_init() will run, and will find iet->fpe_configured false,
> exiting early.
> 
> Then you run ethtool --set-mm ... tx-enabled on, which sets
> iet->fpe_configured = true.
> 
> Then you insert a cable and icssg_qos_link_up() -> icssg_prueth_iet_fpe_enable()
> runs, which calls schedule_work(&iet->fpe_config_task). But you've never
> called INIT_WORK() on this structure, so the kernel will oops.
> 

Yes that's true. Thanks for catching it. I wasn't able to reproduce this 
because I always bring down my interface, call ethtool --set-mm and only 
then bring up the interface again. So during ndo_open() it always calls 
INIT_WORK(). I will fix this in v2.

>> +
>> +	/* Init work queue for IET MAC verify process */
>> +	iet->emac = emac;
>> +	INIT_WORK(&iet->fpe_config_task, icssg_qos_enable_ietfpe);
>> +	init_completion(&iet->fpe_config_compl);
>> +
>> +	/* As worker may be sleeping, check this flag to abort
>> +	 * as soon as it comes of out of sleep and cancel the
>> +	 * fpe config task.
>> +	 */
>> +	atomic_set(&iet->cancel_fpe_config, 0);
>> +}
>> +
>> +static void icssg_iet_set_preempt_mask(struct prueth_emac *emac, u8 preemptible_tcs)
>> +{
>> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
>> +	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
>> +	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
>> +	u8 tc;
>> +	int i;
>> +
>> +	/* Configure highest queue as express. Set Bit 4 for FPE,
>> +	 * Reset for express
>> +	 */
> 
> I wasn't able to parse the code below, I just got stuck on this comment.
> Why configure just the highest queue as express, rather than all queues
> as express?
> 
> What is the current default behaviour in mainline, and does this
> constitute a change of that behaviour?
> 

This code was the existing design in our TI kernel, on top of which I 
made some additional changes. Now that I think about it, this 
configuration is redundant. If user doesn't request anything all queues 
should be express, and that is the case with the all the queues 
out-of-box. So all I need to do will be to check what user is expecting 
and configure the queues accordingly.

>> +
>> +	/* first set all 8 queues as Preemptive */
>> +	for (i = 0; i < PRUETH_MAX_TX_QUEUES * PRUETH_NUM_MACS; i++)
> 
> What is the purpose of PRUETH_NUM_MACS here? Is the FPE configuration of
> PRUETH_MAC0 not independent of that of PRUETH_MAC1?

You are right. This function gets called per emac and should be 
independent of the other emacs. I will drop this as this is not required 
in the first place.

> 
>> +		writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
>> +
>> +	/* set highest priority channel queue as express as default configuration */
>> +	writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + emac->tx_ch_num - 1);
>> +
>> +	/* set up queue mask for FPE. 1 means express */
>> +	writeb(BIT(emac->tx_ch_num - 1), config + EXPRESS_PRE_EMPTIVE_Q_MASK);
>> +
>> +	/* Overwrite the express queue mapping based on the tc map set by the user */
>> +	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
>> +		/* check if the tc is express or not */
>> +		if (!(p_mqprio->preemptible_tcs & BIT(tc))) {
>> +			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
>> +				/* Set all the queues in this tc as express queues */
>> +				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
>> +				writeb(BIT(i), config + EXPRESS_PRE_EMPTIVE_Q_MASK);
>> +			}
>> +		}
>> +		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
>> +	}
>> +}
>> +
>> +static int prueth_mqprio_validate(struct net_device *ndev,
>> +				  struct tc_mqprio_qopt_offload *mqprio)
>> +{
>> +	int num_tc = mqprio->qopt.num_tc;
>> +	int queue_count = 0;
>> +	int i;
>> +
>> +	/* Always start tc-queue mapping from queue 0 */
>> +	if (mqprio->qopt.offset[0] != 0)
>> +		return -EINVAL;
>> +
>> +	/* Check for valid number of traffic classes */
>> +	if (num_tc < 1 || num_tc > PRUETH_MAX_TX_QUEUES)
>> +		return -EINVAL;
>> +
>> +	/* Only channel mode is supported */
>> +	if (mqprio->mode != TC_MQPRIO_MODE_CHANNEL) {
>> +		netdev_err(ndev, "Unsupported mode: %d\n", mqprio->mode);
> 
> struct tc_mqprio_qopt_offload has an extack argument. Please use
> NL_SET_EXT_MSG_MOD(extack) instead of netdev_err() here and below.
> 

Sure, will update it as part of v2.

>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < num_tc; i++) {
>> +		if (!mqprio->qopt.count[i]) {
>> +			netdev_err(ndev, "TC %d has zero size queue count: %d\n",
>> +				   i, mqprio->qopt.count[i]);
>> +			return -EINVAL;
>> +		}
> 
> You set caps->validate_queue_counts = true, which is laudable. But did
> you also look at what mqprio_validate_queue_counts() does? Do you need
> to duplicate it here?

Honestly, I simply set this to true looking at other drivers, with no 
background on what this does, which I shouldn't have done :)
But now that I looked into mqprio_validate_queue_counts(), and I will 
remove the code inside prueth_mqprio_validate() whatever is getting 
duplicated.

> 
>> +		if (mqprio->min_rate[i] || mqprio->max_rate[i]) {
>> +			netdev_err(ndev, "Min/Max tx rate is not supported\n");
>> +			return -EINVAL;
>> +		}
>> +		if (mqprio->qopt.offset[i] != queue_count) {
>> +			netdev_err(ndev, "Discontinuous queues config is not supported\n");
>> +			return -EINVAL;
>> +		}
>> +		queue_count += mqprio->qopt.count[i];
>> +	}
>> +
>> +	if (queue_count > PRUETH_MAX_TX_QUEUES) {
>> +		netdev_err(ndev, "Total queues %d exceed max %d\n",
>> +			   queue_count, PRUETH_MAX_TX_QUEUES);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
>> +{
>> +	struct tc_query_caps_base *base = type_data;
>> +
>> +	switch (base->type) {
>> +	case TC_SETUP_QDISC_MQPRIO: {
>> +		struct tc_mqprio_caps *caps = base->caps;
>> +
>> +		caps->validate_queue_counts = true;
>> +		return 0;
>> +	}
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
>> +{
>> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth_qos_mqprio *p_mqprio;
>> +	int ret;
>> +
>> +	if (mqprio->qopt.hw == TC_MQPRIO_HW_OFFLOAD_TCS)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!mqprio->qopt.num_tc) {
>> +		netdev_reset_tc(ndev);
>> +		p_mqprio->preemptible_tcs = 0;
>> +		return 0;
>> +	}
>> +
>> +	ret = prueth_mqprio_validate(ndev, mqprio);
>> +	if (ret)
>> +		return ret;
>> +
>> +	p_mqprio = &emac->qos.mqprio;
>> +	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
>> +	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
>> +
>> +	return 0;
>> +}
>> +
>> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>> +			   void *type_data)
>> +{
>> +	switch (type) {
>> +	case TC_QUERY_CAPS:
>> +		return emac_tc_query_caps(ndev, type_data);
>> +	case TC_SETUP_QDISC_MQPRIO:
>> +		return emac_tc_setup_mqprio(ndev, type_data);
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
>> +
>> +void icssg_qos_link_up(struct net_device *ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth_qos_iet *iet = &emac->qos.iet;
>> +
>> +	if (!iet->fpe_configured)
>> +		return;
>> +
>> +	icssg_prueth_iet_fpe_enable(emac);
>> +}
>> +
>> +void icssg_qos_link_down(struct net_device *ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth_qos_iet *iet = &emac->qos.iet;
>> +
>> +	if (iet->fpe_configured)
>> +		icssg_prueth_iet_fpe_disable(iet);
>> +}
>> +
>> +static int icssg_config_ietfpe(struct prueth_qos_iet *iet, bool enable)
>> +{
>> +	void __iomem *config = iet->emac->dram.va + ICSSG_CONFIG_OFFSET;
>> +	struct prueth_qos_mqprio *p_mqprio =  &iet->emac->qos.mqprio;
>> +	int ret;
>> +	u8 val;
>> +
>> +	/* If FPE is to be enabled, first configure MAC Verify state
>> +	 * machine in firmware as firmware kicks the Verify process
>> +	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
>> +	 * received.
>> +	 */
>> +	if (enable && iet->mac_verify_configured) {
>> +		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
> 
> When mac_verify_configured transitions from true to false, who disables
> the feature in firmware? Or do you have to reboot the board?
> 

The driver doesn't need to explicitly disable PRE_EMPTION_ENABLE_VERIFY. 
The firmware handles the cleanup after successful mac verification.

>> +		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
>> +		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
>> +	}
>> +
>> +	/* Send command to enable FPE Tx side. Rx is always enabled */
>> +	ret = icssg_set_port_state(iet->emac,
>> +				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
>> +					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
>> +	if (ret) {
>> +		netdev_err(iet->emac->ndev, "TX preempt %s command failed\n",
>> +			   str_enable_disable(enable));
>> +		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
>> +		return ret;
>> +	}
>> +
>> +	/* Update FPE Tx enable bit. Assume firmware use this bit
>> +	 * and enable PRE_EMPTION_ACTIVE_TX if everything looks
>> +	 * good at firmware
>> +	 */
>> +	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
>> +
>> +	if (enable && iet->mac_verify_configured) {
>> +		ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS, val,
>> +					 (val == ICSSG_IETFPE_STATE_SUCCEEDED),
>> +					 USEC_PER_MSEC, 5 * USEC_PER_SEC);
>> +		if (ret) {
>> +			netdev_err(iet->emac->ndev,
>> +				   "timeout for MAC Verify: status %x\n",
>> +				   val);
>> +			return ret;
>> +		}
>> +	} else {
>> +		/* Give f/w some time to update PRE_EMPTION_ACTIVE_TX state */
>> +		usleep_range(100, 200);
>> +	}
>> +
>> +	if (enable) {
>> +		val = readb(config + PRE_EMPTION_ACTIVE_TX);
>> +		if (val != 1) {
>> +			netdev_err(iet->emac->ndev,
>> +				   "F/w fails to activate IET/FPE\n");
>> +			writeb(0, config + PRE_EMPTION_ENABLE_TX);
> 
> Why do you write 0 to PRE_EMPTION_ENABLE_TX here? You previously said
> that "FPE is disabled by firmware" which I suppose translates into the
> same (incorrect) thing? Is it disabled by firmware, or by the driver, or
> by both?
> 

Yes FPE is disabled by firmware if MAC verify fails. But let's say 
verify is successful but firmware couldn't transition ACTIVE to true by 
the time we are reading PRE_EMPTION_ACTIVE_TX, we will assume firmware 
failed to activate FPE, but firmware might be taking time and eventually 
activate FPE. But since timeout happened w.r.t driver we manually 
disable FPE from the driver so that driver and firmware are on the same 
page.

> When FPE is enabled with verification, but the link partner does not
> respond, the ENABLED status remains, but the ACTIVE status never
> transitions to true. It is documented that preemptible traffic should
> only be sent based on the ACTIVE status, not the ENABLED one. So, I
> don't think this is necessary at all.
> 
>> +			return -ENODEV;
>> +		}
>> +	} else {
>> +		return 0;
>> +	}
>> +
>> +	icssg_iet_set_preempt_mask(iet->emac, p_mqprio->preemptible_tcs);
>> +
>> +	iet->fpe_enabled = true;
> 
> iet->fpe_enabled is set to true here and never to false. It tracks no
> useful information, other than "was icssg_config_ietfpe() ever called
> for this interface with enable=true?". You assign that result to
> state->tx_enabled in emac_get_mm(), which is obviously wrong because
> this variable does not track that information.  For example, if you call
> icssg_config_ietfpe() with enable=false, FPE should be enabled, and
> emac_get_mm() should reflect that.
> 

Yeah I get your point, if fpe ever gets disabled no one tracking that 
ans returning incorrect status. Will fix it, thanks. I think there 
should be two flags fpe_enabled (which tracks if user has requested to 
enable/disable fpe) and fpe_active (which tracks if fpe is enabled by 
the driver and is operational)

>> +
>> +	return ret;
>> +}
>> +
>> +static void icssg_qos_enable_ietfpe(struct work_struct *work)
>> +{
>> +	struct prueth_qos_iet *iet =
>> +		container_of(work, struct prueth_qos_iet, fpe_config_task);
>> +	int ret;
>> +
>> +	/* Set the required flag and send a command to ICSSG firmware to
>> +	 * enable FPE and start MAC verify
>> +	 */
>> +	ret = icssg_config_ietfpe(iet, true);
>> +
>> +	/* if verify configured, poll for the status and complete.
>> +	 * Or just do completion
>> +	 */
>> +	if (!ret)
>> +		netdev_err(iet->emac->ndev, "IET FPE configured successfully\n");
>> +	else
>> +		netdev_err(iet->emac->ndev, "IET FPE config error\n");
>> +	complete(&iet->fpe_config_compl);
>> +}
>> +
>> +static void icssg_prueth_iet_fpe_disable(struct prueth_qos_iet *iet)
>> +{
>> +	int ret;
>> +
>> +	atomic_set(&iet->cancel_fpe_config, 1);
>> +	cancel_work_sync(&iet->fpe_config_task);
>> +	ret = icssg_config_ietfpe(iet, false);
>> +	if (!ret)
>> +		netdev_err(iet->emac->ndev, "IET FPE disabled successfully\n");
>> +	else
>> +		netdev_err(iet->emac->ndev, "IET FPE disable failed\n");
>> +}
>> +
>> +static int icssg_prueth_iet_fpe_enable(struct prueth_emac *emac)
>> +{
>> +	struct prueth_qos_iet *iet = &emac->qos.iet;
>> +	int ret;
>> +
>> +	/* Schedule MAC Verify and enable IET FPE if configured */
>> +	atomic_set(&iet->cancel_fpe_config, 0);
>> +	reinit_completion(&iet->fpe_config_compl);
>> +	schedule_work(&iet->fpe_config_task);
>> +	/* By trial, found it takes about 1.5s. So
>> +	 * wait for 10s
>> +	 */
>> +	ret = wait_for_completion_timeout(&iet->fpe_config_compl,
>> +					  msecs_to_jiffies(10000));
> 
> Why schedule async work (&iet->fpe_config_task) then immediately wait
> for it to finish? Isn't that an extremely roundabout way of just running
> the contents of the task directly?
> 
> Also, I think you are blocking the system_power_efficient_wq (which
> phy_queue_state_machine() -> .. -> emac_adjust_link() runs on) for up to
> 10 seconds at a time, and nothing else can run while you are waiting for
> the FPE verification completion.
> 
> Why exactly do you need to wait for icssg_prueth_iet_fpe_enable() to
> finish here?
> 

Ok, I wasn't aware that I am scheduling work onto 
system_power_efficient_wq (he same WQ used by phy_queue_state_machine -> 
emac_adjust_link), indirectly blocking other works queued in that WQ for 
10 secs, which I believe is a bad design.

I was waiting inside icssg_prueth_iet_fpe_enable() because whatever FPE 
configuration has been requested by the driver needs to be serviced by 
the firmware and will take sometime assuming firmware is alive and is 
able to take the requests from the driver.

I think better design would be to make it truly asynchronous (simply 
schedule the work, not wait and return immediately), since the caller 
doesn't strictly need the operation to finish.

>> +	if (!ret) {
>> +		netdev_err(emac->ndev,
>> +			   "IET verify completion timeout\n");
>> +		/* cancel verify in progress */
>> +		atomic_set(&iet->cancel_fpe_config, 1);
>> +		cancel_work_sync(&iet->fpe_config_task);
>> +	}
>> +
>> +	return ret;
>> +}
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
>> new file mode 100644
>> index 000000000000..3d3f42107dd7
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#ifndef __NET_TI_ICSSG_QOS_H
>> +#define __NET_TI_ICSSG_QOS_H
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/netdevice.h>
>> +#include <net/pkt_sched.h>
>> +
>> +struct prueth_qos_mqprio {
>> +	struct tc_mqprio_qopt_offload mqprio;
>> +	u8 preemptible_tcs;
>> +};
>> +
>> +struct prueth_qos_iet {
>> +	struct work_struct fpe_config_task;
>> +	struct completion fpe_config_compl;
>> +	struct prueth_emac *emac;
>> +	atomic_t cancel_fpe_config;
> 
> This variable has no reader.
> 

Yes, will fix it.

>> +	/* Set through priv flags to enable IET frame preemption */
> 
> These comments referencing priv flags might be obsolete. At least in the
> mainline submission there is no netdev priv flag involved.
> 

Ok, I will drop mentioning priv flags in the comments.

>> +	bool fpe_configured;
>> +	/* Set through priv flags to enable IET MAC Verify state machine
>> +	 * in firmware
>> +	 */
>> +	bool mac_verify_configured;
>> +	/* Min TX fragment size, set via ethtool */
>> +	u32 tx_min_frag_size;
>> +	/* wait time between verification attempts in ms (according to clause
>> +	 * 30.14.1.6 aMACMergeVerifyTime), set via ethtool
>> +	 */
>> +	u32 verify_time_ms;
>> +	/* Set if IET FPE is active */
>> +	bool fpe_enabled;
> 
> "enabled" and "active" have quite distinct meanings if you read
> Documentation/networking/ethtool-netlink.rst (ETHTOOL_A_MM_TX_ENABLED vs
> ETHTOOL_A_MM_TX_ACTIVE) as well as the standard. The fact that this
> comment explain that "fpe_enabled" tracks the "active" status makes
> things clear as mud.

Makes sense. I will update fpe_configured to fpe_enabled (IET is 
enabled, which can be inactive if verification failed) and fpe_enabled 
to fpe_active (IET is operationally enabled i.e., verification is either 
successful or disabled).

> 
>> +};
>> +
>> +struct prueth_qos {
>> +	struct prueth_qos_iet iet;
>> +	struct prueth_qos_mqprio mqprio;
>> +};
>> +
>> +void icssg_qos_init(struct net_device *ndev);
>> +void icssg_qos_link_up(struct net_device *ndev);
>> +void icssg_qos_link_down(struct net_device *ndev);
>> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>> +			   void *type_data);
>> +#endif /* __NET_TI_ICSSG_QOS_H */
>> -- 
>> 2.43.0
>>


