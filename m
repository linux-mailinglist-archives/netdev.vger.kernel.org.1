Return-Path: <netdev+bounces-127931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BF977152
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E111C23773
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA91C2DAC;
	Thu, 12 Sep 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAq0IbSk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3141C243B
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168384; cv=fail; b=Xl/fqT/utnw0JRZqbRbBzxg/SoyFQqN1IJC9UvY2kZBLwsDJFMwBD1w9SOmoJ3jLQ1WaL/Px9H5SscritcExUQwBS/p3sQ1YaN2TkXHK0uXQlszrWUsyXsUW4urP2P2FchPpscHEQ4n1lhLDTDL1H2LvwF0JJYmKch32f7damQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168384; c=relaxed/simple;
	bh=juvJEva9UUT50euru9yWhMwl5FCj3NG0DaVShFgEKW0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rMGWqGnJztMkGCfuQPb8JQfjWFyt3lsEZT0rrofGuGipt3ebzhEZYku3+Ajh76Vx6PRyPfOiUL3kzTHjxHC6zCaS76FwRird2lqOPdunwFUZjJku5ZboMqY7fwbjSdA07wGqxwE/Dt9SU1LdurAkDUp1QDYekomEL0nmwRH8eMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAq0IbSk; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168383; x=1757704383;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=juvJEva9UUT50euru9yWhMwl5FCj3NG0DaVShFgEKW0=;
  b=GAq0IbSkhadEA9Bm2PALS+7BJRtqdJTQ7AFK63qZP4kz7qvI7AIyySrM
   DoVlc1hPSnsdVWwqNeOyxZ2GfQLP7d/UrYA+43rUtZt2RdgFrr8fFpoQR
   onpZJ4Bf4arbTs1hv497LBLla3LYXnqPIybXXQdz3ZwSJxbfSlNdd/KQw
   vowT0wTwEOcr0edwu7Yuc/Oc57iRiCL7JxW2UnKyRdK/WIHZfrRpGHIdg
   s+Zk5/jdJBQH+XW/WK3GFCgIga6joLaQsWk1VGMsmIbjCE/0RJJym6gN1
   KVctL0cPkXzT2kpjkpwMMchLgvva+f3cdgeUw60bies/jagoowEyrgug5
   A==;
X-CSE-ConnectionGUID: zs5r9utqTYSvzqUkvVSobw==
X-CSE-MsgGUID: Rf8o9ebZQ3q33zKCYgH1Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24534170"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24534170"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:13:01 -0700
X-CSE-ConnectionGUID: 17DvKI9RTxiXNi88rrq6EQ==
X-CSE-MsgGUID: pYNb3Av3TZqA83VHdr8+hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="98621805"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:13:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:13:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:13:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:13:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+BYhkykHyZ+egG/MXl0qZPM9qyKo2aTNlyM9mIlOwMYQVhTHGXnLgBRM18kW71nKsf4aNs19ag48s1Epb/TfbUE2ywrbeqUfjBJeMAEs5PceVPPhF9LZwwWrMzfhmFRXrkTF+Z7TFS+DD9eDoxUGHaAue0TucdVwgZUu8jM0Y4lfkEf03lKBwieJNSOQPFny2oLwCrgLXc7zsLLF8AKtdmOeCg9N8aCUTv3GUneNbFA/cn8i47cBZeZ8nsg94arGC4nOtoL93m+EN23b2pZ1gq6qYn6KI4MenDf3VRY9uT9Tvv/Xouwearw3ZoRIm0ZRHzIRshKeZyWAuROcmQM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm7SPTIDhjoi4+ZwmO+R8j6og/u6MjD1tELExvdmcxA=;
 b=O/zGbJiYN809dmQ49LHTBfl3itkJyNMjwoXNMn4JEFhshO3LEgzquTrf7XCfV/QbcDSV0CuvU1laXtr67wbyjhQw/pj/P2ATUgHlB1Y/zSHF/5s6wHlyECD6vLOmGjdybuopazijhPjp01b4Y36Y29v3c0eRiCGXqq3xRF30df1Ri0ZsSx9a8rXbAuiVBZNeo24rVKMF4DtrDAj6Ku9zwWT07VvmRPvkmPgxB2/rZybb0sRsy9ndKFJy9Pxfr1YCf2K0bf3GD9JUjAYCnYnvqsH7lZmJw6l6ImnWq6Ir2xzuZ3lvHNq6mPH5FADEeQZwaXQspwbYEvDXnnQCHsnUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:12:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:12:58 +0000
Message-ID: <3662bbd2-926c-4ce3-91e3-fadcff4bc028@intel.com>
Date: Thu, 12 Sep 2024 12:12:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 11/15] net/mlx5: Skip HotPlug check on sync reset using
 hot reset
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-12-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-12-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 29459721-8c51-46db-094e-08dcd35ee99b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Snd2ZmYyTDV0dE9DN203dlpZMlpZa2ZmcmltTWUxWEl0REJMNk9sSWd4UVZG?=
 =?utf-8?B?ZjNMVVB0Tmdsd3ovTDErUTlNRVFYTnd5a0N1VVBrd0xxYmwyZVNlQW93ODdF?=
 =?utf-8?B?b09LMEhNcXVOK0QxYlhKL3M5UGVqMkNiVGx6M2M0SjEvelIvQnp6a2NzNEcw?=
 =?utf-8?B?UUx4SHUzcFVsUlZNOEFSSGtiWkxaeGZYeHhXSTBNYm9Ic0tCNUthem9NVUpo?=
 =?utf-8?B?SDZKc1hhcGh5NkxiUU50aFcveGRvRHRLNDBUTEFjRzhIOGtpSEFEaGVxc3du?=
 =?utf-8?B?UlI1QU92ZTRRQUFwL2kwUUkwc2xxQUdnS0psZGRyZW9xZWdWVW9UNkI0ajhS?=
 =?utf-8?B?MWQ1WER2dEFId1dvZFhDVDgxR002cnFWd2szdzNNNUw5R0s5QU0rM2J3NHov?=
 =?utf-8?B?aWJLK2lRMUZ6dUVVNzJoNFV6ME9aTWRoa1BYallER0RORWNReEpBOGtIS1Zt?=
 =?utf-8?B?SjlQSVQxWVI3SkxwQTNlS0hmK0F6a01BWFE0UGZxcytaamtGcEdoVFRaN0pu?=
 =?utf-8?B?aXBqcGZPVUNWbWVUdGZXdGRMSlZSQTEycXlyK0FFb2VxbERuQy9JcjhpbS82?=
 =?utf-8?B?cFdINzBRanlRT0RHQkFvbE9EbkwrZVJZcUF3L21WY1FoSEJNT2FiT3hoQjVE?=
 =?utf-8?B?QTJEVTVqMVFpNmo4b0YxaTM2Z2N1L1lwWjBXZys3a3JPdzBsR0ZNT0lWZEpy?=
 =?utf-8?B?ekRTMVNXbGI2ZXV6THp5eENMZTJsaE14akkvaFc1NWVEYzZMdnRQVEx3MTBZ?=
 =?utf-8?B?L1pNYWNySDFodHBMcnNDa3lmTXVEdTA1VmRYVnlrU1ltRHhUQ096N21QR1Nj?=
 =?utf-8?B?ckU4VlBVZW90VDJ1cUlrUUZicmp3NWk1UjNFMWxrYnA1Z1AxSnVML2V6TU53?=
 =?utf-8?B?TnA4dFBSOFlMKzFMUlJ6cDdXSkxjRWJlcnAyLy9YV2Rtcm1BeGZtZFVXZCtF?=
 =?utf-8?B?QXRCUnZ1b3hRczdCbU5wM1ZEVkR2WXBuYzBaMkRzakQrc0ZNaW9NNWRXM2FK?=
 =?utf-8?B?MXpVeWFrTHJ1eGJTSFdBYmNBVGkrUmpQQUZrR0sxc1VPQ2lhaE92clZDU3hM?=
 =?utf-8?B?TUxQYWc5VlRvRTRBRkMxNHN0RzF5SWtsbVFka1grN0h2c1VHMi9qZXFWdVFM?=
 =?utf-8?B?ZlIwNVlILzRPbFVrUlJPUHVpQW1zNHBLSjZzcXVvbGphNVhFeUE3c3F6UkFI?=
 =?utf-8?B?NzQrL2pmSThBMnBXQXUyZ3NnR2pCSzV2WkRPaGMyclJQcjQ2RUdYeU9ueElZ?=
 =?utf-8?B?OXdYcjB2cFd4b0wzaFd0YUFjamNUeEJGczhDalBxSHB0V3orMzhCRFI5NmJa?=
 =?utf-8?B?Y3AxYUIxemZYOFUzWDJGRDc4YmllbU5ML05pVjhjY3ptTnh4Wnh4MDZmT0xP?=
 =?utf-8?B?Njhhd243TkY2dzMzRUVBMDlqKzU0SjU0aUZTUXZPRFBEY05tdEpUNGVKT1FF?=
 =?utf-8?B?UUVUUHJTWDgxUXdpaWsweFcrWDAvUTdsNEtXSFRQU2k5TFRGdVg5NXlPdkNo?=
 =?utf-8?B?ODJlemRhUENQOHFleHZxUklxWFlXUHpsTm5OdkMrc2NXU1J6MEdlbjhkUXFK?=
 =?utf-8?B?NlVvSzhtVWNBblFEU0w0SS9Zck5kQ0VUclNTcmVHMmZzYmF0NzFCMXFoYzB4?=
 =?utf-8?B?WGpYRmVOQndBMSt5RThEUnc1ZlpLWC9SNlNJRVFnTDZkZWJHN3VWVGVJQVlH?=
 =?utf-8?B?R1RFaXM0aExLMHJBRGpNMXRId1Ezb1FTb1VndUl6N1ZoSW1vWDc0Q0VQOTcx?=
 =?utf-8?B?VnNzRFhidW83Q0UzUEkrZVhKZVl2YVZ4TXZ4UG93UVBTdXRyY3p1UUlZSisy?=
 =?utf-8?B?VmJuOERCYzBua212SnlCQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVjWVJQSnlZQmJVZHliOEp3Y1BxT3NzMXhMMHM3VVZuZWRhZnl6MHZ6eUxJ?=
 =?utf-8?B?WkE4azFJeGlzT2xBUWFIN0QxeEliVHFWRThhTVJ6dGttRkc5alNhU21tK1M3?=
 =?utf-8?B?NXlOeUFweHExUE9UUk5Uelp2KytKOGowTlYwVVdhY0xhR1VLZTZuMHFiRk5u?=
 =?utf-8?B?ZHR3SWhpMVFEMHVSUkx5K1BqdWs1aWFidUc5YjMzWWlVU2FQRWRBYld3dHlk?=
 =?utf-8?B?aGdiUjZVS3A2aGVBaUs3UWxLTUhNKzNQS3ljSG1Fb3k4MXR5YmY0UUpERzBi?=
 =?utf-8?B?MksvZWJOeTNoM1N3ZXhpazhKMjA2eUFQYTVHZFFkUTFTWklYTUMxNXNIc3Nz?=
 =?utf-8?B?Rmt2NmNreXpsbWhOdTQwc2lBWk1yOCs4RkVpcDBuUWNmMXVxenN3d252YUxP?=
 =?utf-8?B?bHpveGE3V01SVDJNQnk0QzcrYUI5RmxneXp6S0xTL0UyZnZCTG50WTA4UnZB?=
 =?utf-8?B?ZWFpTXp2VGdCai9OeFZyUTJwZjBnUnFUQTJGaVd6c3JOTk1uK3FPVisxMnZr?=
 =?utf-8?B?TGcvc0xYczRVNlFDWUVuM1lEOWUzUm5oTVdaVVFta0prcnkySzNyWkROSlM5?=
 =?utf-8?B?a081M3QzUTEvcnB1QlkwYnljZGZSQll4NEFCN2xaVnp1bUIxNUdJaUR4Uk5t?=
 =?utf-8?B?UVBLVDFKdjE0cFZsTnV5NS9TWGp3OUJtNjcvN0l0bnVSZzBEN0ROdytJTE5u?=
 =?utf-8?B?cDRlcm4wMlJncUJvbVJvK3hZOHliTEplaE5ZNmx1czlRcDhjZm0vN2RRL1lm?=
 =?utf-8?B?LzFVcVFlSjRqUVFkSFhsK0orYzVGUmhtdEl2ZHZzeEwzcko0a0loZ2NZYnhR?=
 =?utf-8?B?STNRWXQ2VlRJbmJzSmVTdjJ1bmRqeWdJTTA3WEZVc3ZDQXJJSmV1b0VYWXZa?=
 =?utf-8?B?cXh0cy9YY3pybmIvZVNrR2JHUHdPNVhORmh2UTdyR3BmUnhjcUVkM2Iwb1Zj?=
 =?utf-8?B?N3ByLytKaE5tQWdhNHVBd0drKzUrV1BwZWV3U3AzK2ZnNWF3T2hJTUNUVFRp?=
 =?utf-8?B?b2ptVkVTM2lYdEozeDJScVU2K2JLK3M0VFE3MWJYV3JBODFOa0dlbDVhMDZh?=
 =?utf-8?B?SHhQZlpZS3AySGdSRlVzYy9OSnA0UVdtbTBqZFJGckpOblNzR2wxY1pwa0RI?=
 =?utf-8?B?M0I5d2FzOTVIYVc4dEZvaGlKVnNNWDZudkwrc28vUG5HSUNNOFJpMXVlR3Rw?=
 =?utf-8?B?Ni8wTEZjZklYb0dieG1yejBzU0JwT0xDSXF1SmpPWGFUNUhBc1Q2UWRNakpv?=
 =?utf-8?B?M2VidWh0UDVZYURjQUlYaEZ2dlhEeEkxakJ1cDY1T0FreUFaM2hYenQ2YmxC?=
 =?utf-8?B?UFhhTFhCOUFuMkppSW03Y0JkQTZNRXlNazZLZEE3UjRGWDBGemJsZVdndGNU?=
 =?utf-8?B?WWVMQThMVjhoZFVCL3BkejZLSk9zVW1vTlNrMHZYaCtrZk5xTjdleFZtanlH?=
 =?utf-8?B?WmdSSC9HOUViQ0NKayt5NGVQR2pURnNWZ2hSbEtuenJJUUVLWStrRDkwL2RT?=
 =?utf-8?B?YjVPejRqQjRaK3FYYkVmWHpCZVh3R205bm0rc2hBeVdDdWQ3UEpQc1cxMEtI?=
 =?utf-8?B?UDJiTkFyREhzeWpOLzZSU1BjcjlKcHd6czNtV0pKZ1NQZlBiOEZySVh2dlRJ?=
 =?utf-8?B?MEV5TW1GTk4zOFVDVzZIejJQQlFhVy9zbUQ0dHg2UVUvYllTZy8wNGJ1cHBX?=
 =?utf-8?B?WW05cmdBKzBBYzFkdjMwWEhReExMdnRTcnZSdUtPOEg4bytwUUdqMTk3dUNX?=
 =?utf-8?B?b2xzSWlCelR4UFV5YnJoQU5zMnFzejRyb0JUMmVKbWRvUEJ0eVA1TUsrL0Vr?=
 =?utf-8?B?YXNqUG9aRXU2VW10OHphT3pXM1gwN3VqZENKZ25vVENGR01mNEo4aFlObjU4?=
 =?utf-8?B?UElBNWEwc3RGL0VQV0xmWVJySldvYzhlY2ROU0hlUWN4Ym81Z2ZXc0x4WlY5?=
 =?utf-8?B?dHMySmdIN3JZSGRuK3RZaUVlaWxkMndPTmlGZ25JdmVBdmtDVzNkL2FaZWJw?=
 =?utf-8?B?VGdSdU1PN0l6eEhPUS9hM0FBOU5zS2NoTVY5TUZoUlBMMHlTaFpVbjVCbXBJ?=
 =?utf-8?B?ZUNtQ0NqQ0ZsRjhrSkMySENIUm1Dd2xJQVNwbWR5eWI4b3VMMjFzbktLZ1Y4?=
 =?utf-8?B?MXRKQzJ1MnpxTHlublRHRjRFeE9wUlh1ZmhhcHRLTW9TTmt6WEw1RDVDdU04?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29459721-8c51-46db-094e-08dcd35ee99b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:12:58.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZDVvu4rYFxoUszsTwzpuEk3dpvGUaqQCg4rJj+5LCSZ4IircHWiggTXzHMWs8w3xQq/WTaLimKMQSNUhjmciV+tMLo8flH2jyJE3o+r+uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Sync reset request is nacked by the driver when PCIe bridge connected to
> mlx5 device has HotPlug interrupt enabled. However, when using reset
> method of hot reset this check can be skipped as Hotplug is supported on
> this reset method.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

