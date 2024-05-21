Return-Path: <netdev+bounces-97380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0D8CB2A8
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 19:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4751C2186C
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518B142910;
	Tue, 21 May 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3a2GsbEi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DEF22F11
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311670; cv=fail; b=n+yhD99XXlOXAODyKXkvIpD8mJ+ImDhmEmt9/bVFxTnOFMGQSptVKBaPZEGyPNolh2qFelqktMb4OXOGjxFnsYTdkeNVr6z6q+hJVq3PHY8nfTFJZonVVRnlCYVMBtnh5t0aH7B7Wmzw2Fqpu9M5+OPqt551Yf5UXJ3fOypLrtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311670; c=relaxed/simple;
	bh=AN5jJYioB/CYjMsMk7lFSHMEw8YPX/RBOpBm+r0EHlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kyk+tUAU4PRddmbfvCbraiJwMt0rEudZRtf1sbABGYMzo54GQbj4VL+81ZGp4r3mpUOLNtsWEbwxQnBGzR3Uap5Qdl6sr6zQJKfU9oOrWT95QEt6XM95z6Zfb7C+Km290631W+wqTECURu2CVHfHhoF6hfcPSjcW9U4gVWrTks4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3a2GsbEi; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlinSu7XenAV544phAJ1XljGdWB84b19TYfUlCSptJOIT5Zxzu+UpMFKpZyWKog55C/cTPGigPChkk0+hizhvi5MhNJwYHKbfG7LiT03HhwuMg/X3SHseoYFRuBCfnQQFF5MIKT2ZhG01ynF4+0dt1yPI4r5kOWVIVhG3i4BkBcYfRHoSD/qeLmLHas57Bfy8psvTAr0dfVu6yCY5OAM/esdN4VUbwRjUk/4kqCpfeVGCgJGAAbyuycre7EgIY2vScLO9Ac0xdQcfVpLzIHjgrdSlJuYKhQmQgOGyhEVY8bCHC3cKok83HDH/8BYTIBldhfNrXu5JQxz+l7PSmpvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiT29AKhRQHvBqk50ZQYV6s+C4Pb2lvLDVSAWOLaUv4=;
 b=k6hKCqT2URkOrZ5/gqf/xlEqrTpeyFGkbuqaN2V/IhqjGuvYrKCEi0v6RAHXIptHFyEcRCnp7t3mUd1U6oU57Tp12/iIWkry7qbPWCD4DnKGDf4+M6sfCNDi4EMU42/KCiQkNrHw1Lak/bN53yj+G35+/WWrYx5zUH9ntGjHWWkDeGX3aqyymhmDrwDzH9R9/B9r8EX0OmghAJq1vlt7ppRVcNNSqY3UHC9COrLJmgKsDmfGsibFXhKKkvUDN7orkQBkknKvJLIMwtkgjkEy4TKX+Zrpy4mX2v8Zz6sAZBijNj/ysQkuoti+2wLggNTGWr9kCjfUzd6Y+Wh6K64BAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiT29AKhRQHvBqk50ZQYV6s+C4Pb2lvLDVSAWOLaUv4=;
 b=3a2GsbEiZQiiWU/yiT36dQKR9NrKPlJhLgdYFHggKcH9vcr/xxFtnqzkFEBUSbptTnWiXv5A0D2kn7ySndJf2hkQemxciZT9bT8ZiC6pcZLfQeP3/tF8DTQvOucr420q6xKZbsqnf1aCt2W7jigzSL3cAKjltAx62TW3pL0pkX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:14:26 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%7]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 17:14:26 +0000
Message-ID: <e68cf441-e877-4cf8-98c6-86b6067364a8@amd.com>
Date: Tue, 21 May 2024 10:14:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/7] ionic: small fixes for 6.10
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io
References: <20240521013715.12098-1-shannon.nelson@amd.com>
 <20240521140631.GF764145@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240521140631.GF764145@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: f378676d-2965-4929-6482-08dc79b97772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk0yTHU4VjdzaVFtK3dXQTVOU1JIRGRLdzJVSStQcXRjY3dWam1rdGNSejk0?=
 =?utf-8?B?M2t2Wm9lZ3lGa1pXSVQzdWoybXZLTlhtR2pwUjBWRGVRcytQclVMUzJ0dVMv?=
 =?utf-8?B?VVNCZ1crOURZak5mdkJGS3UyQVBZeFZtWTFucDBQaWwyRURxQ2k1R1lGWEQz?=
 =?utf-8?B?UHlHK09OVThxQUhHRis2UjZocWdOZXVuUE9nakplT1JOWTczb0paU3REc09P?=
 =?utf-8?B?OGQvTS9Pb25kdDNjTmxxc2E4OWd3UG9kYlJWeC8ydXM1dTJnRlRTUU1DTkYr?=
 =?utf-8?B?bWtnK1ZDVnFKZzl1eXNaWXNYRDVDK2xZd2ozTUpVaitOK1NtRmdTeHNzUkFS?=
 =?utf-8?B?MEFrZVI1RGJuTzh0NnRya0dabld3d25lNENiVFNSVlV6UFhLMGRvaUFCYmVo?=
 =?utf-8?B?R3BOOUdyQ3o2RDhKbmRRTSs1Z1hmMGsvV0FaeVFxUWNrbkpoVHdhUVJ6Uko0?=
 =?utf-8?B?Y1RHOHhUOFhhR24rZENrQkJoSnIrWm5DY1h2NWpwR0pzak5zaFBvYnp0dUJt?=
 =?utf-8?B?YXdKeHlzdUpDN3BldGZWMUdobzJQaUpnT21scGZRNXBvTElLc044cDkvRDE0?=
 =?utf-8?B?QzJERURzWjBDdGU0dkNQVjRoN0FCZGhVOFlWNTM5SHVhNzJiWlJrclMvNTJP?=
 =?utf-8?B?TjNqU2pJblc2TkJWczZwVDd1ckZ3NWJRS1dYM0RKVlEzWW5Ja1lWYWhOUDBi?=
 =?utf-8?B?MkNhWURWYXVhZ0hONnNDUk9yS3BjRmIvbi9oODFJV2hGT09MbG9sWjRDTXYz?=
 =?utf-8?B?MGxYUVlLSHBYckVxckM1TmJoUDhtUUxNTmZqdUdpUTZqeXk4T3QyYVNIdzd2?=
 =?utf-8?B?TDJPTkdvTW85TU04TG5mSEFyRnJ5SkJRcTFjTDFwNGpjd0U1eVk3VS81a0tm?=
 =?utf-8?B?YTdPd0ZCU1d2RDZ5SHQwYi8zYUd5d1FXd2JOaXdCREdkTjZVZzNaNDc5T0Nt?=
 =?utf-8?B?Ly9rR21nR2F4N0NMcExOYmp5VWxVU3AzWStKbzRmU0dsSkttSXAvOUhWbmVE?=
 =?utf-8?B?a1NsOFB1V1YyVXVKYUtEK1JhNEh3eDZiS2l5UFZpQlNzSGUyRXIxMVVmTWxK?=
 =?utf-8?B?YWIwdy9BdGJueExYMnNxdEd5dnc2YVZWNHdjTitBSVZMMDVoM2lHT2R4LzhT?=
 =?utf-8?B?KzJHQ0UzL0NsYUtkelFUdTVwdnRBLzRaLzYrTFV3Lyt1MHBMTXBXSndhUHYz?=
 =?utf-8?B?LzZsZXRFZ2tYZE1JbnQyZmNlT3ZTTnpHRElMdm5FZlVWTUJGY2ZvY0VSdXFz?=
 =?utf-8?B?RGRaQ21Xb09Da3FVOWhCNjRoejNwTmpqZHc1WVBaL3FTZlJoYjQ4eFE3dHgw?=
 =?utf-8?B?MnJPRnhBS3R6S3ZlUllmTFhlakxKWjFPUUNoWWpWeWMyOW5FZG1sRWUxWTNi?=
 =?utf-8?B?TGlXWFZybmtqV2UrTzBCdTVRVXZJRi9SUHRwWVRGdkF0ZWo2Qk9tVUx2Tmg0?=
 =?utf-8?B?STJnK29ENWV3S3lkMGNHSnQrWGtBMDFsRmx2S29lTWJpcG1qTGdpbkdmYjNL?=
 =?utf-8?B?WDFmeWJQT1A4ZExQWldydFlrVEgrYjF6ZDE2cUpjd28rVzNZdkxZRzRQWmtG?=
 =?utf-8?B?MXFzZjdOeHRJOU0waGxoWmhUa045WEhEN2tvZUl3Yno3Tm1MSW1aNmZQc1N6?=
 =?utf-8?B?QWdBR09qNmJrNzdlQ0U5bEZ0OFZWMXRiOTFnR3I3dVNOdWxqWldBUDRXTHVD?=
 =?utf-8?B?UkFxRU1TTlI1RklPM1BlVHFyWk1meEZOSUplMHVHa3JlcXBmcUJ4MFRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmIzWldCMk1iVmFyOXFIVWt2VlFuSWc1NE0wZkhjN2JQRFZ4MW5aUEVqSnJP?=
 =?utf-8?B?bjNPOXlubUlvOVZ3YzdVeHZGTHFibGZZSEI3R05TN2p4Zzc1T3k5THYvL2pw?=
 =?utf-8?B?ekdGZm1lTVFxSVhjbS9FQkxTTlV6SXE5eHpkb25Gd1dRWEo0bWZvdHZoRXpw?=
 =?utf-8?B?MURLbXdyZDZ5dWRaN3dLNEQxOEU4NW5RWlFESWs4MnovV0g3bVdyRnBObVZX?=
 =?utf-8?B?d2swTklCVGF4ak5RWEhMZHhWNzJ0SExtWG9VT2FEMFhOZUNqdlFicW4wam42?=
 =?utf-8?B?OUpyM3pnbXVuSU5kMm1aRWhRYWFZVStNdmNNcjRzbTF1M3hEZ0V6VXNUUWk2?=
 =?utf-8?B?VkJzNEFqT25CeHBaZEprQk52ajdYTkxkNGJkU05KRGN5RWJVbnVmcFY3c1Ex?=
 =?utf-8?B?S2NuVjgrS3VOVnRPaklUTE5zbE1jcENjaHFlUWdldUIxajRibC9RaWlPUE5R?=
 =?utf-8?B?VHRPYmR2WHZpSjI5VUlmRU05T0FMTHlZMXFnOG8wVjhrZTJMQlMyNjdaNWlo?=
 =?utf-8?B?c3Fvc1VQVms4Tld0cDFoZ2FJNDJrRHl4cE1vQ2lOa1JkNlZKS2MxOWQ2K1li?=
 =?utf-8?B?bHdTWWRCbkVtNGgvRExPQnBYa1FEeGhhWlR5S3NUcm02YVh2M0grdVFQSFg4?=
 =?utf-8?B?UHBRTkw0TkR5K1BuQ3dkd1FEVmtqOHV3UThhUnpETXFrMDllblk0VFJNVkFD?=
 =?utf-8?B?c2I5bk1iMzlybXJScXlYVFdseXYrTytZVGFQSFdnVWQ5a1Z4NnhncmtxbEZG?=
 =?utf-8?B?VG5LS08zV2t1SlRlMU14ZTFKekViS1NjU0p6Y0hFMTFZa0VJSW5IZmNOSzVi?=
 =?utf-8?B?YkJ4VTEwbVM2dDdjT2htUFc2cWtlQmZERWYyQ1MrMjI5UUdkNUJSSGJiYkJK?=
 =?utf-8?B?RmZ1U3BkSkdkRDFCcGtHeFF3dS9ZWVlmRHZuT1RxMDJpUnlOMWtFUzl1SCtp?=
 =?utf-8?B?Y3VGQXFhK0FIR25IaW9lV1BmS3BKL3lnOTFIclpQK1Y0SjRQc0ttK0lNRmxm?=
 =?utf-8?B?T1VzN1FyNDhjVkMwSzlFZ2huYm4xRXM1d056OVFjUDZpcEk3RjIzY3RxWG5x?=
 =?utf-8?B?eFdmdy9wSjJOVzJDY0RTOWVWNDVFcWN5a2FPUW5iOW9MRVdjaGZpVTFhQ3VY?=
 =?utf-8?B?RGJTdlNJeWdIaitGYnhMWktQSGkydFcvK0lKWEd6b0VmeXI5bDA1ZnNkSUda?=
 =?utf-8?B?ZCs4VWdjZ0dRYjk0KzdXYTRHUGNjb01hMTIyQXoyYStadlVDYWVnaFJ1YzR4?=
 =?utf-8?B?QWlsS1Y1RWZIYkloazF0cmhnWU5Vajhqa1V2Wkx6TXJkOEoxNS9DSnljbVVH?=
 =?utf-8?B?aTRURXI2YkJ0c1RhWmZ5M2lwN2V2REtsd1hseS9zK0t1YzhoMi8wYzlIcE5S?=
 =?utf-8?B?MDZBc0xiMytzVzJvN3c4Q3BFd1VEWFVFa2tkaU9RNjJ2Vlo2dkJXR0NhZ1ZC?=
 =?utf-8?B?U0ZSbE1CbmVyaE5yaTM4SUZOOHpzZW5MUjRWeWVYTmliTk9UMmRIR1g5STIx?=
 =?utf-8?B?TkhPcVR4WEVLS2FTU3FrQkJIVFZMdklzc1JPbkh0Ujl2cTdZR1BiRWlkTHJU?=
 =?utf-8?B?aWx6TGowWkNvaDd1c3V5QVBtaE45L3hSMkZnLzF2TUxGbTNUN3g4KzZucW8w?=
 =?utf-8?B?blJzeVRQY0l3Y1lPRTV3WVdNUWFxY3NLbmpwcGJFbm5HME1UemMveUNDVVNp?=
 =?utf-8?B?VDN1NEJTc3o5cThlRVZZQ2d4dVRVVVZqV0hMQzh2MzVXOU5UL01rM1NlNmZp?=
 =?utf-8?B?NlRpVTRpQzRxVXVGWjc0b2UxWjc1d3BvSkhjSVFVS0ZvMjJTZlRrMDBiM0NI?=
 =?utf-8?B?VytrNzE3SlhRRS9jS05vMCtIWWUrTW1aalFQUGNhaUZTRTFjTkJPTTNlVERn?=
 =?utf-8?B?NEM1S1oyMUFDQ1VSQllXN0o3dDdDampQMzUydnM0SGdMVElVclhjWjZVVDFp?=
 =?utf-8?B?L1AvR1FnQjFqZGpnYnVTV29PRSt6V1VwZ3NhTXNwRGNOdHRaVm1uaVJpdVF5?=
 =?utf-8?B?V2oyb1h3NmRoUUszWk95eVBxcVNTT0ZSSnhyNm1YUSsrNU5zaVE2UmI2dG1R?=
 =?utf-8?B?MjJlMC9YdE5zeGdRcnNPeWVCeVl1djcvVFQyY2wzL2NBTFl3RExzT2RHdzNZ?=
 =?utf-8?Q?hEv9nQ2OCbFnySO7v+pcDrOXR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f378676d-2965-4929-6482-08dc79b97772
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:14:26.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf3YCUPog35vWZKlo6gxZLio6YruSTS135lBe5uetd7OW6XyLXgp+kKA1ihiFl2Kg0yjAYfhfhTEQiwnv5c3gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

On 5/21/2024 7:06 AM, Simon Horman wrote:
> On Mon, May 20, 2024 at 06:37:08PM -0700, Shannon Nelson wrote:
>> These are a few minor fixes for the ionic driver to clean
>> up a some little things that have been waiting for attention.
>>
>> Brett Creeley (3):
>>    ionic: Pass ionic_txq_desc to ionic_tx_tso_post
>>    ionic: Mark error paths in the data path as unlikely
>>    ionic: Use netdev_name() function instead of netdev->name
>>
>> Shannon Nelson (4):
>>    ionic: fix potential irq name truncation
>>    ionic: Reset LIF device while restarting LIF
>>    ionic: only sync frag_len in first buffer of xdp
>>    ionic: fix up ionic_if.h kernel-doc issues
> 
> Hi Shannon and Brett,
> 
> All of these patches look like good improvements to me.
> However, it is only obvious to me why patch 2/7 is a bug fix
> suitable for net. Would the other patches be better targeted
> at net-next once it reopens?

Hi Simon,

As always, thanks for taking a look at the set.

All of these patches are fixing existing code, whether by cleaning up 
compiler warnings (1, 7), tweaking for slightly better code (3, 4), 
getting rid of open coding instances (5), and fixing bad behavior (2,6). 
  It seems to me these fit under the "fixes to existing code" mentioned 
in our Documentation/process/maintainer-netdev.rst guidelines.

Thanks,
sln

