Return-Path: <netdev+bounces-121119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F357495BC6C
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE041C22D21
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D61CDA3C;
	Thu, 22 Aug 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nu3G8y/t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D691CDA2F
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345352; cv=fail; b=KipkFUEIcFt17dLUeuZVSu0bJ/1d9IeD6DvIlfxgStm0qq57fz16Gp4lQdH/x55IJw5nR58iOPcIWDzm0nH+llrsyGsv+J3RKVfHJjOzBPhWWuxncVrNaqFSo7/MPrgzYAR9aGoiG/bev8hSWg/CTme6HMaQe0ud3juUVUM4/rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345352; c=relaxed/simple;
	bh=S0bibqQdkx89nz67wVsxt+4mjD0L/MzsPXgB/IjNC6Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0DsszwW6LIRcCjVn8Y5Qu8/O+c086o1LiaBXrh2eNYy+vHNLSVYhE6j0p5ED+h4r9tl2Cu05kyNoZq6N5PSgTT9c0+N8VW5FvLxkTYvcCzQInoFgJKHN4fKDav2qh3H0oV7Fj2Un7h2mFbfPxech/7bwxK79Y8z2LmUJXZKTV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nu3G8y/t; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724345350; x=1755881350;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S0bibqQdkx89nz67wVsxt+4mjD0L/MzsPXgB/IjNC6Y=;
  b=nu3G8y/t+OqDWAceSpUj4vSCJXRE+OWM9EBBTK+qFD5gudTC+lRhMkhh
   uI2I4zfRyDfdMrCK5/HLu1wuv9jbfPlo/ekGj+nwCj0r5+UlMZwbYTph4
   poQL1M3PhZoGlD8ceEIxnKeMwi1zpLtiucE6Kv4p3kTn/wWKO7vne/4dS
   3sZ7AckpJrHe/orF/jByRWk/ZY3m5DB93MkaERegDscrDJ4TgOGPns4iM
   DVBkekNCXFBIsh3OR9OU6Zx4JmN4N1tIfICtmObJxiEriBRGg0Y3lpRXj
   NRc8QBf4uC666M+cIxNO+s3TF18p9WFPY1rhM96LTdircMQJHnJ8lZFu/
   g==;
X-CSE-ConnectionGUID: JkEvcx+5T+uzpK8vE5d0Zw==
X-CSE-MsgGUID: K9Hi2DwqSwC8XjI2O8kYzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40243631"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40243631"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:49:09 -0700
X-CSE-ConnectionGUID: nWQfBjaNSMW8CqD3sZwM8A==
X-CSE-MsgGUID: S5znBQtGR8qzKda1/PcPbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="99027666"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 09:49:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:49:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 09:49:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOlneAMVxwVffhhEEK5dLMNNLXoAAuW3dlm3NmkO6fLC9fEGeWniVahz/1okYQ1hmBUL2IjT0AfB5vrORFj8Eo2UGc00FUNC/+PpPvZ1pQUsRMs9ZfUo+hOdFdxShcaAl94DPoIyrJ8mtPYgEtNCagelRgxyv0bqXWjka86+6C2c7oB5iIbiVGxFpHbbNShR3rftFkrPUruf8kkX5al46K02omeZw/dkQAK+/Lf6sbCjhsAwN2VnY/wPK3mv0Hfj08lDHQbZhTU5oq1nbhKQP34BFlZz65CH45mvIB84/ksRZF/YsaIa4nuuSBmtFfeaK4hnLlXU7BW7rhe3Mtwm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CsoHzxqH7u/s/raGL8dKf9A2wamrvo+B+OiIH/oud0=;
 b=EPn5oBuwecq/aFFGJXrZQkPXov+Mb6uMC2A6mjcsFqx+cqSPNSmn6paNiEDfICZFPE9ir5mnNZe42eHlQZWwhDgcqBhvfH+qqOMVa1bn/OxPbI/HjQJr1cKM+NaTnWutj2TS0xYgEdiUdCvkZwDd52Gdvph7H6uqXWh16fDDPdVnNFRWIUwRnSgg7N3Ct6Agsoh0ve8mQ7dO6AeW+z8ciwdpav/J+wv5vN/gPtGqzVPmI6HySkRm8kVUdBEiJEo2rP29h+NGP4HvkUMQPBuOyNTF3Js+hwi0Tc5+qvmYJO49XVFg6HMva6sey/eaXmiERyv5PyCFulYKB/O2GnOwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 16:49:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:49:02 +0000
Message-ID: <c2627358-cd3b-44d4-b4a3-13b85ddc98e7@intel.com>
Date: Thu, 22 Aug 2024 18:48:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v10 13/14] iavf: handle set and get timestamps
 ops
To: Wojciech Drewek <wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<horms@kernel.org>, <anthony.l.nguyen@intel.com>, <kuba@kernel.org>,
	<alexandr.lobakin@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
 <20240821121539.374343-14-wojciech.drewek@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240821121539.374343-14-wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: c04c55d4-88b8-4479-e0a2-08dcc2ca53d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGtmQ2FHM3M3ZVZEWEFObWptVWxndVgweS9oZHpFdGFSSmlHUzdJQTdGUUND?=
 =?utf-8?B?T3BRdlM4a0VneW9mdUdISDA1QjJ2NFEzQThqQ1M5UHVsd01RcjUyNUg0OERz?=
 =?utf-8?B?aW1aM2FBMlNLaEU2UWhSWlZsQ2ROOWQ3d3FWN3hFUXRRNVJqKzBqZWxyTGZ3?=
 =?utf-8?B?ekNEdFBiV2pRL09xWVJSTm5PM2JWd2gySFZ5MFhKMUNnc1U2MUFMMHNzbitn?=
 =?utf-8?B?MERXbkJIeEN6ODRKMXNQcVNZNk53WWpUWmtvdWtmMVJxeStRQmV3SitEaVRa?=
 =?utf-8?B?cUgxM2V1Ty9Od2l0OHdSa0xjQTFSY2xYbGZ0K3AxcFppa2tOWVQ2V0xndStw?=
 =?utf-8?B?QXBvRmUyV25RcS9oV2pGeWZTMU9TbzUydEt1NG53YkRjQjhIVHdjS3B4WXhF?=
 =?utf-8?B?eWlWUlpicHJoMi9NNjZ5Uys5K2dIOVFKUkJSdW44UWcwRVdsZUFxcFFzUURP?=
 =?utf-8?B?citKanRvbWt1U21UMEcxRHVINWtaREhYT2VCQUtZNittMWJINUlJYTByOXVj?=
 =?utf-8?B?NVZWeFNiNEVRUG5pd1pXRllZenZMUUhzcWNMUWY3R1hUWEF2Q25rTFEyeUdN?=
 =?utf-8?B?NVNDaUxzWkhlVjlvQ1g2ZWc1OWNyUXc1OWVESm1yYytxQmw5ME9GMXVYYXND?=
 =?utf-8?B?K09Nd1NWQjhGYmVXU2NyUS9VUGJFVnpoQzFOZjdvSWoySVA1R3dtSzA2aEE0?=
 =?utf-8?B?dUZzNlJ0TWkxZDZ2QmRuQkNkZGFIdUIvWHRWaG1lYmxOZnlhNUliZDNveU0z?=
 =?utf-8?B?VzRLQWVqSTNtaXA4a0M3VEoyU0lSc1A5VFkxdDl1V0h6V205VmZJT2hESmdV?=
 =?utf-8?B?aVRSVnRnNjdOcklXeVNVSmZZQTdPL1BQZjNNSjgzUzZSUlFhd0plVEkyU2Zy?=
 =?utf-8?B?dFE3T0IxNEo5Y0NselVseTdablFXbjVzTFJHY0NaUEZpcDVLbUZqYXpMdEtw?=
 =?utf-8?B?RloxQXVxSktCbmdZcWNZdTRJN0YvazVPcWNxQlZPWDN3MjdoOVZqam5tSVdG?=
 =?utf-8?B?Ukl0RUlNRlNyTm0yMHFnTm9qenFQUnJPOFZFTTBrdG92eElVOTBmdXVpNlVJ?=
 =?utf-8?B?K3RWWUxXVE10ZjR2bDZaR0dxSXFjOFVVRnJNVzB5ajFwbTh4eGttRWF0bnph?=
 =?utf-8?B?NGhRaTg2MXdjTE9tb3g2aHpyNDJFdjEvcGJtOHN2M01Xb1B1Mzl5NHNXbjhN?=
 =?utf-8?B?azIzeVc0VnRyN3RQWUFCajFMTTA3WkkzZXpTeTBibGtlZlBzSG5EMXBHNU5n?=
 =?utf-8?B?S2dDWkdzN0gvOWhXcy9TTHpWbmozbktFMzFZMDdEKy9NMjFyN2k4QWNBVzNl?=
 =?utf-8?B?a2JWWUI5NmR5NFlHajdQYzByTWMxMmV4WXVtREkyMldHY3hUSXM2dHFDZ1Z6?=
 =?utf-8?B?cnl4SnU4QVBzemUrSzV5MGQ3YkhUdWx6RFdRZU9PbndseWw3aFJBYlNZaEFz?=
 =?utf-8?B?N3lldXNveGExZkNrR0JlaW40dWt0UkZWOThqcXN0aXlQWUdsWm1VWk1QNy80?=
 =?utf-8?B?NnUxNThKQkxmUXAwWXNuWE9pMi9rN2lzRXJzSzNjM0pBSTRwMG1IelF5NkZB?=
 =?utf-8?B?L0VIR0ZpN1FKdWhudktlUW9FNjdOeXA1bEhxLzQxSzJvbHRlVWJlMWErTXds?=
 =?utf-8?B?UGcwOTltRjUrcG0xYVRtSVlnbDZWM21kMWUzOWhVOTgvTFhHZ0MrOHV6cVd1?=
 =?utf-8?B?WnJReU9NQ3JZVUZBNHRZeFBOQWtVSlRLMkEwU3lFVVpHQjRiVCt2ejk0ZUZG?=
 =?utf-8?B?dTBiUkJUelFWWk5iNXNnUXMxdmphMHR2VmllMWxQN0dFTVlMdlZRN2d3OC9Z?=
 =?utf-8?B?blFlTWU2MUxOOVlMQnhCQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TndZa2V5YWYzWE0yaEI4bnJvVnh0cGo5UWZzYyt6dlR1cW5vUDRGaHpVR2M5?=
 =?utf-8?B?N3lXZXBpUk5scVFwY0RML00rZUY0Y0plbWl1SWVoNHpucHYzSllEWmZ1SFpx?=
 =?utf-8?B?emdlSXJrMlgwSGJWbDVnZlJDNkUrL0NSQXk5SGdZd2ZPTE9kTlk1WWpJNU9U?=
 =?utf-8?B?SEl5VHN6UmlETFMzY3VrSzVtaVlvWE8yZVFaWFZXWk9IbHZKR25BbXI2Unpi?=
 =?utf-8?B?L2tiWlg3bkFsVlRWbkFiblpaZzJiZ0FIbzlKblFOK1lXRFIvTDEzY08yT2Rz?=
 =?utf-8?B?bkJlUk5YQVkwU1hGNDJ3TkNLL2FiUjJBYklRWUsxdVN5Z3c5WEZ4Vm1QUlMx?=
 =?utf-8?B?TkN2UUNHNHZsN0ZaV0YzSVR0VDlPajBpRWZ0emwyaFpqRTZFdGpSbkZyRGhC?=
 =?utf-8?B?TCtDSThpajkvMzBMM0NwQTJKTEVUVTFNM2o1N0ZYR1JVRHRnQ2h3OVJiRGg1?=
 =?utf-8?B?YWtEcU0yQ3ZIclhEdkJlNDdOWExGcWJPa0VOWnQ3NHJ1Y2pxbkxDRnJCUm80?=
 =?utf-8?B?bGkvQlQ4QlhzWUJlNGhRZk1SaytqODREa1JrV3hYQktxdi9XdWd3Wm5Hc0Er?=
 =?utf-8?B?VE9YT1pFcmdGN1dPTEJiN1kwS3N6VzYwOGJCS3l5MUdEQzB2K1JmRnBrS2ha?=
 =?utf-8?B?dTNTYXFhUFcrNTVtb3E1VGltWjdsSnp2ejVLNnJYaTNVRE81L0RHbGt5QXVB?=
 =?utf-8?B?NEJ1aUpobm80WExaall3VmxKUklwNnBQVVNDcVZ0WXNYSHVTZ3RsZ3ZaYlJz?=
 =?utf-8?B?R1BtOTVzODlqKzJ1YnV5eHY2VGlJQ3RQOEhOZjk5QWJENjAweWFLR1BBdXRm?=
 =?utf-8?B?MmFvZ3BndjgwQUpGd2dWUUtRNnlZYlNwS3ZsTWsxT1ZpaTRBMTVyck9TWDR0?=
 =?utf-8?B?eS96MzhteHcvZ3dlT3BQYnFZV1VNWnl2NHRZM2JRb0xkZTJCNmw0WGZmRmFC?=
 =?utf-8?B?MCtoSFZ6eGp1TkFZNXhqNU9sNVhmWjhOc2hqOER4WVh6K3dudEg3VEppV3Jz?=
 =?utf-8?B?WnZ5dktLdVV2aVlsTGdoQlVYMU1mbjZBVngvLzFHYmVNNUN4UzF2T012cmFG?=
 =?utf-8?B?S3FVSXl2bnBrcm9NTTcxSE5DNFdrMmg5cGpWUVZ5UGs0S2ZIWFUvRndMOXhs?=
 =?utf-8?B?aVppVHZNTS95T1NRMEowZ1dRYUhaaXNSeEpOTTdGc1FrUndqeW00RE9ORWhv?=
 =?utf-8?B?UWw3eGoyYXdWYVZ6QjR3dk8vY2pqSUFYbTNESWxVZHVpWXAzTWR2NWhzMzhn?=
 =?utf-8?B?eWQ5U2VWeithQnVDV3RoY25MRnRQSnJBdmlCMWFYQXQ2Uk1Dc0d4UDJGakFU?=
 =?utf-8?B?cS9od2h3R0prZ0l3YWUwL0dZbFV5NExCVVVHbk9FbTdmWEJ4RG10RE5nR1B4?=
 =?utf-8?B?WG5SMzU0ckltaWVyQzErakFkNFVqUlkvNTNXQ3pSaU9mY09ESWpSTGppN3lt?=
 =?utf-8?B?bkxXWkpmZ3FDaUdwUEIydGRrcjRyM1doajFSYnU5MzZ3VmZ2dTUyVzNKdlJP?=
 =?utf-8?B?VVl2OEdVMkxFS25YQ2ZZL3gvT3RZVUlHUFVBRVo5V1NtZnI2MnY3eFF4Y250?=
 =?utf-8?B?RUlCeVh0ZER3UFl2Z0NDT29sUUtiMGhiUnppdEcwbk44ejBTdWpyRzROTWRj?=
 =?utf-8?B?VkRVeVZ6a2pZZ3FkOWNvS21ETTZQQ3ZtenUweVYzS2wrNE51Ty9aeVZRL3VP?=
 =?utf-8?B?TDVUZU5WeHVyZHdkalVUeFNDUEtKUE1BSnNTTTlOaUZHd3Vpdkd4WVJTdm5p?=
 =?utf-8?B?b244Rm1WaWZHMk9TNWhZa0J1ajFnaVlZMWJOMHVKaXF2Qnp1WnJUR2ozczhi?=
 =?utf-8?B?K1kyeXdsaFFqa3JqT1dsMzA3RXNvY1hkak1PNVVpcG42TU5na2IwSnRKQ1cw?=
 =?utf-8?B?NCtjUkJNVngrck5Jb0hJdjBlWjQ3Qmp3VmlaSEs2ai9HUTJWTnM4UWFvemVt?=
 =?utf-8?B?TUdHWHRuSHNlMGhQVUNmNVhHK2x1YlRQM1BvT1hLZmhFbjg3WDdoVHVXWXUw?=
 =?utf-8?B?ZG5HTWJRZENJUm8wSDE4MWh1VXZoYTBoVXpGVVM0ZW4wSW1FTWpiTzUrYVF0?=
 =?utf-8?B?anVXYm1oU1hIK1Z6cjl6ZG1WblVMcU1LV0J3MFFSVElsK0dpU1dGa3BUbEZQ?=
 =?utf-8?B?SldKQnFWVEVTdVF0QjBZUllPcGllVy9DNGpYcWhOVWhCL1NkcEt0NHo0OXhr?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c04c55d4-88b8-4479-e0a2-08dcc2ca53d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:49:02.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PTHf6ZbWYwKQ8T5XqMGAHdethSYuASYEC/+4LUPfAeclhQ/BYxbyBmqnmU3S8x7DulVNdICkNEwDDBCQ+sC2C50QBRE9tDVm5KBkBtpWVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
X-OriginatorOrg: intel.com

From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Wed, 21 Aug 2024 14:15:38 +0200

> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add handlers for the .ndo_hwtstamp_get and .ndo_hwtstamp_set ops which
> allow userspace to request timestamp enablement for the device. This
> support allows standard Linux applications to request the timestamping
> desired.
> 
> As with other devices that support timestamping all packets, the driver
> will upgrade any request for timestamping of a specific type of packet
> to HWTSTAMP_FILTER_ALL.
> 
> The current configuration is stored, so that it can be retrieved by
> calling .ndo_hwtstamp_get
> 
> The Tx timestamps are not implemented yet so calling set ops for
> Tx path will end with EOPNOTSUPP error code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Thanks,
Olek

