Return-Path: <netdev+bounces-156295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B39A05F5B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D18F1888D5C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262D1F9439;
	Wed,  8 Jan 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rd4qH74u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B8A1FCCF6;
	Wed,  8 Jan 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348004; cv=fail; b=L1HjulCgI6hrQiIWPa3i8xi5wB5XJ/00f01A6JFRyVigb2uzO2TCDK9jQpIGMxbyyQvaq2D9e+3xTCrTQCrke0/Nl0IHzMEOQOW5rwBa7rRt484IMPjQi54AzJHJylxlu4bPLlDHSkfgjjUSL6xwUqaBTU81K0qNZYHWowlhQZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348004; c=relaxed/simple;
	bh=Q2JYZRtwuZSzWGTl8zej2INoJzmtQeL0C+CKStjHRWI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q3KamMri4dn3x+5DHXSNXxOXsW/OS0k6HPPmaAzZBOKp8CD92ehp01X22EakvyD9Q4bDtvAKIBuPm14VXoxPxJr7c+AvsI4WRUztTJ53LpZC4uoWJgthXpYTeyjuBM0M0CvmlpHlA4OhDzodIMnyCy31BD4Pm/qUu9A93bN+P4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rd4qH74u; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6Qq+gx37l58QkrahjycBTcOOBgHxVccQXMY89+y8ymAikD6MZvDY3xTwwqLAiGpzssZzUuEbRVG8meFVsh6vlciI3znazrKQly9RC1+Erh+wKNjNEhfXXQRF5RQVulhSQMRxuzXX7GmH0BHK3Ir58oOaSYnNz1cvoDopJipHCDKznzJvB2NRfhba+iTqJT9xQn1cREd3+UWt3eJptUjlT3z3RXaqza5NbzABuuZ8SNzdw5lod6GKGMiT2xzU+tCQK2ItP3PnAmJOHHXop0wNoqQD8mnoJjMzNvFgHUA3Jy8hzjLra5bwn24C1EqJtoCn7Rx5rtLTNEof8Y0h1unZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSV9exOO7NByDNo6IOidkg5vlb0UPerwlvo0OPwTyHo=;
 b=VPZlnEqI24UHI92PXj0ZGMcZqCywrgRzhTXJ3V970rrKxu3w86fhPEh8SvYVze9fuEGLMjiJ2FUwiwE/lN0FXQLqpa8sJ1rl/uWCzJsQZAWFJG5k9S+p/LgnqyJlyRk803mOrG1Lg/YCMeF2TF6yLAggfp1tarJyMQwwUjMyt2jMP0EDSQ96AGEWpUyUI0WYmTnw6OhFYEpVX8W7R+YdIjfTEVLuGY6tv8lrmpxQQAzYT4rmC0CNVkQwYShLkluQ740OQ4CNkwSF4VsTUJoMR4gMwPTMHHeM/+vhqqezjQdF66tGCGGjBsHLWaQu8hhC8fk40cBPMKyeF4QQ8YSf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSV9exOO7NByDNo6IOidkg5vlb0UPerwlvo0OPwTyHo=;
 b=rd4qH74uPmK0wCd2a/KQvM/NzIJFxE7z0b+3nxvoX6LpwZOds3QOuW8AeZNu2c3FdLRyHZAcBoCBafhrzyMzLH2SgX6LqASE6WhZs7b1PcFiYAOI0s3fITR+/0gFexdgsNtaUelaM2pksm3cDtmXNh5YO6nmdzLrpborgvTXtjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 14:53:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 14:53:19 +0000
Message-ID: <61d4932d-7e8e-c8d0-d782-8b15c9d86714@amd.com>
Date: Wed, 8 Jan 2025 14:53:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 02/27] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-3-alejandro.lucero-palau@amd.com>
 <677ddb432dafe_2aff429488@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <677ddb432dafe_2aff429488@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: bd058cbb-573c-4540-db80-08dd2ff430bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?US8vYmp5R1oxMlVJWEM3ejFqcEo0R1BsZlRVQURRc2EvK05RTGRzWG5ZWkVW?=
 =?utf-8?B?bEJteFhRdHBEaGgybFVxeUJ1dUxiMTRyNFRzc3IyT2NMT3puM0I5cE9rb21y?=
 =?utf-8?B?TTk4Z3d3L1owUzdwMWRTZ0FRVnFQY0RZNzVvcDB5TDVVR0xIUWNLd3RidUt0?=
 =?utf-8?B?OTYvOHZlOFVDck9vZEI3QlpQZUVMbzZJa1RDY1hVUDY5VjQraVc3K1hRWTV2?=
 =?utf-8?B?ZVhvZisyQzZMQkZtYWpZSnIxeEswY1JmalVCalBvMHE2bGJkMlhhbGVwWVpR?=
 =?utf-8?B?d2JJbHlRZ25LTGxySTBMNkFYbWlTWjFGQVlFYUs0TWR5WTJLSld6R2FsVW13?=
 =?utf-8?B?cC84a21scm44NEtFQzRyblF1QS9nMTYrUzlwRGlENDNDMXdpbFlTNXRBMXVm?=
 =?utf-8?B?STF5Z1lSTkxnVElOWG9tM0NmMXRSc3ZudUVIbkpmaVhGSEtiS1VpSHpOckpK?=
 =?utf-8?B?WkVjRXlpRURQcEpqcWE2ZXBmL0ZLN1lsVlFTSE4rZVRxTWVKdGdtSlVjUXZL?=
 =?utf-8?B?emtLUWNhWHR6U2ZjR1FQUXpzUjlQNnpsak9MWmMzeDhmUW5YOHUyNHBUWTdv?=
 =?utf-8?B?cUh0c0gvY2hrbmRmaVZzbTc3c0V5TEdDaGk4WG11SU1udGZXbkhPcXZZUHJr?=
 =?utf-8?B?R3VCOWVFRzN5QVU1RlBmT1VJcmRlcER1MmozSGp6cXowYmdlUjhDd2V1TkJ4?=
 =?utf-8?B?TDNpUGt1NGFBMjh4ekl6ZE1mRGhHaWRrakljR3QzVFAvUVNXbWlXbDNCRmR6?=
 =?utf-8?B?RlluaTRMSmNoWkJvc3FnS1dnM0pMMDZtS1ZQbktFdjdxcSsva3h4cHBmQVBW?=
 =?utf-8?B?dFVDbElsYjEvaDU5TnN3K2RnV2ZUSEYvT1Jad0pnZUZUQWJwSDVnanQ5aGpF?=
 =?utf-8?B?OXRiZ2d4cStjOHpyOVlhVFk4cjlDSk81SU1nb0U1OGRpYVJlSXdHdzdHWXlM?=
 =?utf-8?B?Zi9zK3VleW9rZUY0dG5KQnlMRTBIV0FRdkRRMEZRdnI4VjdXYjBscVBjQVEy?=
 =?utf-8?B?WWYwd3kzZFpLWnBTOUh0UW95U1l3b3BUd3JVd2lNNS8xQjNMRlRDa3FlMWxm?=
 =?utf-8?B?N3Vmd3NXT2RZNHNiVFlIeWZaTm9aRHRwTVB1cldKQnhoemJySjlGZVJaQ1ll?=
 =?utf-8?B?cUhDaXFmSXB1akd5V2d1OFEzaDdDc1ROcFplZG1CY3ErTFRrdlUvMjE4WEEv?=
 =?utf-8?B?WHBCOWkxL3RrWXZTL2pTcUlUZWROZ3dRaXVtblVnWXMvYUpiMTBBZGpHKzY2?=
 =?utf-8?B?cEVSSEJoS2QrZWswUmNDb2FIZ1R4K1FtalNrb1FxekxCRHlqb0JJM21TcFF6?=
 =?utf-8?B?NjVydjY1Q2M1em5UQlAyTmZtWXF3WC9hUXNiRURWaW13SXJHcWt6TDdQWlFG?=
 =?utf-8?B?RHFzcUJXdTRlSlpadnhSb2dMWS9LWGZDaEsvNjZ6a0RWWFpFR1hGSzdoNVVw?=
 =?utf-8?B?ekFMR2MxYStWZUxIckVXaFNraVExQWJ1WWtEN2hUTm5uUVhodDZMbDMrc1J1?=
 =?utf-8?B?VHFpSTR4YXl5d3dRZ2FmTFQ2UDloZW9pYUwyNFkrTkt2emtVQzRLMTF2YVh3?=
 =?utf-8?B?aW5Fckkrc0lWdGo5Y2JkNnExSUo1MnYrSHBBekFteXlXbE1xQzBINDQ0OTNk?=
 =?utf-8?B?cUlRdUR3bVBaUmJHWmZkWmtlYnNhdlhBUk9oREtFOHZIbldoMElRNzBiUWdS?=
 =?utf-8?B?MUVGclo1Q1dqWnJ5aEFOSnVGQXZYV2dFN09XSjFqZ29sbWM3NEt2K2l6b1gr?=
 =?utf-8?B?NHFZTUV1Z1NnREtjK3lQbFFXKzFESFZxQzl6bUFlNFNkL0pWeXEzcThNQTN5?=
 =?utf-8?B?cWVZZjl2dzhYOGxrZ204UllFdGp0U3RZVmE1Q1FXeW5tSWczQXQ0VktaTXN5?=
 =?utf-8?B?WFdOLzNwQ2dKZThzSXpQb1ZYOVpzVGJlNXZySU01Q1p2d2ZYTFM0UGRaTXhs?=
 =?utf-8?Q?BTUdHfuwXm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzdVWThQWklRdG1uTE9kbkI5cHE1VVN0NW9ackdldS9FSDMxd1E2d3ZQZThS?=
 =?utf-8?B?a3lpTElBTE8xaCtWQUg1VXptRkxxMTNFeWoxc1JsdW9LNEVCZ1hCaXhmMDNq?=
 =?utf-8?B?dVdHZDgzVU9tY3JyWlVaZ2IrUE93d2FaNlZrWXZkODZLOGhMeHgwcGlEUmc1?=
 =?utf-8?B?dUE4QUdQcHVDMjM2L0NCb1RQYU1mbkRDUEF0SjNnMXYzcjhTeWNLNFZqRWc3?=
 =?utf-8?B?RkxGdldkUkJLZjRReEFiRlQ0ekdSY2ZLUDFlT1h0WnRoQ2FsWkxLekh3Y0Ez?=
 =?utf-8?B?bU9Nak90R3g2VkQrWVhySUppVmxoK0ZoRjdock1zUXhYSSttZFoxYXFDU09J?=
 =?utf-8?B?bnhEYk5OOC9VYnNrQnBxQ21CK0hYRW1USkd5dUdycTNMRzI1eCt0aDVQOTU2?=
 =?utf-8?B?MDU5VE9LdjBiZGJxditJcDd2dTZzaUNraHkyOGJ1blViSkJ0NEFXSXpXUWl0?=
 =?utf-8?B?Y3oxK2x4bDI1S2V0MXV6NzNFVHBrb2IrOUozYXlvY3JIT0hxTy9nL0drdndG?=
 =?utf-8?B?Mi93cGVPZmpFeHFzNkRnN2NzNHM4dXhIaXdIYnZJd21WTGJxOUg2YWlqbDVs?=
 =?utf-8?B?bGVEdWxaVk9pQmlmalplZmQwdWU0c0k2M0NzQmZMVEhhU0ZwOWJqVjlDVW9i?=
 =?utf-8?B?K3pEeEhYL1J5UFB2cTdoSDh6TXUyNEluQUR0c0VmdVpyYVJjMzZGMDJYMGNI?=
 =?utf-8?B?VExsNXJqQ0tPZEFJUGc1YkZIK3BZTWdpUE4rUnlPR2hIZWUybC82a0VTUE4v?=
 =?utf-8?B?K3YyVzA0eHdlVDNMRzVBaHM5aE1ERGVmeGd3UGphQkFaOXJIeFRqbHdxa3U0?=
 =?utf-8?B?T2libEJaV25zTnRJWlZtMXBKa29OMlgrZWQwUUNRUm5MMmNxUlBMQ0k5YVlw?=
 =?utf-8?B?Zmp4cHNmZFo0VFhOY01Cdkk2N3gvUDI2RVE2U2JkV0FTT2R6QmEzbnFzS0Zq?=
 =?utf-8?B?QjhFRldDSXRtZnZkWnB4eElNMDlIVVdMZThyeUVBMWR2RGdCUUxYZ1Jmc0Ns?=
 =?utf-8?B?OEt4UzVocVZld3YrT3RqM2dTZzVTeEt4K0E1V2g2aTVySE1BTXZ5QjMvRy9z?=
 =?utf-8?B?WkpEYnBDbm1UV29Sazdsb2R4ekxUVlhIWmxldHdxRTJjQWRTL0diYzdqSjl6?=
 =?utf-8?B?b0Zhdk9aazRmTzZZakVJQ3RqQjZSYWFCOHdMTGxxZ3ZZTHM0UXA5SVpVNm5V?=
 =?utf-8?B?Mmg0TXR2d21penhJODJKRlNkMk5ydFI1L1o2aHRqbVR6ZisvZWdoY3RKeWlJ?=
 =?utf-8?B?RzdwV0hnYlNRcXUvbWtZbUloNGFBcTNBY2NWdkUvTzVBK0xVaVhPTWlaNzcx?=
 =?utf-8?B?WFJsNUlWVzhpUFZHUEZ2ZHVuRTFCK2xGUXc4Q0VFbFdrb2orbkFSTXg3RXQ2?=
 =?utf-8?B?amQwQkhHeTZkV0VWSlhWMmtzUTZ5L3JidXE1ck42OFVlMnU4S0lRd3lOdnpq?=
 =?utf-8?B?ZVVKUlBHSkEwVUZKNU1tNHdIZFIxVm9YdmtHNHRBTWZteXcrU05oVFJ3OWd1?=
 =?utf-8?B?NkEzb3k1L3kvMWZGdnVZSUJ1bU43RzRqSDhlTEhiTzllSXFQRjNyK1oveFVM?=
 =?utf-8?B?NlpidHB4eHRHZXMxbENJcVBNT3ZxOS82UkZKRTNxZ2VTU0U0MWpVNEp5MzhX?=
 =?utf-8?B?YVVIU2Q1WGhFdUNBZ0QwWkNmM0NWUXZyeXZmby9oWlFheFYvbktOSzF0cjMv?=
 =?utf-8?B?OXRld2pKS1VTYy8wTzJNaHErKzdtaHN5ZjlLNndYaFV0bE5aQldpYVdicnQy?=
 =?utf-8?B?MWpyRzVPaFUwdG45T0p6L0lKTXNaUXFNSGZIcXRUcEZQYVh2andNbTV2NjU0?=
 =?utf-8?B?cHBsYnJxZ3ZzZTN1ejJ3ejVkaUZGcVZoZWY5S3UzWis3N0JVKzd6ZVNjbjFT?=
 =?utf-8?B?SWRRY1I1MVM0N3NxNEdDcTY3Q1g5U0FlbmNOd1R6aENNT2pMc0FRTVhPVkJO?=
 =?utf-8?B?cU5UelhrRC9JaGViRTJzSzBONUViVHJHRFcrK1RldWttSUQ5RnBKR1laWFZJ?=
 =?utf-8?B?RXIwcEZVVkRHOXZyTWw0WlExNWJOWGNzcGhOaS91MzIra1JtLzNQVmNGeW5R?=
 =?utf-8?B?NnNVOXIybmQ5VEx3YmJhTXJOQ3YwTnZ6VDJDZjExY0wwdTQ0NldWWTBzbTEw?=
 =?utf-8?Q?wYhFbDVqLf0qkItjB8/wp1UR1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd058cbb-573c-4540-db80-08dd2ff430bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:53:19.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDgSNOFblAyzG7sQO6kGuyn5w52tTkgCx9HFHn76MN9zS5aN6DnGzw8zGMUVPU5lwxLaukq/yYqFFt4gDEX9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173


On 1/8/25 01:56, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  7 +++
>>   drivers/net/ethernet/sfc/Makefile     |  1 +
>>   drivers/net/ethernet/sfc/efx.c        | 23 ++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 87 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
>>   drivers/net/ethernet/sfc/net_driver.h | 10 +++
>>   6 files changed, 155 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index 3eb55dcfa8a6..a8bc777baa95 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -65,6 +65,13 @@ config SFC_MCDI_LOGGING
>>   	  Driver-Interface) commands and responses, allowing debugging of
>>   	  driver/firmware interaction.  The tracing is actually enabled by
>>   	  a sysfs file 'mcdi_logging' under the PCI device.
>> +config SFC_CXL
>> +	bool "Solarflare SFC9100-family CXL support"
>> +	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
>> +	default y
>
> This looks a bit messy, how about:
>
> depends on SFC
> depends on CXL_BUS >= SFC
> default SFC
>
> ...where the "depends on SFC" line could be deleted if this other
> "depends on SFC" options in this file are all moved under an "if SFC"
> section.
>
> ...where the "CXL_BUS >= SFC" is the canonical way to represent the
> "only build me if my core library is built-in or I am also a dynamic
> module".
>
> ...and where "default SFC" is a bit clearer that this is a "non-optional
> functionality of the SFC driver", not "non-optional functionality of the
> wider kernel".
>
> Noted that all of the above is inconsistent with the existing style in
> this file, I still think it's a worthwhile cleanup.
>
>
>> +	help
>> +	  This enables CXL support by the driver relying on kernel support
>> +	  and hardware support.
> That feels like an "information free" help text. Given this
> capability auto-enables shouldn't the help text be giving some direction
> about when someone would want to turn it off? Or maybe reconsider making
> it "default y" if this is really functionality that someone should
> conciously opt-in to?
>
> Otherwise if it auto-enables and you do not expect anyone to turn it
> off, just disable the prompt for this by removing the help text and
> making it purely and automatic parameter.
>
>>   source "drivers/net/ethernet/sfc/falcon/Kconfig"
>>   source "drivers/net/ethernet/sfc/siena/Kconfig"
>> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
>> index 8f446b9bd5ee..e909cafd5908 100644
>> --- a/drivers/net/ethernet/sfc/Makefile
>> +++ b/drivers/net/ethernet/sfc/Makefile
>> @@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>>                              mae.o tc.o tc_bindings.o tc_counters.o \
>>                              tc_encap_actions.o tc_conntrack.o
>>   
>> +sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
>>   obj-$(CONFIG_SFC)	+= sfc.o
>>   
>>   obj-$(CONFIG_SFC_FALCON) += falcon/
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 650136dfc642..ef9bae88df6a 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -34,6 +34,9 @@
>>   #include "selftest.h"
>>   #include "sriov.h"
>>   #include "efx_devlink.h"
>> +#ifdef CONFIG_SFC_CXL
>> +#include "efx_cxl.h"
>> +#endif
> Just unconditionally include this...
>
>>   
>>   #include "mcdi_port_common.h"
>>   #include "mcdi_pcol.h"
>> @@ -1004,12 +1007,17 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_pci_remove_main(efx);
>>   
>>   	efx_fini_io(efx);
>> +
>> +	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +#ifdef CONFIG_SFC_CXL
>> +	efx_cxl_exit(probe_data);
>> +#endif
> ...and add a section in efx_cxl.h that does:
>
> #ifdef CONFIG_SFC_CXL
> void efx_cxl_exit(struct efx_probe_data *probe_data);
> #else /* CONFIG_SFC_CXL */
> static inline void efx_cxl_exit(struct efx_probe_data *probe_data) { }
> #endif
>
> ...to meet the "no ifdef in C files" coding style guidance.
>
>
>> +
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>>   	efx_fini_devlink_and_unlock(efx);
>>   	efx_fini_struct(efx);
>>   	free_netdev(efx->net_dev);
>> -	probe_data = container_of(efx, struct efx_probe_data, efx);
>>   	kfree(probe_data);
>>   };
>>   
>> @@ -1214,6 +1222,16 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	if (rc)
>>   		goto fail2;
>>   
>> +#ifdef CONFIG_SFC_CXL
>> +	/* A successful cxl initialization implies a CXL region created to be
>> +	 * used for PIO buffers. If there is no CXL support, or initialization
>> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
>> +	 * defined at specific PCI BAR regions will be used.
>> +	 */
>> +	rc = efx_cxl_init(probe_data);
>> +	if (rc)
>> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
>> +#endif
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
>> @@ -1485,3 +1503,6 @@ MODULE_AUTHOR("Solarflare Communications and "
>>   MODULE_DESCRIPTION("Solarflare network driver");
>>   MODULE_LICENSE("GPL");
>>   MODULE_DEVICE_TABLE(pci, efx_pci_table);
>> +#ifdef CONFIG_SFC_CXL
>> +MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
> No, endpoint drivers should not need softdep for cxl core modules.
> Primarily because this does nothing to ensure platform CXL
> capability-enumeration relative to PCI driver loading, and because half
> of those softdeps in that statement are redundant or broken.
>
> - cxl_core is already a dependency due to link time dependencies
> - cxl_port merely being loaded does nothing to enforce that port probing
>    is complete by the time the driver loads. Instead the driver needs to
>    use EPROBE_DEFER to wait for CXL enumeration, or it needs to use the
>    scheme that cxl_pci uses which is register a memdev and teach userspace
>    to wait for that memdev attaching to its driver event as the "CXL memory
>    is now available" event.
> - cxl_acpi is a platform specific implementation detail. When / if a
>    non-ACPI platform ever adds CXL support it would be broken if every
>    endpoint softdep line needed to then be updated
> - cxl-mem is misspelled cxl_mem and likely is not having any effect.
>
> In short, if you delete this line and something breaks then it needs to
> be fixed in code and not module dependencies.


It has been a while since I worked on this part, so I need to put my 
mind back, but with the right softdeps the driver initialization does 
not fail due to the CXL modules not being loaded yet.

With a softdep for cxl_port, which is the problem here, and with 
cxl_port having a dependency for cxl_core, I would say everything the 
driver needs should be there at the time the sfc driver is loaded. I 
agree cxl_acpi could be a problem because it is architecture dependent, 
and I need to see the cxl_mem dependency which is obviously unclear 
after you spotting the typo.

In other words, I need to think about all this again and perform some 
testing. This was implemented after the problems you solved regarding 
the loading dependencies and enumeration delays, and from our discussion 
then, I though EPROBE_DEFER was not needed for solving this.


Thanks anyway.



