Return-Path: <netdev+bounces-177801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2743EA71CE3
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE8A3BBC9E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA61FBC8B;
	Wed, 26 Mar 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmjKbqQo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E291FF1D5
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009329; cv=fail; b=ogzsnDh83PED7+suwX3Nk2cVzQHAPgIUdfGcwsS2Zf7Ax8Aa1utLt342m9iiRoWPdg4RK+gVtTCK3GEjw89NO64t0EdKJMAtPGcD9FSo62YhgzH+zNOf+RN7wL2uWz8sNtKptSWR3HHSoJWWAXnWwqIluACCKcdHr5N2b4Qwi/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009329; c=relaxed/simple;
	bh=vUacGhkAsktPTwIjGl02f9aIt1snQO4ZdPERNoyavkw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GTuF3I5dbH9UavzmjOB5zVahv9rX0xjuY8Q0mUvPxBpLZrT/UUpk3/lzo6qRhjmBbKdpWEAUORY7UikqSmBFfYIKkLc0PODIOdmUK6qZU//OTaq9uKrXPYKgE5i3cOT6XNJmv80Qv6fhi8aBnUUdYmpClP3lj8C+y/U66HVCuKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmjKbqQo; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743009328; x=1774545328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vUacGhkAsktPTwIjGl02f9aIt1snQO4ZdPERNoyavkw=;
  b=ZmjKbqQoJbGI5lihVCZSkuzR8DNPPA1srGtiA0B2z3AjbYm8quyNNPxp
   Q/XIi3waw2sQ0dvGdm12hVY+TefphboqXCZhTzKmxG4ziR9HcHKRzjE2c
   KdOa23fK3uGJOHi3DR9VfKHGgHzBVUushIULyOfA3iZ8fOW+f2CD1iHly
   fVdeeZhl1CaYRkheXT//XnxVbR93WkpovHZtwYhld4MTyEF24fwZWQAtf
   bIWiQQGrlG5aAtmb17YcXeEVD7jfYla4kh9keHvcN01aqF6k7vNidOUiL
   d9mnolq5/ZHJG2L5072STbdEZMDD9faLU6yz9dbL/R5GgxiYCKoM07XEC
   A==;
X-CSE-ConnectionGUID: S4I61AGITiCURLKkgItnOA==
X-CSE-MsgGUID: rNAUiLcoS3GAnQx4y68fOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="31917449"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="31917449"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 10:15:22 -0700
X-CSE-ConnectionGUID: I4uIXqY/Q+Wq/K+lwbSaRA==
X-CSE-MsgGUID: uW+UoPaVSdSNSMTQAxzM7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124809985"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 10:15:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 10:15:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 10:15:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 10:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG0QR2yTyJvPWOAQkCiYstJUtaxnXzgQqCQIkdycFam0lxy7HEFRGBSUsqnlFBhOi8j3lBygqoSGMQCOuNDNx0MsEG+9qk9zCpxUIit5Md9ht/V8cxDiQnXhlVMnbyb1YZgJgj6TUz9Q3aHZynZ6WK7RQmikHunKop74b7cdGYK6tG4fageINjlR4UgTSgXzXhj8dMAT4w/2uGWS148TQoS2xq9bba9g+Mp9F0yFxquc0BCuENgW3ZfY9+qjUl3xlUdIoXkI3RiaoEfyeHrVKq6Bz9DHLsYk0hQM4Otir8c/M6v/U1XwhnY0IGE+yrkCdxkbDsXsNxFnEoVoihWtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq13Eid1elbyPfdLKRJcKvhuzWwfzUgh/Ty1zyr0Vec=;
 b=ImU8NtlXpcd29MESISbqoEF2Mfh2ZdjHvaEAvMc01iPO17o9ERMAUNAY79Bnkj8p01QUGTcsjkl+m2nNrhj5Y3PX372QyfZ587Ym6+6V/Gl6wP4dxUbmV2OVD2HkxUzuf99PcUROT2vu6lAFRF20Bjf5UbzQWLer6OtqhOTNp2qbDlrdelCNH5BQfq7QwOS1e0PalK8MWapsqkq4dKAcx/TlUhqdZJRacT6u6VVD3108if8U5plKFcak46rwkcXDAvDa3PnM1hDCphU/UOhLAHAtgmFZhRLAPkf7vmVtVoSf/+cxhto9ArbYrHb0X+LF0Maw/a/zX/V0k5JFCgLzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 17:15:02 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 17:15:02 +0000
Message-ID: <452e0969-9811-4853-86e0-ce1be0b848c9@intel.com>
Date: Wed, 26 Mar 2025 18:14:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/2] idpf: add flow steering
 support
To: Ahmed Zaki <ahmed.zaki@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <anthony.l.nguyen@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <almasrymina@google.com>,
	<willemb@google.com>
References: <20250324134939.253647-1-ahmed.zaki@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250324134939.253647-1-ahmed.zaki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|PH7PR11MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 525aa51e-edbe-4e6f-533b-08dd6c89be6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnA0UXU0cnMwdlFQN2RrZ1lvaVdQaEpBSDFZaEV1b2RjemV2enNKMFhzM08y?=
 =?utf-8?B?MG1MSDFKejNuMW5tWWc0SUZJWjFZd2tCMHFGSXU4U3RSM0Uvd3BocWEweEFh?=
 =?utf-8?B?bXZNVUUyOHlHdDNFbFNGYys5WTBENUEyWkxzdWlvdWw2OGdhZ2F2SzJBckx0?=
 =?utf-8?B?eER0QzQ4MFdxRENuSWkyYzNiVnlIUC9JZDFSWHQxSmVQeTdCdGhRNU5FUXd1?=
 =?utf-8?B?R2xSQzhEeHZxbXZ5ME84WTJIMHcrZGd6MFgyUG9UY293aEd0WWRrbkgyRnd3?=
 =?utf-8?B?aWthOTkzS1o0WjI2TVdvbzRjeGd6LzVhK2krc0QrS1JtQ1VUaEpUVXpjMHlZ?=
 =?utf-8?B?NkZHeDBHcG1jWE1ieGpFTm13YVRieENZTTlQb1ZzMkJlTDZDQzN5SDRmNFUz?=
 =?utf-8?B?VDErN3o0WmZpRE95dVZLUEI3ankzY25kZkFjQXl5UjloSUZxUDVERURYcXNU?=
 =?utf-8?B?bUhXMVB5L0syRFBtMm9UL3RXT2ZwUVJnMm1QWUUwbXUyZDRvYUVPRmZKc1VT?=
 =?utf-8?B?LzFOR0djcmRjK2lhKzIvNFIyVTdQV3Mvb3d0bG84d2todWhRS2hxM1BEdkVp?=
 =?utf-8?B?THdncm10SE96T3pFaXBnVHhSWXArY1JjeXhlSDkrZlNmejBTYmJSKzMwcUZ0?=
 =?utf-8?B?YmZjbG1ERVFBUXRUYk5KVXRWcGVjOWlESmNFWmt6UGJOZHc4YUhEU1pZU0N1?=
 =?utf-8?B?QzhlVnR4YVpTemZRT1V4enA5bkxnaDd4cE5qbXgya3VwYkg1WG54TzdRZ2FL?=
 =?utf-8?B?elZwcC9tMDFGbUh4WjVrRWVaWUhCUElPT2ZEUzR1WTRGdmMrZkRHSzhYN01Z?=
 =?utf-8?B?R2dQNDdvVWVrMXFXMEt6cFJnYVFRU2x1azd6WkswZGwrRVpHZlZ1MjFrV09z?=
 =?utf-8?B?a25LR3lTVVNzaVlzK2ozMjFvUWpURTlZMlQ2c3FDNjRrdFY5WFZNYzUzcVNr?=
 =?utf-8?B?c2xaWHlnenNKVWdTZTBzTFkwRENmMHVqdmJwYWc4dEllczhLN0JreWdtSzE2?=
 =?utf-8?B?YWZRZ01BT0g1ck1PTjJoT0tTbkVMUXBsMlNhakpxUHhBTG5sQTkzeVV0ZytD?=
 =?utf-8?B?cjVCK2VSYWovSFBJa1hvUm9oSUVBSkxOWXczSURscU9iUGlRV3FOL1RuNzA2?=
 =?utf-8?B?UVR5VGx3S0ZDSWd5amRsSndQcU44SmtvS08yV3FLSmsyWWdWYSs2YndKdzJh?=
 =?utf-8?B?cElJZS9mV1pEVExiWE83Z3pCODdKY1B2WHRIN09LS29PMWNLelZuamNpMnA0?=
 =?utf-8?B?YjM5S3ovQWYrd2VaajVXL0p6aXdKY3ZPbTcvM2tKOWVtZHIwMEwxM3E5a2VI?=
 =?utf-8?B?KzFhd2x0elVDQ1FQL3NLa1NJSkRITm5UcENUTFhheXYzRDl6a3RtMjZybUZl?=
 =?utf-8?B?STVPc1k2V0xMTE5EVTIwN3dldCtYOFd4amlySTdBMVQ2TW85Vit3R2hQdkh4?=
 =?utf-8?B?aEZwTUh3VzVOT0NxYk8reGRmU20vWUpBYVh6RVdoZHZMVnc1YjRsTmpaa3RN?=
 =?utf-8?B?LzFUbHB0Yk5heXgybXprMFlkTytkYTF2Q0F3TTJoYVNwMExrV1l5M2U5bTFv?=
 =?utf-8?B?am9yVmxZRUFhUUxLTld2RmxsUEhEZnpBN0prZXY4dFNpNi8vR09iWXZqTDZs?=
 =?utf-8?B?aGhDQm1aS09SSjA5Q29ITHU5RlRZNnRFTGxWRWJFeVBrc1lNc1FMSWp0LzA2?=
 =?utf-8?B?MXhyNmFLNmJzdTZiQkFUeVZiWGNmM1B4bFJlZDM5cnNmcnBhZGR4clRzUzZp?=
 =?utf-8?B?V3I0L0JZY2J2YUhmeVpPWG9WM2Z4UGd6TXhrMkR6TlpybTMrcWk0VWtZcmQ0?=
 =?utf-8?B?QmRCQnRlaEdKajc3VGt1eVRiZnpyMTNtMlozbStWZlQ3QjN1cjc3UDllcElk?=
 =?utf-8?Q?A298QfXOfeqLH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVQ4c2xPM3pqZjFNdVVnZmxScHM4SHBidUt4UUZFZCtIcFdtMmVBL1lMMFd3?=
 =?utf-8?B?bTgvZGZ6RUFDZDA0cVdYL0N2Q1BOR1g0ZWhrakVwTGdicUFzVEpBZnh2M3Zp?=
 =?utf-8?B?TDVXclNXeGN5TjlrNmpqTXJOZzRpeFFNS1p4YkoxbTZJZDNLTm85Q1YxNzNv?=
 =?utf-8?B?aUhzeXZxWUg1UDJNQkszZ3Z2Z1lSSE50V0YwY2U2WllxamsxbEx4ZGtBeFNa?=
 =?utf-8?B?MGJoeUJDM1RDNjBmOVBrZFNDcmhqZVlyTWhyZUNoQUxlUWp5MW5FRGFwQXJM?=
 =?utf-8?B?T3VaTmh6OTNwbWt3S2psYVlVU1VuSTZqOW9SNHpZTWpGZ2phUGw1QUpzanNB?=
 =?utf-8?B?d0cwUTdkc3c1TWtlOXYzS3JFdU5zU2FWL044TTIyZkVPWDByS1QzRTgrT202?=
 =?utf-8?B?bWs0R3Rkcm9SeUZIWWhySzhvaXV4ZlpHdldEdmlwWDN5aFZUemMreklaanBq?=
 =?utf-8?B?aXJ2NVNRZ3lFZzVTdDlBb1BZdUQ1bGhBR05hdmNaL0dFb2gzUlBVeXpoWld3?=
 =?utf-8?B?ZFJ6SWRodm9KblFLa2JpRFovRW1kVDVFbjZDb0p2MSsvWTBOWDNvOWVzOWE5?=
 =?utf-8?B?dGYxWUNDcUIxTEZQcmVLVTFtSm13Q3BMd0JjUXdTdzZJWnVlbFEvSGxaQ3RS?=
 =?utf-8?B?c251OFV2Tm1RQnQzL2xWV3dDZWlkVFU4Wmh3SmdnV0MxN3RZM1VGeEhWQ0NX?=
 =?utf-8?B?MEMyQkswcE9FSmNsSmlXNjVQLytLcGFMRXlzTVljZEo4a2NzeUlheHE3dEcr?=
 =?utf-8?B?UkFBcjN3V3ExazFneG9IUVlBaUJ0L0grUlBQSlNybGo4QmxNWllMb0M2Ukla?=
 =?utf-8?B?RTZ3K2EwL09LNHJESUlhY291eGkzaFR6bUwrdkQ4d1RYWEpVU2pGNlk1TzdB?=
 =?utf-8?B?ZVFtaXVDUUhxZDJmYmlQVzE4YTMrRnlucjVJMWFhNWhsRGpJVE5CMFo3RnF1?=
 =?utf-8?B?YVZ2dVBwZVl0UmM5dGg0eDJSZFZXUERvVzhyUzlid2xDM1UyN3U5OW12RjI1?=
 =?utf-8?B?MG5INzYyOTlGV3pOY0tCL0FVWHNhYmtkS0Voc3lpNTFaOGRpZjZzb1llb0M1?=
 =?utf-8?B?N2lLVFBBSnMzNDVtcWs2bG5lWVFNdHVTTkNzdHVRUnkxNU9UVWxIelZmMVo1?=
 =?utf-8?B?OGJTem5MZ0M0amxWZ0FxT1pydGxjU0lydDVlMzNCeitJTThCcGVLRUU3YS9r?=
 =?utf-8?B?ZTM5S3VBcTlsTXlTbFNEZTY5VEpsZXVaU25Vdm5JSEd1NGZUMXhnckFoNDBU?=
 =?utf-8?B?YkVmQUpOL1VNVVFqdGJxYVlZcENpcEhrSWxGYjNmMTJORjRwWlIwb2RNL0Q5?=
 =?utf-8?B?VEVRRnF0ckViN0tpWVk0U3h2c0VibGxjdFlvamtvMWR1cEFPb3VVUWN0VXN4?=
 =?utf-8?B?WFJYRDYrdHVZMTRjNjFaM3RqL1hMemhRZm82ckg3aytCR3NhKy93QWEybUNC?=
 =?utf-8?B?UW1Lbnd3MlBqUWlRSHVkY04yTE5ZZnYxWC9Pbzl1eVhrbFdQQzg5azhMcWY0?=
 =?utf-8?B?Y29BODRwelRCRHo3K1RVcUdMNUt5enVkQ08zeDMwNm5mMlY5ZFkzS0tPUXVJ?=
 =?utf-8?B?T2g1VnhoYVRZWjI3clV3V1pZWit4QnFkZ2M4dnJKNVNLdHRKc2xHMUxhdWtq?=
 =?utf-8?B?VUdncEd1ay9xaGpzcWRlMVFQOW42alBCcmlXbks1bnE2alZadlBBVVFDaCtx?=
 =?utf-8?B?NFp3c09xR0thTkFidXI3ZjJLNHV4YWE5bEtoWUQ4NVVhM0lNQkpDNU5oZWFl?=
 =?utf-8?B?dUxUUU1QUWNESUlxMFIzenkxOERBWWxsSFhhS0hIem5ZaUxxWS9UTzh0Ym1X?=
 =?utf-8?B?UXl4TkF5eFFiTVMrbFNnRGZPYk0yeUJ6SFdQS25vMk5CYTJYRU4vMHBTd3dY?=
 =?utf-8?B?UzZUS2FzdlFkRUlJODhZdDgyaUNKcEV5ZXJPMDNhOGJ6WXZKQmFvVHc4dFVr?=
 =?utf-8?B?Q09wajYwb0ZkNUgrMXgrM2FIcmZRUTZKcFF3YXdweDdKMEZPUmlNOFhZcWQy?=
 =?utf-8?B?K0VjMnFmNnROSktuYm1hWUhoT1ZjRk9XcXNCT0kvM3pTbEpGVEpzUXU1bkVF?=
 =?utf-8?B?OEdpUWJoQ2U4bzk1NUFGSmR3NjVxdFhXYW90amV2bkpDdTcybHdLanhtZVk0?=
 =?utf-8?B?LzZzVWk1c21WV2wvaFJzNWdPcHlxWkN0UHhIYWlvcmNNWFM5eGNENXNrUVZp?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 525aa51e-edbe-4e6f-533b-08dd6c89be6f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 17:15:02.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oMOxHxLnU8Flwo2Sw002OLE8JZ6uSiqq+eRMc1DHsT4UntJlLV+dTHU/M9Cf45i2FNTgFMDYmEZvRdA161QXRJkEWQQKga3wuXEyd+RLxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7608
X-OriginatorOrg: intel.com

From: Ahmed Zaki <ahmed.zaki@intel.com>
Date: Mon, 24 Mar 2025 07:49:36 -0600

> Add basic flow steering. For now, we support IPv4 and TCP/UDP only.

1. Very poor cover letter. I'd suggest describing a bit more here.
2. net-next is closed, so this is RFC at max.
3. I haven't seen this reviewed properly on our internal ML.

> 
> Ahmed Zaki (1):
>   idpf: add flow steering support
> 
> Sudheer Mogilappagari (1):
>   virtchnl2: add flow steering support
> 
>  drivers/net/ethernet/intel/idpf/idpf.h        |  14 +
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    | 297 +++++++++++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   6 +
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 104 ++++++
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +
>  drivers/net/ethernet/intel/idpf/virtchnl2.h   | 233 +++++++++++++-
>  6 files changed, 650 insertions(+), 10 deletions(-)

Thanks,
Olek

