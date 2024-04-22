Return-Path: <netdev+bounces-90301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E104C8AD92F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 01:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BDE2815C5
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 23:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220BB446B6;
	Mon, 22 Apr 2024 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIN7/ET+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E81C286
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828731; cv=fail; b=BTO91LlTSWcLwppL3TlDjnAg34tcKeFNNIiIBgTxZxBKJ4q/kFQVIYt8Q7rjLnhYjSnrLBlHhbnCVXWo0u27yXV6xk0zQ1KwQ2WcrGdrzswZoP0LUovrDN5emWhEaxPjdQzO0E7aYXTWY/d5ixLgUwKHEdqM+fshejhNB7C9Srs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828731; c=relaxed/simple;
	bh=ocqb2nJAxSRMT6x4WraqIVDlus085So+8VgbjMKBOtI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ovbEOTOk92g5laiPPpFo8DEwWNyOlCzA1RtwtmHyHeDwT/sjWxUpeICXwGYyyWmd/Z3sJYLIZOiUt7tss7C+dAGBo8b47FSJpji+xhOQGydeuMm7866NGHrB0FwNZJ7gF2RmhyWs7wfTlqoRq3TlTUGFW/NIAcXZi2c49CycS7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIN7/ET+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713828729; x=1745364729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ocqb2nJAxSRMT6x4WraqIVDlus085So+8VgbjMKBOtI=;
  b=hIN7/ET+Lxp3oUC/aYmZoH8BRWKjrm1kwNvyi2SMw71qKT74nECjA71s
   MnS+NRkqYPjniXIhsYxiYEL2QQ5zyLpsaDQ38cKGDSNnrRCdtiKcG1Flw
   STXsEKin+WGf9S1wF+uqIVpjIA2Yq9PiO0oka1uFeYkBj4TwWA72B59T1
   6G2MkF6qaiAIzmiCNmsR9k8nu1oyaTF5htGR9zbEaYcxIQvdbPx6pcCvs
   rkgqO1LEbJFLWMqvf5TvgBTouBjh6WIxJspz6XkbUqRvccyn3+CDxkJEP
   ZYVCu5qnEzGSaE5B9iXAdq+L9ZgzvDZxZ700oDh1FFE2pt2c0NUu9VEsv
   Q==;
X-CSE-ConnectionGUID: BSU/EvAOSCi0SWPr75u0/w==
X-CSE-MsgGUID: zGk06kZdTNSB3hxFKAnEKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="12328533"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="12328533"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:32:08 -0700
X-CSE-ConnectionGUID: g8YUvYHyQZqUTHlKAGdEOQ==
X-CSE-MsgGUID: yzN3aH+nSoWuCU9TEOxVow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="47456328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:32:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:32:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:32:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRrQKbnmCysQZ6rpTG9aJ+CNKpXiJRihuFBhodiiSUBq4BZgn/BI+pIgAyf2KJxiqDxj70lFKQ5AGO9OmKc1FBF6LidkddAn11TJQXLPOC29FgawH2uxHSii1UIJE2eAOZZPBhvVmPM1ENJ8q63PNrjY+/thaXEvuT+FY4jlY0ClxCZuaTREqG8ZAcSNNY0olmvYkgmBgcpe/3RNwKSHVAJnkvYVAJWiVJPx9B0UBnxqFvdTcpp5ORNNB5AJ/7HgiRMLinFPBLVb3cVuVCr2FkA9osOwtXiTPp7WzByHxc0E39tL+fnLG85hx6Il2iYUwvLZ2zCFS6eMaQdmm9lVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo/btZYuPJ0B9dpzD2FUPJMYhd9gyLBvn6HukzpZSFg=;
 b=eyfCmzRtgpYJFHVRmKQRPNSIrQB0Jsb6LnRsX0+mSccM7cztytd6R2g/tmRIg9pDwn7T1k8DLUXU0NdnrvBnU4c9uDYUGpdzI7y3B6s+0xS0tuTD2TPD062DC6It7iswvJ8SJ0M2IgyGEkA8W8pDTCDeb8WJ3JgmrFaFgt17lkKo3QaqUCqAPAUjf9vw5JsmGHZ8UYoUolkBL2oIRncn8lb8+1gOF7ogIR1wDzHmZOTux/pqoqxAzMUNK2cVdsEo7MQ2N1IrOLlVN0dkE5om/QTEKTdRbyBkc7mZKPdNTT3hlcO2YxwhOYIY9nzdRaeRZNXfQV35j3k13Xj5vrYAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 23:32:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 23:32:03 +0000
Message-ID: <96939b80-b789-41a6-bea6-78f16833bbc9@intel.com>
Date: Mon, 22 Apr 2024 16:32:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, <sasha.neftin@intel.com>, Roman Lozko
	<lozko.roma@gmail.com>, =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
	<marmarek@invisiblethingslab.com>, Kurt Kanzenbach <kurt@linutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>, Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
References: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8cc79c-e6cb-4bca-7a04-08dc63246a6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGtEWlZkMktGWnJ3YUVQbHdKZjRLT1IvWXhad2gzOWZhOGdGSnMvYm9mWWt1?=
 =?utf-8?B?V2g2SnlNaE81V1NlMFh4L3dDTXJEZG1WaGZnMDgyQ3g2REx3U3BnWFdBeGlF?=
 =?utf-8?B?clRheFJaem9udkVQSjJ4eTVUTmhqUHNHaXozNmE5V2hTY2hVUWg5WDIrVmMz?=
 =?utf-8?B?QS9mM21vYmRmeDBsVmVoemNudUFDTDNwOGR2ZThtZkQvdHhyTDdEMTFCNHNV?=
 =?utf-8?B?UE0rVTZKYXpMM0ZCSE90SjAzR3RPdnhCcDM3RFQxSlpyQWdTVkhLY2hNUHlY?=
 =?utf-8?B?ZnlqMytZZGNqaTdmam50S1dabnlPK1RVTDQ1TGVHdGQrdnJoS2lTQUJDL0tQ?=
 =?utf-8?B?V3NZZW14ck1YY2o2MWxya2ErOUZWY1plQnFaeU5QZWxOUmNLTXFlcmtMeFBu?=
 =?utf-8?B?Vkp3NWFzeXhyc1lGRFhBTithT0VxcWxjWndBeVAvRmNNUm1aWXpXT1RERDN6?=
 =?utf-8?B?cjVBb0ZLVUlPTjgyYzJpeTNXQm9aQm90MHRqVmFjU2tkVnN5NnBNNzJjS1M1?=
 =?utf-8?B?UGRNd2pDbEJDVVVPaFRnN1ZuNkV4NTJEaTR0YXA1Q3VuQVF3VnpwdVpyd1lw?=
 =?utf-8?B?ZFNISmErMTNqTlRadVNWVjd0SmkrSmhZLzZ3bGJHY2hYVXA0Q055SVZRL09G?=
 =?utf-8?B?QjdqVXY1N2twbXNFM29rdE53ZHZCbThLRlExVWgvK2xqeHFiSldETUxjWnlr?=
 =?utf-8?B?VkF1Q3ppSisvVGVXMVUvOGlPZUpRa21GcDhzSzVBOVFHWmhTMHg3bW40Zkox?=
 =?utf-8?B?bVVseUFhZVBuUmFVRkppR3V6VVJPZDlGYktHZ3o5QzJoNWtzTXErSXRrMDEx?=
 =?utf-8?B?Y1R4bnI0SURQa3lNQitSOWVvWENvNUxLK2U5M25vSk5ESWJqb2hTeGFGaldJ?=
 =?utf-8?B?Y0xTL1djSlEvaENGRXlpWTVaTm1CcElxWlIvMGJXeG5Qb2wwZEs3WWxCbUpT?=
 =?utf-8?B?WmpUWXoxTE5USjZBSzBaVHhzUGtWeEFTTGsrUjRKUHorcXBSc2NWOFRwWEJl?=
 =?utf-8?B?S1FWaWswTVkyREVmRllCU2ltQS8rNVpaVks1UVZIQkd5UlJDTVBpanRqQm5Q?=
 =?utf-8?B?VlpoVVc3cXk0aDJCaEJaTW5hVkYzMmFvWTlWdEwzZkNRb2gwNGNEcEpLRFh4?=
 =?utf-8?B?TmlsZWUzVDBBWnkrcDlQV00vY3dLMHgxenpXU3lqS1E2aWVyc3VWMlB4TWg2?=
 =?utf-8?B?bUFHLzJtZVFzTDYvL3M5N0V0R3FBZkZVcGF6QWdmMDVxNm1pWmdySXpKa1dF?=
 =?utf-8?B?cndRTUVhQTlZN2pWWlVMbk5NTmZYeFNEVU9oRXFhdSthaW1KdEpEOEM2OU5H?=
 =?utf-8?B?bWhPWUNnaUhuc0hHbHpTL1V1V3lrY3hNcWJaYSsvVHQ4SDQwNzZ6STVUWkg1?=
 =?utf-8?B?Vld4L2lDVXpSQ3B3bTg1ZjZ1bHcvTXAyWExSS1htUndOTjNsN3o3cjdoNFB3?=
 =?utf-8?B?ME42UFNXbXhBZGRCUFFhWnN3SUpESDNKT2VYUE1xQy9ad1NzNXR4MzlVd2Nv?=
 =?utf-8?B?MG5hZjFDbVV6aDFGTHpDcUMxRnptak9IakdHRjRuQnZZK20zbVRVU0FrcVJK?=
 =?utf-8?B?OTJleldLdEdRdWtUK2pMQUV6UW5xbXUzS3ZZbTB1TDVaa3FNQ2ZIR3daeU9H?=
 =?utf-8?Q?tDhinZo2NFdR60Fczp5pPkuw1Ddseyw2y09mMNDN7FUU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVM5dXFzZ0R5NmF6UUlQckVXM253Y2EwV0FMakUwRC83MGtQN2ZHWG93anRG?=
 =?utf-8?B?Wi94MTB1S1UxUFA1WXFLdmlScTVEL3haQXpoamc4bXh1NzExeStPWUpVdHJM?=
 =?utf-8?B?TVJTMW1MejdDK1hRbGt3WEwzNUVPYVR2USs4TUJvcit3RlZidVQ1OG8veTB0?=
 =?utf-8?B?THJFcXFsTDh2N0xDcDRWYWhVa0dxLzNpc0o4SHpuUVFET3A5NDRYZU5mKzhL?=
 =?utf-8?B?NWRtRWltZFVxRVBaT0FFRnY4LzV1YnZKdFN3UlNHd3pHS01nSFVpN2srVC9q?=
 =?utf-8?B?M2xtKyt1bWV5UnJjYmxwWEE0OVRYVDJzMm9mWXpKSGlrTmVyOStyK0ZnSys3?=
 =?utf-8?B?S29kVkM2Z0J3cVk3KytxNlk3MUsrdWpreTdJN2FGZWZ6c3pKeDFtbGtKa2sz?=
 =?utf-8?B?b0xVMkQzdmRMOHVyZlJJZWRJVnZqU2hUbFRKTWZzZXhMNnVXZWpoSWlLdkhq?=
 =?utf-8?B?WGMyaWtzUjIrdlovY3Vac1ExMlRYRnNQZi91NGlSNE92cm1hY1RkK01sUHVm?=
 =?utf-8?B?cUt5OFp3eFFPVENjUkE1c0dQd25xdDNiR1Z5anpCSktFYk1vQmpkd1ZPZy8z?=
 =?utf-8?B?WWVCZG5WZFJCd3dKMUp0OTZzZU91WEQ5Smg5QWIrYktPMGF3VFZRbldIUzBu?=
 =?utf-8?B?L1R6aGZFZ2FHZk5OdmtkWmk1YzhwY0hHbHF0YitvRVNnUjRFZmtOVXhGV0xB?=
 =?utf-8?B?RWJsTVZFUTIyS2pPSS9OOUZHY3hFbkE4OTZ3THhPdjJ5SzdUU29sTkR2RVc5?=
 =?utf-8?B?MERtaWFTdzhhTTEzK1l1TGM1VENYS2o0cDVIWXlSTVJ4b1NtMHp6SXJ6MWU0?=
 =?utf-8?B?a3cxYWZxM2o2OUJlTStVLy9IWlBld2xTOE1lNjNqc0tVSVJvQ0lFcSs0VjNM?=
 =?utf-8?B?b21iY1lESDBwbTEyVjlBUzlzaGpjSUErVWovS2lzSjJiSDVGMmZCRmMzTlRH?=
 =?utf-8?B?bkhrbnBkLzdITHZkdXp5WExKMWJxU0F2VnFHUzZGR0hxUytGNEtGRENBbFhv?=
 =?utf-8?B?Z0hnNzdRQnlQNHhReVRCOW03d0hLUlJFZ2dLYjVEdWhBcFFyQ0lIcTNSMlZk?=
 =?utf-8?B?ZDdadFFtNHNtVjRyWHI4aW5jQXFwanRzQVJaVGdyRitNeHh0WXVwRzA4S3Ux?=
 =?utf-8?B?aGtCTlhTeisxdm5tYjg3Yk9MRWQrWFl1SUsrTGlSdHBnK3RaaUlhMS96bWpk?=
 =?utf-8?B?L0pINDl6VUVQYkMxOW1TRjJ1cm90L1l2c2x4bGlBMHZGSHd6OE9DZCtwTG9P?=
 =?utf-8?B?cUduOGhtNGpOazg1bWJQVjMwS3hNdVE0bTVEdWpsYmw2MEp5L1lDWTFrYWlP?=
 =?utf-8?B?MUJQbmplSEFoT05lUXN2VGZiWVVaVGlMblhyMXJhOGtKWVQ4MzZ6Qlh5bHQy?=
 =?utf-8?B?SG1HaEZzMkdiVi83REhSaWY3dTJCUEd6akloajhxZTVmdEY4VTNqQnlGeFNX?=
 =?utf-8?B?TEdNeFVVWGlMaTJSRWxLM2EzcEVCMjBhR3pXZDZXODFLWDgvc0lqSEx4VDBm?=
 =?utf-8?B?VXQ5eUdObWZweEx0amdZV1JxeHhTM2l1ZjdhNUFmb2ZZRUFJZ3VaMGNTQzF3?=
 =?utf-8?B?WllVamNJWWd3aWpqZTVDUEdWZXJDaVc3SjN3UHA1U3dGZ2lCNldwMXduWkhE?=
 =?utf-8?B?dWYva1pDWFhremtaVzlHSkxpK2xjaGRPQVRxS080eElvSGxmamxXcXd4T3hh?=
 =?utf-8?B?d1ZFeDFCODJISWFLREhvcVZGTnVVcEVHOGJCVFlwRi9xbzlTTWUyMmJ6OXRF?=
 =?utf-8?B?VlZBSlFzRFpNUE9tQytpWlBKdUN5NEZuQnRJU2VvRUEyaFI4RWVWMGhaU2pY?=
 =?utf-8?B?ZFVoZ3RONisrQ2NOUkNmM1NLaGZnQXFqdnFiYXBGVFV2YkNVVHA0aSt1NjJI?=
 =?utf-8?B?YzUySU9GeGEyQ1hVaklUT1hJSmFZT2JyZWg4OXllRzY3VTZWQnRacUNFdEx3?=
 =?utf-8?B?LzhSbm53YUgyeTRqc1lxamt6VFZrdStFNkhPN1lhZkdDTnJsZURpVGpGcVNi?=
 =?utf-8?B?bW1SMnVDNUJjdGNHazNxQmo1RFRTR1ZoMVNYZjVibE94anpURVRqd2hObnFq?=
 =?utf-8?B?UmtjSnJoaUpIVEVhenh0b3ZlMHBiY0FQZjNhdkRJekdMaTdjdTNYS1RSV0Zv?=
 =?utf-8?B?bjFMczRmS09wMjByQkFvbDZQSHRGYXFycEpzZGk2dTZVamlaL2kxTzUrc2wx?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8cc79c-e6cb-4bca-7a04-08dc63246a6f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:32:03.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpcrnZ4LURL4zv0XlEFxTNnT2din7xTicdFHSexCKIuibJ95NIcY7L7gxkMu3xMw19gI50+H73sVUv8kNdIOu37ro20uPXZZrmT7v3gOf4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com



On 4/22/2024 1:45 PM, Tony Nguyen wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> Roman reports a deadlock on unplug of a Thunderbolt docking station
> containing an Intel I225 Ethernet adapter.
> 
> The root cause is that led_classdev's for LEDs on the adapter are
> registered such that they're device-managed by the netdev.  That
> results in recursive acquisition of the rtnl_lock() mutex on unplug:
> 
> When the driver calls unregister_netdev(), it acquires rtnl_lock(),
> then frees the device-managed resources.  Upon unregistering the LEDs,
> netdev_trig_deactivate() invokes unregister_netdevice_notifier(),
> which tries to acquire rtnl_lock() again.
> 
> Avoid by using non-device-managed LED registration.
> 

Could we instead switch to using devm with the PCI device struct instead
of the netdev struct? That would make it still get automatically cleaned
up, but by cleaning it up only when the PCIe device goes away, which
should be after rtnl_lock() is released..

I guess I don't have an objection to this patch in principle since it
does resolve the issue, but it seems like it would be simpler to switch
which device managed the resources vs re-adding the manual handling.

Thanks,
Jake

> Stack trace for posterity:
> 
>   schedule+0x6e/0xf0
>   schedule_preempt_disabled+0x15/0x20
>   __mutex_lock+0x2a0/0x750
>   unregister_netdevice_notifier+0x40/0x150
>   netdev_trig_deactivate+0x1f/0x60 [ledtrig_netdev]
>   led_trigger_set+0x102/0x330
>   led_classdev_unregister+0x4b/0x110
>   release_nodes+0x3d/0xb0
>   devres_release_all+0x8b/0xc0
>   device_del+0x34f/0x3c0
>   unregister_netdevice_many_notify+0x80b/0xaf0
>   unregister_netdev+0x7c/0xd0
>   igc_remove+0xd8/0x1e0 [igc]
>   pci_device_remove+0x3f/0xb0
> 
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Reported-by: Roman Lozko <lozko.roma@gmail.com>
> Closes: https://lore.kernel.org/r/CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com/
> Reported-by: "Marek Marczykowski-Górecki" <marmarek@invisiblethingslab.com>
> Closes: https://lore.kernel.org/r/ZhRD3cOtz5i-61PB@mail-itl/
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # Intel i225
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  2 ++
>  drivers/net/ethernet/intel/igc/igc_leds.c | 38 ++++++++++++++++++-----
>  drivers/net/ethernet/intel/igc/igc_main.c |  3 ++
>  3 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 90316dc58630..6bc56c7c181e 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -298,6 +298,7 @@ struct igc_adapter {
>  
>  	/* LEDs */
>  	struct mutex led_mutex;
> +	struct igc_led_classdev *leds;
>  };
>  
>  void igc_up(struct igc_adapter *adapter);
> @@ -723,6 +724,7 @@ void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
>  void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
>  
>  int igc_led_setup(struct igc_adapter *adapter);
> +void igc_led_free(struct igc_adapter *adapter);
>  
>  #define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
>  
> diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
> index bf240c5daf86..3929b25b6ae6 100644
> --- a/drivers/net/ethernet/intel/igc/igc_leds.c
> +++ b/drivers/net/ethernet/intel/igc/igc_leds.c
> @@ -236,8 +236,8 @@ static void igc_led_get_name(struct igc_adapter *adapter, int index, char *buf,
>  		 pci_dev_id(adapter->pdev), index);
>  }
>  
> -static void igc_setup_ldev(struct igc_led_classdev *ldev,
> -			   struct net_device *netdev, int index)
> +static int igc_setup_ldev(struct igc_led_classdev *ldev,
> +			  struct net_device *netdev, int index)
>  {
>  	struct igc_adapter *adapter = netdev_priv(netdev);
>  	struct led_classdev *led_cdev = &ldev->led;
> @@ -257,24 +257,46 @@ static void igc_setup_ldev(struct igc_led_classdev *ldev,
>  	led_cdev->hw_control_get = igc_led_hw_control_get;
>  	led_cdev->hw_control_get_device = igc_led_hw_control_get_device;
>  
> -	devm_led_classdev_register(&netdev->dev, led_cdev);
> +	return led_classdev_register(&netdev->dev, led_cdev);
>  }
>  
>  int igc_led_setup(struct igc_adapter *adapter)
>  {
>  	struct net_device *netdev = adapter->netdev;
> -	struct device *dev = &netdev->dev;
>  	struct igc_led_classdev *leds;
> -	int i;
> +	int i, err;
>  
>  	mutex_init(&adapter->led_mutex);
>  
> -	leds = devm_kcalloc(dev, IGC_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
> +	leds = kcalloc(IGC_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
>  	if (!leds)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < IGC_NUM_LEDS; i++)
> -		igc_setup_ldev(leds + i, netdev, i);
> +	for (i = 0; i < IGC_NUM_LEDS; i++) {
> +		err = igc_setup_ldev(leds + i, netdev, i);
> +		if (err)
> +			goto err;
> +	}
> +
> +	adapter->leds = leds;
>  
>  	return 0;
> +
> +err:
> +	for (i--; i >= 0; i--)
> +		led_classdev_unregister(&((leds + i)->led));
> +
> +	kfree(leds);
> +	return err;
> +}
> +
> +void igc_led_free(struct igc_adapter *adapter)
> +{
> +	struct igc_led_classdev *leds = adapter->leds;
> +	int i;
> +
> +	for (i = 0; i < IGC_NUM_LEDS; i++)
> +		led_classdev_unregister(&((leds + i)->led));
> +
> +	kfree(leds);
>  }
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 35ad40a803cb..4d975d620a8e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7021,6 +7021,9 @@ static void igc_remove(struct pci_dev *pdev)
>  	cancel_work_sync(&adapter->watchdog_task);
>  	hrtimer_cancel(&adapter->hrtimer);
>  
> +	if (IS_ENABLED(CONFIG_IGC_LEDS))
> +		igc_led_free(adapter);
> +
>  	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
>  	 * would have already happened in close and is redundant.
>  	 */

