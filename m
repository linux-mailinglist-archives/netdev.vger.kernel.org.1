Return-Path: <netdev+bounces-254252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JzvCO0JemkK2AEAu9opvQ
	(envelope-from <netdev+bounces-254252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8310A1D0C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E233041BED
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBDB350D79;
	Wed, 28 Jan 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nir8M32M"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902F350A21;
	Wed, 28 Jan 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605356; cv=fail; b=J3ApO2YEsMa19OR+D4JnqO19YFxiPmpEW3XzhQB4eAOpzuFQIoe7m94VXvzn6D3jco2G/l14avLmy3wRGA2O2d47mPUcaw8PsIB1KjZcOf9izlzT+0w3y38xJWQxFNkjc2A5AvtqiGt9M6A3efmcYFBlQg1nxDGcHyhcAfyou0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605356; c=relaxed/simple;
	bh=9I3mH1dxML8zHhRwOBaZurPjjUVQklI58MFHjrGeVXI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=qFeyugbBU2v9YFwEptSgDlTxqMHiJOym36H++JJrTOAfGHoLRQBcjrZeLmGYznQ5xkjsrH6rGZqUTWCRkVRb445vDNzIH/+v/VWK+DVnBOCy1vFtLHoj2hhqzb9p5bMq6hltcia9SlNMj0Nl5LOp6O9O1lTl2FDXRH8IUZWQGQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Nir8M32M; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZRaYHRS2+DF93gv3A/J46u+7eLMp/ZBFUg92IJJuAy/FQzZCzKLZ5R10kU99nZ30eS3I3VAdq/PIcWIU+EEIbmW/gvLT0+h/pBSGouq08ln3EWPh/UqQPnBxybNWel70W0d9+4lhdQ/bPq35b0IawP98lgVbM+loTUZQDlq9GPnGsvpB1estDrYEFGaNWDul3qzV9KDDlENFhqaAlRva2MuxCWkBbDNOV9pzqZMs/LN1d1XTi/sNAxFvGoUWUty0uV+kveULD2s12LSgqn0a4RF30hKxtICVk02NNBVtPVQTZBIEXaM8L9fXlx/621SEfZGfO+dSjAKq4sgfcVMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl0cKyUguUytD7r7DkTYX4vu8LRXpAp/piQBiQ4SDx0=;
 b=XxdSn0tFOKoJMWVOJ3fuDMMh43Q/YvviT38Oa1Bv/hBiyNdI9D8oD/UX2KtnDoqtmZqgNpHTlRxcqPm/Eet34USLjBBSMgAWvFbp0LYSIqDEJPnHLBm4sTHS3ndqySMMYtDEZvpZNfrYYlNCB8di3e4+v/f8ZaE2OW4yWGijnNBkLuOksfXYgrxcgCjX784qOJ8Gds8X/XnoMjn0c9UImtAEoIWahTRQ77PhTu0beT5OM9mlbk6XQ9IvVsQCU41tN94lBBPuOdUgIBe+pNnC46DV8iIlmPz0EaQ4i+/Hms7ks1kkziWtsRMrLYEMVzbUmeJcojSLquB5OIs6oVEulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl0cKyUguUytD7r7DkTYX4vu8LRXpAp/piQBiQ4SDx0=;
 b=Nir8M32MGK2GHvHtpQr1po3EnGF/Lo4gnV+iuX/SvkenGOinlo6zzamK3CqcI3q2q+FbnaIF5jfgH1T/YNxExtCUaSgLdU2rM3vNPwlJSqAW5TIaLAgkE59jeWRUJ41ozWSGqH7VxD2GczJf/aII2LhgEsyaVcMR4r5pc5yq+iw=
Received: from MN2PR01CA0033.prod.exchangelabs.com (2603:10b6:208:10c::46) by
 IA4PR10MB8253.namprd10.prod.outlook.com (2603:10b6:208:561::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Wed, 28 Jan 2026 13:02:29 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::56) by MN2PR01CA0033.outlook.office365.com
 (2603:10b6:208:10c::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 13:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 13:02:27 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 07:02:11 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 07:02:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 07:02:11 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60SD26iC1995379;
	Wed, 28 Jan 2026 07:02:07 -0600
Message-ID: <931bb43b-fbba-4423-9a20-122602b3b630@ti.com>
Date: Wed, 28 Jan 2026 18:32:05 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Malladi, Meghana" <m-malladi@ti.com>
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool ops for
 Frame Preemption MAC Merge
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
 <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
 <20260112181436.4s5ceywwembn674r@skbuf>
Content-Language: en-US
In-Reply-To: <20260112181436.4s5ceywwembn674r@skbuf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|IA4PR10MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 0457695a-60cc-43fc-a03b-08de5e6d7d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEdhaWYyUFQvcVlrUUxFTFlQYml5aHFuK2cvVWtZeDFqa0tZbGNSNkxiVDlC?=
 =?utf-8?B?Zzh5bmMvQ1BXOWFKV1hlcHBScmwzUnJnVW8zdkFneGZlZDFJYU5ZNTVRMmJH?=
 =?utf-8?B?WHdyOHNhU2ZPR29FSmk0YTNHTjNBMHZWQjZZNHhGdnhoa1l6dzlyMCtzYm1a?=
 =?utf-8?B?NVNCYk1YUGszTzFsTHlzai9KaXhPMkRrS2hZS0J3WmFoUjFtZVo5Zm51VmIr?=
 =?utf-8?B?SlJTWno0ZHpiVGM4VTAwcWhsZ0lxS3hBZlUrSjAvaDJYekFsZ01WMGhtNGlQ?=
 =?utf-8?B?T0JLTlZXMllZNGYzS3pydTFPZG03OVNUTWo5d0JQTGx2STZSODBqaHVoSW10?=
 =?utf-8?B?aThHUC81bkpBWjZMVVBkYW9Ob1NXWGo4Ri9sU3g3aGVTZGFsVDNYYlNQNlM2?=
 =?utf-8?B?ME0vNUsvTVFtZ21JeWkvWWtrNU9XT1BHTWVSRkptUzBhWXlzd2x1UmFMbFpy?=
 =?utf-8?B?TkJTZkpLVWF3TmcvNENmZ0R4TURzREFKc0N6WGk0ZVcyeUJ4N1FlYW9ZaDdv?=
 =?utf-8?B?aTM2UDFSUnJtZ3BqZnY3bmxtNGdkNC9EVjVCTEVBdUh0Ylg4YmJZdis3eXhz?=
 =?utf-8?B?cXJPYVljN0NoMEwzR0o5VGhreUZFVVZUamZqYnRDdzlzdGFXMGtPTXp3K3ZU?=
 =?utf-8?B?UGVGZmI2Y0wreGI4ekNkekR6Z1FPR3hpYlpwRzQ3VnZSOG15SzFCMXlrUTdq?=
 =?utf-8?B?ZzlDQVYzZkFZOS9oRFhWcllpSExBZWFHUjByWTk0REU5UGdWVWJFNGlHbXhr?=
 =?utf-8?B?cFAyMUV2SzBOcUY2cWZDck80NzNkdUdOYjFGMHJtR25JbWVLVnAzQUdtRFBF?=
 =?utf-8?B?N0RTaE5HNVJURXUwTEYrTld5MVBzQ2srdGFBQjZyc3I1S1RQejdxTXg3Sk5n?=
 =?utf-8?B?d0xIck1HZjhPd0hvVXViQUltM1FaS0pFSU9iMzBIaWJyS2s5WG1sU0VxV2Mv?=
 =?utf-8?B?ZlhqTEZaTFJOU0swWTU0NVhuYzFCOE1kcnRpMzU3dVRkUlZMaU9NT1pwRE9I?=
 =?utf-8?B?d2Z5UVh5YXQrV3JqWmQzWTlqTkpreS93U0d0d3kyMDlueW9YNFZsbDRHVmhj?=
 =?utf-8?B?M2dJRlVEYUJSOE9BV2F3RTRqRVF6QyszcXU2U2E0UVZTQWRBY0lENjBVaHEv?=
 =?utf-8?B?cGVSNS9OQU53Yjdoam9FMDNrNnZUU1JUT2JkR0U1b0ZUck1vbU0rVUI5T2Yy?=
 =?utf-8?B?dExoNlZpa0pld2xrWGNRTVlXN3NQRkZmSUpoY1YvZjB1Z2taNGRjWm5aSjc3?=
 =?utf-8?B?aktzZTloQTZmejk5U0NxTld2L3djMFU5THNjbS9iS3RVamU3NXBZWU0yV25C?=
 =?utf-8?B?M29aTlJOOXp0T0lJMytYL3pmaUtTZGRhaFk0dHhaUU10czhqeUg3cE5wTHpC?=
 =?utf-8?B?eFhicG1VQk1HRkI4ODZHZFo2NnRjR2d0R3o4RUU5Y1NSWWtIZVBWb2VRYWNr?=
 =?utf-8?B?bHB0RUg5Q3NJUllFZEordisxKzYyQ2xtbEFoWjgrZ0o5SDZ4ZFBKdnViTUVP?=
 =?utf-8?B?eXA0LzhHZmtnZkhaeUh2aFJVbW9ONlFTb0w4a1FINSt6VUJnSmsxM005K1E1?=
 =?utf-8?B?NlpEMER0ZkJNVkhwbjhqN29pVnFuQWVodFVEWkF1QU1NRnp2ZXd5cTRrRktx?=
 =?utf-8?B?SFRBUFhNWUc3QTdvSzNPbkJrTlhNZGJUeVg0V0hQZ2owcmZOMnNPWXlUSGZQ?=
 =?utf-8?B?dGpkQmUzU0N1ZkFXaXVRMjZOeWt1NFY4a2gzUm44ejhmZWRIWSs3VFdPR1lC?=
 =?utf-8?B?T1VnQ01wR1dESGI4Rms2eFZKNXRGKzR5MEdnb3ZCM0RJV2xoL2lEZTNDZHRT?=
 =?utf-8?B?aWl3RHJIbFlkazdQZldKMHZNUHRnZm50ZkRWU2dXRWQ0ZlAxVW1jY04rVk1s?=
 =?utf-8?B?UTNEU25kL1NkQnRTcDkxd3dPaHJNb056Y3F0NkdrR0JrLzhDS25yUTRaY3JJ?=
 =?utf-8?B?THlsZjF4eFprczNMcTB4OWZzNGJlU1JVM2RxT0Iwb0FUd3pmNGt4S2dXTC9N?=
 =?utf-8?B?YzJqYkFidWJPN2xVaWpSL0tQenByS1BqKzdaZGhSeUlmTW44R2d3L0FwNW1H?=
 =?utf-8?B?TFk4YTdRMDhxdWZGalRQNmd4YVlkeWhlalZ6TWR6SVoxb2FJajZNYWhsSUgx?=
 =?utf-8?B?bXUyYXJuWWt5ODQrckJRMEJwS05jdnZnc0ZCS0Zvb0I4em0rc3JPMHVWa2lV?=
 =?utf-8?B?aFpCSGlBUDFFdXFNV0lxZTRIaWI0SjdFQU0veTI0YnVRUEJ1L0xnM2REVFI0?=
 =?utf-8?B?dVp2YmJwSjAzV0xnQmxJWDZMNEV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:02:27.8094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0457695a-60cc-43fc-a03b-08de5e6d7d44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8253
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-254252-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A8310A1D0C
X-Rspamd-Action: no action

Hi Vladimir,

On 1/12/2026 11:44 PM, Vladimir Oltean wrote:
> Hi Meghana,
> 
> On Wed, Jan 07, 2026 at 06:21:11PM +0530, Meghana Malladi wrote:
>> Add ethtool ops .get_mm, .set_mm and .get_mm_stats to enable / disable
>> Mac merge frame preemption and dump Preemption related statistics for
>> ICSSG driver. Add pa stats registers for mac merge related statistics,
>> which can be dumped using the ethtool ops.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>   drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 58 +++++++++++++++++++
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  2 +-
>>   drivers/net/ethernet/ti/icssg/icssg_stats.h   |  5 ++
>>   .../net/ethernet/ti/icssg/icssg_switch_map.h  |  5 ++
>>   4 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>> index b715af21d23a..ceca6d6ec0f4 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>> @@ -294,6 +294,61 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
>>   	return 0;
>>   }
>>   
>> +static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth_qos_iet *iet = &emac->qos.iet;
>> +	void __iomem *config;
>> +
>> +	config = emac->dram.va + ICSSG_CONFIG_OFFSET;
>> +
>> +	state->tx_enabled = iet->fpe_enabled;
> 
> I would expect state->tx_enabled to be returned from
> iet->fpe_configured, aka from the same variable in which tx_enabled was
> saved in emac_set_mm(). In case it's not clear, ethtool saves state in
> the device driver and expects that state to be later returned in the
> get() callback.

Ok got it, will fix it in v2. I am aware that ethtool saves state in the 
device driver which will be returned in the get() callback but didn't 
know that should be the case every time.

> 
>> +	state->pmac_enabled = true;
>> +	state->verify_status = readb(config + PRE_EMPTION_VERIFY_STATUS);
>> +	state->tx_min_frag_size = iet->tx_min_frag_size;
> 
> What is the range of acceptable values for PRE_EMPTION_ADD_FRAG_SIZE_LOCAL?
> Is it safe to accept this value with no sanitization, just the ethtool
> netlink policy which limits it between 60 and 252? Even if that is the
> case, please add a comment specifying what the valid range is.
> 

Sure, I will check and update in the comments.

>> +	state->rx_min_frag_size = 124;
> 
> Please add a comment justifying this non-standard value.
> 
>> +	state->tx_active = readb(config + PRE_EMPTION_ACTIVE_TX) ? true : false;
>> +	state->verify_enabled = readb(config + PRE_EMPTION_ENABLE_VERIFY) ? true : false;
>> +	state->verify_time = iet->verify_time_ms;
> 
> Why are some values returned from firmware and others from driver memory?

Sure, I will store all the values in the driver memory and return from 
them. But should that be the case all the time ?

> 
>> +
>> +	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
>> +	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
>> +	 */
>> +	state->max_verify_time = 128;
> 
> ETHTOOL_MM_MAX_VERIFY_TIME_MS

Ok, will update it.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>> +		       struct netlink_ext_ack *extack)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth_qos_iet *iet = &emac->qos.iet;
>> +
>> +	if (!cfg->pmac_enabled)
>> +		netdev_err(ndev, "preemptible MAC is always enabled");
> 
> missing \n, OR use NL_SET_ERR_MSG_MOD(extack) which doesn't need \n.
> Doing the latter is preferable, because the driver still accepts the
> command while not modifying its internal state, and ethtool prints the
> extack as warning if the return code was 0.
> The catch is that openlldp sets pmac_enabled=false on exit, and that
> would otherwise generate a noisy netdev_err() in your proposal (but
> would be silent with the extack):
> https://github.com/intel/openlldp/blob/master/lldp_8023.c#L443-L444
> 

Ok makes sense, thanks for pointing this out.

>> +
>> +	iet->verify_time_ms = cfg->verify_time;
>> +	iet->tx_min_frag_size = cfg->tx_min_frag_size;
>> +
>> +	iet->fpe_configured = cfg->tx_enabled;
>> +	iet->mac_verify_configured = cfg->verify_enabled;
> 
> Changes to the verification parameters should retrigger the verification
> state machine, even if the link did not flap. Also, changes to the
> ENABLED state should similarly be applied right away.

.set_mm() will return -EBUSY if the interfaces are up. So changes in 
verification parameters or ENABLED state can happen only when the 
interfaces are down. And when the interface goes up the IET task get 
scheduled re-triggering everything based on updated configurations.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void emac_get_mm_stats(struct net_device *ndev,
>> +			      struct ethtool_mm_stats *s)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +
>> +	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
>> +	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
>> +	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
>> +	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
>> +	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
>> +}
>> +
>>   const struct ethtool_ops icssg_ethtool_ops = {
>>   	.get_drvinfo = emac_get_drvinfo,
>>   	.get_msglevel = emac_get_msglevel,
>> @@ -317,5 +372,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
>>   	.set_eee = emac_set_eee,
>>   	.nway_reset = emac_nway_reset,
>>   	.get_rmon_stats = emac_get_rmon_stats,
>> +	.get_mm = emac_get_mm,
>> +	.set_mm = emac_set_mm,
>> +	.get_mm_stats = emac_get_mm_stats,
>>   };
>>   EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index 7a586038adf8..9c31574cc7f6 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -58,7 +58,7 @@
>>   
>>   #define ICSSG_MAX_RFLOWS	8	/* per slice */
>>   
>> -#define ICSSG_NUM_PA_STATS	32
>> +#define ICSSG_NUM_PA_STATS	37
> 
> Can't this be expressed as ARRAY_SIZE(icssg_all_pa_stats)? It is very
> fragile to have to count and update this manually.
> 

Yes I think its high time we did this. Will make this change in the next 
version.

>>   #define ICSSG_NUM_MIIG_STATS	60
>>   /* Number of ICSSG related stats */
>>   #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> index 5ec0b38e0c67..f35ae1b4f846 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> @@ -189,6 +189,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
>>   	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
>>   	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
>>   	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
>> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
>> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
>> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
>> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
>> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
>>   	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>>   	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>>   	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> index 7e053b8af3ec..855fd4ed0b3f 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> @@ -256,6 +256,11 @@
>>   #define FW_INF_DROP_PRIOTAGGED		0x0148
>>   #define FW_INF_DROP_NOTAG		0x0150
>>   #define FW_INF_DROP_NOTMEMBER		0x0158
>> +#define FW_PREEMPT_BAD_FRAG		0x0160
>> +#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
>> +#define FW_PREEMPT_FRAG_CNT_TX		0x0170
>> +#define FW_PREEMPT_ASSEMBLY_OK		0x0178
>> +#define FW_PREEMPT_FRAG_CNT_RX		0x0180
>>   #define FW_RX_EOF_SHORT_FRMERR		0x0188
>>   #define FW_RX_B0_DROP_EARLY_EOF		0x0190
>>   #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
>> -- 
>> 2.43.0
>>

-- 
Thanks,
Meghana Malladi


