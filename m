Return-Path: <netdev+bounces-234422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B8AC207F3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6813A188D8A1
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188AB67A;
	Thu, 30 Oct 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ioKHHEgd"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5D1A7AE3
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833009; cv=fail; b=fRhOJ05DFdlggyiQGE59Qqo+RDBv7CSWZaj0dcES7MqqGNLHPBVSHRgw29t2iH+H4Bd0GbVUYMxLXP6WXfG10fQFOCpSl7QdNJYEZJRyEp9Y4clY8FyJ9qPxKsFMQDSMi8pqbLX1NrzBxNHkIwSDG11Vxi6UZL/5xsdUw2fbdDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833009; c=relaxed/simple;
	bh=KW3GSZIt5QqW7xSNBN8x8TYz8nP1g6hdORpo9vyI8d0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iXygq0twGMkKaT69bbrkONyyM+JJrXuEpnz6KGNwptG4yq7VvEjINJWaZ7RtmxkfdrD2lTL+ZcfioilKwEYpPF3GEPZvyq3MDeiVo6TpxS2L7vPwEKek6nQ83AHuJFLA8anqywdtlEd57eEsvVGm4ZkuqCsuWWoSrY/2vrTGH+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ioKHHEgd; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpyCA+SMpBCWKPkd9LGh6AFul9PWLiD6gWK1TPAUrEe1ptFLH0/Nml8IzDd3CfDM9VvOMkpdPtq+1OgNByHdeXw0pUIpG1eBoExoxk5w89K2YtdDi1IcIk271MtpSbEUhXFYmlHdMswtg2Gt3wF7/HY+OI0309fkjwhiBOhXHnMh2bJ6FWKX1IObnmkL9XELKXDpiQpdeTLHkuAoBoIBRet3XeTLqzng8MorwbKAqOBIyGIdK6pkfEDn+tMK79wQt1+aKxOyDBCzZKePH4TKG5QtfsMmqZ94Nb7r96a2BEcwsagES7s9GKM0hoh0jW9xtLW6oLrFQsXtPLwlRtwvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6POctbfhEPFCOjjPefevDVhKA35ERTCX+WA3KGNeqY=;
 b=L4HBeAqq6ExnRsqjpTYPSDpHqFLJFdT9sp9DqklkbeuNWdcMvl6oMGbX6T5JZ20uLhE+Ms1CLsrfC3HYKZuC8AnRYfL3AJf/ErdmyZDkUaL3decDPyBUVU5A+sqR9cOv2YEm5/UzKKwLQhZVYMAYr311XnplFuPrO4wQjgsU7V3/2LV0WxcSF/xBqxUhhRwDtowZiY3BQZv41F7D6Snhjf9/3aiOipiaab7WwTrBUgDr+VENdl7vNw72D5qQkfLVc1HTK8Zi9YW2iJbtTGxzcvZjm+APx7+SQLH3i5Vsu6ZGolA4QZ2dP07SYg5GdfvJkACVTwLnMVzd2dfM3gLuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6POctbfhEPFCOjjPefevDVhKA35ERTCX+WA3KGNeqY=;
 b=ioKHHEgdXznDQiJ8r5I1eqmyj0CRXSE+uZJ0u+P4LuQ9tXq86PfQCPg4GLdpHT9n2/gtilNM2bsIWSeGM1iXFsMgKnWO65pSIc1C5+/L5uK1I74nkhearfJweHmvKw5hXT6RSYPEB5jz1eIJJk5Ufs5x5SfeyCdlwwLQSqV1aNXZo+TzRJV56pFOOqqMKcvZmlqkznf5IOvYv0IIxEZpmycJ9o2P3/dH2+zD0vROaVIckWXuo/bm/KEjhvK0VjUWmZjCxMfCbrQg+JCHoCNwycy52yq1/jUwzXfMgCINnRVLEcd3xbyXSvcuX1o7B1KGRXK9VDTU2XA0zeGPiqwJ0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:03:24 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 14:03:23 +0000
Message-ID: <e4ac7f20-2643-4f3b-8f85-5b11cd3ab606@nvidia.com>
Date: Thu, 30 Oct 2025 09:03:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 05/12] virtio_net: Query and set flow filter
 caps
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, alex.williamson@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-6-danielj@nvidia.com>
 <b55d868c-7bc1-4e25-aef4-cdf385208400@redhat.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <b55d868c-7bc1-4e25-aef4-cdf385208400@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0120.namprd11.prod.outlook.com
 (2603:10b6:806:d1::35) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 350d5e96-8a7d-4167-64df-08de17bd16df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjZGcTNlaXlzanVhdkpKZ1RZbmNJcE1kV1pSdFhJTkdIdG11aUhrekpOQURZ?=
 =?utf-8?B?QmN6OHE3MU83UFZYc21IZWJVYlVQZ01OQ0VwNmJ0dkljK0tBbXBpM0dMdzhP?=
 =?utf-8?B?Vk53NVBCcDNBcDFHdGU3OFg2djF0akVPT3NVcWxZeU5QbThFUHMvQm1zNFBC?=
 =?utf-8?B?NGFPK25ST1ZrVUMwNkNGWUdvbCtadXBaTXR3TTNmQnlYUFk1MzVmclFaN3Q0?=
 =?utf-8?B?K001TURpRVZsZWVTb3F1RXdyTVI0SkwrRG9oc3lHWTZ5eitQU1A5NEFZV3pK?=
 =?utf-8?B?U0YwSUlqOUtDUGNsb3pyNVROd3JiemQwNmpvdFhNTmh2TlRacVZScVptOG9v?=
 =?utf-8?B?QTBXS3EvMVdSeEhHKytOZHZBV2FzaXMyR2NSV2xDQlI5Z0MxaVBNMjJ4ZUNp?=
 =?utf-8?B?RlV2M2RDQ253b1dCbzI3eFphV3MrNUFWbkxaZVZkNXRBQjV4K2tBK2g1RVNP?=
 =?utf-8?B?ak5nNnkvYXpoMmJETnRUUytiSVB5Y0hubVhYWHgvN2xML1UyUGxJaVAwUEsr?=
 =?utf-8?B?SzlUMnBlSGVsd3V0L3NQUUpXUWMxTUcrSHNxWnF1UUx2eHVjZnp6ZVpwYVdD?=
 =?utf-8?B?VjFLSHp2WmxnY1VFRmk2UDJLaWVEMEVQc0FNdGNqR2ZrK2dLcjZnbk9hZGg5?=
 =?utf-8?B?QmUydy9ZNFJvMFlIWTR1K24wanJmdWRRYUpQZklWVUF0MmFHd1ZKN1FQQjRD?=
 =?utf-8?B?a293WWhOZHh3bU4xeUJKY3dML2NLMWIxZ2Rib1lwdGpPeGUvS2h2OXNHQzkr?=
 =?utf-8?B?M0g3UXJqRnpaYTZHdkQ1ekp1UjRiUmY5YmRrMmJCcEkvcUkxdVczbTBSR1VU?=
 =?utf-8?B?NVFOclYwSURJUmJWeDRNQjJneUZaZTZtOXp3NUdLNGpyeHBpUDl2UkZETDlG?=
 =?utf-8?B?OXd6c1lMQVV2YWFESVJFQUhBQVhJdWhPRDNZZnh2KzBPRWhpVG84MldSOGJY?=
 =?utf-8?B?M0FhZ0tNYVhmV2I5NWhEYytqV1ZVUUpGTUZDMExna3NreEFSZUxrZnFrRkQv?=
 =?utf-8?B?bE1ZdXZsZjk5S2VNbG14cDBQQzdaMnIzdHB3WTEvS0pob21RdCtGd0JSbThY?=
 =?utf-8?B?ZDdmeDRyTXpPOUxTNUlKdDhYYzg3SklObW9YcDRWSTk4MSsvN1JoaXlrRWI1?=
 =?utf-8?B?NFd0QTJHSlJybzBpWXQvSFhMT3ZYdUV2NjIvQld3UjQ1UnVSaHFnc3V1RjdG?=
 =?utf-8?B?QnlKQmNVZDhadlZXUzRKZ1pKQWFvRGlRcFVpZ01YTFNqSWxVVlR5VTJaUmF6?=
 =?utf-8?B?Y2FEbTdObDMrdGlnUTk0Tk9HaG5jd3VMUytRSHhwTC9zMVp5MzErSGhGNEVt?=
 =?utf-8?B?Zng3eEF1TnlPajg0eGVNaVY0RUZTbk5zMHo5eDZhdXNib0NGUnhNZTlNUnds?=
 =?utf-8?B?aFd1RDV0Z1lxSE9zbXR2elRmeUpWUDl6V0JMSDJoaHlIT1Z5Z3ZzWWtXS0lY?=
 =?utf-8?B?TjhMaEtENkJSZEpPR29MbFJhWGVHcXRsZVdmVmZlTG1jd2VjRVJWYlJ4NW9L?=
 =?utf-8?B?bkVqWjM2eTNtWUg1VVBjaTI3eHllQ2dGMnV6bS9TMXU0bnpYZWE3UklsV0kr?=
 =?utf-8?B?QXZaVnk1S2dRVFBpRXNvbmQzSlp1SWJSM09WQ0x2Sk9lcFRVc0RzWWh2Ly9j?=
 =?utf-8?B?YVdZR0dTMmNaeWg4U2dwM2N1K3lQUjE1VFZEeElIMHluUDBEY254TkhKV2tF?=
 =?utf-8?B?U211YkFnb2ZMbENZM3dTSGZkYm1VZXRNL0taakZ4OU9IT0ZJQXpPVTc2cHRl?=
 =?utf-8?B?S2crbEIrL0x4Uk00THFEREdjRVEzYnNQWFNTNk5BTmNoQ2hMYTFqaGNVaGdr?=
 =?utf-8?B?MC90OFdqc2F6R0g3N1JtTHpWdHZ0N0U3b3BDeGxaMWJ5MTdhOUJROVlBNGll?=
 =?utf-8?B?Ym80Yk1PZk1PUFplSHhtL0hvZlJYZ09SWDdYTnNxcjhrNWRuRFpIMFZ2bHZl?=
 =?utf-8?Q?Nl3FJp6otlIEASXBeWTHYi1259hZBCXB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXV5R25DTFFlc0tLOFZWdldnbC9KY3NGR25tZnluNVVBQk9kbUpnM3pqbzQw?=
 =?utf-8?B?cHJiY2xmQzlSU1dmK3ZmcFp3T2U4M2FoYlU5ZTVDbnVYdXdXelZjQmhZMVBx?=
 =?utf-8?B?Q2xaNkRIckNpK3lINWhEWFFIZFlVQUhtV3AvV3BSM2xLbnpQSW1vZnF0ZEd4?=
 =?utf-8?B?ODhoWmptcEMyajRGODlWOTEwSFVtanpuZjBBcndtV0dtbWxMUE9ieFdKbDB5?=
 =?utf-8?B?WS91Q29YU2ljOWRSM0UrOFkzVk5aa3Yza0ZtVUNiODYrTGJiaUVaRUpMa2Vt?=
 =?utf-8?B?WGxYVG5peHhadEVDL29WMStjekxhemh5OUFQVlN3N0EvUTJCbFJvaG1DMzVq?=
 =?utf-8?B?dUZnbFRrQjRsV0cwckhzSU01djE3ZlFpeTBUbDExSzB3TDFWVjE3aktMRi9O?=
 =?utf-8?B?ck5yUUhZNG01QzlTV0tLTUgxbFk2ZFhhRnRKdWFid0ZnRXZVUDBDdDUwS29W?=
 =?utf-8?B?c3lTZGExaU12cEh3MWxoaGxkZXA0anprZ2dMS0ljVCtaeTNPdVV1L1RoSFRa?=
 =?utf-8?B?S2s1VlNRM0JRTXdidGdBWmNyVWNhRGdWUjhJZVY0WmxBaTc5UHVwOG5GNGIr?=
 =?utf-8?B?ZlFZSXZhUTMybDAxYjh0VFdkSzMrS1VLWTFJMEFtOVlwbG92RW15QkZudjEx?=
 =?utf-8?B?MUdQUzZHNTUxOUZYdEovNmRDUXdocko1ZEREMmFkcDcwVFFQbUUxTTdBdEVx?=
 =?utf-8?B?MkxXNHFSR2NOQnpNck04d2orRFROOXlhT3JFc1BZNFpwdXFnVkZFc0lHUTZH?=
 =?utf-8?B?R2VrOGNYYWl4UGdyTjdYVmtsQUhvbXFFWjRmTnlDeTBtZklPenB0cUxLdGJ3?=
 =?utf-8?B?QXplZHFBckxZVEIrYzdnZGtZd2RsYUVmWVhLRm9xNlhiK3ExMG1CckdvNGtq?=
 =?utf-8?B?LzF1N1c1enZ2MXFmRmp0RGJmNGZzYSs5R2o0SE9HUWpMeERSWkNxYlk0VGhN?=
 =?utf-8?B?dkNTTU8yUGFOMmwyN3lhUHgxSnI1SEg0THlrV1NOSFR6V0JjMGhqTW5GU1dY?=
 =?utf-8?B?eTdERDFUTHB3ZlkxRnZPdVJFVHhFUkUrRmRCQ3pvWDdoaWphcCszTFE5S21Y?=
 =?utf-8?B?M3dHcEV0RmtOZ2pjTVJVcVg4TmlLc1NkekdJWE9NZG9YcnJaVmh4WWxta1Z1?=
 =?utf-8?B?dDNGMkNHMmVMREFIYm5DaDZhVjROY0FNdW1SRzB3ZmlJQWgvZGQrNkU4SjNa?=
 =?utf-8?B?OStDamVOYnlGK1M5blJocktFNjZUbDhsalA4RlNkRUEycnZTQ05wdDV2ejNW?=
 =?utf-8?B?elBDemh6MVFCamZYUE1La2xvcHZycVZKd01FQlRtbEVEKy9VRS9DQ2xGUTNu?=
 =?utf-8?B?Z0NhWExMOGloMUlIOTJVOTJDc2NFb1ZFaCtUYkgvUDByNmJNYTNDdzBScGha?=
 =?utf-8?B?eExnTy9NS1ZxVENMRENSL0cvM29xazM1UlZ5RUpGbHBCTllMMk1kYnVFVjcv?=
 =?utf-8?B?ekEyVk5ZbDdVcUgzckhIL3RQMlBpdUlKdDkzdGVmaDAvQ25ndTNhZFRJZTFa?=
 =?utf-8?B?NGJoVWFsRkRxN0J4SCtidno5ZmhKLzVsNTM5bW41QVZXUTA2VTQ1QWJGU0NV?=
 =?utf-8?B?cHRDdnNqTDR0SnNvTGlpSXoxM0I5cHlOMmkzTTBBaDJZdEhDVTdBVkRUSnB1?=
 =?utf-8?B?QUwxVVFXem0vYXRWdHJOTXAvMHFHekZ3SVp5em5wMzlsVHp1Q01MeEt1QVVL?=
 =?utf-8?B?dEpJQzBONlZPT0gwNXdPU0NoS3BUNzNHRWpkQUxlVURPZm5OUUVEMmhpY3VH?=
 =?utf-8?B?Q3prWHpDRVUrcFB1cjFnUlp1SExOanpoUGh1cTFEdGNmQ0k3eHlBenczT0xi?=
 =?utf-8?B?cUtTZVdsWFB0eTlrSHk5aXRwbkdmMm5OdE1oeUtCalhvN1JuQ0xaajB5Qm02?=
 =?utf-8?B?Q3FHU2hnclRrSnlvZ1ZhMXowNkdvTXgyTW5Eb1FFdis4VlAvcW1jU0ZlQ2tq?=
 =?utf-8?B?T3pabWpEMU5NblVpTjBpUUtoU0pFOVRqVW1TV1pYeW82YWN1akFVb1B4c0NJ?=
 =?utf-8?B?U3M3QlBkZ25na3FUZGIxWCtYY1lid25QcnlibkVMZ3JBcWM0THJlZkdXenF0?=
 =?utf-8?B?QW80UnF1UjZPT0VxbW56VGlDemc2SGxQb2JGN2cxWmJLVmJzNUdWUExEc3hL?=
 =?utf-8?Q?S4u5p4vq4fxZmLsR91PfJ9owB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350d5e96-8a7d-4167-64df-08de17bd16df
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:03:23.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZZfGKw9YUFa8UUr4u1vwhCG09GoDRdVTQCchWQtuxAJ6d8keW3FkCjAsI9nYzIGC5gmJvkcNwnXTBby57ssjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On 10/30/25 6:19 AM, Paolo Abeni wrote:
> On 10/27/25 6:39 PM, Daniel Jurgens wrote:
>> When probing a virtnet device, attempt to read the flow filter
>> capabilities. In order to use the feature the caps must also
>> be set. For now setting what was read is sufficient.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> ---

>> +err_ff_action:
>> +	kfree(ff->ff_actions);
>> +err_ff_mask:
>> +	kfree(ff->ff_mask);
>> +err_ff:
>> +	kfree(ff->ff_caps);
>> +err_cap_list:
>> +	kfree(cap_id_list);
> 
> Minor nit: AFAICS the ff->ff_{caps,mask,actions} pointers can be left !=
> NULL even after free. That should not cause issue at cleanup time, as
> double free is protected by/avoided with 'ff_supported'.
> 
> Still it could foul kmemleak check. I think it would be better to either
> clear such fields here or set such fields only on success (and work with
> local variable up to that point).
> 
> Not a blocker anyway.
> 
> /P
> 

I can do that. Thanks for reviewing.



