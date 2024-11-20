Return-Path: <netdev+bounces-146512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78D9D3CDB
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C9728244F
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098AC1A7262;
	Wed, 20 Nov 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zpPkNOt9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2091A2C19;
	Wed, 20 Nov 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111040; cv=fail; b=XXNKIfd0bFM0d1xOfHuM5si5Rt1cJZmUA1PymN6IlzqD6DQpcjjVbYN59ebamizA2TtO3C65Lb7u/Gdl/BM5FqNo3SQMvj18OhWs2w+V7IC7N3/xZQwLeOLwjTJTuWP86xNb0zAwRBZ62LRSivxdllDtz80KZ148JEic0pR5fAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111040; c=relaxed/simple;
	bh=CSgdObcVw40JR/b/NCkSIyR19QHXysqZv1T1QMsYy+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CvZG+FBX5pwaQG0J6+8tma78qbrx4mJWmb9t2xX8bHjzIMLIJgmlbEh4rY4bc8x65dOeDHq1XWh/iy0Q8F8hhm4cizFVwGtg5VOPBRWqA8kUAAHascBj3xtSb2ERa0C0Db9AlN031WhrShhRsZWLufdszVHYD4p3eCOOXDi2dos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zpPkNOt9; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwrDxuUMvC/Uc0DzAIM2KJR8AGipKL9NlTr1lzMZxienAhAU3slTTiPIZ0txtvndBqKxf3/3DjbCwepSzYRaEBQwgs/VuGgAh/hiorVgckXi7CPyvIMpLR+lEprcgFu/3nmLnjPUcAycMV+qwTvkOAd9OIfCByGzb4NflEo5XL0PzcLjuwM153m4UqbRyqOIONgYxN/e1cCRRBqz8Qbgge/FqEFu3qonIdCIfIIaDcJ72gdGPEDYTEkWjWZaCsDjVenWl6iejAQmuivVMPPTdVZCWQOkswkxaa+tPG9C19NZxtTDctzmFDybih8LhqQCRx4PFGS1O/WPRFD7anZa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+LweubzYaatS1e6M9IKGepGuHaKr9LTz5TQ+c4wskM=;
 b=Ns3eTuw5aZiZXAlJTt+rdOPyBt2ihUlUpdfBAUiki66RNe6uHXj8o8Gi3ev0QNOrh3mZTr5/0z8SEHbx0B6FTIrdVagSjQFfbtOFRU0f1X4BECG+uKu6HsYTzWp6iDtvw9p82sl5BECOqd9vrsUszCzXwaBYfBnVv5wJUQ6sHvuX+nTW0oGAx2MJp0+gEYM6X5xiOwiAFoGPA+SN+gS6BCvNVQeRjFEDeV1yF5iD1enektCfqSclDQF7e1tOJinN/gY375W+bEpps3e5Ybf1aZGtivfEJhxY+8Ny/yk4sIHhoov9CPC+nrXNaMvkDPc4JEC2Pdn4vMF9I9vasU/MRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+LweubzYaatS1e6M9IKGepGuHaKr9LTz5TQ+c4wskM=;
 b=zpPkNOt91b2fD+PYs9JC85wesZtPiSvkb9BUtx4nUGRmX1Uo7ocMI4ecV4tg9hwD3K/uwTZdTeYoZN/BbhiQrmF7fgCcaKRizofOgpz0NKRL25tvMYBCHIbG+0eOR/MPP8kvi8BRhDFj4U9n9twjxvFdHgLOhZi5DkYlncR+F0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:57:15 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:57:15 +0000
Message-ID: <e2e4136c-87ec-7e4a-d576-8c0002572893@amd.com>
Date: Wed, 20 Nov 2024 13:57:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 13/27] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Zhi Wang <zhiw@nvidia.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-14-alejandro.lucero-palau@amd.com>
 <75e8c64e-5d0c-4ebf-843e-e5e4dd0aa5ec@intel.com>
 <20241119220605.00005808@nvidia.com>
 <4fc8fd99-f349-47f9-8f5e-d4c393370ada@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <4fc8fd99-f349-47f9-8f5e-d4c393370ada@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: cddb5bfb-4e76-4362-c830-08dd096b3d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC83TTJjRWE2SkcwRHZ3cXhHREhHbGtIZmVmYTdPbFUvdmJlSDZKTkF2UTBj?=
 =?utf-8?B?RW80emZHZ01iWWNZZFhJN3BPYlZDUlJsZ3doaXIxOVU3d2E1bjg1VFBsRkNt?=
 =?utf-8?B?ZmFXTmlwSnMyVmpZTmpEeUtzSlc2RGkvQWFDd3JPLzluaWNxMGtqQy9seTk3?=
 =?utf-8?B?S21yUmFXMDdMUlBkMzdqak5IWHJqRjJXVHJvWm91ZUtVVDg4ZWNGRjBGcVEw?=
 =?utf-8?B?eHNYNDh4YXhFVkQ1TFkrT0tLM2NMbm9LWGpSZVBMeEs1UFJOU2JFVkFzY2pS?=
 =?utf-8?B?TkV4UjJKa2pTSlBqTE9LM1F4cldzUzc5U0RkMURaUWQ0MUQ5MG8yb2dZN2RG?=
 =?utf-8?B?QkxTUHpCaDB5N0pTLzhqUGY0Q3o1K3BnazJlQ0pYeTdnOEFicnZXZ0FqMnBv?=
 =?utf-8?B?SGVrS2NFWFlsNlF6RFlPcWlJblovWHBML3VPUG5RVktzS1Y2Nno5Y0FCV3Zm?=
 =?utf-8?B?SVduU1dFN1lMdnhxbFU2TTBNTm9mangzY0FhT1VkeEw0aytTVWpKWHhwK0pn?=
 =?utf-8?B?S2xLZ3FaNVBldlFqYmpPekFMdi9MYkk2cHBFaDlqQ3JuUHNoZGRMTDVUWk9V?=
 =?utf-8?B?NkZVd29oWGNPeUFZWmo1MGN0VWZYMi82VmhkLzlTWEdtQk9QTWxTTFNwSm1S?=
 =?utf-8?B?a1h5UFc2QS9CK0pLMENXVmRLTVJiUUxjSHBRcEk0L25QdUxnVFdtVk5BSjJB?=
 =?utf-8?B?Kzc1ZGtKbG1GRndvL2lQajA1K2MrNFEzdXFuc1M0cDc3YWwrQnJWSkJGeU4z?=
 =?utf-8?B?akY3aDdoeitlNTRkRXNzckRyeWZHcFhQTFhIOXpBaTE5ZU5RS084NmhQN1lk?=
 =?utf-8?B?Q0RDL2wvRGhUOUhPWjNkY0FCY3lyeStKZDhEdFN1NXpBWUQ1N1Jxb01mK0Jy?=
 =?utf-8?B?RXMwbFREZ0VQV0htamxyQnhGUnVkNzNvZGJISTloSkJqaC9HQjJySng0VHhy?=
 =?utf-8?B?L3padkY3TWw3VUFIV0FSejlRUURlRTFOdVl0aVhQZ2tNM0RPbjYxczlqajNl?=
 =?utf-8?B?Vk0xc2w5YVBIaG1KK0Jobm1abmFJbXN0ZmI0L0NuNGEzeVVCdE9ITmlyTFIx?=
 =?utf-8?B?ZFlmbDZLOEJWL0YxVko0WVV1djFPZWhyeGdQTGpvOUxoRE1hem5KeVd4eU1z?=
 =?utf-8?B?bC9UN2hmMmRQRTRLWkF4bkFWVkR6eUk0Z00vRXJnRzZ4SjIybDlaVjlkbzhI?=
 =?utf-8?B?Y3NLUTJ5dFdVeXM2aDFKWUV2STgrQ3lUU21SSXhyMWc3dUliNjM4aGtkNnJH?=
 =?utf-8?B?a3lmM3Vtek9LbnNDb0JqSzB6eU9CdzgrR29PZWdtYVNWeDQ1c2tKYUNVeHpI?=
 =?utf-8?B?UEJpcTQvelp2UEs3QnNPemgrTG1JcDlkbjNURVlUNldSY0ZNSUtlODVSRUhn?=
 =?utf-8?B?TjIwUmFyYUt0NkFiZEZlejUvdTNGdS9CanJqZ29TMjFPWXhsU0EvbDNhNEQw?=
 =?utf-8?B?MTJwYlpDNDE5dktOZHNEZ2dXQktWWDY2d0duRy9ZQ1FxcUpha3IvbEVET3h5?=
 =?utf-8?B?UUZremF0YytwWlhSNmp6T25ObEVBOW5zTTJuZnp6ODVXRVBBbmowaEJ6bDQ1?=
 =?utf-8?B?bTZFOGEvYkN5OUk2TkxvYkJCRXl4blNYSUpyclVkK3o3ZVR1Tk03dE5pTXVv?=
 =?utf-8?B?Z3BHSlZzbDE5azJ4M3pnQ2xFNFF0cTN5UXFzdCt2dm4wTDBybnV3UU5BMHR5?=
 =?utf-8?B?YytPclhRR05tQ2psQWdOMk5uNXVnWVJtNUxNRHNjYlMrRWxJTW4xdUNCR2Vx?=
 =?utf-8?Q?7DC7Um3yoQkmvFG10x5MEZxpoCkNizUW+seRZ2Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czViLzRhdFA0ejlDdXg0aDhPM3RmTWJ3T2dQbTloSHZYQ2wwWm5EazczQ21R?=
 =?utf-8?B?WStibnpCWWorMjM0VU5XamsxQnJvbktRZXpUTHlZYlF5aHZzZWVzOWFkRDVu?=
 =?utf-8?B?NHd3Z3BNWXhjS1NSQVRUWnp5WS9jL3A0NUpna2VwWXZnK012b3g5SkJua2Za?=
 =?utf-8?B?c0NxdWJueXV3czF6V3FneEs2VEtuMTg3YThiY3VMVGEvbk91cUszVi8zMktu?=
 =?utf-8?B?eXFzZzNYdWZEeHdtb2FWclJESmk0NWNubUI1L0xYUXhkbVRlaXB4OHJJOUxP?=
 =?utf-8?B?ZnptdEtEWGxFalUrY3VwMTF6d29WVXhMazBsdUpoUGRvWjdnTVJYL2xNd24r?=
 =?utf-8?B?R1ozc2VxekUvYzB0ZXFCdWFsc25pUTNGL2wzNFZEdlZoZUFudEtTM1loUVBu?=
 =?utf-8?B?ZjZCbzNXRzQrZzh1MzVPN1d3MW5ZMVNNcE9kbzJ5ajJwNFpZSEcwdzRxL0ll?=
 =?utf-8?B?S2ZabzNFQnlsZWZWVWQzTW5IdDVXakVzU3krU3FrZnhQaS9sSStSVklJbDc0?=
 =?utf-8?B?a0trTHZNZnQ0VzRxK1NhUFU2VmUrWHpZeVZPMDI3MSt4bGxCaDl1WGxrT1B1?=
 =?utf-8?B?eEh4M1hMSzhUT3hnbnUxa2ZRM0ZkSE03Z3dFQjJaMTV5T3VZeE1Kd1BINy9P?=
 =?utf-8?B?bEtQU1NGNmJ0NFBBdnl1VUh4UDVNTStES1NydDFlQ2NDRHMweC9qUlBBdDZZ?=
 =?utf-8?B?dnIyMS9rY042QTBSU1drYzNIUm5Najk5SjZDZFRFMW5hZzhUK1JtODJwOXZU?=
 =?utf-8?B?bUFYTi9WWERlOHA1Vmo0cVQ5aXdoN2VFeGl2eC82VzFJWkIrRXhZVWN3SEwz?=
 =?utf-8?B?bTBRS3o1MXczOG9qS0F3TElyZE1Uem9iYlhyZWZ1V3FaNmowdWxxL0NsOWFL?=
 =?utf-8?B?OFRQL2ZIWjR3QUdVZnhmQmZnanZHRy9oNFUrU2VvcitpeXE0OS9MOEcrUEVO?=
 =?utf-8?B?VDNZVmVRRUY5ZVB5US9tUnlMUjZlcFZFWWFWUldRdExrRGlYeWVNRkwyM05z?=
 =?utf-8?B?M29xQ05lcThkcXBkVk44NlRCYzZUTjNqVmMzdm9GRFV1VjVhaFZicFB1RFl3?=
 =?utf-8?B?REtIelpTNDVDVys1Z2VCSDEyOGlVNmY5a0NRNjgxU1ZaMG8za05nU29Xd05B?=
 =?utf-8?B?K2FycGg5VnFTMTFBRmNzTlN5UHdHL0VManF4bk5jeWR0cmZzUHdDblJJeFMz?=
 =?utf-8?B?L0t0Q0VNYWh6enhvMS8xUDhqRmswOVVkZUdoakNNTmxscm5lVjJQVEJKTHVF?=
 =?utf-8?B?ckR2aEdsdDlaNitVSDl3Vi92UDhBNTVOdlNybmw4NHJLTnptalJUdDA2NS95?=
 =?utf-8?B?VnRkbmtaZ3hLN2VoeEQ0Snp5bnZoc3daNE1YM1hnUElVOUZIQU1BNnZtSFZV?=
 =?utf-8?B?WitJUEdNUXJ6SlY5V1VRWGdWVjJxeG5MdFBVdHJRdHMyOGlISnFySjZkajE5?=
 =?utf-8?B?Z1JFb1BBT0xEWURpK2FmVGRzOE0zWllFUWt6RHJxN0lXcEoxeFBUejVpbWM2?=
 =?utf-8?B?dmhnYzFUNWpLRXNEOEc4c2hPa01yVXE0YXpRK0xsbVh2dDFNYzV2M0QweWJ6?=
 =?utf-8?B?M0oyUlJNNkxWK2dvTnE0aklpUVp4bUZTQTl6Y1FibDdMN1VPb3ordExTRFlx?=
 =?utf-8?B?N1R5OTFBNnFOR0hJTm9ZYTFIQkZGS2NKbFRscncvOFZRTFplZ2Y4dWljeDls?=
 =?utf-8?B?UVl4QXlUbVkrZ2FzZzBTR1pkazdtMWMrekFHM0E1OWpSOGRxV3FRZHZ4YlNS?=
 =?utf-8?B?OEwzSDFvM3VIaFNxMDhEY29mRkRjSDdMMSsyVDVWdXVzY0psbUF1MGUrWDUr?=
 =?utf-8?B?cVZhcnVUdHhVR1hTNzZxdGdoc3RSVVJmbkpVVm9wdkgraEUvcWl3R2U4WUx3?=
 =?utf-8?B?ZDNOTDJyS0NEZ2NxTzJjeGJTd1lNMEZLbEIzR3JZbkxuN1JIMXRBVWFwY1N1?=
 =?utf-8?B?ZGRzRnNGbXpsaDFmQVJzNFR1N2ZwZlRVaDFQblFlcXRPb0M1K0NwU3pqOVlV?=
 =?utf-8?B?enBWRU5mK29YWDl5Mmo3RHVpM3lUaGZwZHhkaDdtYnR6VmRYYWlzYW5GYkZj?=
 =?utf-8?B?YnR3SlBHTGlnSG5GZVh2b2JZN05GYzJIUE5UMFU4cVp4TUNUbVdMVmp1cVVJ?=
 =?utf-8?Q?hQxDlAt9cIvg4ivG0W0PMBzcs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddb5bfb-4e76-4362-c830-08dd096b3d82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:57:15.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12X3me6M5z1tBp6IYb/mmASrwJfdlZL9wncb5hfZFqQPgAKx3tsXngi+sf+Y8ngvM/kj0eulP1GCEmx+ac/R1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924


On 11/19/24 21:27, Dave Jiang wrote:
>
> On 11/19/24 1:06 PM, Zhi Wang wrote:
>> On Tue, 19 Nov 2024 11:24:44 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>>
>>> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device
>>>> when creating a memdev leading to problems when obtaining
>>>> cxl_memdev_state references from a CXL_DEVTYPE_DEVMEM type. This
>>>> last device type is managed by a specific vendor driver and does
>>>> not need same sysfs files since not userspace intervention is
>>>> expected.
>>>>
>>>> Create a new cxl_mem device type with no attributes for Type2.
>>>>
>>>> Avoid debugfs files relying on existence of clx_memdev_state.
>>>>
>>>> Make devm_cxl_add_memdev accesible from a accel driver.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>   drivers/cxl/core/cdat.c   |  3 +++
>>>>   drivers/cxl/core/memdev.c | 15 +++++++++++++--
>>>>   drivers/cxl/core/region.c |  3 ++-
>>>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>>>   include/cxl/cxl.h         |  2 ++
>>>>   5 files changed, 39 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>>>> index e9cd7939c407..192cff18ea25 100644
>>>> --- a/drivers/cxl/core/cdat.c
>>>> +++ b/drivers/cxl/core/cdat.c
>>>> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf
>>>> *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle struct
>>>> cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds); struct
>>>> cxl_dpa_perf *perf;
>>>> +	if (!mds)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>>   	switch (mode) {
>>>>   	case CXL_DECODER_RAM:
>>>>   		perf = &mds->ram_perf;
>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>> index d746c8a1021c..df31eea0c06b 100644
>>>> --- a/drivers/cxl/core/memdev.c
>>>> +++ b/drivers/cxl/core/memdev.c
>>>> @@ -547,9 +547,17 @@ static const struct device_type
>>>> cxl_memdev_type = { .groups = cxl_memdev_attribute_groups,
>>>>   };
>>>>   
>>>> +static const struct device_type cxl_accel_memdev_type = {
>>>> +	.name = "cxl_memdev",
>>>> +	.release = cxl_memdev_release,
>>>> +	.devnode = cxl_memdev_devnode,
>>>> +};
>>>> +
>>>>   bool is_cxl_memdev(const struct device *dev)
>>>>   {
>>>> -	return dev->type == &cxl_memdev_type;
>>>> +	return (dev->type == &cxl_memdev_type ||
>>>> +		dev->type == &cxl_accel_memdev_type);
>>>> +
>>>>   }
>>>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>>> Does type2 device also exports a CDAT?
>>>
>> Yes. Type2 can also export a CDAT.
> Thanks! Probably should have the split out helpers regardless.


Maybe, but should not we wait until that is required? I did not see the 
need for adding them with this patchset.


>>> I'm also wondering if we should have distinctive helpers:
>>> is_cxl_type3_memdev()
>>> is_cxl_type2_memdev()
>>>
>>> and is_cxl_memdev() is just calling those two helpers above.
>>>
>>> And if no CDAT is exported, we should change the is_cxl_memdev() to
>>> is_cxl_type3_memdev() in read_cdat_data().
>>>
>>> DJ
>>>
>>>>   
>>>> @@ -660,7 +668,10 @@ static struct cxl_memdev
>>>> *cxl_memdev_alloc(struct cxl_dev_state *cxlds, dev->parent =
>>>> cxlds->dev; dev->bus = &cxl_bus_type;
>>>>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>>>> -	dev->type = &cxl_memdev_type;
>>>> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>>>> +		dev->type = &cxl_accel_memdev_type;
>>>> +	else
>>>> +		dev->type = &cxl_memdev_type;
>>>>   	device_set_pm_not_required(dev);
>>>>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>>>   
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index dff618c708dc..622e3bb2e04b 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct
>>>> cxl_region *cxlr, return -EINVAL;
>>>>   	}
>>>>   
>>>> -	cxl_region_perf_data_calculate(cxlr, cxled);
>>>> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
>>>> +		cxl_region_perf_data_calculate(cxlr, cxled);
>>>>   
>>>>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>>>   		int i;
>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>>> index a9fd5cd5a0d2..cb771bf196cd 100644
>>>> --- a/drivers/cxl/mem.c
>>>> +++ b/drivers/cxl/mem.c
>>>> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>>>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry,
>>>> cxl_mem_dpa_show);
>>>> -	if (test_bit(CXL_POISON_ENABLED_INJECT,
>>>> mds->poison.enabled_cmds))
>>>> -		debugfs_create_file("inject_poison", 0200, dentry,
>>>> cxlmd,
>>>> -				    &cxl_poison_inject_fops);
>>>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR,
>>>> mds->poison.enabled_cmds))
>>>> -		debugfs_create_file("clear_poison", 0200, dentry,
>>>> cxlmd,
>>>> -				    &cxl_poison_clear_fops);
>>>> +	/*
>>>> +	 * Avoid poison debugfs files for Type2 devices as they
>>>> rely on
>>>> +	 * cxl_memdev_state.
>>>> +	 */
>>>> +	if (mds) {
>>>> +		if (test_bit(CXL_POISON_ENABLED_INJECT,
>>>> mds->poison.enabled_cmds))
>>>> +			debugfs_create_file("inject_poison", 0200,
>>>> dentry, cxlmd,
>>>> +
>>>> &cxl_poison_inject_fops);
>>>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR,
>>>> mds->poison.enabled_cmds))
>>>> +			debugfs_create_file("clear_poison", 0200,
>>>> dentry, cxlmd,
>>>> +
>>>> &cxl_poison_clear_fops);
>>>> +	}
>>>>   
>>>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>>>   	if (rc)
>>>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject
>>>> *kobj, struct attribute *a, int n) struct cxl_memdev *cxlmd =
>>>> to_cxl_memdev(dev); struct cxl_memdev_state *mds =
>>>> to_cxl_memdev_state(cxlmd->cxlds);
>>>> +	/*
>>>> +	 * Avoid poison sysfs files for Type2 devices as they rely
>>>> on
>>>> +	 * cxl_memdev_state.
>>>> +	 */
>>>> +	if (!mds)
>>>> +		return 0;
>>>> +
>>>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>>>   			      mds->poison.enabled_cmds))
>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>> index 6033ce84b3d3..5608ed0f5f15 100644
>>>> --- a/include/cxl/cxl.h
>>>> +++ b/include/cxl/cxl.h
>>>> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev
>>>> *pdev, struct cxl_dev_state *cxlds); int
>>>> cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource
>>>> type); int cxl_release_resource(struct cxl_dev_state *cxlds, enum
>>>> cxl_resource type); void cxl_set_media_ready(struct cxl_dev_state
>>>> *cxlds); +struct cxl_memdev *devm_cxl_add_memdev(struct device
>>>> *host,
>>>> +				       struct cxl_dev_state
>>>> *cxlds); #endif
>>>

