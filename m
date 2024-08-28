Return-Path: <netdev+bounces-122940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ACA963399
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D50A1F225C0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D961A7050;
	Wed, 28 Aug 2024 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkUk0gry"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796345C1C;
	Wed, 28 Aug 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879282; cv=fail; b=cW4Yt7L4gS3dnivabbJfBLx5fNysR3i9y+ikxVjJAAvoMTT/KUwlHmyNMdZtMRndUDXfNpjRYqyj+27LpJKD+goabrAJkdy7E9STGmnaDE+aEfRfIpGYeQr38tKaH8+lJN5RuTF5+PLAud76DoNHF4drwHIJ6e3khydL7V6ge1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879282; c=relaxed/simple;
	bh=GcOw2SDfGAJOgqLJqQ9EPytCljV7KNgRJUeisO0SViE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2cIDkTFx7jHyXb733Icq2Q7pUGvzEBxyZO5QjTMGMtIZHwjMd1uHOda9TqYeTYcN9r+W0z2E8TibvN53k5cF1EYau7rRMmYuMmXH6eh/st6PLHkdfibKf+JXZ02+HaXw5fma0ov/5iXYEelSsSgFhuLEviESjp5TBgbuP2lA00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkUk0gry; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724879280; x=1756415280;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=GcOw2SDfGAJOgqLJqQ9EPytCljV7KNgRJUeisO0SViE=;
  b=OkUk0gryxYxFAnqFVP6JY0YjzGwRHwicXswDuzj9yKqBPJtXiEm0kFAi
   PBlF7hcApYxornShh/MiF/SmZPc1ahT3bcsACK/Nb6IOGlpxm55hoTvrv
   LP9T8m1HzTef+GaIkpafTlUUrpyD0uDTKB27IHtHfXtMKV1pn6T+Q78UX
   ldTOjuXd2JmSmT75P4EHyrW50BT7/SXmFLq7CY2OXpv7WUmu6tMhXDrVj
   655kvUSGX/96nCMoU2577Q9zv2GCPYCvNOPSWoLDYvBRk4kEcxKVaHn39
   ptk2uHiSCyrXRtpglLTSwiPlmCzuopHV5zI1Tcv6EZiWHzmtobTnWqNpv
   g==;
X-CSE-ConnectionGUID: mMicpnoCS7ylxjDi1j1zBA==
X-CSE-MsgGUID: GcPKBorqQM2czrQtIGy81w==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23625888"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23625888"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 14:07:58 -0700
X-CSE-ConnectionGUID: PiOXC1h7SlylpVmLvi6Fqg==
X-CSE-MsgGUID: SpMoFTPKR92SqG0Juo+HMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="67720029"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 14:07:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 14:07:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 14:07:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 14:07:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 14:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWzu7qraxZHSvVPO+eivyEOgCa1TAkUTvVA679MsIagntTf45/XZCp96TzsuV9FtBGHXK0dEN+/LsnTos77YpOg250afAP/YHvVuZH8hPHSFNRMCNEipDoriAhSOZvKvPyzmftIKA9z1p+jmk7+AFjg5EoPo20BZOxKV3h/6PYio4tlQuJKXj6m2OtONa5LruGIVhfDKNpOswqEhnLUi0I8063SnUQACScPJRM0D0sF1ZlzAni6zpjjTWTeJa2l9wlCF/4tstXXnCe6IIRQC/Q5YFg59oZMAcoZXP1FmDhT+40BDs8n7UCTWRdw6rSdvRVK6/YG2UGvyA92/4oPArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Pne5Y7KR6IP+HhTNtyQ2YPN8NO8ZRQxzSi+nh1/sL0=;
 b=WfH5dAi+jPXAVu3dlX+aXXLUs3VUanUVL+n5BejktA2bl7zAYcyabhp4yiXdh3IjPBsUTrfhwwy7Gd0vtM6zh+RmwRGq6PO0G8sqEfGhM9ecgn5bwIalQ0PHkmWtGbEk+GB2OTvBR1W+CnWKF3hzhgQtKgv6QjfnGf+eXYYRdsCOqFx6KBnQchLKTIV/z2/o6if5r3z0RK387ojpgQgdUrr1fwKhhXKJLFDygpTxT9Am8+W8VcgV6iEP6QTf1W1Oks/zurO3HftKg/pUJglH0uv0Ld/WM7ZC44rI9rwMAbI4gTCzudzfkrSw15o/td5aw8x/+wUMJhZ9LG7Zrog/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 21:07:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 21:07:55 +0000
Message-ID: <6e29e82f-b0ab-4c48-8971-3b97752dd210@intel.com>
Date: Wed, 28 Aug 2024 14:07:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: ftgmac100: Get link speed and duplex for NC-SI
To: Jacky Chou <jacky_chou@aspeedtech.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<u.kleine-koenig@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240827030513.481469-1-jacky_chou@aspeedtech.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240827030513.481469-1-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:303:85::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 417de185-b0de-47e0-4949-08dcc7a57cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW1DWUhvQ25FaWdaTy9FeStXbEkxdzFaU0t0K0tjUzVEbnhMb0c0Nlc5QitE?=
 =?utf-8?B?N3ZRZ3o1cCtielpmcXJTUWdjZ0ZVMkllR0IwWXBidXEwVktRb0ZjNXRFcHcx?=
 =?utf-8?B?b1VrT0pmOHhBL1BEUjMyMVlRNG1hYWJXTFJHOXdSZTdXUVJVcU9GbWV0WGIr?=
 =?utf-8?B?WHBicnhjOURYcU4vUUZtN3ArYjNiazg5MXVNL21oSEptZ1hUNHR2QzVROFJP?=
 =?utf-8?B?NkpHa2ZGZ2NZVnU0YWYvcVhGSE9yZkhTMjJoQndEMUFwT3ZiZFVzeEM3THh2?=
 =?utf-8?B?cUFWZ0dFczBUL2JYaktPNG9EQ2l0TUd2YjF3RkUycnF0aGE1NDIvSjZ1V1lr?=
 =?utf-8?B?V29SeDA5dHhTelJFUHkxY3lORldocFFmN0ZnK2VGNWM1dE9CQVNCUmRkcjJ3?=
 =?utf-8?B?MTZEclZWby9qMEJtakxCcUxkQlZUejZpMDY4UktFK0ZqUVJkSU5GUk00RkNo?=
 =?utf-8?B?V09sclhkSDI0c2FiK09Ba3hvODZLbmtiL1RCajF2V3RsL2tDQ3ZkQ3AxUStz?=
 =?utf-8?B?ZHFiZHNrMDEwQXB5a3RIRWEwUGlaRFRuakVIUmtkUE5iMEpRcW92SzhvZlA3?=
 =?utf-8?B?MjRBOGY4RmdjSGFKVm9KOWxmOWFGQ3dBS01aV3cyYlVVMElvYmZTekVYODRt?=
 =?utf-8?B?SXhEdFo3bDBBVEhYMGpzRGVzMGhRcUtmNlk1bzRORlJvNlpQZkRoMTlhMllP?=
 =?utf-8?B?M1NpWDdDTzhDOGZEVmRmU0NhUUxndjdSY1lXR1UwZFBwbkVwVEgzWStPVlhk?=
 =?utf-8?B?d1d2YUFBNHlBR1Q3ZTVqQmF6eUcrUTRXcmxHKzdES1FQZmR3NzhJNTJNTEc3?=
 =?utf-8?B?Y2xKckRoSnU1bGxuUG1qNER4UVN0U3NYMC9mWnc0dVExMXgrWk9CVWo4Y0xo?=
 =?utf-8?B?TStXOEJzRmhGdGlwUEsxcUFRVW8vSmtqZFpNNFhSaFBYZjFnSTFhbDBFZ1RU?=
 =?utf-8?B?UVc1MEZHY1ZmYzJacnBSMk1VLyswdDZmZVJMbUk3ZmQwd2JtSXlqMVlKVXZZ?=
 =?utf-8?B?KzdLanp4dExpRG11OCtXRDFTKzc2TmkyYzl3RjE3KzNZSHRJK0FYYzdVVjdp?=
 =?utf-8?B?dlhLNU0wQ2p3QmlIdW1XWEljVEkycGhjR0F3SzZSaXRCM2dtQWRXZ05DTkYr?=
 =?utf-8?B?bldJZDNTWXNtazRwcTgzWUxqWHljcWh5N3NncndVRGlOTXMzMERvak1hTmFp?=
 =?utf-8?B?MnJicThFdjEzUmFXaTNlVDArakd4bHZ2QnVjZlVqTFI4WStEeEU1ZFFBaFlr?=
 =?utf-8?B?RDhyMDZjUjhQbEFhQ0VYZHFlK3BIYzNxYTJFbmxPZ1luQmEyZExvY3JyM1cw?=
 =?utf-8?B?dytENnlzZXpNQi8yZFhiR2Ywc1JLZFVvaHpjKzRYY1ovc29keFVQcXp4bkxE?=
 =?utf-8?B?eUZuQzU4ek4xTnJvK1lpY1g0aWloZkd5aCtwKzVIUHFQSk9tUHFueEdsNm53?=
 =?utf-8?B?ZlBYMUwrbEdaMGs2TTYyeWIrOCsramNLaVBsYzBZMmd1V1RDTm5kbDVVbXlB?=
 =?utf-8?B?NmhXeVZ2T25VQmNZYjloSElzcXg1LzZGR1V0TFk0M3UwejA2YkV6SE9nbkxj?=
 =?utf-8?B?L2hGN0tTaG5MbGpmVmVWN0I2ZUk0NFVXWFk1ZVJYaUVHaGNIZUVrVUkyNFk5?=
 =?utf-8?B?MVRPSTJNU2kxRFlJNlRIK2RveHVVYTZ0WkdEZldHWThrWVpEeWZURGRFamFX?=
 =?utf-8?B?UTk5ZlEzV1Zja2dBOExsRUxRNFpkRTRoQUtJOGRHTEF2M1d1MVlTMWdWNkdU?=
 =?utf-8?B?ZFNnSmxWV2EvK3REZktGR2M2azRQbCtDcFZaODBSd0tvazY3ZFBtMXdkNkZk?=
 =?utf-8?B?RllsK2RSUGI3T2FuNnFtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5KbEVhUVhBQ2tOMTM5eC9IQ2dUaktzbm5wK0x2NUkwSFhYdE5SMzVmbUVG?=
 =?utf-8?B?cXpTYjgyVlZqeU9EUlhXdEFqVkVocjZpRjJjdzgrZUZ2TVMxWVVzSU9zQVVG?=
 =?utf-8?B?amRxdnFHYlE5UkozSno1YmFRZEY0N2RyRUpHaW1XaHc3M0pEdXZaQUJsZnZk?=
 =?utf-8?B?aFVxelV3clNpcW5hTytMVm83d1U1Qlo0V3dWTlUvZW1GRmZZQWVkcnU0NmVI?=
 =?utf-8?B?U1VsWkdKb3ZMc2VOQWxDWmhsVU9MRzFzSTBING4vdXFMTkRyTmQrZzlvTFFQ?=
 =?utf-8?B?K1Z5dFJIVnZ4b1FaUGdpQmxrWnpuUXFkUzJqSVBLY3Q0VSs1MXRlYnNQd1RW?=
 =?utf-8?B?ZlNJbW1tWGdEZ20wVEdjdVIzK0tOQ2NUNDJvVCtjbng1aEVrWjBIcHJQLzN3?=
 =?utf-8?B?d2VyRWM1QlRBSW56Qll2eTRWSUk5RCtCZWJPMXFBN1ZybXMyZ21IZVA3WnlM?=
 =?utf-8?B?THRsb01HdWx3Y0RySUo1enRzdWZSODgwNThvYnV2akRxYTFMTW5iOXd4L29Q?=
 =?utf-8?B?R3pBQmI2dHg0aGsrc0NzaEVwZVlNNHRRS1JvZ2UwNlVTTE50c2FzMDlMNDY0?=
 =?utf-8?B?L3cvSVRvcnBKVDBNQ2UrajFvcDVZeDR6ZTNzRTRFenhJWkpwN09jcUROWjEy?=
 =?utf-8?B?dVRJeHgxTjg0eGZ1bVZHcDA3ZUhwaExPZlJxazk4Q2RiYWxjTnh0QmVTVWlK?=
 =?utf-8?B?dUFOSk9pNkJGcjhTNXlsZFVla2Jpdk9oanN5b2xnR24yNGsyY09tZDlOT05N?=
 =?utf-8?B?dEZPNnQwcWJXZzlKcFdJaHhPY0VWZG1HTXRLdlJlQW5LaXN1OE0xTnJpUk5Z?=
 =?utf-8?B?K1poQml6TnhvUWNoSmdQSFhNaDE2a0pWRHBlcXNlZnp0K1oxL0tNemJybGxm?=
 =?utf-8?B?ZkFoaFE1M2lobytPbWdIbUFQUnIvczU0MTcraEFRM2xmRmpRNEFPK3ZranZD?=
 =?utf-8?B?djZ3cjRtWTBnaFpuNUZhbit4Z1ZMNlVaS0JRZFNCQ1dWeG5NQjNlN3grQ1hC?=
 =?utf-8?B?aC9WekZYSTFRZGxValhsVUxVVHJqTlNHNmtNdmRqdlRMQU9pNmx6d3FvSUl3?=
 =?utf-8?B?eHBpYlRmb2s3S3M4bUF2MllXTTN0RTlkY085aTZmT3lndmJkWUFnak50c0M3?=
 =?utf-8?B?NExxQ0FPTjdRc09aMnNPNE03MmVUdWxQd2Y2TnVIb1c2K0NiWXdVeDg1SWUv?=
 =?utf-8?B?eTdEZ3dPSWYySFRQR1VwMi9MUjNwODhkYTVBUWo0RWh4NElmcGlCQW9HVUVN?=
 =?utf-8?B?MGc0NjJYS2RJa2tYdVdKcG4vekdaSEFZVzB2RU9ObzlDNEN3Y2sxZ0dBNm9x?=
 =?utf-8?B?WVAvUlhERTZLbGhmZGlTVXRZWWNSOWxQRXJjVWRWSFI5Z3NXQmhpTW9YZ0Ew?=
 =?utf-8?B?ZFlUT0tXOE9CZ0szK1c2cnhibG5EKzlSamtEQ2JGMnB2Z0liUitjbnhoS1NT?=
 =?utf-8?B?alJ3KyswbjVUc2R0VXUzMW1WeXQ5SUtsN0VtcXZ1SFRWMWc2bzVieXE4VHN4?=
 =?utf-8?B?eE15S0FRRmV3YXQ3WngwMTlSUnlXQ0ZSUEhRTDJ4VmpuOXlXMDdaN1pKQmZ1?=
 =?utf-8?B?dkRON3MwWEszTk5UTWJiMy9KbUg0amZPZU5hT2M1bitiZ1BrMFR2OEVUaWl4?=
 =?utf-8?B?amNTVFdXQnZ6ektlT1QxL1JybDcxdGkrblN4WFVGVUtCd3ZicXBzUFdDbmFq?=
 =?utf-8?B?Q292Y1RBb3FHdDEvVWpKc0FueE9XVDR2c3hRUFRFSU0yeVRQbzVSOUlkMHdr?=
 =?utf-8?B?YVhUYTRzWTJoNnBnSy9yV1pRTnVxMXowaWlvSis0VnhOSGpDK0Z4QVZKMUZX?=
 =?utf-8?B?TXFueWZ6dHFkVkpTZ05hSTFiUHNjOEg4ekdlWWNmL3hTYlhNYklRSmFGNFR1?=
 =?utf-8?B?RlpvMTV5WWNpYVlFRWNZMUtTT2FwUXIwSEV3VXYwZ05WdktsWXV4cldVbWVW?=
 =?utf-8?B?YSs5MmZ2cXJiY2hBWlJTblkwVFdIcFNJVVIvQzN1TXU4QUpxS0lZRnEvR3VR?=
 =?utf-8?B?azg2MzREWkk3TVJMWnZIRC8xSWpDTW5sTHVtQnJ3UE0rS1Y2UjNWMVhJQk5a?=
 =?utf-8?B?SlJBYU93UlVHaXBZN1AzQ00vQTg2SFJzeDBvVGk3b1BHQytNZUlPb1dLL2NL?=
 =?utf-8?B?R243dnB3YWQvblU4SDRLakhsQk83cmNIY0hBTnRYL3VsZEFMQ2d3RmQzTVR4?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 417de185-b0de-47e0-4949-08dcc7a57cb8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:07:55.6761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bp/gliuZMQelKXmPA/19EypntPFDT7Z7oLDkEbx1YltFn3nDzm5R4wVCls17M7jbjLaybWYQcWxmlZLn8LvpjnCP74qMwOtkY1u4+hA4n5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com



On 8/26/2024 8:05 PM, Jacky Chou wrote:
> The ethtool of this driver uses the phy API of ethtool
> to get the link information from PHY driver.
> Because the NC-SI is forced on 100Mbps and full duplex,
> the driver connect a fixed-link phy driver for NC-SI.
> The ethtool will get the link information from the
> fixed-link phy driver.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

