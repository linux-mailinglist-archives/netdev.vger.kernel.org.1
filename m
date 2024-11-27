Return-Path: <netdev+bounces-147574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F02D9DA496
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4757A28203B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E63188CC6;
	Wed, 27 Nov 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aQNMd7Tl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43D15746F;
	Wed, 27 Nov 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698945; cv=fail; b=Z5L2JN4K44/6+lWcWdiX05AW9MhTKcpRzzgs4bQz4OEKwYiG1wzjO82CsZYj2Gbp/Gch1s8VvRb0Gg5tPixcPz1i4PKgnSaDOM6FklCHs+8UqDJxr/5N5zj6kg5kv27wf9+ACsy30nnY4cw4X5oQjzpoZBwJOqYPyibb43qlFqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698945; c=relaxed/simple;
	bh=R7CxEdImLaNG4pC0ip+8Ull6rB5bQq7Hk9+vn79NbCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jttgga8AkvCBaJ+DbT/EDFyiUZ5Ji0vSoV08clTCD36Zjpkmkk3MqdcXEHOEwvxjAHdxapfv1+vrpNRlwJFU9Ju3zofLaSTQYMdJqmV4DtNAiko0XdVyYcYQAnx7+rhFaVqeCL0wU3xa1AQvhwNFOGGdc2I4z7emWgakbw0KmOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aQNMd7Tl; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvwrS0vV887xLQrp3yvzT9pYOyUevtrTzbGK1pcaOicBh/07SOuLNsappTY+k8XzUPMPWf5odwjZvyQoDQjV0WT/PRUPHK9bjIXUAhTme7QhBUmZXCD9tw9InQNTS5lja9LwHKvTi8Sj75H/XJoOvPO/giofTquCPnzg31A2+YyohY0a6xY4UyL2HDlOMztt2Q5ySPI6hA/gRyKyXo/r+hZSBXUL6rZQ5MHOgd7HHFwRPtBH5vgOqg1Ux5WeOZDjzzz1VBiem3IeZduVFdTz4ukp4SjVKYT3uYcO9JhdWhz7Q2yLeX26bj5MUKX/3isNh+E/1xV+jcPVZuWxZdyN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8UBideWrBNB4jFVxPrHkZZ+KLEUCXlMF82zS7GHbHA=;
 b=O/KJdHfpiAMsQYyDXneQNO5RRszpLOEM7/Ig7IiQuGW548gcHKeqbTCzeA/7vhEiwKdbjeEYgyX0r/xaXvPIbi+dlAb3qRdA8zvPUAY6720Apf7kFbQ77NaF+4iNev7qq7LRTtuE+ea2pJAT6S8UFHYby4hfAiAfMvSc7hc2Y3HAD8/ESoE7GcMO5fI2pQ7lgwVnIBKTD3LhVWzKgQVqT7nYkxzi2chSXN+QA4bfyvOM/tPJl6VIWm82haFsNtnv2dbt+kQ9s5Lti2RUM3DJkbmsbTWOrC8oZihYYwU5jkvvgfj30XN1tmRvhrVlG4MbMz6c4rrUdjBzlYNoIEkdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8UBideWrBNB4jFVxPrHkZZ+KLEUCXlMF82zS7GHbHA=;
 b=aQNMd7Tl+ykH1d9e3NM2XYyN+IO3FRY/WePDlH5FOXGiu2N2JCZKvR0DZnnya+99px2GL6egNtkonkar4ggHUmcOYKs4YEWTEXW+HmrjPhIL3391OhGGTRmw0mS6jAcVHeeLcsmuNOxp85Fop2kRs2Ei5IEVqmduMhQSzryFy5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 09:15:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 09:15:40 +0000
Message-ID: <718b80f0-a540-f5da-9ae2-0c964baedec7@amd.com>
Date: Wed, 27 Nov 2024 09:15:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 02/27] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, "Cheatham, Benjamin" <bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-3-alejandro.lucero-palau@amd.com>
 <79d02ee8-3b7b-4bc0-bee7-1968fffb9582@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <79d02ee8-3b7b-4bc0-bee7-1968fffb9582@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: b57d60a9-94aa-4d2a-907d-08dd0ec40ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjNnN2psT3RzTngwTU94dDZhL1UwOVZ3aXRuelVLOG80Z1VuM3lxQjRsQWY2?=
 =?utf-8?B?RVoxRFcxdHI3bSs5WXp5SXFGTUV2bkhrM2xvOW12RjdHRWtsUVYvOUtqcW90?=
 =?utf-8?B?VHJFL3pudWdNVnhNL0dYU3plQmVQMHVRVWp5bnFZTWJDeXR0cU1iMHZsR3RC?=
 =?utf-8?B?SkJuOUVhbUNUdkl1SHMyZGtNT0VqUGV3eldQNkprajQ0b1ZESXl3aVpubzB2?=
 =?utf-8?B?MWhjdVg3U1lYY3VzZG52SWMyamZheG5BaStlVUVWc09QVkVTRjRHcHJPMWZX?=
 =?utf-8?B?SzhIV0VickhXYzByV2RzQmphaEkrZ2pzMUd0LzhRa210b2M5SGNDdTRTaWJP?=
 =?utf-8?B?bG11Qk5sbzExVmMxMjlmZE9ZNkVOOEpNTTV1K2I4bjBmYzBTWkY4aTV5a1FL?=
 =?utf-8?B?N0NLM21vcGxmZnFCdUlONGROZWt3ekNQZlh3aTJVRnhPbmcyK0lyb1Jwdi82?=
 =?utf-8?B?RmdJTzFlTU5oekNUTnlGYUlKRlowbDB3cU9abnlJVVBKS0dXRjVVOC9vaVV4?=
 =?utf-8?B?bERYeHI1TVVxRU8xTmxyTUtPdkwyeE9DSVBIM0JVclJ4T1QzN1o0Z2dJeHNF?=
 =?utf-8?B?eEFwUW92MzJNUEV2R3QxNmpvcWliRkV6WlN6THRTK0VtK2pFb3JzTDMxZDVS?=
 =?utf-8?B?aStzNGkzNUhTaWp3akZSZUpqUzlxWDZXdGZjY1VIVFpIbWpDblNYdDdjYzZ1?=
 =?utf-8?B?NjRHZm9zSEx0U1JkQVVrMDRjRDZ6UFVuTzBRNWtlU0Z4Qm9DTlF4TFJ1Zmxj?=
 =?utf-8?B?YU5ZZk1UOUZLL0RNeEFHQzhhV3ptWW45Q2twdjFxUExFTDR0LzdaU09wTERl?=
 =?utf-8?B?NDVJL1hMcEgzRTN2N1NDTTZUOEsyZWFRS2hBa1BGU2lMZzNmMzdKZmwzUFph?=
 =?utf-8?B?blVvcThUT0pFaFNtMHdyN0lOd3NzTVpaaGpoWjRtS1BiekhaZVNmQi9MUXll?=
 =?utf-8?B?WEdpYXMxWXJqejBUZE9uMmhETmN1NGsyWVFKdk1LWXdXOVQwMjRIMC9GZ2d2?=
 =?utf-8?B?NE1tOWFGQkZiblNVSUZIUUVyWnZpQ2lXMkhkOXNaZXdrRnpGRmpXYUVYek12?=
 =?utf-8?B?VE1scXlrOGhqYVloMGhnZWxPNFhNMlRncHppdG5zcURqWTVwc1d0SmxheWV4?=
 =?utf-8?B?S0d4RElTL3A1S2gwdnR1UUVud0UzYXhjdjlNcW4wM2dpNFN3bFZnYlZ4dG9F?=
 =?utf-8?B?eU1yM0JSWnU3ZHBtQTgyTW9icGk4VzV3WGg1dmRlOEdRYVNIWGxRNDdlem5E?=
 =?utf-8?B?YitKT2tDK1EwalBvNElVd1BQVEpLYU5EcTBnMkxoRk1FcHV6VUEvbkpQc3I1?=
 =?utf-8?B?SUlIaU1VNXJrQ0p0dk5sMmt4Mk14aklFR3pGL3VHbU1SV1FMeGZIV2p0RG5j?=
 =?utf-8?B?TnZlQndwN0wwbE5iOFM1RTZNeXBjcy9oZU0xNjdoRjhtK2NrOEgwY1hoeVRa?=
 =?utf-8?B?VHVmL2tGWDdObm12MHJOS2JiL1ZrV3g4MThyemRVcWVzaEkrajIvOThOcklE?=
 =?utf-8?B?VmFvd2dlY3ZwSG9FZW5vV0NEazRaNFZVNzhCNUsycVFzRlRVMEFkdmhjdGNP?=
 =?utf-8?B?OERLK0FqZGxGcVBPU3puNjFvMkJGOEUvV2sxaGxoUUxEYVQvclg1Ylo1cHlO?=
 =?utf-8?B?MDZRM3NmUXFScmVmeEgydjR2R3lRZmRjWEZvS1FNcXZJTmRocGg3dXlHT3RP?=
 =?utf-8?B?NXhnV2hhTGRwYzgyTURvcEE5czdkYzJ3ZG55RGZqNkZib1dTbHZ1K3E5R1Bi?=
 =?utf-8?B?Rzc3Vmp0TnVxT0tDZFliaVUwWXdpa0NzTnFCR0t0a25KSzVkWTJ3aVcvbEk5?=
 =?utf-8?B?bFdpMGhNS3FhR1pnNlJiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkFzSVNyb1VoSzloelNpMC9PNlRTVW9DeDY5VEJ3U3FzVFY3L09ocitBSGZF?=
 =?utf-8?B?NzBEOXJ3UThrcDd1ZmNsaDU2Q3QySFlobE1nNjVjWDdHeUg2Z3o2V0dlMWlv?=
 =?utf-8?B?WEhtUlpFTmNyMWxIQ1llYmZXWVdnVk5iZVNKUndNVGJPRmxYNGxEaCtJZTF0?=
 =?utf-8?B?RmhiQmR0Q0tnYm1KWi9wUDBkSEpoVVBtUUNBV2J1TVpNaHhhemg0Sm1EeUla?=
 =?utf-8?B?VVI3S2xWY1VqZHY2aUNwSXBJK3BzT3hxaldSSzVkY0RyajAzV3YrNm81R3F2?=
 =?utf-8?B?dk5oNkZwY0pOL3lzT1o1bGpGTWQ4Q24wODJ6cUJjejZCRG4yR3F4VS85Q21W?=
 =?utf-8?B?VDhiblZQeC9NUzh2N1JPaUJHd0dsbzl0bWloVDBKcnZvT0RVRmVWVHowMVp6?=
 =?utf-8?B?dFlSbTJZWXd1MUlzMUJhOUVUTHdVZkJMajZSM0pNcjNCTnpwMzVVUGpqV3ZL?=
 =?utf-8?B?YWpkaVlMYm9XeU1ZY0NrNlI2cTd6Z1FEaU1pTFF5VGlHeFlvTUdOM1lkZlR6?=
 =?utf-8?B?K1NnU2x2K051WFNGWEtYTDN6aG1LdTdZM0NyZ1g1MkR2QzEyOFRyd3VTOThu?=
 =?utf-8?B?N3dKd3dORFdkR29iVHpFWG5PSjIyOHNwMVRFZ3V2bUpjYk9tUnpTMmtKVkU2?=
 =?utf-8?B?aVdOQmUraUR3TWZSdDBHRFQrYzR2ekx2Rno2UVFENGxuUUwzSTdIOUhOQjRn?=
 =?utf-8?B?cStjRCtiUW8vRDJkekZoSlVuRVM4Vit5YWliVXdadnlZTTE0eTNuTmZjUFQ0?=
 =?utf-8?B?M3pSUjQ4MnBoc0E1NkFiUFhIdnEzbDZJTEM3bkRhRWJZMk9pVElXRkVwQXJn?=
 =?utf-8?B?T3JNMElTLzdoWmlTSnZIQjFIaDE5S2tyM2RsSVN1bVhpR2JzaDJTdnA4WnpO?=
 =?utf-8?B?WGd0LzJCejBJSWczNTd5eHBzc0hud1dqUVZXTEFSdzF5Y3R2QkFhZ1ZGdmxZ?=
 =?utf-8?B?SUNKZkN6a05jbWU2VmVlTTdyTUtkZzc1RitqaG1ZWFQ3ZUhwd1Q3Tk4zdDhV?=
 =?utf-8?B?WlVwaytzWGphVnVZUHNhTWpFZGw2bGluSFFnajBlMlpNTHpBbEdQbzdxb2hC?=
 =?utf-8?B?Nlloblh4SmxRVWtHY1A5WVRmRW9NSW0rN1owek01Tm1lZWMrWkliVmZUQmd4?=
 =?utf-8?B?ZTh6aCsxaUFDb05SQ1pIMUVISzVTRW1LenZxbDVKWVJGZDkyZkZNaFFWUk83?=
 =?utf-8?B?b2t2QlpzN3JqK1VEQVFoWHdMMDJXUVlSa05yM2ZRRjhQdTlaZWNpbFMvNUZu?=
 =?utf-8?B?QXU2NStkalgwY0NxMkZ5Sk9GdzJybEJHak1lLzZmaVRVVkpZa21LZTNqaFE0?=
 =?utf-8?B?M09LMWRqMStyNTJRUDRaNXcwMkRDb2tmMDFoOXdJbnJOZFFXTFpqdXZVWkVa?=
 =?utf-8?B?Q3M2Yy9sdjhqd2c4REljZmtIZU1sWk9PVkJEQTg2MHdBR1ovek5VSjQ3WGVN?=
 =?utf-8?B?ekl2NHhMZW5iekFjYVBpOHN3VHFnMVpOQW14eXVVdVBPZGhuZ0RSR2lBV3l0?=
 =?utf-8?B?K0hQUnU3SnpNVmI0MFZmaEtXM2VJOHowRVljK1dTVnR5Z0IzRy9XaFB6b3VS?=
 =?utf-8?B?Q2VIUXB2N2xPY0NkWEoray96RUtTVGlxWk5YaGFWaXlkL2NkOXBmRU9HekpS?=
 =?utf-8?B?SmIzdmZ3b2wzRnhKajFHRHBpYTkvUVN4d0dQQXFqZ3dmbDREVHFHSVdRVE1Q?=
 =?utf-8?B?WXlxclRDTmk1K2J4MzlmWlhCbWx1ZW12NnRzZ1A4QWpGVEh0ZEljMTlsWFQz?=
 =?utf-8?B?RXlWQ0VjczRqbW9oaElXeUR0aElsL1lWaFFIK3UrcGZkNmtXNkZveHczeE16?=
 =?utf-8?B?S0pyNE1hTzErSmpSeHgvNGJVU1dsNzFLNUNzeUJMUVVvVzd0QXJGaVpiVWMr?=
 =?utf-8?B?aWU3N1dZMTFXVFdjVm9VUURLTTJVWTBBdXd5OW9CWU9OQUFjcWhJcXovNXYv?=
 =?utf-8?B?OGtHaHZndzFrUW9ybXQyYUFLckdWcXNiUnpDeEVxMkFVcVN0My9Oek5qTktk?=
 =?utf-8?B?TjRiUGgrTDhGK1VRV2dQZW1yTjBlZXBMSHZPOW9GSmc0eFRYNzVrRHhsbERO?=
 =?utf-8?B?NkMyOUpsN3plL1dUUHRwbVNYYjFZbmx6dURtNFBxQTVyMnBjV1VTbm51c0lV?=
 =?utf-8?Q?fsIS1nNKlpiPjn3DtAPacY6xZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57d60a9-94aa-4d2a-907d-08dd0ec40ff7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:15:40.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2LmdhCEkIKov+f8atUIvfBBao3AB8KgHD6X4azlS2DNQhs1lIEpgwQ8eszu4imq8s+5N4mPNqoR5TkyJY0vmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715


On 11/22/24 20:43, Ben Cheatham wrote:
> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependable on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  7 +++
>>   drivers/net/ethernet/sfc/Makefile     |  1 +
>>   drivers/net/ethernet/sfc/efx.c        | 24 +++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 88 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
>>   drivers/net/ethernet/sfc/net_driver.h | 10 +++
>>   6 files changed, 157 insertions(+), 1 deletion(-)
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
> If I'm reading this right, you want to make sure that CXL_BUS is not set to 'm' when SFC is built-in. If that's
> the case, you can simplify this to "depends on SFC && CXL_BUS && CXL_BUS >= SFC" (or SFC <= CXL_BUS).
> I'm pretty sure you could also drop the middle part as well, so it would become "depends on SFC && CXL_BUS >= SFC".
> Also, this patch relies on the cxl_mem/cxl_acpi modules, right? If so, I would change the CXL_BUS above to one of
> those since they already depend on CXL_BUS IIRC.


This has been discussed internally and the decision was to follow what 
the SFC_MTD option does. It is good enough for our purposes.

Thanks.


>> +	default y
>> +	help
>> +	  This enables CXL support by the driver relying on kernel support
>> +	  and hardware support.
> I think it would be good here to say what kernel support is being relied on. I'm 99% sure
> it's just the CXL driver, so saying it relies on the CXL driver/module(s) would be fine. I
> have no clue what hardware is needed for this support, so I can't make a recommendation
> there.
>
>>   
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
>> index 36b3b57e2055..5f7c910a14a5 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -33,6 +33,9 @@
>>   #include "selftest.h"
>>   #include "sriov.h"
>>   #include "efx_devlink.h"
>> +#ifdef CONFIG_SFC_CXL
>> +#include "efx_cxl.h"
>> +#endif
>>   
>>   #include "mcdi_port_common.h"
>>   #include "mcdi_pcol.h"
>> @@ -903,12 +906,17 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_pci_remove_main(efx);
>>   
>>   	efx_fini_io(efx);
>> +
>> +	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +#ifdef CONFIG_SFC_CXL
>> +	efx_cxl_exit(probe_data);
>> +#endif
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
>> @@ -1113,6 +1121,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
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
>> +
>> +#endif
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
>> @@ -1384,3 +1403,6 @@ MODULE_AUTHOR("Solarflare Communications and "
>>   MODULE_DESCRIPTION("Solarflare network driver");
>>   MODULE_LICENSE("GPL");
>>   MODULE_DEVICE_TABLE(pci, efx_pci_table);
>> +#ifdef CONFIG_SFC_CXL
>> +MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
>> +#endif
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..99f396028639
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#include <cxl/cxl.h>
>> +#include <cxl/pci.h>
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev;
>> +	struct efx_cxl *cxl;
>> +	struct resource res;
>> +	u16 dvsec;
>> +	int rc;
>> +
>> +	pci_dev = efx->pci_dev;
>> +	probe_data->cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	if (IS_ERR(cxl->cxlds)) {
>> +		pci_err(pci_dev, "CXL accel device state failed");
>> +		rc = -ENOMEM;
>> +		goto err1;
>> +	}
>> +
>> +	cxl_set_dvsec(cxl->cxlds, dvsec);
>> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
>> +
>> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
>> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
>> +		rc = -EINVAL;
>> +		goto err2;
>> +	}
>> +
>> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
>> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
>> +		rc = -EINVAL;
>> +		goto err2;
>> +	}
>> +
>> +	probe_data->cxl = cxl;
>> +
>> +	return 0;
>> +
>> +err2:
>> +	kfree(cxl->cxlds);
>> +err1:
>> +	kfree(cxl);
>> +	return rc;
>> +
>> +}
>> +
>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
>> +{
>> +	if (probe_data->cxl) {
>> +		kfree(probe_data->cxl->cxlds);
>> +		kfree(probe_data->cxl);
>> +	}
>> +}
>> +
>> +MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> new file mode 100644
>> index 000000000000..90fa46bc94db
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#ifndef EFX_CXL_H
>> +#define EFX_CXL_H
>> +
>> +struct efx_nic;
>> +
>> +struct efx_cxl {
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_port *endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *efx_region;
>> +	void __iomem *ctpio_cxl;
>> +};
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data);
>> +void efx_cxl_exit(struct efx_probe_data *probe_data);
>> +#endif
> I know nothing about the /net code so sorry if this is just a style thing, but
> you can delete the #ifdef CONFIG_SFC_CXL in efx.c (and elsewhere) if you add stubs
> for when CONFIG_SFC_CXL=n. So the above would look like:
>
> #if IS_ENABLED(CONFIG_SFC_CXL) // or #ifdef CONFIG_SFC_CXL
> int efx_cxl_init(struct efx_probe_data *probe_data);
> void efx_cxl_exit(struct efx_probe_data *probe_data);
> #else
> static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
> static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
> #endif
>
> and then you can just #include efx_cxl.h unconditionally.
>
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index b85c51cbe7f9..efc6d90380b9 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -1160,14 +1160,24 @@ struct efx_nic {
>>   	atomic_t n_rx_noskb_drops;
>>   };
>>   
>> +#ifdef CONFIG_SFC_CXL
>> +struct efx_cxl;
>> +#endif
>> +
>>   /**
>>    * struct efx_probe_data - State after hardware probe
>>    * @pci_dev: The PCI device
>>    * @efx: Efx NIC details
>> + * @cxl: details of related cxl objects
>> + * @cxl_pio_initialised: cxl initialization outcome.
>>    */
>>   struct efx_probe_data {
>>   	struct pci_dev *pci_dev;
>>   	struct efx_nic efx;
>> +#ifdef CONFIG_SFC_CXL
>> +	struct efx_cxl *cxl;
>> +	bool cxl_pio_initialised;
>> +#endif
>>   };
>>   
>>   static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)

