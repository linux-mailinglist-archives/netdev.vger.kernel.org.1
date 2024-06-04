Return-Path: <netdev+bounces-100407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8530A8FA6D6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9115B241F0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FC337C;
	Tue,  4 Jun 2024 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cST++06W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCA182
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717459959; cv=fail; b=b66Slm1JkQZ8WAWuhsK1cmrh0AsUxwZz+RtCP18aQZtbtcKK/i/DuVBdz8HA2aXItWZO88Ph86wr2X1Z6iVvxrXznBCzRoRM2EJlrSr+dmMUxQqyhuq+7O5cAQpO9o15v+qjnbU3u1/a19k/dkvh9NIPhNKDlxG+mOK0Hn/69As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717459959; c=relaxed/simple;
	bh=4O2iIJAQgUwnavy9vM4Dbk/mHGE8iwRsJ3ri0IadXWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nfliHkNdOIhOQnqMoZ0cg6B6HkcMZuj1zQdEh+/RInx19R8Q+DnQBiGCQfOU/gICAp7tMJYoDSZoAitelkGqUN1xcLcwNRWCJXYLJedSmdRTaA3E9Mn6DqerFmebFmEFdkzWaidkuQpBYb+A7s9NvImrXubpFpn1N/7+lZbkJS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cST++06W; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+KB5194JzmDV+8hlMK4TiLCVMWz/ggUcb4CB1enYW1ckfwmKUOZNVeitTtTEVFGE/nnGP3u5Ki/BKSOzD8kiP81c5klZd+eTgtt8Y4j8KvzLgWP8xj12h3iZAycgrRFikzO8JlGkIVlNE7jljmOanuuEaKp+x7c/yDk+uMTPJxtRMV+MuUCKpTcILHWSPRbV1MdLJIv21c5fTg9v/QquT8xVnK5qVqZegtyNJejcDoLNqewqyNfHA+S16F7ncarXmQ7M7JQ7QywAcajpErQo9PvVKzKoxK+02SrytlSchvamKzpE+ft0N4HXYouE5H3ijbCgWAXjTcbVkx8gzMy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijqR5V0xe96E5Ya3dGZim/IV48J1Ht6XwbwG13RcuGo=;
 b=nuKr+eabAdeMMbvgnz6nBqCZSHCcww5CX7msMKcMIE7PqHDVgH5MQCMtC8mWZGI/1cJ21vXWMdLLiIvHvQQEmzIjcZVMEzrjRpgzvpewJIstZ4GkqXk5XKo7A6hrf99BvEeb4JQ+mWz6j18uxZC7+BoKl9wQZ2FibRsiYBaNHI0kpUg43TfQfc/KQ/fRYyi7xfGPgA+A3brHy1g2e+gupdnxJSKTWMfS/rEDps6l23CUD/Cwyic1hIoiRqaPPcDm235IZYFqflB1JLbJknEg6l21w5c2zvZPeH7m3WlYDTqxHjhFlenifa++aDqvLgnT1GpIwHM/MYBhlm2OeX9Cug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijqR5V0xe96E5Ya3dGZim/IV48J1Ht6XwbwG13RcuGo=;
 b=cST++06WRgTuvh3OhYOigS33XzAXOGrNpjsD5DtDIO+KZkISR/RIEmSReggEizArDX+9O9jMtmni4TEzCHh3pD424BTzN4zmORTMqhFjOb/BeCYdBVbRyqU05pOIqM4PagcSY7iHZt6ADLkUx12mkVgBx7/VnZWZCUBdFOXzUIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 00:12:34 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 00:12:34 +0000
Message-ID: <f8f8d5fb-68c1-4fd1-9e0b-04c661c98f25@amd.com>
Date: Mon, 3 Jun 2024 17:12:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] igc: add support for ethtool.set_phys_id
To: Jacob Keller <jacob.e.keller@intel.com>,
 David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Menachem Fogel <menachem.fogel@intel.com>,
 Naama Meir <naamax.meir@linux.intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
 <20240603-next-2024-06-03-intel-next-batch-v1-9-e0523b28f325@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-9-e0523b28f325@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::24) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aeec370-2e49-4c4f-f7cb-08dc842b0864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SERpMDNhaldEdzkzY2UrMXFBOElRYUZiSWVPSDZiL202UWZTTGtnS3kwYnBU?=
 =?utf-8?B?SDI2eTFwZU9xY0RxQk1md21Bb0Q1bVBvdlRnRVpmcUU5M3FzYnZKN3lOaU85?=
 =?utf-8?B?bVo0U20zYzd1RHd3ZEIyQjdkODlWak9oZnNVWEg5cEQ2NTFia2FsVXVsZ0lk?=
 =?utf-8?B?anFOQ2p3U1pGcVRsMjRYK25nTTg3TS9Fdk85M29Mc3lBS1VKN25vYkJTd0dY?=
 =?utf-8?B?TWF3MGhnbXFuM3pxbnBteGZ4L3ZmNnhWNEg2OElsSG84RjZ4NFRON1NEUWh1?=
 =?utf-8?B?R090QzZibWt1aCtnL3ZBdHVwdTdhWGhtYkNCMVJ3Uzhxc2czV1VCK0g3cmJY?=
 =?utf-8?B?eDZ6M3ozZDhUVk5EKzhNd0t0b2lKbkxCeGxpeE16RGtYNndxZXNuOG5oc0JH?=
 =?utf-8?B?bnREc2ZQUm1nZ1ozdjIyQTZBSlJCRWw5ZDlpVGtFTy8rdHZlYkdoUk1xTCtZ?=
 =?utf-8?B?cThNTFU1ZnFab0FHS05zSDRUajNZeDJGdXZxUzMyRWNjdkIzYzVmcmhPUU5m?=
 =?utf-8?B?WlNPMjArWkZOV3FpZ056L3JjcVJBdTZPcjV0eU9pVUFGWUZMQkVMMW1UcW1j?=
 =?utf-8?B?VndXZDZJdjV1ZWxGWkJMRU55a1RXV2VERkdudEsxd0grTzkrWTk1Tnh0Q3V1?=
 =?utf-8?B?YUh6dVpocnprZFhVR0xVU2xubEVMV1BXaFFCK2ovaUtjWTJtM3BJdlY3bE9X?=
 =?utf-8?B?Y0RndDl3NktFN2MzMktCTHovV3htRVNDTlNFNTQwUm9SN0Z4VnFrSmx6ZXJO?=
 =?utf-8?B?YnIyMXBCUXN2MkRTdHl1bFFXWENYaVpqRTVERHBqUUdJVTlFc3hQRS9rTEl5?=
 =?utf-8?B?SW9lM0ZhU3R5MHdkaUdNb0JRRHdDdTNYbksvRzhNUHZHUDN1cWtkUzhsYS9J?=
 =?utf-8?B?NnpLSGhqa1FrTEZ6UW5QYnFUZCtmeWlaTitYKzZ6Sk1xSHlNNUplN2dMVjJR?=
 =?utf-8?B?T0NRZEIvNDE5QzRRL20vNjJFQi9SWExnaHVHZ2lOaFpNOVNXOEVtT3FaY0hX?=
 =?utf-8?B?MkUxUENjL1M3aCswc0lYWW95RmxNR1Q4STd0ZTlqclFiMTJ5S1NCVjZNUWY1?=
 =?utf-8?B?YWRoODhSc1JzcFA5MWhHVUdmM0VYNzN0TStSa1pxYWlEbXBDeTNvclNQNU96?=
 =?utf-8?B?Z2pMQVpqc1QwOTk4dmUxVXV4a2tnQVZpdFlMYVg0NTNvS0xTMm5oNE5DelNI?=
 =?utf-8?B?d3BBeUszaG50NkJKdFBOUUhEME1nRHA5RCtPbFhkdmpWMVQ5V2dpV2JFUUE4?=
 =?utf-8?B?Z3FDd0k5MDdaN3ZkZmhES2xZS1JJQ2lXdGFpdS9yMlE4djlJbHpoeHBDcXRw?=
 =?utf-8?B?a0lkR3F3eWgva3N6STRiZ2NPWmIwdXRXZ3ZRSFpDbzF3SFpnRWFBZ3YvZjlr?=
 =?utf-8?B?cEdJSXhXd3JGeW1QbFhBVExBV3ZMMFRiaUNCVE5EaFM3cDhkc3dQS0VEQWkw?=
 =?utf-8?B?OFp6L1pBZzFWQ2laRnlBOUpYWVlMc0YzL1pGSElvQWRTTjRNczV4bEFkdnFI?=
 =?utf-8?B?c2NzYzhocWUxYVhlY0VidTRyZEhVdlBrL3BZMXR6dThWSkNIRjJ6ZzB0VW9h?=
 =?utf-8?B?ZmxxdUQ0RTk2WkhqMlVMMzFMQ0U5OEphRXdjSUt6bHI2NEtZODJQOUxGVFl2?=
 =?utf-8?B?eVBud25wRkNTajJabVZTc1BJT0ZoMUM2OTZ4a1c0aThxREI3eVpUa2NNYkJu?=
 =?utf-8?B?VXFTcEJLRFdGa21nd2ZqOXpKcUdiVmw2Y09pZ3RTcy8wS2RWczFhc2JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1puRDVmU21xQ1pzREw3ZzBITHBCY2swVy9ZS2lZSll1ZmdZb1FZSE5qVEhs?=
 =?utf-8?B?bGRGS2laOWkzeXMwaTVlRFNJY09vUEYzbW0yVTJtemlteUpWbkJ1eUVhVjBw?=
 =?utf-8?B?eHI3R1Y4a2JxeXMvSjBtZEE0OTlwc25DSTU4M0dMeFJsbHJBOUphd3lwdWFD?=
 =?utf-8?B?bXBDd1N3cnczQzM1Ym5UejhIV3pHYkVNcEFFQmhGVjlBNTlLeEtnOTVkM1lP?=
 =?utf-8?B?V3RzRXlmeTY3SjlxTGphMEc3N0Y3VkhKYWsvOC9UVnYzSkFhL0VtdVBpRUdQ?=
 =?utf-8?B?bnBpSGd4TnhpZjB0RHovbkcwZHg4VnFWQTFGRmdKLzJuUVVmNW1Bb2Z2V0t3?=
 =?utf-8?B?WjZ6dWZldWJXSnhwSDlTT282OHI0VjBMQ0JHOTV3d3lkam9JRngxSk1RbnZi?=
 =?utf-8?B?YmFoWng4eVhLOVMwazVDcytacWVKdnQ4cllvRE05eGhvOFRuKzhqdXg4TGxS?=
 =?utf-8?B?UWVjcFo4NnBzN2hsNDJQdHNjdnhvb0lPK09Nbm04WjdJUGNBclE4RGV1dmJv?=
 =?utf-8?B?TVVscWhRelZhMEZOZnJWTlp6cmxrSWZwZVB2czNZOFgyMVRUMzZqOFkySGky?=
 =?utf-8?B?MndONDdxNWVUSi9rR09JdzZ4RksrSzFIN2VTY2tYcUY4VFYyQ21GWXdvV3Vt?=
 =?utf-8?B?Kyt2aktJQVk5VmJpKzNQV2krZUxMcGxIWFFZTGx2dGFYL2JEVWhBNVNSaGZZ?=
 =?utf-8?B?M3R4WGplMkVZNTdUVDlOVzNGNHhIbHFncXhkZVZQT1M4Z3d0Y0RPUkpWVC9w?=
 =?utf-8?B?WENLbUFFbXdpa2huenZoVEpNa3lQWktPQ0xHQjJoa0JDQ3E2YmdNTVVEaGVO?=
 =?utf-8?B?QTlVbWlsVWdiY09ybDBleEdMcEh4Vk1JNU9pUTIyYjI4SUU2R2VEd1Y3RjF0?=
 =?utf-8?B?bTNMRGdIaGNhbzVldGU2b2x1VEpFMUtNMWVhNG0xQlZHWW5oNkQ0TGhqcW5M?=
 =?utf-8?B?MnlFUTBEeWh4SjRZd0xheEtleTFCMEdXUzlpVnVVUUs2RHVhZVhlM0Z6RmZL?=
 =?utf-8?B?akpXd28xSUVYWHc0dGlXUENoYWVPUUw4S2FHNTRWeDBWa3hnZVg5ME5rRHZ2?=
 =?utf-8?B?cmRRTnYvbnZnUFBWQkJubEFJMkVSUVFjSEp2WUJxVnMrN0xPL09KOERvYkxl?=
 =?utf-8?B?S2VtNm9lM0dTbmp0N3Rsa0ZXV0VHNHJqL2R4ZTBFRW15blhGekt5bVdHRmZG?=
 =?utf-8?B?UEpSZHNQbGVRRlVLVlA3N2dVZ1Z4TnVaQ0JiOHNIaW1sdjBRWUVBMFR5aFJo?=
 =?utf-8?B?T21xUHdaWW5zUTVEUWlHRStacGZncy9tTGJyd2daUlRsNjU4SVdnTDJZemxk?=
 =?utf-8?B?ZW5XVnlFOFVqQjNoVTNZOVUxZEZsNmcrbzF0a3lpejJ6V3B5SXFaYjk3MFBV?=
 =?utf-8?B?eGtnbFFUaWdXdHFTVGw3U3h4bW5SbUxGTHpXTFN5SkhuMGorM2FxNHpZWnFO?=
 =?utf-8?B?RWZPOEVsbHZhcENoQ29RVERNSDlDQTJtYmhKMG5aN0hORU5BbjBKMVFYMjBp?=
 =?utf-8?B?NlEyc2pWWGQzSVRvb1QvdVZDbFpRQ1orSml1SFJ3cVhyZmRjWXdYMndQMUFh?=
 =?utf-8?B?azR5ZXBYdlpzUnBIbU1ON3BCZkxZOHhzY3JST0E0VTV0S3ZiZkpLOGRlSmNB?=
 =?utf-8?B?VEM0OUQxMFkvSHEzVGRiK0R3RWM3YXBVVlZYUmh4Y3IvMWN0WTBOTVRGUXlV?=
 =?utf-8?B?eXRBSnl6VjVyTlZKNW5JaHRJMkEyd1ZaWHdMV1RCc2dvVWFUQ2IxK1MyOWl3?=
 =?utf-8?B?QVhqdWJNV0RRRE1EYXJVTFA4YXVEaXNqY01TdUJXNVhRN0lON3Y1TjhtRzlL?=
 =?utf-8?B?Z1R3Q3lTUFd4Rm5tZkk2aWwzdzk5aU5hT1hNNmVmdTQ0WlRmNitzTFVDM29u?=
 =?utf-8?B?ejU5YWE3T1JNV1FsN0JodzUxcGJSL2IrMEk0UEppVnIrcUJsQkZXeDhyOSsw?=
 =?utf-8?B?MlNrcWI2enFvSmMyQ2hGUlRMcVorVG9zMlBmNTlJcmN1QTIyVlprNFBUNFVI?=
 =?utf-8?B?MWVhRVJaSllZMmlDSkUzMmlhb0FPZVBmUVJHeldwOFdUYk5GaEo3UTNPdDdX?=
 =?utf-8?B?OE9vQmJ1OWFZM1BCNWVCOWNneTNsd0hZdzVpbDdUOFVjMUs2M1pJSlJJR00r?=
 =?utf-8?Q?YnI3c8rOCiJuNEPSIOejpZYlM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeec370-2e49-4c4f-f7cb-08dc842b0864
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 00:12:34.0635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /D3TdlSW2u7QQPvyLgmXvb+gDkNdyGUFvIb+gVbohzxBjq5Ym4XaHV3VCz9b2uPAr2kA1Q+NGnIFTzyGZYRxCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459

On 6/3/2024 3:38 PM, Jacob Keller wrote:
> 
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> Add support for ethtool.set_phys_id callback to initiate LED blinking
> and stopping them by the ethtool interface.
> This is done by storing the initial LEDCTL register value and restoring
> it when LED blinking is terminated.
> 
> In addition, moved IGC_LEDCTL related defines from igc_leds.c to
> igc_defines.h where they can be included by all of the igc module
> files.
> 
> Co-developed-by: Menachem Fogel <menachem.fogel@intel.com>
> Signed-off-by: Menachem Fogel <menachem.fogel@intel.com>
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 22 +++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 32 ++++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_hw.h      |  2 ++
>   drivers/net/ethernet/intel/igc/igc_leds.c    | 21 +-----------------
>   drivers/net/ethernet/intel/igc/igc_main.c    |  2 ++
>   5 files changed, 59 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 5f92b3c7c3d4..664d49f10427 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -686,4 +686,26 @@
>   #define IGC_LTRMAXV_LSNP_REQ           0x00008000 /* LTR Snoop Requirement */
>   #define IGC_LTRMAXV_SCALE_SHIFT                10
> 
> +/* LED ctrl defines */
> +#define IGC_NUM_LEDS                   3
> +
> +#define IGC_LEDCTL_GLOBAL_BLINK_MODE   BIT(5)
> +#define IGC_LEDCTL_LED0_MODE_SHIFT     0
> +#define IGC_LEDCTL_LED0_MODE_MASK      GENMASK(3, 0)
> +#define IGC_LEDCTL_LED0_BLINK          BIT(7)
> +#define IGC_LEDCTL_LED1_MODE_SHIFT     8
> +#define IGC_LEDCTL_LED1_MODE_MASK      GENMASK(11, 8)
> +#define IGC_LEDCTL_LED1_BLINK          BIT(15)
> +#define IGC_LEDCTL_LED2_MODE_SHIFT     16
> +#define IGC_LEDCTL_LED2_MODE_MASK      GENMASK(19, 16)
> +#define IGC_LEDCTL_LED2_BLINK          BIT(23)
> +
> +#define IGC_LEDCTL_MODE_ON             0x00
> +#define IGC_LEDCTL_MODE_OFF            0x01
> +#define IGC_LEDCTL_MODE_LINK_10                0x05
> +#define IGC_LEDCTL_MODE_LINK_100       0x06
> +#define IGC_LEDCTL_MODE_LINK_1000      0x07
> +#define IGC_LEDCTL_MODE_LINK_2500      0x08
> +#define IGC_LEDCTL_MODE_ACTIVITY       0x0b
> +
>   #endif /* _IGC_DEFINES_H_ */
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index f2c4f1966bb0..82ece5f95f1e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1975,6 +1975,37 @@ static void igc_ethtool_diag_test(struct net_device *netdev,
>          msleep_interruptible(4 * 1000);
>   }
> 
> +static int igc_ethtool_set_phys_id(struct net_device *netdev,
> +                                  enum ethtool_phys_id_state state)
> +{
> +       struct igc_adapter *adapter = netdev_priv(netdev);
> +       struct igc_hw *hw = &adapter->hw;
> +       u32 ledctl;
> +
> +       switch (state) {
> +       case ETHTOOL_ID_ACTIVE:
> +               ledctl = rd32(IGC_LEDCTL);
> +
> +               /* initiate LED1 blinking */
> +               ledctl &= ~(IGC_LEDCTL_GLOBAL_BLINK_MODE |
> +                          IGC_LEDCTL_LED1_MODE_MASK |
> +                          IGC_LEDCTL_LED2_MODE_MASK);
> +               ledctl |= IGC_LEDCTL_LED1_BLINK;
> +               wr32(IGC_LEDCTL, ledctl);
> +               break;
> +
> +       case ETHTOOL_ID_INACTIVE:
> +               /* restore LEDCTL default value */
> +               wr32(IGC_LEDCTL, hw->mac.ledctl_default);
> +               break;
> +
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
>   static const struct ethtool_ops igc_ethtool_ops = {
>          .supported_coalesce_params = ETHTOOL_COALESCE_USECS,
>          .get_drvinfo            = igc_ethtool_get_drvinfo,
> @@ -2013,6 +2044,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
>          .get_link_ksettings     = igc_ethtool_get_link_ksettings,
>          .set_link_ksettings     = igc_ethtool_set_link_ksettings,
>          .self_test              = igc_ethtool_diag_test,
> +       .set_phys_id            = igc_ethtool_set_phys_id,
>   };
> 
>   void igc_ethtool_set_ops(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
> index e1c572e0d4ef..45b68695bdb7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
> @@ -95,6 +95,8 @@ struct igc_mac_info {
>          bool autoneg;
>          bool autoneg_failed;
>          bool get_link_status;
> +
> +       u32 ledctl_default;
>   };
> 
>   struct igc_nvm_operations {
> diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
> index 3929b25b6ae6..e5eeef240802 100644
> --- a/drivers/net/ethernet/intel/igc/igc_leds.c
> +++ b/drivers/net/ethernet/intel/igc/igc_leds.c
> @@ -8,26 +8,7 @@
>   #include <uapi/linux/uleds.h>
> 
>   #include "igc.h"
> -
> -#define IGC_NUM_LEDS                   3
> -
> -#define IGC_LEDCTL_LED0_MODE_SHIFT     0
> -#define IGC_LEDCTL_LED0_MODE_MASK      GENMASK(3, 0)
> -#define IGC_LEDCTL_LED0_BLINK          BIT(7)
> -#define IGC_LEDCTL_LED1_MODE_SHIFT     8
> -#define IGC_LEDCTL_LED1_MODE_MASK      GENMASK(11, 8)
> -#define IGC_LEDCTL_LED1_BLINK          BIT(15)
> -#define IGC_LEDCTL_LED2_MODE_SHIFT     16
> -#define IGC_LEDCTL_LED2_MODE_MASK      GENMASK(19, 16)
> -#define IGC_LEDCTL_LED2_BLINK          BIT(23)
> -
> -#define IGC_LEDCTL_MODE_ON             0x00
> -#define IGC_LEDCTL_MODE_OFF            0x01
> -#define IGC_LEDCTL_MODE_LINK_10                0x05
> -#define IGC_LEDCTL_MODE_LINK_100       0x06
> -#define IGC_LEDCTL_MODE_LINK_1000      0x07
> -#define IGC_LEDCTL_MODE_LINK_2500      0x08
> -#define IGC_LEDCTL_MODE_ACTIVITY       0x0b
> +#include "igc_defines.h"
> 
>   #define IGC_SUPPORTED_MODES                                             \
>          (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK_1000) | \
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 12f004f46082..d0db302aa3eb 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7070,6 +7070,8 @@ static int igc_probe(struct pci_dev *pdev,
>                          goto err_register;
>          }
> 
> +       hw->mac.ledctl_default = rd32(IGC_LEDCTL);
> +
>          return 0;

Is this the only time the driver should read the register?  Are there 
any other reasons/times that the LED register value might change while 
the driver is loaded that shouldn't get lost?

If someone leaves the LED blinking then unloads the driver, is the LED 
left blinking?  Should igc_remove() restore the default value?

Thanks,
sln


> 
>   err_register:
> 
> --
> 2.44.0.53.g0f9d4d28b7e6
> 
> 

