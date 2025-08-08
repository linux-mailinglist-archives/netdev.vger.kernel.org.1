Return-Path: <netdev+bounces-212173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB84B1E8F4
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D45560EA6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15DB27BF6F;
	Fri,  8 Aug 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="daD1m4Vx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9F27BF84;
	Fri,  8 Aug 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658687; cv=fail; b=ki3BQKjCrVuRJhQ2EQlr63CZnlKPm9yCQrw2FbHz24AMITMLcPZLBRyAIlEpJdrVutDOVn29CTzf3CNRZviUg5EHmLOiPaW9Mlu3zOylyyPLlw28NvVozvJDCPRwyRxbEYu8qNZFa1vXIM6I9VUB9hdf7lrLOJurLOBSDg3pfno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658687; c=relaxed/simple;
	bh=3kSD6fWrPhVxibRXysYeboUx6I+aDEiPWySkk4OS5jQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WSwtx2lNCWuyLMwPctjnsfzPlYMjdp3T3aISGNDBxQl0qtfZHY20KI2ielaUGWIx69Acw28AimKrDYeB5WIRLWB4vF8xXkdBwhmKXhR5G3C15vtpOW8G8bvOkq/HhhDq9DWXMG+KFj2Y5sY3BrruBDg/nFtCLTdL4uadENKXsdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=daD1m4Vx; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iucpeM1d/PmFwAaeXhIiadCZtpVnq7FRgiS/f0lZF9rKMBdlQ/cp6SfdhkosLRI5zf9NEKZYMcpVbIRIKz94JuP5+4FGPIl4YYPhtCiBahA1V3gjMIfksfvCJboBlxpVduM630UT60Xc+wzrC2QvU5UGWcZJFwFZKLdflV7kTNaNQRQFAo2J/V2T+8zSR2Io4AJvYV+S1xuMLHozPLnu1fbAD1fTXvUuld7xlXcj7wHcTbF0STp1xEHYfP6xHaNXyCpCF0lRJr+RwFXkmoquDn6FMkHd0e4NDcymU803z9HZapEDZKFmnEjaIbB5tStW0A0LaXjhbt54MW/w/zHIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpkDSi/V6eyc8q+GFd7tudO3dKqtfk9Zy3Yq8vtEDJg=;
 b=UjoYpf0hzof9Eyg64Ue2jpPiaSDbULTjXmAw2Ho9Ve3lZWOPhfh2XQJvtZLa844aX3VKhcHBePhEv/yaxFZw6O1OG2tJkCYK1SNwZBYub0g8bmcUF5ULS5ijz/63U+nIHYbvz8FEeSqYTlRfXsjyPb0TrE5VVC3sT6AnWA5gg8iJi8GbMDfrFdSA8g0LY1vaJjPuRD8Aw7DsP8Yl/7KQu15L2wdl9zwxFabn0Uu+iOa+zN9jVT5qgPPqQqy2ZoBTXnAUmt1+b1tOeLs/uSUMvuqZjdmO3IHqbVF1AzIE2Fas6dNSCbYkml0YG9vvZD34cPry2TvnDWrKN2Ucxzv1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpkDSi/V6eyc8q+GFd7tudO3dKqtfk9Zy3Yq8vtEDJg=;
 b=daD1m4VxdusttVXkuz7kYCxOo5vKEHb8oaKqs2JWc52EWGi6+ewztycJerOFSh7Jb7OYJEhA5rNd5ltz0A15EjYQcAJXM574fuIh3qLqXk4y/lY8po7azqGQMPJI5hafNaOpBOzUZR28oIxRgHkssQQSOMK8iDQDfLNqNVwNHlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 13:11:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 13:11:22 +0000
Message-ID: <b1f3652e-6ee0-4222-8d31-73b9e57b8ede@amd.com>
Date: Fri, 8 Aug 2025 14:11:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 05/22] sfc: setup cxl component regs and set media
 ready
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-6-alejandro.lucero-palau@amd.com>
 <20250627093923.00004930@huawei.com>
 <593e126b-7942-484b-bdf3-2f8d25273f31@amd.com>
In-Reply-To: <593e126b-7942-484b-bdf3-2f8d25273f31@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0181.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2c5a1b-0969-470c-5e91-08ddd67d11fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dExHdFVibXJxQnFzaU12YitBNmt5WlRJb0l3VmZMSnJseEhia1liV2xSY0lr?=
 =?utf-8?B?R1gyTHpQc0FkU2N3ZUhySmJUN2xFaGNJTURaaElGUzRZTzFBLzVrRTVwMUNQ?=
 =?utf-8?B?andsTkxINGM0dnZ1TWNWRGdtckVTWFloMDNUMU9lb1NjOTRHMTNCQWp0alRD?=
 =?utf-8?B?L0ZKRVZBNkVaUUo5NC9lamFMTUVyVDhUeFpNTXVLbE0rZVdXZUNQWVpwMDBV?=
 =?utf-8?B?NVo0blBkdWFHRjNsUnlZNllXcmg3bWd2WDNpc2kxOGpERnM5djNTNktJTnpi?=
 =?utf-8?B?VlkzS2xGQzQwbzh2YmgzcXVyeUJ2UTluY3ZnUEpPb2Y0STZGUDArb1J2R0ZJ?=
 =?utf-8?B?ODFueHlmU0UrMGFHMHFaVExDbTI0eFNQWXQ1VVJWb0ZNR2Q3anZZVGFCamE3?=
 =?utf-8?B?MHdSYmowdjYvK1puUTlYV1IxZHpIQ0xxVnFnOHJTbVNlcW5jTC9YWFJ5bXQz?=
 =?utf-8?B?bnFxMXRUTTFyVDVTTjdmZ1RkWWQwTzBFV1VOVFpoZCt5Z3oyRndMOEdXMk9k?=
 =?utf-8?B?NlYrK3RNUE9NT0M3Z3YyOFhxVXdURTEwTWJqa3FDRXJyek5tWFcxUEd1Ty80?=
 =?utf-8?B?S3lZM1puZlZSNzBvcHFSUnpCNzg5aVJMV05JSDNHWVJCajNSblJoOWNHQjRK?=
 =?utf-8?B?dDRuZCtPTkZIM0hpTHovWTVtd0wxMVo3UzNTeCtDRWtldHpFTS9kMkt1NUZw?=
 =?utf-8?B?Y05FNWhvSFVOMHlFdmxQeXhGOGFMMXUrR3ZSQzJqcThZQ0ptdzFRNm50YUVF?=
 =?utf-8?B?cFVKZDZjc2hYSUdxN2NiRGpTOFhVRE82eTRXNWhhK1pvekRZaG1HNDB5T3d3?=
 =?utf-8?B?VFhMaUZQNkRkUjVNTTE0NVJwTlUrVVFpVGovZWlvZHNLSWhraFZLZEpDTkZ3?=
 =?utf-8?B?SHNZNU94SGRzWmQyYWVaL0VLZW1tMWRuekNmUTNlbUVNY2EyQ0tHR2VYUUFG?=
 =?utf-8?B?cXNXZjhpbGxWd1JNbm1mUDhwa25jYURxSVdEMHAzbDNnQkpOUnpOVHZWYWJy?=
 =?utf-8?B?c2FReVhIek41WTVDQktkMmVmSSsyZ2JNUEhqbWx5b3FqM3E0NTFTYTBuMm1h?=
 =?utf-8?B?bnV0SGV1TW9iM0xSMlFGNHViWmFHd0NJNE5qT3AxNG1aZWk2V3NqQ2NBQS9s?=
 =?utf-8?B?WlBRQWtJZXRaY21EY0RhVWVYVkxGVGwwNHMyRlR5QWxyVVM5NmQ0a01GSkJz?=
 =?utf-8?B?VTcvb2ZBN1R0c1JRL1l1OEJ3b0M1Y1FVMmdNZGdyWVRTZCtPaXhOaGdWenJm?=
 =?utf-8?B?dzZ5a25VNnZ4NTBKN2FBRE5Dcjc5UXpWMy9mMlgzWnRqUG9QTUhEUW1MUXgr?=
 =?utf-8?B?WnUzTmovcld0aS9uYVBVaXhibHJLU1czaCsxY1cyZGFlSlRZZGlydjdUczdP?=
 =?utf-8?B?OERWMUUrQ1pBY1I5R3JIS2pJUm0yM0JYZm1wSWVucmJJYk9haWE0WDdQbTU3?=
 =?utf-8?B?MXI3ZnRzWENKVUNBd2l0OWZIOEp3ci9zajJHYXY2ZTdJOFd1R1dPWEVidURC?=
 =?utf-8?B?YnFsaFNvRVdBRzM0UDc5OS9HMHJUKzVpRXdCNnBkdzNtVTc2dWNhQ3lmVW5B?=
 =?utf-8?B?NWVSTFl5Y3ZiSG9hTGhwc2JodVpHZjQ1SFZCU3pIdjN1NGxocG9oc2tseWN0?=
 =?utf-8?B?NDZveURDYzFoVlZCYWlXbW1MaFRIY2svelc5UWpHbkY4N2U1M1VHRGZ2MG9y?=
 =?utf-8?B?UjNWZkRzVlBaU1hIOEdGQ3JhRlRTUFIrWEt3VkZxbm9KN0NLd0xxVlJFcGtQ?=
 =?utf-8?B?dUZ2SXdZaE8zeUVBK3NURG1qbTNFTW1MQjhYeS9CU1pKS0tEam96cmxmVVlr?=
 =?utf-8?B?N1RjOVRnSllJRlh1Y3dUZmhIUmJkemhGRDByTmdUakoxQ2lpK1VMQVlTOG91?=
 =?utf-8?B?bERxWXU5T3IxMmFkdEhIaHdBaC84RThtUThESW9Nb1BSMVByVGQ3UGNCekZu?=
 =?utf-8?Q?QplCZxlqIOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a09obDNSYVZaRWpOYUpINXVHaFAwYmRSdyttam5kM1FGYThNTFZ1c05iT3Jj?=
 =?utf-8?B?ZUI0a041cHhTU0o4V0hXWTM1bnl3Uld4RXp1WTd6R09TWUd2SlRRR3VqZXk4?=
 =?utf-8?B?a29XVTJHeU9YdlBVT3YvbUZocmtWMW1PUzVWZzJzVWhkUlhTMGxLdENyVXZq?=
 =?utf-8?B?bFU3anVLRlc2S1U0N3NiemJJMGFzMFczbm1tZmliSERHOXhyOUxPR0JWbUtF?=
 =?utf-8?B?MzZaaGNWYXB2MGJ1WnZQUEU2ZUxHQUplUWY0SG9LRkFSbEh6bG93WCtMNHBi?=
 =?utf-8?B?aDREbWhzMlhVTXNQZWxuOStURkV2YjE1MG44VWhESit1Q3pKLzdIYWFPTHRs?=
 =?utf-8?B?dWN2VXhhOUc4d0R1dUs3b0FQZitDRVlWQWRuQkdTVEwvUlRwdGJpYTgvS1RU?=
 =?utf-8?B?YVh1R1MwYUh2bURUdmVldlQzWUF6b2EyR3JUVUtwdEJ5NEZBeXk5UVMvcGk1?=
 =?utf-8?B?N0VqVlJhQWFobWVqQnFiMnY2RUZwNUlYM2lpYlNQRVZIQUl6dDFoNW9YdCtI?=
 =?utf-8?B?N0k1YlFVNWtIZ2RnVzV1UVJDTytSZWQxcWxJVTA5a1pGeWlnZGVjalpQanRM?=
 =?utf-8?B?ZFAwRTc1cVBBdEtXSlBLY1JkWlJucmlOVVNtV1pBRHZGSU41VnZ4aFhoVWpL?=
 =?utf-8?B?SUFXaGFkTFFSVnR1bnVkOUQrNUI1RFRqUU0wOCtVcStkWXUrYUZnZ041L3Zt?=
 =?utf-8?B?VzdGMWh4bHp4UFNoU3FKNG51ZHJtNDlYRERSRHVYRjNzdXhiN3FBNEdQbnRx?=
 =?utf-8?B?Y0NOdktDZXlrY25kdjlwbmVzOHZwL1F4c2phNXU4blQwcTVlZ3NDNUxoZmxY?=
 =?utf-8?B?bnE1T1pqN28zNWcrM2pDTm52WVVwTnROOFdWM0liQ2VtS1NTZzJpOWU5T0lZ?=
 =?utf-8?B?TXZuV0t3LzlUYlY5T2FFOGo2WFhyOVJuZVdvMld3eVJVdktwYVRxMy96UDdY?=
 =?utf-8?B?RUJmbVhFQ085UzgxdWlrNEVQVlhuSWh4Y3BFYUlwK3JDQ0tiY3p5SS9pNWVU?=
 =?utf-8?B?Smk2anNFRFc3RU54Ni9OMHVHblJjcjJZYWdVM0l6ZGM5dmlUa0x4M0pJbDho?=
 =?utf-8?B?YW05MVR1aDZGajMrdkRGN3o5MVBDajN5emdiNy92blBvQmZpMys1aktuLzBR?=
 =?utf-8?B?a09xdGNCdENWQ3E3bTkySFQ5dm1MQzk1Ly9XZ1poVHBhQ25PK3FYcWdhSHBK?=
 =?utf-8?B?NjJSQ3ltWG0vNW5BRmJrcW14ZkxqME9hQXNlcElVUlFGbE9mcHJsMEFPTVh4?=
 =?utf-8?B?MStUY2lrNGVoV0lxRVBXVHlDdXpKbHllVnBoVEtJSTdNWnZtNnpxZjgwdkVN?=
 =?utf-8?B?SHo2cENIK3NMZTFOOFFDYVVPdmdvTFpHc2VOaldFK0NiY1JEUzF2czFHNi9s?=
 =?utf-8?B?WE1PTWVyOTRweUdicktLa0sxdU0xYVllejFpeWsrVWdyNGZubURmY2RmQ1pF?=
 =?utf-8?B?aWdxbGdFbVFIZVI5dnhFTzlaVFZtb1B2bEE5cTVIcFNWZytaMUF3TURHMDJG?=
 =?utf-8?B?Sm16OU5WRGhzR2t5dlJmVkpQY3Q0a0JoMmpNTjBsbmUxN0l6TDdwN1Bla1I1?=
 =?utf-8?B?L2JucWhEc2R4ME5xTkVnZXFPRFh4cmkxelBNUk80Y1p3dXgvM3l1TllFZXov?=
 =?utf-8?B?K1VyRDduOHlDNFI5M08yRzN2RGlTN1NaOGlkK0sxUFhJSGU0a1hwem13S1Jn?=
 =?utf-8?B?NzhEdWJGS1NmMitKM2lkNXVBR2dHaUd0b0hmRDR4TjRGSGVMeDN0UHEvSTdO?=
 =?utf-8?B?THIzczVZVC9id1pvNndJVy9Cd0Y5cHVnLzlwbytCeGFQQnl6b05ka3I4eitj?=
 =?utf-8?B?RHQvZTNwbUVJcDVGNDNldFpQK1NhaDE5L1E1YTgyVFNFRzd1NUxCdXYyeVNY?=
 =?utf-8?B?MVBMQ3JsZFhibC9QNmlCQ1JkbzBSNHFtbW1lb3M3djRnWDJqTTRFRDZGY1JK?=
 =?utf-8?B?dkc4ejdkb0N4STBWT2ZpdFZ4TkhSVGgrSDc3QkUyZGNOaFNKM1JITHVQdFE1?=
 =?utf-8?B?TXpBS2l6Umw3dVBOdHFOY3Y2TUpIZ3RGNTBkNTVUSkFxYklMa2JVVXliTE96?=
 =?utf-8?B?Y3h3TjNiY1h2SHdUalEzbjVCVmZqdGY1RGVLVUhSaDR2OGxzS1duWnRNcXkx?=
 =?utf-8?Q?INseaJTzjywYxR8ZI0mGCl20G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2c5a1b-0969-470c-5e91-08ddd67d11fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 13:11:22.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDgbkWd93Ll4wLE7R0ZetoYknY3Wki9c3lxoEYvyhQ8M9FGQg857aof0JYnmytydhBwVYrknRI4VWB+ygo+9rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

<snip>


>>>   +#include <cxl/cxl.h>
>>>   #include <cxl/pci.h>
>>>   #include <linux/pci.h>
>>>   @@ -23,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>       struct pci_dev *pci_dev = efx->pci_dev;
>>>       struct efx_cxl *cxl;
>>>       u16 dvsec;
>>> +    int rc;
>>>         probe_data->cxl_pio_initialised = false;
>>>   @@ -43,6 +45,38 @@ int efx_cxl_init(struct efx_probe_data 
>>> *probe_data)
>>>       if (!cxl)
>>>           return -ENOMEM;
>>>   +    rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
>>> +                &cxl->cxlds.reg_map);
>>> +    if (rc) {
>>> +        dev_warn(&pci_dev->dev, "No component registers 
>>> (err=%d)\n", rc);
>>> +        return rc;
>> I haven't checked the code paths to see if we might hit them but this 
>> might
>> defer.  In which case
>>         return dev_err_probe() is appropriate as it stashes away the
>> cause of deferral for debugging purposes and doesn't print if that's 
>> what
>> happened as we'll be back later.
>>
>> If we can hit the deferral then you should catch that at the caller 
>> of efx_cxl_init()
>> and fail the probe (we'll be back a bit later and should then succeed).
>>
>
> I'm scare of opening this can ... but I think adding probe deferral 
> support to the sfc driver is not an option, or at least something we 
> want to avoid because the complexity it would add.
>
>

It turns out the EPROBE_DEFER can only be obtained in this call if it is 
a restricted cxl device, so nothing to care about for sfc.


Seizing this reply for telling you I'm going to squash this patch with 
the previous one which you gave your review tag, so I think it is better 
to not add yours after this squashing, but happy to do soon ...


Thank you


