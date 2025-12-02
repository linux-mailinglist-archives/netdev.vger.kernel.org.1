Return-Path: <netdev+bounces-243178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605A2C9ACB9
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 10:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D6C3A4FA4
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F13093DD;
	Tue,  2 Dec 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BEMjIwYW"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52236D510;
	Tue,  2 Dec 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666581; cv=fail; b=h0Qq3j12NQvU4VdRuPGwqJ1OCcTFfxhkWFh3y9lyAjppfyUy1LXLbIZuaYUUgRCywdCTlEk70eJWGBeC50eSK/FZfFX6Va4StMz1bJ1QEeoKrfHyqHIQXCgj7rjZIBMa9dNanLPvk8Crzbx1KGPSEzz0y+A8IPw5Jo7CXB9app4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666581; c=relaxed/simple;
	bh=hWXF/fiIpKKTwlU4cA4RSImmvzJTPftqr0VPfG3DCXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ckxxVPqW484+qUUsyKm8u2oQeSuf+0oj5/QOy80eq8sOdrguwLb1v2Kbrv2oB6Do+7LveSObtiPAnh+jjjitQcQgVHdLFJIE4qBaSyNShHOAaKSuKk/IG0vdP1nqw/Xzi/31R+2idA1xGn0DTLTL+Mx6/+sOwKa3/RkG+c5fgKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BEMjIwYW; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWDt2UddRUMkK0Mps/htASBYcdB0lf4daiMPJRlhR7pfgLqgSDWNEl8Ia16npFk1bEep+Vg86j6DrPR7hrxeutmCGg5AvlUq3lJsYm1zm8NK/JuqCJxP860Dk9PXJOd+USUBIiDUauLmoJHqISPdZ4ZqZePJVbkj2WAdZT3u7mT7YoDyfdwLBuZvXgTTFsRPhjqDIiivWPyaK56rgtxyzpVU8GB1rWVQ0I3l72G/byPy7rqnfqjWfv48ky8uty2U93oe/SDBhKzP2gfYOA/+YY0ItAyf313iWq+qx3YMLtSWRJ3Wzktal9piWoCciUvFNpjBgoNE73oVUzp/UgHX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1YV+PAvW5bFlZB5ZArtPxDBZdlLMrTU+IZEXc5COk4=;
 b=n8FCjY2l1AKIopdoYKy93vNw29AkVwdL02boy+79VPJwMhiJ1zYF2p8PrqGMWbNtv2wISwKySPJl7kOEnEzn5ee+VRwD7SraFCC0ZI1tTqX08CFGphXRyZOATjQ1Q+N3zkesl5k2iCDf08d0BMNRVduhGxnxFCQ5ZUxkMpc2Pu3KYv6SISeYwxvTpeO2Jyqpw9lmgti5eco3woe6KZ4sN1vCkJLVAUhJCskvm03oUb/b5kr8prTyzI+m05l1uwniNjj/sz3ojPueXpkbYHMr0R2UasbkOwH8wl/fGltoHLLhXasJLHLMyGwGP2l4sAvcEDDh/hZWogk6zdDJvXvr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1YV+PAvW5bFlZB5ZArtPxDBZdlLMrTU+IZEXc5COk4=;
 b=BEMjIwYWQcrLAF4tlGKkNeGwlw4nJUKGvX98hH83sGomug4ieDfJQWRYB+/2nfbnZVpaNGLu/DYLdPpTS8v0mlrwwIcSfYp6cWHCDltOKKsKR67KecGV9lmYGVFrAUVeKnBlJcCcnGNHqjCUxpIU48hgekcD0JYFko9suxebJtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 09:09:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 09:09:36 +0000
Message-ID: <e1009cde-ee48-478c-a8cf-13762e272ecb@amd.com>
Date: Tue, 2 Dec 2025 09:09:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 15/23] sfc: get endpoint decoder
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
 <4aab1857efeaf2888b1c85cbac1fc5c8fc5c8cbc.camel@kernel.org>
 <34f7771f-7d6d-4bfd-9212-889433d80b4c@amd.com>
 <7f1e56067bdc46195a9e36f914aa103dc76d4f7f.camel@kernel.org>
 <ab182638-3693-422b-a7b6-b3630a35a0be@amd.com>
 <07a0cd77a61358cfb6e436da60fb5f644201b52c.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <07a0cd77a61358cfb6e436da60fb5f644201b52c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: d61b2e0e-c6cf-4f44-5d41-08de318283f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHlLWVJpL2xEOTJPeUNGT1M2UkUwZEZxa1JyVE80MVZjUkNuZ3oyTXIzRGVG?=
 =?utf-8?B?UGUzMUdXYVRKbnkveWpNT25uZzV3S2ZJY3pEenVLOEZoVUFmbUxHODRxNDA5?=
 =?utf-8?B?Zm8xa1p1c3k1RXoxMml1YjN0eUtoTzh2QjE5SWFzNzMvQTIydUVSTERQYlYv?=
 =?utf-8?B?MEJ1S2oxek9EOCs2dVoxdnNob0JwVHdJL1BsdGVrYnIyUkZiUmdyYmJoVkhC?=
 =?utf-8?B?akdqZnNLMnRSM3JnNnpsZ0pyUDVzblZZaFo1TVFjK2VrL1REL3ZxRUVVN2Zz?=
 =?utf-8?B?U2RSNUw2Ry9uS3Y2SjZLaXRlYU9YVXBXeVIxc2ZoNlZFYkRXbUYwRGpiN2s5?=
 =?utf-8?B?YkRXMCtGNGQrZkh1SSt4eTB1aW8ySnAyVy9sVkpPWGVxZXFEWEdYWENYWWFu?=
 =?utf-8?B?WTg2Uk9hbWNWeWE1SkdYWWdBNEQ4U01HMjlpUVBMbG1UQytQdHN3a3JzR2Fo?=
 =?utf-8?B?cnhuZTJMUDNLYmtqanJGd211MkdHT3AzTzVyOTRsWWROWmVXK3YwVVNQS2o1?=
 =?utf-8?B?OTZDeWFtWlM4UmJoNDlBTWRBZTh5K3hhVEYrdUlvQm5IWVlxaHV2ZElvRExM?=
 =?utf-8?B?cFR5eEdjNlNDWkM4NEllZlVLMWlxQ2ZlUXJiei8zMUxadEo3alpKdDZHRkc1?=
 =?utf-8?B?Y0I0Zm5zaUlCNXVQZDBocmtXbGdYeThvL2ZobDVNK3Z4ek9sbHFDY1NJMlRW?=
 =?utf-8?B?WitoKyswb0pZRVMycitQTEtJajZaMm9BS244ZnZNWHdReEdnWnBoNkEzK3VQ?=
 =?utf-8?B?SzY4bFdhN3JqRmp3OXBnR0k0cjUxSEFxdnJGaFVtUXBRMXVCUXpoNHg5cU9x?=
 =?utf-8?B?ejZUdWthNS83SDVrUGdiQURJb0hpTVhWa2cxSVdKK1g4NWs2bWs0dWE0ejVm?=
 =?utf-8?B?NjdSM2Z3bnF1ajZGeUZUSzZTbnNzMml1N01NOVI2aUpQbG9URG82Q1JZeVVl?=
 =?utf-8?B?eHE5MU51cnVzSER2SkxlVVgyeDQ5bm1GbjZXMHlqWDRIbjc2NWNRVkdUWXhq?=
 =?utf-8?B?VUhnZkxpcTRiU05LcnhuaWExaEdkQUM4MGZkOW5EQ3drdVJhRk04TE9KbmNt?=
 =?utf-8?B?Njk5SlkvQ2pRZzBlT0tha2t1QnFkcElrVnR1aWhmaFNzRFdiV0FLVzJJOEFM?=
 =?utf-8?B?SWVaSXdUbXlSdzdNcXRrVlJxM3c5SXFpMHlxZTl3WWZ6OThxYlpHOVJiQkhi?=
 =?utf-8?B?eDcwOGRlQ2RHTDhVSHVoYUU5NDhxR2RKamE5K2Q4RStQY3ZkZ05ENU43NDI3?=
 =?utf-8?B?MmY0NVFZWncyb0JzR1JVR3FZa3g5cm9VQVBTMjNOMG1vTmpPNVNRMmFsUFRT?=
 =?utf-8?B?aHBzcmFzZEE0c3BZek8xYTBUMko0bHh6RThaSU43b0c4eVhXdlRraUg2K3VQ?=
 =?utf-8?B?QnJqWkFXYkhmcFpkZ29ObWs5MkZrNGR6RW1wRUM3UVhsUzdsSFlKWDNlQm1h?=
 =?utf-8?B?MDJoaEhZWDlDNkVPb0UzYUZmNEVrQmZuakJxK1NKTkNLTjI4bXVrdUM3emZ0?=
 =?utf-8?B?U1FPTndtaWdjYXhyWjkrT2tXditSNVlWd1R2RjJVT0RsdXAwNDhkOWQ0c3Ix?=
 =?utf-8?B?OC9CUEVZTUpXcCsrMUJ3SDNia1FhcWx6TjQ0UXIyQ0xyOUFzbjFUczJmaTRN?=
 =?utf-8?B?Nm52Wk9IYjNWdHIxSXcwb3dJV3poNFNadzZ2WUtNMTNSTEYvdkZTVHphNkov?=
 =?utf-8?B?dG5CUVFvTWNNTUJrV1QrQ0YxbEdPWHJQcmxiZ2JwMjE4aXhHNjU2OEt2Slpt?=
 =?utf-8?B?aHZleEs5MThyUzlBTWJlTWhFT2szTVRLeWgxcERqSlRvNDhYSFpWakdsZTls?=
 =?utf-8?B?cWZXbDBtTjYrdzFKVHowUzZsUDJYcUhIZnZNL3RSbjV6QVNBd0lZWXgyc09Q?=
 =?utf-8?B?cTFOWjgyakFnSEdLNG9WMGhBK1dpZWlYemU5ZE9lZEFYUzhoZjhvU21DSWRv?=
 =?utf-8?B?TklBU0x2RlcwWUg4NU8xUktaYSs0M1BQRDMrb3dma0JJTm5vZSs2RmV2YVM3?=
 =?utf-8?B?WTloR2Nvci9KdUNHVGJsVlhlUkE4UGtjQm9WTHZ0Q25SUVdxZXd4RE9uMkF0?=
 =?utf-8?Q?qvJ/vJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCtEUTZhbkw5dzlGdEh2ZW91VzhMR013U2N4eVB1eWFXV1piY2prVWZYbVBW?=
 =?utf-8?B?Rk84VkwrTnhWV3NFYkp1c2pvWkRnZGYvcHp4ODVpR2NKY2ZDb1gzYStvaHZ0?=
 =?utf-8?B?SjB6bWtMc24wblJ1endSa2ZXekNwZ2ROZ0ZCTkVGd3UyTDBkVTZnZlZ6UnFy?=
 =?utf-8?B?WElwR2djdFBidE9EQ2NzZkxuSmhiSk43bkRkSUU2Yk9lZFF6b1VWWFZYRzJV?=
 =?utf-8?B?ZG1mR2t5Qk9qZnd3dWJaaEFvMDQ4NWd6ZXZlVk5aa0J2aUdDeWNJMjNxRWRK?=
 =?utf-8?B?MWhFTjVYWW9zTERxM3pKZkRhYmFpNFVNRjFJYlZIalVCZEgvSTNtVmlWNDNW?=
 =?utf-8?B?eVhnc1dDSkhxZk1VdGlqdnV5cHBMeGI3SHVWODY2QW91TjdqUXdIODFZWXky?=
 =?utf-8?B?OVEvTHM4ampkVldsK1oxY1VMZFdLM3drcHF1U1R2dVVOcEJkUm9IeWEyVFRW?=
 =?utf-8?B?MXphQU1YRTh0R2ZyWlhtR1RCSXFpdXp3K0JzTHM1MDVhcmNGbUUvbGNGQVdL?=
 =?utf-8?B?T1h6dTBrUlJqMktpNGxWU0xrSXk4ejIwSDZWUHM4akJ0Y08rbXdxRlphcWh1?=
 =?utf-8?B?b2t5U2YyMk5YenpOV3dIcm5UTGIydEdsYzJLZTJ1bmRCNTlrVSsyZEw5Z29v?=
 =?utf-8?B?RGhETXlqb1RUOVFuSXpMTFhaZWo1T05xeUZ3b2dZK3Y2bXppOEdlV2R5Snl3?=
 =?utf-8?B?ZHVKOENRTDFwV0xRdWFlbVFRdHVJamdoYXNBaHRXNzRRSVFablArMG1xc2tl?=
 =?utf-8?B?MDNlZWxMcmZlbnRCYzg3L0tKenczT0xUWk02cFhZZWFEeTgvL0E5RTlXeXpI?=
 =?utf-8?B?b1ZLek8yc1k2Y1Q0eUFDU2VQQ28yeU5kRXJEWXptdStyQmk1Z1YyaWhXSHN2?=
 =?utf-8?B?OU5FUGtiRGJTTy81bHBKMVlLYzR4ZFN1STJONmUra2lQY2dhSlhLVWRHcFN1?=
 =?utf-8?B?SCtZZS9MM0I2YmhoUktySFd0Z2U0UVZjaWJzQzVmd2R5ckFDOTZ2MEYvZWhj?=
 =?utf-8?B?VzJtazd3dFhVVzd0MlkrSnlIMVN4bkswRURUN0VRN1ZCN3FoTXJ5UlpUOHRT?=
 =?utf-8?B?dHp3WnpyWm5UTHFFd0c2RDhLL2FFaTQ1U0oyekdacVJ4ekRjQTJFUjJnT1ZK?=
 =?utf-8?B?ajNvZlowaFY5aXdsSUJKRjF6c0M5WFZUNVFObHlVOWVaVmtHZzhqckxaaVhC?=
 =?utf-8?B?SE9IaTU0M1oxczVlb3pOYnFjUU9nTmY0ZWFFTldVN3h3VDl4TWM2ZTdoQy9l?=
 =?utf-8?B?SmF4Q2I4dUI1d1BwUzdHRnlKVElNNm1PZnZKZngraVBtSlZzOEl3RkM4QnQv?=
 =?utf-8?B?WHMvL0FLQlB1Z3JTQ0RuTGV4bC9mNHM1MVRnTVpwbjJ1Q1k2OW5xTEd1cmNo?=
 =?utf-8?B?eVU4YUtadUJrRXBJK3o3c3d5bi83WVh5M29rY0N2OVgrZ21Cb0tCc1VkbW96?=
 =?utf-8?B?RHpnY2xRdzhtTkRLMUZibjdYdVpXckk4TjhMUnd6aEIvRHhnSlpRMVRWb3lC?=
 =?utf-8?B?OTZacGZoMGtnbzY2K2Rvelg3UWdMemc5YmhDRElVcGYwSGxUUXVPU2lob0lq?=
 =?utf-8?B?M1pSU1JBVDZxVjFJemJnTi9Pak9GSU1BTGY3YkRKTHROT2Y4NUQ3djZkclkw?=
 =?utf-8?B?dUxOTnpFSkFoZVhrOERLOXlhTFNDK3UrTzFSbUNSQnU5NU5OUDhZNytrZUpN?=
 =?utf-8?B?QUR4UVpuRWs1d2EwYlNWQUxCNm9Zcno2ZUwwUHpzeXdtNjFMdHBoZE5UdlIz?=
 =?utf-8?B?QjZqZFRoT2xYSzFCSXB6cU1MM2JPbWFKL3hFc3NLcFFsNkdiTnR0ZzNJdUM2?=
 =?utf-8?B?RVhrR2ZTb2t0VlJmcUpsM2RhZ0hBK253eXZNVnFKMi9zUE9seXNjRHpnVm93?=
 =?utf-8?B?ZmNFeS9PbzdmMmEyYjIyeTRkbUhYdHR2YlNkUzVqTU0yWjVXNGt6YjU1K25w?=
 =?utf-8?B?VGxxVnhEVjZKaDdnNEdXdnNKT05LRk50V3QrZjFTTzRWZXYzRnY4d2J4c3FV?=
 =?utf-8?B?YTdFZzhwYXlNZnJ1NEVzZkgzem9PVGVXdFdsdzZObENTTzFyQU16eExYajVl?=
 =?utf-8?B?TXBwVnpQN1I5dHF0UTNkMVUwWGRydlVSUnEzWFVYR1ZCdFJORmwwdGVzR01Y?=
 =?utf-8?Q?VL2a4EVOaRsWTG/dQbnLgHPAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61b2e0e-c6cf-4f44-5d41-08de318283f1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 09:09:36.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: va6VN7nXxCh4kKns6aq9ODup4YYm5D1HsRZcATWYKmPqgWsRL/Rhfb2sELYMY3sePTNbsPRu8K64YAbL5dTx9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327


On 12/2/25 08:49, PJ Waskiewicz wrote:
> Hi Alejandro,


Hi PJ,


> On Thu, 2025-11-27 at 09:08 +0000, Alejandro Lucero Palau wrote:
>>> TL;DR: if your device you're testing with presents the CXL.mem
>>> region
>>> as EFI_RESERVED_TYPE, I don't see how these patches are working.
>>> Unless you're doing something extra outside of the patches, which
>>> isn't
>>> obvious to me.
>>
>> Yes, sorry, that is the case. I'm applying some dirty changes to
>> these
>> patches for testing with my current testing devices, including the
>> BIOS
>> and the Host.
>>
> Well, this is basically the issue.
>
> You are proposing these patches to support Type 2 devices, and use the
> X4 with SFC as the vehicle.  But out of the box, following the same
> flow, my driver for my (proprietary) device can't match the behavior.
> If you're having to make modifications to these patches to work with
> your device, even if it's to work around a weird platform or BIOS, then
> these patches can't be considered as-is.


I disagree. From day one I was told our device should not be touched by 
BIOS. If I have no hardware yet doing so it should not be changing the 
specific support I need, something I can easily emulate with QEMU and 
what I have been using in parallel to other specific hardware emulations 
internally.


>
> I have two main platforms in use for development.  One is an Intel
> Granite Rapids, one is an AMD Turin.  I've got production SKU's and
> CRB's, so I have a cross-section of BIOS's.  All of them behave the
> exact same way with these patches.  I do have a BIOS that is doing the
> right thing from what I can tell (tracing with a bus analyzer, and also
> ILA taps).
>
> CXL Type 2 device support is desparately needed.  I'm happy you've been
> championing this to get it merged.  I'm also very committed to helping
> test, modify, etc.  So please don't be discouraged.


Thanks for the kind words.


>
> I'm also one who's dealt with internal pressures from a company to get
> something working upstream.  But honestly, upstream work doesn't align
> with corporate or company calendars.  Been there, done that, hasn't
> gotten easier.  The kernel can't take a patchset that doesn't work at
> face value.  It's unfortunately as simple as that.  So let's figure out
> how to get it working out of the box with the patches.


Yes, management usually do not understand how kernel upstream effort 
happens, but it is not a relieve to know that ...


I did work on your problem (and I guess not only yours) these last days 
and I'm happy to say I have a solution ready to be shared. It will be in 
v22 what I hope to have ready later today, and it is simple and, I 
think, clean enough to be accepted without too much adjustments. Of 
course, it will depend on how quick reviewing happen and exchanges about 
how to do it if it is not liked follow.

Thank you


>>>> FWIW, last year in Vienna I raised the concern of the kernel
>>>> doing
>>>> exactly what you are witnessing, and I proposed having a way for
>>>> taking
>>>> the device/memory from DAX but I was told unanimously that was
>>>> not
>>>> necessary and if the BIOS did the wrong thing, not fixing that in
>>>> the
>>>> kernel. In hindsight I would say this conflict was not well
>>>> understood
>>>> then (me included) with all the details, so maybe it is time to
>>>> have
>>>> this capacity, maybe from user space or maybe specific kernel
>>>> param
>>>> triggering the device passing from DAX.
>>> I do recall this.  Unfortunately I brought up similar concerns way
>>> back
>>> in Dublin in 2021 regarding all of this flow well before 2.0-
>>> capable
>>> hosts arrived.  I think I started asking the questions way too
>>> early,
>>> since this was of little to no concern at the time (nor was Type2
>>> device support).
>>
>> Maybe we can make the case now. I'll seize LPC to discuss this
>> further.
>> Will you be there?
> Yep.  I'll be there, as will Dan.  We definitely need to find some time
> and chat.
>
>
> Cheers,
> -PJ

