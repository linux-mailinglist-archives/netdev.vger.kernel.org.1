Return-Path: <netdev+bounces-101146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB68FD7A8
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D16286562
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4F715F32D;
	Wed,  5 Jun 2024 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOQDDFPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93A15ECC4
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619923; cv=fail; b=uLwnL/QUbIYVpATN2CEV6QXlqvx6fY9kce5VeIieHIpT7W5hHgwPEuP6yJaDGdk1cUOpiJ4Hu3dCVeYk+OysDZNHfKr07oDS/WUO4fXgCx8Xi+BJeo+4z6o1+5cZettEEWgUz7vmVPfKvLMGyYRrAilAHWjQdEyYMu3QWaZlcVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619923; c=relaxed/simple;
	bh=qZRMJtFuePxbx3O59nbKd4F7QrkbKwmmAz3cYu5y0RE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDMmviwl/4S2TVO5jMvibrxRNLdOIaMfbNdIb5nm9PW3aJHGAxCTy1r8iCL3hqoX5/LfkFc5cIegrwWxK3lpAFoaUTB6ewfd7+V74JOPdMTJnA3RtcljBhcFFDDDoQJR6HpjpSA7/uQOcBJ2K+FYpg3FnYLgy9RXhXsxX7ph4Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOQDDFPQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717619922; x=1749155922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qZRMJtFuePxbx3O59nbKd4F7QrkbKwmmAz3cYu5y0RE=;
  b=lOQDDFPQUFyEL+3Ve75fRddDoC1VtQ1Gcsv/VGoTb+ANYrLIsK31xXbJ
   n9WWjJwQEoavOKF0blSbUIaKLA8UZVUCeKOLowrR8xvjUilnRD8zTne7r
   OkRwYEZfHvTAQHXMdeDGs6iyIlzVcueka1lI0Y8oEO8Df11PbHzN+zECR
   FU6vJKCinl516V+MENHhOsiAoyGo1MPVrFQ7101w3cLB+ky+aLJtkwmFa
   iWDCwqSd62u0dOaiegN9DeLSRSDGK8ZDiwqqEsKgJIH+ic4hFPYQVNu/O
   w4VkcA3DBn0bPIk9NZLDi1DEhhrffaTy94xS2mh/OzEYIwpWK1O6T5tvf
   w==;
X-CSE-ConnectionGUID: /Iz3FeMZQpaDS3Oi73PGMw==
X-CSE-MsgGUID: iLIp/70tT1yNBwHEgJZXNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="17191692"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="17191692"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:38:41 -0700
X-CSE-ConnectionGUID: iCs8UuVgRUGwqOpxlPu+cg==
X-CSE-MsgGUID: 3VOmxmI9QWe8uErNgwkD2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="75190241"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 13:38:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:38:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:38:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 13:38:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 13:38:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLCcDQMeUvKiwntgHFZpnWuIX9ItgxWl1HgoIYhCQLDhasi+PYJuFCsnydiqw+spnN6hYDIEMD+74zo/eQGJQ6siK4oUOkxdY778XB4wTHwkUr+LytmCh7asAxP7CNtqpfU9vfPtNDcKVN8IQasz0NZDWH0T9xc6oMFk9g/gr8XzOcQ8zNg4WeN5Z/aEQSvMdLIMaY99j+nUYxdrlxbYHtaNyT+URUMbG+wd8qjxwjpeQNTkVfWjT+ytoedfgkvB00pV0mhaJYtkxmy5GR0YxoggUyk0fsrx26HDg+lDph8LqoqyKkat7lf6zWr6gkLVLmxLY+nEJpJmjtnAxrFA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEUVFL96mInH8EcRQOIgTG1+x/qaeYDvidXiAidGIs8=;
 b=j7USdkwP5gUm+pr+Nap70sK0Gosdz0g1PK4XTbdHmPKI3490KKKa1iGF0d0107mF3ITb5txV9/Carg0pF41GOTk1TwtpfM6fZYZUPX+m0ro9LUTzNto0ezheBea0l+BDjV3YQ9VbVgClkPF5VEpI6Wv8qaThfleNeBO9dGLHWT6loM0CAqfw+6/ipwy6eT6JgUDqtWCLZXwE2yak0nVcyZKlh4Rcqm8cP+85ZmGveOrTL7RSxCSzHZPNCEOWlMXoZkotVz9hjYpKKIDUPuqdZGgT/zKwNXtmdc6uFP/hPlAjDxo3L+T1zFL1P4gbdpb08dl/DV3QbI78efZjx56Gog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY5PR11MB6210.namprd11.prod.outlook.com (2603:10b6:930:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 20:38:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:38:36 +0000
Message-ID: <735233d0-b462-4669-aaff-e7fb3213f251@intel.com>
Date: Wed, 5 Jun 2024 13:38:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Intel Wired LAN Driver Updates 2024-06-03
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Jakub
 Kicinski <kuba@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Sujai Buvaneswaran
	<sujai.buvaneswaran@intel.com>, Michal Schmidt <mschmidt@redhat.com>, "Sunil
 Goutham" <sgoutham@marvell.com>, Eric Joyner <eric.joyner@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Karen Ostrowska
	<karen.ostrowska@intel.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Menachem Fogel <menachem.fogel@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>, Jiri Pirko <jiri@resnulli.us>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY5PR11MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 78281bcd-2122-40f5-e569-08dc859f795d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFJOb1NmMURlUW4vNmEzdDZjN2pWS21yOUNQUXp0UGZjNHBVNzg0eFJmYkVE?=
 =?utf-8?B?QmpHZnBsM1RPVngraDduQ3hrcFdpYUFRQkpmVGlPcFNmNW9icUJlZDlHVWln?=
 =?utf-8?B?emlzaW5QWEVmWEJuanJ2Tlk5MGtrQzNiQU0xOWtwY05UNEJtM1Y3UkpzSFdW?=
 =?utf-8?B?cWVTVEgrWkNzaS9FTzRRbWo0R2ZnU00vc2M0YkE0QlFBc0g5ckJZeUN1UDkx?=
 =?utf-8?B?ZG9GUFFOOUo5bWJHSE1iOTd3Yjdid3NPRk1XcVVUeHJUVWZQMFFoZTBpRVQv?=
 =?utf-8?B?YldqZnl1M0JpUU8zUkJNSWptS1dGNEJwTHhPQlRBZFRqS2ptbE9paGdwdkk2?=
 =?utf-8?B?cjhwbmZEODNxRVZKcTl2bzkvb3l5eVhRNUZqWHlhVUw2RFZmbFdQWlZmdTIx?=
 =?utf-8?B?WWFpLzFMMk8vKzIvZXNuaTJHbHJscGNmL0gyN211RndIUXl6Wllnb0FHaHVL?=
 =?utf-8?B?SkM5clQ1YTJ6dC8wRk55bm5qTGRPWGRwL0JsdFAzejFaeDR6UTJZNDZFMXR5?=
 =?utf-8?B?TTE1MHRUVC9MOUZMQit6aXBpUllNYTkwSENOTGx4eHE1S3BrN09jbURmSzhY?=
 =?utf-8?B?YXZCODJmbmk5WXN5OHAwTUswc2M0WmQ0NGxvbFJmK2lyNmticlo0UWQ2VGNU?=
 =?utf-8?B?TXNadmVZaHZQUG1CRUlzWnlzYWFwNTloSVFoRHdJRXBOY2NEZDYxUnIzc2ZM?=
 =?utf-8?B?bGt0Q3dZUzB1M09jY2hhQ0w3Y0lGQmp5R3M3VGpOT2c4d1dmMXgzMk9DUzhi?=
 =?utf-8?B?OVlTVjgxWG85Mnc2bzJoREJBTkZCaEk1VjlsOTluQlBpRzlyZHc3azBDMncw?=
 =?utf-8?B?ekgwUEVTVWRMc0JFZU11SENQYW05TlpYeHI3UDc5RVloeElKVGwzWkNnVkFT?=
 =?utf-8?B?TlIxbkhsT0dScDFSeDZUT3JjUWhrRVl4ZXA1MzZUV0VXV3hnS3Z0Ym90Y045?=
 =?utf-8?B?RGNkY1dzdzZKS2V2cjlRQVhXdERmck5UM0ZoaDJlSFBpdGFUZ0VHVFYrTmR2?=
 =?utf-8?B?Umw0MVpwSzVlZGpMei9wVlZUa1UwVzZOVktsbUdaM2cyMEZDWWdsWGdYcFdS?=
 =?utf-8?B?M2VKWFNjdUJwSitkeGFPV0RONjNwVFJlS2VxNzVkN3VOekI0TWRsU0Z0OHhq?=
 =?utf-8?B?dVRVUk5scm1rcm5waThqU0VSN2s3VUxhY3JEKzFwY1VSZDI0aHhPd1llSVdH?=
 =?utf-8?B?WGZqRlVINEw1WU1HZ3pqTC9Rbk9pbSs1NUhjcFdXM1dETXBoSHkxMmFnbEx0?=
 =?utf-8?B?d2tERldDNDZnSXRXdWpmZnpvazBsTmpuVEJkVnR3TXA0MFpUYW5qVUZpNDZB?=
 =?utf-8?B?YTB6S08ydTZ3Wkh3bEFSZ3drRkpvVDhEOE5HNDVQZWZrUk9aempYMjNlN3pQ?=
 =?utf-8?B?SDIrVUpIeUtWS1lzM3pxMEVSblhETHZmbkZDTDNBdEFNSFpmRjM4L3g4ZVVD?=
 =?utf-8?B?RG1pdmRSOXZjWVk3NTU4a0I1d1lsSWtxeTI3NHZBVXNFdysrOEhQOXZyZ05I?=
 =?utf-8?B?VG5FSmwyeVBsSCthT2JPU3pJUEFqajlwN045Qm0wd1NBNXROOWlzMUN5SjN6?=
 =?utf-8?B?UlZWSW9JbjF1aTNXZmpDT3VVVUJtOHFEVlI4MzR4L0E4czlvRDR4dWdUSTR1?=
 =?utf-8?B?L1ZYcHMvbGRCdkNBdk9nQVlmZ2lUd3h6em9pTlRCeXJtZFlUMjdCekNGcEdV?=
 =?utf-8?B?OVphYkNaUkVKZ2JhS2FDdVo0a29RQnlOL2VsQnlnMWtUUHZJRllKVUFEbFgv?=
 =?utf-8?Q?BzWliNlFfEbtlnoeQtStHTE60GjDn8p1hO+FpJq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNSWUd2Vm9YUmRQS3hRUFJoODBWam10K2RPa09oTUU5VVFJYkxsUVNLYUs3?=
 =?utf-8?B?a3dPS3RYbGhUZnoyektjeDlhWGdsQktGYTVYOHFySUZRZ3JEcGtpeW44VmIz?=
 =?utf-8?B?S1RXd1ZWV251Vkl2TjJxQW85b0Z5a3JqeGxKOGZMZUhtRkxGMUlDZ05RNU81?=
 =?utf-8?B?aHNydlRjVnZTUkwrRlVBVE1pdkFOclAyTHcvbVlVS0RCZXkrUDF0UmduWStm?=
 =?utf-8?B?VTFoUjF2M0RLOUhqemx3OHZSbTlCQ1Q5Q2xCaXBBVER4NG94ZlI3Y2o0dTk1?=
 =?utf-8?B?YkI5aS9HQWdyL3FiNFdNeVRZSitxV3ZQTGg0LzVUZkxZN0RNZUw5bHE1WDlR?=
 =?utf-8?B?SkxyT2NtVzhJU0NpaWdnN2p2a1FJT0Mxc1JhWWdoYmdud2EwY3Vrd2tkZTlG?=
 =?utf-8?B?b2VWeUJPTzFTZzcvK2tNQXZrR2w5Y3RUMDlUSCt2L3ZLeVVKRDl2bDZVQVdk?=
 =?utf-8?B?WldNNVV1SGE4bWtXWFp2dU9ueE9lclFGNmFSckJBNFNtQlZwN3BEa1NQam1m?=
 =?utf-8?B?NThyMW9ubS8zWE9uZXRvVTk0TnBucTA0SUV2VFNPSy9yVkJ4YXRRVjNkUDdh?=
 =?utf-8?B?cXQxUFZJYTcrOStlTlZocjZyK0hIWjQzZS81Ny9QSzN5SmRFLzNQckg1VG9w?=
 =?utf-8?B?UzlzWUcvM1hiNm9pc3d1SFRpc3ZrOWdOR2k5eDFVdGZFWkJwZkJBVUwrcHJH?=
 =?utf-8?B?Mzl0ajdPeGk1cVZCSldYUGp6L2lEc2d6MWloc1ZxdXVwYTkwNkxYaFAyS0dn?=
 =?utf-8?B?bVUvSjZRL1pPaCtvcXdrc2JKQWEzcWZSM2NCdityeTdBWFJISFRxZnIvcU85?=
 =?utf-8?B?SUgwVVBZZk9JSitTd2Z4M2pIblFaSWU3VzRWYVhhbnIzdXB3QUg2UENseTVP?=
 =?utf-8?B?WDVLT1FBOHF1dllCRWkrZUk1RlFIWmR1V0lyNVVFcEsvU1RUUlBDZzI0a0N2?=
 =?utf-8?B?Wno2WHI1b2orQWEybXU0bjU5em1BUFg1TDBhMHl0WlN2aHhwMzEzdHBkdFRH?=
 =?utf-8?B?LzZZRDRicmJmZ2hLRjFnT2YwUERrRGppazRib0Y3OEE0RkpFQzA0a3BlaHpr?=
 =?utf-8?B?YkVjWXY3VmJQMVUrR2RaRzN4L0FoQk9weHJreUxhczI3Z2d4TlExZExDSnk1?=
 =?utf-8?B?K2F0V1Zza1drWWJRQkVpZVBlNDRCdHBjaWNKUVh1bXNJUUtYbUVHeDRnQXhk?=
 =?utf-8?B?U0JRMXdWRlFYWkdCTVEvVU00M3ZiNXczckR6NlBtaTY0TGpDYU9NY0VXVjV0?=
 =?utf-8?B?NVd1TENYTEZVMi9Pb3IrNE1vYWdaT1R3MEErNVkxSks3a3dmQjl0Vi9vVkQr?=
 =?utf-8?B?NDBLRlhXdTBtUW1sNm45RjA2Wmh3bzdMVU5Kb3pNdE9PZnBqblR4Z1FZVnNi?=
 =?utf-8?B?ZXVydE5zWmp3bk9HYnVqcFAvUG9lRzhMM28rWE95VGFNSG8zUTcwVTVIQ1FU?=
 =?utf-8?B?TEFJTjBIV2Nmak45NjEzWkVpU0E3UXY3RHFuU1ZLTEtmN1h5U3hGUTNWTFFD?=
 =?utf-8?B?Nk5mOEpIZjBydXJUangrTWRqeTZZSmJ0YWZHY2dlcW5kL2dtSWlHbTc3aTBi?=
 =?utf-8?B?b0p2WU9FczgwbjVmdWFLYmdyL0cyQWZzR0YxcFdHMzllb2tTc0ZQQlNiQW1H?=
 =?utf-8?B?N0RqVWxZa0g2VmlJanVkcFJZcnltY3F4b0wrV3pSMmNyY3ZEdkFVbFNVelZF?=
 =?utf-8?B?Uk13RE1nNlo3NTRMSHMzclJjRGxjaVFhSG95YlA0T21ZNW1RUm5pT0xvNXkw?=
 =?utf-8?B?bFhrYnJpNHJ4MThGL0I4TjEzZG1idGkyMlpSaWhrLzFDay9aN0hSdVg3dVNs?=
 =?utf-8?B?dWpnUWJxR3VqS0xsUmhWSzZ2MEpyVi9ZV0VLcm9qQzI2RXdGSm5ZSEZ5K21a?=
 =?utf-8?B?MGpIYWJXeGUrUm96OWlqVlBUM3hSeEJ4eGlONTJmYytQa0RWWlZtZEZsNzBw?=
 =?utf-8?B?b04xR0szOXloMHg5VVdLOWxwTCtrMGlqMnA1U3h4M1N3VlV5MWxLQ2tHRVlI?=
 =?utf-8?B?NlJScWF6MmNBOEhSOWp4Q1F4bWxCazZMcjZVV3J5cm5tNFduMWFrM3BaVGdu?=
 =?utf-8?B?d2dRYko0T1UwZEdIYzVlNUZ6YzlYK25rUkgzNkhGU25DeE9Ga0NQV0NROUJ0?=
 =?utf-8?B?TVBzcTF2bG03cE5DdG5GeFFoTzh1c0ZxbTNYUmtGQnYvYWhjZFVsUDAxc0VO?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78281bcd-2122-40f5-e569-08dc859f795d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:38:36.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcHgqRKOcwI9pOkAF5/8FUSVHBjioY6Ih7/fTyd/YcLWOLjwwJ+d7pe5DdO/tE7EvhDHYU0rwumBgOBxThWs5UwkCex+SczcTl7jRUWpmV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6210
X-OriginatorOrg: intel.com



On 6/3/2024 3:38 PM, Jacob Keller wrote:
> This series includes miscellaneous improvements for the ice and igc, as
> well as a cleanup to the Makefiles for all Intel net drivers.
> 
> Andy fixes all of the Intel net driver Makefiles to use the documented
> '*-y' syntax for specifying object files to link into kernel driver
> modules, rather than the '*-objs' syntax which works but is documented as
> reserved for user-space host programs.
> 
> Michal Swiatkowski has four patches to prepare the ice driver for
> supporting subfunctions. This includes some cleanups to the locking around
> devlink port creation as well as improvements to the driver's handling of
> port representor VSIs.
> 
> Jacob has a cleanup to refactor rounding logic in the ice driver into a
> common roundup_u64 helper function.
> 
> Michal Schmidt replaces irq_set_affinity_hint() to use
> irq_update_affinity_hint() which behaves better with user-applied affinity
> settings.
> 
> Eric improves checks to the ice_vsi_rebuild() function, checking and
> reporting failures when the function is called during a reset.
> 
> Vitaly adds support for ethtool .set_phys_id, used for blinking the device
> LEDs to identify the physical port for which a device is connected to.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

The igc patch needs to be completely removed and reworked. I think I
also saw some comments about Eric's ice_vsi_rebuild() that we missed on
Intel Wired LAN.

> https://lore.kernel.org/intel-wired-lan/20240604144712.GR491852@kernel.org/

I'm going to send a v2 which drops those two patches so that they can be
reworked.

Thanks,
Jake

