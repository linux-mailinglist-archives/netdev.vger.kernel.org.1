Return-Path: <netdev+bounces-149112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCC9E43AD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240A62832EE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A613D246;
	Wed,  4 Dec 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZJcNkAO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE092629D
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338053; cv=fail; b=lsA5qKSJA3+CVZS9VZFpFDOhTXosq/GHX/HZRABqeKtAPa9GQ1M5LrQtlSipdh0mHAHQcxgQwLuebdHWrmrf76LxIkhcUw2cFL9/t23Nn+j0zII5AVHm89oZGD5RSe8+rNnko8ScKaI68Y3PvcHGe/SBkQErKDlcuNq+4FPRI6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338053; c=relaxed/simple;
	bh=ypY3xXyBSZkJGekbWqgdmSJoKyk6/Ewt10qVqR5T8RM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UsBLtmwuj0UsR2sPW2bvcutF3/A8t9DAtgebdoOYjdhjjV6VNYCZDbGkMd2q4tTtF78JKhy3zzTxNgycwFfd0QMxWiPS8rs7ZPt5fexQ8fbhcXswAuLFfhl4p2h+wUTHXzpkUGAsf37PISfE4afoPSeUZBgTlV0wa5igssoyrW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZJcNkAO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733338052; x=1764874052;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ypY3xXyBSZkJGekbWqgdmSJoKyk6/Ewt10qVqR5T8RM=;
  b=AZJcNkAONfZ0GLZ7c/z69vHBCAil0z2j2Ghdtkjuvir8ws504lOWcUXo
   Q60ZjAXmvQKlZdjSoEcaVsmqkon6ZGWRZFpDl/F6DC2c9CYj3iMHASn5C
   G9F7I4A0eYl0SfFnHgQEl2fKm1xCBa+uXdHSF3oZo7rNEsrwR0UdCbk7g
   9GAmRiwmVDMyasBIjItY8rc8c5dywPXsU+jkp9Bn3y/d//aWglYjidVZk
   O5TtsyTuy/L5t379THm2Sdb/4ZWCy4q79gyOqSh8suqZLnYUW9oj4MirM
   HRqjNDFho3kz65uI2LmLtPVee0xf5tRNzPaw7ZMBI+budEwYYAjZ0GJ7V
   w==;
X-CSE-ConnectionGUID: VvNbl4XvSEWVO3vDpjBgsw==
X-CSE-MsgGUID: Eb1KZTlyQx+sCYA4Bnj3jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="59031001"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="59031001"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 10:47:30 -0800
X-CSE-ConnectionGUID: 7wR5srmjSnChZllV+P1Y+A==
X-CSE-MsgGUID: 5hKAMarbTYGBZHbuRwJ47w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="98663153"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 10:47:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 10:47:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 10:47:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 10:47:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsKXBE9mjRuUIDcjK2ROSL9R7dHRYs+t3YikRN9BU+DQ/K/g+l8oFz9nGnahDV5JK5Maq24oBxieg7qAKzRWF9Hvd4a+WCvJrSopxOyU+KmE/kVpdEQBmpJdOpp9dWVh0MZcWjp2OrCAv/5wNMVK6wanJ253I17BDYh+FcB4WMKX9PvpqkeMDxdQecUQIIdHiUwS3cS8wzoeGLo1PHHnFLvVJxOpWsoIjor2hsQAtn8o2FojNjnIlbWtMoBjGek6flhaS4RGyz7p9omRNrFtjSPO/w/u78CT4kGh3h82CLpQyelFGZorMVR5+hMANklB4kOOQXdi+g+APBE0u3IhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GBL4YnsorS+Igp1dSeklGV6nKDPcNiTEOZjI1LbD6E=;
 b=g4wInYPTzwUSmxuy9iYOVP3UWK9jKyv7fcxuzLOlcs2yWENroDo1o7xMW/22pJf9YwXbMlW+38jpyRRzNSP6C8574j4pWSUTNHCiqMc/De6MIASqeueDPmAt1dK9y7zsZwZkgkwkIqc9O6wN3Mlq8UTrvZakSxA5C2MasF/M1JbGlWluIuJirGhX1L3hckX5sS4vUNyLS6KA0LfWa0O9CXm22gpLvaH9fkwSo3JSLgbkGHfYyy4gXwNYZHzVRIUn/7rzGjtfLWPPXwpdyDHZ+2P1G4lWUu6zlNTTeIPz++/rZg1ENVjm+i9KGodexsW9CSb/Wr4VEAwvnFrtrEp5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN6PR11MB8217.namprd11.prod.outlook.com (2603:10b6:208:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 18:47:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 18:47:26 +0000
Message-ID: <56a3653a-bcec-4755-bafc-03bf1e7cee3a@intel.com>
Date: Wed, 4 Dec 2024 10:47:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
 <20241204171215.hb5v74kebekwhca4@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241204171215.hb5v74kebekwhca4@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN6PR11MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: c62758ee-b7a4-4a51-0665-08dd14941914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alQyTnY5RXpMOWU0c3NKYmlWWmNjM0Mvd2FSUWs4WnJjdDZsbHVHZ1djSGxN?=
 =?utf-8?B?by9BTmloUkhUUlFvbTBOYWRNOVo0RDQ0THRocUVWRmd1aXduY3VqRC9sZSt5?=
 =?utf-8?B?ajN4K3pzRzE5U0RCR3FVMHp5KzVoWElwbEpLZjhuSWlRN0k5OVczbXl2Ny9J?=
 =?utf-8?B?cVd3SUU2NTAvckZoZWk3c044em5ZV3czSm15S2F3eW85Nkd4MEFLOEhmaGxl?=
 =?utf-8?B?V0s1cmg2MXA4b1FoWHlOZndqYW1HSnhlMjVBWFpjR256eWJEYWNGRm5UZnFK?=
 =?utf-8?B?Sk5UejEvQmFRa2NmeFdhWEp1a1BRUWlzaVJvb1pRV2kzVlRZOHhjSE1aT2xT?=
 =?utf-8?B?RGRPMUFqb3VRZEFYdGs3WmdqM1g3cEFvK3JnWFRQcHFXWTd0dEpwS1c4Q0dv?=
 =?utf-8?B?Ull5cUdiV3g1Vy9adVpMZmlDVlN4dWh6dlJCczNkMHRjRG1HVkkwWDZDNkhO?=
 =?utf-8?B?OUh6cGNNeFJqeEYxZFlScUpUekp1a1ZvdTQ1aGRwT01hNlRYTXN6VHF5K2Nv?=
 =?utf-8?B?OXNYMzNkTHk5K3NLS2tUV0RXSGZoRVFRRXBuaDRySGFhT0VoTzkycmkvc1JC?=
 =?utf-8?B?cHlhR25aY1dtRGFXVFpBc090Rk53Tk1ydDUzL2huWjdGaGRhcFlWQVZxYnll?=
 =?utf-8?B?MC8rbFdqOXh6aVpyZ0VsaWxNNlJGVHFyemw2eWFkR1lSVDBxb0pvOVo2SWxm?=
 =?utf-8?B?WDJOemMxTFhseDdFL0FmUitpQjc5dTl4b1FUOVowcVlJNk5ZelFveHNBN05i?=
 =?utf-8?B?VTByOHM5eG5oK3gzR3hrVVNSaDJ4WWE5cnk5eU41ZjBRbjNWZVdpTDRjTWN6?=
 =?utf-8?B?dUFtWmQ4MGdPZkdESkp6bExPRlhzOVVpQ1E1Y1hvclZyQXo5TDhQYXJHWkhI?=
 =?utf-8?B?MTdwRnFKTWdRd0ZraFB4Y2dKWmN5R1Z5MDVFeFdXOXd3TW9EWFRETDBnR04v?=
 =?utf-8?B?dDdFRUhUVUgyWG9nRU9JRjNuN2szdURBV1ByRFQ3ckxVZUtXcWhScDVYdW9v?=
 =?utf-8?B?YUJTYXdyM043VW53ZHJBQittTzJKcHE0UVAvM200S3NoZFpqKzRpS3pFeXZz?=
 =?utf-8?B?ek5nU2ZubDREOEhJNGVEdjA0ajZwUTlIMElPblpSdFByMkl4MDdxa2VEalhh?=
 =?utf-8?B?R2V3cW5ZaVQxby8rSnNXdUdkaVdhZy9lWkFiVUhSY0xaQmJsL1dhQnFSZDY3?=
 =?utf-8?B?dklUNGJ4QkphekdEZUpHaXZ3aEhMNDZib3VLazVYM0NDazBpQjlMM2QzZlY4?=
 =?utf-8?B?K1N6S2VmQVl4RWlyTzRBaEQ0N01jQU5GNmdZell1YUptZVdPMjdTQXNxU0xo?=
 =?utf-8?B?dDd0d3lDWENqdTg4NXNpRkYzS1V3RTF6YUhPcS9qRDh4YVJWUEtDT0dodWlm?=
 =?utf-8?B?RDd1cE9OMzlKeWlJMmowUVd3dnNpMDFITmVKTGtXTFlxNHhjaEQ3dEpCUjFP?=
 =?utf-8?B?OTVFTThIUzErdTNHM2NUeWp6cllKWHpwRllnYk11Yy9mQWRDajZwaTBOTk9u?=
 =?utf-8?B?L1laWFF5d2xhMUdQU1phYWVxbi9TTzRJeDJnN1F3RmJXNlp5Sm5IcW01ejRG?=
 =?utf-8?B?ZVVwOEtjcjg2MFczTmQ2UHlDUnVNWHpuYTh1cWVVcWJOaGlQRDEwLzVzREVF?=
 =?utf-8?B?SkpSdXRtcXJyQzJFcThFTW9DSXRyaHQ4cndTUjh6WHFTc0VVV1dLRWVJZk9j?=
 =?utf-8?B?YnlueFVJUnJ5NGxPd0pGOWJHS0hkemRSeDRMbCtkVTE1dXNJamp2QVdkWUha?=
 =?utf-8?B?K015dmNONDZONWE2dGdWMVljRUx5cXVOVTJpYnNkT01xTkVaenpxVDRockQr?=
 =?utf-8?B?dVVqVkh3ajJEc09ZVVJwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di96RjBrREtta3R5WkZ0MjJDOWM2Y3lDSlhXbTF3a0dQQ1BaVWZreWkwMGhv?=
 =?utf-8?B?RnZCUGRxeHJGbVZLNGZBOFB3ZlVUcnpEUVJzQW4vNkptS04zZlk3cjNmc3VI?=
 =?utf-8?B?VWNhdFdvK1M2ZnV0NzAvMWlKcllIZWFOVjBSK0VtenVCZnordXR1TmlaTWpD?=
 =?utf-8?B?RHE3ZzFuM21iZHJGK0drVnVwNVBJS3N3K0NRRHh6VjMxSm4rcE9TMDN6YVBE?=
 =?utf-8?B?cEZXTXRHREtVcy9WeWZlclMxN3drZ241UmsyekJJNlVJSXZSNlV6OU14cEZx?=
 =?utf-8?B?TTNnSFJKaExkemVETktTTUdLQ09ySXZlRDB0TjIxem4vNW9XQnRuQkU2Vy9z?=
 =?utf-8?B?RW1BV2pSd214SEo4dWpmU3JEekp4aVhTVUNaVHNCUlFHbWlLb25sNHFFUzJH?=
 =?utf-8?B?OVA2MDRFWk9NVDcvY0NvUmFGUGUzdjJQa0FqWkNOYkQ4TmlzeU5POE43TUVI?=
 =?utf-8?B?R2ZuUWJyaXQ4QS8xbHVaRkpuaFlSalgvRlFtcW9qdUdhWGQzUXpsWFJsaFpi?=
 =?utf-8?B?czQ3ZEZBR3FqdktLd3U2aUREeGovZFpkUHFqNFJPN3pkZWMvQ0lyZW1IdDhi?=
 =?utf-8?B?U1pnVSt4WHZPWkZXUzAxRUlDY1hjWTcxbnk1dlp4U21pVTIva2FDYmxQOE5z?=
 =?utf-8?B?eFBQMjdMTnZrWkZhU2xZQTh6QVhJU3VtMlpaUDRld28vWkZDUzJIVG53NG9L?=
 =?utf-8?B?aGhBNS9wVmdhNjcyOHM1QnJTbGh0RHRHWFZHVDNyRmhzc05VOG9KeG1kMmhm?=
 =?utf-8?B?UkFhdnhUMDlVZEh5eGNPQ0VocEtFdkx3RUtrMlY3STE2YkpRNlJhazNoV21y?=
 =?utf-8?B?Q1NmMkVKeXRBY0hRcWloUmFVQm8vVUZ4c2RZL1ZoTFdkcEVmOHNvREU5NTNT?=
 =?utf-8?B?ZzV4dEw4eWtlNVUvU002M1FYWUJ2WGNhRjZBNXUzUi84SXJScFRBcVJtV1lR?=
 =?utf-8?B?ZjBmaTJ5ajdwUHlERUgwSEswUHA0MkdSdTFvQlZnNTJFTVpOSTA1N2ZWS1BU?=
 =?utf-8?B?SkRxSndUN3hhU20zS1hTek1jMkdyODlJK0ZZSWJtVWZrT2U5a09LL0JZeTJJ?=
 =?utf-8?B?SUpDR2gwOUlJVU1FbnJWMG1mOWh4SUxkSWRINUh2TmxQUnhONytiUmtBT1NR?=
 =?utf-8?B?WjVpY05WU2NyUFlOWTIxSjM3dzhPWGxBY1RZQVNIbStaRGlpeWh4RXlaeU1u?=
 =?utf-8?B?VkRjYmtYK0lTYlJlcFFmcE4zYVhmUS83dDlOd2RRdmEreTR3Y21EdzRsc1Qv?=
 =?utf-8?B?RHhQU0dwVnVrZUlWQmE3aU9XUDlqSndWYzBPWHdhTUtnMnZUMDhmcFoxaUcw?=
 =?utf-8?B?RGtGMFJmbW9mMys3Yy9KTkFiZmpHc2xqYUQ5UjJhb0dRL1NnY2JhTFlOeitv?=
 =?utf-8?B?VlpuMUVrTmZVd0xkQXREUUQ5K1RydEwrRHBOQ3JjK1hBaVA5UFhNQkxpNW1D?=
 =?utf-8?B?ZEd0MHd6VGpHc3lVcVQrOEJuL1k3ZGRHU1VJQVc2LytpODhoUERsdnYvTUYw?=
 =?utf-8?B?c0lONzZmTTR5dkR5MnNFTmZtUU5qd2hBWUswc3pzeXp0NlZ6UVdqdm4xTHFh?=
 =?utf-8?B?T3ljTU5uNmF4djhoRm0vakg4T2xCVTdVUFVkSnNGclZFdWdQcHhSbGVWUmxK?=
 =?utf-8?B?MDhrankrL09BK1NnSHorb1F6c1B5RXI1OVRqODF0M3hENW9vTHdNa0pPT3Rs?=
 =?utf-8?B?M2JLS21CbVUzVm95dFVIL2YwWENsMVVTZllKTWJ3cXpWR0VIcnlEQ0VBcU1I?=
 =?utf-8?B?WWlVZ3grdjUvNlJ4eEJFczhsUnI4aHZZUG05T0lZSnhIRzAxbnVwSm1ySGNJ?=
 =?utf-8?B?aFA5d0ZCNGJ1WjVSWUltUjFIVktwOEpRakFWd2JDK3BVbW1yNjNhVU9kWFN2?=
 =?utf-8?B?a2FrdmJXK2lPQlZmTndZNU0rRGJ5bTFQQlZUNWVrN0tweEVaQUNjT3FzSTB5?=
 =?utf-8?B?czRoUW5TT2N6MjArMmJsajNrUzZGMFZ0emZxenJ3Qlg3NWJiK3grR0VIME9U?=
 =?utf-8?B?V0NxTDF3a0xrMjNjcFpVMFdmN1hKMXUvZ3J5M1lyYkYzeE9qcFFqbUNMU0l6?=
 =?utf-8?B?Tkk4a1ZuV01OOHBGdVdEUHoyTFBTVENNUmF5dVY2bllNK3lMaElLSkFuN2g0?=
 =?utf-8?Q?mMslw139h1VTQ2Rj/51wDnLpc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c62758ee-b7a4-4a51-0665-08dd14941914
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 18:47:26.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uV/l1ZqA2nXoTeEcMEklrx5Q6I5BdiLogzI6KOH6Ws6/QZdRe8Y85kJU/SPU0W0uxm4lPxxC/W5Kfnrg+9qohAIJ5wirAkeLC9srlf0z81g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8217
X-OriginatorOrg: intel.com



On 12/4/2024 9:12 AM, Vladimir Oltean wrote:
> On Tue, Dec 03, 2024 at 03:53:49PM -0800, Jacob Keller wrote:
>> +#define CHECK_PACKED_FIELD(field) ({ \
>> +	typeof(field) __f = (field); \
>> +	BUILD_BUG_ON(__f.startbit < __f.endbit); \
>> +	BUILD_BUG_ON(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size); \
>> +	BUILD_BUG_ON(__f.size != 1 && __f.size != 2 && \
>> +		     __f.size != 4 && __f.size != 8); \
>> +})
>> +
>> +
>> +#define CHECK_PACKED_FIELD_OVERLAP(ascending, field1, field2) ({ \
>> +	typeof(field1) _f1 = (field1); typeof(field2) _f2 = (field2); \
>> +	const bool _a = (ascending); \
>> +	BUILD_BUG_ON(_a && _f1.startbit >= _f2.startbit); \
>> +	BUILD_BUG_ON(!_a && _f1.startbit <= _f2.startbit); \
>> +	BUILD_BUG_ON(max(_f1.endbit, _f2.endbit) <= \
>> +		     min(_f1.startbit, _f2.startbit)); \
>> +})
>> +
>> +#define CHECK_PACKED_FIELDS_SIZE(fields, pbuflen) ({ \
>> +	typeof(&(fields)[0]) _f = (fields); \
>> +	typeof(pbuflen) _len = (pbuflen); \
>> +	const size_t num_fields = ARRAY_SIZE(fields); \
>> +	BUILD_BUG_ON(!__builtin_constant_p(_len)); \
>> +	BUILD_BUG_ON(_f[0].startbit >= BITS_PER_BYTE * _len); \
> 
> Please add a comment here stating that we check both the first and last
> element to cover the ascending as well as descending ordering scenarios.
> It took me a while to realize this, I thought the _f[0] check was unnecessary.
> 

Sure. I will also try to adopt the BUILD_BUG_ON_MSG style you have used
for the overlap to help with better error messages.

>> +	BUILD_BUG_ON(_f[num_fields - 1].startbit >= BITS_PER_BYTE * _len); \
>> +})
>> +
>>  #define QUIRK_MSB_ON_THE_RIGHT	BIT(0)
>>  #define QUIRK_LITTLE_ENDIAN	BIT(1)
>>  #define QUIRK_LSW32_IS_FIRST	BIT(2)
> 
> I spent some time today to play around with this version, and it seems
> to work, but I took some liberty and made the following changes:
> 
> - Tail-call CHECK_PACKED_FIELD_OVERLAP() from CHECK_PACKED_FIELD(). This
>   reduces the size of the generated code from 2753 lines to 1478 lines,
>   which already brings it a little bit more into the realm of "tolerable" IMO.
> 

Nice thats a good improvement.

> - Remove the BUILD_BUG_ON(ARRAY_SIZE(fields) == N), since I think
>   that's just wasteful (in terms of space and compiler CPU cycles) and
>   ultra-defensive, when the auto-generated __builtin_choose_expr() is
>   the only caller. It was justified when the consumer had to explicitly
>   select the right checking macro.
> 

Sure, we can drop these. I had kept them because I felt it was
worthwhile in case someone does call them manually, but I don't think we
should encourage that behavior, and it is otherwise completely wasted
cycles. I guess its defense against screwing up the builtin_choose_expr,
but that is auto-generated now too.

> - Add some prettier error messages. Compare (for an error injected by me):
> 
> ../drivers/net/ethernet/intel/ice/ice_common.c:1419:2: error: call to '__compiletime_assert_3302' declared with 'error' attribute: BUILD_BUG_ON failed: max(_f1.endbit, _f2.endbit) <= min(_f1.startbit, _f2.startbit)
>         pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
>         ^
> 
> with:
> 
> 
> ../drivers/net/ethernet/intel/ice/ice_common.c:1419:2: error: call to '__compiletime_assert_3414' declared with 'error' attribute: ice_rlan_ctx_fields field 3 overlaps with previous field
>         pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
>         ^
> 

That is much nicer, thanks.

> 
> That incremental improvement is below, if you'd be interested in including it
> (the auto-generated code is not part of the diff):
> 
> diff --git a/include/linux/packing.h b/include/linux/packing.h
> index c4fc76ae64a5..1c89a5129b06 100644
> --- a/include/linux/packing.h
> +++ b/include/linux/packing.h
> @@ -36,22 +36,38 @@ struct packed_field_m {
>  	sizeof_field(struct_name, struct_field), \
>  }
>  
> -#define CHECK_PACKED_FIELD(field) ({ \
> -	typeof(field) __f = (field); \
> -	BUILD_BUG_ON(__f.startbit < __f.endbit); \
> -	BUILD_BUG_ON(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size); \
> -	BUILD_BUG_ON(__f.size != 1 && __f.size != 2 && \
> -		     __f.size != 4 && __f.size != 8); \
> +#define CHECK_PACKED_FIELD_OVERLAP(fields, index1, index2) ({ \
> +	typeof(&(fields)[0]) __f = (fields); \
> +	typeof(__f[0]) _f1 = __f[index1]; typeof(__f[0]) _f2 = __f[index2]; \
> +	const bool _ascending = __f[0].startbit < __f[1].startbit; \
> +	BUILD_BUG_ON_MSG(_ascending && _f1.startbit >= _f2.startbit, \
> +			 __stringify(fields) " field " __stringify(index2) \
> +			 " breaks ascending order"); \
> +	BUILD_BUG_ON_MSG(!_ascending && _f1.startbit <= _f2.startbit, \
> +			 __stringify(fields) " field " __stringify(index2) \
> +			 " breaks descending order"); \
> +	BUILD_BUG_ON_MSG(max(_f1.endbit, _f2.endbit) <= \
> +			 min(_f1.startbit, _f2.startbit), \
> +			 __stringify(fields) " field " __stringify(index2) \
> +			 " overlaps with previous field"); \
>  })
>  
> -
> -#define CHECK_PACKED_FIELD_OVERLAP(ascending, field1, field2) ({ \
> -	typeof(field1) _f1 = (field1); typeof(field2) _f2 = (field2); \
> -	const bool _a = (ascending); \
> -	BUILD_BUG_ON(_a && _f1.startbit >= _f2.startbit); \
> -	BUILD_BUG_ON(!_a && _f1.startbit <= _f2.startbit); \
> -	BUILD_BUG_ON(max(_f1.endbit, _f2.endbit) <= \
> -		     min(_f1.startbit, _f2.startbit)); \
> +#define CHECK_PACKED_FIELD(fields, index) ({ \
> +	typeof(&(fields)[0]) _f = (fields); \
> +	typeof(_f[0]) __f = _f[index]; \
> +	BUILD_BUG_ON_MSG(__f.startbit < __f.endbit, \
> +			 __stringify(fields) " field " __stringify(index) \
> +			 " start bit must not be smaller than end bit"); \
> +	BUILD_BUG_ON_MSG(__f.size != 1 && __f.size != 2 && \
> +			 __f.size != 4 && __f.size != 8, \
> +			 __stringify(fields) " field " __stringify(index) \
> +			" has unsupported unpacked storage size"); \
> +	BUILD_BUG_ON_MSG(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size, \
> +			 __stringify(fields) " field " __stringify(index) \
> +			 " exceeds unpacked storage size"); \
> +	__builtin_choose_expr(index != 0, \
> +			      CHECK_PACKED_FIELD_OVERLAP(fields, index - 1, index), \
> +			      1); \
>  })
>  
>  #define CHECK_PACKED_FIELDS_SIZE(fields, pbuflen) ({ \
> diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
> index 09a21afd640b..fabbb741c9a8 100644
> --- a/scripts/gen_packed_field_checks.c
> +++ b/scripts/gen_packed_field_checks.c
> @@ -9,15 +9,9 @@ int main(int argc, char **argv)
>  {
>  	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
>  		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);
> -		printf("\ttypeof(&(fields)[0]) _f = (fields); \\\n");
> -		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
>  
>  		for (int j = 0; j < i; j++)
> -			printf("\tCHECK_PACKED_FIELD(_f[%d]); \\\n", j);
> -
> -		for (int j = 1; j < i; j++)
> -			printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[%d], _f[%d]); \\\n",
> -			       j - 1, j);
> +			printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", j);
>  
>  		printf("})\n\n");
>  	}
> 
> And there's one more thing I tried, which mostly worked. That was to
> express CHECK_PACKED_FIELDS_N in terms of CHECK_PACKED_FIELDS_N-1.
> This further reduced the auto-generated code size from 1478 lines to 302
> lines, which I think is appealing.
> 
> diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
> index fabbb741c9a8..bac85c04ef20 100644
> --- a/scripts/gen_packed_field_checks.c
> +++ b/scripts/gen_packed_field_checks.c
> @@ -10,9 +10,10 @@ int main(int argc, char **argv)
>  	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
>  		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);
>  
> -		for (int j = 0; j < i; j++)
> -			printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", j);
> +		if (i != 1)
> +			printf("\tCHECK_PACKED_FIELDS_%d(fields); \\\n", i - 1);
>  
> +		printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", i);
>  		printf("})\n\n");
>  	}
>  
> 
> The problem is that, for some reason, it introduces this sparse warning:
> 
> ../lib/packing_test.c:436:9: warning: invalid access past the end of 'test_fields' (24 24)
> ../lib/packing_test.c:448:9: warning: invalid access past the end of 'test_fields' (24 24)
> 

I'll take a look and see if I can spot it.

> Nobody accesses past element 6 (ARRAY_SIZE) of test_fields[]. I ran the
> KUnit with kasan and I saw no warning. The strace warning comes from
> check_access() in flow.c, but I don't have any energy left today to go
> further into this.
> 
> I'm suspecting either a strace bug/false positive, or some sort of
> variable name aliasing issue which I haven't identified yet.

I had some issues with various attempts I made at the compiler checks
because different compilers would not always track constants.

