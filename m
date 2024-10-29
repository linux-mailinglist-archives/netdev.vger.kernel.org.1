Return-Path: <netdev+bounces-139976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257379B4E0C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4877F1C2105D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994F176FB0;
	Tue, 29 Oct 2024 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLxSwNSq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AB2BAF9
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215932; cv=fail; b=PFx6ag//CYzZVWkDYPOzq0OiB0y85WgPJrtg3eJrF4iIwlALhM/1x32naFETsThWlkH5FM96TQxIRtcUepfum9ldkwX7MTlnYRxwGdHyyycaZk0WTEoAvMAnvni9EqNsF/K4OvXjyKNxzloLaz7Z2qUDqafsvuTpIha11TYW2OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215932; c=relaxed/simple;
	bh=Lp42xjo5Z8CJS5fo1UDoiLMoZMZiT7SBflfHaK+9wlA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OsNsPtFqYbuaaDECNHTift0Ub6OuirlSDq86IQfJVuCjVvFVCcEzAZXa7Qgr7gJrQsoDUBDsrqZ622W5JWNybOG1yspIQukNpOesVEtikB+6cBqAQj9vi/rwuF5cA6gJL2JF3D0lSm8CB4hZddk5F0b6wi4M/n+kRWD+nKU0sHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLxSwNSq; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730215930; x=1761751930;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lp42xjo5Z8CJS5fo1UDoiLMoZMZiT7SBflfHaK+9wlA=;
  b=GLxSwNSqh4jMhnY3Jl2dqDTzXl1Zod9M4LWltqdYDx4gGDFj50op6Ra7
   HnNy2FsvpkNU6MqR0yMpHPoniTVYHATxietMLAdPqvcyrtgxHaud7NGUk
   zJnEBPVLFHAlu+VEBeYi1sVcGQhFbaordAx04CUaQn5OR+HZm6sR/xkhK
   3AZ4BG7lb8FPsunNUqPOiyuBD7lZh+L6yQ4JlemWVHDza6qMyvg0G9p92
   Oy54QsRjbIxp5rAFHus50INEqib9TfGH+ufC4ifYoZ+Lpc48t2Owvb5eI
   yclJzkuAEj5ZOl49wTfX+Y+Ga8Fr2qjCOyzBKN210wadBmvp3ma5OUffC
   Q==;
X-CSE-ConnectionGUID: crX1atzsS9i1OWUMQ1nRuw==
X-CSE-MsgGUID: BmxpRpHbS62X3uiJY68mEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="47346915"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="47346915"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:31:55 -0700
X-CSE-ConnectionGUID: 0cK3q1pNSH2nSrW/fCoZvg==
X-CSE-MsgGUID: haAYZ/O/QkivJWh/edGQPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82808613"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 08:31:55 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 08:31:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 08:31:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 08:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhWAr5lip80muQlschXeUBWYjHclfo3b+TCuLYUrbXFmlLsSEciAp14CKxgbJvh13ztQ/Up1C95I6hLh0F2DvRt816szF90jeuh+Mca9FJ+ADRNLQy7S1q9kSRZJ4B4mUgsHEIrDsGegV+6ovZwv/3oFm8U/nBpJ0WEoQkxBnudxrDsDlqdOGWxHj+QggPIPy7O4o9y68yoApMmNaL+kaDk23wU67l6P8gUf02ACHELbRETSMrdHVzWqTxO9S1C0/7lfqVWnnTmteIM+qe0oUjwRMxek4eNBuJ9PiVUonsNgOCHbE11XjZkD8OeLfLPr5nCH15GhLfSBcAM1JyGwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrExYIiT+6AZfmPjPJmQGpMV5oxr4U1Rzr0vamE/018=;
 b=t+FSSVZ7Dr7m7MSCVZuV/VQZkkeEl08+1JJIGfV5VmHCF0dUwPfjhtHK3ED3cn4+5Sg+RNDpiNZnk9tJnC95g4DzfXkYamMV/ieX+g6eIOS7biuRThh/Pr8tb1pwDQPWPBg6sbsdDCXXbBiwZ6GKwAvMWKlp6/O2NtdryVJiVOlT7xJOFX3gW4zG16YKWT3mm2AjT3vWjBNSHsrI305JS3IHDm8ALSuYSu8TToPERrybjpTiaEDZFnwnwJM8Xyp1fvVUtLSggwjI46fRAyVtcNAPCiDSq4d68sHImIoFMe4AkI7+mIE7DsbHQOJjaLhT3zdKWprlPg5lBaePdJG5tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by PH0PR11MB7445.namprd11.prod.outlook.com (2603:10b6:510:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 15:31:51 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%6]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 15:31:51 +0000
Message-ID: <b44d50d8-23a2-47d6-99f7-856539e1de69@intel.com>
Date: Tue, 29 Oct 2024 16:30:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
To: Jakub Kicinski <kuba@kernel.org>
CC: Mohsin Bashir <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
	<alexanderduyck@fb.com>, <andrew@lunn.ch>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<kernel-team@meta.com>, <sanmanpradhan@meta.com>, <sdf@fomichev.me>,
	<vadim.fedorenko@linux.dev>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
 <5a640b00-2ab2-472f-b713-1bb97ceac6ca@intel.com>
 <20241028163554.7dddff8b@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241028163554.7dddff8b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|PH0PR11MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 16521d42-881e-491a-70c3-08dcf82ecf35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWxWYVppOTJ1aWpTWW9MRVN0Z2xOcTR0QnBWVG0xTzVGTVBDMzZsbzJjaVlt?=
 =?utf-8?B?UEVoN0RhK2hjWi9PZVJGa3QzRGR0TExPR3hlQlVuS0RTVlhGclh0MkhXVVBr?=
 =?utf-8?B?Y1pMQ0JJQVZPQnVVZDBuclI4Y1BFY0ZKWEVKUnZRdzJ3UXN5dnpyOUVZbmc4?=
 =?utf-8?B?czdTcFQrdk5UYi9hWEd1b2lNN0N2L2l3MTRBMFl1NVZ5UEJRcUJOTUxDY3hj?=
 =?utf-8?B?Yk9qL0RYZE5pTHB4UXgzbUtBYzM4QTZaYkZWYjFVVzVSWDFqdFhTWkNFTGtO?=
 =?utf-8?B?aHArT0pZdmovOG95L0w2VVMwSDVWeGg2WCtQdlNCMldqSkR3K2QrY0t1Lzdx?=
 =?utf-8?B?aER6RDRXQUhnKzFWVzdOeGZxdkpqelExNjJiQkR6RWdJUjdjdlRWeCtaNEx2?=
 =?utf-8?B?eVFQM0Q4SG51UGVRckhrWEI4cUxsWWhUUDhCMmhZM1BGcmY0OXdpQkVucWMw?=
 =?utf-8?B?SUhVSStIaVNXYWtjMlAya05UR2RmbzdhN0lLSmFISmY2YWpqdUZXUU04NkV2?=
 =?utf-8?B?YkVSWUpkd2o4ZVNhdG5hVEI1YXdJa0xzb3lVNXVpTzFjZmdvMWlaN0ZCYlYv?=
 =?utf-8?B?aTlPaFZaaTQ4TnVxSmhrTHFKMkxDbjgzTlQvTVUydnJvTmZ2c0lGYXl6eGtP?=
 =?utf-8?B?cVVrMk8vNHdmU2NZcFFDREVGS3NIcGFIVzZrYktwSVlGbHhSaXlaeExGamkx?=
 =?utf-8?B?ckl2a0ZKbGhod3pUSnRuVFN3a3MvSkdPd2srakwvU2FyV0t1c0dpZ1NVZU85?=
 =?utf-8?B?YTdxa1djdklpcjFOc09QT0FpRzlPUk5iZFVHZEFIU2ZMTzRrbGdlYXlwYTZY?=
 =?utf-8?B?VEg2dXZicG1HOUlsZjBUZ3FiUkpja3hSdzVWVUl6SVpObHgxekJSTloraElm?=
 =?utf-8?B?Z3NBYXplcGRieFFNS0h0ckxGcDBQanArMG1kQlJKby8wMTQrYWs2MW53a0NL?=
 =?utf-8?B?cVBXRThnWFJpNytFQWdvQyttS3ZiblAxSXpsK3dNWWZ0V0hLT2FHMk8yQzk2?=
 =?utf-8?B?N0tObEFTR0RBNmpuMEh3NVJ3T3FlRDB5MzQxeDdCQmlmTzJzMlhaMml4T1M3?=
 =?utf-8?B?MHNQUmpKZlV1VDJSQWtOWllCN2xqZTc2bzhaa3dvTmVrR2o1OWJNWUM1YlJZ?=
 =?utf-8?B?K0prYkpacE5CTXhUa3hCQkxBbWdneGpvM20rOUcrZUNyV21ua2VFaks1cWZJ?=
 =?utf-8?B?bnc1UXJWZVdZM0h5R3Z6UmE3MVNYTCtoM1JkTFl6NjFPR2loenZRN2VSRzUw?=
 =?utf-8?B?b05WK1c3QXJMb2ZENm5zR0MwbWhDcmxReG9XUFJZZUJEOGMzNXpVdFRhMXFi?=
 =?utf-8?B?RWRtUzFubTZrRGkzQmRjM3JFeVF4akkzcWsrdGtnemhXTmhXZGEwVUtNY1BU?=
 =?utf-8?B?VTZ6ZU4vdkJUOHJUZTVDQmYwUmovdHBKeUxTSmNnZlhBcFd6eU8vZk1uZmNh?=
 =?utf-8?B?WlR0alBTRGNQOExlNkNoVnQ0eFlEbUF6emwxRUZ3WGtvc2xxQTRLTUJFcjNr?=
 =?utf-8?B?QzlZKy95UW9iOGpWcmZ5YVpudkU5NHM2amp1UlNWaVJIUW9qY1YwbmpBYjVY?=
 =?utf-8?B?VnFCRXdja3BSQUJja1lSVm9tQnBoVlNvR3lsQndURi9HaHA5dklDSWVKenU0?=
 =?utf-8?B?M3dJVXFIK0RieE0rYTFVZ2R4SWFwcUYwaWlLSXpYejhINVBIU2hOd3FRbzhh?=
 =?utf-8?B?bm1Od3Z4ZzNNWjVkc0ZZbmhGWklaUE5aT0Yyd3FkbHNaMEtkSUJwYXlTT1BR?=
 =?utf-8?Q?jroKjrsm336u/bHmBnkYig8RrajlvKmts1YqoIb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b254THJFSWVmamw1MjNWSEJQOEVKdDIvZEp2OFVreGNKZGVseWM0NmtXV3Fr?=
 =?utf-8?B?am9xRFRSNzNKWWN0S1Q0RFhPR2xHcDFUQUxEaUJUR2VvMm52WXREVXIzOThG?=
 =?utf-8?B?Q0d4NjdiR1dSL0ozZ3N3VHNLY2xscWRXTnJYOVl2L1ZaZVQ3MDFGbWIrd2M4?=
 =?utf-8?B?V3ExV0VNSnhVQjZPd2lMakU2OWVoTHY4M25DR3ZaWG1ZR01BcVNleVFQSUda?=
 =?utf-8?B?c24wZkJJdmM5bkFZeHdpS1UxU3RXTjNWVGdSWVpvUGY4Vys3eit4TURvMk9Y?=
 =?utf-8?B?cDVYUmdmTXVZTHA5eU5sYU0xTmVvSlNBZWNSNGpNbmNOL2VJOVFnakFzLytr?=
 =?utf-8?B?MkluN1VDYkZpZTc1ZTY0WGlnSmNFUDU0TWhZQ1l0b210ZUZpSElsOWFFZFhS?=
 =?utf-8?B?R1hZNlRLSTVQaHN5bzE3cTkvNUJUUkFncDNITmo2SDBwTDhwQXNKNlhWbk4v?=
 =?utf-8?B?elpEV2xDTlFrRS9kNWVTMzdQdUZwNWlubC9RMXhGV0J3RGplSHN2Z0ZlZ0VL?=
 =?utf-8?B?Mmhra3FieU5jdUVhR2QxUnRSeUJEQm5aVzNxWndFQzVia0NSZUp2d0NxMG12?=
 =?utf-8?B?QXRGS1U2L1liMTNRTkFBaHRxTCt1b1hWMW1zak10dHBqNW1vcHNqdStONEkx?=
 =?utf-8?B?TGZtbHlJVXlPRzdWbVJoZEVRdFdCZXRHSFpOYytiUlBxQVNPbnV2NXVOdkdF?=
 =?utf-8?B?bDl0bEgzVXJCTkJ5cSs1RllCTFY4bVZDS2ZQRkdOaExXdXJUeDZXK0xIUXd0?=
 =?utf-8?B?L0hLRExWT05LY3RUb1FRYXZuM2ZuSzROVWRDcnA2UFdGSGVuNUZNVmd4ajVO?=
 =?utf-8?B?eVpMeitHVXI5RGxqNWcxVWE0MG9Hc2FFNzdVWjcvVDdSYTlRelJWdDhhamR5?=
 =?utf-8?B?WEJ2V0Z1c0xsb1hTTkZrVElGMjFrRTZUOXVVcmpuT0xnWm1GR2ZxcFByUDFl?=
 =?utf-8?B?VFdhbWVucHhaWWR2MnYxZy9KUE5jeU5nVzgyTnRZeHRwM2k5MkRyNFZQellQ?=
 =?utf-8?B?WWt3SStwdFFTL0EwVENXdXlXWldmZjNTQXpJRmhiYjcvTW4xcjM0ZllsbzVT?=
 =?utf-8?B?bGFTTWJ5SFhkNW0zbkhsM0JFU3pFbmlrZTMvcW9odUZXOVVTcDNIMyt1b0tY?=
 =?utf-8?B?enJHbEVoWFJiQ05VdXdPT3p0U2lXbHllZGpVaytUcFdVdEh3UTBkVzZMOEhv?=
 =?utf-8?B?cyt2WmRYaTJ5ek9lNElCREpwOEFPdlBWQ1RUSDFGSmRvN296M3VwcUZqUnY3?=
 =?utf-8?B?K2E5VGdjSVNJbG1YK1FXQis2WDNWLy96djdJUlNWWXNTdERoVldkSHRteldi?=
 =?utf-8?B?dHZhTFdBOVh0VlUyaWpDY05hZFkrdnVTcWV0NnlhY1NWNGR6Z08vRDJQcUhN?=
 =?utf-8?B?N0VzaW9NNC9YYXFKYll3WW0wVmtVU3RRdWRZTCtMQ054TlJOcTEwMFRvN3Zi?=
 =?utf-8?B?RURLTWNrMVFrdy94a2Z0amxiLytEK3pRVFVyenNSRk1ySzQ1c3l6dE50d0t4?=
 =?utf-8?B?Q3o1TXZZNUJhMk0zQnB5RHhDS1M0MUdyM2NKV0R4KzQ2U3d4SHVYL1JQODBa?=
 =?utf-8?B?NUlvZGk1anZDWFlFM3JCNmM5eXozQXlGU1NrNkQ2RHIrWkVHNW1XM0J6cVha?=
 =?utf-8?B?WHdWaktwc2xzUTB6U2k4TWJQSkZWdnJsN3VtY0F6N29TdC94VG4wZzBQMzJU?=
 =?utf-8?B?dnB0VTlZR1ZGNk9oL3d5S1Z5Uk9kUkw1MllNTFFmUVdjOGNOQ1pLR2xiSDZx?=
 =?utf-8?B?dUgwcVVjTEk4a01BWHRDbUxodC9WY0xrMXVhVStienVUdnF4aU01K094UTQw?=
 =?utf-8?B?TUEyWGltYUlPSjJTZk1acytPRXJqMDcvbmE4R3Q4QmVCelZhalY1SDR2SWF0?=
 =?utf-8?B?Y0xLMnNGK0pkbGVmakV3d3hSTkM4VEhjeFp4a2ZDL1Z2MnM3ZGFlb3pKQTZN?=
 =?utf-8?B?YXB0WkswWmJId3VlU1hQMlJIcnFjTEY0VFBGWlFLU3ErYit5Q012c20rcStO?=
 =?utf-8?B?cWswWkF5K2ZQc0dTMEE2WnhUbEMxNCtmSnplcVRzbDgwUUNwSmxBUTl6UXE4?=
 =?utf-8?B?T0lmYzZTeCtTdURCeFhXcHFuczZrNFJhd2lvcC9YeVZzWlBZc2lDSSs0Yzdr?=
 =?utf-8?B?dEUwVDdLZkU5K1kvaFIyaW5VUXZWTFp0WEhMckthdWxmTEhwLy9VUkl3NEhR?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16521d42-881e-491a-70c3-08dcf82ecf35
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:31:51.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D3KzGBvbDdXnNtZKXea2kMOgLB+bkUhGiREDXhd/uH3LHCg+xUN/cc9Bg3y1/NLf5dIcTValMcyPFBsegy1CLmtyyYNSzMgCljPK+o83r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7445
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 28 Oct 2024 16:35:54 -0700

> On Fri, 25 Oct 2024 17:19:03 +0200 Alexander Lobakin wrote:
>>> +static void fbnic_clear_tce_tcam_entry(struct fbnic_dev *fbd, unsigned int idx)
>>> +{
>>> +	int i;
>>> +
>>> +	/* Invalidate entry and clear addr state info */
>>> +	for (i = 0; i <= FBNIC_TCE_TCAM_WORD_LEN; i++)  
>>
>> Please declare loop iterators right in loop declarations, we're GNU11
>> for a couple years already.
>>
>> 	for (u32 i = 0; ...
> 
> Why?

Because we usually declare variables only inside the scopes within which
they're used, IOW

	for (...) {
		void *data;

		data = ...
	}

is preferred over

	void *data;

	for (...) {
		data = ...
	}

Here it's the same. `for (int` reduces the scope of the iterator.
The iter is not used outside the loop.

>
> Please avoid giving people subjective stylistic feedback, especially

I didn't say "You must do X" anywhere, only proposed some stuff, which
from my PoV would improve the code.
And make the style more consistent. "Avoiding giving people subjective
stylistic feedback" led to that it's not really consistent beyond the
level of checkpatch's complaints.

> when none of the maintainers have given such feedback in the past.

I don't think my mission as a reviewer is to be a parrot?

> 
>> (+ don't use signed when it can't be < 0)
> 
> Again, why. int is the most basic type in C, why is using a fixed side
> kernel type necessary here?

Because the negative part is not used at all here. Why not __u128 or
double then if it doesn't matter?

Thanks,
Olek

