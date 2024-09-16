Return-Path: <netdev+bounces-128487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D0979C9E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA11D1F231E0
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7910913BC1E;
	Mon, 16 Sep 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X9A0nHfH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A00522A;
	Mon, 16 Sep 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474596; cv=fail; b=l3knFfcGVrPIk9M577KqG19VcolgursDYflmrNiADpSOeFOc47TNpg29s8TulWxKQMM/G6tPrDjUNAchA5NIiYJxbLpC+sADqeuvJzOBPIxMhds6icMjuY77taszYpUIrEACmc7t3gaBHAi+lDGz6zvYRqHNFp4KFE4oMWZ2zkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474596; c=relaxed/simple;
	bh=HzSeUWGsdtGdx54KQ/556QBtmBddtgF4RJoxtPXAcUc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VzssbY6pK+2YWi4cdVlRlhss5UFHIOdJFQyuRRqxgBAM9BFmP23nH6yQ7Djpifv9GQ2LOy+YAfi2qhznIThMAmjAr5Vt7i7o5lbEufRzi0fME5HsSv3jGFc7H+m5KhjCDupI/xkp65bP0mFxhhEkEcPgV0sB6tnl5f/ZKP89Si8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X9A0nHfH; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATCaIs/vTZVKei+EQt6c3wDCtMOuL7J3wMWgH4P0YnVlRMCuJJ9yzHMfY+IkxR/yKEMftxdNxZ9myi5I+HynS55Zkh5dyx8Xp/8rP1dPoVb2t1xoJVl7IAyxBlp5lPmmidRJDJODjHD+Wixe9vQJbhoFXAxsPNj9MPVplHdNhezEAHySE03vndb5ouHic8plY25Bec25YfzyKCANPFVe7LWZTDz6Sh1HGLENGHhOSNEhUE4t7uf7CCbb1YuUCGdJJdcy4GhOYBzhE66rfF5fF7s7FP68FB/2/b5CyFuW2b4ER5WCPVONPnHuC/HIwndehsiDn1FstYAksDa+7leacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMdAPJwEz15Adg+wNLxa8hVV/icvzVCSXO876bwRXCs=;
 b=u5cTLtiXe2o/4E/GMRfnhNn/PR6mGbIT+xmbFTLa6UgPKA0dxVbnnbdWmiDmKzvFEmKm6N4lE7dXGcGoq1fciajpNXb7BZSHDqGYXJRDsuLADHysg6KsIkDPsUDxNXwYzyr9Xs1xQcpreRpDeLoxnAnKWctdJq3exQmp9CYAc5dENS2BbMffIXJcjCtue9Sr/95/ytq0mPmDKuWCfPX7rMWGrliLSRXysgSFZc5zQCsRH8y0lHwmtKvDkO00VSPsczpSS5WJimX1lWXNVSsIHxQm+9alYbbb+ijV7cQ8Ef4zlGACjAE1+gxe4cC35dk+xbO/7Iv1sF6qLhmwkCnYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMdAPJwEz15Adg+wNLxa8hVV/icvzVCSXO876bwRXCs=;
 b=X9A0nHfHBBPcOEXz5jJ7lnwCVSqKkpMJMts8+HXaJNTQtjcD41odf/e29SXZh6siKw3MNqHqGGKsnu/ooWijgZY7Y6vvNrA875b1IVV2H+oB9CZkJunkU8t7Rs6tFSfg5sWouvN2MikL/4ZZtyZ6szrbMHAU9Qr+KcQs+dy0Zr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 08:16:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:16:31 +0000
Message-ID: <b824bcb0-bde2-d54b-c91c-ea9f1eec7f83@amd.com>
Date: Mon, 16 Sep 2024 09:15:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 06/20] cxl: add functions for resource request/release
 by a driver
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-7-alejandro.lucero-palau@amd.com>
 <6315c924-1d1d-4417-ac6f-a9b200c41f8f@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6315c924-1d1d-4417-ac6f-a9b200c41f8f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: adf03033-5a97-4c10-98ea-08dcd627ded0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDNqRlIyckxZcU5RRUVmbEtjRytDYys1c2JIWTJCZ1JSMzRROUszbU5pRmts?=
 =?utf-8?B?YlM4RkZrYVNZMWxwb29SUE1HaWNjOXpURklrUWNYbE0rNWFidjU1RWRRT3A0?=
 =?utf-8?B?VmkyWEVLcUVrYW9DeGpUSkdjSVNUNk9sYUhNcXRGbnNSL0tsYUJDVnd1Q0lh?=
 =?utf-8?B?RG1rOWhncUduSEVWN1B4Y0xFZXJ4OFV2aFlBZi9EeStsZi9PdUZhVUR6S25L?=
 =?utf-8?B?RnJNQThpOTdaaEJ0SnRRRlU2MVY1VVJlcWxBcnpZMkI3VVp4K0FBK1BvR3Q2?=
 =?utf-8?B?RmJMMHhvSFJydnlGMUxMclAveTZMVm5EVUdWWjVRRDJta2h4cnFodnNiVmhM?=
 =?utf-8?B?cDY1ck1aY2I1dGdsTUZ2R0IySFZyb1NGU3YxZUQrSHlCME9HTUVjSlNJMm9a?=
 =?utf-8?B?NkRjTVV2QWFTVGVsWm9xN28xaExSYk5UblhTQVo4V3dJeUh3M3QwNXhUcUdN?=
 =?utf-8?B?aWZhdFgwSFZ4a1IxcVF0emZSOUNPQ3VNVURZSXF1bFIvb05Sa2xTdHlETFpZ?=
 =?utf-8?B?S1Q4cEJLc3JsWnFvQ2c1c3RSUkUzaFh4Yms5NGtaQmVadkp6bEJKM3RoNmFJ?=
 =?utf-8?B?dlBYR0grK1VsYkF6V1QzSWwwdEg1Z3pKRGN1bkJwdkd0VnlYdGFyZUgrTUdP?=
 =?utf-8?B?UFB6MFZOT0VMNmhiMFlob0lYNTMvMlZ6TTM1dEpFRm5SVEV4YlNPcWVvSi9i?=
 =?utf-8?B?VmcrOGRuOHlpZDN0M3E4WEJlcStxalRSV1RxSnBrWWxHaVhyN0llMXBCQnBY?=
 =?utf-8?B?bjY5ckJTTExMQkJyUDhodzY0MUlzWmE5TnRFVGFBMDBVSWV1SWhmWWpwZXNs?=
 =?utf-8?B?OVZ1bkQ5NWxnNUhnZE1mYWtNY2VDSjI5c0dXYjZUeERCMkNycTdyLzc3STg4?=
 =?utf-8?B?c3Jpb2djKzd4KytRbU81Vnp5N0E4MkhveVFORUNCaWFqS3FTMWV6TnFoVWhM?=
 =?utf-8?B?NVd3WW1WVjA3OXhDMU9hZE9qTndVRmNERTZsb2VtSURFY1VPanZ0a1VZa3I1?=
 =?utf-8?B?UVp5SGNzUzFWa1Y0ZElKcFA4SUVPUUVjV0VRL3JnMEcyVHgxTEgwTXQwSTUv?=
 =?utf-8?B?azZEZFFCa0phbUYrbEt0VklGR0FIaldQYUtlYmt1RS9NNkxBMUdqcTZmYkIv?=
 =?utf-8?B?NmdQUVlmNUUyZ2FQeVBpVjI5OHJaWEp5ajNobWs1MjdhbVpIUkhwd1RLdFFI?=
 =?utf-8?B?OXcrek40dFpaZ2NtUStnb080VDB6LzJiU3RCK0YvVTNVakIxdjBOemt2Z1d3?=
 =?utf-8?B?Q055RFZpTjgyMXJSRFFMOHJYT3dlUlhRaFU4SE1HcGZoWnhiU1R4NmlKQjln?=
 =?utf-8?B?NmExZjRweERiME9Yc1pHMDZCMG1TelNhbnRJNzVSa3hHTk9IUlQyamVuTEpX?=
 =?utf-8?B?bXRybm9NR3VnakZwY2xsNDdOVCsxeTFiRlNKQStHL1ZQSzBKb0RHaHFNS09r?=
 =?utf-8?B?ZEJHa3lIcFA3ZmdhcW11YzFqZmxOUmh0Q1k4NkZOWndPOHBjKzBsQXlBaURE?=
 =?utf-8?B?UE1CaEkvYmJWd1N1NFNacXM2QmxoVW9ZTzFvcVk3R0RtU2hhbHJKMmxXNmpk?=
 =?utf-8?B?TVFjb083WFN4Z3grRVR2Z0tjejhqMklaOXNITWNzRzE4TXNVNXE3SkZXVU11?=
 =?utf-8?B?Q0xJQVphZEhMbFcxa3AzRDN4eU1ycXV6SGhHVVhUMG8rK1RSNFJuZTVqaUtR?=
 =?utf-8?B?cjZ3RjNiYlZVV1RRSHBPcVEvTW8wQjFjbWNRVlVLWGMwTHUzMFplT2dYeEFH?=
 =?utf-8?B?SFIwRjFuTklYLzAvSE5vTXdLWGMvTnZQb29FOURGSS95bDhFK2YxWElEN2dz?=
 =?utf-8?B?emhUdXZEU0FzNG5jRUR0OTBqOU5PakZPcHhuenA3T2h4blN1Q1RRdUdpaWVB?=
 =?utf-8?Q?RHaIaqFKJGDWA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3lBMDZFZHdFSWI5QjJxVFEycVJXMTE3azB3dTRINHcvd3ZiN2dDNmpDOEhp?=
 =?utf-8?B?QlArd2VMQW5hRG1BbGx3bW0wZFVsTkx6T3FFYWtDQ2lhVHZrdVdKaDg0VXZT?=
 =?utf-8?B?QTF0OUxXVk9wb01kQ0Y2QTY0cFlMM0FWNCtiWUt2VG1MZzVUTFIzcTRqTmdJ?=
 =?utf-8?B?UzhyM01IeXRKczVCR29KaW9YWHFtVkdVd2Q1NmZLRTJHbVF0YXNjM09GYTF5?=
 =?utf-8?B?R3NWdUIvc3VFOThYcVhmVHc4UVpDZ2RIVkExUVBkOFRSdFh3anJ6WUc4SGo2?=
 =?utf-8?B?bHVEVDdULysxKzIrZjJYQ0dKaXVsWGVPTU9vM0tVSTdNdGRHODFoMWJiU2Jp?=
 =?utf-8?B?MkZGbS9iRW1QQUpHbkhpdDdxL2k1eEVWaldGeTNBbGNsNkE1dVpnWEhSTWV3?=
 =?utf-8?B?eDc0OWlkYmxiRkVDNVZYMDU0OU9sdjlzY21ISmpiNTBTREZIaG5MazJlWFRL?=
 =?utf-8?B?ejdkWmhKdnkwZlh6QmRHbm5PRVV0c29VY0xKU2xzVFBUYnlOOW9ZL1dDMkVz?=
 =?utf-8?B?VUJqNkNYRzB5T25sMkh4YU85c0lTU1p3NzIzWEJ5b2N1MFZzNDFiWHJkdWRj?=
 =?utf-8?B?OVlSVVZBdVFjWjl0Vm5TaDVKN05HaFl1R1dWdU9KbWhjeVoyL21zdU1sVmRI?=
 =?utf-8?B?YWU4cHJlRnBqNkZQYWpuYzF2SDBkeCs3b2crWS9DQlFoaEFmcDB5UFpySHhk?=
 =?utf-8?B?cFZoSThDU1JDcitRbFAyVXdzSVVsYkM0aVJIYVJIQkdGQlJOb3dHcklHY3FW?=
 =?utf-8?B?Ny9tUGE5bkxlbUsvYVdoRU93czdCQXBtaExkOTVvVExiSWZEMWNoekx4TUVt?=
 =?utf-8?B?empycDEvZnNlUWFCcmRnRjlNOXpJQmtkdUIxci9Mbm15L3F1NHV4UkNQblR3?=
 =?utf-8?B?YTJGbU9ZZk8wdlhOK0dWZ1lweXdUUW9tNmNSbUpPZ0NVdGdNbURCSUJGK2tn?=
 =?utf-8?B?c3kvZncwMnQ2NVNOQnJwcEJTWWZ2TmJpVDFIditldTB3aDFqUlJtWGJwNUE5?=
 =?utf-8?B?QVRYZVp6TmtyUFNQNnZtMWxyKy9NcVR1YjdoSWpqMWVFWkRYNkVOSkQ4TDgr?=
 =?utf-8?B?RTZPQm4ydHhSaDMwdnJRbk8zMDMzcHBTbUt4aEgwaDdKV0JrYzczYms2WEkx?=
 =?utf-8?B?bzE2VTcwTXlJdk44TjZEVHdTZ2wrZUd1VVpjSkhUSEZxRzRIeUNSSk1kdW9B?=
 =?utf-8?B?N1RHNHJHc1RLN2FMcFVoRFhCTm9JQmtMcjMyWWwxM0NmZldmeWROY2tuSHV4?=
 =?utf-8?B?MzhzMkZLNGwwOXFLb2lGdnhqWVZHVGhmOXVJc25TNTNNNVp5ZTY5dmtkVU5U?=
 =?utf-8?B?ZS9JRkJrditzSXdNaHVCOWxZNXdkOUZlZnR2VXJOS3ZtdGsyaVlzVUlMUW5C?=
 =?utf-8?B?UFdaQ3IvRFBkSlNQektDRmVadUFoaWZ1WVBEWDJpTjliUFZHWjMxWmt3anAz?=
 =?utf-8?B?TzRzRmlCOFl1MXpLcy9kVi9OUzVGTEU1VTFreUVEck9Db1lBRmxIa3RkVEJH?=
 =?utf-8?B?WmFPanQzWlk0L01WekpkTys3QWs1eE9PWjN4YTBUNDB0d0lhdDYrc0l5dDlD?=
 =?utf-8?B?QW5KanBQUStITHRhNW9jTklXRnRSaG1RbnVzVFB4bzV1aVAzdERZcDZQQ2dO?=
 =?utf-8?B?WW9WQkpWbWdzMTNJeDBxRlZhRVJBazdFWEhJUEVzSDJEMUlXUk5EQTNleWcy?=
 =?utf-8?B?aVhoWWJCb2VBYnl4QnQ5citCMTJWNzRXZEpna1h5QjMxelJMem41WEZCUy9Q?=
 =?utf-8?B?WHdHdzJxNkVwK3JPNkwzc1NsMGwxRFZpUEt0dlhpanArVW9hc0FreHZ4ZWds?=
 =?utf-8?B?dkFxMnFJeEMrWWJTUExLRW9xSmMrc0JRMXJHUzN1c0RMTUxsZ3RHOXRjaytt?=
 =?utf-8?B?MnozOEhzaFl5enFzS1BpL0lsWS9nWHhqSmVXamdLeHE1MHVyZnFsK0hnekE3?=
 =?utf-8?B?M2pnSUpLTkk3WS92amZYcVVrdDhoTUk3eS9UTmNsSDBjeGhDZENwY2ZNUGxQ?=
 =?utf-8?B?NEk0dEQ5bUx5d3hnWC9VRzRvMi9FMUFObjlkNW1JUGtMSVFONUZlbkRJeXJk?=
 =?utf-8?B?Nk1uNktWMERoS0ZuRmREOHJuK0swSE9ORkU5cnk2S3R6TnZpVW5mTUpzZ1VL?=
 =?utf-8?Q?hkWy95Wnwxe15CdzDTAU3rSrf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf03033-5a97-4c10-98ea-08dcd627ded0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:16:31.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W60sl5ggbKzTPFrX5Zoda8VEB3l2jAyprMx96MIMuKmPK/E2jLvM/iar56NpfQkA45f5ib0HoZqteaiRQvPOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201


On 9/10/24 07:15, Li, Ming4 wrote:
> On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create accessors for an accel driver requesting and
>> releaseing a resource.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c          | 40 ++++++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++
>>   include/linux/cxl/cxl.h            |  2 ++
>>   3 files changed, 49 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 10c0a6990f9a..a7d8daf4a59b 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -744,6 +744,46 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>>   
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +	int rc;
>> +
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_RAM:
> Should check ram_res size before request_resource().


I'll do.


>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
>> +		break;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> Same as above. Checking the size of pmem_res.


I'll do.

Thanks


>> +		break;
>> +	default:
>> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
>> +
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +	int rc;
>> +
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_RAM:
>> +		rc = release_resource(&cxlds->ram_res);
>> +		break;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		rc = release_resource(&cxlds->pmem_res);
>> +		break;
>> +	default:
>> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index fee143e94c1f..80259c8317fd 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -72,6 +72,12 @@ int efx_cxl_init(struct efx_nic *efx)
>>   		goto err;
>>   	}
>>   
>> +	rc = cxl_request_resource(cxl->cxlds, CXL_ACCEL_RES_RAM);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL request resource failed");
>> +		goto err;
>> +	}
>> +
>>   	return 0;
>>   err:
>>   	kfree(cxl->cxlds);
>> @@ -84,6 +90,7 @@ int efx_cxl_init(struct efx_nic *efx)
>>   void efx_cxl_exit(struct efx_nic *efx)
>>   {
>>   	if (efx->cxl) {
>> +		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
>>   		kfree(efx->cxl->cxlds);
>>   		kfree(efx->cxl);
>>   	}
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index f2dcba6cdc22..22912b2d9bb2 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -52,4 +52,6 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>   			u32 *current_caps);
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   #endif
>

