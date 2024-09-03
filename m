Return-Path: <netdev+bounces-124525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC73969DAA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BD91C22897
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8A1A0BE0;
	Tue,  3 Sep 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqzYFljA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4572570;
	Tue,  3 Sep 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366807; cv=fail; b=h0/ylLsaQlwn/PlCNvKeSlXKcQVC/tJgpFRBK+FFtxqgviqcf2kEqo19Mi4tVEhfg6lXPJ1tP7V2oOo/ZcIV/m3If7E9JB3oP/UVhCiZEyBLUAkr0r+cQ7+DV6hSvgvhQ+r38IdNAbBRPbmOHlt8nGIrRAopuzqmL7quV/V5Olw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366807; c=relaxed/simple;
	bh=EcyFrE+C8fnzEc8D12lMRH2r+QSVwEwbfs/Zfn+0xM8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=poygEIOA0AJvU+oGNSGB4PkV4bGc2rRdAbXoppCBWZxJbO8aK0CycMqBWfzQeixHfd4AE4MqL9gH6i1nYHenng+t1pTwC27utlF3/TRakOZ8VzsY3aK+gEdcQQBQ1hD3IZItvxMNd4JAfUc5SGgRvbVaXoFk7Jcy9Ye/ZcsvJsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqzYFljA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725366806; x=1756902806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EcyFrE+C8fnzEc8D12lMRH2r+QSVwEwbfs/Zfn+0xM8=;
  b=lqzYFljAyIfVPRiiLYr2Gs61Z9Vb+FwmkfRWndbwvQDc14qakenSSi/Z
   d6Ubr5trgEjvc6Bu7zM5QijYdC75xyH8PLoiwxNuisk6A8TLaFlZVQa9B
   INPWZ+5Zf7ZU3aFv1yXB6SfcPVZyebk1FFOPM0HVf47Gmdr32ikOY2DCV
   jf/DqeeHZhqHakU7ERE/K14wrENPdoE639tqHiEfbYWuhumvOrcdOLyr5
   tE+ijLnhI7dpTetERObJ2QSlVbh+BA2NOmhKC2a03YUgLjtQR4+/zRWVu
   S3zmvqSqMpeU4Ux9zBMOuZWX6FsJMzQ1eU0BqZx94QtnaDjDS8qF0EGCN
   A==;
X-CSE-ConnectionGUID: gr6KcPnbTReBW4Y/lygIZQ==
X-CSE-MsgGUID: yVkaOtU8TderIo1f+VWoNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="27753985"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="27753985"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 05:33:25 -0700
X-CSE-ConnectionGUID: fAXun6p6Spis+pj0UK27Aw==
X-CSE-MsgGUID: 2TAjGGorRaelnLZ7srjQlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="65411420"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 05:33:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 05:33:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 05:33:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 05:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGL88sA0i2KWFDM9XqLcNJfa0Y0J/k0DbHP4QZuqFrNzlKKWHXJao3Go8xjm1i88yzfyqAzXPWNvAKRi8rQ1p1BN87HW3+zIwtjDJYARRwpnvGHh4LEqi+uYTvrKy7t/4bk0klZcIuNfrmTointnGen8GBhiHyS6WqXj/p+sCvicPdS7XmeqN63H1usaubkccz82K5ASvYAxsvJ4BWMfV0VjAmNwCm0BdIZDQ8nW4aEcYbTm58UzxpuHmNTAB1N81WwfLr7oW8ycyljpx65poCpfj3r5M/BsOnuH+GdLojvmbE9Yl5Sh1uF93telNLv+OV8brhPVfax5Bk+cQ7foFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR3Qro16PmU6lX9DFTkign7wT+/3FNt+OnDW0hropvE=;
 b=d4ZbjpGlRl8w8tqfvHMi07oS4AQfuL01IpNVR/YP0wrcA3lIFTf8H1ZaW1lIGK3XOiq+Otw0IMUKlcwrUjALrr9Frv46HLdeEgeR4fGa9OlcwAuvmjcMSvSQkA5K84kVdYwUuStdkCsj4drD5LP5e2Ku0O8U3ia3GL8AX4HrYtlqHINYIzpsoPgGRvKomXs3GbElT62d1tVm9wGBwx7tIyzY2Hc2bvZjmvMXKj5lcJdF3RUMXjPeebgTb9uPUyTgiu5fMEN3JiUbc02CcmgYJ5tTa7+ckc6r17/SVM3bh29yxbYcgDQOcBrevuBrfdpTQACP/0okxU7fMzsQA0e/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 12:33:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 3 Sep 2024
 12:33:16 +0000
Message-ID: <428563b5-acee-4320-9af9-883877903629@intel.com>
Date: Tue, 3 Sep 2024 14:32:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/12] net: vxlan: add skb drop reasons to
 vxlan_rcv()
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <idosch@nvidia.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<dongml2@chinatelecom.cn>, <amcohen@nvidia.com>, <gnault@redhat.com>,
	<bpoirier@nvidia.com>, <b.galvani@gmail.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-8-dongml2@chinatelecom.cn>
 <c5896f81-5c32-43f0-8641-81fdb4710a4b@intel.com>
 <CADxym3YkROBgjbd0-h6nk2nxKkzofjCdJ6k9PLE86BQzKoxKUA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CADxym3YkROBgjbd0-h6nk2nxKkzofjCdJ6k9PLE86BQzKoxKUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 0931e87d-e8cf-4d7b-0f08-08dccc149570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkxWamM2Qi9NeTRvVkRlanpLcGV2bDlIUmxCK2FsakoxTUZNdjFSMjJwMGRC?=
 =?utf-8?B?WHhIYkR6TXFBd1NNaHcyMkwzTHNNZHFMODVCWW9taTA2ald3dXFuQllMN3lJ?=
 =?utf-8?B?S05PUnViVEh0Vkovc1ZnMEJYSnlzMER3ajZhWFRlMjB3c2JvVTBLQWxNY0Z1?=
 =?utf-8?B?NkU3ZFMvZ0svalk4cS8xOGI0akI2UzJWamtlVFhDaFc5aXMvZVZ6Q296bE5E?=
 =?utf-8?B?T0pucnRYRWI2ci9oY2JVckd6MUYzUjR2c0JNd3U2alprNnBETnp6bGN4NHpv?=
 =?utf-8?B?Q0xBei9zSGl0aUl0UnQxeUhDaC80UjhXM3BoeG9BWTVISTJLbTBsZ0VMQUdM?=
 =?utf-8?B?TDBoNGNWcmt4NWxoeEtmZFE1ckN2eVQxakJRY3FHN2FZVlVPSmhjZFpwYlB5?=
 =?utf-8?B?RHJoRUMxaEFMaW5NejByNnkraFp6U21MUTRrUHdENzdwdk1ZZlNndHI3elJE?=
 =?utf-8?B?bkwvdTMvZk8wN1diZzlTcS9FM2dkMXFjcUdSZTFKZUx1ZjUvd1pnMjRoZkFj?=
 =?utf-8?B?TjV1NTYyNGJ6WkFVQ2NOZnZXdlE2RERUNTc2SlExVk5PMWpOMWZMczdhTjdO?=
 =?utf-8?B?b1Q0STcvRnQzbndRVWZuOHEzWmVId3dmZG1CTytoYzgyc29LYzFIZDR3ZVlw?=
 =?utf-8?B?OVlYVmpNYzQwbDFPYk1IbmduNFdMb0FmU0F2bkRlWUJwU2hZaW43U242UGh3?=
 =?utf-8?B?c3U5OVhHaXVRdEx1Vnk0T3d1OGhET3JjMHdEMkhPMjhETTlnSkJnWGkwZHhQ?=
 =?utf-8?B?VnViUk5MTlJML0FZRjVrNGFYWUpVVG5MdWFPd0xGZklDUjBuRWJpTWMrT0RT?=
 =?utf-8?B?K0F0ZXNVb2xlMlJlRi9lSmxPdWwvZUxaRjMzeVUraFpZblpIa0tScUNpRmFU?=
 =?utf-8?B?R2oxZlVZWmhMUDRZY0Faek5vWjk1NjloaEJrcXBrbGJPODVXdWVFT3lLakJG?=
 =?utf-8?B?TGorZEU1SjU4Z1lPTGFmRXNsRWxMblNQRC83dUpXWUppNUhTT2E3UTRxVlhx?=
 =?utf-8?B?M1M3ZE9ueW9jWUxRSGw4bFJVR2d2SXphbnJOUWRhb0ZTZWNqSXZFSEdpMzRV?=
 =?utf-8?B?M3p2MkxjVUJNOGtyYUk0YXB1b0Era1RDNXlNcWNmcFdBWFFMekpFbzRlYUQ3?=
 =?utf-8?B?Qk52Q1RKTHkwNWs5dXBtNkQvTVEyUEFiV1E5OG1FSkEyMDZneTdLSFdlcHZE?=
 =?utf-8?B?VVh5ZUF1T3I0Y2NCUUlVUkFaMXBqQ1B3cVFSUFRnejZDTXNwdnIvdFpuRTcv?=
 =?utf-8?B?bkRTNGRtSFhNY3NWQWxrZy9mWmpCTWFsbW9yWmpod1UwbmRZd09tbE51K24x?=
 =?utf-8?B?SmF5UElybmRWTlNxc1BCU09oSHA2TTZMWUo5VCt5SWVpYnJUNzY0cGFpbjhE?=
 =?utf-8?B?ZElMa2tuUVVmdmZkM3FDZUFURXowdytmeU40OWN3TE44NlVKeVQ3OWx2YWo2?=
 =?utf-8?B?d21lV3M2WDBFZ1BwaGZEZ0FrZGpWMTVodGtORHZQSUFnSDgwSVdWYkRnWG1W?=
 =?utf-8?B?cXBTdUJ0T2JPUlB1SnZoYVJzRnI1VFhoUjhIR0VSalcxUlpPcTgzblJzd3B2?=
 =?utf-8?B?S3NTbzNUSXRjU1lHK3VZc3RFMVI4QzlPbWxjRVBuaDUvMG8wUFcyS1lzNmNK?=
 =?utf-8?B?UTBrRFhqeUZGUk5OaU5sY2JubmJvS2FJcVFvSU1ZM2NjK05Fa2VqV1NNeDZ1?=
 =?utf-8?B?NkhNMm90SGtXTCtlcXMyaWhpdjFqMmhKaUJqQjZDZFo4UlVKWTlBRHZPK21W?=
 =?utf-8?B?MzAzZ09HUGJ3TGR0VWJQamxvQ1lkVTBwQjk0aDJuZDcyMmQvblFPWW5TWE5U?=
 =?utf-8?B?V3JMT1dVNm1wZ3pXOW5lUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndRVXdoaWFGaG04MUptNjVaVjJuT2JyZXd2cGNnS3I0aGsrTnRURFpTbnNJ?=
 =?utf-8?B?YXQrVEZ2bWhLMW1UcXVkdzJVY2VlVGU3dFQ5TEJobno5clA1VWdDazRQbWZC?=
 =?utf-8?B?SjNRUUNtYlZNTUg1alVHSDk3WDlQRXVOejlqTUYwWWxiU3R6NjN4VHB0dW44?=
 =?utf-8?B?bjZJbU83aEx5TmJ4S0FzRS9IUGxybmhlQWsvM1NieDgycU9zbE5OYzNHVm15?=
 =?utf-8?B?RkdUQXpDY2dodnhiam1DWTcvam54N1UweDdOSjdrTjRqUVdScmc4bDZxb1dX?=
 =?utf-8?B?NUlCdklSaUJ4QWNVTXNsUTZlVVp5SlQxemxiZFdVRXVNWVF3ZUtNSnJVMkhz?=
 =?utf-8?B?Yjc0N3NRR2doTG1qNzZQTzNPRTdwUmcxN0N0QUlNVGVhbHVzUHpLRlpqY05a?=
 =?utf-8?B?RmNITVBkUVppcktWTWZxd2Y1NnE1L1hoQkZwNGFWVFNlN2NjVDVYUENTZldS?=
 =?utf-8?B?S3kxdmtmZXY4NlBnaldVTDBEdVNDMmYyNEo3bGxHNGJRQ2V0Nm5oVldRMkhj?=
 =?utf-8?B?cmh0Qkx5VGRHTTZGemJ5cEh2cDVuVmg0MGVEQXVNYlUxWkZDWWQxQmJEdDJz?=
 =?utf-8?B?NFJrRUtNRGZNRCtrUWJndUZlN0F6SytUa05zVm9sL1U0Sy9LZEFTQTJOdnBy?=
 =?utf-8?B?QUljM0o1YUVyNVM0TzJTd2Q0RnY3RUhtbklqYW9lZzN2bFFVZFp2L2tyeWRj?=
 =?utf-8?B?TE9odWcvdUMwckxOWXB2OE0xcXptYWVrWk8raWl5YXQzM2srUll2elIwNUhD?=
 =?utf-8?B?UDg5RzQ4b0RZVzhPR0xaazJMdmFaZUhxU3gyM3VjNzc2NVFJWDNJNUwwaTV1?=
 =?utf-8?B?QWFiVld0MEY3ampyMGxMWXpkQmNncXBTRGFlL0NkL0N4NUZ6WVBhV0N1QU1k?=
 =?utf-8?B?VzFtMSs2NlJtSmQ0cW9DVjBmcFNSV0lwbkNLdTdMbjNEYjl1QWh1Y0hickE4?=
 =?utf-8?B?OUxIOVBld0FCSkRaMVJ0bjhWNmhnTmdLMzhhcDZzOGFZMGFZZnlpOFVBM0tN?=
 =?utf-8?B?eHdGRmFhWndxTmdrNzU2aVUzSEhvRzBKMjcvdTFCVVFmamlNeFNTUTFyR1VQ?=
 =?utf-8?B?NmtVWnlQdStGT1ZQcEF1dlpuVmFVSEtwMi9MUVRCeXh4dlh1MW9YQ2F2b2ow?=
 =?utf-8?B?RWlVaWE2ZTV0ajJWUDBqbkJMOFlMUHVWc2gzVW5sdHM2OGJVeUREMlgxUGkr?=
 =?utf-8?B?Q0pJalZsVTlIYnBOaEw2dzM5ajY0Q0N3OWlpS1NNbzBTWHBPRFlmN3lwQjUv?=
 =?utf-8?B?MGNqYVI5VzdiT3BZL1MrSTVrVFNEY0orUU9UZFFmTGt2ZzNubExUS1NOVXNn?=
 =?utf-8?B?TmRKeENKZFk2NVBaeUxpWnhvT0k5Mm1TWkpiUTZCUzExamRRUDB1aUlQRjdn?=
 =?utf-8?B?YzlGZWV5eDg2OFVwazFrektYOEluTzlGVEJIOHV0TlozMzF2UzF4Nk5WMFFQ?=
 =?utf-8?B?eWNxb0Y2L2w2bnc3RnprWURQOExHNjlhdGZXNTdScXhBQ2dqdU9sazB4SUFF?=
 =?utf-8?B?M0pySEQwQkF1b29LZG9XWUFOcGlFeFhSQzhQZy94S3puRUtCRzBZbFRHRlRI?=
 =?utf-8?B?MW9Qb0RxY3VOWHdoREdkdmdzY2ZEWXQwbmNqcFpxODlQeG94S0x4NkllM2Ir?=
 =?utf-8?B?VW80TkpMdkRuU3QveHp2Q2tsMXByNkRhcjJEYi9FcVd2R241UlVndlVoR2Y1?=
 =?utf-8?B?YndYUGpPUW1OeDE5aXNDTTk5VVVuRHp3VHpWaTJGSUpqbjhma0w2amliUmVG?=
 =?utf-8?B?N0U2WG91MjdRRHlmTGFpYmVVMWdJQStpR1ZXenJhWC9OUG50OGxFbkxLRjN3?=
 =?utf-8?B?dEl2cCtacHVSd2J2NDMxdFV0UDIrQWdFbk43S3lDUUlmeVZmVE9RdjR3TTBs?=
 =?utf-8?B?SGtHVjh5N0ZyTU9raGpvTmRjVWpaV2t1NFo4emIzWitoVDF3ckpHaENoYTFj?=
 =?utf-8?B?Y0hYL0UzRmVzbDJHWWdUREQ3U1MvZjZxWnFSckdSYmlvajJBR3E0bVllL3gx?=
 =?utf-8?B?MEdrVmtmcExma1N4VkpLNHNkTE1aa2FzTHpmUzVFamh6cTdLMnhoLzQ4WVhx?=
 =?utf-8?B?MCt1a2RObzNMRW0wLzNtL0ZNSmVOL2dMNjNsZzJaT0xjc3o5aElMUzljTy8z?=
 =?utf-8?B?S0xQU05HbDVLcEhqcnkyakZEMVNYTWhicVJTaDlOR0hnOGNLOFdGRThmMldn?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0931e87d-e8cf-4d7b-0f08-08dccc149570
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:33:16.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IH6+2AT/M2iSmq6pEVkNCynYhuRZ1UFAPoxRBOXZMoorhTzu6FIVd/oETb2ixDmlGFPu13s1zvJnk6F3d99fqVUY21e4kfV9K7C7kgeCAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
X-OriginatorOrg: intel.com

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 21:02:17 +0800

> On Fri, Aug 30, 2024 at 11:04 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:

[...]

>>> @@ -1814,8 +1830,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>>>       return 0;
>>>
>>>  drop:
>>> +     reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
>>
>> Is this possible that @reason will be 0 (NOT_DROPPED_YET) here? At the
>> beginning of the function, it's not initialized, then each error path
>> sets it to a specific value. In most paths, you check for it being != 0
>> as a sign of error, so I doubt it can be 0 here.
>>
> 
> It can be 0 here, as we don't set a reason for every "goto drop"
> path. For example, in the line:
> 
>     if (!vs)
>         goto drop;
> 
> we don't set a reason, and the "reason" is 0 when we "goto drop",
> as I don't think that it is worth introducing a reason here.

Aaah okay, I didn't notice that, thanks for the explanation!

> 
> Thanks!
> Menglong Dong
> 
>>>       /* Consume bad packet */
>>> -     kfree_skb(skb);
>>> +     kfree_skb_reason(skb, reason);
>>>       return 0;
>>>  }

Thanks,
Olek

