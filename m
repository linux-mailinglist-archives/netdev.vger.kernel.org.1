Return-Path: <netdev+bounces-188939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3BAAAF7A4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B664C0ADE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2818CBE65;
	Thu,  8 May 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ANj+p/ZA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD64A957;
	Thu,  8 May 2025 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746699554; cv=fail; b=uFmdDuGbSlahCS+hDB4C6Cbujc4biuIsrEkj9eKMD3cjosWWQ2EcKl4Hg+Tn/WYsWSTW7uQhVLGue5vYA8C0Lg9IrBahtKB61XOMOmjSnXQX5eELhJE6Al1fQCE9KqWVgQVRTcyLR3S97TJZ8uuTX5+FHdoIOY0jcb/ecS039ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746699554; c=relaxed/simple;
	bh=fhxTGDc6efkHlT30wWPrPx5TIMwvnioRqhMDbW8VLQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=meNTb7+ZIES6XZmMEPMocJvG0XywshNR/d6omVLmx/FUGm771NfANyWtjvx6eX/DEEIFpmES9BZ9iwsNj9HbblK7C4I4SqUujktljakghVzOYEWCj+IeNQICRrkoAtRzBG1OGXMfHChTO0isXhs+rxN5FrtcSTLZi1AWoZJvfpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ANj+p/ZA; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGSzkmXLj8LLt+6P4Z1bqv7UcjeqsGAHfQ9lX373vquAIepIxOlMkuu5NsslhVkhu8nyVZ1tW4DWYGppLLPljUJ3xkt+TGUl7tFVckL19BoBvlwzJCHUsXGbZ7zD+mE2wsfAGvrkCrF6yPGqsHf3bVvNX8lVm3STkITRZIDZM35DVi0U46/4+P/UeqhmOMaF6NmoJd4C5ts+HsrfmLli4j+D//LkU05+NRsUfTR10e3ufhsDaYfFoqWRx9rGI0VG9gQp0hex7KTWvBpOMxsDKXuoa1qIyHjTj68jQuklpBno1YFLJ1OqWdAqxm5ExNQKwncmyQcRdBEl3iXw/gVr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wyMTooIHr6vjeWhCb8FCthSeQLBbJsLpK8RzUvkOn4=;
 b=VN/eNjgfoelO1YOUH/5D+m/tAMYX5k7u4B/uIGlsTwCBZllK8WhvW1vB6HrHCcw0J9hCYNpYVclABGi0IgTcW562mQysAf6yz/pWaXTDTMzbgLnfi7egLFO6LvP//N0M12RaRDNgNdfW+GZwzazYTiAwp+OAVQjQJyQKBvcN+E49F2qQ2wxQXyl7zHOTdEVsC2sOMUzcFQaLSxblwopi3Ys5BT4aharz2MVyJOQIBSXPVzaN1XT3NKFH+1/OCVsM71AI5dEA1yb3vgAbBZZSYD7OQlyGKTGuoy432BFaj/wnO2Nqn8cyhbzjysasGfQwizshZNSthWUDIqIGCK/XKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wyMTooIHr6vjeWhCb8FCthSeQLBbJsLpK8RzUvkOn4=;
 b=ANj+p/ZA5G57tUKMAGL+hXxfB6ixhSb5pDm2OG8b3iTjO/mVd+PiFqvE+t30kpSz49J059/YwazL7ZVY037bnGAWMP+D3ecb9Tb3M6inO4XFpqMhPOITZTmoq8o/VMM0asncX6KX3Ez7IM4N2XN8VH282aUeT0HLuDXF58Jkm3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 10:19:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 10:19:07 +0000
Message-ID: <291cb69e-9018-4c7e-a6e0-ee6b4b475bf7@amd.com>
Date: Thu, 8 May 2025 11:19:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/22] cxl: add type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-2-alejandro.lucero-palau@amd.com>
 <aBv59PLYPD4MeDrE@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBv59PLYPD4MeDrE@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0251.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e53e5fa-c22b-4d39-b0c5-08dd8e19c441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RC9VNEc2bWt3SWpXdjRjSkd1bThiNU95L1grYWJGNXZHWGozOWZoL2FUWXll?=
 =?utf-8?B?bEdwcWhzM05vTEdTaEF2Q0VOa2FaVUpoMkgyVlQwQlRTSDE3WjlwdWNHYjEy?=
 =?utf-8?B?bGk0MmpTNTNuTDhhSEhhckthRnNBYjNCS3BYTTVFVFVSL1RuVXpoQjdaa2dT?=
 =?utf-8?B?WlhaWWlJcDdaQWZ4NkhlQnY3aVBwZE9IeS90SjNrYWk5cDkxZTNPWVN3K1p0?=
 =?utf-8?B?WmRuazIxS3krUUlUdnhxTUNqQzBuZzBwNHB4SmpHSUh4dUw5TERkMWJWdWVl?=
 =?utf-8?B?Z3gxZVlva2w3ekp0M0pFeFNuRFRUT0I4UVJDRVlkYTRFdndLTkMrbUQrZXNX?=
 =?utf-8?B?Zkx4TytGS0JneDBxaVNiclgwdUZ6NU1IQmhNZGxlRWxrK2pwenU3REdydlYr?=
 =?utf-8?B?ckxxN0ZPZjdyaVdmbzl2c2MveW9YRlozbWlTWHJFRWZ2QlNkWGNQbDVhZVVD?=
 =?utf-8?B?d2xXb1RLczBQRzZEU3YvTTk0dHZVUFpRQU5WM0JFRUY1aGtTTE8zSTJjaEd3?=
 =?utf-8?B?L3NZQ2xDU0hmWlJ3L2pxazREVEFPNXpsclVhRXh5SG9PemJWM2FYSlY3SFM1?=
 =?utf-8?B?aEJLZjJ3a0VyeGJ2WnVlVG5jeVM2MnJhR3VPWU4wdEh4akdqMXo3dVo5QzJv?=
 =?utf-8?B?YXJ3Z1VDZ253L1BFRmM5VkFuQytWRU5mbzBzeEZzUldiQ01mSXhCWmtiNnhE?=
 =?utf-8?B?ZjRKZkNvVlZSYTIrNUQ1Y0hBeUJGNE5wbTF2QUEyUjd4amhCYjJCdWJtdDkw?=
 =?utf-8?B?dDM5NkdoeUdxL2xHL3VXQ0JnZGdDSFF1eC83a09XOUpQcWNQd2VsUU5JNjVD?=
 =?utf-8?B?dGgrbHZ5NXNJRTZjRlhlS2pvMTVyNVpkdUFoU240WG1BcHVEeDVvWmNkN2JC?=
 =?utf-8?B?R3Npd2ZpZElkWDBod2VZZzFCdndOc24wSUVQVVFOVDNISmZPelN4aEZ1UlQv?=
 =?utf-8?B?QVdDNnBaZHpFYWw3d0lTUlc4RFhTbUk4NS90dm15YjdIZFNsZUZNd2gxSXM0?=
 =?utf-8?B?WVNkN0p4ZEtjTS90cWxDQWFQd08vc2RYVTJqVzJqdS9nK2J0UnJPc1pmdktX?=
 =?utf-8?B?c2hsNy9pY2lheGxGRUJ0WFFHWHpjZ013VGlkZUg1aTNqalR3c0tYK0l3WUJO?=
 =?utf-8?B?ZkJRd240SFRNYTlDaDREN0N2aE5HMkwrNkU3U1BML0NVUWE5YmEwUVB2bmpE?=
 =?utf-8?B?R0cxayt1K1B2VmVJL1BQMUJtRFg1WERaNzd3VWR3WDh6TnpIUm1ZcHUyZDRG?=
 =?utf-8?B?ZEx5T05QY3YxVUJHMnRmMmtoV1dtV0lGZ0xrWko4U3hSVmk1QU00WnhSeW9o?=
 =?utf-8?B?OVEwbFhNcFFCRWUvM2pxUmFlcVhLMk1KZXNtQVRUeThwdE50a3owN21JVTY1?=
 =?utf-8?B?ZXR0OEZpcEFYZmI1d1NPMkduSDg4TXBTYU1UZ2F5Mm96ZDRiMEdoNjQvWkV2?=
 =?utf-8?B?Z2FLL2oxRGVPSnVZMEJGNXROUGR3TTI0QkhUWnFlYjFKSXVpQVVFWVhUcjdi?=
 =?utf-8?B?UW9UUkZkdzVzV3VtS2tBdVFFV0pmVDlxMUROdnZtdHU4TUw3RkkxWVhCS2pa?=
 =?utf-8?B?Q1M0QkZkTzdhKzM1d2syZXltcTlnQWJ6WmlodVBqMWlnZUdRWHRIa1hPK1Bq?=
 =?utf-8?B?c1kzbFNFc2Z6Mmp4NllHSERrdGtxbVVyZDRHL1IvbEs4WmhYVGFTeHpHS2Nu?=
 =?utf-8?B?V05uWStDa1FXUUgrNjlNdi9GZ2d2dm93cEdvRm1WQWdHZlpmaEROemZ0bzZt?=
 =?utf-8?B?U3BvaGxNT05RUnRCKzYrWXQrSHZ6akRGNWl5azZxTm01am1ZU041ZDlPSkYy?=
 =?utf-8?B?Wm5JS2lRVGR2WUwyVEdpU2JyUG1QSVRnVlFIT2hPSEFHdVRtMUo4RDcrSXpR?=
 =?utf-8?B?UmppcW5yaFQxdmRqNENkL1lqazZSWnlBNVk4RDNWSzdMR01QOTI5WmQ1ZjN5?=
 =?utf-8?Q?WGXETwYL8z0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHRRMFNQd2Z4dWRGaS9mT2JJSXBQNVhCMG9WRzgzdVYxWDhyS3h5OHdIL0kx?=
 =?utf-8?B?UGVsVXFPWmZhb0RhWXh2cURpSUhtZGo3dmtiOHRVZFMzdkp2RUlxcjkwelVE?=
 =?utf-8?B?Rmcxbms5ZkRhaXR3TkxvNUR1Q1JQUUdkSUNCRFQ2RnZXSzg4WlRlaGhIazhM?=
 =?utf-8?B?bmxBM1o3T1VSYUVsRDFKT0dhZlgwbUJqOFNSallaUmZEQ3pYQTZrMXgrMmZJ?=
 =?utf-8?B?WGliZmhMcGZSUUlvSzZ1RmtIZVI5T3RCa09lTnZSbyttczJmSjZZaVBsVFkx?=
 =?utf-8?B?NWlLMG11YkZkSUJ4b3QxU3dtZ0x2bjNyM0RGcXNGdC84dzVaSXA4UDBKeHZX?=
 =?utf-8?B?Sk9kY2Q3TjQrSHFYeU5ZeVBzZG05U3N2cXZyMzIzUHJjdHFoMW5xVjl1MFpu?=
 =?utf-8?B?VW9uUDRucnRvTHNCSllsY2Z1aDdwNlRuVWJjMHpvMHhUdTZ6UXpFbkhLblpD?=
 =?utf-8?B?NW5JKys3SFRFL0pBRFltZUo5ZTRFejdURHB1ZWtQS0FqWnlCQ1ZKek04ZU84?=
 =?utf-8?B?V2JCS0FPLzMveFliVmo0ekxuNDB1WWd6Vi9tTHRNWSt2SXZab1BXQVVhc3hu?=
 =?utf-8?B?c0MyNnlqQ2JlcUlTM1l4WllCN1NyMmJtVlJsays5bXIyLzMyT2Y2Ym1Td0VB?=
 =?utf-8?B?SlBMVWpDd01NaTB2SHlHZmVOQ2RucnIxaWtBK0Rnd05VYkJ3TXRwdGQwengx?=
 =?utf-8?B?QVBFZ3h1SHJxZTVLc2pNaHduak9IVUoxZUU0akxJdlNxMkkvQ3hHbEZOOHdM?=
 =?utf-8?B?Nm5ZNWMrUms1OHhnRVcvVzVTN0JJU2Q5VEwxbjlucUx5eVhLdW1UUXdrSzJS?=
 =?utf-8?B?UXBsTTduSm5QTmhkUXRtOFdrYUQ4TExGcmg3YWxWZVZDQ2RnaU1IUG0zYlJT?=
 =?utf-8?B?ZHhYQWlrZ1FDbzB5QitVQ3dDYi85eE5GWmh6cGkyeEFRVHE1eC9mSkFGbFph?=
 =?utf-8?B?djBVN0tkZUh1aTNyWWt6ZStNcnVEa292WVQxb21hdUtxWWcwdGthK255NHh5?=
 =?utf-8?B?V0lvZW9aQXVyK2tYTmxnbmx3a0tYSk1ESjBsbmdXclFiRndUUU1UY21WNmdY?=
 =?utf-8?B?eGZ6b2s1N3F4Zm1DdGhlVzB4ZWpDQUV2Z004UzFhOHBrV0pmckdiaCtQT25y?=
 =?utf-8?B?NTJubHJhVWNmYlR4a0cvVy9lNDhaRHk5T1NEYTdsRW9udXBjbGJDQllqbmNm?=
 =?utf-8?B?anVzcjhTQUJCazl0SlBySE9XcWZBRGdHaTJPMlk1OW5YRTdVK1l3N3Eycjky?=
 =?utf-8?B?cWVBOUVOSXozNjJHQkEvcGp3TjNlTHRVMWhaWldoNjlMc0V1bEVURWRnZnY5?=
 =?utf-8?B?QmdjMEZSTnY4dHB5K0dUU1plSmhQOVZHS0pHQ0pFa1A2YXI1d3VyaXhEZGhq?=
 =?utf-8?B?ZGQzZmZaMDdLbFJhQmtQcFFBWTVxN3BGbEorcWQyT2FvRnlRN09MQUtDcFVn?=
 =?utf-8?B?ZmpVZmVFdUw2Nm53UHhibEVhYjYycnRQc3IxR1ladldMQ2FRdVpCNjZWSm5T?=
 =?utf-8?B?dTY1Vy9PZE50VWliZE1zUWRyc2VQQjJoOFJ6VTJqS3duTXQzSm9iY09DRllO?=
 =?utf-8?B?N0h3K2p0RXJqOVd4azVBSEgrMW1KdzdyYWxwMDlmL0VRNDNnMEwraUJXd3hq?=
 =?utf-8?B?MWhoUzFvNElWQkJxdUNTcmpXTHR3WEZvTXBmNUtSOFowQUM3RE1heVpFeklB?=
 =?utf-8?B?U1hTVXoydUN4RGIxSEtPbytwSmZnZFJDZWZycThHbCtMNVBTTng4SHFNYURD?=
 =?utf-8?B?V2dFQkRiTGt6cWFsOXZsYmtsb2xKS1VQVzNsMmxHSGJuN0ZSdk5nV09ZZG02?=
 =?utf-8?B?Nlg2a1NKTG1FZnJldGdmTGtBQ3lISU5GYWFkbHU1K1FwOU5pRmZxMU81aXRY?=
 =?utf-8?B?YXBjdEZ1eGdnL2JVaDRqWTExZ3VmeUc2MWluQVBVRmh5MzE2aFg2Q0xxVDRM?=
 =?utf-8?B?d1pia2oyQUpyNXQrSUhZYjcrTlkrVlhCSGhWbFRFSENsb0YwcWJORUxYZUxB?=
 =?utf-8?B?NjVudGhPbkdJQXRlUnBQNEdCbm10ZmwzYkxsdWV2em5ScWxtU0lzVFAwNTcx?=
 =?utf-8?B?QURTWE1xbHhQbWNMbk9SUnFEVmJYMmhFajM4OWFONm1IU3l1OW5ndHluSUQx?=
 =?utf-8?Q?iggxLtF2mlNYPKjBAjyQ1sgcd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e53e5fa-c22b-4d39-b0c5-08dd8e19c441
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:19:07.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shgSG2wqcB425Wo2GF9q3jVbDoAJfQQ2VzF23DFXCl3mDD9PGcY0NVVrmpcwQ+kFCOK2f2yFad2jndyS0d8iwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935


On 5/8/25 01:25, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:04PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> snip
>
>
>> +
>> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
>> +					    enum cxl_devtype type, u64 serial,
>> +					    u16 dvsec, size_t size,
>> +					    bool has_mbox);
>> +
>> +#define cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
>> +	({										\
>> +		static_assert(__same_type(struct cxl_dev_state,				\
>> +			      ((drv_struct *)NULL)->member));				\
>> +		static_assert(offsetof(drv_struct, member) == 0);			\
>> +		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
>> +						      sizeof(drv_struct), mbox);	\
>> +	})
> I spent a bit of time unravelling this macro and came to understand that
> as a macro it can enforce compile time correctness, and that is all good.
> However, a comment would be appreciated.
> Perhaps: Safely create and cast a cxl dev state embedded in a driver
> specific struct. Introduced for Type 2 driver support.
>
I can do that. Note that the commit refers to the change due to type2 
support, but I can add also your suggestion at the macro definition.

Thank you


