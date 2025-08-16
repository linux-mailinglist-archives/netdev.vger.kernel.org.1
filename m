Return-Path: <netdev+bounces-214284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09DB28C1E
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 10:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A775E4F59
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7623ABAF;
	Sat, 16 Aug 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R6HwW+sb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530E1E25E3;
	Sat, 16 Aug 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334529; cv=fail; b=sTekaXOTynWAzSLEoZ0BtF9B4iKRbYPjRwpkp10TSxMpSt91JMe9nJDNJ9I0YXsIizatZBLkjVdvuoFcpaGflSCdaJAqpri77EkpAecFxgdJem9d8JoyrzgzTmzDVtHrsTzH8t28s1DDCNAhxy7VR+nv7KLt2xp6d+PuDaN03eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334529; c=relaxed/simple;
	bh=Vu9/QO7JtGiG1PrKIXXYYg1/1nEuvb8LrI6T8YDLv1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0rc2P7aszCa7VhbqtzOvf059x4gIuD3mRBczPeMnFhdkQ/YZnRtX5BQbJ/o5Nr9OW9hrtS9rhO6X6CezBpDEBBQILtE5V9JpjEQPY8lb5+O7Uhhvx1ZRpDJ+Yw9E4LvmUyqVL+ChL5BA11XjzKEPoDTPVkaZC4z82TbJFOdIWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R6HwW+sb; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NETOaXYSHG0RU/I49P++1NCCf/ul36P3luI4VsLQ3Ax1PZIrD4ejSsCZOqkOK0tr8oZb175Av/g+PK12XAg4cb+L3WSlAMgGVYb5ASaugO7RQ38odRBvokSrM7aPpls7TZclgMRWTzWppnbspmDJ9i4BMIkpl0PjY9w4S7eptcGJtGU4bxqlHyWnvabV+0lo2RK19stt6IKiLMyAQ5Lx5bV9tP9SplNoZ4GoFdO6y6vkitDklcoyx9hfyZkyj6uZEdylX8/4wu6spoVCWWFG0geSbg6SRRqdhYQV1bV98tscstNj4WRUMLHWArhGxUPT0c340EiMXeVz7XHUgizw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeRcgdr26iIJLqSHjbDKayOxesbC0mYOvkJbT+NvqVw=;
 b=NalWIBocDp5fTq4XDnKm9IIu1Gi1Gc791X5F+aszKvmD2Hk6K5V8IPNanofDEvRMHsdi85WdUhcdRVhtehQ+nuX9gXDsp2qwx/ao5W2/NA548/cKgRLbBdk0WCkr+O5bxNNB/GMBjwiY88gvgtH12ktv621Iu7U/eNVI5y9/Ki1v97P2oQ6+3JFXl9A+dB0UVjyJ7FRjP/T9B4A0BVtq65k+PHYpMpx52eezf3UOdWuBghRUY9awHykNUeJppoWHU1gnO9zAJYdsdmVm9raChd/3BX8YR4kEs6PyGnJ6iug7mCa2LJ8xVhZIDPnor/PjEEHqIFlasLrWS/chb2v7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeRcgdr26iIJLqSHjbDKayOxesbC0mYOvkJbT+NvqVw=;
 b=R6HwW+sbRWDUfSXIyWlVo7t4lh3D4xWymH1i5ymmXKfCqpwE/jYyIxQnjr90eKXlbuthiTG+96zpBVtlfsvjn2Rwl+y+KF2AR0KJnhHSkKJnH3Nm0pjfccqeOTwF7GSKQNz4LUk6Vl+p3fbyAsqXDiEH2kDPFnd3HCdiEFn2XAxe/u5PLgbwHqHLUaLyJhlD/SifPe+EUvc34KExQYE4VN83c0np61dWTwEmIUnZ0vLdlCml2ZePtgvdF1/mhNywfP8ZNpco9+GbCQN8Svh+18ZXl1dTTryCktzQG30os4ohIOGXRKdnRxL1Q6t1+lpvcSQ9IhLwJvvf3Rgf9ax7tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Sat, 16 Aug
 2025 08:55:25 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 08:55:25 +0000
Date: Sat, 16 Aug 2025 08:55:16 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	tariqt@nvidia.com, parav@nvidia.com, Christoph Hellwig <hch@infradead.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 1/7] queue_api: add support for fetching per
 queue DMA dev
Message-ID: <gdrdgfsmn3gikjzdspe7cnwsd3dw4dgo2uds6amfqnxlhzedxe@wkewgyhn2t6b>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
 <20250815110401.2254214-3-dtatulea@nvidia.com>
 <CAHS8izMdevPuO4zFF9EFP2Q7tdAUk+w+bMOO-cz-=_N0q0V37Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMdevPuO4zFF9EFP2Q7tdAUk+w+bMOO-cz-=_N0q0V37Q@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f00dc5-e390-49f4-f0e4-08dddca2a41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDlqVktoMlgvS00wNmFtUmk3OWRrejJoV2ozMmxWKzVNbzRFQVRabGZFWndp?=
 =?utf-8?B?S1BtdkVrd0c3Kzg2OGdqN0NsY3BIZDhyc0xHVjlBRXJpV2pUQ2FGQUdNTXR3?=
 =?utf-8?B?djlUOWlBRzNTcWRSM3hpemxZeUN1dzY1SFByRlRzb0QyblVVSmcxVjVvY25N?=
 =?utf-8?B?b1BxWTZVRmwxay9JemhTaHN5WlZvbmlTN0R2RTFscXRGNmYxSkV2NDhQL0dj?=
 =?utf-8?B?UEY3VHJzekVaUzVySUhIT2cvbUF3NG5hWHBCWDV3dnI1eTNVdTlMZ0pzSHZM?=
 =?utf-8?B?WUMzZUdpOHdDZGRweHJIWVZlaTIvYmVUYjIwZnRTTXBGcjRXUjczQzdBUzQx?=
 =?utf-8?B?NjlxejF5MGs3U1ROc0xsR1hPR016QzFtcXpIWE9RWW9qRnM2VzZQMzZXZlBL?=
 =?utf-8?B?T2U4K25qR0ZvS280L29PbkVGbDByKzBNR0ZGbm12bEZKUU5jTXI2M2M4Rk55?=
 =?utf-8?B?Sk1Sb0lvM2xjU0t4Y3BhdldvUUYxenBaNklkcWM0YXFzM3E0aFR4NVhRUlhK?=
 =?utf-8?B?U1dVVUpKMU9PeGRxL0wyajNmUitMNEU1NFJ6V2dTeEt1dWRGZkV6TkRnaWZF?=
 =?utf-8?B?T0tDeG1jZVpKNEtZV0YzdnFZN3ZBTE5QN2t6UmJFL3kvam8vN0lYTDVQK1Zn?=
 =?utf-8?B?T2FyOXA5bkNFNjgva0twVFlIbXNrcWVYVW9jYmFtY2tYOGZMYkYxVVJiWThu?=
 =?utf-8?B?VGMvMGc4eTJNZFRtK3p6TWZ2dmdEV2VyZTNZZVpPSDdmUFhqU21FVjN4YVdp?=
 =?utf-8?B?QkdHYWNKS3RkMUpRMEFWNFo3S3BsYmt0bVNzQlV2Yi9uRFFKVmJObmVrR041?=
 =?utf-8?B?RXFNV3pIaXFxWHRFTW95RFlrSkRNQnFZRTNIcVhPd2Z4eFVFaTFlek96dEFT?=
 =?utf-8?B?ZjBKaW5GNEk5anh1ZzY4YW44Zk8vOHdlT2ptOWR0djFRcjYzOFE2UllSaEo1?=
 =?utf-8?B?bnVqanMzdTc4UEFGY3ZwRmxoa00wbW5EekdqTUd4S1dxb0dlVmh4TjlMZWNU?=
 =?utf-8?B?VzR4b0I1YWhUSXY5bU0xOG00V2lEd01EV1V5aCtzMWlzWkdyRFBRSndBWFQz?=
 =?utf-8?B?MjRSTkEyZmh5REpMYTNkTStLelo4VkoyMS8xTERZclRVMVJTVFc2Vk5EanhP?=
 =?utf-8?B?K1FXN2F4b1l2SXM5bDREc2ZWa1d5b0pYOS9KcnVBZXJjaTUrWEVLdy9SQkpG?=
 =?utf-8?B?UnBzY3NlWk9ENS9zSWt1RGJTRTNmUDlEaTdYQUdCajRYRXdTRjJobms3Rlcw?=
 =?utf-8?B?dFk2ZVdxOUpDSjFQWWo2N0hPWTlZcUUyRlBjMTZYeHpabENpamRhZS92bXcz?=
 =?utf-8?B?a09Qck9tMTlyMklkdThKUE41QnRkZDM4TkdiREZacG9sakNZRWdCKzJPbDR4?=
 =?utf-8?B?Z2h5MnpyYnN0a3lqOUw1TnZiNUZnTlFGN3BsUGFSU2MyTWVIY0RqaDhiY3lt?=
 =?utf-8?B?dkV3Q3lBUElsNFVQeTd2VHRKWGlFdWoyV0VUQ1U2bW9WaFZBSDZIa0gyQjdT?=
 =?utf-8?B?VitpRnc1OXhwdDdZOFBRK2U3LzlNd3lEMm1ONUQvK21DeEoyZWozTzN0d3lQ?=
 =?utf-8?B?N0RnREVibVQwK01JMmdhY29rSDduUFIvM0tLWXRrckJWUGVJL1VjNEpDMUN6?=
 =?utf-8?B?NFVlM0NYVjJiNTZlWkZUYTJGK1ZHeTQrcEhmeVJmTmt5ZGYzdlUwQVE2U3Fh?=
 =?utf-8?B?TlI3NmJpeFl0bTd2MHZ5V1U5dUFuQVNvbEpWSGFFVk1YVm5pamZ6SDFaT0RE?=
 =?utf-8?B?d0tYMG5ybitHNVlwVWl0a2lWUE5qVnUrSmNkREp0U3RVeWdlM1o3L0JBb2lS?=
 =?utf-8?B?Z1hZcms0Q3VIM2tHcThSYW03VzZxRXRZM0RCYkhVWUZRZU12blFYWnN4UW9I?=
 =?utf-8?B?bVEzblpsZnFQOUd6WjhIYnFRRWx6WlFsQXJSSklBdS8rQWh1d3FvRUJ0WXZN?=
 =?utf-8?Q?Ne2YJw6VgfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZLM3RUTEhGR2xSdnJDWmY4QVAzYXc5YXYwVjYxdWZiWE43a1Bmd2t6d3o5?=
 =?utf-8?B?cDlydzBpQ1EvOVpBdWE5Smh5VUxtVTVOQTlmdXgzZGdUTUdlTXh1cEdORVUz?=
 =?utf-8?B?V1hSY25kSzJTNVBaQmhEZFN5eHByV1dOSWllSGd2Ry94OEFKdVZrclpjd1Zr?=
 =?utf-8?B?VjlxZHR4U3paVkpDTjFBS2VKTU1xaldNdU1hOGtSdWhxSVdHY1FUalpjanBN?=
 =?utf-8?B?ck9sWGFscVpSZEhUc2svclhrcUg2ZDlaQXlGOUNtdkI3SmhiYjdnbURxZHF0?=
 =?utf-8?B?UHBpbis4WjkwcGJkdFl6WHlJWW5GM1RyNG5zbHdBTzViNlh5Yjl2KzBiYW5y?=
 =?utf-8?B?RWJCeERzeTYyY0NyOWZNMVozcDBqd0RhNGhBeGdCU1VodzFuTEpBTWRXUC9T?=
 =?utf-8?B?M0NSRThrL1hta0MvdHlSOERnK0FBbUZnVWdVZW1CdDVrYVdlVVAwelk0SU5X?=
 =?utf-8?B?c1cwaG0yL21vR1J3WlBtZ216WFBBcnJNcFo5V0JBSVJFSWo5WTN4NzVwU3JN?=
 =?utf-8?B?TllLVlJwV0xjYWpmU2VlZUU0QU54NHVVTCtHUkU3WHZVdzF6SUlwNXRISzNW?=
 =?utf-8?B?M2JFclZKRGd2QkFOOE16SkJWTERCQnZqZlpwRUxKeW9TZk05MVJhZnhxMkVF?=
 =?utf-8?B?Tko0NlRIZmoyYkJVdUhBSWpQeTlxTHZPbkV6NjFCSUx5RngvaGlEdllCNXZD?=
 =?utf-8?B?MENmTjhQZmxRbFpwUnVYRzZYWEdWOE9kWkZWb0h1RHRMV21FTHZWeGJVQTYr?=
 =?utf-8?B?N0xyeFQ3T0R1RmFxQWtHdjNqSlNHUEdHQk5FRTE2aUJWd0JETm4rc1RudkZV?=
 =?utf-8?B?NDZVWnFlSGFRQXpJYjZRZXR2VEh6bVpjYzBhdGFRS1laWW9RWEZWMEQ4aytO?=
 =?utf-8?B?Q2hYc2FwUEVnZHR4WDhWakhnTWkrRnRnOHpQaFhUdTFPcFVIRTVnT1l0cTFx?=
 =?utf-8?B?V2txclZqR1pwbXF2RU1hS1Rkd2NMUFJramt0b1Vka1NYc2dzY01aendxSkNP?=
 =?utf-8?B?dDN0ZGRteE9QdDVSTmFpSTlBVmV2WEgvMDVCOVpLNTI0dVJZVUxhd0sxOWNS?=
 =?utf-8?B?ZVhQWlBpZFhwR3RXOWlJV2xlNDZVSnlaeEYxZEMzTDZMTHBjQ3NtZVlQalJ0?=
 =?utf-8?B?eDlwVE5PcXRzemx4dTlSMldqZDdvTFEvakc5UmZURzBOVGxMeHl4bS91REhV?=
 =?utf-8?B?MzFkLzJlbE04MHBScFpyOUJvOWtzUjFESGtCZFJ3QUhNMHNyc3R4UEtLUktN?=
 =?utf-8?B?S3puVXdXWEtPR0IzcGdDYjU5SHJHSnRhTGIwQjZzMkovbmhBVjNNbWYwVGky?=
 =?utf-8?B?bnJVNW9nR1RCZlNHK0MyK2g3QUZwb1J5QXVvdHZvaW42dHBFTi85THBWNW43?=
 =?utf-8?B?VUVVSmV4QkdvZ1ZXa1VZZDVLOHRmWGc3WU9SMEVKb29SUllYVkR4UVdVU3VD?=
 =?utf-8?B?VGx5bHg4T3Z0N2tieE00d0ZBNXVGYWFoL2RRazhSVHM2bk1QSUxKcFBzSWFX?=
 =?utf-8?B?N3F2ZjdqVklncGtCS1FqWTFUczN6T25YMzJqbE84dnFTVlQ5UjlHZ0Jnblpw?=
 =?utf-8?B?dmtUVk95S01RdTFWaHV5aWgyRi9iZGJmUm8wMFJaUjVTTnhheE9XR1RIbTU1?=
 =?utf-8?B?ZWs0SHp0OUZZQkFKT0JQM29OMWpaVXF0UEp0NlVUNllIbUpxSlZBRHZ6YUJY?=
 =?utf-8?B?aUFHTHQ3WjdJKzBCcWxLZnRQUGRMWEp1VmNoek00YXROc3czcDVXSm93cmEv?=
 =?utf-8?B?YnRNWFAxaTZtSnZhQ3lGYWdiYXRXbjhRTFlZZmM3MzZIZ2loS0dpMlRzUUNM?=
 =?utf-8?B?VUtBVFJ4eUlpRjRtb3hOc1pUazlXNDM3eTFXK1ZVbXhSZHZUTmY4c1NqdldW?=
 =?utf-8?B?V1RHWUJpNDlpZURZYVF6MU81WjlTWTNyUGc4Uk5mbkJHUUQ1WmxVMm4rTldZ?=
 =?utf-8?B?VmdBN1NNQnJ0N3h0cTVLSlR3WkZONFVPZDBFTHBUaHZyYXNuMVBRd0hUcGcw?=
 =?utf-8?B?NS8wVllDQlhoUkJDRENucVJBaC80T2pNS284TWdTSmZPRHAwQ3hsVnArMWpy?=
 =?utf-8?B?cGUyYm1qaWp4Smh2Ym5pRmVSMjVZWHp6MUVOM3BGeXExRlE4YzNVbldDbjRo?=
 =?utf-8?Q?dgiSEVYNejenWxVei8BFODRYv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f00dc5-e390-49f4-f0e4-08dddca2a41f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 08:55:25.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzrazYWBvBDnsZ2kliTl63ri+CG+gfghvZAml4zAD33VvMjwRmbdidEZ7DjpzkU9gjatpk4IRjikdKLxiOsgwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123

On Fri, Aug 15, 2025 at 11:11:01AM -0700, Mina Almasry wrote:
> On Fri, Aug 15, 2025 at 4:07 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > For zerocopy (io_uring, devmem), there is an assumption that the
> > parent device can do DMA. However that is not always the case:
> > - Scalable Function netdevs [1] have the DMA device in the grandparent.
> > - For Multi-PF netdevs [2] queues can be associated to different DMA
> > devices.
> >
> > This patch introduces the a queue based interface for allowing drivers
> > to expose a different DMA device for zerocopy.
> >
> > [1] Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
> > [2] Documentation/networking/multi-pf-netdev.rst
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > ---
> >  include/net/netdev_queues.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> > index 6e835972abd1..d4d8c42b809f 100644
> > --- a/include/net/netdev_queues.h
> > +++ b/include/net/netdev_queues.h
> > @@ -127,6 +127,10 @@ void netdev_stat_queue_sum(struct net_device *netdev,
> >   * @ndo_queue_stop:    Stop the RX queue at the specified index. The stopped
> >   *                     queue's memory is written at the specified address.
> >   *
> > + * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
> 
> I'm wondering a bit why this dma-dev issue exists for memory providers
> but not for the dma-dev used by the page_pool itself.
> 
> I'm guessing because the pp uses the dev in page_pool_params->dev
> while I implemented the memory provider stuff to completely ignore
> pp_params->dev and use its own device (sorry...).
>
AFAIU rightly so. The page_pool is created at a later stage.

> We may want to extend your work so that the pp also ignores
> pp_params.dev and uses the device returned by the queue API if it's
> provided by the driver. But there is no upside to doing things this
> way except for some consistency, so I think I'm complicating things
> for no reason.
>
The drivers are setting the pp_params.dev though, so no need for a queue
API call. Or maybe I misunderstood your point?

> I think this looks good to me. With the helper moved to a .c file as
> Jakub requested I can Reviewed-by.
>
Will do.

Thanks,
Dragos


