Return-Path: <netdev+bounces-207816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A238BB08A19
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DCA7BE0C9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73551291C35;
	Thu, 17 Jul 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4iSNb4k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E8D289808;
	Thu, 17 Jul 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746331; cv=fail; b=ozl2/1rsCLT+9Rl8Ed+R6D3L6Q5lUHs7Z28bNYRJvRkDHI3gKGfCOjMhmBkBZOCkYJSYtXzV/g43l3wB30H66JnCqsa2bxjq35r0makmk7+HYSy2rXJIKL81Saatg0GC9nRkcjZc+BGBn4pGXUntDRHGAiK9/smBPs/C27Txk9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746331; c=relaxed/simple;
	bh=lRArxOtkKsW9faJ4nKqBYv+a2FJnqgTaXRgsdfq0Zds=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bhoILThYf9y2i7uJSJSY+8FgzrjPEEiYBPhlx/stDn1KafeUOhYmSsvlZIqi+7Gm9tXaH2oahZyXpQZ5pVIX5ga5mSmMEY3EOXe8ktH4zWiwThTU+t/JgH6cskZTe0sBfRaApHfCJ3Hlgarlbh+IAG5Jsinugq1y+9knjeCheyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4iSNb4k; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752746330; x=1784282330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lRArxOtkKsW9faJ4nKqBYv+a2FJnqgTaXRgsdfq0Zds=;
  b=V4iSNb4kMKToxkoPOVwMxA3puAiPhs3bftviTHHHDqVd7hwIAUuhE+pq
   8CAeUOerip2WnU/N58PRu+wzi0GWtTVjNiSzq42XPJeAnrcJIYMqTii+z
   xiYMRV9D36+f3DYDS+TVtnt05IrHWB1l8H+ijlkmXGdlSPa9B0RkoIZc9
   DLz1suDR2Bh/wpbEeiXwdKWRCEhD0DFmj53XANxF4zrhS8DwFhHrJvBGj
   NemHJU8HmD6+31/AVMKY4ozdLS7yUtnnl1JlYfrpnrDY9FFNXnA2r/sAZ
   JMvkHXlHWqckZdfywsHjwoj5MXAtSKZJN5lBr65DzEHGxXptcCol/E2Am
   g==;
X-CSE-ConnectionGUID: TPx53k+0SViKSr/nrYZ2lA==
X-CSE-MsgGUID: oxHfmu5PSgahDM6YT4WAWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58824536"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="58824536"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 02:58:49 -0700
X-CSE-ConnectionGUID: KNytd/lRQr+58IwnkCJy0A==
X-CSE-MsgGUID: gylVmJt6QLm5T7vZ5KOHsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="157425355"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 02:58:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 02:58:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 02:58:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 02:58:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEmCO9ORrGXfhDB73FY3G08sV4lZ//4j0M9GOe7I66uprbjp/dlhU/ffUHfgkvDLmUJpJXrMFaLmbE7CxpJcd9iXBPOAweC1m3t7nXTEFtZThDVZbNrVlaALjUSs985ZfcLevjH3kUUcLbu+3ROwqROvqmLuyH9PTiRLgldtT7CRPB6YRRnb1NXlExqxfz47dxIGRFFuzP0DBG7/idBpIIx5xDhLuEOacgpvMC8rT6d4at7ll3EYm3xyhbVTxmvYO+gtYwwFaSEY0D+TtfudkDUFER+awiwGiIXcNKbEHYdzCAVa7YYvGDsK1jLdDEhZV1e99eQOCD4X2LxIAoQzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47KwVyrQoJ+2k71uoH48OaKzj8uZAoZaPhBDl+zy0DE=;
 b=eK8s9aH85/qqqcu0U5GYC1l+J3LIg5ACPjcecVQvJYsmO2XISHNSokcDjx+F+ABtn7Xily4oSbUd029cOz57teDdJ2ykjQzCC6hXfjdZn1+225DQuvG3zjp5m443Qh9V8oFrD9wOENimL2bSjtUPEmdTNuXT6c7X5Kn/d8OtEhxZ8EEmgQ/g2TD0bNLF0uxFcTWOArhUxoTggq4ls4j7xxylcpkeuhuiSAx+Jx2M8p6p8N38l/okq7N6HdehY5n6SegmkEGDy64IV5FCNj2igr7ilSqfHuZuPVLPU8E5vaGPP+Y8qGcPtclo0hzaUI7MCNDPUE44ve8lUADpk7w6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 17 Jul
 2025 09:58:13 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%5]) with mapi id 15.20.8901.024; Thu, 17 Jul 2025
 09:58:13 +0000
Message-ID: <9abe0c53-93bd-4037-bc5e-a6888a0dcc2d@intel.com>
Date: Thu, 17 Jul 2025 12:58:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] e1000e: Populate entire
 system_counterval_t in get_time_fn() callback
To: =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>
CC: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <markus.bloechl@ipetronik.com>, John Stultz
	<jstultz@google.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|SA1PR11MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5d13c2-7e13-45be-a8ac-08ddc518718b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWRHZ1p2VDRqZU13RjRKSEkreklteWU1aTlJaGdYUFlaU1dEZFJIMEVzdzlO?=
 =?utf-8?B?UzZNazcrT1FRU3Zvay91YkxKa3V1Y2szTUtTKy9lZkx4UFhoNE1PNnFsb0dT?=
 =?utf-8?B?MGlNbE90QnhLV2VlZTRoSGJYY1NuRU5oYUVUN0xrRHp5bGxHWkt1dU9qNzZD?=
 =?utf-8?B?MFIreWhXZ1VUNGJEOW83MUR0WkFOYjJYK0I3ZFc5eUx2b2VIc1VFL3ZITTRq?=
 =?utf-8?B?dVVaaVJ4UXhJQ1NQYVVPYjNOOW9aT1hCUER2UENaMHEwU2paenNGNEdzbGpE?=
 =?utf-8?B?YStqY0lCbWgwQ0dqbzU4RjB3THQyNGJRWUV6dko0dk5BR2pKSkFFYkVjTXpj?=
 =?utf-8?B?WVZiZU1qMmN3dzRPd3A2VHNvQXB5U1liY0FYUjlCYjVGYUxXNmZMeGNJeVd0?=
 =?utf-8?B?MURYRjFEQ2ZnSXk0REYyZWZNaEIrL0FIcE52T0VrWWxTd0FXTnlyT0tNWEQ5?=
 =?utf-8?B?V3J6RExFMjJMeUpjYWEzSWR0TkRlVmE0SzhBQlVxRU5ZbUVkeUwwcFpKR3Q1?=
 =?utf-8?B?WkkvT3BHSW9aYjBkb0kwMU9ZWFR4K1ZmT2F1ZzhUbjNIdGQzQjB2c0FBNXRD?=
 =?utf-8?B?SWw4Nm55OUF3d0hETkppSXZXNzVReDVjTHVFM0VMRGZEcmtCWGdlSUNtT2Nj?=
 =?utf-8?B?M050cktGQk5MTlFBZE1DZ29FTUR0VmdHbWZMalB5a25hRUQ0eDRNMlZpK1M3?=
 =?utf-8?B?ZVltVklnU2hwd1BXbWJBRGpaTXlvYklqWXlaWXZWOU43Q3BnV1FHcWV4eVpK?=
 =?utf-8?B?ZkRyY2lhdTNleVBEcy9ueXNNVUhOOFJUOUhyQlRDV001ZFdxQlgxTnZOTWRY?=
 =?utf-8?B?Z0pLNlRyUlBDYi9kSEFsN0NMLzRhZ3g1TEtHczVjZGpFMDBoT2FVd0lHMTMx?=
 =?utf-8?B?d2xwcXI3OEFNYUkrTkU4cVM1S1RkUFI2S0VaUTdLUEVQcjNpSnp5MTBDbFpC?=
 =?utf-8?B?R24va1kxOWdqbW0rS2xHaXNPWks1SytwV1MwbE5TY2tVTHFibkxoVTJvUSti?=
 =?utf-8?B?S2xUSGpKS1FUL1dkYm0rbEovcnVkTUlEVmwxMU5FcVZGdjhWWFI1RG9jZmhW?=
 =?utf-8?B?MkxFTGRUYUZtM1ZBaUFPTkdjcHdUV21aOTZFMDVmNnk4S00rVVdKeWlCWUZi?=
 =?utf-8?B?NjlzQ3FzSlhUamNPVVVvakxXQ2lycnQzbkVyUG83QXd0ZVVEbTE0STFhSUdF?=
 =?utf-8?B?b3hRNUZWbGJvWit6T2d3OWFGYTVyR2cxQkU4VXYyS20yQXNvak04Z3h0b29v?=
 =?utf-8?B?MGx6blV6bVNROU0vY3IzRVBoTG80OW1ramhocmVZZ3JJK2N0cTdlVVhJVDAw?=
 =?utf-8?B?bVpTcEJOVVQ1ZnpSZ0ZQKytFY1JnTmxsSktmcFRWU2EyR2hCdEZBZFJxbW9z?=
 =?utf-8?B?VVJrREtQWUpBaFIySy8yc0tNSE1ZekZycGZGTWFRelBCSXlMY2pxRzZNNVpy?=
 =?utf-8?B?MHMzb3dpZW4xeDgyTnQvcjZObzd0dDdNSG9nNThIQnMyN1dJQnNlck1JK1VW?=
 =?utf-8?B?S3Q2Tmg2bzZTajJsUG5VNFlITnkwb3BiQTNXdTl6cmw5dVZDQnRNZFl5Tmcy?=
 =?utf-8?B?aGxFSko5M1l0aUJJTVJidm1WbmZnZDB1RTM3azFsOG03SWYya2ExbEpkVldN?=
 =?utf-8?B?QzNLS0VIMCtkck1lN0NqK2NBc1pnM3FUcGdsSWM4cG1XMElQZFdFVWMyZWFa?=
 =?utf-8?B?YXJJbTNJSVNRMVVBTHFvUENiQlhCd3M3TTBGcVRSS0cxTFNxdkNqamdZaHNX?=
 =?utf-8?B?bHNuSzROWENvZDZVYjVKSlZCeFdSUlEvRCtZbnRBNW4vWXh4Zll5TTJaUWc5?=
 =?utf-8?B?NkhHYjc1N3F1VzIxTFh3aXoyaTNxNlZmcFo3QmJxekJ5Rkl6eTZkQldWczND?=
 =?utf-8?Q?GPA+NTCwepeTb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk1TMFhiK0xPdCtSWU5GbURHeGh5bTdzOUxVY3RQMEo0WkkycVNXMGVZSXFQ?=
 =?utf-8?B?RUlCbzh3NHVBM1NJemZML2h4SkVFVCs2N3B2UU5ZYmVVWUxnODhPaGd3OWsv?=
 =?utf-8?B?UEF4dDJvMWc2c2tXRVFELzUrTWtUMXcyUXNDeGI3ZDh5ejlNMTZJT3FnMjl5?=
 =?utf-8?B?elArOVpTbWNwUWFuUlVHNG02b2hVUDhheXRlUXczN1NOT3phVEcyUng3TWNU?=
 =?utf-8?B?TWVLejlva083SUl5ZmNSZDBtZjlKc1VQZCtLYy9reFZBc0Y2MEFVM2FLSHR2?=
 =?utf-8?B?U2c3dU43WWJmalJDL3FCVTFkV2xWbDdKMWhrQ2xpeFBpaEpEVzNleHFJbWZs?=
 =?utf-8?B?c2p2bi9pY0hsTGRXWnBwRWxONFJoZFE1SEoxdEg0bDN1T3VIN2JySDFjL0pl?=
 =?utf-8?B?dmpEckQ3KzhxNzJ5ZWVOMzR0QUc4dzhaOWw2TWxvbjdlbStqNG94RkZTV1FW?=
 =?utf-8?B?dkl3Z21RVlBveHVBc3NYWk9GcjdPbU1LUjNCdGsyeEUzTzUwa1JRN25xZzJ3?=
 =?utf-8?B?MkMzV1RRM2xKVFQvNlBFbzhvT0J5VSs5OWxmNnVrOTVHY2EwVVhoMGcvSTFx?=
 =?utf-8?B?UVBGZzFYZU02TkhQWHFmSCtNN2hPVm1FSCtTN3VXQmFoT2M4Vy83ejU1cDJM?=
 =?utf-8?B?TjJKa1VPR3BLSlh4bllwbTI2M01ZQXoycjhwYWQwbVJ4NEpzSDQzdm42WlZl?=
 =?utf-8?B?ZW83Q2JuRzhFb1dkb3N6azBIODI0cVR3a3o0OVl4NWhvOURXblljdTRiSW9l?=
 =?utf-8?B?eGJ5ZlkveDFLSGprV3FtWkRsYU1UZmN1cjI5cjFlc091T0FGa25GS1RKYnZZ?=
 =?utf-8?B?ZGhsNmlsRUphdUJ2anRpdWRqdlZBYU81TGlROWR6V2QzSnhQdGk4ZDFSbmtO?=
 =?utf-8?B?dmF3Q3EvVU9aTXVhZ1ZkbElydGVxbHJmOEZIeDZQaWkyVTlZTExGVkluN2NF?=
 =?utf-8?B?YW10TU00YTJLakF2U0N0TGZPdGVJQnJjSTZyeDNDUjA5M1lHVHZZVVgxUy9y?=
 =?utf-8?B?UjJ1akQ3OEo4SzN4eDg0cDI0cnY4YVhvNTJTb20zL0VuU0RaYzdFME81QnpX?=
 =?utf-8?B?ZERPSnpRUHR1a1BzNWh4V2NnWFdiQndtUXJwcDFXZjF3MDVYT1RleEdCVzQz?=
 =?utf-8?B?Uys3VnNOUWpQelllQXlkYXBBM2VMUU1jeEdVWlVvTnBuU3ZTUU9ma2RWMEJ6?=
 =?utf-8?B?SnlUVk5laXVnODdLQkZIaVE3azlYK1hQcTg4SjFWNENYQ3Q2VUQ0OHdIb1R1?=
 =?utf-8?B?d0JtZG9Cb2V3TFRGaWZSNDR2Y1NtS2NiM2cwVnN3YkFCQ1U3TExFZDE1SERI?=
 =?utf-8?B?ZHgvK3lzZUJhVHFmTHprS3B2SzVaTlpld3NEU2lNdjVyOUpNM25TMVJSRnow?=
 =?utf-8?B?NVd6NW04RU4xRmU4Zm1IbW4xVjdYb0dlVlViMkhmUnRkaG0yc2QyUW9FcDhP?=
 =?utf-8?B?NzZBbnkwTmlUdS9ycVh5S2w0V1M4cXI0OGlobU9ySDdMRm1OZ0xvZE1GTk1V?=
 =?utf-8?B?bFpDYmNuMkEweVBSZmlQb25uUWNmNWEyczhnZWhoUGRtNEJmNnNnUUdFWTdJ?=
 =?utf-8?B?OTdOdklTUVdHVzZSSkxTZXNLeTBFWitqTzFJelE1N1B1b1psU24wbXEzNEFJ?=
 =?utf-8?B?TnhMUG1uOFJoQ2Zaa3hpeGdWekl5YXI5WG92WTgyV2xVRDEyMm5aY2lIOXli?=
 =?utf-8?B?c1ZaSTdiOG50M3h3ZVRaaWhIMHdNazhOVUpJcWxJOGRaODNHS0JYd1p3a2lU?=
 =?utf-8?B?UVk3azdjVnVOaVNibENVbGQ0K2FzZFBEdGdIRWMwdEZSTktFME1kY0VWYWx2?=
 =?utf-8?B?S1l3cXVhOThmTWJ3UlppbHgzOG1ZOG5Qa2tzZTlPYnRDcDhPK2JOZDJlMXFF?=
 =?utf-8?B?UlRsc1grTTFHdUphVlZCZnMvNVVTU0RKQlVibGZIakZPYUF5K3hsdEo0Szdy?=
 =?utf-8?B?dFc0UGVIUE9ISG1UaTJLY2RsNHd1VjBUODNMQythRm9maU80M24vcGd6b3Fu?=
 =?utf-8?B?Z3JkaFVKMnVhdDNpam9yZmhjLzl4cXFpL1BnR2hCeVdpRnU1ZjJNVTNkT3FU?=
 =?utf-8?B?bXVZbzRvQjFFUFVQT0gvQWRCZzdFK3k1ZVZ1ZUR0akRSckZ2VHcxMlFBbmY3?=
 =?utf-8?B?cHcvaDR0MCtQcnkrVy8ySjFkUnkyMGozMktCaVNRK29wd0h5cXZEWkVrcmFh?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5d13c2-7e13-45be-a8ac-08ddc518718b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:58:13.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tvHXDq0L1S2yZDih6t+OqhhfI3iqR6dCnVRE4PbihHqpKsEuOGEWi4f4YW+wDuAMZqhA+mv7x88/832a3C6xzLCxDsr7scK5keXyTljRWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6805
X-OriginatorOrg: intel.com

On 09/07/2025 20:28, Markus Blöchl wrote:
> get_time_fn() callback implementations are expected to fill out the
> entire system_counterval_t struct as it may be initially uninitialized.
> 
> This broke with the removal of convert_art_to_tsc() helper functions
> which left use_nsecs uninitialized.
> 
> Assign the entire struct again.
> 
> Fixes: bd48b50be50a ("e1000e: Replace convert_art_to_tsc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Blöchl <markus@blochl.de>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
> Notes:
>      Related-To: <https://lore.kernel.org/lkml/txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo/>
> 
> Changes in v2:
> - Add Lakshmi in Cc:
> - Add Signed-off-by: trailer which was lost in b4 workflow
> - Link to v1: https://lore.kernel.org/r/20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de
> ---
>   drivers/net/ethernet/intel/e1000e/ptp.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

