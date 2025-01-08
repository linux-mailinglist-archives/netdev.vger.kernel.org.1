Return-Path: <netdev+bounces-156294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F8A05F24
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11733A1D93
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE891FECDB;
	Wed,  8 Jan 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kM1Xcy9A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6E1FCFF2;
	Wed,  8 Jan 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347194; cv=fail; b=NQMpwJGSZiTJVF1HJdubCyObS/gkEEJrfup/0JGEpKacK1XvU7BpVq/+NvtS/CdwczWpXpeag8fFU7P/XcqL31+SxW65devncHvc3MiaZnqOkwPHDgdSJ8qccRwM5sCdOlJhxWJG4G5EiHBONQ8z7SYVavJhpFxZUu/WZL/Mv2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347194; c=relaxed/simple;
	bh=bcClJx2IGmYQqchXyHpWa6pF6GvxiSDoZ57Ofm9R0uA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I+ENcL5X189/YD+0OuT0Bey2w7ZintDhIFZjUmI9afSADkLMby7h+BK0qPsS/7/tnj+Cr4icmJbehuE89dF7uzDBq4xnvFJjs3Pa+n9swqR7Hxgb+s4HZ81XuMYsPsG7zjLar6GAOHBJJ9kkj3rbcUbxai7Ht7oO4Ysbk0yVl7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kM1Xcy9A; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3bm/x1ttcjO+yv6AwumdBvFcB7HUmlNc/4btbl/A8PRe0c3WyhA7aG2JB4rgvMKqDNON32fKmNV/FDaaFOyB72WgT5E4RtYJxWKheZRT2QYXWv+1gl0FOugxcycvBsbove//M95Ko8nWGbhecej25uLl7BpYqHMlOpslim95torgJ3UP/Kpffgz+VJiF7pdCmEFm4w1q9UH4cMs6kWJ2p3NAOIpNt+d+dLGTANLyDAz3zX2tDvcGQZ1HLut+RM1PpmCws3pQugxoN2IvhMO8iqBKP4cKA2V4QC1ciTQZUXx5aWzUET+V1oL8bEhDC9tImzZzDbVXolKg5xzi0lViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNaWcU14bAPqvvWVvJdaHd2PE1oTOv2gJepLaFo/n1Y=;
 b=SkUlHFnh3KB5dSELLaZKzo5N+KVClsdaP2cw0iZgKIIYY7JqtLO/JgWb0CBEqyYAjCW33mglXybxbKSCLISFQ6yrZMiyuYAj+d2OWNbYggm6WXbMnpi/1bwnVVo+qbfhV4xD25zr9iqVar9hefHW4cbGjATxS6BKK8cFJYJkkLpsvtGrkntv3P5CtflHY7PsjM5kjecg+6IZFBUA7qSaHV1o/bO5OKmt6jlnluuAz5nv0KiIdqK8vab6PK4YHbrBgkGSJBQCKzStwjyjTW1ujKpKbiYc5+TEhIc8XlmmS5MrIXZRvIbRHrbVy+ZP1HXeupxXlea6wX9l0fN/PnKxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNaWcU14bAPqvvWVvJdaHd2PE1oTOv2gJepLaFo/n1Y=;
 b=kM1Xcy9AF2DGkq8hr9nXABrELgSnq99lYiGW9EtClINpbLJaKwcf4YPOfuSzdKhSgyqDbfQGntTa+riJSL7nLfdV8WFURJ7nqAkgmvFQvmkXOWC4O8UTuGApmtKtMEdqPXoa/dKow09M09dLI6y4Pom+VGSxrBcuQNHvQYcQjAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Wed, 8 Jan
 2025 14:39:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 14:39:50 +0000
Message-ID: <8372e7c3-0e32-fdca-2b1d-284650c6b448@amd.com>
Date: Wed, 8 Jan 2025 14:39:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 05/27] cxl: move pci generic code
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-6-alejandro.lucero-palau@amd.com>
 <677e0af67788e_2aff429448@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <677e0af67788e_2aff429448@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a2b3e6-c534-4d8f-f6c8-08dd2ff24e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXhGbE9GajlXVmg2TlBySGdyY1N3QVUxbFFXMlVGZ1N2WldBMU9HSjQweUk4?=
 =?utf-8?B?akRNamVueGRKSkYxblBjWGlxa1YvamhOcWpOb1g1Y0hQNEhDWnpzbFhISmdS?=
 =?utf-8?B?elZFcW80czVBRjNkcVRMN3FNUEJHZWVXa1pib3V3dTZCaDdObU9OdENtdHZq?=
 =?utf-8?B?NXEvV2dWbXJoOGYyUFc0aUxyaTR4UVNKNTBpdWV4ajVKeUNKSXp3RlRSb3hp?=
 =?utf-8?B?a2dodk1ycTNoY0t2OU01Mm5HektZZGJFY1I0NVlCbSt0aHhpQTN0ZjU0MEd0?=
 =?utf-8?B?ZTFhbk4zMFRxaWtYYWw4UkREbTY0UERWQTQ2WlFaN1krQUZRNFpHZW9YUG12?=
 =?utf-8?B?Rjh2Y21FTm0xZWFXR3RxL2JKYTdXdFlpYkUwS20raHk0c3JBaWpTblJySi9w?=
 =?utf-8?B?ZTd0akVaVFFHN2lDZzBmelU4UzRKcEthWVFzRnJCcVBYcVlMS1c3ejN0NGR0?=
 =?utf-8?B?ZGhQWEFPRlBDUXdVL0x0L2s5TDMvWHY0b3RIcW9SdGo3VFhtcld1dU9Pa0Rh?=
 =?utf-8?B?TkY5NGtkdlRsNm9IeEtBNWNyYzRNTnJ3eEljNWNXalpaMUtqWDE0dnZEL1Bx?=
 =?utf-8?B?bkJaMmM0NG9MQjNVZTBSdTdEMWhkT2JpTTBKYUZKWTRUalJPVHgzbk1nZ21y?=
 =?utf-8?B?cjA5OXVnVXhVak84d01lbjREL3JHektacVRid2RxaHlTT2w1T3RqSmg1Q3N1?=
 =?utf-8?B?VUdackduYnRyRzdSUXBuejBSdGRtT3R4TkZDdTVnMUt0Z2lVRDdhTWNQNEZN?=
 =?utf-8?B?dkRyQUpRUUk3VkNVY3JZZ2xzR3A1ZTYxdTZyMnkzcVFJbnpJQkpCUmZ0SmNz?=
 =?utf-8?B?RGxjQ0pVYWNFWHMzYkx2TWNOSEhKSXRZdnorK1FiSzR3TWlhTWczUFhWbys1?=
 =?utf-8?B?Q2gvYlV2ZXhva3NKQmoxNFU1Qjl5UFYxS2NVSU15MkNJQUhERjR1Rmk5c29F?=
 =?utf-8?B?bmcxUHk4aitEa0NuQVZQWVUzL0JwOFVmNlBJd05SVmNsRXpDdHVZTWVUQjFI?=
 =?utf-8?B?cjd1RklzSjNOL0gzYzZnQzlsYU15d3ZPdjNYOGNWOXRDWWw5RHRZUFBKTGlK?=
 =?utf-8?B?UmRhTVVoMEo3dEVydW0xMVhDQzhaTUFkVDR3SkxJOE1oYnptMnRMdzgrbkY3?=
 =?utf-8?B?a09VLy9TK1ZrcHlkV2VlbURSekcyMWdhU3NaTzJZV2t2a1dHL2ZIeWUySUt5?=
 =?utf-8?B?YXFpRnF5bGI1cE1jY1BralZmb0ZqdnZxY2gxbkR4M0Y4N1E0dXF4L0Z6c0ZS?=
 =?utf-8?B?bzFwRnRhRkhKVVR0T2xhT3Z6YUFFRXJuQXFzaVRFaGJrMElPTWNwTzJjZUlh?=
 =?utf-8?B?MXpjVlJnWSszejVUWlAxVUs4QWtZaXJlVjlYbUl0WnJpalJqUE5YRXc3UTVM?=
 =?utf-8?B?YUU3Ny9kQTVQZDJLcXF5VHJwQUVGd2VUcXFzeWhGdzFCbmJ6RGZ6c1dXcmtJ?=
 =?utf-8?B?Qy83bTdjd1VqdEl6RlBzcHg0NHdPTENwNTdmRzd4VnBOb01ScjZHQlcxeXhS?=
 =?utf-8?B?UmZnTllVdTJTS0VXUzlGYWRid0FLYjZGVkd5MG8xcWZTNTJWaGxJcVRueGt5?=
 =?utf-8?B?NjNIRTBSbEN0ays0WmZjWGJES3ZsN3B6MFF3M1pva2RpTEtGZ3h0Nlh1dlUv?=
 =?utf-8?B?ZWVqY1NXQ3RXbVc4Qk01LzlGaXkwaDY3TDI5K0ZFVHVEZlYzVkd0VVJ2dzYv?=
 =?utf-8?B?bHRmRFQ4YUVUY0JVZXVGVVNNd1psSW9oSDZwNG1lckROQlQreG14TkZMVk1G?=
 =?utf-8?B?YWNQdXNHUTdob0tBQUpTNUNiQk1KaU1ZZDFDc0hiS3pWSkFNUjNSczlzeUxa?=
 =?utf-8?B?QXJYcW80ZWNQVEUwT1BOZHhBbW5LRkQzWVZ4bHJJMUMraDNHc29tKytQS3Yy?=
 =?utf-8?B?aDVXdko5dGp5WjZLL2pYVlRYSUdEM3lpVytLYVRQN0lnQ1NCdVY1SnVEK2Zs?=
 =?utf-8?Q?I/2mR+mSIiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NExFKzRIeFRoR3RldHNPNVZpVTVBMlFESC81UHg4ZFQrVU1hMWtOZS9Yekt0?=
 =?utf-8?B?NjdVSGpyTzhoNmtGWFpPZXcrc1NVWHRLcUFRN0JPT3hnQ0V5WVkzblN4OGZH?=
 =?utf-8?B?UElQc2F4clFTZTNjSm5OWHA2M0xPRVd6REFwSit0aFFpZnVsUWJONm5PYmo3?=
 =?utf-8?B?bXNYY2F6M3htUzNEZUV2aTlKSFdjcTY2SUcxM2xPa0JVMTk3ckZCNTdsU09J?=
 =?utf-8?B?RGRlN3VaN0QreDd2bmVQcndFaEJNUkdZRFRkTGZVWWdXcDhLV2IraWFSVXpW?=
 =?utf-8?B?YXo0dG8ybHI3VEM1WGtoa2JaR082YmdxZjNGbEU2cDVTbnpvNkhWQ01UWHpp?=
 =?utf-8?B?UjJ0Vzk1REVSL2RCeHhJQWhVaGN1WDZ5UWFCYzcrdEVCT1lDNmlVcDBkUVpM?=
 =?utf-8?B?N2RZV2Z0U1VNck5VclNuSU04WUhTVVoxclE5S1VxWnJmaWZkdVhLVWx2UjFW?=
 =?utf-8?B?Uys1NDNKTXJ5ZGZRYms4eFUvbU9nTzFjTGYyZUFWQWpNYzRqNGJENkozUDRz?=
 =?utf-8?B?ci9UVnF6RTR1QXErRnRnMWF5bVp0K2JVNGZVOFVKRHdOU0VJVk5BNWR2c25Z?=
 =?utf-8?B?UTBibVp0Y3hlcnNyUW5FYTNsMU41UlRJTEswR2R2VzM2Y1dMWVpvaThKZllx?=
 =?utf-8?B?bmwvaCt3ZUpmb0ZzQ0wvWEtqWXQ1dmxidEloVS9aTlZKS0JXcERhRHJtS2NS?=
 =?utf-8?B?NHVLdGoxbFZYWE9wQW9hcWFZZHJNVGc4SWl4R01uWlJ0QzRFN0dvWGwzMFdX?=
 =?utf-8?B?TktOeGZaY2djZkVUZUNHcWdCRnN5UlFMcUY5V2lRMmhRbllMWFQ4Qk96dU9s?=
 =?utf-8?B?aCtseFl3WnloTGtMbE85RmgxMEt2Q0hrK1gwaWFVbUtmdE51K0lFaE4rYlMr?=
 =?utf-8?B?Y1lmK1Y1NEd5R3pLY1VvQTRCa3FSTjd5QzMxWFpONThDVGNxVjBuTThDZng0?=
 =?utf-8?B?Rm91d0t5SWY3dkdnb2hzMS8wSE54cmRVTDFvQUo1dGU2bjJJaUxVQW96WGZ0?=
 =?utf-8?B?M3V5UVNEa3FSS3YyV3pWRzFaVDdMVVdkS09rY3lEdjRJNTZRbFhoc21DMTY5?=
 =?utf-8?B?RHR2c1lKVFQvTTJWL3NzNUxGaGF4UWhGWDlaNUhSYVNoYmlpWmp0RHgyUk1J?=
 =?utf-8?B?cjRieHhWOXJuYW9hY1c1YTBPQ0NtUE92UGpYdm9tUkorcmJXRTBKQ0pZaHkv?=
 =?utf-8?B?YmJHRUxuMDlObjF1TUNBVkxOcVJXdW10eDZXVGxZZ1JoRE1UeDhYVEg0RXZK?=
 =?utf-8?B?YTZBaEUrV2t3K091VDhGSFJ2QWVBRDRLRTIvL2pJUVVpZWJ0MnBFM2owUU94?=
 =?utf-8?B?dUNyMVc2TUJDVkpoQ2N2TEVSYXIxL2hyNG1tRExrZExqbTA5dFZ4OUF1M1ZH?=
 =?utf-8?B?emFaUW81UGlNSDNidjExcXM2RWVKNEJrRENzUTY1MzFkZEdZYUNieTVVUTJz?=
 =?utf-8?B?ZUIzNHhuV3AwMndkdno5VU5KbHpvN1lOS3JKYzlZYW11eDRQT3JDNXloZ3lP?=
 =?utf-8?B?SThXOG9WaDhTb1JQeDgrNExxN3VXSjgrOGF6cEJXcTh3SU5VendkVjVRSlpU?=
 =?utf-8?B?cVk2cklUaEkwRnVmRUZYaEtrMWx4ODBGeFpZdTdzMktuWDB2MUUvcGZ3ME1m?=
 =?utf-8?B?VjRQNUxHOTYvNldLTUNWNThJeUxkdUpmWmI4ZjViYlJldVpxTzdwV1d4WVV6?=
 =?utf-8?B?K0VTUG1wMzlmbXh4UGJNbEdLbFk4blBEK3RTZklKc2xCRndEc2NzcWZvSk5D?=
 =?utf-8?B?TUVhTFljS3VQaXFBR2k1V2dRZHVFUTZSV05HbnVHNmF6dnI5V2RHUGl4by9X?=
 =?utf-8?B?MnMyS1VyMVNMYy9RcXFvdnVwUmFIblJqb2V3SEJRZ2Y0QVJPeFA3MFJNYjVz?=
 =?utf-8?B?SEdTbEIwZkhTcVZnaXhGNFNDTEUrdG5YekZZQXY4dEE4akVocnVnRm5uZnNn?=
 =?utf-8?B?aFBvZ0xzUFcvbmF4cXMzcnlIaXdkZDdNaEtsUVB2Szh0NEwyWkROSDl1aFlq?=
 =?utf-8?B?Mi9UVnhPR0tKbmtaNkJjRjg3YmVyRWd3U1dSWFNzRThkMmE0OGZUUVpjQWlH?=
 =?utf-8?B?VHg3WmYxRzVIWkFKTmpFZUliY1ZXamNCY1pHTWQwZlRNUWdYZU9nMXo0NTFD?=
 =?utf-8?Q?iJVRm2WuJn8L14aRKE/qtHaYQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a2b3e6-c534-4d8f-f6c8-08dd2ff24e5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:39:50.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCLZi5ei7xjDG/YxwS8fJM3Li4Vof+0VKgixGQkw72EK/dokSlshXPkUVW9WO0ix/CRgsMTJ+Alz/qWxoh5tYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489


On 1/8/25 05:19, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> This is the patch that causes the cxl-test build error...
>
>> ---
>>   drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h   |  3 ++
>>   drivers/cxl/pci.c      | 71 ------------------------------------------
>>   3 files changed, 65 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index bc098b2ce55d..3cca3ae438cd 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>>   
>> +/*
>> + * Assume that any RCIEP that emits the CXL memory expander class code
>> + * is an RCD
>> + */
>> +bool is_cxl_restricted(struct pci_dev *pdev)
>> +{
>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, "CXL");
>> +
>> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> +				  struct cxl_register_map *map)
>> +{
>> +	struct cxl_port *port;
>> +	struct cxl_dport *dport;
>> +	resource_size_t component_reg_phys;
>> +
>> +	*map = (struct cxl_register_map) {
>> +		.host = &pdev->dev,
>> +		.resource = CXL_RESOURCE_NONE,
>> +	};
>> +
>> +	port = cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return -EPROBE_DEFER;
>> +
>> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> ...and it is in part due to failing to notice that
> cxl_rcd_component_reg_phys() no longer needs to be exported once
> cxl_pci_setup_regs() move to the core. Please make sure there are not
> other occurrences of EXPORT_SYMBOL() cleanups that can be done in this
> series.


Sure.


> Again, as I do not want to inflict cxl-test and --wrap= debugging on
> folks, here is an incremental fixup/cleanup below.
>
> Note how I fixed up the is_cxl_restricted() comment to make it relevant
> for the accelerator case. Please don't leave stale comments around when
> moving code.


OK.


> Also note renaming the header guard to something more appropriate for
> include/cxl/pci.h. That should be folded back to patch1.


I'll fix it.

Thanks!


> -- 8< --
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 800466f96a68..3b33470b8cbc 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -107,6 +107,8 @@ enum cxl_poison_trace_type {
>   	CXL_POISON_TRACE_CLEAR,
>   };
>   
> +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> +					   struct cxl_dport *dport);
>   long cxl_pci_get_latency(struct pci_dev *pdev);
>   int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>   int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index aaea29bff0f1..afa3bd872dc0 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1034,16 +1034,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>   
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, "CXL");
> -
>   static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>   				  struct cxl_register_map *map,
>   				  struct cxl_dport *dport)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 6432a784f08b..0a218385c480 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -633,4 +633,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   		return CXL_RESOURCE_NONE;
>   	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>   }
> -EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 22e787748d79..8f241d87127a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -311,8 +311,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   		      struct cxl_register_map *map);
>   int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>   struct cxl_dport;
> -resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> -					   struct cxl_dport *dport);
>   int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>   
>   #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index ad63560caa2c..efed17bc9274 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -1,8 +1,21 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>   
> -#ifndef __CXL_ACCEL_PCI_H
> -#define __CXL_ACCEL_PCI_H
> +#ifndef __LINUX_CXL_PCI_H__
> +#define __LINUX_CXL_PCI_H__
> +
> +#include <linux/pci.h>
> +
> +/*
> + * Assume that the caller has already validated that @pdev has CXL
> + * capabilities, any RCIEp with CXL capabilities is treated as a
> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
> + * registers in a Root Complex Register Block (RCRB)
> + */
> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
>   
>   /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>   #define CXL_DVSEC_PCIE_DEVICE					0
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index b1256fee3567..e20d0e767574 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
>   ldflags-y += --wrap=cxl_hdm_decode_init
>   ldflags-y += --wrap=cxl_dvsec_rr_decode
>   ldflags-y += --wrap=devm_cxl_add_rch_dport
> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>   ldflags-y += --wrap=cxl_endpoint_parse_cdat
>   ldflags-y += --wrap=cxl_dport_init_ras_reporting
>   
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 450c7566c33f..af7a5ae09ef8 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>   }
>   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>   
> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> -						  struct cxl_dport *dport)
> -{
> -	int index;
> -	resource_size_t component_reg_phys;
> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> -
> -	if (ops && ops->is_mock_port(dev))
> -		component_reg_phys = CXL_RESOURCE_NONE;
> -	else
> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
> -	put_cxl_mock_ops(index);
> -
> -	return component_reg_phys;
> -}
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
> -
>   void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>   {
>   	int index;
>

