Return-Path: <netdev+bounces-148601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197E79E2B9C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE9BB43EFA
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62461FA272;
	Tue,  3 Dec 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t7b39Sqz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A41F9407;
	Tue,  3 Dec 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246675; cv=fail; b=dB7RHbFYBRufnBerEDCWiPiRtLd17CcY4+/1zdPqZPYC8mmfqhABNHH4DVsVVTW/a4KrYE3H7WVFVGTYmEYbykENYLC2SEAt3leV3SbNYtquvbJZdTHuOcA2zQZG7Ki9DSyhzWEnuk2mgxHjRYaKFacx71QHOEecCI68W84sb8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246675; c=relaxed/simple;
	bh=FJbnUNAzxsUzctlpav2l2qVxHGYTMh+EO8kslByUV8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXwsTA4RvdcNhWxmDtpYrZ2wK4hMvkI4pmyHVUaIE0Rf126zEM5/8aEzjwvl650EyRrFGHI6PTimTvkICInd/kY02XHSy4+rAFE+PnSVQT8Y3pl9mhiUCCksBCjr6/fYAhgbpcTCgc/9PVXydkomA9FSNVo5O+0LTB5Htu9i4Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t7b39Sqz; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VekjIfmZtfUZ6Z1zvKMd/H8BKDMC2hKQuvAiQ1nFrUKwU0WHMwpMtGdQ5uwQBh6R0k5gESzgLVmHxdA5TCNdkqMwLs+/Cv3+cUH0ILb5gaHEn6g9XbXM7w+RKB0/eVoK85W6WuvIDeSd/NGwYAs6uFVWQ+pa7bDOPvadWtML2QlK2bb67UjN4ueWb/qNlXWVgb53OTE5U6s3Cg6Z1jdhfW3gW3BYEOVQb6D5XjPgFVLgv3KQK+1AO/vai1hrXKZ6fXFOFFZf2YjlIz6snp+L1xYPTDYlFD62hQbpzQkA5TPqnKcdtNPmnZS2W9Gh9h3nsWct6y8ET3FMdgEzC6da3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SchpqKYGLRLAR+CPVuyhBQKehntmxO2vV8KPEVAXN6c=;
 b=dGLCz5NpKfNTc/68DT7UaSzt0LI99FAvXwuBmBEGsFT45JQAhN+2PvAFd+d0T+E2fvnkTc3S2a6c1AxMAe8OQYsojd82/pYPby8tygMD5+b/n7HKM8ib+XjyJRPzJjHdVbSVSUUKmoupmK4o/lrawGHxJuFpghfxQuN+1fQ5CSP3hGRmnMg29/0croiDQoR0AUDo+V5Sd+//6EIK6mnc/mu0h9t7CRq/qNsoqxRX3aTaI6u79ZsT5HWOcvpJJXcQ1g/4NnqEB2YCoPOSbKlCrFyRyGbKorgrvrB0OV89kqTbXmidOkAM3kdw2S7eYCdhPt5CvtrmbN34JZP1Z2iBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SchpqKYGLRLAR+CPVuyhBQKehntmxO2vV8KPEVAXN6c=;
 b=t7b39SqzvPTaGIgD+ALY1XcQ/SGrdYaOXX24AsdcmVhttkwZfhzeSWzgiHBQAJxk7l47e8OiQKFoSetSCJohHvQkGpjkO+y28HC6qTijIPF2LnJ+TsfBPbgx1CSHgV/6l/JV3PIEZ1+LemKcQNAZVvwWjwFQx7m7qV0TYY2DCJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 17:24:30 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 17:24:30 +0000
Message-ID: <27ba1109-95d8-6091-5fce-bd00c68f2da1@amd.com>
Date: Tue, 3 Dec 2024 17:24:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv4] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, nifan.cxl@gmail.com
References: <20241203162112.5088-1-alucerop@amd.com>
 <20241203171430.00000d0e@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241203171430.00000d0e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 050560c9-8292-40fe-a5f2-08dd13bf58b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEp5cW04YVd4VjRIQlJwUE1qa2NNazhMTW4wWUtxc0VlZTZXMDV3UVN0bWh4?=
 =?utf-8?B?U2dEZFBJZG9KRy9SYjRONG52VDg3bHJZZmxDS2lCYlg0WGtmV2RoYytyZk95?=
 =?utf-8?B?WWlkSUhBWWxSREpwMnM5aGJuUXp4dmU4WXA4Ky9hZjk0S1BzeTIrQU1XMmc3?=
 =?utf-8?B?L0l3Wmo5T0dyYi9ySzE0TDNFNGZoSW03TURzZDloL3VvMzBvYTZhaExjRzZh?=
 =?utf-8?B?OXpHSkkrNlIvMkhQZC9zWEpSbDFxVFNoNEpLREVqaGRNMTJjby9XZEFUMGJt?=
 =?utf-8?B?bCtsVmtrUmFNZGJ1cGZMKzh1aFIrMFNiZUxNQ0lCaEhiVExYdTV4bm95dmx5?=
 =?utf-8?B?VEc2L2NIdnV6bE1vNkxVR1pzbmlicC9qSHFEUE5nSjNaeVBUbDd2L3A1QkpE?=
 =?utf-8?B?b014TkRTbnFQMVp3Zmd3NU9ObW54enhsejZ1QzVGbUl4N3dJSStzWFQ4MWZt?=
 =?utf-8?B?cTNkRWp1MmJKN0ZGUjh5ZDdDbnhCbml2a1k4bFJoWHJ2UkxoN2ZnTm9lbEVh?=
 =?utf-8?B?WSs0RytvVVRuUWREU1cva2pSNElsNXhNTHVkK2NlUndFRmlhNzNMT3ZkbFp0?=
 =?utf-8?B?WDhrRFFLQmlXdE4xOElpcEw4YjdLZDZEaEJFdmFSWjBGUklrL0IrdDViOXBj?=
 =?utf-8?B?YU42c3puSHJBQzViQUtaQzdSSE1OL2pJU0xVbStuakhPYVhhdHNhTVVFWTBJ?=
 =?utf-8?B?QmNSRjdZT3FocXROdmNQNjFqWEpMSmZkL0V2UnlhUDA4bEs0M3lKdmtsOGhp?=
 =?utf-8?B?b3AvTWY5bGwrbEViRStKQWNxNnV6Yy9SZ2JWVVJSUm5abVROeHF3akZWZTU3?=
 =?utf-8?B?bzhFMkFuMGh5S3J3TGk2YTQrN29kRTNHdFdKMHFuR3FzYm9oWGpmMzJDK1VT?=
 =?utf-8?B?M25UQ2MwV2d6aEV6S1ptWWVaM0dsSkx4ZVlxS1JHbkM1QTgrYUZIejh3S1NR?=
 =?utf-8?B?MzF1NjlUQUpMTk5BZndyR0VvVThESlVkQjdXYnVjU2c3S2FTdE1DMWZQM3o2?=
 =?utf-8?B?aE0rUHRQS0VRdUpQMXVReGpYd29hQkVGVTQ5aERWTjkvZWJsbWQ3Sm54MEFN?=
 =?utf-8?B?aGZ2alJZQ3ZDK1RHQURNS1RHWC9XK0ZUQ3R4WFM1Zm5JSk5TWENQaWRXZTlO?=
 =?utf-8?B?dXhtaHdtR1F6dnowM0lWdmhPNkZZTFFUTzBIdFpYa1NDZkplQVBWN3YvVFY2?=
 =?utf-8?B?bGYvbzFWS0grS1J6STV3azZ2SXVqTnJiTlZzeDFmaG9lUkxvMHl6ejZEdVBE?=
 =?utf-8?B?NFErUlRYa2I4ejF4d2Rzd1lzUTZEOUh5S0pteTQvdkxHdEJDcnkxUVlYcHRR?=
 =?utf-8?B?Q0F0UkhDMzJqMDM1bDJtdWIvSHk4WlYwaG0rRWF6Z0h4aURSNUIrcUlMNWRv?=
 =?utf-8?B?UFpFUzN3NFg4ak4yVEcxWFBDRDZjZ2ZsYWtnTm84K1prQjVXZ0VqZXVQcXda?=
 =?utf-8?B?OXJrY2VXMGlsbU9NTlNScUtRNGg2MFVlQU13Rm9KTnJYd3ltY1dEOUh4YnN6?=
 =?utf-8?B?NENvZTM1Y2ViSkY0eXB6TnhEOGYwVitaeHpFVDBISlFJSmFmeVZCdEx5dlI0?=
 =?utf-8?B?OTFtd1Y5Y0pFNUZxdjZwQkwvSVNaeVIyeVVXSmh0c3NLRyt3eXVkODdiSytY?=
 =?utf-8?B?VFBxMjdNT2Y3UU9hdjJsWitXMXRRQ1JER21vVWs1dUxtN0p0Tk90cWEzaHVk?=
 =?utf-8?B?T1BQK1dhVC9RZHZabkdCbUI2UisxNytwak9WRW9JSVhxc1RqblQwSXFSRVI3?=
 =?utf-8?B?U0dsY29aZWJDQXFXTFhBM0RRTmlIc3JmTnlnQmhjN1dJcS9Hc3U0THFvVFlH?=
 =?utf-8?B?eWw1aUt5dzQ2UFpoV21PUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlwT0FUQWNDc2J6elQ1QTJ5Z3FibFZZRUZtem1aVEUxNVI5YmROOVcya3pE?=
 =?utf-8?B?azZwdFBHM0F1K05mQndObnlwUjFvMlhHa3dsMXpXQzVWampuMy9wMVI0RnF6?=
 =?utf-8?B?RmMzS1NZY1gxdDBJT3hvTHU3OFlqa05OcFMyZ2tCZ20wdVJmOWtINXpueHBQ?=
 =?utf-8?B?bTIxYStvMS8vSUsra04xcjJzVVRzUVZhWW15NjBSMmppenhjRlFhcHFsQ2Zu?=
 =?utf-8?B?Nm9ja2FxMmdydlQ2a1pCYXBVTXNFVjJweFdmcmZET2hoUUNESWlGTVRXaGFs?=
 =?utf-8?B?Wm1UcVB6a0pYRGtVTHBMbG9qY25BVzBJSUt1UmdObklKVnp2MjRpdHk1VTZZ?=
 =?utf-8?B?OWVIaE5SNHp0RDJsRkdDMDhSWlgxWlJxQWkxQnJiZldBNGdKdytUUG5rY2Jm?=
 =?utf-8?B?d1RYb0Ryb2dCSGhOWXRrVTVwMVJEZkhZYzBnYW1yeGsyUkk4bUVwcXU2eEFB?=
 =?utf-8?B?RDQycWE0OEh3MUFHdDcrMXdxRHJGQnRlRjZoYS9ZTVJ1ckhRRkFuTkZ1Unps?=
 =?utf-8?B?dkd1YkRkMlFmSnpGcjVyRWN0MURhVXErbXVsN0tTOVU2WStJQ3dseVo0RzR4?=
 =?utf-8?B?YS9lSFM4c25aMUREL2FBSU9oQm5ubGVtcDlERmZyN3NPQWtmR3htMFFibVNJ?=
 =?utf-8?B?V1p5OEdtZktEU3VsVEgyTHpLSjhsV0pHNUR5ME5uRWVVWC9qcFlScHhFUGJM?=
 =?utf-8?B?cmRYcFJ0amtRUW1zekZyV0dUdFdkRlQ3Z3ZjSWVGSzlXZlpUT29vWFUyZFY5?=
 =?utf-8?B?RG00YnlkU203S1d3MlcvcE0wTHBGUk1HL1hkcHFMT0xPeWViODlCK1dZNHN1?=
 =?utf-8?B?SURSY2orUGZpc054YzN0OHhXWjRSZ0lpVWFQSU9GSFlSYTBKYWxrQkJ1VVBj?=
 =?utf-8?B?R0lZaGFRSE1DMWpuQzNxQys3Tk1nVlBUb2NUdDBzOUtTY1lZdkJMM0tjcGlV?=
 =?utf-8?B?YWF5a3JYcFBYMUhpRUt0R2RjeDVxVVVYZ01UclhZMGZybmFyaHJJQ0NFKzZE?=
 =?utf-8?B?QTcvU1puR3J5WXJNMmlHSlh1d24rOGp2bXBwRmIxUkh2LzhWY2JpT21RY0Nv?=
 =?utf-8?B?RjkzYWRyRFRxekJueEdmTENyS1plSHF5dW9SeXg2aGlUOFJPakI0TFRySkdQ?=
 =?utf-8?B?THJheWlHRzU0eWRsL3UzMTdpSkhtL2R6T1pIY0Mzc3F3VzdxNHdjT1Fob3Rh?=
 =?utf-8?B?SmdmbGlqakdpT0JTTDZ0dGNKemFzL3hDV0cvRnh4a2lXRHZIRFJaTkdzUGFZ?=
 =?utf-8?B?RjhUWUx6RGNwL3JzUEN2T0dZV3BHQ2lQeG1hUFpKOTlzdWtGbGhRcld4b3dQ?=
 =?utf-8?B?ckJPWkd4eWpEN0ZNem85d3RnUHNkRWs3Qk9adW9KdE41ZjNDMExXVldWNncy?=
 =?utf-8?B?WUFwN29OK0dWNDlYN2ZSdVdhT3dCWXNhMjRzeVh0UTdOUitsQzZySFI5MzJB?=
 =?utf-8?B?ZTRqa1habis0engvNm8wd2hpcWxDeXoyVnp1b3BlY0dRcnh3U1V4anBQK0gv?=
 =?utf-8?B?cHcrelpnMUlXTUR5ejRIZXVLR2ZJa2JuMlJ3Nk1WMFhjTjF1N1VKSldOamFw?=
 =?utf-8?B?YzhhcGEya0NXVG5rY3JPUGc5cTBFMWNVclpRSlNRY1NMUnZMTkJTNVpFaEkr?=
 =?utf-8?B?ZGN1Wk9kbWk1ZjI5TFBrYjR3UURMR0pzTG5JR3AxOWlpcy83U0xGeXFDZ1JG?=
 =?utf-8?B?bHJMdGx5bEdZNE8xTGhjbjRDdndFZEttNHEvckpzcGdueVI0a3dOenFERlNS?=
 =?utf-8?B?U0lTSGJ6STBacXk4eUZKVjJ3blBMYStVcjJFTlRkZVNmazJqR1dMdEdnWWV4?=
 =?utf-8?B?ZFI0RVVvTTBvM0src1BzZEliWkxrUDRlL2FBcFBBU2c4RXcxNGJzZ1YxMTRB?=
 =?utf-8?B?UnY4Z280UnRFN3ZEWFRqUXRXZFBrSjhZU3UxZlhOcFVoUkw4bUVzY3ZINC9r?=
 =?utf-8?B?dDJBUUt5K3J6YkkvMlpoUjRISU5NODlPOHlUYUo0UHJHUDBYSjlBZlF1aFRa?=
 =?utf-8?B?RUtweGNjVDB0UGFxN216YUxHRFE4L3hpYWhoMm1PajJJV2JMc2JXZ0hpSnZp?=
 =?utf-8?B?Szh6ZC9PWjVzS3lqTzJaYjR1cklBNGdKL01mMVRGZkxIYzNnSDI2c3RGN3Za?=
 =?utf-8?Q?dH9bAxdI3Bv63TtZvQBcQ48Uk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050560c9-8292-40fe-a5f2-08dd13bf58b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:24:30.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGT/w+uYm4WQ4aLFCTwpErhh86wX7StV0iNG0173HgJo358fx34QQ6X+1/v0K2zxWbRd3iGbGPWA7WldyXfkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252


On 12/3/24 17:14, Jonathan Cameron wrote:
> On Tue, 3 Dec 2024 16:21:12 +0000
> <alucerop@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL Type3 pci driver uses struct device driver_data for keeping
>> cxl_dev_state reference. Type1/2 drivers are not only about CXL so this
>> field should not be used when code requires cxl_dev_state to work with
>> and such a code used for Type2 support.
>>
>> Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.
>>
>> Seize the change for removing the unused cxl_port param.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> I wondered if the other places this assumption is made about drvdata
> would cause you trouble, but they seem ok for now at least as
> error handling code you probably won't use.


I think once the Type2 support is hopefully merged soon, it will be in 
the heads of all of us for avoiding this kind of uses. For the sake of 
that support, this patch is enough, but I bet we will find similar 
issues soon.


> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Thanks!


