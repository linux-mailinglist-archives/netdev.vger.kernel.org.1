Return-Path: <netdev+bounces-100610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554528FB510
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780201C2191E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C9381B0;
	Tue,  4 Jun 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2XDZAAP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D2179AF;
	Tue,  4 Jun 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510788; cv=fail; b=A/fPPqq5tB8ORak2golEHgOz/BnoaIvODjweFv8LpiAJpvdlyAuwJFg3vLZy01AqpuQzF+ydA39twnJDUGaj16Zz23SrsOb1Q02ZoK81TUaTNtqX3mdjMXq07YB6s7VgllDV4JDVqbAWZ6EplOiZRiGXyQ+Pn3+aExz17siio8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510788; c=relaxed/simple;
	bh=LE+4vtoFVNddd7VJfrkMtlWxIiELAROUmCcshmAQzeE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MRPlI2IuE0TVboNUOurFvITCkOtg0TGrQlhWXJu7CreKwhp9YY1Tp8yDzfijZQQVrGsIUZqQ8lGepdmPu7s32sc4ZWPUnaJCgdL6GqlRNis1X+N/eiN2CiS/PTFdQ3Q9qD1APOdGgbQIeHppqL6Kx09p36RT3gC/xGYFjc94Tx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2XDZAAP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717510787; x=1749046787;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LE+4vtoFVNddd7VJfrkMtlWxIiELAROUmCcshmAQzeE=;
  b=e2XDZAAPvXDZXBv2htFA9PoOxsnMEwP9ZdW9IggZVNj5X8ipbXz1QLka
   IycZJ213TOtyWrFbOzyQv+V+wVBI1Ku+7/kq30O8+iJLNDozPRgMnOSf2
   W6dQ5+J1vWGc7qc0PWRpM7dpzah3AzXOaZPhzNuRs8I4g03gBMB2xA3Br
   /IFxNuYbe8Lp0jMG4bsmejv61pIjM07ZScnTWn2Ltw69lGq1cTX7SoGUZ
   GS6T4/ot+WFngzvJnOuvQogIEpTpSoUFTyotFZ4xDiQczmUFyJU5MuxFw
   8O/WkXZv3FTdm7vkKTcq0cVBMsvY0c4zWZMnGAkQRujT+1UJg+/xscOza
   A==;
X-CSE-ConnectionGUID: VyxPw45AS1OyQGmE1c6ifA==
X-CSE-MsgGUID: iu/+xvGIS6KZk3smLzIy2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31594432"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="31594432"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 07:19:45 -0700
X-CSE-ConnectionGUID: 45zv02yrT9mOV0zumZB+1A==
X-CSE-MsgGUID: 5MTio0xxRgafrJVLWdR4Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="42363632"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 07:19:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 07:19:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 07:19:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 07:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmsY+Tv15PvQ3+b6N1Mk/dLyXjW1W6/LX4GM/VeX9GU1aASeqqI7EIg8odJ6m21Vqy3zVNwcJJFeh68TLOWgU6Dti4I24c6sEWqKAAKGRo1FKipLSd9CUJW2tamjtbpNQJ8xBbq1X0a1QJIusl5SI2dHrQGRDLYUoJzMqr0kPTR91Bb8vA4hhkl4boyKmzaETXbcD1h4s9yjsJCwaCs0hZ3fe/XaAv6RFDtavNI3RixZTh47GdQRE1WdIMyH722p1aUv700u93fgbeC3WNg6HO1JTtv3AlOrjbxX72YHbMAMDYjU1zkObUF3beIDNIw3NR0UdDpqgtgzDfAaaVGJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELysixVxn+CNop1UvlLo+wU1DDu0ofktAUq7X/+Nn5Y=;
 b=Zrm7EkMr+tDFL8tWcqjhOwWSdwMqIa/XHW21KpaCyuGs4uuVcm+THRx3oxEhgphC2nwmCQ7tsQ7uQPVCIWzACXcm8a6v9QjQad6DxApC+a92ODT4MXffk4xoyTXpkTLZLDxh7jajBnEBVaMuodHxdR1hJdgxbbFPCShUtXqsXU3Cr7Je2dMwGFJjW8bJCnkvO+zMHYdEf/YLJIW264ft9QxzI/XVPZAOtAn+HH5f0fioJb2HKo2Uj7NAsVICRimSPhYnxGvMni8HWQ9bpqxjzrqVdC/YlM8rT1Vkq49zkxXxm/89dE6sul5AiW5IeT8+XiSg5UxN15IGGRVkQNtM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 14:19:41 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:19:41 +0000
Message-ID: <fa6c0e29-8baf-46ec-b462-0a093b6f530e@intel.com>
Date: Tue, 4 Jun 2024 16:19:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: ti: icssg-prueth: Enable PTP
 timestamping support for SR1.0 devices
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
 <20240604-iep-v2-1-ea8e1c0a5686@siemens.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240604-iep-v2-1-ea8e1c0a5686@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fac1d8b-6d16-422f-d60c-08dc84a15f7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnZsdGZBaUZyNGI4L0lSSU51RFc4Y3MySGdaUFRTa1BjMmxPaWFwaFRZVXNU?=
 =?utf-8?B?RWNWd3RJNDhOaklRUUZUcjNHQ2NoTFdiYzdhZWlZRElVQUNzMnFFNTc3czFn?=
 =?utf-8?B?K1ozS1Fva1A2U002NlRhVHJ5dWZwdWgyRnJha1BoRnp3TTV3VWVMZlQvUUJM?=
 =?utf-8?B?MXhsNHFtcS80bVd4d1ZPMWdaSWFqdFZVUUVuWkFGcjBGdFcvaUh2Uk03U000?=
 =?utf-8?B?ZWw3SUt1TVF2ZWo4NkJzQkp2OXFVd0tJalNFM05xN0xEdUhvVlFzQUZMQUJC?=
 =?utf-8?B?dGlNYzZJZVgxRE1CcGVod2czMUlsU1BqazdMdnNxeE5uNnNEaWI1TFdtR0g4?=
 =?utf-8?B?M0xkZ1hqTGFZWFNWQ2xDdUpUL1BWWnJLSE81am5TaFFGeDlKTmhYTDFEN0Vo?=
 =?utf-8?B?MDNoVytyNkNyK2NxS043VFQ5V1BBbFhJaVFhZ2xjN1owRnlITDJveWpWN1VZ?=
 =?utf-8?B?WWJyTDM3MWJXa2gzbHVtcFFnL0dSekF5T05yeEZFSEh2U2pEK2JxUHRLM3A1?=
 =?utf-8?B?TjdtNjZ6US96T0RDSk9kWWVhZ2N2OTcrbTN3T3V2bFRFTUFxMlYwYkhsdmsv?=
 =?utf-8?B?c041MnBpdWhVcnBmZTRYVE4yMTFRSWUyRDZvLzg0WUQybDN0ZHNjcmdRWXhH?=
 =?utf-8?B?NWRZUHdhVEJIRHYyYitvVGpKT0s2NDgxRWZ2TTYrTzQrb3d5amN3cXEvMDQv?=
 =?utf-8?B?Y1IwRm55MUdYRFpOZHNFMEQ2K1FYQmRsR2NjbS9LOSs2YUhCMk5ROEdJellx?=
 =?utf-8?B?TE1XREVwYURLb0tRM3ZWTlUwZU5EamEzb1RkUHdrSjg5NWhTd1FQTjhvSFZh?=
 =?utf-8?B?eDRPQkpvYVhrZ0REUG9KSzZIMURTRkpqNjQ5dUo2dFBjeXk3WU5XdU9zZ01X?=
 =?utf-8?B?NlluWFcyYjZGUHRud25GSndtRDVkc3hRd3AxSktXY3BiTzFjQ1NPenVLTzdM?=
 =?utf-8?B?WkxGNm95ZVVpRnZOSG1WL3VYOE04MlNYdkxaeUJkdkZpOHBkbHNZMGRaVks3?=
 =?utf-8?B?RzY3QUlpdlNKNjBveUdzck9kQTk0WW5nOWZ5US9odGJQNnFtbUJYSmlNckFQ?=
 =?utf-8?B?SHdPMGNxVzNqWnlUb0Fwb1o3N1JhcXcwR0dWM0dJZDZxZzZGMW01YTBGRkx4?=
 =?utf-8?B?a3VOTDVMOU9jV3M4T0p4QnZhM3IyNlUrT0dEMzkrSlZ2K0t2R1dXOU5oSmZh?=
 =?utf-8?B?cHdZdEtLNWt0N0t1eks0REYwejE0R2R2dEkwMnRJKzFHQnJjOUdUdHg3UUtK?=
 =?utf-8?B?Mm5iMC9seS9HQkovSE1lODJLdjVEWUszVnM4SHp6N201eUZ5ZW1iTkhhcXJV?=
 =?utf-8?B?VjZwKytkMHpseWZJSkFmWkxDcFNVUGdRR21FNkpWU3hmb0g2RSt2aStVdlZD?=
 =?utf-8?B?QWJVWmliVFlPU05UMUJ1cmwyRDgxbUxoRkJWeHc2Uk84M3YxenB5L09SOVhB?=
 =?utf-8?B?TU1hWFJHaU9GR2luTVAvUk90VzVmMXhOc21aU1lJd1FsbXVIZ1FyNzY2eEdX?=
 =?utf-8?B?MmVGME9IcnkwWkFreHNXLzE5UlcxMVZQMDQ5enBGa0poMEhlaWdDUVhnWmFj?=
 =?utf-8?B?YWVEVU5Bd1RDNkZQWHUvbFlJQnB2OVR6S3RpVCtMVTcrZTlyYituOGFNSWFp?=
 =?utf-8?B?azFpSHhPZkZ0MTJqU0RWY0E5azI1czUzQzZxVWJUdW5obGlSd3ZDZjQrRVhZ?=
 =?utf-8?B?aG54dUV5WmNnelR4dCtydTUraVFvN2Nqd3c4dnBVTERuNERFN2VuSkJsUyt3?=
 =?utf-8?Q?4n+/GIR6fmZl1wC7aXY575c2HLKcCT3vzVLA9xe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZ0OFNxTXhZcXpUWXFheEY4T2ZtUU44cWpDeUZZT0dERkRuK0RobVRTM04z?=
 =?utf-8?B?Y3BoVk1WcHFrVSttOWNJTVE5NHdVcHFReDFjMURZdFlkWTFYU20zYnhVM1ZT?=
 =?utf-8?B?cVZiV1E4ZkFrNThXM1l1d1N1bytVMVVMekVkcWhKRDdadUJjaDdzTzJ1OUda?=
 =?utf-8?B?bkUzL09OazZ3cXhBc3c4WWdKU0xKckd5dnNIa25peE94Q2ZzbkdwT2t5ajhz?=
 =?utf-8?B?bUtYMUVLTXdVUWtJUFNEaUdiZkFWTjZ4eFcyZlNValQ5L2tMZWRvZ3lnSVNW?=
 =?utf-8?B?STNnQTJxajh4a2MrNWZmTnZiZk9yZUFCRjM0STk4Umx1czFxd1hPWUN5dnhx?=
 =?utf-8?B?YXpkUzBUZTdyMzJlczRHTGk3Y3Frd3ZBdmp0bktMUit0RUlSS290YmN6YU1K?=
 =?utf-8?B?cWFWNDF5S0MvdWZTSlNOYjFEa0xPYkhOSjI4WEhyUEdXdE90Y2NrUkRUSExa?=
 =?utf-8?B?b0tvNUdmT2NtdEIwK3RUY3E0VGlXZU5UZmczQ25UVGlFb0dPSVJIRTJjZytV?=
 =?utf-8?B?MDkxLzJwNmF1Q2V6NGl5WWFZd1VqeU9kM3RVbEtzZTcwelIvSGRISEhCQVFu?=
 =?utf-8?B?dnpKTzNKNE5ib05ET08zcGFBK2QrcGZqUnZIRExjeHowbnJZS0NFM3VscjNm?=
 =?utf-8?B?aFJqZ2pnS00rSWF2TE15WFRvOGpHMEFhZlJJbk50UlZ1SlpqdXJSWENOencz?=
 =?utf-8?B?TXd3SVNTV0tEMlo0YmY0MHBZb2NjQ1Q2M0lVZkdOVmR3OEhzSlhXdUFYSUk3?=
 =?utf-8?B?S3VZL3VOS3RUeGVpSVUrMVpjR3VZdXJqajZhSmlmU1dFcHVFbGFoeXI4SXEy?=
 =?utf-8?B?QmpMdFFacDQwOW9HejRLeXpUaGV3cGtKbUs0bDBIU3BTY3V5RktiZVI5L2Ir?=
 =?utf-8?B?RjNKZVR2VEgxY2xnRlRST0kvWVM1VFNEM2lPUVE2K3F1dHFBNXlPT3Y0blNJ?=
 =?utf-8?B?KzdySndidE5qOXBadWtlVS9KNnBJSnFuNCsvajZTcUNIbTdSRjhUYmo4bS92?=
 =?utf-8?B?VlRtVlVpcnlGcTJhUlBQc0tVSUZTVDQ4TkhXckszaHJGMlhCTWxmbmZKbmRi?=
 =?utf-8?B?eW1GQzhRaVhhM0dNQWpyaW5jYVgxSCtXQW01T0FBaTZGdVpBcFpvWHZwT25I?=
 =?utf-8?B?Qnd3bkxsVjJJNUY1cTY2Nm51elRtK1FjOHVNR2dOL1d5bWFjTnBqK2syVzNU?=
 =?utf-8?B?cDBsZ1RVdWF3VmhKNU02Q0ZVbWRnbUJmd3o5OThoR1Bld3hNRzY2d21OMDBO?=
 =?utf-8?B?YjdYZUozeU16RGt1RTBvbmxNQUpqMmJ2UW1JcWZiMW84czVQREJtclRLbVB5?=
 =?utf-8?B?dlFGWFYxak16bzN1NDVCbTlFbXNha2Z5c2JXWk5Wb0dTd0lKQ2c4Z1VuVUNy?=
 =?utf-8?B?ZldQNmh2WitZQUdwbkcvd0c0RUJpV3J1dzFSTFF3b0s4RE44UTZjMXdaUkt3?=
 =?utf-8?B?NnJ6QXJMQ1RacDBGcVBLaFVHWVJ6aUwyandrSG4vNXdrMEFyYm9UT21LS3Va?=
 =?utf-8?B?dlFoRHQ3MG9mV1pYeGRrSzFLY25TWFpwQmVlL1R2eDBpQll4dksra1prZUgw?=
 =?utf-8?B?ancreURKUUlLSXQ3NmY3cyt2aFFUL3Q5eU05UnNPdE5TSXhRTkRpZE9STUJx?=
 =?utf-8?B?Y2doSnA2NEo1dWk3dHJsR0p4RURuTitOTWc2K0YzWFBNMmdkdlNWaVRWVzZk?=
 =?utf-8?B?M0xHRVNUK0ZYSDN0T2drVG5BRjkyeS9RU3hsdUFGVE1lc1ZCckJSVng3bjBz?=
 =?utf-8?B?TjJrcmhscDZyT21tU05WNGpnS3NWbm4ydktlaG0zLzd5RFhsWU1YUkxKQnhB?=
 =?utf-8?B?b3BCSTBzZjFadlBrUHhOcnN3NzNEeE1XSy9CdzYvN1ZMUFlJZ1ExMjk4UWxp?=
 =?utf-8?B?K0l6TWpmbFpwREJhRUJjcHVUQTIxcm5YMEhwbVBpRGZWS3dNYmhiQTlzUTlp?=
 =?utf-8?B?YlM4UTYyOFdLVVEzWW91N1hpYUljTlkwT3FwZm5TdzlTYUl2ZGUwNFZSMm1Q?=
 =?utf-8?B?SWZlNjVlWVl5R0crUUJEN1Y1U1lhMVZNMmM5dTJJS09WZWo0aDlhaXdHS2ha?=
 =?utf-8?B?ZzFTUHc3STMwTmVwc1hvWE1qMXJyTzdHWmxDS0pHQ1B3a1BNWlhjcEZYQ3o1?=
 =?utf-8?Q?B/3DSGrDzIAGpP7RYpwJgQevk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fac1d8b-6d16-422f-d60c-08dc84a15f7c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:19:40.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plVKYJQr9UClfid278coaM5N64lo9LRLfIOI/lfcWYLwY0CmUuoKhRMS4ES4hg57zJ6uou/F206V8hLL2Qqqy2vhXd965CUX9tzFRVYy63o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com



On 04.06.2024 15:15, Diogo Ivo wrote:
> Enable PTP support for AM65x SR1.0 devices by registering with the IEP
> infrastructure in order to expose a PTP clock to userspace.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 51 +++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index 7b3304bbd7fc..fa98bdb11ece 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -1011,16 +1011,44 @@ static int prueth_probe(struct platform_device *pdev)
>  	dev_dbg(dev, "sram: pa %llx va %p size %zx\n", prueth->msmcram.pa,
>  		prueth->msmcram.va, prueth->msmcram.size);
>  
> +	prueth->iep0 = icss_iep_get_idx(np, 0);
> +	if (IS_ERR(prueth->iep0)) {
> +		ret = dev_err_probe(dev, PTR_ERR(prueth->iep0),
> +				    "iep0 get failed\n");
> +		goto free_pool;
> +	}
> +
> +	prueth->iep1 = icss_iep_get_idx(np, 1);
> +	if (IS_ERR(prueth->iep1)) {
> +		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1),
> +				    "iep1 get failed\n");
> +		goto put_iep0;
> +	}
> +
> +	ret = icss_iep_init(prueth->iep0, NULL, NULL, 0);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to init iep0\n");
> +		goto put_iep;
> +	}
> +
> +	ret = icss_iep_init(prueth->iep1, NULL, NULL, 0);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to init iep1\n");
> +		goto exit_iep0;
> +	}
> +
>  	if (eth0_node) {
>  		ret = prueth_netdev_init(prueth, eth0_node);
>  		if (ret) {
>  			dev_err_probe(dev, ret, "netdev init %s failed\n",
>  				      eth0_node->name);
> -			goto free_pool;
> +			goto exit_iep;
>  		}
>  
>  		if (of_find_property(eth0_node, "ti,half-duplex-capable", NULL))
>  			prueth->emac[PRUETH_MAC0]->half_duplex = 1;
> +
> +		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
>  	}
>  
>  	if (eth1_node) {
> @@ -1033,6 +1061,8 @@ static int prueth_probe(struct platform_device *pdev)
>  
>  		if (of_find_property(eth1_node, "ti,half-duplex-capable", NULL))
>  			prueth->emac[PRUETH_MAC1]->half_duplex = 1;
> +
> +		prueth->emac[PRUETH_MAC1]->iep = prueth->iep1;
>  	}
>  
>  	/* register the network devices */
> @@ -1091,6 +1121,19 @@ static int prueth_probe(struct platform_device *pdev)
>  		prueth_netdev_exit(prueth, eth_node);
>  	}
>  
> +exit_iep:
> +	icss_iep_exit(prueth->iep1);
> +exit_iep0:
> +	icss_iep_exit(prueth->iep0);
> +
> +put_iep:
> +	icss_iep_put(prueth->iep1);
> +
> +put_iep0:
> +	icss_iep_put(prueth->iep0);
> +	prueth->iep0 = NULL;
> +	prueth->iep1 = NULL;
> +
>  free_pool:
>  	gen_pool_free(prueth->sram_pool,
>  		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
> @@ -1138,6 +1181,12 @@ static void prueth_remove(struct platform_device *pdev)
>  		prueth_netdev_exit(prueth, eth_node);
>  	}
>  
> +	icss_iep_exit(prueth->iep1);
> +	icss_iep_exit(prueth->iep0);
> +
> +	icss_iep_put(prueth->iep1);
> +	icss_iep_put(prueth->iep0);
> +
>  	gen_pool_free(prueth->sram_pool,
>  		      (unsigned long)prueth->msmcram.va,
>  		      MSMC_RAM_SIZE_SR1);
> 

