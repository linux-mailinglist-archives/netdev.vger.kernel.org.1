Return-Path: <netdev+bounces-72572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A1858911
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2201F203B0
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2A13AA57;
	Fri, 16 Feb 2024 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CK5Cqhv8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945417BB9
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123466; cv=fail; b=HmDtjc4EDsThqHzo6SRCKenwgBWrpQjNjorRXOxEGFYAi3OPMFRuGvVCX4BKuOsLlBhv739JmV3JkDk8l4QRh6J698FoYDbDRLC1j3zYmLszIyPV4v8x2drWohbFh+5HBnYlAEnZrXWpLvEs0ZuMA62nvgK1UYbKsXoI0eG2IQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123466; c=relaxed/simple;
	bh=+1Tkeq7OzsrHytomEJIHtNxVYpBS8P+guN6U7KD4KvY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rS2AZ5/iCsO6RcXj1KR7x3SOwIYO7CeLGQwu5NcN2saKYw90Mk+z58YRNPWALQe8hCCCcm8qbtZlAXuqoreXGO5Qm31Ujau57Crwp3+6gFv8tP/vXDU7wMIohUicz/i919zrc2e7y8CG4UdsLb5D5yXhqbx3TEvT2RQRkscmrP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CK5Cqhv8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708123465; x=1739659465;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+1Tkeq7OzsrHytomEJIHtNxVYpBS8P+guN6U7KD4KvY=;
  b=CK5Cqhv8bjx/FQj/lIXD+nBRXv8aZl4SjRkcvrvkRDhWCL7llC22F12H
   rZQxJoMn0I3zNjRyNGL54ywzSs0D06VE1jvgGUIN9ALU09Vg+DPgVxovP
   fyOx330eBhd4LpOWyNx5QMKJXDIBWzxsFjev2JccUz0NcJA6R2XhK78FK
   seyJzfGYe+mOmo830g8c6qfXuuZXH17I2JGFCDIAiXLFIqfiO0NFTFDKl
   fviHhgFfBeR0mttYTDXLkpWzVbLEOKsWF1ejjpxLCOl5bv07gCu3nvxGZ
   tNMjEP7FZy9kduZLox7wSBQ2CFSrOKulFkcpaufVJbTPrK/uMmk9pWK5d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="19689463"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="19689463"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8619517"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:44:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:44:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:44:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:44:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:44:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqOUvTrWl/uFmT6FUuTVTmlsUeap3njphe9cDEYtSQIEp2I9KCqWwrsvX5GEi6Ss1ZLWI2HQSTDSzg6iuWOJ7HV79y4EP81WiQYKwX6nFV5KYGEuQL12ETYibxRXpcMT4uVK+XZoMgRh5gDyjnc2Og7Fkk73OhVUV7y0er4qAD96ahhoh8JqaO92oWZQ0VFbNonzwDf6hxJCBUPG++71w7L889H6pMR+hVVjziIJZNzfqSffY3mGG3rfVbSFCHjGpyryHp1ggSdOA90HoT6YyUTf4iKamblLpRcaWpKDWfi+4pGw+CdnW1sc9ktgCo1guCcAlZVuFJfpQ/gQpLt8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHAUR1bwn/ii3moepoXYFHCEzsUpS+YWmuPjnQqB9wI=;
 b=WOrSA6GJGsJO1YMiQmwyDyOfPraFk/Np9ATMC2+lbXUKAEpCUdpudnN6X2LQrweE28n5rJjdRxZ5UKb7Szeh0rznQ855Wh85Jsz7XzPhDpFFy0LeFYhoggMv/+q7ivXgrdkeZD4czm0bRy8oehRmUEXKoNSRLD96t7ZVc9IcUL6Xq1h+gWzYWYqKX1smettnIKqDhL5/2IdXsBVf4bEIDRjf508TgVvFmy2df0TqgXiV067mu8vMWAcP9rracIfP2Dh+tZF5TS4DnT6kEtT/vVt8blQgKDEDkkTcCtWGGF5Dk6HQqmYIzZnOt+7G/cB9ccO2qWETQotFqbU1GolRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:44:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:44:20 +0000
Message-ID: <9a4c20eb-dcd8-414b-9ada-0007dadfaea7@intel.com>
Date: Fri, 16 Feb 2024 14:44:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] i40e: Use existing helper to find flow
 director VSI
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Ivan Vecera <ivecera@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Simon Horman <horms@kernel.org>
References: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
 <20240216214243.764561-2-anthony.l.nguyen@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240216214243.764561-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: aa348d39-d1d1-466e-7f5a-08dc2f40d069
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiFRhvJBgxHFUL6CyRs7nQyK32DGQ6xIa9K8V356u6v6cwugbBClEYIWdo27gKYk8JR7gFfU7D2lved+bKQOn8qu1p2cmUwWTjNaY2Mfz9t2POzYVtAAm3ljGrviJ11JQr7wcirqjjTT0qxERO7YMv+QrfL543BQYFEVT3Pxd0UmeB16p3LjTWfY/19OWNF/sVGvSTK0fnTtgrxkSURh+yQAwkLt4LaE1zTuP14u89olnYwIj4UJAwsaR8WvJNdYeL+kqEUwzm65HzFvnmY/eMPRwgAcperMczk02msTj5CAtcXO7JkvbCIKD3emWIs5yCjJVozoHyqj0BzIev6lWNsKGEs7lle42h9q8+tPFmBTVvy9c65xGtW2H8L5j5znGVDOYtAw0PvOsbNP09G32sSjRaEgA7HCYdPwMv2j66980QTWdV9T4lg0kiQ5IqkIrCV9w6TOaGfPb4G4D2DyfmJmoBHgzo8ZQZaf/Ponvyu6wdeJTuG6rvKZdJ/e14ZHVyH9oe6eoWnzyhdO+kZ1T9quC7Ze+/oK9krtpjptAc4gStjDn6rhhQ8qymlbqXHC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8676002)(4744005)(66946007)(5660300002)(66556008)(31686004)(8936002)(2906002)(66476007)(4326008)(31696002)(86362001)(36756003)(82960400001)(38100700002)(26005)(2616005)(6512007)(316002)(53546011)(6486002)(54906003)(478600001)(6506007)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNTcG9wRERrUzdRSHRqODAwVE1mQkhkWVhZUWdlUlA2dWs5Mkx1RTgwMElK?=
 =?utf-8?B?ZlFPQ08rWHA3V3hhbitlamd3cE1oTmd0YnQ3OW02RGJsU2toZ2JKQmtLbVJ5?=
 =?utf-8?B?S2laQ0E0aWthQ0VORGU1R2RTazMvVGtFelhvQkpJYjRJbnp2cU80ekVRWUlh?=
 =?utf-8?B?MzFuN21OTzV3NzVIbkNJSCtBTk1jcXUrOGVZSERxWktOejRpelRCNnZrSzBs?=
 =?utf-8?B?WDNrdThkYmxnR3paYTdLYUVyUlZXU0tZZFZ5SGZ5ZjIxUm5SdFZOMTgwd3hi?=
 =?utf-8?B?b3F1MzEwMG9Gdjk4T2tBSVBnR0c1T0JlL2s5TUphZXNRd09tbkgzQUh4UEFh?=
 =?utf-8?B?MGFGUXdxODIwNEZjcTRLa0R3QTM4NGp4M0NlOUdRclMyUEs3RGRWUFZZRUc4?=
 =?utf-8?B?UFhGMVBFd1RYSmE3c1U5M0JQSGR2dnF1MURhQWd0Z25PbWhGVExGYUpaZ1Nu?=
 =?utf-8?B?MFRKb2FRNENxUXlFUDBERWtXQWVyWlN6Mk1OcEZkZitCTVdXQmI5dERuWHQ1?=
 =?utf-8?B?aFdDSzVMSytvSjFUSEVZL1FacnZIaHo4LzA5b3N5bHhkcVdjTUUwMG5JVEMv?=
 =?utf-8?B?a0JGakMxOFJGS2IyWTArZXBUSjhlRFVOczVyVC9yTStoTDJwdUZnRWdNakpK?=
 =?utf-8?B?NDNMVVI3SGl5WEVBUUk5eng1ZklhSjE5ZXJkWmZKY1dJZHpRQm10dW83OHZP?=
 =?utf-8?B?bUNmQXQrRWR5WWNmU3QzdjJwSUZ1VWFRL01leithc1VGaG53TnRRQ3N2YXJh?=
 =?utf-8?B?NFphUWJvemUwb25jWUN2dzB0ZlBPUkY3WjNRREJFcE1IV1JzbnNDbytCUlND?=
 =?utf-8?B?aG1TOElxQzNPZkdXM3B5QWNrN1VZUVAxTHNQSFlXV0d5RlJHOGUvdXRiSUNx?=
 =?utf-8?B?TFZoMjh6cnJLRStwSmFBUjQvYzZiTzRTTmNQUXVjL3NreDM3R3k4dzY1ejIz?=
 =?utf-8?B?VEVzL0VEbDkzd0RhKzR6a3BuclNPMkkxVFdkMzJ1U3dhZWh1TUxWMTd1MFBU?=
 =?utf-8?B?VGJXWjIyYmNHczl4cHJHckZvc2hQbjFCeGZpRitpNG1UOVlNZS9GV2E5M2E1?=
 =?utf-8?B?V1VENTZHMmF4c1oxTi9sc25VaTJQQkhJMVdPeEM4QUpxTC82ck9PZG9sNTRa?=
 =?utf-8?B?aStQYXdJTWViZnFQQWdZd2Z6UUo2Qmo3WjNTTnVhTTZwVjhVZzZGOXYrMWxR?=
 =?utf-8?B?K0JsYjMyeEZHUjRyVGZVdUF2ZHBPSWdhenFxVEFEZXpOU0NkK3BHVjQ3MkdJ?=
 =?utf-8?B?RUkyYnhraitqSlVudWxnVWpMMkhrekMxS28rTktvdXR0aFJnK1N0SVlGKytw?=
 =?utf-8?B?eGpQTS9HRmh4YWdYNkRJMEFjam1uYk4yRmJXc0lUeEF1SjZpN25QbHUxUEtl?=
 =?utf-8?B?M2tmMG11dXJaaDNmUWcvYm1WNWFIeVVvYzNqUWozZ2N5N3Ftb2t2ZEtJT2lG?=
 =?utf-8?B?SzgzYkhQMmZDbGlDR1B4NGpEbnRtQ2EvMzRIWDRhL2w0aWhwR1NDRVpBQzVB?=
 =?utf-8?B?RnlqS0V3a0dKSHRLdHg0M1FnZ0V3RWZuYTRod2xaamxqTVU0ZmY1RlhKUG1h?=
 =?utf-8?B?S1VDVitGcjVLd0dKMXpRZmJZbXJQQmVyK2VRbmE1MzZDbmczSGVxcTZPL2tZ?=
 =?utf-8?B?Z2NuYms0VUoxaStFbEprZUdWVmdyWVJQWGJkRVpQOFNCSDZkcTFOSUpzdS9j?=
 =?utf-8?B?S1h5S1duKzJTTWR5Rk52VEZkK0RSaDNqTlFaYzlYbGV4c2w4OFdSSTZQYjdD?=
 =?utf-8?B?RXZISGVxMmlCVFVaYkFLUEUxaU1uck1NaGJJUVNiOHlPR043Y0NSOUxFenVh?=
 =?utf-8?B?c1J5TFkzUnNkYnVhWTFEOFdhTml6dG1pbUo4QjFySVpxN0wweWtadEs1Q0RZ?=
 =?utf-8?B?MVNPdTRWVzJFclBCbUFaNkZEenYzU0VyWGxjRU1vY0ZpZnpEQ1h2UlMxTkdz?=
 =?utf-8?B?S1Zxc3FzNWxWSTlWalVsQ2FrcGRVNmQ3dU1vUHptVHBJdVlKOTBpODdYRWlr?=
 =?utf-8?B?SkdyejI3TDYzT0pFSmNvaWYyVmI3RU9KUEluenFSNHU1WW5yV0I0ejAxL1Q4?=
 =?utf-8?B?VVlORVRYbTEvVmtLQjhDT1c4RlRvTm4zM2IyUVlzYUY0clNZNSs2bC9Gd3JF?=
 =?utf-8?B?SDd0Wm9KWStIMmRwbXRoVVF0OGxvSmtoRmpRMTF4UEd3Q3NRSzFFM0kyWWdU?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa348d39-d1d1-466e-7f5a-08dc2f40d069
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:44:20.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LATWfeAauKYSFNmJqnry70EBXzWTKRM0qEikOf+GECvqUXtHLK+XJc9aN4rMC4czXQc01IHCRbRXRXO65rVf5bBSWHpN3/SAXRDDLYEIEAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
X-OriginatorOrg: intel.com



On 2/16/2024 1:42 PM, Tony Nguyen wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Use existing i40e_find_vsi_by_type() to find a VSI
> associated with flow director.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

