Return-Path: <netdev+bounces-254881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGy3Kk2fe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:56:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDBB34AE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDF9A3072A24
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B33559E7;
	Thu, 29 Jan 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VjEjtBl8"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF23559E3
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709121; cv=fail; b=j754PJAUdeJAM23ssimSRiJka6tt9dvyNzIXDcEsEtTQn4xDaWBkLBlKQTTwc4kPKFjZDI9hgtMttrlXsjAEPbqITNafXTn44aEPE1EsgOC3Ld83rFh9BELHewvPCAy9ESL/AQ0kC33N/pXgejusulJxcvlSuzQxSCyxuE5zLlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709121; c=relaxed/simple;
	bh=JF3HmddUCRS2kkCD0M25JK9VdZ0x40SEIwvLNZh0iRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PELkImkv3g2rxgwACvakja/37gRrcrOlsiS5vTHDpACaTH1DxWNgBStyC8ycDOTRyLxEqNWBwnrn3FdmPF4zSK8Mav1qHQLSLUMk77x3L8SrT8Y8Swilq5oM+mWOGugKsgMHOOJKN7UdQ1uzVJyUDNCfSylRxJnPDI+crg5F8Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VjEjtBl8; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f278sP6b7kXI8S6+x2KQ9jZoBa1/0BhIpZGyV65MdwfMFFKEJbesugG2vAAB64/LPrcrQoNOIBNPej7q/9aBChvlVpcJo3BZrl5qUkNWn/xEOU8Bysqz8Vw079VqOqwKj/j3Yi8ccuvOkglXWLlfb0yHcTv2Qituyamym/z7c3HT8ntyfW70Y2dntYP39O2u+uPhA2nCvTjymDFEmr+EYXCrO9SkPP83mQAEfhS+M6F69mMXhNfYfOMJuQ1ObB8clbFfBAF521lzeXF+qPCVabnb7a9zmRhV5z+1REHrwcKm8YOGHwXn71jyuzB/jpoPXxvJN1h+2MnopiuWr/BOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyxHD9XHk8p1SVk7FpVMC/LZAyS7F+b5qXkoKLU47S0=;
 b=t0zGgNoVna1eIib43OKZd/jkw1RqOu378qvBKkccxzA2oTKmb/T4oB9Y4gq6HU09QPIZ05V59Wl00mNhbyomlbpwPoO3ajIMryDS1B/XZgTfGa+YjoiZc1opBhrGfEIBx8cLOaT8FLPKEHzVT/4Idp/fZXJRuvIdL61QBfHlN+gSQm3X7Njy1wv/BQr8CuJzzlhnwccrbN4F6cf1JNnDThktsz+odNBQTywh7hVCIDcwcUUyPW5h7Z/OwsEID6we96J6ZxRe6sSO23GxDSR9ii5k/eSGzpJGQDICR5fW6/zFI5/vjlSVhbYTN3hoYC5kmIkiUQaUjeuasfDkAlicgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyxHD9XHk8p1SVk7FpVMC/LZAyS7F+b5qXkoKLU47S0=;
 b=VjEjtBl8sxvXVBEf5Getl1L1wc3uN5bvIi+mnaxT3+oM2E5zVozM2WqMTqG2jJUtXwy17abta+sxzrPdL1w20E63m0czPCmrYbUKuUgo8ThOgcxkp0OqpFAhxAoJtXRtcwYBLPecQ4jJMb96qehBi3SUtug/hG7HpVteeL4R95+dVytrHJExp96CG4m82aK7cB510aeoUy4HBduJ5zTKpS+6I3OcsMJA2ygFvQM4pQ/U9Cx+EVBzuZPC+WvwbJkwUxH35dKiSehJpaR1HrzVJ0SqpLb0K3Mf6dzBQPSR18C6XUrfRcBVBbMKAfiDJXgYui4x8hA8Qb8p7gsucDBy7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) by
 SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 17:51:57 +0000
Received: from DM8PR12MB5415.namprd12.prod.outlook.com
 ([fe80::e757:d15e:4293:e24b]) by DM8PR12MB5415.namprd12.prod.outlook.com
 ([fe80::e757:d15e:4293:e24b%4]) with mapi id 15.20.9564.008; Thu, 29 Jan 2026
 17:51:57 +0000
Message-ID: <9b56861d-d940-4409-9a93-9f42cbc1b28f@nvidia.com>
Date: Thu, 29 Jan 2026 11:51:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v16,05/12] virtio_net: Query and set flow filter caps
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
 jasowang@redhat.com
References: <20260121220652.894364-6-danielj@nvidia.com>
 <20260123014338.3007350-1-kuba@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20260123014338.3007350-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To DM8PR12MB5415.namprd12.prod.outlook.com
 (2603:10b6:8:25::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b84060-91e8-4c08-984b-08de5f5f1893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0Z1QjVDMjBqQlVsaFAyMThZc2pxRmprTUgwelE3T1EzZFRnUDZWdko1M2Ft?=
 =?utf-8?B?YVhSVkhlR3llcHZpVkdMNE1TZUE0TUJseGhDcFQweG9FZmRhb2FNQnZlaHd1?=
 =?utf-8?B?ZmVSNjhoOE5kU21wZmFIREN1cXB0Ym92OGhQamhkTkRrcmcrN2gzWkYwSGcz?=
 =?utf-8?B?U3gwU1VTV0Z0OVV3UzRoM055aDZUWWQwdVJGR0pXMjBQL2pYRHVtRUNUamhp?=
 =?utf-8?B?blFmS05pTitXVXVqeFdZTk1kNEdYTFRHQkNQcHhaZ3IvNkRxbHVBRGw2R3NW?=
 =?utf-8?B?THJ3aU1tSUFlS2JMcXRVaWlMZ3Y0eW9CRi9DdlpFVXQ3WkM1bURJZG0xNVAw?=
 =?utf-8?B?d2hVYWlIM1FVeFF6K0R3MWFWUk5hc2t4OG5PWlZvYmdjQy9vdmtMbTFLUlVL?=
 =?utf-8?B?Q3EwWVNrZGtmMEVSWGJVUXJPSUtwT1haWnJNaGp0RGMyd24vc0p0OTNXaEI3?=
 =?utf-8?B?ZWFVZUFKZjhKSnNkeC9ZTXBiZXFwRHdrTWVzOHY2bjcxZDg1RXhFK2ZTVzlI?=
 =?utf-8?B?SnlRbUdjNStlSlFsVVV0b1Zxa0pxVnE2NjNkNTUvb1ZGMW9LcHNzQUVNNzQr?=
 =?utf-8?B?V3djeGppNWZHRnpUT1FLelY4S0FDZ3hPckdpV0JlSWwzMnpkYnBiVWxmK3ZR?=
 =?utf-8?B?Mjlzc2RoWXpmcHJEZ2Z2a2RGL3RwenZoaFJJcjgxNmxZU3FPQjA3eTk2RHdt?=
 =?utf-8?B?Rm01ZDl2NU45RStSa1luQ2RRRWN6Y3V1QWloNnFlRldMYUtFV1RIQjA2T2U3?=
 =?utf-8?B?UUJBaGdOQ1Y1eUdidVRIN2sremRsaG8rT0JtV3IwOEFiV1kxazFxWXZ0VXc5?=
 =?utf-8?B?bllpVnRreU5RMEFCQWhod1pnYzZqTUloN0poTXFoQm5xemJ0c0J4NzJaVmt3?=
 =?utf-8?B?YVZvRzlISmN3eitnRnhLRGxtSHFkMTF3ZUZlZ1o1eVlZdTR2OFJhVVhuZlBk?=
 =?utf-8?B?c01TN2xTZi9Hb2sxZHdlR1E5WFdnQzVuRFN6QUt1VUt4a3pJYXA3OHp3RTlX?=
 =?utf-8?B?bDdObHRqTEVndS92bUVjajlPUFU5Rm04S0xzbEVoMkJmdnVHUGRZYlJpNmpE?=
 =?utf-8?B?Rytmczk2eDRrbTVCVUxHaXErVGtFTjBCdUQ4T0FRUFFJRmhKbmJzL2tmVnpP?=
 =?utf-8?B?d2RCVDJZb0x0TmZwdlhjQk5tSVdEbjdRVis1UzNoSFJZRGhXamZlM0lXaC9T?=
 =?utf-8?B?UzdQbVl4Zzd3UzZMbFFtRjlXUnFHREtnT3E1b01GSjJSUGk4TlRGWWlZc0lL?=
 =?utf-8?B?ejFPM0dKSFNnSVVpcXdDWXc4ZUNDWjVTWDluS1A2YkVqSzJTc2N3dVJLclVn?=
 =?utf-8?B?VXo5cE5xYkFXSk13TmRiZjg1NEp3K2E0d3FqYmR4cHNmbzMxeXh2U1VOZlZJ?=
 =?utf-8?B?QWFxMysyWlNVandHZzlUSUdaQU8xeDdKaWhEdHVaNHdkZXZPUFo2WldERjJU?=
 =?utf-8?B?eDFIN1VwL1AzTlNCb04xZFpWVkZDZ3ZIZ1g1OUZoOWVEQ0dobllGZndVc0lt?=
 =?utf-8?B?dnkyb2J2OEZ0eVhnSGduNXp4czR0YWFoNDZER1VlUk9Eams1MU0xWWI3Qy83?=
 =?utf-8?B?MTBWOEtwdVdLUGllTEVpK1lJNk1mMUNiUkFuS0FRd1FkVnVjMlRsdEw5a3Yw?=
 =?utf-8?B?NDR2Y3ZpOTd5cG1oWlQzRFZRaXREdGhKVlVraWJ4MHlKK0hTZlFWeEFLSjA1?=
 =?utf-8?B?aVA0RHJqYVNHbGF1clAzMzVHVmdKcU9kZUo4TGNlZEF6emJNSHI1T3NUSFdY?=
 =?utf-8?B?RVFNTzB3K09pK0Y4Q0Q1MkVwbFo4STZJOURwUndlQnVySVl1NUE3V1dUWDlS?=
 =?utf-8?B?bW9UTmp4dC85aDR2cW5xQlhlWnRMRkYzV0ZpanlEeDRNNFV4eFlKa3FSUkFB?=
 =?utf-8?B?TU56U01HM1pjMXdoNkNBcTRlQTczYVFvRVpiaGNzcmVkdGE3cUlWSVlPdVZw?=
 =?utf-8?B?QjNTcHZFMElPRWdhb3p1bWRzZ1lTcVhtamlVTmdMQXNoazBBYnpEMW80c1hw?=
 =?utf-8?B?NVNPbEVqSTRhQ2JMa2ZYWjJ0NVk3aGpGbUhjK2Ezd2lVUEMxV0xveDUrKzIw?=
 =?utf-8?B?TDdvNEZKZElKSVo5QlM3enAyc3NsQUFmaEh6YXo1Q0p2V0lpeWdOUXNaemg0?=
 =?utf-8?Q?hQ4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5415.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEd2UjEzUFNnY1RHSDJScTdTMDJ2OFBXRTVmaFhJL2g5OURweU1RMVhNOTNL?=
 =?utf-8?B?dGN5VWEyTVpBY0NwdnhvcGprdmN4VVY0M1Awb2Y0S2xUNmN3eUNhWkQ5Tk5k?=
 =?utf-8?B?cllTUnR6YU5wZzFNM3E3Q0RqWGRwdC9RQ2dURTdsVXJ5U0Z2SUFLTm1iVnhY?=
 =?utf-8?B?ekNaWWdjOGxxa1dxR0s0ajZFNW5ic2U1aldjZVp0Y0NxNS8wU3IyZnVRdTVJ?=
 =?utf-8?B?K3RSRTRFUVEwa1FqUkwrVEVpV0t5a2hqZjB4VE0xSUJjV2t2ZTJNb2tGaGZ4?=
 =?utf-8?B?M0lkK2xETUJVZjk5Uk9ndUdYMFdQVlkyYnMyeDJxUER0VGRkS2x0RmU0Mzcr?=
 =?utf-8?B?RWlZd3BhSCs2ZTdBNGMwaDIwNTBrdjV3QzJqb3pzTGhXQ3cyUEM1cXF4T2J4?=
 =?utf-8?B?TWF0NDBlQXFFZnFaMTN3R3ZuYzRzem9iV2ZqSzFaZTNnNDNGZDFkWDBkMjBL?=
 =?utf-8?B?RWt2QVBFWVdHdXFhcTRzZU9WWWpPbjY3YTRWMkF3TE1ZbHdZTVJTd1RaZXho?=
 =?utf-8?B?QzZENlNYT2JiTnFTSitkek5Db29nRjlmOE9jOXlNSEZpSEdkbm83aEc5c0xv?=
 =?utf-8?B?aHNhWkJZQzhtMGdmb2VaMWZVc3k5MG1Fa0g0ODFiKzc3U2tlOXFmZTl6OE9j?=
 =?utf-8?B?MGVCUVpGVGF5RnNtWnFxeEk2cWRJM2V3OGFDM3pLeVhvdllRUUMvUDFJSXBY?=
 =?utf-8?B?bEJaTGhjbVM0RWdOVVVnejJPdG9Md0lmUmV2UGl2WVFub0R5TDBwYWdoK0ZK?=
 =?utf-8?B?bzVNb0xmYjU3VEtBS1FseVZ4SWFWTUtWcUE0Snk0YzBRZzA2M2NJbTh1MXlr?=
 =?utf-8?B?dWhsdjd2MTVOK0c3V0JQUWtTVjdKNlV3KzRZNWd4c1pTV210QVRpRGQremJa?=
 =?utf-8?B?d3cxcDRyS3lJYXhESEJhak5BREZ2ZWhHczRoaGZ3eEdjMjJnTkdhZms3NVpV?=
 =?utf-8?B?MmJ2VGJwWnp4TlBKNmNLL1JieTMycjVKeTQ5RndjbG5zd2tUaWpRUzB6ZDlF?=
 =?utf-8?B?c2hwYjVxMlQwQXB2WEgvOGk5SXMwc2l3NW5UcVNVQUNHbHN0V2Ntei9HMGVw?=
 =?utf-8?B?SVJ2dTJ4a3V4T0pKaElQa294T3FDaFhQYUxXRmg4VXdLMlcxWjUxb3dpQVE0?=
 =?utf-8?B?WmFoc245WWlHVGNjTDhhN2wxVmwyTzZPYnZzeWt2QXMxY3plRldPYm5nbCtt?=
 =?utf-8?B?NzlsRTlxWU1HVktiYktXSHFvSWxubVVqblZ4ZURUZmI5MkN2VUFZQ2dXdjJV?=
 =?utf-8?B?UnlBVDd3VnVrVTdIK1pGUXBwamxVRyswbWZCWmNTbHBLMCswUU10Y3k5WnpJ?=
 =?utf-8?B?SnRTNVM0QWZiQllzdVVxcVp0Nk82YThOaWYyQ2NkMjV4Q0hMbkRVZHFiU3hy?=
 =?utf-8?B?S2lNcmRSV0RTOGI1ZlFGVzFmbFkwVys2WjRlcGRmWEF5V2krbUQ0ZzRTb0JU?=
 =?utf-8?B?dDNoWHZaNzZBd0VFbUJIc3J6ZEpkNUdUcWpwY1FXU0d6cS9YQklaSW92SGht?=
 =?utf-8?B?ZTEyODJPL2MrWlE4d2JWQWZoN09KUHRQaHRpNVVDQmhBY1I0RzJXYVNxZzhS?=
 =?utf-8?B?WXhrQ1lxbjZZZWlZcGFhenFwbUE3ZjlKVHI5SnEvMEVrUHFVcWd2ZE5ZajNm?=
 =?utf-8?B?d2dxZ1Y4YWVBaStXQmxXdGhEZlV1dEVRMVBDZ1dVVWlLVXFhayt2SDN4Z1Zl?=
 =?utf-8?B?c1BydkdGN0k0bVJQbkcvblVKQjNBK1hmR3p3SUNBUzNHQnU3UjUyS0tSMHVh?=
 =?utf-8?B?a2R1SXFnVks3eThJM01Hb01NcVhncVR6YUpuWXZKY1pEUXlyVjFqOUVOOVc5?=
 =?utf-8?B?ZTZBdlFhczZyT1lXSVYrY0krSkxkd3RpbTRyZGwxdHRpV09kWTF5WTVvclRv?=
 =?utf-8?B?NE9sY3QzYjgvWnpkUGgwUE84VTY2cUFTT3N4S0FTSjg1OTRTd1FFSlNkMi9o?=
 =?utf-8?B?NlMvRzJGckovbStoMFhhdHh5Z09ibDliMWtFaVNWSE8vaXMzd0t4ZEk5dWgz?=
 =?utf-8?B?RCtnUFR6YzFMSDdYWE1ka0RxdFA2Y1FmQ1hYL1c4ODFTeVpIREdWS2pkNE1a?=
 =?utf-8?B?MUFKbFhrVlJWbnJZU1gyWjE5QzhsTjlJUEhQTjBFVVp4WXhPYmZ0bnltWXVZ?=
 =?utf-8?B?L3RWRm5ZUTFiQld3ckt5T3FWbGpQOFZLZGJXd2QxZ2FkcnRIQy95cjNNYldq?=
 =?utf-8?B?c0k1b3Z2ZUxEdkVTNUhLaytlQjNNSlZkaVFYdWJob09hS3ZiMlZDakdWMWo2?=
 =?utf-8?B?U3RJT0J0OVc1OWpWaW9HRFo0NnRNQ0g3ZGpCVHd2M2NCYWZIWWxTMDRwVHE3?=
 =?utf-8?B?ZGdBYnZuNGdXeGNUcjFkZStYMmVpcmxia2V0ZEdQZm92Zlk0UjYrUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b84060-91e8-4c08-984b-08de5f5f1893
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5415.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:51:57.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2JCtNKOq9u50wquwK4Mu0cNBm6mcOZgKJ3ff4bFfKgWJOc6j/Qy9d1R7OtmmN8O6gcqhToO7Dck34GQgVLT7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254881-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 10FDBB34AE
X-Rspamd-Action: no action

On 1/22/26 7:43 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> virtio_net: Query and set flow filter caps
> 
> This patch adds flow filter capability support to virtio_net. It queries
> and sets flow filter capabilities during probe and restore, with cleanup
> during freeze and remove.
> 
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index db88dcaefb20..03bd3d2c2b0e 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
> 
> [ ... ]
> 
>> @@ -5727,10 +5934,31 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>>  			return err;
>>  	}
>>
>> +	/* Initialize flow filters. Not supported is an acceptable and common
>> +	 * return code
>> +	 */
>> +	rtnl_lock();
>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>> +	if (err && err != -EOPNOTSUPP) {
>> +		if (netif_running(vi->dev))
>> +			virtnet_close(vi->dev);
>> +
>> +		/* disable_rx_mmode_work takes the rtnl_lock, so just set the
>> +		 * flag here while holding the lock.
>> +		 *
>> +		 * remove_vq_common resets the device and frees the vqs.
>> +		 */
>> +		vi->rx_mode_work_enabled = false;
>> +		rtnl_unlock();
>> +		remove_vq_common(vi);
>> +		return err;
> 
> If virtnet_ff_init() fails here, remove_vq_common() frees vi->rq, vi->sq,
> and vi->ctrl via virtnet_free_queues(), but the netdevice remains
> registered. Could this leave the device in an inconsistent state where
> subsequent operations (like virtnet_open() triggered by bringing the
> interface up) would access freed memory through vi->rq[i]?
> 
> The error return propagates up to virtnet_restore() which just returns
> the error without further cleanup. If userspace then tries to use the
> still-registered netdevice, virtnet_open() would call try_fill_recv()
> which dereferences vi->rq.

It seems like there is a preexisting bug in this area.

Shouldn't we do virtnet_freeze_down and remove_vq_common on any error in
virtnet_restore_up?

The existing code doesn't suffer use-after-free, but the device is in a
bad state.

static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
{
	struct virtnet_info *vi = vdev->priv;
	int err;

	err = virtnet_restore_up(vdev);
	if (err)
		return err;
	virtnet_set_queues(vi, vi->curr_queue_pairs);

	err = virtnet_cpu_notif_add(vi);
	if (err) {
		virtnet_freeze_down(vdev);
		remove_vq_common(vi);
		return err;
	}

	return 0;
}

> 
>> +	}
>> +	rtnl_unlock();
>> +
>>  	netif_tx_lock_bh(vi->dev);
>>  	netif_device_attach(vi->dev);
>>  	netif_tx_unlock_bh(vi->dev);
>> -	return err;
>> +	return 0;
>>  }


