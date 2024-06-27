Return-Path: <netdev+bounces-107148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E010891A1C6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2F1C20923
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751BA80031;
	Thu, 27 Jun 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hr6WHAkp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148D7C097
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477644; cv=fail; b=d4Kcd8/vGbEHtu3cud8nKli/i2yyMymwUPMSI2CiOyG62neiwCIVeS90ZabYAgmMbT5TnJCQ5InngWAzs4gJOrxaIzKsSjyxvA0tUzFYnLxge8fSwyn6uLrYEf5itiJiS9n4OO7Ggi4i8Ha91zaHgYnOrgur0eDClbg1F8rAvMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477644; c=relaxed/simple;
	bh=ZCYVRhWJeyrnGw8d9G562YHDsVtZLgc2fp45tokjDVI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u+HJ+wSmsDajoEi71QsLPL4SjbKwuK3FxOyL0oBF/IxBraMPGJThEk/vYmcBd0Wy6H9OIs5fd6yyOS/sXlbkRKlvceaISpBd+2o24MuSk2isI88y4iT48gu6SdXctS12OiaSCMq7KSTGFnFpwpS5GEELNyp/KlQArJ9sCtLnVUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hr6WHAkp; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719477642; x=1751013642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZCYVRhWJeyrnGw8d9G562YHDsVtZLgc2fp45tokjDVI=;
  b=hr6WHAkp0ZiQWcPJwLNp1SS/mUQwtDKLiB/zlZw13YhRJQNxwiT4pLAJ
   Yo9oFzZsGa1en5E4H/TIQVVDTBEYagjx+c6B2RrS3D0ooUrSV+6YW1Uxo
   lNCuWpeEXhQ2CAwmMONQ0p88fqjAajNQl29T5A/xSmKlr8x8joAIOWBh7
   UC3+L/KbdxebkhGkfTGvRbb+Z34RtTYGpPdQi+MA2+EqBUi5H83jh6nfU
   zKnFbNe9sWYt214te/RMQsbCwFVuYrKnQ5LFVzpv+OBPJIHuXt9vuP33X
   mtIOUWSqBsl2x6APt/b46PSWn85BOllx4xRdi/xYBtXdjRzK88UUYfLZs
   g==;
X-CSE-ConnectionGUID: 14R5BT+wQX26N9xKiF/dgQ==
X-CSE-MsgGUID: ZmZgljJsRHqtfY5St1BbkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="34125386"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="34125386"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 01:40:41 -0700
X-CSE-ConnectionGUID: bjjk28jLQ0WjuRMmWM9RUg==
X-CSE-MsgGUID: Emr89IuQS+6wnKTj8aiN7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44427710"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 01:40:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 01:40:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 01:40:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 01:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/Uu+yn1nbdid/sKWq5WckVSgDavACQZAGkjwqmt1S9GlAkEvAe/yY8mIyNEhPWsBGYJ0+SND8r/VC0LTHln2z4GBzgwoh5n6s7ywtOIAxQsiI6q20t2Ts8WxEZJxmrSDncMB4GWOMfZh5hmr4WtbjKuYNrCxHYTBkq1IxCnGZzj1cWOGIQEVNudl3o8lfco0F3mkWJPIwAl70UGL+c5j4LjT6aY12c5+PHidpuHT2IjwAzJm7oidDPqwKu5UfVKHIumvXNiRqRrooEEeYr2AnrP+KWO2zJJ8gj5N3l1INyVFNjkKdnfQysnv9MAm9LsNnKfnpsiIBoE+5mDerDkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2aImgv1efxXZ0WDmf/lfjPcJFbsf2v9evFlqB8brgo=;
 b=fUqLSIK2DxsrgAjUX0vy1zPOvURod8c8Twze0Ho1Ig6LDCqom4Xrd0BDY+iE7vMKKxeqbb9vNE6iCSLXKNWDsKNOqMT4HUxAfgoPG4TQXIFi5aOQea9cD/cothUwaAMmmWP7iwwiuREOi5B2lUwbt848vO8PwB642TXoH6mTad7sZ/7xqadfQssMDJpoKgnF7X8/9ccbBf9hKCDLljJ4Ks+962BgnE2cjFjHUkfKYwn018jA24x4WFGdyoZRtmcsbuYI2HCycxTH9T4Fj/i2HLqvuDfZtupbs6yn8Kuf6v5dZaZaxAwXXUOK5YbhaTwkjDV9uZVjs4zWHG/Tu9acDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB7873.namprd11.prod.outlook.com (2603:10b6:930:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 08:40:38 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 08:40:38 +0000
Message-ID: <49fcfb78-32ac-49de-8e83-2e12bc04fff2@intel.com>
Date: Thu, 27 Jun 2024 10:40:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <leitao@debian.org>, <petrm@nvidia.com>,
	<davem@davemloft.net>
References: <20240626013611.2330979-1-kuba@kernel.org>
 <20240626013611.2330979-2-kuba@kernel.org>
 <d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com>
 <20240626094932.1495471b@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240626094932.1495471b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:803:1::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6191b933-fd5d-4311-100f-08dc9684d22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTRXWUFBMUc5RGd5V1BVenpzR3pha3VPamlrd2VFeHVtOUZwRzlWZGROa0FF?=
 =?utf-8?B?dUJkbzNIVmxyd0NSeDBTQUNyWmtqeHRLbmtCWEJWR2ZCSmQyaHlBSm5WbGUv?=
 =?utf-8?B?KzVMZWYzdEhzRWE5TllBN2FqQTNOZDk0a2hIc21BRXdEWmVocjdSWGRyUUpM?=
 =?utf-8?B?Ung2TXZvQjBHQmoxTTgvcjByL0xQYWkyUDBVSkhmOXNUMklnMDAzNmtLZ1NV?=
 =?utf-8?B?a3k2d0UzeXJaS1RDOEVJRzBFOUZ2bmJtYkFpd2xxOFZoSE9IaHVkcGRYTUJz?=
 =?utf-8?B?V3RJNG1FdXFRRndiRFVBZjFGMXd6a0NzN3pIS1BScTA5TG9ybUlwMXpsbnVr?=
 =?utf-8?B?NGswdWtPYyswM2YwY2d0enRsTWdiK01NQXV1QjN5V3I0QnJJaHc1eDJoOEtF?=
 =?utf-8?B?bEV2Q2RLa1lLb0hHREJiSDUvb01DVEVVdTZpSERRamJhZGpxRExoZEs0MFdS?=
 =?utf-8?B?RnhwSUFaL0NqWkJGRlVJZ0Fwcncrb0JmaDVyeTk0WXZSYmZ3NHM1VWxrUEdw?=
 =?utf-8?B?M0tTdlpjdVJNdTViRUoxL0QxcVZueGdPbVl5ZUx1cjJPNGVXT0YrTmxPR2wx?=
 =?utf-8?B?R3JwNG1jc290d00vTU5YTUNGN1Qrb0dEMklteXdvQnJ6cTRrSkIvK1JiUGFp?=
 =?utf-8?B?WVRra1NkdWV6d0YzMEpvSmc4M3RJZnhEcjRPK2ljNTBiQzZ4WkVwNUVDV0JE?=
 =?utf-8?B?NlFwQ2Y1ZDYvcnM2TDBSK1d2NXdielNlZjhlTm5BZjVwZDRNNjMxTS9QODZW?=
 =?utf-8?B?ejkwZ3lJbmhhcUZSNktZM2NCQUdnNkgzSjlBY1Q1NnZheVhYSFgvMWlMcHFn?=
 =?utf-8?B?Tkp1cXord3ExZEIrL013NHF1L2oza3BLVmRSMDNwUFZsZ0g1K0pFZzhCNzJo?=
 =?utf-8?B?bThTeUl2bkVTWTZxMjJKTWMzQmc4RkxxcXU3TGlFN2w5dldaUmRGT2p5QmZD?=
 =?utf-8?B?bWxTRTIvSnlGR215eWxUdElZUTdMbUcyN1o3OGFhcDRjNlNkSUJjazQ0b0x4?=
 =?utf-8?B?S3l3ZjIxY252V1B3QXEzS0FBS0tCZWx0T3d6REVQQ2NneWZmYmtqUnFJNy85?=
 =?utf-8?B?QUdXUnNBTlVmYkZLdU4rQ2I4VTNjNC9OWDlCNHJQNHFDc1NDUW1mZWJPVlkw?=
 =?utf-8?B?SmVOdEYxRHZ3Y0JlMDVtd0Q0aTdYRFM1bjQxdGxudlYrWk9TUm0rUUQxWjEx?=
 =?utf-8?B?NEd1OXI1amNkMGlnVTJDTXJ2dTlQZEE1Z213N2VsMDNoZ0J6Z0wxVkljaVBw?=
 =?utf-8?B?cC92RERVb0lvdythM09JTm9Ed2xsdkZOWWRuTzhoV09aeDRQd1lOdzlYVUdq?=
 =?utf-8?B?MW4yaTEwa1lMcU9rSUtNd1kzbGZHQWRucU1jS3V3MTJLRzRnaEVWaVlCbVBD?=
 =?utf-8?B?WjRDcGRyblJYQ2p0Nlg4c2pVMVM5aFpJaU11YVJmYmVMbHJudHZyOVhzSjR0?=
 =?utf-8?B?bU9ycTR1U2dxMkpRc0tmVHk3NnMzd200YjhDRTU2V0pFV2RIYUE3cE1KaTFT?=
 =?utf-8?B?Um1LVllBOE5jZzZnT3AyQitoWGR4ZWpva1dvVWJpc1lveGxtQk9jTXFGYUEx?=
 =?utf-8?B?VSsySUpwV2IwTHBrUm9rQkNqUUpEc3BSZHNCM1drdnlKaHB5czFQaEtFMEp1?=
 =?utf-8?B?VmlZVmZBSCs2a1M4WkY2ZEZ3VlhPWnNCVXp6WFk5Vyt3YVh5TEo4UzJmbnlE?=
 =?utf-8?B?dFYrczFHTjRMUDhPQjdxZXRJWG1xQmJLVjB0YmNSclptTk00Mm5JT0lMbnBX?=
 =?utf-8?B?ektVK1dUR0xsNVl4MENXTGg2MThub3I1Wk42RldGeDUvbTl0TG1ubDMrdk12?=
 =?utf-8?B?VUUrZkx1VEZIV3VoOUZBUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJQVTgzRFBJTVNZdE96NTNlZmlvVHE3eE5ubllUVXhnVkJaUnRmVS9KVms4?=
 =?utf-8?B?dU5uVGxuL25DWkxQdDZIZDVmRVlJNDlXdHoyOEFHRHdVSTR5UE5xa2VNQWlv?=
 =?utf-8?B?RExzMHc2N2lJbUZ2RXZRNnhPSlM5TUozVFN4OTVRTUVYb1pzSTdxNzQzL0Vi?=
 =?utf-8?B?RG1teFAzREM1RU1TZEc2NFIzQnhQMFQyTUZMb21sNGJ6a1pzTCtSL3FydVV6?=
 =?utf-8?B?OVFxL3lPYnhOS0krV2thL3ZRdzh0bDMyUkNwK0dhKy92RmFvVjJuS01qTG5v?=
 =?utf-8?B?Nk53SGRkd0tpL25lc0VOOGFYdi8wdW9wbUo3NzEvUUxwalY2NjhDSWlUTUh3?=
 =?utf-8?B?cWRSVFZieVNmbGZFSmE2bzJwTVlWL0g0UnMxNHcrbUVCWGlqMGFVb002QkYr?=
 =?utf-8?B?MGt6aDJpc1dQMGczaEZSc09RZGsyZHNSaFRKbTBGUlBNK1JUanBUUmZCbVg3?=
 =?utf-8?B?b2x4TkFTdG5FSkhUaExTS3BZM053YkttWVR2RjQ5Q3VEOUxNWG51QnNodTBZ?=
 =?utf-8?B?NG1BSE4vREJLY0NXSkl6bTNQSGJBWkdLMy9aMDcwWi9zOGFwRmhoaTk4Rzhr?=
 =?utf-8?B?VW1iYktDc1BLWE1uQlNScjBsTkNDdkZyZEVUdlNuM3NnOWE4bXBERzVKK3Nl?=
 =?utf-8?B?ZmlDM3RlQUlDQUU0SG5iZTJZeWdWYmdKNUtFSG5yVFZyNEZEK0xZMFIySm84?=
 =?utf-8?B?NEsxQzlXNm8xVkhqdmFQZ1FhMnloMVpwRnVMV25URnpVbmJ4NjFMR296WVdU?=
 =?utf-8?B?cjhtS2Z4dVczN1JwckZSZXFDbm5HOVY2b3IzM3lmSzVhQWlhZ1N1Q1lwSHlF?=
 =?utf-8?B?WDl3NGxRZktGUGRYQWUwbnhIejdtQi9rTnQ2VUk4VldDcTZEdDd6YjJJTFRz?=
 =?utf-8?B?YmVRSkt5aWFSeDZkYm8wWGFZSGRGc3hvT1lRZHhNM3NVTlBVVFdzM3FjZVpY?=
 =?utf-8?B?TWE4NWQ2WFZSbDBPVTVraHpzWHcvc1JGYVUrWmNUUFBDVlFyOXVQYVMrV2th?=
 =?utf-8?B?a2NkK3VpeHFweDF0TGNMUkpZVUIxMTZpTmdxcktpQTJlS2xlQ2xCRjZpZ05x?=
 =?utf-8?B?TEpBaFlvV042Z2FqR2NGV0xQRUttd0YvNFA5dVJTdEQxNUJ2c0JtSE1MRFRR?=
 =?utf-8?B?c0pZQ0RITUhjMHVFVHRIQkRPWEZIYVBvUlJSNHFTZEJsZ1V1bThsZlFuNjY1?=
 =?utf-8?B?cDM5OVkzMTU5Ym5hekVoeG1ZekVzRmI4b3JrNGUwQ0MvYkV6RVVROHdIdElo?=
 =?utf-8?B?RFdsMXdGMTZkMWZjNEd4OE1RdkpUcWFGMy9ra0ZoZkQ4QUZ5VHdzak9HMVVD?=
 =?utf-8?B?SjJnaGh1NXd3anhTTnIzZ2RML3M0L1doRHZuZkRYdWIzOUpFcVlneWVnUVBw?=
 =?utf-8?B?b094MFJyL25KREVja1ZFMjdrTUZOZ0t0NnZDL3JZTzFuUG9tWjgvWnZ6MXFT?=
 =?utf-8?B?ZTZWUk1VVCtrbDkrS0xxVVRHNmJQOUUrbUhqRWw5WjlPV216QVdZd0VTQUpC?=
 =?utf-8?B?NTRxZVozNG5LYWc1bFdkazJGN212bXhUVWNRNlh4dGtPYW5NQ3hmVU9QTWZr?=
 =?utf-8?B?SE81R2UrS3UzSGh0WnNDMitPZytzczJtWTFMcmFiSGd1ZFdpVllnd0lwOE5M?=
 =?utf-8?B?Sk5CYk9ackdIbGV5YVhpZ2xMb2lqRGRKb1pNYTdaQ0tDVmpnN1Fxc1lNM2pZ?=
 =?utf-8?B?MW5iQXdSSHFmNmtLYStkOWZYbG1mOEptdlRxSndvSmhWbVJMakVBMjRQSzVp?=
 =?utf-8?B?R3BTdWJXQUh2Mmxqd3RBbTVEaXhPZmVvNmF0K1VRblNFektGNk1qUnlJek5L?=
 =?utf-8?B?MHlVT3V3KzhIdE1pVThBSVZvZzl3a2Nac0RNOWZSQy9WM0ExQ2VPbC9CeVk0?=
 =?utf-8?B?M2NoSHYzRzZwVE5kMDV5V29tNnp4Q0hLVWU0cE5Ua01yMU03cWxjaFUzYk5i?=
 =?utf-8?B?MFcyL2NNQ3dROFNqZTMxQTI5UTZHUDA4NFAwM21ta05ER2tKVEtTc3RYQlpz?=
 =?utf-8?B?dFdIaFJERFRnTXZpUzZ4Wm9BOXJTNjdOVGNGTVRjYSt6WjJIZjZJTndoVkVO?=
 =?utf-8?B?MFBGY3NQQ3N5Y3p3QTU0QXlRYmw0VDluYVVWT2ZNSENoUFRFYjVWSWdzUm5L?=
 =?utf-8?B?WUc3UTQ0TjhXZzVtZm90TTJPZmk2VDluZ05aSkw0VEEvVWRnOUljT2UyNFd1?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6191b933-fd5d-4311-100f-08dc9684d22e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 08:40:38.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsy63roNOIRXeW2ATZPlnuA+XvoziD+7psRhgD/x9/R/m7MV0apxXmD1QarDImnVfS8vxiwxqnge2K0ICMl9p5t8VeHKEcQeT047mju9rv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7873
X-OriginatorOrg: intel.com

On 6/26/24 18:49, Jakub Kicinski wrote:
> On Wed, 26 Jun 2024 09:43:54 +0200 Przemek Kitszel wrote:
>>> As a nice safety all exceptions from defer()ed calls are captured,
>>> printed, and ignored (they do make the test fail, however).
>>> This addresses the common problem of exceptions in cleanup paths
>>> often being unhandled, leading to potential leaks.
>>
>> Nice! Please only make it so that cleanup-failure does not overwrite
>> happy-test-path-failure (IOW "ret = ret ? ret : cleanup_ret")
> 
> That should be what we end up doing. The ret is a boolean (pass / fail)
> so we have:
> 
> 	pass &= cleanup_pass
> 
> effectively.
> 
>>> +            ksft_pr("Exception while handling defer / cleanup!")
>>
>> please print current queue size, if only for convenience of test
>> developer to be able tell if they are moving forward in
>> fix-rerun-observe cycle
> 
> Hm... not a bad point, defer() cycles are possible.
> But then again, we don't guard against infinite loops
> in  tests either, and kselftest runner (the general one,
> outside our Python) has a timeout, so it will kill the script.

I mean the flow:
$EDITOR mytest.py
./mytest.py
# output: Exception while handling defer / cleanup (at 4 out of 13 cleanups)

then repeat with the hope that fix to cleanup procedure will move us
forward, say:
$EDITOR mytest.py; ./mytest.py
#output: ... (at 7 of 13 cleanups)

just name of failed cleanup method is not enough as those could be
added via loop

> 
>>> +            tb = traceback.format_exc()
>>> +            for line in tb.strip().split('\n'):
>>> +                ksft_pr("Defer Exception|", line)
>>> +            KSFT_RESULT = False
>>
>> I have no idea if this could be other error than just False, if so,
>> don't overwrite
> 
> Yup, just True / False. The other types (skip, xfail) are a pass
> (True) plus a comment, per KTAP spec.
> 


Thanks!

