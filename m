Return-Path: <netdev+bounces-98041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A608CEBB7
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 23:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD791C20D7A
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C284047;
	Fri, 24 May 2024 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cr4ZcoHD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5084A53
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716585091; cv=fail; b=fMXrhFyvAk7UDmlrQrV+q6fbRzkwEBuaXFIVplkD+ZAYcrLp3RLG70Ve/hVivgSRhftEbspIA70HdR5I+kpRknFdyk2mLJJeMUXxH6KO4RlQ2wJzkVk4o/TrqAwAWScVmlrKPiisiD74WCaKHlKkpyd1WtC7dgZDk1YdV0LMGm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716585091; c=relaxed/simple;
	bh=sE4pPB71a5RhvOU3VkkRNLGgwANDyhqYualhMmmdu8E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aNJcL9/lZCqN/Y2S9OcNPnWbMkJctC733pAwq92DGZT7iQJdLUTiAEa/Mk9hiz/QjU+UClpwVwHj1PxVbsSTHwypuFTQabavf6xIXunWknkOdX9dunUib/xY3jXJ5cP0GXJG1ScvZGAoqRHLNtAY4U2YR78AByPky/94HUcgXmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cr4ZcoHD; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716585091; x=1748121091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sE4pPB71a5RhvOU3VkkRNLGgwANDyhqYualhMmmdu8E=;
  b=Cr4ZcoHD1t+hEkXzp6eKa2PmJinhNGIxdJr5e86JwED1U78Lf/bjptts
   wWUYeCvUyjqNKiVbU+U/gN+/IQLRl3aiN+j17AHbaCyqcWP1FH29r1VSR
   wM9/zt1BVyzkbdETRBRfEIeX/6o+52oqAmddt2W7kv2GOpplCNhmaQ8PR
   UrDHfrYzapuak6eNajtUMtGGFtyLbY+FuuuCNyK65aajbLmjFC2Q2w2T/
   YBnegID7bdQTLrLCc1r8B8sl/HhhLK4QXxautN/7CY0emx9tmyKFlG2Tt
   lrLM0ZL1ybRozhpDhD28SoUMFdNP/jOvRVe0eirIoQbLWFn9WAE+0q6rS
   Q==;
X-CSE-ConnectionGUID: P+y8/C6aSsmnstrhR40pyQ==
X-CSE-MsgGUID: qU3Jd63/Sb6VUmlkxCthMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="12822585"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="12822585"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 14:11:30 -0700
X-CSE-ConnectionGUID: jrdn3ly4RiGC1/cdpwI7qQ==
X-CSE-MsgGUID: J+6aUpIMRhGZfWlyn1Wzdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="57363667"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 14:11:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 14:11:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 14:11:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 14:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm1KsesHpaL3Ss/jo0yB1BZ5n+tlwUb5WHNumVeCSDOCrx1OmW8nWm7hiMh6r6PuN/99SsvtITHQ6OBODNGgBLFDx3nWwxbMpwO2zzI/VsQgfI+TUhMo5ffkurzVqBwdrDS5fIAuw+2M/eM8Tf+RXuqn7mX3alCs1f0tFIDJee1yf/R8SCgv6T6PdWO54rhOjsxCDNRgkyGFKdb1kDzdh0OT/qJ560Jy8THgm8wtf5LZi1tAllCh9GH/7s70tU29VKsbClCzt2zVATrT9UCLkwM55kwDP+tJszDWWIZP10EwSaLm392aUXDSRXUcutD2UZk3LT1q8n33OX/PaHDkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DwibAwyOu89XqL0NFXH79vq13/KzIC4nWlDWvg1HeM=;
 b=EsFAhg7j3Lh5Bv/LAT3/v6x7TlYRUtMEz4oySYqhkMK8kvfWJWFyqhOmoebOHztgqSwGRcNjadqAUOCUwQeMkTC7iarn59031btRfp9KNnyde5lao9N2ZTJX4B2KBuutp5fvolhDYcYDIDseZK2kyRu1ERBq1zgfFXsXkvaV7CSyavod7jDecDaQp/RWMPr29t6it+7rp6AwI/r6KHEPPWkuzFmhs+klg6YsrEC4CLBf/7tTSDoBkgXF43HCQaPjB+yM4ZRnpQ9f8XJZQqzVf8GRG6LfTlII+ID6aiZoTnNtR6rGrTlVhs9RMHn1vKuNHXOSOF+cpyE+hIkhILdVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYYPR11MB8431.namprd11.prod.outlook.com (2603:10b6:930:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 21:11:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 21:11:27 +0000
Message-ID: <2fe273b9-dd6b-408c-bc69-e12c00b4141d@intel.com>
Date: Fri, 24 May 2024 14:11:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 0/3] ice:Support to dump PHY config, FEC
To: Anil Samal <anil.samal@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <leszek.pepiak@intel.com>,
	<przemyslaw.kitszel@intel.com>, <lukasz.czapnik@intel.com>,
	<anthony.l.nguyen@intel.com>
References: <20240524135255.3607422-1-anil.samal@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240524135255.3607422-1-anil.samal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:303:8e::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYYPR11MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 969ab952-ff7f-4713-8740-08dc7c361312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzZnT3B5ZTdQanY2Q2pPb3hCQktkYjFSam96UDJRZFFhQnJ0UDdtdXdyb1dn?=
 =?utf-8?B?UmFHRU9ZZmNsRG1lVm1SeUFQanFrRXFGL3RMbGVZRzBXSE0wQXl4eTdoM3R1?=
 =?utf-8?B?LzArSHNmVXM2R1paTndCZHZnOWF5c20wOVl4Zi84SldlSFlrdXFzMEc1RzJK?=
 =?utf-8?B?NGpKZGt4dVRka3E1V3FCcUg2cGhFNjcvUDJ3L1RGZFQ1dUVjS3NzWWlyMDBF?=
 =?utf-8?B?dDNkbkw1LzRtem9iVnZYcWQ1WC85NTFaOEJ0ZGNHSVFOYUpXcmpORW9SVmZI?=
 =?utf-8?B?R2hWY2syTmxqUTJ1SXVwQ0ZvZ3U1YlI3Rmx0RHkyVURGUWVlVU56M3lqdWN0?=
 =?utf-8?B?TmV3ZjNTaks4MGdzMkxOWFZIMTEvRFNNdmkvZW9TM2wwS3VOcFptbW9zZHhN?=
 =?utf-8?B?ZWhVY0I0aDd0RHVpMzFZVHdFY2xvS1dwM3lzTjE1anNLVXVPcmE0U2lJWU5o?=
 =?utf-8?B?R2V0bERlUEJRWUFIb09pUXYwNWtTdFpDVjI1MEFndXgwSkNqYW1ZQkIyNVBh?=
 =?utf-8?B?ZFdIMXl2QXhhVGVnRVprbndWanM4UFY3SDNnOWkrQ2h0NUZkVTFLTE5yWVd3?=
 =?utf-8?B?R055MVRBSzdzbFR2aXNSN0I3R2ZVeGJaUzliTGJoZ1lDR1lGVzJxSE1hOW5N?=
 =?utf-8?B?alhCNE9OM3B6aDZaR3pweHRXajhWbVBxU3M0NjN3SDlvWnlvUTl5V2c2bzVk?=
 =?utf-8?B?RGJFVkxLN1NCRmdkRnJMTmxZb1BBZHJoOC9ydUkzdG9DalpuVkZYZk5EcDhk?=
 =?utf-8?B?RWFDajFlMXFiYXZjRDZuQ1JRRURXcTNJR1ZwU2RmL1hxTEtHVUk5Y2RiVk1S?=
 =?utf-8?B?UXJBR2RSM3oxOEtuSGErWVJwVm8wOHByT1RRUklzY2k5RGNlVVBSQURtVTZi?=
 =?utf-8?B?V2ltQWlYRXJKeTZZUzN1a3IvSTl2Q3NHdXI0dmRzWHl3Y2s5YVUzUW1MTGFk?=
 =?utf-8?B?TTFObWIyZlJQKzIvZ05KVVE1NUljUTY3RTlHZVJNbEw3eDI2R2VicnRpZzZF?=
 =?utf-8?B?MFd6dDdEZkMxdXlGS1A4NU5DeW1NVUNqM29JbVBYWFlrRDAwdmwxWTZicC9u?=
 =?utf-8?B?NFg5c0FQQ2lTYTA4N0loRTlzeUVhS1pZTDVFSmkyeWV1QVdjZzA2QkFxQzVk?=
 =?utf-8?B?d3Q2ckhXRDJtd3YrTEhzdUJYYnozOVZ5YlR1WEYxQ0tvNUZBazhKcEdxS0dU?=
 =?utf-8?B?YkpiZGt6UXFDNTZwMzhBWDVMR0NaUGsydnFFWDJQZkZLWDh3am9oQkxhY0tY?=
 =?utf-8?B?c2dQUVNzaW9nY25tNFhiMUo4MnN2NExKckJTdHlXY2VLUjNUOXFPZHpQOE91?=
 =?utf-8?B?T1RNYWxZNUZlSk5DOG0vY0M5Yis5Ry9kRUhWMytkQjYraHZyTnY0MGNTY0M2?=
 =?utf-8?B?TWxRWmFOb1FhYnRiVHBNTDl1UjBmTDVRekthaDBQZ0k0VXZWUmJWNi9UZFBI?=
 =?utf-8?B?R3hFbFBQTFBiVFRWejc5b0FFLzVXeFRxWXpjS0EwK0lheEdHbHErWndENitF?=
 =?utf-8?B?ckUxN2FQMG9XVnJxSmhnNWRvWk1HeVVLYzJERUZ5TitLMlVxVzkrRGtEQlNp?=
 =?utf-8?B?aXdMeHZMdlBPY3BRRW1HM3YyRVdmQmN1b0xpQ0tHNjlpZ0RUaXIybDZiQjU0?=
 =?utf-8?Q?/mXo9NZtIpGo20gSRRAwG2rrvWpnPZCNdo9peRf8wigI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpuUzhTVmpFOGpoVkViWFJDMW80OWFEUCtsZk1pZnBZVWxPdy9aMVhyMUdv?=
 =?utf-8?B?WFpBeGlXWWhoeHF1ZHNacGhYVTI3ODNvSUxQYytaL0JOeVQwT2lSbUxGZ2k3?=
 =?utf-8?B?WXZWN0FwNXBmd2MrK2FkUnhkNEwvVHAweTNDeXAzQjlsZmlmRDdBbXFaK1hY?=
 =?utf-8?B?eVNjZTkxck8rWk0wUzlMRlI3R05iV0hMSitXZ0liY3Z0NEcra0l1WHFOYlQz?=
 =?utf-8?B?RlFLenoyQUFacU01QmFyRDNVbEd6cFMrYkF6bGFDRWRvcFZiSGhxQUZZN2J0?=
 =?utf-8?B?VmV5NVhBSGZZdmFTaG9xSWVtRUdXWEdlRjh2Qkp3Zk92UmhCR2ZxWkpjQ3lS?=
 =?utf-8?B?MFB4SDYxNHBKdndKTGJ1enh3K0lWSm91dW1rZWdqd0NmQmc0TTNjYjl1RktI?=
 =?utf-8?B?aUZnVWdpcGNwVUV0Y1Z1cldqbno5bHo0NFVZRjhwYWdiU1VrNmdyMmZZbkpU?=
 =?utf-8?B?WHZRTWJoU1NPUXRFUmhjRVRhUStBemRNeVNydWZoWU9DWVY4ekloeWRDZG9O?=
 =?utf-8?B?emhFdzlqakgzUk0zbmt6K0J2QU1adERsQy9rSE1sSCtoN3JoS2wrNHZtZlU3?=
 =?utf-8?B?UStMaFAxTzZjaEFSdkMreGFVQlJTS05pdDRWbUFPZnU5eGxWNERjZVNCMmo4?=
 =?utf-8?B?WXdGazJUMzdtVDRYNmdJYXNBRzMwNUtIVEsxalhycXoyQVJ5MktRLzdOWUxr?=
 =?utf-8?B?bXBkSUpzNzNMZGNMMlV3d1lwZXUrSGdaZ2crT3dpaTk3NmZkWkppTHNlZWpF?=
 =?utf-8?B?WWkwbFBmY3BGS2pNK09SdkwzWFdqdXp6Y2tjdzZYajl4c2t1R2RsZ0FFa29l?=
 =?utf-8?B?Z2ViaG5oalZ0MWxpRFJFNDdLOTVPd1R2QzlPRHNqdW1yY0FpMkVGTjBqSHE3?=
 =?utf-8?B?SG5kWmI5VlpvS0RieWJBUGVwK2pHczlRL1NNSU1FNGtNTXVDSXRTaUdCYXhZ?=
 =?utf-8?B?VjRLUmlvdGdHcWFnOUsxeThzR3BYK0gzampjY1lYcmZDWDVZS05hdEhXNVQw?=
 =?utf-8?B?WXVQZU53WnhqVnVybThBZGZSQ2NVMWdkREhuZitFMnhHTVNrbmJPb3lOY1lR?=
 =?utf-8?B?YVFRTTEwS09FNUt6N1RrNUgvNkl1ZkpzZWxVcS9LUTliOVJFUFV6N3ZzdU1C?=
 =?utf-8?B?aFFITjJwRjhUa05ZN25uZGxBRkNHZEJCYzZONnJZRDVtMHVaYUJQUEpUYmNL?=
 =?utf-8?B?WjRuU1F3R3pmYyt3dFdYNy93NjNveEFqRlI2Z1RjRjE1VS84d3JIbFZ0SlZp?=
 =?utf-8?B?bVppWDJEUGNQb1BMSXgwaW5YZlQ4Y0hjbEk3L3JFdStjY3FZbjhWbElqaTky?=
 =?utf-8?B?NVRlU2RsaXJFOTBJaytxN01hbGZPdmt1dkFETCtXd3NiVDBIZENCY1M0K0Ix?=
 =?utf-8?B?OFVLQWxHYVpHM3dxVkFDWEcreDB4REk1QUF0bHVleWRiWlNYbEdVUTlRc2Ji?=
 =?utf-8?B?azU5RWRCNFNMamxTVnF3eVB0M3lQVmxsbStSSXdiK2JlejJKRDBCWkxBWkFs?=
 =?utf-8?B?djh3djFxc1MwRVhBbEhuM0docEV3cXBDQ2F4RnB6MzhZdTYzTmtlRnlmckNV?=
 =?utf-8?B?RzJPRUtFNGVUeGw0dHFuRWlQL0hBcXg3a041NVl2c0JHYVYxdFFDKyt4NnIr?=
 =?utf-8?B?WmlMM2lJajZLbmhFK1FWRlRHVXN3bldpQ09tVkY4YVdwT1J1MkNPQVJsOExs?=
 =?utf-8?B?YWczRHNtVm5ZWDV5NjlzNGJKUGF4TDBNbm53NzNwbWU0Z3JkVUJtZHZrY0J1?=
 =?utf-8?B?SzNlb00rbTY0dUpISERjU05UVlduQW14aVc1OWJsNTFDUXBDWkRpdmxZejdJ?=
 =?utf-8?B?b0d6Um50RE1aRUYzWDJyTFduU00xQmFxZm1yb1NKTmtOY3NWMnlnKzV2MW1J?=
 =?utf-8?B?bWhGblorRXh5eUlBWVYxcGNkVjJVZHdkY3VJVkJJMmlEQ1p1VVhCamtSaElz?=
 =?utf-8?B?Y08wNzBldkYrYVpET3pINENLU2V5MnJKWWtJT2NLK1BDb2dzaW5SR3dZU1Iw?=
 =?utf-8?B?N2d2dGhtRjRheWFLZGF2MUVvOTFlQTMwV0xDdUlmbVRDanplSE84aUJRQTk5?=
 =?utf-8?B?bG1pSHVSbm85WGhxcThwellkd2Rva0J6UjNyd28xL2hKSjN6MHBTV0gvWktT?=
 =?utf-8?B?N1VFSXh4OUdwc0twMWZOUnV6UmppOXdXaVFoZzhKQmxiYzhyZHNqZTduUitz?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 969ab952-ff7f-4713-8740-08dc7c361312
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 21:11:27.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkUiAR47tFk8EWcIbR6Q2UZoFGcyZOu6q1qxLuMGaKwm/A2kCqERRfn010ubmsxXLn2OUkeW+I6zJVhd2Uh4Q4rhuEXZMdcPRsNL/rGKZRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8431
X-OriginatorOrg: intel.com



On 5/24/2024 6:51 AM, Anil Samal wrote:
> Implementation to dump PHY configuration and FEC statistics to
> facilitate link level debugging of customer issues.  Implementation has
> two parts 
>   

What commit is this based off of? I believe we have slightly conflicting
work already queued in IWL next-queue, and the NIPA automation is unable
to apply this series for testing:

> [IWL-NIPA] Patch: https://patchwork.ozlabs.org/patch/1939088
> Pass: 1 Warn: 0 Fail: 1
> 
> Patch: https://patchwork.ozlabs.org/patch/1939088
> results path: results/408098/1939088
> 
> Test: apply
> Fail - Patch does not apply to next-queue
> 
> Test: tree_selection
> Okay - Clearly marked for next-queue

Normally, basing directly on net-next is fine. Unfortunately, I am
having trouble properly resolving the conflicts with the work on the
queue already.

If you could rebase this on top of dev-queue [1] that would be appreciated.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?h=dev-queue


