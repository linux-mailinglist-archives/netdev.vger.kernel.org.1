Return-Path: <netdev+bounces-136712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD769A2BB1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672801F245B2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328A81DFDBA;
	Thu, 17 Oct 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lr3TdlYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8011DEFF3;
	Thu, 17 Oct 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188548; cv=fail; b=JS91tywEAUs/z8ZKjyHE6+HzKpYbw14nfdoR7TjgcSIft2R4chhTMRWEmFi2d7RxrXqwZ2PAbRhOXO5AumLXvOlMt8930XpW7b/csHEAOM0EJ6RUUtDicnve/Urz+aelzzhLOnekjNU/7TYS7neoqP+9Q3cZpzKFyVnaZpHZpd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188548; c=relaxed/simple;
	bh=4+lPbyT4JmV5dXcUysLsLQMUAddLXUEXqHI3BDrAOc4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YszMUBBIXiRGSYcmuG6gjZnLq0ioKiS2rfkyPpS/SgpjDygzkXiX89InkAjIP+Z/05dhC0xvWS2g8Y4MTwS6p2rpVxRc+pfbK9VKNXJ1kFpnylQOi7QaXN0eRrE4u/tGtDSeBg/E1Ol1g1WYtv+qzdI0jp7LnFPlfJvGjyvqsuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lr3TdlYQ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729188543; x=1760724543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4+lPbyT4JmV5dXcUysLsLQMUAddLXUEXqHI3BDrAOc4=;
  b=lr3TdlYQGWcFK507QAJa079BvbNjWdUpdfY3hclFHgS7LxyPP+dkZ+30
   dQGcMssAzdKgTssfYq64Eob+Iy31HnqYQ0+Mh/NlClM2mzNVqxRq1kjyz
   Jf/73tUt9DFPQbOH0DUdgQ5did7k5uUxD8p/Y8QI2eW2zF4XW54V5ImaK
   0oLcWsk2U3Zi1dW8QJTnCGCwbIAIU8ChXX6iEsXYQ72SedAUoKopRJtdT
   qpQcCby/44wDRx2K9cp8iG1U0TNdH1fb59kmXH3yRwzvocem+UvP2tFCU
   9SFRg1vlhymrWdeyHebTbPRsv/RaIMh5Y7byzAs5w+h+tLTPfpKXlCwRd
   g==;
X-CSE-ConnectionGUID: UvAb3+jaQO+8FzqNLS9+7Q==
X-CSE-MsgGUID: q+fwtcafRKqcU4oLqEkbOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32379545"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32379545"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 11:09:02 -0700
X-CSE-ConnectionGUID: aQ8O4uJBQx6Ec+ZQHI5WlQ==
X-CSE-MsgGUID: yTYQiRAWRcynZuXzEJrkLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83178292"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 11:09:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 11:09:01 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 11:09:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:09:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 11:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0WlMRUITSpmAclPrYzefRZP4UEjQCsDGA4XaDZ/wA41vbW+s0S4GWAE/O/T8gdXVn26g0yHDaYogzmupCI6b1TBVcWZt6n68VgCbREhg/H4z0c/GsGaDbpVKZMVyIS3Tr/m7RsB6zE/IPIhcrmuZKhvC9/Fs0e9y5fz6YW+4Xl08nG2UP1Zaab5ROMqGtZL0Q4X4XbN9hmOU2c9j0wcXr5TthqwGyOl42u2wqCVEwekHdcpNnxif8G6w1bfWd+IukDmEb3kpbBQohVSfLCoAiO1RxIXZM231OfefB67c3tvCb5JhfNVQFSlgupryvMsKHcAaopZ+B17rtbICaNYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epzzLWjvr/67XqgZEGyrMy6ZXqt3DogXiENLDVlJK7Q=;
 b=bgofRmCuhswxlb7CYAkcwAc0tZHSP+F7kuShbRrJL34ApyPYOrmIEUB9xv3KvE0Ck1nwoZzHbrlQH2vzuXGd8okAoicgQG8KHtNGRHBTh5hbMQ0T/hG9yRjiuaD0i/xhuwM6Fq73jZLeksPM0V+oRoNldyw5znSL+tSvMhvyiygFOIpHdZhTvhOJag/CW8bdZ6FgYpSiyRLC6fUOP6XZPU3WvrfakKgml0M8xJWO01zlk7c7Nqd4yD4fFJ4WKP7gshafG/Iq/eqBepdL4IoU05Mkk+Rj0JEZcPsC5E9IFEit1JvqeflxMgc7lL/7htjBUtDGUg1s9w9I1bwwNKdqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 18:08:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:08:52 +0000
Message-ID: <a21c531d-04f6-4c73-8f58-46fc9cda6c8f@intel.com>
Date: Thu, 17 Oct 2024 11:08:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] octeon_ep: Implement helper for iterating
 packets in Rx queue
To: Aleksandr Mishin <amishin@t-argos.ru>, Veerasenareddy Burru
	<vburru@marvell.com>, Abhijit Ayarekar <aayarekar@marvell.com>, "Satananda
 Burla" <sburla@marvell.com>, Sathesh Edara <sedara@marvell.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Simon Horman
	<horms@kernel.org>
References: <20241017100651.15863-1-amishin@t-argos.ru>
 <20241017100651.15863-2-amishin@t-argos.ru>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241017100651.15863-2-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c596bae-d8ae-4e1a-9c2e-08dceed6c1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U05zVERHSmREZ0JDZkR2ZnlpaHQrRDRkbGh3ZE93M3ZlbnhoenRBc3RjQzNj?=
 =?utf-8?B?NmNETmdXME5TUDYwdHJLZ1gxQzBScXNIQkE1R0ZwVjlsWWdpTzg5bHo0cE9H?=
 =?utf-8?B?WkpnclMvYnBHelZmazl1K2tjQkpUSlNCOFNNTXZ5QStoSUdJSVpvVkR0Y1B3?=
 =?utf-8?B?bmpDQkNjMzdSWGgxQW9QSlBrdGhvZ1dKN0FQd2ZEZU9haDcraTR4ekFDT1dp?=
 =?utf-8?B?MjQrR0MrSG9rVzN0RkR3elgrd29mb2ZPUVE2VXJxUDhzbll3TVoyNC94VjZL?=
 =?utf-8?B?cXVmMnlCcVd5VithVm01QnNJVzhxcnVQbWgxL0FqWjgyc2J2S3B2eXpQT0N0?=
 =?utf-8?B?UUt5NzNVY0N4TGJsWmJ1OSs0YWhoREhlTE1oSUFDQkh6K1pRS2tCekxhbmRT?=
 =?utf-8?B?UEZVdXNiU0kwYXJ0bWxVTTNWdURLWVZudy8wOWJvRkdFQ3FZVExPZWh0ZFh4?=
 =?utf-8?B?dllFWFlQRUM3ZkdydktZRWxWRlY3dnpXL0d3MjA0UWJLSk1WVk5ZVzFHQi8z?=
 =?utf-8?B?Qm5WZ2FFUDBNTElMMFFucmRQekVaMzVGL2h6TXdINXB6U25UK21DNFVVdWpH?=
 =?utf-8?B?UFBwQ2lSU3pTTGlXYnFPcG1nK0VTWmRjOVhISlhEUkVDbmN2cExwaU00MFQ4?=
 =?utf-8?B?djF5NUFQVlc0R2Vuc2l3TGpKMEx2dFNnRXRQdEdvSjdGSk9WeGJPaFRDMUFL?=
 =?utf-8?B?YW0yRGRIbDRUM2xNM1J4cFIrWkhRUFkreDZvcnhUZFloVzhWT0xJbTlIUm9E?=
 =?utf-8?B?QU10b3QyeEVkdVhTeFhXQ1lZZzRxTUhBa1lrRTVleGk0MzdyaXRtMWRsZDhk?=
 =?utf-8?B?NUJWTFZNNkc4LzVwc1YvUFJ2QXhXQTY1YTVzYVhvSkUrWWNoNENaTXFVU0x4?=
 =?utf-8?B?UXpHVkM3cHp1M3J3WS9taEpUWk54OCtHUUJtK2tQcFNqZjIyS1RacEtPdy9L?=
 =?utf-8?B?SkprSW45dkNYYTJtaUc2c1V0N2REZU5CZ3lTemRBY1Q4WkNacFhtOXAwU0p0?=
 =?utf-8?B?QUk3dTIwVXp0QThYVktxamxidUtGck42eEJ4dlVJUHl6WUlXTXgrdEVWa2pG?=
 =?utf-8?B?TWEwWDl4ZU5ZWi95NW9Kc1lsSnJ1UWxsZmxyRklZVmt0bUtXNzNPNGtVdG8r?=
 =?utf-8?B?T0pDa0tJZWV0dGJyUUp4MW1TeU9vdkdXekdmTXpHL21xSWhJalprdWUwZ1lG?=
 =?utf-8?B?WnZMNFRKQzF4K0M4NDBUak9GTmswZTBtVGVpbDgxMlF0UEVQNHNyNHhjTkow?=
 =?utf-8?B?c3NNUmZyOUN3Qy8rU3F3c0NmNXY5aE9xek5Vbll2amdqVjR2RlVzS3hkaGVW?=
 =?utf-8?B?TkMwdS9YOGJxVVBpZTJ4RU9hQzVramYzc3hDVzY2VEEra2hKUWNhZGF3QUJ1?=
 =?utf-8?B?UTlFa3FyZnM1MVQzekxLVDhaWCtPT0ZWQWJRc0Rnb1MyYjVNclI1UEtqczB3?=
 =?utf-8?B?endiSWxTOEM4VUkrSTd6amZSVEtQK0hYNmxITEpIUnRaeGJaNHZvc2h1RE9a?=
 =?utf-8?B?NTJ3Yk1wcTE1Z3lBRWV2bmZDdVhVdERxUGJXMUFLOXpGZnRZcU05Vnh3Y1RN?=
 =?utf-8?B?WHErZElzZTlrUjEyRFFpMTRIOW1Qck9sOXdSejFFaU1GazVxMVRwTWEzbkRG?=
 =?utf-8?B?MjMyMktiam84NnVUWjMvUURKR3IraCsyL3VudzBXMkFGUm84NjA2UWRLTmNo?=
 =?utf-8?B?RG5YTVFVeUpuV3JIYmNZSlhib2RuQmxSbk9PMDJheklEa3ZnVDI1UzJ6Mkds?=
 =?utf-8?Q?dRRw/zd7aCObTev1Ih6Ek2ecvgHn0CFbnx4W2nt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xteHFvenZHVFpNMUpSNXVjM2JQbmRwTmdSa3FmYTRyUFVKTU5KcERUaXhM?=
 =?utf-8?B?cmlYUmVadTl5YVU1QTRRaFlLWUoyMFd5a09kNUgzUjhLdW1Pd1NmY2ZNK1ph?=
 =?utf-8?B?YnYvQlczdTdac1FOci85Yi82SlRueFBaWExsOXV0SmhXazFyU0F1QlZ2NWll?=
 =?utf-8?B?QlNodVBrZWplZFB4Q1B1MFpEa2V0YlRKbldjazZObjJPZzJqY3dIVDNqQk1v?=
 =?utf-8?B?QzE2NUtXZ0QwUnRSOEdvNWhLcWd5UVNaZVlQdUJQcWp5WkN1RWlWMEp3OW53?=
 =?utf-8?B?dGFXei9mS1N4cDBDelozdjk0SlRXUm9mbUQ1MElFMEI5UzNrdSs3ZUtDNjEr?=
 =?utf-8?B?VnM3VWtZWHRZaVJHT3hNcjYyblZ4WFpmOTNKdFQ1RExmSzhDMGwrRUI2eTB1?=
 =?utf-8?B?LzRWdjd2enEyL0dPK21rcmZRTE1JaWF0YUpzQ0QrNVhTV0dzNFRBaWlhWDJT?=
 =?utf-8?B?OVlxTXZlMkluWnVaZTZ3MlNlZDVoalJ2MDJLQ1VVcThsSmk2aFJxM204OVI2?=
 =?utf-8?B?UU1nRnhNSHVENjhBOHNPTE9TWUpKbG40VGJZUUdBK2JrUUVWTHNHR3czTUpk?=
 =?utf-8?B?NllnektBeXZuKzMrTGhDUnlUWEl0TXM2VCtmUW9odVYyK0NFTlkxUE9mYVBB?=
 =?utf-8?B?bDJZQWZTVGl5cldZWWRqdzlCc3RjQjFpOU9nVk04KzkyUWhFbEhFQ2xpNFpJ?=
 =?utf-8?B?UmtCVCtiNW5oTEx4NWNrdkVBSjUrSFZLbTJwTUpLb214S0VWdFZBR0Fvakpn?=
 =?utf-8?B?bFRHOFJZR3NKQ2YzdkxvdHljdVB5cE90Ri9WZENvMHlaLzBENGFhYW8vZHAz?=
 =?utf-8?B?TlV6THJyQjVUOXVmYmVUQytSMVdTd2owN1VkaDY5cDJUSk5xL1FIbXBKSkQ3?=
 =?utf-8?B?WEliRkVLSmNuQnkwSzN3WlZLeXdSeW1PZnpsZSt3Mll0V2FncFN2UU1pNml2?=
 =?utf-8?B?T2h1UWxVV0U4NUVmb0o4eFVZWE1qUVUvNzV4ci9OL2JHYkN2YUg5WEo0a1JD?=
 =?utf-8?B?SmU0a3hLQzlaaW5EYS9qaE5MK0ZxeUF3cFlrRnJhUG1haXFBREZTd1RyaDdW?=
 =?utf-8?B?ZlZReE9KZ1BpWmdqeld2OVNzQUtvQXk5SGdDbVI3RTVKeFhkUmV2eXhXdU9E?=
 =?utf-8?B?RnNQeUllbkd3a1cxaTZHWFVPYTdCMXlEUEJwV3VSd0F2WlBjUTdsNFBvWWZY?=
 =?utf-8?B?UnBBcTA3MWgyM1lQMDI2cmVmRFhpRnQ0NWZGVjhXRDVhTDB6UFZRakZPWDRN?=
 =?utf-8?B?cmhUZDFVRytVbzRPbTh6N0U0alRudUF0eEY3U3VLbGt4c2Y5Vy8vME5nVTlW?=
 =?utf-8?B?blpKYk1WL3loVkRHbHlnK2VQNjRPbTNXODRESWIybjlGczBSOTZaWVZLTlVV?=
 =?utf-8?B?QkxHTjE5OCs0Y0YyS3ZaM2FFQUFXL2ZmWnlMWlMxWWxPU1EvL0NqWGpuVFJM?=
 =?utf-8?B?M2NpaFBnRmdXMkhTTm9Ea2tad1hGN0tFbVhlbEdzZzJVOXFuVXpDYlIzY3FZ?=
 =?utf-8?B?aFZOMWxiZTBJblJRcDdFY2QxaGpndEVIU2dXQXl1Z1hienlxalpwNSt5TzRE?=
 =?utf-8?B?Mms2cnBBVlR6Q1gyYU54MjlwQjBDQWtwaFZ2Z1l2MlZoU0lOcmxBUTlnUHA1?=
 =?utf-8?B?OEFDWittbk1KVWdUVlBJZU9weWQ2NG5qSVFQdG9rR1N5cHRNbHZtSXZvQjJj?=
 =?utf-8?B?djlTT0k3Q01OdWczQ2c3SlZkekZSWmJKYWQ3c0tmS1NYSXFxZS9CQ2VQemN2?=
 =?utf-8?B?alR4elB6V3VqbW9nTUVzRXU2VXpGTTduaTl4VzZNMmIwYkdUbnJLQUYrc01I?=
 =?utf-8?B?NUpNVUZyUkgzeUZsaDVISTBNVW90WE95TTM1N3RBUTFlaHdRMldZeDM0clVi?=
 =?utf-8?B?MXpPMCtwSUpHTGFmNGl4ajFnVE5LYm5pVVgycWh1dE1PbUJOMG5aTFhyT1h1?=
 =?utf-8?B?YVpreWJ4VEdjWnBOSnRYKzlMVmhQdDVnSmdkbytPYXdYRmx1NEliVmdWbGFh?=
 =?utf-8?B?TlBiUWN1UW9qSVUySjFiYUNRb0YyNUNldlZna0VEMDA0UVg0WVhmT2VlVW4x?=
 =?utf-8?B?Nm5YUVV4MW5BUERINmYvb2NuS1QxZCtqQWF2YjlaZzRraVFyb0s1OFBWVFYr?=
 =?utf-8?B?OEFCOFJzQTVja1Vxa0UrQzdGQmxxQkdtcHhvZlRXNDdIcXRsSmNvMUw4blow?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c596bae-d8ae-4e1a-9c2e-08dceed6c1a1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:08:52.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWzNbjbHPLUIMTFe7Z+rRQ9WfpSa1XwR4gUMX20eMnpW/47cLeKx+VvohJXvmNccXqFHDNzS8dOXxS4M2UnNhL+TgyBK8tmkkRxQGshQcJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8389
X-OriginatorOrg: intel.com



On 10/17/2024 3:06 AM, Aleksandr Mishin wrote:
> The common code with some packet and index manipulations is extracted and
> moved to newly implemented helper to make the code more readable and avoid
> duplication. This is a preparation for skb allocation failure handling.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

