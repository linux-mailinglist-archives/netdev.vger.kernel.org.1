Return-Path: <netdev+bounces-67732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD8844BF0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114711C24F46
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 23:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80DC482C6;
	Wed, 31 Jan 2024 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vqmhraa+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10719481D3
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742184; cv=fail; b=SFM3SjvG1LeLT3OpZytDiTF7tScBcDZ9GS5vpybeK3rtSIIOmz499gS4l2g+NqiJJPoAsb1h/EMKmz7+r3E/v+yEi6XLxFQ9Rx9Kev5buIlAug81wzfMRTnYDUPo2+u/cgnpbwxLhD/JWyKWeGkA+6CiPlTGb8mLM9d98Lnmt0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742184; c=relaxed/simple;
	bh=fCm3xtmXYeNiNgNet5FGbtIGpbzgAqf40yAQ1ub6h9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gAwG5hLfXgvbtur6GlC1zR3ilOn27ROhjYF11DKtlwwG41dxnuLp2EZ57KBobxMedLBEVs86sbVLEXArslwtCVO51+2cDAw4PP4DTbhYvC8a2oAfTS4tumZUcT+Tq7wO4o/13NiSpTuFH25+OKkK8qs7jMIsxoD0RvZNZ/rGLDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vqmhraa+; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neKVVHaI/y3Cadt4UgaV/ylIT9nCfNXLfj1MDIGadn8wJ/MmnldAS+KArzbCxAtQbsg9vCx1WVWmd5XWP8ki03iKBL2XG/Wb8dPmOvano7ovmOeIvLPdHmFPy2CUN+jZdQX35kc3oR3flY1dnWjLUf125tEHNcmGjaRz1sHDkmmvTjWi6r0+dq+2k+GdB38GcJUHthJw7PvXGaomeTsytkofy68YmhKsZL2rOfm+Xi9tOrx24RmyvjLJKaHAGSQkhrYN93JS+w2QI7wGXIGKDNnd+nE2T+eQ7os4FYFI4s2EMLRO+/qo4saNzeue4ex1IwrdavWJn8qXTuxcrwRI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCm3xtmXYeNiNgNet5FGbtIGpbzgAqf40yAQ1ub6h9w=;
 b=OkF+SoVhtfV0rfs9y+S+B6XWOqevoXTtmjdNPaLn5pFh4BWKpOQJUVRqf6EAkTZwFi0qeM3a0PlZvLVWIn5xvCeSvvHUKnaT4PM1IRekFQtmwJs1G9p2XMnx9GRC9CeodhGd5XiNsYYyyTQmVc8kYksonzlNHubvwFNDc1VkCCPDAH1zQlXyRtD32JnT0G892mnDKRYrglImhZgMx0jKG5w9/TPXqMvfXEW2VwaUXoK9n3Cs4zHtFCRqOw+krphh9YkFgMQTiGnDJ0/iUKh31ac9WHCv4Uat+pUUbB4uuep/U31FLqqw/Ys1Au0swW35qpa994zVLEJKuLTl+7p6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCm3xtmXYeNiNgNet5FGbtIGpbzgAqf40yAQ1ub6h9w=;
 b=Vqmhraa+ui/3K8kJ/xhzGyi0vifrXS4Xl19JQM2RKDsIDiSutxq8BStRKLFkAwr+7Gj6M36lD0zBq3yiDSXDRu6jEstE0Dv0FMpp/OdEnnZ0Bf1p+Uiz8AZtL+fwnbNIt6pGtoHmVmutCx5O308+psOwO5ylybzBWDsfp7AVmV2zQbsjmTnuuIdoB8Ry4K5v78CflrJNAb1pLKLWBl4rxrZkBWsnUxmpYhSbg9dCHqi/eVRdQUe1ObFFugtkZWJRW7bJdNFcjJoDBvMaIlorofsJpVy13Pb9jJgV2HxBPZm0MrqWqH/G0z+PGzj8R40Rev1fc7fZ625AEH9f+9bSUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:03:00 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:03:00 +0000
Message-ID: <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
Date: Wed, 31 Jan 2024 15:02:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240131143009.756cc25c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:303:16d::30) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e0a99c-c560-4206-4007-08dc22b0c578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N9N4Hpk1LayqWP0OC3rKmN0xc3hm39LMxzHI16soeZG0qlDewQXaX++jebcvXpu6fB5qPchM6BG2kO9yUwtDjMZW/33BSIFQG49XBbkHKw0eSzjRHDXBtiH1py5RP/O048eBr2rk+p1sUawIX9569n1PrZZ1C9B67aWJSp4H9zTXk4vLNujoj3YWCHngZ1tlcpEEkcF1OjJggjb6vTP1gWa0SVsKzjMTsDcmK2TkcKCrnIk1ArfAkkhsrd0DKhbXsI1Jqh5dztnamw0gD8POF5iBvrNwIsLlf6oK7pTgI6Y1aVYk6XdoslSRBU4iuCxX2Ka6EoV49qliDinD752EgH9otRgan/lcdDDLYTkSDFFJ+RM4Lzt6SXT4HWDzO6MAqrnaQG1cijdg7AA6BHctkV60LvZHdg+BSq0imtAxt1rdC7eH2sXCZ0VhRa4jXA7RemEHGqHO8vXcDHZGwI2DrlhlMSYYf5R7Lry8DlVg75pCac5eoPMxvw+cOnH2BwgMoyglPNrvvmyPt1/jRIaszY6pnZwWhk+bcUmM1JgQWmxUl8XS1DUx/jCqvmFTtp3lhcPjWjo2cl5CbC+ohqxXfGa/6VeCjw2S74lZvhEuexnbya2wS78qvHU6yQxBk3SM78BCyFCxGGDH7Lvqo0jg/zwH8QasnCS9dF9uM985TE8oERGGP/ivcQpjtBybVWY5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(36756003)(31696002)(86362001)(38100700002)(8936002)(4326008)(6506007)(66476007)(8676002)(316002)(66946007)(66556008)(6486002)(478600001)(26005)(110136005)(53546011)(2906002)(2616005)(6512007)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmxWUnJNK2hPRHMrekVyMTFqMnBqNkVmNGpwSGlwY1JOWm1pSm1LaEZoQVFC?=
 =?utf-8?B?N1RCWER5SDRXVjFEd2lxL3J2d0pxN2VXbnlKb2hVLzFyeU9abGkvZ1FDcHVv?=
 =?utf-8?B?dGdiT3ltdGRobUl5OVNaYUF6Z2l1ZjlUcW9Sb1RYYkQra1pZUjNHMUhtRDcw?=
 =?utf-8?B?UThiQUFGMWgyaStIYkVDa0xZZ05mUUtXTmN5dSt4RUdyalRqSHgzOGU1bmJV?=
 =?utf-8?B?OEFXSjFib0VoR1RUSWovWUFVbnhRaytZdGNBZWU3TFBZcG9jdXpRcmZZVjhR?=
 =?utf-8?B?dzRqMU5tOGViK25SVUsyNFdTOTJxOFR6QmFtVmc4WnhtUmZuWStkeXlhV1Za?=
 =?utf-8?B?RHNsa0RVWllFdzZOT1VVeTd1L1JRRW94R1RXazhnTDl0WW1WRHErMDlrTGpv?=
 =?utf-8?B?OGwxVEVBQjZRajV2c3h4Q2w1bFhIaXFjMjNta2NqYW1pbS9uazRlNmpaRThI?=
 =?utf-8?B?RTFYRnR6ejhOdVRJWGNCcVBZcWxyeGF1Kzd5SHNURUIrejBQTU04MFd0bFVJ?=
 =?utf-8?B?QlA5TGRzeE5pRUdrM3V0V3hmNmVuZjNVWEtOQ0VCNGVMbHlDYnhWZkg0N0ND?=
 =?utf-8?B?b3VGZkh3S3k0Y3dQNndCekhlWm9pa201RGMxTFNyS0VoWVpxSE1hcVVrRllI?=
 =?utf-8?B?elBaSjdyRE9KNjZESHB1NTFyaXhJYWI4YUlFZDZ6QmM5WTR4NzBLVWNnOFli?=
 =?utf-8?B?OHdRcC9XcVcrWnN2UFFuSGZHemd3R1cvWDh1Ykxuc09rMmtERktacHdXeFpQ?=
 =?utf-8?B?NFF6Y0UyUmVNdW9wY2c3Q2xzK1R1ZDlEVHZvV2FVTm5rT2lpMFc1MXJRY3Nx?=
 =?utf-8?B?SjhBU1ltOWxETURlNWFxMXZYZW5NZFRUajZtOXp2N0ZjME9zMG9MMW9WOUpt?=
 =?utf-8?B?bUJiZ0lIUG9VM2EvVEJvcFc0TjQvMGlFTlp1V3pFL1BRNjNBWFI5VlZpcE9E?=
 =?utf-8?B?Vm5WYVFzbFhXT05rVTRGNFFickc3Q1ViZXNsWDF5ejQ4ZUZqd2NWU3JHUk9q?=
 =?utf-8?B?VU9TUGV3RnQ5aGNPQzlCNTl1WURwQW84dXNTRDBVOU4zeWsvWTBLSXdDWFlY?=
 =?utf-8?B?ZFlrT2t4d0RPamN3M1liUktGR0hLenFQemFaUkFvUGpnSkR0NVUxdUxnMTk4?=
 =?utf-8?B?NXp0Um5wM0xrSjdvVmhNeW9QdWJSeGk2ZU5ZWjlMUW0rb2QvTDlsbjhOSG13?=
 =?utf-8?B?MlJHT2lJMkRnRHAwYmpuOXlibEtxSFBSVk9hU1V1bmkwYm5PSHQ1UUE1dDVp?=
 =?utf-8?B?b2I0WFJNaSt3a21WY2hZVmZsOHp2WFIzRkhkR2g4Q3lmSThkelFDNUVicUFm?=
 =?utf-8?B?N09aOWpKZlBQYm4rUy9mbVBzMkJrOE15MzJxL0YxSTZ0a1gzTXpyY1FLUlFH?=
 =?utf-8?B?cS82YXlvcFFXcXBGSkpkeVVoQTYxVVFjSGMrdWpPMW1janVBYXF4L2ljM1lz?=
 =?utf-8?B?MDBlaWp4c2VTNmNpOUdjTXJOQVVqQ2w5NUJLOUYvdFRIOTNNakFJSjE1NGNM?=
 =?utf-8?B?bXNOem5uZDhST0ZKQ0JGbk9vUnA3czdZT0MwOThVNVMybEFPTFpZVHNlMWRV?=
 =?utf-8?B?RzJtMnVZZXl1TWR1aFdpTkt5TjBraFlsUmNacTVYNllUZlk3UzBvNDVWWWlk?=
 =?utf-8?B?UUhNbjllSXFWbXlBOWFvTkNWOU5KZXRqUDc3VlZJUEZnWVJsdHFzWUZvVDRY?=
 =?utf-8?B?bUtjL1NBeXlrQ2NFOTNRSTBhNUNRdmYwcnB6Q2tUYThoL3gxVDFoVDg5d2hh?=
 =?utf-8?B?TW1qdmVqUTlCcVd0TnNWZUM3UDlYcXF5MXBiMkR0L3hYakhQNGNvZ0Q1cnFj?=
 =?utf-8?B?NGQybnZDSkU5S1MyajJnY0pNZllYNVpkdXpQNEVUeldXSUJFcGFVVzlLaGk0?=
 =?utf-8?B?SHJNMzViVjZmazB3c3BLNlVhZjFDSXRRbHFBQzgyNmplV25mVmlFaWoydExx?=
 =?utf-8?B?OWdyVzFGVTlDRVlXb0d0OE1YNDJBRU1FeXZjbENmWUZvaDdXMzgzUDJLWDQ4?=
 =?utf-8?B?NXlwTnhHcHowQ1dSTWpYQ3k1TmxONDd4REdYMzViVStKSFV5M2R0NEZteHF5?=
 =?utf-8?B?cG9lNGYzRi94WXEzNnRrRk9xS2htUGM5TmdRNVdoZlVyNWZoak1pSThMY0pz?=
 =?utf-8?Q?VPMWU8zjs+Yor7EkAectavSyP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e0a99c-c560-4206-4007-08dc22b0c578
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:03:00.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fb1a4fg99QAYbiOxfBe5c6Yrv/ZQIJkCfxRi4llRR4aF7bSXhRFwaN0Z18/iOjO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134


On 1/31/24 2:30 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 31 Jan 2024 13:41:07 -0800 Jacob Keller wrote:
>>>> Still, I feel like shared buffer pools / shared queues is how majority
>>>> of drivers implement representors. Did you had a look around?
>>> Yes, I look at Intel ICE driver, which also has representors. (Add to CC)
>>>
>>> IIUC, it's still dedicated buffer for each reps, so this new API might help.
>> Yea, I am pretty sure the ice implementation uses dedicated buffers for
>> representors right now.
> I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt, ice and nfp
> all do buffer sharing. You're saying you mux Tx queues but not Rx
> queues? Or I need to actually read the code instead of grepping? :)
>
I guess bnxt, ice, nfp are doing tx buffer sharing?


This devlink sd is for RX queues not TX queues.

And devlink-sd creates a pool of shared descriptors only for RX queue.

The TX queues/ TX path remain unchanged.

William



