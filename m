Return-Path: <netdev+bounces-229571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A001FBDE5F8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23DE7344B5D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A553233F5;
	Wed, 15 Oct 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RH4sECbV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA331AF1D
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529740; cv=fail; b=tG5/fF4z/WXKqPO3GWoyECCSufaDwGKutmPHhO09cbLT7cMDBjwFdjmcOgjngw0MW26chX8SKpK7GcW5zNoQG9FqIecgOkYmFBvphEVaTGsSW1HslsyJ8wuTu9TqNejisMKB+I4HTMs2bAJb6sIZQjURsMGmYem2+y+OQjmlMQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529740; c=relaxed/simple;
	bh=9IcUJHO3fCOWem4luSjyUJO0l94P7NfWtCspU+7OTrI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e57KEG4eznEMjQkerNViKdorzTVssqV3I9aZg2EFNIxdolUtd9V7j2+RybqA/pS934xTQtFT9RHh82ED9UScFFwzq3AyvrlNTAfbah9CwTEiiveOiTTEXWhz2AYmj0xJt8xCLaldK/hL+Z/3arkyMAi5mNentJGn3LoWXy0nyY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RH4sECbV; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760529738; x=1792065738;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9IcUJHO3fCOWem4luSjyUJO0l94P7NfWtCspU+7OTrI=;
  b=RH4sECbVEmqlPwEfJ0t7+wZkCE3MbkfPJ9rM+UYTderHX+bEFTzE63mc
   7Ets+VVbGIwBQsmDgTx9kyLsRL1m5R/Sp6kWW/yyAkSP2qwXSGTqjE675
   qAEXE9hMdzF5Nb6BNJBFByqFbNuZ1ujj9Z6NpD4Pj9dBFE5+xrTkTlDUh
   o+DeV2kRMSYzrVaqqvUNeAGpim6yBfxcKzcjGqawNGAnNlMmLIeOJQUtm
   ye8d1P1Hi9xb5gtpWJQQdQHYdg6XUGxSewrkpdrmy4iQEGMzZ9sy1XH2K
   u+9eGARXFkW5qwc64JHDF97568WYCZS2Usg8W/zgECABZNSZOLR40FMaR
   A==;
X-CSE-ConnectionGUID: EoG0vFoZS/GvRtP6wQ+ZlA==
X-CSE-MsgGUID: 7nUzuyjVSA+25o78riwEJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62410405"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="62410405"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:02:18 -0700
X-CSE-ConnectionGUID: kpDUnUq0T8C3/hXu4PiyeQ==
X-CSE-MsgGUID: 49XlSbxMSx+cFd1jIzvZOQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:02:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:02:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 05:02:16 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:02:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsfH7QNvYteWlkVBa8jc4udwoDtsCW3VFMJvmzNNLth+GPk0x+pAJLZoEsmRAYbGsFpIzBv8Rue8r5oxywgOXBBdozCPMffgBQF1EUuQVYTLuVDKVGJFNgVBi6zuDvgoX6VOIIPC3kLtS3uJVIFG7b+NVB40E/09ogvUSpoYvEu9YbhK1ZcfUVf7jKfI+OViWdO77+qdzHV7uAUVQP9OsHElUVxQC/lUqJ0CwZvM9YTo4vkXU4ihzmv5dXStUJ4+Be/Mbw9aQ+2FwPZxqpjw+raHGQtKrRTAD6c14sopJn2I2cahS0a1IuyWTbnf1LB7A8boOUPQK7SLLY32p2ZaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdZ+c0zRvleMFPkwdnVWgC1RtevmlNwg42j4E+yWVqY=;
 b=rD7UlQHxgS0IXODniXWsuv3bXjEAYwHw3MRPMoP4+GFjY6ZYcCKoouUBULcbMFKI03VftJAN4pBJF7iMz2Uqja3NyoVpK0/MsUGXgUDAq2+7gWx9CgdxqonHFyqoQRYsG/lvbQxclVDnyLZupyhHxTLypVkp1sX/xPkx5a3B2xnPN9m8xMza3vbknhtAC71r/F82iMu2b0IFczyRnrX8G5pQwFKCHFlQzwEWGtNLOG2NBnCxqX9nREr0OJByATFraHjLsMoYzd7bjzT52qfLeMZVeqWEHrczif68IDJVwqj8uzm8Hd8JGQ8lbDUW5kPSrzABvn/KV087c9HOV57qjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 12:02:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 12:02:12 +0000
Message-ID: <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com>
Date: Wed, 15 Oct 2025 14:02:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in
 skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
	<kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-3-edumazet@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251014171907.3554413-3-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0172.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b8faf2-ed8b-474a-9171-08de0be2acb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alhKQlBNdTU2SThkQis4eVd0YlNya25SV29nSWZNRnQwZDluNnRiZ0MzTFhB?=
 =?utf-8?B?RTZrU0NCcmp6SDFDSDMrK1Yvd2t0enhoNk5zd0R0ZS85UTFSaDVsak9UOFRG?=
 =?utf-8?B?SjdOMEVGbS9Tblp0cFZCWFljMFNzYW85UFRyTitWVkNuMUd4N2I5V0Q0MkpC?=
 =?utf-8?B?S1FLN1A2KzhrMEZhVnJ1eEFZUTMwWnVaelpCRlRpbHQ5OTJseXY4K20xOWtx?=
 =?utf-8?B?eEphUDBBTTJSOFhIa1RZZjBZMlI2bFlPUnlQRmpDQlhCc1hJTHNaSHZrWkR4?=
 =?utf-8?B?Z211RmVaelhpeS9WK1lFdEVUWnl0VGJQTWgybGJoVUVsRDFnVS8rVE9WOGR3?=
 =?utf-8?B?OUFNai9mZ0JWdmpSRGNLemxLbEoyRG5ZRjNTZkFVd01CQ2UxQitKTXIxTU5H?=
 =?utf-8?B?TXRlaCtjNlBRVk5CM2VzSVRmaUJ5WER2LzNhNlZnVjFudU9iUklYR3pDVm12?=
 =?utf-8?B?akUyS3o4cW5vMkU2TzdCYjREOEd6SXlSZ1NLMlVrRlVDaTNOOXV1U3FFcDBo?=
 =?utf-8?B?N1ZienNFbjVGMWdGTy9OVmdTaFd4OWgzcHBUSmdjbVEwV1VNUk5kdzMwNkdI?=
 =?utf-8?B?L1pGZlA2b1BMNk5INSthRTM5OENXOStVNi9BY252dmJBbXJqMysvaHY0ektT?=
 =?utf-8?B?U3EyeWZpblpTQXhPM3B0TE8vKzQ3TmJxRE9TVVptUSsrQWVEN3hrUURrbGov?=
 =?utf-8?B?cTVwYm1Qa2Nkc1FqN29jeUM4eEQvTEtvUTh0U2RVdCtaZ1NaRTBVanZCeEVj?=
 =?utf-8?B?ZDBvVUEyMmZjNzR5QUJtaXlYL3MwVVpSZHkzTlM2UDkreC9pZ3B4cHA5amZw?=
 =?utf-8?B?OU5IL0N6c25GWHhoNG5TTDhMNDhNcVhiaXdzOGVaQVJQVW9RNGQ3THFsVVhj?=
 =?utf-8?B?WHRNU1I1cXZOR0hQNDFyZkR4VmtKb3FzYm5DeVlSazBrczNkWU9zRnozbFph?=
 =?utf-8?B?Ty85TW5XOHhGVUtvcHE3ZHNMc3VuWWJMWFJSRnRCYzFwWUt0dEd6TGRrVTVN?=
 =?utf-8?B?b0praEhSNUt1MjN4TFI4ak1hS25HTGJWb3lpMnR6ejlzQzlqVHd6cWkvN0Mr?=
 =?utf-8?B?a291NnRaWFdGVStSVWE3cXNSbEJqSjZTTWhHUm95bkp2UVVuWnU0RDhSWHdu?=
 =?utf-8?B?MWZ6ZlNrVW1zVCs0Q1UvVjQvN05ZRTBia1ZkSDRsWlA1YVpsTWNoTUNSYXQ0?=
 =?utf-8?B?TGdEU1BNUkp1SlBNbGR5N1U4aFVmUlRDWXFwUU9QejErT1AyQ09kaVg0M0pF?=
 =?utf-8?B?c0JTRzZUQUUzMHZXQnZ5cTBkbUZKTjJYRENMcVR3Qnp1WDI5aHpDQi8yTnNr?=
 =?utf-8?B?dDdkUzlGRzFlbmlhVHFiOUYzbVQ2VXhTWWExL3ZnV3B1dHRNcTE1NSs1V1dv?=
 =?utf-8?B?VFFZbmFEL1c3aklFV0tiYlFhRWQzUHF4STBEWUhOdVFrM2Jjb0kzZUxnblRh?=
 =?utf-8?B?UldjbTZ4MzdteHpyZ1RNWWdtMWZhTmorSmxHUFNvZGRJRnlpQXc5VXlMbS83?=
 =?utf-8?B?Umtsem1iQk9jSFg3YktPNkVTZGxZMVFpZVJHUlpZUnh2dGpNa0tkOWwrQWM4?=
 =?utf-8?B?T3RwZUN4Rng3NjV6bXFVaFR4SHQ2aVFybVdBUDhZZ3lHdzdlS0FZK0orSlhJ?=
 =?utf-8?B?SWpNc3AySVBQZzlvWkNGdU9xZlJJVllFbHpLSU9CSExKQjRONklTRVpUeUh2?=
 =?utf-8?B?NFZMMW9xY0NmU0hNdk80WjNtRkoxQkJuSWlneElxWG9oM0lJVTBBamtjK051?=
 =?utf-8?B?SXlvWVpxUHJHd1J6aEc3bkpWZ3E0Nm5RcGxBUzA3YlRNVkIrRzBuTlVna1ll?=
 =?utf-8?B?NkI5VXY3K1VXTEEyL3EreU92Z2lISXBpL0FOeFBvdTQ5NEF2dWcxMWxTWklZ?=
 =?utf-8?B?MlU0WTV5WVZpUTBOQVJTaXJ3V0dKeWVMZExHZUYxbDRlR3JLQzJjMXNLV3hw?=
 =?utf-8?Q?G2fAtFkF+aATfkj/6ucTk+lM1EV8M+7P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWVUVzJlM096YXhidEhLZ29OTC93U3ZDYk45ZVBJY3IzTXhYRWZvUGx4bzh3?=
 =?utf-8?B?d3NhSXZOSUFFeDZ2eDZiYjE4Rzdwd0IydGc2ZXcrRStIK1dCaEoxQjVXVGZj?=
 =?utf-8?B?cTl3aytLZ2EvcjJLTm5KRXp2WjJhT2pneTdYQTgvT1huUFduNm9ZSGdEUS9y?=
 =?utf-8?B?UUlIQVIrME4wN3hlNm44WU1LS3hHUkxaUGhtU1d5WWhhd0UyYnh0WlJVbVZD?=
 =?utf-8?B?YmxlZ2Uya2kxa2dkQXFwRDFKVTFxR2MzNjFFWTZtVS9MZmZpU0Z0c0RJRnBp?=
 =?utf-8?B?Ry9WMCt5bmN1Z213R1oyMzdYSE1OME5hVlV5RDJUQ0crc3E5a2lSM0dPUnR4?=
 =?utf-8?B?WHdyMk1hcmZTVXQ5NWRGeDJIMklNQ3Z6UDZRbUtiNjhRWkYwODlCM08rL1Jx?=
 =?utf-8?B?cVBXYmJSaC9yb0RnZE1kUlROSWtjbVd4Y3lLSk1NcEJxMkNwaklDcWFFMGl1?=
 =?utf-8?B?VHVTNjZFVGU4NW5TSGR3UVBmV1lFZE53VDFodDhrQjkxbXRlR1ljU2U1c25T?=
 =?utf-8?B?TnlvNHBYRW5ISzQ3ZjVRRTB2RU9HaUVQazlDbGJWTEhVKzA3bnY2VERVaGNL?=
 =?utf-8?B?UzBISXRzVHc4blB1UGxNdG5GaWg0b0FtSzFvUzJqdHZ5cjZCVmN4WU8xL2Fx?=
 =?utf-8?B?MEtrSXZMV2R4Sk5yZXQ3RVkwK29pMjZ2bWNWY1RSMU9JOXAxUFFJaytsK1ha?=
 =?utf-8?B?dDhKbjFFRzVld1loVUFUUEpIY1pkL1RJUHpYU1V2OUkzelhFM290enJYUmFZ?=
 =?utf-8?B?TElOVUE0c1U4LzlTaTVFRGFvTktXcGlHbjBKMmxZdnFrZ3RNUmZpbFd1WCtp?=
 =?utf-8?B?akRCTmdBUkdYVzZud2FEVU1OQXdXdXNWU1RpbkVFM1V4cDVqN3FlZVRaRFkw?=
 =?utf-8?B?b3pDZEFXMExKTll5TUJQRmVTM2U1Z05JNjBackhSWU5xM1BsdzNwcFdZSFJl?=
 =?utf-8?B?bHhudkNRNEk0QjIwVEJwbG5pVFIwdEVMRXFFbC9hK3JTeGd4SW9YbGppblFK?=
 =?utf-8?B?UzFrTmcvY2g0MjRzMlBsQWJzbjhPanhpakdoZTR6RmhxN1dSUlVDZWVOcXIy?=
 =?utf-8?B?RUVFQ0xaVFhnK056QnJOVlMrWTRYb2N1cDZicHNqaFZSd2lQZGQ0aTF4ZWRl?=
 =?utf-8?B?aThOT2plajd0TXJmdU41blRwNlY5VjBCVHR6SWl0UXZtNWhHV2ZjNGVHbzlC?=
 =?utf-8?B?dHBvTWQvcTd5ZURLYU5BaGRNM2VBRVRCTk04d0tmb3A5TmgyTnhSMFRvTy9H?=
 =?utf-8?B?R1p3SHg5dWhlaysvSHlhZXV5Q1JYVHJNaU02czVkVDEwQ1ZrTHZxSEVnTEFj?=
 =?utf-8?B?MlFzMFRCR0dMMUhNZHNreUtHRmpBekt1R3NIUGFCeWRKNUgySWFLOGpaTFdB?=
 =?utf-8?B?TkJTcTMrNVFwWmw4aDZtektXcGVnUGVGWmhhbUgvV29vcVRlZDZKSmxkN24v?=
 =?utf-8?B?cXhQVkRZMXhjcGFWY2lDYVJRNjFrZGNUNjN0bVpXdXR1NzBlRU9sMlBnZzFB?=
 =?utf-8?B?NGRrWEF2RXN1a1JUdHRCd0RtVEY1cDFXOWdTNUVqaC90bk9LSnFMZ0tEbVkr?=
 =?utf-8?B?RVJkaEluVW1HWnRrVDEveTEyeDU4V1BWZWN4S0MyUmI3ZnJ3MUxzMkFXTEt1?=
 =?utf-8?B?MmVodnNKU3k2aEcvcWh1Tm5mcHZpc0xDRUZqWFI2VzVwaXRrdmM5STVSQm9R?=
 =?utf-8?B?Ymp4bE1BRFpiUjBEeWN2R1hOSmJWZ2htREdaVVFkOW1LNGNrN2ZTang3Y0tm?=
 =?utf-8?B?T2hBeld6ek5hMWVtdkhGSFBTcXV6NHlNZHI3SnVLTmhaRmNyY2pLMGdrbjBo?=
 =?utf-8?B?QmI2cmxwQzYzc3Z6d3VWUlJmSUhVSTNDcUhHWGVzU3p5RVRKMERBaFJvaFc1?=
 =?utf-8?B?cnR5VytIN29CSlpFYnlEYlIvVGN6SW5RdzFDNThjOTJHdXl6UmdjekNjb1Br?=
 =?utf-8?B?OW9mejhsejUwVjdIa21mYWFiNGFPbXhpNWRXUGs3dFR1a0t5YXBhTXBjOTc5?=
 =?utf-8?B?OU5MVEhtOTM2YXcwWk9hZGZuK2VrRW1aQUpGaU5WL05zVkowaWIzTEJva2pQ?=
 =?utf-8?B?bjgxSzhaWVI0M0hEdmRFNk9QU1JZTHVyR0hhVTNrSmFEWi90WDJOTmZ3enFl?=
 =?utf-8?B?cnJUT3Zhb2d5UnF6WDVWUVdVQy9FVWp3QjJEVmkyMmhDTlgyNi9EN1RxWUJz?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b8faf2-ed8b-474a-9171-08de0be2acb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:02:12.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWJkF9vKtyG4Fvv0x/6lyz6ksIDdq2d7mFhITXJLOwJzWgr134RNqdllcPjywKlpe32iWiAE8UGHkUPh9Ds+tbwg1jdiPyul+7aJikekxu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 17:19:03 +0000

> While stress testing UDP senders on a host with expensive indirect
> calls, I found cpus processing TX completions where showing
> a very high cost (20%) in sock_wfree() due to
> CONFIG_MITIGATION_RETPOLINE=y.
> 
> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/skbuff.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index bc12790017b0..692e3a70e75e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1136,7 +1136,16 @@ void skb_release_head_state(struct sk_buff *skb)
>  	skb_dst_drop(skb);
>  	if (skb->destructor) {
>  		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> -		skb->destructor(skb);
> +#ifdef CONFIG_INET
> +		INDIRECT_CALL_3(skb->destructor,
> +				tcp_wfree, __sock_wfree, sock_wfree,
> +				skb);
> +#else
> +		INDIRECT_CALL_1(skb->destructor,
> +				sock_wfree,
> +				skb);
> +
> +#endif

Is it just me or seems like you ignored the suggestion/discussion under
v1 of this patch...

>  	}
>  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
>  	nf_conntrack_put(skb_nfct(skb));

Thanks,
Olek

