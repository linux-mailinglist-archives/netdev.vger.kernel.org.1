Return-Path: <netdev+bounces-107172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4182C91A2CA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D35B2270A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936813AD04;
	Thu, 27 Jun 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l92WEWSx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223BD13A41D
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481230; cv=fail; b=SVeglmfMXHeuke+OXrqxNy97QKb34HboMyQzAa1C/x5F1RyKDkcf/5WYZMVuoD98PDwi1PV801INTHWWTtmuiv/IM6wan8psK1DDDWa9fdEeroNE8yOwKwhi9zaYZ2cVVNHbzplZltTc6AXz9dpNDpM6CXADGrp5Z+AZw1KfNy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481230; c=relaxed/simple;
	bh=Zzqyeob6Av0zXwv845W3mBnRmKmoUhYVRt/xbC7flF8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bkg2BBXdduZHyXNdDFgX8qH1Z7jvM+/MxWgC9RY02lcO81spVJG7eArfJw523unCrzjDpa5woxqnHKg2XCq6b/7kh0qv/bzumsgb99fBxzvYtp/riE+kJiaQPFFLlFG7gqwSPdTLXRh6t/MIhLrUNzmxlN7lwFgOqos9/DDxLOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l92WEWSx; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719481229; x=1751017229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zzqyeob6Av0zXwv845W3mBnRmKmoUhYVRt/xbC7flF8=;
  b=l92WEWSxt7U6fID8pNBTlaVzOSJntbu0Y5mKqeeh7E+us8tyR0yLMghk
   fmOud5N+0IFzpvmcI5Z4cChFW0uhcCUPfH2gXCLbAjaAZ19eVkC8F9CaM
   SorZet48gRXmJYkqugV6jOO116tf0NHyix19SbCGxgmEM4fIAsYNgITTJ
   jYGYMba6h7hW7nW8sJQgq4qVlM9O+kx45ZaKAXClLnIIpXi/5ZkPPENXn
   uw7Re3jECXqNXCYX0tbgpR1n0Zqq73OFYB+r7NBX47zF4TMO2rLMCSoas
   H/Lg8eVhyZWPU22H+H3DIJu+i3daVjSDppzIb0OGUl1Hwi6YB171y5c1s
   Q==;
X-CSE-ConnectionGUID: f+7H/v+TTRuFgXqznH2poQ==
X-CSE-MsgGUID: DwrDsTuoSLm8YEofjBxvvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27733549"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="27733549"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:40:28 -0700
X-CSE-ConnectionGUID: MtJhONgfTfKy6pMi7wAD7w==
X-CSE-MsgGUID: iujFjwlIRQuWSuLlyP8sBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="75068010"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 02:40:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 02:40:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 02:40:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 02:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msSMVYMbXg2GCKYDXYM0p5UhjuRy5jGzzyGFMyekHtpQCWpByz1BTo4zA2oAe7O4xfcjOVcguusr4pM2RZzCeJh8vb/z9rKvaKYIZyjCI7k5mTiMXBYMy2ZOHwf4uKhs7rluspDuIzGMIFSvrdBPN1ZN5ZoMH7oqS5bHGGiHZXgYq1fN9YXP1lVLy4VGN64zAJ/W7yXXodVbKJVSxBuCFiMe5g7F6MDxPWg/qoVWM0FDjVkuxfcJcxYGiJp1k8c/8Ptqxu26rX/Xcezt0l8Sf6btFC6dAOXkqAqCwqXtAuJNwbBJ4Sc9hojvkwb50mLzEReAUnreudaUabkwK+FHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtA+oxmRYZniqMrTLiNo4ByBUgxdbGPKWYaCil3i0+8=;
 b=lCVdCt6hm++3Ci5isFUakZcvZnWcQahnfyQVFEhVeO9BNvN31s++cPOBngfhSwwdv60gp+NG5Hdx3W/9VnzG9EwGVacDMpgLDVuBQWGHCIeojNBO41qyRV/5PRqMFbNjosyylEzGKW4yGto8CA5m/BXG0IKZVkzbxIILCu/ldRZVua3XO7JqMR9x9MW7FSkTw5DDcO2I4BGPt559kkkBDdLFS1OfGN0MNswAv0n7EmCS4KfOg+jdbVbJFi3YG0ySoVJi+zxYd2Cvw0Ln+/YSC3kckgLe3CG70z87PN5nympRDB+xWzbTFRXydmDEN39L9S4SBK9xwtpzqnYFr3gTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 09:40:26 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 09:40:26 +0000
Message-ID: <cbd9c870-def1-4f06-92ed-67d809a7d8a6@intel.com>
Date: Thu, 27 Jun 2024 11:40:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] bnxt_en: Remove atomic operations on
 ptp->tx_avail
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <richardcochran@gmail.com>,
	<davem@davemloft.net>
References: <20240626164307.219568-1-michael.chan@broadcom.com>
 <20240626164307.219568-11-michael.chan@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240626164307.219568-11-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: e2df2183-5ac3-4ddf-420a-08dc968d2c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDB0R0JFOWNub3dGMU14c3ZpSlZLcEsvaCtkQUYyMHNpdHpBRWJQaGsvd21E?=
 =?utf-8?B?MXJ3ZE5MUTFWZWxNb0xJTlJBSmhaS1dkMTRObmhkc1hrdlVjVTNXczVZZ2JY?=
 =?utf-8?B?Y1lQQ21iOW5mRHlzSlhxeHZpTjRzRFNoQ0RJbWh2WHhFT2d0d2N5anlXdVNY?=
 =?utf-8?B?T3V4MHVQaUc2dkE3am1LRmV2eGRkRWNWY2w5MHZhUm5Fcy9ZcCtuS2t2bkF2?=
 =?utf-8?B?RGpEQzF5Y1paUXJIUGdxOW5QMXA1RnBSOC94OWFUcTNRTUcrbUp4amdDdnRw?=
 =?utf-8?B?S25VYXpmSHBKTDhXZHZjamxGVlJIQlk3dWpWc1NzVXJrZ29hZC92MnpNM2xn?=
 =?utf-8?B?M2FQUkU5dXVmWW4veExSZjFXVDVXV3F5VzFQeWI3UzFiSTk1RHpTUzZLTEVH?=
 =?utf-8?B?UzV0M3JpcVkxQUU5YWtYQUhSR1ByT3BlSzM2eldsM1pvSkpDYXhLOFRKbzhN?=
 =?utf-8?B?Qkpjd3BIYkVTVjVEMVA5eGRFeTFucDBuaWRoa3NvcndZd04yY1V5WlVaN2lQ?=
 =?utf-8?B?c215NzdoSXV6QVBUV1hLVUdqNzFFZCt1bHNXaEx4Y2NZeG41UWg4R3F0SEEr?=
 =?utf-8?B?ejJWZG04THRGeWJkL0ZUYzRjeTM4cHZZR1ZCSG90NDRGWkttaUFyVFNreGcr?=
 =?utf-8?B?d0xZMVllZGs0MS9xeHcwTXh2T2JiME9oWXZRemZUaUUwQ0ZUelZwM2YrMlhN?=
 =?utf-8?B?WmliVEJtT2dvcFRLcGxTS3FhcU5OQS9tUTZuNjB1UTBXTEppekN6MTJmS0N4?=
 =?utf-8?B?ZGpHc2RBMWltUDdjRGo0WC9aVTJPcUJUWEkyN1BRaUpSSk5FNTlXSFZMYjFv?=
 =?utf-8?B?aHdmOGxldy93am8yWGx3d21NeGs3S2htN2M2YUVqRXBxSnE1NCt3SkNaN2ND?=
 =?utf-8?B?OU1RSWhqRVQzWjlVd3pMV3RyQ2t1RnlmMmhFK2szTjMxcloxTGV2WXVyQ1p6?=
 =?utf-8?B?ZnRyWGZ0QWpIVE56RU4vUkRYVS83Ym9OOVZLYzJCcGlNRE5pc3BsaU5majlD?=
 =?utf-8?B?TWZaNHZjS0lvNktXUXByM0FYV092OGkxdG5ncTVoUEtKaUZDU1dvOW1tNG9H?=
 =?utf-8?B?OE1DblNGeVAzTnlqSm56U2F5Z01YbG5haUxNUlVUc0V3WWc3dzk5d3VCWThm?=
 =?utf-8?B?dFM1Uk9sUkxZZlJMS3FoaUxackZxdFppSDdEeUNDZ0xYdk1tVEE1ZWZEeGZZ?=
 =?utf-8?B?UDdnYjFLWWRIK1lQVzNqYU9NL2xqbGl3bm16K1dickJNaDFGbXZyZ3VrMzRY?=
 =?utf-8?B?SXM5dytIc1V2Y1hUYkU5WmhOLzFJUXFpdEd6VWd5UUtxMHY4MmowMDNwNjFr?=
 =?utf-8?B?UXdNL1pob21tZFJaOWUyL2NHSW9wYWEzQ1lsa1AxZllyS0J5NzZhZkdRSm5C?=
 =?utf-8?B?ODFmZ2ZudmxvRm9ydkp4ZDBJYXFKaUF1ZjZnM21obnNqbFloTzdaSERGTGV5?=
 =?utf-8?B?ZXRDcWQrMmVaQm14RG8vT0ZUVDFhaG4wb3VWY1lVVTErVHplWTRacVNjcmJu?=
 =?utf-8?B?NzlibU9POFg5QVhqaU9WK3NSSnk3aUpQa2RrczE5dEtYZFpnbTM0MHVMVEdY?=
 =?utf-8?B?MWNaRGVHUEIyK09uWFZGNjlVcXJRU2YxOCtaWVhGUk8wdERSd29TUzI2cTJi?=
 =?utf-8?B?d0FJcENleE1EeHh6UlVKc0dPVTdKSVkyaXVpVGdha3JWWC9IUDBtRXhjemJW?=
 =?utf-8?B?YWF0SW9HOFQ0bWk1SFBiUFpkdVY5Zk9MOG8yZXdJL1NYeTZlQlRCVmM1YXhJ?=
 =?utf-8?B?dHR0dWR2VnR2NjFlYnFEeFlqWWVDSzNVTy9sWStXakxUUDQ1Y20rNTZTQ3V0?=
 =?utf-8?B?TE12RVBvYlpPZC91M253QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFArSU5XbndxdHlpd2lYeklKVGxRclVvK1l0RTVFVXp4NFJGUDFiQmczcURB?=
 =?utf-8?B?VzF6YkxGditPcXZwZWVUeXpudTVYeEJlVWdlMU9VNXlOSTdoYU53b2xWSVhS?=
 =?utf-8?B?UUM0NTZYM0FRejVMNTVRdVkxcUlaRVgzNkU3MWt4Rmt0MndMRUkzWDdjYWIr?=
 =?utf-8?B?Q1dZN04zYlNiekJoMnc0MkRmTmFVT2dTSjBkVjJEcHo3MnZ0clZjVUlxdm5O?=
 =?utf-8?B?OXlVZFFCemVUZVNGQi8rbFBaMjJRbUMrNUJXOEZDSE41WTNYbGxveFRiRk1N?=
 =?utf-8?B?QXBTUkpGWmZLUTcrRDVOWlI5UWpneHFYYXdXK0VRQTFDUlF1ZFR5SENVOHVV?=
 =?utf-8?B?OWpxQ1dZUUUzWVljbGhvNkg0V0FucXk3ZDBHTXZJc21INEVnWXVyMm81dWMw?=
 =?utf-8?B?UnRYckhXUk5HajdWZS9waEZ0ZDZxV3pGcDdiT0JiNWl0TUhjaCtYRUJJaUlN?=
 =?utf-8?B?VHY2VFVVM3FIanlpUUMvRjgrb2tmTFYvVkZGRytTeW5sRnJsVmRWemd2emFW?=
 =?utf-8?B?dksxcFd1ZWZTTWdMamNUS3ZTeFBLMDFoSFpRekhvbGVHMWw1a29OMmY4U01w?=
 =?utf-8?B?VTA5c1RTVVJZSVVhQk1VWWRSeHZoMzhoZVNjbmsyNWNRQ21DSnJ2cVVkMEF6?=
 =?utf-8?B?UkJwT0c4OE9EZXdyTHhIUkRva1hEZ2MzS1pLa0pFY01Jd3VNNXJhcmtjVW5T?=
 =?utf-8?B?OUJpRXVPS0c0aW11VkY4TjdTL3lBSE9hM3JQU1RLd0FuL255OWZSb3FrSWQv?=
 =?utf-8?B?OTNSQlNBTVE4YlBjS2JkbHdaRC9DaHBhWWRLdHZsbzIxWUtrUHllWUR6TkF1?=
 =?utf-8?B?VXI0RVIvRUNiUWFNTU90eFplZThzRlJJaDdaMkFzWExzVUY3WGIwdFk0QjYx?=
 =?utf-8?B?QnZwSjZNYkZISEtMMUVkRlRTK01mN1Rrd0lQcGk0d2xwU1UyY1YxaEovWFFW?=
 =?utf-8?B?dDZ4eTQxcUxNSXlMR21XWmxBU2VZa2pZOEwzQ1FXN0h1Ky9LYXc2d3p5MWNu?=
 =?utf-8?B?cXFhQzM4K1VSbE9HbENsZkRtb1Avc2Z4bUNYR2dOSWxRZmEyRXN5L3NTc1c3?=
 =?utf-8?B?ekM3NnVMWk5GR0JqSWNJNUw2NzBDR1VPQ2RrMTByL2ZTYzNzcldHMUJoTmMw?=
 =?utf-8?B?Sm9rVk5oc04yVDZZb0o3N3NvUlNJZXpDVmkvcWUyN2N6am9VRVRjbExTV240?=
 =?utf-8?B?bDhoUWtORXVuckZFWHh6b1NZcGJUNTVkRmN3M2ExMExYL3d1Rk9FeVpQdVBu?=
 =?utf-8?B?UFMwKy9GdnRkSElPckxkV1pPelYxVTRiUEozSXp1aGJBbi9jZkhvSXVWUjBS?=
 =?utf-8?B?NndJQStVVkl4TG4vZnh0eFBKckNmc2VnUUh1OVJZbjUxQkNrT3hVUW5jdkhF?=
 =?utf-8?B?NjU3ZEo4MDAxamMwbS9icGZXbFlPU3RBT0s5WE1vNy9NRG9jbHduQkNyN2x4?=
 =?utf-8?B?amQ0Nk1BTE82NVJHd2lzR0gwZThpeHp5OEhwVWc1bmlFVVRlZlJsbDJGYUdN?=
 =?utf-8?B?b05PV1BIeDdxcmZURzBDOC9udmdaTTM0bmdEWWlmbm5pVXZIYzZHdFpKT2lH?=
 =?utf-8?B?bE9NVW5WYzlWL0xGNGtZVU5KNExxc3dVcGs0bnhyMnFSbG9ib1RaV1FyN0pm?=
 =?utf-8?B?YUFzUzVzb3hWSFczSVpXdzBnKzBQSCs0Uy9KMktCWEt2a0plclNqSHN5SjJ0?=
 =?utf-8?B?U0RhbUtBb1VVNHJERHBTc3lNZUFqT3V5WUc3MWxQaFBKTXNiQUhKUnQ3NmJP?=
 =?utf-8?B?M1Rkdmx5elZkaWEwQjlmbmlIYzdDS3Uzdms1NnZ2SFgvdXBZd2hmMGozejcr?=
 =?utf-8?B?cG9DWmYrVU12Ym55QmthYWxSSmEvdEY3OGc2b25td2xPUUFRYm9lQjJFWE9V?=
 =?utf-8?B?WGdPQzdSS3NSQmtGNEJqMVUreWFZWUJlMkMrMGtJblBKNjBmcjRObUNibGUz?=
 =?utf-8?B?ZkcraGVtSzVOdjVYL2tjYnRQYkg1Rll4ZEFtbktMWjU5ZU9oYXdLTjl3WUVG?=
 =?utf-8?B?d0MzeHhsRHJuU05pYXRSN292VDhFS0pZUDZ2OFJNZXJFbHpqZFlNK2R1dkZY?=
 =?utf-8?B?YXFkVk1JSlBmT0tza0RzVFBDS2VVUzdpWlFmcmtYcjh4NWVha2pRcXZ4cDBy?=
 =?utf-8?B?RHU1aE9COXd0NGVyMVl4MnFyeWluSnlXclFnSWV4M2xZdmY0VjRhcEJDeHYv?=
 =?utf-8?Q?d0phxh7tbTT/0v/F5QVIUpA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2df2183-5ac3-4ddf-420a-08dc968d2c79
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 09:40:26.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGsFZiia/6bqGU0OqEVM/F2/nNe0EoJon+HMqRyaz11jxUgzZz/ncrtYOI+siVqseE0706BE45oHTj69gghkisYFsHnuePKom0MDCWamgtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com

On 6/26/24 18:43, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Now that we require the spinlock to protect ptp->txts_prod, change
> ptp->tx_avail to non-atomic and protect it under the same spinlock.

Under what condition you will exceed those 4 entries?

> Add a new helper function bnxt_ptp_get_txts_prod() to decrement
> ptp->tx_avail under spinlock and return the producer.
> 
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

overall it is a good series, thanks!

> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 20 +++-------------
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 23 +++++++++++++++----
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 10 +++++++-
>   3 files changed, 31 insertions(+), 22 deletions(-)
> 


