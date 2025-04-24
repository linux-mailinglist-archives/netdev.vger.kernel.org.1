Return-Path: <netdev+bounces-185646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994FEA9B323
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3B646519F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC227CB2E;
	Thu, 24 Apr 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4MTT0R4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12BF86331
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510147; cv=fail; b=iEz5vS0DxSeVmQt7dazbnD+tyIprYsdfyKsT7s+43KhtoWqDc2Q7+T+E9zVxfnB/CJDt+7eHG6vGwhYJaP40NGbv1NOFh5CxXw8HHy9DIWfSRa+IpNUoFXkY0H6A7XEVpubyK2pZI2EGDKYH1UD+blgdDXBg8vGaw0iGY+ctXWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510147; c=relaxed/simple;
	bh=RyqDsJo0C77m8vvxpkjkz8Om5k2fFeSquPcE8oMXRcc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KsmguV731qRgdBrQqqQb0+JUUAS0KfLhJfl8cH3atzYnYa6V4kdGb2ol7Il8yDcT4zD1vECvX8M9LQiVYTEv8NW6H7QBbstErHfojtNhtqayV2vyaN8LpF/N2CtzJfdlEObdyAoH5zyQ4FlxGrKrQ5ez6VvxjIS+8EksDm830MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4MTT0R4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745510146; x=1777046146;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RyqDsJo0C77m8vvxpkjkz8Om5k2fFeSquPcE8oMXRcc=;
  b=i4MTT0R4FYIU5MIyyKEzVeLo/V3wTwfgsUAwzfUH8VyvH/UD2VouNrHD
   FUi3G6GgY+7+21fOHR/z8BrPYabFm1kVJ/eAPGN2MB+xlvNNwOMmqVM6P
   lj3kjmHh073cWX2zmCuf6xRkoKBhcM7wRtXr3Nm2FoKNUonkpnBmfarj8
   dKV5LmmXgqyLQWsKOemv+BEnz6oM5S/uDkxaRmsnK4PWKYtgjqNj5sZXJ
   yKr5QU+B2B0n0JEM+kYSvLkCQMyF3Gjpy9bQCe847XNBVJ3OpPyFyUkOv
   X+Ai6NxrJzLiaeLudiVE1u7aev5/Evv6Uy0hTMgRxYicpdrZZMtdF7w6w
   w==;
X-CSE-ConnectionGUID: /qYUl7eBTXuCmN8N3PkrGw==
X-CSE-MsgGUID: W84/IdUyR5edU1kDvg2CVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47285735"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47285735"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:55:45 -0700
X-CSE-ConnectionGUID: 5tT0PsMcRN+dYOEe776NWA==
X-CSE-MsgGUID: +FpmiGa0Tt+bqDss7YjXAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="169872942"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:55:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:55:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:55:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pV+WTGSMK4OzwB8erQwILpokSHFLO3893+wFEpRQN5Z9J0pOzt5g4nsv2WNFhgDk2siLtLkUp/AVo4mPPEx12X8e2bCF8qr5tqZztmiGuHP+ObnMl8nbjNAl7/aawyt4fKhXGMDof9u9YSl7EU3SL6KZOVm6IrkLsZTbylhEYnGqGQbggFUejp7WlTuDJjlyo07iMlajvG7gGKxUUHB5uG84nigLPsI+JFqWBDb8PG/Q/vFRNK/FtVP8lhwePl2knrVUbY5ame9df9hzHYR7XLNNtFFYPGt9a/z/AKy8vb76cPfV7y5rWWTY2hCfuKNnWb6LQaQCjQwFCwlbjeNpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4fXaasdHIrZxjuvXplCTEvMYb8oER2V8YTx3Q9qdjc=;
 b=BMiEwBsqdTuTe+QQHvqO1VUgJ6iLX48YQYZrtkkoDGiXLBYY+J0IATsJyQOj+gNMZBeViWxhvmx0GPfyr8Ld1gUIxMendNckhR1kDRq/o/KMrzsFjwhkIebly4p2gIwViKOX5gdElGsJtoNolll8hnyqB3X65JwaeCFEDARveeHuc8W2qpdM9SS0lziSOdiKT5EgFVguohvoqZsRPJeqOi89hbX2ivsmCmiCMSThzzbKLNtBljqUj4sM43LWUGxDZZ8sRPnHZp3ci7Eu6ww0BBwMNHcV8P+4W8nj5bpRp3o7j7Q2FaX90r7czFXLhlHTOBQRk//YsNV933fmCazDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Thu, 24 Apr
 2025 15:55:35 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:55:35 +0000
Message-ID: <715b9cb4-55a3-4df1-a87e-c8eb852d3e20@intel.com>
Date: Thu, 24 Apr 2025 08:55:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] tools: ynl-gen: mutli-attr: support binary
 types with struct
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-9-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-9-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SJ1PR11MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 5253452a-b501-46bd-5e19-08dd83487308
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlVQNVdtK1lsMGRVL1Y3T1JLUUlTTGc2RVh5NTF0L0dvTi92OHA4Qk01aERC?=
 =?utf-8?B?OEdCRlhZaGtiQmtKNlpSMEtLZGFkZVc5RDVwRVFOOUlveVoyOGlJZjhNaE5t?=
 =?utf-8?B?V0pSdmlnUUpkUndBaC96TDgweVlQb2VDWjZ4MWpyZ3psZGVhSjhXVjdqN1NV?=
 =?utf-8?B?ODd0SW85MEdVVndSZ0FRWFF4RGptZVhaSE1pWGRFQ3ZocE5NK2tYREhCTk5Y?=
 =?utf-8?B?U0J5SEMrRTU4eEFQUjIyNWkrdDhtUGp1MCtnbTF4c21weGRMMVVya0d1TlNT?=
 =?utf-8?B?VWtTbEMzNjQ2NWg5bjFZc05ydG5YSlpQVFgwTVFQVm9BQTgrWkR3WU9wRVNT?=
 =?utf-8?B?WkdxQjNyOTBTbjZ6Ykd3N1VGc3VocEUyRzJGNDJPc1NQZkpKOUFjNTViNTZm?=
 =?utf-8?B?MVNFb2JKUDVEdG5hTnB4b2sxVmlna3FuZEFOYmlzYlZEWGtaL2k3V09tc1hY?=
 =?utf-8?B?YzZJTzhoSFVlMHhQdlVjNFdkTGhFK1Y2TitqK210VXpBbFc3QTFqckp3NjhC?=
 =?utf-8?B?ZjdYZ0NSY2FlTkdITEVNVHU5R1c0ZENKektlN1NYMDJ0VS9JY1JmZzI0R2NK?=
 =?utf-8?B?SjFEOXVHQ0t3UjdJL2YyaG42bEI1b29nQzU5SzRYUC9CTmgyd05HY2l0MzlI?=
 =?utf-8?B?ZGl3ZXcrVWpGby95U01tckRVYmhOY2dRZEIvL3dTT2ZmV2ExeGV1UWV2R1VB?=
 =?utf-8?B?M25Ca0JSQXVYWlhKZ2NETGRqQm4vUTFwU1JNQTlyNTJ2RXpjQ3hRNDB5a0li?=
 =?utf-8?B?aTBmUDgwcnNKa0ZwL0w0UU5tUnh3UXRBazdNVWcyYjF3emFyOGhMTUxIVzNV?=
 =?utf-8?B?MnEvYlpCMW82RlJCZk95MEkvcU01UFF5N3gzV0pXRUh6emI5UXVabHlMcUNN?=
 =?utf-8?B?MVdIS0hlR1djQ04yd3VQenl5a2c0dURPVk5WbW1LczJxSG0vWENSbFM3MFdo?=
 =?utf-8?B?OWF4VFZta0FkOGs4RmQzZk9QcHZPMDczZXM1SFFQQ1JWUm1KUVdjc2JUakxt?=
 =?utf-8?B?QkpFcU5nMGdST0ZlS01jZU1GenI0cEZyeG9aRnlBWnVxczVGeWlza0htMkpB?=
 =?utf-8?B?QXBaWlkvcUlnL1lONXBMeFg3c3IwbFBkRXEvbWVES3czandXS1lRQzBlbndN?=
 =?utf-8?B?WThQUGhoOTR3TUkvRDF5SDRvRlNXV0hMR05uZUJkRW11RVRlMTNReHlMWHky?=
 =?utf-8?B?OFluZDcwWVJyaUpDdTNRQWtTWW56U29QSWdsWXpPd0djTy95ajIvOWNMSlUx?=
 =?utf-8?B?bVlETCt3aXhuVHNuR1NFSlQ1WTB3WWFHc1ZDVE9GVXpsaVc3RnlSZlV4czdu?=
 =?utf-8?B?ZXJQWXdGdi9hZ3Y3bDdoMnRrKzBLeXBhYTlLdVo5a0V0TjZ4N2o5ZTRMdlVV?=
 =?utf-8?B?RnlLbDJ2S1VMTGxKaXh5Ym90TFhPUVpMdDlBcWZROFRWV2YvSUpaOE9LWWZU?=
 =?utf-8?B?NU9ZeUQ1T1RYYm5BczZrSlZXWTNhTFZFRWY2dVVWM3RZazF3cEtIL1hFdVBi?=
 =?utf-8?B?M3FFbVVWVmI3S0E5VUlpZWxkTmVrNm5COVRXNm5MVW5EQ21sb0xrTnJ0Z3l5?=
 =?utf-8?B?bTZCeTN6WFhWL2E0eWx0SnFpSjJ0REh1OU56enJuc0hJM0pLb2k4TEhPVzlF?=
 =?utf-8?B?cVF3RGs1ZklubWozeEpCMGkxNUdLMk43dVBMejdMTWVhREd3SGRlWnAwcW1R?=
 =?utf-8?B?c0NYNTFoSWFReURvQVRwS3oraVpGN1AvdHdCb0VhcHZGLzFBS29JSVErcEdJ?=
 =?utf-8?B?ZFN1ZnUzaWtiOVgyc1pqYjlYdkNoL0d5OUtGT0wzbnZwTUljWE0yRUo0SW5r?=
 =?utf-8?B?cS8vNWJhS1hMZE94eHd6NDhKQjE4WjFSaTRVMzBjM1NYSld0L3RoRC9wYm81?=
 =?utf-8?B?ektERkhKcWo2T1c4Q255c3V2eHRUTGJnNUpmdVFYRFZvd1d6MWpwcWRoZHYw?=
 =?utf-8?Q?49Tcb4ENU2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVgxdUlhZXBGL29kK0ltYjJ0eHdWaXpiK05SaXltNXFKbHlvcU1ITUxaaVNV?=
 =?utf-8?B?MEE1U05Mc09mKysxS0ZoZHdadWlmN2ZZMHA3MmNRdUxpVTRGaGdGWEhDOHEy?=
 =?utf-8?B?M1JxTVFrVy9PQkw0U1BycFg2MTg4SnlVVjcweEh5S1dMdElXeUU1VGZDNkd5?=
 =?utf-8?B?cWpNNDhBREp2N0tzaVh2dDAzOUFkekVDQVRqczc0QXRTMzZ0ZExPYWFHR0Vp?=
 =?utf-8?B?V2NvaDcrVURENXZSeHlVMlQrSXkyWWZLRndZUERXSWpkakpPYXlMTTJCUXVR?=
 =?utf-8?B?cHpGY2MralVubVZvYTFCbTBha0ptRW5jSlFFRm9KaWxXMHZHRk5yQzdyNXRz?=
 =?utf-8?B?aDUxSUxPN295ZEpoTWVaRXNtclhEYWJvTExGcjV2ZXZqTE04bjZpOWdWN3Fn?=
 =?utf-8?B?TE43ZXA1MVZnenZ1clpyb21UTkZ5OE85YU8vazlTeHNlWitUeVVjbFZRTW9i?=
 =?utf-8?B?Yk1zR0NTT3VTSkZZT0tnQ0pIYVBKZUIvTUswSzRjSXVUcGMvUDR2MnIxdElI?=
 =?utf-8?B?anlrNzBxSnpPVXpqaVQ3cnlRK0lvaGhwNW9qMmd4QyswL2V0Rjl3SlFmUi9P?=
 =?utf-8?B?azRkNG5MSzhTbFdYalRWcHBxRFBXQVdTS2FUVjVVVE54dUZkNVRwZms2ODFM?=
 =?utf-8?B?RUp5QkRiczlFRGtYNy9ibEVBaG9wS2d1Y0ZzdVhrMHRCWHNNOHV6Z2Rzd1g1?=
 =?utf-8?B?b2RmUUNpdzRJL0tXY0ptd00yTDZUejBFSUFCMGVsWWdjSmxzTmFrRnlNTGJ3?=
 =?utf-8?B?VEI5cllySTdabFN2MERFa1pLWWFYcFdNQjI3SHl5WHNMbXJCTkFnKzJWYWdj?=
 =?utf-8?B?R0FEZ0VWc3ZpMTJDTXBQSExGN04wSnVwa1BpZUZQTzJ6QlU1aHBES1NSeCtN?=
 =?utf-8?B?OW53aTEyQTdVeVd5QVlJa2ZxYWhWTG51cEpPZkJOaTdyalJYNjJ6WjlGdTd1?=
 =?utf-8?B?TElDUTFOZERKZjVqSDZENm5Wdk8wT1pXMHljbDhUNVJrZHlkTTVzTXZSYmZw?=
 =?utf-8?B?dG0wK3g1VkRFbTllbmVnT05hWXRTL2sxSmsrbCtoeFlFVjZDYTdENmdteEdi?=
 =?utf-8?B?Zlp2MVNKR0pWM2QrRGFzWlV1TVRFL050Q255UERHSVBYclNheVRLN1Q5KzdF?=
 =?utf-8?B?bzZpMTJBVEhBWXdXRlBnSFBZaTE4bXl5RkJNZUV4czJRTHNBSmp1bFQ1ZGVt?=
 =?utf-8?B?aWNzNlpCOTZ3b3JGZzNJOGlSYWkwUS9GS1RRdnlWeTA1RnRFd3o1aEZtSW43?=
 =?utf-8?B?MncraG5VZVp6ZzNYdmhFbWhFVFVKbG11d2lTek0xN2wzYmxWSW55M21YYkZ5?=
 =?utf-8?B?Umx4dDdycUs5c2dvajFRZGhtRW1hUkU5bkZyZ1J5RksxTXFIRFp5UUxuOEc3?=
 =?utf-8?B?K2c2eEExNEZCNWFVN3JSRFFVT1IxbXZ4bU5vQXRSbFlZU1JjazFqUUZtVnVG?=
 =?utf-8?B?WDg4ZG1kb1hWU0R3Yzh6dnRiZzB3Y1BSU3BJUEtaSEl6M0d0d3RJcC9NZ0dw?=
 =?utf-8?B?WFpvTDIxY21PdkN4WGNXamxWdXJDQWNxd1lVYU13VEp0bThjUDlRWWlxcjY5?=
 =?utf-8?B?TWxYdnpSa0Y1Q1VCcXE0Q3JEMWx3b0M1T1FkSXVneVpGKzIzSU5FR05VSnR3?=
 =?utf-8?B?dlM4RWc2dExOcVM5VXZUcnRzSExmTEpPbnp2bTNMdGhjZ1IvWE1aV0NLQ0V6?=
 =?utf-8?B?aDk2T1NwSnI3ajl5alpxRzF4WkJFamhSRmZkZTVJM3Z3b0Fqc3o3TlVnQTA0?=
 =?utf-8?B?SEhRZ0U3MEZyZ0lTUE1KdHpIOEV5MFRoR3I0Q2hoWkxVd0Znbkh3UmNicVB5?=
 =?utf-8?B?dENyNElaMWFLcFFDWDh4NHJQQnloakoyVFpscmpKT09ya3BBdkIzdVg2S0Rn?=
 =?utf-8?B?TUplaWFORFpRTjRzWFpBTThyTGx6a2xkMmdUQnNhVUszY2VCZlgwWU92R1No?=
 =?utf-8?B?UEJlT0dqVW9YSG5kVk9Ea0N3SE8wYjhRVm9UUDUzeDdTU1FXcHFTa0ZrelI0?=
 =?utf-8?B?dzM1M2dXSURTRFZJcUtIYmp0YUg2QllsTTVWeEhZaGxIdzVIL2l1aTVNVmVN?=
 =?utf-8?B?c2dFNEQ2NVQ0V2NFK2pGZ2hKZmlpYjFOZzYvVWYxdzlMOFM4YVczdGpJU1pR?=
 =?utf-8?B?Y3lMMGJtbkpMdzQxY3pQUUI2MklWOWxvN3ppZThrYzVDcWRSWFF5bit3cnJW?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5253452a-b501-46bd-5e19-08dd83487308
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:55:34.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTllglMZHgwBLwkHPJEb7gp7DbEsIWuXhLmUOC/kFMKl4L5bXv2gQR860ZtA+bkWjtf65Gf3f1ZccwG7RHLWeqoARQiczVbymNut9Evy11U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com



On 4/23/2025 7:12 PM, Jakub Kicinski wrote:
> Binary types with struct are fixed size, relatively easy to
> handle for multi attr. Declare the member as a pointer.
> Count the members, allocate an array, copy in the data.
> Allow the netlink attr to be smaller or larger than our view
> of the struct in case the build headers are newer or older
> than the running kernel.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

