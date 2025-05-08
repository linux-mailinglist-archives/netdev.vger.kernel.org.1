Return-Path: <netdev+bounces-189016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D9AAFDF0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3ED4E728D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA0279790;
	Thu,  8 May 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UdV0XT9v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC927278172;
	Thu,  8 May 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716122; cv=fail; b=tPoSSBEJAsqkOUJc/syQ7H/QxUF7WHJqfIouHQgbtGi/xNurPxvbzMIp6bWo1XkmV6SUU0v3PgtTQOchS1juiGYQjrj2/wgoICot7HFI9mtP4s9QIpjqUYlHif/kt9gOLKVQN3Hfo5fT0nDWcDoXbl3KMBTQjVcMl4SslCw+r6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716122; c=relaxed/simple;
	bh=V72ShbBLlb83myDolHEYluZffTrEQJPAKnxOjUGGYOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sR/LiqP287yVhDv1zuNFexQNIuBsu5VHiS0y4fnQLHICjWpmmEqU7Dbp8yDP2kxrO7i3OqcNgzl1DR73pJVgB6bli5rGwSro4/aO2Ek1tSOVQeWrlN3TXNBR+p8Cew+sm86HExDTUtPEH/i5j+5FfMNcw9b6VfGVuhxud86eeHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UdV0XT9v; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaQnJs0XFh/KyGrMtVeZ6S1Jr83hT5gVN2JTH+s6wzNaWFWL62Xf/lyM7EW6A3JnswkucV8e2fUOp+ZfjRUiMyeC8CGi9jI0p/bqjR7EWbqdlWa3gltLo77OMlTkSbicmow3O4p/gl/1Y6H0C/TtdZAlSYBFttE3ibtSZ54NBfVBgSMLyT+gny492r3TxAYnR3yfknRGErQg3ATAUDInEprj5yIfQfhWHOprVUG8c8+dY7Qz/uwTwtnuwk17j6KgjxSyXGBxcCbP4HGrZFbmkImYSaNUSd2g6zt+Ummnu7M4D0axic3VwdehfwE9gmop1tQeJWPHcQK/dZD5ECMtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcmHfZ8Alg9Q6wQHlsF39vo/0exR5ZEB7nLZMbCh2GQ=;
 b=SP8/QYlhhuAn5vEKZCvubD4rBXd2ASKKyEtX5lXMTuA0wORGMgadU8JQzPMkCnXa5ZW60v+Vw8KA/VA3rDb3UpcAFwR1LM7YMBPBMnYMVy37h7PlVmFbn3ZW9MxtPvVstQ5lKamTaeQxq7DIqD9N6Cdk+afbr4krf53e15sP/tpAzGsNhOypfVLN0tGW1TsLuZliWTcLNdXC6ZKJRwZCSNfMC/U8agLGOWUrd7TKJR/TJC2f+nMOGUfhnQiCeDd7iSwFz7K/l6ZgX9wydYQDfVkmg6T2r8Qo51SkfGecfVY8ooCPZg9ieA6kbOw6Zx42guF6+hxVSAc0fHew0nJGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcmHfZ8Alg9Q6wQHlsF39vo/0exR5ZEB7nLZMbCh2GQ=;
 b=UdV0XT9v11lPAh5iol0NCdj17sEsJ+7GQ6ujr5IsXBqZUMvxr8Uu2UDHTQcskFIlhJFPPXYp1ypEyjlBIoMJIxhLL2XMNh5k05ePOZGJ2xu2dIMj+cqBlTDlyh5R3LEP4NhoUYsR0sfQ2NVksXeLQ1fCoyMx5GUrQRPP6JI23Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 14:55:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 14:55:16 +0000
Message-ID: <1bfb63d8-d16e-4779-b23a-8fbf34342ead@amd.com>
Date: Thu, 8 May 2025 15:55:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/22] Type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <aBwQGNx4uK0f9aCS@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBwQGNx4uK0f9aCS@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0153.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c72a2cd-5b78-4bb0-3b59-08dd8e4057eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qi9qb1VIbXI3eE15UnR6SWt6SFpCcTUwMFRwUHlwaTZqQmFzK3JscXhid3hC?=
 =?utf-8?B?N3E1RUk2T2RDVUFhUkRWZVBtSFdJalY1U2VqNGNLYVVPcHp0dHJHaFBjMVkr?=
 =?utf-8?B?SThBUjJEU2dIZjJwbkkzdGFkd0xrdklVdUR3YzVCRHRTaCtQRnBzR25CUEQ3?=
 =?utf-8?B?N3l0STFZY0MrWDE2RTkxaktZMVVtcUt6SzNmMXdvaFBjU1BZOERJQXk5RWxs?=
 =?utf-8?B?SnlvVHNKeGt0RUJkNk9pOTY1b0tCZlQzK3pPY0NsMDZzdmZGUjhQUDgxSWRY?=
 =?utf-8?B?eXhGc2tML0pSL1RVMzdqT21hUGQzNUZBRSswZUp3VmFoTkduT3ZlZkhXSkFu?=
 =?utf-8?B?aDBQbG1TZUEvOGNnV1grZjNIK3FQRmNIRnJ6a2VFS2EzSzNVVElvV0lMTHlh?=
 =?utf-8?B?WkxhRGlGc1QzNkY2NGlxSlUzNllvU1NmZ1BnSVFqMHFRQjloNFJRdmQ0NTlG?=
 =?utf-8?B?ZmlKSHFobXVMeHBpLzZ0bnRIUk5HZ2orQWFIU0NEYnlaSEpoWUJzUExDSGxM?=
 =?utf-8?B?WHpIeUcyaVhLOE80VFl5K3lXSEpBVlQ1cjBCZVN3Um1kWHVvdVZrMEVXdCtH?=
 =?utf-8?B?aW8rZmU3a2ZzNUNyclU5c0xtZ2M5eXptb3U0YUYwZC9HTUpRTWVTcy9tQVF1?=
 =?utf-8?B?Z01EcGtVM2ZFQngzSFJFQjVwKysyRUZLaUd1Y01OTHJadjZjVUdUSUF0V1RT?=
 =?utf-8?B?V2k0OXMvRXRqN0ZuV3BieXZEWVJQbkdORzBjN1I1UzJTcmNmVC9lM0NxOFgx?=
 =?utf-8?B?cm1NYlBKZUVUNUgvdnp0a0NqdG1BZ08ydjlwc2h3Y2xoUmtNcFRobHpldWZ4?=
 =?utf-8?B?MERFbWxlOW96UlpiczUvWlh2N25kOVlKY1RvTDJMTjY1RXhQd1dJVlMxekNX?=
 =?utf-8?B?UWZzc1FCWllpZXZpeUxzRWdGdi9oZVRFaktZVnA5MUxsbUVOVFBkenNNZ1lL?=
 =?utf-8?B?SCtyWHBZSTBXVDE2T3poR0YraUZZYmVKK1NUM0I0NCsyaHc4T0pQUm5yUVds?=
 =?utf-8?B?UVMxTmVRODVUUWRNUEx4TTVFaFF6YXhyOTNPU3NQOXFhSWVmeFpXbmpYMlNx?=
 =?utf-8?B?WWZOblRmKzRNM1gyM3MvakcwUWJIS0p0LzJUdkppOTEvZVBzemtqVUh6aHNq?=
 =?utf-8?B?YkxqSDRRY2Vlbmg0SFN2YURmZ0RuWEoyVkRPQStlWkR6WTdGaWxvS041SnAr?=
 =?utf-8?B?MjVVcG9LYlRsSlJKVENvVUllZjNnOUV1TG5pcXVNdUtpandqQUUrRmVWRWZq?=
 =?utf-8?B?Uy90V0pOWW1XSEFsdFBHbUhNS2I2NHI4T2oxdTZMTjVaS2h1MXVQTlZMM2k4?=
 =?utf-8?B?aE12cGE3c09maFIvQkhYdVhQK0ZiRS95dTM0eThoSGp2Mzg5bmtEb3FvcnVa?=
 =?utf-8?B?UHVNMWExYkVBbGtoZFdtYVkyaUptbWxMZ2U1SjlKZHB3ZFZreTZoVC9JdkVM?=
 =?utf-8?B?Z3RLK1FsTmEyY1pLMG1VVy9JKzZDNHhWRFY3Vlg1dEdELzJjSlpiS0tZWmUz?=
 =?utf-8?B?YzFiYTJ5bzZ0WW9GWGFydzlkeWNISVd0UFFpSGpJS1JhQVkzaW03VlFaa28x?=
 =?utf-8?B?aERsMjF2Slh3WUJlZ252TzhoTnhkZktMVG5zWHVvaEFxNmNZblhrb0E1UkNz?=
 =?utf-8?B?SWxRUkRNMm9lYy9jMHZ4NjJqTytzK1RKaGNuS1JJK1VlVFNRNVI3b09oRXhT?=
 =?utf-8?B?NnhoNUJ2VVc1dXdsV21ubFNENEh1NTU3VEJqMmdwbkYxK1JJa2V0Tk41RXFy?=
 =?utf-8?B?Nkp5Z0NFQ256OCtVRzRudE1qaEV2WkRaUFlGSTVlemc4REZvYVU3Q1lGYStv?=
 =?utf-8?B?VTg3RzZzZ3hkTTF0VG9iL1VBSkg1R2tUY3VZaURKd3lKU09rcVdsMVBVTmZG?=
 =?utf-8?B?YVIvR2ZKOEYyQThKT3JJdUhqdzdiam5JY1k3OU03WFJOYW9zT2tFekRlMm92?=
 =?utf-8?Q?gWA6qulkoFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzNTaVhFUmJndTRBODQ2WTJyUHlGekNvOFdDZTRXNmg3eXZGOURJT0JLQlZQ?=
 =?utf-8?B?eWpQa2ZiUjd4MmJ0RDVsU3FKcnRYR0RVWVdtamJaLzMyNXl6QTMxUko0SU95?=
 =?utf-8?B?Q0J5RG1ldkw3VTVoTkZYQkxQMmJDVVNLeWNkQmp1OEViR1c3VEJ5Slo0Qktk?=
 =?utf-8?B?aTMvKzhTSHVKR1A5dTRQN0pSc3BEVHZ6UTNydXIvU0ppR1RCQk9sUHl0Z1Rv?=
 =?utf-8?B?SGN5MEVYaGtoZGc5TlJ3cVZob2gycFUxOXFGNWZ3cUI0Vk1FVnpTOE0xT0Vo?=
 =?utf-8?B?Ykp4L1UrWUE1eVphUVVFZHVhTlRKVTNHdk14ckdRQkZSZFlnSVJuaTUzN09D?=
 =?utf-8?B?Q3hIQ3NVN2E0REJnNko3MTNzbE9VcHQzWmREeHBiaEF6MVNNTFN5bnNHMFNu?=
 =?utf-8?B?K0JPenp2STcvZ2lxNnBWVTMwQU40SVozQ3VyVFJzR3JFdU1DclYyRWJwRk1s?=
 =?utf-8?B?OGFqTlVxTzFSMHJaQW1mU25Kb09uRmg4ZlBrVDZCbTRBMU85WGtDS21VaXRx?=
 =?utf-8?B?YlhJSHlaVWUrb3h3OVVtc04rRTdGWEVhSzJWYUdIUzJIdkFoOGxjbXowMnBH?=
 =?utf-8?B?ZHU2Z0s3R0V6R2R6VDBILzJLUFpFc2FKNk93eFRJSjFBZjhZTzJWLzZ2ZTBZ?=
 =?utf-8?B?VTFXZC9KYStYVTRsSE92aGNqTmRvLzY4bFdlaEJKalYwcGNWMzZsYWd5VU13?=
 =?utf-8?B?amJWbytDU2ZwSzJMYnlhV0dqek9MeXE4bDl0M0N0NHlQcXJaQ2c2ck5lWU1F?=
 =?utf-8?B?aVhtSGFqWFlpWlBQRWt0dzd3WHNlYy9Md1dhcWlieUd6WGhqTVlGT0VvU3VY?=
 =?utf-8?B?dlYvRU5RVG8zK1hwWmc1NzAzVmMvTitOMkpJblp1QllqSUc4S0JTY1kvWUlH?=
 =?utf-8?B?VUNWaEhBR3JKUmlza1c1MHlyYnJTbGF2QkFobVRCSnpzSzBpREl1T3RkNEVE?=
 =?utf-8?B?OG0rc2FvN1l4OEh1UWFIK3QxdGRxL0JvRGxHd3VvQlBtYXJJOHptL0JXU2Iv?=
 =?utf-8?B?WHpSN0ZnalgxQ0g4OG9CZ3o1VVpoQVdqeHhOajlGU3pJNWRsdDFBNTREK0kv?=
 =?utf-8?B?VXVYQXVoVFVqSXAwRitRUTdmdHd5SDA0VEd0TG05Nm5QSEJhajFCMHZBWnJS?=
 =?utf-8?B?blJmL2Y0NWM1aXVySVI2VXJWdFAwZ1dBbzR4MFZUT1BRbG5EWHEwdzEzdHlE?=
 =?utf-8?B?RENkRG1SQmI0c01jaDJRYytpb0JsUE5nWi9IVTJYMGxiekdqcGtIZjMwc2hV?=
 =?utf-8?B?aDRjUDhlM3hJdW9rdWllWHFUS3Q0L0R5YUFOeG9iM1VkZlZjVW55SSsrSDZn?=
 =?utf-8?B?N3BZcUdjOGkxclA3bEpRSE9jWWtBNjBzNUplODZJQ0F2VStNcUtIdUwvaDNM?=
 =?utf-8?B?U3BKVjZhQTVtcU0wZEZXZFR4S3NPWVJJcjI2cVN6akJSQ0RWUlFtUWk4ZGRn?=
 =?utf-8?B?VjRDTUw2bjdUZjlmZ0RLNXYwaXZpOXVEZk85T3RSbmxTcTkyODhaQ1BEdXNK?=
 =?utf-8?B?VjRtaXk4ZlJYS2tVRHZNSXJyKzJsMjdrZE9QWWV6Z3I0MGRmeDByejc4UEQ4?=
 =?utf-8?B?dGhLM0YyVDJGRVNFeHNaMDhYa0MrMlcxQlRUaDlKN3hOdXF0Z1I1aGNCV3dX?=
 =?utf-8?B?NEhTUjFuQUF4V3BwZW9QSXVCWEVFbDIyM0Q0K0czVEw5aEhYKy81aGRWMnhC?=
 =?utf-8?B?WngxcFRTWmIyR0poK0J4RXBjYXh1Kys5YklJTHVlZTNDOVhxalVlQ1FoM092?=
 =?utf-8?B?b0RncVdUVGF1Qk8zNHdPNENKN0U0NStMR3ZNSTBvWG04QU1GbDlUcTVsVDJQ?=
 =?utf-8?B?OEFPS0RnTW9rdnVEbmQrY3dVZHkwd1Z1OS9MMmJIQnNHSm1ZVm5qQWxaMkN3?=
 =?utf-8?B?NFpCUnRIWlpYL0ZYYzdTUDdPeHRrdFZ0SXNDUFFOLzlVcVhYaW0rVWNHMVRl?=
 =?utf-8?B?VjYxdGEwbmhmcHcrb3lDZHdsaE5GOEtKalVEdkZPcGo4UzdXc2UyVFUzUnB3?=
 =?utf-8?B?Q1g3OHZlQjRXT1B2Q0FzSzh3aGdpMEhJNHN2T2NQaFZSVjdIbGt2aW1UYmgz?=
 =?utf-8?B?MFV5M3h3M080UzA5dnZIOGNxdGJzQkNoWHhtbGhKbHo3WVFGYk1LRytvQTZL?=
 =?utf-8?Q?oUGkrvmc6O63s4dac0+pFN9dh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c72a2cd-5b78-4bb0-3b59-08dd8e4057eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:55:16.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwBBaVxwC6zdzYX3L2BzDCLq6oRZIvHKSy8cWpjYld/6+eRPeKiz4fKYZXvutCS8roADh4+Twb3z+ytHjaWnAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171

>
> Hi Alejandro,


Hi Allison,


Thank you for your reviews.


My replies below.


>
> I commented on a few things in the individual patches and had a couple
> of series wide comments that I'll share here.
>
> I came into this set with the expectation that it was a model for Type 2
> device support and I expect it is, but without the summary I was hoping
> for. As I review the patches I can pick this stuff out, but would have
> appreciated each patch commit message stating its purpose more clearly.
> We get so use to reading this as a patchset, ie a short story, but once
> this set merges, the patches all must stand on their own, so including as
> much story in each commit message is needed. At the minimum, every patch to
> drivers/cxl/ in this set should explicitly state that this is being done in
> support of, or in preparation for, Type 2.


I understand and fully agree. I'll be sure about all patches clearly 
linked to the type2 support.


> I sorted the set into 3 buckets as I read.
>
> 1)These are the changes made to existing paths in the CXL driver to enable
>    Type 2. These change the existing driver behavior.
>
> 2)These are the patches that add new functionality to the CXL driver,
>    that is only exported for use by the Type 2 driver. These new
>    functions are not used in drivers/cxl/.
>
> 3)The sfx driver code. (which I glanced at)
>
> I'm wondering if bucket #2 is something to be documented in the
> Documentation/driver-api/cxl/.


It makes sense. But if I may say this, I think this could wait for a 
following-up as a Type2 driver guide including some of the problems I'm 
struggling with right now, not about the patchset itself, but some 
assumptions about what the BIOS does. Also, as the cover letter 
mentions, this is "basic support", so a first step which will have more 
steps following soon hopefully paving the proper road for this CXL 
functionality.


>
> Other general comments:
>
> - Consider each drivers/cxl/ function exported for use in sfc for a kernel
>    doc comment if not already present.


OK.


>
> - Some of the added Kernel-doc headers are missing  a Return: field


I'll check it.


>
> - "Printing numbers in parentheses (%d) adds no value and should be avoided."
>     See: Documentation/process/coding-style.rst.


I'll fix those.


>
> - Follow cxl conventions. Commit messages in drivers/cxl begine w uppercase


I'll fix those as well.


Thank you!


>
>
> -- Alison
>

