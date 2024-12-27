Return-Path: <netdev+bounces-154340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4079FD1D4
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 09:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5593A03C1
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383178615A;
	Fri, 27 Dec 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rKJfJDWm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D11876;
	Fri, 27 Dec 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286938; cv=fail; b=NZKL+yb/8WyEbdjA26JBYkX3Bf/qJ31AomTOKCNuTBmVW1VfLoBZ089kUAdDbx1T/Cp4nCDp4tYj7/QezcwEyLm3hnAk+b5w0QVYWCGZpnv6u0Si/p2SGhho7GqaSTgOasanfXHMvaGMgM4z/e3yDdQJDXLBeQrgMwjrYlbxEdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286938; c=relaxed/simple;
	bh=FsoRJ2a5cmiyp99NKTBZL6Hj4sLy9x2pRo89s/H460c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dDi7/pb6y8oJTZimiMSdL4JIgTbq8TSb5KZvT5byybv3NxGDWPYDrUpKCjBTuR9VLPZZiQkgTRjssstpmZUOdyPwVqgDqYKswBOVt2Cizt3vCrESV8SU1Q78NrunQcvSpyREsfp2EXIelufMQLuWz9cqp7sBFP7J+rViW+cBkPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rKJfJDWm; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDEHAgHtEtSUys2E9/+Nuv32KMhtoaT3UdN6Xpwh0waSgdnfvWpL+nhGCcQtkpoHQfMVxfAQ56Dzzp/idjq83L35duFQ8dsRba4owR5HxFCM2Okb1xUoxLPSDNmqhtf78+t0kZX41ZzHEiOqvWoRW20EgFvb5D2Hvaqlo9G0IAo30n9r3+sevwMrmxt9fS9Vg+qoNTq6sLZ9JtLLFPjGW9MPboY6pAIpe3J5adQ5qIreXG5Voq91eT9YcMs0LCH80KB9U+vP6RDrqYvIBlt39tn36sg/SgcdpEZIagWunvirpBZUZ1CMRrvj1KUMXDK7D1JEMAx4BCCzoF3IR84h4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nau2Rd80YyURvRMvpPlzUE9fXjcC+YT1X/UGT0tAujA=;
 b=Oba2WQoKrjClx3Ljp+7OuCUnonXpcuab6Kcu62I8h6GDrQuQuWkruDkweW6ls0htybAWC3ex1VpMVvRVLf96tDjq49jKhWGpxVVMFw5v9q9tsXJbexNSkUliO0t1QYPlAQTYbQEvXeOaZGabsQe/9WVrLACMK/GOqShY0BO7LydZ5tUUBEKWFJsL5/D2eOyUrGoELEd6F3HkffhkuVmndkJ4fzupBcpar4otobtUjf05Kk7zNlgM3mz6G/Cqz1G+SUA1q5R8Nh4BcYGLkn0QawGjNZr5Tp2JYNA6ts6MwDPa7HOBmcA4m0/MHb5FUSln0UiJ/qT3FtX/LVYFQ4k7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nau2Rd80YyURvRMvpPlzUE9fXjcC+YT1X/UGT0tAujA=;
 b=rKJfJDWmxUD1zuvFooAqPeI9xUO2l76zJMED656cMuOilLMt2NrCGk5LJoLmdr6hfgM/ye1VE3VQlMXLAZm/POIMGMSJLFxDvTl8M1ykD+HKiDkGyCGZDt1fRsiQpBuY4Vn1AdhK/KFnnrvaFnd/cc7N4oqURHWIM1GbFdi6tc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 08:08:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 08:08:50 +0000
Message-ID: <69033618-a872-1c3a-3f28-552603cedd8e@amd.com>
Date: Fri, 27 Dec 2024 08:08:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 11/27] cxl: add function for setting media ready by a
 driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-12-alejandro.lucero-palau@amd.com>
 <20241224172916.000024f2@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224172916.000024f2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a5c3b1-20e4-415f-8e18-08dd264db250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEh3cnpWMkRPZ2N4WUh1akNnelp4ZG1peER0WWkxTmk3L2UydnJ6Mzh3ZlFx?=
 =?utf-8?B?VTZTTFFDaERlamN2Z3hTN3JJemliMDdLZ0h3SXdCQmFhVlBUc2xlLy9ZTWxT?=
 =?utf-8?B?STF6b2dEcjNCR1E4YzkzVDVkVjJZeE9GS0ppS2ZRbUMzQmVnenFpc09uWklP?=
 =?utf-8?B?dzQzYkVWdytpdElmOVFpdStNMHZPeGlWOUpDbVhUMXZjUURQRVJrdW9rUXBa?=
 =?utf-8?B?aE1TbTB1Zlhnc3NKa2F0cWE1TVRObGU2cnhIZDE4NU5UNldGb2ZTdHRaMkV3?=
 =?utf-8?B?cVQyZjVQS2hWSDBmSmZvNWkxTU8xWURBeStsMEU1SkF3Q2tZb2duN2J4ZGNV?=
 =?utf-8?B?MHJZOVUxRStPejVtZDlCQUhnU2JCeWRJcmx3K2pSUzROU25XN1JYTUtyeDlL?=
 =?utf-8?B?MU1TbUVVaThkYk9FUkJsY1lOUythNWk3dXRMYmU5SEdVUlRydjRRUWM1MFk5?=
 =?utf-8?B?NVNaYjc0ZWNZa0k3dHI4aFZuZytYdTIydmdTZmxMb3RtNEtUekY5TWQzZ2Ev?=
 =?utf-8?B?dFVMTFdxN2hzZE01TGlVcjdLY1M2VkgwYWhlNEFKS2FmQ3h2VktRT3lWZ3Vh?=
 =?utf-8?B?NmFtaW54VkE0cVZiYnVxRDhWa2lGVEszeXFUSHVQblZObUk4eEFqWFVMa09n?=
 =?utf-8?B?UnBKSllYTEw5aW9GYUt2b2o1SWdiM1FxNHh1V3lNblI0RFNla0V5amdzbW96?=
 =?utf-8?B?cGNHckhuTVN6SUdjVldGQmt0cTBPUHRjVVNLRHJhMnRMYVpnUTlRSnJheENZ?=
 =?utf-8?B?Z0tuRGRLRFV0aUNhVVVwSXNvaHZuYUxTNGNjdjlQZ1U3NzRYNFNyMDhZYjYr?=
 =?utf-8?B?dllYR2RPVHhQUWZxQllqYWJ0Z3dxOTYvY0tIZkJ4T1JlSmVEOVNVZGNxWlBF?=
 =?utf-8?B?MjJhTjlxQStpRks2eGhlNXUxRlNZY3VuTXZwaGJCZlN3djZGZ1dIMTl1VGVB?=
 =?utf-8?B?eHEzbnpPSzNwUU0yQzRMY1dpMWdJeG9USGZ4N3RFb3NZRVI3Ymw2M3U2dnlB?=
 =?utf-8?B?SVhCTjMyZm1IQWg0YXdEMXdJK3Y3bXA1MUtWbFkzQkZMeDdibWFJRENnamw3?=
 =?utf-8?B?RURacmFINXZGVlpVOWl5OFRiY3QzMWpkcTdYMEVRR0w2NUpVSjJvb1RKT0Zt?=
 =?utf-8?B?Qy9iZ3lnVmlMVFYzZm1Ra09GLzdhM2gvbE53SWNFdUVyY1NLQmhwT1gwbTZW?=
 =?utf-8?B?WHBQcG51UXdyUGViYmphNzFzNjdWMkhhQzg5aEVrd282UVg3ajc0Q3NaM2Fl?=
 =?utf-8?B?OHpuRkZGcEpwV2xtZk5yZ1Ezai9aWlE1OVZ0ZGNhZ3hycFFxZ2RNSzVoZFBm?=
 =?utf-8?B?aEVkdFhKMGc1Skw0WUNVcnUxRS9JSUVYRml5a2xLOWJoM3JvREhvRDN4cCt0?=
 =?utf-8?B?cnN0TzdUdStrcjFIcDBSYjNpQ3FrUVM1UlR0QlUxTmRGcm9PRDVYOGpVSG1G?=
 =?utf-8?B?L3JUS1dTYk84eFdJc1FwVlNxc0xYUEM5eDJMNnFzOUswWHU5cFZtblorODlh?=
 =?utf-8?B?SlZUMEQ3aC9uMWFLUGFBUVRZTkw0MFBlSUdGUk1rTmZSYS9YbDhoRGh4bUo1?=
 =?utf-8?B?NUVZRlpPalIzOHFWN1VueTlvWVZjK2MxSTlib3BnNTVteGQ3b1NQdm9La0xp?=
 =?utf-8?B?NWNyZ01xeEpmUU9JUDMrQ3AyQWNyeU5lQ1Z2WWQ5cWNwaWg4NCt2ZXRLUm9Z?=
 =?utf-8?B?N0MvUXgzK3RaY2FwVS9PZkpDSGR3aVdVdndZd0ErakhEYVMzS2JrNmo2MVhD?=
 =?utf-8?B?a3FpdlMybVdyeVVDZEFNaEcwVFYxeEdzNExNZzVKSE9TeXhMZkI3Ly80MUVx?=
 =?utf-8?B?YUtVSFJBc3VnM2pXcHorTEwwNFFUbHhzS2oxR2NGSmx4TlFTNThoTG9NK2hl?=
 =?utf-8?Q?MESWGWHVw+K1/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzdnWDdWREZnR0U4eEdZakk0Q3RzWHUvUThsVjd0UllFQ0pTZ0FQYVZMVmJH?=
 =?utf-8?B?Y0k4TTU2bmg4aGNYNzhzL1Vka2dyTm9GTk04ZmNnSkt6bW83b0R3TXlVdlJ4?=
 =?utf-8?B?TlJLaER3Y0lRSkRVcXMxT2JBbllXRUhnMHRYU3ljZ2xuZ1JWOFhvNFVyV0tZ?=
 =?utf-8?B?K0ZSbzZxS3pndjUvQWM3SHc5V084WEk4WWM2OUxzTlM4QWdzbW5NK1ZCQmJq?=
 =?utf-8?B?QWM4Q094YS9IbnlUVzB2MkQrREdyZzY5RVhFV3AxSkxNZnVnYVp1THdRbDFj?=
 =?utf-8?B?STNmRHFxUFVlQTVlSEErMys3bDdBMWdYSTJvV0dOWC9rYzMvYmFxb3lHcGZ0?=
 =?utf-8?B?SWw2QlVDcnVSRFFpYi92T1NhaVBGdkRoT05KY0VJeTA2V3JpK2Z5ak9FL1E5?=
 =?utf-8?B?OHIvTnAvZ2Z4MFNVMlVISjVkc08rTFF2aTVMZ1Z2OWVtQWt3eFVkTmwvWFVP?=
 =?utf-8?B?NU8yRFg5VEJsUitEMGx6MnI3VGxETzJnYldFaW16UWpBYzgvbzlzanBXbk81?=
 =?utf-8?B?RnVwdnJxOEtUQis0V2tHVUg4Ny9kY090eHpIZU5Ld1RWdll1S1dCa2VUc3Jw?=
 =?utf-8?B?SkxXYW4xUjRCUE5NOGFTYm81QTlDeHdaZTU3QXVmZ3k2amVKRUhqRkZBWFVY?=
 =?utf-8?B?dkhlNE5zNEJXdnJiT012WnVwbnpkMlNXZ09jNDNGUDBoRHU0elh2SWoxdzlX?=
 =?utf-8?B?cGNZR29QZFBwbitCeERIczUwTEozV3M5UlN2M2ROTUE5eFpOalNHL0Y2cFd5?=
 =?utf-8?B?Y3owMll5WFZoQ2FNZ2t2azlsUFFaZ1NtaEJIR2hhMlJmRy9rVUkvNUNHVE1H?=
 =?utf-8?B?UDBvRXJRTFo2VjljeldyS1psN0QyY3NvK3ZiS0FuWkJQUXFKSWwvS2laZUs1?=
 =?utf-8?B?a3ZFeGg4RWZybmh1dDYxOG9ienFaVkJ1ZWNDV2tyQXVSRjJxSncyZEdteTdr?=
 =?utf-8?B?eHp6V25TSHlCa21ZT2NMRnl2V0pKT2k4SFhGc0ZuT2pmQVhyZng3NWVrR3dB?=
 =?utf-8?B?Ym83SkdGNVJSWVB0M2tlNXA0a2RqMG5iWk80MUxJSGhMYjdnWkdTVitzL0VB?=
 =?utf-8?B?d2l6ZzBhemk4TEZOcFRGZURUcWFYdGpXOWdiSkh6a082MlVid2JlTG1acWNW?=
 =?utf-8?B?SThiWFlONktqUXlSWWxwME1zanZjbVNoT1IybUxBb3VSYzJjaGs0ZmVsaHl5?=
 =?utf-8?B?ZWN0SG9XQVJ3MWljc1ArSzRtMm5weTdORldKaG0xdm9FeGlRUUNWZFBZMGJr?=
 =?utf-8?B?SGsvWGk1dkZ3TUV1b0kvaXIxdk4zc1hKcnhRdkhSS1J0ZmN5NDlJTGh5bnlP?=
 =?utf-8?B?SjYzb3JTSWN1aUhPZ1F1b2s1TW5CWlJQdGN3b2o2Vks0NHVJZUUrR3RlN1N0?=
 =?utf-8?B?azNSSzdhN0plZXo5QVREU201eDVmQlNiZEdzSzMrL1V6S21pWElHenM3S0dq?=
 =?utf-8?B?UHFDb1JTWGN6alorV3I4ckN3Y1ppelhyZ2xRSVBPM3RiYUkzall6Mm5xM3Z1?=
 =?utf-8?B?WjVWQzFIT3RIN2dmblVxMGJ2TWRndnUvRFJ2aVFBVnBOVVJWeUZhVHlMS2xB?=
 =?utf-8?B?ZEpOemlRblRQU0NEMXN0dzJpeWNvK281cU9YZmsxYnlXWC8yVVFLeTc1Ukdh?=
 =?utf-8?B?d1c2M3ZpSWVPb3Vuc1N4VVVYbkUrUzZWWkVIczhNbVpETGRXOXI2c05LSUpk?=
 =?utf-8?B?eUtOQW45TEt5UnlYQ0ZUSmc1dGYzUjVtbVRINE8wM2JLcU9pTTdabnRnWDYw?=
 =?utf-8?B?ZDkxbHg4QTF3ZTVHdGp6YnN0VVFTeSthVG84QzNaODRRdGcwWjhPTk1pQTZF?=
 =?utf-8?B?dmFnVHRRd1drZ2UzQ0h3elRLQ3QzQWN4bGRwOGNQZkZtRmZoRGZpU3lTMUFM?=
 =?utf-8?B?MkoydFcvZmtwV2FtWEY1QmhFbUF1L0VSS2o2ZEJnd0NFNU9VMnYranJTODJH?=
 =?utf-8?B?WCtmU2VNdm5PWlZTZ29hcGErQ2VXK21HOXJCUFQ0UmFRWHlyWFZYSVVyS2t6?=
 =?utf-8?B?V3RaeUE2VHBNWVV4emNwYzhqcEl3ZHhHWnFGNG5xZXZlaUVKdUpvVHdtR0hD?=
 =?utf-8?B?WXFUVzJlNk05SXBzK1p5SWJnRk5RdXBPMjJjMDhZc2tqVzFHVTNKRXlTUlNv?=
 =?utf-8?Q?6wwozf+de8omkqEvkQ9+QV0mk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a5c3b1-20e4-415f-8e18-08dd264db250
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 08:08:50.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9JZ6FipHMYymDQjuD0QA4dhvCP8Ru8fSHHKid884FWegzknmjLKWsz5QOwbrq+f/o3ePRtD15sdS8o3yexJGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451


On 12/24/24 17:29, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:26 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A Type-2 driver may be required to set the memory availability explicitly,
>> for example because there is not a mailbox for doing so through a specific
>> command.
>>
>> Add a function to the exported CXL API for accelerator drivers having this
>> possibility.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> I wonder if it is worth capturing the reasoning for this a comment?


Sorry, I can not understand this.


> Either way
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/cxl/core/memdev.c | 6 ++++++
>>   include/cxl/cxl.h         | 1 +
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index c414b0fbbead..82c354b1375e 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -789,6 +789,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
>>   
>> +void cxl_set_media_ready(struct cxl_dev_state *cxlds)
>> +{
>> +	cxlds->media_ready = true;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, "CXL");
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 44664c9928a4..473128fdfb22 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -44,4 +44,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>> +void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>   #endif

